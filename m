Return-Path: <linux-kernel+bounces-563272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1398EA63C29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647CA167631
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45474155C82;
	Mon, 17 Mar 2025 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wKSsRhlD"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFE1537DA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180156; cv=none; b=E2fhfxi6gMkn1hcwmUB0qDZV3MaTme5ADqTCGm3EeTPE8mhREoOUOEMolXZPSAftb1t1kb+ijeUcUdsF9PKHg78NwpmHdKXU/KTMihJ9xFo4uagEfW4uJTXj2OiHvbA/vZDqpukNlHCPnkILwpvVAjh3iW7xCPJ8XHiKzzQkPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180156; c=relaxed/simple;
	bh=Fhaojl1WiaXXJoZzWeNs5O5NenyDYwiIBoWcSjqqsbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZO1QhkQVinC1RtkTvSK9VacKsptuG+36kmvaXMiMEQdpNRzeXc2jm9JPsz7WoEncJoElNAf58qRKOBJZVJxbstWr/IMzqv0rZCzjQ0xqVe8mK6LBi6e3YAYLDvws832xMkirfmHBRpN/ldMMKOcqEpqOLDR+UFRGwv1uxwyb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wKSsRhlD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f121fdf9-aa0d-419f-9323-bd8b0c9682f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742180151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAuClrG3jlt4lXj5XeeHjNqrTi0iDE/XijApFJxz9L8=;
	b=wKSsRhlDNbaSh4KtCTSPB3pDTVwpfn/eIscYvj3fJrzDrRqIvGmp121lSchCxrCydBImjI
	5XH9nSZ3/MC6P5XCfIaMKr8Xzf//tQvF0CQ07akd+K6cjgN/PsUrNzN92ChL5cmoIs4Gp4
	WqZDIi7BuZ0zlHUxCfqggEn4N9475gw=
Date: Mon, 17 Mar 2025 10:54:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Josh Don <joshdon@google.com>, Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall
 <bsegall@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Xi Wang <xii@google.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/16 11:25, Josh Don wrote:
> Hi Aaron,
> 
>>   static int tg_throttle_down(struct task_group *tg, void *data)
>>   {
>>          struct rq *rq = data;
>>          struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>> +       struct task_struct *p;
>> +       struct rb_node *node;
>> +
>> +       cfs_rq->throttle_count++;
>> +       if (cfs_rq->throttle_count > 1)
>> +               return 0;
>>
>>          /* group is entering throttled state, stop time */
>> -       if (!cfs_rq->throttle_count) {
>> -               cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>> -               list_del_leaf_cfs_rq(cfs_rq);
>> +       cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>> +       list_del_leaf_cfs_rq(cfs_rq);
>>
>> -               SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>> -               if (cfs_rq->nr_queued)
>> -                       cfs_rq->throttled_clock_self = rq_clock(rq);
>> +       SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>> +       if (cfs_rq->nr_queued)
>> +               cfs_rq->throttled_clock_self = rq_clock(rq);
>> +
>> +       WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
>> +       /*
>> +        * rq_lock is held, current is (obviously) executing this in kernelspace.
>> +        *
>> +        * All other tasks enqueued on this rq have their saved PC at the
>> +        * context switch, so they will go through the kernel before returning
>> +        * to userspace. Thus, there are no tasks-in-userspace to handle, just
>> +        * install the task_work on all of them.
>> +        */
>> +       node = rb_first(&cfs_rq->tasks_timeline.rb_root);
>> +       while (node) {
>> +               struct sched_entity *se = __node_2_se(node);
>> +
>> +               if (!entity_is_task(se))
>> +                       goto next;
>> +
>> +               p = task_of(se);
>> +               task_throttle_setup_work(p);
>> +next:
>> +               node = rb_next(node);
>> +       }
> 
> I'd like to strongly push back on this approach. This adds quite a lot
> of extra computation to an already expensive path
> (throttle/unthrottle). e.g. this function is part of the cgroup walk

Actually, with my suggestion in another email that we only need to mark
these cfs_rqs throttled when quote used up, and setup throttle task work
when the tasks under those cfs_rqs get picked, the cost of throttle path
is much like the dual tree approach.

As for unthrottle path, you're right, it has to iterate each task on
a list to get it queued into the cfs_rq tree, so it needs more thinking.

> and so it is already O(cgroups) for the number of cgroups in the
> hierarchy being throttled. This gets even worse when you consider that
> we repeat this separately across all the cpus that the
> bandwidth-constrained group is running on. Keep in mind that
> throttle/unthrottle is done with rq lock held and IRQ disabled.

Maybe we can avoid holding rq lock when unthrottle? As for per-task
unthrottle, it's much like just waking up lots of tasks, so maybe we
can reuse ttwu path to wakeup those tasks, which could utilise remote
IPI to avoid holding remote rq locks. I'm not sure, just some random thinking..

> 
> In K Prateek's last RFC, there was discussion of using context
> tracking; did you consider that approach any further? We could keep
> track of the number of threads within a cgroup hierarchy currently in
> kernel mode (similar to h_nr_runnable), and thus simplify down the

Yeah, I think Prateek's approach is very creative! The only downside of
it is that the code becomes much complex.. on already complex codebase.
Anyway, it would be great that or this could be merged in mainline kernel.

At last, I wonder is it possible that we can implement a cgroup-level
bandwidth control, instead of doing it in each sched_class? Then SCX
tasks could be controlled too, without implementing it in BPF code...

Thanks!

> throttling code here.
> 
> Best,
> Josh

