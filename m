Return-Path: <linux-kernel+bounces-521819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DDEA3C2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6D5170A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00BA1E5B97;
	Wed, 19 Feb 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IbZAjarU"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE81D8DE1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976773; cv=none; b=r/8Tg8nQWI6xWcPyOZg27KMLZ6VcTk2DIWQmCIVpwAkOMIkrmKip/3+UMKAZ/vi8G2YLpzXUC6H6qQqmNygKsIXXREUbfgisyIPJZukWxKiAUL19WrQNBLkJb2qlEdk44rTkp6GsmS1Lqoy+5t0J5O5tIZniSmXd3kt/hzhf1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976773; c=relaxed/simple;
	bh=dp5AVOsGmbjgfTQnYJoV/9JkRncskhmWkEaujE8CIsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zm5Av/fypZRWzzhbA/LfURbqe88EGeZhkMxzpN+KW978m+/doD9HFIVf7UTmB+2QWjcaKFnTr7/VYGtqH2IU1Mxndb6eM9tb154NCtPbgmzDmqvpn+Vu90EN6lMnsS6VpP+ms6yAQmo/pROnQ2HeYkxfIn6Zua68l7Ywoedm7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IbZAjarU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so3772021f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739976769; x=1740581569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcrTLEV536jWejUD/85wpmtXUyXxwJGaRE9pys71VVI=;
        b=IbZAjarUoH+nNPfLQKaBioT4qbnWq3UWHGGnMrne78Jpujb14UXoNVNAfcpMyfvORe
         minumA13H/4aVWO/6DMx8ozMiTpi72nRaz72Pdh66a0dg0B3MIrWsjyaOVByhpGsKo1P
         GNeAyaXFuAgXfBub8oxr8RW9JUpwQd3eRnDl3gRh10J6CucCQjoPaT2SLd7YsPP05I9S
         Y7IFwcV3m5zUBcEY73ycyNfWGsTXNydRxgVwUikvqNkwWh7VHpNISWUFqBqv0Z4q8RBZ
         SUHr8uRyjZm+TRUi1zYdFNKGT4Ez6WWfJzIo10NGkPvAGMztBBrANMg85XA9tM2SVgJW
         QjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976770; x=1740581570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcrTLEV536jWejUD/85wpmtXUyXxwJGaRE9pys71VVI=;
        b=ip8o/vlWAedzsZTMIMJNuOWQ1vs7kSzh3Xo4Taqzzpw5eB+R2v/ywtkS3lI1LEkBz0
         +AaJkzToWUIDqDO4tmehoFkRwe8BKHBPX6Scqp+FObfY6KWdbEsS+jpfoTKKKq5MJnA2
         RIbxvS2ZD2KEAUAw1K4AbGoR01/5y1R/QZn0UY1lWc5G+2+4YPjAYWGlOFndhSCIs/61
         nYtjWdZaBbcDP7xfpttgy/AhCZAhWwUrStWKcOihXsKObToFHKGhDs0Kja8y8ouZpFDC
         0yYkwxes4sl9b/AtqCX1Sgo2z/kH4uFwT6j/VoYO1qR4ZTL89MMVK8eg55ZsrwOxnLJc
         l+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXDP1hLvJfXDXiuAgwO3oYAs/8N0U8v0eTJlIW8b2ds5JZMRNPjiQ3xvT5vpm/D6/RJwXtzL6AVJUGYTYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIs8JeMsvaqLT4vjFgbMQgwYMKpytmFq7hWMGRiZl4okfxKtpK
	+P0eyzANC9yN3/p3L1Gjf59u3JsIGmK55+SquyYrWe1D6hRlzaxSZK1ah0eSpvo=
X-Gm-Gg: ASbGncte52t2VAP/7addyfuJuSzbIi9UR4PWPl5TlHf0UMyytF/XzGtJbxcSDPsrXY0
	IOsI4YGMSBl1xHMHqrYX45Na3fwZOrMaMMpuPi1mhtljy0fZig2X6+We1FQYEY7GgQc1wHIRFOg
	Skf/1D7/+mfthFIDG+PUi5c4y6dU0PC0vA2DHtRZdaeHSpqXUQjmeQY3nTzKVOq/diAJdNjv0qr
	P5G7Kh0fM3YDGZH8HIHbI+aMzQjKwRVhQGPWY4XFkv76ZkCO2V/FpJa8A7Kap6ZYbarH7HWpHJ4
	0/UKkp6uGIEniwMkORigYizJqlBib/URj+S4YUgerJUSmeiAejTt4hU=
X-Google-Smtp-Source: AGHT+IEGpOUT2Kql6BOz/f6CUFqRsZvcez+B8YGnnSN/N6M/oshP7AzII9i03CFTfTUAIR5PkMXw/A==
X-Received: by 2002:a05:6000:2a4:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-38f587f3ec3mr3475441f8f.51.1739976769565;
        Wed, 19 Feb 2025 06:52:49 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259f8115sm18324866f8f.92.2025.02.19.06.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:52:49 -0800 (PST)
Message-ID: <5f7cb96d-ccc5-47d6-a732-560dcedfa04f@linaro.org>
Date: Wed, 19 Feb 2025 15:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] irqchip: clocksource: fix jcore-pit irq request
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "D . Jeff Dionne" <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-3-contact@artur-rojek.eu>
 <d7484ab2-6da0-4bb9-a2ae-9388dac15038@linaro.org>
 <CAMuHMdWX9xeLRDLnteGWR31KbhtdupxVbhjQqY-6VaFA4tVaBQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAMuHMdWX9xeLRDLnteGWR31KbhtdupxVbhjQqY-6VaFA4tVaBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2025 15:50, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> On Wed, 19 Feb 2025 at 15:43, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 16/02/2025 18:55, Artur Rojek wrote:
>>> The jcore-aic irqchip does not have separate interrupt numbers reserved
>>> for cpu-local vs global interrupts. Instead, the task of selecting this
>>> property is being delegated to the device drivers requesting the given
>>> irq.
>>>
>>> This quirk has not been taken into account while migrating jcore-pit to
>>> request_percpu_irq(), resulting in a failure to register PIT interrupts.
>>>
>>> Fix this behavior by making the following changes:
>>> 1) Explicitly register irq_set_percpu_devid() in jcore-pit.
>>> 2) Provide enable_percpu_irq()/disable_percpu_irq() calls in jcore-pit.
>>> 3) Make jcore-aic pass the correct per-cpu cookie to the irq handler by
>>>      using handle_percpu_devid_irq() instead of handle_percpu_irq().
>>>
>>> Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")
>>>
>>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>> ---
>>
>> How this patch should be merged ?
>>
>> It is touching irqchip and clocksource at the same time.
>>
>> May I pick it in the clocksource tree ?
> 
> Thomas already took it, cfr. commit d7e3fd658248f257
> ("irqchip/jcore-aic, clocksource/drivers/jcore: Fix jcore-pit interrupt
> request") in next-20250219.

Oh, ok, thanks for letting me know

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

