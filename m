Return-Path: <linux-kernel+bounces-548457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B5BA5450F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9189F3A2DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF01DF24E;
	Thu,  6 Mar 2025 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RRnXXZam"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E00207675
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250329; cv=none; b=eT76qViPk3CI+x9xOYaycll6ApblEEyoezH8pPC7IhocU7rzOl53/0eqzoFjWMq86ur4TLb3r8/v8epuuHtF0xcrbHXIdxb7T6Jc3lrF5DyUJEynXnTkRTsf5VODae+uEpr/cXBISq62GshfJRRfAXc34AI91zuffN/dMiZKK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250329; c=relaxed/simple;
	bh=Mq9QBnk98lCZMXWRu+BTLCtai6PJmcayz0HR+BYAgfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bmrmt5HxLjejhBokZ9blDegiUBhWDDaDbIZvWAQigUZkMC2wB/Tq/QwgcezzHsXDNhYGA7LJYxgqX9J0DD1xlf1kwfiGnItSlLIJXHhQVps+2ku7cFegUDsAlwz6f0t6/ZQgZmxY2QIj0TkHdVdkXwce3PHSTgbqOJBhptTx+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RRnXXZam; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52675g1x027727;
	Thu, 6 Mar 2025 09:38:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	THTPti0GSVkJ4Cd75xheL2m4nwMeiJGZ76Ql1T7hNSg=; b=RRnXXZamHslG4g3e
	Uj+5ddeHAS1FF0PnwSRao4wSH4kqc1blP1txTUwJjJ1OVy5EIqkdi2gabTmdPF28
	UAbwr3nRHkwDUN2laKtxlY4xfiKlVQtDdXBavK4Sn57Hs5+DwHVzQvXq24kizUp3
	rI9XT0Em724nOCx2sDMTh9kBwcS0LzZsaP1aiJc5bS6o86AVz+JFBdmWCed+ETkW
	ADpZLcqFMXsMTW7u2l+WJyZ6ek2QHy5Q8urrPmrgxU3TFNF1HO9TXUlW4dNSsLy4
	h19IrDtz40YnMlhQ/J4lMc5tZ9zS3uPi7c/Hm2+Ets5anIUPnCmc1LswiPHZ6F5S
	7ZaMHw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 454cp8x3cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:38:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6EF8740049;
	Thu,  6 Mar 2025 09:37:38 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC809411871;
	Thu,  6 Mar 2025 09:37:16 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:37:16 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:37:16 +0100
Message-ID: <4081d99c-1283-45a4-9cb8-8e6f8dbd635d@foss.st.com>
Date: Thu, 6 Mar 2025 09:37:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: stm32-lptimer: use wakeup capable instead of
 init wakeup
To: Daniel Lezcano <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <alexandre.torgue@foss.st.com>, <olivier.moysan@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250305125146.1858978-1-fabrice.gasnier@foss.st.com>
 <a7489f16-ca31-4530-8ef1-33079b3c99a9@linaro.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <a7489f16-ca31-4530-8ef1-33079b3c99a9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01

On 3/5/25 18:23, Daniel Lezcano wrote:
> On 05/03/2025 13:51, Fabrice Gasnier wrote:
>> From: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
>> "wakeup-source" property describes a device which has wakeup capability
>> but should not force this device as a wakeup source.
> 
> Is that a fix to be carried on ?

Hi Daniel,

Thanks for reviewing,
I just have sent a V2 with Fixes tag, and have CC'ed stable.

Please review there,
Best Regards,
Fabrice

Fixes: 48b41c5e2de6 ("clocksource: Add Low Power STM32 timers driver")
> 
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>   drivers/clocksource/timer-stm32-lp.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-stm32-lp.c
>> b/drivers/clocksource/timer-stm32-lp.c
>> index 96d975adf7a4..f08baa6720f8 100644
>> --- a/drivers/clocksource/timer-stm32-lp.c
>> +++ b/drivers/clocksource/timer-stm32-lp.c
>> @@ -186,9 +186,7 @@ static int stm32_clkevent_lp_probe(struct
>> platform_device *pdev)
>>       }
>>         if (of_property_read_bool(pdev->dev.parent->of_node,
>> "wakeup-source")) {
>> -        ret = device_init_wakeup(&pdev->dev, true);
>> -        if (ret)
>> -            goto out_clk_disable;
>> +        device_set_wakeup_capable(&pdev->dev, true);
>>             ret = dev_pm_set_wake_irq(&pdev->dev, irq);
>>           if (ret)
> 
> 

