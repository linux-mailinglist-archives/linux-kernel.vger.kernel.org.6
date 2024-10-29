Return-Path: <linux-kernel+bounces-387033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A55709B4AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07388B21EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB736205AD2;
	Tue, 29 Oct 2024 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9Yf+HLR"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CDBA50
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208909; cv=none; b=MPokz0Fe+xonIz8W19Bw0uCWq4pnI5hkdVC4rDGzy0mD3lxgSNnBY1zDE/cLbbU1eGkXWEqiUg/aIj98YarBZy8zK52SJE7IcJGKz6xeF4ub8I/x2yazbZjV7Ms57ep4/WCGUJduP4xmrfQM3dItzAdCXiKLNVg4ZWzxEvdoHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208909; c=relaxed/simple;
	bh=J5PnU16OqwIuLjb8SXUu19InyYicvapUfKcZmPAnSTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AO/Vdk7qdBU1d8tCBZ6yN+qtY6ywpQ8xNBr8AduOY41IAZaWdyUHPFVCrSlt7P7StF0OfaamzaAizTP2729g6Vh1yttk6mum6GiNTYW4f2dObuOags7n3KOp6HP53B1wUWu+4KHkoGAYBfhcNNzJLFnDKqt6SGzH7rez30Zbt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q9Yf+HLR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43158625112so54665955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730208905; x=1730813705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EPSagbJNibvgvISoxlTHCzy9uP06DCcHvDI0SGO33s=;
        b=Q9Yf+HLR8VQF3ZwPD4E6ofbI++YxgHXY4CgoXRWTLUEsT7Gxi1HwLcjQDzS2DMn4Ul
         aMBhbc+CamLdgSda/AwuM+zaK86CIf+ZRkXIIFUDwwQI7r0ic16Z4Rm0ABGc4NpHA5ID
         Qr8+CCGVlDx29cc0MiHVh/TaibRgnqdzKLeN4+5D9NI7/JsjNA+iZERR0Fw3mZ0H2ft7
         S/+qH6e/vsdzdB/W2QPjG4ZrsEAPaUplL2YwIO+Pu50Bm04OgUJ+cpH39RB+ZpwXGkQn
         kge1VM9faEpQA+nG3oad735ECrkLzIN0weFkS5Ys9vDljcWYr2Kab59gzmAhro7q7jD/
         XlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730208905; x=1730813705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EPSagbJNibvgvISoxlTHCzy9uP06DCcHvDI0SGO33s=;
        b=xOPfzBM8MuA3ZzB4ZYqoCHp+KtabW3dV1MqUpu4tOYhFYjcCOOF6JX7owIDIs75UKh
         GD+orOufMrbdsJei8xikEMQWv2iG02ZOqzXM5vMRGOa8XaiBOqSjL65L8T6PqikmAtkf
         7J/UqlD9b+sKIX+TEGnTbG1tpMcCXlLFXdC8W+wiPeD3XLUG897kkNxOrfbBJDEvhizN
         X5fYBdIG+oilU2IlojiRTnS27HAU7b1VM+GiIdiv44+pqOJX5+gUykTtewZFvoTsDbIw
         pV1WrRsb1wlNMMCZBsPheMSTGTkXHz2Wp92MxztxRFkK/gtjM5sagOJBKge3XhRtlvmN
         JZSw==
X-Forwarded-Encrypted: i=1; AJvYcCWdMh9qZ6lBrDFd1hRj87M/NH4D8cr3c5X1BGEbGsxHIdl4jn8aUCyJnzPQutD/Tk6SziWTWptMCR9anr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNzsO1pScWI9dwqQ5IBed5kaZ962eg9Ub6QKqA0ORJKykWAwy
	F5oSPnwtwkD71fKJf89kWSdg0ypigoeGOW2aBD07p3eO2w+9BBVTGnIdeShTFaNWSf3/aB2/4QR
	g
X-Google-Smtp-Source: AGHT+IEN43GPROeIzibt4MSindA3Ieb0caiE4z2wg9uYkNsWVGAHOaRud+GyTcWUzbdiXUO2rdVS7g==
X-Received: by 2002:a05:600c:4711:b0:431:586e:7e7 with SMTP id 5b1f17b1804b1-4319ac6e818mr111337495e9.1.1730208905077;
        Tue, 29 Oct 2024 06:35:05 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f689sm175326845e9.16.2024.10.29.06.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 06:35:04 -0700 (PDT)
Message-ID: <7a370586-203d-4e3b-827c-82e4306ae69d@linaro.org>
Date: Tue, 29 Oct 2024 13:35:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: atmel: add at25sf321 entry
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241029-spi-nor-v2-1-e166c3900e19@gmail.com>
 <0bbd2514-ff51-4b0c-b3ad-547e4937d9f4@linaro.org>
 <ZyDgSRcT79yksuG2@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZyDgSRcT79yksuG2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/24 1:16 PM, Marcus Folkesson wrote:
> Hi Tudor,
> 

Hi!

> On Tue, Oct 29, 2024 at 11:36:17AM +0000, Tudor Ambarus wrote:
>>
>>
>> On 10/29/24 11:23 AM, Marcus Folkesson wrote:
>>> Add entry for the at25sf321 32Mbit SPI flash.
>>>
>>> This flash is populated on a custom board and was tested at
>>> 10MHz frequency using the "ti,da830-spi" SPI controller.
>>>
>>
>> no sfdp for this one?
> 
> No SFDP for this one!
>>
>>> Link:
>>> https://www.renesas.com/en/document/dst/at25sf321-datasheet?r=1608801
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>> ---
> 
> [...]
> 
>>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>>> index 45d1153a04a07b7c61f46b117311b24ab695038f..8285a16b253d54ae8c4a5302850244d2248aa755 100644
>>> --- a/drivers/mtd/spi-nor/atmel.c
>>> +++ b/drivers/mtd/spi-nor/atmel.c
>>> @@ -238,6 +238,11 @@ static const struct flash_info atmel_nor_parts[] = {
>>>  		.flags = SPI_NOR_HAS_LOCK,
>>>  		.no_sfdp_flags = SECT_4K,
>>>  		.fixups = &at25fs_nor_fixups
>>> +	}, {
>>> +		.id = SNOR_ID(0x1f, 0x87, 0x01),
>>> +		.name = "at25sf321",
>>> +		.size = SZ_4M,
>>> +		.no_sfdp_flags = SECT_4K,
>>
>> it seems this flash supports dual and quad reads. Do you care to
>> add/test these modes?
>>
>> you'll need mtd-utils
> 
> Sure, not sure how I test it though.
> I've added mtd-utils but I do not see any good parameters to set mode?

Ah, you can't specify the width at runtime.

In SPI NOR you need to update your flash entry to contain:
	.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,

then in your device tree you can set dual mode by doing
spi-tx-bus-width = <2>;
spi-rx-bus-width = <2>;

For quad you set the tx/rx widths to 4.

Do a cat /sys/kernel/debug/spi-nor/spi0.0/params to see what params get
set. You need to do the tests from
https://docs.kernel.org/driver-api/mtd/spi-nor.html, starting with
section "3 Dump debugfs data", for each of the dual/quad modes.

Cheers,
ta

