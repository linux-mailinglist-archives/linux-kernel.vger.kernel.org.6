Return-Path: <linux-kernel+bounces-565486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29680A6696D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1F81796BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70E1D90C5;
	Tue, 18 Mar 2025 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1PlyRyH"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08212B9A4;
	Tue, 18 Mar 2025 05:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275966; cv=none; b=d40Wu0pnMAXWH6ca5/vFpVPNY47Gg95k6SKw9Df1Equ6m8X1ha24sLk+wr1ZIo5dHA+Md0sQwPT9eB/BKGrHnzZ6UvkQ1Ydw4kfh8xBA2e/Fylzh11ihfH90bPgxusghalbMk/8lZZsGr2ufaWmLAspj+O4iqweMSN+cDdxQDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275966; c=relaxed/simple;
	bh=HhIcaLJXYIiDg0KO5wsh7ttqhlyk9jFB/OzU/Kog3ds=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=AKFtMjY4wF+l8z4+PQ+Zr13vIJD/HEWYjqmU2moJyRpBedf8gpEUPF/Sz64t+VcmtD4avkjiReAwxu+THu5uYT0Wp47lSyzsukzpTBmAWrzH3VmfkYegCOYX3zIbiczodgKzqwxCHPMbaJq+uxy7RYF2Xb9o+g87yFZhEoRCWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1PlyRyH; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51eb181331bso2543790e0c.0;
        Mon, 17 Mar 2025 22:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742275962; x=1742880762; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI0u7teF/1n0kizSaSA9sD8SFlVXxVJNeKmrNpu0di8=;
        b=e1PlyRyHGm5VXVq0MEbEK0/xdfc/x42/TPZy+LgAtdf91/1xmrd+hX95Zm4H/8kXmt
         hYalKDN/XPF3Nk+MVQVy1Z3U014LrTicTXGMjaPe+ji6m092i8Az9+1I2v207h4w2Fs7
         x/HYP1O1hJsgoffNie5mzNWImb+/+DdbZ1Ub0TH3XK9F4/6I/ukT5f2IqgUayAY1X/tA
         O6r+JZhrpYGwv+mJciihNmCZ28hfxY3cmUQfknlcjq/UDX8NJRLS1wLQSo0WQQs+5WTs
         Y5sEpbbEs0Pewl+/vT3ifbO0f+AxtQp3dXaoiLU/7aK3byawFNRipLAVgSZkF98tLRIN
         il3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742275962; x=1742880762;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HI0u7teF/1n0kizSaSA9sD8SFlVXxVJNeKmrNpu0di8=;
        b=pH2Q1zO3jBX0MQedFSY2iTWAm3G0sGYkr7JhgknQTX3Ge4oZqGmGmPjgg2EIIoZeJh
         SdUBvui+qwAbkHz1SKGOdfXJCMn83szcN9ymlHMucTgzbzmXvRQ+h/LPrGyx25J0Z+X6
         uCf/gi0PXoLHvC7j9yXWqep0B+XsW9BekMPHKijj+5YYf8ZUZGKvAfEtF1+pgJa9UoZF
         VlPBnQs2VrIMl8qGa1XK1qS4uaZMukI9G3CStUzvFyj3BytlstStCqmSUiIkZ+fXhTFX
         g8QL9fM04XmKZxtA1vrf/m+ucioRzETBLumOeJ+qkUh/LcGihKJoF5JWw0ryu3sPpkRj
         3zwg==
X-Forwarded-Encrypted: i=1; AJvYcCUQOtTAmyOmE5gcKXRiLa78GMDmaJJrKqDh7PnplQU8UgH5/ohJWnQNS+J4biQqp9WZLPLMr5WKCVwnpA==@vger.kernel.org, AJvYcCVO0sN/zd6KKkCvEwucmuWoqF8Nv05f2NWM6dNlVhOMASfvXGOIN2yQDM2ggPWiJXKsIjoQV15ZLKpoW9uOdqtNHdt4yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSBZn3MyeOKruyZVjV3y1js5zbhWu8tTZyg1JDh19WaqU8WHW
	DopJ6XgYJTow4oZr9W8lA8oAYpazF2bq85yBc+/sbnr0cogXpsdt
X-Gm-Gg: ASbGnctbyO3SLZiQ6krfze5qwQzJC9SxNIcf0V17g5StBmv6o358BlqsuOxNUP/jSLb
	VjAlXrFd7a4RSRj/3cNE81PPWI9QOnI1ASkRRgvcTERvEg9BWCKsYfkBVZvSvhli9sgMFJ3wde1
	fq+E7kbHJu1+MZxaQQ+SkkjdGhtWdgQtIaV4kU0tqQGc8IrFeygbC4y/TsrlSDTAcG90lUWUw8f
	I1CUCbkWQNYrDk+E7qOPmBcWgpAWLdMNFrtFuuUySUAMzy8qi84voqGZy9HFkAxauJRgQ0ABYmb
	l9jD4wTS9OjEol7FaDJ+FH/X96UUiaY5SJmx
X-Google-Smtp-Source: AGHT+IHaVafHzZGZa1+GxDMT6dSD6J0kwFDXzY51fl2mEyxc8CnidhAjo01E/jJQQ6FYShXlf4QAmg==
X-Received: by 2002:a05:6122:438a:b0:520:4d95:1319 with SMTP id 71dfb90a1353d-524498aea23mr10188269e0c.4.1742275962280;
        Mon, 17 Mar 2025 22:32:42 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5a1bb4sm1914485e0c.11.2025.03.17.22.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 22:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Mar 2025 00:32:39 -0500
Message-Id: <D8J5A68UDQOD.3UN0OMYNV0ZAZ@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Werner Sembach" <wse@tuxedocomputers.com>, <hdegoede@redhat.com>,
 <ilpo.jarvinen@linux.intel.com>, <jdelvare@suse.com>, <linux@roeck-us.net>
Cc: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI
 TFAN via hwmon
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313221407.644349-1-wse@tuxedocomputers.com>
 <20250313221407.644349-2-wse@tuxedocomputers.com>
In-Reply-To: <20250313221407.644349-2-wse@tuxedocomputers.com>

Hi Werner,

On Thu Mar 13, 2025 at 5:09 PM -05, Werner Sembach wrote:
> The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TUXI)
> ACPI interface which currently consists of the TFAN device. This has ACPI
> functions to control the built in fans and monitor fan speeds and CPU and
> GPU temperature.
>
> This driver implements this TFAN device via the hwmon subsystem with an
> added temperature check that ensure a minimum fanspeed at certain
> temperatures. This allows userspace controlled, but hardware safe, custom
> fan curves.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  MAINTAINERS                                  |   6 +
>  drivers/platform/x86/Kconfig                 |   2 +
>  drivers/platform/x86/Makefile                |   3 +
>  drivers/platform/x86/tuxedo/Kbuild           |   8 +
>  drivers/platform/x86/tuxedo/Kconfig          |   8 +
>  drivers/platform/x86/tuxedo/nbxx/Kbuild      |   9 +
>  drivers/platform/x86/tuxedo/nbxx/Kconfig     |  15 +
>  drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c | 591 +++++++++++++++++++
>  8 files changed, 642 insertions(+)
>  create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>  create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>  create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
>  create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
>  create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0e..7139c32e96dc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24190,6 +24190,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel=
/git/lenb/linux.git turbostat
>  F:	tools/power/x86/turbostat/
>  F:	tools/testing/selftests/turbostat/
> =20
> +TUXEDO DRIVERS
> +M:	Werner Sembach <wse@tuxedocomputers.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	drivers/platform/x86/tuxedo/
> +
>  TW5864 VIDEO4LINUX DRIVER
>  M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>  M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64b..58b258cde4fdb 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1186,6 +1186,8 @@ config SEL3350_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called sel3350-platform.
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
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+=3D winmate-fm07-ke=
ys.o
> =20
>  # SEL
>  obj-$(CONFIG_SEL3350_PLATFORM)		+=3D sel3350-platform.o
> +
> +# TUXEDO
> +obj-y					+=3D tuxedo/
> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tu=
xedo/Kbuild

I think this should be named Makefile instead of Kbuild.

> new file mode 100644
> index 0000000000000..dc55b403f201d
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kbuild
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +obj-y	+=3D nbxx/
> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/t=
uxedo/Kconfig
> new file mode 100644
> index 0000000000000..1b22a0b29460a
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +source "drivers/platform/x86/tuxedo/nbxx/Kconfig"
> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kbuild b/drivers/platform/x=
86/tuxedo/nbxx/Kbuild

Same as above.

> new file mode 100644
> index 0000000000000..256b03921c732
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/Kbuild
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +tuxedo_nbxx_acpi_tuxi-y			:=3D acpi_tuxi.o
> +obj-$(CONFIG_TUXEDO_NBXX_ACPI_TUXI)	+=3D tuxedo_nbxx_acpi_tuxi.o
> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kconfig b/drivers/platform/=
x86/tuxedo/nbxx/Kconfig
> new file mode 100644
> index 0000000000000..0d011c0c715a5
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +config TUXEDO_NBXX_ACPI_TUXI
> +	tristate "TUXEDO NBxx ACPI TUXI Platform Driver"
> +	help
> +	  This driver implements the ACPI TUXI device found on some TUXEDO
> +	  Notebooks. Currently this consists only of the TFAN subdevice which i=
s
> +	  implemented via hwmon.
> +
> +	  When compiled as a module it will be called tuxedo_nbxx_acpi_tuxi
> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c b/drivers/platf=
orm/x86/tuxedo/nbxx/acpi_tuxi.c
> new file mode 100644
> index 0000000000000..bb452cc33568a
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
> @@ -0,0 +1,591 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/limits.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/units.h>
> +#include <linux/workqueue.h>
> +
> +#define TUXI_SAFEGUARD_PERIOD 1000      // 1s
> +#define TUXI_PWM_FAN_ON_MIN_SPEED 0x40  // ~25%
> +#define TUXI_TEMP_LEVEL_HYSTERESIS 1500 // 1.5=C2=B0C
> +#define TUXI_FW_TEMP_OFFSET 2730        // Kelvin to Celsius
> +#define TUXI_MAX_FAN_COUNT 16           /*
> +					 * If this is increased, new lines must
> +					 * be added to hwmcinfo below.
> +					 */

The style of these macros could be better.

I suggest using an enum instead. Something like:

	enum TUXI_SAFEGUARD_LIMITS {
		...
	}

with it's values aligned and the comment on top.

> +
> +static const struct acpi_device_id acpi_device_ids[] =3D {
> +	{"TUXI0000", 0},
> +	{"", 0}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_device_ids);
> +
> +struct tuxi_driver_data_t {
> +	acpi_handle tfan_handle;
> +	struct device *hwmdev;
> +};
> +
> +struct tuxi_hwmon_driver_data_t {
> +	struct delayed_work work;
> +	struct device *hwmdev;
> +	u8 fan_count;
> +	const char *fan_types[TUXI_MAX_FAN_COUNT];
> +	u8 temp_level[TUXI_MAX_FAN_COUNT];
> +	u8 curr_speed[TUXI_MAX_FAN_COUNT];
> +	u8 want_speed[TUXI_MAX_FAN_COUNT];
> +	u8 pwm_enabled;
> +};
> +
> +struct tuxi_temp_high_config_t {
> +	long temp;
> +	u8 min_speed;
> +};
> +
> +/*
> + * Speed values in this table must be >=3D TUXI_PWM_FAN_ON_MIN_SPEED to =
avoid
> + * undefined behaviour.
> + */
> +static const struct tuxi_temp_high_config_t temp_levels[] =3D {
> +	{  80000, 0x4d }, // ~30%
> +	{  90000, 0x66 }, // ~40%
> +	{ 100000, 0xff }, // 100%
> +	{ }
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
> +#define TUXI_TFAN_METHOD_SET_FAN_SPEED		"SSPD"
> +
> +/*
> + * Get fan speed target
> + *
> + * Arg0: Fan index
> + * Returns: Current fan speed target a fraction of maximum speed (0-255)
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_SPEED		"GSPD"
> +
> +/*
> + * Get fans count
> + *
> + * Returns: Number of individually controllable fans
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_COUNT		"GCNT"
> +
> +/*
> + * Set fans mode
> + *
> + * Arg0: 0 =3D auto, 1 =3D manual
> + */
> +#define TUXI_TFAN_METHOD_SET_FAN_MODE		"SMOD"
> +
> +/*
> + * Get fans mode
> + *
> + * Returns: 0 =3D auto, 1 =3D manual
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_MODE		"GMOD"
> +
> +#define TUXI_TFAN_FAN_MODE_AUTO 0
> +#define TUXI_TFAN_FAN_MODE_MANUAL 1
> +
> +/*
> + * Get fan type/what the fan is pointed at
> + *
> + * Arg0: Fan index
> + * Returns: 0 =3D general, 1 =3D CPU, 2 =3D GPU
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_TYPE		"GTYP"
> +
> +static const char * const tuxi_fan_type_labels[] =3D {
> +	"general",
> +	"cpu",
> +	"gpu"
> +};
> +
> +/*
> + * Get fan temperature/temperature of what the fan is pointed at
> + *
> + * Arg0: Fan index
> + * Returns: Temperature sensor value in 10ths of degrees kelvin
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE	"GTMP"
> +
> +/*
> + * Get actual fan speed in RPM
> + *
> + * Arg0: Fan index
> + * Returns: Speed sensor value in revolutions per minute
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_RPM		"GRPM"
> +
> +static int tuxi_tfan_method(struct acpi_device *device, acpi_string meth=
od,
> +			    unsigned long long *params, u32 pcount,
> +			    unsigned long long *retval)
> +{
> +	struct tuxi_driver_data_t *driver_data =3D dev_get_drvdata(&device->dev=
);
> +	acpi_handle handle =3D driver_data->tfan_handle;
> +	union acpi_object *obj __free(kfree) =3D NULL;
> +	struct acpi_object_list arguments;
> +	unsigned long long data;
> +	acpi_status status;
> +	unsigned int i;
> +
> +	if (pcount > 0) {
> +		obj =3D kcalloc(pcount, sizeof(*arguments.pointer), GFP_KERNEL);
> +
> +		arguments.count =3D pcount;
> +		arguments.pointer =3D obj;
> +		for (i =3D 0; i < pcount; ++i) {
> +			arguments.pointer[i].type =3D ACPI_TYPE_INTEGER;
> +			arguments.pointer[i].integer.value =3D params[i];
> +		}
> +	}
> +	status =3D acpi_evaluate_integer(handle, method,
> +				       pcount ? &arguments : NULL, &data);
> +	if (ACPI_FAILURE(status))
> +		return_ACPI_STATUS(status);
> +
> +	if (retval)
> +		*retval =3D data;
> +
> +	return 0;
> +}
> +
> +static umode_t hwm_is_visible(const void *data, enum hwmon_sensor_types =
type,

All of these callbacks should be prefixed with "tuxi_".

> +			      u32 __always_unused attr, int channel)
> +{
> +	struct tuxi_hwmon_driver_data_t const *driver_data =3D data;
> +
> +	if (channel >=3D driver_data->fan_count)
> +		return 0;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		return 0444;
> +	case hwmon_pwm:
> +		return 0644;
> +	case hwmon_temp:
> +		return 0444;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int hwm_read(struct device *dev, enum hwmon_sensor_types type, u3=
2 attr,
> +		    int channel, long *val)
> +{
> +	struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(dev);
> +	struct acpi_device *pdev =3D to_acpi_device(dev->parent);
> +	unsigned long long params[2], retval;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		params[0] =3D channel;
> +		ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_RPM,
> +				       params, 1, &retval);
> +		*val =3D retval > S32_MAX ? S32_MAX : retval;

Use clamp_val().

Also, is an RPM >S32_MAX a bogus value? Should it be treated as an
error instead?

> +		return ret;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			if (driver_data->pwm_enabled) {

I think this needs locking.

> +				*val =3D driver_data->curr_speed[channel];
> +				return 0;
> +			}
> +			params[0] =3D channel;
> +			ret =3D tuxi_tfan_method(pdev,
> +					       TUXI_TFAN_METHOD_GET_FAN_SPEED,
> +					       params, 1, &retval);
> +			*val =3D retval > S32_MAX ? S32_MAX : retval;

HWMON ABI specifies that the `pwm` attribute range is 0-255. Are values
above this, bogus values?

> +			return ret;
> +		case hwmon_pwm_enable:
> +			*val =3D driver_data->pwm_enabled;
> +			return ret;

`ret` is uninitialized when used here!

> +		}
> +		break;
> +	case hwmon_temp:
> +		params[0] =3D channel;
> +		ret =3D tuxi_tfan_method(pdev,
> +				       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
> +				       params, 1, &retval);
> +		*val =3D retval > S32_MAX / 100 ?
> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;

Same comment as the clamped values above.

Additionally, please use deci_kelvin_to_millicelsius() from
<linux/units.h> and IMO this should be an standard if-else block.

> +		return ret;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int hwm_read_string(struct device *dev,
> +			   enum hwmon_sensor_types __always_unused type,
> +			   u32 __always_unused attr, int channel,
> +			   const char **str)
> +{
> +	struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(dev);
> +
> +	*str =3D driver_data->fan_types[channel];
> +
> +	return 0;
> +}
> +
> +static int write_speed(struct device *dev, int channel, u8 val, bool for=
ce)
> +{
> +	struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(dev);
> +	struct acpi_device *pdev =3D to_acpi_device(dev->parent);
> +	unsigned long long new_speed, params[2];
> +	u8 temp_level;
> +	int ret;
> +
> +	params[0] =3D channel;
> +
> +	/*
> +	 * The heatpipe across the VRMs is shared between both fans and the VRM=
s
> +	 * are the most likely to go up in smoke. So it's better to apply the
> +	 * minimum fan speed to all fans if either CPU or GPU is working hard.
> +	 */
> +	temp_level =3D max_array(driver_data->temp_level, driver_data->fan_coun=
t);
> +	if (temp_level)
> +		new_speed =3D max(val, temp_levels[temp_level - 1].min_speed);
> +	else if (val < TUXI_PWM_FAN_ON_MIN_SPEED / 2)
> +		new_speed =3D 0;
> +	else if (val < TUXI_PWM_FAN_ON_MIN_SPEED)
> +		new_speed =3D TUXI_PWM_FAN_ON_MIN_SPEED;
> +	else
> +		new_speed =3D val;
> +
> +	if (force || new_speed !=3D driver_data->curr_speed[channel]) {
> +		params[0] =3D channel;
> +		params[1] =3D new_speed;
> +		ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_SPEED,
> +				       params, 2, NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	driver_data->curr_speed[channel] =3D new_speed;
> +
> +	return 0;
> +}
> +
> +static int hwm_write(struct device *dev,
> +		     enum hwmon_sensor_types __always_unused type, u32 attr,
> +		     int channel, long val)
> +{
> +	struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(dev);
> +	struct acpi_device *pdev =3D to_acpi_device(dev->parent);
> +	unsigned long long params[2];
> +	unsigned int i;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		if (val > U8_MAX || val < 0)
> +			return -EINVAL;

Please, clamp_val() instead.

> +
> +		if (driver_data->pwm_enabled) {

I believe this needs locking to ensure pwm_enabled hasn't changed.

> +			driver_data->want_speed[channel] =3D val;
> +			return write_speed(dev, channel, val, false);
> +		}
> +
> +		return 0;
> +	case hwmon_pwm_enable:
> +		params[0] =3D val ? TUXI_TFAN_FAN_MODE_MANUAL :
> +				  TUXI_TFAN_FAN_MODE_AUTO;

Per ABI specification, a value of 0 corresponds to fans at full speed,
not "auto". A value of 2+ corresponds to auto.

Please, refer to:

	https://docs.kernel.org/admin-guide/abi-testing.html#abi-sys-class-hwmon-h=
wmonx-pwmy-enable

for more details.

> +		ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE,
> +				       params, 1, NULL);
> +		if (ret)
> +			return ret;
> +
> +		driver_data->pwm_enabled =3D val;
> +
> +		/*
> +		 * Activating PWM sets speed to 0. Alternative design decision
> +		 * could be to keep the current value. This would require proper
> +		 * setting of driver_data->curr_speed for example.
> +		 */
> +		if (val)
> +			for (i =3D 0; i < driver_data->fan_count; ++i) {
> +				ret =3D write_speed(dev, i, 0, true);
> +				if (ret)
> +					return ret;
> +			}
> +
> +		return 0;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops hwmops =3D {

Prefix this struct with "tuxi_"

> +	.is_visible =3D hwm_is_visible,
> +	.read =3D hwm_read,
> +	.read_string =3D hwm_read_string,
> +	.write =3D hwm_write,
> +};
> +
> +static const struct hwmon_channel_info * const hwmcinfo[] =3D {

Same as above.

> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info hwminfo =3D {

Same as above.

> +	.ops =3D &hwmops,
> +	.info =3D hwmcinfo
> +};
> +
> +static u8 tuxi_get_temp_level(struct tuxi_hwmon_driver_data_t *driver_da=
ta,
> +			      u8 fan_id, long temp)
> +{
> +	long temp_low, temp_high;
> +	unsigned int i;
> +	int ret;
> +
> +	ret =3D driver_data->temp_level[fan_id];
> +
> +	for (i =3D 0; temp_levels[i].temp; ++i) {
> +		temp_low =3D i =3D=3D 0 ? S32_MIN : temp_levels[i - 1].temp;
> +		temp_high =3D temp_levels[i].temp;
> +		if (ret > i)
> +			temp_high -=3D TUXI_TEMP_LEVEL_HYSTERESIS;
> +
> +		if (temp >=3D temp_low && temp < temp_high)
> +			return i;
> +	}
> +	if (temp >=3D temp_high)
> +		ret =3D i;
> +
> +	return ret;
> +}
> +
> +static void tuxi_periodic_hw_safeguard(struct work_struct *work)

I wonder if all of this convoluted logic is really necessary. Why can't
you just force TUXI_TFAN_FAN_MODE_AUTO if a certain limit is surpassed?

That would mean fewer CPU instructions that are constantly running.

> +{
> +	struct tuxi_hwmon_driver_data_t *driver_data =3D container_of(work,
> +								    struct tuxi_hwmon_driver_data_t,
> +								    work.work);
> +	struct device *dev =3D driver_data->hwmdev;
> +	struct acpi_device *pdev =3D to_acpi_device(dev->parent);
> +	unsigned long long params[2], retval;
> +	unsigned int i;
> +	long temp;
> +	int ret;
> +
> +	for (i =3D 0; i < driver_data->fan_count; ++i) {
> +		params[0] =3D i;
> +		ret =3D tuxi_tfan_method(pdev,
> +				       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
> +				       params, 1, &retval);
> +		/*
> +		 * If reading the temperature fails, default to a high value to
> +		 * be on the safe side in the worst case.
> +		 */
> +		if (ret)
> +			retval =3D TUXI_FW_TEMP_OFFSET + 1200;
> +
> +		temp =3D retval > S32_MAX / 100 ?
> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;
> +
> +		driver_data->temp_level[i] =3D tuxi_get_temp_level(driver_data, i,
> +								 temp);
> +	}
> +
> +	// Reapply want_speeds to respect eventual new temp_levels
> +	for (i =3D 0; i < driver_data->fan_count; ++i)
> +		write_speed(dev, i, driver_data->want_speed[i], false);
> +
> +	schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
> +}
> +
> +static int tuxi_hwmon_add_devices(struct acpi_device *pdev, struct devic=
e **hwmdev)
> +{
> +	struct tuxi_hwmon_driver_data_t *driver_data;
> +	unsigned long long params[2], retval;
> +	unsigned int i;
> +	int ret;
> +
> +	/*
> +	 * The first version of TUXI TFAN didn't have the Get Fan Temperature
> +	 * method which is integral to this driver. So probe for existence and
> +	 * abort otherwise.
> +	 *
> +	 * The Get Fan Speed method is also missing in that version, but was
> +	 * added in the same version so it doesn't have to be probe separately.
> +	 */
> +	params[0] =3D 0;
> +	ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
> +			       params, 1, &retval);
> +	if (ret)
> +		return ret;
> +
> +	driver_data =3D devm_kzalloc(&pdev->dev, sizeof(*driver_data), GFP_KERN=
EL);
> +	if (!driver_data)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Loading this module sets the fan mode to auto. Alternative design
> +	 * decision could be to keep the current value. This would require
> +	 * proper initialization of driver_data->curr_speed for example.
> +	 */
> +	params[0] =3D TUXI_TFAN_FAN_MODE_AUTO;
> +	ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1=
,
> +			       NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_COUNT, NULL, 0,
> +			       &retval);
> +	if (ret)
> +		return ret;
> +	if (retval > TUXI_MAX_FAN_COUNT)
> +		return -EINVAL;
> +	driver_data->fan_count =3D retval;
> +
> +	for (i =3D 0; i < driver_data->fan_count; ++i) {
> +		params[0] =3D i;
> +		ret =3D tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TYPE,
> +				       params, 1, &retval);
> +		if (ret)
> +			return ret;
> +		if (retval >=3D ARRAY_SIZE(tuxi_fan_type_labels))
> +			return -EOPNOTSUPP;
> +		driver_data->fan_types[i] =3D tuxi_fan_type_labels[retval];
> +	}
> +
> +	*hwmdev =3D devm_hwmon_device_register_with_info(&pdev->dev,
> +						       "tuxedo_nbxx_acpi_tuxi",
> +						       driver_data, &hwminfo,
> +						       NULL);
> +	if (IS_ERR(*hwmdev))
> +		return PTR_ERR(*hwmdev);
> +
> +	driver_data->hwmdev =3D *hwmdev;
> +
> +	INIT_DELAYED_WORK(&driver_data->work, tuxi_periodic_hw_safeguard);
> +	schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
> +
> +	return 0;
> +}
> +
> +static void tuxi_hwmon_remove_devices(struct device *hwmdev)
> +{
> +	struct tuxi_hwmon_driver_data_t *driver_data =3D dev_get_drvdata(hwmdev=
);
> +	struct acpi_device *pdev =3D to_acpi_device(hwmdev->parent);
> +	unsigned long long params[2];
> +
> +	cancel_delayed_work_sync(&driver_data->work);
> +
> +	params[0] =3D TUXI_TFAN_FAN_MODE_AUTO;
> +	tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1, NULL);
> +}
> +
> +static int tuxi_add(struct acpi_device *device)
> +{
> +	struct tuxi_driver_data_t *driver_data;
> +	acpi_status status;
> +
> +	driver_data =3D devm_kzalloc(&device->dev, sizeof(*driver_data),
> +				   GFP_KERNEL);
> +	if (!driver_data)
> +		return -ENOMEM;
> +
> +	// Find subdevices
> +	status =3D acpi_get_handle(device->handle, "TFAN",
> +				 &driver_data->tfan_handle);
> +	if (ACPI_FAILURE(status))
> +		return_ACPI_STATUS(status);
> +
> +	dev_set_drvdata(&device->dev, driver_data);
> +
> +	return tuxi_hwmon_add_devices(device, &driver_data->hwmdev);
> +}
> +
> +static void tuxi_remove(struct acpi_device *device)
> +{
> +	struct tuxi_driver_data_t *driver_data =3D dev_get_drvdata(&device->dev=
);
> +
> +	tuxi_hwmon_remove_devices(driver_data->hwmdev);
> +}
> +
> +static struct acpi_driver acpi_driver =3D {

AFAIK platform drivers are *strongly* preferred over acpi drivers. You
should use that instead.

For an example check the samsung-galaxybook driver in the for-next
branch.

--=20
 ~ Kurt

> +	.name =3D "tuxedo_nbxx_acpi_tuxi",
> +	.ids =3D acpi_device_ids,
> +	.ops =3D {
> +		.add =3D tuxi_add,
> +		.remove =3D tuxi_remove,
> +	},
> +};
> +
> +module_acpi_driver(acpi_driver);
> +
> +MODULE_DESCRIPTION("Fan control for TUXEDO devices using the TUXI ACPI d=
evice");
> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
> +MODULE_LICENSE("GPL");


