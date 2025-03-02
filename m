Return-Path: <linux-kernel+bounces-540416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E690EA4B05B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CE6166B9B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B61D516C;
	Sun,  2 Mar 2025 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JJQ23UEl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A71322E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740902354; cv=none; b=a1HG8G2ab8rCoDWA5Gaz0R24h/M2H78RB8WllF6UGrd1Q+LkoFRpWY9n89E1P/i/pYxl833wLTPkYP3gi+PWQ+nJQEEbtbw/V9YPcfGLpYKMbJKM42yqgKWQivDnp1gDppKftel42e29J+CG/cdI74JhCtrvy8i3tMXx2+g05Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740902354; c=relaxed/simple;
	bh=t76oQCvfoQVXMO2z/dEWUnG3ic1snXfs0ZJrB2ypbc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycx03jxE9urHx2CmaV3xcsBDLan28u6Yj1BEJ42Jh7wEYm5hGeCodNXySDyDQZ5CFxbh4L2zo8vQ8HqRfoofp81hbHP2vlsH2kfkIGfVqR1AgFnL8AKhEGbMd+E774sZJBvRyV+5Cf/VlJ+bs7HI4GCusGOQSRlojcBzHqkGAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JJQ23UEl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9D9DC40E0173;
	Sun,  2 Mar 2025 07:59:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4uGxVQtlFM0Y; Sun,  2 Mar 2025 07:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740902344; bh=0lzVUDfsUSgEE+jFjqrE22V4/6i4hYwcpCCCpid9uL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJQ23UElLr/19irLbgXFM+pNS/7/oXPxxV0zbNdm8tSkmOPy9hLFZSn5MGwE46/dI
	 S4hmU9p92AoRcIsKbxZEFuOvqT3f32edQn8DHa/avg74KApnC+EdRRqeKOkkuQD0qU
	 yZb5rY0I+6qJ0uxiw80NrgOXk9uTESOPjg96wHcfUQhFxJwQULFSmhvc6GFPXKy/ml
	 5vpz/Ajde10byKIfYnc29MK0+sd8Ks0PJCKifThSyVJWTAhfjjm2ex62u6GIvwvFk+
	 c2ZEZYHq5Ds+p1zNob+LELfXZZwz/ZHBzHLUxtyC8NxujVXQAE2kYKjua0LxpaWy32
	 SH3KFnwfwfFhpvJ6Qdos+wArZwZ1mJIoGJZY7/rUsbg1jCUSn+rRZX+FiFeM1IBI7m
	 4zmPS9vupGi7u2waOAoieazMC+8s+YBT+9YwkzQWtNJKbqYz5MFbf+KyW9cO+ReyiV
	 4JAiZokg3gQCxVU1S1sU00jBXFPcDY2+IKw1mI5Zbi9AmBY5A4GWct6oWl/UCexRD/
	 e5W38K/JQRsRLyxleg3JQzQTBoTdERW8ztWtGxjFsrk7HY+2vv6xv/tIRKjJROslok
	 bsRz6FDpWSy8vaz2c9U1h4ImywfbBhLG6u2gcrIrIid3AWlHB43uo/l2Nda/ZSxEhf
	 yk3UyrtR5MPq7YQV1DQ/gh0Q=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B0F140E0028;
	Sun,  2 Mar 2025 07:58:46 +0000 (UTC)
Date: Sun, 2 Mar 2025 08:58:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 08/13] x86/mm: global ASID context switch & TLB flush
 handling
Message-ID: <20250302075840.GJZ8QPsMFa26COAD6F@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-9-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-9-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:43PM -0500, Rik van Riel wrote:
> Context switch and TLB flush support for processes that use a global
> ASID & PCID across all CPUs.
> 
> At both context switch time and TLB flush time, we need to check
> whether a task is switching to a global ASID, and reload the TLB
> with the new ASID as appropriate.
> 
> In both code paths, we also short-circuit the TLB flush if we
> are using a global ASID, because the global ASIDs are always
> kept up to date across CPUs, even while the process is not
> running on a CPU.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  arch/x86/include/asm/tlbflush.h | 18 ++++++++
>  arch/x86/mm/tlb.c               | 77 ++++++++++++++++++++++++++++++---
>  2 files changed, 88 insertions(+), 7 deletions(-)

Some touchups:

--- /tmp/current.patch	2025-03-02 08:54:44.821408308 +0100
+++ /tmp/0001-x86-mm-Handle-global-ASID-context-switch-and-TLB-flu.patch	2025-03-02 08:55:27.029190935 +0100
@@ -1,18 +1,23 @@
+From a92847ac925d2849708d036d8bb4920d9b6f2a59 Mon Sep 17 00:00:00 2001
 From: Rik van Riel <riel@surriel.com>
 Date: Tue, 25 Feb 2025 22:00:43 -0500
-Subject: x86/mm: Global ASID context switch & TLB flush handling
+Subject: [PATCH] x86/mm: Handle global ASID context switch and TLB flush
 
-Context switch and TLB flush support for processes that use a global
-ASID & PCID across all CPUs.
+Do context switch and TLB flush support for processes that use a global
+ASID and PCID across all CPUs.
 
-At both context switch time and TLB flush time, we need to check
-whether a task is switching to a global ASID, and reload the TLB
-with the new ASID as appropriate.
-
-In both code paths, we also short-circuit the TLB flush if we
-are using a global ASID, because the global ASIDs are always
-kept up to date across CPUs, even while the process is not
-running on a CPU.
+At both context switch time and TLB flush time, it needs to be checked whether
+a task is switching to a global ASID, and, if so, reload the TLB with the new
+ASID as appropriate.
+
+In both code paths, the TLB flush is avoided if a global ASID is used, because
+the global ASIDs are always kept up to date across CPUs, even when the
+process is not running on a CPU.
+
+  [ bp:
+   - Massage
+   - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi
+  ]
 
 Signed-off-by: Rik van Riel <riel@surriel.com>
 Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
@@ -66,7 +71,7 @@ index 8e7df0ed7005..37b735dcf025 100644
  
  #ifdef CONFIG_PARAVIRT
 diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
-index 9b1652c02452..b7d461db1b08 100644
+index d79ebdf095e1..cb43ab08ea4a 100644
 --- a/arch/x86/mm/tlb.c
 +++ b/arch/x86/mm/tlb.c
 @@ -227,6 +227,20 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
@@ -77,7 +82,7 @@ index 9b1652c02452..b7d461db1b08 100644
 +	 * TLB consistency for global ASIDs is maintained with hardware assisted
 +	 * remote TLB flushing. Global ASIDs are always up to date.
 +	 */
-+	if (static_cpu_has(X86_FEATURE_INVLPGB)) {
++	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
 +		u16 global_asid = mm_global_asid(next);
 +
 +		if (global_asid) {
@@ -90,22 +95,22 @@ index 9b1652c02452..b7d461db1b08 100644
  	if (this_cpu_read(cpu_tlbstate.invalidate_other))
  		clear_asid_other();
  
-@@ -391,6 +405,23 @@ void mm_free_global_asid(struct mm_struct *mm)
+@@ -396,6 +410,23 @@ void mm_free_global_asid(struct mm_struct *mm)
  #endif
  }
  
 +/*
 + * Is the mm transitioning from a CPU-local ASID to a global ASID?
 + */
-+static bool needs_global_asid_reload(struct mm_struct *next, u16 prev_asid)
++static bool mm_needs_global_asid(struct mm_struct *mm, u16 asid)
 +{
-+	u16 global_asid = mm_global_asid(next);
++	u16 global_asid = mm_global_asid(mm);
 +
-+	if (!static_cpu_has(X86_FEATURE_INVLPGB))
++	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
 +		return false;
 +
 +	/* Process is transitioning to a global ASID */
-+	if (global_asid && prev_asid != global_asid)
++	if (global_asid && asid != global_asid)
 +		return true;
 +
 +	return false;
@@ -124,19 +129,19 @@ index 9b1652c02452..b7d461db1b08 100644
  			   next->context.ctx_id);
  
  		/*
-@@ -713,6 +745,20 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
+@@ -718,6 +750,20 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
  				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
  			cpumask_set_cpu(cpu, mm_cpumask(next));
  
 +		/* Check if the current mm is transitioning to a global ASID */
-+		if (needs_global_asid_reload(next, prev_asid)) {
++		if (mm_needs_global_asid(next, prev_asid)) {
 +			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 +			choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 +			goto reload_tlb;
 +		}
 +
 +		/*
-+		 * Broadcast TLB invalidation keeps this PCID up to date
++		 * Broadcast TLB invalidation keeps this ASID up to date
 +		 * all the time.
 +		 */
 +		if (is_global_asid(prev_asid))
@@ -145,13 +150,13 @@ index 9b1652c02452..b7d461db1b08 100644
  		/*
  		 * If the CPU is not in lazy TLB mode, we are just switching
  		 * from one thread in a process to another thread in the same
-@@ -746,6 +792,13 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
+@@ -751,6 +797,13 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
  		 */
  		cond_mitigation(tsk);
  
 +		/*
 +		 * Let nmi_uaccess_okay() and finish_asid_transition()
-+		 * know that we're changing CR3.
++		 * know that CR3 is changing.
 +		 */
 +		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
 +		barrier();
@@ -185,12 +190,12 @@ index 9b1652c02452..b7d461db1b08 100644
  	bool local = smp_processor_id() == f->initiating_cpu;
  	unsigned long nr_invalidate = 0;
  	u64 mm_tlb_gen;
-@@ -909,6 +960,16 @@ static void flush_tlb_func(void *info)
+@@ -914,6 +965,16 @@ static void flush_tlb_func(void *info)
  	if (unlikely(loaded_mm == &init_mm))
  		return;
  
 +	/* Reload the ASID if transitioning into or out of a global ASID */
-+	if (needs_global_asid_reload(loaded_mm, loaded_mm_asid)) {
++	if (mm_needs_global_asid(loaded_mm, loaded_mm_asid)) {
 +		switch_mm_irqs_off(NULL, loaded_mm, NULL);
 +		loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 +	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

