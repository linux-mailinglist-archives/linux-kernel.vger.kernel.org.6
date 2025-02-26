Return-Path: <linux-kernel+bounces-533729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F05A45E22
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC6D1898957
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4572222AA;
	Wed, 26 Feb 2025 12:01:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A57D22155D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571315; cv=none; b=bA7CQ7MIntONWMQB+HeSasyeTrQSEIrPvkV5E7nVP0LZp5qb/5eid3msw9h7uvy3yawxkp4qvrac45hmI0j6j2BLEuelSBFFv5fYDE3yXkVazifSGof9lYNROdMl3XbJB7yyfvPXTWg6on5+XU48AxXbX8HiTw4vHuTomNNSFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571315; c=relaxed/simple;
	bh=EzUbpGlRv6mMysBayAmKvWMCxpu7lW902WhWhkxbt/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZSSFklQGZz36cWP6Z8OOgGhasbgDe+EnYisLsFEmbJE9EjqTPlgtHtbuxI4Jrji8DjnetYLXLaYGwwt+kr5W7mWVEPuKDUUWC0Yl/rL1rc92Ztshy78QExqP5TBzvZQILywzm3fag/m3BfyuYegGepdOG69nEcBi9Pv0k9pyFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-17-67bf02a77646
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 17/25]  x86/tlb, riscv/tlb, arm64/tlbflush, mm: remove cpus from tlb shootdown that already have been done
Date: Wed, 26 Feb 2025 21:01:24 +0900
Message-Id: <20250226120132.28469-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBjf/CFvMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8aM6SoFrXUVO7fFNTAeSO9i5OSQ
	EDCRWD17FlMXIweY3bY6ESTMJqAucePGT2YQW0TATOJg6x/2LkYuDmaBZUwSe080sIE4wgKr
	GCXaLm1iB6liEVCVePz9C5jNC9RxZ/ZVZogF8hKrNxwAszmB4v92/warERJIlmhZ/5sFZJCE
	wG02ie3XDrJDNEhKHFxxg2UCI+8CRoZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIEhvaz2T/QO
	xk8Xgg8xCnAwKvHwPjizN12INbGsuDL3EKMEB7OSCC9n5p50Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYw1is8Ytxy4NnPmcXZu9yqJyR5PmeT+zVa5
	82vfH+Hjusf3tiV98r7WcfRSQdGM3gB15Zq33hwyc3N8ssRnHo3cd8Y+gGFxisFJgSpW4eke
	X4Tde0sMvmrPfrxf3KmxykNiZePBX+EfLE/fT33K/EOZRWtmRW/ufrY7QZP/2U8W2FkVWSu2
	UVCJpTgj0VCLuag4EQDlhN19ZQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsXC5WfdrLucaX+6wY4fXBZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlzJiuUtBaV7Fz
	W1wD44H0LkYODgkBE4m21YldjJwcbALqEjdu/GQGsUUEzCQOtv5h72Lk4mAWWMYksfdEAxuI
	IyywilGi7dImdpAqFgFVicffv4DZvEAdd2ZfBeuWEJCXWL3hAJjNCRT/t/s3WI2QQLJEy/rf
	LBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDNBltX8m7mD8ctn9EKMAB6MSD++D
	M3vThVgTy4orcw8xSnAwK4nwcmbuSRfiTUmsrEotyo8vKs1JLT7EKM3BoiTO6xWemiAkkJ5Y
	kpqdmlqQWgSTZeLglGpgXPp8laaEwv7vPcxJZpbMJwtWqZ/82ig79fhO718L5JKZj3Vs+hcb
	ZGjNOT3tpszmC/tj9Rd0vzzU76mqsPyFgK5jUH1p0MlTrxkLvrN2aH15HJA2saP7ybOQ3Xm8
	zUx3JLanyiVJ2ZybO4Vjscz/kzPuC7RMfDtvs82vxfsv1Wcbb263C9utpcRSnJFoqMVcVJwI
	ACkTWk1MAgAA
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
index f7036cd33e35c..ae3c981fcc218 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -347,6 +347,32 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
index cecd8e7e2a3bd..936bf9ce0abd9 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -64,6 +64,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 		struct mm_struct *mm, unsigned long start, unsigned long end);
 void arch_flush_tlb_batched_pending(struct mm_struct *mm);
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
+void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen);
 
 static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
 {
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 38f4bea8a964a..6ce44370a8e11 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -201,3 +201,111 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
index 52c54ca68ca9e..58ad7e6989bb1 100644
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
index 2429db598e265..9fccfd38e03f0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1276,6 +1276,7 @@ void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void try_to_unmap_flush_takeoff(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void reset_batch(struct tlbflush_unmap_batch *batch);
 void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
 void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
 #else
@@ -1291,6 +1292,9 @@ static inline void try_to_unmap_flush_takeoff(void)
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
index 530c5c16ab323..7b023b34d53da 100644
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
index 2191cf1d38270..579c75f46c170 100644
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


