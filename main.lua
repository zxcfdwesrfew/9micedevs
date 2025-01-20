-- Основные переменные
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Время для активации меню
local startTime = 12 -- Начало активации
local endTime = 18   -- Конец активации

-- Правильный ключ для активации
local correctKey = "секретный_ключ"

-- Функция для проверки времени
local function isInTimeRange()
    local currentTime = os.date("*t").hour
    return currentTime >= startTime and currentTime <= endTime
end

-- Основной фрейм для меню
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 400, 0, 600)
menuFrame.Position = UDim2.new(0.5, -200, 0.5, -300)
menuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
menuFrame.BorderSizePixel = 0
menuFrame.Visible = false  -- Меню скрыто по умолчанию
menuFrame.Parent = screenGui

-- Заголовок меню
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Text = "Настройки Хитбоксов"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextSize = 24
titleLabel.TextStrokeTransparency = 0.6
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
titleLabel.Parent = menuFrame

-- Поле для ввода ключа
local keyInputFrame = Instance.new("Frame")
keyInputFrame.Size = UDim2.new(0, 380, 0, 100)
keyInputFrame.Position = UDim2.new(0.5, -190, 0.5, -200)
keyInputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyInputFrame.Parent = screenGui

local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(1, 0, 0, 30)
keyLabel.Text = "Введите ключ для активации"
keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
keyLabel.BackgroundTransparency = 1
keyLabel.TextSize = 20
keyLabel.Parent = keyInputFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, 0, 0, 40)
keyInput.Position = UDim2.new(0, 0, 0, 40)
keyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextColor3 = Color3.fromRGB(0, 0, 0)
keyInput.PlaceholderText = "Введите ключ"
keyInput.TextSize = 18
keyInput.Parent = keyInputFrame

local keyActivateButton = Instance.new("TextButton")
keyActivateButton.Size = UDim2.new(1, 0, 0, 40)
keyActivateButton.Position = UDim2.new(0, 0, 0, 80)
keyActivateButton.Text = "Активировать меню"
keyActivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keyActivateButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
keyActivateButton.TextSize = 18
keyActivateButton.Parent = keyInputFrame

-- Плавное появление меню
local function showMenu()
    menuFrame.Visible = true
    menuFrame:TweenSize(UDim2.new(0, 400, 0, 600), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
end

-- Проверка правильности ключа и времени
keyActivateButton.MouseButton1Click:Connect(function()
    if keyInput.Text == correctKey and isInTimeRange() then
        keyInputFrame.Visible = false
        showMenu()
    else
        keyInput.Text = "Неверный ключ или время не подходит!"
    end
end)

-- Слайдер для регулировки размера хитбокса
local sizeSliderFrame = Instance.new("Frame")
sizeSliderFrame.Size = UDim2.new(1, -20, 0, 50)
sizeSliderFrame.Position = UDim2.new(0, 10, 0, 60)
sizeSliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sizeSliderFrame.Parent = menuFrame

local sizeSlider = Instance.new("TextButton")
sizeSlider.Size = UDim2.new(1, -40, 0, 30)
sizeSlider.Position = UDim2.new(0, 20, 0, 10)
sizeSlider.Text = "Размер хитбокса: 2000"
sizeSlider.TextColor3 = Color3.fromRGB(0, 0, 0)
sizeSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
sizeSlider.TextSize = 18
sizeSlider.Parent = sizeSliderFrame

local hitBoxSize = 2000
sizeSlider.MouseButton1Click:Connect(function()
    hitBoxSize = hitBoxSize + 1000
    if hitBoxSize > 5000 then
        hitBoxSize = 400
    end
    sizeSlider.Text = "Размер хитбокса: " .. hitBoxSize
end)

-- Кнопка "Применить на всех"
local applyAllButton = Instance.new("TextButton")
applyAllButton.Size = UDim2.new(1, -20, 0, 50)
applyAllButton.Position = UDim2.new(0, 10, 0, 120)
applyAllButton.Text = "Применить на всех"
applyAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyAllButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
applyAllButton.TextSize = 20
applyAllButton.Parent = menuFrame

-- Кнопка "Применить на выбранного игрока"
local applyOneButton = Instance.new("TextButton")
applyOneButton.Size = UDim2.new(1, -20, 0, 50)
applyOneButton.Position = UDim2.new(0, 10, 0, 180)
applyOneButton.Text = "Применить на выбранного"
applyOneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyOneButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
applyOneButton.TextSize = 20
applyOneButton.Parent = menuFrame

-- Список игроков
local playerListFrame = Instance.new("Frame")
playerListFrame.Size = UDim2.new(1, -20, 0, 250)
playerListFrame.Position = UDim2.new(0, 10, 0, 300)
playerListFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
playerListFrame.Parent = menuFrame

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Padding = UDim.new(0, 5)
playerListLayout.Parent = playerListFrame

-- Функция обновления списка игроков
local function updatePlayerList()
    for _, v in ipairs(playerListFrame:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= player then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0, 40)
            playerButton.Text = v.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            playerButton.TextSize = 18
            playerButton.Parent = playerListFrame

            playerButton.MouseButton1Click:Connect(function()
                -- Применяем хитбокс на выбранного игрока
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(hitBoxSize, hitBoxSize, hitBoxSize)
                    hrp.Transparency = 0.5
                    hrp.BrickColor = BrickColor.new("Bright blue")
                    hrp.Material = "SmoothPlastic"
                    hrp.CanCollide = false
                end
            end)
        end
    end
end

-- Обновление списка игроков каждую секунду
while true do
    updatePlayerList()
    wait(1)
end
