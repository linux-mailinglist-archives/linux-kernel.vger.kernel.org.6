Return-Path: <linux-kernel+bounces-233752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1591BC8C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDB41F23B40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD514A60A;
	Fri, 28 Jun 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QOIo8kNK"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E741C683
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570307; cv=none; b=JSNSmHs6ISVNRxgKHEc8g8e/sPc/BATrb9VkqJedLuEyKff20no+L4GRgfAmqNuFOyPVwXzpqIxk3M1T7Xwz+alsYvjjQGnfURcoCwNGZRv1YFDvsJfAKU8eHlsqfNGaB/b84nRrGMufVm8fHen3LUrvsrkUjhSfUi9m//z48tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570307; c=relaxed/simple;
	bh=MVyx2NMoaPvHZCjJ1KTjnoPDy9zuh97wN1Tq2drBNvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1q2aovyC5BdEUNFaBWQEMXU4NzbXsHl414fsVOq2CgmXdsm+lJyKHVcxAlslHz5tux9hLdR5+59aGEdjana5ssrUwQ1K5qzF71V+md08la2CZYKl4PV5M838W90dBLMBDlp4xsfFrVadoerrihp6ZrI6hePO7fWHK9pLIb7o/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QOIo8kNK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4256742f67fso3472535e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719570305; x=1720175105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nx+ADCri5fDjbQqI/n1BCN4tgTo26I/0S6XiQblv+fE=;
        b=QOIo8kNKjOXfcLyvqzGniNagnIzAh5pB+Dm22li7mP+r7r1lgCQUD4tyIm4YE8TlKW
         lYp7DKP0TnhTIOtzm6MxN56cQVsLwfApCBCtf6BW5Hi9hCM7KG98coMPdSDwdN1fTiSM
         HPEphyYCsdPksBvoJjB7tkyzPZRacYsDLe9DYNTAkrIrLo9aje03dEqyckO5wC9iir51
         WOXpoFcpnQykJ3rXt/gbX3v6vuGcI3Ka/SNEWCb62BCujmSfUtnBagzbiQNiuBPq3T/9
         wFgV9dgW91JbRt8ZNJZBznGJ53xYqulx8Bi5bLyiKzFo5aruTh99vTtPKfCNeZkVVAJF
         C5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719570305; x=1720175105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx+ADCri5fDjbQqI/n1BCN4tgTo26I/0S6XiQblv+fE=;
        b=d36mwwRNLZsGoeiuX3PVGOM3ejfB6hvqmFB1dzXEJLJCN6Y4tNV9Qq7gTy7dPPFNwG
         lkGgwbMo0o1EKNCCiZcrjV59DK8SaMdLAQbDTP6pZGUp4dnbbdBC586+eF3w95kAQlM4
         lcdLl01RY9tFIva7HMdQUEjw+Cg5+ALtB6vp9LU/eQuE6tCXpFxr97SrpJYg1FkED+xA
         CrC0N6t6WtdUPsba6bmKHOCdo5YJcnwXKDNcgELfwnj28W/6hCEo33cA1vf8PR5cFdWC
         AFeRsCcwtjOaQc04ORp8WoKfA4ZyjO24ZLDIDafyxb8YxG7FcfAFMiao84IImORb1HFc
         iuaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDQhUm7oCjbssqezHO1QgGJZRt+rPZB1xVx+MaohkHySEoD9QD3JaNCBhFsFZd0LoRyd/bUjebzrEGt9+dfcWU5+T6c44QjZ2xL1GU
X-Gm-Message-State: AOJu0YwniGKNjNScRqx0DlR6B/uyVnlditfS0/q3gw3a3SCEh/ioQy07
	zElx4J3pMS/EanyHgwPdUiJA+Q0qWM1i/JGOuwefja+0pWpLdylaBP4vte5YRfE=
X-Google-Smtp-Source: AGHT+IGUDm5010syq/xgTlajOkXN6zAoeyuTKEY0ravbOpM9vA1f4/yUpyZq5hWbTISTc4r4z0fWqA==
X-Received: by 2002:a05:600c:3016:b0:424:a721:1d0f with SMTP id 5b1f17b1804b1-424a7211e6bmr61113515e9.29.1719570304552;
        Fri, 28 Jun 2024 03:25:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4249b133b44sm89189805e9.0.2024.06.28.03.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 03:25:04 -0700 (PDT)
Message-ID: <20ff64a8-e619-4281-894f-1aa08ea67f18@tuxon.dev>
Date: Fri, 28 Jun 2024 13:25:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] i2c: riic: Define individual arrays to describe
 the register offsets
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Brandt <Chris.Brandt@renesas.com>,
 "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
 <20240625121358.590547-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346EF9A001F68162148B70F86D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <6289f329-118f-4970-a525-75c3a48bd28b@tuxon.dev>
 <TY3PR01MB1134603F92C72D9B6C6C3733C86D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <2f162986-33c5-4d80-958c-4f857adaad20@tuxon.dev>
 <TY3PR01MB11346CA73575CF61B2024F3B386D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <79c26030-4b92-4ef3-b8ce-d011f492161b@tuxon.dev>
 <TY3PR01MB11346A2DFBD7FE81337A748D386D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346A2DFBD7FE81337A748D386D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.06.2024 11:24, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>> Sent: Friday, June 28, 2024 9:13 AM
>> Subject: Re: [PATCH v2 07/12] i2c: riic: Define individual arrays to describe the register offsets
>>
>>
>>
>> On 28.06.2024 11:09, Biju Das wrote:
>>>
>>> Hi Claudiu,
>>>
>>>> -----Original Message-----
>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>> Sent: Friday, June 28, 2024 9:03 AM
>>>> Subject: Re: [PATCH v2 07/12] i2c: riic: Define individual arrays to
>>>> describe the register offsets
>>>>
>>>>
>>>>
>>>> On 28.06.2024 10:55, Biju Das wrote:
>>>>> Hi Claudiu,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>>>> Sent: Friday, June 28, 2024 8:32 AM
>>>>>> Subject: Re: [PATCH v2 07/12] i2c: riic: Define individual arrays
>>>>>> to describe the register offsets
>>>>>>
>>>>>> Hi, Biju,
>>>>>>
>>>>>> On 28.06.2024 08:59, Biju Das wrote:
>>>>>>> Hi Claudiu,
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>>>>>> Sent: Tuesday, June 25, 2024 1:14 PM
>>>>>>>> Subject: [PATCH v2 07/12] i2c: riic: Define individual arrays to
>>>>>>>> describe the register offsets
>>>>>>>>
>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>
>>>>>>>> Define individual arrays to describe the register offsets. In
>>>>>>>> this way we can describe different IP variants that share the
>>>>>>>> same register offsets but have differences in other characteristics.
>>>>>>>> Commit prepares for the addition
>>>>>> of fast mode plus.
>>>>>>>>
>>>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Changes in v2:
>>>>>>>> - none
>>>>>>>>
>>>>>>>>  drivers/i2c/busses/i2c-riic.c | 58
>>>>>>>> +++++++++++++++++++----------------
>>>>>>>>  1 file changed, 31 insertions(+), 27 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/i2c/busses/i2c-riic.c
>>>>>>>> b/drivers/i2c/busses/i2c-riic.c index
>>>>>>>> 9fe007609076..8ffbead95492 100644
>>>>>>>> --- a/drivers/i2c/busses/i2c-riic.c
>>>>>>>> +++ b/drivers/i2c/busses/i2c-riic.c
>>>>>>>> @@ -91,7 +91,7 @@ enum riic_reg_list {  };
>>>>>>>>
>>>>>>>>  struct riic_of_data {
>>>>>>>> -	u8 regs[RIIC_REG_END];
>>>>>>>> +	const u8 *regs;
>>>>>>>
>>>>>>>
>>>>>>> Since you are touching this part, can we drop struct and Use u8*
>>>>>>> as device_data instead?
>>>>>>
>>>>>> Patch 09/12 "i2c: riic: Add support for fast mode plus" adds a new
>>>>>> member to struct
>>>> riic_of_data.
>>>>>> That new member is needed to differentiate b/w hardware versions
>>>>>> supporting fast mode plus based on compatible.
>>>>>
>>>>> Are we sure RZ/A does not support fast mode plus?
>>>>
>>>> From commit description of patch 09/12:
>>>>
>>>> Fast mode plus is available on most of the IP variants that RIIC
>>>> driver is working with. The exception is (according to HW manuals of the SoCs where this IP is
>> available) the Renesas RZ/A1H.
>>>> For this, patch introduces the struct riic_of_data::fast_mode_plus.
>>>>
>>>> I checked the manuals of all the SoCs where this driver is used.
>>>>
>>>> I haven't checked the H/W manual?
>>>>
>>>> On the manual I've downloaded from Renesas web site the FMPE bit of
>>>> RIICnFER is not available on RZ/A1H.
>>>
>>> I just found RZ/A2M manual, it supports FMP and register layout looks similar to RZ/G2L.
>>
>> I introduced struct riic_of_data::fast_mode_plus because of RZ/A1H.
> 
> Maybe make the register layout as per SoC
> 
> RZ/A1 --> &riic_rz_a_info
> RZ/A2 and RZ/{G2L,G2LC,V2L,G2UL,FIVE} --> &riic_rz_g2_info
> RZ/G3S and RZ/V2H --> &riic_rz_v2h_info

Sorry, but I don't understand. Patch 09/12 already does that but a bit
differently:

RZ/{G2L, G2LC, G2UL, V2L, FIVE} -> riic_rz_g2_info
RZ/G3S and RZ/V2H -> riic_rz_v2h_info
Everything else: riic_rz_a_info

I don't have anything at hand to test the "everything else" thus I enabled
it for RZ/{G2L, G2LC, G2UL, V2L, FIVE}, RZ/G3S and RZ/V2H.

> 
> Then except RZ/A1, set FMP. 

I cannot test all these.

> 
> Currently register layout of RZ/A2 is not matching with
> Hardware manual.

I cannot test this either. Also, I think this is not the purpose of this
series.

Thank you,
Claudiu Beznea

> 
> Cheers,
> Biju

