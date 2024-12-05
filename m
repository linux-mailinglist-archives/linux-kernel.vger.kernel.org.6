Return-Path: <linux-kernel+bounces-432456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2DA9E4B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C854188146B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA4C11712;
	Thu,  5 Dec 2024 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dwkRN8WO"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9D14286
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359551; cv=none; b=OxA3WSOmAj5iwGnuAvf3T4COnJpwLIF3XPhFOuw9imporl6dXNIcrXYsnzzqkw8l/wlDhKxvjVhVJ6FeDd8VxH2IHGrhE3JEQSJ1VWI5zsxi3aoo+DCR1AciTM+DDFqyzCAbMDTYbo60mRNrUoyCvMkOHKYIPCmE2yQIrEJgBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359551; c=relaxed/simple;
	bh=hh9oWDDCxLyIXLy7Qnybet3RgFDYgoQ9qpT3Bn5+yoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IwkUozDm6pYSFFS2k4CdtZ57SLXZoGIRCbsZISzfMNcLlXL/qvThzx10p1TtpyD3OHNDbYT22EkxOgmIt9ju+6lCQp06dNXHH0uEcr3CnsQL/deU4BuyUnz/uktSsBjKS4zOBHgpG/xzpFvcbAX0CO2oWvthR67ZaxkQ/CJrskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dwkRN8WO; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f1d1068451so123930eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 16:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733359548; x=1733964348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/FCnLqIV3c5gFZZKyUvcvdxacahbxrJaclywz0evSE=;
        b=dwkRN8WOtrZ6ilLs5fgPrmw9fFXxP5OqwFrp51hfwkCFKP+QZ2ioPLNVCAyAbZjgiE
         gmrFc4MPDtZVE10jsKgD+hfEXAlwcri6KSuEgUqBE190JFzPTjpqn+pjhbbOQJ+C0mMI
         0h1BP+jRBzWh4kyUhIiWiA53tECYsCKVYgbqzYlEx1YDPPPudwAppn7VAKF/ZEWprbtB
         wKO+JIKcHufjmwP3akcM1+G8aNZ9Hm/5BmOQko6vQTe7YvoprzRuHy3fUv0Wh2DiVO2d
         PpsaUXqwJbXHvsVNTr081NRM5PhGemBX4avw+Drbww3TCkV8HNuNKYTBPwdSHgVas2tJ
         2kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359548; x=1733964348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/FCnLqIV3c5gFZZKyUvcvdxacahbxrJaclywz0evSE=;
        b=g/ZTvWCZVAhV8t7pvzd46lftkwVvKcTGHg68L4qHyp93uOp824iK5441ZSo20olFE9
         aVv/SV++klAG+f4EcDSr1vwIeP+2MgKLDOLQywDzYwxrhCUMIKJ4TTQM+tCp8GLGUuJo
         2lGhzB8qsHWwuvGHNKygkj+rWRWxGCnvbV8zJpBqr/HMjhpNEUgF1hoqHy8H7A/+J8gs
         rQFwKnvlx0SJX2Fjawz5pRobYWvOE0Zvu9dODm8qSQFn2TiGBzdsDduPUUNUscKxEz8b
         NPt0ey2j0FD1++5FnwMAmCSw2sS049C17jsUacPeyGuTR5oyJh01OqTqMYmuvUoCViBL
         rDzA==
X-Forwarded-Encrypted: i=1; AJvYcCUS8FKf0AejR/Em/8o8tjwBQa0cwiKz6McVE9P1Ng1fjXOT7DpeA71tgIZG/TM2ChCBpzzySujdVeJIRRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0q8OrHlDvGlrvbYxLN24iPo53lyNY82aLMmN5n5/6r4tmJ8Hp
	uHJ1/ngWYENEXllaN6X9ijCrlGT7nWX+w42dKJqdLCQ5sdo7dD7BOmBZYajZXNg=
X-Gm-Gg: ASbGncvAeds2QzBFx8QqCVA0WWE7uKsBz5XKYyiWluDUiwzdy7G1TFxI5Gi5fg+yQr+
	tXfIsfHSr9jK5azOW4lcbHB2AChPW3USK5D7lrIMVP1wQB/pAIhK4kIWoJtliQQxumBob4Imw4i
	1KcC/DwlC/FvjQE3sf6urA17MxYFFXRTi5ZJblOavQv1F70QcODzwnFl0jJYsdRekiJkqvEkl/E
	cgfPa6nIL+0W2X0655XjZ3vP2P8SzIXgoW/pjf41+CaKDD2tdbnFjrqqRWO9RnRtvHhfanWJTiW
	h0OxlnNoE6A=
X-Google-Smtp-Source: AGHT+IE2VVhobAGnHQ8sMunIePFtPqs/USgm18njX/jVJTnFj9axuZeVGzdkL1iM057JakoPHKuEiQ==
X-Received: by 2002:a05:6820:50c:b0:5ee:d89f:1d2c with SMTP id 006d021491bc7-5f25ad40e71mr6699009eaf.1.1733359547906;
        Wed, 04 Dec 2024 16:45:47 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f279235511sm110807eaf.18.2024.12.04.16.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 16:45:46 -0800 (PST)
Message-ID: <7caec777-e234-4bd7-872f-4a5d5dd32fc0@baylibre.com>
Date: Wed, 4 Dec 2024 18:45:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] iio: adc: adi-axi-adc: set data format
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-6-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241129153546.63584-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:35 AM, Antoniu Miclaus wrote:
> Add support for selecting the data format within the AXI ADC ip.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v7:
>  - add back 16-bit case
>  drivers/iio/adc/adi-axi-adc.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index f6475bc93796..cb3b8299a65e 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -45,6 +45,12 @@
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define   AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK	GENMASK(1, 0)
> +#define   AD485X_PACKET_FORMAT_20BIT		0x0
> +#define   AD485X_PACKET_FORMAT_24BIT		0x1
> +#define   AD485X_PACKET_FORMAT_32BIT		0x2
> +
>  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
>  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
>  
> @@ -312,6 +318,30 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
>  	return 0;
>  }
>  
> +static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	unsigned int val;
> +
> +	switch (size) {

This could use some explanation that there are two different variants of the
AXI AD485X IP block, a 16-bit and a 20-bit variant. So 0x0 (AD485X_PACKET_FORMAT_20BIT)
is really 16-bit on the 16-bit variant of the IP block.

> +	case 16:
> +	case 20:
> +		val = AD485X_PACKET_FORMAT_20BIT;
> +		break;
> +	case 24:
> +		val = AD485X_PACKET_FORMAT_24BIT;
> +		break;
> +	case 32:
> +		val = AD485X_PACKET_FORMAT_32BIT;

AFAICT, technically 0x2 (AD485X_PACKET_FORMAT_32BIT) is not valid on
the 16-bit variant of the IP block, so we should explain why it is
safe to allow this instead of returning error in that case.

Or we could solve both issues by just create two separate functions.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				  AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK, val);

To be consistent, would be nice to use FIELD_PREP() with val.

> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -360,6 +390,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
> +	.data_size_set = axi_adc_data_size_set,

As mentioned before, this callback is specifically for the AXI AD485X version
of the IP block and doesn't apply to the generic base AXI ADC IP block.

[1] and [2] are adding DT compatible and lookup table to handle a different
AXI ADC variant. So we could build on top of that to add the variants for
AXI AD485X. We could add two compatible strings, one for the 16-bit version
and one for the 20-bit version which would allow us to have separate callback
functions as suggested above.

[1]: https://lore.kernel.org/linux-iio/20241121-ad7606_add_iio_backend_software_mode-v1-2-8a693a5e3fa9@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/20241121-ad7606_add_iio_backend_software_mode-v1-6-8a693a5e3fa9@baylibre.com/

>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


