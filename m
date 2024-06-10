Return-Path: <linux-kernel+bounces-208552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 789889026B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB4A287063
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38B3143864;
	Mon, 10 Jun 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhKY5lZW"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992DB5B1F8;
	Mon, 10 Jun 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036958; cv=none; b=PDQZNR70u8QLPj4JNwzuotyd0wV/KCdg+KG2aBHv2T2to/2t7If7cswuXCkJynYsAwx3B/cKa+36V4OIMcq+DpFNyh/x5AV6m0Ih1Ld2kdDwN0BBJpgAd/gbltzfRGupzb5Bw8KH4xHaQjNqVWDNJXbwEeK521l0G6oODFurc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036958; c=relaxed/simple;
	bh=XbZF71q1zYnvPsR2ymkEb7s6SSdeVRGUxy4y1HaDNj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJcVK3vsOkDS2TA+YZReIp8/hnCKQLcHdjLcXXDlSimdOFrTEUCL3/MrPlJR6sW27AfAUKEzNqcm5kFgB9TaPUNfIwOOXtxS98nS4l/YUXUh7VoQgY599u/LFqRjhgk+TdT2u0pgpX+riHATsTKu5/2fkqxCjkwWR+f9/L3r67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhKY5lZW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f480624d10so41525485ad.1;
        Mon, 10 Jun 2024 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718036956; x=1718641756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vFW4QMDXEfiSRxy7aS4QsiVoTt08DVq0GrTNcQt+urE=;
        b=nhKY5lZWj68rnTFyiMmZmRTKHnQbPa6mbWxuPrpc96pDtjPKJmXqnfs3bT4BMIXZcu
         UnlP6K/ovePHnHqOts3Dl6xvM4t+HXrfSI3IKazKsqw6x6jEQcCq/nbtdqKy2aMPeDqd
         4gi061l56oH9zEQBQNLwEyOYj2/2IS77cBecOEoInvDDUeFSMFNaA8RAJf1Ks46+zVft
         Hu+sLOrAwEiedJIUYI7WXKPHDlG/eRSUtN0wa9bFGu+51GJZrFl7D/L1EWMQjnArNG4+
         /sgDoUFlOw8CB0JD0eXEmwuCOy2S9WM/l/bBlwwBPy3hhfJ29UAzWV4i9qMtQiP3E3aU
         dljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718036956; x=1718641756;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFW4QMDXEfiSRxy7aS4QsiVoTt08DVq0GrTNcQt+urE=;
        b=If4wbNX78LBSEwYCh8Q+JRTQGxvCxAISiCrzH+eakreL4WEFkooldjB/vwDdn5KNgG
         hpAnHB68ds/T0KGfMmwPRsRYdF7pt97R6jiAVxiLaEKEOVgaRQ2Tduu7SZk3qYse3dsJ
         q7/uHCIurEKQQEe9gtlFQw6x8O1zBV+JKbVjJoQYMO+DJDYYrfG0Bb3BkxW1sbwyVUYt
         /U/4h1mh+U32BfxQvb8f5W0hg8wHaqKa4hYGU1bnMJQzO7Au68QFWLMG7u9Tp3kYC9Sq
         ns3+13Olhf92eTao6Cc3iBTMxe3qXgq7G0BpezVpCU9x6GuHfq6Sgi/tjpT+zdvq8Had
         maNA==
X-Forwarded-Encrypted: i=1; AJvYcCXXJsRf3IguYszILqBxjf2PiBIrm8E74mUydgp1UJ9lYmehtF2+CSG0d6oQC47bEWBGI5SCs3PYo2PV11TRhLecKwiMuu3OuEELDHe4RSEes1IXf+O5sznwZrdKLooBnGtUo+QyBqCi7tUabW96AJggyskDNVSXooPHkd1aM+b2lfPhekYg
X-Gm-Message-State: AOJu0YyQwe8e8xhXcf4PiahIcnPq4BeK7+HLPqrNN8ra/VXSNnLe0VNI
	ACMBsSFZ2cUbuDy7VA0Dv5N5b/i6ADVjWQQ/ttDwPFcXtoe8mv8wFLEZpg==
X-Google-Smtp-Source: AGHT+IE7JQHKMyGctSZmckJTHmiYsKytTpvlCGW5ta2gn7cl3uRslllpr9As/0C4KFrJyfQXHYsUSg==
X-Received: by 2002:a17:902:ecc7:b0:1f2:fb02:3dfd with SMTP id d9443c01a7336-1f6d02d2170mr128827675ad.11.1718036955727;
        Mon, 10 Jun 2024 09:29:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f728492becsm1350945ad.78.2024.06.10.09.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 09:29:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <33f421f0-f52a-4bf5-9efe-727ea5701cd1@roeck-us.net>
Date: Mon, 10 Jun 2024 09:29:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: (ina2xx) Add device tree support to pass
 alert polarity
To: Amna Waseem <Amna.Waseem@axis.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com>
 <20240603-apol-ina2xx-fix-v3-2-b9eff3158e4e@axis.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240603-apol-ina2xx-fix-v3-2-b9eff3158e4e@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 03:08, Amna Waseem wrote:
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
>   drivers/hwmon/ina2xx.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index d8415d1f21fc..101346d26c88 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -73,6 +73,11 @@
>   #define INA226_READ_AVG(reg)		(((reg) & INA226_AVG_RD_MASK) >> 9)
>   #define INA226_SHIFT_AVG(val)		((val) << 9)
>   
> +#define INA226_ALERT_POLARITY_MASK		0x0002
> +#define INA226_SHIFT_ALERT_POLARITY(val)	((val) << 1)
> +#define INA226_ALERT_POL_LOW			0
> +#define INA226_ALERT_POL_HIGH			1
> +
>   /* bit number of alert functions in Mask/Enable Register */
>   #define INA226_SHUNT_OVER_VOLTAGE_BIT	15
>   #define INA226_SHUNT_UNDER_VOLTAGE_BIT	14
> @@ -178,6 +183,17 @@ static u16 ina226_interval_to_reg(int interval)
>   	return INA226_SHIFT_AVG(avg_bits);
>   }
>   
> +static int ina2xx_set_alert_polarity(struct ina2xx_data *data,
> +				     unsigned long val)
> +{
> +	if (!(val == 0 || val == 1))
> +		return -EINVAL;
> +

The above check is completely unnecessary. This is a static function,
and the parameters are known to be either INA226_ALERT_POL_LOW or
INA226_ALERT_POL_HIGH.

Guenter


