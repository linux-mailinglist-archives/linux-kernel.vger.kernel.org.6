Return-Path: <linux-kernel+bounces-572574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D4A6CBA9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FF516F514
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA5233705;
	Sat, 22 Mar 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6mNuYXN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476733FD1;
	Sat, 22 Mar 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742664316; cv=none; b=UwJQBk+QgQ7U+HghZOkU32dz6WawJrBmfIyQbkHEj6sSq83e4uV/Pd5ybVarSkfd3DY+cxtgavPZNqwaG5oQXfg+Rh8OuV/J7Xr5SULU7W7jRjwKJ8kdQch/YWumNWKzKyZJKN3PO05RfU0AzYxxME2n+ZdbPBlStCOZTyZrEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742664316; c=relaxed/simple;
	bh=2/ohAQVTYgl8ae7rGZkboPpWp0EZ+gIy7r0mF3uTSb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDlfwvv6gyRxuQkcbAa7uAc2pV7rpBVrdB5Yd/AP796XvWp+vrn+bcp3BOii+wJzpTRtNK4ukJoeQQaLr4y08tH+GHAkOveAgPCQQ0D/kcpUCTD7mokXdZ8rA+ZQTTxRsaNNcAUiDT06aMNoBh1cqUEioVLu5Js4965YWtVoDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6mNuYXN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225e3002dffso43272575ad.1;
        Sat, 22 Mar 2025 10:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742664313; x=1743269113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SCs/2mshegO0qSImSCU6kLeufgciDz0qQo47rDq92D8=;
        b=U6mNuYXNZrmpmRpAdaJZM/3f/O2KWsICUb6HIvc7T7wh/lkVoI0VS3dDJcue6hph38
         Neabz8wFb4yqTcylwIVyoysNGL/3hWV2eGYAWirCAJ6HxsKWmbOk+Mm1Yp7C1Q/yYJZD
         lz1AxDaPceAyZPo6dsXbZ/r0cBSCzgmZCCn7FvuXTYSqDUKBrosTZDEsw2kJkAWUUsrW
         0gpu0GzZMaQumy4EQhRc1wMMc/yj5uqSLJWdhd42TZX3+3wYNdLOncBndy8NA2vI6YAJ
         YHGf1HIMhwqz4BDoR6jx7tFW4S7SylzrJY61jOoVujWp5OuNvAeYwbezY6rwefkc/hZN
         XUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742664313; x=1743269113;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCs/2mshegO0qSImSCU6kLeufgciDz0qQo47rDq92D8=;
        b=Zz/5nTKPlSpB9wU4kIbrs/ArgAen1yHgvd4Ui3qlxYPSSgJG1zLqa9+zIF6Sk3QfoJ
         5wNBNdoq4/mSE6Q3kMU+buz5ZHavNd4K9eOnx7MovgiUNDCCatO0NNAAI+AaaQojaYjF
         w4y/RZ8nN84ul7LvlVCTDAbPALs+DW1MdNnZEoqqlOORJefAhyC5IO355LyOyjQ2yMN2
         p72weAdyOK0K3QPnVWvLHlZBvpkKry+HigVriJKJn42c+IPwRNspyE5T0P4mC9wPO1Zr
         7lvgN0RcLrd51jolFFxu7JATUr7iQTdGmSUZKJMFndEu+VWs/vzgpZrPDjhDDPyD1LHd
         gQug==
X-Forwarded-Encrypted: i=1; AJvYcCU0iISkF0xpTr9epVYAZDmqX+kqjdgtUQxWilVU5CgZDkoNa2hH2cA5F1ES2U4E2qKJqI6NkOGgFIHurXWm@vger.kernel.org, AJvYcCUt9P1aXVrtgBH+zIG8PlkE81Vai++caCUcduCMY9G2V7vD9ayBI6zhyAiPGzr3zULRcnw0ONzTBsK+Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYFSMhhrrXHXSK8wrnoNsjbON3jzlZkRayl6jwJ17RK4o4vS9
	ZmrfGg4LYFP0DDKZcNpApHC/e4Sbxg2Afp41y9wS7apXLfJbLrqF
X-Gm-Gg: ASbGnctC0gn6URtAerBI1B7mq+8y6C0j3WYUEt5578YktqF+mSyNq9HVHI7M1/VxwOa
	p5AW+HeNpr75w5mVnaO/u+vQ8AMlspB7iCcMUFn4OVtoiqX2QooOH6PUCOLLWf5hAD3PnYLS7Nr
	xS9zfMlglpHy4Kf3Ju8nzrO0Bu/dpC+lnvAzdIRuBi2kM1Fwd3vGMv3rbXp5lyk9daNAacP4erK
	9BVzI2SNAh5cFyUtuA0iSpe5gbksZlj6QkqjtNJ3ZCDkjADDg+RR2MTwQG+5c0vTWrIijAaxpYt
	Xr/OR8BRBON5KyxcCXnjpOdbZw9ntDYWlezcmnaAe0kZ686CP0HuFrxA0HivJh9tihZLQ5iLByC
	jwlsUJYSkNAi9Yjn65h4a8MS05mw8
X-Google-Smtp-Source: AGHT+IFs3vBP+6lhi8qs8V9bel3HpMcOoRr/kiizxfv4B/VQG5YAlVtPdgzanzBlR+SNz2JGNXSLOw==
X-Received: by 2002:a05:6a21:3a82:b0:1ee:e96a:d9ed with SMTP id adf61e73a8af0-1fe42f26308mr13620985637.7.1742664313167;
        Sat, 22 Mar 2025 10:25:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a28058f9sm3824794a12.24.2025.03.22.10.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 10:25:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <801599a6-81d9-4e06-8fc6-e959132eef24@roeck-us.net>
Date: Sat, 22 Mar 2025 10:25:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] hwmon:(ina238)Add support for SQ52206
To: Wenliang Yan <wenliang202407@163.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jean Delvare <jdelvare@suse.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250313075501.5435-1-wenliang202407@163.com>
 <20250313080240.5506-1-wenliang202407@163.com>
 <20250313080240.5506-2-wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250313080240.5506-2-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 01:02, Wenliang Yan wrote:
> Add support for SQ52206 to the Ina238 driver. Add registers,
> add calculation formulas, increase compatibility, add
> compatibility programs for multiple chips.
> 
> Signed-off-by: Wenliang Yan <wenliang202407@163.com>

The patch unfortunately combines adding support for a new chip
with adding the necessary infrastructure. I finally found the time
to look into this further and split the changes, trying to find out
what actually changed. Unfortunately there are some problems.
Some of them are listed below.

This is not a complete review. Also, I'll have to write module tests
to ensure that support for existing chips is not broken.

>   #define INA238_SHUNT_VOLTAGE_LSB	5 /* 5 uV/lsb */
>   #define INA238_BUS_VOLTAGE_LSB		3125 /* 3.125 mV/lsb */
> -#define INA238_DIE_TEMP_LSB		125 /* 125 mC/lsb */
> +#define INA238_DIE_TEMP_LSB			1250000 /* 125 mC/lsb */

This is not correct. The unit is 10ths of uC.

> +#define SQ52206_BUS_VOLTAGE_LSB		3750 /* 3.75 mV/lsb */
> +#define SQ52206_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
>   
... expressed in 10ths of uC.

>   static const struct regmap_config ina238_regmap_config = {
>   	.max_register = INA238_REGISTERS,
> @@ -102,7 +114,20 @@ static const struct regmap_config ina238_regmap_config = {
>   	.val_bits = 16,
>   };
>   
> +enum ina238_ids { ina238, ina237, sq52206 };
> +
> +struct ina238_config {
> +	bool has_power_highest;		/* chip detection power peak */
> +	bool has_energy;		/* chip detection energy */
> +	u8 temp_shift;
> +	u32 power_calculate_factor;		/*fixed parameters for power calculate*/
> +	u16 config_default;
> +	int bus_voltage_lsb;    /* uV */
> +	int temp_lsb;   /* mC */

No, this is not the temperature in mC. It is the temperature in 10th of uC.

>   			/* gain of 1 -> LSB / 4 */
> -			*val = (regval * INA238_SHUNT_VOLTAGE_LSB) /
> -			       (1000 * (4 - data->gain + 1));
> +			*val = (regval * INA238_SHUNT_VOLTAGE_LSB) *
> +					data->gain / (1000 * 4);

The slight benefit of this change is that the divisor is now a constant,
which may enable some compiler optimization. Still, it is not a necessary
change and just makes review more difficult.

>   		else
> -			*val = (regval * INA238_BUS_VOLTAGE_LSB) / 1000;
> +			*val = (regval * data->config->bus_voltage_lsb) / 1000;
>   		break;
>   	case hwmon_in_max_alarm:
>   	case hwmon_in_min_alarm:
> @@ -225,8 +298,8 @@ static int ina238_write_in(struct device *dev, u32 attr, int channel,
>   	case 0:
>   		/* signed value, clamp to max range +/-163 mV */
>   		regval = clamp_val(val, -163, 163);
> -		regval = (regval * 1000 * (4 - data->gain + 1)) /
> -			 INA238_SHUNT_VOLTAGE_LSB;
> +		regval = (regval * 1000 * 4) /
> +			 INA238_SHUNT_VOLTAGE_LSB * data->gain;

This change is both unnecessary and wrong: The result is multiplied by data->gain,
not divided by it. "INA238_SHUNT_VOLTAGE_LSB * data->gain" would have to be in ()
to yield the same result as the original code. Also, unlike the change above,
it makes the divisor non-constant. I don't see why this would be beneficial.

 > -
 > -               /* Signed, bits 15-4 of register, result in mC */
 > -               *val = ((s16)regval >> 4) * INA238_DIE_TEMP_LSB;
 > +               /* Signed, result in mC */
 > +               *val = div_s64(((s16)regval >> data->config->temp_shift) *
 > +                                               data->config->temp_lsb, 10000);

This will overflow since there is no type cast to s64.
(32767 >> 4) * 1250000 == 0x98836D30. That means that large positive temperatures
will be reported as negative temperatures.

I did not have time to validate the rest of the calculation changes,
but each of them will require close scrutiny. I suspect that most if not all
of the 64-bit operations can and will overflow because the first parameter is
not type cast to s64/u64.

Also, the patch should really be
split into multiple patches:
- Introduce ina238_config
- Calculation optimizations such as the ones above, with rationale
- Introduce support for SQ52206
to simplify (and even enable) review.

Thanks,
Guenter


