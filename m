Return-Path: <linux-kernel+bounces-551367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140DEA56B81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790C8189C197
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB09D221735;
	Fri,  7 Mar 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBA6VD2A"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885F221733
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360342; cv=none; b=cAAb4FgsepZgKHOl4iu2JZhmYmU7D6sr7GWn27swxg8dyE7ynBSpSVO1muwYWCkcxz6BJTSPMTp4JF96VL3txtbfbIodEhjYk5l9t7O7AYBZz2dTSTXaSSoZt4m3RUMM16+ZGmOgIxbRgz3K1G692mIny1rMLerZpb6mIeKLrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360342; c=relaxed/simple;
	bh=X8bFjvWIEL6nNohkMOL5h5TzljFrKQZopW+uAVwDnpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/HOcSFOVS0IA5YTdZNiQpqp4z2NL6umYlwTY5yJ3BoAmOpk5Sz4/n9ONjYr5x6qWWU4Ghsl6g2dWRyyTaFvcrx2w+yqKwe6KJ2KNPaPn9m9o8NyTtym1cLwJ0rX5zexaFBLcIqkPUs7Era06wb0GNzIBQGJjDRHkA45IUcniTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBA6VD2A; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390f69e71c8so1148662f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741360338; x=1741965138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3KPjXWWPyK0oX1t83TQ9M25n1uZNpHn3HsSYBqjRW2A=;
        b=QBA6VD2AunMwKkSaHhn3XdS+lZVP9RJtNwJLVA9jIyJm8pk2KrkZ0YPZNStB1TfI05
         ARP4m9N0uxq7hXtfkj8yHYTJRvGuqpWEAKhtrqxocT/KzV5L0zSIn3ziWPr0ef4INjCt
         BcEtMWvK8BoPFqrled1IOzS4G5WfcAnYIQ4wnTfy+oUrukhxt7FUhHBXxByiIWKpW3HP
         ObES84JtOipmEkbsN/MUCBD4mp0Q7K2Xo08XZrn7By/VPmzrW6+KNRMEn8euM5/xLdJu
         WlevOkY/lNmp5v3QqjnQrFzrTiWAhczM3TwRdaR0C1JY89mDpEVhfns1R9VsxGoRGOTq
         0taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360338; x=1741965138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KPjXWWPyK0oX1t83TQ9M25n1uZNpHn3HsSYBqjRW2A=;
        b=VNvx8v8y67+B0mKNaCm5X2Tr9a1MsORJDQ4WNMDNGT4DMiBDb8R3XyR+u945qhW/v9
         To/BQj7lrogxCY34IRQjWUcTJXM7tvm2iJoayPt5avEu41nmiy7pkO6kClZOzSVl5Coo
         pqy5mtIzIuXee+iCqoKqPkfPkih+J76zYRt1lNJvyDEBXRQsRojk30BWHrkyHMcpcUx8
         UF5yyA5UCloisq/lpvdtmlyZEVCe4iPoc6wHrVGNGHZcbXgNpjROJCk8RJNDxi2PDEn6
         oQgQxQnfCu/C/bP4GpN1hKXtSduqS3jVoIBajbCr3HBfLkYM5uYNQdw6A2oUnbQnkWCh
         gpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8dYtV49RwToA9Qiaq42snAptlGmpHioblUg0j4E1G6Xa+Xm2YpagLbGFAEfb1sy9JOCi+LzUHbI66FiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYz3qOxsKujcUZa5i1+1p+ZH/10/g9cNUx83b3E9kVUpD9gzaA
	doTeiKT0Dai//Ajb7aA8UloKvfEZrm8z4Pto3EsVQzxgptYzeE8E0hDDximzdn4=
X-Gm-Gg: ASbGncvpf71zsIVks7AI3WObxnHpHqAWhN6sAgrW/EhKz9aSIl1lFzoN2vdP3EiWn/v
	N+5BF7glCdv2dIkixkka3MAcXzQ8H7mdTXfDwaG+fOYcaIHlihpVdJLuh3loqhB9x/xrad+mKCZ
	03UGjpyJ7pOshXv4SlL5pZcEomc8/Oiu4qu0jcxo/9wWb+U5/oprf0dV+qZxgmefmot7DANu7Kh
	FxeJVyytAue6ZDMwmE6gM3tgXdzy0VBjFT+Adsk4P3YtDDabUuuacqZz64GUrDNu/TxTa/V3nMD
	FCMu21MsB+9Z41ZtvtEacSS4VF8CMp0PxC4BXrzfZInoX8PqPKbUTNeSpV+7Pga38u/ugLLqJbj
	JAwynGOcn
X-Google-Smtp-Source: AGHT+IF/RAT3IwHfPoJTNREYxSSMrMjlEJSFksJXdPdttaAQyHvw/bJK7g/nq3YVVLUv/LTreYAVjw==
X-Received: by 2002:a5d:59ae:0:b0:391:22e2:ccd2 with SMTP id ffacd0b85a97d-391296c2485mr5482638f8f.3.1741360338305;
        Fri, 07 Mar 2025 07:12:18 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912c104acesm5662531f8f.98.2025.03.07.07.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:12:17 -0800 (PST)
Message-ID: <83283a94-6833-4d7d-8d89-6ba42b43b96c@linaro.org>
Date: Fri, 7 Mar 2025 16:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] clocksource: stm32-lptimer: add support for
 stm32mp25
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, lee@kernel.org,
 ukleinek@kernel.org, alexandre.torgue@foss.st.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jic23@kernel.org, tglx@linutronix.de
Cc: catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org,
 wbg@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
 olivier.moysan@foss.st.com
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
 <20250305094935.595667-5-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250305094935.595667-5-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/03/2025 10:49, Fabrice Gasnier wrote:
> On stm32mp25, DIER (former IER) must only be modified when the lptimer
> is enabled. On earlier SoCs, it must be only be modified when it is
> disabled. Read the LPTIM_VERR register to properly manage the enable
> state, before accessing IER.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in V2:
> - rely on fallback compatible as no specific .data is associated to the
>    driver. Use version data from MFD core.
> - Added interrupt enable register access update in (missed in V1)
> ---
>   drivers/clocksource/timer-stm32-lp.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
> index a4c95161cb22..96d975adf7a4 100644
> --- a/drivers/clocksource/timer-stm32-lp.c
> +++ b/drivers/clocksource/timer-stm32-lp.c
> @@ -25,6 +25,7 @@ struct stm32_lp_private {
>   	struct clock_event_device clkevt;
>   	unsigned long period;
>   	struct device *dev;
> +	bool ier_wr_enabled;	/* Enables LPTIMER before writing into IER register */
>   };
>   
>   static struct stm32_lp_private*
> @@ -37,8 +38,15 @@ static int stm32_clkevent_lp_shutdown(struct clock_event_device *clkevt)
>   {
>   	struct stm32_lp_private *priv = to_priv(clkevt);
>   
> -	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> +	/* Disable LPTIMER either before or after writing IER register (else, keep it enabled) */
> +	if (!priv->ier_wr_enabled)
> +		regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> +
>   	regmap_write(priv->reg, STM32_LPTIM_IER, 0);
> +

Why not encapsulate the function ?

	regmap_write_ier(struct stm32_lp_private *priv, int value)
	{

		/* A comment ... */
		if (!priv->ier_wr_enabled)
			regmap_write(priv->reg, STM32_LPTIM_CR, 0);

		regmap_write(priv->reg, STM32_LPTIM_IER, value);

		if (!priv->ier_wr_enabled)
			regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
	}


> +	if (priv->ier_wr_enabled)
> +		regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> +

>   	/* clear pending flags */
>   	regmap_write(priv->reg, STM32_LPTIM_ICR, STM32_LPTIM_ARRMCF);
>   
> @@ -51,12 +59,21 @@ static int stm32_clkevent_lp_set_timer(unsigned long evt,
>   {
>   	struct stm32_lp_private *priv = to_priv(clkevt);
>   
> -	/* disable LPTIMER to be able to write into IER register*/
> -	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> +	if (!priv->ier_wr_enabled) {
> +		/* Disable LPTIMER to be able to write into IER register */
> +		regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> +	} else {
> +		/* Enable LPTIMER to be able to write into IER register */
> +		regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
> +	}
> +
>   	/* enable ARR interrupt */
>   	regmap_write(priv->reg, STM32_LPTIM_IER, STM32_LPTIM_ARRMIE);
> +
>   	/* enable LPTIMER to be able to write into ARR register */
> -	regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
> +	if (!priv->ier_wr_enabled)
> +		regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
> +
>   	/* set next event counter */
>   	regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
>   
> @@ -151,6 +168,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	priv->reg = ddata->regmap;
> +	priv->ier_wr_enabled = ddata->version == STM32_LPTIM_VERR_23;
>   	ret = clk_prepare_enable(ddata->clk);
>   	if (ret)
>   		return -EINVAL;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

