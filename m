Return-Path: <linux-kernel+bounces-533756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE61DA45E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1627A189BC67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CC822A80A;
	Wed, 26 Feb 2025 12:04:00 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F07221562
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571439; cv=none; b=noA3CXqNHhdxaGLn2MP7gYRVMJYeaX5XEImkmr+HxAGJukxAdBGtbk1743H/nTrjh0naRlO0pHXDS9mGxqhoF4FE+xuGqQDt42KyUYF1uhTJzNjZRsp3AxxrBtcjxgSswG1GPDqoTd6KrRJbEp6yfqq/f4svoVWVLJFDVKb63qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571439; c=relaxed/simple;
	bh=7oWv0Hgui0RdP8NPP9zP1bwQrQv7GBrXYIxyAU7uXa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JsGCiK4z4ftbzei3Ua6S7nbLEXXOodvZAcr6JunT7O5tbzafAAoWZzZu9uerHfwvaIoAZHKx0dD1W3Jwe1RmAmjwnhJhbv5o9yXDKsL4IPrwjXyNpnl8pSiC1CHo3l1Y8xCZqUdfB42qLCmy51gUqE9scqUOICQIzcDJIWX5qJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-48-67bf03239cb8
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on v6.14-rc4 17/25] x86/tlb, riscv/tlb, arm64/tlbflush, mm: remove cpus from tlb shootdown that already have been done
Date: Wed, 26 Feb 2025 21:03:28 +0900
Message-Id: <20250226120336.29565-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnka4y8/50gy+T+SzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK+P33I/sBU9qKy4e28fSwDg3vYuR
	k0NCwETiXUsfC4x9r7MDzGYTUJe4ceMnM4gtImAmcbD1D3sXIxcHs8AyJom9JxrYQBxhgSmM
	Els6lwM5HBwsAqoS088mgJi8QA0zj+VBzJSXWL3hANgcTqDwp2nH2EBsIYFkiZ2//zCBjJEQ
	uM0m8ebqX6gjJCUOrrjBMoGRdwEjwypGocy8stzEzBwTvYzKvMwKveT83E2MwKBeVvsnegfj
	pwvBhxgFOBiVeHgfnNmbLsSaWFZcmXuIUYKDWUmElzNzT7oQb0piZVVqUX58UWlOavEhRmkO
	FiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRt6LRo4z3ljahRZLFHK7ndtYKDqR9d/uTo7a
	6/t//bstx9GYwcxy7fRLG1eRD73ZBXpTLJjmpdQnyjmf8tdJyDTRc+P6GvUv18fh16qIyfab
	c87Jc/gf32EYVOhQl/yWb9GJHJkGPXG/+n7HO+yPvW01/JV2BKmJqqQd41pty60vpiNz21mJ
	pTgj0VCLuag4EQBkq1b8ZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/d4NUBG4s569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyfs/9yF7wpLbi
	4rF9LA2Mc9O7GDk5JARMJO51drCA2GwC6hI3bvxkBrFFBMwkDrb+Ye9i5OJgFljGJLH3RAMb
	iCMsMIVRYkvnciCHg4NFQFVi+tkEEJMXqGHmsTyImfISqzccAJvDCRT+NO0YG4gtJJAssfP3
	H6YJjFwLGBlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIbosto/E3cwfrnsfohRgINRiYf3
	wZm96UKsiWXFlbmHGCU4mJVEeDkz96QL8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhP
	LEnNTk0tSC2CyTJxcEo1MFbpLm2zva2vZnpo1u0DzJkKDgccOL3Sc0Jttt196Wu+z9zjYI7G
	3eLr4W+KMxZUpcm5puzRL54472TOz+O7Tr6V36JaWXFY73Nt2cIPMW1nF4bOarl8I8G4Z+7d
	HVI1GfdSyxoj+G2O9dbENSkJ/v12pFNr+Q2+Z4ZntWYUqc1XcrjbGWYvosRSnJFoqMVcVJwI
	AE4I4GZNAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

luf mechanism performs tlb shootdown for mappings that have been
unmapped in lazy manner.  However, it doesn't have to perform tlb
shootdown to cpus that already have been done by others since the tlb
shootdown was desired.

Since luf already introduced its own generation number used as a global
timestamp, luf_ugen, it's possible to selectively pick cpus that have
been done tlb flush required.

This patch introduced APIs that use the generation number to select and
remove those cpus so that it can perform tlb shootdown with a smaller
cpumask, for all the CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH archs,
x86, riscv, and arm64.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h |  26 +++++++
 arch/riscv/include/asm/tlbflush.h |   4 ++
 arch/riscv/mm/tlbflush.c          | 108 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/tlbflush.h   |   4 ++
 arch/x86/mm/tlb.c                 | 108 ++++++++++++++++++++++++++++++
 include/linux/sched.h             |   1 +
 mm/internal.h                     |   4 ++
 mm/page_alloc.c                   |  32 +++++++--
 mm/rmap.c                         |  46 ++++++++++++-
 9 files changed, 327 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index acac53a21e5d1..5547ab1ffb3c3 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -354,6 +354,32 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	dsb(ish);
 }
 
+static inline bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen)
+{
+	/*
+	 * Nothing is needed in this architecture.
+	 */
+	return true;
+}
+
+static inline bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen)
+{
+	/*
+	 * Nothing is needed in this architecture.
+	 */
+	return true;
+}
+
+static inline void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen)
+{
+	/* nothing to do */
+}
+
+static inline void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen)
+{
+	/* nothing to do */
+}
+
 static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
 {
 	/* nothing to do */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 1dc7d30273d59..ec5caeb3cf8ef 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -65,6 +65,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 			       unsigned long uaddr);
 void arch_flush_tlb_batched_pending(struct mm_struct *mm);
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen);
 
 static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
 {
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 36f996af6256c..93afb7a299003 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -202,3 +202,111 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
 			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
+
+static DEFINE_PER_CPU(atomic_long_t, ugen_done);
+
+static int __init luf_init_arch(void)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpu_possible_mask)
+		atomic_long_set(per_cpu_ptr(&ugen_done, cpu), LUF_UGEN_INIT - 1);
+
+	return 0;
+}
+early_initcall(luf_init_arch);
+
+/*
+ * batch will not be updated.
+ */
+bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch,
+			unsigned long ugen)
+{
+	int cpu;
+
+	if (!ugen)
+		goto out;
+
+	for_each_cpu(cpu, &batch->cpumask) {
+		unsigned long done;
+
+		done = atomic_long_read(per_cpu_ptr(&ugen_done, cpu));
+		if (ugen_before(done, ugen))
+			return false;
+	}
+	return true;
+out:
+	return cpumask_empty(&batch->cpumask);
+}
+
+bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch,
+			unsigned long ugen)
+{
+	int cpu;
+
+	if (!ugen)
+		goto out;
+
+	for_each_cpu(cpu, &batch->cpumask) {
+		unsigned long done;
+
+		done = atomic_long_read(per_cpu_ptr(&ugen_done, cpu));
+		if (!ugen_before(done, ugen))
+			cpumask_clear_cpu(cpu, &batch->cpumask);
+	}
+out:
+	return cpumask_empty(&batch->cpumask);
+}
+
+void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch,
+			     unsigned long ugen)
+{
+	int cpu;
+
+	if (!ugen)
+		return;
+
+	for_each_cpu(cpu, &batch->cpumask) {
+		atomic_long_t *done = per_cpu_ptr(&ugen_done, cpu);
+		unsigned long old = atomic_long_read(done);
+
+		/*
+		 * It's racy.  The race results in unnecessary tlb flush
+		 * because of the smaller ugen_done than it should be.
+		 * However, it's okay in terms of correctness.
+		 */
+		if (!ugen_before(old, ugen))
+			continue;
+
+		/*
+		 * It's for optimization.  Just skip on fail than retry.
+		 */
+		atomic_long_cmpxchg(done, old, ugen);
+	}
+}
+
+void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen)
+{
+	int cpu;
+
+	if (!ugen)
+		return;
+
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		atomic_long_t *done = per_cpu_ptr(&ugen_done, cpu);
+		unsigned long old = atomic_long_read(done);
+
+		/*
+		 * It's racy.  The race results in unnecessary tlb flush
+		 * because of the smaller ugen_done than it should be.
+		 * However, it's okay in terms of correctness.
+		 */
+		if (!ugen_before(old, ugen))
+			continue;
+
+		/*
+		 * It's for optimization.  Just skip on fail than retry.
+		 */
+		atomic_long_cmpxchg(done, old, ugen);
+	}
+}
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index c27e61bd274a5..dbcbf0477ed2a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -294,6 +294,10 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+extern bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+extern void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+extern void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen);
 
 static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 523e8bb6fba1f..be6068b60c32d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1270,6 +1270,114 @@ void __flush_tlb_all(void)
 }
 EXPORT_SYMBOL_GPL(__flush_tlb_all);
 
+static DEFINE_PER_CPU(atomic_long_t, ugen_done);
+
+static int __init luf_init_arch(void)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpu_possible_mask)
+		atomic_long_set(per_cpu_ptr(&ugen_done, cpu), LUF_UGEN_INIT - 1);
+
+	return 0;
+}
+early_initcall(luf_init_arch);
+
+/*
+ * batch will not be updated.
+ */
+bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch,
+			unsigned long ugen)
+{
+	int cpu;
+
+	if (!ugen)
+		goto out;
+
+	for_each_cpu(cpu, &batch->cpumask) {
+		unsigned long done;
+
+		done = atomic_long_read(per_cpu_ptr(&ugen_done, cpu));
+		if (ugen_before(done, ugen))
+			return false;
+	}
+	return true;
+out:
+	return cpumask_empty(&batch->cpumask);
+}
+
+bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch,
+			unsigned long ugen)
+{
+	int cpu;
+
+	if (!ugen)
+		goto out;
+
+	for_each_cpu(cpu, &batch->cpumask) {
+		unsigned long done;
+
+		done = atomic_long_read(per_cpu_ptr(&ugen_done, cpu));
+		if (!ugen_before(done, ugen))
+			cpumask_clear_cpu(cpu, &batch->cpumask);
+	}
+out:
+	return cpumask_empty(&batch->cpumask);
+}
+
+void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch,
+			     unsigned long ugen)
+{
+	int cpu;
+
+	if (!ugen)
+		return;
+
+	for_each_cpu(cpu, &batch->cpumask) {
+		atomic_long_t *done = per_cpu_ptr(&ugen_done, cpu);
+		unsigned long old = atomic_long_read(done);
+
+		/*
+		 * It's racy.  The race results in unnecessary tlb flush
+		 * because of the smaller ugen_done than it should be.
+		 * However, it's okay in terms of correctness.
+		 */
+		if (!ugen_before(old, ugen))
+			continue;
+
+		/*
+		 * It's for optimization.  Just skip on fail than retry.
+		 */
+		atomic_long_cmpxchg(done, old, ugen);
+	}
+}
+
+void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen)
+{
+	int cpu;
+
+	if (!ugen)
+		return;
+
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		atomic_long_t *done = per_cpu_ptr(&ugen_done, cpu);
+		unsigned long old = atomic_long_read(done);
+
+		/*
+		 * It's racy.  The race results in unnecessary tlb flush
+		 * because of the smaller ugen_done than it should be.
+		 * However, it's okay in terms of correctness.
+		 */
+		if (!ugen_before(old, ugen))
+			continue;
+
+		/*
+		 * It's for optimization.  Just skip on fail than retry.
+		 */
+		atomic_long_cmpxchg(done, old, ugen);
+	}
+}
+
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	struct flush_tlb_info *info;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 47a0a3ccb7b1a..31efc88ce911a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1403,6 +1403,7 @@ struct task_struct {
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 	int luf_no_shootdown;
 	int luf_takeoff_started;
+	unsigned long luf_ugen;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/mm/internal.h b/mm/internal.h
index 43e91f04d6d1c..a95c46355e93d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1259,6 +1259,7 @@ void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void try_to_unmap_flush_takeoff(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void reset_batch(struct tlbflush_unmap_batch *batch);
 void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
 void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
 #else
@@ -1274,6 +1275,9 @@ static inline void try_to_unmap_flush_takeoff(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void reset_batch(struct tlbflush_unmap_batch *batch)
+{
+}
 static inline void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset)
 {
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index db1460c07b964..8e1ed80f304cd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -668,9 +668,11 @@ bool luf_takeoff_start(void)
  */
 void luf_takeoff_end(void)
 {
+	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
 	unsigned long flags;
 	bool no_shootdown;
 	bool outmost = false;
+	unsigned long cur_luf_ugen;
 
 	local_irq_save(flags);
 	VM_WARN_ON(!current->luf_takeoff_started);
@@ -697,10 +699,19 @@ void luf_takeoff_end(void)
 	if (no_shootdown)
 		goto out;
 
+	cur_luf_ugen = current->luf_ugen;
+
+	current->luf_ugen = 0;
+
+	if (cur_luf_ugen && arch_tlbbatch_diet(&tlb_ubc_takeoff->arch, cur_luf_ugen))
+		reset_batch(tlb_ubc_takeoff);
+
 	try_to_unmap_flush_takeoff();
 out:
-	if (outmost)
+	if (outmost) {
 		VM_WARN_ON(current->luf_no_shootdown);
+		VM_WARN_ON(current->luf_ugen);
+	}
 }
 
 /*
@@ -757,6 +768,7 @@ bool luf_takeoff_check_and_fold(struct page *page)
 	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
 	unsigned short luf_key = page_luf_key(page);
 	struct luf_batch *lb;
+	unsigned long lb_ugen;
 	unsigned long flags;
 
 	/*
@@ -770,13 +782,25 @@ bool luf_takeoff_check_and_fold(struct page *page)
 	if (!luf_key)
 		return true;
 
-	if (current->luf_no_shootdown)
-		return false;
-
 	lb = &luf_batch[luf_key];
 	read_lock_irqsave(&lb->lock, flags);
+	lb_ugen = lb->ugen;
+
+	if (arch_tlbbatch_check_done(&lb->batch.arch, lb_ugen)) {
+		read_unlock_irqrestore(&lb->lock, flags);
+		return true;
+	}
+
+	if (current->luf_no_shootdown) {
+		read_unlock_irqrestore(&lb->lock, flags);
+		return false;
+	}
+
 	fold_batch(tlb_ubc_takeoff, &lb->batch, false);
 	read_unlock_irqrestore(&lb->lock, flags);
+
+	if (!current->luf_ugen || ugen_before(current->luf_ugen, lb_ugen))
+		current->luf_ugen = lb_ugen;
 	return true;
 }
 #endif
diff --git a/mm/rmap.c b/mm/rmap.c
index c3df36cf7ac16..fcd27200efa04 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -656,7 +656,7 @@ static unsigned long new_luf_ugen(void)
 	return ugen;
 }
 
-static void reset_batch(struct tlbflush_unmap_batch *batch)
+void reset_batch(struct tlbflush_unmap_batch *batch)
 {
 	arch_tlbbatch_clear(&batch->arch);
 	batch->flush_required = false;
@@ -743,8 +743,14 @@ static void __fold_luf_batch(struct luf_batch *dst_lb,
 	 * more tlb shootdown might be needed to fulfill the newer
 	 * request.  Conservertively keep the newer one.
 	 */
-	if (!dst_lb->ugen || ugen_before(dst_lb->ugen, src_ugen))
+	if (!dst_lb->ugen || ugen_before(dst_lb->ugen, src_ugen)) {
+		/*
+		 * Good chance to shrink the batch using the old ugen.
+		 */
+		if (dst_lb->ugen && arch_tlbbatch_diet(&dst_lb->batch.arch, dst_lb->ugen))
+			reset_batch(&dst_lb->batch);
 		dst_lb->ugen = src_ugen;
+	}
 	fold_batch(&dst_lb->batch, src_batch, false);
 }
 
@@ -772,17 +778,45 @@ void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src)
 	read_unlock_irqrestore(&src->lock, flags);
 }
 
+static unsigned long tlb_flush_start(void)
+{
+	/*
+	 * Memory barrier implied in the atomic operation prevents
+	 * reading luf_ugen from happening after the following
+	 * tlb flush.
+	 */
+	return new_luf_ugen();
+}
+
+static void tlb_flush_end(struct arch_tlbflush_unmap_batch *arch,
+		struct mm_struct *mm, unsigned long ugen)
+{
+	/*
+	 * Prevent the following marking from placing prior to the
+	 * actual tlb flush.
+	 */
+	smp_mb();
+
+	if (arch)
+		arch_tlbbatch_mark_ugen(arch, ugen);
+	if (mm)
+		arch_mm_mark_ugen(mm, ugen);
+}
+
 void try_to_unmap_flush_takeoff(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
 	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
+	unsigned long ugen;
 
 	if (!tlb_ubc_takeoff->flush_required)
 		return;
 
+	ugen = tlb_flush_start();
 	arch_tlbbatch_flush(&tlb_ubc_takeoff->arch);
+	tlb_flush_end(&tlb_ubc_takeoff->arch, NULL, ugen);
 
 	/*
 	 * Now that tlb shootdown of tlb_ubc_takeoff has been performed,
@@ -871,13 +905,17 @@ void try_to_unmap_flush(void)
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
+	unsigned long ugen;
 
 	fold_batch(tlb_ubc, tlb_ubc_ro, true);
 	fold_batch(tlb_ubc, tlb_ubc_luf, true);
 	if (!tlb_ubc->flush_required)
 		return;
 
+	ugen = tlb_flush_start();
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	tlb_flush_end(&tlb_ubc->arch, NULL, ugen);
+
 	reset_batch(tlb_ubc);
 }
 
@@ -1009,7 +1047,11 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 	int flushed = batch >> TLB_FLUSH_BATCH_FLUSHED_SHIFT;
 
 	if (pending != flushed) {
+		unsigned long ugen;
+
+		ugen = tlb_flush_start();
 		arch_flush_tlb_batched_pending(mm);
+		tlb_flush_end(NULL, mm, ugen);
 
 		/*
 		 * If the new TLB flushing is pending during flushing, leave
-- 
2.17.1


