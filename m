Return-Path: <linux-kernel+bounces-251814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F3930A2F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3946F281654
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C869F13211F;
	Sun, 14 Jul 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ghOS0W+R"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F6131BDF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964337; cv=none; b=Xl0YLIRYYTsbOJ9uQZGAZTRmd3Hx7gBc0SomwsijumjxXsXMkjoirHK8svbi+Sw50m1dXdZJHNO1nhjZBMQ8HgmWrjnsSwIgG15P+oBOiH+lQAtgDtj19d97NforLOo27PvKK4NeXAPLgODL1PuiTGaw/d9/odoZaf6rR4mqzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964337; c=relaxed/simple;
	bh=B3xuHRBuHoa230RyJGbZ5wSJRZMe9eb0eEMIE4pfxng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lNA9TAeodmafkwi7WCFlH1USJd8TRiv3pT3KO5hfDL0E4YKlzHtOScTOG9XqsrDeo7bHEePgyP5UcyUUKsd92AZNEcROzmY6mLQTS0K5gPcoEY9N0DqU57laJb089WL6Rl+LFox21awKnw+NvdIwOtfmYZkAst3VQNxDfsNGb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ghOS0W+R; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4267300145eso26794565e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964334; x=1721569134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r39c9BCN+jg7BbDLwYi3q6RBwDCZYgJj4DGme1UyFk8=;
        b=ghOS0W+Rv5e+9STuJ0x5VdBI6oWU1jBwiwBg7g4MX3v6gIcbqxvncnSju/9WQDDmQU
         +F1OCm0daxEAoKyKwCnm+3ooeaQZt4duJftqD9DB2eeU289JLSMRC34N8k+3HfbMCO+V
         sgE1QsSx+l0Skjvw5gbWmpdQDkxjlXhi1LiRS/mLGt78raolAaYnxR4t1Co9aKRR60uz
         5DfPtRgk7DNyu5oY++cYm1HYlPSpvNrjFVJgc18fFH22Wga9ct8YVTa2ilUm4B5yXmjh
         TiRVdC8HEWgmkP6c8ILl4U9N0N1weweuguKrKxQZbKdGkIQpGfB1PUe1+vyX0gwiSBbH
         Ccqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964334; x=1721569134;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r39c9BCN+jg7BbDLwYi3q6RBwDCZYgJj4DGme1UyFk8=;
        b=g23mfZ1czkXUoF92RKSIDodP+RM2QoieOzc/dqv3DpNfwx7tmQu/q8FQiBkL3GcoXM
         qlWDbf6OLC5xqRdxI7J+nGBdIejYyHORGLjhPOHJUJk0mSzdi1rk4JFl69xZ18+dWFIS
         ZfVK3+7U3vJopu2OIR2/tNoDvih6G/8PATdAQ+F4F/pOt0kPFOH5VvDJDHlQReoJmoyI
         IJq7FYZuUPBvMF/b9qMZc8G9sVj3b6fg+QE1TUCrVKa8nZWW8/VjzpqTdNl0kCOfMPtx
         w4o6wGOymHLYYaTo3Q8BO6OD5u88Z+Ln0BtyOpRbUxg1aSkaGBn6swFzEHgTqz4JsWyf
         2n2A==
X-Forwarded-Encrypted: i=1; AJvYcCVowrBwcOY4kFB0e/CODYRUUeWsKOIYyAH53u3kX60El/C9ACnY56mvv1yW4MWPgfCBeebC7MgjqkVqhx95QSqBxPzOLXTllHo3+V1u
X-Gm-Message-State: AOJu0YxyvGoIm33nicAFKM0Nfo8WYx/o209kO1t0+SOUhBVlXhjBKGmD
	9A6mZzIJicrYZIgSCJ0T/AsvVWEQ4bM2Oa4dVMdIx0yjTmUE5NRLeT8KypxtXuw=
X-Google-Smtp-Source: AGHT+IE4jtSEO1yWmx3Qfi8/Ckim4CjNiCjfZEXUY8ozTD2+o0rwCjYBEaETyLa0t6w2X2UpuO1rHg==
X-Received: by 2002:a05:600c:22d4:b0:425:81bd:e5ee with SMTP id 5b1f17b1804b1-426707d07c5mr146355945e9.16.1720964333986;
        Sun, 14 Jul 2024 06:38:53 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:38:53 -0700 (PDT)
Message-ID: <c6e9f1d7-b262-41ff-87cb-6087004b6fdc@tuxon.dev>
Date: Sun, 14 Jul 2024 16:38:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/27] dt-bindings: clock: at91: Allow PLLs to be
 exported and referenced in DT
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102749.195907-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102749.195907-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:27, Varshini Rajendran wrote:
> Allow PLLADIV2 and LVDSPLL to be referenced as a PMC_TYPE_CORE
> clock from phandle in DT for sam9x7 SoC family.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
> Changes in v5:
> - Updated Acked-by tag.
> ---
>  include/dt-bindings/clock/at91.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index 3e3972a814c1..6ede88c3992d 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -38,6 +38,10 @@
>  #define PMC_CPU			(PMC_MAIN + 9)
>  #define PMC_MCK1		(PMC_MAIN + 10)
>  
> +/* SAM9X7 */
> +#define PMC_PLLADIV2		(PMC_MAIN + 11)
> +#define PMC_LVDSPLL		(PMC_MAIN + 12)
> +
>  #ifndef AT91_PMC_MOSCS
>  #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
>  #define AT91_PMC_LOCKA		1		/* PLLA Lock */

