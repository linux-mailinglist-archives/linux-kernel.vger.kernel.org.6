Return-Path: <linux-kernel+bounces-320750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F38970FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54991F2298E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF751AD3EF;
	Mon,  9 Sep 2024 07:28:50 +0000 (UTC)
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5F4EE41C69
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.143.126.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866930; cv=none; b=q1LbmzKWApo77mKvJIdn3ZR+kUV9zWKgJlPqK3ZLfomxgDOlR1leV+vfy1198Zs7nS3a1UAXTOFuv78W9UNfGPAisq63I5eJZxkB1mzzGrQIVFB9QXBLUegckwWHPlxQ8oXLXu6OZJVqGPE/P5bQJGLegUWhVaikUqbHWm/QeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866930; c=relaxed/simple;
	bh=iPIS2/A4UyMGxN239RnR5liQztzw/zwjjc9c9v2vi1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSKJzIzPxzgI49BUlI03eCSo3CEf0pxNLJyOHy1yKLEnNvXuot3S8HvurxXcCzdcmG0H+Ogb/+jMCixpq6Yf5kX75gVbm8PDiU1IL9xjzkN6o1PKwqAfFq1+3eptZ5b24F3FRANU3LToFv9aJ7mXg4HT57dD2haGfPaofQbnRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=audible.transient.net; spf=none smtp.mailfrom=audible.transient.net; arc=none smtp.client-ip=24.143.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=audible.transient.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=audible.transient.net
Received: (qmail 2206 invoked from network); 9 Sep 2024 07:28:47 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 9 Sep 2024 07:28:47 -0000
Received: (nullmailer pid 23244 invoked by uid 1000);
	Mon, 09 Sep 2024 07:28:46 -0000
Date: Mon, 9 Sep 2024 07:28:46 +0000
From: Jamie Heilman <jamie@audible.transient.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, peterz@infradead.org, stable@vger.kernel.org
Subject: Re: regression in 6.6.46; arch/x86/mm/pti.c
Message-ID: <Zt6jru89n7DBECCr@audible.transient.net>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	stable@vger.kernel.org
References: <Zt6Bh2J5xMcCETbb@audible.transient.net>
 <87h6apcp9x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6apcp9x.ffs@tglx>

Thomas Gleixner wrote:
> On Mon, Sep 09 2024 at 05:03, Jamie Heilman wrote:
> > 3db03fb4995e ("x86/mm: Fix pti_clone_entry_text() for i386") which got
> > landed in 6.6.46, has introduced two back to back warnings on boot on
> > my 32bit system (found on 6.6.50):
> 
> Right.
> 
> > Reverting that commit removes the warnings (tested against 6.6.50).
> > The follow-on commit of c48b5a4cf312 ("x86/mm: Fix PTI for i386 some
> > more") doesn't apply cleanly to 6.6.50, but I did try out a build of
> > 6.11-rc7 and that works fine too with no warnings on boot.
> 
> See backport below.

Yep, that tests out fine for me too.  Thanks!

> ---
> From: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue Aug 6 20:48:43 2024 +0200
> Subject: [PATCH 6.6.y, 6.1.y, 5.10.y] x86/mm: Fix PTI for i386 some more
> 
> commit c48b5a4cf3125adb679e28ef093f66ff81368d05 upstream.
> 
> So it turns out that we have to do two passes of
> pti_clone_entry_text(), once before initcalls, such that device and
> late initcalls can use user-mode-helper / modprobe and once after
> free_initmem() / mark_readonly().
> 
> Now obviously mark_readonly() can cause PMD splits, and
> pti_clone_pgtable() doesn't like that much.
> 
> Allow the late clone to split PMDs so that pagetables stay in sync.
> 
> [peterz: Changelog and comments]
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lkml.kernel.org/r/20240806184843.GX37996@noisy.programming.kicks-ass.net
> ---
>  arch/x86/mm/pti.c |   45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -241,7 +241,7 @@ static pmd_t *pti_user_pagetable_walk_pm
>   *
>   * Returns a pointer to a PTE on success, or NULL on failure.
>   */
> -static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
> +static pte_t *pti_user_pagetable_walk_pte(unsigned long address, bool late_text)
>  {
>  	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
>  	pmd_t *pmd;
> @@ -251,10 +251,15 @@ static pte_t *pti_user_pagetable_walk_pt
>  	if (!pmd)
>  		return NULL;
>  
> -	/* We can't do anything sensible if we hit a large mapping. */
> +	/* Large PMD mapping found */
>  	if (pmd_large(*pmd)) {
> -		WARN_ON(1);
> -		return NULL;
> +		/* Clear the PMD if we hit a large mapping from the first round */
> +		if (late_text) {
> +			set_pmd(pmd, __pmd(0));
> +		} else {
> +			WARN_ON_ONCE(1);
> +			return NULL;
> +		}
>  	}
>  
>  	if (pmd_none(*pmd)) {
> @@ -283,7 +288,7 @@ static void __init pti_setup_vsyscall(vo
>  	if (!pte || WARN_ON(level != PG_LEVEL_4K) || pte_none(*pte))
>  		return;
>  
> -	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR);
> +	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR, false);
>  	if (WARN_ON(!target_pte))
>  		return;
>  
> @@ -301,7 +306,7 @@ enum pti_clone_level {
>  
>  static void
>  pti_clone_pgtable(unsigned long start, unsigned long end,
> -		  enum pti_clone_level level)
> +		  enum pti_clone_level level, bool late_text)
>  {
>  	unsigned long addr;
>  
> @@ -390,7 +395,7 @@ pti_clone_pgtable(unsigned long start, u
>  				return;
>  
>  			/* Allocate PTE in the user page-table */
> -			target_pte = pti_user_pagetable_walk_pte(addr);
> +			target_pte = pti_user_pagetable_walk_pte(addr, late_text);
>  			if (WARN_ON(!target_pte))
>  				return;
>  
> @@ -453,7 +458,7 @@ static void __init pti_clone_user_shared
>  		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
>  		pte_t *target_pte;
>  
> -		target_pte = pti_user_pagetable_walk_pte(va);
> +		target_pte = pti_user_pagetable_walk_pte(va, false);
>  		if (WARN_ON(!target_pte))
>  			return;
>  
> @@ -476,7 +481,7 @@ static void __init pti_clone_user_shared
>  	start = CPU_ENTRY_AREA_BASE;
>  	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
>  
> -	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
> +	pti_clone_pgtable(start, end, PTI_CLONE_PMD, false);
>  }
>  #endif /* CONFIG_X86_64 */
>  
> @@ -493,11 +498,11 @@ static void __init pti_setup_espfix64(vo
>  /*
>   * Clone the populated PMDs of the entry text and force it RO.
>   */
> -static void pti_clone_entry_text(void)
> +static void pti_clone_entry_text(bool late)
>  {
>  	pti_clone_pgtable((unsigned long) __entry_text_start,
>  			  (unsigned long) __entry_text_end,
> -			  PTI_LEVEL_KERNEL_IMAGE);
> +			  PTI_LEVEL_KERNEL_IMAGE, late);
>  }
>  
>  /*
> @@ -572,7 +577,7 @@ static void pti_clone_kernel_text(void)
>  	 * pti_set_kernel_image_nonglobal() did to clear the
>  	 * global bit.
>  	 */
> -	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
> +	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE, false);
>  
>  	/*
>  	 * pti_clone_pgtable() will set the global bit in any PMDs
> @@ -639,8 +644,15 @@ void __init pti_init(void)
>  
>  	/* Undo all global bits from the init pagetables in head_64.S: */
>  	pti_set_kernel_image_nonglobal();
> +
>  	/* Replace some of the global bits just for shared entry text: */
> -	pti_clone_entry_text();
> +	/*
> +	 * This is very early in boot. Device and Late initcalls can do
> +	 * modprobe before free_initmem() and mark_readonly(). This
> +	 * pti_clone_entry_text() allows those user-mode-helpers to function,
> +	 * but notably the text is still RW.
> +	 */
> +	pti_clone_entry_text(false);
>  	pti_setup_espfix64();
>  	pti_setup_vsyscall();
>  }
> @@ -657,10 +669,11 @@ void pti_finalize(void)
>  	if (!boot_cpu_has(X86_FEATURE_PTI))
>  		return;
>  	/*
> -	 * We need to clone everything (again) that maps parts of the
> -	 * kernel image.
> +	 * This is after free_initmem() (all initcalls are done) and we've done
> +	 * mark_readonly(). Text is now NX which might've split some PMDs
> +	 * relative to the early clone.
>  	 */
> -	pti_clone_entry_text();
> +	pti_clone_entry_text(true);
>  	pti_clone_kernel_text();
>  
>  	debug_checkwx_user();
> 

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

