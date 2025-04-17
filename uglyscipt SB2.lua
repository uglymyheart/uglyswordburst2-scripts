local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Neuublue/UILib/main/main.lua"))()
local Window = Library:CreateWindow("Bluu Hub | Swordburst 2")

local Player = Window:AddTab("Player")
local Misc = Window:AddTab("Misc")
local Main = Window:AddTab("Main")

Player:AddButton("Walkspeed", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 300
end)

Player:AddButton("Jump Power", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 300
end)

Player:AddButton("Inf Jump", function()
    local InfiniteJumpEnabled = true
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if InfiniteJumpEnabled then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

Player:AddButton("Noclip", function()
    local noclip = true
    local player = game.Players.LocalPlayer
    local char = player.Character
    game:GetService('RunService').Stepped:Connect(function()
        if noclip then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide == true then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

Main:AddButton("Auto Farm Mobs", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Neuublue/Bluu/main/SB2Farm"))()
end)

Main:AddButton("Kill Aura", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Neuublue/Bluu/main/SB2Aura"))()
end)

Main:AddButton("Equip Best Weapon", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Neuublue/Bluu/main/SB2Best"))()
end)

Misc:AddButton("Anti AFK", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

-- 🧨 InstaKill Feature 🧨
local InstaKillTab = Main:AddRightTabbox()
local InstaKillSettings = InstaKillTab:AddTab("InstaKill")

Toggles.InstaKillTouch = InstaKillSettings:AddToggle("InstaKillTouch", {
    Text = "InstaKill Mobs (Touch)",
    Default = false
})

local function setupTouchKill()
    local plr = game.Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()

    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.Touched:Connect(function(hit)
                if Toggles.InstaKillTouch.Value then
                    local mob = hit:FindFirstAncestorOfClass("Model")
                    if mob and mob:FindFirstChild("Humanoid") then
                        mob.Humanoid.Health = 0
                    end
                end
            end)
        end
    end
end

-- Call function initially and on respawn
setupTouchKill()
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    setupTouchKill()
end)

Library:Notify("Script Loaded!", 5)
