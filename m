Return-Path: <linux-kernel+bounces-560360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD11A6031A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F93A421C20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D41F4639;
	Thu, 13 Mar 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="b7Yoikxr"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67E14A60F;
	Thu, 13 Mar 2025 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741899534; cv=none; b=ZxNc1hxNmiwEybFtsM89unKXryiasWjmIaVOntTgzazjvOdhgmXn2pyV/tFF97vh3UAlBYlTFFIMufKAmm39E/RUdw86PT4uEF0FsgDb+qhodgiWw8VJMvmO6CgIiFsUqLHJIeSjljNc0teOZ7IGOOFIQnlvWMg6g2KUYS9OOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741899534; c=relaxed/simple;
	bh=fSvPTMewSmcZmfUQpIHVhrzMlnrHus6axRXlv6L5LZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVEgLxqQRk5YBa3Q4EXLIkF/0zZMsN8fEu04UrpN/r3XzcvN3xB5+2FY5sV0wIvcJ4q3B/1eoIJv/8EACPcJCzV8uROuS71levySU0rK043RFkzA4WbFOZzO1s0UuvwXaawqTEHkNPVuMN2rhfv19HKfsoX2npFfWH++bxyzS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=b7Yoikxr; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id C31BB2E0999D;
	Thu, 13 Mar 2025 22:58:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741899520;
	bh=Y5VrSNdlsgJQoubN0CAtgMrTyGcggYC2+C8A79hNoGg=;
	h=Received:From:Subject:To;
	b=b7YoikxrejUqbDJgJG2FEKT1MgIumkC/ZLTFGIfvlZ74XLKyUgWHss8kFvRsxg9BT
	 JvK123SrnyaRN5US6UFU2KR7LIJRi64xvqPz21bUm0c7Ct+T2gAnVkHBbfgRRAQJJE
	 KgCgi0M40tfaZ8yVif1V/msq1ZeyrS7TYA1GcEFk=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-307c13298eeso16794601fa.0;
        Thu, 13 Mar 2025 13:58:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVElnud0s3mHVmVQaTxtWvhmX65hpqFc/37eWpqMW0xnYN3NVtMBNx5B4lhb5lmOSSBxkSmfZYDN0c=@vger.kernel.org,
 AJvYcCWMxoabzEGmRsJLQUigukJ1wmcV5CPX0GJs9O+hHxfuNHhma9nH7qIiWrq8LL4nqPjdpp/9/u1ql2pnKNIc@vger.kernel.org,
 AJvYcCXiy96Qee2GDRlxF9SIYzlOvLOSYyVR8ZZOfG39ki93x6GwhM5lL+VRvDT6HUvoo2kk8rDu+S/0h5rh7Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhICELr4MKRcp8Rk0lLtABHtxQLIZVbLXwXjGn9xfVnnAEAdrd
	joHBRAMc0opj5YyQtMxyPiOuU/ZOjA5sS7aQ5X5PDc6vFacIw+tdAGCoKDW/iq4SpodawJoLP+v
	PicztmMeTPYJUkQKEVY0NwJN8Pfw=
X-Google-Smtp-Source: 
 AGHT+IFVP2z7pKlq2maJuuMlyQM96aJotIRkeu4CsibblhQYwRjJaI00Z/V6Tm+b2Z5A/RkkyK7mrtpF1KQlceOALdU=
X-Received: by 2002:a2e:a985:0:b0:30c:799:8418 with SMTP id
 38308e7fff4ca-30c3dd13dd4mr16284171fa.4.1741899518912; Thu, 13 Mar 2025
 13:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
 <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
In-Reply-To: <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 13 Mar 2025 21:58:27 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
X-Gm-Features: AQ5f1JpUweQBsjYFek3ctv1nypRPZzbamtcli6P4-dMtP8MdB-GFwb0CiLd94TU
Message-ID: 
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Cryolitia@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
	someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>,
	command_block <mtf@ik.me>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174189952030.30846.1271750701143063826@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 13 Mar 2025 at 21:10, Cryolitia PukNgae via B4 Relay
<devnull+Cryolitia.gmail.com@kernel.org> wrote:
>
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
>
> Sensors driver for GPD Handhelds that expose fan reading and control via
> hwmon sysfs.
>
> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
> devices. This driver implements these functions through x86 port-mapped IO.
>
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> ---
>  MAINTAINERS             |   6 +
>  drivers/hwmon/Kconfig   |  10 +
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/gpd-fan.c | 681 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 698 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0fa7c5728f1e64d031f4a47b6fce1db484ce0fc2..777ba74ccb07ccc0840c3cd34e7b4d98d726f964 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9762,6 +9762,12 @@ F:       drivers/phy/samsung/phy-gs101-ufs.c
>  F:     include/dt-bindings/clock/google,gs101.h
>  K:     [gG]oogle.?[tT]ensor
>
> +GPD FAN DRIVER
> +M:     Cryolitia PukNgae <Cryolitia@gmail.com>
> +L:     linux-hwmon@vger.kernel.org
> +S:     Maintained
> +F:     drivers/hwmon/gpd-fan.c

A problem we had with oxp sensors is that once OneXPlayer expanded
their EC to include e.g., battery capacity limits, it was no longer
appropriate for it to reside in hwmon. I expect GPD to do the same
sometime in the near future. If that is the case, should we
futureproof the driver by moving it to platform-x86 right away?

> +
>  GPD POCKET FAN DRIVER
>  M:     Hans de Goede <hdegoede@redhat.com>
>  L:     platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index dd376602f3f19c6f258651afeffbe1bb5d9b6b72..974b341c0bdaba147370de59f510140c0c937913 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -729,6 +729,16 @@ config SENSORS_GL520SM
>           This driver can also be built as a module. If so, the module
>           will be called gl520sm.
>
> +config SENSORS_GPD
> +       tristate "GPD handhelds"
> +       depends on X86
> +       help
> +         If you say yes here you get support for fan readings and
> +         control over GPD handheld devices.
> +
> +         Can also be built as a module. In that case it will be
> +         called gpd-fan.
> +
>  config SENSORS_G760A
>         tristate "GMT G760A"
>         depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b827b92f2a7844418f3f3b6434a63b744b52c33d..cd512c19caa9737a2926a3d4860f65b65cd013c3 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) += gigabyte_waterforce.o
>  obj-$(CONFIG_SENSORS_GL518SM)  += gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)  += gl520sm.o
>  obj-$(CONFIG_SENSORS_GSC)      += gsc-hwmon.o
> +obj-$(CONFIG_SENSORS_GPD)      += gpd-fan.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN) += gpio-fan.o
>  obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
>  obj-$(CONFIG_SENSORS_HIH6130)  += hih6130.o
> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..782c9981d5357b11faad4e6cd75242828e667f95
> --- /dev/null
> +++ b/drivers/hwmon/gpd-fan.c
> @@ -0,0 +1,681 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/* Platform driver for GPD devices that expose fan control via hwmon sysfs.
> + *
> + * Fan control is provided via pwm interface in the range [0-255].
> + * Each model has a different range in the EC, the written value is scaled to
> + * accommodate for that.
> + *
> + * Based on this repo:
> + * https://github.com/Cryolitia/gpd-fan-driver

Perhaps the github link will date this. I would remove it.

> + *
> + * Copyright (c) 2024 Cryolitia PukNgae
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "gpdfan"
> +#define GPD_PWM_CTR_OFFSET 0x1841
> +
> +static char *gpd_fan_board = "";
> +module_param(gpd_fan_board, charp, 0444);
> +
> +// EC read/write locker
> +// Should never access EC at the same time, otherwise system down.

These two comments could use some rewording. E.g., Prevent access to
the EC at the same time to avoid system instability.

> +static DEFINE_MUTEX(gpd_fan_lock);
> +
> +enum gpd_board {
> +       win_mini,
> +       win4_6800u,
> +       win_max_2,
> +};
> +
> +enum FAN_PWM_ENABLE {
> +       DISABLE         = 0,
> +       MANUAL          = 1,
> +       AUTOMATIC       = 2,
> +};
> +
> +static struct {
> +       enum FAN_PWM_ENABLE pwm_enable;
> +       u8 pwm_value;
> +
> +       const struct gpd_fan_drvdata *drvdata;
> +} gpd_driver_priv;
> +
> +struct gpd_fan_drvdata {
> +       const char *board_name; /* Board name for module param comparison */
> +       const enum gpd_board board;
> +
> +       const u8 addr_port;
> +       const u8 data_port;
> +       const u16 manual_control_enable;
> +       const u16 rpm_read;
> +       const u16 pwm_write;
> +       const u16 pwm_max;
> +};
> +
> +static struct gpd_fan_drvdata gpd_win_mini_drvdata = {
> +       .board_name             = "win_mini",
> +       .board                  = win_mini,
> +
> +       .addr_port              = 0x4E,
> +       .data_port              = 0x4F,
> +       .manual_control_enable  = 0x047A,
> +       .rpm_read               = 0x0478,
> +       .pwm_write              = 0x047A,
> +       .pwm_max                = 244,
> +};
> +
> +static struct gpd_fan_drvdata gpd_win4_drvdata = {
> +       .board_name             = "win4",
> +       .board                  = win4_6800u,
> +
> +       .addr_port              = 0x2E,
> +       .data_port              = 0x2F,
> +       .manual_control_enable  = 0xC311,
> +       .rpm_read               = 0xC880,
> +       .pwm_write              = 0xC311,
> +       .pwm_max                = 127,
> +};
> +
> +static struct gpd_fan_drvdata gpd_wm2_drvdata = {
> +       .board_name             = "wm2",
> +       .board                  = win_max_2,
> +
> +       .addr_port              = 0x4E,
> +       .data_port              = 0x4F,
> +       .manual_control_enable  = 0x0275,
> +       .rpm_read               = 0x0218,
> +       .pwm_write              = 0x1809,
> +       .pwm_max                = 184,
> +};
> +
> +static const struct dmi_system_id dmi_table[] = {
> +       {
> +               // GPD Win Mini
> +               // GPD Win Mini with AMD Ryzen 8840U
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1617-01")
> +               },
> +               .driver_data = &gpd_win_mini_drvdata,
> +       },
> +       {
> +               // GPD Win Mini
> +               // GPD Win Mini with AMD Ryzen HX370
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1617-02")
> +               },
> +               .driver_data = &gpd_win_mini_drvdata,
> +       },
> +       {
> +               // GPD Win Mini
> +               // GPD Win Mini with AMD Ryzen HX370
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1617-02-L")
> +               },
> +               .driver_data = &gpd_win_mini_drvdata,
> +       },
> +       {
> +               // GPD Win 4 with AMD Ryzen 6800U
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
> +                       DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
> +               },
> +               .driver_data = &gpd_win4_drvdata,
> +       },
> +       {
> +               // GPD Win 4 with Ryzen 7840U
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
> +                       DMI_MATCH(DMI_BOARD_VERSION, "Ver. 1.0"),
> +               },
> +               // Since 7840U, win4 uses the same drvdata as wm2
> +               .driver_data = &gpd_wm2_drvdata,
> +       },
> +       {
> +               // GPD Win 4 with Ryzen 7840U (another)
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
> +                       DMI_MATCH(DMI_BOARD_VERSION, "Ver.1.0"),
> +               },
> +               .driver_data = &gpd_wm2_drvdata,
> +       },
> +       {
> +               // GPD Win Max 2 with Ryzen 6800U
> +               // GPD Win Max 2 2023 with Ryzen 7840U
> +               // GPD Win Max 2 2024 with Ryzen 8840U
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
> +               },
> +               .driver_data = &gpd_wm2_drvdata,
> +       },
> +       {
> +               // GPD Win Max 2 with AMD Ryzen HX370
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1619-05"),
> +               },
> +               .driver_data = &gpd_wm2_drvdata,
> +       },
> +       {
> +               // GPD Pocket 4
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1628-04"),
> +               },
> +               .driver_data = &gpd_win_mini_drvdata,
> +       },
> +       {
> +               // GPD Pocket 4 (another)
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1628-04-L"),
> +               },
> +               .driver_data = &gpd_win_mini_drvdata,
> +       },
> +       {}
> +};
> +
> +static const struct gpd_fan_drvdata *gpd_module_drvdata[] = {
> +       &gpd_win_mini_drvdata, &gpd_win4_drvdata, &gpd_wm2_drvdata, NULL
> +};
> +
> +/* Helper functions to handle EC read/write */
> +static int gpd_ecram_read(const struct gpd_fan_drvdata *drvdata, u16 offset,
> +                         u8 *val)
> +{
> +       int ret;
> +       u16 addr_port = drvdata->addr_port;
> +       u16 data_port = drvdata->data_port;
> +
> +       ret = mutex_lock_interruptible(&gpd_fan_lock);
> +
> +       if (ret)
> +               return ret;
> +
> +       outb(0x2E, addr_port);
> +       outb(0x11, data_port);
> +       outb(0x2F, addr_port);
> +       outb((u8)((offset >> 8) & 0xFF), data_port);
> +
> +       outb(0x2E, addr_port);
> +       outb(0x10, data_port);
> +       outb(0x2F, addr_port);
> +       outb((u8)(offset & 0xFF), data_port);
> +
> +       outb(0x2E, addr_port);
> +       outb(0x12, data_port);
> +       outb(0x2F, addr_port);
> +       *val = inb(data_port);
> +
> +       mutex_unlock(&gpd_fan_lock);
> +       return 0;
> +}

One concern I had with this driver while using it is that ACPI might
have access to this EC. If that is the case, then this mutex is not
exclusive and that could cause some instability. You can reference
oxp-sensors for an ACPI lock.

Although, if I am being honest, the lock in oxp-sensors is probably
duplicative because ec_read already holds a mutex. In your case, you
do not use ec_read so it is not.

> +
> +static int gpd_ecram_write(const struct gpd_fan_drvdata *drvdata, u16 offset,
> +                          u8 value)
> +{
> +       int ret;
> +       u16 addr_port = drvdata->addr_port;
> +       u16 data_port = drvdata->data_port;
> +
> +       ret = mutex_lock_interruptible(&gpd_fan_lock);
> +
> +       if (ret)
> +               return ret;
> +
> +       outb(0x2E, addr_port);
> +       outb(0x11, data_port);
> +       outb(0x2F, addr_port);
> +       outb((u8)((offset >> 8) & 0xFF), data_port);
> +
> +       outb(0x2E, addr_port);
> +       outb(0x10, data_port);
> +       outb(0x2F, addr_port);
> +       outb((u8)(offset & 0xFF), data_port);
> +
> +       outb(0x2E, addr_port);
> +       outb(0x12, data_port);
> +       outb(0x2F, addr_port);
> +       outb(value, data_port);
> +
> +       mutex_unlock(&gpd_fan_lock);
> +       return 0;
> +}
> +
> +static int gpd_generic_read_rpm(void)
> +{
> +       u8 high, low;
> +       int ret;
> +       const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
> +
> +       ret = gpd_ecram_read(drvdata, drvdata->rpm_read, &high);
> +       if (ret)
> +               return ret;
> +
> +       ret = gpd_ecram_read(drvdata, drvdata->rpm_read + 1, &low);
> +       if (ret)
> +               return ret;
> +
> +       return (u16)high << 8 | low;
> +}
> +
> +static int gpd_win4_read_rpm(void)
> +{
> +       const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
> +       u8 pwm_ctr_reg;
> +       int ret;
> +
> +       gpd_ecram_read(drvdata, GPD_PWM_CTR_OFFSET, &pwm_ctr_reg);
> +
> +       if (pwm_ctr_reg != 0x7F)
> +               gpd_ecram_write(drvdata, GPD_PWM_CTR_OFFSET, 0x7F);
> +
> +       ret = gpd_generic_read_rpm();
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       if (ret == 0) {
> +               // re-init EC
> +               u8 chip_id;
> +
> +               gpd_ecram_read(drvdata, 0x2000, &chip_id);
> +               if (chip_id == 0x55) {
> +                       u8 chip_ver;
> +
> +                       if (gpd_ecram_read(drvdata, 0x1060, &chip_ver))
> +                               gpd_ecram_write(drvdata, 0x1060,
> +                                               chip_ver | 0x80);
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int gpd_wm2_read_rpm(void)
> +{
> +       const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
> +
> +       for (u16 pwm_ctr_offset = GPD_PWM_CTR_OFFSET;
> +            pwm_ctr_offset <= GPD_PWM_CTR_OFFSET + 2; pwm_ctr_offset++) {
> +               u8 PWMCTR;
> +
> +               gpd_ecram_read(drvdata, pwm_ctr_offset, &PWMCTR);
> +
> +               if (PWMCTR != 0xB8)
> +                       gpd_ecram_write(drvdata, pwm_ctr_offset, 0xB8);
> +       }
> +
> +       return gpd_generic_read_rpm();
> +}
> +
> +// Read value for fan1_input
> +static int gpd_read_rpm(void)
> +{
> +       switch (gpd_driver_priv.drvdata->board) {
> +       case win_mini:
> +               return gpd_generic_read_rpm();
> +       case win4_6800u:
> +               return gpd_win4_read_rpm();
> +       case win_max_2:
> +               return gpd_wm2_read_rpm();
> +       }
> +
> +       return 0;
> +}
> +
> +static int gpd_wm2_read_pwm(void)
> +{
> +       const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
> +       u8 var;
> +       int ret = gpd_ecram_read(drvdata, drvdata->pwm_write, &var);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return var * 255 / drvdata->pwm_max;
> +}
> +
> +// Read value for pwm1
> +static int gpd_read_pwm(void)
> +{
> +       switch (gpd_driver_priv.drvdata->board) {
> +       case win_mini:
> +       case win4_6800u:
> +               return gpd_driver_priv.pwm_value;
> +       case win_max_2:
> +               return gpd_wm2_read_pwm();
> +       }
> +       return 0;
> +}
> +
> +static int gpd_generic_write_pwm(u8 val)
> +{
> +       const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
> +       u8 pwm_reg;
> +
> +       // PWM value's range in EC is 1 - pwm_max, cast 0 - 255 to it.
> +       pwm_reg = val * (drvdata->pwm_max - 1) / 255 + 1;
> +       return gpd_ecram_write(drvdata, drvdata->pwm_write, pwm_reg);
> +}
> +
> +static int gpd_win_mini_write_pwm(u8 val)
> +{
> +       if (gpd_driver_priv.pwm_enable == MANUAL)
> +               return gpd_generic_write_pwm(val);
> +       else
> +               return -EPERM;
> +}
> +
> +static int gpd_wm2_write_pwm(u8 val)
> +{
> +       if (gpd_driver_priv.pwm_enable != DISABLE)
> +               return gpd_generic_write_pwm(val);
> +       else
> +               return -EPERM;
> +}
> +
> +// Write value for pwm1
> +static int gpd_write_pwm(u8 val)
> +{
> +       switch (gpd_driver_priv.drvdata->board) {
> +       case win_mini:
> +               return gpd_win_mini_write_pwm(val);
> +       case win4_6800u:
> +               return gpd_generic_write_pwm(val);
> +       case win_max_2:
> +               return gpd_wm2_write_pwm(val);
> +       }
> +
> +       return 0;
> +}
> +
> +static int gpd_win_mini_set_pwm_enable(enum FAN_PWM_ENABLE pwm_enable)
> +{
> +       const struct gpd_fan_drvdata *drvdata;
> +
> +       switch (pwm_enable) {
> +       case DISABLE:
> +               return gpd_generic_write_pwm(255);
> +       case MANUAL:
> +               return gpd_generic_write_pwm(gpd_driver_priv.pwm_value);
> +       case AUTOMATIC:
> +               drvdata = gpd_driver_priv.drvdata;
> +               return gpd_ecram_write(drvdata, drvdata->pwm_write, 0);
> +       }
> +
> +       return 0;
> +}
> +
> +static int gpd_wm2_set_pwm_enable(enum FAN_PWM_ENABLE enable)
> +{
> +       const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
> +       int ret;
> +
> +       switch (enable) {
> +       case DISABLE: {
> +               ret = gpd_generic_write_pwm(255);
> +
> +               if (ret)
> +                       return ret;
> +
> +               return gpd_ecram_write(drvdata, drvdata->manual_control_enable,
> +                                      1);
> +       }
> +       case MANUAL: {
> +               ret = gpd_generic_write_pwm(gpd_driver_priv.pwm_value);
> +
> +               if (ret)
> +                       return ret;
> +
> +               return gpd_ecram_write(drvdata, drvdata->manual_control_enable,
> +                                      1);
> +       }
> +       case AUTOMATIC: {
> +               ret = gpd_ecram_write(drvdata, drvdata->manual_control_enable,
> +                                     0);
> +
> +               return ret;
> +       }
> +       }
> +
> +       return 0;
> +}
> +
> +// Write value for pwm1_enable
> +static int gpd_set_pwm_enable(enum FAN_PWM_ENABLE enable)
> +{
> +       switch (gpd_driver_priv.drvdata->board) {
> +       case win_mini:
> +       case win4_6800u:
> +               return gpd_win_mini_set_pwm_enable(enable);
> +       case win_max_2:
> +               return gpd_wm2_set_pwm_enable(enable);
> +       }
> +
> +       return 0;
> +}
> +
> +static umode_t gpd_fan_hwmon_is_visible(__always_unused const void *drvdata,
> +                                       enum hwmon_sensor_types type, u32 attr,
> +                                       __always_unused int channel)
> +{
> +       if (type == hwmon_fan && attr == hwmon_fan_input) {
> +               return 0444;
> +       } else if (type == hwmon_pwm) {
> +               switch (attr) {
> +               case hwmon_pwm_enable:
> +               case hwmon_pwm_input:
> +                       return 0644;
> +               default:
> +                       return 0;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int gpd_fan_hwmon_read(__always_unused struct device *dev,
> +                             enum hwmon_sensor_types type, u32 attr,
> +                             __always_unused int channel, long *val)
> +{
> +       if (type == hwmon_fan) {
> +               if (attr == hwmon_fan_input) {
> +                       int ret = gpd_read_rpm();
> +
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       *val = ret;
> +                       return 0;
> +               }
> +               return -EOPNOTSUPP;
> +       } else if (type == hwmon_pwm) {
> +               int ret;
> +
> +               switch (attr) {
> +               case hwmon_pwm_enable:
> +                       *val = gpd_driver_priv.pwm_enable;
> +                       return 0;
> +               case hwmon_pwm_input:
> +                       ret = gpd_read_pwm();
> +
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       *val = ret;
> +                       return 0;
> +               default:
> +                       return -EOPNOTSUPP;
> +               }
> +       }
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +static int gpd_fan_hwmon_write(__always_unused struct device *dev,
> +                              enum hwmon_sensor_types type, u32 attr,
> +                              __always_unused int channel, long val)
> +{
> +       u8 var;
> +
> +       if (type == hwmon_pwm) {
> +               switch (attr) {
> +               case hwmon_pwm_enable:
> +                       if (!in_range(val, 0, 3))
> +                               return -EINVAL;
> +
> +                       gpd_driver_priv.pwm_enable = val;
> +
> +                       return gpd_set_pwm_enable(gpd_driver_priv.pwm_enable);
> +               case hwmon_pwm_input:
> +                       var = clamp_val(val, 0, 255);
> +
> +                       gpd_driver_priv.pwm_value = var;
> +
> +                       return gpd_write_pwm(var);
> +               default:
> +                       return -EOPNOTSUPP;
> +               }
> +       }
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops gpd_fan_ops = {
> +       .is_visible = gpd_fan_hwmon_is_visible,
> +       .read = gpd_fan_hwmon_read,
> +       .write = gpd_fan_hwmon_write,
> +};
> +
> +static const struct hwmon_channel_info *gpd_fan_hwmon_channel_info[] = {
> +       HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +       HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +       NULL
> +};
> +
> +static struct hwmon_chip_info gpd_fan_chip_info = {
> +       .ops = &gpd_fan_ops,
> +       .info = gpd_fan_hwmon_channel_info
> +};
> +
> +static int gpd_fan_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct resource *res;
> +       const struct device *hwdev;
> +       const struct resource *region;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +       if (IS_ERR(res))
> +               return dev_err_probe(dev, PTR_ERR(res),
> +                                    "Failed to get platform resource\n");
> +
> +       region = devm_request_region(dev, res->start,
> +                                    resource_size(res), DRIVER_NAME);
> +       if (IS_ERR(region))
> +               return dev_err_probe(dev, PTR_ERR(region),
> +                                    "Failed to request region\n");
> +
> +       hwdev = devm_hwmon_device_register_with_info(dev,
> +                                                    DRIVER_NAME,
> +                                                    NULL,
> +                                                    &gpd_fan_chip_info,
> +                                                    NULL);
> +       if (IS_ERR(hwdev))
> +               return dev_err_probe(dev, PTR_ERR(region),
> +                                    "Failed to register hwmon device\n");
> +
> +       return 0;
> +}
> +
> +static void gpd_fan_remove(__always_unused struct platform_device *pdev)
> +{
> +       gpd_driver_priv.pwm_enable = AUTOMATIC;
> +       gpd_set_pwm_enable(AUTOMATIC);
> +}
> +
> +static struct platform_driver gpd_fan_driver = {
> +       .probe = gpd_fan_probe,
> +       .remove = gpd_fan_remove,
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +       },
> +};
> +
> +static struct platform_device *gpd_fan_platform_device;
> +
> +static int __init gpd_fan_init(void)
> +{
> +       const struct gpd_fan_drvdata *match = NULL;
> +
> +       for (const struct gpd_fan_drvdata **p = gpd_module_drvdata; *p; p++) {
> +               if (strcmp(gpd_fan_board, (*p)->board_name) == 0) {
> +                       match = *p;
> +                       break;
> +               }
> +       }
> +
> +       if (!match) {
> +               const struct dmi_system_id *dmi_match =
> +                       dmi_first_match(dmi_table);
> +               if (dmi_match)
> +                       match = dmi_match->driver_data;
> +       }
> +
> +       if (!match)
> +               return -ENODEV;
> +
> +       gpd_driver_priv.pwm_enable = AUTOMATIC;
> +       gpd_driver_priv.pwm_value = 255;
> +       gpd_driver_priv.drvdata = match;
> +
> +       struct resource gpd_fan_resources[] = {
> +               {
> +                       .start = match->addr_port,
> +                       .end = match->data_port,
> +                       .flags = IORESOURCE_IO,
> +               },
> +       };
> +
> +       gpd_fan_platform_device = platform_create_bundle(&gpd_fan_driver,
> +                                                        gpd_fan_probe,
> +                                                        gpd_fan_resources,
> +                                                        1, NULL, 0);
> +
> +       if (IS_ERR(gpd_fan_platform_device)) {
> +               pr_warn("Failed to create platform device\n");
> +               return PTR_ERR(gpd_fan_platform_device);
> +       }
> +
> +       return 0;
> +}
> +
> +static void __exit gpd_fan_exit(void)
> +{
> +       platform_device_unregister(gpd_fan_platform_device);
> +       platform_driver_unregister(&gpd_fan_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(dmi, dmi_table);
> +
> +module_init(gpd_fan_init);
> +module_exit(gpd_fan_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Cryolitia PukNgae <Cryolitia@gmail.com>");
> +MODULE_DESCRIPTION("GPD Devices fan control driver");
>
> --
> 2.48.1
>
>

I will try to swap from the dkms variant to this series soon.

Best,
Antheas

