Return-Path: <linux-kernel+bounces-435127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAC9E7000
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E073216B99C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8E0206F3E;
	Fri,  6 Dec 2024 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nJ3V6J3E"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324E206F35
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495065; cv=none; b=irGCDhK3XQPCWESYB/mv3UW18jxHyP3Ord1wMBLf9TqTbVtBbSpwpV3Col5gdWCHEJsjwW4SFf7Mjbacus5WHITSJsU6gtMvYH2cLCKqv0D+VhQ10LR4Mqf1oeaVuJ8gulcS7GjFQDwDHb9c70BNESESXlKT7ZzqMjhhipDnl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495065; c=relaxed/simple;
	bh=7oPiMJcLvGCD/foDGESKJW7aHQ+kfhsJMQSRPNe0cMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7lo6tifA49J5BnIetVXTXlAwLtNmWtGfvHwXAcfTeFTzdpsjlh06WbgzxnjQkb1Z7bDbVDjtFENiQUBUrPQ0rkW02ENf2xrr1DD7MBc0d+UNrWfKhYOGLR2VYRYFuI+pJ/tw5RQufRti4RtuubSCVmxxtyd3EMmUMk4BOKdpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nJ3V6J3E; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa636f6f0efso130829466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 06:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733495061; x=1734099861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwHfTrGKe1Ng6qTTv8m18Y45pZvy2+0tveAWJarX1a0=;
        b=nJ3V6J3EDG/JezqErBjaK4y+TyGwmDl+wmD0U3kEfCtEua/Ay85LXojzS5PaELP2GJ
         MWHoARByG+wERYq9bjQW2oWmTEdAm4Iui82srgkI9OrSlDAiGfbEfcq7OPoLygf9O4WR
         i+XohLKLXqE7BmnBrjqXtP+r/9G72rZ4hv7/iuiIqXU+Cyd2CBEU0JHiOq6bmTkhAp5c
         XBhgU3oOj9qHN7NuoMCI8lZSHbjxsyXSeZPFUdZl8VTYlyp40eSxRzLF6DL9R4qjRD31
         BsoTH4brlhZiICln7X1CUGk2GffMFeQrGZMe5/8dF2c+ZkubmZg5JLZAu3sUa/Tz6kYs
         soYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733495061; x=1734099861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwHfTrGKe1Ng6qTTv8m18Y45pZvy2+0tveAWJarX1a0=;
        b=Zn6+8YwH3YRPz2NzrxdErEIpDiu0Zf4g7nqP4GbSY/2tkCoIHo2oVmaATE94TQhD9J
         UeXukCcv4Kfcbk2pfc4oYucO9KwJdOA2/tH0LG1hjUgKbC8ktXeNBUHpLk3m+qSARTaj
         eploJIHFaLQ6LqXb0eOVPLBuqidPTD7i39/Jt1ldGBojUMbILd04RFxPxLP85kpHPgNX
         GoWcVY1epkgNyKJimADVFXyzkFmnuiTCzaNSXaVZF4YRsmI8pxEsznMdVerBCPk7R5Hc
         MSFwJrfH9RL7UiLfuvMiHcvrKaZBqOU4vSHFcvKgxIYtTwqmH2k9/vW/o9Y5UjgvdBGd
         4O5g==
X-Forwarded-Encrypted: i=1; AJvYcCVRz9LoyOGtYj2O52BD/4f0/BaPWECj0hNtDFsseNu1z8FYEmv/YCavS1gP7KD7WOleZ+g4OxPlQL7gy+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVdEF+Oqx7h+I7b8lHZXOr/786BtVLm/JHd1iM1FRXqzVxSPaH
	b/z3MqO9GQyeNIibYqs/kdDp1eL06tKOny0RBwF1vq09fPd1qu3B2wauhC4B/0U=
X-Gm-Gg: ASbGncviuj/eGJ4dtoGTT6ZEJ/2ikMckj182eNTGVf/aoOQwn+8OP9OwuJItI+xH7U4
	kse/mA9drQRew0nJKlU/CA5zx/EclmCgmUAosyz21Is5TyTfgkobbDAbcJwJItFUB1oHbFBsd+c
	YcuZviSUEyTKusZUPDcSOEKDoFCxfAY3kZQFZa0gdl8H4FITev6ZW9g432dT92y8IOFiXytBY99
	+HRpArg/aaCcUuRmwu+xn1MPeGbxOgSgS5QHQFwZovjEY3JeQmqeuyPNqo9BHY=
X-Google-Smtp-Source: AGHT+IEcTcffeDUZkl+nKBkgYPiYpxv1W8zJJQYjH/nBa4yD5QQ4BKGe/griAaUczS+I795ml4xtxA==
X-Received: by 2002:a17:906:4c9:b0:aa5:d06:4578 with SMTP id a640c23a62f3a-aa63a15a016mr199717266b.28.1733495060824;
        Fri, 06 Dec 2024 06:24:20 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e92a58sm248149066b.48.2024.12.06.06.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 06:24:20 -0800 (PST)
Message-ID: <9b9f5daa-2456-4ad0-9e56-a6978c35b197@tuxon.dev>
Date: Fri, 6 Dec 2024 16:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: change BU Power Switch to automatic mode
Content-Language: en-US
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cristian Birsan <cristian.birsan@microchip.com>
References: <20241125165648.509162-1-nicolas.ferre@microchip.com>
 <34a5b77b-e732-4393-a469-d9c719afa879@tuxon.dev>
 <24069031-9ed4-4592-af98-ff53222caf03@microchip.com>
 <c7ad1f03-f2a9-4706-ae87-2843b93de040@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <c7ad1f03-f2a9-4706-ae87-2843b93de040@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Nicolas,

On 06.12.2024 16:14, Nicolas Ferre wrote:
> Claudiu,
> 
> On 02/12/2024 at 17:44, Nicolas Ferre wrote:
>> On 02/12/2024 at 09:05, Claudiu Beznea wrote:
>>> Hi, Nicolas,
>>>
>>> On 25.11.2024 18:56, nicolas.ferre@microchip.com wrote:
>>>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>
>>>> Change how the Backup Unit Power is configured and force the
>>>> automatic/hardware mode.
>>>> This change eliminates the need for software management of the power
>>>> switch, ensuring it transitions to the backup power source before
>>>> entering low power modes.
>>>>
>>>> This is done in the only locaton where this swich was configured. It's
>>>
>>> s/locaton/location
>>>
>>>> usually done in the bootloader.
>>>>
>>>> Previously, the loss of the VDDANA (or VDDIN33) power source was not
>>>> automatically compensated by an alternative power source. This resulted
>>>> in the loss of Backup Unit content, including Backup Self-refresh low
>>>> power mode information, OTP emulation configuration, and boot
>>>> configuration, for instance.
>>>
>>> Should we add a fixes for this?
>>
>> Not so easy to tell as there's a loose dependency with the bootloader.
>> But it's true that switching to automatic never harm. So probably yes.
>>
>>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>> ---
>>>>    arch/arm/mach-at91/pm.c | 31 ++++++++++++++++++++-----------
>>>>    1 file changed, 20 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>>>> index b9b995f8a36e..05a1547642b6 100644
>>>> --- a/arch/arm/mach-at91/pm.c
>>>> +++ b/arch/arm/mach-at91/pm.c
>>>> @@ -598,7 +598,21 @@ static int at91_suspend_finish(unsigned long val)
>>>>         return 0;
>>>>    }
>>>>
>>>> -static void at91_pm_switch_ba_to_vbat(void)
>>>> +/**
>>>> + * at91_pm_switch_ba_to_auto() - Configure Backup Unit Power Switch
>>>> + * to automatic/hardware mode.
>>>> + *
>>>> + * The Backup Unit Power Switch can be managed either by software or
>>>> hardware.
>>>> + * Enabling hardware mode allows the automatic transition of power
>>>> between
>>>> + * VDDANA (or VDDIN33) and VDDBU (or VBAT, respectively), based on the
>>>> + * availability of these power sources.
>>>> + *
>>>> + * If the Backup Unit Power Switch is already in automatic mode, no
>>>> action is
>>>> + * required. If it is in software-controlled mode, it is switched to
>>>> automatic
>>>> + * mode to enhance safety and eliminate the need for toggling between
>>>> power
>>>> + * sources.
>>>> + */
>>>> +static void at91_pm_switch_ba_to_auto(void)
>>>>    {
>>>>         unsigned int offset = offsetof(struct at91_pm_sfrbu_regs, pswbu);
>>>>         unsigned int val;
>>>> @@ -609,24 +623,19 @@ static void at91_pm_switch_ba_to_vbat(void)
>>>>
>>>>         val = readl(soc_pm.data.sfrbu + offset);
>>>>
>>>> -     /* Already on VBAT. */
>>>> -     if (!(val & soc_pm.sfrbu_regs.pswbu.state))
>>>> +     /* Already on auto/hardware. */
>>>> +     if (!(val & soc_pm.sfrbu_regs.pswbu.ctrl))
>>>>                 return;
>>>>
>>>> -     val &= ~soc_pm.sfrbu_regs.pswbu.softsw;
>>>
>>> It seems that softsw and state members of at91_pm_sfrbu_regs.pswbu along
>>> with their initialization could be dropped. What do you think?
>>
>> I think that I tried when writing the patch but I think that there's a
>> little difference with sama5d2 register layout. Give me a couple more
>> days to come back to this and verify.
> 
> Ok, I remember now: I was wondering if I needed to remove the whole
> sfrbu_regs.xxx mechanism and define more generically the content of
> include/soc/at91/sama7-sfrbu.h for sama5d2, but if we need one day to use
> the STATE bit or even the SMCTRL bit of sama5d2, then it should be kept.
> 
> So, now that the mechanism is in place, I would prefer that we keep it:
> okay for you?

OK

> 
> Do you want me to re-spin a v2 for the rest?

No, I can handle the insignificant typo while applying.

Thank you,
Claudiu

> 
> Best regards,
>   Nicolas
> 
>>> I can do it while applying, if any.
>>>
>>> Thank you,
>>> Claudiu
>>>
>>>
>>>> -     val |= soc_pm.sfrbu_regs.pswbu.key | soc_pm.sfrbu_regs.pswbu.ctrl;
>>>> +     val &= ~soc_pm.sfrbu_regs.pswbu.ctrl;
>>>> +     val |= soc_pm.sfrbu_regs.pswbu.key;
>>>>         writel(val, soc_pm.data.sfrbu + offset);
>>>> -
>>>> -     /* Wait for update. */
>>>> -     val = readl(soc_pm.data.sfrbu + offset);
>>>> -     while (val & soc_pm.sfrbu_regs.pswbu.state)
>>>> -             val = readl(soc_pm.data.sfrbu + offset);
>>>>    }
>>>>
>>>>    static void at91_pm_suspend(suspend_state_t state)
>>>>    {
>>>>         if (soc_pm.data.mode == AT91_PM_BACKUP) {
>>>> -             at91_pm_switch_ba_to_vbat();
>>>> +             at91_pm_switch_ba_to_auto();
>>>>
>>>>                 cpu_suspend(0, at91_suspend_finish);
>>>>
>>
>>
> 

