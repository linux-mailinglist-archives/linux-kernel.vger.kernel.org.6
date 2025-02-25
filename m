Return-Path: <linux-kernel+bounces-531741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96569A44452
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D942B172BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A68D26B968;
	Tue, 25 Feb 2025 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RUYgTBkL"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF226B95B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497220; cv=none; b=jj8kmdYlX+fIPXBjaj7M9MTuOPNsURh5NxDjIvbBLxOMd9OEwmOxAGpO5Oi2WXKA7SBDOhZDygnjFDHD8Ew+AAQrAi4QKb2dSatdwC+jNPy6AaJyV+eaieBvjObeUzyNomZXo3YdOUL0R3meoMnXhY59NT1Byn/3fQw76b8dWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497220; c=relaxed/simple;
	bh=R3eOfvTKD8GbF+X93jYcj93Ugx4SD0tD0JNmsutwA+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z3gdaWxIgZ+2x9kF6Olq6o9fcJ0TtfQsM5d2OhLcADEcAw7AiE9Kl5PJtuRwEujblvC9WQ0UgsZT2EueFL3AcQaim3u3XHzSDNKPb5d5tygdps7OQ7WraX8DaiOOgkSazv87gdqi7xyfGt1v7tjCxCz3CE398rCzs5ybiS8UYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RUYgTBkL; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7272f9d216dso3159613a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740497218; x=1741102018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEFMtqXWJ11nWI2h5TBKW+yhwiEH+1Jx79XU7n+Tvio=;
        b=RUYgTBkLJc5LcVmJKtlOa7wXn18qyGd8nUJcH6hAelS/mZOyWGLFKCBwC0ZAlJ+JyD
         VsOAwCt80OOkaQYpJ5D+avEDU8rjUh0IOg1wzOZo8plr7Bf+48ebEknTTBIsOoE7bPic
         glQLOOVc9bgAn7Kb2oXJj+WGuMAptlZ4dy8lj1rQx8K6dw18WLiTDTQHnVX0WrZCY58u
         QXuNEcKwKLW286CwJPV47//X3nbWmpwM96clBnDNBWeTIIw35HsHT1dFrMv/5aD9tdSF
         2cH1x0u0TgMd1BsWb2Gsld6GTKXn3s8v2Jz8PpdrezpDlL02hUXe5dQS5vRWZW9eZhtD
         RqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497218; x=1741102018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEFMtqXWJ11nWI2h5TBKW+yhwiEH+1Jx79XU7n+Tvio=;
        b=fj/PgA+lMQDBH76t94Juk/Pp4Z3ITe+Wk498sphKDKaGZmSi49i29zUR9KV3OAXJy+
         lkRNsb023J64maFfhStQB3kYMFxBNnXHz8Fsr4WlO0LfALoYQaeieuLeILG6Nv2hp2vl
         bJWUkCtGD1u4cQiVwXX4iCs9a2XhfE7wBGZkZSTQvIPJUARKMx2fyDWISvJmpaQ40RN0
         l2jyXcgXGdZzyXT26vuzVP8DP+LMGpGf/touj681UF4hbDnbgtjRgv+vZpkYSdeJBOTE
         K3fL55caURDi9F+3nm8B9RpbHquq+SE5hV5wx2oNHdsYrlyFc31PDdnvLI3UVFAj9xA9
         qsxg==
X-Forwarded-Encrypted: i=1; AJvYcCXzSa5f5Um7a+tuxoyixTnpV7XiIQrKRRUol1/O7AquxJn/oRP2tl2H6P1mms6GMVR2JdlPn105pQA5N6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4h1Gn38g6PIySszMDNYEQ2WQr9J2J2Icxb8jZeJsrKoCz9SXb
	ARzbCnKAfMPfyCz5UP+KU6CsMhBKdNnY640GrGpsEMTdkaxILem/TB0DZAl4gIg=
X-Gm-Gg: ASbGncuznpnTpDWl80FGoKdEmN98ucvWdh88n9ee2vRDljiQKMiNPvTFaN3Zh5l2+UN
	qsRkzIdA/2M/MUEwPlerMNZE7UNJ8YheQNY9RpNhTQ38A3XTWzBane2csoOZ/GKTjl0RV4AE40w
	ODzdPWenl51tg6a33shkpIegAQY4iWRNJDP4PtHFNJxeENByX94XlWnyRNF8+rdoEoLTN2HiBHe
	fBnyov5XzCGqAioPbyu46D8ApMVsEpEutVjo/AF+4FbMpaaOdHcExGVyNumnEG/7SWQA0nsL9wr
	3lFozC+5oXnp8x37LXrWWu0fKwFwKqoSjuYnpLQUN1aRADqAvoO1cdcugjaxXEY=
X-Google-Smtp-Source: AGHT+IFGCyY/0apfFgHzqIrY9A63Ru1cUYpVgHHxAiTBgOOrsAuBzOUsIBrLonLqsT9Pl1DiMc3++w==
X-Received: by 2002:a05:6830:2b07:b0:727:2e61:c831 with SMTP id 46e09a7af769-7274c235252mr14195332a34.25.1740497218150;
        Tue, 25 Feb 2025 07:26:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-728a42cdcd9sm25002a34.11.2025.02.25.07.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 07:26:57 -0800 (PST)
Message-ID: <d1af7490-5d91-4b30-a86f-8df3a8d17af7@baylibre.com>
Date: Tue, 25 Feb 2025 09:26:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] Documentation: ABI: testing: ad4080 docs
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
 <20250220135429.8615-15-antoniu.miclaus@analog.com>
 <8f588f4b88d122815df694660d19672e8ccd3d70.camel@gmail.com>
 <fd3ba169-c5e0-4405-961f-d7c11c68dffb@baylibre.com>
 <3f4bb345c1d76e7521d8bdbf4b4552e727c7dc1c.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3f4bb345c1d76e7521d8bdbf4b4552e727c7dc1c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/25 3:16 AM, Nuno Sá wrote:
> On Thu, 2025-02-20 at 12:27 -0600, David Lechner wrote:
>> On 2/20/25 8:53 AM, Nuno Sá wrote:
>>> On Thu, 2025-02-20 at 15:54 +0200, Antoniu Miclaus wrote:

...

>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate
>>>> +Date:		February 2025
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Set the filter’s decimation rate.
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate_available
>>>> +Date:		February 2025
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Return the available filter's decimation rates.
>>>> +
>>>> +
>>>
>>> I'm not yet convinced we need the dec_rate custom attr. I'll add more
>>> comments
>>> in the driver.
>>
>> If we do need it, in another driver recently we concluded that
>> decimation rate is the same as oversampling ratio and there is
>> already a standard attribute for oversampling ratio, so we used
>> that.
>>
> 
> Yeah, in theory decimation is about averaging samples. Makes sense to me even
> though I never thought about using the oversampling ratio attr. I was biased by
> the IMUs drivers where we configure the dec_rate as part of the sampling
> frequency attr since these filters directly affect the chip ODR. 
> 
> Out of curiosity, how did you handled this in the other driver? I would be
> tempted to only allow reading the sampling frequency attribute which means that
> the oversampling ratio attr is the one we can write (which then directly affects
> sampling frequency).
> 
> - Nuno Sá

The other driver is still under review:

https://lore.kernel.org/linux-iio/2c3ce1701545e435238605342397e45657a0fb2a.1739368121.git.Jonathan.Santos@analog.com/

It is modifying an existing driver, so in that case, we still have to preserve
writing to sampling_frequency even if that isn't the ideal way to set it up.

