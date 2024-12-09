Return-Path: <linux-kernel+bounces-437460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA69E9389
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC62282C7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7121D008;
	Mon,  9 Dec 2024 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="k5s08lx+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920E22069F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746238; cv=none; b=KIvzkHcUkoYCxi8wlsaPgYFYwENlbCus98oI2FelmwwJgAAqeQGNlZjjPLTYz1b8ArK1GbYV38Q4Olqv2rELAeBuJ5+eXG+1yzcpUt47m+DC3LH2I1HDiQCny9mTZP+Kmb4K8AquwnNX3eKlk/Ze98+8jhDB54V0FRazwiB5xhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746238; c=relaxed/simple;
	bh=E8tkYJODIHheFUnS5WXIUldliI7SSiXfmfMfRYvHoDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyPCm3Z6Y8yU1C2v7NGDhuM4zyjmGjp0TnzHSu4ZPtJTWbpXr+BY5alanMvFGQl8tnzPlsYY6WYlZIwKKAa4OMaS/I7/e0DgwNqgoaMUKT9VhPa5awUgcQPeZPns3AIOelLRifaEoNaaspTcLShk6iIpcU6qLNKvZxa6++OeicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=k5s08lx+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a044dce2so46301495e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733746234; x=1734351034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHX/J4FydKfXDM4LudMI3jraYFA+WTkpN2SeJgrLN0k=;
        b=k5s08lx+uAqx7VYlqsWlNAubDoTdUuywEmNmcE4GOBjtTtsA7WVOfLOnLOzRQSg06Q
         Al6x4B6WMpZWpkEO4wWMqFjs5h5OoYUboU+UQL93zV2MUZPR/xO6jrFYMX/DRUKTP+tz
         hF5v3jZTJWzFwxHR/H7AueSKd9EJpRWuFG6VWOsPwijHWZ0lmfvT7MVLMmieCJ3/E7ak
         NSm8SRms6lcjquMsHK4vjapWbxVkJbFQwadyFKqcg4gif/BFuVPSkVlh0S3NShBTWtA8
         pfQ2swySFBvBKSKkFCBjpizpPgJb9WKwpMBP0uRQj4DmjS0p+WoaIygbWirJeLHIloqF
         1niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733746234; x=1734351034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHX/J4FydKfXDM4LudMI3jraYFA+WTkpN2SeJgrLN0k=;
        b=LKpqcgk0hiCXRs4Jnz+xhyAtteqsyN9UMggFowkGxqef+oNwQXCXX2UwPKIJ3HO2Zi
         YOWhtOOh/03bnb3rkCq2rafjKJstx5KZpuI0IacjLHO15oLdysy+Fta6rNzlqyt/P0VB
         tluS1gQJwStP4sv0n9iPaWngCdcpSgjK2ERRomTQw85fRCWc0pvXVe+tw9w7Tqtf5Fl/
         HmUXZslxnlySkmoJ+j9ZujL1EHnfqvcEvPQV6cKhuUBdxREHD3cN4Jzm5pP5NaYmpD89
         oWVmle4HfBeb1CvVvMwf9+5on7ocCRarhUq0nubUPfzOBnj9tx/EW7eS2uCqbLdDKXMN
         47wA==
X-Forwarded-Encrypted: i=1; AJvYcCXKdTYilNrYo01sWGeT6kKfcdrbVRJxowqdh8aAEiHg5UudT3aiFQoFgpDhLVfsULEtNGuT1zR2S39SRL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGGfooLgshQvjYcFltTUrQSRW2tnK7WoJoO+p53Q47OGqEw7Z
	vmcxaFfDMSe2B2ECK3NwYjAGYITfF7qxz2J4f9NdEIq59Y4NZHxOjW/bbXZtocc=
X-Gm-Gg: ASbGnctYS7cKcVJrzorsDiplGB+RI60Q/Ib2XzK0RwbOpMlQhHVUNpFvvDyyEOPHQF+
	9p4EaR8mrYQwHgSA5JPzsCxL10P4omVIrK7NFO4GC1BLi8i3229VTUcNpD3ct1Sl8yGWvDEQLcF
	1MaxolWn+/EzO9Xayb+bI0cSYQtEHz+hPN0NHUT4kzBXTjQeeEovUkxSfNJGDwwfVht1PBIM5wl
	kTuth2kIWxp3K0+ML01daX35ERgLL3roVgn42hvgppbEZhadfXOAQ60Kyw=
X-Google-Smtp-Source: AGHT+IGUfN/EA4JH6RTVsbnUKthIOhG2zwFRZUFAX7rqRG2CHXvmm33MqQPTkWqeEZrSe9CBG7Ax8g==
X-Received: by 2002:a05:600c:4e88:b0:434:fddf:5c0c with SMTP id 5b1f17b1804b1-434fff30e74mr2642745e9.4.1733746234205;
        Mon, 09 Dec 2024 04:10:34 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434e8bb0390sm86199035e9.27.2024.12.09.04.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:10:33 -0800 (PST)
Message-ID: <240a461f-9c46-4f02-81f9-b2c7453fa1f4@tuxon.dev>
Date: Mon, 9 Dec 2024 14:10:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] arm64: dts: renesas: rzg3s-smarc-switches: Add a
 header to describe different switches
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, p.zabel@pengutronix.de,
 lethal@linux-sh.org, g.liakhovetski@gmx.de,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-serial@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
 <20241115134401.3893008-7-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVgxKHw4PDbgOGAJf7xsRR1Uyzxu-br+=RK_1ouHoj41g@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVgxKHw4PDbgOGAJf7xsRR1Uyzxu-br+=RK_1ouHoj41g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 09.12.2024 12:09, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Nov 15, 2024 at 2:50 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> There are different switches available on both the RZ/G3S SMARC Module and
>> RZ SMARC Carrier II boards. These switches are used to route different SoC
>> signals to different parts available on board.
>>
>> These switches are described in device trees through macros. These macros
>> are set accordingly such that the resulted compiled dtb to describe the
>> on-board switches states.
>>
>> Based on the SW_CONFIG3 switch state (populated on the module board), the
>> SCIF3 SoC interface is routed or not to an U(S)ART pin header available on
>> the carrier board. As the SCIF3 is accessible through the carrier board,
>> the device tree enables it in the carrier DTS. To be able to cope with
>> these type of configurations, add a header file where all the on-board
>> switches can be described and shared accordingly between module and carrier
>> board.
>>
>> Commit prepares the code to enable SCIF3 on the RZ/G3S carrier device
>> tree.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> @@ -9,25 +9,7 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
>>
>> -/*
>> - * On-board switches' states:
>> - * @SW_OFF: switch's state is OFF
>> - * @SW_ON:  switch's state is ON
>> - */
>> -#define SW_OFF         0
>> -#define SW_ON          1
>> -
>> -/*
>> - * SW_CONFIG[x] switches' states:
>> - * @SW_CONFIG2:
>> - *     SW_OFF - SD0 is connected to eMMC
>> - *     SW_ON  - SD0 is connected to uSD0 card
>> - * @SW_CONFIG3:
>> - *     SW_OFF - SD2 is connected to SoC
>> - *     SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
>> - */
>> -#define SW_CONFIG2     SW_OFF
>> -#define SW_CONFIG3     SW_ON
>> +#include "rzg3s-smarc-switches.h"
>>
>>  / {
>>         compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
>> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
>> new file mode 100644
>> index 000000000000..e2d9b953f627
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> I agree with Rob about the license.
> 
>> +/*
>> + * On-board switches for the Renesas RZ/G3S SMARC Module and RZ SMARC Carrier II
>> + * boards.
>> + *
>> + * Copyright (C) 2024 Renesas Electronics Corp.
>> + */
>> +
>> +#ifndef __RZG3S_SMARC_SWITCHES__
>> +#define __RZG3S_SMARC_SWITCHES__
>> +
>> +/*
>> + * On-board switches' states:
>> + * @SW_OFF: switch's state is OFF
>> + * @SW_ON:  switch's state is ON
>> + */
>> +#define SW_OFF         0
>> +#define SW_ON          1
>> +
>> +/*
>> + * SW_CONFIG[x] switches' states:
>> + * @SW_CONFIG2:
>> + *     SW_OFF - SD0 is connected to eMMC
>> + *     SW_ON  - SD0 is connected to uSD0 card
>> + * @SW_CONFIG3:
>> + *     SW_OFF - SD2 is connected to SoC
>> + *     SW_ON  - SCIF3, SSI3, IRQ0, IRQ1 connected to SoC
> 
> Note that the original comment above says "SCIF1, SSI0", and looking
> at the schematics (IC7 and IC8 controlled by SW_SD2_EN#), that is
> actually correct?

You're right, I'm not sure why I've changed it. I'll fix it in the next
version.

Thank  you for your review,
Claudiu

> 
>> + */
>> +#define SW_CONFIG2     SW_OFF
>> +#define SW_CONFIG3     SW_ON
>> +
>> +#endif /* __RZG3S_SMARC_SWITCHES__ */
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

