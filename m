Return-Path: <linux-kernel+bounces-387237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B73FF9B4E56
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772DB28351B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32EC194C86;
	Tue, 29 Oct 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6WTzwZ5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9C194AD6;
	Tue, 29 Oct 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216656; cv=none; b=ZfXMO3knQ4G39W+CeuLSgEYzfUeI+rmeRdYTlcqYAsY6zKTbIsW8COCO3DpuFnEQA/0MeJfcCubPd4jFhPOBsfaz+QnYl7GSyinFK5r10qwGKYb5QklkXrpb8IFo2Sn/HZKSLcTdssQ2jH3ZqlOglCd9KZNb2kjymPWIgu5tY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216656; c=relaxed/simple;
	bh=nmy5s3zv0/z2BAjom6ZfBqtq4TbyyLclyHG6cYUimtI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hGyQ3gTe3FxTSxZhmYW0y7F+AaHt0Rua4HNwpgrjtuV9GQ4Wg4fXtxGfoAeIsIvbu/fLo+RY1WOXxL9hGhUvdl8GsoOIEMA0Dn6HzfkHrbYw+Acj6PpkCpYuQka13eTGO8CcGe76qfT+2+FdJhptutfq7Psr0PF2Wb+/TuPuDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6WTzwZ5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730216654; x=1761752654;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nmy5s3zv0/z2BAjom6ZfBqtq4TbyyLclyHG6cYUimtI=;
  b=l6WTzwZ5qZoJFvrx3POiDjVxECEN5gxV4yWxRLkExIOEDhMMIMmcb8n6
   fKd+CJcY4YUF3z2dvMMci8OPWQ4n0o1LVNFVyu/QOXt5uMQWjOlFcUGo2
   sDD0U+saYDUcnXumRT6h824TwfZdTmUucSsJ7h4VRmIRcDB8oTjDHXfKC
   GbcryMkq+Ne8qPEoXLkLiRWC9K6i8CtTDTDtlh4XwvOD+uPaC5uMU3MzC
   hs3JF8AxvdTsLzAort21edwpbirpM0oXcNe2RLKwEyj2ZCCl66NQ9qUUp
   wBQdbkm69dBmLtt0OIIRvOWhb9nQhhJZ57xx1StgjW/m/wvsRiNUgFlJu
   A==;
X-CSE-ConnectionGUID: n7GKcSDjSh+sJppNIM4CKQ==
X-CSE-MsgGUID: eb7cwYM7QceqwB9NfqI7og==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="47349067"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="47349067"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:44:11 -0700
X-CSE-ConnectionGUID: rjwNP3i2QvqVQJ+/shsHHg==
X-CSE-MsgGUID: EI9xok8kSGmFBhJ2soBq+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82810452"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:44:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 17:44:05 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v10 3/5] alienware-wmi: added platform profile support
In-Reply-To: <20241029135341.5906-1-kuurtb@gmail.com>
Message-ID: <9caaa4f1-9605-da2a-9afd-8f40ed33719f@linux.intel.com>
References: <20241029135107.5582-2-kuurtb@gmail.com> <20241029135341.5906-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1073594778-1730216645=:951"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1073594778-1730216645=:951
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 29 Oct 2024, Kurt Borja wrote:

> Implements platform profile support for Dell laptops with new WMAX therma=
l
> interface, present on some Alienware X-Series, Alienware M-Series and
> Dell's G-Series laptops. This interface is suspected to be used by
> Alienware Command Center (AWCC), which is not available for linux
> systems, to manage thermal profiles.
>=20
> This implementation makes use of three WMI methods, namely
> THERMAL_CONTROL, THERMAL_INFORMATION and GAME_SHIFT_STATUS, which take
> u32 as input and output arguments. Each method has a set of supported
> operations specified in their respective enums.
>=20
> Not all models with WMAX WMI interface support these methods. Because of
> this, models have to manually declare support through new quirks
> `thermal` for THERMAL_CONTROL and THERMAL_INFORMATION and `gmode` for
> GAME_SHIFT_STATUS.
>=20
> Wrappers written for these methods support multiple operations.
>=20
> THERMAL_CONTROL switches thermal modes through operation
> ACTIVATE_PROFILE. Available thermal codes are auto-detected at runtime
> and matched against a list of known thermal codes:
>=20
> Thermal Table "User Selectable Thermal Tables" (USTT):
> =09BALANCED=09=09=090xA0
> =09BALANCED_PERFORMANCE=09=090xA1
> =09COOL=09=09=09=090xA2
> =09QUIET=09=09=09=090xA3
> =09PERFORMANCE=09=09=090xA4
> =09LOW_POWER=09=09=090xA5
>=20
> Thermal Table Basic:
> =09QUIET=09=09=09=090x96
> =09BALANCED=09=09=090x97
> =09BALANCED_PERFORMANCE=09=090x98
> =09PERFORMANCE=09=09=090x99
>=20
> Devices are known to implement only one of these tables without mixing
> their thermal codes.
>=20
> The fact that the least significant digit of every thermal code is
> consecutive of one another is exploited to efficiently match codes
> through arrays.
>=20
> Autodetection of available codes is done through operation LIST_IDS of
> method THERMAL_INFORMATION. This operation lists fan IDs, CPU sensor ID,
> GPU sensor ID and available thermal profile codes, *in that order*. As
> number of fans and thermal codes is very model dependent, almost every
> ID is scanned and matched based on conditions found on
> is_wmax_thermal_code(). The known upper bound for the number of IDs is
> 13, corresponding to a device that have 4 fans, 2 sensors and 7 thermal
> codes.
>=20
> Additionally G-Series laptops have a key called G-key, which (with AWCC
> proprietary driver) switches the thermal mode to an special mode named
> GMODE with code 0xAB and changes Game Shift Status to 1. Game Shift is a
> mode the manufacturer claims, increases gaming performance.
>=20
> GAME_SHIFT_STATUS method is used to mimic this behavior when selecting
> PLATFORM_PROFILE_PERFORMANCE option.
>=20
> All of these profiles are known to only change fan speed profiles,
> although there are untested claims that some of them also change power
> profiles.
>=20
> Activating a thermal mode with method THERMAL_CONTROL may cause short
> hangs. This is a known problem present on every platform.
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v10:
>  - Corrected THERMAL_MODE_BASIC_BALANCED -> THERMAL_MODE_BASIC_QUIET in
>    is_wmax_thermal_code() logic
>  - `thermal` and `gmode` quirks now have to be manually selected,
>    because not all Dell devices posses the new WMI thermal methods.
>  - Because of the above reason, errors in create_thermal_profile are now
>    propagated
> v9:
>  - Bool comparisons are now coherent with their type
> v8:
>  - Fixed alignment in wmax_mode_to_platform_profile[]
>  - Quirk thermal and gmode changed from u8 -> bool
>  - Autodetected quirk entries are not initialized
>  - is_wmax_thermal_code refactored to increase readibility
>  - is_wmax_thermal_code now covers all possibilities
>  - Better commit message
> v7:
>  - Method operations are now clearly listed as separate enums
>  - wmax_thermal_modes are now listed without codes in order to support
>    autodetection, as well as getting and setting thermal profiles
>    cleanly through arrays
>  - Added wmax_mode_to_platform_profile[]
>  - Added struct wmax_u32_args to replace bit mask approach of
>    constructing arguments for wmax methods
>  - create_thermal_profile now autodetects available thermal codes
>    through operation 0x03 of THERMAL_INFORMATION method. These are
>    codes are stored in supported_thermal_profiles[]
>  - thermal_profile_get now uses wmax_mode_to_platform_profile[] instead o=
f
>    switch-case approach
>  - thermal_profile_set now uses supported_thermal_profiles[] instead of
>    switch-case approach
>  - When gmode is autodetected, thermal_profile_set also sets Game Shift
>    status accordingly
> v6:
>  - Fixed alignment on some function definitions
>  - Fixed braces on if statment
>  - Removed quirk thermal_ustt
>  - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE.
>  - Proper removal of thermal_profile
> ---
>  drivers/platform/x86/dell/Kconfig         |   1 +
>  drivers/platform/x86/dell/alienware-wmi.c | 306 ++++++++++++++++++++++
>  2 files changed, 307 insertions(+)
>=20
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/del=
l/Kconfig
> index 68a49788a..b06d634cd 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -21,6 +21,7 @@ config ALIENWARE_WMI
>  =09depends on LEDS_CLASS
>  =09depends on NEW_LEDS
>  =09depends on ACPI_WMI
> +=09select ACPI_PLATFORM_PROFILE
>  =09help
>  =09 This is a driver for controlling Alienware BIOS driven
>  =09 features.  It exposes an interface for controlling the AlienFX
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform=
/x86/dell/alienware-wmi.c
> index b27f3b64c..1d62c2ce7 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -8,8 +8,11 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>  #include <linux/dmi.h>
>  #include <linux/leds.h>
> =20
> @@ -25,6 +28,13 @@
>  #define WMAX_METHOD_AMPLIFIER_CABLE=090x6
>  #define WMAX_METHOD_DEEP_SLEEP_CONTROL=090x0B
>  #define WMAX_METHOD_DEEP_SLEEP_STATUS=090x0C
> +#define WMAX_METHOD_THERMAL_INFORMATION=090x14
> +#define WMAX_METHOD_THERMAL_CONTROL=090x15
> +#define WMAX_METHOD_GAME_SHIFT_STATUS=090x25
> +
> +#define WMAX_THERMAL_MODE_GMODE=09=090xAB
> +
> +#define WMAX_FAILURE_CODE=09=090xFFFFFFFF
> =20
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>  MODULE_DESCRIPTION("Alienware special feature control");
> @@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
>  =09WMAX_SUSPEND =3D 3,
>  };
> =20
> +enum WMAX_THERMAL_INFORMATION_OPERATIONS {
> +=09WMAX_OPERATION_LIST_IDS=09=09=09=3D 0x03,
> +=09WMAX_OPERATION_CURRENT_PROFILE=09=09=3D 0x0B,
> +};
> +
> +enum WMAX_THERMAL_CONTROL_OPERATIONS {
> +=09WMAX_OPERATION_ACTIVATE_PROFILE=09=09=3D 0x01,
> +};
> +
> +enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
> +=09WMAX_OPERATION_TOGGLE_GAME_SHIFT=09=3D 0x01,
> +=09WMAX_OPERATION_GET_GAME_SHIFT_STATUS=09=3D 0x02,
> +};
> +
> +enum WMAX_THERMAL_TABLES {
> +=09WMAX_THERMAL_TABLE_BASIC=09=09=3D 0x90,
> +=09WMAX_THERMAL_TABLE_USTT=09=09=09=3D 0xA0,
> +};
> +
> +enum wmax_thermal_mode {
> +=09THERMAL_MODE_USTT_BALANCED,
> +=09THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
> +=09THERMAL_MODE_USTT_COOL,
> +=09THERMAL_MODE_USTT_QUIET,
> +=09THERMAL_MODE_USTT_PERFORMANCE,
> +=09THERMAL_MODE_USTT_LOW_POWER,
> +=09THERMAL_MODE_BASIC_QUIET,
> +=09THERMAL_MODE_BASIC_BALANCED,
> +=09THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
> +=09THERMAL_MODE_BASIC_PERFORMANCE,
> +=09THERMAL_MODE_LAST,
> +};
> +
> +static const enum platform_profile_option wmax_mode_to_platform_profile[=
THERMAL_MODE_LAST] =3D {
> +=09[THERMAL_MODE_USTT_BALANCED]=09=09=09=3D PLATFORM_PROFILE_BALANCED,
> +=09[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]=09=3D PLATFORM_PROFILE_BALAN=
CED_PERFORMANCE,
> +=09[THERMAL_MODE_USTT_COOL]=09=09=09=3D PLATFORM_PROFILE_COOL,
> +=09[THERMAL_MODE_USTT_QUIET]=09=09=09=3D PLATFORM_PROFILE_QUIET,
> +=09[THERMAL_MODE_USTT_PERFORMANCE]=09=09=09=3D PLATFORM_PROFILE_PERFORMA=
NCE,
> +=09[THERMAL_MODE_USTT_LOW_POWER]=09=09=09=3D PLATFORM_PROFILE_LOW_POWER,
> +=09[THERMAL_MODE_BASIC_QUIET]=09=09=09=3D PLATFORM_PROFILE_QUIET,
> +=09[THERMAL_MODE_BASIC_BALANCED]=09=09=09=3D PLATFORM_PROFILE_BALANCED,
> +=09[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]=09=3D PLATFORM_PROFILE_BALA=
NCED_PERFORMANCE,
> +=09[THERMAL_MODE_BASIC_PERFORMANCE]=09=09=3D PLATFORM_PROFILE_PERFORMANC=
E,
> +};
> +
>  struct quirk_entry {
>  =09u8 num_zones;
>  =09u8 hdmi_mux;
>  =09u8 amplifier;
>  =09u8 deepslp;
> +=09bool thermal;
> +=09bool gmode;
>  };
> =20
>  static struct quirk_entry *quirks;
> @@ -64,6 +122,8 @@ static struct quirk_entry quirk_inspiron5675 =3D {
>  =09.hdmi_mux =3D 0,
>  =09.amplifier =3D 0,
>  =09.deepslp =3D 0,
> +=09.thermal =3D false,
> +=09.gmode =3D false,
>  };
> =20
>  static struct quirk_entry quirk_unknown =3D {
> @@ -71,6 +131,8 @@ static struct quirk_entry quirk_unknown =3D {
>  =09.hdmi_mux =3D 0,
>  =09.amplifier =3D 0,
>  =09.deepslp =3D 0,
> +=09.thermal =3D false,
> +=09.gmode =3D false,
>  };
> =20
>  static struct quirk_entry quirk_x51_r1_r2 =3D {
> @@ -78,6 +140,8 @@ static struct quirk_entry quirk_x51_r1_r2 =3D {
>  =09.hdmi_mux =3D 0,
>  =09.amplifier =3D 0,
>  =09.deepslp =3D 0,
> +=09.thermal =3D false,
> +=09.gmode =3D false,
>  };
> =20
>  static struct quirk_entry quirk_x51_r3 =3D {
> @@ -85,6 +149,8 @@ static struct quirk_entry quirk_x51_r3 =3D {
>  =09.hdmi_mux =3D 0,
>  =09.amplifier =3D 1,
>  =09.deepslp =3D 0,
> +=09.thermal =3D false,
> +=09.gmode =3D false,
>  };
> =20
>  static struct quirk_entry quirk_asm100 =3D {
> @@ -92,6 +158,8 @@ static struct quirk_entry quirk_asm100 =3D {
>  =09.hdmi_mux =3D 1,
>  =09.amplifier =3D 0,
>  =09.deepslp =3D 0,
> +=09.thermal =3D false,
> +=09.gmode =3D false,
>  };
> =20
>  static struct quirk_entry quirk_asm200 =3D {
> @@ -99,6 +167,8 @@ static struct quirk_entry quirk_asm200 =3D {
>  =09.hdmi_mux =3D 1,
>  =09.amplifier =3D 0,
>  =09.deepslp =3D 1,
> +=09.thermal =3D false,
> +=09.gmode =3D false,
>  };
> =20
>  static struct quirk_entry quirk_asm201 =3D {
> @@ -106,6 +176,17 @@ static struct quirk_entry quirk_asm201 =3D {
>  =09.hdmi_mux =3D 1,
>  =09.amplifier =3D 1,
>  =09.deepslp =3D 1,
> +=09.thermal =3D false,
> +=09.gmode =3D false,
> +};
> +
> +static struct quirk_entry quirk_x_series =3D {
> +=09.num_zones =3D 2,
> +=09.hdmi_mux =3D 0,
> +=09.amplifier =3D 0,
> +=09.deepslp =3D 0,
> +=09.thermal =3D true,
> +=09.gmode =3D false,
>  };

So now gmode is always false unless the module parameter from patch 4 is=20
given?

--
 i.

>  static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -178,6 +259,15 @@ static const struct dmi_system_id alienware_quirks[]=
 __initconst =3D {
>  =09=09},
>  =09=09.driver_data =3D &quirk_inspiron5675,
>  =09},
> +=09{
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Alienware x15 R1",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_x_series,
> +=09},
>  =09{}
>  };
> =20
> @@ -214,10 +304,19 @@ struct wmax_led_args {
>  =09u8 state;
>  } __packed;
> =20
> +struct wmax_u32_args {
> +=09u8 operation;
> +=09u8 arg1;
> +=09u8 arg2;
> +=09u8 arg3;
> +};
> +
>  static struct platform_device *platform_device;
>  static struct device_attribute *zone_dev_attrs;
>  static struct attribute **zone_attrs;
>  static struct platform_zone *zone_data;
> +static struct platform_profile_handler pp_handler;
> +static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFIL=
E_LAST];
> =20
>  static struct platform_driver platform_driver =3D {
>  =09.driver =3D {
> @@ -761,6 +860,204 @@ static int create_deepsleep(struct platform_device =
*dev)
>  =09return ret;
>  }
> =20
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
> +#define WMAX_THERMAL_TABLE_MASK=09=09GENMASK(7, 4)
> +#define WMAX_THERMAL_MODE_MASK=09=09GENMASK(3, 0)
> +#define WMAX_SENSOR_ID_MASK=09=09BIT(8)
> +
> +static bool is_wmax_thermal_code(u32 code)
> +{
> +=09if (code & WMAX_SENSOR_ID_MASK)
> +=09=09return false;
> +
> +=09if ((code & WMAX_THERMAL_MODE_MASK) >=3D THERMAL_MODE_LAST)
> +=09=09return false;
> +
> +=09if ((code & WMAX_THERMAL_TABLE_MASK) =3D=3D WMAX_THERMAL_TABLE_BASIC =
&&
> +=09    (code & WMAX_THERMAL_MODE_MASK) >=3D THERMAL_MODE_BASIC_QUIET)
> +=09=09return true;
> +
> +=09if ((code & WMAX_THERMAL_TABLE_MASK) =3D=3D WMAX_THERMAL_TABLE_USTT &=
&
> +=09    (code & WMAX_THERMAL_MODE_MASK) <=3D THERMAL_MODE_USTT_LOW_POWER)
> +=09=09return true;
> +
> +=09return false;
> +}
> +
> +static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data)
> +{
> +=09acpi_status status;
> +=09struct wmax_u32_args in_args =3D {
> +=09=09.operation =3D operation,
> +=09=09.arg1 =3D arg,
> +=09=09.arg2 =3D 0,
> +=09=09.arg3 =3D 0,
> +=09};
> +
> +=09status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +=09=09=09=09=09WMAX_METHOD_THERMAL_INFORMATION,
> +=09=09=09=09=09out_data);
> +
> +=09if (ACPI_FAILURE(status))
> +=09=09return -EIO;
> +
> +=09if (*out_data =3D=3D WMAX_FAILURE_CODE)
> +=09=09return -EBADRQC;
> +
> +=09return 0;
> +}
> +
> +static int wmax_thermal_control(u8 profile)
> +{
> +=09acpi_status status;
> +=09struct wmax_u32_args in_args =3D {
> +=09=09.operation =3D WMAX_OPERATION_ACTIVATE_PROFILE,
> +=09=09.arg1 =3D profile,
> +=09=09.arg2 =3D 0,
> +=09=09.arg3 =3D 0,
> +=09};
> +=09u32 out_data;
> +
> +=09status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +=09=09=09=09=09WMAX_METHOD_THERMAL_CONTROL,
> +=09=09=09=09=09&out_data);
> +
> +=09if (ACPI_FAILURE(status))
> +=09=09return -EIO;
> +
> +=09if (out_data =3D=3D WMAX_FAILURE_CODE)
> +=09=09return -EBADRQC;
> +
> +=09return 0;
> +}
> +
> +static int wmax_game_shift_status(u8 operation, u32 *out_data)
> +{
> +=09acpi_status status;
> +=09struct wmax_u32_args in_args =3D {
> +=09=09.operation =3D operation,
> +=09=09.arg1 =3D 0,
> +=09=09.arg2 =3D 0,
> +=09=09.arg3 =3D 0,
> +=09};
> +
> +=09status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +=09=09=09=09=09WMAX_METHOD_GAME_SHIFT_STATUS,
> +=09=09=09=09=09out_data);
> +
> +=09if (ACPI_FAILURE(status))
> +=09=09return -EIO;
> +
> +=09if (*out_data =3D=3D WMAX_FAILURE_CODE)
> +=09=09return -EOPNOTSUPP;
> +
> +=09return 0;
> +}
> +
> +static int thermal_profile_get(struct platform_profile_handler *pprof,
> +=09=09=09       enum platform_profile_option *profile)
> +{
> +=09u32 out_data;
> +=09int ret;
> +
> +=09ret =3D wmax_thermal_information(WMAX_OPERATION_CURRENT_PROFILE,
> +=09=09=09=09       0, &out_data);
> +
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09if (out_data =3D=3D WMAX_THERMAL_MODE_GMODE) {
> +=09=09*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +=09=09return 0;
> +=09}
> +
> +=09if (!is_wmax_thermal_code(out_data))
> +=09=09return -ENODATA;
> +
> +=09out_data &=3D WMAX_THERMAL_MODE_MASK;
> +=09*profile =3D wmax_mode_to_platform_profile[out_data];
> +
> +=09return 0;
> +}
> +
> +static int thermal_profile_set(struct platform_profile_handler *pprof,
> +=09=09=09       enum platform_profile_option profile)
> +{
> +=09if (quirks->gmode) {
> +=09=09u32 gmode_status;
> +=09=09int ret;
> +
> +=09=09ret =3D wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATU=
S,
> +=09=09=09=09=09     &gmode_status);
> +
> +=09=09if (ret < 0)
> +=09=09=09return ret;
> +
> +=09=09if ((profile =3D=3D PLATFORM_PROFILE_PERFORMANCE && !gmode_status)=
 ||
> +=09=09    (profile !=3D PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
> +=09=09=09ret =3D wmax_game_shift_status(WMAX_OPERATION_TOGGLE_GAME_SHIFT=
,
> +=09=09=09=09=09=09     &gmode_status);
> +
> +=09=09=09if (ret < 0)
> +=09=09=09=09return ret;
> +=09=09}
> +=09}
> +
> +=09return wmax_thermal_control(supported_thermal_profiles[profile]);
> +}
> +
> +static int create_thermal_profile(void)
> +{
> +=09u32 out_data;
> +=09enum wmax_thermal_mode mode;
> +=09enum platform_profile_option profile;
> +=09int ret;
> +
> +=09for (u8 i =3D 0x2; i <=3D 0xD; i++) {
> +=09=09ret =3D wmax_thermal_information(WMAX_OPERATION_LIST_IDS,
> +=09=09=09=09=09       i, &out_data);
> +
> +=09=09if (ret =3D=3D -EIO)
> +=09=09=09return ret;
> +
> +=09=09if (ret =3D=3D -EBADRQC)
> +=09=09=09break;
> +
> +=09=09if (!is_wmax_thermal_code(out_data))
> +=09=09=09continue;
> +
> +=09=09mode =3D out_data & WMAX_THERMAL_MODE_MASK;
> +=09=09profile =3D wmax_mode_to_platform_profile[mode];
> +=09=09supported_thermal_profiles[profile] =3D out_data;
> +
> +=09=09set_bit(profile, pp_handler.choices);
> +=09}
> +
> +=09if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> +=09=09return -ENODEV;
> +
> +=09if (quirks->gmode) {
> +=09=09supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
> +=09=09=09WMAX_THERMAL_MODE_GMODE;
> +
> +=09=09set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +=09}
> +
> +=09pp_handler.profile_get =3D thermal_profile_get;
> +=09pp_handler.profile_set =3D thermal_profile_set;
> +
> +=09return platform_profile_register(&pp_handler);
> +}
> +
> +static void remove_thermal_profile(void)
> +{
> +=09if (quirks->thermal)
> +=09=09platform_profile_remove();
> +}
> +
>  static int __init alienware_wmi_init(void)
>  {
>  =09int ret;
> @@ -808,6 +1105,12 @@ static int __init alienware_wmi_init(void)
>  =09=09=09goto fail_prep_deepsleep;
>  =09}
> =20
> +=09if (quirks->thermal) {
> +=09=09ret =3D create_thermal_profile();
> +=09=09if (ret)
> +=09=09=09goto fail_prep_thermal_profile;
> +=09}
> +
>  =09ret =3D alienware_zone_init(platform_device);
>  =09if (ret)
>  =09=09goto fail_prep_zones;
> @@ -816,6 +1119,8 @@ static int __init alienware_wmi_init(void)
> =20
>  fail_prep_zones:
>  =09alienware_zone_exit(platform_device);
> +=09remove_thermal_profile();
> +fail_prep_thermal_profile:
>  fail_prep_deepsleep:
>  fail_prep_amplifier:
>  fail_prep_hdmi:
> @@ -835,6 +1140,7 @@ static void __exit alienware_wmi_exit(void)
>  =09if (platform_device) {
>  =09=09alienware_zone_exit(platform_device);
>  =09=09remove_hdmi(platform_device);
> +=09=09remove_thermal_profile();
>  =09=09platform_device_unregister(platform_device);
>  =09=09platform_driver_unregister(&platform_driver);
>  =09}
>=20
--8323328-1073594778-1730216645=:951--

