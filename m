Return-Path: <linux-kernel+bounces-189380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D258CEF4B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278AC1C20A0B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D81C6B9;
	Sat, 25 May 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzHJk8+F"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877542AAE;
	Sat, 25 May 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716647400; cv=none; b=ZbPtkGGvCzC5kIEzuWtohgYAg+1Cfyrrx0ttzYMl4Ihf4DFuzH7X1axktFaMjvFpM5ZcDjwpw6EOfC52yVPQFFPOzMl4kw0izsIXtRp0rYZhrmfNCJZr6YSaPP7N2bXVZTqzhAJsmXRdZBoxgC6M2pwQX6BsGUPDLPHDqShB1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716647400; c=relaxed/simple;
	bh=b/t8r98l9FjmZ289ZeUsLV2y4dFfA6JznZrQHkNuGIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q5RsUx1Nd4LsoYOciw6vMz+qWMMsczdoqdbdJRV6J3sbkYFEBDPK3M32OsfQSjwb6wPWS7MSlJ6ibbPMAg0YK1/naKcEphGpaCujMgxkVjy+Uwjg8Csb/o/IOGjFhI6PsCwV6pAbtEk+egC4YH+fLwTRA0AjzozfQ/SBU0T1mz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzHJk8+F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f8edff35a0so1545621b3a.2;
        Sat, 25 May 2024 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716647398; x=1717252198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NqbXEqn7iiab8ufGC/O7HrhqiqO12kcLNgDjYp6QgNY=;
        b=jzHJk8+FEbV1Zt9/XEc3+Qm40QkIQSo85ogfrQRa/3ufJRjOyuUbjqjPBQRTPdIb76
         fYdackzFESNGIalsWKKvgOY6hJ7dKgU8heK3JHEw0Ywpnv/u+IvlaXBn2zgdfQNcRdW4
         UAvQ6yUVLAcuu1CX5zCbvqewcvd66FA4SkzXm4+YOk4YZ6KdBEkUa6gQ/bEjuz58d8mB
         ftdLeFgnopENepcC/HedEgRwN2+G8G9LCycxlSAefgcORXZU/jEzeMnii2nYoDJZJmyp
         mFkvM1sUQPDzhORmNflg2Jm/f/v1lBV26UgO4qZ75bpAK8wPbVEjHWT01BmWXkmZskgr
         3HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716647398; x=1717252198;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqbXEqn7iiab8ufGC/O7HrhqiqO12kcLNgDjYp6QgNY=;
        b=Ke5LQ0afyRrOov3MD8mIo6vpJkuZwhmjYrwqNDPBXESrbQ5uazSA82p+6KzdeZbpIF
         ta58nUi59vP0Wvqi/AVcyetAYp15dFkIF3Gag75TnMsuH7EbaP2b5fHm2F6UTLE38ldW
         Oj9vhapmzGBQx67gLoLD209G7Y90xhtKumUomhDX6yVohqMQzV806w+vu4DcsfbUeUz3
         14pPjfkDizNUXXaV88tLalO+C1IZMK9ucHM173yikz7BnwhV7E1DUDwkuiQPam/QRdaS
         XGuM8fEelLywNVCOA6EWyPsf1phh1/6S8E8ksE2ryw+K8Wb22l4/J7fVGNTyHaKVtP+f
         MzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcU0wfuJ067r7YtK+trqgAh6nuuvkICrsBlmvuwSKMr4hSltEmfjdJq9MtMcWVuHfGyzItbxNku55VYJ5isXCDNbw6JPcmBXKAPsKPFNQOb9xhEbEQ3bf5R+uOAu1qfiiic672s6kvTnbMA9M2oDz7MVp14gKY808UD/kVdjQhLbXFICtT
X-Gm-Message-State: AOJu0Yw0AzA8HLlUurqBgxPdG2GDXFzJz8kCSNbq/dLbTr0WIQlg3AHk
	W7F498/6EmzNqAVF9l6SKfT67lE3jDYU3HWBHZX+z/IpmkeIKNhU
X-Google-Smtp-Source: AGHT+IEBuatXoUKV55VG9p+vfASYFrF0C4T+ReRNfst1vKYE0F8Wer2mTffDGaqVAHBdaL7Ocscc7g==
X-Received: by 2002:a05:6a21:6da3:b0:1af:d07a:37c8 with SMTP id adf61e73a8af0-1b212e51053mr6044103637.37.1716647398210;
        Sat, 25 May 2024 07:29:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc0599ffsm2513856b3a.56.2024.05.25.07.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 07:29:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bbcce511-1105-40f7-b6e7-beef07971205@roeck-us.net>
Date: Sat, 25 May 2024 07:29:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hwmon: g672: add support for g761
To: Christian Marangi <ansuelsmth@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240525102914.22634-1-ansuelsmth@gmail.com>
 <20240525102914.22634-3-ansuelsmth@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240525102914.22634-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/24 03:29, Christian Marangi wrote:
> Add support for g761 PWM Fan Controller.
> 
> The g761 is a copy of the g763 with the only difference of supporting
> and internal clock. This can be configured with the gmt,internal-clock
> property and in such case clock handling is skipped.
> 

Do you happen to have a datasheet ? The datasheet is not available from GMT,
making it impossible to validate the changes.

> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/hwmon/g762.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> index af1228708e25..1629a3141c11 100644
> --- a/drivers/hwmon/g762.c
> +++ b/drivers/hwmon/g762.c
> @@ -69,6 +69,7 @@ enum g762_regs {
>   #define G762_REG_FAN_CMD1_PWM_POLARITY  0x02 /* PWM polarity */
>   #define G762_REG_FAN_CMD1_PULSE_PER_REV 0x01 /* pulse per fan revolution */
>   
> +#define G761_REG_FAN_CMD2_FAN_CLOCK     0x20 /* choose internal clock*/
>   #define G762_REG_FAN_CMD2_GEAR_MODE_1   0x08 /* fan gear mode */
>   #define G762_REG_FAN_CMD2_GEAR_MODE_0   0x04
>   #define G762_REG_FAN_CMD2_FAN_STARTV_1  0x02 /* fan startup voltage */
> @@ -115,6 +116,7 @@ enum g762_regs {
>   
>   struct g762_data {
>   	struct i2c_client *client;
> +	bool internal_clock;
>   	struct clk *clk;
>   
>   	/* update mutex */
> @@ -566,6 +568,7 @@ static int do_set_fan_startv(struct device *dev, unsigned long val)
>   
>   #ifdef CONFIG_OF
>   static const struct of_device_id g762_dt_match[] = {
> +	{ .compatible = "gmt,g761" },
>   	{ .compatible = "gmt,g762" },
>   	{ .compatible = "gmt,g763" },
>   	{ },
> @@ -597,6 +600,16 @@ static int g762_of_clock_enable(struct i2c_client *client)
>   	if (!client->dev.of_node)
>   		return 0;
>   
> +	data = i2c_get_clientdata(client);
> +
> +	/* Skip CLK detection and handling if we use internal clock */
> +	data->internal_clock = of_property_read_bool(client->dev.of_node,
> +						     "gmt,internal-clock");
> +	if (data->internal_clock) {
> +		do_set_clk_freq(&client->dev, 32768); > +		return 0;
> +	}:
> +
>   	clk = of_clk_get(client->dev.of_node, 0);
>   	if (IS_ERR(clk)) {
>   		dev_err(&client->dev, "failed to get clock\n");
> @@ -616,7 +629,6 @@ static int g762_of_clock_enable(struct i2c_client *client)
>   		goto clk_unprep;
>   	}
>   
> -	data = i2c_get_clientdata(client);
>   	data->clk = clk;
>   
>   	ret = devm_add_action(&client->dev, g762_of_clock_disable, data);
> @@ -1029,12 +1041,17 @@ static inline int g762_fan_init(struct device *dev)
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
>   
> +	if (data->internal_clock)
> +		data->fan_cmd2 |= G761_REG_FAN_CMD2_FAN_CLOCK;
> +

This and the property must only be accepted for G761.

>   	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_FAIL;
>   	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_OOC;
>   	data->valid = false;
>   
> -	return i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
> -					 data->fan_cmd1);
> +	return (i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
> +					  data->fan_cmd1) |
> +		i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD2,
> +					  data->fan_cmd2));

This is wrong. It would logically combine error codes, and execute
the second write even after the first failed.

Guenter

>   }
>   
>   static int g762_probe(struct i2c_client *client)


