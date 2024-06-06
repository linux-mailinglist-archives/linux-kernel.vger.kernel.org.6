Return-Path: <linux-kernel+bounces-204259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3E08FE64B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4D4B23F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D79195FC4;
	Thu,  6 Jun 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdAjV9ES"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B0195F2E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676068; cv=none; b=VMB9JMW440pt7aTJQPi5OCYjXII9p5hkNQupTRH7gL0y87+JQbzQKN5/1U7rqzjUEyMgOZxB12hlCCmZWAaNSSzd5x0OfH4UAaDbp8flzWIiVFC+Pz1hAoZv7b/+r8QXUD9opDKsB6vMsbOfpD4eqGBUvbS3Ew+K+oSnRhfzUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676068; c=relaxed/simple;
	bh=6Wohv+osAdLb7FnEZVEAAa/e/pGCKjdQxGRzOwQyVOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBfnJGv73vkDxBZNBbVgzVX1cguuNamYRJ3z/dhxwSqkD98neyYih1qC9RZevJu22Xe4yr9GtcCuyskdQ7z1wCYNq76/kPB9mRZxpMx/nD4Ubmexc/JQCG4EO8gXgFILcjaaARTg41WvM80mreFD1axGA6+kNXbD5NyErVpS0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdAjV9ES; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso3361579a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717676065; x=1718280865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4eR0U8qSC2JKNbsIe9eb3BDB8OBTYCS7ARMldo+loA=;
        b=RdAjV9ES7QP3/zlbiaQC7UxjHBJtqHjGzaGkuPDKIhc2opTV/ibDiAgx36Rh+T6KrK
         CSBzhAKncY2C2szDlY86Epeu+oy8aE6QxQG8K3SXm50ENLcMnb4olXg/nhGZeTHHuYl8
         4vm2MtOOj8c6qvJ7qKcJMA+NgRPTNPEwN0eU/ya/TdDH5IYs1vZ8fxiQ0tKd8r0n18Al
         6lu+XCbBo3YM608OgdXEGfLgfn+WhWrkLQdzEV9jccuMdHzSMY0UidbB5sDRwklewM9z
         D9HYwbiSEK6RqwGMJP5psiLobvQ3R1PQjy1jXZHy+r9saaDz/M/9ihOjov4+wK+CJBSe
         RHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717676065; x=1718280865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4eR0U8qSC2JKNbsIe9eb3BDB8OBTYCS7ARMldo+loA=;
        b=qXq5ugj0KIkRqBbzInc2gW/TV0++X/GBaV3K5+QeQpGWsjECa6TelOaesFAA2bmydK
         WUFKfUVv6bDGUo8cFC+9gN6+GGwDR2f9amdwzmsvOIqBffHwaOKqpY1/RuxCQccr2tZJ
         AaLxCdF4dWr1GaLPds8/y42vH/1NzE1UYECUsql2OgRDoiczqqOdrPpZqFcfv1fxMWAp
         Thwavp/CxDYmHn7DTGflWfwKCrth8th53v8b/qhdUhXI9In+r0JOhriMA5QBPYQlKrk9
         Jq2MwXH4rTtIxkIeFT9pyHcecJd0wtlHNLVamZXnf6siZg2CDWq4LTF1BxbIGgBt8v9O
         DPdg==
X-Forwarded-Encrypted: i=1; AJvYcCUqZJlC96pZOuF4Lco6EdBrdUf/r4YU9CJf1RShvvQk8YG4HMP17P3tZqapeyh+UWMLjDP9gqfVza08YgnUnQgQO/uUz+j6hdro4wyT
X-Gm-Message-State: AOJu0YytaAR0X9aRI3Bf6OhXFDvzAfjTxkVujEbx2xY2jffv4IxeLRGX
	USiWlkahiG/zbw1LbVAcaMGuOaXQAjK9mKFVDb8D4FKbGK4KBqTQnRPGbzWzXF4=
X-Google-Smtp-Source: AGHT+IEhF5VnQ6RnaPOF2ap3H2sWIDZtTNmy4OAYW9J+Tfvg4TS3Uau9eObHLN4jYtjlQ3mlVjyN6g==
X-Received: by 2002:a50:9eeb:0:b0:579:fb7e:2112 with SMTP id 4fb4d7f45d1cf-57aa5425c5cmr2134985a12.11.1717676065035;
        Thu, 06 Jun 2024 05:14:25 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9d28bsm993500a12.19.2024.06.06.05.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 05:14:24 -0700 (PDT)
Message-ID: <1094fbfd-0ee7-430e-b62c-20764c1fbeec@linaro.org>
Date: Thu, 6 Jun 2024 13:14:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
To: Thorsten Scherer <T.Scherer@eckelmann.de>,
 Michael Walle <mwalle@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Marek Vasut <marex@denx.de>, Imre Kaloz <kaloz@openwrt.org>,
 Andrew Lunn <andrew@lunn.ch>, Flavio Suligoi <f.suligoi@asem.it>,
 kernel@pengutronix.de
References: <20240604074231.1874972-1-mwalle@kernel.org>
 <kl4ikwh4fpkhhlpneuujyk2j4a2byif7l27n7kgb4pm72hb4an@akhbc4jg6hyq>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <kl4ikwh4fpkhhlpneuujyk2j4a2byif7l27n7kgb4pm72hb4an@akhbc4jg6hyq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/5/24 14:58, Thorsten Scherer wrote:
> Hello,
> 

Hi!

> in the past I more actively worked on the ci4x10.  That changed after switching
> departments.  Anyway, I thought maybe it's useful if I share my point of view.
> 
> On Tue, Jun 04, 2024 at 09:42:31AM +0200, Michael Walle wrote:
>> These devices are more like an AT25 compatible EEPROM instead of
>> flashes. Like an EEPROM the user doesn't need to explicitly erase the
>> memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
>> (flash) driver, one should instead use the at25 EEPROM driver.
>>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> You cannot reach Uwe via this address anymore.
> 
> IMHO missing in this discussion is 
> 
>     kernel@pengutronix.de
> 
> , which I added to CC.
> 
>> Cc: Thorsten Scherer <t.scherer@eckelmann.de>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Imre Kaloz <kaloz@openwrt.org>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Flavio Suligoi <f.suligoi@asem.it>
>> ---
>> The referenced binding only supports the true AT25 compatible EEPROMs
>> where you have to specify additional properties like size and page size
>> or cypress FRAM devices where all the properties are discovered by the
>> driver. I don't have the actual hardware, therefore I can't work on a
>> proper driver and binding. But I really want to deprecate the use of
>> these EEPROM like devices in SPI-NOR. So as a first step, mark the
>> devices in the DT bindings as deprecated.
>>
>> There are three in-tree users of this. I hope I've CCed all the relevant
>> people. With the switch to the at25 driver also comes a user-space
>> facing change: there is no more MTD device. Instead there is an "eeprom"
>> file in /sys now, just like for every other EEPROM.
> 
> My vague memory tells me (at least some of) the domain specific applications
> running on ci4x10 rely on MTD(block?) devices.  So this change would break
> user-space.

it's a possibility, indeed. I assume we don't know for sure, right?
> 
>> Marek already expressed, that the sps1 dts can likely be removed
>> altogether. I'd like to hear from the other board DTS maintainers if
>> they seem some problems moving to the EEPROM interface - or maybe that
>> device isn't used at all anyway. So in the end, we can hopefully move

if it's not used at all we can remove it entirely.

>> all the users over to the at25 driver.
> 
> The ci4x10 is still being used and sold.  Right now I do not have a clear
> view on the implications of moving to that driver.  I'd like to invest some
> time to sharpen my picture (or find the person that claims responsibility), but
> this will propably not happen this week.
> 

if it's used then we are forced to keep the entry in SPI NOR for
backward compatibility. But we can still deprecate the use and forbid
new support in SPI NOR while directing users to the other driver.

> Hope this helps.
> 
Thanks!
ta

