Return-Path: <linux-kernel+bounces-519715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E72A3A0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25C6165F03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662E26B943;
	Tue, 18 Feb 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHjjiTGJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D226B2DD;
	Tue, 18 Feb 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892042; cv=none; b=XiuxsV8prwIc0YkTKifoTXCBhpzB6eEmAsO0HhV5HsnJzUVihUlfFD1qYXbRZSN7bJadJjpG5oEuyI/GU3JQ2meKQfdBf1FFAiIli9zltpQolzX0+2Yz2jbHKfknXyCaSJIWeguCb+KAKsUU6SB94ZJR+MHXWEVPBY3NS/0tf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892042; c=relaxed/simple;
	bh=Gjf0kJ9HEyQ34wGkt26kNLZ83JYuY0vFR+qmzLBpVSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnsndUd8BDaq6x3zYeOx7c33YGqWkGXhw0VIEMpzH58tbg8yt8HQzWSE4/AvshrcfFV+fi89mwaE858rjVeQOcZtPHIPoBUTIbZX/IJGNpzEfE8hbpoQgGHTMX0NjRbGBg6+s2WpVzm9Z4aD4V0hM9L1YZN9dtrCvK6kPS6ue7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHjjiTGJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220f048c038so70754585ad.2;
        Tue, 18 Feb 2025 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739892039; x=1740496839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wqlDiu9+4PXHTzdQ8LtnGZRIIPBAU7VrwG1yyrtoKCQ=;
        b=HHjjiTGJvA0Mxgwyf/WmrjcrZCA8D72OjZiT/V86T33EA5SQBkNz/4K+9BwJKMjixG
         nY3yN2IMKg/UGIYYvYQjdWJogO5brS5VW9jnDZdiIapE99dMzfeLSwMf9jHxeW3Ih3dO
         mJAUI7aDsARnHC0511xtSqlCszwvU1x7wWu3wQ4FTuV1HJ3X4zgJgs9K0Cxq89Ku9T6q
         JV+wd+wtjpPqZcabzCd8GUxLw16tFdajtsy+KXUnLdBChtJVxumqyJymIg/aB+636F1/
         G7Cr1GiLtLNY/SEwnBTskHpu5TSestoCOjem09PhNpjC0U5kJ+NhVMny/XZceo1XMNnC
         U3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892039; x=1740496839;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqlDiu9+4PXHTzdQ8LtnGZRIIPBAU7VrwG1yyrtoKCQ=;
        b=D3U6QsmFkgPnQjjVt51/0XgHE8+RnyYijB+riAwe75glvNqL4ot1L3qhYUVazxfevg
         3Mk2ooewtb1MfGnwunjBSZvxh2wkS1eRVuPXIXPxbtGBQBnhhg5nBLP6FrekIcu1Q07J
         T/wHt7p8KdQRIXlO9bi9FJVGa1plJubVvXlPkn2vCeVREqyw0hS5e/Proo/7p6iTNf8x
         madO6cYn+GYCHV7ijF291eA5Z+oAnH540WgBN0Kx7Qk0s9m+WdlI/0cDJ/2jZ9YcnmuD
         9TyiT9zQ6/y0LKWufTBH/G6YOhqbyFGmBB8zUTR5ZV+WiubV1N0TQ4P3+uKTBrkE3QBK
         mKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8IBgt4etKY/nVcjArpFuYDaSDplOIqLM59o4jSKsB/Lht40VEiR/LbL0xRdf9mBP2AjP8BHlQbKnI@vger.kernel.org, AJvYcCVGSM3djFzG6wpps4+9835uC/ZjPMET9Z/jKoR9woQ0R0nYfo70HkcFWnhJBvszoLr++4oSgQ4H+Dl3xcQ=@vger.kernel.org, AJvYcCWAdOqFhofSW7WQvl4SdommwEUosQvnmOqO7zX5uj9e0KyV+djDlEdht8MyNVB91ASGX8JtoZ92eQcNMk0=@vger.kernel.org, AJvYcCXAHTjVGc234wXfEzBkxjWcc2Wh6XATwTFa2RVEOIlLbe8SL8J+ldgsjlLK59qkpqU33r/nB7HjjCjqtMOb@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcs7AunYjAUr0HVVPxQAw2YnCZYDBsqBdCbZ5o6ddm8vPV8Gl
	g+OPa8yQeC22HpznZfEOogdN/ikzAEgVMm/r6dDYA4CMmcQu+i8M
X-Gm-Gg: ASbGncscRdb3wq8tpaAI1w6cvzZ6CyxWnD7BjA655CgHEdY1TvPL8FylhLaUy0IO1AW
	Jtp2XBJANjyZNigQ2vKKNM59dUnKc0HDiCzf2MTVmdvpgM4CkPSNRKxoTpQck4InHwgWEYZzMi1
	WNHEZgwewLV6XGqFrffcU4eFESZNjGvY1VhZXAOG5dSn70o2QNjK2tNXudn5FwKmPRycLH8pL8U
	GGX3A/V5/W+L0CgOOSIkgnIOBwBXTGtWUiwnZduHBPlQnWTtGiN7thJXj8WPAcNhBkgpeE3c9iD
	qOPU95NqeCal/X33LQnlsAQs1M8YIIpnnWoBaAmy/jQI5NZhQhpDJm7p+8Z1OIiu
X-Google-Smtp-Source: AGHT+IGFYo4EVA9fVJUwiKOKVkLfMpTPYy0wXj38DXcmwkklM1Y5i6yij/daLZ/w5gkqFsleIq2M9w==
X-Received: by 2002:a17:902:ce06:b0:21d:3bee:990c with SMTP id d9443c01a7336-221040a99cemr225673635ad.42.1739892039240;
        Tue, 18 Feb 2025 07:20:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536455esm90870965ad.74.2025.02.18.07.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:20:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e0e2ae0-c53d-444c-9d8a-d465be690232@roeck-us.net>
Date: Tue, 18 Feb 2025 07:20:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/29] ASoC: tas2770: expose die temp to hwmon
To: James Calligeros <jcalligeros99@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-14-932760fd7e07@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250218-apple-codec-changes-v2-14-932760fd7e07@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/25 00:35, James Calligeros wrote:
> Create and register a hwmon device to export the die temperature
> to the hwmon interface
> 
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
>   sound/soc/codecs/tas2770.c | 69 +++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
> index 84066884d36be8d41d83bca5680e9f683c420d78..fee99db904a5885d740c1cfe8ce2645a963c6e1d 100644
> --- a/sound/soc/codecs/tas2770.c
> +++ b/sound/soc/codecs/tas2770.c
> @@ -12,6 +12,7 @@
>   #include <linux/err.h>
>   #include <linux/init.h>
>   #include <linux/delay.h>
> +#include <linux/hwmon.h>
>   #include <linux/pm.h>
>   #include <linux/i2c.h>
>   #include <linux/gpio/consumer.h>
> @@ -537,6 +538,61 @@ static struct attribute *tas2770_sysfs_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(tas2770_sysfs);
>   
> +#if defined(CONFIG_HWMON)

If this works with CONFIG_TAS2770=y and CONFIG_HWMON=m, the ifdef is unnececessary
because IS_REACHABLE() is used below and the code will be optimized away if
it is not reachable.

> +static umode_t tas2770_hwmon_is_visible(const void *data,
> +					enum hwmon_sensor_types type, u32 attr,
> +					int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tas2770_hwmon_read(struct device *dev,
> +			      enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long *val)
> +{
> +	struct tas2770_priv *tas2770 = i2c_get_clientdata(to_i2c_client(dev));
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		ret = tas2770_read_die_temp(tas2770, (int *)val);

Type casting a pointer like this is never a good idea. This only works
if sizeof(int) == sizeof(long).

> +		if (!ret)
> +			*val *= 1000;

The calculations in the previous patch suggest that this is wrong.

Either case, this is redundant. The temperature is already displayed
as device specific sysfs attribute. Displaying it twice does not make sense.
I would suggest to either drop the sysfs attribute in the previous patch
or to drop this patch.

Guenter

> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct hwmon_channel_info *const tas2770_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops tas2770_hwmon_ops = {
> +	.is_visible	= tas2770_hwmon_is_visible,
> +	.read		= tas2770_hwmon_read,
> +};
> +
> +static const struct hwmon_chip_info tas2770_hwmon_chip_info = {
> +	.ops	= &tas2770_hwmon_ops,
> +	.info	= tas2770_hwmon_info,
> +};
> +#endif
> +
>   static const struct regmap_config tas2770_i2c_regmap;
>   
>   static int tas2770_codec_probe(struct snd_soc_component *component)
> @@ -768,6 +824,19 @@ static int tas2770_i2c_probe(struct i2c_client *client)
>   	if (result)
>   		dev_err(tas2770->dev, "Register codec failed.\n");
>   
> +	if (IS_REACHABLE(CONFIG_HWMON)) {
> +		struct device *hwmon;
> +
> +		hwmon = devm_hwmon_device_register_with_info(&client->dev, "tas2770",
> +							tas2770,
> +							&tas2770_hwmon_chip_info,
> +							NULL);
> +		if (IS_ERR(hwmon)) {
> +			return dev_err_probe(&client->dev, PTR_ERR(hwmon),
> +					     "Failed to register temp sensor\n");
> +		}
> +	}
> +
>   	return result;
>   }
>   
> 


