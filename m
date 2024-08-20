Return-Path: <linux-kernel+bounces-293902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB13A958655
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8246B2882B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156418E768;
	Tue, 20 Aug 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZBB+gEeK"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4418A6BC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155150; cv=none; b=EYm5+NUEUxcPzYZ5XBlKWflcbw/yYcF2iMJn8GjACjsqVyImn09hyJzcOvlfkBVVmLVnYgC8DE233uzxHab/U04RkZvZ3AEYFbDYFHMWHg9IxQ70/YHy9cDHsZ/RZZTrnCvpiEzrB0b5g+iEXFyV67FSwErCchRZE7NWrPXxW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155150; c=relaxed/simple;
	bh=HB/rjHtHx0nA3DIsUylw7ODrGLvcmff7otJmyWVYebE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o6Z1to2onJElEGYA3De178GDqPGfkNFOu31fLEL+CErDh1f10fD0mtpEGZG8LD+kWq/EGwQb2RWuZCfWyYfFlXufwZFAD6LrKjRNaEhvn9CwIqL1yPUn9n/Vv9q7jGcw2MS2ccgtlr6RaVdk42mLV9cfAQdQwiwkk6gQp/gKauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZBB+gEeK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53310b07267so7137655e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724155145; x=1724759945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nFxuzjFCgkJM3sAjGZ8Yf6t2/ZIwmQ2s6Td+hf/DgrU=;
        b=ZBB+gEeKoIptKn707uEcIomvT6lpyxu23BFKbCLG73guAa/VPQtM9ox079OxRpkYCd
         GYVTafZK3tLkMrBPJUGGPXAPQNikGAjEi8TCEO+CdqdfsPWqqov9CmSpNfrUVwS06DAl
         fdXSUDui2pUh9yDUG3+ibaJTTIjsIrd89+2jL90VBYeM5KwppolkdMTS8kICCWcbBnk7
         QDtd2LnYeIlamisqWj59aEZePqoT7VZ3JmM1/cqxrw83ORLnphBQOk5U1zBDjjPWdRY4
         E8UoQhiVv7+p/1cjA5ceQNoiCX8g9e3IEin3+MQrzhuo+Ep73Nt0s2I6RnYFt8NySGwz
         CIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724155145; x=1724759945;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFxuzjFCgkJM3sAjGZ8Yf6t2/ZIwmQ2s6Td+hf/DgrU=;
        b=r2T0huAcrf/BYhqgt3TlsURlRYzojzw+BDXYhtcrDdnfjbXAts7Kq/8uE6TpUQH7Gf
         mdha2Dv+VjgOwAiawQ8ogN4OQXqejRzU6hSkygwY0iYWV7pQ5edjioZxwUtzjIG77sE/
         got9UwJJUbXIUN8khOmkUg5wAkLWzuDmLxrbpLsP441PewbVj/E1VMcO9ceo7Ym+HpMA
         5HtON1y9DXkLEfZCnZjtFOjI6qI1UzGs3lt2rDRE3SRVXQTR0+kDzMp5Ytx4lCQmv4zD
         T6M70XNZcLeKX5qqUGE7H9eop5wQrdiJsOMFvhkZCHWoaymShRRsFQCHtUakciRH9u8X
         njfA==
X-Gm-Message-State: AOJu0Yz0mlULOaPWl3DLu7vynHUMI5Mn/M8fnksr6pmJwgtXwfa5m44a
	dfWsje7zCzW+jW9XbefGZtHMbn6TvTjjVxM1TsYOTdYffegS0TqMwRxBQM9duRY2mRxWkPVI++L
	4
X-Google-Smtp-Source: AGHT+IG0rs1clXSKqMVK20PgcBimoqMXo7ETSjYoEaN80e48D2PX3Ar5IhKHzO5RPPbI7CoIMi8ZMQ==
X-Received: by 2002:a05:6512:220b:b0:533:c9d:a01f with SMTP id 2adb3069b0e04-5331c692014mr12244567e87.4.1724155145189;
        Tue, 20 Aug 2024 04:59:05 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394716esm762069366b.146.2024.08.20.04.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 04:59:04 -0700 (PDT)
Message-ID: <479c083b-9c1a-4200-aff5-77dc250e536c@tuxon.dev>
Date: Tue, 20 Aug 2024 14:59:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Timeout error with Microchip OTPC driver on
 SAM9X60
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20240412140802.1571935-1-ada@thorsis.com>
 <d4dc3f45-5bae-44a8-8169-58077f8b7966@tuxon.dev>
 <20240813-payable-ecology-8a9e739704bb@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20240813-payable-ecology-8a9e739704bb@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Alexander,

On 13.08.2024 11:55, Alexander Dahl wrote:
> Hello Claudiu,
> 
> Am Wed, Apr 24, 2024 at 10:32:02AM +0300 schrieb claudiu beznea:
>> Hi, Alexander,
>>
>> On 12.04.2024 17:08, Alexander Dahl wrote:
>>> Hei hei,
>>>
>>> on a custom sam9x60 based board we want to access a unique ID of the
>>> SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
>>> content of the OTPC Product UID x Register in that case.
>>>
>>> (On a different board with a SAMA5D2 we use the Serial Number x Register
>>> exposed through the atmel soc driver, which is not present in the
>>> SAM9X60 series.)
>>>
>>> There is a driver for the OTPC of the SAMA7G5 and after comparing
>>> register layouts it seems that one is almost identical to the one used
>>> by SAM9X60.  So I thought just adapting the driver for SAM9X60 should be
>>> easy.  (At least as a start, the driver has no support for that UID
>>> register, but I suppose it would be the right place to implement it.)
>>>
>>> However it does not work.  I used the patch attached with
>>> additional debug messages on a SAM9X60-Curiosity board.  (That patch is
>>> not meant for inclusion, just for showing what I've tried.)
>>>
>>> On probe the function mchp_otpc_init_packets_list() returns with
>>> ETIMEDOUT, which it can only do if mchp_otpc_prepare_read() returns with
>>> timeout and that can only happen if read_poll_timeout() times out on
>>> reading the Status Register.  Poking that register with `devmem
>>> 0xeff0000c 32` gives 0x00000040 which means "A packet read is on-going".
>>
>>
>> Would it be possible that the OTP memory is not properly initialized and
>> the algorithm to initialized the packet list to confuse the hardware?
>>
>> I see in the datasheet the following: "The initial value of the OTP memory
>> is ‘0’ but the memory may contain some “defective” bits already set to the
>> value ‘1’."
> 
> I think this might be possible?  SAM-BA also stumbles here, but the
> SoC is like shipped by the vendor, no OTPC writes ever from my side.

I'm not sure how the SAM9X60 OTP memory is shipped by vendor. If I remember
correctly the user must flash the bootconfig packet depending on his needs.

> When calling this …
> 
>     $ sam-ba -p serial -d sam9x60:0:1 -t 5 -a bootconfig -c readcfg:bcp-otp
> 
> … I get this on serial debug output:
> 
>     Applet 'BootConfig' from SAM-BA Applets Framework 3.8 (v3.8).
>     -E- Cannot read Boot Config Packet.
>     -E- Invalid parameter for read config: index 0
> 
> Question is: how should the driver behave in this case?  Fail like it
> does now?  Or load in some kind of safe state with "empty" nvmem?

The driver cannot know if the memory is defective or not. Not that I've
know. It expects the memory to be in a proper state.

E.g. On SAMA7G5 the OTP memory has at lest the temperature sensor
calibration data packet. And if I remember correctly, it also has the
bootconfig packet on the first position.

Thank you,
Claudiu Beznea

> This is especially interesting with regard to a new question below.
> 
>> Otherwise, from the top of my mind I don't have any idea on what might happen.
> 
> I have some debug code here, and digging deeper into this currently to
> see what's really happening.  While at it, a new question came up:
> 
> There's this OTP memory which the driver tries to expose as NVMEM.
> However what I really want to do is getting access to the OTPC Product
> UID x Registers, which are not OTP memory but plain registers inside
> of the address space of the OTPC here.  Should this be exposed as a
> second nvmem device then, or handled by a different driver?  How would
> accessing the same register space from different drivers be handled
> then?
> 
> Greets
> Alex
> 
>>
>> Thank you,
>> Claudiu Beznea
>>
>>>
>>> Kinda stuck here.  Any ideas?
>>>
>>> Greets and have a nice weekend everyone
>>> Alex
>>>
>>> Alexander Dahl (1):
>>>   nvmem: microchip-otpc: Add support for SAM9X60
>>>
>>>  .../dts/microchip/at91-sam9x60_curiosity.dts     |  4 ++++
>>>  arch/arm/boot/dts/microchip/sam9x60.dtsi         |  7 +++++++
>>>  drivers/nvmem/microchip-otpc.c                   | 16 +++++++++++++---
>>>  3 files changed, 24 insertions(+), 3 deletions(-)
>>>
>>>
>>> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

