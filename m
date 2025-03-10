Return-Path: <linux-kernel+bounces-555167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3FA5A655
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05A4171337
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349C1E25F9;
	Mon, 10 Mar 2025 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvjZeanv"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215701DFFD;
	Mon, 10 Mar 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642596; cv=none; b=D+qsF1TYm1+oxlrDLAkntT/rS2yd5uaZkFlL4MRky7QgN+QQhdUSGypcdXDOszNtJZq8p/G1ZDhecSdro9YhpJdtHDdl0ZfvLpA08/726MNT4fr6B4qvFulgcnKZnaoiT+1eQIuQn0jdK995W3e6E6n8Hv9YSQAMC+eqxyWkpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642596; c=relaxed/simple;
	bh=y/BRf8+wQQosnibtxovOKL2Iodi/jJsXGeYYauGz0hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ah8JUpnDOe37XsodTbYs1Ll4y76D+6g1pKeAmRPweTXW/CE/eSx/NwQfSHQwa8jt5Sq8VsnpjqHRoc1YshGd806wIuxa0MTCmWn6xLP35xkqae78PED39goud9GIRPn0Cw7q19ofXzWV/YPwKPPJNdPvCocikR2SuqH6Lihmng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvjZeanv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so49376566d6.0;
        Mon, 10 Mar 2025 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642593; x=1742247393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHob6tqa3ayGo1vQiona5MKWNJXncq4kSGLwjoTAbRk=;
        b=CvjZeanv61kb1o7qWsYqlu2vKPQzAJD/vcizN5kkFIdJUXlAvn5a+cURmdh7K4fvak
         S2PNCum5HqimderZ56scgS2z5Ctfhpx8nZe0LwDbt7U9Av5q5Z4o6W0BU3IvFHh7iQm2
         G0FJB22vCzUmV6x8HLGm58Ml3bRnf4RsKu6J2C42k/dJ3ghb/f0Pt88sgSmEgPw4gS45
         nP+MLGKNOVsBt+sCZ5gyHxzrfuT3+jK4z6l/+JiYqg4sG3e8wc6x5aAMUnwnmHqMbfJK
         XhfcKm6hRr7huSKxGKc65o/GR6D6MTeiKwdoZ+QOc6EZBriLu1cHDufC7nv+oWxdcLEb
         EhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642593; x=1742247393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHob6tqa3ayGo1vQiona5MKWNJXncq4kSGLwjoTAbRk=;
        b=mDDWoesA9Hk0pkYyLpBIC9QiuqScoWlVFqA1cIUtx2H7Tk6lDvEOyp6U4h64We7tiL
         1l/fi1Z69nktts+LfEbUlOFViskg4+k2adrJ898coKZcL0e8QV4crHeAdigLFVTO45hc
         zYZPk8ilaHiJRU3N6inUHnjRb/Fkt8yvt4uTYXExqcuezTH7etx3CzSI+3AcuIF6o4Mr
         d3dM1ZQQGgeeQ5y6IOWZ9dyS6elCHg1FD38RTo0PP/fSbVaqw4xcFHIrO4DxJzYy5l70
         Ik2Ei6hb7KrrJ1aaHLrBCi30c9ICr7kk42kW10V4YQrd8kc4E5fpgyT7/22O2D3UUw2U
         fVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWULZ37t8XVvW/6ayn2Icch/fycEwtGe8W0W+kSFcWaYF0Cai6t/DwDUqEMBORxnNUCD2Lp7CvmnvmnT97hT0v/vZ1xVQ==@vger.kernel.org, AJvYcCXTbyMUzY3JedacBlmb+ry/JCOpHEykjJKkTRCxQlzezDXi4ErhWf6jujX2780y/foac1Djnd9o0mU=@vger.kernel.org, AJvYcCXcfd7PHPndS0fOMas0HD61ip9vMDQ+SI/n1ybi5UNK58LuZ6Foel1qwdebCRDtnWCGWBKmNljnSR9KwHnJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyevjiv5WydD2jWBjl47St7h1x1XqgnH4pUslhcwNeu3iOVkqBf
	3OHgFPZDNZ3K83MpjluvLSTJU7PSO8x5dQsAOnwImLx2UDuYs5SRmhm68JB65noTbnbpWX49m37
	KatCvmmmJMFigX9WZkq+xfDQ/rio=
X-Gm-Gg: ASbGncvezWSFJNnPrXnGyMdtsQrR1ID+kbxhuaNNaorr0mQ3nr9DdIkw0HN9A2XaGY7
	17RfAIE0lJzGRzzgjGWnbddot2CBIimKQ+REUjAvCQIMIdHOUjG8ArBt5gSUjM/8VM6RSqWFkMq
	wZh/YyWWkaXfqMII0LOqxTpFptTe8=
X-Google-Smtp-Source: AGHT+IHQTBfHEn1vRnmpMgmTSZMUTKlFtCcc2pRp9pQUpGKKyDPG+wYx8A6p6VWHYQAglD/I+7HDpTURyjcvI4bU1RM=
X-Received: by 2002:ad4:5f0f:0:b0:6e6:5f22:bb58 with SMTP id
 6a1803df08f44-6ea51f18684mr20923706d6.20.1741642592686; Mon, 10 Mar 2025
 14:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-2-derekjohn.clark@gmail.com> <e46d95cc-800f-43e0-8064-77e784b40b7a@gmx.de>
In-Reply-To: <e46d95cc-800f-43e0-8064-77e784b40b7a@gmx.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 14:36:21 -0700
X-Gm-Features: AQ5f1JpsNaMWowNj5fpjibz2N3Ychq-Jvkw8RIbjiJ1c9XpTMJSa5V-C5tJTOM0
Message-ID: <CAFqHKT=EHMO3fD7xHR4THJ67hARBnfDjT7Q9Dsjt1n4MHarwTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] platform/x86: Add lenovo-wmi drivers Documentation
To: Armin Wolf <W_Armin@gmx.de>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>, 
	Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, "Cody T . -H . Chiu" <codyit@gmail.com>, 
	John Martens <johnfanv2@gmail.com>, platform-driver-x86@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:51=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
>
> > Adds documentation for all new lenovo-wmi drivers.
> >
> > v3:
> > - Split documentation into multiple files, one for each parent
> >    driver for the Gamezone and Other Mode WMI interfaces.
> > - Add MOF data for all parent and child interfaces.
> > - Remove lenovo-wmi-camera.c driver from v2 documentation.
> > v2:
> > - Update description of Custom Profile to include the need to manually
> >    set it.
> > - Remove all references to Legion hardware.
> > - Add section for lenovo-wmi-camera.c driver as it follows the same
> >    naming convention.
> >
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> >   .../wmi/devices/lenovo-wmi-gamezone.rst       | 355 +++++++++++++++++=
+
> >   .../wmi/devices/lenovo-wmi-other-method.rst   | 142 +++++++
> >   MAINTAINERS                                   |   7 +
> >   3 files changed, 504 insertions(+)
> >   create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> >   create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.=
rst
> >
> > diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Docume=
ntation/wmi/devices/lenovo-wmi-gamezone.rst
> > new file mode 100644
> > index 000000000000..1dc281fdd99d
> > --- /dev/null
> > +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> > @@ -0,0 +1,355 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Lenovo WMI Interface Gamezone Driver (lenovo-wmi-gamezone)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +The Lenovo WMI gamezone interface is broken up into multiple GUIDs,
> > +The priamry "Gamezone" GUID provides advanced features such as fan
> > +profiles and overclocking. It is paired with multiple event GUIDs
> > +and data block GUIDs that provide context for the various methods.
> > +
> > +Gamezone Data
> > +-------------
> > +WMI GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
>
> Maybe formatting the GUID as monospace text would look better here.
>
Acked.

> > +
> > +The Gamezone Data WMI interface provides platform-profile and fan curv=
e
> > +settings for devices that fall under the "Gaming Series" of Lenovo dev=
ices.
> > +It uses a notifier chain to inform other Lenovo WMI interface drivers =
of the
> > +current platform profile when it changes.
> > +
> > +The following platform profiles are supported:
> > + - low-power
> > + - balanced
> > + - balanced-performance
> > + - performance
> > + - custom
> > +
> > +Balanced-Perfornance and Performance Profiles
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profi=
le
> > +enabled in their BIOS. For these devices, the performance platform pro=
file
> > +will correspond to the BIOS Extreme Mode, while the balanced-performan=
ce
> > +platform profile will correspond to the BIOS Performance mode. For leg=
acy
> > +devices, the performance platform prfile will correspond with the BIOS
> > +Performance mode.
> > +
> > +Custom Profile
> > +~~~~~~~~~~~~~~
> > +The custom profile represents a hardware mode on Lenovo devices that e=
nables
> > +user modifications to Package Power Tracking (PPT) and fan curve setti=
ngs.
> > +When an attribute exposed by the Other Mode WMI interface is to be mod=
ified,
> > +the Gamezone driver must first be switched to the "custom" profile man=
ually,
> > +or the setting will have no effect. If another profile is set from the=
 list
> > +of supported profiles, the BIOS will override any user PPT settings wh=
en
> > +switching to that profile.
> > +
> > +Gamezone Thermal Mode Event
> > +---------------------------
> > +WMI GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
> > +
>
> Same as above.
>
> > +The Gamezone Thermal Mode Event interface notifies the system when the=
 platform
> > +profile has changed, either through the hardware event (Fn+Q for lapto=
ps or
> > +Legion + Y for Go Series), or through the Gamezone WMI interface.
> > +
> > +
> > +WMI interface description
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +The WMI interface description can be decoded from the embedded binary =
MOF (bmof)
> > +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> > +
> > +::
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("LENOVO_GAMEZONE_DATA class"),
> > +   guid("{887B54E3-DDDC-4B2C-8B88-68A26A8835D0}")]
> > +  class LENOVO_GAMEZONE_DATA {
> > +     [key, read] string InstanceName;
> > +     [read] boolean Active;
>
> The MOF definition mixes tabs and spaces and is not properly indented. Pl=
ease fix this.

Will be fixed, ty.

> > +
> > +     [WmiMethodId(4), Implemented, Description("Is SupportGpu OverCloc=
k")]
> > +    void IsSupportGpuOC([out, Description("Is SupportGpu OverClock")] =
uint32 Data);
> > +
> > +     [WmiMethodId(11), Implemented, Description("Get AslCode Version")=
]
> > +    void GetVersion ([out, Description("AslCode version")] UINT32 Data=
);
> > +
> > +     [WmiMethodId(12), Implemented, Description("Fan cooling capabilit=
y")]
> > +    void IsSupportFanCooling([out, Description("Fan cooling capability=
")] UINT32 Data);
> > +
> > +     [WmiMethodId(13), Implemented, Description("Set Fan cooling on/of=
f")]
> > +    void SetFanCooling ([in, Description("Set Fan cooling on/off")] UI=
NT32 Data);
> > +
> > +     [WmiMethodId(14), Implemented, Description("cpu oc capability")]
> > +    void IsSupportCpuOC ([out, Description("cpu oc capability")] UINT3=
2 Data);
> > +
> > +     [WmiMethodId(15), Implemented, Description("bios has overclock ca=
pability")]
> > +    void IsBIOSSupportOC ([out, Description("bios has overclock capabi=
lity")] UINT32 Data);
> > +
> > +     [WmiMethodId(16), Implemented, Description("enable or disable ove=
rclock in bios")]
> > +    void SetBIOSOC ([in, Description("enable or disable overclock in b=
ios")] UINT32 Data);
> > +
> > +     [WmiMethodId(18), Implemented, Description("Get CPU temperature")=
]
> > +    void GetCPUTemp ([out, Description("Get CPU temperature")] UINT32 =
Data);
> > +
> > +     [WmiMethodId(19), Implemented, Description("Get GPU temperature")=
]
> > +    void GetGPUTemp ([out, Description("Get GPU temperature")] UINT32 =
Data);
> > +
> > +     [WmiMethodId(20), Implemented, Description("Get Fan cooling on/of=
f status")]
> > +    void GetFanCoolingStatus ([out, Description("Get Fan cooling on/of=
f status")] UINT32 Data);
> > +
> > +     [WmiMethodId(21), Implemented, Description("EC support disable wi=
ndows key capability")]
> > +    void IsSupportDisableWinKey ([out, Description("EC support disable=
 windows key capability")] UINT32 Data);
> > +
> > +     [WmiMethodId(22), Implemented, Description("Set windows key disab=
le/enable")]
> > +    void SetWinKeyStatus ([in, Description("Set windows key disable/en=
able")] UINT32 Data);
> > +
> > +     [WmiMethodId(23), Implemented, Description("Get windows key disab=
le/enable status")]
> > +    void GetWinKeyStatus ([out, Description("Get windows key disable/e=
nable status")] UINT32 Data);
> > +
> > +     [WmiMethodId(24), Implemented, Description("EC support disable to=
uchpad capability")]
> > +    void IsSupportDisableTP ([out, Description("EC support disable tou=
chpad capability")] UINT32 Data);
> > +
> > +     [WmiMethodId(25), Implemented, Description("Set touchpad disable/=
enable")]
> > +    void SetTPStatus ([in, Description("Set touchpad disable/enable")]=
 UINT32 Data);
> > +
> > +     [WmiMethodId(26), Implemented, Description("Get touchpad disable/=
enable status")]
> > +    void GetTPStatus ([out, Description("Get touchpad disable/enable s=
tatus")] UINT32 Data);
> > +
> > +     [WmiMethodId(30), emented,      Description("Get Keyboard feature=
 list")]
> > +    void GetKeyboardfeaturelist ([out, Description("Get Keyboard featu=
re list")] UINT32 Data);
> > +
> > +     [WmiMethodId(31), emented,      Description("Get Memory OC Inform=
ation")]
> > +    void GetMemoryOCInfo ([out, Description("Get Memory OC Information=
")] UINT32 Data);
> > +
> > +     [WmiMethodId(32), emented,      Description("Water Cooling featur=
e capability")]
> > +    void IsSupportWaterCooling ([out, Description("Water Cooling featu=
re capability")] UINT32 Data);
> > +
> > +     [WmiMethodId(33), emented,      Description("Set Water Cooling st=
atus")]
> > +    void SetWaterCoolingStatus ([in, Description("Set Water Cooling st=
atus")] UINT32 Data);
> > +
> > +     [WmiMethodId(34), emented,      Description("Get Water Cooling st=
atus")]
> > +    void GetWaterCoolingStatus ([out, Description("Get Water Cooling s=
tatus")] UINT32 Data);
> > +
> > +     [WmiMethodId(35), emented,      Description("Lighting feature cap=
ability")]
> > +    void IsSupportLightingFeature ([out, Description("Lighting feature=
 capability")] UINT32 Data);
> > +
> > +     [WmiMethodId(36), emented,      Description("Set keyboard light o=
ff or on to max")]
> > +    void SetKeyboardLight ([in, Description("keyboard light off or on =
switch")] UINT32 Data);
> > +
> > +     [WmiMethodId(37), emented,      Description("Get keyboard light o=
n/off status")]
> > +    void GetKeyboardLight ([out, Description("Get keyboard light on/of=
f status")] UINT32 Data);
> > +
> > +     [WmiMethodId(38), emented,      Description("Get Macrokey scan co=
de")]
> > +    void GetMacrokeyScancode ([in, Description("Macrokey index")] UINT=
32 idx, [out, Description("Scan code")] UINT32 scancode);
> > +
> > +     [WmiMethodId(39), emented,      Description("Get Macrokey count")=
]
> > +    void GetMacrokeyCount ([out, Description("Macrokey count")] UINT32=
 Data);
> > +
> > +     [WmiMethodId(40), emented,      Description("Support G-Sync featu=
re")]
> > +    void IsSupportGSync ([out, Description("Support G-Sync feature")] =
UINT32 Data);
> > +
> > +     [WmiMethodId(41), emented,      Description("Get G-Sync Statust")=
]
> > +    void GetGSyncStatus ([out, Description("Get G-Sync Statust")] UINT=
32 Data);
> > +
> > +     [WmiMethodId(42), emented,      Description("Set G-Sync Statust")=
]
> > +    void SetGSyncStatus ([in, Description("Set G-Sync Statust")] UINT3=
2 Data);
> > +
> > +     [WmiMethodId(43), emented,      Description("Support Smart Fan fe=
ature")]
> > +    void IsSupportSmartFan ([out, Description("Support Smart Fan featu=
re")] UINT32 Data);
> > +
> > +     [WmiMethodId(44), emented,      Description("Set Smart Fan Mode")=
]
> > +    void SetSmartFanMode ([in, Description("Set Smart Fan Mode")] UINT=
32 Data);
> > +
> > +     [WmiMethodId(45), emented,      Description("Get Smart Fan Mode")=
]
> > +    void GetSmartFanMode ([out, Description("Get Smart Fan Mode")] UIN=
T32 Data);
> > +
> > +     [WmiMethodId(46), emented,      Description("Get Smart Fan Settin=
g Mode")]
> > +    void GetSmartFanSetting ([out, Description("Get Smart Setting Mode=
")] UINT32 Data);
> > +
> > +     [WmiMethodId(47), emented,      Description("Get Power Charge Mod=
e")]
> > +    void GetPowerChargeMode ([out, Description("Get Power Charge Mode"=
)] UINT32 Data);
> > +
> > +     [WmiMethodId(48), emented, Description("Get Gaming Product Info")=
]
> > +    void GetProductInfo ([out, Description("Get Gaming Product Info")]=
 UINT32 Data);
> > +
> > +     [WmiMethodId(49), emented, Description("Over Drive feature capabi=
lity")]
> > +    void IsSupportOD ([out, Description("Over Drive feature capability=
")] UINT32 Data);
> > +
> > +     [WmiMethodId(50), emented, Description("Get Over Drive status")]
> > +    void GetODStatus ([out, Description("Get Over Drive status")] UINT=
32 Data);
> > +
> > +     [WmiMethodId(51), emented, Description("Set Over Drive status")]
> > +    void SetODStatus ([in, Description("Set Over Drive status")] UINT3=
2 Data);
> > +
> > +     [WmiMethodId(52), emented, Description("Set Light Control Owner")=
]
> > +    void SetLightControlOwner ([in, Description("Set Light Control Own=
er")] UINT32 Data);
> > +
> > +     [WmiMethodId(53), emented, Description("Set DDS Control Owner")]
> > +    void SetDDSControlOwner ([in, Description("Set DDS Control Owner")=
] UINT32 Data);
> > +
> > +     [WmiMethodId(54), emented, Description("Get the flag of restore O=
C value")]
> > +    void IsRestoreOCValue ([in, Description("Clean this flag")] UINT32=
 idx, [out, Description("Restore oc value flag")] UINT32 Data);
> > +
> > +     [WmiMethodId(55), emented,      Description("Get Real Thremal Mod=
e")]
> > +    void GetThermalMode ([out, Description("Real Thremal Mode")] UINT3=
2 Data);
> > +
> > +     [WmiMethodId(56), emented,      Description("Get the OC switch st=
atus in BIOS")]
> > +    void GetBIOSOCMode ([out, Description("OC Mode")] UINT32 Data);
> > +
> > +     [WmiMethodId(59), emented,      Description("Get hardware info su=
pport version")]
> > +    void GetHardwareInfoSupportVersion ([out, Description("version")] =
UINT32 Data);
> > +
> > +     [WmiMethodId(60), emented,      Description("Get Cpu core 0 max f=
requency")]
> > +    void GetCpuFrequency ([out, Description("frequency")] UINT32 Data)=
;
> > +
> > +     [WmiMethodId(62), emented,      Description("Check the Adapter ty=
pe fit for OC")]
> > +    void IsACFitForOC ([out, Description("AC check result")] UINT32 Da=
ta);
> > +
> > +     [WmiMethodId(63), emented,      Description("Is support IGPU mode=
")]
> > +    void IsSupportIGPUMode ([out, Description("IGPU modes")] UINT32 Da=
ta);
> > +
> > +     [WmiMethodId(64), emented,      Description("Get IGPU Mode Status=
")]
> > +    void GetIGPUModeStatus([out, Description("IGPU Mode Status")] UINT=
32 Data);
> > +
> > +     [WmiMethodId(65), emented,      Description("Set IGPU Mode")]
> > +    void SetIGPUModeStatus([in, Description("IGPU Mode")] UINT32 mode,=
 [out, Description("return code")] UINT32 Data);
> > +
> > +     [WmiMethodId(66), emented, Description("Notify DGPU Status")]
> > +    void NotifyDGPUStatus([in, Description("DGPU status")] UINT32 stat=
us, [out, Description("return code")] UINT32 Data);
> > +
> > +     [WmiMethodId(67), emented,      Description("Is changed Y log")]
> > +    void IsChangedYLog([out, Description("Is changed Y Log")] UINT32 D=
ata);
> > +
> > +     [WmiMethodId(68), emented, Description("Get DGPU Hardwawre ID")]
> > +    void GetDGPUHWId([out, Description("Get DGPU Hardware ID")] string=
 Data);
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("Definition of CPU OC parameter list"),
> > +   guid("{B7F3CA0A-ACDC-42D2-9217-77C6C628FBD2}")]
> > +  class LENOVO_GAMEZONE_CPU_OC_DATA {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description("OC tune id.")]
> > +      uint32 Tuneid;
> > +
> > +      [WmiDataId(2), read, Description("Default value.")]
> > +      uint32 DefaultValue;
> > +
> > +      [WmiDataId(3), read, Description("OC Value.")]
> > +      uint32 OCValue;
> > +
> > +      [WmiDataId(4), read, Description("Min Value.")]
> > +      uint32 MinValue;
> > +
> > +      [WmiDataId(5), read, Description("Max Value.")]
> > +      uint32 MaxValue;
> > +
> > +      [WmiDataId(6), read, Description("Scale Value.")]
> > +      uint32 ScaleValue;
> > +
> > +      [WmiDataId(7), read, Description("OC Order id.")]
> > +      uint32 OCOrderid;
> > +
> > +      [WmiDataId(8), read, Description("NON-OC Order id.")]
> > +      uint32 NOCOrderid;
> > +
> > +      [WmiDataId(9), read, Description("Delay time in ms.")]
> > +      uint32 Interval;
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("Definition of GPU OC parameter list"),
> > +   guid("{887B54E2-DDDC-4B2C-8B88-68A26A8835D0}")]
> > +  class LENOVO_GAMEZONE_GPU_OC_DATA {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description("P-State ID.")]
> > +      uint32 PStateID;
> > +
> > +      [WmiDataId(2), read, Description("CLOCK ID.")]
> > +      uint32 ClockID;
> > +
> > +      [WmiDataId(3), read, Description("Default value.")]
> > +      uint32 defaultvalue;
> > +
> > +      [WmiDataId(4), read, Description("OC Offset freqency.")]
> > +      uint32 OCOffsetFreq;
> > +
> > +      [WmiDataId(5), read, Description("OC Min offset value.")]
> > +      uint32 OCMinOffset;
> > +
> > +      [WmiDataId(6), read, Description("OC Max offset value.")]
> > +      uint32 OCMaxOffset;
> > +
> > +      [WmiDataId(7), read, Description("OC Offset Scale.")]
> > +      uint32 OCOffsetScale;
> > +
> > +      [WmiDataId(8), read, Description("OC Order id.")]
> > +      uint32 OCOrderid;
> > +
> > +      [WmiDataId(9), read, Description("NON-OC Order id.")]
> > +      uint32 NOCOrderid;
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("Fancooling finish event"),
> > +   guid("{BC72A435-E8C1-4275-B3E2-D8B8074ABA59}")]
> > +  class LENOVO_GAMEZONE_FAN_COOLING_EVENT: WMIEvent {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description("Fancooling clean finish event"=
)]
> > +      uint32 EventId;
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("Smart Fan mode change event"),
> > +   guid("{D320289E-8FEA-41E0-86F9-611D83151B5F}")]
> > +  class LENOVO_GAMEZONE_SMART_FAN_MODE_EVENT: WMIEvent {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description("Smart Fan Mode change event")]
> > +      uint32 mode;
> > +
> > +       [WmiDataId(2), read, Description("version of FN+Q")]
> > +      uint32 version;
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("Smart Fan setting mode change event"),
> > +   guid("{D320289E-8FEA-41E1-86F9-611D83151B5F}")]
> > +  class LENOVO_GAMEZONE_SMART_FAN_SETTING_EVENT: WMIEvent {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description("Smart Fan Setting mode change =
event")]
> > +      uint32 mode;
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("POWER CHARGE MODE Change EVENT"),
> > +   guid("{D320289E-8FEA-41E0-86F9-711D83151B5F}")]
> > +  class LENOVO_GAMEZONE_POWER_CHARGE_MODE_EVENT: WMIEvent {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description("POWER CHARGE MODE Change EVENT=
")]
> > +      uint32 mode;
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("Thermal Mode Real Mode change event"),
> > +   guid("{D320289E-8FEA-41E0-86F9-911D83151B5F}")]
> > +  class LENOVO_GAMEZONE_THERMAL_MODE_EVENT: WMIEvent {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description("Thermal Mode Real Mode")]
> > +      uint32 mode;
> > +  };
> > diff --git a/Documentation/wmi/devices/lenovo-wmi-other-method.rst b/Do=
cumentation/wmi/devices/lenovo-wmi-other-method.rst
> > new file mode 100644
> > index 000000000000..d555f1ed9588
> > --- /dev/null
> > +++ b/Documentation/wmi/devices/lenovo-wmi-other-method.rst
> > @@ -0,0 +1,142 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Lenovo WMI Interface Other Mode Driver (lenovo-wmi-other)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Lenovo WMI Other Mode interface is broken up into multiple GUIDs,
> > +The primary Other Mode interface provides advanced power tuning featur=
es
> > +such as Package Power Tracking (PPT). It is paired with multiple data =
block
> > +GUIDs that provide context for the various methods.
> > +
> > +
> > +Other Mode
> > +------------
> > +WMI GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
>
> The suggestion with the monospace formatting applies here too.
>
> > +
> > +The Other Mode WMI interface uses the fw_attributes class to expose
> > +various WMI attributes provided by the interface in the sysfs. This en=
ables
> > +CPU and GPU power limit tuning as well as various other attributes for
> > +devices that fall under the "Gaming Series" of Lenovo devices. Each
> > +attribute exposed by the Other Mode interface has corresponding
> > +capability data blocks which allow the driver to probe details about t=
he
> > +attribute. Each attibute has multiple pages, one for each of the platf=
orm
> > +profiles managed by the Gamezone interface. Attributes are exposed in =
sysfs
> > +under the following path:
> > +
> > +::
> > +/sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>=
/
> > +
> > +LENOVO_CAPABILITY_DATA_01
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > +WMI GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
>
> Same as above.
>
> > +
> > +The LENOVO_CAPABILITY_DATA_01 interface provides information on variou=
s
> > +power limits of integrated CPU and GPU components.
> > +
> > +The following attributes are supported:
> > + - ppt_pl1_spl: Platform Profile Tracking Sustained Power Limit
> > + - ppt_pl2_sppt: Platform Profile Tracking Slow Package Power Tracking
> > + - ppt_pl3_fppt: Platform Profile Tracking Fast Package Power Tracking
> > +
> > +Each attribute has the following properties:
> > + - current_value
> > + - default_value
> > + - display_name
> > + - max_value
> > + - min_value
> > + - scalar_increment
> > + - type
> > +
> > +
> > +WMI interface description
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +The WMI interface description can be decoded from the embedded binary =
MOF (bmof)
> > +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> > +
> > +::
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("LENOVO_OTHER_METHOD class"),
> > +   guid("{dc2a8805-3a8c-41ba-a6f7-092e0089cd3b}")]
> > +  class LENOVO_OTHER_METHOD {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiMethodId(17), Implemented, Description("Get Feature Value ")=
]
> > +      void GetFeatureValue([in] uint32 IDs, [out] uint32 value);
> > +
> > +      [WmiMethodId(18), Implemented, Description("Set Feature Value ")=
]
> > +      void SetFeatureValue([in] uint32 IDs, [in] uint32 value);
> > +
> > +      [WmiMethodId(19), Implemented, Description("Get Data By Command =
")]
> > +      void GetDataByCommand([in] uint32 IDs, [in] uint32 Command, [out=
] uint32 DataSize, [out, WmiSizeIs("DataSize")] uint32 Data[]);
> > +
> > +      [WmiMethodId(99), Implemented, Description("Get Data By Package =
for TAC")]
> > +      void GetDataByPackage([in, Max(40)] uint8 Input[], [out] uint32 =
DataSize, [out, WmiSizeIs("DataSize")] uint8 Data[]);
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("LENOVO CAPABILITY DATA 00"),
> > +   guid("{362a3afe-3d96-4665-8530-96dad5bb300e}")]
> > +  class LENOVO_CAPABILITY_DATA_00 {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description(" IDs.")]
> > +      uint32 IDs;
> > +
> > +      [WmiDataId(2), read, Description("Capability.")]
> > +      uint32 Capability;
> > +
> > +      [WmiDataId(3), read, Description("Capability Default Value.")]
> > +      uint32 DefaultValue;
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("LENOVO CAPABILITY DATA 01"),
> > +   guid("{7a8f5407-cb67-4d6e-b547-39b3be018154}")]
> > +  class LENOVO_CAPABILITY_DATA_01 {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description(" IDs.")]
> > +      uint32 IDs;
> > +
> > +      [WmiDataId(2), read, Description("Capability.")]
> > +      uint32 Capability;
> > +
> > +      [WmiDataId(3), read, Description("Default Value.")]
> > +      uint32 DefaultValue;
> > +
> > +      [WmiDataId(4), read, Description("Step.")]
> > +      uint32 Step;
> > +
> > +      [WmiDataId(5), read, Description("Minimum Value.")]
> > +      uint32 MinValue;
> > +
> > +      [WmiDataId(6), read, Description("Maximum Value.")]
> > +      uint32 MaxValue;
> > +  };
> > +
> > +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> > +   Description("LENOVO CAPABILITY DATA 02"),
> > +   guid("{bbf1f790-6c2f-422b-bc8c-4e7369c7f6ab}")]
> > +  class LENOVO_CAPABILITY_DATA_02 {
> > +      [key, read] string InstanceName;
> > +      [read] boolean Active;
> > +
> > +      [WmiDataId(1), read, Description(" IDs.")]
> > +      uint32 IDs;
> > +
> > +      [WmiDataId(2), read, Description("Capability.")]
> > +      uint32 Capability;
> > +
> > +      [WmiDataId(3), read, Description("Data Size.")]
> > +      uint32 DataSize;
> > +
> > +      [WmiDataId(4), read, Description("Default Value"), WmiSizeIs("Da=
taSize")]
> > +      uint8 DefaultValue[];
> > +  };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6f78d6bcbc7b..e20c32b3c480 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13151,6 +13151,13 @@ S:   Maintained
> >   W:  http://legousb.sourceforge.net/
> >   F:  drivers/usb/misc/legousbtower.c
> >
> > +LENOVO WMI drivers
> > +M:   Derek J. Clark <derekjohn.clark@gmail.com>
> > +L:   platform-driver-x86@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> > +F:   Documentation/wmi/devices/lenovo-wmi-other.rst
>
> Just a side note: when rebasing your work on the current for-next branch =
you will have to resolve a minor merge
> conflict here due to the new Lenovo hotkey utilities driver.

Okay, thanks for the heads up.

Cheers,
- Derek

> Apart from the formatting issues the remaining patch looks good to me.
>
> Thanks,
> Armin Wolf
>
> > +
> >   LETSKETCH HID TABLET DRIVER
> >   M:  Hans de Goede <hdegoede@redhat.com>
> >   L:  linux-input@vger.kernel.org

