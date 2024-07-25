Return-Path: <linux-kernel+bounces-262303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0093C3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5878A1C20B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB319D069;
	Thu, 25 Jul 2024 14:16:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF95199393
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916975; cv=none; b=UgQ3gMSL8TOhGRoj0OdNUR9TL0Ex5mPsN0ko170wiqE/++kaYguFsYdpTwuyBSNHmzJ0BB2UHLFECabWvFyoB0EvOZEFb9XZC7WxFXMnrdREUp2/bnvpbQWwVyNnTnsQEH/7HBY4yxxoXvMhO/DtnLiQl1gjWVr4jy1eO23NX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916975; c=relaxed/simple;
	bh=S+EQWPwjOkFr4P9kxBtEDbKWkvgPv2a8SXxnjPA6keM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MCMWiAeEZxG83LK7YSofw5Wf0ATLNyU/pbTVzbl8bNmqGEx5FvBqjGn7ovbWd3U6TsVASguZPwLpTraLEL2ir8qaEcHAVh7HX/i8Xw9xvGgeF2y7miZQmT6N5N3N7qLbPd9u3TeU3Ks5obF4y8SxOnhZIE57MfiJJeiARd8zIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WVCbl1s6NzxTxg;
	Thu, 25 Jul 2024 22:16:03 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 21D5518009D;
	Thu, 25 Jul 2024 22:16:07 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 25 Jul 2024 22:16:06 +0800
Message-ID: <0007bb35-9008-43cc-8f9e-089ff046780d@huawei.com>
Date: Thu, 25 Jul 2024 22:16:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] sched/fair: inline cpu_util_without and cpu_util to
 improve performance
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <zhangqiao22@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240723073607.568819-1-lizetao1@huawei.com>
 <20240724105338.GA13387@noisy.programming.kicks-ass.net>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20240724105338.GA13387@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100002.china.huawei.com (7.185.36.130) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/7/24 18:53, Peter Zijlstra 写道:
> On Tue, Jul 23, 2024 at 03:36:07PM +0800, Li Zetao wrote:
>> The commit 3eb6d6ececca ("sched/fair: Refactor CPU utilization functions")
>> refactored cpu_util_without and cpu_util functions. Since the size of
>> cpu_util function has increased, the inline cpu_util is dropped. This had
>> a negative impact on performance, in the scenario of updating
>> sched_group's statistics, cpu_util_without and cpu_util functions are on
>> the hotspot path.
>>
>> Inlining cpu_util_without and cpu_util functions have been shown to
>> significantly improve performance in lmbench as follow:
>>
>>    Machine: Intel(R) Xeon(R) Gold 6248 CPU @ 2.50GHz
>>                       before          after          diff
>>    fork+exit          317.0625        303.6667       -4.22%
>>    fork+execve        1482.5000       1407.0000      -5.09%
>>    fork+/bin/sh       2096.0000       2020.3333      -3.61%
> 
> That's quite significant. Did you look at what exactly was causing this?

In the fork scene, in order to select a CPU for new task, there is the 
following hotspot path:

   sched_balance_find_dst_cpu() ->
     sched_balance_find_dst_group() ->
       update_sg_wakeup_stats() -> cpu_util_without() -> cpu_util()

When the system has a large number of CPUs, in order to calculate the 
util of sched_group, the cpu_util() will be called many times.
> 
>> This patch introduces inlining to cpu_util_without and cpu_util functions.
>> While this increases the size of kernel/sched/fair.o, the performance
>> gains in critical workloads make this an acceptable trade-off.
>>
>> Size comparison before and after patch:
>>       text	   data	    bss	    dec	    hex	filename
>>     0x1264a	 0x1506	   0xb0	  80896	  13c00	kernel/sched/fair.o.before
>>     0x12672	 0x14fe	   0xb0	  80928	  13c20	kernel/sched/fair.o.after
>>
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> 
> This SoB chain is not valid. Please review the documentation we have
> on this.

I will fix this in v2 version.

> 
>> ---
>>   kernel/sched/fair.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 5904405ffc59..677b78fa65b6 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7706,7 +7706,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>    *
>>    * Return: (Boosted) (estimated) utilization for the specified CPU.
>>    */
>> -static unsigned long
>> +static __always_inline unsigned long
>>   cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>>   {
>>   	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
>> @@ -7794,7 +7794,7 @@ unsigned long cpu_util_cfs_boost(int cpu)
>>    * utilization of the specified task, whenever the task is currently
>>    * contributing to the CPU utilization.
>>    */
>> -static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>> +static __always_inline unsigned long cpu_util_without(int cpu, struct task_struct *p)
>>   {
>>   	/* Task has no contribution or is new */
>>   	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
>> -- 
>> 2.34.1
>>
> 

Li Zetao
Best regard

