Return-Path: <linux-kernel+bounces-272547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78819945DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE712823DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335671DF670;
	Fri,  2 Aug 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V68btgcz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78601C825A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722601243; cv=none; b=hJ8rYx4sXDP8Tm7MmOqBJHa9LO+rKh40/Eht/Hkue+3C8IwBqilQUpx2YrgNiHNEwAPgPpBlz6EP25rNMIqurz5+vsuhvjhQE4PyVjinHoAsi+YirNxQff3JCAE6a5drUEDaKs3WT/edL+wp3Ojyoy6asxhM2I3Geqv07mLXVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722601243; c=relaxed/simple;
	bh=HQBrl3FC7BW6zxaO/CNSOpI8WbKepc8OGkYZuIt9q9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCRdFDiPLYt7WRkjB59wGgZvs97doiX52sMcZfh00PX1Z5iJI675YP59EqqmTLaJhQq1RfNi2ht/DEnHgDguwOj14uHTodIMWdPiC9IOlEcAMJis0JJ44nO8AF0LsmQQPxJ+goBHL3a8L4FIO7LfRc0ZZGUpfgdsxBeAS82RbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V68btgcz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xBW+/N+vFfIbqYScXDF4An/NDnPz2OPfhpkfLYo7tBY=; b=V68btgcznH2r4+dDmTVqQXIMdT
	cyBXUWUSQoey9qxTITeqpjJMlKxgxcXBlNYxUIoKohLqz1hVnYKwgqNRJtI53UlfW0oStAUxEVM9H
	PVUhfsnt4oqQRzNI3pX1z7VB+bP+ZXjUq4AknOqcBP7lWjWx96Mgk+lC8T+5X5GP6yCrlU4dkJwlS
	EYcSTr8fFROTep6SLWouI/8mMQvMybchAmmJ1McB/tnnVn5mQnsL2ZTCqqO1/223TCVD6UBsqNGUW
	0JH6Tr7FVoDJoVwhapXSuXSf57QqRrNyUO98gk8uVRYdB4uHTFLkJO6iu2/sMt0udvV29mMykydxB
	/mcaHpUA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZrGt-0000000108H-2AD8;
	Fri, 02 Aug 2024 12:20:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8BA8430049D; Fri,  2 Aug 2024 14:20:34 +0200 (CEST)
Date: Fri, 2 Aug 2024 14:20:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240802122034.GZ12673@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723163358.GM26750@noisy.programming.kicks-ass.net>


A few more..

> +static bool scx_switching_all;
> +DEFINE_STATIC_KEY_FALSE(__scx_switched_all);

> +	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
> +	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
> +		static_branch_enable(&__scx_switched_all);

> +	static_branch_disable(&__scx_switched_all);
> +	WRITE_ONCE(scx_switching_all, false);

FYI the static_key contains a variable you can read if you want, see
static_key_count()/static_key_enabled(). No need to mirror the state.


> +static struct task_struct *
> +scx_task_iter_next_locked(struct scx_task_iter *iter, bool include_dead)
> +{
> +	struct task_struct *p;
> +retry:
> +	scx_task_iter_rq_unlock(iter);
> +
> +	while ((p = scx_task_iter_next(iter))) {
> +		/*
> +		 * is_idle_task() tests %PF_IDLE which may not be set for CPUs
> +		 * which haven't yet been onlined. Test sched_class directly.
> +		 */
> +		if (p->sched_class != &idle_sched_class)
> +			break;

This isn't quite the same; please look at play_idle_precise() in
drivers/powercap/idle_inject.c.

That is, there are PF_IDLE tasks that are not idle_sched_class.

> +	}
> +	if (!p)
> +		return NULL;
> +
> +	iter->rq = task_rq_lock(p, &iter->rf);
> +	iter->locked = p;
> +
> +	/*
> +	 * If we see %TASK_DEAD, @p already disabled preemption, is about to do
> +	 * the final __schedule(), won't ever need to be scheduled again and can
> +	 * thus be safely ignored. If we don't see %TASK_DEAD, @p can't enter
> +	 * the final __schedle() while we're locking its rq and thus will stay
> +	 * alive until the rq is unlocked.
> +	 */
> +	if (!include_dead && READ_ONCE(p->__state) == TASK_DEAD)
> +		goto retry;
> +
> +	return p;
> +}


> +static void update_curr_scx(struct rq *rq)
> +{
> +	struct task_struct *curr = rq->curr;
> +	u64 now = rq_clock_task(rq);
> +	u64 delta_exec;
> +
> +	if (time_before_eq64(now, curr->se.exec_start))
> +		return;
> +
> +	delta_exec = now - curr->se.exec_start;
> +	curr->se.exec_start = now;
> +	curr->se.sum_exec_runtime += delta_exec;
> +	account_group_exec_runtime(curr, delta_exec);
> +	cgroup_account_cputime(curr, delta_exec);

Could you please use update_curr_common() here?

This helps keep the accounting in one place. For instance, see this
patch:

  https://lkml.kernel.org/r/20240727105031.053611186@infradead.org  

That adds a sum_exec_runtime variant that is scaled by DVFS and
capacity.

You should be able to make the function:

	u64 delta_exec = update_curr_common(rq);
> +	struct task_struct *curr = rq->curr;
> +
> +	if (curr->scx.slice != SCX_SLICE_INF) {
> +		curr->scx.slice -= min(curr->scx.slice, delta_exec);
> +		if (!curr->scx.slice)
> +			touch_core_sched(rq, curr);
> +	}
> +}



> +static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
> +				   u64 enq_flags)
> +{
> +	struct rq *task_rq;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * If dequeue got to @p while we were trying to lock both rq's, it'd
> +	 * have cleared @p->scx.holding_cpu to -1. While other cpus may have
> +	 * updated it to different values afterwards, as this operation can't be
> +	 * preempted or recurse, @p->scx.holding_cpu can never become
> +	 * raw_smp_processor_id() again before we're done. Thus, we can tell
> +	 * whether we lost to dequeue by testing whether @p->scx.holding_cpu is
> +	 * still raw_smp_processor_id().
> +	 *
> +	 * See dispatch_dequeue() for the counterpart.
> +	 */
> +	if (unlikely(p->scx.holding_cpu != raw_smp_processor_id()))
> +		return false;
> +
> +	/* @p->rq couldn't have changed if we're still the holding cpu */
> +	task_rq = task_rq(p);
> +	lockdep_assert_rq_held(task_rq);
> +
> +	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(rq), p->cpus_ptr));
> +	deactivate_task(task_rq, p, 0);
> +	set_task_cpu(p, cpu_of(rq));
> +	p->scx.sticky_cpu = cpu_of(rq);

(this *could* live in ->migrate_task_rq(), but yeah, you only have this
one site, so meh)

> +
> +	/*
> +	 * We want to pass scx-specific enq_flags but activate_task() will
> +	 * truncate the upper 32 bit. As we own @rq, we can pass them through
> +	 * @rq->scx.extra_enq_flags instead.
> +	 */
> +	WARN_ON_ONCE(rq->scx.extra_enq_flags);
> +	rq->scx.extra_enq_flags = enq_flags;

eeew.. it's not just activate_task(), its the whole callchain having
'int' flags. That said, we should be having plenty free bits there no?

> +	activate_task(rq, p, 0);
> +	rq->scx.extra_enq_flags = 0;
> +
> +	return true;
> +}

> +static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq,
> +				struct task_struct *p, struct rq *task_rq)
> +{
> +	bool moved = false;
> +
> +	lockdep_assert_held(&dsq->lock);	/* released on return */
> +
> +	/*
> +	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
> +	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
> +	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
> +	 * rq lock or fail, do a little dancing from our side. See
> +	 * move_task_to_local_dsq().
> +	 */
> +	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> +	task_unlink_from_dsq(p, dsq);
> +	dsq_mod_nr(dsq, -1);
> +	p->scx.holding_cpu = raw_smp_processor_id();
> +	raw_spin_unlock(&dsq->lock);
> +
> +	double_lock_balance(rq, task_rq);
> +
> +	moved = move_task_to_local_dsq(rq, p, 0);
> +
> +	double_unlock_balance(rq, task_rq);
> +
> +	return moved;
> +}

I've gotta ask, why are you using the double_lock_balance() pattern
instead of the one in move_queued_task() that does:

  lock src
  dequeue src, task
  set_task_cpu task, dst
  unlock src

  lock dst
  enqueue dst, task
  unlock dst



> +/*
> + * Similar to kernel/sched/core.c::is_cpu_allowed() but we're testing whether @p
> + * can be pulled to @rq.
> + */
> +static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq)
> +{
> +	int cpu = cpu_of(rq);
> +
> +	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +		return false;
> +	if (unlikely(is_migration_disabled(p)))
> +		return false;
> +	if (!(p->flags & PF_KTHREAD) && unlikely(!task_cpu_possible(cpu, p)))
> +		return false;
> +	if (!scx_rq_online(rq))
> +		return false;
> +	return true;
> +}

I'm a little confused, is_cpu_allowed() is used for that same purpose
no?

