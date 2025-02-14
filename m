Return-Path: <linux-kernel+bounces-515589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66016A36684
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3D81633DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2951C84C5;
	Fri, 14 Feb 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dcau+ilY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7E1C84AF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562783; cv=none; b=DuWtSlXkxJZ5FuBCjE0wIqYexN10Zzo9StQVnN+Dku+r5j2sG14FwEJWxTHWwZN39TCS5jv8saw6vFto2OnidyRhFfZmtTG9NqeRfkwC6Kk+VP0nnQFXWFjHFzIWIIo7nZFplzb8rB++XnDI0F48pflZRBVcpLNUymrU8yq5fXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562783; c=relaxed/simple;
	bh=hl4noWkGJ1twVbnY/RbvDunmTwmDVgqQvvcFWPyqAO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzaIC93fty0perhWIKST8TvWMFlJz1XGqVox5+Q2cjIXs/6HftrZgQFy94hE7Vd1xG/qr3JaIl13eZ4PtenPSZVJiIT0bATHGavRHwh4rb37zgUp78iqO+QA8HsB3BCvZaL7j/xiC9IYddKJxyUMwhACLvcnJMADVpFfABHVmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dcau+ilY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739562782; x=1771098782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hl4noWkGJ1twVbnY/RbvDunmTwmDVgqQvvcFWPyqAO4=;
  b=Dcau+ilYxV4fX9vpeV2iQXKWiHrFmy83YdCz39RzFtKv9mcBoo/wjpGi
   D6ocIs93rpSDRoRzy5RCB1RD5xqC8HVXexmRU/tDKhJuLLiBrsSipGIsQ
   w7n3Xy43hsR5WE3MK+cqBlsKH/lJL1x33VgEyBb1G95/aA9p2yqG06/hh
   mMofcXwdLrog/Pq/7EMpP1vzF1jlPjVNP8MidPWr8AF54oWk6a78GKWiB
   i62BItOVNg8lp4BsBWEa57ClFNwu01Z95y7lrzIf36IqTVQ7AFDqRU/3b
   8cYiB96IW+LH592Cv4FqoYB0GxUoY92MiBWS3Oq7QQgtreGJWc+zVgi/b
   A==;
X-CSE-ConnectionGUID: 7YUMrLaPSQiqnkwAFY67Lg==
X-CSE-MsgGUID: kzA8uwQ4RMSQ8PGI1zGpTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40182563"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40182563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:53:01 -0800
X-CSE-ConnectionGUID: zwLfM8OhRRq5IWdtY2ghhA==
X-CSE-MsgGUID: VkoMZ43+RDWoQDgRXWZhjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113510011"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.21]) ([10.125.109.21])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:53:00 -0800
Message-ID: <b067a9fc-ff5f-4baa-a1ff-3fa749ae4d44@intel.com>
Date: Fri, 14 Feb 2025 11:53:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/12] x86/mm: enable broadcast TLB invalidation for
 multi-threaded processes
To: Rik van Riel <riel@surriel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali Shukla <Manali.Shukla@amd.com>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-10-riel@surriel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250213161423.449435-10-riel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 08:14, Rik van Riel wrote:
> Use broadcast TLB invalidation, using the INVPLGB instruction, on AMD EPYC 3
> and newer CPUs.

Could we please just zap the "on AMD EPYC 3 and newer CPUs" from all of
these patches? It can be mentioned once in the cover letter or
something, but it doesn't need to be repeated.

> In order to not exhaust PCID space, and keep TLB flushes local for single
> threaded processes, we only hand out broadcast ASIDs to processes active on
> 4 or more CPUs.

Please no "we's". Use imperative voice. This also needs some fleshing
out. Perhaps:

	There is not enough room in the 12-bit ASID address space to
	hand out broadcast ASIDs to every process. Only hand out
	broadcast ASIDs to processes when they are observed to be
	simultaneously running on 4 or more CPUs.

	Most importantly, this ensures that single threaded processes
	continue to use the cheaper, legacy, local TLB invalidation
	instructions like INVLPG.

> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
> +	u16 global_asid;
> +	bool asid_transition;
> +#endif
> +
>  } mm_context_t;

Please give these at least a line or two comment explaining what they do.

>  #define INIT_MM_CONTEXT(mm)						\
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 795fdd53bd0a..d670699d32c2 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -139,6 +139,8 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
>  #define enter_lazy_tlb enter_lazy_tlb
>  extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
>  
> +extern void destroy_context_free_global_asid(struct mm_struct *mm);
> +
>  /*
>   * Init a new mm.  Used on mm copies, like at fork()
>   * and on mm's that are brand-new, like at execve().
> @@ -161,6 +163,14 @@ static inline int init_new_context(struct task_struct *tsk,
>  		mm->context.execute_only_pkey = -1;
>  	}
>  #endif
> +
> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
> +	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
> +		mm->context.global_asid = 0;
> +		mm->context.asid_transition = false;
> +	}
> +#endif
> +
>  	mm_reset_untag_mask(mm);
>  	init_new_context_ldt(mm);
>  	return 0;
> @@ -170,6 +180,10 @@ static inline int init_new_context(struct task_struct *tsk,
>  static inline void destroy_context(struct mm_struct *mm)
>  {
>  	destroy_context_ldt(mm);
> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
> +	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
> +		destroy_context_free_global_asid(mm);
> +#endif
>  }
>  
>  extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index bda7080dec83..3080cb8d21dc 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -6,6 +6,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/sched.h>
>  
> +#include <asm/barrier.h>
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
>  #include <asm/special_insns.h>
> @@ -239,6 +240,78 @@ void flush_tlb_one_kernel(unsigned long addr);
>  void flush_tlb_multi(const struct cpumask *cpumask,
>  		      const struct flush_tlb_info *info);
>  
> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
> +static inline bool is_dyn_asid(u16 asid)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
> +		return true;
> +
> +	return asid < TLB_NR_DYN_ASIDS;
> +}

If possible, could you avoid double-defining the helpers that will
compile with and without CONFIG_X86_BROADCAST_TLB_FLUSH? Just put the
#ifdef around the ones that *need* it.

...
> +static inline bool in_asid_transition(struct mm_struct *mm)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
> +		return false;
> +
> +	return mm && READ_ONCE(mm->context.asid_transition);
> +}
> +
> +static inline u16 mm_global_asid(struct mm_struct *mm)
> +{
> +	u16 asid;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
> +		return 0;
> +
> +	asid = smp_load_acquire(&mm->context.global_asid);
> +
> +	/* mm->context.global_asid is either 0, or a global ASID */
> +	VM_WARN_ON_ONCE(asid && is_dyn_asid(asid));
> +
> +	return asid;
> +}

Yay, some kind of custom lock. :)

Could give us a little idea what the locking rules are here and why this
neds the READ_ONCE() and smp_load_acquire()?

...
> +	/*
> +	 * TLB consistency for global ASIDs is maintained with broadcast TLB
> +	 * flushing. The TLB is never outdated, and does not need flushing.
> +	 */

This is another case where I think using the word "broadcast" is not
helping.

Here's the problem: INVLPGB is a "INVLPG" that's broadcast. So the name
INVLPGB is fine. INVLPGB is *a* way to broadcast INVLPG which is *a*
kind of TLB invalidation.

But, to me "broadcast TLB flushing" is a broad term. In arguably
includes INVLPGB and normal IPI-based flushing. Just like the function
naming in the earlier patch, I think we need a better term here.

> +	if (static_cpu_has(X86_FEATURE_INVLPGB)) {
> +		u16 global_asid = mm_global_asid(next);
> +
> +		if (global_asid) {
> +			*new_asid = global_asid;
> +			*need_flush = false;
> +			return;
> +		}
> +	}



> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH

How cleanly could we throw this hunk in a new file? I always dislike big
#ifdefs like this. They seem like magnets for causing weird compile
problems.

> +/*
> + * Logic for broadcast TLB invalidation.
> + */
> +static DEFINE_RAW_SPINLOCK(global_asid_lock);

The global lock definitely needs some discussion in the changelog.

> +static u16 last_global_asid = MAX_ASID_AVAILABLE;
> +static DECLARE_BITMAP(global_asid_used, MAX_ASID_AVAILABLE) = { 0 };
> +static DECLARE_BITMAP(global_asid_freed, MAX_ASID_AVAILABLE) = { 0 };

Isn't the initialization to all 0's superfluous for a global variable?

> +static int global_asid_available = MAX_ASID_AVAILABLE - TLB_NR_DYN_ASIDS - 1;
> +
> +static void reset_global_asid_space(void)
> +{
> +	lockdep_assert_held(&global_asid_lock);
> +
> +	/*
> +	 * A global TLB flush guarantees that any stale entries from
> +	 * previously freed global ASIDs get flushed from the TLB
> +	 * everywhere, making these global ASIDs safe to reuse.
> +	 */
> +	invlpgb_flush_all_nonglobals();

Ugh, my suggestion to use the term "global ASID" really doesn't work
here, does it?

Also, isn't a invlpgb_flush_all_nonglobals() _relatively_ slow? It has
to go out and talk over the fabric to every CPU, right? This is also
holding a global lock.

That's seems worrisome.

> +	/*
> +	 * Clear all the previously freed global ASIDs from the
> +	 * broadcast_asid_used bitmap, now that the global TLB flush
> +	 * has made them actually available for re-use.
> +	 */
> +	bitmap_andnot(global_asid_used, global_asid_used,
> +			global_asid_freed, MAX_ASID_AVAILABLE);
> +	bitmap_clear(global_asid_freed, 0, MAX_ASID_AVAILABLE);
> +
> +	/*
> +	 * ASIDs 0-TLB_NR_DYN_ASIDS are used for CPU-local ASID
> +	 * assignments, for tasks doing IPI based TLB shootdowns.
> +	 * Restart the search from the start of the global ASID space.
> +	 */
> +	last_global_asid = TLB_NR_DYN_ASIDS;
> +}
> +
> +static u16 get_global_asid(void)
> +{
> +
> +	u16 asid;
> +
> +	lockdep_assert_held(&global_asid_lock);
> +
> +	/* The previous allocated ASID is at the top of the address space. */
> +	if (last_global_asid >= MAX_ASID_AVAILABLE - 1)
> +		reset_global_asid_space();
> +
> +	asid = find_next_zero_bit(global_asid_used, MAX_ASID_AVAILABLE, last_global_asid);
> +
> +	if (asid >= MAX_ASID_AVAILABLE) {
> +		/* This should never happen. */
> +		VM_WARN_ONCE(1, "Unable to allocate global ASID despite %d available\n",
> +				global_asid_available);
> +		return 0;
> +	}
> +
> +	/* Claim this global ASID. */
> +	__set_bit(asid, global_asid_used);
> +	last_global_asid = asid;
> +	global_asid_available--;
> +	return asid;
> +}
> +
> +/*
> + * Returns true if the mm is transitioning from a CPU-local ASID to a global
> + * (INVLPGB) ASID, or the other way around.
> + */
> +static bool needs_global_asid_reload(struct mm_struct *next, u16 prev_asid)
> +{
> +	u16 global_asid = mm_global_asid(next);
> +
> +	/* Process is transitioning to a global ASID */
> +	if (global_asid && prev_asid != global_asid)
> +		return true;
> +
> +	/* Transition from global->local ASID does not currently happen. */
> +	if (!global_asid && is_global_asid(prev_asid))
> +		return true;
> +
> +	return false;
> +}
I'm going to throw in the towel at this point. This patch needs to get
broken up. It's more at once than my poor little brain can handle.

The _least_ it can do is introduce the stub functions and injection into
existing code changes, first. Then, in a second patch, introduce the
real implementation.

I also suspect that a big chunk of the ASID allocator could be broken
out and introduced separately.

Another example is broadcast_tlb_flush(). To reduce complexity in _this_
patch, it could do something suboptimal like always do a
invlpgb_flush_all_nonglobals() regardless of the kind of flush it gets.
Then, in a later patch, you could optimize it.

