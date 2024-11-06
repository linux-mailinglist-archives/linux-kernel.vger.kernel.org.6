Return-Path: <linux-kernel+bounces-398457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62A9BF18D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B66284949
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C1A202F87;
	Wed,  6 Nov 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eAvksleF"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39466200CB5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906716; cv=none; b=lzFmK5SNkk8JB7hQt7GBEc3+6MMOCyDXZWtqyNHBmh5n5deDvv6GFV1x0Zka/EQrI9LXBbdL4K6NrTZA3hitxXZsc5eLA1Ul8OmdKauxgWB9yyJdmb73DK4Bh5UhXbL6LkkPvpJNZkrLiM6ygixzX1gYlNgVfKmZhvUSid4D70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906716; c=relaxed/simple;
	bh=825fFcUQnPqu974K62Cc6TOzabToD2+pOzemxF4MwRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kt+f4MMSb9BRkUlPL7vrN/4w3KLujy3c82wkbpVoEsrndo21ocjap+w04CEoDCgdP8lPg8BpFblJwCFRlLKmc/dqrQKCAFolnLmhtEpqXMXKdTuF9sSY2MaekL5y8FL1/sUsh9d0H2ReLUNm9I7bdeCo1w4tkemR30E6yk1XJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eAvksleF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a68480164so1022792466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730906714; x=1731511514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpz0KPFgwBV81mrLK+Jjg94JN4iKvNSkamb0eOPZLK4=;
        b=eAvksleF7W+C+ALDEBsiL1juBKu4OBb8yTa1Uos7IDPpjRzWA0CZkV4wDVvq2ubycU
         Ft1338HVt9x6/xBsWOh11mGoRQcs4Q3Humzxpd321W1ydp6fNVCBzXNlpEl7wMCHqJ3v
         M15fNINekBH6k/t+HanQpJNZVzIp18KAnAx0A0se/8nx5S1PrDd1cBWaIWSyn6JoAH6+
         2x2vii6jgBe1SbVnAFVbI8SsHMtqm8Tz1RV8oa/4Akr/n0hp0RUF80+nXI+uHREaCZsK
         8DFEWbUeyS60OtSybjOw2o11rgdamI52QSDgm31ETdpHr+4R5TL3TAdQ9YNjgUzllLRd
         yUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906714; x=1731511514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpz0KPFgwBV81mrLK+Jjg94JN4iKvNSkamb0eOPZLK4=;
        b=ZR6xOaM3s0yHqZNRDzdsHfyO85r2gRkNjO47oqopzegXUz+TsHg7xgzsrLWbNzQwGX
         ITpm3NfS6ej5BKfmRFN1oTf/KPxkbDezMQDe61dDqZ2q5/4BE1Uoe2pyIhwX859CLnY4
         ewaevwoQ3pVNyEWGTrX4SxFAqYCTsqxpvRdQwW/QSnP9YpGRd6nwPVgURwl7WbiO/zxI
         MrqrFivL/PYBrl0hm7jzAbcDh/F4eiBZTsriu+Vzcni3UjQrBHMd8c0CjS1hki3L+Rdf
         16Gvb0998GV/hYH4ZDS7e3S0DdyXKf0FYVe93nf0at4wFrLdMISnHZ1szaVPcbzSm5+r
         2ffg==
X-Forwarded-Encrypted: i=1; AJvYcCW0cc89JOYUeoQap7P3AIaFp2sO4YGV/wPRPcfNbq9V9e0CGPv1kI5E0T0diuX1zgSgNyU/M7sfPNBDeUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiz0YE3MLFU2CowKkW4I7LuPlmiExmvhMGVeZu12yuzwRbwcRU
	P98WKdwdquIBg4JKYNPav+YE1OHC/aiobolFBprG4Kuu7/AL0LDQ6GWWSLBD2PE=
X-Google-Smtp-Source: AGHT+IGCsBt4YImQ9v/cxMm8F2bd0t7nztI/dFwfKLybyOThX/4Zc2NTUaw9MVXNyjcZDUzvlEvVaQ==
X-Received: by 2002:a17:907:1a4e:b0:a9a:2523:b4ce with SMTP id a640c23a62f3a-a9de5c91985mr2353019666b.6.1730906713378;
        Wed, 06 Nov 2024 07:25:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1814086sm294320366b.193.2024.11.06.07.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:25:12 -0800 (PST)
Message-ID: <5f524886-7479-44d7-b94f-21207c5a9ff9@tuxon.dev>
Date: Wed, 6 Nov 2024 17:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/31] ASoC: sh: rz-ssi: Use a proper bitmask for clear
 bits
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lgirdwood@gmail.com,
 broonie@kernel.org, magnus.damm@gmail.com, linus.walleij@linaro.org,
 support.opensource@diasemi.com, perex@perex.cz, tiwai@suse.com,
 p.zabel@pengutronix.de, Adam.Thomson.Opensource@diasemi.com,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241106081826.1211088-1-claudiu.beznea.uj@bp.renesas.com>
 <20241106081826.1211088-13-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWxmoUQSSnAVdqhpTQJYvUCJTL0EZbdKmLLhFWi8UCGkg@mail.gmail.com>
 <4e233ebe-b0e1-4b37-9063-bdbeb5980b13@tuxon.dev>
 <CAMuHMdVrKoyRuaa=jtZ5SJ3OX8ytGyN_jwv2uKX2ohGpg6yiuA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVrKoyRuaa=jtZ5SJ3OX8ytGyN_jwv2uKX2ohGpg6yiuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06.11.2024 17:21, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Nov 6, 2024 at 4:17 PM Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 06.11.2024 16:56, Geert Uytterhoeven wrote:
>>> On Wed, Nov 6, 2024 at 9:19 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> While it is still correct to pass zero as the bit-clear mask it may be
>>>> confusing. For this, use a proper bitmask for clear bits.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/sound/soc/renesas/rz-ssi.c
>>>> +++ b/sound/soc/renesas/rz-ssi.c
>>>> @@ -331,7 +331,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
>>>>                 dev_info(ssi->dev, "timeout waiting for SSI idle\n");
>>>>
>>>>         /* Hold FIFOs in reset */
>>>> -       rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_FIFO_RST);
>>>> +       rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_FIFO_RST, SSIFCR_FIFO_RST);
>>>
>>> But you're not clearing SSIFCR_FIFO_RST, you're setting it?
>>
>> The bits should be set to reset the FIFOs.
>>
>> By "Use a proper bitmask for clear bits" phrase in the patch title or
>> description I was referring at the 3rd argument of the
>> rz_ssi_reg_mask_setl() function, which has the following prototype:
>>
>> static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *priv, uint reg,
>>
>>                                  u32 bclr, u32 bset)
>>
>>
>> Would you prefer to rephrase it in the next version?
> 
> The idea behind such functions is to pass a bitmask representing the
> bits to be cleared to "bclr", and a bitmask representing the bits
> to be set to "bset".  In this case, you do not want to clear any bits,
> so the "bclr" parameter should be zero, and the original code is fine.

OK, I'll will drop this patch.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

