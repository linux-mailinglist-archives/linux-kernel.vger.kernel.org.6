Return-Path: <linux-kernel+bounces-309955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F073E96726A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665021F2251A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254628377;
	Sat, 31 Aug 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PmwzjSLZ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132C23775
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725118692; cv=none; b=ah9HzTk39ZWYFI3Jrb4R9Cn0MXnrCCfHGztRdv2Q1u6LNrgWF6uc6prSt3KSGVE8tNfODnVjQn5ySOoI/Bt6IXbo+gbpXm224lICGxjW2MCdIjOj4oHb2Pa2gj8/JxS+03/5bMemTpsT7z9Bl+CKgn7T6UPJYxGid3N42f5MjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725118692; c=relaxed/simple;
	bh=bAclMpx8G9l4pXyS/2hc+W4v1YGIfepANSFskHgHYQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h/Ls6mizfBD4KbDATLpwm3ES6hLamv8Q5lWB8NXsUP/Esk74f1WZCMJ9kYrs/nXrs8Gli467dB0eXx06c43d78xPwxDv9OTr9xb3vl5sGGGZzkB40M99UPonMzAGyihSH6X5tANEr6CEgBNlfvwP9LK5nXKXN48jfV3409spgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PmwzjSLZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374ba4e094aso750769f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725118689; x=1725723489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZthrGtEqqFLYC6PIzIIDizVrqC6Gx/oqBLZku67P34=;
        b=PmwzjSLZTGJpcgXAbWAqzI2Dgx4c+MEQiFfFdp9GEyeKyzXyP9W0snmtzylLslN8wc
         oBNa25XhPX9Fpu5I4CYTMXSmxOmq4xQeNRLFT6Bb8UHVnR0voMs7EqcNaygb4sUUC3ms
         aWXJZPrn20OhtIjIpoGDkOKMQIFhEaS93YjVrx9cWQCQuwIdK0EXw4toF8kKUPYoDn5Y
         dDM3Vji8PQi7A9mEZKD2YxAgUcjnUBHdDLrdBFitC+koKiZeGErOxotlZhiayORWXv9n
         m6RGSWJ0CInmhQjL8G6JV5abKLkvJmQc0IJI32zEIcH6o0+kplOSi7EQaaxf9UqTKt9h
         RiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725118689; x=1725723489;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZthrGtEqqFLYC6PIzIIDizVrqC6Gx/oqBLZku67P34=;
        b=TIGxHKDn3B0qGt7mOpZYpYsHB1eLTLiVe57WGmosFacUYDEpcyDIHTUZ5KoKhwlIt7
         O0VZ8XEiMzafh3Gh64kI4RQrBxGSyU/ndy7nTC7KAbQ8WuI5sP+gbXlj6VfjOZ0LUhRg
         CTt4Ck7s3KgpsQSrZ8AA/t02LTge1WNQwZyjLMuFatolJ1U5g3N6vEvToS1kwd+V3XWP
         mRbqAkvlnIQQOoQvHDkna+eIW+32+eAeztEjHLZ6lo7+tb1XYwb+deTKIHQV0CTQQNMN
         FPCktu6xj7cxn7+9k5mwJpiwowJ9xJzxlyGf+dkXgg67nN/DzxyI/2/eiJuPduSalUzI
         hrAA==
X-Forwarded-Encrypted: i=1; AJvYcCUNtuwluf6My5TUar2vl/alkAPTGViaQs89qvkxzlRUNYp2nTviq2FBb5d7+iPYF/crxlfbpj6VamoAf7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+rhacs5jmekzSzgookd6SAOmqcnM3CKQ1mEP0K7CEUeaKPQL
	FjhNko8G0f57uTxwsUEEvRZ/7f1n1xoNfFiF7q8chzzUbeNIygzXW8xbtQfzPV8=
X-Google-Smtp-Source: AGHT+IEkkDlKTut9HMW81eLUExS8xSMLD6ArSEwZXNGJj9UgxWCYQMDP/Ydx1Ja/ANu3OiJc/FSH+g==
X-Received: by 2002:adf:e405:0:b0:374:bcff:cfa6 with SMTP id ffacd0b85a97d-374bf04f7e6mr1176513f8f.18.1725118688647;
        Sat, 31 Aug 2024 08:38:08 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee6f76asm6777148f8f.25.2024.08.31.08.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 08:38:08 -0700 (PDT)
Message-ID: <5e34726c-214a-4e2f-bfb0-e30c89dc7059@tuxon.dev>
Date: Sat, 31 Aug 2024 18:38:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/12] Microchip OTPC driver on SAM9X60 exposing UIDxR
 as additional nvmem device
Content-Language: en-US
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Christian Melki <christian.melki@t2data.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240821105943.230281-1-ada@thorsis.com>
 <717bd06f-3eba-4825-a53f-b2f9aa1c81c8@tuxon.dev>
 <20240828-steadily-nearby-1fe97d4cbe97@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240828-steadily-nearby-1fe97d4cbe97@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexander,

On 28.08.2024 10:31, Alexander Dahl wrote:
> Hello Claudiu,
> 
> thanks for having a closer look on the series.  The issues the bots
> complained about are already fixed in my working copy and will be part
> of v2.  Detailed discussion on particular patches itself over there,
> general remarks below.
> 
> Am Sat, Aug 24, 2024 at 07:17:43PM +0300 schrieb claudiu beznea:
>> Hi, Alexander,
>>
>> On 21.08.2024 13:59, Alexander Dahl wrote:
>>> Hei hei,
>>>
>>> on a custom sam9x60 based board we want to access a unique ID of the
>>> SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
>>> content of the OTPC Product UID x Register in that case.
>>>
>>> (On different boards with a SAMA5D2 we use the Serial Number x Register
>>> exposed through the atmel soc driver.  Those registers are not present
>>> in the SAM9X60 series, but only for SAMA5D2/SAMA5D4 AFAIK.)
>>
>> Not sure if you are talking about Chip ID, Chip ID extension registers.
>> These are available also on SAM9X60.
> 
> No, this is not what I'm talking about.  The Chip ID and Chip ID
> extension registers are common over all SoCs of the same type.
> 
> What I need is a unique ID, the same sam-ba returns with the
> "readuniqueid" applet.  The SAMA5D2 has this in SFR_SN0 and SFR_SN1,
> handled by drivers/soc/atmel/sfr.c driver.  The SFR block on sam9x60

I see, I missed this one.

> has no SNx registers, the unique ID comes from OTPC_UIDxR here.
> 
> Best thing would be a simple nvmem device for the SAM9X60 providing
> just those 4 registers, in a similar way the sfr driver does for
> SAMA5D2.  This is the motivation for the series and what's eventually
> done in patch 12.  The other patches are just fixing the otpc driver
> for SAM9X60 so I can add that nvmem stuff.

Got it, thanks for details.

Thank you,
Claudiu Beznea

> 
> Greets
> Alex
> 
>>> There is a driver for the OTPC of the SAMA7G5 and after comparing
>>> register layouts it seems that one is almost identical to the one used
>>> by SAM9X60.  Currently that driver has no support for the UIDx
>>> registers, but I suppose it would be the right place to implement it,
>>> because the registers are within the OTPC register address offsets.
>>>
>>> The patch series starts with fixups for the current driver.  It then
>>> adds the necessary pieces to DT and driver to work on SAM9X60 in
>>> general.  Later support for enabling the main RC oscillator is added,
>>> which is required on SAM9X60 for the OTPC to work.  The last patch adds
>>> an additional nvmem device for the UIDx registers.
>>>
>>> This v1 of the series was _not_ tested on SAMA7G5, because I don't have
>>> such a board for testing.  Actually I don't know if the main_rc_osc
>>> clock is required on SAMA7G5 too, and if yes how to handle that with
>>> regard to the different clock ids.  If someone could test on SAMA7G5
>>> and/or help me sorting out the core clock id things, that would be
>>> highly appreciated.
>>
>> Please add Nicolas in the loop on the next revisions of this series as this
>> should also be tested on SAMA7G5. I don't have a SAMA7G5 with OTP memory
>> populated.
>>
>>>
>>> Also I assume some more devicetree and/or sysfs documentation is
>>> necessary.  If someone could point me what's exactly required, this
>>> would be very helpful for me.  You see I expect at least another version
>>> v2 of the series. ;-)
>>>
>>> Maybe some files having that "sama7g5" should be renamed, because that
>>> DT binding is used for more SoCs now and deserves a more generic name?
>>
>> Not needed, adding your compatible there is enough.
>>
>>> Thinking of these for example:
>>>
>>> - Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
>>> - include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
>>>
>>> Are there other SoCs than SAMA7G5 and SAM9X60 using the same OTPC?
>>>
>>> Last question: Should the UID be added to the device entropy pool with
>>> add_device_randomness() as done in the SAMA5D2 sfr driver?
>>>
>>> I sent an RFC patch on this topic earlier this year, you'll find the
>>> link below as a reference to the discussion.  The patch itself was
>>> trivial and not meant for applying as is anyways, so I decided to not
>>> write a full changelog from RFC to v1.
>>>
>>> Last not least, special thanks to Christian Melki on IRC, who wrote and
>>> tested parts of this, and was very kind and helpful in discussing the
>>> topic several times in the past months.
>>>
>>> Christian, if you feel there's credit missing, just point me where to
>>> add Co-developed-by and I'll happily do that for v2.
>>>
>>> Greets
>>> Alex
>>>
>>> (series based on v6.11-rc4)
>>>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: devicetree@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-clk@vger.kernel.org
>>> Link: https://lore.kernel.org/all/20240412140802.1571935-2-ada@thorsis.com/
>>>
>>> Alexander Dahl (12):
>>>   nvmem: microchip-otpc: Avoid writing a write-only register
>>>   nvmem: microchip-otpc: Fix swapped 'sleep' and 'timeout' parameters
>>>   dt-bindings: nvmem: microchip-otpc: Add compatible for SAM9X60
>>>   nvmem: microchip-otpc: Add SAM9X60 support
>>>   ARM: dts: microchip: sam9x60: Add OTPC node
>>>   ARM: dts: microchip: sam9x60_curiosity: Enable OTP Controller
>>>   nvmem: microchip-otpc: Add missing register definitions
>>>   nvmem: microchip-otpc: Add warnings for bad OTPC conditions on probe
>>>   clk: at91: sam9x60: Allow enabling main_rc_osc through DT
>>>   ARM: dts: microchip: sam9x60: Add clock properties to OTPC
>>>   nvmem: microchip-otpc: Enable main RC oscillator clock
>>>   nvmem: microchip-otpc: Expose UID registers as 2nd nvmem device
>>>
>>>  .../nvmem/microchip,sama7g5-otpc.yaml         |  1 +
>>>  .../dts/microchip/at91-sam9x60_curiosity.dts  |  4 +
>>>  arch/arm/boot/dts/microchip/sam9x60.dtsi      | 10 +++
>>>  drivers/clk/at91/sam9x60.c                    |  3 +-
>>>  drivers/nvmem/microchip-otpc.c                | 86 ++++++++++++++++++-
>>>  include/dt-bindings/clock/at91.h              |  1 +
>>>  6 files changed, 100 insertions(+), 5 deletions(-)
>>>
>>>
>>> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399

