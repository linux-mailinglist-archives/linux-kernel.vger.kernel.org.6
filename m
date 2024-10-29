Return-Path: <linux-kernel+bounces-387376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B69B501C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0851C22B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0E1DCB31;
	Tue, 29 Oct 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eM6ppBrU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65C1D9A51;
	Tue, 29 Oct 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221587; cv=none; b=TT4NwYdHM4HWGCkvG+AXpaxnxS9cunzlnLdyNd5RyUOtJxQxTSQYIXN3EbR6vVR3pY0SAKipVr9dg6D+EgofnFrjbI2AAOF2fQs0LM9VLIgetCiNrojcERNIVFheGgOtcvZnyS9Gh62VjvuEUAbvOKy6hx2bUi8jtTgU+VVTBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221587; c=relaxed/simple;
	bh=/EnbBhjrp0fL+RZaa3oZ/24Om08jpAthEADwgyy8OIc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wl7wxYLBkDrDj/IbOiDGzMkIG0Q21Ujrf9xrg4j8dX4wQ3GwZ5nVetNr+qYHN3eE1P4VkQw+ElTgEQ2ZfzrzIxHOn+Rcvd3hTjvS1HBrMuy0gIKieujaq2agoWGkTnMgklvO2bWmHfHRy9Kvd9m4fjD00NlArveRxSiwwJ/8x+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eM6ppBrU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730221584; x=1761757584;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/EnbBhjrp0fL+RZaa3oZ/24Om08jpAthEADwgyy8OIc=;
  b=eM6ppBrU61w4RPxdDroDYvY4FaoZ7kxUS8Mttz5m95sYFANix6NsQLuT
   iKvG759dYi6lTEspOdYbHgP2F3X7fy5K/NXJi/GN+Cg7JAV+NoRGCs5be
   bayxwG+lya33gB9MQLUrqjRYAfXetTZq8Aq35Yvw6QQ03SHOqyQg5GTFs
   tYS59WR7K5O0GCmGsPlzJIx91HINlb39+qV0Wdv3bGkSbjkcncFrZ8x7R
   gxmuxt7MM1iLe+9A4lYSVFCKDby9q+UhD0OMh/PmShTNm3iZbVrB+ahV8
   VuQOf70SPJdcerMKPCrykZRBuJOsLAauvojEvGxCzc26QZr6KOBr9TgnG
   w==;
X-CSE-ConnectionGUID: 6okAPr8IQ2+qROaBiOhUIw==
X-CSE-MsgGUID: 9DPDsa3ITKO7tmxIDRYpRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33673473"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33673473"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:06:23 -0700
X-CSE-ConnectionGUID: SiHbL5urSum25V8aZBo1Gg==
X-CSE-MsgGUID: aGk65hEqT9a5OfamsRtiUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82840605"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:06:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 19:06:18 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v10 3/5] alienware-wmi: added platform profile support
In-Reply-To: <pvsp76cvdqp7irpa52mr3canryyzilgvyijhtqvxzhix3diavj@bcfuduinqlcb>
Message-ID: <12f980ac-f1d3-a802-37a9-cb6e03b046de@linux.intel.com>
References: <20241029135107.5582-2-kuurtb@gmail.com> <20241029135341.5906-1-kuurtb@gmail.com> <9caaa4f1-9605-da2a-9afd-8f40ed33719f@linux.intel.com> <pvsp76cvdqp7irpa52mr3canryyzilgvyijhtqvxzhix3diavj@bcfuduinqlcb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-146057457-1730221521=:951"
Content-ID: <4f51f3ab-8aa0-069d-9986-498a59f18c90@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-146057457-1730221521=:951
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9a57ff9e-0845-7c20-276e-ee58d1bc3f20@linux.intel.com>

On Tue, 29 Oct 2024, Kurt Borja wrote:

> On Tue, Oct 29, 2024 at 05:44:05PM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 29 Oct 2024, Kurt Borja wrote:
> >=20
> > > Implements platform profile support for Dell laptops with new WMAX th=
ermal
> > > interface, present on some Alienware X-Series, Alienware M-Series and
> > > Dell's G-Series laptops. This interface is suspected to be used by
> > > Alienware Command Center (AWCC), which is not available for linux
> > > systems, to manage thermal profiles.
> > >=20
> > > This implementation makes use of three WMI methods, namely
> > > THERMAL_CONTROL, THERMAL_INFORMATION and GAME_SHIFT_STATUS, which tak=
e
> > > u32 as input and output arguments. Each method has a set of supported
> > > operations specified in their respective enums.
> > >=20
> > > Not all models with WMAX WMI interface support these methods. Because=
 of
> > > this, models have to manually declare support through new quirks
> > > `thermal` for THERMAL_CONTROL and THERMAL_INFORMATION and `gmode` for
> > > GAME_SHIFT_STATUS.
> > >=20
> > > Wrappers written for these methods support multiple operations.
> > >=20
> > > THERMAL_CONTROL switches thermal modes through operation
> > > ACTIVATE_PROFILE. Available thermal codes are auto-detected at runtim=
e
> > > and matched against a list of known thermal codes:
> > >=20
> > > Thermal Table "User Selectable Thermal Tables" (USTT):
> > > =09BALANCED=09=09=090xA0
> > > =09BALANCED_PERFORMANCE=09=090xA1
> > > =09COOL=09=09=09=090xA2
> > > =09QUIET=09=09=09=090xA3
> > > =09PERFORMANCE=09=09=090xA4
> > > =09LOW_POWER=09=09=090xA5
> > >=20
> > > Thermal Table Basic:
> > > =09QUIET=09=09=09=090x96
> > > =09BALANCED=09=09=090x97
> > > =09BALANCED_PERFORMANCE=09=090x98
> > > =09PERFORMANCE=09=09=090x99
> > >=20
> > > Devices are known to implement only one of these tables without mixin=
g
> > > their thermal codes.
> > >=20
> > > The fact that the least significant digit of every thermal code is
> > > consecutive of one another is exploited to efficiently match codes
> > > through arrays.
> > >=20
> > > Autodetection of available codes is done through operation LIST_IDS o=
f
> > > method THERMAL_INFORMATION. This operation lists fan IDs, CPU sensor =
ID,
> > > GPU sensor ID and available thermal profile codes, *in that order*. A=
s
> > > number of fans and thermal codes is very model dependent, almost ever=
y
> > > ID is scanned and matched based on conditions found on
> > > is_wmax_thermal_code(). The known upper bound for the number of IDs i=
s
> > > 13, corresponding to a device that have 4 fans, 2 sensors and 7 therm=
al
> > > codes.
> > >=20
> > > Additionally G-Series laptops have a key called G-key, which (with AW=
CC
> > > proprietary driver) switches the thermal mode to an special mode name=
d
> > > GMODE with code 0xAB and changes Game Shift Status to 1. Game Shift i=
s a
> > > mode the manufacturer claims, increases gaming performance.
> > >=20
> > > GAME_SHIFT_STATUS method is used to mimic this behavior when selectin=
g
> > > PLATFORM_PROFILE_PERFORMANCE option.
> > >=20
> > > All of these profiles are known to only change fan speed profiles,
> > > although there are untested claims that some of them also change powe=
r
> > > profiles.
> > >=20
> > > Activating a thermal mode with method THERMAL_CONTROL may cause short
> > > hangs. This is a known problem present on every platform.
> > >=20
> > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > > v10:
> > >  - Corrected THERMAL_MODE_BASIC_BALANCED -> THERMAL_MODE_BASIC_QUIET =
in
> > >    is_wmax_thermal_code() logic
> > >  - `thermal` and `gmode` quirks now have to be manually selected,
> > >    because not all Dell devices posses the new WMI thermal methods.
> > >  - Because of the above reason, errors in create_thermal_profile are =
now
> > >    propagated
> > > v9:
> > >  - Bool comparisons are now coherent with their type
> > > v8:
> > >  - Fixed alignment in wmax_mode_to_platform_profile[]
> > >  - Quirk thermal and gmode changed from u8 -> bool
> > >  - Autodetected quirk entries are not initialized
> > >  - is_wmax_thermal_code refactored to increase readibility
> > >  - is_wmax_thermal_code now covers all possibilities
> > >  - Better commit message
> > > v7:
> > >  - Method operations are now clearly listed as separate enums
> > >  - wmax_thermal_modes are now listed without codes in order to suppor=
t
> > >    autodetection, as well as getting and setting thermal profiles
> > >    cleanly through arrays
> > >  - Added wmax_mode_to_platform_profile[]
> > >  - Added struct wmax_u32_args to replace bit mask approach of
> > >    constructing arguments for wmax methods
> > >  - create_thermal_profile now autodetects available thermal codes
> > >    through operation 0x03 of THERMAL_INFORMATION method. These are
> > >    codes are stored in supported_thermal_profiles[]
> > >  - thermal_profile_get now uses wmax_mode_to_platform_profile[] inste=
ad of
> > >    switch-case approach
> > >  - thermal_profile_set now uses supported_thermal_profiles[] instead =
of
> > >    switch-case approach
> > >  - When gmode is autodetected, thermal_profile_set also sets Game Shi=
ft
> > >    status accordingly
> > > v6:
> > >  - Fixed alignment on some function definitions
> > >  - Fixed braces on if statment
> > >  - Removed quirk thermal_ustt
> > >  - Now quirk thermal can take values defined in enum WMAX_THERMAL_TAB=
LE.
> > >  - Proper removal of thermal_profile
> > > ---
> > >  drivers/platform/x86/dell/Kconfig         |   1 +
> > >  drivers/platform/x86/dell/alienware-wmi.c | 306 ++++++++++++++++++++=
++
> > >  2 files changed, 307 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86=
/dell/Kconfig
> > > index 68a49788a..b06d634cd 100644
> > > --- a/drivers/platform/x86/dell/Kconfig
> > > +++ b/drivers/platform/x86/dell/Kconfig
> > > @@ -21,6 +21,7 @@ config ALIENWARE_WMI
> > >  =09depends on LEDS_CLASS
> > >  =09depends on NEW_LEDS
> > >  =09depends on ACPI_WMI
> > > +=09select ACPI_PLATFORM_PROFILE
> > >  =09help
> > >  =09 This is a driver for controlling Alienware BIOS driven
> > >  =09 features.  It exposes an interface for controlling the AlienFX
> > > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/plat=
form/x86/dell/alienware-wmi.c
> > > index b27f3b64c..1d62c2ce7 100644
> > > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > > @@ -8,8 +8,11 @@
> > >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > =20
> > >  #include <linux/acpi.h>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > >  #include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/platform_profile.h>
> > >  #include <linux/dmi.h>
> > >  #include <linux/leds.h>
> > > =20
> > > @@ -25,6 +28,13 @@
> > >  #define WMAX_METHOD_AMPLIFIER_CABLE=090x6
> > >  #define WMAX_METHOD_DEEP_SLEEP_CONTROL=090x0B
> > >  #define WMAX_METHOD_DEEP_SLEEP_STATUS=090x0C
> > > +#define WMAX_METHOD_THERMAL_INFORMATION=090x14
> > > +#define WMAX_METHOD_THERMAL_CONTROL=090x15
> > > +#define WMAX_METHOD_GAME_SHIFT_STATUS=090x25
> > > +
> > > +#define WMAX_THERMAL_MODE_GMODE=09=090xAB
> > > +
> > > +#define WMAX_FAILURE_CODE=09=090xFFFFFFFF
> > > =20
> > >  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
> > >  MODULE_DESCRIPTION("Alienware special feature control");
> > > @@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
> > >  =09WMAX_SUSPEND =3D 3,
> > >  };
> > > =20
> > > +enum WMAX_THERMAL_INFORMATION_OPERATIONS {
> > > +=09WMAX_OPERATION_LIST_IDS=09=09=09=3D 0x03,
> > > +=09WMAX_OPERATION_CURRENT_PROFILE=09=09=3D 0x0B,
> > > +};
> > > +
> > > +enum WMAX_THERMAL_CONTROL_OPERATIONS {
> > > +=09WMAX_OPERATION_ACTIVATE_PROFILE=09=09=3D 0x01,
> > > +};
> > > +
> > > +enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
> > > +=09WMAX_OPERATION_TOGGLE_GAME_SHIFT=09=3D 0x01,
> > > +=09WMAX_OPERATION_GET_GAME_SHIFT_STATUS=09=3D 0x02,
> > > +};
> > > +
> > > +enum WMAX_THERMAL_TABLES {
> > > +=09WMAX_THERMAL_TABLE_BASIC=09=09=3D 0x90,
> > > +=09WMAX_THERMAL_TABLE_USTT=09=09=09=3D 0xA0,
> > > +};
> > > +
> > > +enum wmax_thermal_mode {
> > > +=09THERMAL_MODE_USTT_BALANCED,
> > > +=09THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
> > > +=09THERMAL_MODE_USTT_COOL,
> > > +=09THERMAL_MODE_USTT_QUIET,
> > > +=09THERMAL_MODE_USTT_PERFORMANCE,
> > > +=09THERMAL_MODE_USTT_LOW_POWER,
> > > +=09THERMAL_MODE_BASIC_QUIET,
> > > +=09THERMAL_MODE_BASIC_BALANCED,
> > > +=09THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
> > > +=09THERMAL_MODE_BASIC_PERFORMANCE,
> > > +=09THERMAL_MODE_LAST,
> > > +};
> > > +
> > > +static const enum platform_profile_option wmax_mode_to_platform_prof=
ile[THERMAL_MODE_LAST] =3D {
> > > +=09[THERMAL_MODE_USTT_BALANCED]=09=09=09=3D PLATFORM_PROFILE_BALANCE=
D,
> > > +=09[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]=09=3D PLATFORM_PROFILE_B=
ALANCED_PERFORMANCE,
> > > +=09[THERMAL_MODE_USTT_COOL]=09=09=09=3D PLATFORM_PROFILE_COOL,
> > > +=09[THERMAL_MODE_USTT_QUIET]=09=09=09=3D PLATFORM_PROFILE_QUIET,
> > > +=09[THERMAL_MODE_USTT_PERFORMANCE]=09=09=09=3D PLATFORM_PROFILE_PERF=
ORMANCE,
> > > +=09[THERMAL_MODE_USTT_LOW_POWER]=09=09=09=3D PLATFORM_PROFILE_LOW_PO=
WER,
> > > +=09[THERMAL_MODE_BASIC_QUIET]=09=09=09=3D PLATFORM_PROFILE_QUIET,
> > > +=09[THERMAL_MODE_BASIC_BALANCED]=09=09=09=3D PLATFORM_PROFILE_BALANC=
ED,
> > > +=09[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]=09=3D PLATFORM_PROFILE_=
BALANCED_PERFORMANCE,
> > > +=09[THERMAL_MODE_BASIC_PERFORMANCE]=09=09=3D PLATFORM_PROFILE_PERFOR=
MANCE,
> > > +};
> > > +
> > >  struct quirk_entry {
> > >  =09u8 num_zones;
> > >  =09u8 hdmi_mux;
> > >  =09u8 amplifier;
> > >  =09u8 deepslp;
> > > +=09bool thermal;
> > > +=09bool gmode;
> > >  };
> > > =20
> > >  static struct quirk_entry *quirks;
> > > @@ -64,6 +122,8 @@ static struct quirk_entry quirk_inspiron5675 =3D {
> > >  =09.hdmi_mux =3D 0,
> > >  =09.amplifier =3D 0,
> > >  =09.deepslp =3D 0,
> > > +=09.thermal =3D false,
> > > +=09.gmode =3D false,
> > >  };
> > > =20
> > >  static struct quirk_entry quirk_unknown =3D {
> > > @@ -71,6 +131,8 @@ static struct quirk_entry quirk_unknown =3D {
> > >  =09.hdmi_mux =3D 0,
> > >  =09.amplifier =3D 0,
> > >  =09.deepslp =3D 0,
> > > +=09.thermal =3D false,
> > > +=09.gmode =3D false,
> > >  };
> > > =20
> > >  static struct quirk_entry quirk_x51_r1_r2 =3D {
> > > @@ -78,6 +140,8 @@ static struct quirk_entry quirk_x51_r1_r2 =3D {
> > >  =09.hdmi_mux =3D 0,
> > >  =09.amplifier =3D 0,
> > >  =09.deepslp =3D 0,
> > > +=09.thermal =3D false,
> > > +=09.gmode =3D false,
> > >  };
> > > =20
> > >  static struct quirk_entry quirk_x51_r3 =3D {
> > > @@ -85,6 +149,8 @@ static struct quirk_entry quirk_x51_r3 =3D {
> > >  =09.hdmi_mux =3D 0,
> > >  =09.amplifier =3D 1,
> > >  =09.deepslp =3D 0,
> > > +=09.thermal =3D false,
> > > +=09.gmode =3D false,
> > >  };
> > > =20
> > >  static struct quirk_entry quirk_asm100 =3D {
> > > @@ -92,6 +158,8 @@ static struct quirk_entry quirk_asm100 =3D {
> > >  =09.hdmi_mux =3D 1,
> > >  =09.amplifier =3D 0,
> > >  =09.deepslp =3D 0,
> > > +=09.thermal =3D false,
> > > +=09.gmode =3D false,
> > >  };
> > > =20
> > >  static struct quirk_entry quirk_asm200 =3D {
> > > @@ -99,6 +167,8 @@ static struct quirk_entry quirk_asm200 =3D {
> > >  =09.hdmi_mux =3D 1,
> > >  =09.amplifier =3D 0,
> > >  =09.deepslp =3D 1,
> > > +=09.thermal =3D false,
> > > +=09.gmode =3D false,
> > >  };
> > > =20
> > >  static struct quirk_entry quirk_asm201 =3D {
> > > @@ -106,6 +176,17 @@ static struct quirk_entry quirk_asm201 =3D {
> > >  =09.hdmi_mux =3D 1,
> > >  =09.amplifier =3D 1,
> > >  =09.deepslp =3D 1,
> > > +=09.thermal =3D false,
> > > +=09.gmode =3D false,
> > > +};
> > > +
> > > +static struct quirk_entry quirk_x_series =3D {
> > > +=09.num_zones =3D 2,
> > > +=09.hdmi_mux =3D 0,
> > > +=09.amplifier =3D 0,
> > > +=09.deepslp =3D 0,
> > > +=09.thermal =3D true,
> > > +=09.gmode =3D false,
> > >  };
> >=20
> > So now gmode is always false unless the module parameter from patch 4 i=
s=20
> > given?
>=20
> G-Series laptops can also register a quirk_entry with gmode set in the
> future. I can do it ahead of time, but I don't have a G-Series laptop to
> test it.

Understood. I'm fine with this in the current form if it's fine for Armin=
=20
too.

--=20
 i.
--8323328-146057457-1730221521=:951--

