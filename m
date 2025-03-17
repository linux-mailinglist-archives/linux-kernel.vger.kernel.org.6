Return-Path: <linux-kernel+bounces-564510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07C1A6568F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15FD3BC0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2450188733;
	Mon, 17 Mar 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IdNLgRWV"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3E182CD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226407; cv=none; b=XFQPimbcRHn32RDFTtwweqYCPaQ0as1YLA6V2GLlujmYHX4afug3Wyaebf5Y+y+LVSlgXeRGYJv+MhKD0UMx3+Q5AtIzYssPyuJwL85B/amPlhA5DDOy4Te4F4d6Wvxf8lOvqpt/uxNUfp5dyGoKbSJsfQYTaI1Cv8u3pIr2VAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226407; c=relaxed/simple;
	bh=nMkcbK7rnWCIpgL+LrcuWEQLQ+oABD8VNGsKOQi3vnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJ7bc/sBhYWT0u7VO8BA24wdSptsAVf8evAI5ecVJ+M1lrvVdo4ZzpCHLiwC110TtwgOrfYgirsdw9yar6IQHNTsSfrvLCq76l//lJ2wuayqTkuLyxTfrHBqiP3+JsrGMeTL0c4bN4nMj+irxucx3RVTcIoz5v5KSbCwdcQIsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IdNLgRWV; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3fa58dc37c5so2882590b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742226403; x=1742831203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxGNuwSiLEC16juyCY9zxGdn8dvaO0Mb9PTV3kmTytI=;
        b=IdNLgRWVzk+yncNOIcmy4n0tbYcUdHiWKDJgiQSL1lodSMEEYx5YsP1iJKUax8ikv3
         257tM57iXPArHFqJMulmt1tVDa6HMUL5CvHyoiQ7r5Wgk/m3+Jhrk4IBr/QcmnyCQ/Np
         H16aw0lIBHenqj+TcfIq9ibWPvlyOpYwIZrE5vslRLPJqjaB9DGQ2nPLAA+9gF14gOur
         5ejEcsU2YaV4OTDHmghqt0DC8mLJwe1GqONX4XcWkBKtryMu7JPd7SfY4AoQ03xtp5Xj
         ojt6JZjZSAz37Jc1yxwWwdiLUFOBUMVjsxDsY22ldLQW8ZZfV+EAAW7rg4Je29T4+qdQ
         Ew7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226403; x=1742831203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxGNuwSiLEC16juyCY9zxGdn8dvaO0Mb9PTV3kmTytI=;
        b=CYNNNSnvrzggTY6KbVJEJ900jExaNA6a7tfuLTB3vGwcAZv/qu0D8js5xWIz59sFM8
         SM+1v4P2Sd+jGX+6kKADkinPwiFL7e3NJqQGubqWn3iMkKdhDILZ8dKDHXQYPtU+NaEk
         GpbVXp1uN1IkEa2fmrAjvDQv0njJNChT6Ur4Cwk0RzEs6nZZTH4X5WC0okovLH0V4Zw4
         KFhq/mLU0pQlFkBFef5lNZWabdLuOy4UQJCkYkFQCSIS+V9YebsKQBIjSBGNP5P7GGmD
         GZ1p4hM0yVM+67amrHAVkRCquyJX23B6nKBZbKIYWgbsRiGh0D94iGAq9SiyBgHkwlFD
         uSFg==
X-Forwarded-Encrypted: i=1; AJvYcCX8EYZ7DWityMG2tH4eBRjvdOi38jB6OYAUSAkqrGeXKKX1Nna7SrSYkuAN4+0/5OPSTWuyg470nximKIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+MOLjPJlyOCem5ImUKcPI83h2n1nQ2KPaBSVg7v+Ycco1ES+/
	zxcunw4ciCbpusv/SeR1BkbnpD82htSfIzRz8yQz95qP3bPQ4EWlBI7UlQrFGII=
X-Gm-Gg: ASbGncvNjIsw7cH3iqP7ad3h37mv1dx1czPnJ7oj5tA2LRfULAPrVwdp8Pnw2dIDghw
	dnxDat7PJISLvTtLGAHiBXP/xH3QApgj6AQx0lgxjNsj2q0Nnh0HyU1mNjOCbEfndKvP+BYndvE
	FlmRLz9h8SswOiLSW1yjVyi0RqKdrWzbk/O9Hlah6ZN4XLM/+h0Yuy4zlN4ZeTqe19dJq/W02mj
	u/UxRljlOHjexbc43VG7UiupU9KUYDY3zKM8WYcL8E8PzGe59J5KgQ5Eg3CTkORvvUpUufYEcEO
	Cgz2D8jX7wslANVsFi5Ob4pEBVqLL7/Dsa9enWTkc09PMv2u4l56EJETsT3n1arvdEcEYrwOU/V
	g1iZwwQ==
X-Google-Smtp-Source: AGHT+IFFtYd6yezG8t20CQe2zbctBzchEdRc4S/9ladxI0m7POupxKIlYT2EGN1PZGkgE32uracq7w==
X-Received: by 2002:a05:6808:3509:b0:3f6:a851:fe56 with SMTP id 5614622812f47-3fcbb6c0905mr9258519b6e.12.1742226403596;
        Mon, 17 Mar 2025 08:46:43 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd5bfff2dsm1861032b6e.32.2025.03.17.08.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 08:46:43 -0700 (PDT)
Message-ID: <60831e04-52c2-446f-8bc5-b5d3e9e5fd40@baylibre.com>
Date: Mon, 17 Mar 2025 10:46:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, corbet@lwn.net
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
 <301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>
 <20250317102751.5702fb82@jic23-huawei>
 <Z9hAUs1wPOIAo2nt@debian-BULLSEYE-live-builder-AMD64>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <Z9hAUs1wPOIAo2nt@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 10:31 AM, Marcelo Schmitt wrote:


> ...
>>> +/*
>>> + * This executes a data sample transfer when using SPI offloading for when the
>>> + * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
>>> + * tree property is set to "high". In this connection mode, the ADC SDI pin is
>>> + * connected to VIO and ADC CNV pin is connected to a SPI controller CS (it
>>> + * can't be connected to a GPIO).
>>> + *
>>> + * In order to achieve the maximum sample rate, we only do one transfer per
>>> + * SPI offload trigger. This has the effect that the first sample data is not
>>> + * valid because it is reading the previous conversion result. We also use
>>
>> Say what happens to that invalid sample.  Is it dropped or provided to userspace
>> as if it were valid?  (I hope dropped!)
> 
> TL;DR: The invalid sample goes into the buffer as a valid one.
> 
> In AD4000 '3-wire' mode, data capture has a latency (delay) of one sample.
> 
> The ADC begins sampling data N at CNV rising edge
>           |   +-- CNV (usually SPI CS) is brought low to begin reading the data
>           |   |                                +-- Data N + 1 that will be read
>           |   |                                |   on the next transfer starts 
>           v   v                                v   being sampled at end of transfer N.
>            ___                                  ____            
> CNV  _____/   \________________________________/    \_____
>                     _     _             _
> SCLK ______________/ \___/ \_ ...   ___/ \_______________
>                    ___   ___           ___
> SDO  _____________/___\_/___\ ...   __/___\_______________
>                     ^
>                     |
>              Data from conversion N is output from here on
> 
> A better drawing can be found in datasheet page 29, Figure 57.
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADAQ4003.pdf
> 
> In sum, we're always reading a conversion that started at the end of the
> previous SPI transfer or, in other words, the data comes out with a latency
> (delay) of one read.
> 
> Datasheet somehow mentions that by saying
> 	When turbo mode is enabled, the conversion result read on SDO corresponds to
> 	the result of the previous conversion.
> 
> I think I can do a dummy SPI transfer on buffer preenable so at least the
> first data is not invalid. Would that be better?

Not really. There will be a relatively long delay between that conversion
trigger and when the sample is read. So the data might be slightly less stale
in that case, but still not particularly useful, e.g. if you are doing any
kind of signal processing that expects equal time between all samples.

On similar chips, like ad7944, we just documented that the first sample does
not contain valid data and needs to be discarded.

> 
>>
>>> + * bits_per_word to ensure the minimum of SCLK cycles are used. And a delay is
>>> + * added to make sure we meet the minimum quiet time before releasing the CS
>>> + * line. Plus the CS change delay is set to ensure that we meet the minimum
>>> + * conversion time before asserting CS again.
>>> + *
>>> + * This timing is only valid if turbo mode is disabled (reading during acquisition).
>>> + */
>>> +static int ad4000_prepare_offload_message(struct ad4000_state *st,
>>> +					  const struct iio_chan_spec *chan)
>>> +
>>
> ...
>>> +		xfers[1].bits_per_word = chan->scan_type.realbits;
>>>  	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
>>>  	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
>>>  
>>> @@ -719,7 +1007,9 @@ static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
>>>  	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
>>>  
>>>  	xfers[1].rx_buf = &st->scan.data;
>>> -	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
>>> +	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
>>> +	if (chan->scan_type.endianness != IIO_BE)
>>
>> This is odd enough to require a comment.  Why is endianness relevant?
> 
> When using SPI offloading (at least with PULSAR-ADC HDL project [1]), ADC data
> is read by SPI controller and pushed to DMA memory in CPU endianness. I don't
> know exactly where data gets rearranged in the data path (whether SPI-Engine,
> the DMA controller, or something else rearranges ADC data into CPU endianess).
> But I know, from testing with these ADCs and HDL project, that data is correct
> when read in CPU endianness because it converts back to expected mV values.
> When IIO buffers were set to IIO_BE and SPI offloading is used, data just looked
> weird and didn't convert to expected values in mV.
> 
> [1]: https://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
> 
> Other IIO drivers also set IIO_CPU buffer endianness when using offload support,
> e.g. ad7944, ad7380.

These drivers also use IIO_CPU for the non-SPI offload case though.

> 
> They only say buffer would use 32 storagebits when using SPI offload.
> https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-10-e48a489be48c@baylibre.com/
> https://lore.kernel.org/linux-iio/20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com/#t
> 
> I also didn't expect to find out HDL support for 16-bit data width was removed.
> We used to have a build parameter for 16-bit precision ADCs.
> https://github.com/analogdevicesinc/hdl/commit/b2dc91b30dae891b6319d88e083f26e726f43ba0#diff-1117c2618353232e5f22aa6a12e8ae976757fa897b3425f470a12123cae26535L13

A while back the HDL engineers mentioned to us that they wanted to standardize
on 32-bit data words everywhere. While not the most efficient use of memory,
having fewer options does make things simpler across the entire software stack.

> 
> Would something like 'because SPI offloading leads to data being pushed to
> memory in CPU endianness' be a reasonable comment?

Another way to say it is that SPI offload reads data in complete words and not
in separate 8-bit xfers (bits_per_word = realbits vs. bits_per_word = 8).



