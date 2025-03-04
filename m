Return-Path: <linux-kernel+bounces-544314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28580A4E002
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59645188E44C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69D204F6F;
	Tue,  4 Mar 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7QlZWM/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D08205AC2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096727; cv=none; b=nJuYCVVpUIphdwW8eIZ5pvfuh/H3AGFy/Rb7zAX4ZkKNEycjrWLN7zowJbNpAWKcdYcFwqQF9OaXriQOskRDycoswVUFCwJTotaNheXlPyjUASTBPYGzshKv06G7CgF7zki1JSSCAATvKpqb/rYyyNwnG3SwgjcJwMp/+4a4Gj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096727; c=relaxed/simple;
	bh=peFXxf6pvLf5YEyvcQ+VbBtK2U9T/s+L+AAUIiO804s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/9tgcr09tw4RJjs9NtwV4I7SA4ZBervV8+HvbdH7e6vW+9+AJQ2k6RNEGIbU17lFH4OCBs1ngmuuNxM1CSMYYE6hHLTDFPj+3sPebwnbNG1yqh+Q1evmWVR3r1T4IZrOckLt9yY6eFVOKXIzz5BNupydYIohBE+ufyFhYDzFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7QlZWM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F4FC4CEE9;
	Tue,  4 Mar 2025 13:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096726;
	bh=peFXxf6pvLf5YEyvcQ+VbBtK2U9T/s+L+AAUIiO804s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7QlZWM/CvKDjp1KSyaZW0Gg+U5tDAu/tniChxnze6F0p3R4UsBk4jH0EF/Kzs3Mx
	 0moEMEQ3opI+uD/pw7uBzKAS6sbhHhSJkBE4pKAC4hIiyOQ1I6bV7Ae63yPKmdKtNh
	 EtB/ZqyF/dPQKdEpvFBzOZkzsiRzXZcD+vXEUXJhYa2R72hMWWFqkkmB67ZwlqnTQn
	 R512uPWnT7sVtlM3yK4XhbSY1taGfbn8u8PdmACuqr8Kn2V4o7m3/G28tHK6YZBDx8
	 uQU61uZPanCTq0lOqmnhjIkUF1YceJP0PeCCPXUZaTWx8qKKsnlzwJKmxmTvA+CC84
	 CkqRKyss0jfHA==
From: Borislav Petkov <bp@kernel.org>
To: riel@surriel.com
Cc: Manali.Shukla@amd.com,
	akpm@linux-foundation.org,
	andrew.cooper3@citrix.com,
	jackmanb@google.com,
	jannh@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhklinux@outlook.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	zhengqi.arch@bytedance.com,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v15 07/11] x86/mm: Handle global ASID context switch and TLB flush
Date: Tue,  4 Mar 2025 14:58:12 +0100
Message-ID: <20250304135816.12356-8-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304135816.12356-1-bp@kernel.org>
References: <20250304135816.12356-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

Do context switch and TLB flush support for processes that use a global
ASID and PCID across all CPUs.

At both context switch time and TLB flush time, it needs to be checked whether
a task is switching to a global ASID, and, if so, reload the TLB with the new
ASID as appropriate.

In both code paths, the TLB flush is avoided if a global ASID is used, because
the global ASIDs are always kept up to date across CPUs, even when the
process is not running on a CPU.

  [ bp:
   - Massage
   - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi
  ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-9-riel@surriel.com
---
 arch/x86/include/asm/tlbflush.h | 14 ++++++
 arch/x86/mm/tlb.c               | 77 ++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f7b374bcdc0b..1f61a39a8776 100644
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
 #ifdef CONFIG_BROADCAST_TLB_FLUSH
 static inline u16 mm_global_asid(struct mm_struct *mm)
 {
@@ -266,9 +271,18 @@ static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 	mm->context.asid_transition = true;
 	smp_store_release(&mm->context.global_asid, asid);
 }
+
+static inline bool mm_in_asid_transition(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	return mm && READ_ONCE(mm->context.asid_transition);
+}
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
+static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6c24d967b77d..b5681e6f2333 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -227,6 +227,20 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 		return;
 	}
 
+	/*
+	 * TLB consistency for global ASIDs is maintained with hardware assisted
+	 * remote TLB flushing. Global ASIDs are always up to date.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
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
 
@@ -399,6 +413,23 @@ void mm_free_global_asid(struct mm_struct *mm)
 #endif
 }
 
+/*
+ * Is the mm transitioning from a CPU-local ASID to a global ASID?
+ */
+static bool mm_needs_global_asid(struct mm_struct *mm, u16 asid)
+{
+	u16 global_asid = mm_global_asid(mm);
+
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	/* Process is transitioning to a global ASID */
+	if (global_asid && asid != global_asid)
+		return true;
+
+	return false;
+}
+
 /*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
@@ -704,7 +735,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	 */
 	if (prev == next) {
 		/* Not actually switching mm's */
-		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
+		VM_WARN_ON(is_dyn_asid(prev_asid) &&
+			   this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
 		/*
@@ -721,6 +753,20 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
+		/* Check if the current mm is transitioning to a global ASID */
+		if (mm_needs_global_asid(next, prev_asid)) {
+			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
+			choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
+			goto reload_tlb;
+		}
+
+		/*
+		 * Broadcast TLB invalidation keeps this ASID up to date
+		 * all the time.
+		 */
+		if (is_global_asid(prev_asid))
+			return;
+
 		/*
 		 * If the CPU is not in lazy TLB mode, we are just switching
 		 * from one thread in a process to another thread in the same
@@ -754,6 +800,13 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 */
 		cond_mitigation(tsk);
 
+		/*
+		 * Let nmi_uaccess_okay() and finish_asid_transition()
+		 * know that CR3 is changing.
+		 */
+		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		barrier();
+
 		/*
 		 * Leave this CPU in prev's mm_cpumask. Atomic writes to
 		 * mm_cpumask can be expensive under contention. The CPU
@@ -768,14 +821,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
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
@@ -894,7 +945,7 @@ static void flush_tlb_func(void *info)
 	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	u64 local_tlb_gen;
 	bool local = smp_processor_id() == f->initiating_cpu;
 	unsigned long nr_invalidate = 0;
 	u64 mm_tlb_gen;
@@ -917,6 +968,16 @@ static void flush_tlb_func(void *info)
 	if (unlikely(loaded_mm == &init_mm))
 		return;
 
+	/* Reload the ASID if transitioning into or out of a global ASID */
+	if (mm_needs_global_asid(loaded_mm, loaded_mm_asid)) {
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
 
@@ -934,6 +995,8 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
+	local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+
 	if (unlikely(f->new_tlb_gen != TLB_GENERATION_INVALID &&
 		     f->new_tlb_gen <= local_tlb_gen)) {
 		/*
@@ -1101,7 +1164,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (info->freed_tables || mm_in_asid_transition(info->mm))
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
 		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
-- 
2.43.0


