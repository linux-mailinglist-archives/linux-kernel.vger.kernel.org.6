Return-Path: <linux-kernel+bounces-522997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E35A3D0E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDE03BAFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843621E9B16;
	Thu, 20 Feb 2025 05:36:11 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4573E1E7640
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029769; cv=none; b=PgHekLAL6nA/9X6Q9Ikmq5NzyPdqUb1RXbsy5C91oUbKw197U1JcQhNH5aTZH+CLkx8ojgMBonyqacRFpHjWv3tNteSTALzHQ3Q7t5WkZUoqjwFhlC5422+xOORbAtUlpt4LRRpXhW/gnMypPf/92PmEAdxgttnOiUuI7aTTHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029769; c=relaxed/simple;
	bh=Q7vnjTLWOrbiW5f59YTqwg06V+yzI/mytdoniBJqdJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DD9ld4URQexQR1X8XwKzOtaqnZETjwPnbdOK6m/EXKExA7MFap5boCCoXgIljZ0TtCLn7fuUsYA0iMtH8i+Ikv38TSTEhdkxwRBbSisvjF9Ae+xuLxdqojcTDpnl7AklaAr2TkorhaRmWSGIfwQOFqpmvzbaey43aK/+AthSBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-03-67b6bba6c75d
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 17/26] x86/tlb, riscv/tlb, arm64/tlbflush, mm: remove cpus from tlb shootdown that already have been done
Date: Thu, 20 Feb 2025 14:20:18 +0900
Message-Id: <20250220052027.58847-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXC9ZZnoe7y3dvSDeZuZLGYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	PbsvsBU8qa14/WwqUwPj3PQuRk4OCQETiTfLzrHA2F9mLGAGsdkE1CVu3PgJZosImEkcbP3D
	DmIzC9xlkjjQz9bFyMUhLNDIKHH4xEEmkASLgKrEuv+v2UBsXqCGc58eM0IMlZdYveEA2CBO
	oPiPGb1gNUICphLvFlxiAhkkIfCZTeJg30KoKyQlDq64wTKBkXcBI8MqRqHMvLLcxMwcE72M
	yrzMCr3k/NxNjMDgX1b7J3oH46cLwYcYBTgYlXh4Z7RuSxdiTSwrrsw9xCjBwawkwttWvyVd
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA+OqMpaTN4MW
	c7xftXZpbLcUx/1zL7OvnlyydMHLAgub/EtrTi7xLzk5fUHY/ZSU7Enl9raXnW9v2MCUwHjM
	5dGhhpSwNY9zbqd/qCtNz4q8YxTFWub7qKyThVtlmcfvXUq3Z14/c2jl/DXmbWVywT4PrI9n
	yxkVzDBxmvNjq3pe1fzMLtV28XIlluKMREMt5qLiRAA4o4pdegIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g6OHzSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAldGz+wJbwZPaitfPpjI1MM5N72Lk5JAQMJH4MmMBM4jNJqAucePGTzBbRMBM
	4mDrH3YQm1ngLpPEgX62LkYuDmGBRkaJwycOMoEkWARUJdb9f80GYvMCNZz79JgRYqi8xOoN
	B8AGcQLFf8zoBasREjCVeLfgEtMERq4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAkN5
	We2fiTsYv1x2P8QowMGoxMP74PHWdCHWxLLiytxDjBIczEoivG31W9KFeFMSK6tSi/Lji0pz
	UosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGJXPXDF0FNj1XHTD0eXRaa9NzyTe
	239kpdSGmb2Oq5V7tsZNOF7I2XUtUqF8YYOVdVH3vsZrSl8kH5hOioh2XKOeH/I46KLt4/hd
	hYxndmkLbPuUUFti65WzPd7LIGJrfdfb91fZr220MgwJ3a34pb3/2eTNQnoqb++8dMvm0d3O
	uiRgQe9TNiWW4oxEQy3mouJEAG9p8vZhAgAA
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
index a62e1ea61e4af..f8290bec32e01 100644
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
index 0ae9564c7301e..1fc5bacd72dff 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -293,6 +293,10 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+extern bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+extern void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+extern void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen);
 
 static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 860e49b223fd7..975f58fa4b30f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1240,6 +1240,114 @@ void __flush_tlb_all(void)
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
index 94321d51b91e8..5c6c4fd021973 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1377,6 +1377,7 @@ struct task_struct {
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 	int luf_no_shootdown;
 	int luf_takeoff_started;
+	unsigned long luf_ugen;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/mm/internal.h b/mm/internal.h
index fe4a1c174895f..77657c17af204 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1246,6 +1246,7 @@ void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void try_to_unmap_flush_takeoff(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void reset_batch(struct tlbflush_unmap_batch *batch);
 void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
 void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
 #else
@@ -1261,6 +1262,9 @@ static inline void try_to_unmap_flush_takeoff(void)
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
index 65acc437d8387..3032fedd8392b 100644
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
index 0aaf02b1b34c3..cf6667fb18fe2 100644
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


