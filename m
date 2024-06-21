Return-Path: <linux-kernel+bounces-224184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBE2911E68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EA52832BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326716EC12;
	Fri, 21 Jun 2024 08:14:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0D16D317
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957681; cv=none; b=hPa5IZ5ty4DTuvtHWSJ4v5dHQKv/JFj6xjX3x6xilHxyJUPWP4tvY54oVTl+xVtxM9WDfJfH1JvpROYr3oQ743pt2kwfkCfRBSWwG6XElvRIzXE2ZMHfoo8kZlYCBCZ7hbTt3R7e4ouL7iQOL+6i6jRCwjrsLijIXfgT5ktOd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957681; c=relaxed/simple;
	bh=wTseDd38xUTNwwmmze1WyyHdFXM7jsf7p29T1v1AhQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sXP/lQMcOyiTnMAawgOqjzirFIr1ROa2hZqWkFs58Shfw783sq6aaWukZk1qqxa8DwVtIHC+BtBNEXkG78fYH9nNypTMxpuNnp/gM0KMOOxsfcM9LpZ6hgXocUqaJcwiLtNk4XAwc0sgnuFZK4l1iKdtBvzHV4+vHPvRbqm6htM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W598b6tbgzdcgJ;
	Fri, 21 Jun 2024 16:13:03 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 77AF21403D2;
	Fri, 21 Jun 2024 16:14:35 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 16:14:34 +0800
Message-ID: <33b6be1d-ac8f-1511-480a-0f2d609af115@huawei.com>
Date: Fri, 21 Jun 2024 16:14:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/5] arm64: irqchip/gic-v3: Select priorities at boot
 time
To: Marc Zyngier <maz@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <alexandru.elisei@arm.com>,
	<catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <will@kernel.org>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
 <20240617111841.2529370-6-mark.rutland@arm.com>
 <39b2bce8-3bc1-b1d9-3e4a-8132a92059c6@huawei.com>
 <8634p6ka7j.wl-maz@kernel.org>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <8634p6ka7j.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/6/21 15:48, Marc Zyngier 写道:
> On Fri, 21 Jun 2024 07:23:54 +0100,
> "Liao, Chang" <liaochang1@huawei.com> wrote:
>>
>>
>>
>> 在 2024/6/17 19:18, Mark Rutland 写道:
>>>  	cpus_have_group0 = gic_has_group0();
>>
>>> +#define __gicv3_prio_to_ns(p)	(0xff & ((p) << 1))
>>> +#define __gicv3_ns_to_prio(ns)	(0x80 | ((ns) >> 1))
>>
>> What about refactoring the gic_has_group0() using the mapping macros
>> between PMR priority and GIC priority like this:
>>
>> ---------------%<-----------------
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -882,6 +882,7 @@ static bool gic_has_group0(void)
>>  {
>>         u32 val;
>>         u32 old_pmr;
>> +       u32 prio = BIT(8 - gic_get_pribits());
>>
>>         old_pmr = gic_read_pmr();
>>
>> @@ -896,12 +897,12 @@ static bool gic_has_group0(void)
>>          * becomes 0x80. Reading it back returns 0, indicating that
>>          * we're don't have access to Group0.
>>          */
>> -       gic_write_pmr(BIT(8 - gic_get_pribits()));
>> +       gic_write_pmr(prio);
>>         val = gic_read_pmr();
>>
>>         gic_write_pmr(old_pmr);
>>
>> -       return val != 0;
>> +       return val != (__gicv3_prio_to_ns(__gicv3_ns_to_prio(prio)));
>>  }
>> --------------->%-----------------
> 
> No, that's terrible, and makes it simply impossible to understand what
> is happening without looking at 3 layers of indirection.
> 
> Read the comment, and realise that the code implements exactly that.

You are right, it is BIT(8-gic_get_pribits()) decides gic_read_pmr() must return zero
if SCR_EL3.FIQ is set, there is no need to overcomplicate things.

> 
> 	M.
> 

-- 
BR
Liao, Chang

