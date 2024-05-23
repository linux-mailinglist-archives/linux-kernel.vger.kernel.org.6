Return-Path: <linux-kernel+bounces-186996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E573D8CCBAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE3B21870
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D91129E93;
	Thu, 23 May 2024 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrF3uUL3"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC8C17F6;
	Thu, 23 May 2024 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716441112; cv=none; b=Wq3XBtel16Pzt8QhQ8oAkM81aJ51vkd28EeXwPGSCnhhdJfmTJgimehbvZKdnS5tgYJ40V5e1OnXo0+2iPCss7WPKbOX2oljFLC2QZKuBoHFlT9d+EdIfARr2lbZwXfL6dSUuVRvkmTrBSPbsXha3ksSKjyHpa1rxGf8tZZtu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716441112; c=relaxed/simple;
	bh=RBKW8SDKEk1sUR6t3kEj2pdyIuZJaibBGlTDVf/EAEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UyYd2u6b/+Q+un6Mc8i+uEV1jw+YSNkwnawFnm73kMG+jBdP9GAfo12TSBFiBTGcyb4UALMJLK9ltwc8uu8W3jWGzlhdZcvCxUkjbu2svNzfMjN7utP6F4E0ToD8H2J6c8STN9LVYhIG3HWvFMaGTDxHjEJj6O+todorbl59xC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrF3uUL3; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9b94951d5so2875263b6e.3;
        Wed, 22 May 2024 22:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716441110; x=1717045910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CnocMPvO0Zq6EystdpiClmbIYkS+OF1BxnCWXU7ItHE=;
        b=OrF3uUL33n03oiaYI91Wb9xlFCXEFeF85pQwV2sJHrmr+0vHwIR/YkYqPm7Pq7YF3A
         KQlpbjRvYtW8sAxUQWg7H/6MyKM/aXVQLNGpP8U089/EFBW6sAItriBwLl4HvYJBuQAI
         m/ZgBgiKoyxnIebkQms88u5HrmmQdYLij3jF53FJZKzObdVsf/2MeHZESGFY955CfAhH
         dkPOsaoesmxSpOiXENKuidSJjr6S3Lei9w3GBgH6GfECqgxIxpltbKpJ/KBRrof3fLsR
         /fDnwxnvPWs1gBMtG5Qw0v70Bz4qClBdy7w42rtpUhKR2WK1nz847VisjdCqDjGDm+55
         CcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716441110; x=1717045910;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnocMPvO0Zq6EystdpiClmbIYkS+OF1BxnCWXU7ItHE=;
        b=dSAnUZLQVoYRkUo0VJlSxdF0anwP4LwdQTXPePIg80zIiP0ETIWEFdrs+g01WgUr5h
         Nfgp/lTgMG47B4FZ4sowuu14k6i7+sWlaGjs8KBueR72RkCnheRWbl8GNDduM69docRX
         IxnPJzOSZmw0CW4QloY3A9NH/Zwhqln19od5BrV9JPygyn5d68iLM3uMeEgyU/SdbCso
         XhcEVE+jO0sZoTaOZ4/F8jN+XaYwbEdd5OdyWDGn66HKcBBfbTyifdtXvSJpDLh7ILmY
         UJkk9X/TqsKY8d5bW8coAVjlMXDkT4FtJlgpfEA9blPGW05vTlSPDbsq5JPYog8/gdu6
         ZoGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0LulwbiTW7QuTczu5QV9rZM+F1vgTCgLniZDVaYna/2OLKq1Q6fVMgyN/2rUrvBiGz0lywkC2lAdTHUR4kVH5hp08AGaZz5QdNGI3d4qTVN5ba7b20hfSTITTtStSPC3gycDNobvwW7VmjNuKCJkAJ4CndQFjQYNhpgajU9d0wyJMPpM=
X-Gm-Message-State: AOJu0YyevwKkB0LbvexaY9QFHQnaqT/hmboQ6cHThCj+GHEVcFKjc56n
	+0+UyI/1s0IMFkDc0gWs5IbiIVzdyhJx9tiGsbdFuoqOacrhYEGx4NOjoA==
X-Google-Smtp-Source: AGHT+IEfNEaW4002ir0/i77Lus2FarsHejDOcD6JuZan6UeVM5Pad9Qpgu2QWl6keKD/oU71x/8BUg==
X-Received: by 2002:aca:1b05:0:b0:3c7:4976:7953 with SMTP id 5614622812f47-3cdb32e46b6mr4059865b6e.3.1716441109731;
        Wed, 22 May 2024 22:11:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66557sm23168954b3a.44.2024.05.22.22.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 22:11:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9ea574e6-711c-43b4-8a5c-2182b4500e08@roeck-us.net>
Date: Wed, 22 May 2024 22:11:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers: hwmon: max31827: Add PEC support
To: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522123923.22320-1-radu.sabau@analog.com>
 <20240522123923.22320-2-radu.sabau@analog.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240522123923.22320-2-radu.sabau@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 05:39, Radu Sabau wrote:
> Add support for PEC by attaching PEC attribute to the i2c device.
> Add pec_store and pec_show function for accesing the "pec" file.
> 
accessing

> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

There are lots of unrelated changes. Please drop all those, or
if they are supposed to fix checkpatch problems submit as separate
patches. I will not accept coding style changes unless they fix
checkpatch problems.

The patch is not based on the latest kernel. Please rebase
at least on top of v6.9.

More comments inline.

>   Documentation/hwmon/max31827.rst | 13 ++++-
>   drivers/hwmon/max31827.c         | 95 +++++++++++++++++++++++++++-----
>   2 files changed, 92 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index 44ab9dc064cb..9c11a9518c67 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -131,7 +131,14 @@ The Fault Queue bits select how many consecutive temperature faults must occur
>   before overtemperature or undertemperature faults are indicated in the
>   corresponding status bits.
>   
> -Notes
> ------
> +PEC Support
> +-----------
> +
> +When reading a register value, the PEC byte is computed and sent by the chip.
> +
> +PEC on word data transaction respresents a signifcant increase in bandwitdh
> +usage (+33% for both write and reads) in normal conditions.
>   
> -PEC is not implemented.
> +Since this operation implies there will be an extra delay to each
> +transaction, PEC can be disabled or enabled through sysfs.
> +Just write 1  to the "pec" file for enabling PEC and 0 for disabling it.
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index f8a13b30f100..16a1524413db 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -11,19 +11,20 @@
>   #include <linux/hwmon.h>
>   #include <linux/i2c.h>
>   #include <linux/mutex.h>
> -#include <linux/of_device.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
> +#include <linux/of_device.h>
>   

Include files should be in alphabetic order. The above change
deserves a NACK.

> -#define MAX31827_T_REG			0x0
> +#define MAX31827_T_REG	0x0
>   #define MAX31827_CONFIGURATION_REG	0x2
> -#define MAX31827_TH_REG			0x4
> -#define MAX31827_TL_REG			0x6
> -#define MAX31827_TH_HYST_REG		0x8
> -#define MAX31827_TL_HYST_REG		0xA
> +#define MAX31827_TH_REG	0x4
> +#define MAX31827_TL_REG 0x6
> +#define MAX31827_TH_HYST_REG	0x8
> +#define MAX31827_TL_HYST_REG	0xA
>   
>   #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
>   #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
> +#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
>   #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
>   #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
>   #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
> @@ -46,6 +47,8 @@
>   #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
>   #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
>   
> +#define DEBUG_FS_DATA_MAX	16
> +
>   enum chips { max31827 = 1, max31828, max31829 };
>   
>   enum max31827_cnv {
> @@ -151,8 +154,8 @@ static int shutdown_write(struct max31827_state *st, unsigned int reg,
>   		goto unlock;
>   
>   	ret = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> -				 MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -				 cnv_rate);
> +				   MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +				   cnv_rate);
>   
>   unlock:
>   	mutex_unlock(&st->lock);
> @@ -344,7 +347,7 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   		switch (attr) {
>   		case hwmon_temp_enable:
>   			if (val >> 1)
> -				return -EINVAL;
> +				return -EOPNOTSUPP;

Why ?

>   
>   			mutex_lock(&st->lock);
>   			/**
> @@ -384,7 +387,7 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   	case hwmon_chip:
>   		if (attr == hwmon_chip_update_interval) {
>   			if (!st->enable)
> -				return -EINVAL;
> +				return -EOPNOTSUPP;
>   
>   			/*
>   			 * Convert the desired conversion rate into register
> @@ -472,11 +475,60 @@ static ssize_t temp1_resolution_store(struct device *dev,
>   
>   	return ret ? ret : count;
>   }
> -
>   static DEVICE_ATTR_RW(temp1_resolution);
>   
> +static ssize_t pec_show(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
> +}
> +
> +static ssize_t pec_store(struct device *dev, struct device_attribute *devattr,
> +			 const char *buf, size_t count)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned int val, val2;
> +	int err;
> +
> +	err = kstrtouint(buf, 10, &val);
> +	if (err < 0)
> +		return err;
> +
> +	val2 = FIELD_PREP(MAX31827_CONFIGURATION_PEC_EN_MASK, !!val);

This is completely unnecessary.

> +
> +	switch (val) {
> +	case 0:
> +		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
> +					 val2);

	s/val2/0/

> +		if (err)
> +			return err;
> +
> +		client->flags &= ~I2C_CLIENT_PEC;
> +		break;
> +	case 1:
> +		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
> +					 val2);

	s/val2/MAX31827_CONFIGURATION_PEC_EN_MASK/

> +		if (err)
> +			return err;
> +
> +		client->flags |= I2C_CLIENT_PEC;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(pec);
> +
>   static struct attribute *max31827_attrs[] = {
>   	&dev_attr_temp1_resolution.attr,
> +	&dev_attr_pec.attr,

Attach to i2c interface.

Oh, wait, you are doing that as well. So there would be two
"pec" attribute files, one attached to the i2c interface
and one attached to the hwmon interface. Care to explain ?

>   	NULL
>   };
>   ATTRIBUTE_GROUPS(max31827);
> @@ -493,8 +545,8 @@ static int max31827_init_client(struct max31827_state *st,
>   				struct device *dev)
>   {
>   	struct fwnode_handle *fwnode;
> +	unsigned int data, lsb_idx;
>   	unsigned int res = 0;
> -	u32 data, lsb_idx;

I am quite completely at loss trying to understand why you are making those changes.

>   	enum chips type;
>   	bool prop;
>   	int ret;
> @@ -578,6 +630,11 @@ static int max31827_init_client(struct max31827_state *st,
>   	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
>   }
>   
> +static void max31827_remove_pec(void *dev)
> +{
> +	device_remove_file(dev, &dev_attr_pec);
> +}
> +
>   static const struct hwmon_channel_info *max31827_info[] = {
>   	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_MIN |
>   					 HWMON_T_MIN_HYST | HWMON_T_MIN_ALARM |
> @@ -627,6 +684,16 @@ static int max31827_probe(struct i2c_client *client)
>   	if (err)
>   		return err;
>   
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_PEC)) {

This does not make sense. If the controller does not support PEC,
it does not make sense to provide an attribute to enable it.

> +		err = device_create_file(dev, &dev_attr_pec);
> +		if (err)
> +			return err;
> +
> +		err = devm_add_action_or_reset(dev, max31827_remove_pec, dev);
> +		if (err)
> +			return err;
> +	}
> +
>   	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
>   							 &max31827_chip_info,
>   							 max31827_groups);
> @@ -652,15 +719,17 @@ static const struct of_device_id max31827_of_match[] = {
>   MODULE_DEVICE_TABLE(of, max31827_of_match);
>   
>   static struct i2c_driver max31827_driver = {
> +	.class = I2C_CLASS_HWMON,
>   	.driver = {
>   		.name = "max31827",
>   		.of_match_table = max31827_of_match,
>   	},
> -	.probe = max31827_probe,
> +	.probe_new = max31827_probe,
>   	.id_table = max31827_i2c_ids,
>   };
>   module_i2c_driver(max31827_driver);
>   
>   MODULE_AUTHOR("Daniel Matyas <daniel.matyas@analog.com>");
> +MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");

Providing a patch to a driver does not make you the author.

>   MODULE_DESCRIPTION("Maxim MAX31827 low-power temperature switch driver");
>   MODULE_LICENSE("GPL");


