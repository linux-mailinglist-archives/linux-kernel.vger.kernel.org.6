Return-Path: <linux-kernel+bounces-240272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1ED926B09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717BBB21439
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA73191F83;
	Wed,  3 Jul 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1dI6i/z"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7621E49F;
	Wed,  3 Jul 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043804; cv=none; b=rutQNJmjVlFfyTmORWBAOvISQejSbk+JrLCXyThvcGxDMzW0PSvZ1CsIvStxlEU+AMj+fl5PLzG/yIjK+KmF1QctZH202/0g4bhkT2igHeiIY7TaQNa1Ew4n3rHNDKSfZbQ8CirK8AjX0TLfC5Pe2KaVksqfImvuGvAumN4ErVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043804; c=relaxed/simple;
	bh=1+YTn3dIOeDJfoLGZQBdtN3XpA+TZgyiDhPfGpaEPOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fO+ab1LC1jIO5L8w8Rrxq7T3tZMWFDvP4bXS7ySMM00lGmFTJxxu/3979ijK/6B6d3x48OBuZUieyXr9vOxeqfKmhNl+x878fdFw22WlM8LgZkF+A0g0Ws2FJwB0XxBApalvFRdwZkA0eT8Vr+CBDpxq12jbcV6Aciehqt5qT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1dI6i/z; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c9f6338a4so21404fac.1;
        Wed, 03 Jul 2024 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043801; x=1720648601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NSE/m2zZbakwvs1F6RA5g6uA7BZCRYoaxoKgYZnqXNo=;
        b=Y1dI6i/zE970c5jGPPY75CP1I2Vrmu4FxuVF9CJ81WnSXUZuQjdOi47ONXw0Gt7dqz
         1YEGDo89/LS9UI8rjV3VbGKLQScych9VlTKRgc/zVArEGXDBDrIrHJBESF5DJh9Z6Vju
         c1GbekDBY7133Q68dUwuNe5F1dcHdeW74qj3tfKw+m12dxkFZApHS8pC7p6GgB8ZY9Tq
         WpjfilDVLnPlCgBi5H7S1ue1uDhbk/iyrMHVyz9PqBb4s0LL6gH28xsXudBMmYD9Umsz
         kNaxu6jJzgPpOEJRgB+BAyVF0naN7Gk3wPSF4z8MydgPR8o7C0WjxY1JWgYk7OCSBH5j
         yg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043801; x=1720648601;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSE/m2zZbakwvs1F6RA5g6uA7BZCRYoaxoKgYZnqXNo=;
        b=QLVAgLwFnmojjMHZD9se/rQvxhtJYnXuy+lD2p4C+mcoJ4+2CQrFJYw+hj0Ckdb6wB
         6prsjgvA23s1HGIdxb4DsbozUsQLeyGcvgvJRkBCdJ22CmDap778uISBpaC4RJMS9qwe
         U5hCNnfa2Alsm5zj7p8oEnQciVFd7W/lis/to+JiRdnQ3Qr0+wN9lSal5dkUPPb2zbAb
         8KKrneFZlHEuLh1zdJxZ51nkbJELnNKKIoX+KtNmWXSaNahoKSxvB+5t494KLTh/Eowb
         CHJN8iCS0rr7E7jSLFCLzUr8CExPqNiDzeOFDBpYMAULPBqm4vLwXgmi1t6efSr65wHd
         OQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN5JcttY9vgFob8MC/RHxRDxM4IgtOM392Hua6u152Wy3mVsq2q2+NTKsGkjF0f7UryEKYP9BB1NZczX2iN+vwd+hHQxHpTNDlO8uVLfSo3vYz4ey4yNOG0fn4RhrJiOyOw3qAWa7BJWU=
X-Gm-Message-State: AOJu0Yx4vt6tFAd9/f2vr97k4n+b3BfRY/zn9N+KNZFVSOU6GjJEz/uW
	IakVzW8cvq3OghrczBxqJ8WzrVeMuGKEduEVJFMXDXl/AQoCWw0fZc1pvw==
X-Google-Smtp-Source: AGHT+IGw9OpUcJNXsCVQtff2v6e34FGuCuX1fBCIxFSZw2QkQ7Hmnlysak4EvhPR89gY/eE2/cZzXw==
X-Received: by 2002:a05:6870:1ec7:b0:25d:dea:456f with SMTP id 586e51a60fabf-25db3640381mr12229317fac.42.1720043801519;
        Wed, 03 Jul 2024 14:56:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53b2csm10920990b3a.39.2024.07.03.14.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 14:56:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cbcf8eb9-1817-4451-9c1e-a0daa81a18ea@roeck-us.net>
Date: Wed, 3 Jul 2024 14:56:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (dell-smm) Simplify with cleanup.h
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240703083129.95955-1-krzysztof.kozlowski@linaro.org>
 <982dc693-dbb2-41a7-ae0d-3b3c05c28117@roeck-us.net>
 <20240703191641.i5okrz22exrt3mgk@pali>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240703191641.i5okrz22exrt3mgk@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 12:16, Pali Rohár wrote:
> On Wednesday 03 July 2024 11:52:14 Guenter Roeck wrote:
>> On 7/3/24 01:31, Krzysztof Kozlowski wrote:
>>> Allocate memory, which is being freed at end of the scope, to make the
>>> code a bit simpler.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    drivers/hwmon/dell-smm-hwmon.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
>>> index 0362a13f6525..e72e26db6e10 100644
>>> --- a/drivers/hwmon/dell-smm-hwmon.c
>>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>>> @@ -14,6 +14,7 @@
>>>    #include <linux/acpi.h>
>>>    #include <linux/capability.h>
>>> +#include <linux/cleanup.h>
>>>    #include <linux/cpu.h>
>>>    #include <linux/ctype.h>
>>>    #include <linux/delay.h>
>>> @@ -1095,9 +1096,9 @@ static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
>>>    	struct thermal_cooling_device *cdev;
>>>    	struct dell_smm_cooling_data *cdata;
>>>    	int ret = 0;
>>> -	char *name;
>>> -	name = kasprintf(GFP_KERNEL, "dell-smm-fan%u", fan_num + 1);
>>> +	char *name __free(kfree) = kasprintf(GFP_KERNEL, "dell-smm-fan%u",
>>> +					     fan_num + 1);
>>>    	if (!name)
>>>    		return -ENOMEM;
>>> @@ -1115,8 +1116,6 @@ static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
>>>    		ret = -ENOMEM;
>>>    	}
>>> -	kfree(name);
>>> -
>>>    	return ret;
>>>    }
>>
>> If you really want to clean this up, just use
>> 	char name[32];
>> 	...
>> 	snprintf(name, sizeof(name), "dell-smm-fan%u", fan_num + 1);
>>
>> I don't see the point of all this complexity.
>>
>> Guenter
>>
> 
> Lets first ask a question: And what the problem we are solving there?

None.

> I do not see any memory leak here, it is neither mentioned in the commit
> message. So I think that there is no real problem, and code has just
> clear and explicit alloc/free pattern.
> 
Correct.

> On the other hand proposed change with __free does not make it simpler.
> It has still same complexity, plus magic around.
> 
Again correct.

> snprintf with stack allocation at the first glance looks simpler.
> 
> But has a problem that if in future the device name will change then it
> would be required also check (and maybe modify) size of stack buffer. In
> its usage you are specifying pair <sizeof(name), "dell-smm-fan%u"> which
> has size not related to the string. But something more common sense
> would be to specify pair <32,"dell-smm-fan%u"> which could say that it
> is always maximally 32 (and you can easily check if the string is not
> going to be larger). So for long term maintenance this is maybe worse.
> 

Agreed, but I very much prefer that over the complexity introduced with
the "free" magic.

Unfortunately, once framework code such as the free magic is introduced, it
doesn't help to just say "please go away", because people will just keep
submitting patches like this one which don't improve the code but still take
review time.

Guenter


