Return-Path: <linux-kernel+bounces-569963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895EA6AA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22321892CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624081EB195;
	Thu, 20 Mar 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlDBDPvm"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03231C5D61
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485550; cv=none; b=RpCsoBKZJlhAf6COQHg4b7USOi3M8XFL0vt0HxiK+LcccsCfrr56RsWuC/vjTesQKoJF1b84/x/PHawLhV2sVkE5UKUkEy5PzEeQ6nt1k/+dOTOajVHYWDISgxXdtPpPIQ0qNVvanjCb3yLG5FstXkqGHo8MH5fRox0Etvfej1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485550; c=relaxed/simple;
	bh=6ceQmsgRcTvZ6USukJ3sO5wzd3ACRgAvulJLMsk3KFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ5lbyDbHMgeYnPq6VB2K8sjus9obRPHpodgc//jsXIfv/+eX3F1U+Zt6ZgdAGdlbtPoPW2Xfc8oMORCjTl/7C2cghrl93YAMYtnOgOboodgyzVwqlUaxDG05RBxTFJjGylReI4Axy2OKlaOIpdq7t93m8Xrg5xrZCvG8DQzyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GlDBDPvm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso660473f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742485547; x=1743090347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrf584PxMsH6/Jh6HwYl2KNT4s5oL8tjFSmMaaJHl78=;
        b=GlDBDPvmiSVAwBThJgt5S8S1GFfqwYRlgGRL/PWm/hsf1ynQlQoroxILioJ2XB67nl
         M5WtvI00lIeTug6/4e7cm6m9lO40vDGsr8EWm2IS/EwXV2r0zKn6BNBdogWSy3f67lrI
         t83/7Rqba6H4Sq2+0c++HER1A8NQIR04QufE3YctiTr2iS7Z29emLNsEdDxR3LgzL/wN
         DGYuwn3qHl/xRxx++aBgKSU2CBFXIeq5YeBWfGwkkNPvPlG2exhRpGXNqGMe+g8GijwT
         Km0+C9acUgJM5RAybid/V8ePLiCvsfR0BvX+mIxqJhd1zILjU8eMi/9h6k3IIkchQpu3
         PBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742485547; x=1743090347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrf584PxMsH6/Jh6HwYl2KNT4s5oL8tjFSmMaaJHl78=;
        b=tcwjBYXnNuW6LQONOeQX1Bmav3ghFlXtExeLpHSKmHrx0MQ2TaQ2DXHvs7LQpne9++
         V1I3wkDRex8VC35Ot1wba0YOsstV0zJ/J2kUFSnXoMK/880ONGTfFyPSLMZsZ5tfp1RL
         PtQ2AScoQKOhFvxmD0uj/IlH7h7LCcNHBRoGHsKO86kCNKqh8e2BEorGAmmv64NagpQ7
         yRUg9emprDoO3R8PX04IBptehqxxUqXvC9ApE3/C2YMH+2zfmc/yTzMStB7xDfo8Q+XX
         3YRVM0Nzb6tIs1DW8/6fjSYsr2dUT1ff6IvO93XtEJtowYkZnJMMTCZgHGPSFTX0uSxV
         AFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnCsqrGjfi7lwF6b2B4vBawDwQ0RBUpwvKvfCOuX8ibDNVXj0QrM3wn/j2NPX6tFHjs5mt9PI6zeEu8uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKB+WQNl0YNdMiwml0ixt+Dla1L4gdSdU7hbV1X1Rr2Nc7bate
	K1uPLUyGdzpjX5Ou4aYec3fi5xw88ECH5qKTdN2DoD2rYuLDnvV8dzoIcqj+HsY=
X-Gm-Gg: ASbGncsw9cvAo5mk96ve9g0UwnabgBiV4tP6DKP+Ztv14fDIAkaZhozPMG7rXFfc5+4
	9Ix64yriUYYWz6HK5+dT5Ky49OqPKjDwufP8eTqI9oqifsg9BPF7owBveOrB3m6T2beEm+p/F6r
	1qQ6oAUnRcbRRfIJO0TjAqy9uSEqZY2yAWzaQgTwOX+Jo8V6MDS3UYxA01ttgAMpcBcwhG6EyJ5
	oeln/+I9PllKfz/reCVhxwN21pSsg7i0vMKYqavHmPCpFiF06Wz9ZXKV3oq75PNM34NRK8RP2FX
	WippGI7WJ4bID2KrkHuas0AatKuHf8Gg2pfBc1mITEspVaUn/aGL2w==
X-Google-Smtp-Source: AGHT+IGdH1lgoJr0bazg0fksi9pHBFYCBH5/M+YEIFTTKoDR0hUthlDLaxA5qHXNw5jfyW9M5ZzTEw==
X-Received: by 2002:a5d:588e:0:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3997f90e00cmr1069f8f.29.1742485546807;
        Thu, 20 Mar 2025 08:45:46 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb93csm23779355f8f.86.2025.03.20.08.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 08:45:46 -0700 (PDT)
Message-ID: <50de19f7-2021-433e-b8f8-d928ed7d5d57@linaro.org>
Date: Thu, 20 Mar 2025 15:45:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mtd: spi-nor: use rdid-dummy-ncycles DT property
To: Rob Herring <robh@kernel.org>
Cc: Takahiro Kuwano <tkuw584924@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bacem Daassi <Bacem.Daassi@infineon.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Mark Brown <broonie@kernel.org>
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
 <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com>
 <20250319233024.GA2625856-robh@kernel.org>
 <a3818477-5a67-43ad-8961-88fa02916968@linaro.org>
 <CAL_JsqKtz5+R1kjEzjo6bVicOX2c=UauC0_STAF0T02rSDqO+w@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAL_JsqKtz5+R1kjEzjo6bVicOX2c=UauC0_STAF0T02rSDqO+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/20/25 2:06 PM, Rob Herring wrote:
> On Thu, Mar 20, 2025 at 2:44 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Hi, Rob,
>>
>> On 3/19/25 11:30 PM, Rob Herring wrote:
>>> On Wed, Mar 19, 2025 at 06:47:44PM +0900, Takahiro Kuwano wrote:
>>>> There are infineon flashes [1] that require 8 dummy cycles for the
>>>> 1-1-1 Read ID command. Since the command is not covered by JESD216
>>>> or any other standard, get the number of dummy cycles from DT and use
>>>> them to correctly identify the flash.
>>>
>>> If Read ID fails, then couldn't you just retry with dummy cycles? Or
>>
>> I think Read ID won't fail when the op requires 8 dummy cycles, it
>> probably just reads garbage on the first 8 cycles, so we risk to wrongly
>> match other flash IDs.
>>
>>> would unconditionally adding dummy cycles adversely affect other chips?
>>
>> Adding 8 dummy cycles to chips that don't need it, would mean ignoring
>> the first byte of the flash ID, thus we again risk to wrongly match
>> against other flash IDs.
>>
>>>
>>> Otherwise, add a specific compatible to imply this requirement. Adding
>>> quirk properties doesn't scale.
>>
>> Do you mean a flash name compatible, like "cyrs17b512,spi-nor"?
> 
> Yes, but that's not the format of compatible strings.
> 
>> The
>> problem that I see with that is that we no longer bind against the
>> generic jedec,spi-nor compatible, so people need to update their DT in
>> case they use/plug-in a different flash on their board.
> 
> This chip is clearly *not* compatible with a generic chip.

I think it is compatible. The chip defines the SFDP (serial flash
discoverable parameters) tables. At probe time we parse those tables and
initialize the flash based on them.

We don't even care about the chip ID, if all the flash parameters can be
discovered via SFDP. Unfortunately these tables do not describe all the
flash capabilities (block protection being one). Or worse, manufacturers
mangle these tables.

So vendors need to identify chips to either fix those tables via some
quirks after the parsing is done, or to specify support that's not
covered by those tables.

For basic ops, flashes that get the SFDP tables right, don't even need a
flash entry defined, we don't care about their ID, we just initialize
the flash solely based on SFDP.

In this particular case, this flash needs identification to fix some
wrong SFDP field, it corrects just the mode cycles for the FAST READ
command. All the other commands seem fine according to patch 3/3.

> 
> You have the same problem with a property. Users have to add or remove

True. It's the same problem. Even if we specify the dummy cycles via a
property, the next plugged-in flash will use those. We can of course
fallback to the SFDP only init if the ID doesn't match any flash entry,
but the problem is the same.

> the property if the flash changes. Anyone thinking they can use this
> chip as a compatible 2nd source is SOL.
> 

I think the property vs compatible decision resumes at whether we
consider that the dummy cycles requirement for Read ID is/will be
generic or not.

I noticed that with higher frequencies or protocol modes (e.g, octal
DTR), flashes tend to require more dummy cycles. I think with time,
we'll have more flashes with such requirement. Takahiro can jump in and
tell if it's already the case with IFX.

Thus instead of having lots of new compatibles for this, I lean towards
having this property. I'm still open for the compatible idea, I just
wanted to explain better where we are.

Thanks,
ta


