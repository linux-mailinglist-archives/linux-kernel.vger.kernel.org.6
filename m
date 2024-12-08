Return-Path: <linux-kernel+bounces-436470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598209E8647
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520121884410
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2515CD46;
	Sun,  8 Dec 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FlAE7rAS"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115961586CF
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675007; cv=none; b=ml84nq3GyVhdwwD22UV8ulYfmaHLOBxGK0tXLeEn8GDP9d5GFPK5VX0YvOWcNI9EnLjUnzKYmFpy5KqLg9oYAJzIeQiIIU+FeagmuZTdJj/Y5FXi1mYQKidMTOn1jYbYQEKSeQSC8cdkhl/PIHPbSS77dKAn+iR2JPg8TI4GFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675007; c=relaxed/simple;
	bh=JsGq0YhaA/fjrB5i30iNldjy4eoZqlyPCHjVboORafM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6LNyjVbrk7SR2cRlvG6D0skNS0O1Cf7nW+WqSzMiuY8XwhnsoQJ2fYDLVzb2RAPd44mUtWOEtZx26eERN9S/LiigqIqdKXw6gu0QVJpY7kPTNbD1MG1hxPLWE8wfKkCCHJUW/mo1qBgIkytUC4zvBCQbwkc86WNji47rcQFaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FlAE7rAS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so1550828a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675003; x=1734279803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Ja4iyQmAzISPsWmv2Yy+J9mTuONiwkR0YrQmpPL14U=;
        b=FlAE7rASzQNuKr9euzhs9NzZvBARBYt/IpnehyvTb2Wy5sL4zB0eTp5N9X6agMmUqb
         0h9+3AhChPJObIzyWK37nEiK2m0Po2I4aYYNFOgnbEHYmYI8BEbJtcvBac8LozdrUn1+
         63l1VJlqJNHYyqXjdbBabCVY4u8eA6xCSZqOf1CNwZlD6Pp8eEOsrUqsC3wl31ZFunwz
         ouBnXinGMtGMmuG9ZII48//6wXYCvtKggsg29rC1oAThHYHv1LLdDlXfklJT/BOFvKh6
         BPu9vvaK5wgHWMwrNS1p5ci1Ii5+DYSmjx4Q+Q5UvO2t/CG46NWI+2xKkEoPgZuqit7i
         tbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675003; x=1734279803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ja4iyQmAzISPsWmv2Yy+J9mTuONiwkR0YrQmpPL14U=;
        b=RYF5yYmfnl7BOyo521utSd5cHiHs1PvtFh9OfUjWxTQiIvO2TOn9VC5FQjlK4zBwok
         e+/8tiFTP4CcgcwDGtxjato4JAoxviatVIYRzntSI+HkP6byJNyGK1q2V/kiXx6qHmW2
         A604Zq/40b8GjtHqeA7564erodgBNTD4NK1IDTyaqP4ClTdIWSvZaQtEIK9ImwbRpmG2
         3mKXX6eeBqnvQF8ln9JyfqKVuZqpy+FxgZDdPm2HECH/kcpJ+hWC+K8Hk+yBlSj3MnDa
         FbCyQ8qPRnstGIS3sumDarq+VzvMly95L8lCkP/pljYvtHO1hE5yX+a0aUrl+8R+gBki
         eAMw==
X-Forwarded-Encrypted: i=1; AJvYcCUOzn2/Uayz34wibjashEmDeb90SRZsakvduFUGx/oQaJxn1PnjrHBmwrdB0EciwrzG3RngVbBc2p9wZCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyt4nTn73ldlB1mG5cVw/NyFjR+4mBUX9LSFtlDKRfhOMr1zgV
	ySWkX5iLgcGbcI58rT9lUCMh3+VGvsDMitNTlM/s60hsX3+FE6vbZmnt3RdMLAA=
X-Gm-Gg: ASbGncsfbR0Su/7A97c5m/qydQAsvNwIiH+GTNT50hOh58UBsHi/MJa3wSznaa6KH4d
	uPgw/Yu0P/dO38q9gRquIO9baiYNnFlaYpeNTdVCQ6zmrGVkOBSucf9j1l3yy74MPK0qlKssW+A
	yiR8+bQErBJV5vzOH/rdBY4OkHpp0TS/c7xj6iD+itOpgzrxDR9ZEEtEUTRn82t4KLqqYevjY8/
	L8jiZQpnMdAyzJWfBJ4hdfrrYPBigsNgmlFmIXkmdiqLKNMU1da0UrP6iq0sUY=
X-Google-Smtp-Source: AGHT+IH86UBvGGnyAV0eg40dVkna/XfNJd8hDIG21j22U90IZW6G8d+OfAAcOP2EKLLK8RxyDrgbuA==
X-Received: by 2002:a50:8e1d:0:b0:5d3:d7ae:a893 with SMTP id 4fb4d7f45d1cf-5d3d7aea934mr5930138a12.25.1733675003295;
        Sun, 08 Dec 2024 08:23:23 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49e48sm4883698a12.30.2024.12.08.08.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:23:22 -0800 (PST)
Message-ID: <40084072-8581-49b1-b0b8-e3c63dd39f3a@tuxon.dev>
Date: Sun, 8 Dec 2024 18:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] dt-bindings: ARM: at91: Document Microchip
 SAMA7D65 Curiosity
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <d5a22763a2081daa0d2155e2c05b7dc0eb468610.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <d5a22763a2081daa0d2155e2c05b7dc0eb468610.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Romain Sioen <romain.sioen@microchip.com>
> 
> Document device tree binding of the Microchip SAMA7D65 Curiosity board.
> 
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index 7160ec80ac1b..0ec29366e6c2 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -180,6 +180,13 @@ properties:
>            - const: atmel,sama5d4
>            - const: atmel,sama5
>  
> +      - description: Microchip SAMA7D65 Curiosity Board
> +        items:
> +          - const: microchip,sama7d65-curiosity
> +          - const: microchip,sama7d65
> +          - const: microchip,sama7d6
> +          - const: microchip,sama7
> +
>        - items:
>            - const: microchip,sama7g5ek # SAMA7G5 Evaluation Kit
>            - const: microchip,sama7g5

