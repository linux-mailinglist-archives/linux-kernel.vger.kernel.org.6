Return-Path: <linux-kernel+bounces-535206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C432AA47023
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9527B3B099F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105FC13D;
	Thu, 27 Feb 2025 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN1O2U2p"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B855A47;
	Thu, 27 Feb 2025 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615715; cv=none; b=UrRumKgTo77jZ337JmEQOFGBXTpMio/4v0Omj4OZ5B7dQZ3hCXupqSYIn7oSNwYdMOjII9aR5QIk0/lQ6YNVcVdCYMjAVK/w8/nX27YtlAN8SFukFnKaSgbs/oXuZbiyad9t0suhNHyL3SIhY68iPfN3CCgK04qbsS31DkPEUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615715; c=relaxed/simple;
	bh=haSzZ6uB217jKnUFkl24sYYCl0OJjHk0LJxUpkLyYpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fz0T5lc12WJ+N2bm1J7SrEaGe7Sj1llU8Np+SG2D2PuouAvKxiwA72pqh+Qq5NVXMpVoMz4Ff3IPc0+hi+vSZ98cffD7eKmNc4of5ZeGH2tglM46Ns7rKW/X8KxumG+D31OFwY3+99p2ONrGGPHvhtJLvN5lSii+z9fn0c4QvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN1O2U2p; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8978cca96so1759236d6.0;
        Wed, 26 Feb 2025 16:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740615711; x=1741220511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzqcHDtTa0vp1j56Udl43O/vzUyzUMHiY+rU4y5jaas=;
        b=EN1O2U2pdtyi+GECeeJO5bfIyVl+jdDXfdjb8dXmPvWjliWwxB0Tbs/0HUG7OClBgJ
         Ifdtu2wiBDn4tCuxn/P82x5Ovfz+6OyyKo/rG+tJCELTiG29zciF08Ivc+p5t54UZqbS
         Yss39CRuaWwBjnV0sJMkSd+k3kgoy2peMSi9knsZpJ8LKa1cWXciw5jU7okqTHFI9o11
         vnFy5fu3Nqf8CpljufN8Yx4j/4BJo1DRDX9HZ2O81ionvH7/EGf1tI1I3wyeHg2bghOl
         D10D+OVBuvN89a8i1Nb4nUMqxhklIDfu7OEVrYLFkGLOcjsqtZy3v/F5oJhEqvniFIPm
         vlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615711; x=1741220511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzqcHDtTa0vp1j56Udl43O/vzUyzUMHiY+rU4y5jaas=;
        b=ew8AJO2yubllmZ8R2WeAidlvqA8zralMxn2KbswjNXtkS8Pmy06oeuaAwqJFR5LGOn
         emgQjl3TyOUc4xl99F/wtjawq/xY99Q7WQmJ230b0fuNMjHspZkS3ezw1t59XIq59dZ0
         iBYSPhKdZjvxqEaHsPjTeLt1r/RojgJ3aJzJv0LUtLE5HzgIbO4IXk0as9hiN1h1LxWf
         1oRM5oAiwChfD5xiQryNrjTGpJ3TSUidXfyz1BjnyY0IvOWyl8ztqvwFJvS1wo1jtIxR
         1Aw3+drAYrGcDMvASjCNfJWw652y2tASkXYzEDQIymIXmU+uGbF3t2r6mURFzMH4UCQE
         egmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuI3Om+bQ+lwWwAfSFh4xkiqOai35YdtM1KB8fT6zLBsSq7cFrcpaWCMCl3aUfxlmq0COe3ChZnyxo4R15@vger.kernel.org, AJvYcCVq+ES8DMR+gQ5NNk4m44PHsuX1NvEiFojCOg3y1H3uXj165ql0tFsU5kQ7ATgQ91/iqQ9Z0xeNo4gau9roAn0CA+eJ5g==@vger.kernel.org, AJvYcCXTxeE41p23SHLyjufADsKpqXvrub0tq3ZQ+3pzotpFFl7FMhP85kUVbFvI0kTt9rdZxVYvkV8m54k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXGxisPQR+mrGef6hKhl+gafQyLMIsLM1v+mPiwF6ARaTeDcD
	nLl31ugQs92isvIQDdwLExT/fxL+uQVjo5rvvLLxf3ZI0Ysjug2l3DnjM9gCOoJ2S3IdXlarAOA
	KPqMjtrGCOs6BxbgFKKXvCSlgCEo=
X-Gm-Gg: ASbGncvdaWCWflogcPIMbiFg+u0bo/chOW3tDHQTdGnl5NdcK0/lnGwLDTp0qhopyR7
	uDSDuhcvqDG4GJAkrfdGZaRdrE23jFijrfQHU5b04gRYPKDD7pcIMkbzE2J06m2lQw8UbAcQpql
	JrKqlWYxgT
X-Google-Smtp-Source: AGHT+IFmeoumFS97vw6BKUDLs26oza+dTIgJgV++E7d3N7Xku5ECnuD2tlYaoCmAqMHlbh57nG4OJnhtTk+ry5Ni2Bc=
X-Received: by 2002:a05:6214:d49:b0:6e4:4012:b6f1 with SMTP id
 6a1803df08f44-6e8959a99a4mr23428416d6.3.1740615711224; Wed, 26 Feb 2025
 16:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-2-derekjohn.clark@gmail.com> <43457d5d-d32d-4d3c-9174-d63a9f7ed4c3@kernel.org>
In-Reply-To: <43457d5d-d32d-4d3c-9174-d63a9f7ed4c3@kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Wed, 26 Feb 2025 16:21:40 -0800
X-Gm-Features: AQ5f1JqvUAl1hYAgw9il1AjOK7YLGFCQi_BBVRanwL4DDn7H9R2OODW6j408tAM
Message-ID: <CAFqHKTkjF8A1yWWvgpH9Wj661PRk60cWR2be+SNk0m3WN6QQgw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] platform/x86: Add lenovo-wmi drivers Documentation
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, Luke Jones <luke@ljones.dev>, 
	Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, "Cody T . -H . Chiu" <codyit@gmail.com>, 
	John Martens <johnfanv2@gmail.com>, platform-driver-x86@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:36=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 2/25/2025 13:59, Derek J. Clark wrote:
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
>
> Generally speaking the changelog from each version should be below the
> cutlist (---).  Otherwise you're going to end up with this text in the
> commit meesage that is committed to trees.
>
> So it should be something like this:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> foo: bar
>
> Foo the bar
>
> Signed-off-by: Foo bar <Foo@bar.com>
> ---
> v1->v2:
>   * Foo the bar harder
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> This comment goes for all the patches.
>
> Other comments inline as well.
>

My mistake, thanks.

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
>
> profile
>
> But this also invites a confusion on my part.  Does that mean that
> balanced-performance "isn't" offered on the legacy devices without
> extreme mode?  Or is it not functional?  Or it means the same as balanced=
?

It is only enabled if the following conditions are met:
- The IsSupportSmartFan WMI method returns v6+.
- There is no entry in the quirk table for the modern devices with an
incomplete extreme mode entry.

For some reason on their handhelds, Lenovo report v6 but extreme is
essentially blank. I did some testing to see what happens on these
devices if extreme is allowed to be set and it does a few things:
- The Legion +Y macro breaks and is unable to cycle through the profiles.
- Performance is tanked, presumably because the max TDP hits some
logical low point.
- The light ring on the power button goes out.
- WMI calls stop working to change the profile and a BIOS reset is needed.

In any case, I can add that balanced-performance isn't available in
the docs for those devices. What would be a good syntax for noting
there are caveats for some profiles?

The following platform profiles are supported:
 - low-power
 - balanced
 - balanced-performance*
 - performance*
 - custom

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
>
> Did you find/replace at some point and lose the "Impl" on some of these?
>   Or is this a bug with bmfdec?

Lenovo provided the bmof data, but the formatting was poor. My VIM
macro to clean them up probably messed up here. I'll fix it, thanks
for noticing this mistake.

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

Note for self here, attribute [attibute]

- Derek
> > +::
> > +/sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>=
/
> > +
> > +LENOVO_CAPABILITY_DATA_01
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > +WMI GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
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
> > +
> >   LETSKETCH HID TABLET DRIVER
> >   M:  Hans de Goede <hdegoede@redhat.com>
> >   L:  linux-input@vger.kernel.org
>

