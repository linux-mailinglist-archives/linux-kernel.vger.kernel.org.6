Return-Path: <linux-kernel+bounces-310486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29964967DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5841F2249C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBA2C182;
	Mon,  2 Sep 2024 01:58:29 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9022331
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242309; cv=none; b=RdCiR7+mcUhYsTZmX7BtpoF6gnGHpU1hjUltMxIcBpSSTVKAHMhDfQ7ItTRmRL+b7FgTxLkAOf+XMFPC55OQMQxGLn/oZfn0NOsdZZMJ+3uoRh3PTLDvpNGGOowqYYZu2ru7VPVMv0G7zRGQLl3ifhHqXpT95aP6d8cuMZUvnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242309; c=relaxed/simple;
	bh=E0bTQB+xHofberqzJzN/FXrNFANvbZZQEQZiJAcykoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pCme7qlm0HVPHO7bk4UTBfgOZWkb0TmKCpaV7/1Gn/S36K5j8dy/On7g0Tv/pt5o9FO9hxrZxaAcCFIFJtSE4iCLH6LyUeBBHbo+G839+O3BNjiaW7P+s+xSxLe6g4xP1TMS+/EQbOkLk9VP+3aTUXNZkcxYFxmmB65wkUJ/zLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WxsGq0ydpz69Qp;
	Mon,  2 Sep 2024 09:53:23 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A2F914022D;
	Mon,  2 Sep 2024 09:58:18 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 09:58:17 +0800
Message-ID: <fa150839-43d3-ed28-b1ae-7eaa15a1200d@huawei.com>
Date: Mon, 2 Sep 2024 09:58:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] genirq/timings: Use min_t() to simplify the code
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240831093654.4139823-1-ruanjinjie@huawei.com>
 <b7cc4af3df4c41b3975ac990532e4ba0@AcuMS.aculab.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <b7cc4af3df4c41b3975ac990532e4ba0@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/2 4:53, David Laight wrote:
> From: Jinjie Ruan
>> Sent: 31 August 2024 10:37
>>
>> The irq count can not exceed circular buffer IRQ_TIMINGS_SIZE, use
>> min_t() to simplify it.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  kernel/irq/timings.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
>> index c43e2ac2f8de..69f103b4c7a6 100644
>> --- a/kernel/irq/timings.c
>> +++ b/kernel/irq/timings.c
>> @@ -406,8 +406,7 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
>>  	/*
>>  	 * 'count' will depends if the circular buffer wrapped or not
>>  	 */
>> -	count = irqs->count < IRQ_TIMINGS_SIZE ?
>> -		irqs->count : IRQ_TIMINGS_SIZE;
>> +	count = min_t(int, irqs->count, IRQ_TIMINGS_SIZE);
> 
> Why min_t() ?
> 
> 	David

To align with the latter min_t() in __irq_timings_next_event().

> 
>>
>>  	start = irqs->count < IRQ_TIMINGS_SIZE ?
>>  		0 : (irqs->count & IRQ_TIMINGS_MASK);
>> --
>> 2.34.1
>>
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

