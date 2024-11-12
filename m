Return-Path: <linux-kernel+bounces-406044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7111B9C5A60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E196A1F226B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E31FCC42;
	Tue, 12 Nov 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cA+CuVxs"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD71531CB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421732; cv=none; b=JMf4YwNZSQ0/7h/o7ZjxQO65vv46fmA7fRaMS17ejYSNDElhx34mPu0f5vnAp3sgxlqWaKKnwgtJQwJWKtVAhsRb/ABazPKXpx4CXMlIl/557Lpw2Xg2scIP73QoxaGw+TMjwoi6eh1L1QiwF118LldJFjwLZDWGhZvBppN4RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421732; c=relaxed/simple;
	bh=Zr8bm1lBd4bS/nrCZQbbvCHkK7jy5ohjF5f67FDOS0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9gMSCeCqjMy+0xYWh/CeWRmiDabonC6mYzhZw4PqQdDgFIw5uv+JhqtrGTUnGwhtcs27LnyEJtH78ztYvpfVI8SS4l8F3iftEA4QgNZ3AbBa+T4wmk8ACAj2KV13HZk2AAl7sUE7n9+4JNAR5h8s1nKLjZs1f62skMDmJzM+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cA+CuVxs; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1731421727;
	bh=Zr8bm1lBd4bS/nrCZQbbvCHkK7jy5ohjF5f67FDOS0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cA+CuVxsj33iOaHGXWQt8VeBpUtXVNwx7jlrNOXOMQXZZxYzNS6MNZgQYs+7Tur9o
	 e24mXQxaqiVV3kx2xlb+Htx9ofQT380VGvIYEIJyo9frJ1UUoUYuj69Ad7UCBYwfe4
	 blyXtKTBJ6cbmOTcov2AGH2EEUUODLjAEXx15fwjLsIjbRA4/09KlSlPxagcz73i+W
	 z02D34YzBwb/zR8ynXpk32jWDf0Y8/bqOCfKnFVew6Wm5qD3Zn90NiSbj9kRDRrGLD
	 gV26zrjV+MQG4fqrxPKPYjePUkFP7rGGzkxpwN5T4tgo4wF6eAtW53t76XcNE296wu
	 TA5A1nl1JgcLg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xnpgg2spfz183w;
	Tue, 12 Nov 2024 09:28:47 -0500 (EST)
Message-ID: <f76b79c0-070a-44d6-ac8b-71d063f2357a@efficios.com>
Date: Tue, 12 Nov 2024 09:27:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rseq: Validate read-only fields under DEBUG_RSEQ
 config
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Oskolkov <posk@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
 Florian Weimer <fweimer@redhat.com>, Carlos O'Donell <carlos@redhat.com>,
 DJ Delorie <dj@redhat.com>, libc-alpha@sourceware.org
References: <20241111192214.1988000-1-mathieu.desnoyers@efficios.com>
 <20241112100419.GN22801@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241112100419.GN22801@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-12 05:04, Peter Zijlstra wrote:
> On Mon, Nov 11, 2024 at 02:22:14PM -0500, Mathieu Desnoyers wrote:
> 
> So I'm entirely agreeing with the intent, but perhaps we can argue a
> little on the implementation :-)

Of course, thanks for providing feedback!

> 
>> +#ifdef CONFIG_DEBUG_RSEQ
>> +static struct rseq *rseq_kernel_fields(struct task_struct *t)
>> +{
>> +	return (struct rseq *) t->rseq_fields;
>> +}
>> +
>> +static int rseq_validate_ro_fields(struct task_struct *t)
>> +{
>> +	u32 cpu_id_start, cpu_id, node_id, mm_cid;
>> +	struct rseq __user *rseq = t->rseq;
>> +
>> +	/*
>> +	 * Validate fields which are required to be read-only by
>> +	 * user-space.
>> +	 */
>> +	if (!user_read_access_begin(rseq, t->rseq_len))
>> +		goto efault;
>> +	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
>> +	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
>> +	unsafe_get_user(node_id, &rseq->node_id, efault_end);
>> +	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
>> +	user_read_access_end();
>> +
>> +	if (cpu_id_start != rseq_kernel_fields(t)->cpu_id_start)
>> +		printk_ratelimited(KERN_WARNING
>> +			"Detected rseq cpu_id_start field corruption. Value: %u, expecting: %u (pid=%d).\n",
>> +			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start, t->pid);
>> +	if (cpu_id != rseq_kernel_fields(t)->cpu_id)
>> +		printk_ratelimited(KERN_WARNING
>> +			"Detected rseq cpu_id field corruption. Value: %u, expecting: %u (pid=%d).\n",
>> +			cpu_id, rseq_kernel_fields(t)->cpu_id, t->pid);
>> +	if (node_id != rseq_kernel_fields(t)->node_id)
>> +		printk_ratelimited(KERN_WARNING
>> +			"Detected rseq node_id field corruption. Value: %u, expecting: %u (pid=%d).\n",
>> +			node_id, rseq_kernel_fields(t)->node_id, t->pid);
>> +	if (mm_cid != rseq_kernel_fields(t)->mm_cid)
>> +		printk_ratelimited(KERN_WARNING
>> +			"Detected rseq mm_cid field corruption. Value: %u, expecting: %u (pid=%d).\n",
>> +			mm_cid, rseq_kernel_fields(t)->mm_cid, t->pid);
> 
> So aside from this just being ugly, this also has the problem of getting
> the ratelimits out of sync and perhaps only showing partial corruption
> for any one task.
> 
> Completely untested hackery below.

Your approach looks indeed better than mine, I'll steal it with your
permission. :)

> 
>> @@ -423,6 +504,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>>   	current->rseq = rseq;
>>   	current->rseq_len = rseq_len;
>>   	current->rseq_sig = sig;
>> +#ifdef CONFIG_DEBUG_RSEQ
>> +	/*
>> +	 * Initialize the in-kernel rseq fields copy for validation of
>> +	 * read-only fields.
>> +	 */
>> +	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
>> +	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
>> +	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
>> +	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
>> +		return -EFAULT;
>> +#endif
> 
> So I didn't change the above, but wouldn't it make more sense to do
> rseq_reset_rseq_cpu_node_id() here, but without the validation?

Indeed we could do this (for both DEBUG_RSEQ={y,n}), but it would add extra
useless stores to those userspace fields on rseq registration, which is
performed on every thread creation starting from glibc 2.35. The
rseq_set_notify_resume() invoked at the end of registration ensures that
those fields get populated before return to userspace.

So I am not against a more robust approach, but I'm reluctant to add redundant
work on thread creation.

> 
> ---
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1364,6 +1364,15 @@ struct task_struct {
>   	 * with respect to preemption.
>   	 */
>   	unsigned long rseq_event_mask;
> +# ifdef CONFIG_DEBUG_RSEQ
> +	/*
> +	 * This is a place holder to save a copy of the rseq fields for
> +	 * validation of read-only fields. The struct rseq has a
> +	 * variable-length array at the end, so it cannot be used
> +	 * directly. Reserve a size large enough for the known fields.
> +	 */
> +	char 				rseq_fields[sizeof(struct rseq)];
> +# endif
>   #endif
>   
>   #ifdef CONFIG_SCHED_MM_CID
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c

We should #include <linux/ratelimit.h> then.

> @@ -25,6 +25,79 @@
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>   
> +#ifdef CONFIG_DEBUG_RSEQ
> +static struct rseq *rseq_kernel_fields(struct task_struct *t)
> +{
> +	return (struct rseq *) t->rseq_fields;
> +}
> +
> +static int rseq_validate_ro_fields(struct task_struct *t)
> +{
> +	static DEFINE_RATELIMIT_STATE(_rs,
> +				      DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
> +	u32 cpu_id_start, cpu_id, node_id, mm_cid;
> +	struct rseq __user *rseq = t->rseq;
> +
> +	/*
> +	 * Validate fields which are required to be read-only by
> +	 * user-space.
> +	 */
> +	if (!user_read_access_begin(rseq, t->rseq_len))
> +		goto efault;
> +	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
> +	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
> +	unsafe_get_user(node_id, &rseq->node_id, efault_end);
> +	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
> +	user_read_access_end();
> +
> +	if ((cpu_id_start != rseq_kernel_fields(t)->cpu_id_start ||
> +	     cpu_id != rseq_kernel_fields(t)->cpu_id ||
> +	     node_id != rseq_kernel_fields(t)->node_id ||
> +	     mm_cid != rseq_kernel_fields(t)->mm_cid) && __ratelimit(&_rs)) {
> +
> +		pr_warn("Detected rseq corruption for pid: %d;\n"
> +			"  cpu_id_start: %u ?= %u\n"
> +			"  cpu_id:       %u ?= %u\n"
> +			"  node_id:      %u ?= %u\n"
> +			"  mm_cid:       %u ?= %u\n"
> +			t->pid,
> +			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start,
> +			cpu_id, rseq_kernel_fields(t)->cpu_id,
> +			node_id, rseq_kernel_fields(t)->node_id,
> +			mm_cid, rseq_kernel_fields(t)->mm_cid);
> +	}

It looks better, thanks.

> +
> +	/* For now, only print a console warning on mismatch. */
> +	return 0;
> +
> +efault_end:
> +	user_read_access_end();
> +efault:
> +	return -EFAULT;
> +}
> +
> +static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
> +			       u32 node_id, u32 mm_cid)
> +{
> +	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
> +	rseq_kernel_fields(t)->cpu_id = cpu_id;
> +	rseq_kernel_fields(t)->node_id = node_id;
> +	rseq_kernel_fields(t)->mm_cid = mm_cid;
> +}

This too.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


