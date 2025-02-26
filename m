Return-Path: <linux-kernel+bounces-532907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDDA45395
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835D31883515
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C959224AE3;
	Wed, 26 Feb 2025 03:01:52 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241721D581
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538911; cv=none; b=I6Ovq1Wq71fkqjxzWlnGXQS1T1WaKWYj4ELiUvE4h8Pk7aYkttWSQfM/g3krGBE624nGuGs/BSsJVM0dsEMGVXL6HYx3rsp21Yx629VYvL26m0UPMKSTTJ8LNARpSG6wogXycoyzgkdQWxXdlOVKLjOiXO2hkdJDbGTlvquUrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538911; c=relaxed/simple;
	bh=oam4p42jeyx04aKKTpN6MCEKDHgXzEa/KQNcIk/zeRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs7NE50qGI51WGN7T8FA4MZy/AlBGsr/nwina50BPnUAN5K3qwcaHMmOy7oPlgpTAzeLs1oq4zTbvoaEAKLjhIfxIY28Ocn12MQxzOgCQuL4K5pfaSCbvVohAmmP6CTPmbhaRmwnYrpIdEof9nquIJ4KB0703lCO9cE/GU+1A44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn7fw-000000001Y5-1HJG;
	Tue, 25 Feb 2025 22:01:32 -0500
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
Subject: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from tlbbatch code
Date: Tue, 25 Feb 2025 22:00:46 -0500
Message-ID: <20250226030129.530345-12-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226030129.530345-1-riel@surriel.com>
References: <20250226030129.530345-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Instead of doing a system-wide TLB flush from arch_tlbbatch_flush,
queue up asynchronous, targeted flushes from arch_tlbbatch_add_pending.

This also allows us to avoid adding the CPUs of processes using broadcast
flushing to the batch->cpumask, and will hopefully further reduce TLB
flushing from the reclaim and compaction paths.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/include/asm/tlb.h      | 12 ++---
 arch/x86/include/asm/tlbflush.h | 34 ++++++++++----
 arch/x86/mm/tlb.c               | 79 +++++++++++++++++++++++++++++++--
 3 files changed, 107 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 91c9a4da3ace..e645884a1877 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -89,16 +89,16 @@ static inline void __tlbsync(void)
 #define INVLPGB_FINAL_ONLY		BIT(4)
 #define INVLPGB_INCLUDE_NESTED		BIT(5)
 
-static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
-						unsigned long addr,
-						u16 nr,
-						bool pmd_stride)
+static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						  unsigned long addr,
+						  u16 nr,
+						  bool pmd_stride)
 {
 	__invlpgb(0, pcid, addr, nr, pmd_stride, INVLPGB_PCID | INVLPGB_VA);
 }
 
 /* Flush all mappings for a given PCID, not including globals. */
-static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
 {
 	__invlpgb(0, pcid, 0, 1, 0, INVLPGB_PCID);
 }
@@ -111,7 +111,7 @@ static inline void invlpgb_flush_all(void)
 }
 
 /* Flush addr, including globals, for all PCIDs. */
-static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+static inline void __invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
 {
 	__invlpgb(0, 0, addr, nr, 0, INVLPGB_INCLUDE_GLOBAL);
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 811dd70eb6b8..22462bd4b1ee 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -105,6 +105,9 @@ struct tlb_state {
 	 * need to be invalidated.
 	 */
 	bool invalidate_other;
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	bool need_tlbsync;
+#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 	/*
@@ -284,6 +287,16 @@ static inline bool in_asid_transition(struct mm_struct *mm)
 
 	return mm && READ_ONCE(mm->context.asid_transition);
 }
+
+static inline bool cpu_need_tlbsync(void)
+{
+	return this_cpu_read(cpu_tlbstate.need_tlbsync);
+}
+
+static inline void cpu_write_tlbsync(bool state)
+{
+	this_cpu_write(cpu_tlbstate.need_tlbsync, state);
+}
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm)
 {
@@ -302,6 +315,15 @@ static inline bool in_asid_transition(struct mm_struct *mm)
 {
 	return false;
 }
+
+static inline bool cpu_need_tlbsync(void)
+{
+	return false;
+}
+
+static inline void cpu_write_tlbsync(bool state)
+{
+}
 #endif
 
 #ifdef CONFIG_PARAVIRT
@@ -351,21 +373,15 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 	return atomic64_inc_return(&mm->context.tlb_gen);
 }
 
-static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
-					     struct mm_struct *mm,
-					     unsigned long uaddr)
-{
-	inc_mm_tlb_gen(mm);
-	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
-	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
-}
-
 static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 {
 	flush_tlb_mm(mm);
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+					     struct mm_struct *mm,
+					     unsigned long uaddr);
 
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cd109bdf0dd9..4d56d22b9893 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -487,6 +487,37 @@ static void finish_asid_transition(struct flush_tlb_info *info)
 	clear_asid_transition(mm);
 }
 
+static inline void tlbsync(void)
+{
+	if (!cpu_need_tlbsync())
+		return;
+	__tlbsync();
+	cpu_write_tlbsync(false);
+}
+
+static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						unsigned long addr,
+						u16 nr, bool pmd_stride)
+{
+	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride);
+	if (!cpu_need_tlbsync())
+		cpu_write_tlbsync(true);
+}
+
+static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+{
+	__invlpgb_flush_single_pcid_nosync(pcid);
+	if (!cpu_need_tlbsync())
+		cpu_write_tlbsync(true);
+}
+
+static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+{
+	__invlpgb_flush_addr_nosync(addr, nr);
+	if (!cpu_need_tlbsync())
+		cpu_write_tlbsync(true);
+}
+
 static void broadcast_tlb_flush(struct flush_tlb_info *info)
 {
 	bool pmd = info->stride_shift == PMD_SHIFT;
@@ -785,6 +816,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
 
+	tlbsync();
+
 	/*
 	 * Verify that CR3 is what we think it is.  This will catch
 	 * hypothetical buggy code that directly switches to swapper_pg_dir
@@ -961,6 +994,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
  */
 void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
+	tlbsync();
+
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
@@ -1624,9 +1659,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
-		invlpgb_flush_all_nonglobals();
-	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
@@ -1635,12 +1668,52 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
+	/*
+	 * If we issued (asynchronous) INVLPGB flushes, wait for them here.
+	 * The cpumask above contains only CPUs that were running tasks
+	 * not using broadcast TLB flushing.
+	 */
+	tlbsync();
+
 	cpumask_clear(&batch->cpumask);
 
 	put_flush_tlb_info();
 	put_cpu();
 }
 
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+					     struct mm_struct *mm,
+					     unsigned long uaddr)
+{
+	u16 asid = mm_global_asid(mm);
+
+	if (asid) {
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), uaddr, 1, false);
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (static_cpu_has(X86_FEATURE_PTI))
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), uaddr, 1, false);
+
+		/*
+		 * Some CPUs might still be using a local ASID for this
+		 * process, and require IPIs, while others are using the
+		 * global ASID.
+		 *
+		 * In this corner case we need to do both the broadcast
+		 * TLB invalidation, and send IPIs. The IPIs will help
+		 * stragglers transition to the broadcast ASID.
+		 */
+		if (in_asid_transition(mm))
+			asid = 0;
+	}
+
+	if (!asid) {
+		inc_mm_tlb_gen(mm);
+		cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+	}
+
+	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
+}
+
 /*
  * Blindly accessing user memory from NMI context can be dangerous
  * if we're in the middle of switching the current user task or
-- 
2.47.1


