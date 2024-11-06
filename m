Return-Path: <linux-kernel+bounces-398516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA99BF24A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BF7B24E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBAB20400E;
	Wed,  6 Nov 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHfNbF7i"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF5190075;
	Wed,  6 Nov 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908534; cv=none; b=mqU2nX2uhx0vffk/93qR8Kt+sb1Ny7WJ++CaMVd/NIH1l6+vJ3jP3c4nS5EKn8khqCWFdwhZeIkpotqUZocCEnxb/qwpbtKGB0u8YE/UOGd7TPck4J64xdU4RkcKr/I9A+QFgZ933bbTJDjGWbmSqoNnyu2aqU7wCwyK+LGcFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908534; c=relaxed/simple;
	bh=lmZ34mpN9FKQ2MZimuXtaoFX+pwfJtaEkD7X19/GC8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtjmwI6B07AmBp7EBpd/8x4/K8AloX3aLLfd6O5P68SOcS71QKVVbaloO2oXG3AuXIrH9x6Bz1d2WjUYkjtcE0g/A3MttiOChemA8oZdkkwXZJQl8XY4U8ahqDHkx4dDGRZc78uUps6xmEAGQjZY23RmCK+Uojv1nmU/YcJJPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHfNbF7i; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720be27db74so886031b3a.1;
        Wed, 06 Nov 2024 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730908533; x=1731513333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jXs+F/oKsf4Wfse4T8HZVhXMFtchgJeyB9DnhWTGYD0=;
        b=SHfNbF7iSN6lAAapbmVvrm9joqYnUbjnBU8KSyLakIuJOU1DxS/nS7u8vXNIFIKUhP
         pIC1XDAwZP5bk7a9bZtPPPIqQv5n0YFyv0Lpgqq8zVB8fGvu3xhuGIBl4BAIq/SG3QgU
         sgNKmB9YkoBjnOmEhXn+FJcZVI1Lt7eesZCf5HXswtNHecHec/ZPDvvtbv6416w5PzJD
         4AobnaL5svztiDRdXU9cYJMEaAkcrMXP4gGRnVLMeSSdPRHyo2WCCrM66Hvup+IgsP/k
         t8nZWKS2ri5kpIyaZvD6HCM+A5uylmhcSdwAiIFSKAO13Leeuj9aLmJiPK4RB6oBO0PI
         YsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908533; x=1731513333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXs+F/oKsf4Wfse4T8HZVhXMFtchgJeyB9DnhWTGYD0=;
        b=tj+0nYQzd4RA75QmS+eEf+r9kdI8aj9r7oYK8aNkb1F9A8M0ZKNPmy4yJNrCLBIakx
         jAdN1CQkjIttE2rZzXPBMKAR1wAeouJgaZCaSBI/xtYL+KU0XWGsVpcdRXxbTVdety0J
         9xGYwomyDvtd+UnbMhrvKbU9Epk+SjdeEyzGVFaAQdyZmxMa/QmwTVvd5Mzqoy3ytgZS
         CtpusA95zJWSQI4tXRuux/17bHfK+r8OhVnbqsHyIZiiW2VBThBh1zjrnsakMLoZgwYx
         HeEc6BkT3BhMN5+qxsVPrX2pbbKsIH9meGFrcFXPu6eYHLBSypPzZgwCV3kp8Rz7XGJ4
         aoWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPw2YVNVn+gmg9/5DuzbLNwwkP4IjanfWSBUr7bOdFwzKinQW72xVHQCkE74DtmoWSkKyNw3TRoeKO7d0E@vger.kernel.org, AJvYcCV4wX/+NT5VRoE12lDeWWGL5YaBmjpB5tW11lkhX4p7sLkAcbobquuhxb4ikWSQSqTIGZUQSdPqmtMlb9g=@vger.kernel.org, AJvYcCXd9TYIOkoliQH2+LPCnp9rluv88Bn9t1z3JiJqHrIKu+vNxbTFi20tpuw2rrP5Ml2jcqIHYftANJyR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4kJ4+9Yn/eFIsFedYbtPPKjjJ01oDLRcckPDM2dKwyvwcFUa
	8nrshZ4Qwuri6R9DGZ6mGxhdPSiG35QyFQ1pT/5jeXY9XmhTdvfO
X-Google-Smtp-Source: AGHT+IHRceEXaz4pH/Bn4VqW0+lmY0WB4+hP8S8LIqUPVBWY1GPT/V//tYeEzO3AQB2Pecq2M2/apw==
X-Received: by 2002:aa7:88c6:0:b0:71e:6a99:4732 with SMTP id d2e1a72fcca58-723f7a8ecbfmr4985051b3a.11.1730908532538;
        Wed, 06 Nov 2024 07:55:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc315ad0sm11860092b3a.198.2024.11.06.07.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:55:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <55825e91-b111-4689-bb3e-ede2c241728d@roeck-us.net>
Date: Wed, 6 Nov 2024 07:55:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-3-alexisczezar.torreno@analog.com>
 <ZytSCD0dViGp-l2b@smile.fi.intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZytSCD0dViGp-l2b@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 03:24, Andy Shevchenko wrote:
> On Wed, Nov 06, 2024 at 05:03:11PM +0800, Alexis Cezar Torreno wrote:
>> ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
>> ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
> 
> Missing blank line and perhaps you can add Datasheet: tag(s) for these HW?
> (see `git log --no-merges --grep Datasheet:` for the example)
> 

Is that an official tag ? Frankly, if so, I think it is quite useless
in the patch description because datasheet locations keep changing.
I think it is much better to provide a link in the driver documentation.

>> Signed-off-by: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
> 
> ...
> 
>> --- a/drivers/hwmon/pmbus/adp1050.c
>> +++ b/drivers/hwmon/pmbus/adp1050.c
>> @@ -6,8 +6,8 @@
>>    */
>>   #include <linux/bits.h>
>>   #include <linux/i2c.h>
>> -#include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>>   
>>   #include "pmbus.h"
> 
> Stray change. This pure depends on the your `locale` settings.
> The original one seems using en_US.UTF-8 and it's perfectly fine.
> 

Agreed.

> ...
> 
>> +static struct pmbus_driver_info adp1051_info = {
>> +	.pages = 1,
>> +	.format[PSC_VOLTAGE_IN] = linear,
>> +	.format[PSC_VOLTAGE_OUT] = linear,
>> +	.format[PSC_CURRENT_IN] = linear,
>> +	.format[PSC_TEMPERATURE] = linear,
>> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT
>> +		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_VOUT
>> +		   | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT
>> +		   | PMBUS_HAVE_STATUS_TEMP,
> 
> I dunno if the other entries in the file are written in the same style, but
> usual one is
> 
> 	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT |
> 		   PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_VOUT |
> 		   PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
> 		   PMBUS_HAVE_STATUS_TEMP,
> 
> Or even more logically
> 
> 	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> 		   PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> 		   PMBUS_HAVE_TEMP |
> 		   PMBUS_HAVE_STATUS_INPUT |
> 		   PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> 		   PMBUS_HAVE_STATUS_TEMP,
> 
>> +};
>> +
>> +static struct pmbus_driver_info adp1055_info = {
>> +	.pages = 1,
>> +	.format[PSC_VOLTAGE_IN] = linear,
>> +	.format[PSC_VOLTAGE_OUT] = linear,
>> +	.format[PSC_CURRENT_IN] = linear,
>> +	.format[PSC_TEMPERATURE] = linear,
>> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT
>> +		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3
>> +		   | PMBUS_HAVE_POUT | PMBUS_HAVE_STATUS_VOUT
>> +		   | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT
>> +		   | PMBUS_HAVE_STATUS_TEMP,
> 
> Ditto.
> 

That one slipped through with the original driver submission.
I thought that checkpatch complains about that, but it turns out that
it doesn't. I agree, though, that the usual style should be used.

Guenter

>> +};
> 
> ...
> 
>>   static const struct i2c_device_id adp1050_id[] = {
>> -	{"adp1050"},
>> +	{ .name = "adp1050", .driver_data = (kernel_ulong_t)&adp1050_info},
>> +	{ .name = "adp1051", .driver_data = (kernel_ulong_t)&adp1051_info},
>> +	{ .name = "adp1055", .driver_data = (kernel_ulong_t)&adp1055_info},
>>   	{}
>>   };
> 
>> +
> 
> Stray blank line.
> 
>>   MODULE_DEVICE_TABLE(i2c, adp1050_id);
> 


