Return-Path: <linux-kernel+bounces-262360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638893C550
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5793B22628
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAA19AD91;
	Thu, 25 Jul 2024 14:49:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532948468
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918995; cv=none; b=KnLz2fwQBhv3WnFcUR02QAO20HH02Jt5IupZ/GQZyrMrMO4511wzhJHu3x74auLwHxn3uqEPFN4PGllPwfnY0uCTNVHgWp3Ad/wtP9F0mMVZdZH19dhUBpZ/JqAKBMfGCAefsQkt6/4aIDs2WkfcGytX+x6Y9N4nA80R9Wsw6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918995; c=relaxed/simple;
	bh=2LJCpYrAfUWYSbVJT8eYm5ee0BLYMU8okFLRcM5mq6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m0G4kg1A/5f7biLtm2MMytqya2euWHQEatTZtLEIfYBz65/29SNsSEP9q4dIXOak8Ke418KEx011boHdpvhRxj50skGEEGYE2Iqd4V6HW0bkfnQZNU/EhhuJgRQt563XkIaot7yIOyjH45SAmBy5Mfz92o8LVu3f0qb+7Mf4Bxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WVDFZ00DRz28fpS;
	Thu, 25 Jul 2024 22:45:21 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id 407D61A0188;
	Thu, 25 Jul 2024 22:49:48 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Jul
 2024 22:49:47 +0800
Message-ID: <b21d9fa7-45be-8346-db28-4c42847e2e0b@huawei.com>
Date: Thu, 25 Jul 2024 22:49:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] sched/cputime: Fix mul_u64_u64_div_u64() precision
 for cputime
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<oleg@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <20240725140508.GH13387@noisy.programming.kicks-ass.net>
From: zhengzucheng <zhengzucheng@huawei.com>
In-Reply-To: <20240725140508.GH13387@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500019.china.huawei.com (7.221.188.86)

Sorry, I made a mistake here. CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set.

在 2024/7/25 22:05, Peter Zijlstra 写道:
> On Thu, Jul 25, 2024 at 12:03:15PM +0000, Zheng Zucheng wrote:
>> In extreme test scenarios:
>> the 14th field utime in /proc/xx/stat is greater than sum_exec_runtime,
>> utime = 18446744073709518790 ns, rtime = 135989749728000 ns
>>
>> In cputime_adjust() process, stime is greater than rtime due to
>> mul_u64_u64_div_u64() precision problem.
>> before call mul_u64_u64_div_u64(),
>> stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
>> after call mul_u64_u64_div_u64(),
>> stime = 135989949653530
>>
>> unsigned reversion occurs because rtime is less than stime.
>> utime = rtime - stime = 135989749728000 - 135989949653530
>> 		      = -199925530
>> 		      = (u64)18446744073709518790
>>
>> Trigger scenario:
>> 1. User task run in kernel mode most of time.
>> 2. The ARM64 architecture && CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y &&
>>     TICK_CPU_ACCOUNTING=y
>>
>> Fix mul_u64_u64_div_u64() conversion precision by reset stime to rtime
>>
>> Fixes: 3dc167ba5729 ("sched/cputime: Improve cputime_adjust()")
>> Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
>> ---
>>   kernel/sched/cputime.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
>> index aa48b2ec879d..365c74e95537 100644
>> --- a/kernel/sched/cputime.c
>> +++ b/kernel/sched/cputime.c
>> @@ -582,6 +582,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>>   	}
>>   
>>   	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
>> +	if (unlikely(stime > rtime))
>> +		stime = rtime;
> But but but... for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y the code you're
> patching is not compiled!
>
>
> .

