Return-Path: <linux-kernel+bounces-534001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F828A46157
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F7816A8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0ED21E0AF;
	Wed, 26 Feb 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYZWcigx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB623218858;
	Wed, 26 Feb 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578032; cv=none; b=qA078TJmyiUIXMpLHFrccnjj6d+oXnFjpQSfqppbJ5oCmhkLwpD6xq5Rgwp19J66wTu6nkTz+a4W2gt390Ww8+Dav8wJzaSaWu8OXVfmZAhDrUQKiRQfXOnSzfeYwttJ5SxWKYxPE3z01pbaJDyr9ZenMDeX+d76X9ZbR17gM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578032; c=relaxed/simple;
	bh=+eYFCiH3NBSpv4GUZuAu6USo6izhd6fHXs+8xlh26BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ax1+Cd/SpS9pzKx7nTQl2RTNVZVFGUV4YTFTqXxkJGSWK1rdL6ktmwZxZte1rxAqtz7g+fp/fnDuIamx9z7vHzMmKjHzsKeKRXjVe+aNE8mJYGNQHLlSnCgnIDiEkYAo2vmovgBFB7BWC4YxLNH8iI9uzfKUHv07bCxQPKSP4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYZWcigx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220f4dd756eso145872905ad.3;
        Wed, 26 Feb 2025 05:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740578029; x=1741182829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VPP3X0IxQjlg9owNUh42Fwz69O/msAxP9G3t/ihm/Os=;
        b=ZYZWcigxtHEnhjR8CJLzZbDspJemMK9iAV78RoL1BkakFm+1TiABNWSU//dDG35wjP
         wLYPovrnruxQ271BE0D4qzlkxkuJcDKdinDFE2K9+kKf6MJi69bI+FzA0j+D2ROoLDq0
         nCnxAxC+6ZaZ5zIyzm0M+IFEl03McLWTVt/uSrKVUwP0K3PWuWzQJ/4BGl2n9lx2oJO5
         KZN0wZER+3O/4EwDY2WtEmBQW30CvzHY+IRTrk8LFug8eo3SJ4MOSHm5CLmjU1y09TaG
         Ld4KW527Xp0fnos0AiZT286euukr/9RgcZ/OMnosZv6uJpBhxEC64BNdnBxVPtwmjlK/
         I2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578029; x=1741182829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPP3X0IxQjlg9owNUh42Fwz69O/msAxP9G3t/ihm/Os=;
        b=c7Ejv6/2DwUU8QJt9uPrN7OM9L4dnJgNZQlXacmvQN94uWJOUA26tw4vTaiwsZbSU8
         PX5xrKYoHfNvKH6eDt9oKsgsQa2RqVTGUTZoCiOAdiV8GEmyeBSkKMxJL+mKm+pVo0Qe
         AI7W78FJZSrxH488fvstf15VtiFirhq2Hbh2skFj51sbLJdzn0zHFnQTYqcPpRhK5aUh
         VYtDwT19cTXuaoSxmT2zBZUiuSAcvt9K0ct1Yizt7OH5ab9jPnOIwtRI2tGyVM8spueL
         qHN2kvbpLe1/ezrpDdToF5dV2M9b+mzb1eo7jpzBOCN8E82L7+tjm99/F0Ca1Xosy252
         dCCw==
X-Forwarded-Encrypted: i=1; AJvYcCU9XBWAWogWv8staW/hPQHRQWSMTn3H/C3YCZFL+9Eul7Z/d3MndokhmxNozPFSUkfcZu/aLSNyoICIyTp7@vger.kernel.org, AJvYcCUtuxwShpcMSMIwGGk1sOHDjIDy+PTgTzSOtvSAB1a11s7Mdukk/VhDJdG1wO5cvSxJ4vCddL/WGbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFo5/+aObCA51aB4HTfImflSmcF1skvjzNxM8WaynNs90P08PO
	i9cw3e/bKlvgVSWylB1LI0HNEmWzsP3Ic8kjyR3h+7ICmIsLUVuHMv50Ew==
X-Gm-Gg: ASbGnct/6Hna7TbvgfGdbQHvv9ulFMwonWnzU9hARoiczX781nA0dHCUZ56Xz7l4imP
	Z0lTT9KU/xzVTI6B9/I3lY9hW1BnvEx3EdxYrEF0yi7WPzSCUXt2pWh2b56ACiNR1I8EPmDdsjg
	dC0G8bVBTcs20tuIPEEKh9wM8pma1V1JVcuVY6NKtat39/xRAi7ImBW6yVCMXztRUjYfNb7j3rM
	Mkkchux5uCZvAEGkh3FCGwLtQHV7IY78i5D9D+HIZOEDVAFNvlFG3YPdZvAJMPB7ywSys3yx4Y4
	TRiBfVJczJWpJ4rlDqnT+l1/Tc7YH+x5bA8rg+HBtjKb81FgN5TcBZylMvPNsaYea9T7PcQ0QWQ
	=
X-Google-Smtp-Source: AGHT+IFNZMIH3p1S1KUrgIvknf1x/pquKtgazNfd5p3KNzC28I8jFVVs1sF97ndlEY4hJHWgR+fmag==
X-Received: by 2002:a17:903:2448:b0:21f:9107:fca3 with SMTP id d9443c01a7336-22307b69a02mr107018505ad.30.1740578028996;
        Wed, 26 Feb 2025 05:53:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000a21sm32327525ad.28.2025.02.26.05.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:53:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f80207ca-da38-4999-be16-326490396d18@roeck-us.net>
Date: Wed, 26 Feb 2025 05:53:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max77705) add initial support
To: Dzmitry Sankouski <dsankouski@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 11:11, Dzmitry Sankouski wrote:
> Add support for max77705 hwmon. Includes charger input, system bus, and
> vbyp measurements.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Maxim MAX77705 is a Companion Power Management and Type-C interface IC.
> It includes charger and fuel gauge blocks, and is capable of measuring
> charger input current, system bus volatage and current, and bypass
> voltage.
> 
> This patch add support for mentioned measurements.

s/This patch add/Add/

Please run checkpatch --strict and fix what it reports (mostly
multi-line alignment problems and unnecessary spaces).

> ---
>   Documentation/hwmon/index.rst    |   1 +
>   Documentation/hwmon/max77705.rst |  39 +++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS                      |   7 +++++++
>   drivers/hwmon/Kconfig            |  10 ++++++++++
>   drivers/hwmon/Makefile           |   1 +
>   drivers/hwmon/max77705-hwmon.c   | 260 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 318 insertions(+)
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
> index f076360ce3c6..b6e970731928 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18025,6 +18025,13 @@ S:	Maintained
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
> index f114d0c55d78..17b2e1b535eb 100644
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
> index 000000000000..3218e9f5a726
> --- /dev/null
> +++ b/drivers/hwmon/max77705-hwmon.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  MAX77705 voltage and current hwmon driver.
> + *
> + *  Copyright (C) 2025 Dzmitry Sankouski <dsankouski@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/max77705-private.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/regmap.h>
> +#include <linux/jiffies.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>

Aplphabetic order, please.

> +
> +struct max77705_hwmon {
> +	struct regmap *regmap;
> +};

Unnecessary structure. Just point to regmap directly if nothing
else is needed.

> +
> +struct channel_desc {
> +	u8 reg;
> +	u8 avg_reg;
> +	const char *const label;
> +	// register resolution. nano Volts for voltage, nano Amperes for current
> +	u64 resolution;

Why u64 ?

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
> +static umode_t max77705_is_visible(const void *data,
> +		enum hwmon_sensor_types type,
> +		u32 attr, int channel)
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
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int max77705_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +		int channel, const char **buf)
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
> +		u32 attr, int channel, long *val)
> +{
> +	struct max77705_hwmon *drv_data = dev_get_drvdata(dev);
> +	struct regmap *regmap = drv_data->regmap;
> +	u8 reg;
> +	u32 regval;
> +	u64 res;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			reg = current_channel_desc[channel].reg;
> +			res = current_channel_desc[channel].resolution;
> +			ret = regmap_read(regmap, reg, &regval);
> +			if (ret < 0)
> +				return ret;
> +			*val = mult_frac((long) regval, res, 1000000);
> +			return 0;
> +		case hwmon_curr_average:
> +			reg = current_channel_desc[channel].avg_reg;
> +			res = current_channel_desc[channel].resolution;
> +			if (reg) {

reg is 0 for current channel 0. That should be addressed in the is_visible
function, and the attribute should not exist for curent channel 0.
Checking it here is wrong.

> +				ret = regmap_read(regmap, reg, &regval);
> +				if (ret < 0)
> +					return ret;
> +				*val = mult_frac((long) regval, res, 1000000);
> +			}
> +			return 0;
> +
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			reg = voltage_channel_desc[channel].reg;
> +			res = voltage_channel_desc[channel].resolution;
> +			ret = regmap_read(regmap, reg, &regval);
> +			if (ret < 0)
> +				return ret;
> +			*val = mult_frac((long) regval, res, 1000000);
> +			return 0;
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
> +			HWMON_I_INPUT | HWMON_I_LABEL,
> +			HWMON_I_INPUT | HWMON_I_LABEL
> +			),
> +	HWMON_CHANNEL_INFO(curr,
> +			HWMON_C_INPUT | HWMON_C_AVERAGE | HWMON_C_LABEL,
> +			HWMON_C_INPUT | HWMON_C_LABEL
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
> +	struct max77705_hwmon *drv_data;
> +
> +	drv_data = devm_kzalloc(&pdev->dev, sizeof(struct max77705_hwmon),
> +			GFP_KERNEL);
> +	if (!drv_data)
> +		return -ENOMEM;
> +
> +	i2c = to_i2c_client(pdev->dev.parent);
> +	drv_data->regmap = devm_regmap_init_i2c(i2c, &max77705_hwmon_regmap_config);

This is unusual for an mfd driver. Why not pass regmap from the parent
driver ?

> +	if (IS_ERR(drv_data->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(drv_data->regmap),
> +				"Failed to register max77705 hwmon regmap\n");
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "max77705", drv_data,
> +			&max77705_chip_info, NULL);
> +	if (IS_ERR(hwmon_dev)) {
> +		return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),
> +				"Unable to register hwmon device\n");
> +	}
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
> base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
> change-id: 20250123-initial-support-for-max77705-sensors-ad0170ac1ec5
> 
> Best regards,


