Return-Path: <linux-kernel+bounces-544972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D14A4E734
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E704E19C5010
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD727BF92;
	Tue,  4 Mar 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E51xbQYb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217627BF90;
	Tue,  4 Mar 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105875; cv=none; b=golZGGEuQ2soIciPKuiT/3CqFU0pzxhSa5I/RLqD0zl6AhTb9XpVkpW8SOFmWMQ14aAn9hzLmcBzZNZB2O/zoIY3wQKIL/pQ4nOyxj3V9uSfpctoOlvQIGh869OoAcoxx8FfrKJHqiO+/GF++9UEWsFC7ryVA3SkyhMAumUs/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105875; c=relaxed/simple;
	bh=/YJ9yPU9Qot21uQi+eiSh1qLYYbIQ5QG7UZGe0XhN0E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r57hZ/aqzHPGsstulHc2SFbWYZs3yO/Hyn8P0cpkB3g376w5M6EsgEOD1DIBZrlFde/4ql6SqIf8QoUDiw8on506PqHYdwAaDR0IzKnd5oXkZ6j4KkeycGFZlYSODlM6JBgqrDIc9355EscvNEgGyhm+ExV16AbZhsW1Vf5tpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E51xbQYb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741105874; x=1772641874;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/YJ9yPU9Qot21uQi+eiSh1qLYYbIQ5QG7UZGe0XhN0E=;
  b=E51xbQYb9DZDoLod9sYltkDs4VxZWH0Bi+BVViPMsJnmot4UMvN9lu0L
   riyoSgksmJQD125D8hHHWDTROCKss+zSBQ5QwXDrhPdR0krRJYsDV+Whx
   /W21pmbdsqH+l8B4fYV8wwCbHnM9TnobhpB1DGG69tFPOHZ2bxgCuX/Jo
   cDhgv08pO3O1ZHeHO5113jWkHX5KKfes8QDfw1lg2XfYIUxQC7lARzGN4
   chFjy+K0D8VB2ezpDZQWwWF7R31dqLTnksMwTFnDt6KA/qy3iQPOSfrq9
   YYCC6fAK32viOl4OYgyVZecGtQm/Ks0cKAoetmB74jxKbL5URQyB7XF6C
   g==;
X-CSE-ConnectionGUID: Ib266fKyQ7S++eHPqx5Tzg==
X-CSE-MsgGUID: h1Zo8rVVR1emVVPgsK1kWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41745790"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41745790"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:31:13 -0800
X-CSE-ConnectionGUID: U6WujrHUTP6r995x93RaWQ==
X-CSE-MsgGUID: LeDlO4+iTVeu+Qc+YjpJDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123349493"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:31:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 18:31:06 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, Dell.Client.Kernel@dell.com, 
    LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
In-Reply-To: <D87MG1SMP0WA.1EXT0WKP65DQR@gmail.com>
Message-ID: <93a4ce49-1d16-4569-8b4b-554bf26a002a@linux.intel.com>
References: <20250225222500.23535-1-kuurtb@gmail.com> <20250225222500.23535-8-kuurtb@gmail.com> <a85825d5-7718-93f4-e837-849323ef4387@linux.intel.com> <D87MG1SMP0WA.1EXT0WKP65DQR@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1823786508-1741105866=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1823786508-1741105866=:931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Mar 2025, Kurt Borja wrote:

> On Tue Mar 4, 2025 at 10:53 AM -05, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 25 Feb 2025, Kurt Borja wrote:
> >
> >> All models with the "AWCC" WMAX device support monitoring fan speed an=
d
> >> temperature sensors. Expose this feature through the HWMON interface.
> >>=20
> >> Sensor readings are cached for 1 second before refreshing them to
> >> mitigate the performance cost of calling WMI methods.
> >>=20
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> >> ---
> >>  drivers/platform/x86/dell/Kconfig             |   1 +
> >>  .../platform/x86/dell/alienware-wmi-wmax.c    | 403 +++++++++++++++++=
+
> >>  2 files changed, 404 insertions(+)
> >>=20
> >> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/=
dell/Kconfig
> >> index f8a0dffcaab7..85a57c01aaad 100644
> >> --- a/drivers/platform/x86/dell/Kconfig
> >> +++ b/drivers/platform/x86/dell/Kconfig
> >> @@ -43,6 +43,7 @@ config ALIENWARE_WMI_WMAX
> >>  =09bool "Alienware WMAX WMI device driver"
> >>  =09default y
> >>  =09depends on ALIENWARE_WMI
> >> +=09depends on HWMON
> >>  =09select ACPI_PLATFORM_PROFILE
> >>  =09help
> >>  =09 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep slee=
p and
> >> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/=
platform/x86/dell/alienware-wmi-wmax.c
> >> index bbe87f91fcb6..818023a5b205 100644
> >> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> >> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> >> @@ -9,10 +9,13 @@
> >>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >> =20
> >>  #include <linux/bitfield.h>
> >> +#include <linux/bitmap.h>
> >>  #include <linux/bits.h>
> >>  #include <linux/dmi.h>
> >> +#include <linux/hwmon.h>
> >>  #include <linux/moduleparam.h>
> >>  #include <linux/platform_profile.h>
> >> +#include <linux/units.h>
> >>  #include <linux/wmi.h>
> >>  #include "alienware-wmi.h"
> >> =20
> >> @@ -25,6 +28,7 @@
> >>  #define WMAX_METHOD_BRIGHTNESS=09=09=090x3
> >>  #define WMAX_METHOD_ZONE_CONTROL=09=090x4
> >> =20
> >> +#define AWCC_METHOD_GET_FAN_SENSORS=09=090x13
> >>  #define AWCC_METHOD_THERMAL_INFORMATION=09=090x14
> >>  #define AWCC_METHOD_THERMAL_CONTROL=09=090x15
> >>  #define AWCC_METHOD_GAME_SHIFT_STATUS=09=090x25
> >> @@ -38,6 +42,10 @@
> >>  /* Arbitrary limit based on supported models */
> >>  #define AWCC_MAX_RES_COUNT=09=09=0916
> >> =20
> >> +static bool force_hwmon;
> >> +module_param_unsafe(force_hwmon, bool, 0);
> >> +MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support withou=
t checking if the WMI backend is available");
> >> +
> >>  static bool force_platform_profile;
> >>  module_param_unsafe(force_platform_profile, bool, 0);
> >>  MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting therm=
al profiles without checking if WMI thermal backend is available");
> >> @@ -47,16 +55,19 @@ module_param_unsafe(force_gmode, bool, 0);
> >>  MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile=
 is selected");
> >> =20
> >>  struct awcc_quirks {
> >> +=09bool hwmon;
> >>  =09bool pprof;
> >>  =09bool gmode;
> >>  };
> >> =20
> >>  static struct awcc_quirks g_series_quirks =3D {
> >> +=09.hwmon =3D true,
> >>  =09.pprof =3D true,
> >>  =09.gmode =3D true,
> >>  };
> >> =20
> >>  static struct awcc_quirks generic_quirks =3D {
> >> +=09.hwmon =3D true,
> >>  =09.pprof =3D true,
> >>  =09.gmode =3D false,
> >>  };
> >> @@ -154,9 +165,18 @@ static const struct dmi_system_id awcc_dmi_table[=
] __initconst =3D {
> >>  =09},
> >>  };
> >> =20
> >> +enum AWCC_GET_FAN_SENSORS_OPERATIONS {
> >> +=09AWCC_OP_GET_TOTAL_FAN_TEMPS=09=09=3D 0x01,
> >> +=09AWCC_OP_GET_FAN_TEMP_ID=09=09=09=3D 0x02,
> >> +};
> >> +
> >>  enum AWCC_THERMAL_INFORMATION_OPERATIONS {
> >>  =09AWCC_OP_GET_SYSTEM_DESCRIPTION=09=09=3D 0x02,
> >>  =09AWCC_OP_GET_RESOURCE_ID=09=09=09=3D 0x03,
> >> +=09AWCC_OP_GET_TEMPERATURE=09=09=09=3D 0x04,
> >> +=09AWCC_OP_GET_FAN_RPM=09=09=09=3D 0x05,
> >> +=09AWCC_OP_GET_FAN_MIN_RPM=09=09=09=3D 0x08,
> >> +=09AWCC_OP_GET_FAN_MAX_RPM=09=09=09=3D 0x09,
> >>  =09AWCC_OP_GET_CURRENT_PROFILE=09=09=3D 0x0B,
> >>  };
> >> =20
> >> @@ -179,6 +199,12 @@ enum AWCC_SPECIAL_THERMAL_CODES {
> >>  =09AWCC_SPECIAL_PROFILE_GMODE=09=09=3D 0xAB,
> >>  };
> >> =20
> >> +enum AWCC_TEMP_SENSOR_TYPES {
> >> +=09AWCC_TEMP_SENSOR_CPU=09=09=09=3D 0x01,
> >> +=09AWCC_TEMP_SENSOR_GPU=09=09=09=3D 0x06,
> >> +=09AWCC_TEMP_SENSOR_LAST
> >> +};
> >> +
> >>  enum awcc_thermal_profile {
> >>  =09AWCC_PROFILE_USTT_BALANCED,
> >>  =09AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
> >> @@ -215,6 +241,15 @@ struct wmax_u32_args {
> >>  =09u8 arg3;
> >>  } __packed;
> >> =20
> >> +struct awcc_fan_data {
> >> +=09unsigned long *related_temps;
> >> +=09unsigned long *auto_channels_temp;
> >> +=09u32 total_temps;
> >> +=09u32 min_rpm;
> >> +=09u32 max_rpm;
> >> +=09u8 id;
> >> +};
> >> +
> >>  struct awcc_priv {
> >>  =09struct wmi_device *wdev;
> >>  =09union {
> >> @@ -230,6 +265,11 @@ struct awcc_priv {
> >> =20
> >>  =09struct device *ppdev;
> >>  =09u8 supported_profiles[PLATFORM_PROFILE_LAST];
> >> +
> >> +=09struct device *hwdev;
> >> +=09struct awcc_fan_data **fan_data;
> >> +=09unsigned int temp_sensors_size;
> >> +=09unsigned long *temp_sensors;
> >>  };
> >> =20
> >>  static const enum platform_profile_option awcc_mode_to_platform_profi=
le[AWCC_PROFILE_LAST] =3D {
> >> @@ -494,6 +534,19 @@ static int __awcc_wmi_command(struct wmi_device *=
wdev, u32 method_id,
> >>  =09return 0;
> >>  }
> >> =20
> >> +static inline int awcc_get_fan_sensors(struct wmi_device *wdev, u8 op=
eration,
> >> +=09=09=09=09       u8 fan_id, u8 index, u32 *out)
> >> +{
> >> +=09struct wmax_u32_args args =3D {
> >> +=09=09.operation =3D operation,
> >> +=09=09.arg1 =3D fan_id,
> >> +=09=09.arg2 =3D index,
> >> +=09=09.arg3 =3D 0,
> >> +=09};
> >> +
> >> +=09return __awcc_wmi_command(wdev, AWCC_METHOD_GET_FAN_SENSORS, &args=
, out);
> >> +}
> >> +
> >>  static inline int awcc_thermal_information(struct wmi_device *wdev, u=
8 operation,
> >>  =09=09=09=09=09   u8 arg, u32 *out)
> >>  {
> >> @@ -564,6 +617,343 @@ static inline int awcc_op_get_resource_id(struct=
 wmi_device *wdev, u8 index, u32
> >>  =09return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &=
args, out);
> >>  }
> >> =20
> >> +/*
> >> + * HWMON
> >> + *  - Provides temperature and fan speed monitoring as well as manual=
 fan
> >> + *    control
> >> + */
> >> +static umode_t awcc_hwmon_is_visible(const void *drvdata, enum hwmon_=
sensor_types type,
> >> +=09=09=09=09     u32 attr, int channel)
> >> +{
> >> +=09const struct awcc_priv *priv =3D drvdata;
> >> +
> >> +=09switch (type) {
> >> +=09case hwmon_temp:
> >> +=09=09if (channel < priv->temp_count)
> >> +=09=09=09return 0444;
> >> +
> >> +=09=09break;
> >
> > IMO, these could be written as:
> > =09=09return channel < priv->temp_count ? 0444 : 0;
>=20
> Ack.
>=20
> >
> >> +=09case hwmon_fan:
> >> +=09=09if (channel < priv->fan_count)
> >> +=09=09=09return 0444;
> >> +
> >> +=09=09break;
> >> +=09case hwmon_pwm:
> >> +=09=09if (channel < priv->fan_count)
> >> +=09=09=09return 0444;
> >> +
> >> +=09=09break;
> >> +=09default:
> >> +=09=09break;
> >> +=09}
> >> +
> >> +=09return 0;
> >> +}
> >> +
> >> +static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type,
> >> +=09=09=09   u32 attr, int channel, long *val)
> >> +{
> >> +=09struct awcc_priv *priv =3D dev_get_drvdata(dev);
> >> +=09struct awcc_fan_data *fan;
> >> +=09u32 state;
> >> +=09int ret;
> >> +=09u8 temp;
> >> +
> >> +=09switch (type) {
> >> +=09case hwmon_temp:
> >> +=09=09temp =3D find_nth_bit(priv->temp_sensors, U8_MAX, channel);
> >> +=09=09if (temp >=3D U8_MAX)
> >
> > It cannot be larger than as its type is u8??
>=20
> Thanks, I forgot to change this! U8_MAX should be replaced with
> priv->temp_sensors_size.

I recall seeing another similar line somewhere else in the file so please=
=20
take a look at that as well.

> Thank you for reviewing this set! :)
>=20
>=20

--=20
 i.

--8323328-1823786508-1741105866=:931--

