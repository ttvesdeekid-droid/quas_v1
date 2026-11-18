--// Quas V1 - Murderers vs Sheriffs Aimbot & ESP
--// Designed for Potassium

local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")

--// Settings
local Settings = {
 TargetPart = "Head", -- Options: "Head", "Torso", "HumanoidRootPart"
 AutoShoot = true,
 FOV = 150,
 ESP = true,
 TargetHighPriority = true,
 MinimapEnabled = true
}

--// UI Variables
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuasV1"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

--// Window Variables
local WindowFrame = Instance.new("Frame")
WindowFrame.Name = "WindowFrame"
WindowFrame.Size = UDim2.new(0, 350, 0, 400)
WindowFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
WindowFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
WindowFrame.BackgroundTransparency = 0
WindowFrame.BorderSizePixel = 0
WindowFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = WindowFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
 ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
 ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
})
UIGradient.Parent = WindowFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = WindowFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Quas V1"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0, 7.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "x"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0, 7.5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TitleFrame

--// Minimize Logic
local isWindowOpen = true
local MinimizedFrame = Instance.new("Frame")
MinimizedFrame.Name = "MinimizedFrame"
MinimizedFrame.Size = UDim2.new(0, 30, 0, 30)
MinimizedFrame.Position = UDim2.new(0.5, 0, 0.8, 0)
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MinimizedFrame.BorderSizePixel = 0
MinimizedFrame.Parent = ScreenGui

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 5)
MinimizeCorner.Parent = MinimizedFrame

local MinimizeEye = Instance.new("TextLabel")
MinimizeEye.Name = "MinimizeEye"
MinimizeEye.Size = UDim2.new(1, 0, 1, 0)
MinimizeEye.BackgroundTransparency = 1
MinimizeEye.Text = "👁️"
MinimizeEye.TextSize = 24
MinimizeEye.Parent = MinimizedFrame

CloseButton.MouseButton1Click:Connect(function()
 WindowFrame.Visible = false
 MinimizeButton.Visible = false
 MinimizedFrame.Visible = true
end)

MinimizeButton.MouseButton1Click:Connect(function()
 WindowFrame.Visible = true
 MinimizeButton.Visible = true
 MinimizedFrame.Visible = false
end)

MinimizedFrame.MouseButton1Click:Connect(function()
 WindowFrame.Visible = true
 MinimizeButton.Visible = true
 MinimizedFrame.Visible = false
end)

--// Options Frame
local OptionsFrame = Instance.new("Frame")
OptionsFrame.Name = "OptionsFrame"
OptionsFrame.Size = UDim2.new(1, 0, 1, -35)
OptionsFrame.Position = UDim2.new(0, 0, 0, 35)
OptionsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OptionsFrame.BackgroundTransparency = 0.5
OptionsFrame.BorderSizePixel = 0
OptionsFrame.Parent = WindowFrame

local OptionsLayout = Instance.new("UIListLayout")
OptionsLayout.Padding = UDim.new(0, 10)
OptionsLayout.Parent = OptionsFrame

--// Settings Elements
local PartDropdown = Instance.new("TextButton")
PartDropdown.Name = "PartDropdown"
PartDropdown.Size = UDim2.new(1, 0, 0, 30)
PartDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PartDropdown.Text = "Target Part: ".. Settings.TargetPart
PartDropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
PartDropdown.TextSize = 14
PartDropdown.Font = Enum.Font.Gotham
PartDropdown.Parent = OptionsFrame

local AutoShootToggle = Instance.new("TextButton")
AutoShootToggle.Name = "AutoShootToggle"
AutoShootToggle.Size = UDim2.new(1, 0, 0, 30)
AutoShootToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AutoShootToggle.Text = "Auto Shoot: ".. tostring(Settings.AutoShoot)
AutoShootToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
AutoShootToggle.TextSize = 14
AutoShootToggle.Font = Enum.Font.Gotham
AutoShootToggle.Parent = OptionsFrame

local FOVSlider = Instance.new("TextButton")
FOVSlider.Name = "FOVSlider"
FOVSlider.Size = UDim2.new(1, 0, 0, 30)
FOVSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FOVSlider.Text = "FOV: ".. Settings.FOV
FOVSlider.TextColor3 = Color3.fromRGB(0, 0, 0)
FOVSlider.TextSize = 14
FOVSlider.Font = Enum.Font.Gotham
FOVSlider.Parent = OptionsFrame

--// Event Handlers
PartDropdown.MouseButton1Click:Connect(function()
 if Settings.TargetPart == "Head" then Settings.TargetPart = "Torso" elseif Settings.TargetPart == "Torso" then Settings.TargetPart = "HumanoidRootPart" else Settings.TargetPart = "Head" end
 PartDropdown.Text = "Target Part: ".. Settings.TargetPart
end)

AutoShootToggle.MouseButton1Click:Connect(function()
 Settings.AutoShoot = not Settings.AutoShoot
 AutoShootToggle.Text = "Auto Shoot: ".. tostring(Settings.AutoShoot)
end)

FOVSlider.MouseButton1Click:Connect(function()
 Settings.FOV = Settings.FOV + 10
 if Settings.FOV > 300 then Settings.FOV = 50 end
 FOVSlider.Text = "FOV: ".. Settings.FOV
end)

--// ESP Drawing System
local ESPObjects = {}

local function CreateESP(player)
 local esp = {}
 esp.Line = Drawing.new("Line")
 esp.Box = Drawing.new("Square")
 esp.Distance = Drawing.new("Text")
 esp.Name = Drawing.new("Text")

 esp.Line.Thickness = 2
 esp.Line.Color = Color3.fromRGB(0, 255, 0)
 esp.Line.Visible = Settings.ESP

 esp.Box.Thickness = 1
 esp.Box.Color = Color3.fromRGB(0, 0, 255)
 esp.Box.Filled = false
 esp.Box.Visible = Settings.ESP

 esp.Distance.Size = 14
 esp.Distance.Color = Color3.fromRGB(255, 255, 255)
 esp.Distance.Visible = Settings.ESP

 esp.Name.Size = 14
 esp.Name.Color = Color3.fromRGB(255, 255, 255)
 esp.Name.Visible = Settings.ESP

 table.insert(ESPObjects, {Player = player, Esp = esp})
end

local function UpdateESP()
 for _, v in pairs(ESPObjects) do
 local char = v.Player.Character
 if char and char:FindFirstChild(Settings.TargetPart) then
 local part = char[Settings.TargetPart]
 local pos, visible = Camera:WorldToViewportPoint(part.Position)

 if visible then
 local dist = math.floor((v.Player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude)

 v.Esp.Line.From = Vector2.new(pos.X, pos.Y)
 v.Esp.Line.To = Vector2.new(pos.X + 20, pos.Y - 20)
 v.Esp.Line.Visible = true

 v.Esp.Box.Size = Vector2.new(40, 40)
 v.Esp.Box.Position = Vector2.new(pos.X - 20, pos.Y - 20)
 v.Esp.Box.Visible = true

 v.Esp.Distance.Text = tostring(dist).. " studs"
 v.Esp.Distance.Position = Vector2.new(pos.X + 25, pos.Y - 40)
 v.Esp.Distance.Visible = true

 v.Esp.Name.Text = v.Player.Name
 v.Esp.Name.Position = Vector2.new(pos.X - 15, pos.Y - 60)
 v.Esp.Name.Visible = true
 else
 v.Esp.Line.Visible = false
 v.Esp.Box.Visible = false
 v.Esp.Distance.Visible = false
 v.Esp.Name.Visible = false
 end
 else
 for _, obj in pairs(v.Esp) do obj.Visible = false end
 end
 end
end

for _, v in pairs(Player:GetPlayers()) do if v ~= Player then CreateESP(v) end end

--// Aimbot Logic
local function GetClosestTarget()
 local closestDist = math.huge
 local closestPlayer = nil

 for _, v in pairs(Player:GetPlayers()) do
 if v ~= Player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
 local part = v.Character:FindFirstChild(Settings.TargetPart)
 if part then
 local pos, visible = Camera:WorldToViewportPoint(part.Position)
 local dist = (Vector2.new(pos.X, pos.Y) - Camera.Mouse.Hit.Position).Magnitude

 if visible and dist < Settings.FOV then
 if dist < closestDist then
 closestDist = dist
 closestPlayer = v
 end
 end
 end
 end
 end
 return closestPlayer
end

--// Auto Shoot Logic
local function Shoot()
 if not Settings.AutoShoot then return end
 
 local char = Player.Character
 if not char then return end
 
 local tool = char:FindFirstChildOfClass("Tool")
 if not tool then return end
 
 local handle = tool:FindFirstChild("Handle") or tool:FindFirstChild("Part")
 if not handle then return end
 
 local velocity = handle:FindFirstChild("AssemblyLinearVelocity")
 if not velocity then return end
 
 velocity.Value = velocity.Unit * 100
end

--// Main Loop
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
 UpdateESP()
 
 local target = GetClosestTarget()
 if target then
 local char = target.Character
 if char then
 local part = char:FindFirstChild(Settings.TargetPart)
 if part then
 local cameraCF = Camera.CFrame
 local targetCF = CFrame.new(part.Position)
 Camera.CFrame = cameraCF * CFrame.lookAt(cameraCF.Position, part.Position)
 end
 end
 
 Shoot()
 end
end)
