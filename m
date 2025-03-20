Return-Path: <linux-kernel+bounces-570360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F30A6AF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923943ADF55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A1E229B1A;
	Thu, 20 Mar 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fzZoDIbD"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D7226CF6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503673; cv=none; b=DLXjOmkl5SYB/BjaLQyAfQg5ANx9BeVQ891ZUnewuh6rQ4sk8W0G/6hPkTv9g0ojLlQM4KeCzwKCsHs7sRn/Wy6rqtmyUQRnGIOzOZeMc6/0YMmPRDvuW4mhsWQICxNXB4Edi1AYBIf6GNPg1qPHjFteh13Ru138icvENhTD89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503673; c=relaxed/simple;
	bh=0pa3qUWShFOIIPn2FAgjh8DEifBri8O2kFVSUQNXO3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLMwKy67BaCZP+9Ognu+mAdv6zqd6UaY2VYOFpHnRt7YWey1l+wkk1oa2TpS0YUJoCHNf3+fQQNX9LRmiTJzDY9CA1pXmnkVfKqBXRnzP09THiBMTc6gE9EpUgIpbcXrXurWOfRZZ1xfibAhGHHUeTiw/dyhaPq3NOtoneYb2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fzZoDIbD; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso1402754fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742503670; x=1743108470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRODcuOcDkwihFlUFXkQPgGgFD8LkIhE+Zo27moyxtw=;
        b=fzZoDIbDNnyp5OmzgFHHrNI8Se/CMkuiHQwoc8kQBsuWbqZ1KACTD8rgYf7sKmf3b5
         TejcQ9KtYeTT+omtWnRukMbZlHus4w6PxoEMTTljzK8wFBz/bnSc035RaH9rY1LE9H9S
         Okf+20wJUGY6HQSB/8kuue/Qwpr3oCPTpkEI530bvgXTwIXWzVu++IsKp8/vROCB2GCb
         odHn8iqqFu6JDSD33G3dho8F+yn9u5ZDzlOtWKJErOpVUCfXYeGNxn05iU2fKDiYzke3
         2aVNWbLfdf0OqxnzWi49ZnHujgOA7POPhJAczdtSyz2uDa1aLRka2/nVT54ZjgO2gteg
         RQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503670; x=1743108470;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRODcuOcDkwihFlUFXkQPgGgFD8LkIhE+Zo27moyxtw=;
        b=GSfcz29IO1aFq3uG+q1RPeJ3VH01EexDtiXdSjWYUtoS2PjQAaWjTz4e4ZBdZJwpXS
         xoECD3V1bqk1g7icJk0grxTMw5WAXvR26vjcNQV67oAQOO2ItGqyd1np+Dj8XDU6J1+v
         lpWdL+EHQ38ijB9QOPodA3tbOIVKyUsYxotb3i20RJOIrVEuOyPIcAoMU+4/QUn0kvbr
         8efgNQWok+yJNM4z8FKHLj8Lsut4UTRcVhWMI89NFmcuIZsyFsbM7UcBiCJJ/403Ka7F
         d3H5TmkiUssjeyXhPaa6gq4EOrmC9nPXGstI5J4wkrWrqk4tcVFq5i3BsCazh5xA1yh0
         /2dg==
X-Forwarded-Encrypted: i=1; AJvYcCW30w5lC1Bxf0dqwg/4Te49CCPIDYWUxNjn9u7foVbxLIq3IHduYhZf+viCB8DNFl8gbci4fIW/IUtCWFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwaSoSeIVWJQPwFUhOfk0loBD6RoGDa19IF5nomS+/CGYyZkF
	Ew6u4eGhFKKQBJSp31iyK6+HWQGhhYI3YLh6bJcgIltvhIUYqfPxK/uWJoaYcjQ=
X-Gm-Gg: ASbGncuEd/sUZkugn7/3vlgBGiI1BAz4isQ/E0JgETg70YegaocEsHqgJuGNPp7Q7cS
	vnUhACP3bH4IZq6rEYS9UDNN4s2wpN9f0C8UXc7bBCpZMuk8fN/sZyA57Z4RLtgZ7QZsCtyOuqw
	6avfRAdOPBiAaXTosPtNLnEJEKjKZVMVfaYFoSxTpbFJKa0L2N8RWkjNNe8LCVXXIZ1o2kJYOv2
	3ZEWW4JVClsruoBYZnSsemgQR0rlY+Oek2MnshwHHxK3yylOoHskY/TeWXyRlGSETBW8i+JesFw
	0adPoJxEHIds5Pa77OINBjPkFd/x1GKakzjIcuH3JwLd1Q//36/vOH3Obt9b5DZMdVMAWYIwYlA
	j8zZG6w==
X-Google-Smtp-Source: AGHT+IH4NtaMc4tQn6nQExXu/1Co8ni5D/0wn0TjJ2tIKq6Deh6SloJkSffIrdbR3zy2Derlk/MTaw==
X-Received: by 2002:a05:6870:4f03:b0:2c2:5f8c:4630 with SMTP id 586e51a60fabf-2c77fe22fd3mr748912fac.0.1742503669680;
        Thu, 20 Mar 2025 13:47:49 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f05ec85sm132955fac.32.2025.03.20.13.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:47:48 -0700 (PDT)
Message-ID: <c449fff5-ef23-4094-8306-0a6b27a22c1c@baylibre.com>
Date: Thu, 20 Mar 2025 15:47:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: ad4000: Add support for SPI offload
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <84843837a2acab58f8853152ecaa67c79b9a9666.1742394806.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <84843837a2acab58f8853152ecaa67c79b9a9666.1742394806.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
> FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
> The PWM IP is used to trigger SPI-Engine offload modules that in turn set
> SPI-Engine to execute transfers to poll data from the ADC. That allows data
> to be read at the maximum sample rates. Also, it is possible to set a
> specific sample rate by setting the proper PWM duty cycle and related state
> parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
> trigger) is used in combination with SPI-Engine.
> 
> Add support for SPI offload.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

I'm surprised I'm not on the CC for this series. scripts/get_maintainer.pl should
have picked me up due to K: spi_offload which matches this patch.

> Instead of changing bits_per_word according to buffer endianness, I set
> bits_per_word for other SPI transfers and updated IIO channels to always use CPU
> endianness (the first patch in the series). With that, bits_per_word no longer
> needs be updated according to buffer endianness or, in other words, buffer
> endianness is no longer related to bits_per_word.

As mentioned in my reply to the previous patch, this is a breaking change, so
probably not the best choice.

> 
>  drivers/iio/adc/Kconfig  |   7 +-
>  drivers/iio/adc/ad4000.c | 491 ++++++++++++++++++++++++++++++++-------
>  2 files changed, 419 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index b7ae6e0ae0df..1cfa3a32f3a7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -25,10 +25,15 @@ config AD4000
>  	tristate "Analog Devices AD4000 ADC Driver"
>  	depends on SPI
>  	select IIO_BUFFER
> +	select IIO_BUFFER_DMAENGINE
>  	select IIO_TRIGGERED_BUFFER
> +	select SPI_OFFLOAD
>  	help
>  	  Say yes here to build support for Analog Devices AD4000 high speed
> -	  SPI analog to digital converters (ADC).
> +	  SPI analog to digital converters (ADC). If intended to use with
> +	  SPI offloading support, it is recommended to enable
> +	  CONFIG_SPI_AXI_SPI_ENGINE, CONFIG_PWM_AXI_PWMGEN, and
> +	  CONFIG_SPI_OFFLOAD_TRIGGER_PWM.

I guess this is fine here, but people might be more likely to see it on the
ADI wiki where the HDL project that has these requirements is described.

>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4000.
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 19bc021e1b5d..b3f4d215cad4 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -21,9 +21,12 @@
>  #include <linux/iio/iio.h>
>  
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> +#include <linux/spi/offload/consumer.h>

Why not before #include <linux/spi/spi.h> ?

> +
>  #define AD4000_READ_COMMAND	0x54
>  #define AD4000_WRITE_COMMAND	0x14
>  
> @@ -32,10 +35,15 @@
>  /* AD4000 Configuration Register programmable bits */
>  #define AD4000_CFG_SPAN_COMP		BIT(3) /* Input span compression  */
>  #define AD4000_CFG_HIGHZ		BIT(2) /* High impedance mode  */
> +#define AD4000_CFG_TURBO		BIT(1) /* Turbo mode */
>  
>  #define AD4000_SCALE_OPTIONS		2
>  
> -#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)	\
> +#define AD4000_TQUIET1_NS		190
> +#define AD4000_TQUIET2_NS		60
> +#define AD4000_TCONV_NS			320

Does this actually work for every single chip? For example, the AD7983 datasheet
give the max as 500 ns for this timing parameter. Might need to put this in the
chip_info to account for differences.

Also AD7983 doesn't have any quite time in the datasheet, so those might not be
needed in some cases?

> +
> +#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access, _offl)\
>  {										\
>  	.type = IIO_VOLTAGE,							\
>  	.indexed = 1,								\
> @@ -43,8 +51,9 @@
>  	.channel = 0,								\
>  	.channel2 = 1,								\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> -			      BIT(IIO_CHAN_INFO_SCALE),				\
> -	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> +			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
> +	.info_mask_separate_available = (_reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0),\
>  	.scan_index = 0,							\
>  	.scan_type = {								\
>  		.sign = _sign,							\
> @@ -54,25 +63,28 @@
>  	},									\
>  }
>  
> -#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access)			\
> +#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl)		\
>  	__AD4000_DIFF_CHANNEL((_sign), (_real_bits),				\
> -				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
> +			      (((_offl) || ((_real_bits) > 16)) ? 32 : 16),	\
> +			      (_reg_access), (_offl))
>  
> -#define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access)			\
> +#define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access, _offl)		\

We always pass 0 to _offl here, so we can leave out this parameter and just
hard-code the 0 below. We will never have a case with offload + soft timestamp.

>  {										\
> -	AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access),			\
> +	AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl),		\
>  	IIO_CHAN_SOFT_TIMESTAMP(1),						\
>  }
>  
> -#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)\
> +#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits,		\
> +				     _reg_access, _offl)			\
>  {										\
>  	.type = IIO_VOLTAGE,							\
>  	.indexed = 1,								\
>  	.channel = 0,								\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
>  			      BIT(IIO_CHAN_INFO_SCALE) |			\
> -			      BIT(IIO_CHAN_INFO_OFFSET),			\
> -	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
> +			      BIT(IIO_CHAN_INFO_OFFSET) |			\
> +			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
> +	.info_mask_separate_available = (_reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0),\

Unrelated change (adding braces)?

Also, could be nice to have sampling_frequency_available so that userspace can
discover the max sample rate.

>  	.scan_index = 0,							\
>  	.scan_type = {								\
>  		.sign = _sign,							\
> @@ -82,13 +94,14 @@
>  	},									\
>  }
>  
> -#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access)		\
> +#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl)	\
>  	__AD4000_PSEUDO_DIFF_CHANNEL((_sign), (_real_bits),			\
> -				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
> +				     (((_offl) || ((_real_bits) > 16)) ? 32 : 16),\
> +				     (_reg_access), (_offl))
>  
> -#define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access)		\
> +#define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access, _offl)	\

ditto about hard-coding _offl here

>  {										\
> -	AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access),		\
> +	AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl),	\
>  	IIO_CHAN_SOFT_TIMESTAMP(1),						\
>  }

...

>  static const struct ad4000_chip_info ad7983_chip_info = {
>  	.dev_name = "ad7983",
> -	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
> +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
> +	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
>  	.time_spec = &ad7983_t_spec,
> +	.max_rate_hz = 1330 * KILO,

This is actually 752 ns period when 750 is allowed. Could make it 1 * MEGA + 333
* KILO + 333 or 1333333.

>  };
>  
>  static const struct ad4000_chip_info ad7984_chip_info = {
>  	.dev_name = "ad7984",
> -	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
> +	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
> +	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
>  	.time_spec = &ad7983_t_spec,
> +	.max_rate_hz = 1330 * KILO,

ditto

>  };
>  

...

> +static int ad4000_offload_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad4000_offload_buffer_setup_ops = {
> +	.postenable = &ad4000_offload_buffer_postenable,
> +	.postdisable = &ad4000_offload_buffer_postdisable,

Needs to be predisable to correctly balance postenable.

> +};
> +
> +static int ad4000_spi_offload_setup(struct iio_dev *indio_dev,
> +				    struct ad4000_state *st)
> +{
> +	struct spi_device *spi = st->spi;
> +	struct device *dev = &spi->dev;
> +	struct dma_chan *rx_dma;
> +	int ret;
> +
> +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> +							   SPI_OFFLOAD_TRIGGER_PERIODIC);
> +	if (IS_ERR(st->offload_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> +				     "Failed to get offload trigger\n");
> +
> +	ret = ad4000_set_sampling_freq(st, st->max_rate_hz);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to set sampling frequency\n");
> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "Failed to get offload RX DMA\n");
> +
> +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> +							  IIO_BUFFER_DIRECTION_IN);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup DMA buffer\n");
> +
> +	return 0;
> +}
> +
> +/*
> + * This executes a data sample transfer when using SPI offloading for when the
> + * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
> + * tree property is absent. In this connection mode, the ADC SDI pin is
> + * connected to MOSI or to VIO and ADC CNV pin is connected to a SPI controller
> + * CS (it can't be connected to a GPIO).
> + *
> + * In order to achieve the maximum sample rate, we only do one transfer per
> + * SPI offload trigger. Because the ADC output has a one sample latency (delay)
> + * when the device is wired in "3-wire" mode and only one transfer per sample is
> + * being made in turbo mode, the first data sample is not valid because it
> + * contains the output of an earlier conversion result. We also set transfer
> + * `bits_per_word` to achieve higher throughput by using the minimum number of
> + * SCLK cycles. Also, a delay is added to make sure we meet the minimum quiet
> + * time before releasing the CS line. Plus the CS change delay is set to ensure
> + * that we meet the minimum quiet time before asserting CS again.
> + *
> + * This timing is only valid if turbo mode is enabled (reading during conversion).
> + */
> +static int ad4000_prepare_offload_turbo_message(struct ad4000_state *st,
> +						const struct iio_chan_spec *chan)
> +{
> +	struct spi_transfer *xfers = st->offload_xfers;
> +
> +	/* Have to do a short CS toggle to trigger conversion. */
> +	xfers[0].cs_change = 1;
> +	xfers[0].cs_change_delay.value = AD4000_TQUIET1_NS;
> +	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +	xfers[0].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;

There is no data transferred in this xfer, so we don't need to set this flag.

> +
> +	xfers[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	xfers[1].bits_per_word = chan->scan_type.realbits;
> +	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
> +	xfers[1].delay.value = AD4000_TQUIET2_NS;
> +	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +	spi_message_init_with_transfers(&st->offload_msg, xfers, 2);
> +	st->offload_msg.offload = st->offload;
> +
> +	return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->offload_msg);
> +}
> +

...

> @@ -804,19 +1125,39 @@ static int ad4000_probe(struct spi_device *spi)
>  
>  		break;
>  	case AD4000_SDI_VIO:
> -		indio_dev->info = &ad4000_info;
> -		indio_dev->channels = chip->chan_spec;
> +		if (st->using_offload) {
> +			indio_dev->info = &ad4000_offload_info;
> +			indio_dev->channels = &chip->offload_chan_spec;
> +			indio_dev->num_channels = 1;
> +
> +			spi->cs_hold.value = AD4000_TCONV_NS;
> +			spi->cs_hold.unit = SPI_DELAY_UNIT_NSECS;

Modifying spi is suspicious. Normally, this would come from the devicetree. And
this isn't used by all SPI drivers - notably the AXI SPI Engine ignores it.
Better to just handle this in individual spi xfer structs.

> +			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to optimize SPI msg\n");
> +		} else {
> +			indio_dev->info = &ad4000_info;
> +			indio_dev->channels = chip->chan_spec;
> +			indio_dev->num_channels = ARRAY_SIZE(chip->chan_spec);
> +		}

nit: add extra blank line here

>  		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret,
> +					     "Failed to optimize SPI msg\n");
>  
>  		break;


