Return-Path: <linux-kernel+bounces-244480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D6D92A4C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E415D1F21FB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB613D61E;
	Mon,  8 Jul 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABs8n3ZF"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE81132137
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449166; cv=none; b=RiUTaYT89Yb0hX/4QuBBlu+ttIdMGQEqqfVmvrNc7iIDWnNYd4egrSSg8D2V6DpGo5uIQIzMzAfyruH+Z8FVkeKQD/ZOqM/yP6Ti7BHkfQN5XiRpIAVeM26POu9TS/gcdiuRo5bKIdInHcgMHrY0alf7PvThM0i2Hnuvof/by8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449166; c=relaxed/simple;
	bh=h2n4GBy05uln/QFcugjE2s0QDaFBDA0WMeFoE8PJiC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2s/DLpcDKOi/DheFGoYWA51EwCFxq0f37Of9/6mfykgTle28YjZ5qDXuLQoYcbcFyQlObghZHPGoTGGgLkLzct3TtqMcjtOJ5CTuMCk7YyoyRcWk2n6CXquG36CrZGNP0X/lOqN3LO5V7JAQWNmBf4B4UkrXSjkNc3j2sKFSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABs8n3ZF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367aa05bf9dso1567208f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720449163; x=1721053963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0/ugamjuwV0WtdcnqAzFnluGO3nYXx9Z/EOUxvebi4=;
        b=ABs8n3ZFQ7rK7e5yX8GOzcAKyHfGiAPTVIbdEt0NUqcMmbLjSgp4plaR15gcf917/6
         ewKdqndlJ5hGAlxuI5wq95LYJTKN3GHde6Q3Uu1q48JPN5ZE3PxKNS1h6zRd5fheTlJX
         +222cO0xuIv/vSPNs9LfzPz1T9hMV360b6RYawh0Bk2gKESxv1FECXIZVJ2PnR+/TA2e
         yPOiyH/3j7IwXNsTBvdpqVtXilK0JCOVCTtpLX47jcw1DB7iDBMXFLLYoGFi+KvHBM2G
         Gi+1LdSljbEeJnqh9XX2kulMRyEJ2Onsgf8LjgvQ+1qF0ZIUS6kVCOHFVYP6R+jT43Yp
         U4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449163; x=1721053963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0/ugamjuwV0WtdcnqAzFnluGO3nYXx9Z/EOUxvebi4=;
        b=bhczDYzOOPnh/8gY3qOoL8Zv3AAqUjjv6qZUKUR4YKMr9e6GoCxu1b4C0tayFKiptE
         lvTWkgqrdcThQxBxjvpaAPOUxXkiHi7EwvwwF9vaz63dpJtaiK0l0TpzaYyulOWbr8Lr
         DJRjjrVzo4KGMj7hxOK5ZrsPefH1iIm2P2do7SL1uv7qSHeduNNkUxzP1uRn3LRE18E2
         96fnTCggguOZ5YBCBoOElA60pqSAfZrORssO7X3cEhfz6pPoMQ2Xh6IlFzYFCNKa1MKV
         7X4NV6JOqYXfCrZBlMkhKWZ/IudCBT8izgxOtjOI9Txp61BNaXdf6xTjsP7oZR6vSEka
         0jjw==
X-Forwarded-Encrypted: i=1; AJvYcCWbEoRvcBq/4kDfLpykoF3175qkARfy7mSGWcT0JDHKTPT2Br9CihRcaYSgQAWmXuc4phiImC/N5fxFhVWdighTIv0kFwmJSUB9nIgC
X-Gm-Message-State: AOJu0YyGsaTJMk2/VP556xA84/CZr0FTKZsG1msO7xkD4qvy/FEExUMd
	XPDWjzSDtPooKMFJAL0nLevs+KnrwgXD6pruVkjpOw7HV5GiKEVwJzsoG+CcXfw=
X-Google-Smtp-Source: AGHT+IE4fR+pGPYqQZUmsMdN50iJyTKszZcwvEbQ2kUEczJ9IM5mqyEhY/+b9XoPyKas0qvCDz/nbg==
X-Received: by 2002:a5d:55c4:0:b0:367:8383:5895 with SMTP id ffacd0b85a97d-3679de96cd1mr8057111f8f.65.1720449162745;
        Mon, 08 Jul 2024 07:32:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367947ddebfsm13578053f8f.34.2024.07.08.07.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 07:32:42 -0700 (PDT)
Message-ID: <02ed646e-b344-4802-a4ef-806a1e0cac67@linaro.org>
Date: Mon, 8 Jul 2024 16:32:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: core: Add sanity check for polling_delay
 and passive_delay
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <2746673.mvXUDI8C0e@rjwysocki.net>
 <4940808.31r3eYUQgx@rjwysocki.net>
 <402ede79-5eda-48fc-8eb8-5d89ffe6bd41@linaro.org>
 <CAJZ5v0jgTN+6WC9nPGCidMnMjSsYMcMe+m=8Ge7Hr--utefM2Q@mail.gmail.com>
 <a5188c05-cd06-4678-8fb4-1f0b55c18b04@linaro.org>
 <CAJZ5v0i89BJD8AayxqJR912rkg+P8m9qq=GubCXJxmdPuj7DmQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0i89BJD8AayxqJR912rkg+P8m9qq=GubCXJxmdPuj7DmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2024 16:03, Rafael J. Wysocki wrote:
> On Mon, Jul 8, 2024 at 3:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 08/07/2024 15:38, Rafael J. Wysocki wrote:
>>> On Mon, Jul 8, 2024 at 2:12 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 05/07/2024 21:46, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> If polling_delay is nonzero and passive_delay is 0, the thermal zone
>>>>> will use polling except when tz->passive is nonzero, which does not make
>>>>> sense.
>>>>>
>>>>> Also if polling_delay is nonzero and passive_delay is greater than
>>>>> polling_delay, the thermal zone temperature will be updated less often
>>>>> when tz->passive is nonzero.  This does not make sense either.
>>>>>
>>>>> Ensure that none of the above will happen.
>>>>>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>
>>>>> v1 -> v2: The patch actually matches the changelog
>>>>>
>>>>> ---
>>>>>     drivers/thermal/thermal_core.c |    3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>>>> ===================================================================
>>>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>>>> @@ -1440,6 +1440,9 @@ thermal_zone_device_register_with_trips(
>>>>>                 td->threshold = INT_MAX;
>>>>>         }
>>>>>
>>>>> +     if (polling_delay && (passive_delay > polling_delay || !passive_delay))
>>>>> +             passive_delay = polling_delay;
>>>>
>>>> Given this is a system misconfiguration, it would make more sense to
>>>> bail out with -EINVAL. Assigning a default value in the back of the
>>>> caller will never raise its attention and can make a bad configuration
>>>> staying for a long time.
>>>
>>> This works except for the case mentioned below.
>>>
>>> I think that passive_delay > polling_delay can trigger a -EINVAL, but
>>> (polling_delay && !passive_delay) cannot do it because it is regarded
>>> as a valid case as per the below.
>>
>> Right I can see ATM only this as an illogic combination:
>>
>>          polling_delay && passive_delay &&
>>          (polling_delay < passive_delay)
>>
>>>> That said, there are configurations with a passive delay set to zero but
>>>> with a non zero polling delay. For instance, a thermal zone mitigated
>>>> with a fan, so active trip points are set. Another example is when there
>>>> is only critical trip points for a thermal zone.
>>>>
>>>> Actually there are multiple combinations with delays value which may
>>>> look invalid but which are actually valid.
>>>>
>>>> For example, a setup with polling_delay > 0, passive_delay = 0, active
>>>> trip points, cooling map to this active trips, passive trip points
>>>> without cooling map.
>>>>
>>>> IMHO, it is better to do the configuration the system is asking for,
>>>> even if it sounds weird
>>>
>>> Except that it doesn't work as expected because if passive_delay = 0,
>>> polling is paused when tz->passive is set.
>>
>> Yes, but as there is no cooling map, there is no governor action, thus
>> tz->passive is never set.
> 
> In current linux-next, it is set when a passive trip is crossed on the way up.

Ah, I see. AFAIR that was the gov_step_wise which was changing this 
value but based on the thermal instance.

>> So we can have a passive polling equal to zero
>> without being illegal as no passive mitigation will happen.
>>
>> The passive delay is really there only if there is a passive cooling
>> device mapped to a passive trip point.
> 
> Well, shouldn't user space get notified more often when passive
> cooling is under way?

(Assuming you meant "user space get notified when a passive trip point 
is crossed")

Mmh, yes. I see the point.


>> The polling delay is in charge of mitigating the active cooling device
>> like a fan. So it is possible to mix an active trip point to mitigate
>> with a fan and then put at a higher temperature a passive trip point
>> with a higher sampling resolution.
> 
> But it is not correct to pause polling when tz->passive is set.

I'm not sure to get the comment.

Just to clarify:

trip A is active with a multi speed fan, polling every 1s

trip B is passive with a cpufreq cooling device, polling every 100ms

temp(tripA) < temp(tripB)

When the trip A is crossed, the mitigation happens at <polling> rate. 
Assuming it fails to cool down, the fan continues to increase its speed 
until it reaches its max state.

The temperature continues to increase and crosses the passive trip 
point. The fan speed stays at its maximum and the polling switches to 
the passive polling delay.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


