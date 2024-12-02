Return-Path: <linux-kernel+bounces-428027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DCC9E0922
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A392E1615E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EDB1D6DC8;
	Mon,  2 Dec 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JK6AjuaF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08E1D31B2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157870; cv=none; b=KLpKCxlrcD50I4Ep/xxHJNPcV0GpG0iNXMFnaFwwMGwXv5X1MCbjLwEOq0E3D1yJHLZ0HwUn/cTrSX7EAdMwx9M1Fcm/P7monUO+8FMi8YTSjanOnbb+zzi06um1JOIOPotlj/cu46UP+NCC0ED4EPmYG6I8nFh90HKaN5wmWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157870; c=relaxed/simple;
	bh=Kov19Kcf5hBRpnDlYC0mQmJZQDHLQKXhh4VXSpk7UlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HSA9HYTrwu1vgHtziBLpfedLzdtKYSTCvnRDwRj4nCHRclUMVm3HC6vzKCFNb6jzOnom0dEKheIU/tdROhFissoxeDxY6KNdFxN7w5fYOugoyGZ0aRMyx4spcUVak9TyjDcphYbTsCS7LcRPoEQCwhk0c/uhwgIGkgP0W2FDxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JK6AjuaF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733157868; x=1764693868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kov19Kcf5hBRpnDlYC0mQmJZQDHLQKXhh4VXSpk7UlE=;
  b=JK6AjuaFiTdBAdnYY2YCobIyTL+c5f2TZM30KC/xUPW2Tht349g/+34e
   RifGUvi1SrHgBpXqytHR7dVcjp6ISj+DdNcGtRNXI8RUZupO10eMB0BOX
   lG7exe4XZQKQNar1UsMIjRFeZ/14hJDs6QRrKaVjrVge53X4Y67aC3EXG
   92480KuM2wxmGsIXMcUGVtw+R3lCnh5If6E01/XPt86aZFhAla4Q6Lc5V
   3ZI2u1G1YZaoJXP0kx+MsMYOqOC2hB4+hIo/bUXKNPX+MM92HaUR8hdWK
   BnAaQ9kqZWGmQOp6uD8dCCDjwA8qpkwsSzFo49jLpdy4WTT13m9+E9Sqt
   g==;
X-CSE-ConnectionGUID: VXJLcTK3S827uIOuKWwAmg==
X-CSE-MsgGUID: 3CVsFPfDSQ2L2zwHmwYC3g==
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="202476758"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2024 09:44:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Dec 2024 09:44:22 -0700
Received: from [10.171.248.21] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Dec 2024 09:44:21 -0700
Message-ID: <24069031-9ed4-4592-af98-ff53222caf03@microchip.com>
Date: Mon, 2 Dec 2024 17:44:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: change BU Power Switch to automatic mode
Content-Language: en-US, fr-FR
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Cristian Birsan <cristian.birsan@microchip.com>
References: <20241125165648.509162-1-nicolas.ferre@microchip.com>
 <34a5b77b-e732-4393-a469-d9c719afa879@tuxon.dev>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <34a5b77b-e732-4393-a469-d9c719afa879@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 at 09:05, Claudiu Beznea wrote:
> Hi, Nicolas,
> 
> On 25.11.2024 18:56, nicolas.ferre@microchip.com wrote:
>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>> Change how the Backup Unit Power is configured and force the
>> automatic/hardware mode.
>> This change eliminates the need for software management of the power
>> switch, ensuring it transitions to the backup power source before
>> entering low power modes.
>>
>> This is done in the only locaton where this swich was configured. It's
> 
> s/locaton/location
> 
>> usually done in the bootloader.
>>
>> Previously, the loss of the VDDANA (or VDDIN33) power source was not
>> automatically compensated by an alternative power source. This resulted
>> in the loss of Backup Unit content, including Backup Self-refresh low
>> power mode information, OTP emulation configuration, and boot
>> configuration, for instance.
> 
> Should we add a fixes for this?

Not so easy to tell as there's a loose dependency with the bootloader. 
But it's true that switching to automatic never harm. So probably yes.

>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> ---
>>   arch/arm/mach-at91/pm.c | 31 ++++++++++++++++++++-----------
>>   1 file changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>> index b9b995f8a36e..05a1547642b6 100644
>> --- a/arch/arm/mach-at91/pm.c
>> +++ b/arch/arm/mach-at91/pm.c
>> @@ -598,7 +598,21 @@ static int at91_suspend_finish(unsigned long val)
>>        return 0;
>>   }
>>
>> -static void at91_pm_switch_ba_to_vbat(void)
>> +/**
>> + * at91_pm_switch_ba_to_auto() - Configure Backup Unit Power Switch
>> + * to automatic/hardware mode.
>> + *
>> + * The Backup Unit Power Switch can be managed either by software or hardware.
>> + * Enabling hardware mode allows the automatic transition of power between
>> + * VDDANA (or VDDIN33) and VDDBU (or VBAT, respectively), based on the
>> + * availability of these power sources.
>> + *
>> + * If the Backup Unit Power Switch is already in automatic mode, no action is
>> + * required. If it is in software-controlled mode, it is switched to automatic
>> + * mode to enhance safety and eliminate the need for toggling between power
>> + * sources.
>> + */
>> +static void at91_pm_switch_ba_to_auto(void)
>>   {
>>        unsigned int offset = offsetof(struct at91_pm_sfrbu_regs, pswbu);
>>        unsigned int val;
>> @@ -609,24 +623,19 @@ static void at91_pm_switch_ba_to_vbat(void)
>>
>>        val = readl(soc_pm.data.sfrbu + offset);
>>
>> -     /* Already on VBAT. */
>> -     if (!(val & soc_pm.sfrbu_regs.pswbu.state))
>> +     /* Already on auto/hardware. */
>> +     if (!(val & soc_pm.sfrbu_regs.pswbu.ctrl))
>>                return;
>>
>> -     val &= ~soc_pm.sfrbu_regs.pswbu.softsw;
> 
> It seems that softsw and state members of at91_pm_sfrbu_regs.pswbu along
> with their initialization could be dropped. What do you think?

I think that I tried when writing the patch but I think that there's a 
little difference with sama5d2 register layout. Give me a couple more 
days to come back to this and verify.

> I can do it while applying, if any.
> 
> Thank you,
> Claudiu
> 
> 
>> -     val |= soc_pm.sfrbu_regs.pswbu.key | soc_pm.sfrbu_regs.pswbu.ctrl;
>> +     val &= ~soc_pm.sfrbu_regs.pswbu.ctrl;
>> +     val |= soc_pm.sfrbu_regs.pswbu.key;
>>        writel(val, soc_pm.data.sfrbu + offset);
>> -
>> -     /* Wait for update. */
>> -     val = readl(soc_pm.data.sfrbu + offset);
>> -     while (val & soc_pm.sfrbu_regs.pswbu.state)
>> -             val = readl(soc_pm.data.sfrbu + offset);
>>   }
>>
>>   static void at91_pm_suspend(suspend_state_t state)
>>   {
>>        if (soc_pm.data.mode == AT91_PM_BACKUP) {
>> -             at91_pm_switch_ba_to_vbat();
>> +             at91_pm_switch_ba_to_auto();
>>
>>                cpu_suspend(0, at91_suspend_finish);
>>


