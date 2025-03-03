Return-Path: <linux-kernel+bounces-541170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D79CA4B984
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A253AAA2B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E31E9B31;
	Mon,  3 Mar 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GTwMmdPn"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5034C85
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991066; cv=none; b=oQAd6CoYr8P4G3reLLHv6tWMffc40jljaeagRXbd24LkVew8h56sow2mWRAnV0B+P2sPGJ3myvkVKLIIYvzedTm1WKykF/vsUmP4OkChUtGzzMWFWL4a0Z3bsplDrlJMxSjmQA2NrWbvxeFYqKGpRqZchlvTRHnbDgTxferQGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991066; c=relaxed/simple;
	bh=RK+QYQOjVVok1aZddoO9G5Ba4alVGQm4Od6mXZJOVrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7ontAzi5NdWvHVCudWfYCsZXUZx+e74wV6eE+8hdxqElwcWa5YKUG3UQE9yYJ2o+lcD6HYNzU6J9nDXVTcfKN3DxkUa4dYtX3TAuFfvX3V9iY9xxeCg+YYCpPmMh0zJvhI5l3TGnyVOMk2NIRnOAR+UjMtm5zNBrZ0P4XFMg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GTwMmdPn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so6654058a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740991063; x=1741595863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=088gCiVsmCpfljLz/WNF5os3OZWs6Dr62hIApojY3d8=;
        b=GTwMmdPnOt4JdMYnuZd0BMPrJfhOGVMFGyaIt30eGyGKH88mrDBAzuCfb/8W5gXcoy
         Fi0uy9lBo5b+sX6jQwzO/TDHvHWK+HQ1iD2HimnqoKKc3X9eeKxHTqBk7fAMzKMe7ITd
         GNspcevs36/PtIIe/M4DnImUflW+aYnaeFBZ2YhmvcrpsGZFM7rNmzpGAJqBJ1tfWeC+
         L/h+qu3fKXDM9nLcrDaz281esofKd3ZoO1E+e7XW9UMkROxWf0HeLO8RKiKKWwvyXNf7
         K8v7lThakNbJ8u5gSwcEum02YRFL0CJc2ABSIZROxqE9G47oFCC9y5epW7El/7yx/rIP
         TR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991063; x=1741595863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=088gCiVsmCpfljLz/WNF5os3OZWs6Dr62hIApojY3d8=;
        b=LoKHd1ff3ie+ruQdpA9SPqrmHY9OXcNT0BVcgBCQVU3iz8dAq9aAfzqbhu6Ryc8BrD
         qGdCSIq0TPcQ444ZhVdHYsVibpi9239w/6u848BwUP0pfRO9KSp98Vn/s9EgOEGSOeFz
         QxkBtgzZYwnQbg338lpYM+gm1aj5cEUQ3IMnxd0P9GA4ba2pSRoMbBerRWZNFXn23wB7
         3veipjlJf6TiTyHcrMPJzRL/L4I3TR13peJ1GXwb3nqyv/lxFuAX+XQHn47/pzQu0WbT
         MfbyTqM92Xfem5evzQju1a5LswcVZ4apDl9VDR0J0K2iWS9dFXF4JLe9pXxfXg+SOeUu
         Zk/g==
X-Forwarded-Encrypted: i=1; AJvYcCUZY/UfM4HdpobvDw5WXafoGUTJnNwfJYiw0fqJC/DAGXrt9t9U5tlZooyUKBM8lR5O5+L4wOS4rrzUdrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/JVqM5kouTQi1bGHu8kABCMUf06tQpaAVdm+9nkwXfW6GlhA
	OQgAbcIyPEteEqWgbiol2MzCS+swjoVyeYWHMWK3+Hjz8S91cNl9Tvw/y0ZkAiY=
X-Gm-Gg: ASbGncux6FZ4WaVcbt1SzFyDjfnFu9F02cDPvXMhbrIAvp54hSXNfy+zI5ceJ+rPkzm
	HFvlrUdsF4ZooqQOT1EyKjXU95I55U/qOzTQBexFYFEdhvjpMtffbQ6rMoa3Ml0pU4rLWRdvzP0
	Eh9EwNEL6Ac60/84hgSA7fwvwFempUP8RHp+91pkCTlDbIMjNF1ng7fTZgURgSZ0cT/atPJJKjt
	blFV6Q2qkmWXZIS/xnYRE8rKR+PfKT8z6pTtVKPwycDFUe3jv6bxVhEn5mk9hVxzEfFGB+L91Hh
	sQNuE/BaYg4Hitv2wHq0D+Fj5Vo2IygpV0t9SRlRKadvVp+QwRInwXtz
X-Google-Smtp-Source: AGHT+IG+mwXTx4eDAQj8AAOugFy3UaMktA3JlzKQWx74RnnVc1/k+KU8S1qfjCYJPEbQsqpxnNFduw==
X-Received: by 2002:a17:906:6a28:b0:abf:749f:f719 with SMTP id a640c23a62f3a-abf749ffc45mr408409866b.7.1740991063333;
        Mon, 03 Mar 2025 00:37:43 -0800 (PST)
Received: from [192.168.50.159] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf19aca8a0sm730375166b.178.2025.03.03.00.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:37:42 -0800 (PST)
Message-ID: <45713e88-57af-43c7-bf0b-4583383b10dc@tuxon.dev>
Date: Mon, 3 Mar 2025 10:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/21] ARM: at91: PM: Add Backup mode for SAMA7D65
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <3a1f59af1ac9322b0203694b535d5d13120a31eb.1740671156.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <3a1f59af1ac9322b0203694b535d5d13120a31eb.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/25 17:51, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add config check that enables Backup mode for SAMA7D65 SoC.
> 
> Add SHDWC_SR read to clear the status bits once finished exiting backup
> mode. This is only for SAMA7D65 SoCs. The SHDWC status register
> needs to be cleared after exiting backup mode to clear the wake up pin
> status.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   arch/arm/mach-at91/pm.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 39644703244d..d82a507bc8da 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -647,6 +647,11 @@ static void at91_pm_suspend(suspend_state_t state)
>   		at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
>   					     &at91_pm_suspend_in_sram,
>   					     at91_pm_suspend_in_sram_sz);
> +
> +		if (IS_ENABLED(CONFIG_SOC_SAMA7D65))
> +			/* SHDWC.SR */
> +			readl(soc_pm.data.shdwc + 0x08);
> +
>   	} else {
>   		at91_suspend_finish(0);
>   	}
> @@ -707,6 +712,7 @@ static int at91_pm_enter(suspend_state_t state)
>   static void at91_pm_end(void)
>   {
>   	at91_pm_config_ws(soc_pm.data.mode, false);
> +

Not needed. I'll drop it while applying.

>   }
>   
>   
> @@ -1065,7 +1071,8 @@ static int __init at91_pm_backup_init(void)
>   	int ret = -ENODEV, located = 0;
>   
>   	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2) &&
> -	    !IS_ENABLED(CONFIG_SOC_SAMA7G5))
> +	    !IS_ENABLED(CONFIG_SOC_SAMA7G5) &&
> +	    !IS_ENABLED(CONFIG_SOC_SAMA7D65))
>   		return -EPERM;
>   
>   	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))


