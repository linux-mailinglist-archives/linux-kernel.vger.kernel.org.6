Return-Path: <linux-kernel+bounces-251813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C26C930A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07971F21658
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0613210F;
	Sun, 14 Jul 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WymuT+/4"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBAB131BDD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964323; cv=none; b=D2GkBxFfKbcFb+uPV7wyhJVsXSEpKDp2kHismbW3Lo0GipdyOXHF8wmHItivt1hIZ31W9sz7YMthVI7zftfKYn4WYNJx4Up1M+qcwnbDUSCFbAwP3wlEu+nWEqmLCbEMPIv7oQpFjEXVmcOGcPo4b4SUYCQEt9p61hvTZnBPQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964323; c=relaxed/simple;
	bh=s68TCx5GQTrGFow3f11gYEGt+WQRFVFLaY7PZ048oZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cI+0Dd+jYO7af3qQAvFptW3BhLBbZ9rrdFXva3gVNrAn0ot85iGcqDuha7rpEXR19Pws/lyt9CRJy6oAOEK8Id7p8fIuMdeWK09Zbf1bPSX5d5UpRpHZt0p83JvFPJHcSKycIyW495c84B8eWgd5gzUwZvsK3p1EfRyJbiQAgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WymuT+/4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36799a67d9cso2764945f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964318; x=1721569118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZjBB6Zz74T0lW5akrOTIxTz7Vc5LGy8K4HXk9FNhmg=;
        b=WymuT+/4ndKcsvAtVDede/bTlQyqKCTRvfNkEO8cOHNlfxW6WJ4W7qC7/KfmOZvujE
         /z3oAUESFwQjpR92XrgbWiliXtOKrQmph+XfxXcR0/73B5Koixrj0EVhD1Gcs5ME43LS
         R0VlfTX07N7/wFjp75TMD9+RrAnX3OEIUnPCa3gPa5v5IIZn4WPFTjg0ggkYiUbahPzy
         swMNEiwhDr2ltXayESwqQUsF+fqMS1DJ154tcWT4mnq/+AoM6M8u9kSFx5YTupcElYaP
         y1YpIKlxqNEH+M/lfWR3qMwGzJgHLDQKd7qCedXvQnzbO1YjVjWo39SW/m9RooWMGcmD
         mhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964318; x=1721569118;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZjBB6Zz74T0lW5akrOTIxTz7Vc5LGy8K4HXk9FNhmg=;
        b=P+L/HJhe6TzqRVvXlI7exED+88epDO7kPQOcwhkD5Okoi57dEKG/kGB++9JDEK47He
         1lvbneM7U0MfGyp2C8x8yjph5tZdgeRBg+kz4UIst3FbMmCVVsK3xpaQEYv34AmD9MXZ
         d4+DWB27gOOmMFNFJKlD3UYEbMXxNJyvq2yQbwcyHsSWNKuMFp1/SumZud4ORBKEyFJO
         oYLvPvLknJt8VZl8fYpWCi7L6MtrQMUhxZ8oh+FclWsij+cZFp2u9XegfvZuwR27bZFn
         1JiI45DNiUnXlD/DgKsnBVzMltDHEb96XE8OBTJALB/5VDvhaq2D703ftQ69lFVySMoQ
         RwlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6trdnP/kSYgVKDPw8l3+UegJl38ayFMLbe9dTsOAcuMr7kve8kwfC+0LW/YTNl/8ikUMrBar/g1SefhpndtL295eahWPYnFkEzE99
X-Gm-Message-State: AOJu0YyD2zmP7emueNQYrFed9KSHV7m6H6Avq769GJu0TSpxIflS3joO
	ghbBPANgoRmQ1J8imHFV73XC8JKs5VEX0gQf4u8vzVStA5LqUWj/ga6kWPDznkg=
X-Google-Smtp-Source: AGHT+IFnZ2fBKni+oMjqw658EaiL2SaxJZ1tRzIUtjKq7rUfVoNeT/hDIkSMgfw1XxaONVjDuTQ5gg==
X-Received: by 2002:a5d:47a7:0:b0:360:75b1:77fb with SMTP id ffacd0b85a97d-367cea46438mr18204551f8f.8.1720964318444;
        Sun, 14 Jul 2024 06:38:38 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:38:38 -0700 (PDT)
Message-ID: <dda95f03-5e41-4eec-8035-9d2a16dd679f@tuxon.dev>
Date: Sun, 14 Jul 2024 16:38:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/27] clk: at91: clk-sam9x60-pll: re-factor to support
 individual core freq outputs
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102729.195762-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102729.195762-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:27, Varshini Rajendran wrote:
> SAM9X7 SoC family supports different core output frequencies for
> different PLL IDs. To handle the same in the PLL driver, a separate
> parameter core_output is added. The sam9x60 and sama7g5 SoC PMC drivers
> are aligned to the PLL driver by adding the core output freq range in
> the PLL characteristics configurations.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/clk/at91/clk-sam9x60-pll.c | 12 ++++++------
>  drivers/clk/at91/pmc.h             |  1 +
>  drivers/clk/at91/sam9x60.c         |  7 +++++++
>  drivers/clk/at91/sama7g5.c         |  7 +++++++
>  4 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index ff65f7b916f0..b0314dfd7393 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -23,9 +23,6 @@
>  #define UPLL_DIV		2
>  #define PLL_MUL_MAX		(FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, UINT_MAX) + 1)
>  
> -#define FCORE_MIN		(600000000)
> -#define FCORE_MAX		(1200000000)
> -
>  #define PLL_MAX_ID		7
>  
>  struct sam9x60_pll_core {
> @@ -194,7 +191,8 @@ static long sam9x60_frac_pll_compute_mul_frac(struct sam9x60_pll_core *core,
>  	unsigned long nmul = 0;
>  	unsigned long nfrac = 0;
>  
> -	if (rate < FCORE_MIN || rate > FCORE_MAX)
> +	if (rate < core->characteristics->core_output[0].min ||
> +	    rate > core->characteristics->core_output[0].max)
>  		return -ERANGE;
>  
>  	/*
> @@ -214,7 +212,8 @@ static long sam9x60_frac_pll_compute_mul_frac(struct sam9x60_pll_core *core,
>  	}
>  
>  	/* Check if resulted rate is a valid.  */
> -	if (tmprate < FCORE_MIN || tmprate > FCORE_MAX)
> +	if (tmprate < core->characteristics->core_output[0].min ||
> +	    tmprate > core->characteristics->core_output[0].max)
>  		return -ERANGE;
>  
>  	if (update) {
> @@ -669,7 +668,8 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>  			goto free;
>  		}
>  
> -		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core, FCORE_MIN,
> +		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core,
> +							characteristics->core_output[0].min,
>  							parent_rate, true);
>  		if (ret < 0) {
>  			hw = ERR_PTR(ret);
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 0f52e80bcd49..bb9da35198d9 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -75,6 +75,7 @@ struct clk_pll_characteristics {
>  	struct clk_range input;
>  	int num_output;
>  	const struct clk_range *output;
> +	const struct clk_range *core_output;
>  	u16 *icpll;
>  	u8 *out;
>  	u8 upll : 1;
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index e309cbf3cb9a..db6db9e2073e 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -26,10 +26,16 @@ static const struct clk_range plla_outputs[] = {
>  	{ .min = 2343750, .max = 1200000000 },
>  };
>  
> +/* Fractional PLL core output range. */
> +static const struct clk_range core_outputs[] = {
> +	{ .min = 600000000, .max = 1200000000 },
> +};
> +
>  static const struct clk_pll_characteristics plla_characteristics = {
>  	.input = { .min = 12000000, .max = 48000000 },
>  	.num_output = ARRAY_SIZE(plla_outputs),
>  	.output = plla_outputs,
> +	.core_output = core_outputs,
>  };
>  
>  static const struct clk_range upll_outputs[] = {
> @@ -40,6 +46,7 @@ static const struct clk_pll_characteristics upll_characteristics = {
>  	.input = { .min = 12000000, .max = 48000000 },
>  	.num_output = ARRAY_SIZE(upll_outputs),
>  	.output = upll_outputs,
> +	.core_output = core_outputs,
>  	.upll = true,
>  };
>  
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index 91b5c6f14819..e6eb5afba93d 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -116,11 +116,17 @@ static const struct clk_range pll_outputs[] = {
>  	{ .min = 2343750, .max = 1200000000 },
>  };
>  
> +/* Fractional PLL core output range. */
> +static const struct clk_range core_outputs[] = {
> +	{ .min = 600000000, .max = 1200000000 },
> +};
> +
>  /* CPU PLL characteristics. */
>  static const struct clk_pll_characteristics cpu_pll_characteristics = {
>  	.input = { .min = 12000000, .max = 50000000 },
>  	.num_output = ARRAY_SIZE(cpu_pll_outputs),
>  	.output = cpu_pll_outputs,
> +	.core_output = core_outputs,
>  };
>  
>  /* PLL characteristics. */
> @@ -128,6 +134,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
>  	.input = { .min = 12000000, .max = 50000000 },
>  	.num_output = ARRAY_SIZE(pll_outputs),
>  	.output = pll_outputs,
> +	.core_output = core_outputs,
>  };
>  
>  /*

