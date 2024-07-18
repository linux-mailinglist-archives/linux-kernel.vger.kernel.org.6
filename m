Return-Path: <linux-kernel+bounces-256786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF893702F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43433B21FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB514535E;
	Thu, 18 Jul 2024 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tCyFIP8K"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7920975808
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339058; cv=none; b=Er7geEaNMz//DBPVNDUZEOAFxTHpB9yCxPTe0/QeGFbbzwdn0B9sbnlSX0//nmp14KBH5jvCjomkonXCPJEIQdjSlOrHC3v1+mxWiEASZ+lbJNdt0uhlDn4HtWXx30ZztmtuHl/YYwV628lyXE5tdZz/SG227VGXO9nj6slqRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339058; c=relaxed/simple;
	bh=h+fAt05va5sYjEVQuomruqJ+9owh9FpKqBq/T/pNkYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM84xv+zO1M3uSmeJFG5gQcANwYMDuDC7tBHTv6u1iK+6SaeqSp6Ls9sKo8cKRbYBh9QMbTzWsa1kNYdoHhJy/cWEE1mQn0BsEmRZkVpeGecTYFj3LttSh+LLeos6Tp/8lAZEXV4QOXzGU+MsIwVf7lnt07DIuDGDgxF1z6oUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tCyFIP8K; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: pasha.tatashin@soleen.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721339054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vRcjS/iHB/YMBfjlrTFTUUEyvvd22iRJeaks2kJ4lCk=;
	b=tCyFIP8K2ww9uIxE7uIITgek9x/8XLOkaaN0OmLFwXXbwq6iwLKnzgteBd/+Xs/R4PbNCK
	zUaveYFIHq/XnTl7iFmnPuSMM0/VW7COuiMKKWqn4q3QdjYJ/eiS4g+XPLQCQdsEvaaoh5
	U3o/ixatn80HJmut1CJbxUcvCDL5Erk=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: jpoimboe@kernel.org
X-Envelope-To: peterz@infradead.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: surenb@google.com
X-Envelope-To: lizhijian@fujitsu.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: ziy@nvidia.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Date: Thu, 18 Jul 2024 17:44:12 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, peterz@infradead.org, 
	nphamcs@gmail.com, cerasuolodomenico@gmail.com, surenb@google.com, 
	lizhijian@fujitsu.com, willy@infradead.org, shakeel.butt@linux.dev, vbabka@suse.cz, 
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
Message-ID: <o3ovvnwhzulw4h7k5zmud46gyscigqx6uolksjdsx6vsvzchue@bwxesck7n357>
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 08:26:11PM GMT, Pasha Tatashin wrote:
> As part of the dynamic kernel stack project, we need to know the amount
> of data that can be saved by reducing the default kernel stack size [1].
> 
> Provide a kernel stack usage histogram to aid in optimizing kernel stack
> sizes and minimizing memory waste in large-scale environments. The
> histogram divides stack usage into power-of-two buckets and reports the
> results in /proc/vmstat. This information is especially valuable in
> environments with millions of machines, where even small optimizations
> can have a significant impact.
> 
> The histogram data is presented in /proc/vmstat with entries like
> "kstack_1k", "kstack_2k", and so on, indicating the number of threads
> that exited with stack usage falling within each respective bucket.
> 
> Example outputs:
> Intel:
> $ grep kstack /proc/vmstat
> kstack_1k 3
> kstack_2k 188
> kstack_4k 11391
> kstack_8k 243
> kstack_16k 0
> 
> ARM with 64K page_size:
> $ grep kstack /proc/vmstat
> kstack_1k 1
> kstack_2k 340
> kstack_4k 25212
> kstack_8k 1659
> kstack_16k 0
> kstack_32k 0
> kstack_64k 0
> 
> Note: once the dynamic kernel stack is implemented it will depend on the
> implementation the usability of this feature: On hardware that supports
> faults on kernel stacks, we will have other metrics that show the total
> number of pages allocated for stacks. On hardware where faults are not
> supported, we will most likely have some optimization where only some
> threads are extended, and for those, these metrics will still be very
> useful.
> 
> [1] https://lwn.net/Articles/974367

Nice and simple, and this gets us exactly the data we want for dynamic
kernel stacks...

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
> 
> Changelog:
> v4:
> - Expanded the commit message as requested by Andrew Morton.
> 
>  include/linux/sched/task_stack.h | 49 ++++++++++++++++++++++++++++++--
>  include/linux/vm_event_item.h    | 42 +++++++++++++++++++++++++++
>  include/linux/vmstat.h           | 16 -----------
>  mm/vmstat.c                      | 24 ++++++++++++++++
>  4 files changed, 113 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> index ccd72b978e1f..65e8c9fb7f9b 100644
> --- a/include/linux/sched/task_stack.h
> +++ b/include/linux/sched/task_stack.h
> @@ -95,9 +95,51 @@ static inline int object_is_on_stack(const void *obj)
>  extern void thread_stack_cache_init(void);
>  
>  #ifdef CONFIG_DEBUG_STACK_USAGE
> +#ifdef CONFIG_VM_EVENT_COUNTERS
> +#include <linux/vm_event_item.h>
> +
> +/* Count the maximum pages reached in kernel stacks */
> +static inline void kstack_histogram(unsigned long used_stack)
> +{
> +	if (used_stack <= 1024)
> +		this_cpu_inc(vm_event_states.event[KSTACK_1K]);
> +#if THREAD_SIZE > 1024
> +	else if (used_stack <= 2048)
> +		this_cpu_inc(vm_event_states.event[KSTACK_2K]);
> +#endif
> +#if THREAD_SIZE > 2048
> +	else if (used_stack <= 4096)
> +		this_cpu_inc(vm_event_states.event[KSTACK_4K]);
> +#endif
> +#if THREAD_SIZE > 4096
> +	else if (used_stack <= 8192)
> +		this_cpu_inc(vm_event_states.event[KSTACK_8K]);
> +#endif
> +#if THREAD_SIZE > 8192
> +	else if (used_stack <= 16384)
> +		this_cpu_inc(vm_event_states.event[KSTACK_16K]);
> +#endif
> +#if THREAD_SIZE > 16384
> +	else if (used_stack <= 32768)
> +		this_cpu_inc(vm_event_states.event[KSTACK_32K]);
> +#endif
> +#if THREAD_SIZE > 32768
> +	else if (used_stack <= 65536)
> +		this_cpu_inc(vm_event_states.event[KSTACK_64K]);
> +#endif
> +#if THREAD_SIZE > 65536
> +	else
> +		this_cpu_inc(vm_event_states.event[KSTACK_REST]);
> +#endif
> +}
> +#else /* !CONFIG_VM_EVENT_COUNTERS */
> +static inline void kstack_histogram(unsigned long used_stack) {}
> +#endif /* CONFIG_VM_EVENT_COUNTERS */
> +
>  static inline unsigned long stack_not_used(struct task_struct *p)
>  {
>  	unsigned long *n = end_of_stack(p);
> +	unsigned long unused_stack;
>  
>  	do { 	/* Skip over canary */
>  # ifdef CONFIG_STACK_GROWSUP
> @@ -108,10 +150,13 @@ static inline unsigned long stack_not_used(struct task_struct *p)
>  	} while (!*n);
>  
>  # ifdef CONFIG_STACK_GROWSUP
> -	return (unsigned long)end_of_stack(p) - (unsigned long)n;
> +	unused_stack = (unsigned long)end_of_stack(p) - (unsigned long)n;
>  # else
> -	return (unsigned long)n - (unsigned long)end_of_stack(p);
> +	unused_stack = (unsigned long)n - (unsigned long)end_of_stack(p);
>  # endif
> +	kstack_histogram(THREAD_SIZE - unused_stack);
> +
> +	return unused_stack;
>  }
>  #endif
>  extern void set_task_stack_end_magic(struct task_struct *tsk);
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 747943bc8cc2..73fa5fbf33a3 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -154,9 +154,51 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		VMA_LOCK_RETRY,
>  		VMA_LOCK_MISS,
>  #endif
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +		KSTACK_1K,
> +#if THREAD_SIZE > 1024
> +		KSTACK_2K,
> +#endif
> +#if THREAD_SIZE > 2048
> +		KSTACK_4K,
> +#endif
> +#if THREAD_SIZE > 4096
> +		KSTACK_8K,
> +#endif
> +#if THREAD_SIZE > 8192
> +		KSTACK_16K,
> +#endif
> +#if THREAD_SIZE > 16384
> +		KSTACK_32K,
> +#endif
> +#if THREAD_SIZE > 32768
> +		KSTACK_64K,
> +#endif
> +#if THREAD_SIZE > 65536
> +		KSTACK_REST,
> +#endif
> +#endif /* CONFIG_DEBUG_STACK_USAGE */
>  		NR_VM_EVENT_ITEMS
>  };
>  
> +#ifdef CONFIG_VM_EVENT_COUNTERS
> +/*
> + * Light weight per cpu counter implementation.
> + *
> + * Counters should only be incremented and no critical kernel component
> + * should rely on the counter values.
> + *
> + * Counters are handled completely inline. On many platforms the code
> + * generated will simply be the increment of a global address.
> + */
> +
> +struct vm_event_state {
> +	unsigned long event[NR_VM_EVENT_ITEMS];
> +};
> +
> +DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
> +#endif
> +
>  #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>  #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
>  #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 735eae6e272c..131966a4af78 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -41,22 +41,6 @@ enum writeback_stat_item {
>  };
>  
>  #ifdef CONFIG_VM_EVENT_COUNTERS
> -/*
> - * Light weight per cpu counter implementation.
> - *
> - * Counters should only be incremented and no critical kernel component
> - * should rely on the counter values.
> - *
> - * Counters are handled completely inline. On many platforms the code
> - * generated will simply be the increment of a global address.
> - */
> -
> -struct vm_event_state {
> -	unsigned long event[NR_VM_EVENT_ITEMS];
> -};
> -
> -DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
> -
>  /*
>   * vm counters are allowed to be racy. Use raw_cpu_ops to avoid the
>   * local_irq_disable overhead.
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 8507c497218b..642d761b557b 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1416,6 +1416,30 @@ const char * const vmstat_text[] = {
>  	"vma_lock_retry",
>  	"vma_lock_miss",
>  #endif
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +	"kstack_1k",
> +#if THREAD_SIZE > 1024
> +	"kstack_2k",
> +#endif
> +#if THREAD_SIZE > 2048
> +	"kstack_4k",
> +#endif
> +#if THREAD_SIZE > 4096
> +	"kstack_8k",
> +#endif
> +#if THREAD_SIZE > 8192
> +	"kstack_16k",
> +#endif
> +#if THREAD_SIZE > 16384
> +	"kstack_32k",
> +#endif
> +#if THREAD_SIZE > 32768
> +	"kstack_64k",
> +#endif
> +#if THREAD_SIZE > 65536
> +	"kstack_rest",
> +#endif
> +#endif
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  };
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
> -- 
> 2.45.2.1089.g2a221341d9-goog
> 

