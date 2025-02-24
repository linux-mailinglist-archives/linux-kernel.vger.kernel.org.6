Return-Path: <linux-kernel+bounces-528066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71651A41320
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9ECF3A9F53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08352A1BA;
	Mon, 24 Feb 2025 02:02:20 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9732BD1B;
	Mon, 24 Feb 2025 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362540; cv=none; b=n6Lu6Wy9TSRrXMnROMwtu8PmwBXo7BUUXQCJgs7/ImvUvdHrE/0EPWGO5NSzREdpVf1Ao/BrOLbro/apDyu+EOfgUjhMxARuZM2IhVwn4PumDDB59fuCoTpho+w1oECqQC3aJI9EY9d3Iriy6ox6eu5a4iFveRXbuzOevdATVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362540; c=relaxed/simple;
	bh=ZLask/BKV23TJd8RnIZxzwZpkB9KagOMw8p4/vK2+Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbByc2fAk6HJDIprDHtIL0B/Um0KiUeLGV9NSR/Ljw7OkfkZFyIH7Vnorlx2JpYw6dxNR0InALZcMBEWBiF+iHEkEyudASIOwXhXILTcCW8IPHOcB57V4tZGRBmiKdFF26A53wT18MSdx8hvTCTXPdr3VniVXOG3+0WLd3fhMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tmNnA-00000000340-0LPO;
	Sun, 23 Feb 2025 21:01:56 -0500
Date: Sun, 23 Feb 2025 21:01:55 -0500
From: Rik van Riel <riel@surriel.com>
To: kernel test robot <lkp@intel.com>
Cc: x86@kernel.org, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v13 08/14] x86/mm: global ASID context switch & TLB
 flush handling
Message-ID: <20250223210155.3c90843f@fangorn>
In-Reply-To: <202502240650.kzshiji7-lkp@intel.com>
References: <20250223194943.3518952-9-riel@surriel.com>
	<202502240650.kzshiji7-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

On Mon, 24 Feb 2025 07:08:49 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Rik,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on tip/x86/mm tip/master linus/master v6.14-rc4 next-20250221]

This version of patch 8 fixes these compile errors.

I hoped the compiler was smart enough to elide the code when
broadcast TLB invalidation was disabled at the config level,
but maybe that happens at a later stage in the compilation,
after it's already thrown the errors...

I'm not entirely happy with this, but it does seem simple enough.

---8<---

x86/mm: global ASID context switch & TLB flush handling

Context switch and TLB flush support for processes that use a global
ASID & PCID across all CPUs.

At both context switch time and TLB flush time, we need to check
whether a task is switching to a global ASID, and reload the TLB
with the new ASID as appropriate.

In both code paths, we also short-circuit the TLB flush if we
are using a global ASID, because the global ASIDs are always
kept up to date across CPUs, even while the process is not
running on a CPU.

Signed-off-by: Rik van Riel <riel@surriel.com>

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 83f1da2f1e4a..24e6531e0b1a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -240,6 +240,11 @@ static inline bool is_dyn_asid(u16 asid)
 	return asid < TLB_NR_DYN_ASIDS;
 }
 
+static inline bool is_global_asid(u16 asid)
+{
+	return !is_dyn_asid(asid);
+}
+
 #ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
 static inline u16 mm_global_asid(struct mm_struct *mm)
 {
@@ -266,6 +271,14 @@ static inline void assign_mm_global_asid(struct mm_struct *mm, u16 asid)
 	mm->context.asid_transition = true;
 	smp_store_release(&mm->context.global_asid, asid);
 }
+
+static inline bool in_asid_transition(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	return mm && READ_ONCE(mm->context.asid_transition);
+}
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm)
 {
@@ -275,6 +288,11 @@ static inline u16 mm_global_asid(struct mm_struct *mm)
 static inline void assign_mm_global_asid(struct mm_struct *mm, u16 asid)
 {
 }
+
+static inline bool in_asid_transition(struct mm_struct *mm)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 405630479b90..e4aecd38ac4f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -227,6 +227,20 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 		return;
 	}
 
+	/*
+	 * TLB consistency for global ASIDs is maintained with hardware assisted
+	 * remote TLB flushing. Global ASIDs are always up to date.
+	 */
+	if (static_cpu_has(X86_FEATURE_INVLPGB)) {
+		u16 global_asid = mm_global_asid(next);
+
+		if (global_asid) {
+			*new_asid = global_asid;
+			*need_flush = false;
+			return;
+		}
+	}
+
 	if (this_cpu_read(cpu_tlbstate.invalidate_other))
 		clear_asid_other();
 
@@ -382,11 +396,30 @@ void destroy_context_free_global_asid(struct mm_struct *mm)
 
 	guard(raw_spinlock_irqsave)(&global_asid_lock);
 
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
 	/* The global ASID can be re-used only after flush at wrap-around. */
 	__set_bit(mm->context.global_asid, global_asid_freed);
 
 	mm->context.global_asid = 0;
 	global_asid_available++;
+#endif
+}
+
+/*
+ * Is the mm transitioning from a CPU-local ASID to a global ASID?
+ */
+static bool needs_global_asid_reload(struct mm_struct *next, u16 prev_asid)
+{
+	u16 global_asid = mm_global_asid(next);
+
+	if (!static_cpu_has(X86_FEATURE_INVLPGB))
+		return false;
+
+	/* Process is transitioning to a global ASID */
+	if (global_asid && prev_asid != global_asid)
+		return true;
+
+	return false;
 }
 
 /*
@@ -694,7 +727,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	 */
 	if (prev == next) {
 		/* Not actually switching mm's */
-		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
+		VM_WARN_ON(is_dyn_asid(prev_asid) &&
+			   this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
 		/*
@@ -711,6 +745,20 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
+		/* Check if the current mm is transitioning to a global ASID */
+		if (needs_global_asid_reload(next, prev_asid)) {
+			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
+			choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
+			goto reload_tlb;
+		}
+
+		/*
+		 * Broadcast TLB invalidation keeps this PCID up to date
+		 * all the time.
+		 */
+		if (is_global_asid(prev_asid))
+			return;
+
 		/*
 		 * If the CPU is not in lazy TLB mode, we are just switching
 		 * from one thread in a process to another thread in the same
@@ -744,6 +792,13 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 */
 		cond_mitigation(tsk);
 
+		/*
+		 * Let nmi_uaccess_okay() and finish_asid_transition()
+		 * know that we're changing CR3.
+		 */
+		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		barrier();
+
 		/*
 		 * Leave this CPU in prev's mm_cpumask. Atomic writes to
 		 * mm_cpumask can be expensive under contention. The CPU
@@ -758,14 +813,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
-
-		/* Let nmi_uaccess_okay() know that we're changing CR3. */
-		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-		barrier();
 	}
 
+reload_tlb:
 	new_lam = mm_lam_cr3_mask(next);
 	if (need_flush) {
+		VM_WARN_ON_ONCE(is_global_asid(new_asid));
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
 		load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
@@ -884,7 +937,7 @@ static void flush_tlb_func(void *info)
 	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	u64 local_tlb_gen;
 	bool local = smp_processor_id() == f->initiating_cpu;
 	unsigned long nr_invalidate = 0;
 	u64 mm_tlb_gen;
@@ -907,6 +960,16 @@ static void flush_tlb_func(void *info)
 	if (unlikely(loaded_mm == &init_mm))
 		return;
 
+	/* Reload the ASID if transitioning into or out of a global ASID */
+	if (needs_global_asid_reload(loaded_mm, loaded_mm_asid)) {
+		switch_mm_irqs_off(NULL, loaded_mm, NULL);
+		loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	}
+
+	/* Broadcast ASIDs are always kept up to date with INVLPGB. */
+	if (is_global_asid(loaded_mm_asid))
+		return;
+
 	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
@@ -924,6 +987,8 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
+	local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+
 	if (unlikely(f->new_tlb_gen != TLB_GENERATION_INVALID &&
 		     f->new_tlb_gen <= local_tlb_gen)) {
 		/*
@@ -1091,7 +1156,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (info->freed_tables || in_asid_transition(info->mm))
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
 		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,


