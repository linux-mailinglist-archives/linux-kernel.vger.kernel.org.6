Return-Path: <linux-kernel+bounces-380377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C99AED63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24728B2523F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F51FBF75;
	Thu, 24 Oct 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIqzW1Xz"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E491F76DC;
	Thu, 24 Oct 2024 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789841; cv=none; b=fjo00evmJ1epOkKpYFXeXhE6nTSWUmvDCyMSQMqLSvTD/Q8dHZqc0HUuikqvJ02j5MddSQXRfu6KMyLnbRZ0Z0TXP9Pr9YxBIPWNZKv6iYqODKh1kyP9uQK7LHfPAqoZFFn9am4wmjWZHPUpMBoEIBd3oZDW7JaSlj1vCIBhoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789841; c=relaxed/simple;
	bh=8b5KV1Q4r4l0EfB29uJ/xYQzxDvHZiUM7IXUxaoONYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9vyiveYTnGJGt7g6VDfW9/6o1xhZml3Xibd0FVbNh46FTsSBFGSNzHVEKXNJPejQuhfjKC5K5SZa3l+R8jIKJFNJwXiRUamEkhvFgUUTB4WDRnMLSKCzsBOkkXZoa9uKNAi2LPM6S7njCLVevI9gKMNZLAk0r4BbTcg9r9vWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIqzW1Xz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e681bc315so835927b3a.0;
        Thu, 24 Oct 2024 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729789838; x=1730394638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DcurmGZITqxZucOzfGQmA3p0Qf0OyPrPoxhKxDn0pTk=;
        b=kIqzW1XzK5mHhprLesL9FOINNxXZRn1MAcxLOU5Fsrr3qVS1XfivJyqM9K+GlMnCX6
         HMVGeREwG/cIoIZ+qDZ+3nwEZqt7i0wwN/ZDjRDhnNVj+X+jgs1DmALol+jHXlDIFeBU
         5oS884DhegpcsNEs105YV+0tU8qIJZQ4r/yG4sQ2RcoVtzni9Tv/BHZBstXn0t6i+MKt
         7W13ALFWycQDAEUsrsl80BHFi0RB+pqdgQdp/F9B+vF7CB30xxpspD7pQX+tb4ArBqwI
         +lH7xFfkRCWYvjfoxw+ANXwAs6/pCXUHFG6zhhEN+yKrWOBx3PGwvVTZBydU+8coQS8S
         25vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789838; x=1730394638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcurmGZITqxZucOzfGQmA3p0Qf0OyPrPoxhKxDn0pTk=;
        b=j8MJGlcmVhfKqFiCRqM10e8+VE/KPbJgfqYMS0xPXDowocFWxYnpxeKcFwKVmz42+x
         zOnv8u6UPmKqDSDcYwDKiWSXpBNLmgjFe79dh6YdD+mqyOd3OaavU8M8wRbdh5JhF2u0
         +SQ09EYROvyaRV+vgzpW5TaY4R75ICJDLgTUe+1DbE/6Ho3aD0zCE+09mjURDE5rwqjc
         csTgCMATbJ/Qi4GxMrUzZl454xRMH4ssNM/4OUt8H2hrz4ayFfcrzlgiTziU6/aj7ySP
         z89el/30LoNHgbZIjCcqTkZly6HWX7nxfJrfLCyEA5JDhTSfz71nVlYE+kz821Uz/gwO
         JWKA==
X-Forwarded-Encrypted: i=1; AJvYcCV7WTxAYvhxEz6fWfLVpykHf2z2B6bFmjQ4ZLklO5iqBw9KGO/QIqII98wQsChDJlpPhpBjlp6UsJjlYi+O@vger.kernel.org, AJvYcCXaKICCFgdN9Q7/p2gSpkNWoUn7XvJU4Ct1iQd1ujye7gXDAofr3z/fOwlSEE6VYN9I98Z3E9upuvyBfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7FNXYjzgcwfaDagTgf+JLzwDnmJlfd1QzDiTO3QhDHzyeAa0
	Dh/XUML/D+UbH7Lw/hIElILM7qFcXJCIvns0nHeGSG2B+QO8pLFgIr4w+Q==
X-Google-Smtp-Source: AGHT+IF+zyX/p9D3XDpIDx8XGwVWBEYvVJnpwBonKYxyzfTncenicQb+gAceqKP39O8vofFJu46YmQ==
X-Received: by 2002:a05:6a00:2316:b0:71e:76dc:10f7 with SMTP id d2e1a72fcca58-7204524951amr4643690b3a.4.1729789837607;
        Thu, 24 Oct 2024 10:10:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eaaafsm8475137b3a.170.2024.10.24.10.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 10:10:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <706d4821-2637-4aac-869b-822f69aebbfa@roeck-us.net>
Date: Thu, 24 Oct 2024 10:10:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hwmon: modified ina2xx to match SY24655
To: Wenliang <wenliang202407@163.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <80bfd968-8f12-46b1-9b72-837502ccdb2a@roeck-us.ne>
 <20241024083055.82047-1-wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241024083055.82047-1-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 01:30, Wenliang wrote:
> v3:Support the SY24655 for current and voltage detection as well as
> power calculation.
> 
> SY24655 provides a power accumulator, thus adding the power1_average
> parameter to output the average power, which can be used to calculate
> energy; In order to achieve average power, adding extra EIN register
> and ACCUM_CONFIG register addresses for SY24655. Due to the 48 bit
> read-only nature of the EIN register, a function has been added
> specifically for average power reading.
> 
Again, please consult
	Documentation/process/submitting-patches.rst
for both description and subject.

The subject should be something like

"hwmon: (ina226) Add support for SY24655".

The change log should be after "---".

The description needs to be in imperative mood. Something like

"""
SY24655 provides a power accumulator. Add support for the power1_average
attribute to report the average power.
"""

Implementation details are really irrelevant for the patch description.
I won't object if you add it, but please use imperative mood when doing so.
"adding" is not imperative mood.

> 
> Signed-off-by: Wenliang <wenliang202407@163.com>
> ---
> 
> 
> 
>   Documentation/hwmon/ina2xx.rst | 25 ++++++++-
>   drivers/hwmon/Kconfig          |  2 +-
>   drivers/hwmon/ina2xx.c         | 97 ++++++++++++++++++++++++++++++++--
>   3 files changed, 118 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina2xx.rst b/Documentation/hwmon/ina2xx.rst
> index 1ce161e6c0bf..eac8bb1deda0 100644
> --- a/Documentation/hwmon/ina2xx.rst
> +++ b/Documentation/hwmon/ina2xx.rst
> @@ -63,6 +63,16 @@ Supported chips:
>   
>   	       https://www.ti.com/
>   
> +  * Silergy SY24655
> +
> +
> +    Prefix: 'sy24655'
> +    Addresses: I2C 0x40 - 0x4f
> +
> +    Datasheet: Publicly available at the Silergy website
> +
> +	       https://us1.silergy.com/
> +
>   Author: Lothar Felten <lothar.felten@gmail.com>
>   
>   Description
> @@ -85,6 +95,11 @@ bus supply voltage.
>   INA260 is a high or low side current and power monitor with integrated shunt
>   resistor.
>   
> +The SY24655 is a high- and low-side current shunt and power monitor with an I2C
> +interface. The SY24655 both shunt drop and supply voltage, with programmable

SY24655 supports both ...

> +calibration value and conversion times. The SY24655 can also calculate average
> +power for use in energy conversion.
> +
>   The shunt value in micro-ohms can be set via platform data or device tree at
>   compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
>   refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
> @@ -108,7 +123,7 @@ power1_input		Power(uW) measurement channel
>   shunt_resistor		Shunt resistance(uOhm) channel (not for ina260)
>   ======================= ===============================================
>   
> -Additional sysfs entries for ina226, ina230, ina231, and ina260
> +Additional sysfs entries for ina226, ina230, ina231, ina260, and sy24655
>   ---------------------------------------------------------------
>   
>   ======================= ====================================================
> @@ -130,6 +145,14 @@ update_interval		data conversion time; affects number of samples used
>   			to average results for shunt and bus voltages.
>   ======================= ====================================================
>   
> +Sysfs entries for sy24655 only
> +------------------------------------------------

Does that pass generating the documentation ? Normally it wants
the "---" line to have the same length as the line above.

> +
> +======================= ====================================================
> +power1_average		calculate average power from last reading to the
> +			present.

Drop "calculate".

> +======================= ====================================================
> +
>   .. note::
>   
>      - Configure `shunt_resistor` before configure `power1_crit`, because power
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 64fefb22ecee..48b446c366f2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2178,7 +2178,7 @@ config SENSORS_INA2XX
>   	select REGMAP_I2C
>   	help
>   	  If you say yes here you get support for INA219, INA220, INA226,
> -	  INA230, INA231, and INA260 power monitor chips.
> +	  INA230, INA231, INA260, and SY24655 power monitor chips.
>   
>   	  The INA2xx driver is configured for the default configuration of
>   	  the part as described in the datasheet.
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index cecc80a41a97..9270af69ef6f 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -51,12 +51,20 @@
>   #define INA226_ALERT_LIMIT		0x07
>   #define INA226_DIE_ID			0xFF
>   
> -#define INA2XX_MAX_REGISTERS		8
> +/* SY24655 register definitions */
> +#define SY24655_EIN				0x0A
> +#define SY24655_ACCUM_CONFIG	0x0D
> +
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
> @@ -84,6 +92,8 @@
>   #define INA226_ALERT_CONFIG_MASK	GENMASK(15, 10)
>   #define INA226_ALERT_FUNCTION_FLAG	BIT(4)
>   
> +#define SY24655_EIN_OVERFLOW_FLAG	BIT(6)
> +
>   /*
>    * Both bus voltage and shunt voltage conversion times for ina226 are set
>    * to 0b0100 on POR, which translates to 2200 microseconds in total.
> @@ -97,6 +107,7 @@ static bool ina2xx_writeable_reg(struct device *dev, unsigned int reg)
>   	case INA2XX_CALIBRATION:
>   	case INA226_MASK_ENABLE:
>   	case INA226_ALERT_LIMIT:
> +	case SY24655_ACCUM_CONFIG:
>   		return true;
>   	default:
>   		return false;
> @@ -127,7 +138,7 @@ static const struct regmap_config ina2xx_regmap_config = {
>   	.writeable_reg = ina2xx_writeable_reg,
>   };
>   
> -enum ina2xx_ids { ina219, ina226, ina260 };
> +enum ina2xx_ids { ina219, ina226, ina260, sy24655 };
>   
>   struct ina2xx_config {
>   	u16 config_default;
> @@ -149,6 +160,8 @@ struct ina2xx_data {
>   	long power_lsb_uW;
>   	struct mutex config_lock;
>   	struct regmap *regmap;
> +	struct i2c_client *client;
> +

Unnecessary empty line.

>   };
>   
>   static const struct ina2xx_config ina2xx_config[] = {
> @@ -181,6 +194,16 @@ static const struct ina2xx_config ina2xx_config[] = {
>   		.has_alerts = true,
>   		.has_ishunt = true,
>   	},
> +	[sy24655] = {
> +		.config_default = SY24655_CONFIG_DEFAULT,
> +		.calibration_value = 2048,
> +		.shunt_div = 400,
> +		.bus_voltage_shift = 0,
> +		.bus_voltage_lsb = 1250,
> +		.power_lsb_factor = 25,
> +		.has_alerts = false,
> +		.has_ishunt = false,
> +	},
>   };
>   
>   /*
> @@ -485,6 +508,49 @@ static int ina2xx_in_read(struct device *dev, u32 attr, int channel, long *val)
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
> +	ret = regmap_read_bypassed(data->regmap, INA226_MASK_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (regval & SY24655_EIN_OVERFLOW_FLAG)
> +		return -ENOMEM;

I don't know what error code to return here, or if it makes sense to return an error
in the first place, but it is not "out of memory". If an error is returned,
the documentation needs to explain what the user is expected to do about it.
Just returning an error is not useful.

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
> @@ -492,6 +558,8 @@ static int ina2xx_power_read(struct device *dev, u32 attr, long *val)
>   	switch (attr) {
>   	case hwmon_power_input:
>   		return ina2xx_read_init(dev, INA2XX_POWER, val);
> +	case hwmon_power_average:
> +		return sy24655_average_power_read(data, SY24655_EIN, val);
>   	case hwmon_power_crit:
>   		return ina226_alert_limit_read(data, INA226_POWER_OVER_LIMIT_MASK,
>   					       INA2XX_POWER, val);
> @@ -702,6 +770,8 @@ static umode_t ina2xx_is_visible(const void *_data, enum hwmon_sensor_types type
>   			if (has_alerts)
>   				return 0444;
>   			break;
> +		case hwmon_power_average:
> +			return 0444;

This is wrong. It must only return 0444 if the chip is sy24655
(or, to support other chips of the series at some later point,
if a flag such as has_power_average is added and set in struct
ina2xx_config).

>   		default:
>   			break;
>   		}
> @@ -734,7 +804,8 @@ static const struct hwmon_channel_info * const ina2xx_info[] = {
>   	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM |
>   			   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM),
>   	HWMON_CHANNEL_INFO(power,
> -			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM),
> +			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM |
> +			   HWMON_P_AVERAGE),
>   	NULL
>   };
>   
> @@ -840,6 +911,18 @@ static int ina2xx_init(struct device *dev, struct ina2xx_data *data)
>   						FIELD_PREP(INA226_ALERT_POLARITY, active_high));
>   	}
>   
> +	if (data->chip == sy24655) {
> +		/*
> +		 * Initialize the power accumulation method to continuous
> +		 * mode and clear the EIN register after each read of the
> +		 * EIN register
> +		 */
> +		ret = regmap_write(regmap, SY24655_ACCUM_CONFIG,
> +				   SY24655_ACCUM_CONFIG_DEFAULT);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	if (data->config->has_ishunt)
>   		return 0;
>   
> @@ -868,6 +951,7 @@ static int ina2xx_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	/* set the device type */
> +	data->client = client;
>   	data->config = &ina2xx_config[chip];
>   	data->chip = chip;
>   	mutex_init(&data->config_lock);
> @@ -906,6 +990,7 @@ static const struct i2c_device_id ina2xx_id[] = {
>   	{ "ina230", ina226 },
>   	{ "ina231", ina226 },
>   	{ "ina260", ina260 },
> +	{ "sy24655", sy24655 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, ina2xx_id);
> @@ -935,7 +1020,11 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
>   		.compatible = "ti,ina260",
>   		.data = (void *)ina260
>   	},
> -	{ },
> +	{
> +		.compatible = "silergy,sy24655",
> +		.data = (void *)sy24655
> +	},
> +	{ }
>   };
>   MODULE_DEVICE_TABLE(of, ina2xx_of_match);
>   


