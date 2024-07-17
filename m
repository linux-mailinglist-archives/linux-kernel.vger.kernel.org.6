Return-Path: <linux-kernel+bounces-255112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6F933C38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116C01F2356A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC717F4E4;
	Wed, 17 Jul 2024 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWWSu+l5"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0017F392
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215561; cv=none; b=IR7xkMeS0e+3rldE1TEnXmnZlToNvX2Ny97LjjXmJNTKAk8VIGGOdcqaKco8RoW7o0D4fKKKBfeowfMO3PuHQ38HJbi9Uc200H2OvhjkwoCvYvyzO07mj1RfA3HemiXPuxxY3c4AiRFj5ivMq5/nCLcu1bvFweLPqZmt1QM9eZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215561; c=relaxed/simple;
	bh=Qx9j0bGSaPG3cgb0UPjJTtV98CIevGgHXf7JNVHfrBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3zHiz2EyKJpIGkzW9n61DAVJoaODdYB5GlqB/UH9/0lv08tmGIyi20bFiJnGk0axVBX9s7y0eAt022V5TvONG5mEEFLQvA2B/IZCswfAjtwtqz+uTZ27GnADbfAxLnLYmOgpx31ZTI7oX8DugM4xLZkCD3vv4kloo+aJGLdcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWWSu+l5; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vishalc@linux.ibm.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721215556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFAGOYSziSUMFB3H3/44wGT9CBV7eyOG/j0O+QCnF4c=;
	b=BWWSu+l5ykmTO8VJWW6cGN7IZRdsAM55QYbGtU1KC3FmwXZ/xR7dl6OTefVBCdjKwfYrQw
	axSo/aSj7OnNv/o0DKZWsNojVDPE9pmg/X+nZQvVN7tA7olvXJY7rlwuhj4z1o3sK/VxVT
	cg0elWPHeoVPpAkWk/sSzZP9V5TzNN8=
X-Envelope-To: zhouchuyi@bytedance.com
X-Envelope-To: mingo@redhat.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <9b0b69bf-dac0-457d-a4dc-4bea18eecc43@linux.dev>
Date: Wed, 17 Jul 2024 19:25:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
To: Vishal Chourasia <vishalc@linux.ibm.com>,
 Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20240716150634.21247-1-zhouchuyi@bytedance.com>
 <Zpel7oyBNTpkLiPS@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <Zpel7oyBNTpkLiPS@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/17 19:07, Vishal Chourasia wrote:
> On Tue, Jul 16, 2024 at 11:06:34PM +0800, Chuyi Zhou wrote:
>> cfs_rq::nr_spread_over and cfs_rq::exec_clock are not used anymore in
>> eevdf. Remove them from struct cfs_rq.
>>
> 
> nr_spread_over tracks the number of instances where the difference
> between a scheduling entity's virtual runtime and the minimum virtual
> runtime in the runqueue exceeds three times the scheduler latency,
> indicating significant disparity in task scheduling.
> Commit that removed its usage: 5e963f2bd: sched/fair: Commit to EEVDF
> 
> 
> cfs_rq->exec_clock was used to account for time spent executing tasks.
> Commit that removed its usage: 5d69eca542ee1 sched: Unify runtime
> accounting across classes
> 
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> 
> Acked-by: Vishal Chourasia <vishalc@linux.ibm.com>

Looks good to me! Maybe it's better to add these to your changelog.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

>> ---
>>   kernel/sched/debug.c | 4 ----
>>   kernel/sched/sched.h | 6 ------
>>   2 files changed, 10 deletions(-)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index c1eb9a1afd13..90c4a9998377 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -641,8 +641,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>>   	SEQ_printf(m, "\n");
>>   	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
>>   #endif
>> -	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
>> -			SPLIT_NS(cfs_rq->exec_clock));
>>   
>>   	raw_spin_rq_lock_irqsave(rq, flags);
>>   	root = __pick_root_entity(cfs_rq);
>> @@ -669,8 +667,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>>   			SPLIT_NS(right_vruntime));
>>   	spread = right_vruntime - left_vruntime;
>>   	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
>> -	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
>> -			cfs_rq->nr_spread_over);
>>   	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
>>   	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
>>   	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 4c36cc680361..8a071022bdec 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -599,7 +599,6 @@ struct cfs_rq {
>>   	s64			avg_vruntime;
>>   	u64			avg_load;
>>   
>> -	u64			exec_clock;
>>   	u64			min_vruntime;
>>   #ifdef CONFIG_SCHED_CORE
>>   	unsigned int		forceidle_seq;
>> @@ -619,10 +618,6 @@ struct cfs_rq {
>>   	struct sched_entity	*curr;
>>   	struct sched_entity	*next;
>>   
>> -#ifdef	CONFIG_SCHED_DEBUG
>> -	unsigned int		nr_spread_over;
>> -#endif
>> -
>>   #ifdef CONFIG_SMP
>>   	/*
>>   	 * CFS load tracking
>> @@ -1158,7 +1153,6 @@ struct rq {
>>   	/* latency stats */
>>   	struct sched_info	rq_sched_info;
>>   	unsigned long long	rq_cpu_time;
>> -	/* could above be rq->cfs_rq.exec_clock + rq->rt_rq.rt_runtime ? */
>>   
>>   	/* sys_sched_yield() stats */
>>   	unsigned int		yld_count;
>> -- 
>> 2.20.1
>>

