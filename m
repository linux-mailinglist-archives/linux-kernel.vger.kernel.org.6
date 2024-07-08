Return-Path: <linux-kernel+bounces-244433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789892A436
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A651F21F02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8313B7BE;
	Mon,  8 Jul 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7AAqXq8"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9013B7A9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447129; cv=none; b=s5jSOriiNgIw9rG0Hk2392bFeKB+wU2OMG7PM9XvfnfLwgH2dNxIn7tnvnwfYv/6d3w0NU1BosUMKloCnCUXrECxWBWdG2W4q9LArOGDKyw8tdUkt6HhTXETbDdvmqjAFzEsEBQIHqVwpybEyG21Uw3k8JQ1ZTZEwJl1y8E0euM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447129; c=relaxed/simple;
	bh=DPDcoM8CC8jvCSEhQCQlhv6vFfsOT5R303uBcZoIJVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcoP/Stb8Uxs0r1CXHUzEG31El0I39Y2bkYtz3yZ+odqmEZ57a9NcsPPlA1q16dFm3f+oVjDtZZfpD6TPHUQ25IaWkVfLla06mpaAsH5SvdQcI/rNqvouyKS5ZQQqpfRU3MDL6MCHGPKo7df4dnFYCkDnqYmJPf9dlU0fnre3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N7AAqXq8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so4356620e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720447125; x=1721051925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2aXk52r/aGzZ3te3K9Jzl6AoOV8NP7cU/QYGC7AXUU=;
        b=N7AAqXq8QKcJBbeBFg3etgLGK3CSc1Rn8flVHtKFA+yfpk5J9m+laslMxhWUTaUNFS
         H+YhgItXmimr1qSpC/4EtNrH2sXxY2Oi8hq0EMKn0nVkRZk9983elJStzPi9IdaH2BWf
         zkvi9aOlToW/rE4WPS4qdz5WgPzQ7p9U1VLbXi+dz5EVacUAlQ/zqtDbbhfLO+DvFtx1
         E0D43HJ1us1EIwdbBpjtOkQwBYPp0cDdU55ZH+5YLhKt5i5p5VoyCDxZKkNL6CrbO+5h
         mVkHTWBGET7q9l86w/mTBSPuQB8llWoCBQX/JLcYf0c1V9pOaXAWR8Ulz30yFwYe12/V
         QaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720447125; x=1721051925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2aXk52r/aGzZ3te3K9Jzl6AoOV8NP7cU/QYGC7AXUU=;
        b=g89iTvtDIn/3vsFs34dsDZ90XLhONDdeX5OWGndGlKOQQg9BJOxqAu1wOLAi3HLLS4
         UPrSFLQfyiLeuefs+lmfu9GYhBTUIb3luSQbxmere8Y/dbIbCp3YXCfQpGcGJK0TIPuv
         6h3Ke1hNQ7m3JOivg6IJ1gdQww436YNXXrxayVjmquvml5GcYykQNe/IivMeT4PLKmW9
         INnYHxYwRSOAi+Trzm7gdEO5gyJhV+h83lilHTWnM/JN1CbarZ/UeR54ZyyyrJ1OwwgO
         u99R61ZOmF+71M5f0TQ3tclSB8nqd/Mf4VW2Js/OEESWEeyujHtE1UTBLt+YNaEPguNp
         IeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS8bZZeVYumHaAWyaGdEspN/6Ysa0PYwOy26e8jZOOzqmzWO/uKfasFWoWm15AqLFedmz6sl7tsXsu0L+Usx9GoDUZyE4/LeFF0qnS
X-Gm-Message-State: AOJu0YzhWY+zCddVyg4UsNdwtBj6AVtcb1NSXSxs/mJsP82yTIFJpyGp
	oDGbUkfOW+EBeRzIDz397bu0J0TnLlAnuWAI8OR8/Pzafdp4lCl3+znDa527j94=
X-Google-Smtp-Source: AGHT+IFgb9DNOdpJeTNRb41kwxqf/5nzVESIqIDomzdLxIbT0RDkHTOABF6fJOuR/ZmrXxvOMSs4KA==
X-Received: by 2002:ac2:4c33:0:b0:52e:9958:1a66 with SMTP id 2adb3069b0e04-52ea064c58cmr7433160e87.23.1720447125475;
        Mon, 08 Jul 2024 06:58:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42668b87496sm47911185e9.8.2024.07.08.06.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 06:58:44 -0700 (PDT)
Message-ID: <a5188c05-cd06-4678-8fb4-1f0b55c18b04@linaro.org>
Date: Mon, 8 Jul 2024 15:58:44 +0200
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jgTN+6WC9nPGCidMnMjSsYMcMe+m=8Ge7Hr--utefM2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2024 15:38, Rafael J. Wysocki wrote:
> On Mon, Jul 8, 2024 at 2:12 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 05/07/2024 21:46, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> If polling_delay is nonzero and passive_delay is 0, the thermal zone
>>> will use polling except when tz->passive is nonzero, which does not make
>>> sense.
>>>
>>> Also if polling_delay is nonzero and passive_delay is greater than
>>> polling_delay, the thermal zone temperature will be updated less often
>>> when tz->passive is nonzero.  This does not make sense either.
>>>
>>> Ensure that none of the above will happen.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v1 -> v2: The patch actually matches the changelog
>>>
>>> ---
>>>    drivers/thermal/thermal_core.c |    3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -1440,6 +1440,9 @@ thermal_zone_device_register_with_trips(
>>>                td->threshold = INT_MAX;
>>>        }
>>>
>>> +     if (polling_delay && (passive_delay > polling_delay || !passive_delay))
>>> +             passive_delay = polling_delay;
>>
>> Given this is a system misconfiguration, it would make more sense to
>> bail out with -EINVAL. Assigning a default value in the back of the
>> caller will never raise its attention and can make a bad configuration
>> staying for a long time.
> 
> This works except for the case mentioned below.
> 
> I think that passive_delay > polling_delay can trigger a -EINVAL, but
> (polling_delay && !passive_delay) cannot do it because it is regarded
> as a valid case as per the below.

Right I can see ATM only this as an illogic combination:

	polling_delay && passive_delay &&
	(polling_delay < passive_delay)

>> That said, there are configurations with a passive delay set to zero but
>> with a non zero polling delay. For instance, a thermal zone mitigated
>> with a fan, so active trip points are set. Another example is when there
>> is only critical trip points for a thermal zone.
>>
>> Actually there are multiple combinations with delays value which may
>> look invalid but which are actually valid.
>>
>> For example, a setup with polling_delay > 0, passive_delay = 0, active
>> trip points, cooling map to this active trips, passive trip points
>> without cooling map.
>>
>> IMHO, it is better to do the configuration the system is asking for,
>> even if it sounds weird
> 
> Except that it doesn't work as expected because if passive_delay = 0,
> polling is paused when tz->passive is set.

Yes, but as there is no cooling map, there is no governor action, thus 
tz->passive is never set. So we can have a passive polling equal to zero 
without being illegal as no passive mitigation will happen.

The passive delay is really there only if there is a passive cooling 
device mapped to a passive trip point.

The polling delay is in charge of mitigating the active cooling device 
like a fan. So it is possible to mix an active trip point to mitigate 
with a fan and then put at a higher temperature a passive trip point 
with a higher sampling resolution.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


