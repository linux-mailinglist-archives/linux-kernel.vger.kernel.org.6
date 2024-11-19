Return-Path: <linux-kernel+bounces-414617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976D9D2AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE104283AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB71D1309;
	Tue, 19 Nov 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CgUv2Jaq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7341D07AB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033927; cv=none; b=isBCHCM8Bwdz40wQjolZ47P2YjBxClYSGnx1BtHwaJUWJMTZTlOg3F/RwpXO7elNyjh8ReEdbWPtaLpeXyFh1PFWf1GGSjxlKo9xeibEEkcN19fFJ+zOFMZ/3modYmcQe59A7LnQwK5P/meefkRKVvy9yHrZx/MWdOV3ehYJVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033927; c=relaxed/simple;
	bh=t2mAq+XSOk2pSgviatf3ysUM3qhgcmUBIzs/wMhv/M0=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TaMysKo+np0cabXcycS3l42XSh6+NHf6xNJJEnN594H9PTyhpWLPxwzez7uJPFiJ6EMBpa++PEf7dVBe0HtYV24rVcYbGrhmeSmbiJkewNZ7skhq991z6VgoDVUE9nCmKvV8P6YnYNqATqLyTf3CoUucl4+2Zng1hXRDqIg/HX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CgUv2Jaq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Dwx1+Re0t7sLEqRPtBA9teCYzo3QP8AF4KmF4gdWCLE=; b=CgUv2Jaq5SUgC9PBoB7sXsWOwr
	upjTY18zakAKjtSIIGWthq3xngfWl+CjzI7Xae1Oud9MOZccf4ngTo+zk4v8lYRZMnk90tQJaE4SV
	bawyJhV+m1T4QF3TT4+oy4xwdXPuAPQbT9AY4CclmvOYpkmpQQz/iP/rIS2HlnfSsDy6JvJBnqCGo
	ZtKTWdfBUvV09a27P+olZnawCw/T5tfEMOONfP80+XqOu5kwxwp2ZCNnCgPr+7A1Thum5YrdR8A/W
	UwyiSt43BGfI+21qNfKGSHljAnemq1dgKUyOGO6bIkwy+nfjlxZs80QeWO0JZlDrW9ZyYYDbOpXRV
	qsXty4AA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDR90-00000004IUH-2FKB;
	Tue, 19 Nov 2024 16:32:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E264E300E95; Tue, 19 Nov 2024 17:32:02 +0100 (CET)
Message-Id: <20241119163035.533822339@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 19 Nov 2024 17:25:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "To:riel"@surriel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/7] x86/mm: Make use/unuse_temporary_mm() non-static
References: <20241119162527.952745944@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andy Lutomirski <luto@kernel.org>

This prepares them for use outside of the alternative machinery.
The code is unchanged.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d1205bc7e165e249c52b7fe8cb1254f06e8a0e2a.1641659630.git.luto@kernel.org
---
 arch/x86/include/asm/mmu_context.h |    7 +++
 arch/x86/kernel/alternative.c      |   68 -------------------------------------
 arch/x86/mm/tlb.c                  |   63 ++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 68 deletions(-)

--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -263,4 +263,11 @@ unsigned long __get_current_cr3_fast(voi
 
 #include <asm-generic/mmu_context.h>
 
+typedef struct {
+	struct mm_struct *mm;
+} temp_mm_state_t;
+
+extern temp_mm_state_t use_temporary_mm(struct mm_struct *mm);
+extern void unuse_temporary_mm(struct mm_struct *mm, temp_mm_state_t prev_state);
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1774,77 +1774,9 @@ void __init_or_module text_poke_early(vo
 	}
 }
 
-typedef struct {
-	struct mm_struct *mm;
-} temp_mm_state_t;
-
-/*
- * Using a temporary mm allows to set temporary mappings that are not accessible
- * by other CPUs. Such mappings are needed to perform sensitive memory writes
- * that override the kernel memory protections (e.g., W^X), without exposing the
- * temporary page-table mappings that are required for these write operations to
- * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
- * mapping is torn down.
- *
- * Context: The temporary mm needs to be used exclusively by a single core. To
- *          harden security IRQs must be disabled while the temporary mm is
- *          loaded, thereby preventing interrupt handler bugs from overriding
- *          the kernel memory protection.
- */
-static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
-{
-	temp_mm_state_t temp_state;
-
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
-	 * with a stale address space WITHOUT being in lazy mode after
-	 * restoring the previous mm.
-	 */
-	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
-		leave_mm();
-
-	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	switch_mm_irqs_off(NULL, mm, current);
-
-	/*
-	 * If breakpoints are enabled, disable them while the temporary mm is
-	 * used. Userspace might set up watchpoints on addresses that are used
-	 * in the temporary mm, which would lead to wrong signals being sent or
-	 * crashes.
-	 *
-	 * Note that breakpoints are not disabled selectively, which also causes
-	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
-	 * undesirable, but still seems reasonable as the code that runs in the
-	 * temporary mm should be short.
-	 */
-	if (hw_breakpoint_active())
-		hw_breakpoint_disable();
-
-	return temp_state;
-}
-
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
-static inline void unuse_temporary_mm(struct mm_struct *mm, temp_mm_state_t prev_state)
-{
-	lockdep_assert_irqs_disabled();
-
-	switch_mm_irqs_off(NULL, prev_state.mm, current);
-
-	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
-	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
-
-	/*
-	 * Restore the breakpoints if they were disabled before the temporary mm
-	 * was loaded.
-	 */
-	if (hw_breakpoint_active())
-		hw_breakpoint_restore();
-}
-
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
 	memcpy(dst, src, len);
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -674,6 +674,69 @@ void enter_lazy_tlb(struct mm_struct *mm
 }
 
 /*
+ * Using a temporary mm allows to set temporary mappings that are not accessible
+ * by other CPUs. Such mappings are needed to perform sensitive memory writes
+ * that override the kernel memory protections (e.g., W^X), without exposing the
+ * temporary page-table mappings that are required for these write operations to
+ * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
+ * mapping is torn down.
+ *
+ * Context: The temporary mm needs to be used exclusively by a single core. To
+ *          harden security IRQs must be disabled while the temporary mm is
+ *          loaded, thereby preventing interrupt handler bugs from overriding
+ *          the kernel memory protection.
+ */
+temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
+{
+	temp_mm_state_t temp_state;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
+	 * with a stale address space WITHOUT being in lazy mode after
+	 * restoring the previous mm.
+	 */
+	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
+		leave_mm();
+
+	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	switch_mm_irqs_off(NULL, mm, current);
+
+	/*
+	 * If breakpoints are enabled, disable them while the temporary mm is
+	 * used. Userspace might set up watchpoints on addresses that are used
+	 * in the temporary mm, which would lead to wrong signals being sent or
+	 * crashes.
+	 *
+	 * Note that breakpoints are not disabled selectively, which also causes
+	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
+	 * undesirable, but still seems reasonable as the code that runs in the
+	 * temporary mm should be short.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_disable();
+
+	return temp_state;
+}
+
+void unuse_temporary_mm(struct mm_struct *mm, temp_mm_state_t prev_state)
+{
+	lockdep_assert_irqs_disabled();
+	switch_mm_irqs_off(NULL, prev_state.mm, current);
+
+	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
+	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
+
+	/*
+	 * Restore the breakpoints if they were disabled before the temporary mm
+	 * was loaded.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_restore();
+}
+
+/*
  * Call this when reinitializing a CPU.  It fixes the following potential
  * problems:
  *



