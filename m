Return-Path: <linux-kernel+bounces-435119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9064C9E6FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A63168D56
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B777207E14;
	Fri,  6 Dec 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IFJoSVAt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1B2E859
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494490; cv=none; b=JSKV2+fKHnM638NVyZG9Dl0Tg4cP7JNXULrmuV4y7wIKVtIr0ZK47Lm3JYTiBunZqU4aUl+FTyrkWjnpKPj+mg1b40Fb+/Y7ioQZlWwmB009rThFGpqP/64Z1tdjFFwzI31PD/CJxhZdqP/c9y9W5NQJIOalUZeNzvwNP8YYoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494490; c=relaxed/simple;
	bh=S9ZuMJHhQfi2ySmApw4QqUCGnkxfvXkwr5pJnt7ri04=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Rk2SyIQMPS7LQyQFSs9d04+EYq0gRDj3qAGy+sLqmAQ7YQEHUYk2TDNEOqqVcy+62ftpkXcXYvuKd1MPln4pUnMk7yj7wXyQWIbQaH0lZ0nyZ/jWR4aMWwOwrRdqlxC9bx+tuMrIMlNSolTuKOmCXKVkyxW5cRQ+or5GoP357CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IFJoSVAt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733494488; x=1765030488;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=S9ZuMJHhQfi2ySmApw4QqUCGnkxfvXkwr5pJnt7ri04=;
  b=IFJoSVAtX6SUpUNMnXLVVIceW0b1RcZ6TDIWfGH8pOxFyylMQWtvKRjm
   64dsr8E7+c/n2OZH41HY26MhJzb5jIZd9SqGzRQiESRM+aduQyg7APhRG
   gV2Ou2LV3bJfj36f7dxNw/4hcfCRizJS1IH5ZITL2AFaU0dCfFevbdGuO
   /RIPlrr4q9+rxQSteQK7hJLWBnxAKMjlwQqt9b7IdFEiM7uLOsma/j3M6
   yqDvwRHzBjqt8QumoGim3NGM9ST7dC92dd/YE/oIJO6lXCy1KAapfrWBH
   K3dkXlvhIn6qzE7jx960PxRVjrIEpp7CP2vi+NtOZsAwfztx+mpjdq1Ag
   g==;
X-CSE-ConnectionGUID: LNqYZ07gQL+lqwuz+ksYkA==
X-CSE-MsgGUID: +JKe+NVQQ1asrSyShs1RmQ==
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="34914261"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 07:14:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 07:14:01 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 6 Dec 2024 07:14:00 -0700
Message-ID: <c7ad1f03-f2a9-4706-ae87-2843b93de040@microchip.com>
Date: Fri, 6 Dec 2024 15:14:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: change BU Power Switch to automatic mode
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Cristian Birsan <cristian.birsan@microchip.com>
References: <20241125165648.509162-1-nicolas.ferre@microchip.com>
 <34a5b77b-e732-4393-a469-d9c719afa879@tuxon.dev>
 <24069031-9ed4-4592-af98-ff53222caf03@microchip.com>
Organization: microchip
In-Reply-To: <24069031-9ed4-4592-af98-ff53222caf03@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Claudiu,

On 02/12/2024 at 17:44, Nicolas Ferre wrote:
> On 02/12/2024 at 09:05, Claudiu Beznea wrote:
>> Hi, Nicolas,
>>
>> On 25.11.2024 18:56, nicolas.ferre@microchip.com wrote:
>>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>
>>> Change how the Backup Unit Power is configured and force the
>>> automatic/hardware mode.
>>> This change eliminates the need for software management of the power
>>> switch, ensuring it transitions to the backup power source before
>>> entering low power modes.
>>>
>>> This is done in the only locaton where this swich was configured. It's
>>
>> s/locaton/location
>>
>>> usually done in the bootloader.
>>>
>>> Previously, the loss of the VDDANA (or VDDIN33) power source was not
>>> automatically compensated by an alternative power source. This resulted
>>> in the loss of Backup Unit content, including Backup Self-refresh low
>>> power mode information, OTP emulation configuration, and boot
>>> configuration, for instance.
>>
>> Should we add a fixes for this?
> 
> Not so easy to tell as there's a loose dependency with the bootloader.
> But it's true that switching to automatic never harm. So probably yes.
> 
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> ---
>>>    arch/arm/mach-at91/pm.c | 31 ++++++++++++++++++++-----------
>>>    1 file changed, 20 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>>> index b9b995f8a36e..05a1547642b6 100644
>>> --- a/arch/arm/mach-at91/pm.c
>>> +++ b/arch/arm/mach-at91/pm.c
>>> @@ -598,7 +598,21 @@ static int at91_suspend_finish(unsigned long val)
>>>         return 0;
>>>    }
>>>
>>> -static void at91_pm_switch_ba_to_vbat(void)
>>> +/**
>>> + * at91_pm_switch_ba_to_auto() - Configure Backup Unit Power Switch
>>> + * to automatic/hardware mode.
>>> + *
>>> + * The Backup Unit Power Switch can be managed either by software or hardware.
>>> + * Enabling hardware mode allows the automatic transition of power between
>>> + * VDDANA (or VDDIN33) and VDDBU (or VBAT, respectively), based on the
>>> + * availability of these power sources.
>>> + *
>>> + * If the Backup Unit Power Switch is already in automatic mode, no action is
>>> + * required. If it is in software-controlled mode, it is switched to automatic
>>> + * mode to enhance safety and eliminate the need for toggling between power
>>> + * sources.
>>> + */
>>> +static void at91_pm_switch_ba_to_auto(void)
>>>    {
>>>         unsigned int offset = offsetof(struct at91_pm_sfrbu_regs, pswbu);
>>>         unsigned int val;
>>> @@ -609,24 +623,19 @@ static void at91_pm_switch_ba_to_vbat(void)
>>>
>>>         val = readl(soc_pm.data.sfrbu + offset);
>>>
>>> -     /* Already on VBAT. */
>>> -     if (!(val & soc_pm.sfrbu_regs.pswbu.state))
>>> +     /* Already on auto/hardware. */
>>> +     if (!(val & soc_pm.sfrbu_regs.pswbu.ctrl))
>>>                 return;
>>>
>>> -     val &= ~soc_pm.sfrbu_regs.pswbu.softsw;
>>
>> It seems that softsw and state members of at91_pm_sfrbu_regs.pswbu along
>> with their initialization could be dropped. What do you think?
> 
> I think that I tried when writing the patch but I think that there's a
> little difference with sama5d2 register layout. Give me a couple more
> days to come back to this and verify.

Ok, I remember now: I was wondering if I needed to remove the whole 
sfrbu_regs.xxx mechanism and define more generically the content of 
include/soc/at91/sama7-sfrbu.h for sama5d2, but if we need one day to 
use the STATE bit or even the SMCTRL bit of sama5d2, then it should be kept.

So, now that the mechanism is in place, I would prefer that we keep it: 
okay for you?

Do you want me to re-spin a v2 for the rest?

Best regards,
   Nicolas

>> I can do it while applying, if any.
>>
>> Thank you,
>> Claudiu
>>
>>
>>> -     val |= soc_pm.sfrbu_regs.pswbu.key | soc_pm.sfrbu_regs.pswbu.ctrl;
>>> +     val &= ~soc_pm.sfrbu_regs.pswbu.ctrl;
>>> +     val |= soc_pm.sfrbu_regs.pswbu.key;
>>>         writel(val, soc_pm.data.sfrbu + offset);
>>> -
>>> -     /* Wait for update. */
>>> -     val = readl(soc_pm.data.sfrbu + offset);
>>> -     while (val & soc_pm.sfrbu_regs.pswbu.state)
>>> -             val = readl(soc_pm.data.sfrbu + offset);
>>>    }
>>>
>>>    static void at91_pm_suspend(suspend_state_t state)
>>>    {
>>>         if (soc_pm.data.mode == AT91_PM_BACKUP) {
>>> -             at91_pm_switch_ba_to_vbat();
>>> +             at91_pm_switch_ba_to_auto();
>>>
>>>                 cpu_suspend(0, at91_suspend_finish);
>>>
> 
> 


