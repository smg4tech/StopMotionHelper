local PANEL = {}

function PANEL:Init()

	self:SetTitle("Save")
	self:SetDeleteOnClose(false)

	self.FileName = vgui.Create("DTextEntry", self)
	self.FileName.Label = vgui.Create("DLabel", self)
	self.FileName.Label:SetText("Name")
	self.FileName.Label:SizeToContents()

	self.FileList = vgui.Create("DListView", self)
	self.FileList:SetMultiSelect(false)
	self.FileList:AddColumn("Saved scenes")
	self.FileList.OnRowSelected = function(_, rowID, row)
		if not IsValid(row) then
			return
		end
		self.FileName:SetValue(row:GetValue(1))
	end

	self.Save = vgui.Create("DButton", self)
	self.Save:SetText("Save")
	self.Save.DoClick = function()
		self:DoSave()
	end

	self.Delete = vgui.Create("DButton", self)
	self.Delete:SetText("Delete")
	self.Save.DoClick = function()
		self:DoDelete()
	end

end

function PANEL:PerformLayout(width, height)
	
	self.BaseClass.PerformLayout(self, width, height)

	self:SetSize(250, 250)
	self:SetPos(ScrW() / 2 - self:GetWide() / 2, ScrH() / 2 - self:GetTall() / 2)

	self.FileName:SetPos(5, 45)
	self.FileName:SetSize(self:GetWide() - 5 - 5, 20)
	self.FileName.Label:SetPos(5, 30)

	self.FileList:SetPos(5, 67)
	self.FileList:SetSize(self:GetWide() - 5 - 5, 150)

	self.Save:SetPos(self:GetWide() - 60 - 5, 219)
	self.Save:SetSize(60, 20)

	self.Delete:SetPos(self:GetWide() - 60 - 5 - 60 - 5, 219)
	self.Delete:SetSize(60, 20)

end

function PANEL:SetSaves(saves)
	self.FileList:UpdateFiles(saves)
end

function PANEL:DoSave()
	local path = self.FileName:GetValue()
	if not fileName or fileName == "" then
		return
	end

	-- TODO clientside support for loading and saving
	self:OnSaveRequested(path, false)
end

function PANEL:DoDelete()
	local path = self.FileName:GetValue()
	if not fileName or fileName == "" then
		return
	end

	self:OnDeleteRequested(path)
end

function PANEL:OnSaveRequested(path, saveToClient) end
function PANEL:OnDeleteRequested(path) end

vgui.Register("SMHSave", PANEL, "DFrame")
