Return-Path: <linux-kernel+bounces-273009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD7946357
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A2D1F225DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B7013633A;
	Fri,  2 Aug 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcur3hJw"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877A1ABEA2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624475; cv=none; b=q4H7mnfJo3xZgYARd1SDtLgYnsfvcz+m8TeJypTBV0Ig7rzl0RmgHZqbbZ4DO4rNyz7YNlvWgFASzJOm7xWqpyuaAcSh6dFjfzYzjKHDj3e0ft0+TrCj2R2I97C79bKyx8LhfsKGrgwNxJUl/OJSZHVcEIUw6hHEsDq8EjDL+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624475; c=relaxed/simple;
	bh=HQ1H9osY9gdq5z+TScy7bsZZ83ghK/fW6wMUiEETVrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltPeu6+e3BHdPwVyMZfE0wBxQmJ2xYghzXYc9mkMW+9X4bS0nPpwTd2X9kzr2fcvqP/0jupqle7cDcFdZrd/9MFmSVunCcaqWh355x1j5AQS5WHsV6IaNhdXja8jf32xt7xvEAVfU9zn5YTZdxTzSMjyaGF14g+xYndGX2ooRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcur3hJw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d2ae44790so6148480b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722624473; x=1723229273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zK9buRzRB91TBzsCeLOFi3adhlotmWbmaVhftFSbBUY=;
        b=Gcur3hJwWaDldw+hslmX0LnivDdiyFFgaDsX5WrZjRZTWvVlR3PtreeuOJ6cN6W8Pz
         syRbpKRiRZKimWs861dbJA4Hj7cTfyrbG2/jeqGob2P0GLh3mqvh9hnm/GyqebWybGgb
         Y9Us1rM9zpzkZpXQq2/WjR0nBX1AearNaU4MJhY/JOaZJRTcdWj05lwtO532FeqE1IKY
         0b9tMSOMOoNTzJAPTv7fdBd05W41HcGRqHRnfMcaypBvf2TBfMF9/YYCYff6BFCgLxEZ
         D2ZTv2ydC8di2hw7wosfDeXU1J9eW0e3dd29RHwgCspfpYPKnwH1hxmN6myh91iE4woB
         rraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624473; x=1723229273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK9buRzRB91TBzsCeLOFi3adhlotmWbmaVhftFSbBUY=;
        b=jxtdhAqiKE/FDJx4TE/+mB5ACkdywBxwlnBr8Rs++WGrh6xeA2R6qSxw/uBrc1dxck
         xbBJ+wow7jMWWiUVxDlEHcVjz0lCla5exM6Mln8/A9qgkQuyhfBE6TKnp7vDfnQO+QQe
         rUYz/DpPQpub/ttpvfAkVUjkcEduCbpcepcf0IyXfP/Y0J05gDAvIGZ36chSh7/jtn4v
         i32lykYKBFDpXjYH+ND670brmC2d6sKLIYZHDLF5IyxkDAb7ck3mtqd5+CI8EJBRQocE
         0AHrhMyxSDp+xnIiTNT1hfS2addXu069Mh/vXDCVo3oudk9NVv97YbZUDmFSSJ2k1i8e
         ch+w==
X-Forwarded-Encrypted: i=1; AJvYcCVk/RTdNb2wKmwVHB9OvXoIo1nNrpWFIKW7au1OTKE8Lun7MauDRWiXy3HSYC5ZWYTg14CNihVNLI5ZKicg746xnddlgTqeHGoFcdOB
X-Gm-Message-State: AOJu0YwY9Iuz9Hw6twJVkXpIO2JcvDwmDEmD0wXPzDy8LJzFvdD+cm6E
	pmlC0Gdr0dD6EhShzQA2kHDIDPfAV50F7PxN+QJWA92HlBvDUkE4
X-Google-Smtp-Source: AGHT+IFagZSoUCXtsGv1fhyef1OYVjmyXsM4qB6pTX4HtaweGx0pb8aJGwncRF3eYWoBN7JTJIFnqg==
X-Received: by 2002:a05:6a00:b53:b0:710:5848:8ae1 with SMTP id d2e1a72fcca58-7106cf8fd33mr5618698b3a.4.1722624472826;
        Fri, 02 Aug 2024 11:47:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfe2dsm1646435b3a.114.2024.08.02.11.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:47:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Aug 2024 08:47:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <Zq0p154ndOtU9Ypu@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <20240802122034.GZ12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802122034.GZ12673@noisy.programming.kicks-ass.net>

Hello,

On Fri, Aug 02, 2024 at 02:20:34PM +0200, Peter Zijlstra wrote:
> 
> A few more..
> 
> > +static bool scx_switching_all;
> > +DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
> 
> > +	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
> > +	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
> > +		static_branch_enable(&__scx_switched_all);
> 
> > +	static_branch_disable(&__scx_switched_all);
> > +	WRITE_ONCE(scx_switching_all, false);
> 
> FYI the static_key contains a variable you can read if you want, see
> static_key_count()/static_key_enabled(). No need to mirror the state.

They go off together but they don't go on together in scx_ops_enable().
switching_all goes on first which makes new tasks to go on SCX, all existing
tasks are switched, and then __scx_switched_all goes on. I can make
switching_all a static_key too but the only time it's read is during fork
and while switching scheduler class, so it doesn't really seem worth it.

> > +static struct task_struct *
> > +scx_task_iter_next_locked(struct scx_task_iter *iter, bool include_dead)
> > +{
> > +	struct task_struct *p;
> > +retry:
> > +	scx_task_iter_rq_unlock(iter);
> > +
> > +	while ((p = scx_task_iter_next(iter))) {
> > +		/*
> > +		 * is_idle_task() tests %PF_IDLE which may not be set for CPUs
> > +		 * which haven't yet been onlined. Test sched_class directly.
> > +		 */
> > +		if (p->sched_class != &idle_sched_class)
> > +			break;
> 
> This isn't quite the same; please look at play_idle_precise() in
> drivers/powercap/idle_inject.c.
> 
> That is, there are PF_IDLE tasks that are not idle_sched_class.

Thanks for pointing that out. scx_task_iter's are used to move tasks in and
out of SCX when BPF scheduler is attached and detached, respectively. The
requirements are:

1. __setscheduler_prio() should be able to determine the sched_class for the
   task.

2. scx_ops_init_task() must be called on all tasks which can potentially
   switch to SCX. This invokes ops.init_task() if implemented.

The swappers are problematic for both 1) and 2). __setscheduler_prio() won't
preserve the idle_sched_class, and it's really easy to confuse the BPF
schedulers with swappers as they aren't normal tasks (e.g. they have the
same PID). Besides, they are never going to be scheduled by SCX anyway.

Looking at idle_inject, they seem to be regular RT threads which temporarily
set PF_IDLE. AFAICS, this should be completely fine. The iterator just
really needs to avoid the swappers.

I'll add more comments.

...
> > +static void update_curr_scx(struct rq *rq)
> > +{
> > +	struct task_struct *curr = rq->curr;
> > +	u64 now = rq_clock_task(rq);
> > +	u64 delta_exec;
> > +
> > +	if (time_before_eq64(now, curr->se.exec_start))
> > +		return;
> > +
> > +	delta_exec = now - curr->se.exec_start;
> > +	curr->se.exec_start = now;
> > +	curr->se.sum_exec_runtime += delta_exec;
> > +	account_group_exec_runtime(curr, delta_exec);
> > +	cgroup_account_cputime(curr, delta_exec);
> 
> Could you please use update_curr_common() here?
> 
> This helps keep the accounting in one place. For instance, see this
> patch:
> 
>   https://lkml.kernel.org/r/20240727105031.053611186@infradead.org  
> 
> That adds a sum_exec_runtime variant that is scaled by DVFS and
> capacity.
> 
> You should be able to make the function:
> 
> 	u64 delta_exec = update_curr_common(rq);

Will do.

...
> > +	/*
> > +	 * We want to pass scx-specific enq_flags but activate_task() will
> > +	 * truncate the upper 32 bit. As we own @rq, we can pass them through
> > +	 * @rq->scx.extra_enq_flags instead.
> > +	 */
> > +	WARN_ON_ONCE(rq->scx.extra_enq_flags);
> > +	rq->scx.extra_enq_flags = enq_flags;
> 
> eeew.. it's not just activate_task(), its the whole callchain having
> 'int' flags. That said, we should be having plenty free bits there no?

Yeah, this isn't pretty but here are the rationales:

- These extra enqueue flags are only necessary for SCX. For other
  sched_classes, these flags exist to communicate between sched core and
  sched_classes. SCX also needs to communicate from the SCX itself to the
  BPF scheduler, which creates the need for extra flags.

- While possible, it's pretty cumbersome to support backward compatibility
  when flag values change. Unless done proactively, it can silently and
  subtly break forward compatibility.

- As SCX flags aren't interesting to anyone else, it makes sense to put them
  in the upper 32bits. This way, they don't get in the way and the chance of
  needing to shift them around is lower.

...
> > +static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq,
> > +				struct task_struct *p, struct rq *task_rq)
> > +{
> > +	bool moved = false;
> > +
> > +	lockdep_assert_held(&dsq->lock);	/* released on return */
> > +
> > +	/*
> > +	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
> > +	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
> > +	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
> > +	 * rq lock or fail, do a little dancing from our side. See
> > +	 * move_task_to_local_dsq().
> > +	 */
> > +	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> > +	task_unlink_from_dsq(p, dsq);
> > +	dsq_mod_nr(dsq, -1);
> > +	p->scx.holding_cpu = raw_smp_processor_id();
> > +	raw_spin_unlock(&dsq->lock);
> > +
> > +	double_lock_balance(rq, task_rq);
> > +
> > +	moved = move_task_to_local_dsq(rq, p, 0);
> > +
> > +	double_unlock_balance(rq, task_rq);
> > +
> > +	return moved;
> > +}
> 
> I've gotta ask, why are you using the double_lock_balance() pattern
> instead of the one in move_queued_task() that does:
> 
>   lock src
>   dequeue src, task
>   set_task_cpu task, dst
>   unlock src
> 
>   lock dst
>   enqueue dst, task
>   unlock dst

When !CONFIG_PREEMPTION, double_lock_balance() seems cheaper than unlocking
and locking unconditionally. Because SCX schedulers can do a lot more hot
migrations, I thought it'd be better to go that way. I haven't actually
measured anything tho, so I could be wrong.

> > +/*
> > + * Similar to kernel/sched/core.c::is_cpu_allowed() but we're testing whether @p
> > + * can be pulled to @rq.
> > + */
> > +static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq)
> > +{
> > +	int cpu = cpu_of(rq);
> > +
> > +	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> > +		return false;
> > +	if (unlikely(is_migration_disabled(p)))
> > +		return false;
> > +	if (!(p->flags & PF_KTHREAD) && unlikely(!task_cpu_possible(cpu, p)))
> > +		return false;
> > +	if (!scx_rq_online(rq))
> > +		return false;
> > +	return true;
> > +}
> 
> I'm a little confused, is_cpu_allowed() is used for that same purpose
> no?

Yeah, this is a bit subtle. There are two differences:

- IIUC, during migration, is_cpu_allowed() has to say "yes" to the
  destination CPU as that may be the CPU that the task is being migrated to.
  However, task_can_run_on_remote_rq() is asking something different - it's
  asking "can I initiate migrating the task to this rq?", which it shouldn't
  while migration is disabled.

- The BPF scheduler is bypassed while the rq is offline. This doesn't hinder
  other migrations. It just makes the CPU state testing a non-factor for
  "can the BPF scheduler pull this task to this rq?".

I suppose the function can be rewritten to be something like:

	if (!is_cpu_allowed())
		return false;
	if (unlikely(is_migration_disabled(p)))
		return false;
	if (!scx_rq_online(rq))
		return false;

but I'm not sure it's necessarily better. I'll add more comments explaining
what's going on.

Thanks.

-- 
tejun

