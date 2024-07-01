Return-Path: <linux-kernel+bounces-236599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B3891E4A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920161F22BFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EAA16D4CB;
	Mon,  1 Jul 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWJnHAwv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64316D4CD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849019; cv=none; b=h7b30PpXgouXXZnimQjq4gFlRDf+SxDbIEtjxU3mC/zah3f+hJLhIaBfzDX7tviFBl+lPlmF9e6us2nff8g2jYBDzqtcWZa3sE4L4kudNbq7Xpy0SI/W+WezGw+7UPJrZQZ6ULRO8NtBBJ5NJnCo+HNkUBFkx/gUI9g+UztTNQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849019; c=relaxed/simple;
	bh=Ez65kn/UsG3z4e7bvXp7nrcrvh/8qYuC16kPomApudE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsJWt9PnwKeYQz+oBzMjS7JFBjyHMpnyFPmL2ep7Z6/eUCy+X1arB/2ghYpxsOpeGYBtbGdRgqW9bVuHpsfndHrq5zHReuRyyuf8B9QaC1qnzRrVr9EBnJX3yZ9Kk2506Gkb0E75wLJMWrofvBQF3GZSFTxPIEz0RmrQlVMraWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWJnHAwv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42562e4b5d1so23037815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719849016; x=1720453816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHxfnedVPdCoEc1DlUypKDG8XOBX0paS5fE5Uc9RmFg=;
        b=dWJnHAwvszbSbzJpczCrC+jiPNP1NDCa0EFa75+63nW/wVvRHgGJpcSLuatpyqO1Vn
         NJxAcHTxst9O9x2sjZyQIZGYM09lc4VLbwf3aM0FrupTvc3bAUv2TKuO7B+o7QbLOV7m
         2dIANmGcACreeMK600J4ILHynAF9i7gt6mGiEPjv9PRSUOw+X4CcrINKDqoqpND0n0DH
         Ix37PwFyqgq28rSvBjBH99Z32sPG/Vq0PuMQ1OosxMsrlnRQFMooNCtDdBsFk5i4pWyw
         d9d1wPComj/tj1iEIHTSiIb0Tnn73dtvoqPVQ9SkRJZc6/zb4q7Ie8LCp470KDdQeXHL
         l07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719849016; x=1720453816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHxfnedVPdCoEc1DlUypKDG8XOBX0paS5fE5Uc9RmFg=;
        b=LMGEPL3smdeGkle05hz4pG0hqrWbgcNsgybKtAEHgIYAIBLaPkZKOLWES378d6VaR2
         MZ+pBFiCcNDS6Wmp6fnms5bEpTHDSNFjveHIdh7aZ6xpzZO/EXL2r6BWh865WbNoNByg
         HS+FkRTVe3ZSMp8/7OHc8I6rnjGWWRsu0QVFmfE6ddxS1hnndcCs0pPD12Npdfqs01o1
         YdvcdswlEOzfZR6+VwESNZBjLcaTjPGHQoMvNMs5RF0weGuVuzhHmmzwfQYvM2jSDduj
         Zsk53zXAuzM5hyG5oVzqFruNX9GLOk4T0UM51O/xhBDOXw+7/5YaOxT/7cgQID9+Be1k
         qe6g==
X-Forwarded-Encrypted: i=1; AJvYcCVBw46+FfLXl8eqdtcuWwzyc6150+lTv9n3HY4/q3hXMJWkY3RjFc9MgBbV5ikDj7muUqDf1gYCqhc+7x3nIOP64JjRCXpX4UL4mo/h
X-Gm-Message-State: AOJu0YwQHILM9j0zy0Ry7WIRxVYv7NqMJwiQRKv09fRgHN7USEjuiVDh
	ii/1ADO5xfJCs2ER2xxmu7kL2zGzHlJkGd591sg/BeJfvAPXfk7WQ4HM93bzJho=
X-Google-Smtp-Source: AGHT+IG7yhF/QwBWwC42tLipvIGAAq81NA0ae1LAtCR/RkMFHFZPiFnUupzWLxkjVVhQxwyhVq0+FQ==
X-Received: by 2002:a05:600c:1d17:b0:425:7a99:e6f2 with SMTP id 5b1f17b1804b1-4257a99e85fmr35488805e9.14.1719849015569;
        Mon, 01 Jul 2024 08:50:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d5d7:31af:53ed:6dbc? ([2a05:6e02:1041:c10:d5d7:31af:53ed:6dbc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b09aa32sm159997005e9.34.2024.07.01.08.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 08:50:15 -0700 (PDT)
Message-ID: <b0677eff-e80c-48ba-a67b-edaaa037895f@linaro.org>
Date: Mon, 1 Jul 2024 17:50:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iO6MrX3QxAu4Wj4grUL2g7gPPXO3f8PFmZBot-Ud32TQ@mail.gmail.com>
 <9c2971dd-2f2d-426f-9107-eae93d5dd554@linaro.org>
 <CAJZ5v0ip9P7uD76i-SDxpea1Qj_8vgqhQ-jJt2h5iqYsMUaCzg@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ip9P7uD76i-SDxpea1Qj_8vgqhQ-jJt2h5iqYsMUaCzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/07/2024 17:47, Rafael J. Wysocki wrote:
> On Mon, Jul 1, 2024 at 5:13 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 28/06/2024 15:56, Rafael J. Wysocki wrote:
>>> On Thu, Jun 27, 2024 at 10:55 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> Currently the thermal framework has 4 trip point types:
>>>>
>>>> - active : basically for fans (or anything requiring energy to cool
>>>>     down)
>>>>
>>>> - passive : a performance limiter
>>>>
>>>> - hot : for a last action before reaching critical
>>>>
>>>> - critical : a without return threshold leading to a system shutdown
>>>>
>>>> A thermal zone monitors the temperature regarding these trip
>>>> points. The old way to do that is actively polling the temperature
>>>> which is very bad for embedded systems, especially mobile and it is
>>>> even worse today as we can have more than fifty thermal zones. The
>>>> modern way is to rely on the driver to send an interrupt when the trip
>>>> points are crossed, so the system can sleep while the temperature
>>>> monitoring is offloaded to a dedicated hardware.
>>>>
>>>> However, the thermal aspect is also managed from userspace to protect
>>>> the user, especially tracking down the skin temperature sensor. The
>>>> logic is more complex than what we found in the kernel because it
>>>> needs multiple sources indicating the thermal situation of the entire
>>>> system.
>>>>
>>>> For this reason it needs to setup trip points at different levels in
>>>> order to get informed about what is going on with some thermal zones
>>>> when running some specific application.
>>>>
>>>> For instance, the skin temperature must be limited to 43°C on a long
>>>> run but can go to 48°C for 10 minutes, or 60°C for 1 minute.
>>>>
>>>> The thermal engine must then rely on trip points to monitor those
>>>> temperatures. Unfortunately, today there is only 'active' and
>>>> 'passive' trip points which has a specific meaning for the kernel, not
>>>> the userspace. That leads to hacks in different platforms for mobile
>>>> and embedded systems where 'active' trip points are used to send
>>>> notification to the userspace. This is obviously not right because
>>>> these trip are handled by the kernel.
>>>>
>>>> This patch introduces the 'user' trip point type where its semantic is
>>>> simple: do nothing at the kernel level, just send a notification to
>>>> the user space.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>    .../devicetree/bindings/thermal/thermal-zones.yaml        | 1 +
>>>>    drivers/thermal/thermal_core.c                            | 8 ++++++++
>>>>    drivers/thermal/thermal_of.c                              | 1 +
>>>>    drivers/thermal/thermal_trace.h                           | 4 +++-
>>>>    drivers/thermal/thermal_trip.c                            | 1 +
>>>>    include/uapi/linux/thermal.h                              | 1 +
>>>>    6 files changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> index 68398e7e8655..cb9ea54a192e 100644
>>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> @@ -153,6 +153,7 @@ patternProperties:
>>>>                  type:
>>>>                    $ref: /schemas/types.yaml#/definitions/string
>>>>                    enum:
>>>> +                  - user     # enable user notification
>>>>                      - active   # enable active cooling e.g. fans
>>>>                      - passive  # enable passive cooling e.g. throttling cpu
>>>>                      - hot      # send notification to driver
>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>>> index 2aa04c46a425..506f880d9aa9 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -734,6 +734,14 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>>>>           if (tz != pos1 || cdev != pos2)
>>>>                   return -EINVAL;
>>>>
>>>> +       /*
>>>> +        * It is not allowed to bind a cooling device with a trip
>>>> +        * point user type because no mitigation should happen from
>>>> +        * the kernel with these trip points
>>>> +        */
>>>> +       if (trip->type == THERMAL_TRIP_USER)
>>>> +               return -EINVAL;
>>>
>>> Maybe print a debug message when bailing out here?
>>
>> After thinking a bit about the message, it sounds to me that is a really
>> an error in the firmware if we end up binding an 'user' trip point.
>>
>> What about the following message:
>>
>> dev_err(tz->device, "Trying to bind the cooling device '%s' with an
>> 'user' trip point id=%d", cdev->type, trip->id);
> 
> s/an// I think.
> 
> Also I wouldn't use dev_err() as it indicates a kernel issue.  Maybe
> dev_info(tz->device, FW_BUG ...)?

Right, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


