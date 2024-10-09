Return-Path: <linux-kernel+bounces-356638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B47D199646E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A3DB27326
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE8188929;
	Wed,  9 Oct 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JfHeKI95"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83117CA0B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464877; cv=none; b=GjgnpqtM/2/pHpRAO2x8gt7fCU3zYaYWE2AHbuQ707G0cRYsIrqRGeeEt1JrMVy3qchoTKeCIeKAszCTNvP82eVYYlJvpKrzasW+mQNUOefyvfCb2zD7Gms5bwRimDO0O0WB1A+2VCFw72FB0vkO+yaHnKhE/CFNC787xo7ggvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464877; c=relaxed/simple;
	bh=lBJTqYIcr8gfKpTc7b/M7F6yByDHTB+1Nglekp6BiB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWkDqypIke11dwmQB9MBkZJw+2qqvlJwn6LZUqXZAeuch7qRwXRJKwVl1Ymb2W7srdP00QTvdLgBHoL975uKa+sdQa1EvT+1jSaI26Nl2ZhKW5pWULVJJTEMaF1uP0Zdb8yJw3kHRWoDDDDeXfntS+nX7q+htliV3QtXf3M+pu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JfHeKI95; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yb83TdEAZK3Y4e+tA9uNTlb3KAdepX71qz96F0IKK4Q=; b=JfHeKI95nCyAMqbz8n0F/ZYHzX
	nIy5CANwOxWT9sBnfcNmJ/V95bSHXFx49Z4W99o6ALsQaUVF4p6EgjAL3/O+RjQdZ75lyEB3Tqiok
	j2ljNEBfeozrL1iCuwGnEfABXnvWPfTDqOsl3TW46ciE8h0vhWRVby00A1++i9ZrWemwry3AsMSP4
	TGLkSiGcTABAU5Pmm389+ScaY5v8UtNX2hifFtbRctc1Kog9QtkH5maYSHUCllIqIiHd8ip8YoGbN
	JcximOCqBrEiWod9sCP4RKUyPV4XBWWUo27SkHJawqeCS91qHmt58uWaGQeou9Wn2gQ8ylucZclaB
	Hvr8ZTeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sySfY-00000004S2Z-3nkM;
	Wed, 09 Oct 2024 09:07:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DC6963004AF; Wed,  9 Oct 2024 11:07:44 +0200 (CEST)
Date: Wed, 9 Oct 2024 11:07:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v1 1/2] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
Message-ID: <20241009090744.GK17263@noisy.programming.kicks-ass.net>
References: <20241004004439.1673801-1-mathieu.desnoyers@efficios.com>
 <20241004004439.1673801-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004004439.1673801-2-mathieu.desnoyers@efficios.com>

On Thu, Oct 03, 2024 at 08:44:38PM -0400, Mathieu Desnoyers wrote:
> commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
> introduced a per-mm/cpu current concurrency id (mm_cid), which keeps
> a reference to the concurrency id allocated for each CPU. This reference
> expires shortly after a 100ms delay.
> 
> These per-CPU references keep the per-mm-cid data cache-local in
> situations where threads are running at least once on each CPU within
> each 100ms window, thus keeping the per-cpu reference alive.
> 
> However, intermittent workloads behaving in bursts spaced by more than
> 100ms on each CPU exhibit bad cache locality and degraded performance
> compared to purely per-cpu data indexing, because concurrency IDs are
> allocated over various CPUs and cores, therefore losing cache locality
> of the associated data.
> 
> Introduce the following changes to improve per-mm-cid cache locality:
> 
> - Add a "recent_cid" field to the per-mm/cpu mm_cid structure to keep
>   track of which mm_cid value was last used, and use it as a hint to
>   attempt re-allocating the same concurrency ID the next time this
>   mm/cpu needs to allocate a concurrency ID,
> 
> - Add a per-mm CPUs allowed mask, which keeps track of the union of
>   CPUs allowed for all threads belonging to this mm. This cpumask is
>   only set during the lifetime of the mm, never cleared, so it
>   represents the union of all the CPUs allowed since the beginning of
>   the mm lifetime. (note that the mm_cpumask() is really arch-specific
>   and tailored to the TLB flush needs, and is thus _not_ a viable
>   approach for this)

Because my morning juice came with an excessive dose of pedantry this
morning -- the previous and next item end with a comma due to this being
an enumeration; but this one has a full stop, suggesting the iteration
is at an end.

> - Add a per-mm nr_cpus_allowed to keep track of the weight of the
>   per-mm CPUs allowed mask (for fast access),
> 
> - Add a per-mm nr_cids_used to keep track of the highest concurrency
>   ID allocated for the mm. This is used for expanding the concurrency ID
>   allocation within the upper bound defined by:

The description and naming disagree -- while from vague memories they
end up being similar -- it is a stumbling block this morning. The
description seems to suggest this should be called max_cid or somesuch.

Also, is it actually used for anything? I found the tracking code in
__mm_cid_try_get(), but it's not actually doing anything?

>     min(mm->nr_cpus_allowed, mm->mm_users)
> 
>   When the next unused CID value reaches this threshold, stop trying
>   to expand the cid allocation and use the first available cid value
>   instead.
> 
> Spreading allocation to use all the cid values within the range
> 
>   [ 0, min(mm->nr_cpus_allowed, mm->mm_users) - 1 ]
> 
> improves cache locality while preserving mm_cid compactness within the
> expected user limits.

This paragraph seems to rudely interrupt the iteration ? Or is (Fred)
Colon gone missing again to start a new iteration?

(Damn, and now I need me a Nobby reference somehow)

Anyway, I have vague memories I strongly suggested keeping the CID space
dense at some point :-)

> - In __mm_cid_try_get, only return cid values within the range
>   [ 0, mm->nr_cpus_allowed ] rather than [ 0, nr_cpu_ids ]. This
>   prevents allocating cids above the number of allowed cpus in
>   rare scenarios where cid allocation races with a concurrent
>   remote-clear of the per-mm/cpu cid. This improvement is made
>   possible by the addition of the per-mm CPUs allowed mask.

and no comma to continue the iteration.

> - In sched_mm_cid_migrate_to, use mm->nr_cpus_allowed rather than
>   t->nr_cpus_allowed. This criterion was really meant to compare
>   the number of mm->mm_users to the number of CPUs allowed for the
>   entire mm. Therefore, the prior comparison worked fine when all
>   threads shared the same CPUs allowed mask, but not so much in
>   scenarios where those threads have different masks (e.g. each
>   thread pinned to a single CPU). This improvement is made
>   possible by the addition of the per-mm CPUs allowed mask.
> 

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6e3bdf8e38bc..8b5a185b4d5a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -782,6 +782,7 @@ struct vm_area_struct {
>  struct mm_cid {
>  	u64 time;
>  	int cid;
> +	int recent_cid;
>  };
>  #endif
>  
> @@ -852,6 +853,27 @@ struct mm_struct {
>  		 * When the next mm_cid scan is due (in jiffies).
>  		 */
>  		unsigned long mm_cid_next_scan;
> +		/**
> +		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
> +		 *
> +		 * Number of CPUs allowed in the union of all mm's
> +		 * threads allowed CPUs.
> +		 */
> +		atomic_t nr_cpus_allowed;
> +		/**
> +		 * @nr_cids_used: Number of used concurrency IDs.
> +		 *
> +		 * Track the highest concurrency ID allocated for the
> +		 * mm: nr_cids_used - 1.
> +		 */
> +		atomic_t nr_cids_used;
> +		/**
> +		 * @cpus_allowed_lock: Lock protecting mm cpus_allowed.
> +		 *
> +		 * Provide mutual exclusion for mm cpus_allowed and
> +		 * mm nr_cpus_allowed updates.

If nr_cpus_allowed update is serialized by this here thing, why is it an
atomic_t? A quick search seems to suggest you're only using atomic_set()
/ atomic_read() on it, which is a big fat clue it shouldn't be atomic_t.

Am I missing something?

> +		 */
> +		spinlock_t cpus_allowed_lock;
>  #endif
>  #ifdef CONFIG_MMU
>  		atomic_long_t pgtables_bytes;	/* size of all page tables */
> @@ -1170,18 +1192,30 @@ static inline int mm_cid_clear_lazy_put(int cid)
>  	return cid & ~MM_CID_LAZY_PUT;
>  }
>  
> +/*
> + * mm_cpus_allowed: Union of all mm's threads allowed CPUs.
> + */
> +static inline cpumask_t *mm_cpus_allowed(struct mm_struct *mm)
> +{
> +	unsigned long bitmap = (unsigned long)mm;
> +
> +	bitmap += offsetof(struct mm_struct, cpu_bitmap);
> +	/* Skip cpu_bitmap */
> +	bitmap += cpumask_size();
> +	return (struct cpumask *)bitmap;
> +}
> +
>  /* Accessor for struct mm_struct's cidmask. */
>  static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
>  {
> -	unsigned long cid_bitmap = (unsigned long)mm;
> +	unsigned long cid_bitmap = (unsigned long)mm_cpus_allowed(mm);
>  
> -	cid_bitmap += offsetof(struct mm_struct, cpu_bitmap);
> -	/* Skip cpu_bitmap */
> +	/* Skip mm_cpus_allowed */
>  	cid_bitmap += cpumask_size();
>  	return (struct cpumask *)cid_bitmap;
>  }
>  
> -static inline void mm_init_cid(struct mm_struct *mm)
> +static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
>  {
>  	int i;
>  
> @@ -1189,17 +1223,22 @@ static inline void mm_init_cid(struct mm_struct *mm)
>  		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
>  
>  		pcpu_cid->cid = MM_CID_UNSET;
> +		pcpu_cid->recent_cid = MM_CID_UNSET;
>  		pcpu_cid->time = 0;
>  	}
> +	atomic_set(&mm->nr_cpus_allowed, p->nr_cpus_allowed);
> +	atomic_set(&mm->nr_cids_used, 0);
> +	spin_lock_init(&mm->cpus_allowed_lock);
> +	cpumask_copy(mm_cpus_allowed(mm), p->cpus_ptr);

Should that not be using p->cpus_mask ? I mean, it is unlikely this code
is ran during migrate_disable(), but just in case that ever does do
happen, we'll be getting a spurious single CPU mask.

>  	cpumask_clear(mm_cidmask(mm));
>  }
>  
> -static inline int mm_alloc_cid_noprof(struct mm_struct *mm)
> +static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
>  {
>  	mm->pcpu_cid = alloc_percpu_noprof(struct mm_cid);
>  	if (!mm->pcpu_cid)
>  		return -ENOMEM;
> -	mm_init_cid(mm);
> +	mm_init_cid(mm, p);
>  	return 0;
>  }
>  #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
> @@ -1212,16 +1251,31 @@ static inline void mm_destroy_cid(struct mm_struct *mm)
>  
>  static inline unsigned int mm_cid_size(void)
>  {
> -	return cpumask_size();
> +	return 2 * cpumask_size();	/* mm_cpus_allowed(), mm_cidmask(). */
> +}
> +
> +static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask)
> +{
> +	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
> +
> +	if (!mm)
> +		return;
> +	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
> +	spin_lock(&mm->cpus_allowed_lock);
> +	cpumask_or(mm_allowed, mm_allowed, cpumask);
> +	atomic_set(&mm->nr_cpus_allowed, cpumask_weight(mm_allowed));
> +	spin_unlock(&mm->cpus_allowed_lock);

We're having a problem here, you call this from __do_set_cpus_allowed(),
which is holding rq->lock, which is a raw_spinlock_t.

>  }
>  #else /* CONFIG_SCHED_MM_CID */
> -static inline void mm_init_cid(struct mm_struct *mm) { }
> -static inline int mm_alloc_cid(struct mm_struct *mm) { return 0; }
> +static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
> +static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
>  static inline void mm_destroy_cid(struct mm_struct *mm) { }
> +
>  static inline unsigned int mm_cid_size(void)
>  {
>  	return 0;
>  }
> +static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
>  #endif /* CONFIG_SCHED_MM_CID */
>  
>  struct mmu_gather;

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..772a3daf784a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2691,6 +2691,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
>  		put_prev_task(rq, p);
>  
>  	p->sched_class->set_cpus_allowed(p, ctx);
> +	mm_set_cpus_allowed(p->mm, ctx->new_mask);

This here, is with p->pi_lock and rq->lock held -- both are
raw_spinlock_t.

>  
>  	if (queued)
>  		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);

