Return-Path: <linux-kernel+bounces-226645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A871391418E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5441C226C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365C168DC;
	Mon, 24 Jun 2024 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NxHoeKxS"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18518638
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205058; cv=none; b=srj2BDkguJ++8xWWUnVU6W5v4Me0FwVdPhADmtdOIWXjqf9mHP1TEfAMdZgxO9CbRLjbtIqiIyFuj+Ae4ASjuedv7Uv7mijFvVDx7kESzsmLVvm8RIR+XL+p3/DM7AapBZIEf+EJ5Rl94XlyAiHBzpQcUH3AlbddQrheoO09fnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205058; c=relaxed/simple;
	bh=3Wx89PgeJUXfZoOBkjFuaH88YOgjOqCDVC8IK0Vf4UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFbDJ8nJgXHpxlioO23pvKC6aaunE5nx7vazbp25LccU/9rkRXHyY3EUxtqR+wq0O3sapn7krHR4hNZTpMnYoyFnzrCFK00tQt5fVKYhEHUbVscVg5x+JIQ73SN2n377zWqt3TWTIHifjSypyq8VHrdrxsBv3cOMBOnCAKGwHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NxHoeKxS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso4477127a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719205055; x=1719809855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1pWvROhLVXSfOtM9EJCk67ObqDKumuc3QdFFlUZwE0=;
        b=NxHoeKxS1iFdyxV7/M+xgZsy43qzrRxJhaJl3p0H3Ce55fXbs921kPZRHOBMVLXN1J
         b0FWlctBYN4Fht7Ph8t6JbvkuSGhkNGywxEy3r16eKElmj65TEoGKhCqOHOygs2ZSkMp
         BDxBhgHOE+nYOlneaqanY3HH8W+8enugckL3Nt3qQutThM+Su0OGMv74NJqRuMUg6QrJ
         Jjzg7Yyh+TJFbU19neMU0V/3IF2sZ5IpF8N/c3+z+gGrCQON5XhSgWsaCZ3+9afznXYP
         DqCs4cRMCfCujSMWAQP48hi4XEqAuMUOgKdCCVp4dBH/xzRMJlFh5IUT6Wi4TCaqle87
         ZdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719205055; x=1719809855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1pWvROhLVXSfOtM9EJCk67ObqDKumuc3QdFFlUZwE0=;
        b=CriySrukzkrOqpyLH/5CvsMmcFtGGJn/xAG9jebg7Utdcipht/F/HJ6MzVZa/bEn4X
         G7fbpYoSbL9hA3NCk2eul5aaJ3zu59ADkqHxaMqMzhMIHWqzlqazVGWhKUaUE7VFlqay
         sM+gveyGoiUvjktiUyaw13qeBwFJHH2GX+bgFO2Xf2J0W3jm8eQ23GNQBqhJ4LOCs/tk
         JVf0shqf8pHydTK8GvJE4obCvYwmvPNRs9HiYd06IvqBFhOYezgh4ETw/nAWM+7aWTGd
         jeDa2mCp/7FRr7y45QF7Aj7BbI/3XMtdnnLVMofng5iVZ/TjxihuoTiWZhD5r89P0ufa
         czQw==
X-Forwarded-Encrypted: i=1; AJvYcCVLKoXGnMImhq5LnsZ286LU3zAbufP6UI5npQUQPl4O0oik7sDh9S8NkgUU4S5x4Qrowkw7hfT77KhiRUchtsUEiEl+k5/wq4MZupPw
X-Gm-Message-State: AOJu0YxtnkP+6N2nczUes5r9wZoqjlBio4aunVGHtwcLomtiIpsXUnOd
	AyGB+pkoPIQU+J/aTjeW1YPZUSK3FczYCz3kJ+pERW2n1dnqMyE4qoUpL9jQvugwNUycIVSevlK
	O
X-Google-Smtp-Source: AGHT+IEzFCBOH7AeWSt/kNYxsrJ1aswQQ421zB0ZiKGazh6BNIHQV/0IkapgdhHUl6fZiqUNeOTljw==
X-Received: by 2002:a50:c30f:0:b0:57c:a422:677b with SMTP id 4fb4d7f45d1cf-57d4bd537fbmr2754496a12.8.1719205055438;
        Sun, 23 Jun 2024 21:57:35 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303d7aecsm4209761a12.20.2024.06.23.21.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 21:57:35 -0700 (PDT)
Message-ID: <e196c6ca-3198-47b1-861c-933c9e6476ac@tuxon.dev>
Date: Mon, 24 Jun 2024 07:57:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] pinctrl: renesas: rzg2l: Reorganize variable
 configuration macro
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240618174831.415583-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240618174831.415583-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240618174831.415583-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18.06.2024 20:48, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The `PIN_CFG_VARIABLE` macro did not indicate the capabilities of a pin
> but served as a flag indicating that the pins of a port have different
> capabilities.
> 
> To better reflect its purpose, move the `PIN_CFG_VARIABLE` macro beside
> `RZG2L_SINGLE_PIN` and rename it to `RZG2L_CFG_VARIABLE`. Additionally,
> introduce new macros for packing variable port configurations:
> 
> - `RZG2L_GPIO_PORT_PACK_VARIABLE(n, a)`: Combines `RZG2L_CFG_VARIABLE`
>   with `RZG2L_GPIO_PORT_PACK` to handle variable pin configurations
>   for a packed port.
> - `RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(m, a)`: Combines
>   `RZG2L_CFG_VARIABLE` with `RZG2L_GPIO_PORT_SPARSE_PACK` to handle
>   variable pin configurations for a sparse port.
> 
> Due to the above change the configuration macros have been reorganized
> as follows:
> - Shift the bit positions of `PIN_CFG_NOGPIO_INT`, `PIN_CFG_NOD`,
>   `PIN_CFG_SMT`, `PIN_CFG_ELC`, and `PIN_CFG_IOLH_RZV2H` down by one
>   to accommodate the removal of `PIN_CFG_VARIABLE`.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 29 +++++++++++++++----------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 37a99d33400d..9a67de960470 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -57,14 +57,14 @@
>  #define PIN_CFG_IOLH_C			BIT(13)
>  #define PIN_CFG_SOFT_PS			BIT(14)
>  #define PIN_CFG_OEN			BIT(15)
> -#define PIN_CFG_VARIABLE		BIT(16)
> -#define PIN_CFG_NOGPIO_INT		BIT(17)
> -#define PIN_CFG_NOD			BIT(18)	/* N-ch Open Drain */
> -#define PIN_CFG_SMT			BIT(19)	/* Schmitt-trigger input control */
> -#define PIN_CFG_ELC			BIT(20)
> -#define PIN_CFG_IOLH_RZV2H		BIT(21)
> +#define PIN_CFG_NOGPIO_INT		BIT(16)
> +#define PIN_CFG_NOD			BIT(17)	/* N-ch Open Drain */
> +#define PIN_CFG_SMT			BIT(18)	/* Schmitt-trigger input control */
> +#define PIN_CFG_ELC			BIT(19)
> +#define PIN_CFG_IOLH_RZV2H		BIT(20)
>  
>  #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
> +#define RZG2L_CFG_VARIABLE		BIT_ULL(62)	/* Variable cfg for port pins */
>  
>  #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
>  					(PIN_CFG_IOLH_##group | \
> @@ -100,12 +100,17 @@
>  #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)	(FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
>  						 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
>  						 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
> +#define RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(m, a)	\
> +						(RZG2L_CFG_VARIABLE | \
> +						 RZG2L_GPIO_PORT_SPARSE_PACK(m, a, 0))
>  
>  /*
>   * n indicates number of pins in the port, a is the register index
>   * and f is pin configuration capabilities supported.
>   */
>  #define RZG2L_GPIO_PORT_PACK(n, a, f)	RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
> +#define RZG2L_GPIO_PORT_PACK_VARIABLE(n, a)	(RZG2L_CFG_VARIABLE | \
> +						 RZG2L_GPIO_PORT_PACK(n, a, 0))
>  
>  #define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
>  #define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
> @@ -371,7 +376,7 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
>  
>  		if (FIELD_GET(VARIABLE_PIN_CFG_PORT_MASK, cfg) == port &&
>  		    FIELD_GET(VARIABLE_PIN_CFG_PIN_MASK, cfg) == pin)
> -			return (pincfg & ~PIN_CFG_VARIABLE) | FIELD_GET(PIN_CFG_MASK, cfg);
> +			return (pincfg & ~RZG2L_CFG_VARIABLE) | FIELD_GET(PIN_CFG_MASK, cfg);
>  	}
>  
>  	return 0;
> @@ -1835,13 +1840,13 @@ static const u64 r9a07g043_gpio_configs[] = {
>  	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x06, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
>  				    PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
>  				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P19 */
> -	RZG2L_GPIO_PORT_PACK(8, 0x07, PIN_CFG_VARIABLE),				/* P20 */
> +	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x07),						/* P20 */
>  	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x08, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
>  				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P21 */
>  	RZG2L_GPIO_PORT_PACK(4, 0x09, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
>  			     PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),				/* P22 */
> -	RZG2L_GPIO_PORT_SPARSE_PACK(0x3e, 0x0a, PIN_CFG_VARIABLE),			/* P23 */
> -	RZG2L_GPIO_PORT_PACK(6, 0x0b, PIN_CFG_VARIABLE),				/* P24 */
> +	RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(0x3e, 0x0a),				/* P23 */
> +	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x0b),						/* P24 */
>  	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_FILONOFF |
>  				    PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
>  				    PIN_CFG_NOGPIO_INT),				/* P25 */
> @@ -1913,7 +1918,7 @@ static const u64 r9a09g057_gpio_configs[] = {
>  				      PIN_CFG_ELC),		/* P8 */
>  	RZG2L_GPIO_PORT_PACK(8, 0x29, RZV2H_MPXED_PIN_FUNCS),	/* P9 */
>  	RZG2L_GPIO_PORT_PACK(8, 0x2a, RZV2H_MPXED_PIN_FUNCS),	/* PA */
> -	RZG2L_GPIO_PORT_PACK(6, 0x2b, PIN_CFG_VARIABLE),	/* PB */
> +	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x2b),			/* PB */
>  };
>  
>  static const struct {
> @@ -2637,7 +2642,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
>  		if (i && !(i % RZG2L_PINS_PER_PORT))
>  			j++;
>  		pin_data[i] = pctrl->data->port_pin_configs[j];
> -		if (pin_data[i] & PIN_CFG_VARIABLE)
> +		if (pin_data[i] & RZG2L_CFG_VARIABLE)
>  			pin_data[i] = rzg2l_pinctrl_get_variable_pin_cfg(pctrl,
>  									 pin_data[i],
>  									 j,

