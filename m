Return-Path: <linux-kernel+bounces-563424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A265DA64199
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9EA416D843
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4AA21A444;
	Mon, 17 Mar 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iot4REpc"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121D1B0401;
	Mon, 17 Mar 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193241; cv=none; b=Wu/dsRo/t1vOhlRX4m1h2IgImtJCWQEB8jTpVAohIiNruHjiXgYkSRA9tA+EhaMJkNSZXYQ9+TN7vhdmv8TwKkk/8Y3twvhERRYwzfDw0OufLpFIG8b3uPBGKH3JYg1ptGesTlqiTvLMB3PFUFel4bpSBi6tDueOwF4RYTmcwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193241; c=relaxed/simple;
	bh=cnzHwtcxR0J1F/xOvyMa2Ch1YB3B5zJbuKmfoCLlHGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nULxY+8jkaY8ivqmHgKU9pCdlpDZxNXOyit3VvGQTTJIRvOez8EJmAk8wpJ8V+ssHHdzYH7t8oKSRkStwSTwbbBNweXx2NFjmc/5FZBzUjFqLdCQUrPysfXFJz6PMViq5YA9VlpcdaVb9xjmE0XGI/QufPIXccpOmx9INkT7tx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iot4REpc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3018c9c6b5fso646662a91.3;
        Sun, 16 Mar 2025 23:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193239; x=1742798039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJvFT5GCHg1GWLrlxfBtd+P/oPS0GN0NKk2wNs1GpZw=;
        b=iot4REpcZjrOsRYp1RAzA8HgNpWSXEof6uVa1lnh+PwvcLyRLk/WaD/ts6XqDUfoR1
         3d/VPPfs7FSsD55iaGxW5gfo25OxUALRWN7DPaJPhR8DKKY37wlLiT5SEXlciyOCd6mh
         RovJ/vd9gw4fxITMzdW0EIj2G3WFCtC+PAQ4e9FI6rUtTcx5x083lQlxj9u6McWn3uxI
         +BRh89dfZROUN0Ot4jQmJV8ffp/TDzYXbvtoS/b0si4mRpkruGd99DYZl+0o2UpUG5BG
         xmZ9dKS+E032kixtubH1UWLNpTYUV2iNLY/dwAwN+b3Ld7ow0dI/LDCVbiaslZaxfHtL
         dAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193239; x=1742798039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJvFT5GCHg1GWLrlxfBtd+P/oPS0GN0NKk2wNs1GpZw=;
        b=uU0gnrQPHM98NhOfyWDFFXXX2eAQqftiX7RnpKvbPwggJbzECUx7oZWB4a1yVp7gTf
         aXUvhXtROC9DcSNsPhX+D8XmrmMPK9TPgzdLnistb+QReojcPMy0jZsDIS13YrMOYxzT
         SLA6Bor7tmOtN1L8XQYYXLcS+bdDsweENCE16mP/iAwxMNacj+ftbNKTFIAYGcbfW4RD
         CVdWmUJ8Qe7c2Kbho8JNeq/tdNB0sCWC/YFljjVoTI+lx2Iy9aXCwGO6arXBSnRdEryM
         FzF9ol9+F3W/RTVI4A9X0vW0FgQOAruPumf+3Eei4cecxCacvZp86GloF25vTKZWu6Zo
         4lzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/x9kmr8K9gMvltRuyvn355HZQ3olvk285NTUpRtnj6r+PzmpVxv0G1JNuPg5MjR3VGBHiO1Zx9gg=@vger.kernel.org, AJvYcCWO6Ke7V9AW+NM7JI3WMb/fTdFXJOeIuUcrLcUPEw1Dt5URixQ7eJRvZg2mznhfAdAltW7vdwNKtWQXy9F9vBZaqbiKNw==@vger.kernel.org, AJvYcCXSfQYGvp2olo3OJa92aYTajggJebemr5Q6yAuO5gkwiT2zeAvqPP8dNpx73ESWEGBw3oG3IrXnczs/VXwq@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHv4GJINJeP2aLsTdgOf8xz/csLTK8FO/1KT4OBTgi46JhxNy
	LJ5o7SHuJ1pXQdAtSsGJFV0Sriu5mrxiKsI8tv433VXKm1zTE/zT
X-Gm-Gg: ASbGncuibsEoQ18P9FECciKMcOm6z3MJGmsfsO2DRW2gCQPKnPJrHJn5lBzY2U3+SIm
	EvvN8SxvQpcXy8nxYn69oOEHK84wHVTsxxL+WcsPmH7utqGEpQ+GQxnRaEjCviZu1CjYnmVv4rP
	r69qfJb8UVnC+dMTMJkpbf8FubATQbsSos7HuOoIjPdYetNhk9+3V7Rofzpd/OQAr+N1ndYKiAO
	Cp6joy1168IcAlXqqDp6zrKrlzVCRu7x7o+z+HewAWbpY/x7i7IW0SuH8jJFWI6eobnHVLI0kwd
	w54mmGPHcuXVOvEPFdtFgUa3nD6G30+IhlEACXPDRZB+az63yfPal9gk5y9hvC/n5UBFyMBzMnF
	+vIDyh+RSYk6mB+TWYEA3xMtTUlQdbV6ziEJAO8PSdqc=
X-Google-Smtp-Source: AGHT+IFZT82O3nYeordHUA8x5UxM/1Rr2fdt07QrQCagee4x/x6EFJ2F7r+pMUkm36GZYn+hka2g5g==
X-Received: by 2002:a17:90a:ea8c:b0:2ff:52e1:c4b4 with SMTP id 98e67ed59e1d1-30151d81707mr12103836a91.32.1742193238592;
        Sun, 16 Mar 2025 23:33:58 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afee51sm5186555a91.28.2025.03.16.23.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:33:58 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>,
	Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Cody T . -H . Chiu" <codyit@gmail.com>,
	John Martens <johnfanv2@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] platform/x86: Add lenovo-wmi-* driver Documentation
Date: Sun, 16 Mar 2025 23:33:28 -0700
Message-ID: <20250317063337.352966-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317063337.352966-1-derekjohn.clark@gmail.com>
References: <20250317063337.352966-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds documentation for new lenovo-wmi drivers.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
 - Fixed MOF formatting issues.
 - Fixed spelling mistakes.
 - Updated description of balanced-performance profile for Gamezone.
 - Updated description of thermal mode event GUID for Gamezone.
v3:
- Split documentation into multiple files, one for each parent
  driver for the Gamezone and Other Mode WMI interfaces.
- Add MOF data for all parent and child interfaces.
- Remove lenovo-wmi-camera.c driver from v2 documentation.
v2:
- Update description of Custom Profile to include the need to manually
  set it.
- Remove all references to Legion hardware.
- Add section for lenovo-wmi-camera.c driver as it follows the same
  naming convention.
---
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 203 ++++++++++++++++++
 .../wmi/devices/lenovo-wmi-other-method.rst   | 108 ++++++++++
 MAINTAINERS                                   |   7 +
 3 files changed, 318 insertions(+)
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.rst

diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
new file mode 100644
index 000000000000..bde63dde285d
--- /dev/null
+++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
@@ -0,0 +1,203 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+==========================================================
+Lenovo WMI Interface Gamezone Driver (lenovo-wmi-gamezone)
+==========================================================
+
+Introduction
+============
+The Lenovo WMI gamezone interface is broken up into multiple GUIDs,
+The priamry "Gamezone" GUID provides advanced features such as fan
+profiles and overclocking. It is paired with multiple event GUIDs
+and data block GUIDs that provide context for the various methods.
+
+Gamezone Data
+-------------
+
+WMI GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The Gamezone Data WMI interface provides platform-profile and fan curve
+settings for devices that fall under the "Gaming Series" of Lenovo devices.
+It uses a notifier chain to inform other Lenovo WMI interface drivers of the
+current platform profile when it changes.
+
+The following platform profiles are supported:
+ - low-power
+ - balanced
+ - balanced-performance*
+ - performance
+ - custom
+
+Balanced-Performance
+~~~~~~~~~~~~~~~~~~~~
+Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profile
+enabled in their BIOS. For these devices, the performance platform profile
+will correspond to the BIOS Extreme Mode, while the balanced-performance
+platform profile will correspond to the BIOS Performance mode. For legacy
+devices, the performance platform profile will correspond with the BIOS
+Performance mode. For some newer devices the "Extreme Mode" profile is
+incomplete in the BIOS and setting it will cause undefined behavior. A
+BIOS bug quirk table is provided to ensure these devices cannot set
+"Extreme Mode" from the driver.
+
+Custom Profile
+~~~~~~~~~~~~~~
+The custom profile represents a hardware mode on Lenovo devices that enables
+user modifications to Package Power Tracking (PPT) and fan curve settings.
+When an attribute exposed by the Other Mode WMI interface is to be modified,
+the Gamezone driver must first be switched to the "custom" profile manually,
+or the setting will have no effect. If another profile is set from the list
+of supported profiles, the BIOS will override any user PPT settings when
+switching to that profile.
+
+Gamezone Thermal Mode Event
+---------------------------
+
+WMI GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The Gamezone Thermal Mode Event interface notifies the system when the platform
+profile has changed, either through the hardware event (Fn+Q for laptops or
+Legion + Y for Go Series), or through the Gamezone WMI interface. This event is
+implemented in the Lenovo WMI Events driver (lenovo-wmi-events).
+
+
+WMI interface description
+=========================
+
+The WMI interface description can be decoded from the embedded binary MOF (bmof)
+data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
+
+::
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("LENOVO_GAMEZONE_DATA class"), guid("{887B54E3-DDDC-4B2C-8B88-68A26A8835D0}")]
+  class LENOVO_GAMEZONE_DATA {
+  	[key, read] string InstanceName;
+  	[read] boolean Active;
+
+    [WmiMethodId(4), Implemented, Description("Is SupportGpu OverClock")] void IsSupportGpuOC([out, Description("Is SupportGpu OverClock")] uint32 Data);
+    [WmiMethodId(11), Implemented, Description("Get AslCode Version")] void GetVersion ([out, Description("AslCode version")] UINT32 Data);
+    [WmiMethodId(12), Implemented, Description("Fan cooling capability")] void IsSupportFanCooling([out, Description("Fan cooling capability")] UINT32 Data);
+    [WmiMethodId(13), Implemented, Description("Set Fan cooling on/off")] void SetFanCooling ([in, Description("Set Fan cooling on/off")] UINT32 Data);
+    [WmiMethodId(14), Implemented, Description("cpu oc capability")] void IsSupportCpuOC ([out, Description("cpu oc capability")] UINT32 Data);
+    [WmiMethodId(15), Implemented, Description("bios has overclock capability")] void IsBIOSSupportOC ([out, Description("bios has overclock capability")] UINT32 Data);
+    [WmiMethodId(16), Implemented, Description("enable or disable overclock in bios")] void SetBIOSOC ([in, Description("enable or disable overclock in bios")] UINT32 Data);
+    [WmiMethodId(18), Implemented, Description("Get CPU temperature")] void GetCPUTemp ([out, Description("Get CPU temperature")] UINT32 Data);
+    [WmiMethodId(19), Implemented, Description("Get GPU temperature")] void GetGPUTemp ([out, Description("Get GPU temperature")] UINT32 Data);
+    [WmiMethodId(20), Implemented, Description("Get Fan cooling on/off status")] void GetFanCoolingStatus ([out, Description("Get Fan cooling on/off status")] UINT32 Data);
+    [WmiMethodId(21), Implemented, Description("EC support disable windows key capability")] void IsSupportDisableWinKey ([out, Description("EC support disable windows key capability")] UINT32 Data);
+    [WmiMethodId(22), Implemented, Description("Set windows key disable/enable")] void SetWinKeyStatus ([in, Description("Set windows key disable/enable")] UINT32 Data);
+    [WmiMethodId(23), Implemented, Description("Get windows key disable/enable status")] void GetWinKeyStatus ([out, Description("Get windows key disable/enable status")] UINT32 Data);
+    [WmiMethodId(24), Implemented, Description("EC support disable touchpad capability")] void IsSupportDisableTP ([out, Description("EC support disable touchpad capability")] UINT32 Data);
+    [WmiMethodId(25), Implemented, Description("Set touchpad disable/enable")] void SetTPStatus ([in, Description("Set touchpad disable/enable")] UINT32 Data);
+    [WmiMethodId(26), Implemented, Description("Get touchpad disable/enable status")] void GetTPStatus ([out, Description("Get touchpad disable/enable status")] UINT32 Data);
+    [WmiMethodId(30), Implemented, Description("Get Keyboard feature list")] void GetKeyboardfeaturelist ([out, Description("Get Keyboard feature list")] UINT32 Data);
+    [WmiMethodId(31), Implemented, Description("Get Memory OC Information")] void GetMemoryOCInfo ([out, Description("Get Memory OC Information")] UINT32 Data);
+    [WmiMethodId(32), Implemented, Description("Water Cooling feature capability")] void IsSupportWaterCooling ([out, Description("Water Cooling feature capability")] UINT32 Data);
+    [WmiMethodId(33), Implemented, Description("Set Water Cooling status")] void SetWaterCoolingStatus ([in, Description("Set Water Cooling status")] UINT32 Data);
+    [WmiMethodId(34), Implemented, Description("Get Water Cooling status")] void GetWaterCoolingStatus ([out, Description("Get Water Cooling status")] UINT32 Data);
+    [WmiMethodId(35), Implemented, Description("Lighting feature capability")] void IsSupportLightingFeature ([out, Description("Lighting feature capability")] UINT32 Data);
+    [WmiMethodId(36), Implemented, Description("Set keyboard light off or on to max")] void SetKeyboardLight ([in, Description("keyboard light off or on switch")] UINT32 Data);
+    [WmiMethodId(37), Implemented, Description("Get keyboard light on/off status")] void GetKeyboardLight ([out, Description("Get keyboard light on/off status")] UINT32 Data);
+    [WmiMethodId(38), Implemented, Description("Get Macrokey scan code")] void GetMacrokeyScancode ([in, Description("Macrokey index")] UINT32 idx, [out, Description("Scan code")] UINT32 scancode);
+    [WmiMethodId(39), Implemented, Description("Get Macrokey count")] void GetMacrokeyCount ([out, Description("Macrokey count")] UINT32 Data);
+    [WmiMethodId(40), Implemented, Description("Support G-Sync feature")] void IsSupportGSync ([out, Description("Support G-Sync feature")] UINT32 Data);
+    [WmiMethodId(41), Implemented, Description("Get G-Sync Status")] void GetGSyncStatus ([out, Description("Get G-Sync Status")] UINT32 Data);
+    [WmiMethodId(42), Implemented, Description("Set G-Sync Status")] void SetGSyncStatus ([in, Description("Set G-Sync Status")] UINT32 Data);
+    [WmiMethodId(43), Implemented, Description("Support Smart Fan feature")] void IsSupportSmartFan ([out, Description("Support Smart Fan feature")] UINT32 Data);
+    [WmiMethodId(44), Implemented, Description("Set Smart Fan Mode")] void SetSmartFanMode ([in, Description("Set Smart Fan Mode")] UINT32 Data);
+    [WmiMethodId(45), Implemented, Description("Get Smart Fan Mode")] void GetSmartFanMode ([out, Description("Get Smart Fan Mode")] UINT32 Data);
+    [WmiMethodId(46), Implemented, Description("Get Smart Fan Setting Mode")] void GetSmartFanSetting ([out, Description("Get Smart Setting Mode")] UINT32 Data);
+    [WmiMethodId(47), Implemented, Description("Get Power Charge Mode")] void GetPowerChargeMode ([out, Description("Get Power Charge Mode")] UINT32 Data);
+    [WmiMethodId(48), Implemented, Description("Get Gaming Product Info")] void GetProductInfo ([out, Description("Get Gaming Product Info")] UINT32 Data);
+    [WmiMethodId(49), Implemented, Description("Over Drive feature capability")] void IsSupportOD ([out, Description("Over Drive feature capability")] UINT32 Data);
+    [WmiMethodId(50), Implemented, Description("Get Over Drive status")] void GetODStatus ([out, Description("Get Over Drive status")] UINT32 Data);
+    [WmiMethodId(51), Implemented, Description("Set Over Drive status")] void SetODStatus ([in, Description("Set Over Drive status")] UINT32 Data);
+    [WmiMethodId(52), Implemented, Description("Set Light Control Owner")] void SetLightControlOwner ([in, Description("Set Light Control Owner")] UINT32 Data);
+    [WmiMethodId(53), Implemented, Description("Set DDS Control Owner")] void SetDDSControlOwner ([in, Description("Set DDS Control Owner")] UINT32 Data);
+    [WmiMethodId(54), Implemented, Description("Get the flag of restore OC value")] void IsRestoreOCValue ([in, Description("Clean this flag")] UINT32 idx, [out, Description("Restore oc value flag")] UINT32 Data);
+    [WmiMethodId(55), Implemented, Description("Get Real Thremal Mode")] void GetThermalMode ([out, Description("Real Thremal Mode")] UINT32 Data);
+    [WmiMethodId(56), Implemented, Description("Get the OC switch status in BIOS")] void GetBIOSOCMode ([out, Description("OC Mode")] UINT32 Data);
+    [WmiMethodId(59), Implemented, Description("Get hardware info support version")] void GetHardwareInfoSupportVersion ([out, Description("version")] UINT32 Data);
+    [WmiMethodId(60), Implemented, Description("Get Cpu core 0 max frequency")] void GetCpuFrequency ([out, Description("frequency")] UINT32 Data);
+    [WmiMethodId(62), Implemented, Description("Check the Adapter type fit for OC")] void IsACFitForOC ([out, Description("AC check result")] UINT32 Data);
+    [WmiMethodId(63), Implemented, Description("Is support IGPU mode")] void IsSupportIGPUMode ([out, Description("IGPU modes")] UINT32 Data);
+    [WmiMethodId(64), Implemented, Description("Get IGPU Mode Status")] void GetIGPUModeStatus([out, Description("IGPU Mode Status")] UINT32 Data);
+    [WmiMethodId(65), Implemented, Description("Set IGPU Mode")] void SetIGPUModeStatus([in, Description("IGPU Mode")] UINT32 mode, [out, Description("return code")] UINT32 Data);
+    [WmiMethodId(66), Implemented, Description("Notify DGPU Status")] void NotifyDGPUStatus([in, Description("DGPU status")] UINT32 status, [out, Description("return code")] UINT32 Data);
+    [WmiMethodId(67), Implemented, Description("Is changed Y log")] void IsChangedYLog([out, Description("Is changed Y Log")] UINT32 Data);
+    [WmiMethodId(68), Implemented, Description("Get DGPU Hardwawre ID")] void GetDGPUHWId([out, Description("Get DGPU Hardware ID")] string Data);
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("Definition of CPU OC parameter list"), guid("{B7F3CA0A-ACDC-42D2-9217-77C6C628FBD2}")]
+  class LENOVO_GAMEZONE_CPU_OC_DATA {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description("OC tune id.")] uint32 Tuneid;
+    [WmiDataId(2), read, Description("Default value.")] uint32 DefaultValue;
+    [WmiDataId(3), read, Description("OC Value.")] uint32 OCValue;
+    [WmiDataId(4), read, Description("Min Value.")] uint32 MinValue;
+    [WmiDataId(5), read, Description("Max Value.")] uint32 MaxValue;
+    [WmiDataId(6), read, Description("Scale Value.")] uint32 ScaleValue;
+    [WmiDataId(7), read, Description("OC Order id.")] uint32 OCOrderid;
+    [WmiDataId(8), read, Description("NON-OC Order id.")] uint32 NOCOrderid;
+    [WmiDataId(9), read, Description("Delay time in ms.")] uint32 Interval;
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("Definition of GPU OC parameter list"), guid("{887B54E2-DDDC-4B2C-8B88-68A26A8835D0}")]
+  class LENOVO_GAMEZONE_GPU_OC_DATA {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description("P-State ID.")] uint32 PStateID;
+    [WmiDataId(2), read, Description("CLOCK ID.")] uint32 ClockID;
+    [WmiDataId(3), read, Description("Default value.")] uint32 defaultvalue;
+    [WmiDataId(4), read, Description("OC Offset freqency.")] uint32 OCOffsetFreq;
+    [WmiDataId(5), read, Description("OC Min offset value.")] uint32 OCMinOffset;
+    [WmiDataId(6), read, Description("OC Max offset value.")] uint32 OCMaxOffset;
+    [WmiDataId(7), read, Description("OC Offset Scale.")] uint32 OCOffsetScale;
+    [WmiDataId(8), read, Description("OC Order id.")] uint32 OCOrderid;
+    [WmiDataId(9), read, Description("NON-OC Order id.")] uint32 NOCOrderid;
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("Fancooling finish event"), guid("{BC72A435-E8C1-4275-B3E2-D8B8074ABA59}")]
+  class LENOVO_GAMEZONE_FAN_COOLING_EVENT: WMIEvent {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description("Fancooling clean finish event")] uint32 EventId;
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("Smart Fan mode change event"), guid("{D320289E-8FEA-41E0-86F9-611D83151B5F}")]
+  class LENOVO_GAMEZONE_SMART_FAN_MODE_EVENT: WMIEvent {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description("Smart Fan Mode change event")] uint32 mode;
+    [WmiDataId(2), read, Description("version of FN+Q")] uint32 version;
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("Smart Fan setting mode change event"), guid("{D320289E-8FEA-41E1-86F9-611D83151B5F}")]
+  class LENOVO_GAMEZONE_SMART_FAN_SETTING_EVENT: WMIEvent {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description("Smart Fan Setting mode change event")] uint32 mode;
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("POWER CHARGE MODE Change EVENT"), guid("{D320289E-8FEA-41E0-86F9-711D83151B5F}")]
+  class LENOVO_GAMEZONE_POWER_CHARGE_MODE_EVENT: WMIEvent {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description("POWER CHARGE MODE Change EVENT")] uint32 mode;
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("Thermal Mode Real Mode change event"), guid("{D320289E-8FEA-41E0-86F9-911D83151B5F}")]
+  class LENOVO_GAMEZONE_THERMAL_MODE_EVENT: WMIEvent {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description("Thermal Mode Real Mode")] uint32 mode;
+  };
diff --git a/Documentation/wmi/devices/lenovo-wmi-other-method.rst b/Documentation/wmi/devices/lenovo-wmi-other-method.rst
new file mode 100644
index 000000000000..b48832726311
--- /dev/null
+++ b/Documentation/wmi/devices/lenovo-wmi-other-method.rst
@@ -0,0 +1,108 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+===========================================================
+Lenovo WMI Interface Other Mode Driver (lenovo-wmi-other)
+===========================================================
+
+Introduction
+============
+Lenovo WMI Other Mode interface is broken up into multiple GUIDs,
+The primary Other Mode interface provides advanced power tuning features
+such as Package Power Tracking (PPT). It is paired with multiple data block
+GUIDs that provide context for the various methods.
+
+
+Other Mode
+----------
+
+WMI GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The Other Mode WMI interface uses the firmware_attributes class to expose
+various WMI attributes provided by the interface in the sysfs. This enables
+CPU and GPU power limit tuning as well as various other attributes for
+devices that fall under the "Gaming Series" of Lenovo devices. Each
+attribute exposed by the Other Mode interface has corresponding
+capability data blocks which allow the driver to probe details about the
+attribute. Each attribute has multiple pages, one for each of the platform
+profiles managed by the Gamezone interface. Attributes are exposed in sysfs
+under the following path:
+
+::
+/sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>/
+
+LENOVO_CAPABILITY_DATA_01
+-------------------------
+
+WMI GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The LENOVO_CAPABILITY_DATA_01 interface provides information on various
+power limits of integrated CPU and GPU components.
+
+Each attribute has the following properties:
+ - current_value
+ - default_value
+ - display_name
+ - max_value
+ - min_value
+ - scalar_increment
+ - type
+
+The following attributes are implemented:
+ - ppt_pl1_spl: Platform Profile Tracking Sustained Power Limit
+ - ppt_pl2_sppt: Platform Profile Tracking Slow Package Power Tracking
+ - ppt_pl3_fppt: Platform Profile Tracking Fast Package Power Tracking
+
+
+WMI interface description
+=========================
+
+The WMI interface description can be decoded from the embedded binary MOF (bmof)
+data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
+
+::
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("LENOVO_OTHER_METHOD class"), guid("{dc2a8805-3a8c-41ba-a6f7-092e0089cd3b}")]
+  class LENOVO_OTHER_METHOD {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiMethodId(17), Implemented, Description("Get Feature Value ")] void GetFeatureValue([in] uint32 IDs, [out] uint32 value);
+    [WmiMethodId(18), Implemented, Description("Set Feature Value ")] void SetFeatureValue([in] uint32 IDs, [in] uint32 value);
+    [WmiMethodId(19), Implemented, Description("Get Data By Command ")] void GetDataByCommand([in] uint32 IDs, [in] uint32 Command, [out] uint32 DataSize, [out, WmiSizeIs("DataSize")] uint32 Data[]);
+    [WmiMethodId(99), Implemented, Description("Get Data By Package for TAC")] void GetDataByPackage([in, Max(40)] uint8 Input[], [out] uint32 DataSize, [out, WmiSizeIs("DataSize")] uint8 Data[]);
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("LENOVO CAPABILITY DATA 00"), guid("{362a3afe-3d96-4665-8530-96dad5bb300e}")]
+  class LENOVO_CAPABILITY_DATA_00 {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description(" IDs.")] uint32 IDs;
+    [WmiDataId(2), read, Description("Capability.")] uint32 Capability;
+    [WmiDataId(3), read, Description("Capability Default Value.")] uint32 DefaultValue;
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("LENOVO CAPABILITY DATA 01"), guid("{7a8f5407-cb67-4d6e-b547-39b3be018154}")]
+  class LENOVO_CAPABILITY_DATA_01 {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description(" IDs.")] uint32 IDs;
+    [WmiDataId(2), read, Description("Capability.")] uint32 Capability;
+    [WmiDataId(3), read, Description("Default Value.")] uint32 DefaultValue;
+    [WmiDataId(4), read, Description("Step.")] uint32 Step;
+    [WmiDataId(5), read, Description("Minimum Value.")] uint32 MinValue;
+    [WmiDataId(6), read, Description("Maximum Value.")] uint32 MaxValue;
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("LENOVO CAPABILITY DATA 02"), guid("{bbf1f790-6c2f-422b-bc8c-4e7369c7f6ab}")]
+  class LENOVO_CAPABILITY_DATA_02 {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiDataId(1), read, Description(" IDs.")] uint32 IDs;
+    [WmiDataId(2), read, Description("Capability.")] uint32 Capability;
+    [WmiDataId(3), read, Description("Data Size.")] uint32 DataSize;
+    [WmiDataId(4), read, Description("Default Value"), WmiSizeIs("DataSize")] uint8 DefaultValue[];
+  };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1afd30d00aec..675f4b26426d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13158,6 +13158,13 @@ S:	Maintained
 W:	http://legousb.sourceforge.net/
 F:	drivers/usb/misc/legousbtower.c
 
+LENOVO WMI DRIVERS
+M:	Derek J. Clark <derekjohn.clark@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
+F:	Documentation/wmi/devices/lenovo-wmi-other.rst
+
 LENOVO WMI HOTKEY UTILITIES DRIVER
 M:	Jackie Dong <xy-jackie@139.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.49.0


