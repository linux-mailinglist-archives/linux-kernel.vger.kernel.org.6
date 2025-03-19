Return-Path: <linux-kernel+bounces-567213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCFA68353
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811EB42211A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B82144D4;
	Wed, 19 Mar 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmJ6JYzy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456FAD2F;
	Wed, 19 Mar 2025 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352535; cv=none; b=EZ2UIBaBbvvNCAAkJydeJERx1Nz0b93OHgsEmktjyNVpov35WXano44WpKKxLIZS6moD7bzLoKy2UaFyxc7Zn0igGH2jXDcKG+jFIDn7R03xprMu9Vt2shfruuV/xk9c9qZHOBdyvWPW8e7MDKIzt5Nf2onPAVUZtZjuT9RGBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352535; c=relaxed/simple;
	bh=YqvGdKANxrj/wsGv7DuhiJsZRPo/jW8mnNA32Mh8rAk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ucPOszuUC39vWUP1+fj7+JMBYSLeR0el5RqIjR3GFnv1SCtIy7PrgjMWUPdlGmsW5WH5lGKZQLtdO4Dhep73L6Jox4My8/nRaIPhEzBk7ZihmHABlGnMEuQT760LcIb80uLe9bORdhyKPqWtYHOPDAn27ZnyRkin5bg2AO+/XpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmJ6JYzy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2239c066347so135657915ad.2;
        Tue, 18 Mar 2025 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742352532; x=1742957332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6ef9AEwKYrTatSXNBf3w09UlmbAjSSNvD49OBBbhXk=;
        b=WmJ6JYzy+whHnACOtKBTDVsi80RaPnl6K/WAmkSN3cMrDKT3JCNrn3uu2ie9+3jAIf
         2vZ3BWm1sPLVa7y8UDN4QRJMa8RBRJmtQ93ypTc8qBrtXKHQcQIuZg08NIJuUpVmYVS1
         pjo9GIJcoyhX3iIxjlUWfmSuhY/PEy37mMcKd6vMkGohUL4ULJ2T9X4FFeqSLtMgDGXb
         bCrLmg++1uVmQb4Q0ioYlyufnNp8sPbg+teY6tpe3M9wfS/6DL5DYG5plZe0pYW8GwPi
         EMiYFH6wRuwAbtXYBiIauk6K2L91S8euCES6OexjNEmsTgzegUQr32LJSpJrHdiU2iWq
         BibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742352532; x=1742957332;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6ef9AEwKYrTatSXNBf3w09UlmbAjSSNvD49OBBbhXk=;
        b=bbtR+jAgh3rWYP7t0Z+JxmaZD727EPwRyxfQ7e/xn8kb6nkgGySB4pYSHUVOwkcm5P
         RUJVTblD1wAPiKz5CiKoHyOMV5PlehXMVDuhwec8Zpp72BRLXERz3aUasMFOUIV+C/fZ
         0P9h4ogT703tKPb8wlv2Qx1aNOtc5aATYBEjZPZI8dHOfp7GZsvZIWqNQGK/5dhq8/lp
         v910fuFfBhE0LzxKsAFEkbfVfBGAd53vORlG62ibXNVBW8ffZ69PvJanhWufEkcfrRZb
         fnscnPxITlMtUmnN7pRaD/VUm9z39pqaUtskbPimjdL7+3bYAblTbePcai6lVm81v7ha
         uU9g==
X-Forwarded-Encrypted: i=1; AJvYcCU9Dxpl9r553kFIoZ2ypUEBvrFrM1QDW3CFnKy0HlTj/qBdqx4zVDyom853ph8ulRc2hXwMJMAjdhBmoTet9FuoHUd4bg==@vger.kernel.org, AJvYcCVGwiF6Bu5Kc/CTXzLiM1qbrHibvA/lRX3p8Aamh/c7p57n9rCSXe/Mg6393dEhaz+K0aCN5mVwM04tp0hE@vger.kernel.org, AJvYcCXmCfT/Narf1E/jvh8AXJCFqTz7aSTKEXKD88Qq3XdnPguMoTYN4GKykfX0BZ/qkgZgyb4YO1+sV48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPoY7AnBIjdWHpVr/Mp9wAQelxjHKs0SXJcLoR118fU5XRxBZ
	jA3/TPi1YTVWl+xGE18ggVWE6F5LrANp3vV7YG+a7YxsU4kqaa+v
X-Gm-Gg: ASbGncvMIpg97N3i6waXgT8LnZqetyOsux4U5ILx5atdxqphWiu+bzZf1UkadWfMt6x
	sCWLfSPIgYQ7AIhQzuupucKJm2DLMneC3ppzbc6ixFpKwQj/ltVFjq97F9Q5wKo4F1khITXC4d0
	8kE7DsVsOldtExOLCWNupmgJcEUlYNsmVDg7EFvQ7ccFeLbi9PlgYuw5Z2LfZa3MHRrOxMnN6Zj
	aJm1kXT3o0FCt4cN35qktt+i3gG26ZTIirJZi41foZXgmLxujvSi0KjVCXkxqLOo75Wttu2kfEr
	1xeytTmYeCPX9DRRmrZjN0F8kLYuC0vWG0KmNQBWl6h3EjFOx0pQ
X-Google-Smtp-Source: AGHT+IG6RuGzReZrRjNFMxAiLrdVOcM9BlWhLQ4t6BoD1ga+SxyrCCfMiD3hEJqGhBOjKcypoD3B9Q==
X-Received: by 2002:a17:903:1b64:b0:224:2384:5b40 with SMTP id d9443c01a7336-22649a3a240mr17396195ad.24.1742352532362;
        Tue, 18 Mar 2025 19:48:52 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:74e1:402a:ad3:2458:5234:fd64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68884b6sm102867745ad.3.2025.03.18.19.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 19:48:52 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:48:51 -1000
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>,
 Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>,
 Mia Shao <shaohz1@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/6_RESEND=5D_platform/x86?=
 =?US-ASCII?Q?=3A_Add_lenovo-wmi-*_driver_Documentation?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250317144326.5850-2-derekjohn.clark@gmail.com>
References: <20250317144326.5850-1-derekjohn.clark@gmail.com> <20250317144326.5850-2-derekjohn.clark@gmail.com>
Message-ID: <A0BE9899-12F4-42E4-B022-50F75CEE5B9F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 17, 2025 4:43:21 AM HST, "Derek J=2E Clark" <derekjohn=2Eclark@gm=
ail=2Ecom> wrote:
>Adds documentation for new lenovo-wmi drivers=2E
>
>Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>---
>v4:
> - Fixed MOF formatting issues=2E
> - Fixed spelling mistakes=2E
> - Updated description of balanced-performance profile for Gamezone=2E
> - Updated description of thermal mode event GUID for Gamezone=2E
>v3:
>- Split documentation into multiple files, one for each parent
>  driver for the Gamezone and Other Mode WMI interfaces=2E
>- Add MOF data for all parent and child interfaces=2E
>- Remove lenovo-wmi-camera=2Ec driver from v2 documentation=2E
>v2:
>- Update description of Custom Profile to include the need to manually
>  set it=2E
>- Remove all references to Legion hardware=2E
>- Add section for lenovo-wmi-camera=2Ec driver as it follows the same
>  naming convention=2E
>---
> =2E=2E=2E/wmi/devices/lenovo-wmi-gamezone=2Erst       | 203 ++++++++++++=
++++++
> =2E=2E=2E/wmi/devices/lenovo-wmi-other-method=2Erst   | 108 ++++++++++
> MAINTAINERS                                   |   7 +
> 3 files changed, 318 insertions(+)
> create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
> create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method=2Er=
st
>
>diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst b/Docume=
ntation/wmi/devices/lenovo-wmi-gamezone=2Erst
>new file mode 100644
>index 000000000000=2E=2Ebde63dde285d
>--- /dev/null
>+++ b/Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>@@ -0,0 +1,203 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+Lenovo WMI Interface Gamezone Driver (lenovo-wmi-gamezone)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Introduction
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+The Lenovo WMI gamezone interface is broken up into multiple GUIDs,
>+The priamry "Gamezone" GUID provides advanced features such as fan
>+profiles and overclocking=2E It is paired with multiple event GUIDs
>+and data block GUIDs that provide context for the various methods=2E
>+
>+Gamezone Data
>+-------------
>+
>+WMI GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
>+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>+
>+The Gamezone Data WMI interface provides platform-profile and fan curve
>+settings for devices that fall under the "Gaming Series" of Lenovo devic=
es=2E
>+It uses a notifier chain to inform other Lenovo WMI interface drivers of=
 the
>+current platform profile when it changes=2E
>+
>+The following platform profiles are supported:
>+ - low-power
>+ - balanced
>+ - balanced-performance*
>+ - performance
>+ - custom
>+
>+Balanced-Performance
>+~~~~~~~~~~~~~~~~~~~~
>+Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profile
>+enabled in their BIOS=2E For these devices, the performance platform pro=
file
>+will correspond to the BIOS Extreme Mode, while the balanced-performance
>+platform profile will correspond to the BIOS Performance mode=2E For leg=
acy
>+devices, the performance platform profile will correspond with the BIOS
>+Performance mode=2E For some newer devices the "Extreme Mode" profile is
>+incomplete in the BIOS and setting it will cause undefined behavior=2E A
>+BIOS bug quirk table is provided to ensure these devices cannot set
>+"Extreme Mode" from the driver=2E
>+
>+Custom Profile
>+~~~~~~~~~~~~~~
>+The custom profile represents a hardware mode on Lenovo devices that ena=
bles
>+user modifications to Package Power Tracking (PPT) and fan curve setting=
s=2E
>+When an attribute exposed by the Other Mode WMI interface is to be modif=
ied,
>+the Gamezone driver must first be switched to the "custom" profile manua=
lly,
>+or the setting will have no effect=2E If another profile is set from the=
 list
>+of supported profiles, the BIOS will override any user PPT settings when
>+switching to that profile=2E
>+
>+Gamezone Thermal Mode Event
>+---------------------------
>+
>+WMI GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
>+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>+
>+The Gamezone Thermal Mode Event interface notifies the system when the p=
latform
>+profile has changed, either through the hardware event (Fn+Q for laptops=
 or
>+Legion + Y for Go Series), or through the Gamezone WMI interface=2E This=
 event is
>+implemented in the Lenovo WMI Events driver (lenovo-wmi-events)=2E
>+
>+
>+WMI interface description
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>+
>+The WMI interface description can be decoded from the embedded binary MO=
F (bmof)
>+data using the `bmfdec <https://github=2Ecom/pali/bmfdec>`_ utility:
>+
>+::
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
LENOVO_GAMEZONE_DATA class"), guid("{887B54E3-DDDC-4B2C-8B88-68A26A8835D0}"=
)]
>+  class LENOVO_GAMEZONE_DATA {
>+  	[key, read] string InstanceName;
>+  	[read] boolean Active;

When applying as a backport with git am I found I missed two spaces before=
 the above lines=2E Will fix for next version=2E

- Derek

>+    [WmiMethodId(4), Implemented, Description("Is SupportGpu OverClock")=
] void IsSupportGpuOC([out, Description("Is SupportGpu OverClock")] uint32 =
Data);
>+    [WmiMethodId(11), Implemented, Description("Get AslCode Version")] v=
oid GetVersion ([out, Description("AslCode version")] UINT32 Data);
>+    [WmiMethodId(12), Implemented, Description("Fan cooling capability")=
] void IsSupportFanCooling([out, Description("Fan cooling capability")] UIN=
T32 Data);
>+    [WmiMethodId(13), Implemented, Description("Set Fan cooling on/off")=
] void SetFanCooling ([in, Description("Set Fan cooling on/off")] UINT32 Da=
ta);
>+    [WmiMethodId(14), Implemented, Description("cpu oc capability")] voi=
d IsSupportCpuOC ([out, Description("cpu oc capability")] UINT32 Data);
>+    [WmiMethodId(15), Implemented, Description("bios has overclock capab=
ility")] void IsBIOSSupportOC ([out, Description("bios has overclock capabi=
lity")] UINT32 Data);
>+    [WmiMethodId(16), Implemented, Description("enable or disable overcl=
ock in bios")] void SetBIOSOC ([in, Description("enable or disable overcloc=
k in bios")] UINT32 Data);
>+    [WmiMethodId(18), Implemented, Description("Get CPU temperature")] v=
oid GetCPUTemp ([out, Description("Get CPU temperature")] UINT32 Data);
>+    [WmiMethodId(19), Implemented, Description("Get GPU temperature")] v=
oid GetGPUTemp ([out, Description("Get GPU temperature")] UINT32 Data);
>+    [WmiMethodId(20), Implemented, Description("Get Fan cooling on/off s=
tatus")] void GetFanCoolingStatus ([out, Description("Get Fan cooling on/of=
f status")] UINT32 Data);
>+    [WmiMethodId(21), Implemented, Description("EC support disable windo=
ws key capability")] void IsSupportDisableWinKey ([out, Description("EC sup=
port disable windows key capability")] UINT32 Data);
>+    [WmiMethodId(22), Implemented, Description("Set windows key disable/=
enable")] void SetWinKeyStatus ([in, Description("Set windows key disable/e=
nable")] UINT32 Data);
>+    [WmiMethodId(23), Implemented, Description("Get windows key disable/=
enable status")] void GetWinKeyStatus ([out, Description("Get windows key d=
isable/enable status")] UINT32 Data);
>+    [WmiMethodId(24), Implemented, Description("EC support disable touch=
pad capability")] void IsSupportDisableTP ([out, Description("EC support di=
sable touchpad capability")] UINT32 Data);
>+    [WmiMethodId(25), Implemented, Description("Set touchpad disable/ena=
ble")] void SetTPStatus ([in, Description("Set touchpad disable/enable")] U=
INT32 Data);
>+    [WmiMethodId(26), Implemented, Description("Get touchpad disable/ena=
ble status")] void GetTPStatus ([out, Description("Get touchpad disable/ena=
ble status")] UINT32 Data);
>+    [WmiMethodId(30), Implemented, Description("Get Keyboard feature lis=
t")] void GetKeyboardfeaturelist ([out, Description("Get Keyboard feature l=
ist")] UINT32 Data);
>+    [WmiMethodId(31), Implemented, Description("Get Memory OC Informatio=
n")] void GetMemoryOCInfo ([out, Description("Get Memory OC Information")] =
UINT32 Data);
>+    [WmiMethodId(32), Implemented, Description("Water Cooling feature ca=
pability")] void IsSupportWaterCooling ([out, Description("Water Cooling fe=
ature capability")] UINT32 Data);
>+    [WmiMethodId(33), Implemented, Description("Set Water Cooling status=
")] void SetWaterCoolingStatus ([in, Description("Set Water Cooling status"=
)] UINT32 Data);
>+    [WmiMethodId(34), Implemented, Description("Get Water Cooling status=
")] void GetWaterCoolingStatus ([out, Description("Get Water Cooling status=
")] UINT32 Data);
>+    [WmiMethodId(35), Implemented, Description("Lighting feature capabil=
ity")] void IsSupportLightingFeature ([out, Description("Lighting feature c=
apability")] UINT32 Data);
>+    [WmiMethodId(36), Implemented, Description("Set keyboard light off o=
r on to max")] void SetKeyboardLight ([in, Description("keyboard light off =
or on switch")] UINT32 Data);
>+    [WmiMethodId(37), Implemented, Description("Get keyboard light on/of=
f status")] void GetKeyboardLight ([out, Description("Get keyboard light on=
/off status")] UINT32 Data);
>+    [WmiMethodId(38), Implemented, Description("Get Macrokey scan code")=
] void GetMacrokeyScancode ([in, Description("Macrokey index")] UINT32 idx,=
 [out, Description("Scan code")] UINT32 scancode);
>+    [WmiMethodId(39), Implemented, Description("Get Macrokey count")] vo=
id GetMacrokeyCount ([out, Description("Macrokey count")] UINT32 Data);
>+    [WmiMethodId(40), Implemented, Description("Support G-Sync feature")=
] void IsSupportGSync ([out, Description("Support G-Sync feature")] UINT32 =
Data);
>+    [WmiMethodId(41), Implemented, Description("Get G-Sync Status")] voi=
d GetGSyncStatus ([out, Description("Get G-Sync Status")] UINT32 Data);
>+    [WmiMethodId(42), Implemented, Description("Set G-Sync Status")] voi=
d SetGSyncStatus ([in, Description("Set G-Sync Status")] UINT32 Data);
>+    [WmiMethodId(43), Implemented, Description("Support Smart Fan featur=
e")] void IsSupportSmartFan ([out, Description("Support Smart Fan feature")=
] UINT32 Data);
>+    [WmiMethodId(44), Implemented, Description("Set Smart Fan Mode")] vo=
id SetSmartFanMode ([in, Description("Set Smart Fan Mode")] UINT32 Data);
>+    [WmiMethodId(45), Implemented, Description("Get Smart Fan Mode")] vo=
id GetSmartFanMode ([out, Description("Get Smart Fan Mode")] UINT32 Data);
>+    [WmiMethodId(46), Implemented, Description("Get Smart Fan Setting Mo=
de")] void GetSmartFanSetting ([out, Description("Get Smart Setting Mode")]=
 UINT32 Data);
>+    [WmiMethodId(47), Implemented, Description("Get Power Charge Mode")]=
 void GetPowerChargeMode ([out, Description("Get Power Charge Mode")] UINT3=
2 Data);
>+    [WmiMethodId(48), Implemented, Description("Get Gaming Product Info"=
)] void GetProductInfo ([out, Description("Get Gaming Product Info")] UINT3=
2 Data);
>+    [WmiMethodId(49), Implemented, Description("Over Drive feature capab=
ility")] void IsSupportOD ([out, Description("Over Drive feature capability=
")] UINT32 Data);
>+    [WmiMethodId(50), Implemented, Description("Get Over Drive status")]=
 void GetODStatus ([out, Description("Get Over Drive status")] UINT32 Data)=
;
>+    [WmiMethodId(51), Implemented, Description("Set Over Drive status")]=
 void SetODStatus ([in, Description("Set Over Drive status")] UINT32 Data);
>+    [WmiMethodId(52), Implemented, Description("Set Light Control Owner"=
)] void SetLightControlOwner ([in, Description("Set Light Control Owner")] =
UINT32 Data);
>+    [WmiMethodId(53), Implemented, Description("Set DDS Control Owner")]=
 void SetDDSControlOwner ([in, Description("Set DDS Control Owner")] UINT32=
 Data);
>+    [WmiMethodId(54), Implemented, Description("Get the flag of restore =
OC value")] void IsRestoreOCValue ([in, Description("Clean this flag")] UIN=
T32 idx, [out, Description("Restore oc value flag")] UINT32 Data);
>+    [WmiMethodId(55), Implemented, Description("Get Real Thremal Mode")]=
 void GetThermalMode ([out, Description("Real Thremal Mode")] UINT32 Data);
>+    [WmiMethodId(56), Implemented, Description("Get the OC switch status=
 in BIOS")] void GetBIOSOCMode ([out, Description("OC Mode")] UINT32 Data);
>+    [WmiMethodId(59), Implemented, Description("Get hardware info suppor=
t version")] void GetHardwareInfoSupportVersion ([out, Description("version=
")] UINT32 Data);
>+    [WmiMethodId(60), Implemented, Description("Get Cpu core 0 max frequ=
ency")] void GetCpuFrequency ([out, Description("frequency")] UINT32 Data);
>+    [WmiMethodId(62), Implemented, Description("Check the Adapter type f=
it for OC")] void IsACFitForOC ([out, Description("AC check result")] UINT3=
2 Data);
>+    [WmiMethodId(63), Implemented, Description("Is support IGPU mode")] =
void IsSupportIGPUMode ([out, Description("IGPU modes")] UINT32 Data);
>+    [WmiMethodId(64), Implemented, Description("Get IGPU Mode Status")] =
void GetIGPUModeStatus([out, Description("IGPU Mode Status")] UINT32 Data);
>+    [WmiMethodId(65), Implemented, Description("Set IGPU Mode")] void Se=
tIGPUModeStatus([in, Description("IGPU Mode")] UINT32 mode, [out, Descripti=
on("return code")] UINT32 Data);
>+    [WmiMethodId(66), Implemented, Description("Notify DGPU Status")] vo=
id NotifyDGPUStatus([in, Description("DGPU status")] UINT32 status, [out, D=
escription("return code")] UINT32 Data);
>+    [WmiMethodId(67), Implemented, Description("Is changed Y log")] void=
 IsChangedYLog([out, Description("Is changed Y Log")] UINT32 Data);
>+    [WmiMethodId(68), Implemented, Description("Get DGPU Hardwawre ID")]=
 void GetDGPUHWId([out, Description("Get DGPU Hardware ID")] string Data);
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
Definition of CPU OC parameter list"), guid("{B7F3CA0A-ACDC-42D2-9217-77C6C=
628FBD2}")]
>+  class LENOVO_GAMEZONE_CPU_OC_DATA {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description("OC tune id=2E")] uint32 Tuneid;
>+    [WmiDataId(2), read, Description("Default value=2E")] uint32 Default=
Value;
>+    [WmiDataId(3), read, Description("OC Value=2E")] uint32 OCValue;
>+    [WmiDataId(4), read, Description("Min Value=2E")] uint32 MinValue;
>+    [WmiDataId(5), read, Description("Max Value=2E")] uint32 MaxValue;
>+    [WmiDataId(6), read, Description("Scale Value=2E")] uint32 ScaleValu=
e;
>+    [WmiDataId(7), read, Description("OC Order id=2E")] uint32 OCOrderid=
;
>+    [WmiDataId(8), read, Description("NON-OC Order id=2E")] uint32 NOCOr=
derid;
>+    [WmiDataId(9), read, Description("Delay time in ms=2E")] uint32 Inte=
rval;
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
Definition of GPU OC parameter list"), guid("{887B54E2-DDDC-4B2C-8B88-68A26=
A8835D0}")]
>+  class LENOVO_GAMEZONE_GPU_OC_DATA {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description("P-State ID=2E")] uint32 PStateID;
>+    [WmiDataId(2), read, Description("CLOCK ID=2E")] uint32 ClockID;
>+    [WmiDataId(3), read, Description("Default value=2E")] uint32 default=
value;
>+    [WmiDataId(4), read, Description("OC Offset freqency=2E")] uint32 OC=
OffsetFreq;
>+    [WmiDataId(5), read, Description("OC Min offset value=2E")] uint32 O=
CMinOffset;
>+    [WmiDataId(6), read, Description("OC Max offset value=2E")] uint32 O=
CMaxOffset;
>+    [WmiDataId(7), read, Description("OC Offset Scale=2E")] uint32 OCOff=
setScale;
>+    [WmiDataId(8), read, Description("OC Order id=2E")] uint32 OCOrderid=
;
>+    [WmiDataId(9), read, Description("NON-OC Order id=2E")] uint32 NOCOr=
derid;
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
Fancooling finish event"), guid("{BC72A435-E8C1-4275-B3E2-D8B8074ABA59}")]
>+  class LENOVO_GAMEZONE_FAN_COOLING_EVENT: WMIEvent {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description("Fancooling clean finish event")] u=
int32 EventId;
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
Smart Fan mode change event"), guid("{D320289E-8FEA-41E0-86F9-611D83151B5F}=
")]
>+  class LENOVO_GAMEZONE_SMART_FAN_MODE_EVENT: WMIEvent {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description("Smart Fan Mode change event")] uin=
t32 mode;
>+    [WmiDataId(2), read, Description("version of FN+Q")] uint32 version;
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
Smart Fan setting mode change event"), guid("{D320289E-8FEA-41E1-86F9-611D8=
3151B5F}")]
>+  class LENOVO_GAMEZONE_SMART_FAN_SETTING_EVENT: WMIEvent {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description("Smart Fan Setting mode change even=
t")] uint32 mode;
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
POWER CHARGE MODE Change EVENT"), guid("{D320289E-8FEA-41E0-86F9-711D83151B=
5F}")]
>+  class LENOVO_GAMEZONE_POWER_CHARGE_MODE_EVENT: WMIEvent {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description("POWER CHARGE MODE Change EVENT")] =
uint32 mode;
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
Thermal Mode Real Mode change event"), guid("{D320289E-8FEA-41E0-86F9-911D8=
3151B5F}")]
>+  class LENOVO_GAMEZONE_THERMAL_MODE_EVENT: WMIEvent {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description("Thermal Mode Real Mode")] uint32 m=
ode;
>+  };
>diff --git a/Documentation/wmi/devices/lenovo-wmi-other-method=2Erst b/Do=
cumentation/wmi/devices/lenovo-wmi-other-method=2Erst
>new file mode 100644
>index 000000000000=2E=2Eb48832726311
>--- /dev/null
>+++ b/Documentation/wmi/devices/lenovo-wmi-other-method=2Erst
>@@ -0,0 +1,108 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+Lenovo WMI Interface Other Mode Driver (lenovo-wmi-other)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Introduction
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+Lenovo WMI Other Mode interface is broken up into multiple GUIDs,
>+The primary Other Mode interface provides advanced power tuning features
>+such as Package Power Tracking (PPT)=2E It is paired with multiple data =
block
>+GUIDs that provide context for the various methods=2E
>+
>+
>+Other Mode
>+----------
>+
>+WMI GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
>+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>+
>+The Other Mode WMI interface uses the firmware_attributes class to expos=
e
>+various WMI attributes provided by the interface in the sysfs=2E This en=
ables
>+CPU and GPU power limit tuning as well as various other attributes for
>+devices that fall under the "Gaming Series" of Lenovo devices=2E Each
>+attribute exposed by the Other Mode interface has corresponding
>+capability data blocks which allow the driver to probe details about the
>+attribute=2E Each attribute has multiple pages, one for each of the plat=
form
>+profiles managed by the Gamezone interface=2E Attributes are exposed in =
sysfs
>+under the following path:
>+
>+::
>+/sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>/
>+
>+LENOVO_CAPABILITY_DATA_01
>+-------------------------
>+
>+WMI GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
>+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>+
>+The LENOVO_CAPABILITY_DATA_01 interface provides information on various
>+power limits of integrated CPU and GPU components=2E
>+
>+Each attribute has the following properties:
>+ - current_value
>+ - default_value
>+ - display_name
>+ - max_value
>+ - min_value
>+ - scalar_increment
>+ - type
>+
>+The following attributes are implemented:
>+ - ppt_pl1_spl: Platform Profile Tracking Sustained Power Limit
>+ - ppt_pl2_sppt: Platform Profile Tracking Slow Package Power Tracking
>+ - ppt_pl3_fppt: Platform Profile Tracking Fast Package Power Tracking
>+
>+
>+WMI interface description
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>+
>+The WMI interface description can be decoded from the embedded binary MO=
F (bmof)
>+data using the `bmfdec <https://github=2Ecom/pali/bmfdec>`_ utility:
>+
>+::
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
LENOVO_OTHER_METHOD class"), guid("{dc2a8805-3a8c-41ba-a6f7-092e0089cd3b}")=
]
>+  class LENOVO_OTHER_METHOD {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiMethodId(17), Implemented, Description("Get Feature Value ")] vo=
id GetFeatureValue([in] uint32 IDs, [out] uint32 value);
>+    [WmiMethodId(18), Implemented, Description("Set Feature Value ")] vo=
id SetFeatureValue([in] uint32 IDs, [in] uint32 value);
>+    [WmiMethodId(19), Implemented, Description("Get Data By Command ")] =
void GetDataByCommand([in] uint32 IDs, [in] uint32 Command, [out] uint32 Da=
taSize, [out, WmiSizeIs("DataSize")] uint32 Data[]);
>+    [WmiMethodId(99), Implemented, Description("Get Data By Package for =
TAC")] void GetDataByPackage([in, Max(40)] uint8 Input[], [out] uint32 Data=
Size, [out, WmiSizeIs("DataSize")] uint8 Data[]);
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
LENOVO CAPABILITY DATA 00"), guid("{362a3afe-3d96-4665-8530-96dad5bb300e}")=
]
>+  class LENOVO_CAPABILITY_DATA_00 {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description(" IDs=2E")] uint32 IDs;
>+    [WmiDataId(2), read, Description("Capability=2E")] uint32 Capability=
;
>+    [WmiDataId(3), read, Description("Capability Default Value=2E")] uin=
t32 DefaultValue;
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
LENOVO CAPABILITY DATA 01"), guid("{7a8f5407-cb67-4d6e-b547-39b3be018154}")=
]
>+  class LENOVO_CAPABILITY_DATA_01 {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description(" IDs=2E")] uint32 IDs;
>+    [WmiDataId(2), read, Description("Capability=2E")] uint32 Capability=
;
>+    [WmiDataId(3), read, Description("Default Value=2E")] uint32 Default=
Value;
>+    [WmiDataId(4), read, Description("Step=2E")] uint32 Step;
>+    [WmiDataId(5), read, Description("Minimum Value=2E")] uint32 MinValu=
e;
>+    [WmiDataId(6), read, Description("Maximum Value=2E")] uint32 MaxValu=
e;
>+  };
>+
>+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
LENOVO CAPABILITY DATA 02"), guid("{bbf1f790-6c2f-422b-bc8c-4e7369c7f6ab}")=
]
>+  class LENOVO_CAPABILITY_DATA_02 {
>+    [key, read] string InstanceName;
>+    [read] boolean Active;
>+
>+    [WmiDataId(1), read, Description(" IDs=2E")] uint32 IDs;
>+    [WmiDataId(2), read, Description("Capability=2E")] uint32 Capability=
;
>+    [WmiDataId(3), read, Description("Data Size=2E")] uint32 DataSize;
>+    [WmiDataId(4), read, Description("Default Value"), WmiSizeIs("DataSi=
ze")] uint8 DefaultValue[];
>+  };
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 1afd30d00aec=2E=2E675f4b26426d 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -13158,6 +13158,13 @@ S:	Maintained
> W:	http://legousb=2Esourceforge=2Enet/
> F:	drivers/usb/misc/legousbtower=2Ec
>=20
>+LENOVO WMI DRIVERS
>+M:	Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>+L:	platform-driver-x86@vger=2Ekernel=2Eorg
>+S:	Maintained
>+F:	Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>+F:	Documentation/wmi/devices/lenovo-wmi-other=2Erst
>+
> LENOVO WMI HOTKEY UTILITIES DRIVER
> M:	Jackie Dong <xy-jackie@139=2Ecom>
> L:	platform-driver-x86@vger=2Ekernel=2Eorg

- Derek

