Return-Path: <linux-kernel+bounces-364750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696ED99D8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0128B220FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB021D1318;
	Mon, 14 Oct 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="feGxgYTx"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549231D0B9B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940488; cv=none; b=UtvcpKDY9nYKftju0OZArafVYjr4b02CeunPrEQ8nY4QntQ48sf9RrPLkhWht4yqqD/tn49QdRAZFgAQ2FSVWwl1diGQnNekZ/QVgmyugyjWgvAfW5kOfaoM/gFMmcLDr3uXsINvN5EztFv7WDRe1coVzCVP1IEBHZPkLkSYjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940488; c=relaxed/simple;
	bh=nAFlkhcRNHKHuaE+HUU7BIj7CjmDG4Q9GvLHO3xcYGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgJ56tYWgEh4tHQUyorebzwDxbIGuLw+K/C9WQ+s1a6EK/MOD5KPvXTIOIz9/dzfrARO1O6+8lmbg8/qq05CDkbdE7aL8iWdSHThNwCpO3orBBJ767Hs/5SreLYj6Sz5LMPwLjyTHwRmtowtrIyoYLL09gFpJWf0F9R1HzzQEZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=feGxgYTx; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e4d6abb743so2604773b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728940485; x=1729545285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ae6cc/rEu7MTh5Go6Mji5YMOFkTKznRBN2CVBXl0w0=;
        b=feGxgYTx3uu384NqkGC9yoyG7h7KjHm5xYH2H9Nx5M2FtEyJ6eDlq8pgaiZLGCTI6I
         zmz4MytEzZ/Bv2h3ECghOg6kX25JqZ2XHitxVw7zLfiFzcRs0lLM2KwYjAdkd+dc0Mz4
         V1K/TxVoFacs67xCmSchqDfi/wwFkTjrJWR2wb7nIEycXteyAoYDLX3Yw8eZE2KFyrKp
         WtMtqv3TIF9xb7rYxGM6knYqsivqhsVnOWTYz/wJtkgFrS4R64suuLadvNRlEfbSzQ6o
         srAmT1jnVQ9np3lx5A7GvbTB9J4fQPfkN4u5fZoZBw6we4V02dEl2qDXnLs7eUQrviZv
         D1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940485; x=1729545285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ae6cc/rEu7MTh5Go6Mji5YMOFkTKznRBN2CVBXl0w0=;
        b=mfPTBGo7A4DiAp9bJtbsW9SIpMKms47ml4dYIPpbEzVWN9fPU3zvMjBkHPHFo5/Kes
         T4CVod8obOoMIvQwx0lTyQse10uZK37Fw6KSRr7lFjjVn1QjHAxypAIJpfRRl6A/DK0j
         jTI9JApNTIdpmF/cHeYKR9gSP4q9L3+kEsZnwRnCevds2XYoa5ubiXvpt60p+NA4KF3Y
         7E6dcH17fAzvvaVIlJ3RP/HjpZneyv3UaLydm5QxXuDNupgx0NmhB28zRDQIWm0IxAAy
         ttmFM1PlsB/TQF83JXeA6s8BKCvb4ztPZrFzLdQYOi096FZH3QN3XgCqb1OSQ/kr/S23
         waOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6S1XTDj6bsj0c2tNl6R/vwxQO1XpDZ5pa2OvblLGrk97jt/v/OCRJA41sCxkKAiEnWDEYrnhfi6vcW/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31P7ZJ4hHADZEtr/SpSCE0xUlQ7uw/1CRF/bO3PakAvijt9Tb
	AD8YuZVPpLWcV0ZEbjhkREmcIqo7cFBLDYzJBbaER/FcN62TbDIIQOPhoWCYx5w=
X-Google-Smtp-Source: AGHT+IFuC9H1+XXsY76DwCrYv4lf/aU/+7qcxx5rK85iXsvs6ntFlwhM3N3IXgq1nrn73MMdII/pBA==
X-Received: by 2002:a05:6808:179a:b0:3e5:dfc9:535 with SMTP id 5614622812f47-3e5dfc907ecmr3429616b6e.40.1728940485322;
        Mon, 14 Oct 2024 14:14:45 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e50a29ad61sm2178576b6e.2.2024.10.14.14.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 14:14:43 -0700 (PDT)
Message-ID: <161aa7f4-299d-4486-92ad-3f3eab2f2979@baylibre.com>
Date: Mon, 14 Oct 2024 16:14:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] iio: dac: ad3552r: changes to use FIELD_PREP
To: Angelo Dureghello <adureghello@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-5-eeef0c1e0e56@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-5-eeef0c1e0e56@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
> is removed. Variables (arrays) that was used to call ad3552r_field_prep
> are removed too.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Found one likely bug. The rest are suggestions to keep the static
analyzers happy.

				\
> @@ -510,8 +416,14 @@ static int ad3552r_write_raw(struct iio_dev *indio_dev,
>  					val);
>  		break;
>  	case IIO_CHAN_INFO_ENABLE:
> -		err = ad3552r_set_ch_value(dac, AD3552R_CH_DAC_POWERDOWN,
> -					   chan->channel, !val);
> +		if (chan->channel == 0)
> +			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(0), !val);
> +		else
> +			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(1), !val);

In the past, I've had bots (Sparse, IIRC) complain about using !val
with FIELD_PREP. Alternative is to write it as val ? 1 : 0.

> +
> +		err = ad3552r_update_reg_field(dac, AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> +					       AD3552R_MASK_CH_DAC_POWERDOWN(chan->channel),
> +					       val);
>  		break;
>  	default:
>  		err = -EINVAL;
> @@ -715,9 +627,9 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
>  	}
>  
>  	return ad3552r_update_reg_field(dac,
> -					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
> -					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
> -					val);
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> +					AD3552R_MASK_ADDR_ASCENSION,
> +					FIELD_PREP(AD3552R_MASK_ADDR_ASCENSION, val));
>  }
>  
>  static void ad3552r_get_custom_range(struct ad3552r_desc *dac, s32 i, s32 *v_min,
> @@ -812,20 +724,20 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
>  				     "mandatory custom-output-range-config property missing\n");
>  
>  	dac->ch_data[ch].range_override = 1;
> -	reg |= ad3552r_field_prep(1, AD3552R_MASK_CH_RANGE_OVERRIDE);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
>  
>  	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
>  	if (err)
>  		return dev_err_probe(dev, err,
>  				     "mandatory adi,gain-scaling-p property missing\n");
> -	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_P);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, val);
>  	dac->ch_data[ch].p = val;
>  
>  	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
>  	if (err)
>  		return dev_err_probe(dev, err,
>  				     "mandatory adi,gain-scaling-n property missing\n");
> -	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_N);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, val);
>  	dac->ch_data[ch].n = val;
>  
>  	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
> @@ -841,9 +753,9 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
>  	dac->ch_data[ch].gain_offset = val;
>  
>  	offset = abs((s32)val);
> -	reg |= ad3552r_field_prep((offset >> 8), AD3552R_MASK_CH_OFFSET_BIT_8);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, (offset >> 8));

Can drop () from (offset >> 8).

>  
> -	reg |= ad3552r_field_prep((s32)val < 0, AD3552R_MASK_CH_OFFSET_POLARITY);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)val < 0);

Instead of (s32) cast, could write val < 0 : 1 : 0 (to be consistent with
suggestion above for replacing !val).

>  	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
>  	err = ad3552r_write_reg(dac, addr,
>  				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
> @@ -886,9 +798,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
>  	}
>  
>  	err = ad3552r_update_reg_field(dac,
> -				       addr_mask_map[AD3552R_VREF_SELECT][0],
> -				       addr_mask_map[AD3552R_VREF_SELECT][1],
> -				       val);
> +				       AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				       AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> +				       FIELD_PREP(AD3552R_MASK_REFERENCE_VOLTAGE_SEL, val));
>  	if (err)
>  		return err;
>  
> @@ -900,9 +812,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
>  		}
>  
>  		err = ad3552r_update_reg_field(dac,
> -					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][0],
> -					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][1],
> -					       val);
> +					       AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					       AD3552R_MASK_SDO_DRIVE_STRENGTH,
> +					       FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, val));
>  		if (err)
>  			return err;
>  	}
> @@ -938,9 +850,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
>  						     "Invalid adi,output-range-microvolt value\n");
>  
>  			val = err;
> -			err = ad3552r_set_ch_value(dac,
> -						   AD3552R_CH_OUTPUT_RANGE_SEL,
> -						   ch, val);
> +			if (ch == 0)
> +				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), val);
> +			else
> +				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1), val);
> +
> +			err = ad3552r_update_reg_field(dac,
> +						       AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> +						       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
> +						       val);
>  			if (err)
>  				return err;
>  
> @@ -958,7 +876,14 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
>  		ad3552r_calc_gain_and_offset(dac, ch);
>  		dac->enabled_ch |= BIT(ch);
>  
> -		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
> +		if (ch == 0)
> +			val = FIELD_PREP(AD3552R_MASK_CH(0), 1);
> +		else
> +			val = FIELD_PREP(AD3552R_MASK_CH(1), 1);
> +
> +		err = ad3552r_update_reg_field(dac,
> +					       AD3552R_REG_ADDR_CH_SELECT_16B,
> +					       AD3552R_MASK_CH(ch), val);
>  		if (err < 0)
>  			return err;
>  
> @@ -970,8 +895,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
>  	/* Disable unused channels */
>  	for_each_clear_bit(ch, &dac->enabled_ch,
>  			   dac->model_data->num_hw_channels) {
> -		err = ad3552r_set_ch_value(dac, AD3552R_CH_AMPLIFIER_POWERDOWN,
> -					   ch, 1);
> +		if (ch == 0)
> +			val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), 1);
> +		else
> +			val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1), 1);

Should these be AD3552R_MASK_CH_AMPLIFIER_POWERDOWN instead of
AD3552R_MASK_CH_OUTPUT_RANGE_SEL? (2 above and 1 below.)

> +
> +		err = ad3552r_update_reg_field(dac,
> +					       AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> +					       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
> +					       val);
>  		if (err)
>  			return err;
>  	}
> 


