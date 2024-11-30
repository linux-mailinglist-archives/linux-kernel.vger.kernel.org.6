Return-Path: <linux-kernel+bounces-426384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1259DF26B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0DB20D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52F1A76D1;
	Sat, 30 Nov 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZgUDMrT"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472B1A3BD5;
	Sat, 30 Nov 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989501; cv=none; b=TXNLk+FnjpEfBohOTAAGDZJSJaPmCyQTmHf7ZcHdveqLNxNQK4DhxfrLfvDBKM/jgBTswm5vcyADIt8w/xc7Pn4fHx2kdKZKxba9BQju2paHBBjWK/sw/uEfGOvVm7TC9Hm1ttXia6+p4JUDs+F0XdWyISMp/8yN1qIhPyA38Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989501; c=relaxed/simple;
	bh=STvU6bgqFJGzdDVQRbsBPbfg2Qza9Pjril3rE9JdYj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgotnZ0YkZS6DlPhAxjgpokuOS8qgpVpbN8OB2yvUJ+G3W1z86lB5MdXuuArAAwccW+7dVXi06PtMyY6JhnDUClbBBcYigkNdxIi1MbA8+EN0lGYe8fFsbXiowWryaVnVHM0EgEiQHVxqfttgNRsHWfjvrxEFFC1TWJcvxz53pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZgUDMrT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724fc1aaa91so2630160b3a.3;
        Sat, 30 Nov 2024 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732989499; x=1733594299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EW/0da8K2VHNaYJltUzc1fWYpfK+bQDkVqio8uz+pI0=;
        b=gZgUDMrTNpo/yYw5/YZbixS9T2wzUzX+nXwpVmb4AurWC6YiLG2NiErWfz1v92H8ni
         N49AtuIWmhSc0aCt5ATEVU6HCVmP7IJMPQ/fsbBnemBdClEntNHuhjuRxLnC4FTxRCcE
         klWuu827zIdsQN6yGSU9qJwJp0NVmRxr5zP3218tU2siuNX/M8oVZvK8tRmjlhz5yCD0
         E3QqUntQSJNsxi4kClnXTlrrZNaYxF7QBDOI60u30gCLLInk8A+aUKCOtTw5qgfkFpbe
         TaYJZ7CTTOQTlVt337QhL9TPPTUi1KRzvCKakDXxUOh3d4lQcH8bdioh6zwki7GQqO5U
         +EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732989499; x=1733594299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW/0da8K2VHNaYJltUzc1fWYpfK+bQDkVqio8uz+pI0=;
        b=JiriTF6AwrMHVLrhLOpCqB5wMTkgAYpmMGU4yljhPrJSbBHHQZbg+aHGatgq7RCU9I
         ssFP4iHPK8HokTAYb1QpS6UszuMkLZpwekqOjurSrrxBuLkfaE3RM8qPhjGMN8wjEnqj
         F2T2iHziHAxq5P1YLiuyF1i9K9vVZLmhD73QZVh7/rA3/5bim4SaRoxbb2jOwe6mdq5j
         hLTVEFmAqDcbZ4t6Apf0TzaJVx8Xfjf2T+LCKupJBcPQk/CkqoDrOII6Y0fukQwjgLte
         FbD8YsFGNfC05FkVoM4vgOr0DL2QbwgUFXnDMh6FeGCHo6OWBKLP7RxEGXJ5jaKjT6jm
         oA1w==
X-Forwarded-Encrypted: i=1; AJvYcCWKBPTI27WJAK5Fv7LOFYIyOgODIP4RIE1cfIWtgrLo/KZv08zAZ/2TqhIJB5tdtdzilYngEkNDJDLM4Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Wc7WFLspWpUQLai1/KjEW9uKdEo50C3BJytiBjTIZ8QAH4bo
	kZCAhcuA2dVyWHjRt7jhzKE7aA94ldiPGpEibpCpen/T/Q2RzCs8
X-Gm-Gg: ASbGncs9fx5Byv0mpC1ifKlLSRuaBxbbqmf9iBJ4yoO3Q/knSt1fTuXTFQ6BC9z0XcI
	WOSXBa12kiZStzrIpDEPP79FHAnBPQFgcfmu+OjhpblAU7DOdBQfbizLYEy8H+feBrR0q9tYLBq
	1yXSx5p91GVqM+RwcQ2WRvLvqSCj+un0luBZKfDGQmaQTaTp3x0qO2fkXqUjaBOaWkxE40sG50L
	LZNZkqLWoXk+nR4S1KrWQDbUBwXTtQwz22BqxwPsRNGJkBgJex07J2zBEMJJ7JBh1HNv15K3XzV
	fxP58c0BR19QjK6rkYyV5V0=
X-Google-Smtp-Source: AGHT+IGOspVBeCRywftg/WOFcwxmZZeB+BjrNZAkL1m1H/jofGq2xR2mqEQvpmqvUNFHsmYu+UWjMA==
X-Received: by 2002:a05:6a00:2381:b0:71e:55e2:2c43 with SMTP id d2e1a72fcca58-7253005a02bmr22033365b3a.14.1732989499442;
        Sat, 30 Nov 2024 09:58:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417725e9sm5449028b3a.80.2024.11.30.09.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 09:58:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fcf06424-c014-4e87-9ac5-ced1ea679fdd@roeck-us.net>
Date: Sat, 30 Nov 2024 09:58:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (tmp108) Add basic regulator support
To: Stanislav Jakubek <stano.jakubek@gmail.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Frank Li <Frank.Li@nxp.com>
References: <Z0WJg5MMu_1AFYog@standask-GA-A55M-S2HP>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z0WJg5MMu_1AFYog@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/24 00:40, Stanislav Jakubek wrote:
> TMP108/P3T1085 are powered by the V+/VCC regulator, add support for it.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>   drivers/hwmon/tmp108.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> index 1f36af2cd2d9..85e4466259a3 100644
> --- a/drivers/hwmon/tmp108.c
> +++ b/drivers/hwmon/tmp108.c
> @@ -17,6 +17,7 @@
>   #include <linux/init.h>
>   #include <linux/jiffies.h>
>   #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   
>   #define	DRIVER_NAME "tmp108"
> @@ -331,6 +332,10 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
>   	u32 config;
>   	int err;
>   
> +	err = devm_regulator_get_enable(dev, "vcc");
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable regulator\n");
> +

Problem with this is that existing devicetree bindings do not provide
a reference to the regulator. Those would now fail to instantiate,
which would be unacceptable. I think you'll need something like

	err = devm_regulator_get_enable_optional(dev, "vcc");
	if (err && err != -ENODEV)
		return dev_err_probe(dev, err, "Failed to enable regulator\n");

Even though the regulator is now mandatory, existing devicetree bindings
don't know that.

Guenter


