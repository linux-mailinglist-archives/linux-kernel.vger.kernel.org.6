Return-Path: <linux-kernel+bounces-527394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C7A40AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761DC189CA3A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446D20013A;
	Sat, 22 Feb 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AgbDvlRB"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184113774D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245467; cv=none; b=PsmqvieNVHssXYR+m5qdNf9CMBXF6NY9t5ypg3q+i6VBi+cd9u7jYjLq9LUyLWYN+/hf8a0qqyNvcOI2svdlvOMF7Isz2k/u9HIYVStXSt/CatFLjntZdi6Cuh3t68vL0Tw8eJt1nhXR11R8SpefoAxhEZaXGEvKAWlz3Ov7a8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245467; c=relaxed/simple;
	bh=CyF+qU2Ab2T49/DgCHzI2UA3DrsirXHrRpfI2A6oP00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfglRqr6nHmfPkrDowxSZeSOdnkv3k3AdXf+FLnLTDGduuQNsxpb363yuyPJMSBIMmOJKmmM22HxIlqLZqYYCzqA2vVmcx1iraW/Xgl6dW6IRoddk7tFw5AW/eZxQX4+0GMVaZV6edQ6kxyv/qHYlLrNfXM7GFEr9s8PYBm2TZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AgbDvlRB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7273f35b201so1663557a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740245464; x=1740850264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umSaZpJsRTxAjHVQyIPwWd7ZmuYXXC82qLwu4g3KMsU=;
        b=AgbDvlRBajIX5SiHOqJCHGFuoPR5TR+tQmfwTOKEESsbZ8famzV/PrxYQ98MOCoOD/
         YShs9jbYOGEFVwhz8ms3IGlhr6tIHThxkuiWyE0ERtK1eJURMeTnD2m822C730mdQNwa
         pRQuSLnagu98jg7V9/jCIoe3YhF0Y6mHwSNcGLNDWHBUdd5zhdBfiy/RVzW5mWZdUdZR
         CWqvUgIsrF8A799Ryw5ib56hA0xRZmT7vAa5kry8wNzkvyw/nvD2wlwdn1t+GPo4xfXj
         4ahQW8u/etR6xLmHp1DHH2dHS6a/IvT//GLfQJEfgDKwpRNo0ZxhZjwBA1jNlJix5Mcw
         R6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740245464; x=1740850264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umSaZpJsRTxAjHVQyIPwWd7ZmuYXXC82qLwu4g3KMsU=;
        b=cNKsPNff5sYZ8IERRsjjryJkIAs9OHoqpL3ZB/Wz8aEHlW/ZPAsR9lBIhOwc7ootaj
         axLUsYxlj788VWOtI7/It2WZ3tn3nkcZAD5i6dJVR9hM7jGnC+D+aXQGFTSpVEYla97o
         c021TBF28u6siQErUvJNaC843XOT0cOR6oGr1LwFPG8IuhtAGuIF4TeaGteyuLU4vo0I
         Q0Cvf/zD4r0Dw6OoRQIGxOiMCVZ8nfPLMGQJQIXF4ritesE/SF/Fa7Vh1MPMNGMJF27s
         Lu7fyKziL4jKf6O+A/JSjIEj6J+xk5k8d5TKO6oOpOTPoB7XsYIJAZA4I0jHX09Dd0Ey
         LnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwkQFcjstv0mUzV/sPsNQzNaCSHhkMNqAldJ2LLXJggcgFO6DMR1rBDbJzkSduoOXzsNn7d7izpTB81Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfeTl71Kon/4PwxJ/G5ehcgoWzF3VU+UTCELZn6/zQzzynNOnn
	UuL9avLGmZXkkLzmM3aokcqf6soKal5sQwdEx/AYWQip1mFMWS4yxhlVvB1E6FA=
X-Gm-Gg: ASbGnctjp4TFxcJZ8lMq88u0p1WhssZVMYGjv/QEzSIAwH9IsWMTD+NDVpW4JvPPKP7
	BnlWo3cgcB8YacTvGO7GS0fnbvlwZxt9PdLI21ePQrmkEudKui0FyxwkTkz8LzOP6z+Ue1/5omu
	QV+N7F63EDGGX32dEjQEZBp8E5LYQysZQyuxJqa6uPFm3D/VkJmDM/xbR3mrlm7CdZAvaW7EkNq
	2GgYKr9ykVmZxfshUS50TWVo44OTnfcPupmwSi3FP+3KDQIWJ6Xzg1KONow8UV5noZtbhlWOeeC
	cOTWs1juuiLrXONZ/6A7NilJJCUjK7mhUDRfMKD/k827BtYLW1t3jDtC2gzlW3w=
X-Google-Smtp-Source: AGHT+IGXxbWfYhLXPZeHIIm78NNGLMBPXt1gslBwTaTXB0Iczgx0Wa/lUTSQPX5RcLE9fGYxwUKe7w==
X-Received: by 2002:a05:6830:3909:b0:727:2c98:4b15 with SMTP id 46e09a7af769-7274c216ab3mr5979117a34.18.1740245464024;
        Sat, 22 Feb 2025 09:31:04 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72737f96190sm1913719a34.11.2025.02.22.09.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 09:31:03 -0800 (PST)
Message-ID: <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
Date: Sat, 22 Feb 2025 11:31:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ad7380: add support for SPI offload
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 12:03 PM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add support for SPI offload to the ad7380 driver. SPI offload allows
> sampling data at the max sample rate (2MSPS with one SDO line).
> 
> This is developed and tested against the ADI example FPGA design for
> this family of ADCs [1].
> 
> [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

We forgot to also update Documentation/iio/ad7380.rst. We can follow up
with a separate patch later though.

>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad7380.c | 509 +++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 475 insertions(+), 36 deletions(-)
> 

...

>  #define _AD7380_CHANNEL(index, bits, diff, sign, gain) {			\
>  	.type = IIO_VOLTAGE,							\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> @@ -237,48 +335,123 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
>  	.num_event_specs = ARRAY_SIZE(ad7380_events),				\
>  }
>  
> +#define _AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, gain) {		\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                          \
> +		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
> +		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
> +	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |   \
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\

Not sure if this is worth troubling with, but it might make more sense to make
IIO_CHAN_INFO_SAMP_FREQ info_mask_separate instead of info_mask_shared_by_type,
at least in the case of the single-ended chips.

This family of chips does simultaneous conversions so shared_by_type (or shared_by_all)
would typically be the right thing to do here. However, the single-ended versions
of these chips also have a multiplexer, so there are 2 banks of simultaneously
sampled inputs. So the effective sample rate as far as IIO is concerned would
actually be 1/2 of the sampling_frequency attribute value.

Since we have a channel mask restriction where we force all channels in a bank
to be enabled at once, I think it would work to make IIO_CHAN_INFO_SAMP_FREQ
info_mask_separate where the reported sampling frequency is the conversion rate
divided by the number of channels in a bank.

> +	.info_mask_shared_by_type_available =					\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> +	.indexed = 1,                                                           \
> +	.differential = (diff),                                                 \
> +	.channel = (diff) ? (2 * (index)) : (index),                            \
> +	.channel2 = (diff) ? (2 * (index) + 1) : 0,                             \
> +	.scan_index = (index),                                                  \
> +	.has_ext_scan_type = 1,                                                 \
> +	.ext_scan_type = ad7380_scan_type_##bits##_##sign##_offload,            \
> +	.num_ext_scan_type =                                                    \
> +		ARRAY_SIZE(ad7380_scan_type_##bits##_##sign##_offload),		\
> +	.event_spec = ad7380_events,                                            \
> +	.num_event_specs = ARRAY_SIZE(ad7380_events),                           \
> +}
> +

