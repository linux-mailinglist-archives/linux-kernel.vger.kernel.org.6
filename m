Return-Path: <linux-kernel+bounces-521657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF2A3C079
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F7E3A5059
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832811E3DFA;
	Wed, 19 Feb 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyeCFyiH"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824245C14;
	Wed, 19 Feb 2025 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972775; cv=none; b=MHGKOchsMeyz/jAIVyGhLOfrO1wvgIYLt1Im1fBonklECE10YekfbjZoOeWW8f7CBeamyxmkrGvDMBDNLRvfAwPuP2LhcV92XlMxeDCDBcsIdeExtC6KgE2+mwbhUxJlLGwOx7jmeK6Gb0XlumfctOHKMRCOCiW2ME6xAr/7geA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972775; c=relaxed/simple;
	bh=sF4p7YnFDrNE3Rauy3SHdBcBPo0h8UFSpdwTM+io7ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLF6bklMf7LOvOpOvEYujdRxGY9iZE9xqOvR5cUonlvyVO46MFlHGis5bkfhm+wTsvnaKz03UMDEVpSrQco8+Fo5e/P50xd03lxPLrz+OmRPjfmmlNTSR9ScQ5rsbk6rTDU8MyGnAVnwDNYcEPFnbMX/mC4pJVa3T3kVr69oU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyeCFyiH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c2a87378so96351025ad.1;
        Wed, 19 Feb 2025 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739972773; x=1740577573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pHx1cqzi7PFc2LN6Qdt00OGUxS00kL1NLZF9OxOrmlU=;
        b=IyeCFyiHEfAPE2Ks+ue1OPO4fx6KgQ+tX7wIBmTKRSsOYXTeVl0Z5t5p1XLSw7g2jS
         3heF4BwCIH4538a+PDkpPKNWjlEigulomuTWB4ucGAaD7dG+QPh95TvxzjGlaNkTdwBJ
         ol/dNNnnjDgwi+w2OUgFz3Jil9bdOEZDl38eU1p46pbuBrx7zdQGUd8dVldLGCxipa2k
         vgXMIwzNMDy7WFprdL1mBTpk8zvBSKMf8cI6IWqEBkuyAsLxIZKROUE/la4n8EWD+I9+
         /Wl32yo06AWilzkDUQu/yIDhFKH4aOJXjvrJeof5km0m8RoeMtXQIQsN7GIPsyQHo8Mu
         cDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972773; x=1740577573;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHx1cqzi7PFc2LN6Qdt00OGUxS00kL1NLZF9OxOrmlU=;
        b=AtdeXJrZ8Q1yeZiA5HEv021YlX1Wyh+xm3isjRchDS93tbLvSdhjq8+CJrnyX20chl
         Qn7sb27p/2lue3WxMLznIsxroHF8qVmlRTKc74lKwlHIHrEa3MVc4DAcej3LLwgryf9O
         OLtEIH0WWnw3zzyR6ZeiqnP0bY9PKP/PE1CDejgu8C4yfuKCwdkvO/ek3pxq+Ttab/yG
         z2Mq2waq09y0jUtMi+bvviPmJ7mfao8vvuGGYpkWtEEqcjku+ABoPDlzWr7YeV39cuPx
         F/ryxZWb+KeH84ym/GpD98chi3dAHfRMrNEXy3AT0mjqTCJEv2F7DbDkjT0wcRAp3Mno
         XoPA==
X-Forwarded-Encrypted: i=1; AJvYcCUdee6ZePSAduLlOJQxu1Lp6khbwQiwngZiuUoQVTOxjIO/D8WF7DpA2VF80f6dXFLikGzxFEqLTS1b@vger.kernel.org, AJvYcCW0QoqJM05xYjV9qxXavfb4TQ4Sx91/geJlX2cXnJbSp50jYfD9E8kcVeaLb+UxDiKyraZX6hNg4iphTlL4@vger.kernel.org, AJvYcCX3xCP/oAP6r3UUerh5Qch8H3vTSvHzNHrjle+WYcY0QSpbT8XP8GlaQKr8vkx301l+lS1A5xPcQX4Vie0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhF48S4NckQgxkkXVNdb8VA0YUKanKrVHh7C+AbEMH9DhH4u8L
	hB4eD87YyAWDS4qsMwh8Fli9jCRAjiwuewO5Uiy0vtfXf0Ed/pyI
X-Gm-Gg: ASbGncsUi1ywBOXe1+gUu7woPMX2JCQIKhhLPyQVTqujCQj3/Neh63b11UURnofs2g3
	zKbsRAjXNRkTBX1BQBUItjgEQ1/lsF4/WVlzBpFQHMmAOILM/KmZX3elkdCiYxCV1dcD/vxh/yu
	o1JxNzi6NM+LR9RLxyPplo5pkPYvcsIERuoYheIZkKrId6cmJDKwft0z/1dWBPcsQUD//24Rk9Y
	lIUqneTH4xiiPqApqHOiaJ/eJOuyM8mnLL64Vny6CC2uwYHwtGB0y3PhrEMH36k05GGUrYKcTUs
	JmHJFMNcuHz8wgg6eJgCTbpYBHZWkA0jEwtlTKV6VmnIUrShy5mJzOIdABfa2TUa
X-Google-Smtp-Source: AGHT+IEYP47Qp6EQr+RBIJaM90CY7FK2rIZeFafxc0P4K5EVquZ+Fd49jikY1sRAzbEnSP5ZlhvC3w==
X-Received: by 2002:a17:902:e546:b0:220:ff3f:6cc0 with SMTP id d9443c01a7336-221040bf811mr326893355ad.38.1739972773031;
        Wed, 19 Feb 2025 05:46:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366729sm105737245ad.79.2025.02.19.05.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 05:46:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <07ec64e7-041d-4f5a-a04c-daa4b0794111@roeck-us.net>
Date: Wed, 19 Feb 2025 05:46:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hwmon: (amc6821) Add PWM polarity configuration
 with OF
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Francesco Dolcini <francesco@dolcini.it>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Farouk Bouabid <farouk.bouabid@cherry.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250218165633.106867-1-francesco@dolcini.it>
 <20250218165633.106867-3-francesco@dolcini.it>
 <eb5c844a-e726-44c0-a0c1-7796d1a28ec3@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <eb5c844a-e726-44c0-a0c1-7796d1a28ec3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/25 02:08, Quentin Schulz wrote:
> Hi Francesco,
> 
> On 2/18/25 5:56 PM, Francesco Dolcini wrote:
>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>
>> Add support to configure the PWM-Out pin polarity based on a device
>> tree property.
>>
>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>> ---
>>   drivers/hwmon/amc6821.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index 1e3c6acd8974..1ea2d97eebca 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -845,7 +845,7 @@ static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info
>>       return 0;
>>   }
>> -static int amc6821_init_client(struct amc6821_data *data)
>> +static int amc6821_init_client(struct i2c_client *client, struct amc6821_data *data)
>>   {
>>       struct regmap *regmap = data->regmap;
>>       int err;
>> @@ -864,6 +864,9 @@ static int amc6821_init_client(struct amc6821_data *data)
>>           if (err)
>>               return err;
>> +        if (of_property_read_bool(client->dev.of_node, "ti,pwm-inverted"))
> 
> I know that the AMC6821 is doing a lot of smart things, but this really tickled me. PWM controllers actually do support that already via PWM_POLARITY_INVERTED flag for example. See Documentation/devicetree/bindings/hwmon/adt7475.yaml which seems to be another HWMON driver which acts as a PWM controller. I'm not sure this is relevant, applicable or desired but I wanted to highlight this.
> 
>> +            pwminv = 1;
>> +
> 
> This is silently overriding the module parameter.
> 
> I don't think this is a good idea, at the very least not silently.
> 
> I would suggest to add some logic in the probe function to set this value and check its consistency.
> 
> Something like:
> 
> """
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 1e3c6acd89740..3a13a914e2bbb 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -37,7 +37,7 @@ static const unsigned short normal_i2c[] = {0x18, 0x19, 0x1a, 0x2c, 0x2d, 0x2e,
>    * Insmod parameters
>    */
> 
> -static int pwminv;    /*Inverted PWM output. */
> +static int pwminv = -1;    /* -1 not modified by the user, 0 default PWM output, 1 inverted PWM output */
>   module_param(pwminv, int, 0444);
> 
>   static int init = 1; /*Power-on initialization.*/
> @@ -904,6 +904,7 @@ static int amc6821_probe(struct i2c_client *client)
>       struct amc6821_data *data;
>       struct device *hwmon_dev;
>       struct regmap *regmap;
> +    bool pwminv_dt;
>       int err;
> 
>       data = devm_kzalloc(dev, sizeof(struct amc6821_data), GFP_KERNEL);
> @@ -916,6 +917,18 @@ static int amc6821_probe(struct i2c_client *client)
>                        "Failed to initialize regmap\n");
>       data->regmap = regmap;
> 
> +    pwminv_dt = of_property_read_bool(client->dev.of_node, "ti,pwm-inverted");
> +
> +    if (pwminv == -1) {
> +        pwminv = pwminv_dt;

A devicetree property, associated with a single instance of the driver,
overriding a module parameter affecting all instances ? This is a no-go.

Guenter


