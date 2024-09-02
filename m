Return-Path: <linux-kernel+bounces-311354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3A49687F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07851C21D0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58213185939;
	Mon,  2 Sep 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KnpIYwHN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BDC19E971
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281544; cv=none; b=OvVJUg2ovZgZA6QfDXAQOIHWrFD9tTidIDOTm8eP7QBbz1fesjorhf1ZrmobRsuIZiHQ3PVaY639ZZJjnuL+wD1YzTr1uaNduMhGEXb0F71nqRaV9psonkxkiJf5hkCMrR2/Y6Pdpndazo1t4285majywLxWm5fwI7vu5UGBkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281544; c=relaxed/simple;
	bh=ZQotgAsAXs1iZJnrgW7Lw5GSy+74NXLMVHRju+fcSMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLXnufCHSCVsvuNUGls/hNMxgBhpmqYpY8ipMKVPWtVUhPuyaOcB5pFfXXzXnUbfNMd3vAk+TgbBGS31QLgxrl8QyvHJjedd40NiYYTJffB5hKK3NHel3np8wJbJPnv6NU3FHRrf34hkl7glZuVqL73hev4YX6paEpmaPy6jW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KnpIYwHN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso5853054e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725281541; x=1725886341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmeThk7XWFPx4XbOstL7FlA9C94AN0gknO7JvJ/TuZ8=;
        b=KnpIYwHNwweuJqq3TuBcM+aSCyFNomsJeWjbmT7ZupsbdoBtzFFyvEKI6LgiX4xsCq
         HubwIuVE2TTzXllj0/hmOSYg6cglN5DBfsNuUaLrPylREuJiIE7ozWBX2KFYp2CuG/Wz
         pEmFMKYHKzyk5M6Tr5oHWJ9dmQFEDKbmvDSDolPBokDDTQMtGKpM8jXbt4tscqPrGOY2
         x0w6TybPUQiV3XXyHDQ4hp4YuEWA3E7Tfmb4+nHl0RDE0MsjBlzH1IbxYyYmiN/yPQsj
         /moeED3DjL9rM4+SmiNxVsn82qIG5xGcOhptx+fLAqGHhoUO5sxngKykOhltujLruMl6
         Cfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281541; x=1725886341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmeThk7XWFPx4XbOstL7FlA9C94AN0gknO7JvJ/TuZ8=;
        b=WBzeVtnGnTXVhmKR28VJtaVdib73jN++lJrBYCdk3pGOPGAom6hkENKH30aTpgCor7
         DfGJ+yep7/sDSxojtTI0UUpOcFfE5hbEWKIEPa7ojc2k7kWTz0fZ/4gKN31CIMm9HRJt
         xNHHXc1rmZ2IVAV933e0qtQ4uQgkczlaiHermjjgslyk1c5ei1AFfqSC2s0Uv+50UHQL
         AQSzB4EVjrIFd3QSyFWG5zXrnf4mgNsd3yOK53J5pQ8rmBGuKZvA/Rirot1IF+m3+0dc
         6ig/D8DowUl6TmqqFraXbhnhgWndlHT0bEmeqzBvJEXGjIckvrsDtwwsJnB4FTyk9P5i
         sOtw==
X-Forwarded-Encrypted: i=1; AJvYcCXwR2mWb2zj4B93i9s89fp7KoUd8MOHPvyF77NMhO6tNi1yvze774vE3WJc26WK2axUcfnbiIPGQdVWPjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPl6nu73HY2WDWvj3VhfV/Uoa2ChqNH7cykpLE2QU+BVydbO1f
	ZWgA1z7Aw5W1u7GVPQyDXFhMdbQwiwFIYtayxBtkoOBPxxPnwJC/fBuIwRMl9X486m3ufAV6p7L
	9
X-Google-Smtp-Source: AGHT+IEzNCkW3v30wrUdGduiZlS4eBnhnVFOA7c7ArVjEQynND34NoB436fKQ1ZbOxxWlth0imSDbQ==
X-Received: by 2002:a05:6512:31d4:b0:52c:90b6:170f with SMTP id 2adb3069b0e04-53546b3e37cmr8771005e87.29.1725281540459;
        Mon, 02 Sep 2024 05:52:20 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8989222593sm554988766b.205.2024.09.02.05.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 05:52:20 -0700 (PDT)
Message-ID: <decc4495-4a37-4f18-97fa-0bbc25336fac@linaro.org>
Date: Mon, 2 Sep 2024 14:52:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/jcore: Use request_percpu_irq()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>,
 linux-kernel@vger.kernel.org
References: <20240730132015.8920-1-ubizjak@gmail.com>
 <51c33ede-b379-41ab-88b0-71615e214853@linaro.org>
 <CAFULd4Y83ciewbJe36jsuTVXL705_DoS_QpjKayniSCdqkpsEw@mail.gmail.com>
 <21cc2173-2934-470e-a151-ed3fe2bba9db@linaro.org>
 <CAFULd4Ya-dx-=8yYeOd_gmzvXdriZX1i+pUaG9L+X5ykwJxXJQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAFULd4Ya-dx-=8yYeOd_gmzvXdriZX1i+pUaG9L+X5ykwJxXJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2024 12:50, Uros Bizjak wrote:
> On Mon, Sep 2, 2024 at 12:33 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 02/09/2024 12:11, Uros Bizjak wrote:
>>> On Mon, Sep 2, 2024 at 11:17 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 30/07/2024 15:20, Uros Bizjak wrote:
>>>>> Use request_percpu_irq() instead of request_irq() to solve
>>>>> the following sparse warning:
>>>>>
>>>>> jcore-pit.c:173:40: warning: incorrect type in argument 5 (different address spaces)
>>>>> jcore-pit.c:173:40:    expected void *dev
>>>>> jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *static [assigned] [toplevel] jcore_pit_percpu
>>>>>
>>>>> Compile tested only.
>>>>>
>>>>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> ---
>>>>
>>>> Added Rich Felker in Cc
>>>>
>>>> Applied, thanks
>>>
>>> I think we also need the following patch, since we changed request_irq
>>> to request_percpu_irq:
>>
>> Hmm, I think you are right:
>>
>> I would say it is:
>>
>> static irqreturn_t jcore_timer_interrupt(int irq, void *dev_id)
>> {
>>           struct jcore_pit *pit = dev_id;
>>
>>          OR
>>
>>          struct jcore_pit *pit = this_cpu_ptr(jcore_pit_percpu);
>>
>>          [ ... ]
>> }
>>
>> The former the better for the encapsulation.
>>
>> Do you mind to update the patch ?
> 
> Done, v2 with changed jcore_timer_interrupt() was just sent.
> 
> Sorry for the inconvenience.

No worries, thanks for the v2

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

