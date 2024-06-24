Return-Path: <linux-kernel+bounces-227630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116659154BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8411F21438
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06C119E7F6;
	Mon, 24 Jun 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2lxT5SVR"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64B2F24
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247738; cv=none; b=Boo1FqSyr0f85cFWFaY7+Hi33V+1E5so4V50JKi2jff1QvEv+DPI0MiKhrlw3e4iQ9reXIcObWW6zdYnkp2/2DyFL6dvURf22vh3tdxnVUdPaBQlDhdooupEsUYANr1vhn9/iEZrC+ed2h8R4rm3qLC4/UN+D/yC3a07yzthUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247738; c=relaxed/simple;
	bh=bWVnoflNYa8G5Kxrq0nWQrfqsc684kD+NGBZ6hdM2IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVG785BBbhIc0dQ3B+nOjFM7xHtd6XXobyfTpl4yYvuyim7v+jp/nH8XPzrT0X0FTTqg9PNZaJlFP32gCzguXGvb7MJLWmlbqbZtMdgDlqpzd01vQk79V2lPPr7Xhh27e5KxrqVjncpyTq6WM11CsooQsvfO/xckkAkQh0MuGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2lxT5SVR; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d215a594b9so2417828b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719247736; x=1719852536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxxkGiRjkerPamYFY/qxNBX6etGC2eZqvZGM5OE8a/o=;
        b=2lxT5SVRXmqpVUVMDGWxP+ZTxX9GRIFysixr7FDp2KDiaE1jfW9nLqELFQkbfkwH+r
         NsBVo11tBb8vX3RectVHjxzhR2D32pV0R6qO6CYER+1HT4TWRp/MEDn62Y3bJVTGJ9vc
         Dq2gbpKx3RPvnviQk1dldj4Di/U00v2hvDhwettIDtI9pSLk8/ZT5g0AsTEqsIpIOQNH
         ors/J5lvJMV2IhrSInOUcEVIWLZXzAp6AkanIw5qjBFBUs/TqPH5p5YPCi2hghAYGCDx
         DEaRX8niM6oW5HFbIA9uCY1RlRMtil5jdvouxV6zU9NTQFhSj9QJdmkIREk4VjN1FzjM
         nipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247736; x=1719852536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxxkGiRjkerPamYFY/qxNBX6etGC2eZqvZGM5OE8a/o=;
        b=XPNuelZOVFUWL+PUJwG9foIML4fev1HhWC8Ui6xBBwjW9FlgTf8L2JVWCb82N4PBQK
         7qbTNndGykLhwPrtIXgXmg7/OVoBBQzbyBN82/a1lEvitCU7VsLiPDz4Njm07CBjzhcm
         DaygmZHZFz7QHonVuiuRvz5D681GjM6qogDQQxb+VxXFV9tnmJRoPk7e4CcM+EZMEFGw
         VCNq0u5qaHPF2gtGa+Hpkz/GpaGQBEVUjN0bHkAJwpGe1Jo6fFaV7OpcBUMJytqdkGF9
         m0ZYcU3H+ZugU1Yg1GYpwbN8nGrj4fZqppTrbBqr4A2O6XgK1lX+ofmhcdpe/azwpFPy
         WMmg==
X-Gm-Message-State: AOJu0YzAd48HatUV7Ck7MgOu/3S8SUAP5+I10CsoW+6TaoEcZ4heU/mm
	rEA+kDjV/ZLkSjxcmaiP1B8QITa7kaBX9tpgw3gOD9qjSamnvnSJ6khv4fXsmGo=
X-Google-Smtp-Source: AGHT+IHJTWIGqMNnLlw3Aibsovc33vkuDbNsrVUj73Yo3Le40YAQ1flHUPNAWQibOZNFS3MGry2obA==
X-Received: by 2002:a05:6808:190f:b0:3d2:17cd:5601 with SMTP id 5614622812f47-3d543b129aamr7028160b6e.33.1719247735839;
        Mon, 24 Jun 2024 09:48:55 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d54067c8c2sm999719b6e.27.2024.06.24.09.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 09:48:55 -0700 (PDT)
Message-ID: <1cbb4395-cc9e-4e49-9188-c09aeefff956@baylibre.com>
Date: Mon, 24 Jun 2024 11:48:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
 Conor Dooley <conor@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-4-kimseer.paller@analog.com>
 <20240619-left-usable-316cbe62468a@spud>
 <PH0PR03MB7141FB5DFBCA46C727FA9605F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <PH0PR03MB7141FB5DFBCA46C727FA9605F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>>> +  adi,manual-span-operation-config:
>>> +    description:
>>> +      This property must mimic the MSPAN pin configurations. By tying the
>> MSPAN
>>> +      pins (MSP2, MSP1 and MSP0) to GND and/or VCC, any output range can
>> be
>>> +      hardware-configured with different mid-scale or zero-scale reset options.
>>> +      The hardware configuration is latched during power on reset for proper
>>> +      operation.
>>> +        0 - MPS2=GND, MPS1=GND, MSP0=GND (+-10V, reset to 0V)
>>> +        1 - MPS2=GND, MPS1=GND, MSP0=VCC (+-5V, reset to 0V)
>>> +        2 - MPS2=GND, MPS1=VCC, MSP0=GND (+-2.5V, reset to 0V)
>>> +        3 - MPS2=GND, MPS1=VCC, MSP0=VCC (0V to 10, reset to 0V)
>>> +        4 - MPS2=VCC, MPS1=GND, MSP0=GND (0V to 10V, reset to 5V)
>>> +        5 - MPS2=VCC, MPS1=GND, MSP0=VCC (0V to 5V, reset to 0V)
>>> +        6 - MPS2=VCC, MPS1=VCC, MSP0=GND (0V to 5V, reset to 2.5V)
>>> +        7 - MPS2=VCC, MPS1=VCC, MSP0=VCC (0V to 5V, reset to 0V, enables
>> SoftSpan)
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
>>
>> Can you explain why this property is required, when below there's one that sets
>> the ranges in microvolts? Isn't the only new information that this provides the
>> reset values (in a few cases that it is not 0).
>> What am I missing?
> 
> For specifying output range and reset options without relying on software initialization
> routines, and also for enabling the softspan feature, I think this property seems essential.

So in other words, this describes how the MSP pins are hardwired and
the per-channel adi,output-range-microvolt is only permissible if

	 adi,manual-span-operation-config = <7>;

(or omitted since 7 is the default)

because in that case each individual pin could have a different
required range based on what is wire up to it?

But if adi,manual-span-operation-config is anything other than 7,
then adi,output-range-microvolt should be not allowed since all
channels will have the same range because of the hard-wired pins.

correct?

The description could probably just be simplified to say that
this describes how the 3 pins are hardwired and to see Table 4
in the datasheet to understand the actual implications rather
than reproducing that table here.

But I do agree that we need both properties. I think we are
just missing:

- if:
    properties:
      adi,manual-span-operation-config:
        const: 7
  then:
    patternProperties:
      "^channel@[0-3]$":
       adi,output-range-microvolt: false

(not tested - may need two ifs, one with

- if:
    required:
      - adi,manual-span-operation-config
    properties:
      adi,manual-span-operation-config:
        const: 7

and one with

- if:
    not:
      required:
        - adi,manual-span-operation-config

to make it work properly)

> 
>>> +    default: 7
>>> +
>>> +  io-channels:
>>> +    description:
>>> +      ADC channel to monitor voltages and temperature at the MUXOUT pin.
>>> +    maxItems: 1
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  "^channel@[0-3]$":
>>> +    type: object
>>> +    additionalProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: The channel number representing the DAC output channel.
>>> +        maximum: 3
>>> +
>>> +      adi,toggle-mode:
>>> +        description:
>>> +          Set the channel as a toggle enabled channel. Toggle operation enables
>>> +          fast switching of a DAC output between two different DAC codes
>> without
>>> +          any SPI transaction.
>>> +        type: boolean
>>> +
>>> +      adi,output-range-microvolt:
>>> +        description: Specify the channel output full scale range.
>>> +        oneOf:
>>> +          - items:
>>> +              - const: 0
>>> +              - enum: [5000000, 10000000]
>>> +          - items:
>>> +              - const: -5000000
>>> +              - const: 5000000
>>> +          - items:
>>> +              - const: -10000000
>>> +              - const: 10000000
>>> +          - items:
>>> +              - const: -2500000
>>> +              - const: 2500000
>>> +
>>> +    required:
>>> +      - reg
>>> +      - adi,output-range-microvolt

And adi,output-range-microvolt should not be required. When SoftSpan
is not available (because MSP != 0x7), then the range is determined
by adi,manual-span-operation-config.

And even when adi,manual-span-operation-config = <7>, there is still
a default range, so adi,output-range-microvolt should still not be
required in that case.


