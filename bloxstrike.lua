local charlys3gay_gu = getupvalue or debug.getupvalue
local charlys3gay_cloneref = cloneref or function(charlys3gay_o) return charlys3gay_o end
local CHARLYS3GAY_ZERO = Vector3.new()

local charlys3gay_RS = charlys3gay_cloneref(game:GetService("ReplicatedStorage"))
local charlys3gay_RunService = charlys3gay_cloneref(game:GetService("RunService"))
local charlys3gay_lp = charlys3gay_cloneref(game:GetService("Players")).LocalPlayer

local charlys3gay_mods = getloadedmodules()
local charlys3gay_cam
for charlys3gay_i = 1, #charlys3gay_mods do
    local charlys3gay_ok, charlys3gay_r = pcall(require, charlys3gay_mods[charlys3gay_i])
    if charlys3gay_ok and type(charlys3gay_r) == "table" and type(charlys3gay_r.setWeaponRecoil) == "function"
       and type(charlys3gay_r.weaponKick) == "function" then charlys3gay_cam = charlys3gay_r; break end
end
if not charlys3gay_cam then return warn("hmmmmmm") end

local function charlys3gay_hook(charlys3gay_spring, charlys3gay_method)
    local charlys3gay_orig = type(charlys3gay_spring) == "table" and charlys3gay_spring[charlys3gay_method]
    if type(charlys3gay_orig) == "function" then
        charlys3gay_spring[charlys3gay_method] = function(charlys3gay_self, _, ...) return charlys3gay_orig(charlys3gay_self, CHARLYS3GAY_ZERO, ...) end
    end
end

pcall(function()
    charlys3gay_hook(charlys3gay_gu(charlys3gay_cam.setWeaponRecoil, 1), "setGoal")
    for charlys3gay_u = 1, 2 do
        local charlys3gay_sp = charlys3gay_gu(charlys3gay_cam.weaponKick, charlys3gay_u)
        charlys3gay_hook(charlys3gay_sp, "setPosition"); charlys3gay_hook(charlys3gay_sp, "impulse"); charlys3gay_hook(charlys3gay_sp, "setGoal")
    end
end)

pcall(function()
    require(charlys3gay_RS.Interface.Screens.Gameplay.Middle.Crosshair.Settings)["Follow Recoil"] = false

    local charlys3gay_frame = charlys3gay_lp.PlayerGui.MainGui.Gameplay.Middle.Crosshair
    local charlys3gay_centre = UDim2.fromScale(0.5, 0.5)
    charlys3gay_RunService:BindToRenderStep("charlys3gay_pin", Enum.RenderPriority.Last.Value, function()
        if charlys3gay_frame.Position ~= charlys3gay_centre then charlys3gay_frame.Position = charlys3gay_centre end
    end)
end)
