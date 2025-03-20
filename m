Return-Path: <linux-kernel+bounces-569333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59291A6A190
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B7E886416
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C05211710;
	Thu, 20 Mar 2025 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HEPCzMaA"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407A20B7F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459963; cv=none; b=LEcA2PtgN9LanIzyOj8vw5I1Fyy1fpVbcviAvv7ZOJMvRtetZg9K3ryPa1afSI66W7rrQdaPKOqDeUFIGED6XwDuSnRAkmIQf4Wn+Bs2hg2uF2KEEHHNU6jifqtzDofIPiy/h3ZWRQUy3a3cGmo4ZlRcvMNwVP87ZlccqBRiNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459963; c=relaxed/simple;
	bh=mHcV9tiSFKZ0rBaWrmy+ARjA1O0XCKNTPK2PXbjyJlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JByFDIkpWxwB9FFJJygJhX362pcNgbuUKjCItvk90RpMD/L8f5rh5nlbG1FIMAVaOen1muxXv7L/NueXoRKvmhxc1kzXAaFA2GwWZe82ZjY6dldKTUtaxzPzWrj9MgFXMNhsP1WwreCW/+E6y04IoWzn5wxYV9RYHEoJSFWYCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HEPCzMaA; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7d9fbee5-2a06-41ed-9ee3-93ef3c077eff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742459956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2a/9hWlZuP1WJ68PGB+JemZ6tOItj+RUiHw68x+PiY=;
	b=HEPCzMaA0V7VtUXcJGZoe2J82MCsEl5sb14vXq/5KxoC1QEfrVvE+NUJoac8usMIyiiv11
	Bvv+68pTWENOrXz9xhJ1wL/LT1tqgJ070Rz1YL61hGXzHLv9l2DN4MmDnvpesaaa3YOna5
	n8dZBsahsvzAWAWwASJJhC8eT0e37vc=
Date: Thu, 20 Mar 2025 16:39:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: K Prateek Nayak <kprateek.nayak@amd.com>, Josh Don <joshdon@google.com>,
 Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall
 <bsegall@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Xi Wang <xii@google.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
 <f121fdf9-aa0d-419f-9323-bd8b0c9682f3@linux.dev>
 <66a69f8e-6f0c-48d0-b8d6-6438092f9377@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <66a69f8e-6f0c-48d0-b8d6-6438092f9377@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hello Prateek,

On 2025/3/20 14:59, K Prateek Nayak wrote:
> Hello Chengming,
> 
> On 3/17/2025 8:24 AM, Chengming Zhou wrote:
>> On 2025/3/16 11:25, Josh Don wrote:
>>> Hi Aaron,
>>>
>>>>   static int tg_throttle_down(struct task_group *tg, void *data)
>>>>   {
>>>>          struct rq *rq = data;
>>>>          struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>>>> +       struct task_struct *p;
>>>> +       struct rb_node *node;
>>>> +
>>>> +       cfs_rq->throttle_count++;
>>>> +       if (cfs_rq->throttle_count > 1)
>>>> +               return 0;
>>>>
>>>>          /* group is entering throttled state, stop time */
>>>> -       if (!cfs_rq->throttle_count) {
>>>> -               cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>>>> -               list_del_leaf_cfs_rq(cfs_rq);
>>>> +       cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>>>> +       list_del_leaf_cfs_rq(cfs_rq);
>>>>
>>>> -               SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>>>> -               if (cfs_rq->nr_queued)
>>>> -                       cfs_rq->throttled_clock_self = rq_clock(rq);
>>>> +       SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>>>> +       if (cfs_rq->nr_queued)
>>>> +               cfs_rq->throttled_clock_self = rq_clock(rq);
>>>> +
>>>> +       WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
>>>> +       /*
>>>> +        * rq_lock is held, current is (obviously) executing this in kernelspace.
>>>> +        *
>>>> +        * All other tasks enqueued on this rq have their saved PC at the
>>>> +        * context switch, so they will go through the kernel before returning
>>>> +        * to userspace. Thus, there are no tasks-in-userspace to handle, just
>>>> +        * install the task_work on all of them.
>>>> +        */
>>>> +       node = rb_first(&cfs_rq->tasks_timeline.rb_root);
>>>> +       while (node) {
>>>> +               struct sched_entity *se = __node_2_se(node);
>>>> +
>>>> +               if (!entity_is_task(se))
>>>> +                       goto next;
>>>> +
>>>> +               p = task_of(se);
>>>> +               task_throttle_setup_work(p);
>>>> +next:
>>>> +               node = rb_next(node);
>>>> +       }
>>>
>>> I'd like to strongly push back on this approach. This adds quite a lot
>>> of extra computation to an already expensive path
>>> (throttle/unthrottle). e.g. this function is part of the cgroup walk
>>
>> Actually, with my suggestion in another email that we only need to mark
>> these cfs_rqs throttled when quote used up, and setup throttle task work
>> when the tasks under those cfs_rqs get picked, the cost of throttle path
>> is much like the dual tree approach.
>>
>> As for unthrottle path, you're right, it has to iterate each task on
>> a list to get it queued into the cfs_rq tree, so it needs more thinking.
>>
>>> and so it is already O(cgroups) for the number of cgroups in the
>>> hierarchy being throttled. This gets even worse when you consider that
>>> we repeat this separately across all the cpus that the
>>> bandwidth-constrained group is running on. Keep in mind that
>>> throttle/unthrottle is done with rq lock held and IRQ disabled.
>>
>> Maybe we can avoid holding rq lock when unthrottle? As for per-task
>> unthrottle, it's much like just waking up lots of tasks, so maybe we
>> can reuse ttwu path to wakeup those tasks, which could utilise remote
>> IPI to avoid holding remote rq locks. I'm not sure, just some random thinking..
>>
>>>
>>> In K Prateek's last RFC, there was discussion of using context
>>> tracking; did you consider that approach any further? We could keep
>>> track of the number of threads within a cgroup hierarchy currently in
>>> kernel mode (similar to h_nr_runnable), and thus simplify down the
>>
>> Yeah, I think Prateek's approach is very creative! The only downside of
>> it is that the code becomes much complex.. on already complex codebase.
>> Anyway, it would be great that or this could be merged in mainline kernel.
> 
> I think the consensus is to move to per-task throttling since it'll
> simplify the efforts to move to a flat hierarchy sometime in the near
> future.

Ah, agree! And I'm very much looking forward to seeing a flat hierarchy!

At our clusters, there are often too many levels (3-6) of cgroups, which
caused too much cost in scheduler activities.

> 
> My original approach was complex since i wanted to seamlessly resume the
> pick part on unthrottle. In Ben;s patch [1] there is a TODO in
> pick_next_entity() and that probably worked with the older vruntime based
> CFS algorithm but can break EEVDF guarantees.
> 
> [1] https://lore.kernel.org/all/xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com/
> 
> Unfortunately keeping a single rbtree meant replicating the stats and
> that indeed adds to complexity.

Ok, got it.

Thanks!

> 
>>
>> At last, I wonder is it possible that we can implement a cgroup-level
>> bandwidth control, instead of doing it in each sched_class? Then SCX
>> tasks could be controlled too, without implementing it in BPF code...
>>
>> Thanks!
>>
>>> throttling code here.
>>>
>>> Best,
>>> Josh
> 

