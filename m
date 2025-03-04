Return-Path: <linux-kernel+bounces-544042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B919A4DCC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB1B3A2617
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31754200106;
	Tue,  4 Mar 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww5Dx1XA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6E1FDE27;
	Tue,  4 Mar 2025 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088341; cv=none; b=T0mEnGAqq8GCSqUH+Gdefn7Ty7i2frR4KRUku8Nidxv173Z4LFseTiNXZPh/iRMIq8CmqP78qfUUe1Nh63NfK9vUjTnGQEjW4gPYfrJL7/aPPfGp0It4QQhCs0IaRSu7u1uuSQLr8MtSfXbYab0d2Lsg0IIHptLjw6X9bhht3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088341; c=relaxed/simple;
	bh=ZsRZcHWZTDQQfbTTbZqop9EvXaPi8+mBGLyY6/ITkGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enZdj1RxU3qzqJIGaELuFHsX9At+ecmyicCe77EybbanaimWPiYgxRQbD6uj5QmGTm/AyxrGdtNI6MCh5rqAgD9W9RQN2Sr0MyL40l2gf4oEAeBQK6eAFqgfuoGyH8gkEvrx+wV9zzorzactINort9cUe5VLqya4CbNjDZ6aQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww5Dx1XA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2234e5347e2so110257105ad.1;
        Tue, 04 Mar 2025 03:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741088337; x=1741693137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YvPZVxjnDADFJGy7NRpTM2RDJYIWxdtmdLcAO4lQXIM=;
        b=Ww5Dx1XAemKTsRPGWhNkYKztgqXqrTPCwE0wX2fk17AwX72+yn4Zz4F9ehbxAh3kxz
         b6GrM8lKTPMUJwVgAZf0FG4p0pTGTzpU4WiBzIaCyhwgHKwR2mGasQFfAPhvPA4dhI3x
         TDf/4bINAPc4cylNslQn1qTARq4RVE8kw2hpxyJ8uqARrDnW2Kt4rYku4BPYuoMMB3b0
         0wqIrQG3/503BtUpPAaDxWc6pJhvyeXupEV2dWqF6gQii+v7jG/a5X53CJRMS+/q265C
         E9GNkF9fxBwo3ChWIcTL9S3yQfN44eVppH6PIATzbF1W7/rYjc1cwsQ1gPXTlh2A5jTc
         LsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088337; x=1741693137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvPZVxjnDADFJGy7NRpTM2RDJYIWxdtmdLcAO4lQXIM=;
        b=Ta9xkOOOY0IRlgpgQbM+1q+yaiqnukNUx39lxqISFXTjXJSMq0SW9AWFUiA24j0uzm
         A9hxFwUOyRe5A5eX9NMcddprkq9wHBsT2Q4KK4sk03bcgf3QpUjo0ckFYtvj+8zP7ItB
         FHM5Off7uuuqinTu0ps+Lp9zB5S8lwnNHntMHWQIaaku1LOTHskPKNUYxsPUbp1oLplK
         X4zjuicSbII5gcgxSwS6L9GYTL7SVlkEIN7GAVRj70LQJScI71JFW+MlkI3XCKxith8a
         7Tmnp1S6jwSkiD4hMsv/MxwkcZWo9ltF1b6D9KzS/wMxrp2pQIUVj/SsyZQXLbS4TnxG
         PBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+t5hLN81bIwLq/jkl2Hj2oU9oOh/XRQozOg2Uqw8t6qTPJ7u1Qt9BogUYlrKpLuuNnL4MAMiHIOk=@vger.kernel.org, AJvYcCUh/52T0hr7biTcWnsZipmuWFgJpQGG3XowsBeiUU4pqYwbkiRyGWq763WWGjNMo3mTqMpVXfPRZRL7to4V@vger.kernel.org
X-Gm-Message-State: AOJu0YybxyEQpIWZZrXx6JsKytnBudLnIiZL0DNxPXi2Jd9mVX3+eMh7
	vLLm7swqazfOo9k9YT09UA4rlr9AYIrzJCudcTdg2GOatCoLe1pC
X-Gm-Gg: ASbGncvF+RFEt6YSLuQ/9tMG8Ghcf36vhmZfgtrTA7NleEebf6X6ehw6GTIAf8TMyOw
	E76hu1fLOqaL1RPljtuv3zhqG05zAYBh/JukyUPOhUnAW2dpc/03Ycg4t71y4rWizPzvg4/X5mP
	lsNv7HOzk13cgZXGktWNnE6efW42KmnueozCaUdUGR0TD9oCdBhP6YIyciFRIPD9CjeD0thmvDy
	12fcgWRb/4GQIz1qPzWWQDyydSe2oAUxxm897BMnPcJrFPwhLYNgIpf+Rw8P209ZyorIIeFsQbS
	eTOH8RBnoGNCKNhhhXhtkSX2U33wFmnvv64Bsu18LSA5ZVL633ogM/eqGkoqFD5QYJ96jahzOCH
	3RE4hOquarF23771/pg==
X-Google-Smtp-Source: AGHT+IEvEsqqg47B8zLQOs4sZteiuPADAnHKOjvaH6oiZjK9tdsr8P/OfaeMugKpEMWp7V6yN5KGHw==
X-Received: by 2002:a05:6a21:b97:b0:1ee:8bd5:81c4 with SMTP id adf61e73a8af0-1f2f4e3cc95mr27732249637.28.1741088336978;
        Tue, 04 Mar 2025 03:38:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedcf86sm8348229a12.64.2025.03.04.03.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:38:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e9a2383-108a-4440-8f55-77679a79e36e@roeck-us.net>
Date: Tue, 4 Mar 2025 03:38:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (max77705) add initial support
To: Dzmitry Sankouski <dsankouski@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250304-initial-support-for-max77705-sensors-v2-1-58d2207c732b@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250304-initial-support-for-max77705-sensors-v2-1-58d2207c732b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 03:08, Dzmitry Sankouski wrote:
> Add support for max77705 hwmon. Includes charger input, system bus, and
> vbyp measurements.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Maxim MAX77705 is a Companion Power Management and Type-C interface IC.
> It includes charger and fuel gauge blocks, and is capable of measuring
> charger input current, system bus volatage and current, and bypass
> voltage.

That makes me wonder if this should be implemented in drivers/power/supply/
and utilize the power_supply->hwmon bridge. That seems to make more sense
to me than implementing a separate hwmon driver.

> 
> Add support for mentioned measurements.
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com

???

> ---
> Changes in v2:
> - sort headers alphabetically
> - swap curr channel info, to align indeces with channel_desc struct
> - reword coverletter
> - fix checkpatch --strict warnings
> - remove struct max77705_hwmon, use regmap directly
> - move register validation logic to is_visible function
> - move common register reading and converting logic to separate function
> - remove unnessesary {} in if statement
> - s/i2c->dev/pdev->dev in dev_err_probe
> ---
>   Documentation/hwmon/index.rst    |   1 +
>   Documentation/hwmon/max77705.rst |  39 +++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS                      |   7 +++++++
>   drivers/hwmon/Kconfig            |  10 ++++++++++
>   drivers/hwmon/Makefile           |   1 +
>   drivers/hwmon/max77705-hwmon.c   | 250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 308 insertions(+)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 874f8fd26325..444c7865f74f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -158,6 +158,7 @@ Hardware Monitoring Kernel Drivers
>      max6639
>      max6650
>      max6697
> +   max77705
>      max8688
>      mc13783-adc
>      mc34vr500
> diff --git a/Documentation/hwmon/max77705.rst b/Documentation/hwmon/max77705.rst
> new file mode 100644
> index 000000000000..9037226c50b9
> --- /dev/null
> +++ b/Documentation/hwmon/max77705.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver max77705
> +====================
> +
> +Supported chips:
> +
> +  * Maxim Integrated MAX77705
> +
> +    Prefix: 'max77705'
> +
> +    Addresses scanned: none
> +
> +    Datasheet: Not available
> +
> +Authors:
> +      - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +Description
> +-----------
> +
> +The MAX77705 PMIC provides current and voltage measurements besides fuelgauge:
> +- chip input current
> +- system bus current and voltage
> +- VBYP voltage
> +
> +Sysfs Attributes
> +----------------
> +
> +================= ========================================
> +in1_label         "vbyp"
> +in1_input         Measured chip vbyp voltage
> +in2_label         "vsys"
> +in2_input         Measured chip system bus voltage
> +curr1_label       "iin"
> +curr1_input       Measured chip input current.
> +curr2_label       "isys"
> +curr2_input       Measured chip system bus current.
> +================= ========================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29e1a423eee5..0175f9f89325 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18110,6 +18110,13 @@ S:	Maintained
>   F:	Documentation/hwmon/pc87427.rst
>   F:	drivers/hwmon/pc87427.c
>   
> +MAX77705 HARDWARE MONITORING DRIVER
> +M:	Dzmitry Sankouski <dsankouski@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/max77705.rst
> +F:	drivers/hwmon/max77705-hwmon.c
> +
>   PCA9532 LED DRIVER
>   M:	Riku Voipio <riku.voipio@iki.fi>
>   S:	Maintained
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 56494ab85b83..c86fe094a978 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1287,6 +1287,16 @@ config SENSORS_MAX31790
>   	  This driver can also be built as a module. If so, the module
>   	  will be called max31790.
>   
> +config SENSORS_MAX77705
> +	tristate "MAX77705 current and voltage sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for MAX77705 sensors connected with I2C.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called max77705-hwmon.
> +
>   config SENSORS_MC34VR500
>   	tristate "NXP MC34VR500 hardware monitoring driver"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b7ef0f0562d3..ff69f45eca50 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -159,6 +159,7 @@ obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
>   obj-$(CONFIG_SENSORS_MAX6697)	+= max6697.o
>   obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
>   obj-$(CONFIG_MAX31827) += max31827.o
> +obj-$(CONFIG_SENSORS_MAX77705) += max77705-hwmon.o
>   obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
>   obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
>   obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
> diff --git a/drivers/hwmon/max77705-hwmon.c b/drivers/hwmon/max77705-hwmon.c
> new file mode 100644
> index 000000000000..6d2161421ac7
> --- /dev/null
> +++ b/drivers/hwmon/max77705-hwmon.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  MAX77705 voltage and current hwmon driver.
> + *
> + *  Copyright (C) 2025 Dzmitry Sankouski <dsankouski@gmail.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon-sysfs.h>

Not needed.

> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/max77705-private.h>

Doesn't exist.

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +struct channel_desc {
> +	u8 reg;
> +	u8 avg_reg;
> +	const char *const label;
> +	// register resolution. nano Volts for voltage, nano Amperes for current
> +	u64 resolution;

u64 is unnecessary. See below.

> +};
> +
> +static const struct channel_desc current_channel_desc[] = {
> +	{
> +		.reg = IIN_REG,
> +		.label = "IIN_REG",
> +		.resolution = 125000
> +	},
> +	{
> +		.reg = ISYS_REG,
> +		.avg_reg = AVGISYS_REG,
> +		.label = "ISYS_REG",
> +		.resolution = 312500
> +	}
> +};
> +
> +static const struct channel_desc voltage_channel_desc[] = {
> +	{
> +		.reg = VBYP_REG,
> +		.label = "VBYP_REG",
> +		.resolution = 427246
> +	},
> +	{
> +		.reg = VSYS_REG,
> +		.label = "VSYS_REG",
> +		.resolution = 156250
> +	}
> +};
> +
> +static const struct regmap_range max77705_hwmon_readable_ranges[] = {
> +	regmap_reg_range(AVGISYS_REG,	AVGISYS_REG + 1),
> +	regmap_reg_range(IIN_REG,	IIN_REG + 1),
> +	regmap_reg_range(ISYS_REG,	ISYS_REG + 1),
> +	regmap_reg_range(VBYP_REG,	VBYP_REG + 1),
> +	regmap_reg_range(VSYS_REG,	VSYS_REG + 1),
> +};
> +
> +static const struct regmap_access_table max77705_hwmon_readable_table = {
> +	.yes_ranges = max77705_hwmon_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(max77705_hwmon_readable_ranges),
> +};
> +
> +static const struct regmap_config max77705_hwmon_regmap_config = {
> +	.name = "max77705_hwmon",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.rd_table = &max77705_hwmon_readable_table,
> +	.max_register = MAX77705_FG_END,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE
> +};
> +
> +static int max77705_read_and_convert(struct regmap *regmap, u8 reg, u64 res, long *val)

u64 is unnecessary for res.

> +{
> +	int ret;
> +	u32 regval;
> +
> +	ret = regmap_read(regmap, reg, &regval);
> +	if (ret < 0)
> +		return ret;
> +	*val = mult_frac((long)regval, res, 1000000);

This won't build on 32-bit systems. You'll need to use DIV_ROUND_CLOSEST_ULL(),
and the conversion to 64-bit can be done with
	*val = DIV_ROUND_CLOSEST_ULL((u64)regval * res, 1000000);

> +
> +	return 0;
> +}
> +
> +static umode_t max77705_is_visible(const void *data,
> +				   enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		if (channel >= ARRAY_SIZE(voltage_channel_desc))
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_in_input:
> +		case hwmon_in_label:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_curr:
> +		if (channel >= ARRAY_SIZE(current_channel_desc))
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_curr_input:
> +		case hwmon_in_label:
> +			return 0444;
> +		case hwmon_curr_average:
> +			if (current_channel_desc[channel].avg_reg)
> +				return 0444;
> +		default:
> +			break;
> +		}
> +		break;

The chip provides temperature measurements. Why not support it ?

Also, how about limits ? Doesn't the chip support any ? There do
seem to be some threshold registers.

> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int max77705_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				int channel, const char **buf)
> +{
> +	switch (type) {
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_in_label:
> +			*buf = current_channel_desc[channel].label;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_label:
> +			*buf = voltage_channel_desc[channel].label;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int max77705_read(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long *val)
> +{
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	u8 reg;
> +	u64 res;
> +
> +	switch (type) {
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			reg = current_channel_desc[channel].reg;
> +			res = current_channel_desc[channel].resolution;
> +
> +			return max77705_read_and_convert(regmap, reg, res, val);
> +		case hwmon_curr_average:
> +			reg = current_channel_desc[channel].avg_reg;
> +			res = current_channel_desc[channel].resolution;
> +
> +			return max77705_read_and_convert(regmap, reg, res, val);
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			reg = voltage_channel_desc[channel].reg;
> +			res = voltage_channel_desc[channel].resolution;
> +
> +			return max77705_read_and_convert(regmap, reg, res, val);
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops max77705_hwmon_ops = {
> +	.is_visible = max77705_is_visible,
> +	.read = max77705_read,
> +	.read_string = max77705_read_string,
> +};
> +
> +static const struct hwmon_channel_info *max77705_info[] = {
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL
> +			),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_AVERAGE | HWMON_C_LABEL
> +			),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info max77705_chip_info = {
> +	.ops = &max77705_hwmon_ops,
> +	.info = max77705_info,
> +};
> +
> +static int max77705_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct i2c_client *i2c;
> +	struct device *hwmon_dev;
> +	struct regmap *regmap;
> +
> +	i2c = to_i2c_client(pdev->dev.parent);
> +	regmap = devm_regmap_init_i2c(i2c, &max77705_hwmon_regmap_config);

I still think this is unnecessarily restrictive, and that the mfd driver
should register the regmap.

> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
> +				"Failed to register max77705 hwmon regmap\n");
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "max77705", regmap,
> +							 &max77705_chip_info, NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(hwmon_dev),
> +				"Unable to register hwmon device\n");
> +
> +	return 0;
> +};
> +
> +static struct platform_driver max77705_hwmon_driver = {
> +	.driver = {
> +		.name = "max77705-hwmon",
> +	},
> +	.probe = max77705_hwmon_probe,
> +};
> +
> +module_platform_driver(max77705_hwmon_driver);
> +
> +MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
> +MODULE_DESCRIPTION("MAX77705 monitor driver");
> +MODULE_LICENSE("GPL");
> +
> 
> ---
> base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
> change-id: 20250123-initial-support-for-max77705-sensors-ad0170ac1ec5
> 
> Best regards,


