Return-Path: <linux-kernel+bounces-309942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57C96723A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A94D1F228AF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDDC1CD2F;
	Sat, 31 Aug 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lou8KKZB"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B58BF3
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725114668; cv=none; b=Opu7QyHwuc00DYtfOzTEYfIb8Dkr1y363sItJJGhVnNv2Asd7pLO4NfIA3gf9wmkArX7SFwWxLqCMFoHd2YhCqcnuaHg2RyGT3wrPfuxGKq6g07IufO7ow7AXuxbjygX1WS0aY7sR7FwrbTBB+OTQBOFlg0kSG7GUYQfdsSH4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725114668; c=relaxed/simple;
	bh=JJvCauuh1JfOGPT6TLhA5/HzQsOSyReU21rM8kk/CtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYTcNhAMyhyw2ieyTkmF05fpfbryEaySj2ACSVRcjMSBnVjxOZksswIkx+z5zTUZzsDwTAhmrcrHhnfe/y94pYao03rN/CdD69C8E3VtHB3Lf2/6KdFD6rrVg6VZJo1zZaSdsKZ0Vi5K3olqIM7PTzvDbtB3ghXXZaK0NPXJ+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lou8KKZB; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 31 Aug 2024 16:30:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725114662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5LxRLaI6PHeUD1U588+fsIepPXYx0cpFo+a1lpOekU=;
	b=Lou8KKZBf1aaJWCwZDJ1a3O7H98gXloAMJTcgyXxpsDEANUi9WTN9TDX6TFVMFur7eJPoc
	5S44SkrJoTlzA8RR/8NXx8//rb/lyejFdbF5kCY3y69dhVu8zqEl8NxSnR9OMPv/4kHPT0
	zyQNijMYNIW8xOnlPw2CA3PY1bKos2I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, kernel-team@meta.com, linux-kernel@vger.kernel.org,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 10/11] sched_ext: Implement
 scx_bpf_dispatch[_vtime]_from_dsq()
Message-ID: <ZtMpIb38MSn5r4-U@gpd3>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-11-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-11-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 30, 2024 at 01:03:54AM -1000, Tejun Heo wrote:
> Once a task is put into a DSQ, the allowed operations are fairly limited.
> Tasks in the built-in local and global DSQs are executed automatically and,
> ignoring dequeue, there is only one way a task in a user DSQ can be
> manipulated - scx_bpf_consume() moves the first task to the dispatching
> local DSQ. This inflexibility sometimes gets in the way and is an area where
> multiple feature requests have been made.
> 
> Implement scx_bpf_dispatch[_vtime]_from_dsq(), which can be called during
> DSQ iteration and can move the task to any DSQ - local DSQs, global DSQ and
> user DSQs. The kfuncs can be called from ops.dispatch() and any BPF context
> which dosen't hold a rq lock including BPF timers and SYSCALL programs.
> 
> This is an expansion of an earlier patch which only allowed moving into the
> dispatching local DSQ:
> 
>   http://lkml.kernel.org/r/Zn4Cw4FDTmvXnhaf@slm.duckdns.org
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
> Cc: David Vernet <void@manifault.com>
> Cc: Changwoo Min <multics69@gmail.com>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  kernel/sched/ext.c                       | 180 ++++++++++++++++++++++-
>  tools/sched_ext/include/scx/common.bpf.h |   8 +
>  2 files changed, 186 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index df33524d68f3..96b8cc490841 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1067,6 +1067,11 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
>  	return true;
>  }
>  
> +static bool scx_kf_allowed_if_unlocked(void)
> +{
> +	return !current->scx.kf_mask;
> +}
> +
>  /**
>   * nldsq_next_task - Iterate to the next task in a non-local DSQ
>   * @dsq: user dsq being interated
> @@ -5461,7 +5466,7 @@ __bpf_kfunc_start_defs();
>   * scx_bpf_dispatch - Dispatch a task into the FIFO queue of a DSQ
>   * @p: task_struct to dispatch
>   * @dsq_id: DSQ to dispatch to
> - * @slice: duration @p can run for in nsecs
> + * @slice: duration @p can run for in nsecs, 0 to keep the current value
>   * @enq_flags: SCX_ENQ_*
>   *
>   * Dispatch @p into the FIFO queue of the DSQ identified by @dsq_id. It is safe
> @@ -5511,7 +5516,7 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
>   * scx_bpf_dispatch_vtime - Dispatch a task into the vtime priority queue of a DSQ
>   * @p: task_struct to dispatch
>   * @dsq_id: DSQ to dispatch to
> - * @slice: duration @p can run for in nsecs
> + * @slice: duration @p can run for in nsecs, 0 to keep the current value
>   * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ

Maybe allow to keep the current vtime if 0 is passed, similar to slice?

>   * @enq_flags: SCX_ENQ_*
>   *
> @@ -5552,6 +5557,117 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
>  	.set			= &scx_kfunc_ids_enqueue_dispatch,
>  };
>  
> +static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
> +				  struct task_struct *p, u64 dsq_id,
> +				  u64 slice, u64 vtime, u64 enq_flags)
> +{
> +	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
> +	struct rq *this_rq, *src_rq, *dst_rq, *locked_rq;
> +	bool dispatched = false;
> +	bool in_balance;
> +	unsigned long flags;
> +
> +	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
> +		return false;
> +
> +	/*
> +	 * Can be called from either ops.dispatch() locking this_rq() or any
> +	 * context where no rq lock is held. If latter, lock @p's task_rq which
> +	 * we'll likely need anyway.
> +	 */

About locking, I was wondering if we could provide a similar API
(scx_bpf_dispatch_lock()?) to use scx_bpf_dispatch() from any context
and not necessarily from ops.select_cpu() / ops.enqueue() or
ops.dispatch().

This would be really useful for user-space schedulers, since we could
use scx_bpf_dispatch() directly and get rid of the
BPF_MAP_TYPE_RINGBUFFER complexity.

> +	src_rq = task_rq(p);
> +
> +	local_irq_save(flags);
> +	this_rq = this_rq();
> +	in_balance = this_rq->scx.flags & SCX_RQ_IN_BALANCE;
> +
> +	if (in_balance) {
> +		if (this_rq != src_rq) {
> +			raw_spin_rq_unlock(this_rq);
> +			raw_spin_rq_lock(src_rq);
> +		}
> +	} else {
> +		raw_spin_rq_lock(src_rq);
> +	}
> +
> +	locked_rq = src_rq;
> +	raw_spin_lock(&src_dsq->lock);
> +
> +	/*
> +	 * Did someone else get to it? @p could have already left $src_dsq, got
> +	 * re-enqueud, or be in the process of being consumed by someone else.
> +	 */
> +	if (unlikely(p->scx.dsq != src_dsq ||
> +		     u32_before(kit->dsq_seq, p->scx.dsq_seq) ||
> +		     p->scx.holding_cpu >= 0) ||
> +	    WARN_ON_ONCE(src_rq != task_rq(p))) {
> +		raw_spin_unlock(&src_dsq->lock);
> +		goto out;
> +	}
> +
> +	/* @p is still on $src_dsq and stable, determine the destination */
> +	dst_dsq = find_dsq_for_dispatch(this_rq, dsq_id, p);
> +
> +	if (dst_dsq->id == SCX_DSQ_LOCAL) {
> +		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> +		if (!task_can_run_on_remote_rq(p, dst_rq, true)) {
> +			dst_dsq = &scx_dsq_global;
> +			dst_rq = src_rq;
> +		}
> +	} else {
> +		/* no need to migrate if destination is a non-local DSQ */
> +		dst_rq = src_rq;
> +	}
> +
> +	/*
> +	 * Move @p into $dst_dsq. If $dst_dsq is the local DSQ of a different
> +	 * CPU, @p will be migrated.
> +	 */
> +	if (dst_dsq->id == SCX_DSQ_LOCAL) {
> +		/* @p is going from a non-local DSQ to a local DSQ */
> +		if (src_rq == dst_rq) {
> +			task_unlink_from_dsq(p, src_dsq);
> +			move_local_task_to_local_dsq(p, enq_flags,
> +						     src_dsq, dst_rq);
> +			raw_spin_unlock(&src_dsq->lock);
> +		} else {
> +			raw_spin_unlock(&src_dsq->lock);
> +			move_remote_task_to_local_dsq(p, enq_flags,
> +						      src_rq, dst_rq);
> +			locked_rq = dst_rq;
> +		}
> +	} else {
> +		/*
> +		 * @p is going from a non-local DSQ to a non-local DSQ. As
> +		 * $src_dsq is already locked, do an abbreviated dequeue.
> +		 */
> +		task_unlink_from_dsq(p, src_dsq);
> +		p->scx.dsq = NULL;
> +		raw_spin_unlock(&src_dsq->lock);
> +
> +		p->scx.dsq_vtime = vtime;

This would be like:

  if (vtime)
  	p->scx.dsq_vtime = vtime;

> +		dispatch_enqueue(dst_dsq, p, enq_flags);
> +	}
> +
> +	if (slice)
> +		p->scx.slice = slice;
> +	else
> +		p->scx.slice = p->scx.slice ?: 1;
> +
> +	dispatched = true;
> +out:
> +	if (in_balance) {
> +		if (this_rq != locked_rq) {
> +			raw_spin_rq_unlock(locked_rq);
> +			raw_spin_rq_lock(this_rq);
> +		}
> +	} else {
> +		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
> +	}
> +
> +	return dispatched;
> +}
> +
>  __bpf_kfunc_start_defs();
>  
>  /**
> @@ -5631,12 +5747,70 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
>  	}
>  }
>  
> +/**
> + * scx_bpf_dispatch_from_dsq - Move a task from DSQ iteration to a DSQ
> + * @it__iter: DSQ iterator in progress
> + * @p: task to transfer
> + * @dsq_id: DSQ to move @p to
> + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> + * @enq_flags: SCX_ENQ_*
> + *
> + * Transfer @p which is on the DSQ currently iterated by @it__iter to the DSQ
> + * specified by @dsq_id. All DSQs - local DSQs, global DSQ and user DSQs - can
> + * be the destination.
> + *
> + * For the transfer to be successful, @p must still be on the DSQ and have been
> + * queued before the DSQ iteration started. This function doesn't care whether
> + * @p was obtained from the DSQ iteration. @p just has to be on the DSQ and have
> + * been queued before the iteration started.
> + *
> + * Can be called from ops.dispatch() or any BPF context which doesn't hold a rq
> + * lock (e.g. BPF timers or SYSCALL programs).
> + *
> + * Returns %true if @p has been consumed, %false if @p had already been consumed
> + * or dequeued.
> + */
> +__bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
> +					   struct task_struct *p, u64 dsq_id,
> +					   u64 slice, u64 enq_flags)
> +{
> +	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
> +				     p, dsq_id, slice, 0, enq_flags);
> +}
> +
> +/**
> + * scx_bpf_dispatch_vtime_from_dsq - Move a task from DSQ iteration to a PRIQ DSQ
> + * @it__iter: DSQ iterator in progress
> + * @p: task to transfer
> + * @dsq_id: DSQ to move @p to
> + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> + * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> + * @enq_flags: SCX_ENQ_*

Hm... can we pass 6 arguments to a kfunc? I think we're limited to 5,
unless I'm missing something here.

> + *
> + * Transfer @p which is on the DSQ currently iterated by @it__iter to the
> + * priority queue of the DSQ specified by @dsq_id. The destination must be a
> + * user DSQ as only user DSQs support priority queue.
> + *
> + * All other aspects are identical to scx_bpf_dispatch_from_dsq(). See
> + * scx_bpf_dispatch_vtime() for more information on @vtime.
> + */
> +__bpf_kfunc bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter,
> +						 struct task_struct *p, u64 dsq_id,
> +						 u64 slice, u64 vtime, u64 enq_flags)
> +{
> +	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
> +				     p, dsq_id, slice, vtime,
> +				     enq_flags | SCX_ENQ_DSQ_PRIQ);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
>  BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
>  BTF_ID_FLAGS(func, scx_bpf_consume)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
>  
>  static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
> @@ -5733,6 +5907,8 @@ __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
>  BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
>  
>  static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 20280df62857..ef018071da31 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -35,6 +35,8 @@ void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vt
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  bool scx_bpf_consume(u64 dsq_id) __ksym;
> +bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> +bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
>  u32 scx_bpf_reenqueue_local(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
> @@ -62,6 +64,12 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
>  struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>  
> +/*
> + * Use the following as @it__iter when calling
> + * scx_bpf_dispatch[_vtime]_from_dsq() from within bpf_for_each() loops.
> + */
> +#define BPF_FOR_EACH_ITER	(&___it)
> +
>  static inline __attribute__((format(printf, 1, 2)))
>  void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
>  
> -- 
> 2.46.0
> 

-Andrea

