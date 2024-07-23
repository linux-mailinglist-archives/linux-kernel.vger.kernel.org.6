Return-Path: <linux-kernel+bounces-260136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F993A3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45FA3B22E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2F5156F34;
	Tue, 23 Jul 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wydw4J/U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D083D55D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747857; cv=none; b=oJMjXIe64TuRh2DvNYL6GkCjfgNPTTKxieOITmFdW7PcFPZT9wt+BcOMZUxkkXjt7a0cBRgF2sCd6UrCFiGzEKhIciebczyTlfubB4vFqF3GDiCfTeSHsZjziX7DlZkuBM4k2CiSDy0lpuerGDpPmglpbi7igB/i3+i+K1NwDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747857; c=relaxed/simple;
	bh=Op6OMKWNm9UGjwjLeDWTnaEnNPOC1Lhwlu0WkJYl0YU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ly+PLrzLwlj4AwXFj19lsfhcyfFWxLscEvJL706Pcf7gcnBclMT/hyV9TR19Ga1rSJu/vppDteNDeePffN+pvPVm+eLFLmtvStJMpbVa1VzMpGZS78j/PyQ0RvD3HcNa1LCLWqa+QodJADIG0yOusweSTrGYB4ygLu6k7kXyWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wydw4J/U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721747854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Se2qJ3sHYkOm1BoL5Bkw/CO0CmEE/yJ0SmuGMLMSHJ8=;
	b=Wydw4J/USXkqKSdOFRA8ecH6wQfUp88Wczk1zUECcbsLN5rcTQgdNpK0jtsb8xx+556hqs
	gTrIKNtR0mdBtUJ7YBf7FeY2c/caU1+D3uOyn8xTlHXhPeIIyL71GbWo7Y2HroCW1J+F10
	BS0R07N9Y8QhxIvrxfq/p6gGzdETcco=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-wwNUXezIPquj_jMGz3B98Q-1; Tue, 23 Jul 2024 11:16:24 -0400
X-MC-Unique: wwNUXezIPquj_jMGz3B98Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42796140873so38198555e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721747783; x=1722352583;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2qJ3sHYkOm1BoL5Bkw/CO0CmEE/yJ0SmuGMLMSHJ8=;
        b=I5HMOgtB+JoG/SxqJSntFL+rXhHsnF3ZLLqjsKw7fbQC5Idkg1cQGgGdBLOriw9fN3
         XGBJtSsORWMtfWv4etQAZCJaS+3YAU7zhWiW/xK/6P3ql28r9mClmFvLEyZok8dYU/hh
         L/cEXHc4rMiIFFSUfQwxSGXC0dy1U6ES0odoIoAWXKzipbeHzNuGftOKV5+9Xm1Ojuwf
         kiiO5albTWIVtFl13+O6enun9WZ/wdan9eQgTPzoML7V8Taimr1etQc4txPwtQnJizNj
         oOQDxSRpRoCeh+uzIoTSKzmDqUjTWq28aMV82YpgBTpd/Jaxi+OMFR4DCdnqtroTVus2
         YRIQ==
X-Gm-Message-State: AOJu0YyiexNtHDqgh1WfCNRAdCB6DwZXfsYQxGtlpspip4GKuK+s64Ay
	LxcFG3CbjXrQE1IBrpDqLWn3xFgxW+7ziF/BnatkV0V+7XcwROAVwbaMN8G4GbX4xxo/mbfuEzG
	fchPqJcV311W23PkFmHTRAnE36YNpBqx55omEvNaAt2bBIwpVl2LhlsxkS+mouA==
X-Received: by 2002:a05:600c:3542:b0:426:5c36:207c with SMTP id 5b1f17b1804b1-427dc569de8mr65576185e9.25.1721747783307;
        Tue, 23 Jul 2024 08:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7FFmktIg5vCMbVwZ/fZLl5fT4Z99Aig5U8ObPxkOlqcEq6DCQaSqn7libJQiTkG+EAeQk+A==
X-Received: by 2002:a05:600c:3542:b0:426:5c36:207c with SMTP id 5b1f17b1804b1-427dc569de8mr65575945e9.25.1721747782835;
        Tue, 23 Jul 2024 08:16:22 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6902a1fsm172459585e9.20.2024.07.23.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 08:16:21 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Phil Auld
 <pauld@redhat.com>, Clark Williams <williams@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Guo Ren
 <guoren@kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return
 to userspace
In-Reply-To: <xm26y15yz0q8.fsf@google.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-11-vschneid@redhat.com>
 <xm26y15yz0q8.fsf@google.com>
Date: Tue, 23 Jul 2024 17:16:20 +0200
Message-ID: <xhsmhikwwyw8r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 18/07/24 17:25, Benjamin Segall wrote:
> Valentin Schneider <vschneid@redhat.com> writes:
>
>> As reported in [1], CFS bandwidth throttling is a source of headaches in
>> PREEMPT_RT - generally speaking, a throttled CFS task can hold locks that
>> prevent ksoftirqd from running, which prevents replenishing & unthrottling
>> the cfs_rq of said CFS task.
>>
>> Peter mentioned that there have been discussions on changing /when/ the
>> throttling happens: rather than have it be done immediately upon updating
>> the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
>> for the task to be about to return to userspace.
>
> Sorry for taking a while to get to replying ot this.

Well it's a pretty big diff, so thanks for taking a look!

>
>> Clocks
>> ======
>>
>> Correctly handling the different cfs_rq->throttled_clock* is tricky, as
>> unlike the current upstream approach where all tasks of a cfs_rq are
>> throttled at the exact same time, here they each get throttled at a
>> per-task, not-known-beforehand time.
>>
>> For instance, for the ->throttled_clock_pelt, ideally we would need a
>> per-task snapshot of when the task gets really throttled in
>> exit_to_user_mode(), rather than a single snapshot of when the cfs_rq runs
>> out of runtime. This isn't implemented here. The ->throttled_clock_pelt is
>> set when the cfs_rq runs out of runtime, which means the "grace period"
>> given to the cfs_rq's tasks on their way to exit_to_user_mode() isn't
>> accounted.
>
> And I haven't checked it yet because I never remember how the whole
> throttled clock thing works. :P
>
>>
>> Notable behaviour changes
>> =========================
>>
>> Once a cfs_rq is ->throttled, its tasks can continue running until they hit
>> exit_to_user_mode(). This means they can keep draining further runtime
>> from their cfs_rq, which can end up draining more than one period's worth
>> of runtime.
>>
>> I've tested a 10ms runtime / 100ms period cgroup with an always running
>> task: upstream gets a "clean" periodic pattern of 10ms runtime every 100ms,
>> whereas this gets something more like 40ms runtime every 400ms.
>
> Hmm, this seems a little odd since TWA_RESUME does a kick_process.

I didn't ponder too much on the workload used here, but the point I wanted
to bring up is: if you give a cgroup X amount of runtime, it may still
consume more than that within a single period because execution in
kernelspace isn't immediately stopped/throttled.

It means the "standard" bandwidth control behaviour becomes a bit more
bursty.

>> +static void task_throttle_cancel_irq_work_fn(struct irq_work *work)
>> +{
>> +	struct task_struct *p = container_of(work, struct task_struct, unthrottle_irq_work);
>> +	int cpu = raw_smp_processor_id();
>> +
>> +	CLASS(task_rq_lock, rq_guard)(p);
>> +	WARN_ON_ONCE(task_cpu(p) != cpu);
>> +
>> +	if (task_has_throttle_work(p) && !task_needs_throttling(p))
>> +		task_throttle_do_cancel_work(p);
>> +}
>
> I think you can wind up triggering this WARN and in general have some
> weird state, whether or not it matters, basically any time that you
> __task_throttle_cancel(p, a_remote_cpu).
>
> It queues an irq_work and sends an IPI, but doesn't wait for it. If
> handling that IPI is delayed, then we can wind up doing more
> migration/class switch/etc (on this cpu or some third cpu) before that
> irq_work runs.
>
> I think this may be ok and it's just the WARN that's wrong, but I'm not
> sure.
>

That whole thing is indeed nasty, /me goes back through my notes
Right, so you can have:

  task_cpu(p) == CPU0

  CPU0                     CPU1

  rq_lock();
                           rq_lock();
  switched_from_fair()
    task_throttle_cancel()
    ...
  rq_unlock();
                           pull_rt_task()
                             set_task_cpu(p, CPU1);
                           rq_unlock();

  task_throttle_cancel_irq_work_fn()
    task_throttle_do_cancel()
      WARN_ON_ONCE(CPU1 != CPU0);

That does mean the task p could start executing on CPU1 before the
task_work is cleared, which is something I want to avoid - while very
unlikely, the worst case is it reaches exit_to_user_mode() before the
task_work gets cleared, which is a no-no.

I could add a sched_class check in throttle_cfs_rq_work(), but this is making
wonder if irq_work is the right mechanism here.

The one important thing for me is: if a task doesn't need throttling
anymore, then the dequeue_task_fair() in exit_to_user_mode() mustn't happen.
One option I'm seeing is forget about the irq_work, always re-check sched_class
in throttle_cfs_rq_work() (we already check cfs_rq->throttle_count aka
throttled_hierarchy()), and just do a kick_process() to ensure a kernel entry.

>> +	/*
>> +	 * Re-enqueue the tasks that have been throttled at this level.
>> +	 *
>> +	 * The task count is up-propagated via ->unthrottled_*h_nr_running,
>> +	 * as we can't purely rely on h_nr_running post-enqueue: the unthrottle
>> +	 * might happen when a cfs_rq still has some tasks enqueued, either still
>> +	 * making their way to userspace, or freshly migrated to it.
>> +	 */
>> +	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
>> +		struct sched_entity *pse = &p->se;
>> +
>> +		list_del_init(&p->throttle_node);
>> +
>> +		enqueue_entity(cfs_rq, pse, ENQUEUE_WAKEUP);
>> +		task_delta++;
>> +		idle_task_delta += task_has_idle_policy(p);
>> +	}
>
> You know, on our too-large machines with too-many cgroups, we're already
> running into these walk_tg_trees being worrying slow for holding a spinlock :P
>

Yeah, for N throttled cgroups in a hierarchy, this is pretty much squashing
N rq-lock-held segments into one. Not great.

What I'm thinking is we could have N walks re-queuing the tasks of a single
cfs_rq each walk and updating the hierarchy, releasing the rq-lock between
each walk - instead of a single walk re-queueing up to N lists of
tasks. More operations but smaller rq-lock-held segments.

>> +
>> +	/*
>> +	 * Account tasks woken up in children; by this point all direct children
>> +	 * have been visited.
>> +	 */
>> +	task_delta += cfs_rq->unthrottled_h_nr_running;
>> +	idle_task_delta += cfs_rq->unthrottled_idle_h_nr_running;
>> +
>> +	cfs_rq->h_nr_running += task_delta;
>> +	cfs_rq->idle_h_nr_running += idle_task_delta;
>> +
>> +	/*
>> +	 * unthrottle_cfs_rq() needs a value to up-propagate above the
>> +	 * freshly unthrottled cfs_rq.
>> +	 */
>> +	cfs_rq->unthrottled_h_nr_running = task_delta;
>> +	cfs_rq->unthrottled_idle_h_nr_running = idle_task_delta;
>
> I think this should have no effect, right?

Hm so my thoughts here are:
The walk_tg_tree_from(tg_unthrottle_up) will update *nr_running counts up
to the cfs_rq->tg->se[cpu_of(rq)]. However if that cfs_rq isn't the root
one, we'll need the for_each_sched_entity() loop further down
unthrottle_cfs_rq() to update the upper part of the hierarchy. The values
that will be up-propagated there are the ones being saved here.

>
>> +
>> +	/* Accumulate the delta in the parent's stash. Once all its children
>> +	 * (i.e. all of this cfs_rq's siblings) have been visited, this value
>> +	 * will be stable and used for its own count update.
>> +	 */
>> +	pcfs_rq->unthrottled_h_nr_running += task_delta;
>> +	pcfs_rq->unthrottled_idle_h_nr_running += idle_task_delta;
>> +
>> +	/*
>> +	 * If the cfs_rq became empty during throttling, then we dequeued
>> +	 * it. It needs to be put back in the hierarchy if it or any of
>> +	 * its children have now-unthrottled tasks.
>> +	 */
>> +	if (!se->on_rq && (cfs_rq->h_nr_running || cfs_rq->idle_h_nr_running)) {
>> +		enqueue_entity(pcfs_rq, se, ENQUEUE_WAKEUP);
>> +	} else {
>> +		update_load_avg(pcfs_rq, se, UPDATE_TG);
>> +		se_update_runnable(se);
>>      }
>
> So I think this is trying to combine the all updates, and it's logically
> just the same as if the loop was enqueue_task_fair, like you mentioned
> in a followup for the throttle_one_task and dequeue_task_fair?
>

Good point, that should be a mirror of throttle_one_task() wrt the enqueueing.

>>  void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>> @@ -5922,25 +6152,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>>              goto unthrottle_throttle;
>>      }
>>
>> -	task_delta = cfs_rq->h_nr_running;
>> -	idle_task_delta = cfs_rq->idle_h_nr_running;
>> -	for_each_sched_entity(se) {
>> -		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>> -
>> -		if (se->on_rq)
>> -			break;
>> -		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
>> -
>> -		if (cfs_rq_is_idle(group_cfs_rq(se)))
>> -			idle_task_delta = cfs_rq->h_nr_running;
>> +	if (cfs_rq->throttle_count)
>> +		return;
>>
>> -		qcfs_rq->h_nr_running += task_delta;
>> -		qcfs_rq->idle_h_nr_running += idle_task_delta;
>> +	/*
>> +	 * cfs_rq's below us may not have been fully emptied out, so we can't rely
>> +	 * directly on ->h_nr_running. Use the stash instead.
>> +	 */
>> +	task_delta = cfs_rq->unthrottled_h_nr_running;
>> +	idle_task_delta = cfs_rq->unthrottled_idle_h_nr_running;
>>
>> -		/* end evaluation on encountering a throttled cfs_rq */
>> -		if (cfs_rq_throttled(qcfs_rq))
>> -			goto unthrottle_throttle;
>> -	}
>> +	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_clear_up, (void *)rq);
>>
>>      for_each_sched_entity(se) {
>>              struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>
> I think this would be simpler by making the first/original
> walk_tg_tree_from be
>
> walk_tg_tree_from(cfs_rq->tg, tg_unthrottle_clear_down, tg_unthrottle_up, (void *)rq);
>
> (With the clear function being the same, just renamed)
>
> We never have any unthrottled* saved between calls to unthrottle_cfs_rq,
> because if throttled_count is set for us, it's set for all of our
> descendants too, so we're doing nothing but throttle_count stuff in that
> case. Sadly that doesn't let us remove the cfs_rq fields, that would
> need a walk_tg_tree_by_level.

Good point, I think that makes sense. Thanks!


