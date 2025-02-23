Return-Path: <linux-kernel+bounces-527932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D91DA41159
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CD2175A58
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2221FBCB9;
	Sun, 23 Feb 2025 19:50:17 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159E1C84BE
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740340216; cv=none; b=kRbrlBQZgUr3CFAzDFj46djskP6qlfvPuMAP8U2mhyDB08Jmu9XqkENXnjkqTn8MPkNw0iOMrtQZ+2KlqQ0caCDS015wc6fJ3ctmzn5Tg0AGViX+SCoRdB1iUis5xnt/qkQzRKHhHGGRzVkD2LOMlUtW/+tqmq1aBM3KYp/KeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740340216; c=relaxed/simple;
	bh=qF85R4AT2m3EqKaAZU1F58AQqn+ZvYNBDFxHK+aev5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6GNOyY/FNz309C4uEN8JA8CeSwK8KR2RTsDVcuVxH/h5rzOLjd3jkQ0Rvm7sXDrXjI3otypdFu1MQCoLjexGRY40n5v+fZeLVJ5Ep9qH+p3dSCeZUXGQh13Ue+k70BBPi3vrGxN1bdMKVC1ajRqqvfmKo9n/mVpjv/SYH129Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tmHyy-000000001hX-49bB;
	Sun, 23 Feb 2025 14:49:44 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com,
	mingo@kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v13 08/14] x86/mm: global ASID context switch & TLB flush handling
Date: Sun, 23 Feb 2025 14:48:58 -0500
Message-ID: <20250223194943.3518952-9-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250223194943.3518952-1-riel@surriel.com>
References: <20250223194943.3518952-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

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
---
 arch/x86/include/asm/tlbflush.h | 13 ++++++
 arch/x86/mm/tlb.c               | 77 ++++++++++++++++++++++++++++++---
 2 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 83f1da2f1e4a..f1f82571249b 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -240,6 +240,19 @@ static inline bool is_dyn_asid(u16 asid)
 	return asid < TLB_NR_DYN_ASIDS;
 }
 
+static inline bool is_global_asid(u16 asid)
+{
+	return !is_dyn_asid(asid);
+}
+
+static inline bool in_asid_transition(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	return mm && READ_ONCE(mm->context.asid_transition);
+}
+
 #ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
 static inline u16 mm_global_asid(struct mm_struct *mm)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 405630479b90..d8a04e398615 100644
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
 
@@ -389,6 +403,23 @@ void destroy_context_free_global_asid(struct mm_struct *mm)
 	global_asid_available++;
 }
 
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
+}
+
 /*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
@@ -694,7 +725,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	 */
 	if (prev == next) {
 		/* Not actually switching mm's */
-		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
+		VM_WARN_ON(is_dyn_asid(prev_asid) &&
+			   this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
 		/*
@@ -711,6 +743,20 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
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
@@ -744,6 +790,13 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
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
@@ -758,14 +811,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
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
@@ -884,7 +935,7 @@ static void flush_tlb_func(void *info)
 	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	u64 local_tlb_gen;
 	bool local = smp_processor_id() == f->initiating_cpu;
 	unsigned long nr_invalidate = 0;
 	u64 mm_tlb_gen;
@@ -907,6 +958,16 @@ static void flush_tlb_func(void *info)
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
 
@@ -924,6 +985,8 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
+	local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+
 	if (unlikely(f->new_tlb_gen != TLB_GENERATION_INVALID &&
 		     f->new_tlb_gen <= local_tlb_gen)) {
 		/*
@@ -1091,7 +1154,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (info->freed_tables || in_asid_transition(info->mm))
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
 		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
-- 
2.47.1


