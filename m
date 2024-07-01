Return-Path: <linux-kernel+bounces-236752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9545891E6AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6F0283AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B816EB51;
	Mon,  1 Jul 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/0m5HbZ"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595315EFC2;
	Mon,  1 Jul 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855105; cv=none; b=CvQ6VJ0y/FBbyHIvk6sv3I33QFYUhzfHteT/dM7jKfPfDKE9hZum22DR2ryq0TmF+BWi2YjNXyr2Xtj8YBMnvhAuNRIZG0Vjy+9/zPQJJ1QwaM57FU3LRBQly6KOXG0u28dgETK3mdH+IyR5OkyAE5wn6OlVrsmh0DIIztSRwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855105; c=relaxed/simple;
	bh=TSnmE91ts8m5MoEkwM8+530yEwcIGko8qsO6yzrmnrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCFuL89gBuY6sUhl7JDTU6Jg5MhvFIi7DiG0fA3Ygyq/dS1XOkbwUUUT8xw9zqUvtCGomD05Dk1d6aKDI8C8ZXh9oG6GWu8FG4qfbPXQwAB00wCIoVroZ2l5lrySDat0JSCMU9uyJhp/BNV6e3N9JHXe0te8T/eZ9NuOVI6rJfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/0m5HbZ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7021dd7ffebso251933a34.3;
        Mon, 01 Jul 2024 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719855102; x=1720459902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zSAK/44NTLDZNYBgMCw+YgL8/CQMC51+c+ZUun3pCUo=;
        b=b/0m5HbZ9ITpi++IxCLSG5is1QeoAGKvp0WH8NKv0xyhXQHbauYcPnHJzYPo+onMpl
         QRUOGEzYaKZ9TbzibEsb+7DoxnRUCGRQnedoCQ0Z0Cko/ox4o0kftv0kdc+HnaVuL0wI
         2uoukrXg/D89VyTR2p9bZb5dy3O2Xmnj7Nx/Jo0IJODjfmdnnDEa3zKj4DUNmIHinuTm
         Hm6w1AYbar48tm69JLHePcbGrZpMu9pLWryPtom8ibvuq10oH3jr/yVATXYsPgRC8y6j
         NLWcOATRQEHb1Afn+ke6Mpey+xM6Nl8xIk+CuMaSLX8lGu0uKvoSpDENGcnobs5TLy8P
         EdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719855102; x=1720459902;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSAK/44NTLDZNYBgMCw+YgL8/CQMC51+c+ZUun3pCUo=;
        b=h/rIkJRn0jbblm5gkAo1ryKikmvMlHGykrwvqydxkLZoz3Dsv3EfQw3MdNrpf9gg3W
         Q0uE+DK2qKiwO0Vak6EXaIpR739TqRy6vsKMPtkBKL3mTG0gS5YCQ6ImR7sfmE4OD6DH
         Yakdc1JeYGPx/fDXIlVLWDoV86ESoLq/PMf+wVmv2tpA60MZ/y9NZWbU40GeIxfqI4VI
         Jf+yBRevOdF76qJsrfl9Sw1ddP2SkNLCZ44DYamgxR+ACEFB0EpRB5AiOOZBeCBgxwpR
         qUzEIKPg0aJQPV7hgLX0ZvA3bk7X1UndaSNkV/k6OCEr6wq7zss90zn+o+2iCc++2XDA
         dncg==
X-Forwarded-Encrypted: i=1; AJvYcCV4riUGKDbqsdC95gG5zSkS45wufC02KnWN/MKQQXuvdAVf6ksbcYV+EH6EqH0Pk3hJkGy5bUhxdbCw9LBrzDUbdLC9Ewsf1ilZbO4=
X-Gm-Message-State: AOJu0YwwQ3j3Bpqm6HyBmVGpJceQdbClopEheDd6/BiXmXu/bWaFGWrl
	kbfHVDQn2GfkG1T9GgOArwVGeKausdjmoRoXHQKAKpgAS4Xa4NC12Ylulg==
X-Google-Smtp-Source: AGHT+IGXyHpSbUYSxmrEDs3+UU7OqkU8gE0jXgL2G6nQ7sAsxB6lv6xdEN61pCEoWV2eZxZ47nxU0Q==
X-Received: by 2002:a05:6871:3a25:b0:25d:6d99:a483 with SMTP id 586e51a60fabf-25db340df18mr5609826fac.12.1719855101772;
        Mon, 01 Jul 2024 10:31:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e54b97sm7023587b3a.16.2024.07.01.10.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 10:31:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ad2dbb44-b7cd-491f-aced-63e15cef1837@roeck-us.net>
Date: Mon, 1 Jul 2024 10:31:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] hwmon: (amc6821) Add support for fan1_target and
 pwm1_enable mode 4
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-5-linux@roeck-us.net>
 <e1933ae1-af38-4c17-b36e-33d43e90f057@cherry.de>
 <31eb2d27-fd00-4284-93f8-23504e14b47f@roeck-us.net>
 <86df2f79-c201-4e80-9e28-dfe13b674258@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <86df2f79-c201-4e80-9e28-dfe13b674258@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 09:29, Quentin Schulz wrote:
> Guenter,
> 
> On 7/1/24 5:26 PM, Guenter Roeck wrote:
>> Quentin,
>>
>> On 7/1/24 04:23, Quentin Schulz wrote:
>>> Hi Guenter,
>>>
>>> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>>>> After setting fan1_target and setting pwm1_enable to 4,
>>>> the fan controller tries to achieve the requested fan speed.
>>>>
>>>
>>> There's something in the docs (section `Software-RPM Control Mode (Fan Speed Regulator`) that rubs me the wrong way though.
>>>
>>> """
>>> When the TACH-MODE bit (bit 1 of
>>> 0x02) is cleared ('0'), the duty cycle of PWM-Out is forced to 30% when the calculated desired value of duty
>>> cycle is less than 30%. Therefore, the TACH setting must be not greater than the value corresponding to the
>>> RPM for 30% duty cycle.
>>> """
>>>
>>
>> It turns out that the tach-mode bit is in reality the DC vs. pwm selector,
>> and defaults to DC. For pwm fans (4-bit fans), the bit should be set to 1.
>> That means that pwm1_mode should be supported to set the mode. I'll add a patch
>> for that.
>>
>>> TACH-MODE is never modified in the driver, so its default value prevails: 0.
>>>
>>> I'm wondering if there isn't something we need to do to make sure we're not under those 30% for TACH-Low-Limit/TACH-High-Limit/TACH-SETTING? Forbid the user to write (or clamp instead) <30% duty cycle. Forbid the user to select mode 4 if current values are <30% duty cycle, or update them to be >=30%?
>>>
>>
>> It also says that the "the selected target speed must not be too low
>> to operate the fan", which makes sense. It also says that the requested
>> fan speed should not be below the speed translating to 30% duty cycle.
>> However, that is not a fixed value; it depends on the fan. Some fans may
>> operate at 500 rpm with a duty cycle of 30%, others at 3,000 rpm.
>> Looking at Figure 26, I don't think the value written into the pwm
>> register makes any difference in Software-RPM control mode.
>>
>> With that in mind, the only thing we could do is to ensure that the
>> requested fan speed is within the configured low and high limits,
>> or in other words require the user to set the limits before writing
>> the target fan speed. That is a bit circular, though - the user
>> could still write the target speed and _then_ update the limits
>> to a value outside the requested limit. The best we could do would be
>> to sanitize settings when the mode is set to 4 and any of the limits
>> is changed, and return an error if an obviously wrong limit or target
>> speed is requested (target speed outside limit, or low limit >= high
>> limit). Do you think that would be worth the effort ?
>>
> 
> It depends how far we want to go to prevent the user shooting themself in the foot. I think the kernel's stance on that is "let them"?
> 
> The "benefit" of forcing the user to enter a value in a user-modifiable range is that they wouldn't unknowingly trigger a too-low or too-high logic within the IC.
> 
> As an example, my bank has a limit on how much I can pay by card per day. However, I can instantly change the value through an app and retry the payment again right after if it's been refused.
> 
> Would that be something interesting for this speed limit.... who knows.
> 
> Another thing we could do is modify the min and max values if they are higher and lower than the requested speed. But this is trying to be smart, which I think isn't something the kernel is aiming for (as little logic/algorithm as possible)?
> 
> So... I guess, the answer is "no, not worth the effort"?
> 
I'll go with "not worth the effort".

Thanks a lot for the feedback!

Guenter


