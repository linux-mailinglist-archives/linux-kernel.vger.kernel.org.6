Return-Path: <linux-kernel+bounces-361612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE699AA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C72DB22C89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4408B1BE238;
	Fri, 11 Oct 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OXdc+u4Y"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27CF1BCA0A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668360; cv=none; b=t3rf06bX2NfLVIZRGB5mPW8MzSk13IY2YnCMDegDG9I+lOR6xy3jKjwrI2qktS53TuTfUtDFZ+AzKt7v0O4ypP3HCLPSRBmJt1Ylkehx/xFPy61banRfkQkzrf1YMGraLtoK6L/DsV5f8xSBQKhCDqI4avW7I2OXAAFJod5R7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668360; c=relaxed/simple;
	bh=KHm/nsY80/Vh21ydaMBMw714jjspZ31KIRpIn19/cWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XZDkUO7mwahkZRJXwSJ81VbbOdUe5ud5r+t4VHV22JWKiYz8xrmmIr+FPbGbntY0JiVlLSD/vilnow+WBleYf2gmmVdMzWnm9GKeuujochraCD28Mj6clv1QIJrwGn6j4MU5qx+DJBqFhf+ATa9uN9PEnnk8lSfogEVRVROHlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OXdc+u4Y; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BHd6xN120928;
	Fri, 11 Oct 2024 12:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728668346;
	bh=oKW7NLmtZlk0P3yXpYqDnM/aL4seXh7nBaFN5xj2IHo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OXdc+u4YMaBZthECEbPn9iBy99003SjKxb+CN/u4v/cpYWAcKha87gz3ofHYrQe5F
	 LyUjN6rBNFoyAhIjmw9fVUfrHnFacZ5THqX08ynnCnMjsC+QYhqvHysyWf8O6CaqRM
	 GFVwnEzmnWUMw5k29vTzKQAQJr5SaMinOfifoxw0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BHd6fN117053;
	Fri, 11 Oct 2024 12:39:06 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 12:39:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 12:39:06 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BHd6gS062407;
	Fri, 11 Oct 2024 12:39:06 -0500
Message-ID: <71eab373-00cc-49ca-878c-d43182c918e4@ti.com>
Date: Fri, 11 Oct 2024 12:39:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] clocksource/drivers/timer-ti-dm: Don't fail probe
 if int not found
To: Bryan Brattlof <bb@ti.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20241010144440.24654-1-jm@ti.com>
 <20241010211807.ibxatajiwyqchid4@bryanbrattlof.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20241010211807.ibxatajiwyqchid4@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Bryan,

On 10/10/24 4:18 PM, Bryan Brattlof wrote:
> On October 10, 2024 thus sayeth Judith Mendez:
>> Some timers may not have an interrupt routed to
>> the A53 GIC, but the timer PWM functionality can still
>> be used by Linux Kernel. Therefore, do not fail probe
>> if interrupt is not found and ti,timer-pwm exists.
>>
>> Fixes: df28472a1b28 ("ARM: OMAP: dmtimer: platform driver")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changes since v1:
>> - Rebased, add to CC list, add fixes tag
>> ---
>>   drivers/clocksource/timer-ti-dm.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
>> index b7a34b1a975e..1b61fefed213 100644
>> --- a/drivers/clocksource/timer-ti-dm.c
>> +++ b/drivers/clocksource/timer-ti-dm.c
>> @@ -1104,8 +1104,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>>   		return  -ENOMEM;
>>   
>>   	timer->irq = platform_get_irq(pdev, 0);
>> -	if (timer->irq < 0)
>> -		return timer->irq;
>> +	if (timer->irq < 0) {
>> +		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))
>> +			dev_err(dev, "Did not find timer interrupt, timer usable in PWM mode only\n");
> 
> Is this really an error? or more of a dev_info() type problem. It looks
> like we changed how we integrated the timer in K3 chips that broke some
> assumptions made in OMAP.

I can switch to dev_info() no problem, thanks for reviewing!

~ Judith

> 
> ~Bryan


