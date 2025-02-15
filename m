Return-Path: <linux-kernel+bounces-516318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CEAA36F99
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5676D1698B1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F81E5B7C;
	Sat, 15 Feb 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d6zFhGnW"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3821DD0D4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638680; cv=none; b=GwxwV21O5gar+2Vq+lvHtIwy9ykyB+XJaPeofpFfQ+xPwPyHW9CjHQK6S5y4Fi85TasRzQsiFkwKT8zX5IIKY66QciO26K3gwUVa9LY7VRhT3LjPj71PqjAemVyaxC1WSUjYg56iWk+I5PW2D/ORxCUhYtio5xGgLsDzCLT2Ah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638680; c=relaxed/simple;
	bh=2zUFE8Rx2Dqli03I3bs5sTLitJ+sUsvLrkOZcRcLgmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZP8zJkIadcdcX+up1I5glCILZIyHZ2QBnsbLQQDvUzuKgqNPSglujtyJrOtQHbAGz9hPss+wK4cDcPz3ARN2uW/5IcRSETpMKdK+qYS8u+rdShcQP5hRRtJxq+gvfmJN3tMBNernqLTwek//TmSH2TE00qTYaVFCAL9V7FsbvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d6zFhGnW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso292620a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739638676; x=1740243476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDNZRmX9cp47bNPUDnDP3nRpEEr/01wvhc2xIQB9veA=;
        b=d6zFhGnWG83iVePnbpmJxy+RZAKB6psGTWC11/K7vfmj9JM//m5R37RvIBcNcZeBxx
         XIXXhqM2vTWT+NJqqPwufT4sbbIf9Hh/whIgHoi3ZVZERSdPrez1crJ66QLd4LizCHLy
         j55ki23k7b5oROK3V4y7I86qTWwLaopoEV/SJoi+wu3V1ADbu8riUG72FQhBnbKYRMhw
         3HewhpsfxWQ5+oGY3uDq4DSImIfguIrYkeRiH9AFGH5wy6pZ2O1NTEVCBxxYzKknW4ij
         z6E8qazwMf/BJkTbHM8m2DkuW789sqKy+NonjbgdAGqdXEEofsMjYrb1fekGzLJtzP6Y
         /9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739638676; x=1740243476;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDNZRmX9cp47bNPUDnDP3nRpEEr/01wvhc2xIQB9veA=;
        b=po8fyDUfl174Uwg8FLh9Q7Vu7yct29CP/RqDVRw7n+tjaKqcbcQFCOAm5ZL+RoGkzi
         HdGMW1DQb1bC6vSWORZkXpr+pw5iG3zfhJgH4xg//P13VI71PbaUSlUffUeE4rWbEG9o
         UuC1OGkAlNvYwJEWNGLT4Y31DpI++obpCDuhMMTHMNL1smRZ6MvMvGY6Jgr9Cw7jRftT
         R1fcX87NBL92NopxRs2L9DvPWC3pHy05vxMWSfGHGQNr+EBYS5p0vNvOszlwqCN/gP23
         f16W+nkCRGLAZUqzyVBlu5ZH+MlVRoWpdu2wc4l+ErC44jgzgavkBd0FUiZJWbdWTzgx
         kDew==
X-Forwarded-Encrypted: i=1; AJvYcCUPZ0RbSZnG0P5ZV5l19eWgonYP51wmaR+gpQFkkH5vURVAlUGXgj0xGS2MYth7BKv0alqaI3ypD1QPXM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJqJSW2cpBtWR44v6OqFe8eHhCYseRl97sjwbgqGi/pa7/cAs
	kF47jSaDidc4OeZZ2jZyoemgU6hm0xizb43+RH1M2/1nrey2B9wKovMUv8/t+X8=
X-Gm-Gg: ASbGncugiYvfO+eX07KiB9oiNAE6jCDaSH49av8sEwfQ67TKgo1wNeRo2erR1kobLf8
	jS7YYhRWHf9CD4TVFvDMvGUjcG6mJjq/zKozb2wkaBLzjWv/l9v63XVQmsi82Ovd0PAw7gmJ4ok
	1xU9G9c+dllYq9ualqPGaYTy4G7Ka/O0LwgsNVk4SrtID3shECvofIkn05eL8B1PQrImU2gly1h
	7zh62LCXNVgiqnXDV8NBvRGACgU9MEWj3XohLvKtoBpobTjEoA25pzU3A7FeEmvFHK//4oBefh7
	eQie8tzhCCjiLBgfUp3zMp6s
X-Google-Smtp-Source: AGHT+IFTKFYxT7pnJGrZdPmNe4XBatjjSmbkZ3phXPAo6n8cPTCpjh0TufWp+f5ZFCzEhuium/+FZA==
X-Received: by 2002:a17:907:774c:b0:ab7:a5f2:ed27 with SMTP id a640c23a62f3a-abb709337fcmr274119666b.8.1739638676408;
        Sat, 15 Feb 2025 08:57:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb5781da94sm217046166b.85.2025.02.15.08.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 08:57:55 -0800 (PST)
Message-ID: <ee14c4ef-04d9-488a-8304-75d9401b76c5@tuxon.dev>
Date: Sat, 15 Feb 2025 18:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: soc: atmel: fix the args passed to AT91_SOC
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250112-atmel-soc-v1-1-822937f1dd5a@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250112-atmel-soc-v1-1-822937f1dd5a@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Dharma,

On 12.01.2025 06:41, Dharma Balasubiramani wrote:
> fix the arguments passed to the AT91_SOC for SAM9X75 SiP.
> 
> Fixes: 5eb64f2b368f ("ARM: at91: add support in SoC driver for new sam9x7")
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  drivers/soc/atmel/soc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> index 298b542dd1c0..273c1420fd40 100644
> --- a/drivers/soc/atmel/soc.c
> +++ b/drivers/soc/atmel/soc.c
> @@ -111,17 +111,17 @@ static const struct at91_soc socs[] __initconst = {
>  	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>  		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
>  		 "sam9x75", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_D1M_EXID_MATCH,

As of [1], chapter 37.6.11. DBGU Chip ID Register, the chip id is on bits
30..0. AT91_CIDR_MATCH_MASK is defined as

#define AT91_CIDR_MATCH_MASK		GENMASK(30, 5)

Is there something wrong in [1] ?

Thank you,
Claudiu

[1]
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAM9X7-Series-Data-Sheet-DS60001813.pdf

>  		 "sam9x75 16MB DDR2 SiP", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_D5M_EXID_MATCH,
>  		 "sam9x75 64MB DDR2 SiP", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_D1G_EXID_MATCH,
>  		 "sam9x75 125MB DDR3L SiP ", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_D2G_EXID_MATCH,
>  		 "sam9x75 250MB DDR3L SiP", "sam9x7"),
>  #endif
>  #ifdef CONFIG_SOC_SAMA5
> 
> ---
> base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
> change-id: 20250112-atmel-soc-40c4b40c9b68
> 
> Best regards,


