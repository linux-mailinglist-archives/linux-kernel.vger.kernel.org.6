Return-Path: <linux-kernel+bounces-574259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64708A6E2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AF0168981
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A666266F03;
	Mon, 24 Mar 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YzzueryM"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3793264617
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842470; cv=none; b=C+K8OqsPB72piwZ0Q/RxQVB4ZnfJIwa6z0UJ+k7kAuCMpxmAx9AIihj6T9PEeHansqYkGiJyUL5AIl/nO+kN5LcevBtH5fEfsdItAZYs1HBPrdkDbZJNvNe3N5yxLgieu2NGsrB13KdtwpWbituCa+4SHIiQH5nBgs03dUP0308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842470; c=relaxed/simple;
	bh=bYepHZHGKJdzRa8ajrcVmkzK+TWNwXQ/53joqZg6Ssc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pwSDMit9emQkGpAXwPUgNtZNMGBCL7MEsmS4rq8izXpRbD1ZkdFlofWIF6lm8T+nUHb8vnBaSdkSg+lRL+epYIKJeHvBStnaye88vpSDd16hl7QuxhVuFlY/Iq00P+VhqTYjmCfhllKrcGVRAN235rtEXXT6fsOT+65sYMrbzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YzzueryM; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3fea0363284so2581578b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742842467; x=1743447267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06LT1E1RRNMfucwpIVrPW/y7BeeDpu7TG33qT6wY/6A=;
        b=YzzueryMFRgtaTCjzu4AQRYJG62LvLZm+8Z2RajfkODX3Z28nMmonjtXlDnz5ihGT1
         qCK7StYu27iP5Lrvzvq1CzMfkAKyjYYO44cF/at0imjOdHZ7nUoPPlTWqxuh6aa2QUeX
         W6Cw+/IdbjmZQPw0Jc9FzxLEk8btrnApGtrRkdkAAQ5XQGayaL3siXUE7IjTaHWFsnLk
         XbXscwdJ8QsTnmotjX/J+tGUxNJlxvfZoAXr23fLsucnI9GP6xPMD5bgzB566uT2sfa0
         HKs1mPLUGNXGiaFoyDQaWtyGnIY8QzjiLaV1uUjqzWiKrEUGBAch4hZjBnz+3a8vCeyY
         CNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842467; x=1743447267;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06LT1E1RRNMfucwpIVrPW/y7BeeDpu7TG33qT6wY/6A=;
        b=cEGaGT+aEcujmp5Swz7tREOI0AqYrkVYZTBkg9V/M+rFYAhqcCxvJBs66fZlgrYT+A
         2aWa7xKf/XvI5TrTj63ZdkGby/ySA86dq/zSZyXCVcDwYjddWlSvafW1z0e0Wl2eb8JO
         WMAo8Gcy0Qh0h7lhzt/b8l7CSzVrDawybWx6B92TO4Ki3A5MfQs2cvaceMpgiyl4II1S
         D5SvA0MhfGUiSW6ledQ3ISLUhr2PttUfZBEOmSHodd3Rzr78AH5h+ak7PXCi/gYEsn0S
         YZkmzeUWrpx/sgyYwt0hs+RWUK4sU9XtlZrzIOtt72jsBOGj/Ym6vfaBlXTwvHjEW6CC
         08OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZl8Cc7pdNaGRR/d8Z4QXpxFhbvsFVyk6E8H/2xAQrRWBShXgurA5AtWIkVJRvpELtfQZIFEJstMnUhPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1oc30VAEa8bCRfIaFZ1k9mIIH7ykHystItignuuANaJwEURS
	6QeEsvczLxzZegZgImjpQPf3S5rA87lCiLa7xFUL0+B90+NZq0UWGGHqAEFLwUE=
X-Gm-Gg: ASbGncsFsUKsPI8qMnxvL0vNbcztcqADjRxVKi26Jz1Qrfd4Mb26xQ9zcpPcE28eglU
	MN4W/4qTdpJPvjAtrvvynWlM1MyZ7pj/7K0oIoOJKo3ZT4EPACJ4dFP7Ktji7Umfj1N3SmZMqU1
	784E8gcmV7TlGm0E0tQdTEyVfidKI86128Tz+pbuV52NH/4WPg8BcncWldychs9JG6Gi+AVAKGf
	TR8AFD6GdvFZITbck/+abwqdTJ1KTWNZ9QXNi0ZPZcYv55CdDyYyeWnnArrKD8b+IYIF4PBZ7UL
	DXWrM9jwlWFSJQXK499EUKfN58zJT43LlQgJr+M3u3ZSxWApiQYk3WaVk1ivO6NGmYXnhRJwwBf
	CADvZHQ==
X-Google-Smtp-Source: AGHT+IFyi/1W4BZWJx8USQ1sFUEuL/rB0lIMaIVBqUowj6ohQAXIoie0doJJgSvfsuYqIWjgfs5AJQ==
X-Received: by 2002:a05:6808:9ab:b0:3fa:1d22:6d28 with SMTP id 5614622812f47-3febeeaa67fmr6698335b6e.18.1742842466714;
        Mon, 24 Mar 2025 11:54:26 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6bd0a7sm1682759b6e.2.2025.03.24.11.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:54:26 -0700 (PDT)
Message-ID: <705a307d-32dc-4edc-bb71-0e201859264f@baylibre.com>
Date: Mon, 24 Mar 2025 13:54:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iio: adc: adi-axi-adc: add set decimation rate
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Guillaume Stols <gstols@baylibre.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-3-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250324090813.2775011-3-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/25 4:07 AM, Pop Ioan Daniel wrote:
> Add support for setting decimation rate.
> 
> Add separate compatible string for the custom AD7405 IP and implement
> the necessary changes.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 43 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 766406f45396..0ed609e294ba 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -70,6 +70,9 @@
>  #define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
>  #define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
>  
> +#define ADI_AXI_ADC_REG_CHAN_USR_CTRL_2	0x0424

This is a per-channel register, so expect to have a c parameter times offset
like the other channel registers.

> +#define   ADI_AXI_ADC_DEC_RATE_MASK		GENMASK(15, 0)

Usually, we try to include the register name in these as well even if the name
does get a bit long.

ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK

> +
>  /* IO Delays */
>  #define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
>  #define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
> @@ -232,6 +235,16 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
>  	}
>  }
>  
> +static int axi_adc_set_dec_rate(struct iio_backend *back,
> +				unsigned int rate)

This needs to take a channel index parameter as well to keep it generic.

> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +

Might be helpful for future users if we add a comment explaining why we are
setting the denominator but not the numerator.

> +	return regmap_update_bits(st->regmap, (ADI_AXI_ADC_REG_CHAN_USR_CTRL_2),
> +					      ADI_AXI_ADC_DEC_RATE_MASK,
> +					      FIELD_PREP(ADI_AXI_ADC_DEC_RATE_MASK, rate));
> +}
> +
>  static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, unsigned int chan,
>  				    unsigned int *status)
>  {
> @@ -465,6 +478,28 @@ static const struct iio_backend_info adi_axi_adc_generic = {
>  	.ops = &adi_axi_adc_ops,
>  };
>  
> +static const struct iio_backend_ops adi_ad7405_ops = {
> +	.enable = axi_adc_enable,
> +	.disable = axi_adc_disable,
> +	.data_format_set = axi_adc_data_format_set,
> +	.chan_enable = axi_adc_chan_enable,
> +	.chan_disable = axi_adc_chan_disable,
> +	.request_buffer = axi_adc_request_buffer,
> +	.free_buffer = axi_adc_free_buffer,
> +	.data_sample_trigger = axi_adc_data_sample_trigger,
> +	.iodelay_set = axi_adc_iodelays_set,
> +	.test_pattern_set = axi_adc_test_pattern_set,
> +	.set_dec_rate = axi_adc_set_dec_rate,
> +	.chan_status = axi_adc_chan_status,
> +	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
> +	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> +};

As mentioned in my DT bindings patch reply, it looks like this register is part
of the generic AXI ADC IP block, so we shouldn't need to add a chip-specific
struct in this case.

> +
> +static const struct iio_backend_info axi_ad7405 = {
> +	.name = "axi-ad7405",
> +	.ops = &adi_ad7405_ops,
> +};
> +
>  static int adi_axi_adc_probe(struct platform_device *pdev)
>  {
>  	struct adi_axi_adc_state *st;
> @@ -522,7 +557,7 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	ret = devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generic, st);
> +	ret = devm_iio_backend_register(&pdev->dev, st->info->backend_info, st);

I'm guessing you haven't rebased on the iio tree recently. This line was already
changed in [1].

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/drivers/iio/adc/adi-axi-adc.c?h=testing&id=7a794e3a0dc5b1df525bf72260b641d70e337784

>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "failed to register iio backend\n");
> @@ -575,10 +610,16 @@ static const struct axi_adc_info adc_ad7606 = {
>  	.has_child_nodes = true,
>  };
>  
> +static const struct axi_adc_info adi_axi_ad7405 = {
> +	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
> +	.backend_info = &axi_ad7405,
> +};
> +
>  /* Match table for of_platform binding */
>  static const struct of_device_id adi_axi_adc_of_match[] = {
>  	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
>  	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
> +	{ .compatible = "adi,axi-ad7405", .data = &adi_axi_ad7405},
>  	{ /* end of list */ }
>  };
>  MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);


