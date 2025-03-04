Return-Path: <linux-kernel+bounces-543959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5592A4DBD4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C106B162D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804D1FF5EF;
	Tue,  4 Mar 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGpqA9rT"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053011FECC8;
	Tue,  4 Mar 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086424; cv=none; b=KXJrWlakTfZGLlkcGI9L+CtLm7eKWdvXsY4PH3VsfeD8Wz3V4VEoFHymtOXSrXCF+o9C9zZ6yljLaYISUtL0O+VdUtyAsLr4PwtJPoKiWtejvm0eN7fOpN7FEOHDsqTtuzurjJWlZydc5JzcGtvVOObwr7f8lz7ihVGfYCe7S7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086424; c=relaxed/simple;
	bh=u72okckNQ0jdNOB6Z8QVCZcm6/HzQjAsPLcVFc3sDac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHz2rDJUnlB0jznlIKgLqAApoynudh7hLZ9TnaAVtBQjUmFkKu8zWE9ZuV+cjEpDi1uVbljbmFMR+81VODi7Qhj7A3L1ssRTZTcG8QwjFnjereZNDYeyad3qcAT6PeQQ+s4Oo0PuBFY6fEc5ax09BZdp9+bpi8ZhQ/sdb9YFUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGpqA9rT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22356471820so86770495ad.0;
        Tue, 04 Mar 2025 03:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741086422; x=1741691222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dGOYMclsPDgM+t0EQIsJJgGuY0WmmIvyK/JVQuDV9UU=;
        b=iGpqA9rTdIirBwdQTdso4aEJmvSbSicADpvO+7OF7/1C4eQzrIEN1Ei8wx3Nel8KwX
         +cz0bVbDvEP+vbyQ/9m5KMjkO5tTRXngWnQOjhSRBv38FAstYpAyQ2czYlCVGCujQhM7
         DiDLPCU56yd6eP7PioPkxnAeMSO5FZOW+LG4c5CyGLEcysqnbLxjOngZdzl3YspE3PzX
         EcaS6WuJzhskNqYYb9glpJXXwnk/SYcCcXfV4onN1WGaeGQgLzlZHSkdBj8awZULSaSa
         0MsabV5DCwKGt6uq5MDROZqjpC74rmMn2ZRq265NOXC9ixyHsB1fJX1hECu2rP6ShAqe
         cwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086422; x=1741691222;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGOYMclsPDgM+t0EQIsJJgGuY0WmmIvyK/JVQuDV9UU=;
        b=AcFUYIFceOYemveHWa5lxcU4iOFv7iWGHvvDoV+v9z57SXQG45pNnTJrqhoo/FjrWU
         JBU5VQVIkS5Bd8ZQHFYyhc/Sj3+FZkwNjG/N2J8sAtovBv68O+iGKxA87vT+jtVmH7nN
         u9O9iz29zUsoNMlzOvfvEPPVt8JCjoVB8DRZGngzntN3fInc5Do9RqhPLfQl2qAIm5sS
         5qlLqrRxIDWU1w3LcvTl84IXZbzCEqqzj76+SgR0L7+jqybWYxX/howIpCgBWc6h8rmK
         LwPAzIIR6EfbNzt9JXHEcVpVAcltzCkIgKukCIpv5ooNttd/bevAzTQz6PbbvvN/gU2Y
         yRIA==
X-Forwarded-Encrypted: i=1; AJvYcCVOfGfEPf7GEayK3Ec4tdmze+tGWY4izdO26S3zrZWmlwQYCZ1JhFcLS1ibuhLGK4nHnZUA4qcN2lF3XoAr@vger.kernel.org, AJvYcCWsXeTYHDr/ACrKL9Ob/iXbnwAowiVX1ZeMgEXMaPtpYUjAK7/J/cNvSGtSHX2DXrT4fLUwRkhhA5Dk810=@vger.kernel.org, AJvYcCX6FNMMYTy9FyROHeB9bT5FzBcvHVEKp0As/TKEJXwk2EfRLIIs7FovWpB6jxgCJ5euDHZnzRmhE58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdpZx3qlYZI+95I8UoLXINiiCoLTAq4N0bgSw35ygcSZBVZsX
	PjpX7hbFffcoryO4VwS3/4SQ0F4ERqIGnBbexg8PZonWIOnCPR2i
X-Gm-Gg: ASbGncsRmB5LYVCfOGr3qdmR0kwxLAtZCrViKo0d531Lvjh7iv9V5ZwPciMLdsAkaVN
	AvmnNg94avZLanbCfrkj+RXMs9wYa5YyLwWVSEf7qMTNxuxmGdvJvsOS4FPDQQR2kGNPQSCpnFu
	ZyunJ3CBqRlkaKOCHGMIj6FnXG1UpsGdta4+eDD+0IuwI67IxzjKbYy2bvnReZg53GeNPGtc4Fa
	Qotwl7SyqgNszvSu7s9PGnxA1b9AipyamRvu8fQ7u+p0mPYC8E45NhWYHS7Bs0EziEOSTWm0sBp
	mG2HpI+0LaA9pIu9Mp24B4hnRlmpo4SHU2czynNVB0kFHBNWuSE7wztb2veoPCQ69MmHgnYc/Qk
	375hqBiaxzu3rYDpJ0Q==
X-Google-Smtp-Source: AGHT+IHJwekzzBXCf+On6BNR1QynIXIPHY9wpKmMWCfn6uEVAXpFqnt5CFv0C/I7w1D4yIXQMrUnWQ==
X-Received: by 2002:a05:6a00:4b54:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-73657255a69mr10634752b3a.2.1741086422120;
        Tue, 04 Mar 2025 03:07:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf230dsm9847675a12.8.2025.03.04.03.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:07:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2af2888f-919c-40a0-901a-8eb0bc1f1257@roeck-us.net>
Date: Tue, 4 Mar 2025 03:07:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max77705) add initial support
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com>
 <f80207ca-da38-4999-be16-326490396d18@roeck-us.net>
 <CABTCjFD8yozABXGVMtxhHTkpkAVis6tR=LEN9jNpvurTe_0iyQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABTCjFD8yozABXGVMtxhHTkpkAVis6tR=LEN9jNpvurTe_0iyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 02:03, Dzmitry Sankouski wrote:
> ср, 26 февр. 2025 г. в 16:53, Guenter Roeck <linux@roeck-us.net>:
>>
>> On 2/25/25 11:11, Dzmitry Sankouski wrote:
>>> Add support for max77705 hwmon. Includes charger input, system bus, and
>>> vbyp measurements.
>>>
>>> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
>>> ---
>>> Maxim MAX77705 is a Companion Power Management and Type-C interface IC.
>>> It includes charger and fuel gauge blocks, and is capable of measuring
>>> charger input current, system bus volatage and current, and bypass
>>> voltage.
>>>
>>> This patch add support for mentioned measurements.
> (...)
>>> +
>>> +struct channel_desc {
>>> +     u8 reg;
>>> +     u8 avg_reg;
>>> +     const char *const label;
>>> +     // register resolution. nano Volts for voltage, nano Amperes for current
>>> +     u64 resolution;
>>
>> Why u64 ?
>>
> 
> Resolution is in nano Volts, and VBYP value is typically 5v, which leads to
> u32 overflow.
> 

That is not a valid reason. The resolution itself does not overflow.
The conversion to 64-bit calculations can be done there.

> (...)
>>
>> This is unusual for an mfd driver. Why not pass regmap from the parent
>> driver ?
>>
> 
> This limits access to shared device register map by using readable table
> with related registers only.
> 
I do not see that as valid reason to implement separate regmaps. That
only complicates the code.

Guenter


