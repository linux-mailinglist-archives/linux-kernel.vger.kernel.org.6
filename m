Return-Path: <linux-kernel+bounces-380492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B186B9AEF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DE21C239A5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257981FAC42;
	Thu, 24 Oct 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cseLKW/3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDED15957D;
	Thu, 24 Oct 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793740; cv=none; b=keVsjjoVdBKFKzcrdQ5l3SmFlNZ2fY+SLhE5bTI7/KRs/Z0qkqIyaFbmWkcwFtqYkeTX0xa+y3diHbsLHlpNNY8zI8V7sm1pNyAC3JiN6e5xv/Slp4YALOslROLYlsD5gvvz+D9nG4bejq7Rna0cX+26vxXhSrxfRs4fYUeVg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793740; c=relaxed/simple;
	bh=tq8pn7KrDAtke8A5SNXeAVR4JlNg36rCQ1ADq5JyvLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbVHSDAVhikAjQzsCbUaUF+5xOLhWMf/8Cst6L9uIru2GKjueRaFg1AwgXGlu+DfIKsOhWmm773dPOhReER/J4jZVbO88GOpt1Bp6gE8l0JLFttKDvys/Tlk2Hwb6H6CyrV9/QKQKRUuGxAeKt8JOxuqH3ZkJDCbJ3t3SQUPV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cseLKW/3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729793736; x=1761329736;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tq8pn7KrDAtke8A5SNXeAVR4JlNg36rCQ1ADq5JyvLE=;
  b=cseLKW/3X43RQr0dQtlTZmzDnnfxntf4C7KDp9SXokkVewaIpcphw5Eh
   OSoZKBERWtf9v99WZ6lzqtuajHrt0I1b+xxcj7AIP1BrmvSRWNWxDkn7C
   P6BdU8RmJEdeY2Ao4NJXHKdaWof1WhwGLsJrds4chjvjpJmeAbpPrcUgT
   JaCELaAhNsSb4fmH7ka8iWtIftc62SwDWn3vHye09HOLslMnl3qP3UnRt
   hr8dlUHg442R6rTs3ApqVCOnNFp9VdTS4a7mJ9lLeT+YMKkppmwAnK94k
   x8QnAPmKrUplzS1Zp0fWP38rwV4LAswjEkk5B45x1h0rHYpGEul3lYCOF
   w==;
X-CSE-ConnectionGUID: 0651aw6NTB+nCKcf9lvlrg==
X-CSE-MsgGUID: wIun67rqQMCV8/fi4CTuUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29568319"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29568319"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 11:15:32 -0700
X-CSE-ConnectionGUID: JVvdewQ8TJ+PRetjcZgqPw==
X-CSE-MsgGUID: MeU7LTJyQca28BnRrQ3Ybg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80778162"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 11:15:32 -0700
Message-ID: <73e2e4708cdafe42541eaf047727aa6cf3966248.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Cc: corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Larabel <Michael@phoronix.com>, Casey
	Bowman <casey.g.bowman@intel.com>
Date: Thu, 24 Oct 2024 11:15:31 -0700
In-Reply-To: <01b95adb-3ae9-4619-9652-12a5ddafeb82@gmx.de>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
	 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
	 <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de> <ZxkLz6QBahA7WAyh@laptop>
	 <ab6cfea0-a091-4039-94ac-9a26f3df5da5@gmx.de> <Zxk5ZwG-61iVP3Qm@laptop>
	 <8c4209a4-f6d4-4289-9c57-0ef0188149f3@gmx.de>
	 <e1a3a8d980f2c2ff9ffe4f43b91ddffc81d85265.camel@linux.intel.com>
	 <01b95adb-3ae9-4619-9652-12a5ddafeb82@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 22:32 +0200, Armin Wolf wrote:
> Am 23.10.24 um 22:15 schrieb srinivas pandruvada:
>=20
> > On Wed, 2024-10-23 at 20:57 +0200, Armin Wolf wrote:
> > > Am 23.10.24 um 19:59 schrieb Mohamed Ghanmi:
> > >=20
> > > > On Wed, Oct 23, 2024 at 06:31:17PM +0200, Armin Wolf wrote:
> > > > > Am 23.10.24 um 16:44 schrieb Mohamed Ghanmi:
> > > > >=20
> > > > > > Hello !
> > > > > > On Sun, Oct 20, 2024 at 09:42:45PM +0200, Armin Wolf wrote:
> > > > > > > Am 20.10.24 um 21:05 schrieb Armin Wolf:
> > > > > > >=20
> > > > > > > > Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
> > > > > > > >=20
> > > > > > > > > Some recent Asus laptops are supporting ASUS
> > > > > > > > > Intelligent
> > > > > > > > > Performance
> > > > > > > > > Technology (AIPT). This solution allows users to have
> > > > > > > > > maximized CPU
> > > > > > > > > performance in models with a chassis providing more
> > > > > > > > > thermal head room.
> > > > > > > > > Refer to [1].
> > > > > > > > >=20
> > > > > > > > > There are major performance issues when Linux is
> > > > > > > > > installed on these
> > > > > > > > > laptops compared to Windows install. One such report
> > > > > > > > > is
> > > > > > > > > published for
> > > > > > > > > Graphics benchmarks on Asus ASUS Zenbook S 14 with
> > > > > > > > > Lunar
> > > > > > > > > Lake
> > > > > > > > > processors [2].
> > > > > > > > >=20
> > > > > > > > > By default, these laptops are booting in "Whisper
> > > > > > > > > Mode"
> > > > > > > > > till OS power
> > > > > > > > > management or tools change this to other AIPT mode.
> > > > > > > > > This
> > > > > > > > > "Whisper" mode
> > > > > > > > > calls to set lower maximum and minimum RAPL (Running
> > > > > > > > > Average Power
> > > > > > > > > Limit)
> > > > > > > > > via thermal tables. On Linux this leads to lower
> > > > > > > > > performance even when
> > > > > > > > > platform power profile is "balanced". This "Whisper"
> > > > > > > > > mode
> > > > > > > > > should
> > > > > > > > > correspond to "quiet" mode.
> > > > > > > > >=20
> > > > > > > > > So, when AIPT is present change the default mode to
> > > > > > > > > "Standard" during
> > > > > > > > > boot. Map the three platform power profile modes as
> > > > > > > > > follows:
> > > > > > > > >=20
> > > > > > > > > Power Profile Mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AIPT mod=
e
> > > > > > > > > -----------------------------------
> > > > > > > > > quiet=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Whisper
> > > > > > > > > balanced=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Standa=
rd
> > > > > > > > > performance=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Per=
formance
> > > > > > > > > ------------------------------------
> > > > > > > > >=20
> > > > > > > > > Here AIPT mode can be detected by checking presese of
> > > > > > > > > "FANL" method
> > > > > > > > > under
> > > > > > > > > PNP HID "PNP0C14" and UID "ATK". If AIPT mode is
> > > > > > > > > present,
> > > > > > > > > this takes
> > > > > > > > > precedence over the existing VIVO thermal policy.
> > > > > > > > > These
> > > > > > > > > modes are set
> > > > > > > > > using "FANL" method.
> > > > > > > > >=20
> > > > > > > > > Although this =E2=80=9CFANL=E2=80=9D method is not used i=
n the Asus
> > > > > > > > > WMI
> > > > > > > > > driver, users
> > > > > > > > > have used this method from user space [3] to set AIPT
> > > > > > > > > modes. Used this
> > > > > > > > > as a reference.
> > > > > > > > >=20
> > > > > > > > > Link:
> > > > > > > > > https://www.asus.com/content/laptop-asus-intelligent-perf=
ormance-technology-aipt/
> > > > > > > > > # [1]
> > > > > > > > > Reported-by: Michael Larabel <Michael@phoronix.com>
> > > > > > > > > Closes:
> > > > > > > > > https://www.phoronix.com/review/lunar-lake-xe2/5=C2=A0#
> > > > > > > > > [2]
> > > > > > > > > Link:
> > > > > > > > > https://github.com/dominiksalvet/asus-fan-control/issues/=
151
> > > > > > > > > =C2=A0=C2=A0# [3]
> > > > > > > > > Tested-by: Casey Bowman <casey.g.bowman@intel.com>
> > > > > > > > > Signed-off-by: Srinivas Pandruvada
> > > > > > > > > <srinivas.pandruvada@linux.intel.com>
> > > > > > > > > ---
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 drivers/platform/x86/asus-wmi.c | 93
> > > > > > > > > +++++++++++++++++++++++++++++++--
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 1 file changed, 89 insertions(+), 4 d=
eletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/platform/x86/asus-wmi.c
> > > > > > > > > b/drivers/platform/x86/asus-wmi.c
> > > > > > > > > index 7a48220b4f5a..06689d0f98c7 100644
> > > > > > > > > --- a/drivers/platform/x86/asus-wmi.c
> > > > > > > > > +++ b/drivers/platform/x86/asus-wmi.c
> > > > > > > > > @@ -100,6 +100,11 @@ module_param(fnlock_default,
> > > > > > > > > bool,
> > > > > > > > > 0444);
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 #define
> > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO=C2=A0=C2=A0=C2=
=A0 1
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 #define
> > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO=C2=A0=C2=A0=
=C2=A0 2
> > > > > > > > >=20
> > > > > > > > > +#define AIPT_STANDARD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > > > > > > > +#define AIPT_WHISPER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> > > > > > > > > +#define AIPT_PERFORMANCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
> > > > > > > > > +#define AIPT_FULL_SPEED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 #define PLATFORM_PROFILE_MAX 2
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 #define USB_INTEL_XUSB2PR=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xD0
> > > > > > > > > @@ -333,6 +338,9 @@ struct asus_wmi {
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_w=
mi_debug debug;
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_w=
mi_driver *driver;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 acpi_handle acpi_mgmt_handle;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 int asus_aipt_mode;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 bool asus_aipt_present;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 };
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 /* WMI
> > > > > > > > > *****************************************************
> > > > > > > > > ****
> > > > > > > > > ***************/
> > > > > > > > > @@ -3804,6 +3812,19 @@ static ssize_t
> > > > > > > > > throttle_thermal_policy_store(struct device *dev,
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 static DEVICE_ATTR_RW(throttle_therma=
l_policy);
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 /* Platform profile
> > > > > > > > > *****************************************************
> > > > > > > > > ****
> > > > > > > > > **/
> > > > > > > > > +static int asus_wmi_write_aipt_mode(struct asus_wmi
> > > > > > > > > *asus, int
> > > > > > > > > aipt_mode)
> > > > > > > > > +{
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 int status;
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 status =3D acpi_execute_simple_method=
(asus-
> > > > > > > > > > acpi_mgmt_handle,
> > > > > > > > > "FANL", aipt_mode);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status)) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_handle_i=
nfo(asus->acpi_mgmt_handle,
> > > > > > > > > "FANL
> > > > > > > > > execute
> > > > > > > > > failed\n");
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 static int
> > > > > > > > > asus_wmi_platform_profile_to_vivo(struct
> > > > > > > > > asus_wmi *asus,
> > > > > > > > > int mode)
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 {
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool vivo;
> > > > > > > > > @@ -3844,6 +3865,26 @@ static int
> > > > > > > > > asus_wmi_platform_profile_mode_from_vivo(struct
> > > > > > > > > asus_wmi
> > > > > > > > > *asus, int m
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mode;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 }
> > > > > > > > >=20
> > > > > > > > > +static int asus_wmi_aipt_platform_profile_get(struct
> > > > > > > > > asus_wmi *asus,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enum
> > > > > > > > > platform_profile_option
> > > > > > > > > *profile)
> > > > > > > > > +{
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 switch (asus->asus_aipt_mode) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 case AIPT_STANDARD:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D =
PLATFORM_PROFILE_BALANCED;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 case AIPT_PERFORMANCE:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D =
PLATFORM_PROFILE_PERFORMANCE;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 case AIPT_WHISPER:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D =
PLATFORM_PROFILE_QUIET;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 default:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVA=
L;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 static int asus_wmi_platform_profile_=
get(struct
> > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum platform_profile_option
> > > > > > > > > *profile)
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 {
> > > > > > > > > @@ -3851,6 +3892,10 @@ static int
> > > > > > > > > asus_wmi_platform_profile_get(struct
> > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tp;
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus =3D cont=
ainer_of(pprof, struct asus_wmi,
> > > > > > > > > platform_profile_handler);
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 if (asus->asus_aipt_present)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
> > > > > > > > > asus_wmi_aipt_platform_profile_get(asus,
> > > > > > > > > profile);
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D asus->=
throttle_thermal_policy_mode;
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch
> > > > > > > > > (asus_wmi_platform_profile_mode_from_vivo(asus, tp))
> > > > > > > > > {
> > > > > > > > > @@ -3874,26 +3919,42 @@ static int
> > > > > > > > > asus_wmi_platform_profile_set(struct
> > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum platform_profile_option
> > > > > > > > > profile)
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 {
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_w=
mi *asus;
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 int tp;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 int ret =3D 0, tp, aipt_mode;
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus =3D cont=
ainer_of(pprof, struct asus_wmi,
> > > > > > > > > platform_profile_handler);
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (profi=
le) {
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM=
_PROFILE_PERFORMANCE:
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 tp =3D
> > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D=
 AIPT_PERFORMANCE;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM=
_PROFILE_BALANCED:
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 tp =3D
> > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D=
 AIPT_STANDARD;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM=
_PROFILE_QUIET:
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 tp =3D
> > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D=
 AIPT_WHISPER;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -EOPNOTSUPP;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > >=20
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 asus->throttle_thermal_policy_mode =
=3D
> > > > > > > > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 return throttle_thermal_policy_write(=
asus);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 if (asus->asus_aipt_present) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D asus_=
wmi_write_aipt_mode(asus,
> > > > > > > > > aipt_mode);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 asus->asus_aipt_mode =3D aipt_mode;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto skip_vivo;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 if (asus->throttle_thermal_policy_dev=
) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus->throttl=
e_thermal_policy_mode =3D
> > > > > > > > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D throt=
tle_thermal_policy_write(asus);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > +
> > > > > > > > > +skip_vivo:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 return ret;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 }
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 static int platform_profile_setup(str=
uct
> > > > > > > > > asus_wmi
> > > > > > > > > *asus)
> > > > > > > > > @@ -3905,7 +3966,7 @@ static int
> > > > > > > > > platform_profile_setup(struct
> > > > > > > > > asus_wmi *asus)
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Not a=
n error if a component
> > > > > > > > > platform_profile
> > > > > > > > > relies on is
> > > > > > > > > unavailable
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so ea=
rly return, skipping the setup of
> > > > > > > > > platform_profile.
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 if (!asus->throttle_thermal_policy_de=
v)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 if (!asus->throttle_thermal_policy_de=
v && !asus-
> > > > > > > > > > asus_aipt_present)
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 0;
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev,=
 "Using throttle_thermal_policy
> > > > > > > > > for
> > > > > > > > > platform_profile support\n");
> > > > > > > > > @@ -4538,6 +4599,7 @@ static int
> > > > > > > > > asus_wmi_sysfs_init(struct
> > > > > > > > > platform_device *device)
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 static int asus_wmi_platform_init(str=
uct
> > > > > > > > > asus_wmi
> > > > > > > > > *asus)
> > > > > > > > > =C2=A0=C2=A0 =C2=A0 {
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device=
 *dev =3D &asus->platform_device-
> > > > > > > > > >dev;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 struct acpi_device *adev;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *wmi_uid=
;
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rv;
> > > > > > > > >=20
> > > > > > > > > @@ -4593,6 +4655,29 @@ static int
> > > > > > > > > asus_wmi_platform_init(struct
> > > > > > > > > asus_wmi *asus)
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > > > > > > > > asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
> > > > > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 asus->driver->quirks-
> > > > > > > > > >wapf,
> > > > > > > > > NULL);
> > > > > > > > >=20
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 /*
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Check presence of Intelligent=
 Performance
> > > > > > > > > Technology (AIPT).
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * If present store acpi handle =
and set
> > > > > > > > > asus_aipt_present to true.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 adev =3D acpi_dev_get_first_match_dev=
("PNP0C14",
> > > > > > > > > "ATK", -1);
> > > > > > > > Is there really no way of changing the AIPT mode
> > > > > > > > through
> > > > > > > > the WMI
> > > > > > > > interface?
> > > > > > > > I would prefer using the WMI interface if available,
> > > > > > > > since
> > > > > > > > the
> > > > > > > > firmware might
> > > > > > > > assume that FANL is only called through the WMI
> > > > > > > > interface.
> > > > > > > >=20
> > > > > > > > Do you have a acpidump from a affected device?
> > > > > > > >=20
> > > > > > > > Thanks,
> > > > > > > > Armin Wolf
> > > > > > > >=20
> > > > > > > I found a acpidump from a ASUS device with a matching
> > > > > > > FANL
> > > > > > > method. It seems that this method
> > > > > > > can indeed be called using the WMI interface using the
> > > > > > > DEVS()
> > > > > > > WMI method:
> > > > > > >=20
> > > > > > > [WmiMethodId(1398162756), Implemented] void DEVS([in]
> > > > > > > uint32
> > > > > > > Device_ID, [in] uint32 Control_status, [out] uint32
> > > > > > > result);
> > > > > > >=20
> > > > > > > If Device_ID is 0x00110019, then Control_status is passed
> > > > > > > to
> > > > > > > the FANL ACPI method.
> > > > > > >=20
> > > > > > > It also seems that support for AIPT can be queried using
> > > > > > > the
> > > > > > > DSTS() WMI method:
> > > > > > >=20
> > > > > > > [WmiMethodId(1398035268), Implemented] void DSTS([in]
> > > > > > > uint32
> > > > > > > Device_ID, [out] uint32 device_status);
> > > > > > >=20
> > > > > > > Using Device_ID 0x00110019, the returned device status
> > > > > > > seems
> > > > > > > to contain the following information:
> > > > > > >=20
> > > > > > > - 16-bit current AIPT mode
> > > > > > > - 4-bit unknown value (possible values 2, 3 and 7, maybe
> > > > > > > number of supported modes or some kind of bitmap?)
> > > > > > > - 1-bit with is set when (GGIV (0x0907000C) =3D=3D One) is
> > > > > > > true
> > > > > > I just saw this conversation and i think that the behaviour
> > > > > > this
> > > > > > patch will implement in the driver was already implemented
> > > > > > in
> > > > > > this patch
> > > > > > that got added to kernel v6.12-rc3:
> > > > > > https://lore.kernel.org/platform-driver-x86/20240609144849.2532=
-2-mohamed.ghanmi@supcom.tn/
> > > > > >=20
> > > > > > this patch introduced
> > > > > > ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO
> > > > > > 0x00110019 which is the device_id that changes the fan
> > > > > > profiles. the
> > > > > > naming is not clear because it was initially intended to
> > > > > > add
> > > > > > support for
> > > > > > fan profiles for vivobook laptops but it ended up adding
> > > > > > support
> > > > > > for a lot of modern laptops.
> > > > > Nice, you are absolutely right.
> > > > >=20
> > > > > So this patch series is effectively already upstream, very
> > > > > good.
> > > > > I did some research and found out
> > > > > that the status of this device id contains the following
> > > > > data:
> > > > >=20
> > > > > Status=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Supported Modes
> > > > > -------------------------------
> > > > > 0x00[1]300[xx]=C2=A0=C2=A00 1 2
> > > > > 0x000700[xx]=C2=A0=C2=A0=C2=A0=C2=A00 1 2
> > > > > 0x000200[xx]=C2=A0=C2=A0=C2=A0=C2=A0??? (ODV0)
> > > > > 0x000700[xx]=C2=A0=C2=A0=C2=A0=C2=A00 1 2
> > > > > 0x0a0700[xx]=C2=A0=C2=A0=C2=A0=C2=A0??? (ODV0)
> > > > >=20
> > > > > While i have no clue about the meaning of the remaining bits,
> > > > > i
> > > > > can report that the first 8 Bits
> > > > > contain the current thermal mode. Maybe adding support for
> > > > > this
> > > > > would be nice, so the current
> > > > > thermal mode can be read directly from the hardware.
> > > > >=20
> > > > > I also found out that on some models the thermal mode
> > > > > actually
> > > > > modifies the ODV0 variable which
> > > > > is consumed by int3400_thermal and exposed to the Intel
> > > > > Thermal
> > > > > Daemon. So maybe the lackluster
> > > > > performance also has something to do with it.
> > > > >=20
> > > > > > a point that Srinivas Pandruvada mentioned about RAPL
> > > > > > (Running
> > > > > > Average Power Limit)
> > > > > > is valid for a lot of modern vivobook and zenbook laptops
> > > > > > but i
> > > > > > think
> > > > > > it's unrelated to fan profiles.
> > > > > >=20
> > > > > > a lot of asus laptops that have intel cpus suffer from
> > > > > > power
> > > > > > throttling.
> > > > > > for exemple in my case using windows, changing fan profiles
> > > > > > will lead to max power
> > > > > > changing to the values indicated in the table below (asus
> > > > > > vivobook 16x
> > > > > > pro k6604) which leads to higher performance than linux
> > > > > >=20
> > > > > > fan Profile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0power limit
> > > > > > -----------------------------------
> > > > > > Whisper=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A050watts
> > > > > > Standard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 120watts
> > > > > > Performance=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0149watts
> > > > > > ------------------------------------
> > > > > >=20
> > > > > > However in linux, even after changing to the appropriate
> > > > > > fan
> > > > > > profile,
> > > > > > the power is still capped at 50watts and i found the reason
> > > > > > why
> > > > > >=20
> > > > > > here is the results of using the powercap-info command:
> > > > > >=20
> > > > > > intel-rapl-mmio
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 enabled: 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Zone 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: package-0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_range_uj: 26214=
3328850
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: long_ter=
m
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw=
: 30000000
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us=
: 55967744
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: =
55000000
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: short_te=
rm
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw=
: 55000000
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us=
: 2440
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: =
0
> > > > > > intel-rapl
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 enabled: 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Zone 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: package-0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_range_uj: 26214=
3328850
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: long_ter=
m
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw=
: 157000000
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us=
: 55967744
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: =
55000000
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: short_te=
rm
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw=
: 157000000
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us=
: 2440
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: =
0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 2
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: peak_pow=
er
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw=
: 200000000
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: =
0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Zone 0:0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: core
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_ran=
ge_uj: 262143328850
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 na=
me: long_term
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 po=
wer_limit_uw: 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti=
me_window_us: 976
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Zone 0:1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: uncore
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_ran=
ge_uj: 262143328850
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 na=
me: long_term
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 po=
wer_limit_uw: 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti=
me_window_us: 976
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Zone 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: psys
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_range_uj: 26214=
3328850
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: long_ter=
m
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw=
: 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us=
: 27983872
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: short_te=
rm
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw=
: 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us=
: 976
> > > > > >=20
> > > > > >=20
> > > > > > as seen by the output of the command, the intel-rapl-mmio
> > > > > > is
> > > > > > causing the
> > > > > > throttling as it sets power_limit_uw to 30 watts
> > > > > > (readonly). so
> > > > > > the current fix
> > > > > > that i'm currently using is disabling the intel-rapl-mmio
> > > > > > leaving only
> > > > > > the intel-rapl which sets power_limit_uw to 157watts using
> > > > > > this
> > > > > > command: powercap-set -p intel-rapl-mmio -z 0 -e 0
> > > > > >=20
> > > > > > this will lead to the laptop being able to reach it's
> > > > > > maximum
> > > > > > power
> > > > > > limit.
> > > > > >=20
> > > > > > after doing this, when i change the platform profile
> > > > > > through
> > > > > > sysfs the
> > > > > > laptop will start behaving as described in the table above
> > > > > > exactly like
> > > > > > windows.
> > > > > >=20
> > > > > > in conclusion, the asus-wmi driver already has the platform
> > > > > > profiles
> > > > > > (a.k.a fan profiles)
> > > > > > implemented and I think that the power throttling is caused
> > > > > > by
> > > > > > either
> > > > > > intel Power Capping Framework or asus bios.
> > > > > Or the Intel Thermal Daemon somehow does not properly support
> > > > > intel-rapl-mmio
> > > > > or is not installed.
> > > > This was exactly it. the Intel Thermal Daemon wasn't installed.
> > > > now
> > > > everything is working as expected!
> > > >=20
> > > > Best regards,
> > > > Mohamed G.
> > > Interesting.
> > >=20
> > > Srinivas, can you verify that the Intel Thermal Daemon is
> > > installed
> > > on the affected
> > > Asus machines?
> > >=20
> > > I begin to wonder why this thermal daemon is a userspace
> > > component,
> > > stuff like thermal
> > > management should use the thermal subsystem inside the kernel.
> > Thanks for detailed analysis here.
> >=20
> > Here the problem is not thermal daemon or INT340x (I am author of
> > both).
> >=20
> > The ODVP variable is input into thermal tables. These thermal
> > tables
> > are defined by Asus via DTT tables. This results in matching
> > certain
> > max and min power limits and also various temperature limits.
> >=20
> > By default the laptop in question will boot with max limit of 17W,
> > which is limit for whisper mode match based on ODVP variables.
> > There is
> > a SEN1 limit of 50C, once the limit reaches to 50C, you need to
> > throttle upto 12W as per thermal table.
> >=20
> > If you stop thermald, yes, you will stay in 17W, so you will not
> > see
> > throttle but your SEN1 (seems skin limit) limit will be violated.
> > Also if you remove the rapl_mmio driver, that will also work as no
> > means to set power limits.
> >=20
> > Windows will do exactly same. Meeting thermal limit is a
> > requirement.
> >=20
> > But on Windows this ODVP variable will be set to 0 to match
> > standard
> > mode. This will result in matching rules which will set the max
> > power
> > to 22W and min to 17W also increase thermal limit to 55C. So
> > essentially lost 5W of performance.
> >=20
> > Here WMI method as you correctly found out matching VIVO thermal
> > policy. But it will not set ODVP variable unless you call a WMI
> > method
> > to set the mode via DEVS() on the same device ID. So although
> > platform
> > power policy will say "balanced" it is actually "Whisper" for
> > thermal
> > policy. On Windows when system boots the Asus service will set to
> > standard and will set the ODVP variable to 0 and will match the
> > correct
> > table.
> >=20
> > After Luke's help, I can do a work around from user space to change
> > the
> > power policy to any other policy than balanced and then again set
> > to
> > balance. This will result in setting the policy to standard via
> > DEVS()
> > and also set the correct ODVP variable.
> >=20
> > This driver on unload change the vivo thermal policy to default.
> > But
> > doesn't change that to default on load time to match the default
> > platform power policy. So rmmod and modprobe of driver should also
> > fix.
> >=20
> > Thanks,
> > Srinivas
> >=20
> Good point, so basically throttle_thermal_policy_set_default() need
> to be called during
> initialization of the thermal profile. Maybe you can send another
> patch which implements this?

I have already tested this change. But this seems a regression, so want
to confirm first as it was intentional. The following commit removed
the call. If it was unintentional, Mohamed can try to submit a change.


commit bcbfcebda2cbc6a10a347d726e4a4f69e43a864e
Author: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Date:   Sun Jun 9 15:48:49 2024 +0100

Thanks,
Srinivas




>=20
> Thanks,
> Armin Wolf
>=20
> > > Thanks,
> > > Armin Wolf
> > >=20
> >=20


