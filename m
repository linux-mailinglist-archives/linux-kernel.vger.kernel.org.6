Return-Path: <linux-kernel+bounces-218835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EFA90C6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81BFB231C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69A14A09B;
	Tue, 18 Jun 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XU3hsbcs"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BF1487ED
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698297; cv=none; b=J+cbMKf7sm1kVb64MlW/4v3Me7ki1LNNW7oHF879da11nR9I4UrG2k3aVyjj+okBwftbop+VURc5+V4MVUH45wMOXg+J8mDnZNjc31TD22Bt+hA0WFJnK71HBaArYl2zVrFgK7E3LR83EgRJwQLauFOXYJ3KL5Kf+5LfXsd4YHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698297; c=relaxed/simple;
	bh=2KNMmat5vMET2BDI7NUXUz9iV8jjghd0Qaf7pSQvWdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4FO94dfqMfYy1/6svK2d/JoZVgUS0vr3m7LjBb6vbs/1wSpdCvqD8QnegQ0DW8bguQjvGils2la9rrAoAihyjqPelwXjifd76lp1RerKCruw+omveTS2w4S2sOLHedMYWd+SOwNlKmfbRuxIp4c6Ttu4hiKhhx8cLst+1g7zek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XU3hsbcs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4217d451f69so42429165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718698293; x=1719303093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Db/Ttkm8Wt1DAojtG+l5i3VYAIO56vuiF9BvfZCWUE=;
        b=XU3hsbcs6oN4mExeSoAh7KhcLS6krsD89eVRRiZDBOHpP98+i0yBPiudWLfNIexlJC
         ouihp8C99os4Xses4INfKTAib8W/j4WOEWCw/Rv0Bo/32czrzhul0WlocnN2BWqNuCsA
         kvD5gii341WdbDhOgVDoodAuBe7vv1H5QzSgoNLL17py8xgORxnN7hjrT6LIxuVmsGwb
         BMTW00qy31qvRmR6Df/t7pwxiuUkniVtRL0px3It0GacLgjKCKiDppN3PHJ5S8wP0C6h
         d5d74zrnSm9jcksmwBVmPgrhbK1RtqIKOfBvpgo0SV4Mo5HwU7ZuLLBCKVRvCI1QGpRP
         BVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698293; x=1719303093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Db/Ttkm8Wt1DAojtG+l5i3VYAIO56vuiF9BvfZCWUE=;
        b=Hq9x/OpjoO4aUdejYJw+XFTb8cvb5R5DDz5Eqz0GFVwDaRuhZorK1aCA3oFe2n3VgK
         SpfK3XFNHXln3aaac5GMUrHtroiqHAOmzbXWqPKClHr5YPPG1s93KPCnjDpJ2CAjCUv2
         A/wGQkQ4K/EiElb6nNgQNAjoIMrNFBJ+5MIXstV/vk3ZMjwoN4VVt4N7SlPYozHeFjsX
         QXbSfdTUPmWvThy8gUh8GWaf4K912rWMCtgl+LrV5wz6YLYq1pxlSFrA98WCHqIDPWGp
         YGh93MF9Oo9cUO5oDLqbcWF/2oaU4y+eHsW84w9c7WSKd7/+diKl5NQYsf/tT9QMaA8C
         K4XA==
X-Forwarded-Encrypted: i=1; AJvYcCUhlHRhbt5Ku2LGQlhUocsvmNh9vrToZUmFUzqOCM9bJURyzA+ZlqVTiWYRw/ZTFOS8dHdhCzUyf7+TEbu0UFlkIaO4JuJFt9iDB4Cj
X-Gm-Message-State: AOJu0Yy5LJ+ruz2bZdLVnrI2CfElpbtb+ns1mpFWCQ214LnbzKtx25iZ
	6vPrLXrudcRIz5oR8ObOyMoH70EshnjWrN5pJkgMQY0vdC+bhFMyKq19hVZESus=
X-Google-Smtp-Source: AGHT+IEZ4zfien/Ap0pCf2tDyhM1mJ0USifoiBZp4jjoL6ZEetj9nRXUeKMXuBuNxOiTYrJSsTYSkA==
X-Received: by 2002:a05:600c:4fcc:b0:423:4c2:7a80 with SMTP id 5b1f17b1804b1-42304c27cabmr78141565e9.5.1718698292647;
        Tue, 18 Jun 2024 01:11:32 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f2f30925sm183177995e9.0.2024.06.18.01.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 01:11:32 -0700 (PDT)
Message-ID: <ee58a84c-d0a9-4caf-9b97-40a4eaebae3f@tuxon.dev>
Date: Tue, 18 Jun 2024 11:11:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] dt-bindings: clock: renesas,rzg3s-vbattb-clk:
 Document the VBATTB clock driver
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor@kernel.org>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lee@kernel.org, alexandre.belloni@bootlin.com, magnus.damm@gmail.com,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240614071932.1014067-1-claudiu.beznea.uj@bp.renesas.com>
 <20240614071932.1014067-3-claudiu.beznea.uj@bp.renesas.com>
 <20240615-angler-occupier-6188a3187655@spud>
 <3d9ed0ec-ca9a-45b4-a633-8f7051d13cff@tuxon.dev>
 <20240617-subsoil-creed-04bf5f13d081@spud>
 <0a4ba0e5-3fb1-4ffc-b2d8-a4eb418707eb@tuxon.dev>
 <CAMuHMdXOiuORjLo2nRAFxtXmn5rRm7U-CEHqfX2DoXHmQyfdRQ@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXOiuORjLo2nRAFxtXmn5rRm7U-CEHqfX2DoXHmQyfdRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 18.06.2024 10:56, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, Jun 18, 2024 at 9:34 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 17.06.2024 18:19, Conor Dooley wrote:
>>> On Mon, Jun 17, 2024 at 10:02:47AM +0300, claudiu beznea wrote:
>>>> On 15.06.2024 15:17, Conor Dooley wrote:
>>>>> On Fri, Jun 14, 2024 at 10:19:22AM +0300, Claudiu wrote:
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> The VBATTB IP of the Renesas RZ/G3S SoC controls the clock that feeds
>>>>>> the RTC and the tamper detector. Add documentation for the VBATTB clock
>>>>>> driver.
>>>>>>
>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>> ---
>>>>>>  .../clock/renesas,rzg3s-vbattb-clk.yaml       | 90 +++++++++++++++++++
>>>>>>  1 file changed, 90 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzg3s-vbattb-clk.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg3s-vbattb-clk.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg3s-vbattb-clk.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..ef52a0c0f874
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,rzg3s-vbattb-clk.yaml
>>>>>> +  renesas,vbattb-osc-bypass:
>>>>>> +    description: set when external clock is connected to RTXOUT pin
> 
> FTR, this contradicts the explanation below, which states the external
> clock oscillator is connected to RTXIN.

I agree.

> 
>>>>>> +    type: boolean
>>>>>
>>>>> When you say "external clock", is that an input or an output?
>>>>
>>>> I took that statement from the HW manual. As of the HW manual [1], table
>>>> 42.2, that would be an input.
>>>
>>> Forgive me for not wanting to open the zip etc and find the information
>>> in the document, but why do you need an extra property? Is it not
>>> something you can determine from the clocks/clock-names properties?
>>
>> It can't be determined from clocks/clock-names as of my understanding. It
>> depends on the type of the input clock (crystal oscillator or external
>> hardware device generating the clock).
>>
>>> It sounds like an additional clock from your description, is it actually
>>> different way to provide the second clock you mention above?
>>
>> This is the block diagram (see [1], only picture this time) of the module
>> controlling the clock. Please open it, it helps in understanding what I'll
>> explain above.
>>
>> The VBATTB blocks controlling the VBATTBCLK are:
>> - 32KHz-clock oscillator
>> - the mux controlled by BKSCCR.SOSEL
>> - the gate who's input is the mux output and XOSCCR.OUTEN
>>
>> To the 32 KHz-clock oscillator block could be connected:
>> 1/ either a crystal oscillator in which case it will be connected to both
>> RTXIN and RTXOUT pins (the direction of RTXOUT is wrong in this picture for
>> this case)
>> 2/ or a device (like [2]) generating a clock which has a single output and,
>> from my understanding and experience with devices like this, only RTXIN is
>> needed, RTXOUT is connected to the ground; for this case the 32KHz-clock
>> oscillator block from [1] need to be bypassed in which case the newly
>> introduced property will be used; this will select the XBYP on the mux.
> 
> Sounds similar to the RAA215300 PMIC, which includes an ISL1208-derived
> RTC, where this was handled using two different clock names:
> https://elixir.bootlin.com/linux/v6.10-rc1/source/Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml#L49
> https://elixir.bootlin.com/linux/v6.10-rc1/source/drivers/rtc/rtc-isl1208.c#L869

Yes, seem similar. I wasn't aware of this approach. I'll switch to it.

Thank  you,
Claudiu Beznea

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

