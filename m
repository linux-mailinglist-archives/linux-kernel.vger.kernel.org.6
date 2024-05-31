Return-Path: <linux-kernel+bounces-197140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F78D66B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F87B24026
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CD0158DC5;
	Fri, 31 May 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7vMdJSK"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA65145328
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172577; cv=none; b=GbBD2w6XRyA0YG6XK8YxlIb2ULEptMhlRsUeRknzXG2a2vhwrk0fGX3J7HjnbF+QE9yReGXOUwNFHCceWHW6KcMrBupkfNKMEDlJCTTNax56DO5oxNGWyYv9KcopnWbl38OJkcdObL8MIMd8tAjP8Cn+x2jhzoIZH92oWncJ0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172577; c=relaxed/simple;
	bh=wRuzukfHTuY9txqqlUqVEoBDYzEHtslcBcqDMPuKaD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWFrPTQVStVXhPiJXFLY2hx4p0C5TfpmZa+JplXGhNUjM7JkHlVlNdPxAMF+QlCcHqhsVa7dIGunGWZR3Fx6tjkCWZOwmyCjfqPzMIpD3dc/+UmWov7eib/R+2Yr+fGkJnUaMj112PTJemsdLx+p7s4t2XHAl3O4GFbvKty1xOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7vMdJSK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b03d66861so2476392e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717172573; x=1717777373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WU9HOi116oLiCRDppMSgfPzQnRzV0fHJZl34KYHTbeo=;
        b=b7vMdJSKFvZpNoxy84XjSRcL1tNkGMKbKpvyS1mepLDzgMus7le6Y4/RQ25AmYTfMB
         wMvDr294PtddE75Ninc7+aoJBa2GUHHdEIT0Us38MKGE9iJ7BdwErHoJYZF00azHZd2t
         3WQp82CNLCTm9kNZTeBFvrrnCYGBZXZT/Hb6s7BMc9R6ELzh0+NpuLiaK3jdXeDl0KQU
         F3B66cW2uadQ7XhCUyt1AH4ReuXvKKOkgKHn/IX6JAP6N7sC9nFa57yBxw1t0G6ncOsf
         sZZw6b5GbJBt3pKyEq7wk2kyTPGG2qqUDh0knIu/gbjadK/sM5YTWiWFoyhohSz2E9ls
         ziCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717172573; x=1717777373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WU9HOi116oLiCRDppMSgfPzQnRzV0fHJZl34KYHTbeo=;
        b=a6yb7L8vc+rMkG9ZzZ19ZQdJ29A6gAebF5/DAOAN53zKvuDOyobnW8Jz3suJuvBZ42
         N4OWtkyIffaxC2xcp0Q97vBZrc/8Y0Kv7jEch8Lhm1B4I9iZZzvAotifIH05MUB0c68b
         6Yvga7mTZPzj2K0TKuIeg8IXFfXkK07UqPSpIUYt9DAFqcTZdHeKu/S1esQIQg9iyC75
         SeOTxfkoriK7coQUOPf8Fb3X1IORvD5EZxPKGXVXhmxArQD95Jb9Yu1YmKW+2SG987/G
         XLHJBVVXV6V+83bmWofkX03EpRAp9ZK4DtGq2T34envGpk7UnONqfxyrV9Jf0T1bbX9w
         v4hw==
X-Forwarded-Encrypted: i=1; AJvYcCXa0DkniMeFngNXH5fn/65DjTBOC0KdIlkx9dbBdooA1M7AX0yEhPosD+aTrINySM+Xt+VrbogyaYBHsasCnMinbqB1ONyOqVIHbRPl
X-Gm-Message-State: AOJu0YxOEmERzPWOeYHPFtAeTFmINIcLLZQUboblHVFVrSvsI8ocKZAl
	SqyPC2mQqUpEaLQAWNJLDgtzI3AGA8n8NV24TJ9J8QzIxwyPfbuuImbzhZv4xR910pucYsxlAgY
	6QDS/jA==
X-Google-Smtp-Source: AGHT+IGZUoNx/1dQAVFESaKpl/hXh+mkCRbaj3zxnaE0lHE3CM6IhRyVNT/hOJYxM6CIhhcE2RwxhQ==
X-Received: by 2002:ac2:4d90:0:b0:529:b6b4:7e3c with SMTP id 2adb3069b0e04-52b8970c17dmr1550674e87.45.1717172573230;
        Fri, 31 May 2024 09:22:53 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064bba6sm2161697f8f.104.2024.05.31.09.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 09:22:52 -0700 (PDT)
Message-ID: <3f9e58f2-86e4-4ac4-bf48-22d12d5ae4e9@linaro.org>
Date: Fri, 31 May 2024 17:22:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] mfd: pm8008: fix regmap irq chip initialisation
To: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Stephen Boyd <swboyd@chromium.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20240529162958.18081-1-johan+linaro@kernel.org>
 <20240529162958.18081-3-johan+linaro@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240529162958.18081-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2024 17:29, Johan Hovold wrote:
> The regmap irq array is potentially shared between multiple PMICs and
> should only contain static data.
> 
> Use a custom macro to initialise also the type fields and drop the
> unnecessary updates on each probe.
> 
> Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/mfd/qcom-pm8008.c | 64 ++++++++++++++-------------------------
>   1 file changed, 23 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index 3ac3742f438b..f71c490f25c8 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -56,15 +56,25 @@ static unsigned int pm8008_config_regs[] = {
>   	INT_POL_LOW_OFFSET,
>   };
>   
> -static struct regmap_irq pm8008_irqs[] = {
> -	REGMAP_IRQ_REG(PM8008_IRQ_MISC_UVLO,	PM8008_MISC,	BIT(0)),
> -	REGMAP_IRQ_REG(PM8008_IRQ_MISC_OVLO,	PM8008_MISC,	BIT(1)),
> -	REGMAP_IRQ_REG(PM8008_IRQ_MISC_OTST2,	PM8008_MISC,	BIT(2)),
> -	REGMAP_IRQ_REG(PM8008_IRQ_MISC_OTST3,	PM8008_MISC,	BIT(3)),
> -	REGMAP_IRQ_REG(PM8008_IRQ_MISC_LDO_OCP,	PM8008_MISC,	BIT(4)),
> -	REGMAP_IRQ_REG(PM8008_IRQ_TEMP_ALARM,	PM8008_TEMP_ALARM, BIT(0)),
> -	REGMAP_IRQ_REG(PM8008_IRQ_GPIO1,	PM8008_GPIO1,	BIT(0)),
> -	REGMAP_IRQ_REG(PM8008_IRQ_GPIO2,	PM8008_GPIO2,	BIT(0)),
> +#define _IRQ(_irq, _off, _mask, _types)			\
> +	[_irq] = {					\
> +		.reg_offset = (_off),			\
> +		.mask = (_mask),			\
> +		.type = {				\
> +			.type_reg_offset = (_off),	\
> +			.types_supported = (_types),	\
> +		},					\
> +	}
> +
> +static const struct regmap_irq pm8008_irqs[] = {
> +	_IRQ(PM8008_IRQ_MISC_UVLO,    PM8008_MISC,	BIT(0), IRQ_TYPE_EDGE_RISING),
> +	_IRQ(PM8008_IRQ_MISC_OVLO,    PM8008_MISC,	BIT(1), IRQ_TYPE_EDGE_RISING),
> +	_IRQ(PM8008_IRQ_MISC_OTST2,   PM8008_MISC,	BIT(2), IRQ_TYPE_EDGE_RISING),
> +	_IRQ(PM8008_IRQ_MISC_OTST3,   PM8008_MISC,	BIT(3), IRQ_TYPE_EDGE_RISING),
> +	_IRQ(PM8008_IRQ_MISC_LDO_OCP, PM8008_MISC,	BIT(4), IRQ_TYPE_EDGE_RISING),
> +	_IRQ(PM8008_IRQ_TEMP_ALARM,   PM8008_TEMP_ALARM,BIT(0), IRQ_TYPE_SENSE_MASK),
> +	_IRQ(PM8008_IRQ_GPIO1,	      PM8008_GPIO1,	BIT(0), IRQ_TYPE_SENSE_MASK),
> +	_IRQ(PM8008_IRQ_GPIO2,	      PM8008_GPIO2,	BIT(0), IRQ_TYPE_SENSE_MASK),
>   };
>   
>   static const unsigned int pm8008_periph_base[] = {
> @@ -143,38 +153,9 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
>   	.max_register	= 0xFFFF,
>   };
>   
> -static int pm8008_probe_irq_peripherals(struct device *dev,
> -					struct regmap *regmap,
> -					int client_irq)
> -{
> -	int rc, i;
> -	struct regmap_irq_type *type;
> -	struct regmap_irq_chip_data *irq_data;
> -
> -	for (i = 0; i < ARRAY_SIZE(pm8008_irqs); i++) {
> -		type = &pm8008_irqs[i].type;
> -
> -		type->type_reg_offset = pm8008_irqs[i].reg_offset;
> -
> -		if (type->type_reg_offset == PM8008_MISC)
> -			type->types_supported = IRQ_TYPE_EDGE_RISING;
> -		else
> -			type->types_supported = (IRQ_TYPE_EDGE_BOTH |
> -				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> -	}
ick

A no-brainer improvement.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

