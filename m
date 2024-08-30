Return-Path: <linux-kernel+bounces-308309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2F965A27
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545791C208B2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBB16CD28;
	Fri, 30 Aug 2024 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PdX55yCj"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287516726E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006167; cv=none; b=nxtrX1umf7fxbTwdOmaxZJMvD/N5kQr6d0MFZPFNKCqnOMNqU+z4mUkEod8nD/1iCQFQfYd9h6sfgQDEG5j9I1MFD3rxCqNi6x0dvMf9gCoPekVbgSCnig44HZuU9Nq2TOqDxxKHUq1LHtyq+e3LZ+u2yxpHg/6txz2ZzZRiwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006167; c=relaxed/simple;
	bh=lg2a5Or0gfd5Bku8PfxGPt1GgB3ed0TVDFLBpQJIMg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCPTz9EB27cyssNhrpvVQBbEDINCI8sg0vXWmNjSnZzUEZXCNcs0BFcWgI9eZo0L99Mqy4KQsc5XKED4FOlhSnioui6n66e/qwmdHuDEhD/ZidRjzaQ5LSuAuhItw4M52EatgZfXjUsNx7hwbotuloS1a5joZCtEH5OsUR1j/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PdX55yCj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428243f928fso17178475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725006164; x=1725610964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zchK+tZfRdJr/B0VNKRrEBtLoJmeJfsr2YpFzQ08IdE=;
        b=PdX55yCjayxLU3a0HuryCmcojZbcsP1de6j68M6ebp45drf94iA8NvQ3vsQjHDYp5n
         P8yVFUuidLKGgIn94toZdJ8Hez/KX4ijJvG3obykwA8N6EFCXEfuV0jL5hfAVLH9n2FT
         JDgtvtEv2wNPr5PRcw7s1+jaMBUU/ydxJV/5vXjkSb4A6Hx/WLesh7ismzSRiwg1c8oU
         hs4k49jr+zfamjjjl1mOB2Jsvq2B1n/itmC73c4rO1JTg7oZOIHiq05+A5mpJ6OPVLqD
         zUantHtRV6mHWHqKBVgjPqry3UzYkH1R5EeiZOey60NAit5f9lGIWVAf7MkpNyPle08y
         M+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006164; x=1725610964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zchK+tZfRdJr/B0VNKRrEBtLoJmeJfsr2YpFzQ08IdE=;
        b=bZcVMdU83fjb9ZPzokG4Mm8g0yStDR4r4cI0QLlrFMRn6BlTtbT1aOLB/ZINk764tW
         Td/EUikFTeY5woTz+sYqcgF2c7W3Wlx/fSyUm+wNvoFX5+tGeQB3ncC6OGPt8vf+uh2r
         k5tYBCNMIiAAFGxQYDfg9+T5I2r9+2TbooAH+RDedhPCDo3pAgECifenwo/zbRBCKWdv
         MlVQMqYS0MKvQMpXaJF818Kz2H999zSSm8AOlI+l6zjXcdlgdgTAlYs0lJa/11Pywawo
         AR9R/Ax0OOW1LdGfJTaxZOhdajMz/KPkZ9GaueusSS+K+PHWSBbLScdoWi11j5GCRRXx
         GJDg==
X-Forwarded-Encrypted: i=1; AJvYcCXHrrBxxEwXLun6GkbsD1/ITQmuIgaoG1h/kVbnioTKQvO4HK1BHzIJZi/xwCyoCXao1D+4ai1GcMZpwng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqyFQpVFmdR/tP8Jm8P/4Vagg6SAKte0kaCXe0s4P08K/wjTWS
	nfelZhOiBVG2GKfOqj+42J3E1ktNiz/LaSW9HKKWkofZlDnvzFXyZfHYZr1RzvI=
X-Google-Smtp-Source: AGHT+IF8ZkJGKUmuglZKyShKgzTB0GuKfWBu6xay0mGYscvHuYinOaW5h5J83vGVNlCFB6KS0zIxvQ==
X-Received: by 2002:a05:600c:3ca2:b0:426:5520:b835 with SMTP id 5b1f17b1804b1-42bb01ae206mr53646705e9.5.1725006164296;
        Fri, 30 Aug 2024 01:22:44 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb87f7fccsm31864805e9.46.2024.08.30.01.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:22:43 -0700 (PDT)
Message-ID: <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
Date: Fri, 30 Aug 2024 11:22:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com,
 sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

On 29.08.2024 18:26, Ulf Hansson wrote:
> On Thu, 22 Aug 2024 at 17:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> Series adds initial USB support for the Renesas RZ/G3S SoC.
>>
>> Series is split as follows:
>>
>> - patch 01/16           - add clock reset and power domain support for USB
>> - patch 02-04/16        - add reset control support for a USB signal
>>                           that need to be controlled before/after
>>                           the power to USB area is turned on/off.
>>
>>                           Philipp, Ulf, Geert, all,
>>
>>                           I detailed my approach for this in patch
>>                           04/16, please have a look and let me know
>>                           your input.
> 
> I have looked briefly. Your suggested approach may work, but I have a
> few thoughts, see below.
> 
> If I understand correctly, it is the consumer driver for the device
> that is attached to the USB power domain that becomes responsible for
> asserting/de-asserting this new signal. Right?

Right!

> 
> In this regard, please note that the consumer driver doesn't really
> know when the power domain really gets powered-on/off. Calling
> pm_runtime_get|put*() is dealing with the reference counting. For
> example, a call to pm_runtime_get*() just makes sure that the PM
> domain gets-or-remains powered-on. Could this be a problem from the
> reset-signal point of view?

It should be safe. From the HW manual I understand the hardware block is
something like the following:


                  USB area
         +-------------------------+
         |                         |
         | PHY --->USB controller  |
SYSC --> |  ^                      |
         |  |                      |
         | PHY reset               |
         +-------------------------+

Where:
- SYSC is the system controller that controls the new signal for which
  I'm requesting opinions in this series
- PHY reset: is the block controlling the PHYs
- PHY: is the block controlling the USB PHYs
- USB controller: is the USB controller

Currently, I passed the SYSC signal handling to the PHY reset driver; w/o
PHY reset the rest of the USB logic cannot work (neither PHY block nor USB
controller).

Currently, the PHY reset driver call pm_runtime_resume_and_get() in probe
and pm_runtime_put() in remove. The struct reset_control_ops::{assert,
deassert} only set specific bits in registers (no pm_runtime* calls).

The PHY driver is taking its PHY reset in probe and release it in remove().
With this approach the newly introduced SYSC signal will be
de-asserted/asserted only in the PHY reset probe/remove (either if it is
handled though PM domain or reset control signal).

If the SYSC signal would be passed to all the blocks in the USB area (and
it would be handled though PM domains) it should be no problem either,
AFAICT, because of reference counting the pm_runtime_get|put*() is taking
care of. As the PHY reset is the root node the in the devices node tree for
USB the reference counting should work, too (I may miss something though,
please correct me if I'm wrong).

If the SYSC signal would be handled though a reset control driver (as
proposed in this series) and we want to pass this reference to all the
blocks in the USB area then we can request the reset signal as shared and,
AFAIK, this is also reference counted. The devices node tree should help
with the order, too, if I'm not wrong.

Thank you for looking at this,
Claudiu Beznea

> 
> [...]
> 
> Kind regards
> Uffe

