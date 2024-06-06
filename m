Return-Path: <linux-kernel+bounces-204225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61D8FE604
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4B728922E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCF195991;
	Thu,  6 Jun 2024 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNdGafmt"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692DC153
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675417; cv=none; b=NRCmNmItSH/Te+dXYBKMUw2CEn2+0Q6/HehnshcdqdVTsXSRao+w0OE8lJUU6Z9lxWcNin/LShASIsPxdWuBtCKsp2NQ7+YkVxbq5V4ljxA7bGkcpjQcui1D6mSvP5giVKZ0byJOTpQ53Ne2WSZmSQrHNZV3n47jnqK9/gYB+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675417; c=relaxed/simple;
	bh=aNpXvfN77ldJ43zIxp6GfuvwOV+4cBY5Tw8CrZX/K4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMhcDk+LecKdk7IBFTl9lnNiuiCeDZaYPqVGmcyZT9oDZyHMDqc4hh6VbB6hJacYf9UQG5TEVkIirzPk16CAK1osmhyv1n3+0jNk1MX2rv0PyT5HcY1ouJuEiMiQ6WfRydYroISuF+/89QHuTjqfP8ThIq7Wg+FwkKH8WL0P5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yNdGafmt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6266ffdba8so77655966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717675414; x=1718280214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vPS4Wu3K1+SNHP7/UCC3zuql6I1R/Uod3WHUVV4Y/k=;
        b=yNdGafmtvMWC9nFxaK2Ca0EctQhOJeDEgbruhnDMEOB3/GpzKlrmtit8tQoMguOZon
         hBkr/ygCs9ZEovohKzry0CKndQA9rCn1KkuaQqrm079p1sSjjfv5ljh5E2wZStjHVfwn
         WG0MoGJYzeSvVmu233WFh+14X+7SVv8FtBxbQ5quEDb7/HQ4j1q+qmAVkRDfAYJCbUeO
         mn8dXORNcD6DcKn/ly3q9iy7NAGiWDxEbU0Dwx4UyaTpnCLlZ90n7ev4he+6WIgrc4Bo
         1r6Vf1PPsLxDmLJtRHo7M+2/ox7oRe/fj/4LoRkduGS86vwc3o4jTVUs8LNpr8cSyOoA
         5HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717675414; x=1718280214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vPS4Wu3K1+SNHP7/UCC3zuql6I1R/Uod3WHUVV4Y/k=;
        b=T5iQNyoo5qsZAu9MFCu9DAE+AZSzryymZnXnnBsrwIfHfPmHb1YV/ASPDWvAbIx6V1
         kWZPbfn7xvxVHccb7LMW6d3NOsyQ8ZkcRkGmhEgZLfpV9nKnlYkJm/7OcmcFqWrsAL7Z
         0H6bB9uKPEtlliImF7cmIVBMnyF263jdWhYyQO6mm775JAgKFe/Fyx2C0jw+JFg5jmVC
         6XayS66j11BhhZHpSq2nlltydDLYOM8BK1/St9ZmOI4tW3rrMWD6ET3+KtPj/gbDM9CO
         +qLTq+H6ISRxqE/NWNGXBhblN2WbwwcttL/B2AL5nKGP1MjL6FWAPBwX6NWhL8onBHId
         M0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Y0NRuqIIJ0ietMgqMlnZPzm5DG0FLIF3J0M93zw7Bi9i3q0py6iHDIvUFmeQ8mHK7nY4JBiVg+wiiOosZxfAVFkLV//5eHfKEOxT
X-Gm-Message-State: AOJu0Ywl5hO+SPovbPNTcTG40WiPhR8bId9vyIomDDrSxa/+0lDzjkC1
	EiBTfPgB5JKl/DbWi/Ty1NFFms7gkNUGkUPImRrCIKxMX2Xg685NpZEuVpExN6ekdyfpDljV87/
	w
X-Google-Smtp-Source: AGHT+IFmMz1GmHTUvHk6s/qP+CRB/I1EcEnEfMew6pgb89m5yDF7bhdBICxRyQM/+EXeB1BQOKXDcQ==
X-Received: by 2002:a17:906:4915:b0:a66:d1a1:f92f with SMTP id a640c23a62f3a-a699f34da1emr363268166b.14.1717675414101;
        Thu, 06 Jun 2024 05:03:34 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e839sm89223766b.176.2024.06.06.05.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 05:03:33 -0700 (PDT)
Message-ID: <0bb5cdc8-37fe-42c1-a18e-bb1494924095@linaro.org>
Date: Thu, 6 Jun 2024 13:03:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
To: Conor Dooley <conor@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Thorsten Scherer <t.scherer@eckelmann.de>, Marek Vasut <marex@denx.de>,
 Imre Kaloz <kaloz@openwrt.org>, Andrew Lunn <andrew@lunn.ch>,
 Flavio Suligoi <f.suligoi@asem.it>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Bacem.Daassi@infineon.com
References: <20240604074231.1874972-1-mwalle@kernel.org>
 <20240604-ladylike-gout-6fd6ae992712@spud>
 <D1RF2GI60GXE.3A3W7Q3W19GPN@kernel.org>
 <20240605-cosmetics-upgrade-837934256ede@spud>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240605-cosmetics-upgrade-837934256ede@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/5/24 18:40, Conor Dooley wrote:
> On Tue, Jun 04, 2024 at 07:42:16PM +0200, Michael Walle wrote:
>> On Tue Jun 4, 2024 at 7:01 PM CEST, Conor Dooley wrote:
>>> On Tue, Jun 04, 2024 at 09:42:31AM +0200, Michael Walle wrote:
>>>> These devices are more like an AT25 compatible EEPROM instead of
>>>> flashes. Like an EEPROM the user doesn't need to explicitly erase the
>>>> memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
>>>> (flash) driver, one should instead use the at25 EEPROM driver.
>>>>
>>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> Cc: Thorsten Scherer <t.scherer@eckelmann.de>
>>>> Cc: Marek Vasut <marex@denx.de>
>>>> Cc: Imre Kaloz <kaloz@openwrt.org>
>>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>>> Cc: Flavio Suligoi <f.suligoi@asem.it>
>>>> ---
>>>> The referenced binding only supports the true AT25 compatible EEPROMs
>>>> where you have to specify additional properties like size and page size
>>>> or cypress FRAM devices where all the properties are discovered by the
>>>> driver. I don't have the actual hardware, therefore I can't work on a
>>>> proper driver and binding. But I really want to deprecate the use of
>>>> these EEPROM like devices in SPI-NOR. So as a first step, mark the
>>>> devices in the DT bindings as deprecated.
>>>>
>>>> There are three in-tree users of this. I hope I've CCed all the relevant
>>>> people. With the switch to the at25 driver also comes a user-space
>>>> facing change: there is no more MTD device. Instead there is an "eeprom"
>>>> file in /sys now, just like for every other EEPROM.
>>>>
>>>> Marek already expressed, that the sps1 dts can likely be removed
>>>> altogether. I'd like to hear from the other board DTS maintainers if
>>>> they seem some problems moving to the EEPROM interface - or maybe that
>>>> device isn't used at all anyway. So in the end, we can hopefully move
>>>> all the users over to the at25 driver.
>>>> ---
>>>>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 9 ++++++++-
>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>> index 6e3afb42926e..2dccb6b049ea 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>> @@ -21,7 +21,6 @@ properties:
>>>>                (m25p(40|80|16|32|64|128)|\
>>>>                n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
>>>>                atmel,at25df(321a|641|081a)|\
>>>> -              everspin,mr25h(10|40|128|256)|\
>>>>                (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|\
>>>>                (mxicy|macronix),mx25u(4033|4035)|\
>>>>                (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
>>>> @@ -42,6 +41,14 @@ properties:
>>>>                - spansion,s25fs512s
>>>>            - const: jedec,spi-nor
>>>>        - const: jedec,spi-nor
>>>> +
>>>> +      # Deprecated bindings
>>>> +      - items:
>>>> +          - pattern: "^everspin,mr25h(10|40|128|256)$"
>>>> +          - const: jedec,spi-nor
>>>> +        description:
>>>> +          Deprecated binding, use Documentation/devicetree/bindings/eeprom/at25.yaml.
>>>> +        deprecated: true
>>>
>>> The idea here seems okay, but directing people to use the at25 binding,
>>> without actually documenting the replacement compatibles etc is far from
>>> ideal. I think even a wording change that points out that that these
>>> devices need to be documented in that file would be an improvement, the
>>> current wording makes it seem like the works been done.
>>> Until there's a replacement driver, I don't think you could really
>>> expect anyone to move to a new binding anyway.
>>
>> Fair enough. The driver is already there and it basically works -
>> Flavio is already using it. It is just, that at the moment you have
>> to use the (deprecated) "atmel,at25" compatible and you'll have to
>> specify pagesize etc. That is really hacky, because F/MRAM devices
>> doesn't have a pagesize.
>>
>> Anyway, I was already working on the at25 binding but then I've
>> noticed that the current FRAM binding is really hardcoded to cypress
>> devices and as mentioned in the commit message, I don't have any

Takahiro from cc may help with the cypress FRAM testing.

>> hardware to actually write the proper driver support. Maybe we
>> should settle on the binding first, i.e.
>>
>>  compatible = "everspin,mr25", "atmel,at25";
>>  size = <N>;
>>
>> vs
>>
>>  compatible = "everspin,mr25h256"; # no size needed
> 
> I dunno, I am usually biased to having the more specific compatible
> and not needing the extra properties.

I agree with the more specific compatible idea, but we shall aim that
the specific compatible to be generic: "spi-fram" and maybe "spi-mram".
Can it be done?

> 
>>
>> For reference, the already supported cypress fram has the following:
>>
>>  compatible = "cypress,fm25", "atmel,at25";
>>  # no size needed, because the driver will figure it out by reading
>>  # the ID
>>
>> Besides that, I would really get some feedback from the three
>> in-tree users on migrating to the EEPROM driver and thus away from
>> MTD.
>>
>> -michael
>>

