Return-Path: <linux-kernel+bounces-430811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E3A9E35E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB07A287B86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ADC198E84;
	Wed,  4 Dec 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mapWc9ew"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE3198848
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302210; cv=none; b=pQ8BhkW6SJiYbFZQuMwwWFRTYIj8Z27FG3fiGXIp0KTjICoq1IQXwbh6zovntFMO1q973CMqvQvXti1sylEuoMt767vmshes7iMto44qAMAwOFB43dLZFyP2otdBbgbVb2V4cVWr+tf224YIQa/AwZ4+H7YMEgaTxTSC1lYB548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302210; c=relaxed/simple;
	bh=SKbPOKp8EmEZzoWIWsE7IwT5qwKdLVo+LROCnTyZjbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALNAyedKkaMVLOkv982CiBTqccah9LFs9TfTBnkCgVQmkHe20/3sQ8Fmp0zoaJb1v0BmNpN9KG2c0TIjES9swp89DoaLe9qZW629x8TAXpFE3JcL6VSbolP29bzseiCtQJuKSwh+nwK65qf4WLiO/2synnGRvjxwdy7mUS5UbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mapWc9ew; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a099ba95so58858315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733302206; x=1733907006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kX/PdWrycYoLN9w/gftabjVrrnBJFYg9A4mS6DbMIag=;
        b=mapWc9ewi5JeMYlI9k9igzEbEMTg7RZ3PSBcLYVp5Zw0zsvmuPjdeQ1+GBgd1dTnM3
         LmVMIkusahLlK2LC9hf8hURugxEV9DdwUsx5QFfybldduxxhl3eZW35+UZ/G0aWbQze9
         v0pKnJwceFnl3n+HCGtWf/2Lfh8umMPh7r8VUMQuEmXtFhn3zxe8SIVu2G1N1ydzrk0A
         zhS4Cbbx69kFm2YEJJo6Eiack/uVHiyGnsH///zzVp5cAq0k41BxadFwtpswdgLy0eC+
         nD5KokG+/tgnoAiUrGk+v4+SurbnxO3menGShwGI24ibbJznQu3dMxMTw5FwabXNfuK7
         i/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733302206; x=1733907006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kX/PdWrycYoLN9w/gftabjVrrnBJFYg9A4mS6DbMIag=;
        b=XJVePvOFTXgfuHf5Hq6mi87As8ez99fh3KbjlKMjnO9ITGh7vrc3G6+lZyoqqAKrl9
         I/jJiIlIyvY/3eGBpNVyK1LO1J4XNrQwlclMILXQ8FR5MidoZ2qAO7Z2isEkwwyT6QBe
         o57Jf273H6wQeaXuqJNdnzDsBNewZjiN1PvyGraj722o/HWb2JEx34aKhj6i/YlbYirH
         n8MsAvgeEKvRcfrUNS4piycB7Uty+Pagzyqd5HHdYHT9GFMfqsCl6bNRhn81szQRSH1A
         OR3wi7gOYpXq/J4vIll2+peo8NZ9N1iCqvJc76kzGNusUP4v7TmLYurbWlBFQE3HX2un
         TPlA==
X-Forwarded-Encrypted: i=1; AJvYcCULMCn7Rzxov5zRICq0DBvaJkqgHjwO5Q/BgSvtSqKfHSc89WF0cMG5NbrReT02YNLdpk45Lq/eUcdfgWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1QmShWPbpJH9FgIz/DwVkraz2cn1nKRHIEbtPrAi4MlZKFbk
	4n6hbe1c0WfMTSx/EjFb9YUBQsi6rJU0RDEe4yP6QEDt1p7bIRBGcl4oQAKyVic=
X-Gm-Gg: ASbGncsIa2Frb4VUfBeHF2yx+kQVlRZqQyomyr+JS2utBTnSwmL1HcEg/bRGkHTrGrw
	Ing7LLMhUJA6zZJMt0u2sHwQEOX6vT1mujYR2y5/Vf+HBA8NlPDlg187/pVCcXGbGVliGcp52LD
	uB5giUJEr1vaBUMz2G7rv+PBHmJ/Lq5sbZSMbzpQTdokTMOiOGgLmriAKh6S/DFGoPyCrWRrUc2
	fhqcV+TnJbKlLkkgWZSWOrupOmMXoLR+bAKXw6ewVi1HKtc9JCctfwc3/w=
X-Google-Smtp-Source: AGHT+IGbtU/rD+eIsFIVhtu10NokIMY21idDwmyfqhDLr7nu+tQXuHISi1JSEe4tGoyx24spnbSvMg==
X-Received: by 2002:a05:600c:1ca2:b0:434:ba13:e52b with SMTP id 5b1f17b1804b1-434d0a14a83mr53170425e9.31.1733302205966;
        Wed, 04 Dec 2024 00:50:05 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5272f99sm16732325e9.11.2024.12.04.00.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:50:05 -0800 (PST)
Message-ID: <0e5bafb1-fbf9-4168-bbe4-1feaaa6f812b@tuxon.dev>
Date: Wed, 4 Dec 2024 10:50:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] iio: adc: rzg2l_adc: Add support for channel 8
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-10-claudiu.beznea.uj@bp.renesas.com>
 <20241203201857.7ccdcf99@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241203201857.7ccdcf99@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan,

On 03.12.2024 22:18, Jonathan Cameron wrote:
> On Tue,  3 Dec 2024 13:13:09 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The ADC on the Renesas RZ/G3S SoC includes an additional channel (channel
>> 8) dedicated to reading temperature values from the Thermal Sensor Unit
>> (TSU). There is a direct in-SoC connection between the ADC and TSU IPs.
>>
>> To read the temperature reported by the TSU, a different sampling rate
>> (compared to channels 0-7) must be configured in the ADM3 register.
>>
>> The rzg2l_adc driver has been updated to support reading the TSU
>> temperature.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>>  static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
>> @@ -161,7 +173,7 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
>>  	rzg2l_adc_writel(adc, RZG2L_ADM(1), reg);
>>  }
>>  
>> -static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
>> +static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch, enum iio_chan_type type)
>>  {
>>  	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
>>  	u32 reg;
>> @@ -177,6 +189,15 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
>>  	reg |= BIT(ch);
>>  	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
>>  
>> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
>> +	reg &= ~hw_params->adsmp_mask;
>> +	/*
>> +	 * type could be IIO_VOLTAGE = 0 or IIO_TEMP = 9. Divide to 8 to get
>> +	 * index 0 or 1 depending on the channel type.
> 
> That is not particularly nice and potentially a little fragile if we get other device
> support in future. Better to match on the type in rzg2l_adc_channels[] possibly wrapped
> up in a little utility function bool rzg2l_adc_channels_is_temp(); Then use a
> ? 1 : 0 to get the offset in default_adsmp[]

I though about this, too, but considered we should not go beyond 1 as the
rzg2l_adc_conversion_setup() is currently call in places where the channel
type is only IIO_VOLTAGE and IIO_TEMP, just saying...

I'll switch to the approach you propose in the next version.

> 
> 
>> +	 */
>> +	reg |= hw_params->default_adsmp[type / 8];
>> +	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>> +
>>  	/*
>>  	 * Setup ADINT
>>  	 * INTS[31] - Select pulse signal
>> @@ -192,7 +213,8 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
>>  	return 0;
>>  }
>>
>>  
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		if (chan->type != IIO_TEMP)
>> +			return -EINVAL;
>> +
>> +		mutex_lock(&adc->lock);
>> +		ret = rzg2l_adc_conversion(indio_dev, chan->type, adc, ch);
>> +		if (!ret) {
>> +			/* Convert it to mili Celsius. */
>> +			*val = adc->last_val[ch] * 1000;
> Prefer you provide a scale of 1000 and report this raw.

I'll look to this.

>> +		}
> Also strong preference for error conditions out of line.
> As in that other case, guard() makes that easier as yo ucan do
> 		{
> 
> 			guard(mutex)(&adc->lock);
> 			ret = rz....
> 			if (ret)
> 				return ret;
> 
> 			*val = ...
> 			
> 			return IIO_VAL_INT;
> 		}


I agree, looks cleaner with guard().

> 
>> +		mutex_unlock(&adc->lock);
>> +
>> +		return ret ? ret : IIO_VAL_INT;
>> +
>>  	default:
>>  		return -EINVAL;
>>  	}
> 
>>  static const struct iio_info rzg2l_adc_iio_info = {
>> @@ -332,11 +368,14 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
>>  		if (channel >= hw_params->num_channels)
>>  			return -EINVAL;
>>  
>> -		chan_array[i].type = IIO_VOLTAGE;
>> +		chan_array[i].type = rzg2l_adc_channels[channel].type;
>>  		chan_array[i].indexed = 1;
>>  		chan_array[i].channel = channel;
>> -		chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>> -		chan_array[i].datasheet_name = rzg2l_adc_channel_name[channel];
>> +		if (rzg2l_adc_channels[channel].type == IIO_VOLTAGE)
>> +			chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>> +		else
>> +			chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED);
> 
> Make it raw, but I'm curious we have no _SCALE on this device.  Do we really have no idea
> of the calibration of these channels?

The calibration data is stored on the TSU (Thermal Sensor Unit) hardware
block. From the TSU driver (not yet published) we read the temperature
through the ADC channel and apply the calibration data on the value
returned by ADC (this is how HW manual suggests). This is the current
(internal) struct thermal_zone_device_ops::get_temp() API of the TSU driver
(it will be published later, after some clarifications with hardware team
on SoC specific aspects):

// ..

#define TSU_READ_STEPS		8
#define MCELSIUS(temp)		(temp * MILLIDEGREE_PER_DEGREE)

// ...

struct rzg3s_thermal_priv {
	void __iomem *base;
	struct device *dev;
	struct thermal_zone_device *tz;
	struct reset_control *rstc;
	struct iio_channel *channel;
	u16 calib0;
	u16 calib1;
};

// ...

static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
{
	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
	struct device *dev = priv->dev;
	u32 ts_code_ave = 0;
	int ret, val;

	ret = pm_runtime_resume_and_get(dev);
	if (ret)
		return ret;

	for (u8 i = 0; i < TSU_READ_STEPS; i++) {
		ret = iio_read_channel_processed(priv->channel, &val);
		if (ret < 0)
			goto rpm_put;
		
		ts_code_ave += val;
		/*
		 * According to HW manual (section 40.4.4 Procedure for
		 * Measuring the Temperature) we need to wait here at
		 * leat 3us.
		 */
		usleep_range(5, 10);
	}

	ret = 0;
	ts_code_ave = DIV_ROUND_CLOSEST(ts_code_ave, TSU_READ_STEPS);

	/*
	 * According to HW manual (section 40.4.4 Procedure for Measuring
	 * the Temperature) the formula mentioned in the hardware manual is
	 * as follows;
	 *
	 * Tj = (ts_code_ave - priv->calib0) * (165 / (priv->calib0 -
	 * priv->calib1)) - 40
	 *
	 * As the temperature retrieved from the IIO channel is in
	 * milicelsius convert all members of the equation to milicelsius.
	 * It has been chose like this to avoid loosing precisions by
	 * converting IIO reported temperature to celsius.
	 */
	*temp = DIV_ROUND_CLOSEST_ULL(((u64)(ts_code_ave -
		MCELSIUS(priv->calib1)) * MCELSIUS(165)),
		MCELSIUS((priv->calib0 - priv->calib1))) - MCELSIUS(40);

	/* Round it up to 0.5 degrees Celsius. */
	*temp = roundup(*temp, 500);

rpm_put:
	pm_runtime_mark_last_busy(dev);
	pm_runtime_put_autosuspend(dev);

	return ret;
}


> 
>> +		chan_array[i].datasheet_name = rzg2l_adc_channels[channel].name;
>>  		i++;
>>  	}
>>  
>> @@ -386,7 +425,7 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
>>  	reg &= ~RZG2L_ADM3_ADCMP_MASK;
>>  	reg &= ~hw_params->adsmp_mask;
>>  	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
>> -	       hw_params->default_adsmp;
>> +	       hw_params->default_adsmp[0];
>>  
>>  	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>>  
>> @@ -479,7 +518,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
>>  	.num_channels = 8,
>>  	.default_adcmp = 0xe,
>> -	.default_adsmp = 0x578,
>> +	.default_adsmp = { 0x578 },
>>  	.adsmp_mask = GENMASK(15, 0),
>>  	.adint_inten_mask = GENMASK(7, 0),
>>  	.adivc = true
> 

