Return-Path: <linux-kernel+bounces-313635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A896A7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC401F2525F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491C13F43E;
	Tue,  3 Sep 2024 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaDl60DU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E31DC72A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393548; cv=none; b=DuD7Vr1FrwzTNhyt/dZN426bq+mTnXKxu+Mmcr+0rqQTCpPCz6XxVBV7AbpPrPh28jBVSkBX7j9R0qw73DBJPQXvJzz/G9kjMIAgu6iQQPjsSqM7V7Bkma15kRHzpG2IFzG+hZadHJXZWPQAdxXVN1xgolghqbKcuA5bRIGIQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393548; c=relaxed/simple;
	bh=SWS43ytibqyk41k0DMhFyh2/LHalHJGptuRrlFp25pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0M26MpVJtU4n34LwHO0EuSPUSLdn56KOyx7bMcBrM371JdCLtxK2QH8jJTMpKAL2wv7LHSbsmDCxCO40Yq0wGbRlIVDwZyfV8JvWygHIB5TOrevj3QBZ5cLpPEV7lR0WKekjPXn+MHI97qjmscv/nujA5cl1/5atQkKBvFWMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaDl60DU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-715c160e231so4839189b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725393546; x=1725998346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0AreJmzscfuZeXQZD/Xl/m4d/xRg6mf8fencq62gVY=;
        b=DaDl60DUqQDy7eHpYtpxNEgV7iP8nVZwUYptJtU7Nxop6jN/PWi/3tMhqePyjRLeBA
         vVN4yBZJttkExLIz7eWU4na49AJWRdHbs4vGWLTTrhrjGvEhgsr5AgltLBNJSQbylOQD
         AX+ZuNXbNJwJ9RB/HFS7O6nkR+aj/0vT5UXuCctijC8Mlk1Pad33YZY+EScAGZ4ZvTHI
         ywsKPFvtr4B5orQ13GlVTkGIKN8d0B6VA2QTGIsYXfmGJ8XSj3fn9v4Ieh+MnmutWJBZ
         3yO2lwPC8Q9ouH0cHy+S12Y9jvbSpavELH/4q4gRn01n03lzmTBQi0uYl1TG8DkZq9r8
         22qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725393546; x=1725998346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0AreJmzscfuZeXQZD/Xl/m4d/xRg6mf8fencq62gVY=;
        b=MhDd+MZX50rna/cOvgsVMtVyDSLbDhUziMfPXbRasqKlGbmGsGl0ymNg2EjkmNb0ib
         1HZQIm1l7KgE62nhK0tbTDHryAW80j76agx0+tnncpTLHhAV2i7Wh8zh7rhFtpNCjScU
         Dz2xx6t8v3Sf9w96JInNf42483DTXMYYL3xcrkmTBcIvoBu4bT5U+4/IGLH0Kkn3Zkog
         5GQr+RVB2XidoY37GPBrzzzpnPCQd5KBS4TeOMZee3AVCs8AbwsE4T1YAgbsCyV5IEJt
         W/2P17a2Q1WE2dY/tkBwgi9cXxSFAGkjrpEojyCJgQa/QGuphdIwXf/YmWDf0XiDJwAq
         vflA==
X-Forwarded-Encrypted: i=1; AJvYcCVkVfWDhOqEmB63DJ3cZoxKsvdOljBhEQkw83ucSqNKhfBZIxNzRk2nBTdrTBmD0qjmaX91odQyYwICBWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4qs9+o9CXPH0IjxqfR1RdubDviWXa7GWxLErLuNJ2F/FKC2U
	Kr1uaj/L3Occ+rNquyMGX+87jC+8BPwIJjvg+EuRcCEmD/gsw9v5
X-Google-Smtp-Source: AGHT+IEBQxYbrMBqjddFBmK+izRTWSlnDIHsVYcmYc+M+sXLGS8PS4rsxTme7qOj+rCt50uhPMOOcg==
X-Received: by 2002:a05:6a00:94a5:b0:710:4d4b:1af with SMTP id d2e1a72fcca58-715dfbdf8f2mr19209719b3a.7.1725393545591;
        Tue, 03 Sep 2024 12:59:05 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785a6ea6sm247551b3a.184.2024.09.03.12.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:59:04 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:59:02 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH 2/2] sched: Improve cache locality of RSEQ
 concurrency IDs for intermittent workloads
Message-ID: <ZtdqhmKmbVsCSAkJ@yury-ThinkPad>
References: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
 <20240903190650.53644-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903190650.53644-3-mathieu.desnoyers@efficios.com>

On Tue, Sep 03, 2024 at 03:06:50PM -0400, Mathieu Desnoyers wrote:
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
> 
> - Add a per-mm nr_cpus_allowed to keep track of the weight of the
>   per-mm CPUs allowed mask (for fast access),
> 
> - Add a per-mm nr_cids_used to keep track of the highest concurrency
>   ID allocated for the mm. This is used for expanding the concurrency ID
>   allocation within the upper bound defined by:
> 
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
> 
> - In __mm_cid_try_get, only return cid values within the range
>   [ 0, mm->nr_cpus_allowed ] rather than [ 0, nr_cpu_ids ]. This
>   prevents allocating cids above the number of allowed cpus in
>   rare scenarios where cid allocation races with a concurrent
>   remote-clear of the per-mm/cpu cid. This improvement is made
>   possible by the addition of the per-mm CPUs allowed mask.
> 
> - In sched_mm_cid_migrate_to, use mm->nr_cpus_allowed rather than
>   t->nr_cpus_allowed. This criterion was really meant to compare
>   the number of mm->mm_users to the number of CPUs allowed for the
>   entire mm. Therefore, the prior comparison worked fine when all
>   threads shared the same CPUs allowed mask, but not so much in
>   scenarios where those threads have different masks (e.g. each
>   thread pinned to a single CPU). This improvement is made
>   possible by the addition of the per-mm CPUs allowed mask.
> 
> * Benchmarks
> 
> Each thread increments 16kB worth of 8-bit integers in bursts, with
> a configurable delay between each thread's execution. Each thread run
> one after the other (no threads run concurrently). The order of
> thread execution in the sequence is random. The thread execution
> sequence begins again after all threads have executed. The 16kB areas
> are allocated with rseq_mempool and indexed by either cpu_id, mm_cid
> (not cache-local), or cache-local mm_cid. Each thread is pinned to its
> own core.
> 
> Testing configurations:
> 
> 8-core/1-L3:        Use 8 cores within a single L3
> 24-core/24-L3:      Use 24 cores, 1 core per L3
> 192-core/24-L3:     Use 192 cores (all cores in the system)
> 384-thread/24-L3:   Use 384 HW threads (all HW threads in the system)
> 
> Intermittent workload delays between threads: 200ms, 10ms.
> 
> Hardware:
> 
> CPU(s):                   384
>   On-line CPU(s) list:    0-383
> Vendor ID:                AuthenticAMD
>   Model name:             AMD EPYC 9654 96-Core Processor
>     Thread(s) per core:   2
>     Core(s) per socket:   96
>     Socket(s):            2
> Caches (sum of all):
>   L1d:                    6 MiB (192 instances)
>   L1i:                    6 MiB (192 instances)
>   L2:                     192 MiB (192 instances)
>   L3:                     768 MiB (24 instances)
> 
> Each result is an average of 5 test runs. The cache-local speedup
> is calculated as: (cache-local mm_cid) / (mm_cid).
> 
> Intermittent workload delay: 200ms
> 
>                      per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
>                          (ns)      (ns)                  (ns)
> 8-core/1-L3             1374      19289                  1336            14.4x
> 24-core/24-L3           2423      26721                  1594            16.7x
> 192-core/24-L3          2291      15826                  2153             7.3x
> 384-thread/24-L3        1874      13234                  1907             6.9x
> 
> Intermittent workload delay: 10ms
> 
>                      per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
>                          (ns)      (ns)                  (ns)
> 8-core/1-L3               662       756                   686             1.1x
> 24-core/24-L3            1378      3648                  1035             3.5x
> 192-core/24-L3           1439     10833                  1482             7.3x
> 384-thread/24-L3         1503     10570                  1556             6.8x
> 
> [ This deprecates the prior "sched: NUMA-aware per-memory-map concurrency IDs"
>   patch series with a simpler and more general approach. ]
> 
> Link: https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> ---
>  fs/exec.c                |  2 +-
>  include/linux/mm_types.h | 66 ++++++++++++++++++++++++++++++++++------
>  kernel/fork.c            |  2 +-
>  kernel/sched/core.c      |  7 +++--
>  kernel/sched/sched.h     | 47 +++++++++++++++++++---------
>  5 files changed, 97 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 0c17e59e3767..7e73b0fc1305 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1039,7 +1039,7 @@ static int exec_mmap(struct mm_struct *mm)
>  	active_mm = tsk->active_mm;
>  	tsk->active_mm = mm;
>  	tsk->mm = mm;
> -	mm_init_cid(mm);
> +	mm_init_cid(mm, tsk);
>  	/*
>  	 * This prevents preemption while active_mm is being loaded and
>  	 * it and mm are being updated, which could cause problems for
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index af3a0256fa93..7d63d27862e4 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -755,6 +755,7 @@ struct vm_area_struct {
>  struct mm_cid {
>  	u64 time;
>  	int cid;
> +	int recent_cid;
>  };
>  #endif
>  
> @@ -825,6 +826,20 @@ struct mm_struct {
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
>  #endif
>  #ifdef CONFIG_MMU
>  		atomic_long_t pgtables_bytes;	/* size of all page tables */
> @@ -1143,18 +1158,30 @@ static inline int mm_cid_clear_lazy_put(int cid)
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
> @@ -1162,17 +1189,21 @@ static inline void mm_init_cid(struct mm_struct *mm)
>  		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
>  
>  		pcpu_cid->cid = MM_CID_UNSET;
> +		pcpu_cid->recent_cid = MM_CID_UNSET;
>  		pcpu_cid->time = 0;
>  	}
> +	atomic_set(&mm->nr_cpus_allowed, p->nr_cpus_allowed);
> +	atomic_set(&mm->nr_cids_used, 0);
> +	cpumask_copy(mm_cpus_allowed(mm), p->cpus_ptr);
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
> @@ -1185,16 +1216,33 @@ static inline void mm_destroy_cid(struct mm_struct *mm)
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
> +	int cpu, nr_set = 0;
> +
> +	if (!mm)
> +		return;
> +	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
> +	for (cpu = 0; cpu < nr_cpu_ids; cpu = cpumask_next_andnot(cpu, cpumask, mm_allowed)) {
> +		if (!cpumask_test_and_set_cpu(cpu, mm_allowed))
> +			nr_set++;
> +	}

You can do the same nicer:

  for_each_cpu(cpu, cpumask)
  	nr_set += !cpumask_test_and_set_cpu(cpu, mm_allowed);

This should be faster and a bit simpler, to me.

What concerns me is that you call atomic function in a loop, which makes
the whole procedure non-atomic. If it's OK, can you put a comment why a
series of atomic ops is OK here? If not - I believe external locking
would be needed.

Thanks,
Yury

> +	atomic_add(nr_set, &mm->nr_cpus_allowed);
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
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 99076dbe27d8..b44f545ad82c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1298,7 +1298,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	if (init_new_context(p, mm))
>  		goto fail_nocontext;
>  
> -	if (mm_alloc_cid(mm))
> +	if (mm_alloc_cid(mm, p))
>  		goto fail_cid;
>  
>  	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3e84a3b7b7bb..3243e9abfefb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2784,6 +2784,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
>  		put_prev_task(rq, p);
>  
>  	p->sched_class->set_cpus_allowed(p, ctx);
> +	mm_set_cpus_allowed(p->mm, ctx->new_mask);
>  
>  	if (queued)
>  		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
> @@ -11784,6 +11785,7 @@ int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
>  	 */
>  	if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
>  		return -1;
> +	WRITE_ONCE(src_pcpu_cid->recent_cid, MM_CID_UNSET);
>  	return src_cid;
>  }
>  
> @@ -11825,7 +11827,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
>  	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
>  	dst_cid = READ_ONCE(dst_pcpu_cid->cid);
>  	if (!mm_cid_is_unset(dst_cid) &&
> -	    atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
> +	    atomic_read(&mm->mm_users) >= atomic_read(&mm->nr_cpus_allowed))
>  		return;
>  	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, src_cpu);
>  	src_rq = cpu_rq(src_cpu);
> @@ -11843,6 +11845,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
>  	/* Move src_cid to dst cpu. */
>  	mm_cid_snapshot_time(dst_rq, mm);
>  	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
> +	WRITE_ONCE(dst_pcpu_cid->recent_cid, src_cid);
>  }
>  
>  static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_cid,
> @@ -12079,7 +12082,7 @@ void sched_mm_cid_after_execve(struct task_struct *t)
>  		 * Matches barrier in sched_mm_cid_remote_clear_old().
>  		 */
>  		smp_mb();
> -		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
> +		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, t, mm);
>  	}
>  	rseq_set_notify_resume(t);
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 38aeedd8a6cc..4d11dbd5847b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3311,24 +3311,40 @@ static inline void mm_cid_put(struct mm_struct *mm)
>  	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
>  }
>  
> -static inline int __mm_cid_try_get(struct mm_struct *mm)
> +static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
>  {
> -	struct cpumask *cpumask;
> -	int cid;
> +	struct cpumask *cidmask = mm_cidmask(mm);
> +	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> +	int cid = __this_cpu_read(pcpu_cid->recent_cid);
>  
> -	cpumask = mm_cidmask(mm);
> +	/* Try to re-use recent cid. This improves cache locality. */
> +	if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid, cidmask))
> +		return cid;
> +	/*
> +	 * Expand cid allocation if used cids are below the number cpus
> +	 * allowed and number of threads. Expanding cid allocation as
> +	 * much as possible improves cache locality.
> +	 */
> +	cid = atomic_read(&mm->nr_cids_used);
> +	while (cid < atomic_read(&mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
> +		if (!atomic_try_cmpxchg(&mm->nr_cids_used, &cid, cid + 1))
> +			continue;
> +		if (!cpumask_test_and_set_cpu(cid, cidmask))
> +			return cid;
> +	}
>  	/*
> +	 * Find the first available concurrency id.
>  	 * Retry finding first zero bit if the mask is temporarily
>  	 * filled. This only happens during concurrent remote-clear
>  	 * which owns a cid without holding a rq lock.
>  	 */
>  	for (;;) {
> -		cid = cpumask_first_zero(cpumask);
> -		if (cid < nr_cpu_ids)
> +		cid = cpumask_first_zero(cidmask);
> +		if (cid < atomic_read(&mm->nr_cpus_allowed))
>  			break;
>  		cpu_relax();
>  	}
> -	if (cpumask_test_and_set_cpu(cid, cpumask))
> +	if (cpumask_test_and_set_cpu(cid, cidmask))
>  		return -1;
>  	return cid;
>  }
> @@ -3345,7 +3361,8 @@ static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
>  	WRITE_ONCE(pcpu_cid->time, rq->clock);
>  }
>  
> -static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
> +static inline int __mm_cid_get(struct rq *rq, struct task_struct *t,
> +			       struct mm_struct *mm)
>  {
>  	int cid;
>  
> @@ -3355,13 +3372,13 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
>  	 * guarantee forward progress.
>  	 */
>  	if (!READ_ONCE(use_cid_lock)) {
> -		cid = __mm_cid_try_get(mm);
> +		cid = __mm_cid_try_get(t, mm);
>  		if (cid >= 0)
>  			goto end;
>  		raw_spin_lock(&cid_lock);
>  	} else {
>  		raw_spin_lock(&cid_lock);
> -		cid = __mm_cid_try_get(mm);
> +		cid = __mm_cid_try_get(t, mm);
>  		if (cid >= 0)
>  			goto unlock;
>  	}
> @@ -3381,7 +3398,7 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
>  	 * all newcoming allocations observe the use_cid_lock flag set.
>  	 */
>  	do {
> -		cid = __mm_cid_try_get(mm);
> +		cid = __mm_cid_try_get(t, mm);
>  		cpu_relax();
>  	} while (cid < 0);
>  	/*
> @@ -3397,7 +3414,8 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
>  	return cid;
>  }
>  
> -static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
> +static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
> +			     struct mm_struct *mm)
>  {
>  	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
>  	struct cpumask *cpumask;
> @@ -3414,8 +3432,9 @@ static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
>  		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
>  			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
>  	}
> -	cid = __mm_cid_get(rq, mm);
> +	cid = __mm_cid_get(rq, t, mm);
>  	__this_cpu_write(pcpu_cid->cid, cid);
> +	__this_cpu_write(pcpu_cid->recent_cid, cid);
>  	return cid;
>  }
>  
> @@ -3467,7 +3486,7 @@ static inline void switch_mm_cid(struct rq *rq,
>  		prev->mm_cid = -1;
>  	}
>  	if (next->mm_cid_active)
> -		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
> +		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
>  }
>  
>  #else
> -- 
> 2.39.2

