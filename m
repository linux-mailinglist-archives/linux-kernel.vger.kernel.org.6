Return-Path: <linux-kernel+bounces-559615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF49A5F643
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05E216463C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F10C267B13;
	Thu, 13 Mar 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mk2T5/kV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27252E3366;
	Thu, 13 Mar 2025 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873647; cv=none; b=G58/K+ep15eMoE4bH8Kd7WdsVFvSkLp74KIN4N56C2KiMjXuXRKZuG2hVYO5YRQZ8tb0y0RcUzMtws2Xdg9nR5AbKY0QTPLNs+IsNTDugc/NfYobPpbG2mvGA9Sciji7xX0MQdVNIsSA4NOFkhMMM+IbZxWpioyXknLayIoCzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873647; c=relaxed/simple;
	bh=IoUXuilUTeQx3+D2plAtGeZBKPpCNfA4Rkro0WGv6vg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XAPG8g0a091K/3oZ7bzJIjYFcipMn4XZXYz2oRbXAzsixivYUgUEgCVEQa3CgaoWYwRdbQSk56B3ZFGu6l1kFURdcHAiLrTTipQe/igMIV/XRM+xE1fEPnx71mtmRlNE6sD+JaRvSB3UgbeSJvEA+Q0Be5jAcU7HWnRfw2JfFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mk2T5/kV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741873644; x=1773409644;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IoUXuilUTeQx3+D2plAtGeZBKPpCNfA4Rkro0WGv6vg=;
  b=Mk2T5/kVP5apjgoJHXcU/EUn05SrfxrVWG33TqdS5mXp9t+cKqJ7NNbQ
   Wf2WJ9/o49Ox38ohGlRle0BImusZlojtVzRDfaR0K8BAfIA9Ra1IubEeG
   jtQ22JK4aHFqI1ZeaJiDq0hGw+pw2u+Ol0+k68LdO74c9UV5k44wgK54G
   Z759MfREhI5ozQaB6V40qQqT9ax/Fa+mEBvRS/2Hp1ISLbi/x69n+sMJ5
   uHR1DkyXMSG16m7S9O9T6tk9L6kI2NCxvNxIAYQxsKcVRc53ALktmgpFH
   R0CZJHIyHEF6fs5BgDrLx/DVWE4j0w93KmFTRURRF4PQpvAIxwdrfV73N
   A==;
X-CSE-ConnectionGUID: TRKPd7vJT6Smyp9WFJCicQ==
X-CSE-MsgGUID: yEa6JaQ4TOub870+rfrKjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43121180"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43121180"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:47:23 -0700
X-CSE-ConnectionGUID: AZeJKVHQQYOEYyxb7AivRg==
X-CSE-MsgGUID: Wdpf+gcxQWm1Jc4j7rX0Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120674743"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:47:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Mar 2025 15:47:17 +0200 (EET)
To: Werner Sembach <wse@tuxedocomputers.com>
cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <jdelvare@suse.com>, 
    Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN
 via hwmon
In-Reply-To: <20250306132639.642369-1-wse@tuxedocomputers.com>
Message-ID: <70633701-31d2-c2ab-f4f4-043dd186f485@linux.intel.com>
References: <20250306132639.642369-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1196490205-1741873637=:1742"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1196490205-1741873637=:1742
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Mar 2025, Werner Sembach wrote:

> The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TUXI)
> ACPI interface which currently consists of the TFAN device. This has ACPI
> functions to control the built in fans and monitor fan speeds and CPU and
> GPU temprature.

temperature

>=20
> This driver implements this TFAN device via the hwmon subsystem with an
> added temprature check that ensure a minimum fanspeed at certain

temperature

> temperatures. This allows userspace controlled, but hardware safe, custom
> fan curves.
>=20
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  MAINTAINERS                                  |   6 +
>  drivers/platform/x86/Kconfig                 |   2 +
>  drivers/platform/x86/Makefile                |   3 +
>  drivers/platform/x86/tuxedo/Kbuild           |   6 +
>  drivers/platform/x86/tuxedo/Kconfig          |   6 +
>  drivers/platform/x86/tuxedo/nbxx/Kbuild      |   7 +
>  drivers/platform/x86/tuxedo/nbxx/Kconfig     |  13 +
>  drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c | 578 +++++++++++++++++++
>  8 files changed, 621 insertions(+)
>  create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>  create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>  create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
>  create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
>  create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0e..7139c32e96dc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24190,6 +24190,12 @@ T:=09git git://git.kernel.org/pub/scm/linux/kern=
el/git/lenb/linux.git turbostat
>  F:=09tools/power/x86/turbostat/
>  F:=09tools/testing/selftests/turbostat/
> =20
> +TUXEDO DRIVERS
> +M:=09Werner Sembach <wse@tuxedocomputers.com>
> +L:=09platform-driver-x86@vger.kernel.org
> +S:=09Supported
> +F:=09drivers/platform/x86/tuxedo/
> +
>  TW5864 VIDEO4LINUX DRIVER
>  M:=09Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>  M:=09Andrey Utkin <andrey.utkin@corp.bluecherry.net>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64b..58b258cde4fdb 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1186,6 +1186,8 @@ config SEL3350_PLATFORM
>  =09  To compile this driver as a module, choose M here: the module
>  =09  will be called sel3350-platform.
> =20
> +source "drivers/platform/x86/tuxedo/Kconfig"
> +
>  endif # X86_PLATFORM_DEVICES
> =20
>  config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b1429470674..1562dcd7ad9a5 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)=09=09+=3D winmate-fm0=
7-keys.o
> =20
>  # SEL
>  obj-$(CONFIG_SEL3350_PLATFORM)=09=09+=3D sel3350-platform.o
> +
> +# TUXEDO
> +obj-y=09=09=09=09=09+=3D tuxedo/
> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tu=
xedo/Kbuild
> new file mode 100644
> index 0000000000000..0de6c7871db95
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kbuild
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +obj-y=09+=3D nbxx/
> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/t=
uxedo/Kconfig
> new file mode 100644
> index 0000000000000..34aa2e89f00ba
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +source "drivers/platform/x86/tuxedo/nbxx/Kconfig"
> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kbuild b/drivers/platform/x=
86/tuxedo/nbxx/Kbuild
> new file mode 100644
> index 0000000000000..10ddef3564d84
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/Kbuild
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +tuxedo_nbxx_acpi_tuxi-y=09=09=09:=3D acpi_tuxi.o
> +obj-$(CONFIG_TUXEDO_NBXX_ACPI_TUXI)=09+=3D tuxedo_nbxx_acpi_tuxi.o
> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kconfig b/drivers/platform/=
x86/tuxedo/nbxx/Kconfig
> new file mode 100644
> index 0000000000000..827c65c410fb2
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +config TUXEDO_NBXX_ACPI_TUXI
> +=09tristate "TUXEDO NBxx ACPI TUXI Platform Driver"
> +=09help
> +=09  This driver implements the ACPI TUXI device found on some TUXEDO
> +=09  Notebooks. Currently this consists only of the TFAN subdevice which=
 is
> +=09  implemented via hwmon.
> +
> +=09  When compiled as a module it will be called tuxedo_nbxx_acpi_tuxi
> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c b/drivers/platf=
orm/x86/tuxedo/nbxx/acpi_tuxi.c
> new file mode 100644
> index 0000000000000..f42311f119956
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
> @@ -0,0 +1,578 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/units.h>
> +#include <linux/workqueue.h>
> +
> +#define TUXI_SAFEGUARD_PERIOD 1000      // 1s
> +#define TUXI_PWM_FAN_ON_MIN_SPEED 0x40  // ~25%
> +#define TUXI_TEMP_LEVEL_HYSTERESIS 1500 // 1.5=C2=B0C
> +#define TUXI_FW_TEMP_OFFSET 2730        // Kelvin to Celsius
> +#define TUXI_MAX_FAN_COUNT 16           /* If this is increased, new lin=
es must
> +=09=09=09=09=09 * be added to hwmcinfo below.
> +=09=09=09=09=09 */

Please use static_assert() to actually enforce what the comment says.

> +
> +static const struct acpi_device_id acpi_device_ids[] =3D {
> +=09{"TUXI0000", 0},
> +=09{"", 0}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_device_ids);
> +
> +struct tuxi_driver_data_t {
> +=09acpi_handle tfan_handle;
> +=09struct device *hwmdev;
> +};
> +
> +struct tuxi_hwmon_driver_data_t {
> +=09struct delayed_work work;
> +=09struct device *hwmdev;
> +=09u8 fan_count;
> +=09const char *fan_types[TUXI_MAX_FAN_COUNT];
> +=09u8 temp_level[TUXI_MAX_FAN_COUNT];
> +=09u8 curr_speed[TUXI_MAX_FAN_COUNT];
> +=09u8 want_speed[TUXI_MAX_FAN_COUNT];
> +=09u8 pwm_enabled;
> +};
> +
> +struct tuxi_temp_high_config_t {
> +=09long temp;
> +=09u8 min_speed;
> +};
> +
> +/* Speed values in this table must be >=3D TUXI_PWM_FAN_ON_MIN_SPEED to =
avoid
> + * undefined behaviour.
> + */
> +static const struct tuxi_temp_high_config_t temp_levels[] =3D {
> +=09{  80000, 0x4d }, // ~30%
> +=09{  90000, 0x66 }, // ~40%
> +=09{ 100000, 0xff }, // 100%
> +=09{ }
> +};
> +
> +/*
> + * Set fan speed target
> + *
> + * Set a specific fan speed (needs manual mode)
> + *
> + * Arg0: Fan index
> + * Arg1: Fan speed as a fraction of maximum speed (0-255)
> + */
> +#define TUXI_TFAN_METHOD_SET_FAN_SPEED=09=09"SSPD"
> +
> +/*
> + * Get fan speed target
> + *
> + * Arg0: Fan index
> + * Returns: Current fan speed target a fraction of maximum speed (0-255)
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_SPEED=09=09"GSPD"
> +
> +/*
> + * Get fans count
> + *
> + * Returns: Number of individually controllable fans
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_COUNT=09=09"GCNT"
> +
> +/*
> + * Set fans mode
> + *
> + * Arg0: 0 =3D auto, 1 =3D manual
> + */
> +#define TUXI_TFAN_METHOD_SET_FAN_MODE=09=09"SMOD"
> +
> +/*
> + * Get fans mode
> + *
> + * Returns: 0 =3D auto, 1 =3D manual
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_MODE=09=09"GMOD"
> +
> +/*
> + * Get fan type/what the fan is pointed at
> + *
> + * Arg0: Fan index
> + * Returns: 0 =3D general, 1 =3D CPU, 2 =3D GPU
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_TYPE=09=09"GTYP"
> +
> +static const char * const tuxi_fan_type_labels[] =3D {
> +=09"general",
> +=09"cpu",
> +=09"gpu"
> +};
> +
> +/*
> + * Get fan temperature/temperature of what the fan is pointed at
> + *
> + * Arg0: Fan index
> + * Returns: Temperature sensor value in 10ths of degrees kelvin
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE=09"GTMP"
> +
> +/*
> + * Get actual fan speed in RPM
> + *
> + * Arg0: Fan index
> + * Returns: Speed sensor value in revolutions per minute
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_RPM=09=09"GRPM"
> +
> +static int tuxi_tfan_method(struct acpi_device *device, acpi_string meth=
od,
> +=09=09=09    unsigned long long *params, u32 pcount,
> +=09=09=09    unsigned long long *retval)
> +{
> +=09struct tuxi_driver_data_t *driver_data =3D dev_get_drvdata(&device->d=
ev);
> +=09acpi_handle handle =3D driver_data->tfan_handle;
> +=09union acpi_object *obj __free(kfree) =3D NULL;

Please add linux/cleanup.h include.

> +=09struct acpi_object_list arguments;
> +=09unsigned long long data;
> +=09acpi_status status;
> +=09unsigned int i;
> +
> +=09if (pcount > 0) {
> +=09=09obj =3D kcalloc(pcount, sizeof(*arguments.pointer), GFP_KERNEL);
> +
> +=09=09arguments.count =3D pcount;
> +=09=09arguments.pointer =3D obj;
> +=09=09for (i =3D 0; i < pcount; ++i) {
> +=09=09=09arguments.pointer[i].type =3D ACPI_TYPE_INTEGER;
> +=09=09=09arguments.pointer[i].integer.value =3D params[i];
> +=09=09}
> +=09}
> +=09status =3D acpi_evaluate_integer(handle, method,
> +=09=09=09=09       pcount ? &arguments : NULL, &data);
> +=09if (ACPI_FAILURE(status))
> +=09=09return_ACPI_STATUS(status);
> +
> +=09if (retval)
> +=09=09*retval =3D data;
> +
> +=09return 0;
> +}
> +
> +static umode_t hwm_is_visible(const void *data, enum hwmon_sensor_types =
type,
> +=09=09=09      u32 __always_unused attr, int channel)
> +{
> +=09struct tuxi_hwmon_driver_data_t const *driver_data =3D data;
> +
> +=09if (channel >=3D driver_data->fan_count)
> +=09=09return 0;
> +
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09return 0444;
> +=09case hwmon_pwm:
> +=09=09return 0644;
> +=09case hwmon_temp:
> +=09=09return 0444;
> +=09default:
> +=09=09break;
> +=09}
> +
> +=09return -EOPNOTSUPP;
> +}
> +
> +static int hwm_read(struct device *dev, enum hwmon_sensor_types type, u3=
2 attr,
> +=09=09    int channel, long *val)
> +{
> +=09struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(dev)=
;
> +=09struct acpi_device *pdev =3D to_acpi_device(dev->parent);
> +=09unsigned long long params[2], retval;
> +=09int ret;
> +
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09params[0] =3D channel;
> +=09=09ret =3D tuxi_tfan_method(pdev,
> +=09=09=09=09       TUXI_TFAN_METHOD_GET_FAN_RPM,

These fit to same line.

> +=09=09=09=09       params, 1, &retval);
> +=09=09*val =3D retval > S32_MAX ? S32_MAX : retval;
> +=09=09return ret;
> +=09case hwmon_pwm:
> +=09=09switch (attr) {
> +=09=09case hwmon_pwm_input:
> +=09=09=09if (driver_data->pwm_enabled) {
> +=09=09=09=09*val =3D driver_data->curr_speed[channel];
> +=09=09=09=09return 0;
> +=09=09=09}
> +=09=09=09params[0] =3D channel;
> +=09=09=09ret =3D tuxi_tfan_method(pdev,
> +=09=09=09=09=09       TUXI_TFAN_METHOD_GET_FAN_SPEED,
> +=09=09=09=09=09       params, 1, &retval);
> +=09=09=09*val =3D retval > S32_MAX ? S32_MAX : retval;
> +=09=09=09return ret;
> +=09=09case hwmon_pwm_enable:
> +=09=09=09*val =3D driver_data->pwm_enabled;
> +=09=09=09return ret;
> +=09=09}
> +=09=09break;
> +=09case hwmon_temp:
> +=09=09params[0] =3D channel;
> +=09=09ret =3D tuxi_tfan_method(pdev,
> +=09=09=09=09       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
> +=09=09=09=09       params, 1, &retval);
> +=09=09*val =3D retval > S32_MAX / 100 ?

Add linux/limits.h include.

> +=09=09=09S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;

Is the math wrong, as you do retval - TUXI_FW_TEMP_OFFSET before=20
multiplying? Shouldn't it be like this:

=09=09retval -=3D TUXI_FW_TEMP_OFFSET;
=09=09*val =3D min(retval * 100, (unsigned long long)S32_MAX);

+ add include for min().

> +=09=09return ret;
> +=09default:
> +=09=09break;
> +=09}
> +
> +=09return -EOPNOTSUPP;
> +}
> +
> +static int hwm_read_string(struct device *dev,
> +=09=09=09   enum hwmon_sensor_types __always_unused type,
> +=09=09=09   u32 __always_unused attr, int channel,
> +=09=09=09   const char **str)
> +{
> +=09struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(dev)=
;
> +
> +=09*str =3D driver_data->fan_types[channel];
> +
> +=09return 0;
> +}
> +
> +static int write_speed(struct device *dev, int channel, u8 val, bool for=
ce)
> +{
> +=09struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(dev)=
;
> +=09struct acpi_device *pdev =3D to_acpi_device(dev->parent);
> +=09unsigned long long params[2];
> +=09u8 temp_level;
> +=09int ret;
> +
> +=09params[0] =3D channel;
> +
> +=09/* The heatpipe across the DRMs is shared between both fans and the D=
RMs

In multi-line comments:

=09/*
=09 * Text starts here...

What are DRMs? I guess it's neither Digital Rights Managements nor Direct=
=20
Rendering Managers :-).

> +=09 * are the most likely to go up in smoke. So it's better to apply the
> +=09 * minimum fan speed to all fans if either CPU or GPU is working hard=
=2E
> +=09 */
> +=09temp_level =3D max_array(driver_data->temp_level, driver_data->fan_co=
unt);
> +=09if (temp_level)
> +=09=09params[1] =3D max_t(u8, val,
> +=09=09=09=09  temp_levels[temp_level - 1].min_speed);

Both are already u8 so why you need max_t(), max() should be sufficient=20
when types are already right.

Include is missing.

> +=09else if (val < TUXI_PWM_FAN_ON_MIN_SPEED / 2)
> +=09=09params[1] =3D 0;
> +=09else if (val < TUXI_PWM_FAN_ON_MIN_SPEED)
> +=09=09params[1] =3D TUXI_PWM_FAN_ON_MIN_SPEED;
> +=09else
> +=09=09params[1] =3D val;
> +
> +=09if (force || params[1] !=3D driver_data->curr_speed[channel])
> +=09=09ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_SPEED,
> +=09=09=09=09       params, 2, NULL);
> +=09if (ret)
> +=09=09return ret;

Please indent this to the correct level.

> +
> +=09driver_data->curr_speed[channel] =3D params[1];

The use of params[1] obfuscates meaning, please use local variable with a=
=20
proper name and only assign it into params[1] for the tuxi_tfan_method call=
=2E

> +
> +=09return 0;
> +}
> +
> +static int hwm_write(struct device *dev,
> +=09=09     enum hwmon_sensor_types __always_unused type, u32 attr,
> +=09=09     int channel, long val)
> +{
> +=09struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(dev)=
;
> +=09struct acpi_device *pdev =3D to_acpi_device(dev->parent);
> +=09unsigned long long params[2];
> +=09unsigned int i;
> +=09int ret;
> +
> +=09switch (attr) {
> +=09case hwmon_pwm_input:
> +=09=09if (val > U8_MAX || val < 0)
> +=09=09=09return -EINVAL;
> +
> +=09=09if (driver_data->pwm_enabled) {
> +=09=09=09driver_data->want_speed[channel] =3D val;
> +=09=09=09return write_speed(dev, channel, val, false);
> +=09=09}
> +
> +=09=09return 0;
> +=09case hwmon_pwm_enable:
> +=09=09params[0] =3D val ? 1 : 0;

Can those two literals be named with defines?

> +=09=09ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE,
> +=09=09=09=09       params, 1, NULL);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09driver_data->pwm_enabled =3D val;
> +
> +=09=09/* Activating PWM sets speed to 0. Alternative design decision
> +=09=09 * could be to keep the current value. This would require proper
> +=09=09 * setting of driver_data->curr_speed for example.
> +=09=09 */
> +=09=09if (val)

Consider:
=09=09if (!val)
=09=09=09return 0;

So you can deindent the loop by one level.

> +=09=09=09for (i =3D 0; i < driver_data->fan_count; ++i) {
> +=09=09=09=09ret =3D write_speed(dev, i, 0, true);
> +=09=09=09=09if (ret)
> +=09=09=09=09=09return ret;
> +=09=09=09}
> +
> +=09=09return 0;
> +=09}
> +
> +=09return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops hwmops =3D {
> +=09.is_visible =3D hwm_is_visible,
> +=09.read =3D hwm_read,
> +=09.read_string =3D hwm_read_string,
> +=09.write =3D hwm_write,
> +};
> +
> +static const struct hwmon_channel_info * const hwmcinfo[] =3D {
> +=09HWMON_CHANNEL_INFO(fan,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL),
> +=09HWMON_CHANNEL_INFO(pwm,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +=09=09=09   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +=09HWMON_CHANNEL_INFO(temp,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL),
> +=09NULL
> +};
> +
> +static const struct hwmon_chip_info hwminfo =3D {
> +=09.ops =3D &hwmops,
> +=09.info =3D hwmcinfo
> +};
> +
> +static u8 tuxi_get_temp_level(struct tuxi_hwmon_driver_data_t *driver_da=
ta,
> +=09=09=09      u8 fan_id, long temp)
> +{
> +=09long temp_low, temp_high;
> +=09unsigned int i;
> +=09int ret;
> +
> +=09ret =3D driver_data->temp_level[fan_id];
> +
> +=09for (i =3D 0; temp_levels[i].temp; ++i) {
> +=09=09temp_low =3D i =3D=3D 0 ? S32_MIN : temp_levels[i - 1].temp;
> +=09=09temp_high =3D temp_levels[i].temp;
> +=09=09if (ret > i)
> +=09=09=09temp_high -=3D TUXI_TEMP_LEVEL_HYSTERESIS;
> +
> +=09=09if (temp >=3D temp_low && temp < temp_high)
> +=09=09=09ret =3D i;

Why you cannot return i; immediately here?

> +=09}
> +=09if (temp >=3D temp_high)
> +=09=09ret =3D i;
> +
> +=09return ret;
> +}
> +
> +static void tuxi_periodic_hw_safeguard(struct work_struct *work)
> +{
> +=09struct tuxi_hwmon_driver_data_t *driver_data =3D container_of(work,
> +=09=09=09=09=09=09=09=09    struct tuxi_hwmon_driver_data_t,
> +=09=09=09=09=09=09=09=09    work.work);
> +=09struct device *dev =3D driver_data->hwmdev;
> +=09struct acpi_device *pdev =3D to_acpi_device(dev->parent);
> +=09unsigned long long params[2], retval;
> +=09unsigned int i;
> +=09long temp;
> +=09int ret;
> +
> +=09for (i =3D 0; i < driver_data->fan_count; ++i) {
> +=09=09params[0] =3D i;
> +=09=09ret =3D tuxi_tfan_method(pdev,
> +=09=09=09=09       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
> +=09=09=09=09       params, 1, &retval);
> +=09=09/* If reading the temprature fails, default to a high value to

temperature

> +=09=09 * be on the safe side in the worst case.
> +=09=09 */
> +=09=09if (ret)
> +=09=09=09retval =3D 2720 + 1200;

TUXI_FW_TEMP_OFFSET + 1200 ?

Why it doesn't match to that define??

> +
> +=09=09temp =3D retval > S32_MAX / 100 ?
> +=09=09=09S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;

Same math issue comment as above.

Why is the read+conversion code duplicated into two places?

> +
> +=09=09driver_data->temp_level[i] =3D tuxi_get_temp_level(driver_data, i,
> +=09=09=09=09=09=09=09=09 temp);
> +=09}
> +
> +=09// Reapply want_speeds to respect eventual new temp_levels
> +=09for (i =3D 0; i < driver_data->fan_count; ++i)
> +=09=09write_speed(dev, i, driver_data->want_speed[i], false);
> +
> +=09schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
> +}
> +
> +static int tuxi_hwmon_add_devices(struct acpi_device *pdev, struct devic=
e **hwmdev)
> +{
> +=09struct tuxi_hwmon_driver_data_t *driver_data;
> +=09unsigned long long params[2], retval;
> +=09unsigned int i;
> +=09int ret;
> +
> +=09/* The first version of TUXI TFAN didn't have the Get Fan Temperature
> +=09 * method which is integral to this driver. So probe for existence an=
d
> +=09 * abort otherwise.
> +=09 *
> +=09 * The Get Fan Speed method is also missing in that version, but was
> +=09 * added in the same version so it doesn't have to be probe separatel=
y.
> +=09 */
> +=09params[0] =3D 0;
> +=09ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
> +=09=09=09       params, 1, &retval);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09driver_data =3D devm_kzalloc(&pdev->dev, sizeof(*driver_data), GFP_KE=
RNEL);
> +=09if (!driver_data)
> +=09=09return -ENOMEM;
> +
> +=09/* Loading this module sets the fan mode to auto. Alternative design
> +=09 * decision could be to keep the current value. This would require
> +=09 * proper initialization of driver_data->curr_speed for example.
> +=09 */
> +=09params[0] =3D 0;

Is this 0 ..._MODE_AUTO? Please use a named define if that's the case.

> +=09ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params,=
 1,
> +=09=09=09       NULL);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_COUNT, NULL, =
0,
> +=09=09=09       &retval);
> +=09if (ret)
> +=09=09return ret;
> +=09if (retval > TUXI_MAX_FAN_COUNT)
> +=09=09return -EINVAL;
> +=09driver_data->fan_count =3D retval;
> +
> +=09for (i =3D 0; i < driver_data->fan_count; ++i) {
> +=09=09params[0] =3D i;
> +=09=09ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TYPE,
> +=09=09=09=09       params, 1, &retval);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09else if (retval >=3D ARRAY_SIZE(tuxi_fan_type_labels))

No need for else as there's return.

> +=09=09=09return -EOPNOTSUPP;
> +=09=09driver_data->fan_types[i] =3D tuxi_fan_type_labels[retval];
> +=09}
> +
> +=09*hwmdev =3D devm_hwmon_device_register_with_info(&pdev->dev,
> +=09=09=09=09=09=09       "tuxedo_nbxx_acpi_tuxi",
> +=09=09=09=09=09=09       driver_data, &hwminfo,
> +=09=09=09=09=09=09       NULL);
> +=09ret =3D PTR_ERR_OR_ZERO(*hwmdev);
> +=09if (ret)

This obfuscates what you're doing here as you do not actually use 0 at=20
all. Please use this instead:

=09if (IS_ERR(*hwmdev))
=09=09return PTR_ERR(*hwmdev);

> +=09=09return ret;
> +
> +=09driver_data->hwmdev =3D *hwmdev;
> +
> +=09INIT_DELAYED_WORK(&driver_data->work, tuxi_periodic_hw_safeguard);
> +=09schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
> +
> +=09return 0;
> +}
> +
> +static void tuxi_hwmon_remove_devices(struct device *hwmdev)
> +{
> +=09struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(hwmd=
ev);
> +=09struct acpi_device *pdev =3D to_acpi_device(hwmdev->parent);
> +=09unsigned long long params[2];
> +
> +=09cancel_delayed_work_sync(&driver_data->work);
> +
> +=09params[0] =3D 0;

Use a named define?

> +=09tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1, NULL=
);
> +}
> +
> +static int tuxi_add(struct acpi_device *device)
> +{
> +=09struct tuxi_driver_data_t *driver_data;
> +=09acpi_status status;
> +
> +=09driver_data =3D devm_kzalloc(&device->dev, sizeof(*driver_data),
> +=09=09=09=09   GFP_KERNEL);
> +=09if (!driver_data)
> +=09=09return -ENOMEM;
> +
> +=09// Find subdevices
> +=09status =3D acpi_get_handle(device->handle, "TFAN",
> +=09=09=09=09 &driver_data->tfan_handle);
> +=09if (ACPI_FAILURE(status))
> +=09=09return_ACPI_STATUS(status);
> +
> +=09dev_set_drvdata(&device->dev, driver_data);
> +
> +=09return tuxi_hwmon_add_devices(device, &driver_data->hwmdev);
> +}
> +
> +static void tuxi_remove(struct acpi_device *device)
> +{
> +=09struct tuxi_driver_data_t *driver_data =3D dev_get_drvdata(&device->d=
ev);
> +
> +=09tuxi_hwmon_remove_devices(driver_data->hwmdev);
> +}
> +
> +static struct acpi_driver acpi_driver =3D {
> +=09.name =3D "tuxedo_nbxx_acpi_tuxi",
> +=09.ids =3D acpi_device_ids,
> +=09.ops =3D {
> +=09=09.add =3D tuxi_add,
> +=09=09.remove =3D tuxi_remove,
> +=09},
> +};
> +
> +module_acpi_driver(acpi_driver);
> +
> +MODULE_DESCRIPTION("TUXEDO TUXI");

Perhaps this could be made a more specific to the actual functionality?

> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
> +MODULE_LICENSE("GPL");
>=20

--=20
 i.

--8323328-1196490205-1741873637=:1742--

