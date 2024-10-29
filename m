Return-Path: <linux-kernel+bounces-387754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE979B55C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFE81F2373A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2720ADE3;
	Tue, 29 Oct 2024 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xClEgT+q"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FA20ADD3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240772; cv=none; b=ffS4gDQP0T0OAGhYdOzAABtShRtapya/CfrcHw0Fxe9uQLRunXCJmxpdGb6cos2Dm/+s7B2CHd3xn0N9uF6XuD6MNOgTQJUehKir96Dp5NxfzkyT45KhXyCTucIwlS8KqkbimL1uPmM5Vn4ElxCgwEhxCZu/321cZB510gcsOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240772; c=relaxed/simple;
	bh=t5+4Q8OWpVdp/0RgGYt6wGLBd/T5QhCCqDsGYRkkzmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF8oS0Rw91CnuicuWkguKQ393CkWBV/YfPP4fupvVbMhHNwltT3vYGzveLVUelSqX8q4s/FxdIAL1UgYkHRMTcqZfNn/dzRHJ4gyzz88Wght5/DfaVLpFCKRz1XWi5w3YUdDYqtJdnP3BxLXObkb59Mlhkr72y8N8vtZO5hgD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xClEgT+q; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e601b6a33aso3509594b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730240769; x=1730845569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JlW02YBV+5dPho8DkByoe+gPa11gJkbgA1l/C1eYeW4=;
        b=xClEgT+qYhpknxBOr3R27bCuYGRvNZTX8SlqE/R3uqZauJBKBhzcl+SStQG3JJWN5B
         +W5oa+DrNkXM3kNtnE4JC7Lc4gaG1s9u+7VzAHct2byk0/fmbo3jcNdYHxEem8yAcvDl
         MbG7DUIHxjtL6WSuK3xYZMWhk94YHJ2xXiA1bnedsOA7tO/QCEscxiXk5EhiFIRE0lCA
         5CtUEL9kfPCJuZZEqyPn9XypA70rfVcNbzRVXSRhnUcu0Y2PAiHRrZTRv8s0mfowvsyZ
         K3AimnEYPmb8CgivA1wXkS6tUIJ+Axjhu6X4gkUm/wC1Y3XehH8cpFCbc/I8GSqnJBpf
         JAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730240769; x=1730845569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlW02YBV+5dPho8DkByoe+gPa11gJkbgA1l/C1eYeW4=;
        b=wiLbH7g15B04LMVocTItCccDdwlVX8w1aohTbJRufo9EkY/AgpwYfLrUbL/FEO9cr3
         PIO26JpMv3zeYv/qWPluSwgXsjeCk9GeoY1KyUR8/wPye7F9L7tPng1J9hSSILSTnXrk
         lglC0ke82nCC7tgt+R7BKDKtG1Wc/TpnEmsvc8QaD0iWDo3EITBx7sxMziSVeWwoyabf
         4zanwoY7YK5dfSkXoP2YgYm/n2uCzO4kFdshQXEvor+Ey6pYHDj4tkJIPD5TMolmA1+W
         myc9gI5wvWsHfreW63UrFVNVZyZMt+cw7KFnWxYKXz3rD7f3I8/y2o4JcMvrICgeuYPY
         k5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9atrHLDKJJqLRBbASULonlzeHI+1Q/dAmua2O/mCmFhkc31Ya4/MpmZm1L7FRm6HUC9cHc5CF6EPirlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+L6T11dtr5PAY3hn6QEQOv0g+AWaHZmPoV7qpvs43y2NwiyxT
	M531JdG8TLTYLvJy/5mX7/t1CIsemhkCY9SOx8MSB0A3ldu7sBhADRR74GSSEog=
X-Google-Smtp-Source: AGHT+IH+xL4WkT7PHq4e4eGpDTEdBuUhuyNcG6ApkM+ymrg3d/hbpgqXXO+NZSR4pqqXg7V3HUjnJg==
X-Received: by 2002:a05:6808:22a6:b0:3e5:fc09:7f51 with SMTP id 5614622812f47-3e63823916cmr11524333b6e.9.1730240768711;
        Tue, 29 Oct 2024 15:26:08 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6340bbb20sm2221777b6e.7.2024.10.29.15.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 15:26:08 -0700 (PDT)
Message-ID: <b9da1c5e-3177-4bd1-abb2-5e92b0c2fb4c@baylibre.com>
Date: Tue, 29 Oct 2024 17:26:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iio: Add channel type for attention
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Ricardo Ribalda <ribalda@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Harvey Yang <chenghaoyang@google.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
 <20241028-hpd-v2-3-18f6e79154d7@chromium.org>
 <20241028203437.3eb5268d@jic23-huawei>
 <CANiDSCu7G8gDKaY5jJR+JGyqGDobkDPRG+9NOfpXvVviqkQizA@mail.gmail.com>
 <20241029143847.00004392@Huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241029143847.00004392@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 9:38 AM, Jonathan Cameron wrote:
> On Tue, 29 Oct 2024 13:20:06 +0100
> Ricardo Ribalda <ribalda@chromium.org> wrote:
> 
>> Hi Jonathan
>>
>> On Mon, 28 Oct 2024 at 21:34, Jonathan Cameron <jic23@kernel.org> wrote:
>>>
>>> On Mon, 28 Oct 2024 10:12:23 +0000
>>> Ricardo Ribalda <ribalda@chromium.org> wrote:
>>>  
>>>> Add a new channel type representing if the user's attention state to the
>>>> the system. This usually means if the user is looking at the screen or
>>>> not.
>>>>
>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>>>>  drivers/iio/industrialio-core.c         | 1 +
>>>>  include/uapi/linux/iio/types.h          | 1 +
>>>>  tools/iio/iio_event_monitor.c           | 2 ++
>>>>  4 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>>> index 89943c2d54e8..d5a2f93bd051 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>>> @@ -2339,3 +2339,10 @@ KernelVersion: 6.10
>>>>  Contact:     linux-iio@vger.kernel.org
>>>>  Description:
>>>>               The value of current sense resistor in Ohms.
>>>> +
>>>> +What:                /sys/.../iio:deviceX/in_attention_raw
>>>> +KernelVersion:       6.13
>>>> +Contact:     linux-iio@vger.kernel.org
>>>> +Description:
>>>> +             Boolean value representing the user's attention to the system.
>>>> +             This usually means if the user is looking at the screen or not.  
>>>
>>> Hmm. I should have thought of this when I replied to suggest a new channel type.
>>> The question is 'units' for a decision.
>>>
>>> Last time we hit something like this where processing is used to make a decision
>>> we decided to at least allow for the concept of 'certainty'.
>>>
>>> The idea being that smarter sensors would tell us something about how sure they
>>> are that the attention is on the device.
>>> The analogy being with activity detection. See in_activity_walking_input
>>> in Documentation/ABI/testing/sysfs-bus-iio
>>>
>>> Do you think that would be appropriate here as well?  For this device
>>> it would take the values 0 and 100 rather than 0 and 1.  
>>
>> For the particular device that I want to support, they are giving me a
>> value of 1 and 0, and the example from usb.org seems to work the same
>> way (Logical Maximum of 1)
>> https://www.usb.org/sites/default/files/hutrr107-humanpresenceattention_1.pdf
>>
>> I have no problem multiplying my value by 100 if you think there will
>> be a use case for that. It will not have a major performance impact on
>> the driver.
> Same was true (0 or 1) for the activity classification but I'm not
> keen on certainty :)  So lets' copy that precedence and *100
> 
> 
And I assume we would want this to be in_attention_input (processed),
not in_attention_raw.


