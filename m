Return-Path: <linux-kernel+bounces-256903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68693720F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29EB1C20B50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B423B0;
	Fri, 19 Jul 2024 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfsjEDq8"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7C15CB;
	Fri, 19 Jul 2024 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721353292; cv=none; b=cBJ9ClIOuW2vYNsro1wnjIMZ9zANzOJMFcBDV2YV4XHU3iYECrgJqkKX3tPyq8yk1x3KMXtPiibsx3obmKAMcJrNdukGgNPoANsAH6VucjSAzcJ7n/VuBPRh6+qIafE9w6wTWzoypwJP1/0L9nV+vHRji+BAqUvDHA191DOPH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721353292; c=relaxed/simple;
	bh=q1EGcJk7RyObbqMA8od6LNN+T+wtm1aJy635Z9rzEUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shTEqLUIzBdiz1G16ri/3xaUHXepYVPGX+QDDl3Pz5cAay2cioeztcvOSk+OVO2+jbb2LNhRzUPKb5XS7UKaVHrBNscW3dhEkWWUsA4Z3QG2wdMb+2J8e51ohpyPwIay+wfaDy5aJqXRH0nCYhpp9rXnHgVJ8VD7+ysBEJn58r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfsjEDq8; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70365f905b6so880024a34.0;
        Thu, 18 Jul 2024 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721353288; x=1721958088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l50yEJglWf59Kiv3Q4rkQjT11IyhbXOFeWDA0N9D3Xo=;
        b=hfsjEDq81joSuctTLnIslSWQ5CBwxxCIQtGEecdLTkasfnTYzxX2ssJSVyIbDmZUOc
         kv/CnS4uiIshLb1Z+kryppISAHgT7yihT60YkiYrhy1zzHCRRP6rOxilOrMkhdDtveq1
         1IXd/qf//d68Co3jV0n3+jW0ND2EOUXrPemytRhbznPxKrIHv0zi8gJtPqzzaPUUGWqJ
         flIvabbVqUVtwrhAPLse554qjjoFQxqhIME4avGr13oxSaqIyX+tidgEsg+x0R1NzG9N
         aVUTWpQ1tD3Pubgx6h9keAy2V+O3x7zXmzXpxksowTdEuyN+wB/XlPgZMMwiVd5ArJLf
         Yg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721353288; x=1721958088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l50yEJglWf59Kiv3Q4rkQjT11IyhbXOFeWDA0N9D3Xo=;
        b=txWzNT+4phG86PvHlA01g8/VuSYaj0VCe2YeRZTjTnpN25jXAfoIStsfPAIXS1kzrX
         CWKeyRjyPSK6QZNC0NZgiU44zv/vEr3AXOR2gF7rewBNhCRU10f8CWlQw+qb8pFp+kzI
         Vbu9Z/Gc66SOKhHj1tPKF4T6po9dX1iOMZfZnBSw1OTyTdCtBpPeqT1y3/Q4faJMp5qu
         dsMnCfOHHbrBzvuq0DjoO38kqY2sRsSLRbUHkxvSyuCS18iUCxD6O0N+UYi1nz6xw/EK
         4l93AebuQqxlNVRiKbmLtDgEK4gcEhEU49wjRAdAxUQx571Nc66OM7JpnNdqHkK3TZcD
         zBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzoctoqyngiGaAYRaAFcQpDFrsEgx4Ja0NaphcZj3OdcqcEtISwa4vcEl2js4OjVR6LW54Vw4EI/unrheN8jlG+xxJ7W/HcTd4td4VrRP4c5XspGlXerLnu5ihQXL0EmOpezqk8FmY9iWjAOciKx66ODzmhVGiWp9WwOj7nJJLqabnomI=
X-Gm-Message-State: AOJu0YyPmYUwDX1bUQJJKc53WnvoLsjYG1ev5wCaOTGpQxRf68uw7/8J
	9CvURvzFC5fAniFMuKhHAyIZe36F36OMCOYg58TiP4CoH1+PG5fShAhbmA==
X-Google-Smtp-Source: AGHT+IF98V3E7w+t57G9S4XLmMpHHgI2yPU+N4xjbu4dXlOuejsIXmUDLlWMq0kANMfV29v5HWf/4g==
X-Received: by 2002:a05:6870:7252:b0:25e:5ff:7591 with SMTP id 586e51a60fabf-260d91cba0cmr6134692fac.22.1721353288188;
        Thu, 18 Jul 2024 18:41:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff6168e6sm177996b3a.212.2024.07.18.18.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 18:41:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Jul 2024 18:41:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cryolitia@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	Marcin =?utf-8?Q?Str=C4=85gowski?= <marcin@stragowski.com>
Subject: Re: [PATCH v4 1/2] hwmon: add GPD devices sensor driver
Message-ID: <cf41c18f-8b35-4970-a274-2834a15c9f08@roeck-us.net>
References: <20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com>
 <20240718-gpd_fan-v4-1-116e5431a9fe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240718-gpd_fan-v4-1-116e5431a9fe@gmail.com>

On Thu, Jul 18, 2024 at 10:22:23AM +0800, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> Sensors driver for GPD Handhelds that expose fan reading and control via
> hwmon sysfs.
> 
> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
> devices. This driver implements these functions through x86 port-mapped IO.
> I have only tested it on my device Win Max 2 2023.
> 
> Tested-by: Marcin Strągowski <marcin@stragowski.com>
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>

I am havng a hard time reviewing this driver. I am going to pint out a few
issues, but this is far from a complete review.

Guenter

> ---
>  MAINTAINERS             |   6 +
>  drivers/hwmon/Kconfig   |  10 +
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/gpd-fan.c | 683 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 700 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af4b4c271342..9ced72cec42b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9372,6 +9372,12 @@ F:	drivers/phy/samsung/phy-gs101-ufs.c
>  F:	include/dt-bindings/clock/google,gs101.h
>  K:	[gG]oogle.?[tT]ensor
>  
> +GPD FAN DRIVER
> +M:	Cryolitia PukNgae <Cryolitia@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/gpd-fan.c
> +
>  GPD POCKET FAN DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b60fe2e58ad6..368165a25979 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -727,6 +727,16 @@ config SENSORS_GL520SM
>  	  This driver can also be built as a module. If so, the module
>  	  will be called gl520sm.
>  
> +config SENSORS_GPD
> +	tristate "GPD EC fan control"
> +	depends on X86
> +	help
> +	  If you say yes here you get support for fan readings and
> +	  control over GPD handheld devices.
> +
> +	  Can also be built as a module. In that case it will be
> +	  called gpd-fan.
> +
>  config SENSORS_G760A
>  	tristate "GMT G760A"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b1c7056c37db..91c288451290 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) += gigabyte_waterforce.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
> +obj-$(CONFIG_SENSORS_GPD)	+= gpd-fan.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
>  obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
>  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
> new file mode 100644
> index 000000000000..7cf435ef1f1d
> --- /dev/null
> +++ b/drivers/hwmon/gpd-fan.c
> @@ -0,0 +1,683 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2024 Cryolitia PukNgae
> +
> +/*
> + * Based on this repo:
> + * https://github.com/Cryolitia/gpd-fan-driver
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/ioport.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME	"gpdfan"
> +
> +// model param, see document
> +static char *gpd_fan_model = "";
> +module_param(gpd_fan_model, charp, 0444);
> +
> +// EC read/write locker
> +// Should never access EC at the same time, otherwise system down.
> +static DEFINE_MUTEX(gpd_fan_lock);
> +
> +// general struct declare start
> +
> +enum FAN_PWM_ENABLE {
> +	DISABLE = 0,
> +	MANUAL = 1,
> +	AUTOMATIC = 2,
> +};
> +
> +struct gpd_driver_priv {
> +	enum FAN_PWM_ENABLE pwm_enable;
> +	u8 pwm_value;
> +
> +	u16 fan_speed_cached;
> +	u8 read_pwm_cached;
> +
> +	unsigned long fan_speed_last_update;
> +	unsigned long read_pwm_last_update;
> +
> +	const struct gpd_model_quirk *const quirk;

What is the benefit of declaring the _pointer_ a constant ?

> +};
> +
> +struct gpd_model_ec_address {
> +	const u8 addr_port;
> +	const u8 data_port;
> +	const u16 manual_control_enable;
> +	const u16 rpm_read;
> +	const u16 pwm_write;
> +	const u16 pwm_max;
> +};
> +
> +struct gpd_model_quirk {
> +	const char *model_name;
> +	const struct gpd_model_ec_address address;
> +
> +	s32 (*read_rpm)(struct gpd_driver_priv *data);
> +	int (*set_pwm_enable)(struct gpd_driver_priv *data,
> +			      enum FAN_PWM_ENABLE);
> +	s16 (*read_pwm)(struct gpd_driver_priv *data);
> +	int (*write_pwm)(const struct gpd_driver_priv *data, u8 val);
> +};
> +
> +// general struct declare end
> +
> +// model quirk function declare start
> +
> +static s32 gpd_read_rpm(struct gpd_driver_priv *data);
> +static s16 gpd_read_pwm(struct gpd_driver_priv *data);
> +static int gpd_write_pwm(const struct gpd_driver_priv *data, u8 val);
> +
> +static int gpd_win_mini_set_pwm_enable(struct gpd_driver_priv *data,
> +				       enum FAN_PWM_ENABLE pwm_enable);
> +static int gpd_win_mini_write_pwm(const struct gpd_driver_priv *data, u8 val);
> +
> +static s32 gpd_win4_read_rpm(struct gpd_driver_priv *data);
> +
> +static s32 gpd_wm2_read_rpm(struct gpd_driver_priv *data);
> +static s16 gpd_wm2_read_pwm(struct gpd_driver_priv *data);
> +static int gpd_wm2_set_pwm_enable(struct gpd_driver_priv *data,
> +				  enum FAN_PWM_ENABLE enable);
> +static int gpd_wm2_write_pwm(const struct gpd_driver_priv *data, u8 val);
> +

Forward declarations point to a bad driver design. Please reorder the code
to avoid it.

> +// model quirk function declare end
> +
> +// model quirk struct declare start
> +

Isn't that obvious ?

> +static const struct gpd_model_quirk gpd_win_mini_quirk = {
> +	.model_name	= "win_mini",
> +	.address	= {
> +				.addr_port		= 0x4E,
> +				.data_port		= 0x4F,
> +				.manual_control_enable	= 0x047A,
> +				.rpm_read		= 0x0478,
> +				.pwm_write		= 0x047A,
> +				.pwm_max		= 244,
> +			},
> +	.read_rpm	= gpd_read_rpm,
> +	.set_pwm_enable	= gpd_win_mini_set_pwm_enable,
> +	.read_pwm	= gpd_read_pwm,
> +	.write_pwm	= gpd_win_mini_write_pwm,

I am not in favor of those embedded function pointers, just like I
am not in favor of function pointers passed as arguments. Both make
the code difficult to read and understand. I would suggest to consider
changing the code to avoid it.
, 
> +};
> +
> +static const struct gpd_model_quirk gpd_win4_quirk = {
> +	.model_name	= "win4",
> +	.address	= {
> +				.addr_port		= 0x2E,
> +				.data_port		= 0x2F,
> +				.manual_control_enable	= 0xC311,
> +				.rpm_read		= 0xC880,
> +				.pwm_write		= 0xC311,
> +				.pwm_max		= 127,
> +			},
> +	.read_rpm	= gpd_win4_read_rpm,
> +	// same as GPD Win Mini
> +	.set_pwm_enable	= gpd_win_mini_set_pwm_enable,
> +	.read_pwm	= gpd_read_pwm,
> +	// same as GPD Win Mini

I do not see te value in those comments.

> +	.write_pwm	= gpd_win_mini_write_pwm,
> +};
> +
> +static const struct gpd_model_quirk gpd_wm2_quirk = {
> +	.model_name	= "wm2",
> +	.address	= {
> +				.addr_port		= 0x4E,
> +				.data_port		= 0x4F,
> +				.manual_control_enable	= 0x0275,
> +				.rpm_read		= 0x0218,
> +				.pwm_write		= 0x1809,
> +				.pwm_max		= 184,
> +			},
> +	.read_rpm	= gpd_wm2_read_rpm,
> +	.set_pwm_enable	= gpd_wm2_set_pwm_enable,
> +	.read_pwm	= gpd_wm2_read_pwm,
> +	.write_pwm	= gpd_wm2_write_pwm,
> +};
> +
> +// model quirk struct declare end
> +
Isn't that obvious ?

> +static const struct dmi_system_id gpd_devices[] = {
> +	{
> +		// GPD Win Mini
> +		// GPD Win Mini with AMD Ryzen 8840U
> +		.matches	= {
> +					DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +					DMI_MATCH(DMI_PRODUCT_NAME, "G1617-01")
> +				},
> +		.driver_data	= &gpd_win_mini_quirk,

As 0-day points out, .driver data is not a pointer to a constant.

> +	},
> +	{
> +		// GPD Win 4 with AMD Ryzen 6800U
> +		.matches	= {
> +					DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +					DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
> +					DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
> +				},
> +		.driver_data	= &gpd_win4_quirk,
> +	},
> +	{
> +		// GPD Win 4 with Ryzen 7840U
> +		.matches	= {
> +					DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +					DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
> +					DMI_MATCH(DMI_BOARD_VERSION, "Ver. 1.0"),
> +				},
> +		.driver_data	= &gpd_wm2_quirk,
> +	},
> +	{
> +		// GPD Win Max 2 with Ryzen 6800U
> +		// GPD Win Max 2 2023 with Ryzen 7840U
> +		// GPD Win Max 2 2024 with Ryzen 8840U
> +		.matches	= {
> +					DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +					DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
> +				},
> +		.driver_data	= &gpd_wm2_quirk,
> +	},
> +	{}
> +};
> +
> +static const struct gpd_model_quirk *gpd_module_quirks[] = {
> +	&gpd_win_mini_quirk, &gpd_win4_quirk, &gpd_wm2_quirk, NULL
> +};
> +
> +// device EC truly access function start
> +

What is a "truly access function" ?

> +static int gpd_ecram_read(const struct gpd_model_ec_address *address,
> +			  u16 offset, u8 *val)
> +{
> +	int ret;
> +	u16 addr_port = address->addr_port;
> +	u16 data_port = address->data_port;
> +
> +	ret = mutex_lock_interruptible(&gpd_fan_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	outb(0x2E, addr_port);
> +	outb(0x11, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)((offset >> 8) & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x10, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)(offset & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x12, data_port);
> +	outb(0x2F, addr_port);
> +	*val = inb(data_port);
> +
> +	mutex_unlock(&gpd_fan_lock);
> +	return 0;
> +}
> +
> +static int gpd_ecram_write(const struct gpd_model_ec_address *address,
> +			   u16 offset, u8 value)
> +{
> +	int ret;
> +	u16 addr_port = address->addr_port;
> +	u16 data_port = address->data_port;
> +
> +	ret = mutex_lock_interruptible(&gpd_fan_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	outb(0x2E, addr_port);
> +	outb(0x11, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)((offset >> 8) & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x10, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)(offset & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x12, data_port);
> +	outb(0x2F, addr_port);
> +	outb(value, data_port);
> +
> +	mutex_unlock(&gpd_fan_lock);
> +	return 0;
> +}
> +
> +// device EC truly access function end
> +
> +// device quirk function implement start
> +
> +static s32
> +gpd_read_cached_fan_speed(struct gpd_driver_priv *data,
> +			  s32 (*read_uncached)(const struct gpd_driver_priv *))
> +{
> +	// Update per 1000 milliseconds
> +	if (time_after(jiffies, data->fan_speed_last_update + HZ)) {
> +		s32 ret = read_uncached(data);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		data->fan_speed_cached = ret;
> +		data->fan_speed_last_update = jiffies;
> +	}
> +	return data->fan_speed_cached;
> +}
> +
> +static s32
> +gpd_read_cached_pwm(struct gpd_driver_priv *data,
> +		    s16 (*read_uncached)(const struct gpd_driver_priv *))
> +{
> +	// Update per 1000 milliseconds
> +	if (time_after(jiffies, data->read_pwm_last_update + HZ)) {
> +		s16 ret = read_uncached(data);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		data->read_pwm_cached = ret;
> +		data->read_pwm_last_update = jiffies;
> +	}
> +	return data->read_pwm_cached;
> +}
> +
> +static s32 gpd_read_rpm_uncached(const struct gpd_driver_priv *data)
> +{
> +	u8 high, low;
> +	int ret;
> +	const struct gpd_model_ec_address *address = &data->quirk->address;
> +
> +	ret = gpd_ecram_read(address, address->rpm_read, &high);
> +	if (ret)
> +		return ret;
> +	ret = gpd_ecram_read(address, address->rpm_read + 1, &low);
> +	if (ret)
> +		return ret;
> +
> +	return (u16)high << 8 | low;
> +}
> +
> +static s32 gpd_read_rpm(struct gpd_driver_priv *data)
> +{
> +	return gpd_read_cached_fan_speed(data, gpd_read_rpm_uncached);
> +}
> +
> +static s16 gpd_read_pwm(struct gpd_driver_priv *data)
> +{
> +	return data->pwm_value;
> +}
> +
> +static int gpd_write_pwm(const struct gpd_driver_priv *data, u8 val)
> +{
> +	const struct gpd_model_ec_address *address = &data->quirk->address;
> +	u8 actual;
> +
> +	// PWM value's range in EC is 1 - pwm_max, cast 0 - 255 to it.
> +	actual = val * (address->pwm_max - 1) / 255 + 1;
> +	return gpd_ecram_write(address, address->pwm_write, actual);
> +}
> +
> +static int gpd_win_mini_set_pwm_enable(struct gpd_driver_priv *data,
> +				       enum FAN_PWM_ENABLE pwm_enable)
> +{
> +	switch (pwm_enable) {
> +	case DISABLE:
> +		return gpd_write_pwm(data, 255);
> +	case MANUAL:
> +		return gpd_write_pwm(data, data->pwm_value);
> +	case AUTOMATIC:
> +		return gpd_write_pwm(data, 0);
> +	}
> +	return 0;
> +}
> +
> +static int gpd_win_mini_write_pwm(const struct gpd_driver_priv *data, u8 val)
> +{
> +	if (data->pwm_enable == MANUAL)
> +		return gpd_write_pwm(data, val);
> +	return 0;
> +}
> +
> +static s32 gpd_win4_read_rpm_uncached(const struct gpd_driver_priv *data)
> +{
> +	const struct gpd_model_ec_address *address = &data->quirk->address;
> +	u8 PWMCTR;
> +	s32 ret;
> +
> +	gpd_ecram_read(address, 0x1841, &PWMCTR);
> +	if (PWMCTR != 0x7F)
> +		gpd_ecram_write(address, 0x1841, 0x7F);
> +
> +	ret = gpd_read_rpm_uncached(data);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret == 0) {
> +		//re-init EC
> +		u8 chip_id;
> +
> +		gpd_ecram_read(address, 0x2000, &chip_id);
> +		if (chip_id == 0x55) {
> +			u8 chip_ver;
> +
> +			if (gpd_ecram_read(address, 0x1060, &chip_ver)) {
> +				gpd_ecram_write(address, 0x1060,
> +						chip_ver | 0x80);
> +			}
> +		}
> +	}
> +	return ret;
> +}
> +
> +static s32 gpd_win4_read_rpm(struct gpd_driver_priv *data)
> +{
> +	return gpd_read_cached_fan_speed(data, gpd_win4_read_rpm_uncached);
> +}
> +
> +static s32 gpd_wm2_read_rpm_uncached(const struct gpd_driver_priv *data)
> +{
> +	const struct gpd_model_ec_address *address = &data->quirk->address;
> +
> +	for (u16 pwm_ctr_offset = 0x1841; pwm_ctr_offset <= 0x1843;
> +	     pwm_ctr_offset++) {
> +		u8 PWMCTR;
> +
> +		gpd_ecram_read(address, pwm_ctr_offset, &PWMCTR);
> +		if (PWMCTR != 0xB8)
> +			gpd_ecram_write(address, pwm_ctr_offset, 0xB8);
> +	}
> +	return gpd_read_rpm_uncached(data);
> +}
> +
> +static s32 gpd_wm2_read_rpm(struct gpd_driver_priv *data)
> +{
> +	return gpd_read_cached_fan_speed(data, gpd_wm2_read_rpm_uncached);
> +}
> +
> +static s16 gpd_wm2_read_pwm_uncached(const struct gpd_driver_priv *data)
> +{
> +	const struct gpd_model_ec_address *address = &data->quirk->address;
> +	u8 var;
> +	int ret = gpd_ecram_read(address, address->pwm_write, &var);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return var * 255 / address->pwm_max;
> +}
> +
> +static s16 gpd_wm2_read_pwm(struct gpd_driver_priv *data)
> +{
> +	return gpd_read_cached_pwm(data, gpd_wm2_read_pwm_uncached);
> +}
> +
> +static int gpd_wm2_set_pwm_enable(struct gpd_driver_priv *data,
> +				  enum FAN_PWM_ENABLE enable)
> +{
> +	const struct gpd_model_ec_address *address = &data->quirk->address;
> +	int ret;
> +
> +	switch (enable) {
> +	case DISABLE:
> +		ret = gpd_write_pwm(data, 255);
> +
> +		if (ret)
> +			return ret;
> +
> +		return gpd_ecram_write(address, address->manual_control_enable,
> +				       1);
> +	case MANUAL:
> +		ret = gpd_write_pwm(data, data->pwm_value);
> +
> +		if (ret)
> +			return ret;
> +
> +		return gpd_ecram_write(address, address->manual_control_enable,
> +				       1);
> +	case AUTOMATIC:
> +		ret = gpd_ecram_write(address, address->manual_control_enable,
> +				      0);
> +
> +		// Immediately refresh the PWM value
> +		gpd_read_cached_pwm(data, gpd_wm2_read_pwm_uncached);
> +
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int gpd_wm2_write_pwm(const struct gpd_driver_priv *data, u8 val)
> +{
> +	if (data->pwm_enable != DISABLE)
> +		return gpd_write_pwm(data, val);
> +
> +	return 0;
> +}
> +
> +// device quirk function implement end
> +
> +// hwmon subsystem start
> +
> +static umode_t gpd_fan_hwmon_is_visible(__always_unused const void *drvdata,
> +					enum hwmon_sensor_types type, u32 attr,
> +					__always_unused int channel)
> +{
> +	if (type == hwmon_fan && attr == hwmon_fan_input) {
> +		return 0444;
> +	} else if (type == hwmon_pwm) {
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +		case hwmon_pwm_input:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int gpd_fan_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, __always_unused int channel, long *val)
> +{
> +	struct gpd_driver_priv *data = dev_get_drvdata(dev);
> +
> +	if (type == hwmon_fan) {
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			s32 ret = data->quirk->read_rpm(data);
> +
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = ret;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +	if (type == hwmon_pwm) {
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			*val = data->pwm_enable;
> +			return 0;
> +		case hwmon_pwm_input:
> +			s16 ret = data->quirk->read_pwm(data);
> +
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = ret;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int gpd_fan_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +			       u32 attr, __always_unused int channel, long val)
> +{
> +	struct gpd_driver_priv *data = dev_get_drvdata(dev);
> +
> +	if (type == hwmon_pwm) {
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			if (!in_range(val, 0, 3))
> +				return -EINVAL;
> +			data->pwm_enable = val;
> +			return data->quirk->set_pwm_enable(data,
> +							   data->pwm_enable);
> +		case hwmon_pwm_input:
> +			u8 var = clamp_val(val, 0, 255);
> +
> +			data->pwm_value = var;
> +			return data->quirk->write_pwm(data, var);
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops gpd_fan_ops = {
> +	.is_visible	= gpd_fan_hwmon_is_visible,
> +	.read		= gpd_fan_hwmon_read,
> +	.write		= gpd_fan_hwmon_write,
> +};
> +
> +static const struct hwmon_channel_info *gpd_fan_hwmon_channel_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE), NULL
> +};
> +
> +static struct hwmon_chip_info gpd_fan_chip_info = {
> +	.ops	= &gpd_fan_ops,
> +	.info	= gpd_fan_hwmon_channel_info
> +};
> +
> +// hwmon subsystem end
> +
> +static int gpd_fan_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gpd_driver_priv *data;
> +	const struct resource *plat_res;
> +	const struct device *dev_reg;
> +	const struct resource *region_res;
> +
> +	data = dev_get_platdata(&pdev->dev);
> +	if (IS_ERR(data))
> +		return -ENODEV;
> +

With all the "const" spread through the driver, this one is really odd.
I have never seen a driver there the _platform data_ is used to store
instance-specific information. Normally _that_ information is considered
constant and not modified by a driver.  I really have to say that it is
extremely odd to have the init function
declare values such as pwm enable and pwm value and use it in the driver.

Please provide a rationale for this unusual approach.

Also, dev_get_platdata() returns whever it finds in dev->platform_data.
I find it difficult to understand why that would ever be an ERR_PTR().
Please explain.

> +	plat_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (IS_ERR(plat_res))
> +		return dev_err_probe(dev, PTR_ERR(plat_res),
> +				     "Failed to get platform resource\n");
> +
> +	region_res = devm_request_region(dev, plat_res->start,
> +					 resource_size(plat_res), DRIVER_NAME);
> +	if (IS_ERR(region_res))
> +		return dev_err_probe(dev, PTR_ERR(region_res),
> +				     "Failed to request region\n");
> +
> +	dev_reg = devm_hwmon_device_register_with_info(
> +		dev, DRIVER_NAME, data, &gpd_fan_chip_info, NULL);

CHECK: Lines should not end with a '('
#756: FILE: drivers/hwmon/gpd-fan.c:593:
+	dev_reg = devm_hwmon_device_register_with_info(

Plus on top of that multi-line code should be aligned with '('.

> +	if (IS_ERR(dev_reg))
> +		return dev_err_probe(dev, PTR_ERR(region_res),
> +				     "Failed to register hwmon device\n");
> +
> +	return 0;
> +}
> +
> +static int gpd_fan_remove(struct platform_device *pdev)
> +{
> +	struct gpd_driver_priv *data = dev_get_platdata(&pdev->dev);
> +
> +	data->pwm_enable = AUTOMATIC;
> +	data->quirk->set_pwm_enable(data, AUTOMATIC);
> +

This is even more unusual. Can you point me to other drivers in the kernel
using that same approach for handling device specific private data ?

> +	return 0;
> +}
> +
> +static struct platform_driver gpd_fan_driver = {
> +	.probe	= gpd_fan_probe,
> +	.remove	= gpd_fan_remove,
> +	.driver	= {
> +		.name	= KBUILD_MODNAME,
> +	},
> +};
> +
> +static struct platform_device *gpd_fan_platform_device;
> +
> +static int __init gpd_fan_init(void)
> +{
> +	const struct gpd_model_quirk *match = NULL;
> +
> +	for (const struct gpd_model_quirk **p = gpd_module_quirks; *p; p++) {
> +		if (strcmp(gpd_fan_model, (*p)->model_name) == 0) {

		!strcmp

> +			match = *p;
> +			break;
> +		}
> +	}
> +
> +	if (!match)
> +		match = dmi_first_match(gpd_devices)->driver_data;

This assumes that dmi_first_match(gpd_devices) always returns a valid
pointer. How is that guaranteed ?

> +
> +	if (!match)
> +		return -ENODEV;

And why check for driver_data after dmi_first_match() returned a
valid pointer ? What would be the point of creating a match entry
in gpd_devices without valid driver_data pointer ?

> +
> +	struct gpd_driver_priv data = {
> +		.pwm_enable		= AUTOMATIC,
> +		.pwm_value		= 255,

This is unusual, to say it mildly. Since the pwm value is never read
from the controller/chip, this is just a random value.

> +		.fan_speed_cached	= 0,
> +		.read_pwm_cached	= 0,
> +		.fan_speed_last_update	= jiffies,
> +		.read_pwm_last_update	= jiffies,

Is it on purpose that the values won't be updated for a second
after registering the driver ? If so, please provide a rationale.

> +		.quirk			= match,
> +	};
> +
> +	struct resource gpd_fan_resources[] = {
> +		{
> +			.start	= data.quirk->address.addr_port,
> +			.end	= data.quirk->address.data_port,
> +			.flags	= IORESOURCE_IO,
> +		},
> +	};
> +
> +	gpd_fan_platform_device = platform_create_bundle(

CHECK: Lines should not end with a '('
#820: FILE: drivers/hwmon/gpd-fan.c:657:
+	gpd_fan_platform_device = platform_create_bundle(

> +		&gpd_fan_driver, gpd_fan_probe, gpd_fan_resources, 1, &data,
> +		sizeof(struct gpd_driver_priv));
> +
> +	if (IS_ERR(gpd_fan_platform_device)) {
> +		pr_warn("Failed to create platform device\n");
> +		return PTR_ERR(gpd_fan_platform_device);
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit gpd_fan_exit(void)
> +{
> +	platform_device_unregister(gpd_fan_platform_device);
> +	platform_driver_unregister(&gpd_fan_driver);
> +}
> +
> +module_init(gpd_fan_init)
> +module_exit(gpd_fan_exit)
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Cryolitia <Cryolitia@gmail.com>");
> +MODULE_DESCRIPTION("GPD Devices fan control driver");
> +MODULE_ALIAS("dmi:*:svnGPD:pnG1617-01:*");
> +MODULE_ALIAS("dmi:*:svnGPD:pnG1618-04:*");
> +MODULE_ALIAS("dmi:*:svnGPD:pnG1619-04:*");

