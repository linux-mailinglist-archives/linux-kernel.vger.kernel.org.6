Return-Path: <linux-kernel+bounces-251820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3E930A3D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB61EB21573
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296651339A2;
	Sun, 14 Jul 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BZeZDhwk"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119312BE9F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964451; cv=none; b=uO4gyJeDOw0hj1ALv2iJmM2Owp5Pg9pB0UCAV7dzNXfolbzfqU3xqWUVNq6L+vb5AALNf1Nd0Z+yfZqJCseS997eff2yVowaulGsQrt6ApqJuCMvLiq7q+HZpvyFYStbXPy1mvNrKK2Zdbbv2tWAEmw2d1TEwxaqvWIcGGPFDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964451; c=relaxed/simple;
	bh=K9aqft/D7CygqBQnijeaNo02aaq5NRN+v0QxePzPgjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pvNSX8tD/F6NH+FsXlCj9O+BY3JFud/JjlIsnfv4mz+jr/cnKwKJDe1OE6AcBsIi9VdC+PKjVDR9QunFqzURhWHcclqFuiYkGcCnYKH+eokkX73ZJ2V/QX+8lC04bq9Nib5XLfw2H5TtomJdbo8emcRsc7AX2pFOXoxewXyQU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BZeZDhwk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367a3d1a378so3086016f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964448; x=1721569248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhjraO6W9CBYR3VaqXX1XTQ9HZgbWNHi4jVwrXXQGsc=;
        b=BZeZDhwkdE9ZC8/9vLusB/nHHyvmALl3yOL+Fz1lsjGSWsDNmxONYpf+w9HuK0EJRQ
         id/W4+mj+unOrMWVbHceLNzrtFigUp+9MNf13MyKWbosH591KuU7U2YTxn4sDWyXkMOW
         xL7nkmFEtJXJMhcuGfyIV2UYn/mrzZVD2Gb/xokZVDcH4oeTLyGTBZYF5zdKvKcHii3h
         WhDUaZuOdzAkrFfHG2jG3gpvlDYtJKNyrVV328F+kBjKZtBLL+BUhD0B4LgHYWp2iPVG
         x3PJlyBs7H/rY7amXlJxLTqQ5nS2xxqq8fjgb+MR9qe2u0qALOuPuFSz42aZwcxGWALS
         4Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964448; x=1721569248;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhjraO6W9CBYR3VaqXX1XTQ9HZgbWNHi4jVwrXXQGsc=;
        b=fCJAEfv7cNXyRAXeimOQxpizfwUtZi3akfQowrkEyfa7ELtWx4Rqi7IbB3MpTIA+Xk
         o50be9gFa6j75+3CcBPnijdlDEcgNB5Q1hFD6/8ElQtEK1yLmc/HuluvgrFXQAGU62gH
         A0PHIjJlNYuZ5Tv/qkjct3sS4loTSXZfG65o9vOW0BrNiE/sRl3KBJTcFqRmcjqrIClt
         LSdDQh/HuRT9l5Kj1c49pHcDXZav4IHeO4YSvuSMs30xTpJh8LddjUcMWsYpDV34Vaos
         hPIMIgtXYynFpb0f67QVSKOlSoOi6zxMdy9bJNBHmW7446KfW0qdQaVP7n+690CEcUNK
         6bgw==
X-Forwarded-Encrypted: i=1; AJvYcCWsK/wWNpCnkJeEtX+VBpEHfVqFyUO1gW2jUgT1g1kTMvzlu+7OmAUDdRW9ZQvX7lpXcMlUxbrABLh5FJ07QjIb0yrjw+A+LpWlUIrH
X-Gm-Message-State: AOJu0YxPgeEhzGFLzwYPeXWxVuThORkx4iG2HgjvAFW+z6ruTrNAdAli
	p5an6W3CkBfkgcrFmzecsDWknWYRvIADHBfH2dhbTFXSTuWk2K0zfZBSMVPgDmCcs4yAlWApa6N
	q
X-Google-Smtp-Source: AGHT+IGVgVs1XXLVVYQPby3MccHoy2uVZby873eGENmvGMTZEWRUybrfnzyz5CiKPBoXaTOk9n1y+g==
X-Received: by 2002:a5d:4703:0:b0:367:47e6:c7d9 with SMTP id ffacd0b85a97d-367cea95994mr13691775f8f.33.1720964448184;
        Sun, 14 Jul 2024 06:40:48 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:40:47 -0700 (PDT)
Message-ID: <595fcfb0-3770-44cb-9439-792edca23f5b@tuxon.dev>
Date: Sun, 14 Jul 2024 16:40:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/27] ARM: configs: at91: enable config flags for
 sam9x7 SoC family
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 linux@armlinux.org.uk, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, arnd@arndb.de, rdunlap@infradead.org,
 Jason@zx2c4.com, gerg@linux-m68k.org, palmer@rivosinc.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102915.196508-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102915.196508-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:29, Varshini Rajendran wrote:
> Enable config flags for SAM9X7 SoC for the sam9x7 SoC family.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  arch/arm/configs/at91_dt_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 1d53aec4c836..880f0c0f4cc3 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -16,6 +16,7 @@ CONFIG_ARCH_AT91=y
>  CONFIG_SOC_AT91RM9200=y
>  CONFIG_SOC_AT91SAM9=y
>  CONFIG_SOC_SAM9X60=y
> +CONFIG_SOC_SAM9X7=y
>  # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
>  CONFIG_AEABI=y
>  CONFIG_UACCESS_WITH_MEMCPY=y

