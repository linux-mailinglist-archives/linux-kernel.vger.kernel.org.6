Return-Path: <linux-kernel+bounces-251816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C27930A35
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BB11C211FF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8B1339A4;
	Sun, 14 Jul 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j5uf584E"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A19132106
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964370; cv=none; b=RVw27TNaaPS187PadTy3fHE7tvYSkknul07PoCAXhkCuwPB8d7/jEPTjTxahssijI07Y8fVUTmYo0ow/F3+wdkpLiKzatGBaJSDYct/utCyhWm47xNJqx5c6lkMHP1g1+44JF6/11KswO6Vgb9Qg8VruCHwG4b2ocQqozlkEQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964370; c=relaxed/simple;
	bh=lwKoRXGvsudFiNuEtvPjA0tSBSVB9eqmCa6LqtqdozA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qF242zKSwzi8U+Ejfmz1LW4EWFWWXNwiE5+wFQzmAV3s3rEZ2fqyQ8A+MO+pvIY3EbQlZLySO5bVqocUeht2gafgFh6IaP07/UnKGbIQCN2nHPgm2M951QHzHSSVwrUpfdEAtTxREyZ0oNXNBVxx07KMNj6uP6y+lbE/Xf0OF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j5uf584E; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4279ca8af51so19119385e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964367; x=1721569167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeRWeo5XLCh2A+T+FF6zNBNjQic7g6CjwX+aj+Vgyc4=;
        b=j5uf584EaAnbaQDj2Kil796Zz1sHrHAtZzQ6u8a34KOJaXlUlKh2LrOLiQ8jOmyV6T
         8Ssut1kRR1OhYxInS/O+CQjJq7h5YLBb2mVW5LSoeyLjmCKoxrRrjAvdxZnNpMMBgw5O
         mOQUbcReoBStEHFT2FZwUIu+Ul9ji6zRAoXbIn9IxD1T+a1yEygZwcU4O2KRnhi0ocHt
         wDKdt4efVPKo4I1FPgN6XUB0rAGa4uFGiSTs1ZBPFHWLhwzkZxTpARL62Clz3WHYzSTV
         alc3dtbMatVaOH/mtwfYor6cw2NZqhKkMneMDvMY+Q1XuJouOna41itbN601z+9eF8I9
         phbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964367; x=1721569167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeRWeo5XLCh2A+T+FF6zNBNjQic7g6CjwX+aj+Vgyc4=;
        b=tnv1VIpa6vf+TfmstNBTtUupLi8dn4KyAd5YEshh04tVarPYU2Lm8GdDcJqzV54YBV
         jS/i9xn4DfwMWOlJi9tZGxqgQiS3i3gIh+Lc8eqXbjbCRVfkYsqwF2Ym4wo9IVyUuGuj
         Wrg1MFHysOek+CYFSSi5dOdJl7bdbfLFqbXwGgfZjbPE2cUq4Ac4WZVYRNfcK/xs19py
         cO+2moHntUHwrEdzHKz2B0aclcrh10F60+fejYA0pF+S1Xnk9P2VtpkDxkbi9mcBHc7x
         wmj9SttkexCtF6cAr3MwTk5c1D/rk+l3amEP/2cC1SGqPvqodMOrT00KbCASfGB1h8oZ
         Fpvg==
X-Forwarded-Encrypted: i=1; AJvYcCX0aio+w0VoEE6I+tU1mxN6evmlJl73a37avRvgVdn0OWgYG8uCY5gRa1u3qaasDiW6RZDXjXF4jE0hckn00y+R4fEq8FgWqwy3BI0p
X-Gm-Message-State: AOJu0YwI2Fe94mKvvrDFAxZzS/MY+O9QgUSWB2O8j4WVRHo38fi5cMsf
	KwXR4qNTdF7i1wCJSl3Yt9bjxqSaHooaDUdfX6unIRpelsY7ZcDW2iCKW4EnoJE=
X-Google-Smtp-Source: AGHT+IEVGLrWEsPnj95NEpsb3Z45VqnO/5iLS2m+J7kGus8Kl29Z3Yv3Qax48BNRFmUbRhzn9eFBsw==
X-Received: by 2002:adf:f704:0:b0:367:8a87:ada2 with SMTP id ffacd0b85a97d-367cea73311mr10586367f8f.26.1720964367209;
        Sun, 14 Jul 2024 06:39:27 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:39:26 -0700 (PDT)
Message-ID: <0efe571c-a2b6-4686-9442-9f93f8732e4f@tuxon.dev>
Date: Sun, 14 Jul 2024 16:39:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/27] dt-bindings: clocks: atmel,at91rm9200-pmc
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102722.195709-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102722.195709-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Same for this one:

dt-bindings: clocks: at91: add sam9x7 clock controller ->
dt-bindings: clocks: atmel,at91rm9200-pmc: add sam9x7 clock controller

I'll adjust it when applying.

On 03.07.2024 13:27, Varshini Rajendran wrote:
> Add bindings for SAM9X7's pmc.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Other than the title:

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
> Changes in v5:
> - Changed subject according to suggestion.
> - Alphanumerically sorted entries.
> - Updated Acked-by tag.
> ---
>  .../devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> index c1bdcd9058ed..c9eb60776b4d 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -42,6 +42,7 @@ properties:
>                - atmel,sama5d3-pmc
>                - atmel,sama5d4-pmc
>                - microchip,sam9x60-pmc
> +              - microchip,sam9x7-pmc
>                - microchip,sama7g5-pmc
>            - const: syscon
>  
> @@ -88,6 +89,7 @@ allOf:
>            contains:
>              enum:
>                - microchip,sam9x60-pmc
> +              - microchip,sam9x7-pmc
>                - microchip,sama7g5-pmc
>      then:
>        properties:

