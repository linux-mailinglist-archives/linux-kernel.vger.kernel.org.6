Return-Path: <linux-kernel+bounces-562090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D5CA61C01
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE64219C78D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545A6204F7C;
	Fri, 14 Mar 2025 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p6vCjM5P"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A1204C38
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982628; cv=none; b=cnBAEeOOyeMWYAE9KSidC+HEcbZoB187/6NFgDn5ppyoGyEcH/1barU13ps8xwAtgvuC1njXUeDK3Hdb5oDm/rIf22eyNpgTnYz6I9lwYWDILZ03BzAX+K75wiiwG2f8jC/EiB17F1R/erPvHf88XxxgJh03m+cShD1aytU9/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982628; c=relaxed/simple;
	bh=NBh1ib8TOp9yV+GZ8BCBjXKYANmqvBc+qIjMQrykCt0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cahH0hpBtr7YcemxuWTf277ZBVpQ+vpkGlYxuoDOaAxR/OBdtbV6RgRJgwgU07bACb40OADwwej7/XDBDoWc0Gj+pcPlcLE28vJHLtCz6uVXF82NP1JpF/FngMViPmTiI+0sj/EALUsZ6GIs7Zv1y5RaY4+pwbT9UopCiExtP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p6vCjM5P; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c11ddc865eso852184fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741982625; x=1742587425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/t8DGEkQgF9HsFcbNry4sid1C4GD98meoHnJLzxyotQ=;
        b=p6vCjM5PH9L2oX6E2UYzwchfFPUuj894SxrVOU7xZEEjJ6cbeJngyt+PzKc01SzjAG
         /lzOLir0vy8G3uZk2/td5Nt7+eMgXFSUKY74CEQXUxKh/dD2DlOwyAWehEZw9Y8dKxu/
         QVt9vArEBhDwdd/BvrvB8VBuhxsRk6WoLTYHI4Bu8Ln4efIlH/rFlSYwUS52cMzgjZci
         Q33U0N3RTQId/6maB5tl10QjYs9DW02yo+W7uamjDyjAPALXorjBF/GHiP/Pm7gW4q/q
         45Qnxni7sFWhiRc6bQ4uoMTGu+H5K+EW+4tiMvy5/REd1K6HHez0dZKnO6PlN53yS7zo
         WbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741982625; x=1742587425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/t8DGEkQgF9HsFcbNry4sid1C4GD98meoHnJLzxyotQ=;
        b=Huul+6oj9nP+sq54VR1oGJNUWFgO7mI9etjMqh2YHmmnXhpRMTq4J0lrMrtaAjCrIV
         7N3cMi+gKNehTBr0xVyCzcu+IsZOvSq2dK76RKTXmtQ60MXvssbm+vsQ+HiSl4v7P6aJ
         0BbIYZuTZbSW3v0OJOzxKP9Rl48SL7NeNxcm/H924t3tD0R3Saesom+Yv9l8uie2QhRA
         1RDsz+IAoc7VzrtApiaZ4wdjnmiRgTO2BzxURaimHclCr+UO84IIX1mopV14JyZXSOkK
         E3GWD8CmXQWPrAp45RfZud9sXCfh2V01vpK9XxQpKTxelw1fWkhf46adfCkCtUHitAH1
         WAfg==
X-Forwarded-Encrypted: i=1; AJvYcCUqpFs0n8QK3cYpIAjJFOc1CQAejeQFsaxKRYRCnW3lC2pcLVQE7B6O/rvIIWJTkpFxeKJ0N5tyOlewChE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1fByzeWeZUYTusZYqgPIhBQL00vZHYK/onDC2uvNaWQoTOeK
	5myi8ArmwepShTn7nmYP+zq+eQAKh60SgXz6mkwku5GicBiCQHIGH1zVoNyhvNo6ga5yMh7Nbe4
	O+xQ=
X-Gm-Gg: ASbGnctd4w3uGE3Dq9KfqsUdr5sfV9spRH3bvTnWhZ6NbcXPNivxAbd92R4TvVfczjc
	Klef8MVLTxp5CmnJoZ5LmzXEzw9wX+zRtQqNLdgxvgBC1z3TvdlW8zgBf6QtKM1g6reKOVYFb6+
	/iMXHPGxv/VA1sfeJHcy51b1aI4Zq3Jysy+KsXA55pzTwGKUYnuP9mU+ppbyNU+GPn64yf8MAvX
	AuerOWEG0msSkmmuIvL/XtBukmSOYbe+CTXgp7egKrsXN/9adgXog9UcZ9jyI2pMxPqfbEcrOQc
	LYAyf3XjufXF8XtUeBcgVSP5hoRIXdm6R8FwgAs3vv5cC4kfHOx4QJSuMtkoeSygEXBvNH2nifz
	70TffEQ==
X-Google-Smtp-Source: AGHT+IHkQhbCbr5tEQHM5PgoUcAYVVLVKKXP4thp4rJGiHPtHTJRGgiHkIs124SWGjZIG2J1tZ5H7w==
X-Received: by 2002:a05:6871:153:b0:297:2376:9b17 with SMTP id 586e51a60fabf-2c690fe92bcmr2006147fac.19.1741982624833;
        Fri, 14 Mar 2025 13:03:44 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb26bbe2esm773443a34.31.2025.03.14.13.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 13:03:44 -0700 (PDT)
Message-ID: <177eb738-fe13-43ae-a02a-7c6b026536ef@baylibre.com>
Date: Fri, 14 Mar 2025 15:03:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ad7380: add support for SPI offload
From: David Lechner <dlechner@baylibre.com>
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
 <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
Content-Language: en-US
In-Reply-To: <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/25 11:31 AM, David Lechner wrote:
> On 2/20/25 12:03 PM, Angelo Dureghello wrote:
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Add support for SPI offload to the ad7380 driver. SPI offload allows
>> sampling data at the max sample rate (2MSPS with one SDO line).
>>
>> This is developed and tested against the ADI example FPGA design for
>> this family of ADCs [1].
>>
>> [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
> 

...

>> +#define _AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, gain) {		\
>> +	.type = IIO_VOLTAGE,							\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                          \
>> +		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
>> +		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
>> +	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |   \
>> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> 
> Not sure if this is worth troubling with, but it might make more sense to make
> IIO_CHAN_INFO_SAMP_FREQ info_mask_separate instead of info_mask_shared_by_type,
> at least in the case of the single-ended chips.
> 
> This family of chips does simultaneous conversions so shared_by_type (or shared_by_all)
> would typically be the right thing to do here. However, the single-ended versions
> of these chips also have a multiplexer, so there are 2 banks of simultaneously
> sampled inputs. So the effective sample rate as far as IIO is concerned would
> actually be 1/2 of the sampling_frequency attribute value.
> 
> Since we have a channel mask restriction where we force all channels in a bank
> to be enabled at once, I think it would work to make IIO_CHAN_INFO_SAMP_FREQ
> info_mask_separate where the reported sampling frequency is the conversion rate
> divided by the number of channels in a bank.
> 

Hi Jonathan,

You might have missed this since v2 was sent before you had a chance to review
v1. I am testing the chip with the mux now, so I was curious if you had any
wisdom to add here. The way we implemented it feels a little odd to me with
sampling_frequency as info_mask_shared_by_type instead of info_mask_separate
or info_mask_shared_by_all like on most other chips I've worked with so far.

I found a bug in this series that I need to send a fix for, so if we decide
there is a better way here, now would be a good time to do it.

>> +	.info_mask_shared_by_type_available =					\
>> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
>> +	.indexed = 1,                                                           \
>> +	.differential = (diff),                                                 \
>> +	.channel = (diff) ? (2 * (index)) : (index),                            \
>> +	.channel2 = (diff) ? (2 * (index) + 1) : 0,                             \
>> +	.scan_index = (index),                                                  \
>> +	.has_ext_scan_type = 1,                                                 \
>> +	.ext_scan_type = ad7380_scan_type_##bits##_##sign##_offload,            \
>> +	.num_ext_scan_type =                                                    \
>> +		ARRAY_SIZE(ad7380_scan_type_##bits##_##sign##_offload),		\
>> +	.event_spec = ad7380_events,                                            \
>> +	.num_event_specs = ARRAY_SIZE(ad7380_events),                           \
>> +}
>> +


