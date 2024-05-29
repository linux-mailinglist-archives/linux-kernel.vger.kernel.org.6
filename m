Return-Path: <linux-kernel+bounces-194231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EA8D38B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3319428236F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05941CFBD;
	Wed, 29 May 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vst+Qvzu"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497124C83;
	Wed, 29 May 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991641; cv=none; b=NCPvTVNhZRQ33gcSCf8cuK8GVAnetIgjBmVB3nzYp2vlzmmpz71hu1xmWkMyAH+nlkfu5sD0y7FRNuo+dKrsfnkISRZQj496X915zcPPatM734oE79d/fxAb5DaijCjH4uyGRAoVtg7VDnS21XqADLHTbaTrvhiW4eeLD1c/W2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991641; c=relaxed/simple;
	bh=8aAQl6vo/460yrxhxt6zDyqiOWfsxNKRVIOR41neUFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKFbqQyBudaAsZbCj8tiwpf+OQKjgqZ2THryT1I7TFVXPWbFVWMBXcpwdXeEFV9xzSb0mMAekQ18M4jagn6mAj20oiHSlIN6oOGqgpmvSyDYg2rCaPJQr7uq9HvstCnUDuE/2nQ+e39mMbU7H1hhzufSImBkbagFBzm2/Z5UwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vst+Qvzu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c034b016e6so478997a91.2;
        Wed, 29 May 2024 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991639; x=1717596439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZzzbwW0Sya6qTFwpCKnB6KXP4SAHrttnB1q+QFBqeU=;
        b=Vst+QvzuJ7WQHRViSfomiloDSyU+15VUhfGtrjTHjOl2uU8prok9I7tcTLES0uAqsC
         ktoA43Pn0rBwIdgUkz11H/DfBFc+bz/hH9u03kWUi8jwfvwM9yfUBQHrT19CB9KQTjhg
         dHcNhNbukJRTzKKAmAUxiI10xGyGq7YgDdYSiHhQRlJBqSjWVwrg7jDpjB6SBg+HA+QT
         17X4h3ymmQ6Q1AHMt4vnqH6Oan7lZm1Zr+QhsxMmdahKcjiZtNtZrsiibhXhxyxgPyr6
         0FeegoMAtniray3az5cv3+SgAqalBPFOsHi0LaZxoJZFMbo4oCVGtXAl5xkUwxo9WxY4
         tLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991639; x=1717596439;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZzzbwW0Sya6qTFwpCKnB6KXP4SAHrttnB1q+QFBqeU=;
        b=HYV+qCFvhotRsR5BOQVJ5a7IzrwR8ZVrLIH9T2hFwp2yPfBhk1iMgl0KLkkHGKw7EH
         XTqN+tft3x+ExLpOilNQAZVhhMVr15WKynrnGELx3K/HAc7LkakhkDxaxfbJ/hczKeyC
         F/l4qFKKfzVolW2LhYMUnf+DhcBCF+RPJi2GkGKnt+gtq41dsRgMvg9iOa6i2wHI/cA/
         AG4yoz8UfCdaL8hnukOVFbaZ6A74DJRkpjh16AtXLEoqoy7eCclqhSBJuL+U7bt+ce8B
         GEft+UFV+dEGLFtHTk0Up798EEH/3ucn5uOk14llP0ocqzhRXfRLwPNK/GMDjN2WBeuy
         svAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFUXoZfIK0RljAzWfSAjBPv1IDIjptXKVySqo8dMOmteXa0mahpLSTT03Zo5gikkFd64fFbHOZcsIqj6qUMQrlwvK0+lRAkqysJihuFZSPEFxsr9QamKW9yHu/U203KwGRytEX94HCYTAQg3ocrf/JpttiLeDidD59rUY06TY5V4vq1wo1
X-Gm-Message-State: AOJu0YwNqT0XhBEJ4XhtNb7xcPT0Qbygurs2MJP+5jiYh3bg8mfpMRZK
	/VlOiPDrvkhcreG5+rILy3aNRtQptnW0HsUpjPLxKZQ9zQpqayg+lIvTxQ==
X-Google-Smtp-Source: AGHT+IGdlyoKbfUN7gGq/OTsQ0IM0CGrJEi+RALVM7zGBlBuxtEmE/7AkVUqfNTQ/H7mFc/ntdjQLA==
X-Received: by 2002:a17:90b:1046:b0:2bd:d6c3:2430 with SMTP id 98e67ed59e1d1-2bf5f1081b1mr14089429a91.40.1716991639252;
        Wed, 29 May 2024 07:07:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf57720f19sm9852521a91.56.2024.05.29.07.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 07:07:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6f2d2e7e-99b4-4f5d-a2c5-523b5534917b@roeck-us.net>
Date: Wed, 29 May 2024 07:07:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (ina2xx) Add device tree support to pass alert
 polarity
To: Amna Waseem <Amna.Waseem@axis.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
 <20240529-apol-ina2xx-fix-v1-2-77b4b382190f@axis.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240529-apol-ina2xx-fix-v1-2-77b4b382190f@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 23:07, Amna Waseem wrote:
> The INA230 has an Alert pin which is asserted when the alert
> function selected in the Mask/Enable register exceeds the
> value programmed into the Alert Limit register. Assertion is based
> on the Alert Polarity Bit (APOL, bit 1 of the Mask/Enable register).
> It is default set to value 0 i.e Normal (active-low open collector).
> However, hardware can be designed in such a way that expects Alert pin
> to become active high if a user-defined threshold in Alert limit
> register has been exceeded. This patch adds a way to pass alert polarity
> value to the driver via device tree.
> 
> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
> ---
>   drivers/hwmon/ina2xx.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index d8415d1f21fc..b58e795bdc8f 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -73,6 +73,9 @@
>   #define INA226_READ_AVG(reg)		(((reg) & INA226_AVG_RD_MASK) >> 9)
>   #define INA226_SHIFT_AVG(val)		((val) << 9)
>   
> +#define INA226_ALERT_POLARITY_MASK		0x0002
> +#define INA226_SHIFT_ALERT_POLARITY(val)	((val) << 1)
> +
>   /* bit number of alert functions in Mask/Enable Register */
>   #define INA226_SHUNT_OVER_VOLTAGE_BIT	15
>   #define INA226_SHUNT_UNDER_VOLTAGE_BIT	14
> @@ -178,6 +181,23 @@ static u16 ina226_interval_to_reg(int interval)
>   	return INA226_SHIFT_AVG(avg_bits);
>   }
>   
> +static int ina2xx_set_alert_polarity(struct ina2xx_data *data,
> +				     unsigned long val)
> +{
> +	int ret;
> +
> +	if (val > INT_MAX || !(val == 0 || val == 1))

	if (val != 0 && val !=1)

would be sufficient and much easier to understand.

> +		return -EINVAL;
> +
> +	mutex_lock(&data->config_lock);

Pointless lock.

> +	ret = regmap_update_bits(data->regmap, INA226_MASK_ENABLE,
> +				 INA226_ALERT_POLARITY_MASK,
> +				 INA226_SHIFT_ALERT_POLARITY(val));
> +
> +	mutex_unlock(&data->config_lock);
> +	return ret;
> +}
> +
>   /*
>    * Calibration register is set to the best value, which eliminates
>    * truncation errors on calculating current register in hardware.
> @@ -659,6 +679,14 @@ static int ina2xx_probe(struct i2c_client *client)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "failed to enable vs regulator\n");
>   
> +	if (!of_property_read_u32(dev->of_node, "alert-polarity", &val)) {
> +		ret = ina2xx_set_alert_polarity(data, val);
> +		if (ret < 0)
> +			return dev_err_probe(
> +				dev, ret,
> +				"failed to set APOL bit of Enable/Mask register\n");
> +	}

INA219 and INA220 do not support alert pin configuration (or, naturally,
the mask register in the first place). This will need to be validated.

Guenter


