Return-Path: <linux-kernel+bounces-398480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 950049BF1C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05016B23E22
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3282038DF;
	Wed,  6 Nov 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPVjLzwD"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB42036ED;
	Wed,  6 Nov 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907100; cv=none; b=U7ZuBqcJw7POLaAm26L2DyOH8sPOSSyM9uWDmBE+KduvMLcIqHN1DscEgM5mDos6k3xyCWoFpSCMPLLwDx15kR8NOG5UHWwElV1d+Jn5+7cNnlltEV20k63EHiUvOXrBJanY9g0dkkGFGy85rPjm9ya+wbwNG39j8F3Du56mPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907100; c=relaxed/simple;
	bh=0byov6K9ot8q5mTGLJbakNcw22ZD1EFF0b6XR1UwPok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQFyHC3WcfwLV5vAw20r4W3APZW1S684yOlm5N+YoBXXYCVVJwWwe9zDVG5LY0dFm1R+tVulQWelqeS7JdY+7T/EuwwK+1tpoLoQ2Aisg0EKObmGQ8awYy/FxY3yyNBA9/6Gg9qmBITLTCfOVsyaTiDW6jUeMdyeiqaat8jPoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPVjLzwD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7206304f93aso6523230b3a.0;
        Wed, 06 Nov 2024 07:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730907098; x=1731511898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VdDIpYsE11F+R7VwrhdsCBzHGv++r2xXN86k24uxDY8=;
        b=mPVjLzwDYfYf7imodoI4oeSlezrMEdl9lDfrZCyw07YDDWPNM+X3hFD60uLNE0ArU7
         wFyZLw3IgsOU1Vzm60gb2kdGsOC6apiQB04X8btU6cArIXsyejiCiZ47Tnx3soY5AGrr
         ok5IN9DCAGZCmsJljmKrIe9UPSZ/szVqd6HJE9xuTpyzyl6pGrj2VhF8a/sXofoQ39ak
         LXaDGTTs//me7GGWWjNl5BDSr4fVjF9dXXByBQ4c+O/RuJ4TyQLW1E7YJI9T9hxsiebS
         Ag2bpHzrlEiSTpEWE79IZo3gsHd4vU3sHp80zMa2Qp36VnVZjwuaTwL9dKwJQI8POXzd
         smwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907098; x=1731511898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdDIpYsE11F+R7VwrhdsCBzHGv++r2xXN86k24uxDY8=;
        b=idOVnSklL2iUMzrmLcL/qaE35RfhoKUznMUPUc476GaOZOFWAHUDwQHaRbh5T37lSe
         L//eTIjtmTVaDwwi/s+QnF4TvYOjhHV5M/TySSzOeBlTNqZLT9T6+H2dxBtRPRMnHzbK
         Y+8wD55IfrBgObkR9vtVPT8KdnIaU4dSLB/UAeZWwhG1gEpfx9c+Vq8I28420035TvTj
         M7LJdot9eORoqfQi66fq59RqoORvVKSlb91GKeHa4A6oeaDJ5nX1GX+5O4LQ8cYjGbmz
         xupBmpAHxaxeHwzvXxh98sKGB/Wyo2osAA8SxPL6WoN8pn8ydsAW0Whmh17xwzpxeXGU
         BqAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZI9MjAen7OjdwjqQ+IAcPJoZlK0c/z6ahO8D6Eb8Eh5TE+vU82sQzzq6JqZKsPeraoI4G75W/MfRjwb8=@vger.kernel.org, AJvYcCVTN3l1ULq1JuSv6XVdyVpXnaSqwfpQEpuJY1bemVmlnGCeT3kGMDaE0lQpF4drDgG6NGl1Jmn0ijxZktnc@vger.kernel.org, AJvYcCX/JYA0KquNUkJUxtUQf/f+3SZB7KXwxSYdPWLCZGIwI/javcxIHNw04Ik2QuMuf8xBIYyMMaWE1VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yIsNmVoIuYnFETrBMk1pZbxwuKEJvKnwm4SBKdLwRMVcxvvM
	1+ZHH96s2PYg9ZjRwtzfKi3XmZvkduXYmQAsqhGFY/QeOOBCZ63g
X-Google-Smtp-Source: AGHT+IFqvGMEfJDi6CTLeF+ytk7UyJotUeqmdva/cVp1X5XOxTWaqZnnvzj5hOLdD0lryrgzJgd+Xw==
X-Received: by 2002:a05:6a00:22c5:b0:71e:4655:59ce with SMTP id d2e1a72fcca58-720c967e609mr31579202b3a.0.1730907097602;
        Wed, 06 Nov 2024 07:31:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1efc0bsm11948547b3a.86.2024.11.06.07.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:31:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f7ad4c05-8415-4598-81ae-adb1a9c71292@roeck-us.net>
Date: Wed, 6 Nov 2024 07:31:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hwmon: (ina226) Add support for SY24655
To: wenliang <wenliang202407@163.com>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b3da9f78-c7d5-4bbf-80f3-bf5b52270792@roeck-us.net>
 <20241106150547.2538-1-wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241106150547.2538-1-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 07:05, wenliang wrote:
> SY24655: Support for current and voltage detection as well as
> power calculation.
> 
> Signed-off-by: wenliang <wenliang202407@163.com>

That isn't an acceptable signature. You used "Wenliang Yan" earlier.
I will use that name. That is borderline, but the alternative would really
to reject this patch set.

> ---
> 
> ina2xx.rst: Add document content description for SY24655, including
> datasheet, parameter description, and chip function description.
> 
> ina2xx.c: Add register addresses unique(SY24655_EIN and
> SY24655_ACCUM_CONFIG) to SY24655 for data reading and initialization.
> Add has_power_average in struct ina2xx_config to control average power
> reading.
> Add initialization data for SY24655.
> Initialize the power accumulation register(SY24655_ACCUM_CONFIG)
> for configuration SY24655.
> Add a read function to the EIN register(48-bit reading).
> 
> 

This is the _third_ v3 of your patch set, and the above is not an appropriate
change log. No need to resend, though; I'll fix up the problems myself.

However, _please_ spend some time reading the documents describing how
to submit patches into the Linux kernel or you seriously risk getting
future patch series rejected.

Guenter

>   Documentation/hwmon/ina2xx.rst | 27 +++++++++-
>   drivers/hwmon/Kconfig          |  2 +-
>   drivers/hwmon/ina2xx.c         | 96 ++++++++++++++++++++++++++++++++--
>   3 files changed, 118 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina2xx.rst b/Documentation/hwmon/ina2xx.rst
> index 1ce161e6c0bf..a3860aae444c 100644
> --- a/Documentation/hwmon/ina2xx.rst
> +++ b/Documentation/hwmon/ina2xx.rst
> @@ -63,6 +63,17 @@ Supported chips:
>   
>   	       https://www.ti.com/
>   
> +  * Silergy SY24655
> +
> +    Prefix: 'sy24655'
> +
> +    Addresses: I2C 0x40 - 0x4f
> +
> +    Datasheet: Publicly available at the Silergy website
> +
> +	       https://us1.silergy.com/
> +
> +
>   Author: Lothar Felten <lothar.felten@gmail.com>
>   
>   Description
> @@ -85,6 +96,11 @@ bus supply voltage.
>   INA260 is a high or low side current and power monitor with integrated shunt
>   resistor.
>   
> +The SY24655 is a high- and low-side current shunt and power monitor with an I2C
> +interface. The SY24655 supports both shunt drop and supply voltage, with
> +programmable calibration value and conversion times. The SY24655 can also
> +calculate average power for use in energy conversion.
> +
>   The shunt value in micro-ohms can be set via platform data or device tree at
>   compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
>   refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
> @@ -108,8 +124,8 @@ power1_input		Power(uW) measurement channel
>   shunt_resistor		Shunt resistance(uOhm) channel (not for ina260)
>   ======================= ===============================================
>   
> -Additional sysfs entries for ina226, ina230, ina231, and ina260
> ----------------------------------------------------------------
> +Additional sysfs entries for ina226, ina230, ina231, ina260, and sy24655
> +------------------------------------------------------------------------
>   
>   ======================= ====================================================
>   curr1_lcrit		Critical low current
> @@ -130,6 +146,13 @@ update_interval		data conversion time; affects number of samples used
>   			to average results for shunt and bus voltages.
>   ======================= ====================================================
>   
> +Sysfs entries for sy24655 only
> +------------------------------
> +
> +======================= ====================================================
> +power1_average		average power from last reading to the present.
> +======================= ====================================================
> +
>   .. note::
>   
>      - Configure `shunt_resistor` before configure `power1_crit`, because power
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index cfb4e9314c62..a837b7a1cff4 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2189,7 +2189,7 @@ config SENSORS_INA2XX
>   	select REGMAP_I2C
>   	help
>   	  If you say yes here you get support for INA219, INA220, INA226,
> -	  INA230, INA231, and INA260 power monitor chips.
> +	  INA230, INA231, INA260, and SY24655 power monitor chips.
>   
>   	  The INA2xx driver is configured for the default configuration of
>   	  the part as described in the datasheet.
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index cecc80a41a97..16fdbc0eb1f9 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -51,12 +51,19 @@
>   #define INA226_ALERT_LIMIT		0x07
>   #define INA226_DIE_ID			0xFF
>   
> -#define INA2XX_MAX_REGISTERS		8
> +/* SY24655 register definitions */
> +#define SY24655_EIN				0x0A
> +#define SY24655_ACCUM_CONFIG	0x0D
> +#define INA2XX_MAX_REGISTERS		0x0D
>   
>   /* settings - depend on use case */
>   #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
>   #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
>   #define INA260_CONFIG_DEFAULT		0x6527	/* averages=16 */
> +#define SY24655_CONFIG_DEFAULT		0x4527	/* averages=16 */
> +
> +/* (only for sy24655) */
> +#define SY24655_ACCUM_CONFIG_DEFAULT	0x044C	/* continuous mode, clear after read*/
>   
>   /* worst case is 68.10 ms (~14.6Hz, ina219) */
>   #define INA2XX_CONVERSION_RATE		15
> @@ -97,6 +104,7 @@ static bool ina2xx_writeable_reg(struct device *dev, unsigned int reg)
>   	case INA2XX_CALIBRATION:
>   	case INA226_MASK_ENABLE:
>   	case INA226_ALERT_LIMIT:
> +	case SY24655_ACCUM_CONFIG:
>   		return true;
>   	default:
>   		return false;
> @@ -127,12 +135,13 @@ static const struct regmap_config ina2xx_regmap_config = {
>   	.writeable_reg = ina2xx_writeable_reg,
>   };
>   
> -enum ina2xx_ids { ina219, ina226, ina260 };
> +enum ina2xx_ids { ina219, ina226, ina260, sy24655 };
>   
>   struct ina2xx_config {
>   	u16 config_default;
>   	bool has_alerts;	/* chip supports alerts and limits */
>   	bool has_ishunt;	/* chip has internal shunt resistor */
> +	bool has_power_average;	/* chip has internal shunt resistor */
>   	int calibration_value;
>   	int shunt_div;
>   	int bus_voltage_shift;
> @@ -149,6 +158,7 @@ struct ina2xx_data {
>   	long power_lsb_uW;
>   	struct mutex config_lock;
>   	struct regmap *regmap;
> +	struct i2c_client *client;
>   };
>   
>   static const struct ina2xx_config ina2xx_config[] = {
> @@ -161,6 +171,7 @@ static const struct ina2xx_config ina2xx_config[] = {
>   		.power_lsb_factor = 20,
>   		.has_alerts = false,
>   		.has_ishunt = false,
> +		.has_power_average = false,
>   	},
>   	[ina226] = {
>   		.config_default = INA226_CONFIG_DEFAULT,
> @@ -171,6 +182,7 @@ static const struct ina2xx_config ina2xx_config[] = {
>   		.power_lsb_factor = 25,
>   		.has_alerts = true,
>   		.has_ishunt = false,
> +		.has_power_average = false,
>   	},
>   	[ina260] = {
>   		.config_default = INA260_CONFIG_DEFAULT,
> @@ -180,6 +192,18 @@ static const struct ina2xx_config ina2xx_config[] = {
>   		.power_lsb_factor = 8,
>   		.has_alerts = true,
>   		.has_ishunt = true,
> +		.has_power_average = false,
> +	},
> +	[sy24655] = {
> +		.config_default = SY24655_CONFIG_DEFAULT,
> +		.calibration_value = 4096,
> +		.shunt_div = 400,
> +		.bus_voltage_shift = 0,
> +		.bus_voltage_lsb = 1250,
> +		.power_lsb_factor = 25,
> +		.has_alerts = true,
> +		.has_ishunt = false,
> +		.has_power_average = true,
>   	},
>   };
>   
> @@ -485,6 +509,42 @@ static int ina2xx_in_read(struct device *dev, u32 attr, int channel, long *val)
>   	return 0;
>   }
>   
> +/*
> + * Configuring the READ_EIN (bit 10) of the ACCUM_CONFIG register to 1
> + * can clear accumulator and sample_count after reading the EIN register.
> + * This way, the average power between the last read and the current
> + * read can be obtained. By combining with accurate time data from
> + * outside, the energy consumption during that period can be calculated.
> + */
> +static int sy24655_average_power_read(struct ina2xx_data *data, u8 reg, long *val)
> +{
> +	u8 template[6];
> +	int ret;
> +	long accumulator_24, sample_count;
> +	unsigned int regval;
> +
> +	/* 48-bit register read */
> +	ret = i2c_smbus_read_i2c_block_data(data->client, reg, 6, template);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 6)
> +		return -EIO;
> +	accumulator_24 = ((template[3] << 16) |
> +				(template[4] << 8) |
> +				template[5]);
> +	sample_count = ((template[0] << 16) |
> +				(template[1] << 8) |
> +				template[2]);
> +	if (sample_count <= 0) {
> +		*val = 0;
> +		return 0;
> +	}
> +
> +	*val = DIV_ROUND_CLOSEST(accumulator_24, sample_count) * data->power_lsb_uW;
> +
> +	return 0;
> +}
> +
>   static int ina2xx_power_read(struct device *dev, u32 attr, long *val)
>   {
>   	struct ina2xx_data *data = dev_get_drvdata(dev);
> @@ -492,6 +552,8 @@ static int ina2xx_power_read(struct device *dev, u32 attr, long *val)
>   	switch (attr) {
>   	case hwmon_power_input:
>   		return ina2xx_read_init(dev, INA2XX_POWER, val);
> +	case hwmon_power_average:
> +		return sy24655_average_power_read(data, SY24655_EIN, val);
>   	case hwmon_power_crit:
>   		return ina226_alert_limit_read(data, INA226_POWER_OVER_LIMIT_MASK,
>   					       INA2XX_POWER, val);
> @@ -651,6 +713,7 @@ static umode_t ina2xx_is_visible(const void *_data, enum hwmon_sensor_types type
>   {
>   	const struct ina2xx_data *data = _data;
>   	bool has_alerts = data->config->has_alerts;
> +	bool has_power_average = data->config->has_power_average;
>   	enum ina2xx_ids chip = data->chip;
>   
>   	switch (type) {
> @@ -668,6 +731,11 @@ static umode_t ina2xx_is_visible(const void *_data, enum hwmon_sensor_types type
>   			if (has_alerts)
>   				return 0444;
>   			break;
> +		case hwmon_power_average:
> +			if (has_power_average)
> +				return 0444;
> +			break;
> +			return 0444;
>   		default:
>   			break;
>   		}
> @@ -734,7 +802,8 @@ static const struct hwmon_channel_info * const ina2xx_info[] = {
>   	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM |
>   			   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM),
>   	HWMON_CHANNEL_INFO(power,
> -			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM),
> +			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM |
> +			   HWMON_P_AVERAGE),
>   	NULL
>   };
>   
> @@ -839,6 +908,19 @@ static int ina2xx_init(struct device *dev, struct ina2xx_data *data)
>   				   INA226_ALERT_LATCH_ENABLE |
>   						FIELD_PREP(INA226_ALERT_POLARITY, active_high));
>   	}
> +	if (data->config->has_power_average) {
> +		if (data->chip == sy24655) {
> +			/*
> +			 * Initialize the power accumulation method to continuous
> +			 * mode and clear the EIN register after each read of the
> +			 * EIN register
> +			 */
> +			ret = regmap_write(regmap, SY24655_ACCUM_CONFIG,
> +					   SY24655_ACCUM_CONFIG_DEFAULT);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
>   
>   	if (data->config->has_ishunt)
>   		return 0;
> @@ -868,6 +950,7 @@ static int ina2xx_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	/* set the device type */
> +	data->client = client;
>   	data->config = &ina2xx_config[chip];
>   	data->chip = chip;
>   	mutex_init(&data->config_lock);
> @@ -906,6 +989,7 @@ static const struct i2c_device_id ina2xx_id[] = {
>   	{ "ina230", ina226 },
>   	{ "ina231", ina226 },
>   	{ "ina260", ina260 },
> +	{ "sy24655", sy24655 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, ina2xx_id);
> @@ -935,7 +1019,11 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
>   		.compatible = "ti,ina260",
>   		.data = (void *)ina260
>   	},
> -	{ },
> +	{
> +		.compatible = "silergy,sy24655",
> +		.data = (void *)sy24655
> +	},

Should be in alphabetic order.

> +	{ }
>   };
>   MODULE_DEVICE_TABLE(of, ina2xx_of_match);
>   


