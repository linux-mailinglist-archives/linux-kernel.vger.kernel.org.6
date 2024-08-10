Return-Path: <linux-kernel+bounces-281671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A341094D9BB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F41F22D57
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333FD3C463;
	Sat, 10 Aug 2024 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMNgrZye"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9F347C7;
	Sat, 10 Aug 2024 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252788; cv=none; b=brcM5h9CgKuDI8J5CWzzbAWbvaBC1W/jYHNg5zzHxv7S0Bum4oW2vzGb8bnR28P1EewaOvrWUI2NE91GscWq2C9RR4rodvP+RcwhGdipk6XoVXc6vNCbVJSGe0btDnAJqQtaFesMGrHE+a8PT3Waumctj+tEC5X4h+Q2IjP3qCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252788; c=relaxed/simple;
	bh=xvFJ5qXzptSAzs6ufRw0K7CflT3GapudSbUz1XEx3p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4cGNRdfQZOE4biHM6zmh86S/00jEY/u+bfYoMOsMRQ131MG8M2OzibINRlT2S+B1EzkPMMRNaKmsONhfGIAVC19w2BgQ1guhZRae+25j07x+E7qWxsvURyngKK3LHTwbL2Pdn2VPtVgEowm/Tpk59M+H6o73syGVVuLxN1Ceq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMNgrZye; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36d2a601c31so1054609f8f.0;
        Fri, 09 Aug 2024 18:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723252785; x=1723857585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ed27wLGIi8TfTxQJR9Xp4Dn3qUixlhgtcR9BAz+hQCA=;
        b=SMNgrZyeBaULlM3TrPAFjzI/ojU8utbtJewDB1TIOthJQGu2HIlbsRggIqGx3iY7x0
         7g/x4WwfTsHPSRZ9kxZ/kiggAkmHT42ch8ZjdqVm/GnM01M+wznzdFJWF+AWPz/q1xt9
         PxVIvEXcd7hJFhzr8Hgs/SBbZ2P16GmAZtOjsx0PzCHdd2IR3VAxuKu7ziQstIHERYFG
         g7NgjRS8uXm5lj4xZrO/ivst17xeQXxwP+cO64EJpPWku4ceSrdcX6ZO4icBs80iczhH
         kbk1Ftz1QFBnr6V2mZsL0GyufGWRNWrsSrUcf3HVqjBG6JuuBNgN0Ek4w+PrGFXadaYt
         DB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252785; x=1723857585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed27wLGIi8TfTxQJR9Xp4Dn3qUixlhgtcR9BAz+hQCA=;
        b=CfZNH17A/ufSheDKV8lfWUAyLw67cmCSNo2qyja9TXVrg8P0NdTN5DF5Hd3PjI6Meo
         3/rGyTuJNa4BiHpa4+BCyzKyUj7nR7ImqiUfhsAnoV0xHo2VfGkEx20JeN72eTE9ZeTa
         h4zFw7opQliP/QfoWqB+jOC4rzu2LOJR+Kf6tl3juOcww6dXlnu4XPV0i5PaILgssZa/
         UQXx6U0DJsYXhskKubCishHpw6ZTP0hExFiyNJDpWiEvVSgOiu+5cgLnd6uKNbMl/fr4
         HsC7we+6P299SyW8USZXOLF25tNKnn4UpvHBsT7OD2udzeaxCasn31neAarRgDpBZYWz
         xXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmqsMXRez8gXK1YcTKcbul1LgfZXc7QAUrdZI5tdo9Hj4/5+I69MfaghjUfeHROTWiaM25EMVOWSKLUknVT5kf2btf8QfiS35fCsbDErzPj+fdhrPQNsB12ynhI34GTcVQwn9fdhUjNOM=
X-Gm-Message-State: AOJu0Yw4iQPi1TKsTVuqN0mwkG0iqGSmPoDXnDAaAh/T44DAw76bgYQ3
	zdm5aZBYK+m0XrBeidpR9N6Bw99iMbptEQt+7ECI6UmJK8lA5j7a
X-Google-Smtp-Source: AGHT+IGlOuoPmSRMK0/G5JR5K6t9fbYw142XeGbhQM/kww2n3HQtaq1P/i4K65m3+WJV7P9xvecwDg==
X-Received: by 2002:adf:b1dd:0:b0:367:434f:caa2 with SMTP id ffacd0b85a97d-36d5ad9c793mr2195752f8f.0.1723252784638;
        Fri, 09 Aug 2024 18:19:44 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e48c784basm862675f8f.0.2024.08.09.18.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 18:19:44 -0700 (PDT)
Message-ID: <8ce2ae38-51da-470b-9d3a-7408b79cf6e4@gmail.com>
Date: Sat, 10 Aug 2024 03:19:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <2419e2ab-25e2-483b-a163-6b4fbfef6866@roeck-us.net>
 <5d11350f-71b0-44fc-8631-01e1740581d6@gmail.com>
 <5208afb1-92dc-43d3-b6ed-36a2fdd40ec7@roeck-us.net>
 <b66f1fed-20a2-4de3-85c5-bf6fb90c2649@gmail.com>
 <851fe373-471e-4892-addb-343d84334daa@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <851fe373-471e-4892-addb-343d84334daa@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 10:37 PM, Guenter Roeck wrote:
> On 8/7/24 13:11, Maximilian Luz wrote:
>> On 8/7/24 9:50 PM, Guenter Roeck wrote:
>>> On 8/7/24 12:25, Maximilian Luz wrote:
>>>> On 8/7/24 2:32 AM, Guenter Roeck wrote:
>>>>> On 8/4/24 16:08, Maximilian Luz wrote:
>>>>
>>>> [...]
>>>>
>>>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>>>> index b60fe2e58ad6..70c6385f0ed6 100644
>>>>>> --- a/drivers/hwmon/Kconfig
>>>>>> +++ b/drivers/hwmon/Kconfig
>>>>>> @@ -2080,6 +2080,16 @@ config SENSORS_SURFACE_FAN
>>>>>>         Select M or Y here, if you want to be able to read the fan's speed.
>>>>>> +config SENSORS_SURFACE_TEMP
>>>>>> +    tristate "Microsoft Surface Thermal Sensor Driver"
>>>>>> +    depends on SURFACE_AGGREGATOR
>>>>>
>>>>> As the kernel test robot points out, this dependency is wrong.
>>>>> __ssam_device_driver_register() is only available
>>>>> if SURFACE_AGGREGATOR_BUS is enabled.
>>>>
>>>> Right, I should have spotted this before submission, sorry. This should
>>>> be
>>>>
>>>>    depends on SURFACE_AGGREGATOR
>>>>    depends on SURFACE_AGGREGATOR_BUS
>>>>
>>>
>>> SURFACE_AGGREGATOR_BUS already depends on SURFACE_AGGREGATOR, so the extra
>>> dependency is not needed.
>>
>> Unfortunately, SURFACE_AGGREGATOR_BUS is a bool and SURFACE_AGGREGATOR
>> tri-state, and the inference of whether SURFACE_AGGREGATOR needs to be
>> built in or not breaks because of that. Meaning we could have something
>> like
>>
>>      SENSORS_SURFACE_TEMP=y      (tri-state, module)
>>      SURFACE_AGGREGATOR_BUS=y    (bool, optional-code-flag)
>>      SURFACE_AGGREGATOR=m        (tri-state, module)
>>
>> because SURFACE_AGGREGATOR_BUS is fine with either m or y. But in
>> reality, SENSORS_SURFACE_TEMP=y would require SURFACE_AGGREGATOR=y.
>>
> 
> Ah yes, I can see that the double dependency is there everywhere. Normally I'd
> have assumed that to be handled with SURFACE_AGGREGATOR_BUS as non-configurable
> option and its users selecting it, i.e.,
> 
>      depends on SURFACE_AGGREGATOR
>      select SURFACE_AGGREGATOR_BUS
> 
> but, sure, it is your call to make SURFACE_AGGREGATOR_BUS a configurable
> (instead of selectable) option. I don't understand the benefit of being able
> to enable SURFACE_AGGREGATOR_BUS without any users, but then maybe I just
> don't have sufficient understanding of the context.

No... you're completely right. "select" does make more sense.

I'll add a patch to change that for surface_fan as well for v3 (and then
I guess slowly update it for the other subsystems too).

Best regards,
Max

