Return-Path: <linux-kernel+bounces-301998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A588895F86B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD8228409D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1445199221;
	Mon, 26 Aug 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Jz8dOTWO"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB51991CE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694136; cv=none; b=TDfCZPHOmZwNiYGCTdm+UN/uxun30EPeoHo7atM8IsK5sA/EhFtZrKHAiiog1/MyMvcfNVu+BwOHxpEba1PfJtoj8gkkSe70tegi40hDM72AEgXHovDYDszJdr15zomIxD8ZoB7VJurouJ/hlpDzKRK/BhroxO7PT+1iwGm0PxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694136; c=relaxed/simple;
	bh=rhJBniTHjY88Us32RAgfhKeGcN7GL2KlDbC4HgbLOGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOrKCa6HHSOb7selO4MDLpGnVqKkV5sl5G5jehPlJllwhwBo2oRsaLvZmvuiArwDvlMp6MwHNxGBkIQHurgmGfJSQdnPQnU4sV9a8dDNP5fViDCe7lBRmTPLfuVZHMFnz9VE7bcd9fQy2nJdCgXs1seSAJvkPPW9/ZXSzFaiato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Jz8dOTWO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so9043807a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724694133; x=1725298933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFiCyxYJLEqGs500HvKL/JsZpsQRPQOlGWk1hMAooLM=;
        b=Jz8dOTWOZ+Hi4hCWUUDbofQQ+Ln1vYRYZmjmm17P25AlcWrNd91FLsHFlKosU4E09O
         Jzq8lwJl0yV/sqQ3LuNO3Xw+/9QS6Yfnv3vGOMmuBLi2cYYdgPtatwYhHbJubDz1yfYX
         LoaZ5mo+hoaNmg0OwRrbelsjMi5JkY8A7iwZo9Yg0fOMsBi1aWFulfaH9beCKsyvJ1i7
         +TbynLs2yHFj8D6QSf3uQf/subLrRwmphJnEvZdGFV9+S0vVkb7oRlMVDvFEKxLDas/R
         WRmTkTDTKYJw2oIhZKKyOo29BfbFJfhcRQA1GGT10bRafWXM9U+mqTD+tAFG3vYaWP9I
         5prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724694133; x=1725298933;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFiCyxYJLEqGs500HvKL/JsZpsQRPQOlGWk1hMAooLM=;
        b=juq079+vzD5J1I238rCruz61n4hBaZqd+mavpkrAeHFeRfS+IPQlvbclWJJMdah5EU
         9Bm/iKfdJDWE3eq2rdKVGhnnjjoAsmapYXEiW64IS4FE4IQVI9FsAnOS+IilOGFYvg5a
         qtTqiy4F6oXcbK1FPBNX8yPiJmZALdzZHK2ITu5DUn3vvrJUf93Y5QDOCPGzmSSZX4CQ
         Ber22CGpxAodNQB63BvRL1p/NkOJMlBmMjrrx8ZCR1ud7DEcGZ7aa9n94NCum1tnGv4a
         1XlSX93rwY/d5i9k/qXjbtPHkd+fqT6agS85GgtwMhW5h4aYf1I/3dkeZsTGYBppiK+v
         +kmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT+15CORTkegQvw32PihDN/pQ1CKk3TCR8VUOlH5NLagB19AnTyKxLpisyzB1oxcUJbxtO78NisUo+PSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCD96JYzgaYpxh/UkUoddz06AZR9tlAhROOvabg7BmHrHFp5ef
	9179zGY/P6RtTuKMs3e4XW7pK33y/VFLB8bmbuJqkw7wzOfv8cg8QfXswNDqCnQ=
X-Google-Smtp-Source: AGHT+IGK/rDWQktFfcdGSgq6zs7nJIlhwN6w7cv1hF04+Aui72thInt0zEQ9R8DGVui0QugunH9n7w==
X-Received: by 2002:a05:6402:908:b0:5be:ec0a:c10f with SMTP id 4fb4d7f45d1cf-5c0ba195954mr376953a12.2.1724694132631;
        Mon, 26 Aug 2024 10:42:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb481f50sm4519a12.86.2024.08.26.10.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 10:42:12 -0700 (PDT)
Message-ID: <8ae724e3-f467-4df4-b8cc-f03489bd0f35@tuxon.dev>
Date: Mon, 26 Aug 2024 20:42:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: microchip: Use SCKC_{TD, MD}_SLCK IDs for
 clk32k clocks
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240826173116.3628337-1-claudiu.beznea@tuxon.dev>
 <20240826173116.3628337-4-claudiu.beznea@tuxon.dev>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20240826173116.3628337-4-claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.08.2024 20:31, Claudiu Beznea wrote:
> Use the newly introduced macros instead of raw number. With this device
> tree code is a bit easier to understand.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> ---
>  arch/arm/boot/dts/microchip/sam9x60.dtsi | 18 +++++++++---------
>  arch/arm/boot/dts/microchip/sama7g5.dtsi | 16 ++++++++--------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 04a6d716ecaf..eeda277e684f 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -560,7 +560,7 @@ tcb0: timer@f8008000 {
>  				#size-cells = <0>;
>  				reg = <0xf8008000 0x100>;
>  				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
> -				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k 0>;
> +				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k SCKC_MD_SLCK>;

Actually, looking again at it, I don't know if it worth as we use numbers
directly also for other PMC clock IDs.

Sorry for the noise,
Claudiu Beznea



