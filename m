Return-Path: <linux-kernel+bounces-431365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D39E3C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D15F168AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E022B1F756F;
	Wed,  4 Dec 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTYS6Go0"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B7198A05;
	Wed,  4 Dec 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321718; cv=none; b=PfanSOIQvRpuRfGb53U33VQGTNY/lAPliawxysRJS1zRLBqjcAgUGnF0FNLeq4OjsDQ1bqCiDzQ48PoNCtr3gT/XwMC/OBSU74d2PqjjYcINSIm+bXH4Pp7iiuy7YVh1XgC8oOqfGXaRKrQ+yRjm2bq14pVLWs6lqxeX6aRvggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321718; c=relaxed/simple;
	bh=mp0xMakOZkAYjldngtXkYlJ2l7ooeSfFDMdWWpxIjjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPBwKxEc80IKDogY2H2OxvJ5hbc99Y8FTn3Agh2NRIyPEIONsvjqgBh/0zrxrFPACrYHvwqtndO+P7kMh2/wK34cqn24zG2NVzmsGj1bavIcz7PptSelFLJe0fDb6Y+TApkH95hUqwucSwKgcJtqllSbtrLkpMR5HXNOmpfMnRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTYS6Go0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724f41d520cso4080048b3a.1;
        Wed, 04 Dec 2024 06:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733321716; x=1733926516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+VfkMqaoR1PBkGjD27i7J8fTO8qVxs7ERpfayJy5Vxg=;
        b=hTYS6Go0UaMEX2ab/IoglCeywF7BDS0dUQpI6NA6MvDdfTrh4clw+mvAav+7HRc/1j
         9ml2D5HPK5fG9mnormPx0TAJAbEeNnU+YdoMUGHqiiNXW4Q0Zg5+KsYlp1wP4GYna0oH
         BInqdiPigUqzehAiNDgb/NBYWM9SaW9t1u3MU3w7e9rCKmTWhJruKhnFVuTDMTacLJJb
         cHKdcdcL7/UcEOPl3Las8VTUythi58KWRU5Ov2pkX/gbZhEet6yQ4pv2F80u1GrhtCXp
         3aHzBs+KYGd/8kQuvQLXefaJX3jKHIYIC00N5Khve3ky+zA8soAXipHl0zdpKoCyPRzO
         MdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321716; x=1733926516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VfkMqaoR1PBkGjD27i7J8fTO8qVxs7ERpfayJy5Vxg=;
        b=e/0iZL/EaaAZJ2onStszeiPoU11yrJE13kxPdqya6CO+BjL2VMHu+Q6JwYH1VozE42
         NDXhQoD0I21yF7wf+B7N9ee8IK5MmDcztt0Fye7xzeXnGm6R//T7g9d+nW9xPzSu3Qgo
         nJKp7ZF9D3BbKoU8eAm6LMPhywNWoYdIqTMX3LuJ3y1MgZTjki3Cn2xBZwh8NZ5953Zw
         BtR4GK+AvflEECDnKvvJuwVB/FvvNlzc1lUfeHY7ejOR3Uu6zpRG4Q3glLnjM35hJmt9
         GcnHTmrc9KIqGl5u907xG7Ly9uLX5np/5PycykuJc5FGvVo+wBp9lQND4LEwhIHKfChE
         N0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW+9e9T3mX2ze8uUHetdfywIErNvBBnNM0gUkrhSfgbazWd3c8zq9Tc4tmLekmRlPDid2zjmO90G96qtg==@vger.kernel.org, AJvYcCWi7SMLDDVSnKC6R6XO+eGMX8BvJs/EVFcyqHUifx16IsQgCaV8LnrP0tw8148Q5yR8qKujCp5cqpd/mFDG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1SDsMGFBB+E7qPFR+YBDfOqJ68Yb8qlE5epjyb9cES8cKy8a
	aIS77LWDMwD2/igLLi+93j+zKviCySq1IhomGxMBdG8kaQdk5xsQAf3eqA==
X-Gm-Gg: ASbGncuy89Mo1euJCz9ERaEiuaQF2UjNkIJEA1vRPjf/UtTNlE5Li/Cn3E0KejkPFaY
	/AnCNyg3m+4h5Q0/C5tC6yglAD/nBXNOsKWrjF2Tgh/Rqz9vv1kKtkRn4MfAFxHe6xjU7lh74ta
	hyVAeloUJ9D0Ez07VMs3zcTqcchDYOjq5KysZd5TZ2P43AHbHMDhCngj2MkL0Wa+dyAMFYvre6e
	IQvrHcpBfIfpHPhLF3KxCIa1/cT84Jyp57q+1wDEnjTWybGqixSpXoN4H47qjhH1mu/YAm2CwsC
	0anwE/LD80TGKlBjnfcLt2s=
X-Google-Smtp-Source: AGHT+IF4BMho+McDM6sfMlrjrjxQhMsX4MFYD4/yc5eKajq86g9yksIm7j5Jp6utqHxGo7h21QOwCw==
X-Received: by 2002:a17:902:e5c1:b0:215:ab2a:46c3 with SMTP id d9443c01a7336-215bd25458bmr77190435ad.51.1733321715766;
        Wed, 04 Dec 2024 06:15:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c324943sm9989962a12.48.2024.12.04.06.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:15:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <be920ecb-7aa9-4222-a909-41d6c0f27463@roeck-us.net>
Date: Wed, 4 Dec 2024 06:15:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (tmp108) Add basic regulator support
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
References: <Z0WJg5MMu_1AFYog@standask-GA-A55M-S2HP>
 <fcf06424-c014-4e87-9ac5-ced1ea679fdd@roeck-us.net>
 <Z1AZXzw5XnsapWT5@standask-GA-A55M-S2HP>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z1AZXzw5XnsapWT5@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/24 00:57, Stanislav Jakubek wrote:
> On Sat, Nov 30, 2024 at 09:58:17AM -0800, Guenter Roeck wrote:
>> On 11/26/24 00:40, Stanislav Jakubek wrote:
>>> TMP108/P3T1085 are powered by the V+/VCC regulator, add support for it.
>>>
>>> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
>>> ---
>>>    drivers/hwmon/tmp108.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
>>> index 1f36af2cd2d9..85e4466259a3 100644
>>> --- a/drivers/hwmon/tmp108.c
>>> +++ b/drivers/hwmon/tmp108.c
>>> @@ -17,6 +17,7 @@
>>>    #include <linux/init.h>
>>>    #include <linux/jiffies.h>
>>>    #include <linux/regmap.h>
>>> +#include <linux/regulator/consumer.h>
>>>    #include <linux/slab.h>
>>>    #define	DRIVER_NAME "tmp108"
>>> @@ -331,6 +332,10 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
>>>    	u32 config;
>>>    	int err;
>>> +	err = devm_regulator_get_enable(dev, "vcc");
>>> +	if (err)
>>> +		return dev_err_probe(dev, err, "Failed to enable regulator\n");
>>> +
>>
>> Problem with this is that existing devicetree bindings do not provide
>> a reference to the regulator. Those would now fail to instantiate,
>> which would be unacceptable. I think you'll need something like
> 
> Doesn't devm_regulator_get_enable fallback to a dummy regulator when
> a reference to the regulator isn't provided?
> 
> lm90 does it this way too.
> 

Ah yes, you are correct. I misinterpreted the code. I'll apply the patch.

Thanks,
Guenter

> Regards,
> Stanislav
> 
>>
>> 	err = devm_regulator_get_enable_optional(dev, "vcc");
>> 	if (err && err != -ENODEV)
>> 		return dev_err_probe(dev, err, "Failed to enable regulator\n");
>>
>> Even though the regulator is now mandatory, existing devicetree bindings
>> don't know that.
>>
>> Guenter
>>


