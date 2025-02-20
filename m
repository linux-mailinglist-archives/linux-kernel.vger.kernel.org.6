Return-Path: <linux-kernel+bounces-523006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D98A3D0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9F31885995
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB641F0E31;
	Thu, 20 Feb 2025 05:36:17 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8211EBA14
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029775; cv=none; b=sp/KaWqyXEeh6qC5VfJCZ0CXV0fN0Fg1dk81OiKi+lH6YvP734t1AuBhGk+BfS5ha4KpTXFCvlyMN8l81ZMUZrju6noV25RLMP9/0rIQtVNEJKiE6QXVSKpxSRvIYKQwSufZo+M3TgCNSjK1g5PS0mi2PNKCWSrrQdraTjbn12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029775; c=relaxed/simple;
	bh=8cjiuzwkFX3AlqVLR0qyEp6gA9iYW/MALgIX6OXBfdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OMCHjdEc7TOQH0PogpmpFbiH5PYgeHGGdxzawSC+Si9jI8rhlIDL3UAMgcPqJFu6krbjeQTH4KJcr0jZV6MnGu35r90qrDr9COlJhYz6TX3Qh8N09uJlc1UayrfzlQQ+JI6wkKC/XAfwOc4jPlnBaPipMWrngUCL9nxzEGsjMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-32-67b6bba7c76f
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
Subject: [RFC PATCH v12 26/26] mm/luf: implement luf debug feature
Date: Thu, 20 Feb 2025 14:20:27 +0900
Message-Id: <20250220052027.58847-27-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoe7y3dvSDY781LCYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	+99NZC24eJKxYv6a80wNjHuXMHYxcnJICJhI/H81lwnG/rV8ASuIzSagLnHjxk9mEFtEwEzi
	YOsfdhCbWeAuk8SBfjYQW1jASWLbpqNgc1gEVCXmPF/IAmLzAtWfWncXar68xOoNB8DmcALF
	f8zoBesVEjCVeLfgEtBeLqCaz2wSn5+cZoZokJQ4uOIGywRG3gWMDKsYhTLzynITM3NM9DIq
	8zIr9JLzczcxAsN/We2f6B2Mny4EH2IU4GBU4uGd0botXYg1say4MvcQowQHs5IIb1v9lnQh
	3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjHlVHLaf1We6
	uZ03Xyd2bwFXxfUPj2aGS6ju7HXQWVIwLWBFOXtPlZsh09fteWXBMadOKHcIbt3Ut/X/rcVK
	Bp+7uLeJLNCd7+fJ7mZ+dvW7SJ/vd9adiWXdbLlBtq7ymv1iqx3NAXlKTUsernnKEHQ/SJ7J
	491+g5rEM4I+O//ZvFnlc47vkRJLcUaioRZzUXEiAIVnIgB7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXC5WfdrLt897Z0g9UT5CzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlbH/3UTWgosnGSvmrznP1MC4dwljFyMnh4SAicSv5QtYQWw2AXWJGzd+MoPY
	IgJmEgdb/7CD2MwCd5kkDvSzgdjCAk4S2zYdBetlEVCVmPN8IQuIzQtUf2rdXaiZ8hKrNxwA
	m8MJFP8xoxesV0jAVOLdgktMExi5FjAyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAgM5mW1
	fybuYPxy2f0QowAHoxIP74PHW9OFWBPLiitzDzFKcDArifC21W9JF+JNSaysSi3Kjy8qzUkt
	PsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamDkLTu88uLcvaKTz2lZ23uvl8iNDtLO
	+257/PKfqAW1p20nvXRKn75KNVB36vE1TLOiZ365JPyycBuHxaZ77Vs95khsebh2Vc2FOG2p
	Jex8T0XO3FxxeLfosgvMPA0u/32UhdYE/nrcmXL4fgCLiJOXWIinPDPT0/9Bkr9dDSZV3/KQ
	86ph8HBQYinOSDTUYi4qTgQApwYahmICAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We need luf debug feature to detect when luf goes wrong by any chance.
As a RFC, suggest a simple implementation to report problematic
situations by luf.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/riscv/include/asm/tlbflush.h |   3 +
 arch/riscv/mm/tlbflush.c          |  35 ++++-
 arch/x86/include/asm/pgtable.h    |  10 ++
 arch/x86/include/asm/tlbflush.h   |   3 +
 arch/x86/mm/pgtable.c             |  10 ++
 arch/x86/mm/tlb.c                 |  35 ++++-
 include/linux/highmem-internal.h  |   5 +
 include/linux/mm.h                |  20 ++-
 include/linux/mm_types.h          |  16 +--
 include/linux/mm_types_task.h     |  16 +++
 include/linux/sched.h             |   5 +
 mm/highmem.c                      |   1 +
 mm/memory.c                       |  12 ++
 mm/page_alloc.c                   |  34 ++++-
 mm/page_ext.c                     |   3 +
 mm/rmap.c                         | 229 ++++++++++++++++++++++++++++++
 16 files changed, 418 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index ec5caeb3cf8ef..9451f3d22f229 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -69,6 +69,9 @@ bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch, unsigned
 bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
 void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
 void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen);
+#ifdef CONFIG_LUF_DEBUG
+extern void print_lufd_arch(void);
+#endif
 
 static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
 {
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 93afb7a299003..de91bfe0426c2 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -216,6 +216,25 @@ static int __init luf_init_arch(void)
 }
 early_initcall(luf_init_arch);
 
+#ifdef CONFIG_LUF_DEBUG
+static DEFINE_SPINLOCK(luf_debug_lock);
+#define lufd_lock(f) spin_lock_irqsave(&luf_debug_lock, (f))
+#define lufd_unlock(f) spin_unlock_irqrestore(&luf_debug_lock, (f))
+
+void print_lufd_arch(void)
+{
+	int cpu;
+
+	pr_cont("LUFD ARCH:");
+	for_each_cpu(cpu, cpu_possible_mask)
+		pr_cont(" %lu", atomic_long_read(per_cpu_ptr(&ugen_done, cpu)));
+	pr_cont("\n");
+}
+#else
+#define lufd_lock(f) do { (void)(f); } while(0)
+#define lufd_unlock(f) do { (void)(f); } while(0)
+#endif
+
 /*
  * batch will not be updated.
  */
@@ -223,17 +242,22 @@ bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch,
 			unsigned long ugen)
 {
 	int cpu;
+	unsigned long flags;
 
 	if (!ugen)
 		goto out;
 
+	lufd_lock(flags);
 	for_each_cpu(cpu, &batch->cpumask) {
 		unsigned long done;
 
 		done = atomic_long_read(per_cpu_ptr(&ugen_done, cpu));
-		if (ugen_before(done, ugen))
+		if (ugen_before(done, ugen)) {
+			lufd_unlock(flags);
 			return false;
+		}
 	}
+	lufd_unlock(flags);
 	return true;
 out:
 	return cpumask_empty(&batch->cpumask);
@@ -243,10 +267,12 @@ bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch,
 			unsigned long ugen)
 {
 	int cpu;
+	unsigned long flags;
 
 	if (!ugen)
 		goto out;
 
+	lufd_lock(flags);
 	for_each_cpu(cpu, &batch->cpumask) {
 		unsigned long done;
 
@@ -254,6 +280,7 @@ bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch,
 		if (!ugen_before(done, ugen))
 			cpumask_clear_cpu(cpu, &batch->cpumask);
 	}
+	lufd_unlock(flags);
 out:
 	return cpumask_empty(&batch->cpumask);
 }
@@ -262,10 +289,12 @@ void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch,
 			     unsigned long ugen)
 {
 	int cpu;
+	unsigned long flags;
 
 	if (!ugen)
 		return;
 
+	lufd_lock(flags);
 	for_each_cpu(cpu, &batch->cpumask) {
 		atomic_long_t *done = per_cpu_ptr(&ugen_done, cpu);
 		unsigned long old = atomic_long_read(done);
@@ -283,15 +312,18 @@ void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch,
 		 */
 		atomic_long_cmpxchg(done, old, ugen);
 	}
+	lufd_unlock(flags);
 }
 
 void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen)
 {
 	int cpu;
+	unsigned long flags;
 
 	if (!ugen)
 		return;
 
+	lufd_lock(flags);
 	for_each_cpu(cpu, mm_cpumask(mm)) {
 		atomic_long_t *done = per_cpu_ptr(&ugen_done, cpu);
 		unsigned long old = atomic_long_read(done);
@@ -309,4 +341,5 @@ void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen)
 		 */
 		atomic_long_cmpxchg(done, old, ugen);
 	}
+	lufd_unlock(flags);
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 593f10aabd45a..414bcabb23b51 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -695,12 +695,22 @@ static inline pud_t pud_mkyoung(pud_t pud)
 	return pud_set_flags(pud, _PAGE_ACCESSED);
 }
 
+#ifdef CONFIG_LUF_DEBUG
+pud_t pud_mkwrite(pud_t pud);
+static inline pud_t __pud_mkwrite(pud_t pud)
+{
+	pud = pud_set_flags(pud, _PAGE_RW);
+
+	return pud_clear_saveddirty(pud);
+}
+#else
 static inline pud_t pud_mkwrite(pud_t pud)
 {
 	pud = pud_set_flags(pud, _PAGE_RW);
 
 	return pud_clear_saveddirty(pud);
 }
+#endif
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline int pte_soft_dirty(pte_t pte)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 1fc5bacd72dff..2825f4befb272 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -297,6 +297,9 @@ extern bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch, un
 extern bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
 extern void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch, unsigned long ugen);
 extern void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen);
+#ifdef CONFIG_LUF_DEBUG
+extern void print_lufd_arch(void);
+#endif
 
 static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
 {
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 5745a354a241c..f72e4cfdb0a8d 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -901,6 +901,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
+	lufd_check_pages(pte_page(pte), 0);
 	if (vma->vm_flags & VM_SHADOW_STACK)
 		return pte_mkwrite_shstk(pte);
 
@@ -911,6 +912,7 @@ pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 
 pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
+	lufd_check_pages(pmd_page(pmd), PMD_ORDER);
 	if (vma->vm_flags & VM_SHADOW_STACK)
 		return pmd_mkwrite_shstk(pmd);
 
@@ -919,6 +921,14 @@ pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 	return pmd_clear_saveddirty(pmd);
 }
 
+#ifdef CONFIG_LUF_DEBUG
+pud_t pud_mkwrite(pud_t pud)
+{
+	lufd_check_pages(pud_page(pud), PUD_ORDER);
+	return __pud_mkwrite(pud);
+}
+#endif
+
 void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte)
 {
 	/*
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 975f58fa4b30f..e9ae0d8f73442 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1253,6 +1253,25 @@ static int __init luf_init_arch(void)
 }
 early_initcall(luf_init_arch);
 
+#ifdef CONFIG_LUF_DEBUG
+static DEFINE_SPINLOCK(luf_debug_lock);
+#define lufd_lock(f) spin_lock_irqsave(&luf_debug_lock, (f))
+#define lufd_unlock(f) spin_unlock_irqrestore(&luf_debug_lock, (f))
+
+void print_lufd_arch(void)
+{
+	int cpu;
+
+	pr_cont("LUFD ARCH:");
+	for_each_cpu(cpu, cpu_possible_mask)
+		pr_cont(" %lu", atomic_long_read(per_cpu_ptr(&ugen_done, cpu)));
+	pr_cont("\n");
+}
+#else
+#define lufd_lock(f) do { (void)(f); } while(0)
+#define lufd_unlock(f) do { (void)(f); } while(0)
+#endif
+
 /*
  * batch will not be updated.
  */
@@ -1260,17 +1279,22 @@ bool arch_tlbbatch_check_done(struct arch_tlbflush_unmap_batch *batch,
 			unsigned long ugen)
 {
 	int cpu;
+	unsigned long flags;
 
 	if (!ugen)
 		goto out;
 
+	lufd_lock(flags);
 	for_each_cpu(cpu, &batch->cpumask) {
 		unsigned long done;
 
 		done = atomic_long_read(per_cpu_ptr(&ugen_done, cpu));
-		if (ugen_before(done, ugen))
+		if (ugen_before(done, ugen)) {
+			lufd_unlock(flags);
 			return false;
+		}
 	}
+	lufd_unlock(flags);
 	return true;
 out:
 	return cpumask_empty(&batch->cpumask);
@@ -1280,10 +1304,12 @@ bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch,
 			unsigned long ugen)
 {
 	int cpu;
+	unsigned long flags;
 
 	if (!ugen)
 		goto out;
 
+	lufd_lock(flags);
 	for_each_cpu(cpu, &batch->cpumask) {
 		unsigned long done;
 
@@ -1291,6 +1317,7 @@ bool arch_tlbbatch_diet(struct arch_tlbflush_unmap_batch *batch,
 		if (!ugen_before(done, ugen))
 			cpumask_clear_cpu(cpu, &batch->cpumask);
 	}
+	lufd_unlock(flags);
 out:
 	return cpumask_empty(&batch->cpumask);
 }
@@ -1299,10 +1326,12 @@ void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch,
 			     unsigned long ugen)
 {
 	int cpu;
+	unsigned long flags;
 
 	if (!ugen)
 		return;
 
+	lufd_lock(flags);
 	for_each_cpu(cpu, &batch->cpumask) {
 		atomic_long_t *done = per_cpu_ptr(&ugen_done, cpu);
 		unsigned long old = atomic_long_read(done);
@@ -1320,15 +1349,18 @@ void arch_tlbbatch_mark_ugen(struct arch_tlbflush_unmap_batch *batch,
 		 */
 		atomic_long_cmpxchg(done, old, ugen);
 	}
+	lufd_unlock(flags);
 }
 
 void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen)
 {
 	int cpu;
+	unsigned long flags;
 
 	if (!ugen)
 		return;
 
+	lufd_lock(flags);
 	for_each_cpu(cpu, mm_cpumask(mm)) {
 		atomic_long_t *done = per_cpu_ptr(&ugen_done, cpu);
 		unsigned long old = atomic_long_read(done);
@@ -1346,6 +1378,7 @@ void arch_mm_mark_ugen(struct mm_struct *mm, unsigned long ugen)
 		 */
 		atomic_long_cmpxchg(done, old, ugen);
 	}
+	lufd_unlock(flags);
 }
 
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index dd100e849f5e0..0792530d1be7b 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -41,6 +41,7 @@ static inline void *kmap(struct page *page)
 {
 	void *addr;
 
+	lufd_check_pages(page, 0);
 	might_sleep();
 	if (!PageHighMem(page))
 		addr = page_address(page);
@@ -161,6 +162,7 @@ static inline struct page *kmap_to_page(void *addr)
 
 static inline void *kmap(struct page *page)
 {
+	lufd_check_pages(page, 0);
 	might_sleep();
 	return page_address(page);
 }
@@ -177,11 +179,13 @@ static inline void kunmap(struct page *page)
 
 static inline void *kmap_local_page(struct page *page)
 {
+	lufd_check_pages(page, 0);
 	return page_address(page);
 }
 
 static inline void *kmap_local_folio(struct folio *folio, size_t offset)
 {
+	lufd_check_folio(folio);
 	return page_address(&folio->page) + offset;
 }
 
@@ -204,6 +208,7 @@ static inline void __kunmap_local(const void *addr)
 
 static inline void *kmap_atomic(struct page *page)
 {
+	lufd_check_pages(page, 0);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_disable();
 	else
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5c81c9831bc5d..9572fbbb9d73f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -44,6 +44,24 @@ extern int sysctl_page_lock_unfairness;
 void mm_core_init(void);
 void init_mm_internals(void);
 
+#ifdef CONFIG_LUF_DEBUG
+void lufd_check_folio(struct folio *f);
+void lufd_check_pages(const struct page *p, unsigned int order);
+void lufd_check_zone_pages(struct zone *zone, struct page *page, unsigned int order);
+void lufd_check_queued_pages(void);
+void lufd_queue_page_for_check(struct page *page, int order);
+void lufd_mark_folio(struct folio *f, unsigned short luf_key);
+void lufd_mark_pages(struct page *p, unsigned int order, unsigned short luf_key);
+#else
+static inline void lufd_check_folio(struct folio *f) {}
+static inline void lufd_check_pages(const struct page *p, unsigned int order) {}
+static inline void lufd_check_zone_pages(struct zone *zone, struct page *page, unsigned int order) {}
+static inline void lufd_check_queued_pages(void) {}
+static inline void lufd_queue_page_for_check(struct page *page, int order) {}
+static inline void lufd_mark_folio(struct folio *f, unsigned short luf_key) {}
+static inline void lufd_mark_pages(struct page *p, unsigned int order, unsigned short luf_key) {}
+#endif
+
 #ifndef CONFIG_NUMA		/* Don't use mapnrs, do it properly */
 extern unsigned long max_mapnr;
 
@@ -113,7 +131,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
 #ifndef page_to_virt
-#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
+#define page_to_virt(x)	({ lufd_check_pages(x, 0); __va(PFN_PHYS(page_to_pfn(x)));})
 #endif
 
 #ifndef lm_alias
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e3132e1e5e5d2..e0c5712dc46ff 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -22,6 +22,10 @@
 
 #include <asm/mmu.h>
 
+#ifdef CONFIG_LUF_DEBUG
+extern struct page_ext_operations luf_debug_ops;
+#endif
+
 #ifndef AT_VECTOR_SIZE_ARCH
 #define AT_VECTOR_SIZE_ARCH 0
 #endif
@@ -32,18 +36,6 @@
 struct address_space;
 struct mem_cgroup;
 
-#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
-struct luf_batch {
-	struct tlbflush_unmap_batch batch;
-	unsigned long ugen;
-	rwlock_t lock;
-};
-void luf_batch_init(struct luf_batch *lb);
-#else
-struct luf_batch {};
-static inline void luf_batch_init(struct luf_batch *lb) {}
-#endif
-
 /*
  * Each physical page in the system has a struct page associated with
  * it to keep track of whatever it is we are using the page for at the
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index bff5706b76e14..b5dfc451c009b 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -9,6 +9,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/spinlock_types.h>
 
 #include <asm/page.h>
 
@@ -67,4 +68,19 @@ struct tlbflush_unmap_batch {
 #endif
 };
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+struct luf_batch {
+	struct tlbflush_unmap_batch batch;
+	unsigned long ugen;
+	rwlock_t lock;
+};
+void luf_batch_init(struct luf_batch *lb);
+#else
+struct luf_batch {};
+static inline void luf_batch_init(struct luf_batch *lb) {}
+#endif
+
+#if defined(CONFIG_LUF_DEBUG)
+#define NR_LUFD_PAGES 512
+#endif
 #endif /* _LINUX_MM_TYPES_TASK_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 463cb2fb8f919..eb1487fa101e6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1380,6 +1380,11 @@ struct task_struct {
 	unsigned long luf_ugen;
 	unsigned long zone_ugen;
 	unsigned long wait_zone_ugen;
+#if defined(CONFIG_LUF_DEBUG)
+	struct page *lufd_pages[NR_LUFD_PAGES];
+	int lufd_pages_order[NR_LUFD_PAGES];
+	int lufd_pages_nr;
+#endif
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/mm/highmem.c b/mm/highmem.c
index ef3189b36cadb..a323d5a655bf9 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -576,6 +576,7 @@ void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
 {
 	void *kmap;
 
+	lufd_check_pages(page, 0);
 	/*
 	 * To broaden the usage of the actual kmap_local() machinery always map
 	 * pages when debugging is enabled and the architecture has no problems
diff --git a/mm/memory.c b/mm/memory.c
index c98af5e567e89..89d047867d60d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6124,6 +6124,18 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			mapping = vma->vm_file->f_mapping;
 	}
 
+#ifdef CONFIG_LUF_DEBUG
+	if (luf_flush) {
+		/*
+		 * If it has a VM_SHARED mapping, all the mms involved
+		 * in the struct address_space should be luf_flush'ed.
+		 */
+		if (mapping)
+			luf_flush_mapping(mapping);
+		luf_flush_mm(mm);
+	}
+#endif
+
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
 	else
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ccbe49b78190a..c8ab60c60bb08 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -758,6 +758,8 @@ void luf_takeoff_end(struct zone *zone)
 		VM_WARN_ON(current->zone_ugen);
 		VM_WARN_ON(current->wait_zone_ugen);
 	}
+
+	lufd_check_queued_pages();
 }
 
 /*
@@ -853,8 +855,10 @@ bool luf_takeoff_check_and_fold(struct zone *zone, struct page *page)
 		struct luf_batch *lb;
 		unsigned long lb_ugen;
 
-		if (!luf_key)
+		if (!luf_key) {
+			lufd_check_pages(page, buddy_order(page));
 			return true;
+		}
 
 		lb = &luf_batch[luf_key];
 		read_lock_irqsave(&lb->lock, flags);
@@ -875,12 +879,15 @@ bool luf_takeoff_check_and_fold(struct zone *zone, struct page *page)
 
 		if (!current->luf_ugen || ugen_before(current->luf_ugen, lb_ugen))
 			current->luf_ugen = lb_ugen;
+		lufd_queue_page_for_check(page, buddy_order(page));
 		return true;
 	}
 
 	zone_ugen = page_zone_ugen(zone, page);
-	if (!zone_ugen)
+	if (!zone_ugen) {
+		lufd_check_pages(page, buddy_order(page));
 		return true;
+	}
 
 	/*
 	 * Should not be zero since zone-zone_ugen has been updated in
@@ -888,17 +895,23 @@ bool luf_takeoff_check_and_fold(struct zone *zone, struct page *page)
 	 */
 	VM_WARN_ON(!zone->zone_ugen);
 
-	if (!ugen_before(READ_ONCE(zone->zone_ugen_done), zone_ugen))
+	if (!ugen_before(READ_ONCE(zone->zone_ugen_done), zone_ugen)) {
+		lufd_check_pages(page, buddy_order(page));
 		return true;
+	}
 
 	if (current->luf_no_shootdown)
 		return false;
 
+	lufd_check_zone_pages(zone, page, buddy_order(page));
+
 	/*
 	 * zone batched flush has been already set.
 	 */
-	if (current->zone_ugen)
+	if (current->zone_ugen) {
+		lufd_queue_page_for_check(page, buddy_order(page));
 		return true;
+	}
 
 	/*
 	 * Others are already performing tlb shootdown for us.  All we
@@ -933,6 +946,7 @@ bool luf_takeoff_check_and_fold(struct zone *zone, struct page *page)
 		atomic_long_set(&zone->nr_luf_pages, 0);
 		fold_batch(tlb_ubc_takeoff, &zone->zone_batch, true);
 	}
+	lufd_queue_page_for_check(page, buddy_order(page));
 	return true;
 }
 #endif
@@ -1238,6 +1252,11 @@ static inline void __free_one_page(struct page *page,
 	} else
 		zone_ugen = page_zone_ugen(zone, page);
 
+	if (!zone_ugen)
+		lufd_check_pages(page, order);
+	else
+		lufd_check_zone_pages(zone, page, order);
+
 	while (order < MAX_PAGE_ORDER) {
 		int buddy_mt = migratetype;
 		unsigned long buddy_zone_ugen;
@@ -1299,6 +1318,10 @@ static inline void __free_one_page(struct page *page,
 		set_page_zone_ugen(page, zone_ugen);
 		pfn = combined_pfn;
 		order++;
+		if (!zone_ugen)
+			lufd_check_pages(page, order);
+		else
+			lufd_check_zone_pages(zone, page, order);
 	}
 
 done_merging:
@@ -3201,6 +3224,8 @@ void free_unref_page(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
 
+	lufd_mark_pages(page, order, luf_key);
+
 	if (!pcp_allowed_order(order)) {
 		__free_pages_ok(page, order, FPI_NONE, luf_key);
 		return;
@@ -3253,6 +3278,7 @@ void free_unref_folios(struct folio_batch *folios, unsigned short luf_key)
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
+		lufd_mark_folio(folio, luf_key);
 		if (!free_pages_prepare(&folio->page, order))
 			continue;
 		/*
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 641d93f6af4c1..be40bc2a93378 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -89,6 +89,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #ifdef CONFIG_PAGE_TABLE_CHECK
 	&page_table_check_ops,
 #endif
+#ifdef CONFIG_LUF_DEBUG
+	&luf_debug_ops,
+#endif
 };
 
 unsigned long page_ext_size;
diff --git a/mm/rmap.c b/mm/rmap.c
index 55003eb0b4936..fd6d5cb0fa8d0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1161,6 +1161,235 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
 }
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
+#ifdef CONFIG_LUF_DEBUG
+
+static bool need_luf_debug(void)
+{
+	return true;
+}
+
+static void init_luf_debug(void)
+{
+	/* Do nothing */
+}
+
+struct page_ext_operations luf_debug_ops = {
+	.size = sizeof(struct luf_batch),
+	.need = need_luf_debug,
+	.init = init_luf_debug,
+	.need_shared_flags = false,
+};
+
+static bool __lufd_check_zone_pages(struct page *page, int nr,
+		struct tlbflush_unmap_batch *batch, unsigned long ugen)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		struct page_ext *page_ext;
+		struct luf_batch *lb;
+		unsigned long lb_ugen;
+		unsigned long flags;
+		bool ret;
+
+		page_ext = page_ext_get(page + i);
+		if (!page_ext)
+			continue;
+
+		lb = (struct luf_batch *)page_ext_data(page_ext, &luf_debug_ops);
+		write_lock_irqsave(&lb->lock, flags);
+		lb_ugen = lb->ugen;
+		ret = arch_tlbbatch_done(&lb->batch.arch, &batch->arch);
+		write_unlock_irqrestore(&lb->lock, flags);
+		page_ext_put(page_ext);
+
+		if (!ret || ugen_before(ugen, lb_ugen))
+			return false;
+	}
+	return true;
+}
+
+void lufd_check_zone_pages(struct zone *zone, struct page *page, unsigned int order)
+{
+	bool warn;
+	static bool once = false;
+
+	if (!page || !zone)
+		return;
+
+	warn = !__lufd_check_zone_pages(page, 1 << order,
+			&zone->zone_batch, zone->luf_ugen);
+
+	if (warn && !READ_ONCE(once)) {
+		WRITE_ONCE(once, true);
+		VM_WARN(1, "LUFD: ugen(%lu) page(%p) order(%u)\n",
+				atomic_long_read(&luf_ugen), page, order);
+		print_lufd_arch();
+	}
+}
+
+static bool __lufd_check_pages(const struct page *page, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		struct page_ext *page_ext;
+		struct luf_batch *lb;
+		unsigned long lb_ugen;
+		unsigned long flags;
+		bool ret;
+
+		page_ext = page_ext_get(page + i);
+		if (!page_ext)
+			continue;
+
+		lb = (struct luf_batch *)page_ext_data(page_ext, &luf_debug_ops);
+		write_lock_irqsave(&lb->lock, flags);
+		lb_ugen = lb->ugen;
+		ret = arch_tlbbatch_diet(&lb->batch.arch, lb_ugen);
+		write_unlock_irqrestore(&lb->lock, flags);
+		page_ext_put(page_ext);
+
+		if (!ret)
+			return false;
+	}
+	return true;
+}
+
+void lufd_queue_page_for_check(struct page *page, int order)
+{
+	struct page **parray = current->lufd_pages;
+	int *oarray = current->lufd_pages_order;
+
+	if (!page)
+		return;
+
+	if (current->lufd_pages_nr >= NR_LUFD_PAGES) {
+		VM_WARN_ONCE(1, "LUFD: NR_LUFD_PAGES is too small.\n");
+		return;
+	}
+
+	*(parray + current->lufd_pages_nr) = page;
+	*(oarray + current->lufd_pages_nr) = order;
+	current->lufd_pages_nr++;
+}
+
+void lufd_check_queued_pages(void)
+{
+	struct page **parray = current->lufd_pages;
+	int *oarray = current->lufd_pages_order;
+	int i;
+
+	for (i = 0; i < current->lufd_pages_nr; i++)
+		lufd_check_pages(*(parray + i), *(oarray + i));
+	current->lufd_pages_nr = 0;
+}
+
+void lufd_check_folio(struct folio *folio)
+{
+	struct page *page;
+	int nr;
+	bool warn;
+	static bool once = false;
+
+	if (!folio)
+		return;
+
+	page = folio_page(folio, 0);
+	nr = folio_nr_pages(folio);
+
+	warn = !__lufd_check_pages(page, nr);
+
+	if (warn && !READ_ONCE(once)) {
+		WRITE_ONCE(once, true);
+		VM_WARN(1, "LUFD: ugen(%lu) page(%p) nr(%d)\n",
+				atomic_long_read(&luf_ugen), page, nr);
+		print_lufd_arch();
+	}
+}
+EXPORT_SYMBOL(lufd_check_folio);
+
+void lufd_check_pages(const struct page *page, unsigned int order)
+{
+	bool warn;
+	static bool once = false;
+
+	if (!page)
+		return;
+
+	warn = !__lufd_check_pages(page, 1 << order);
+
+	if (warn && !READ_ONCE(once)) {
+		WRITE_ONCE(once, true);
+		VM_WARN(1, "LUFD: ugen(%lu) page(%p) order(%u)\n",
+				atomic_long_read(&luf_ugen), page, order);
+		print_lufd_arch();
+	}
+}
+EXPORT_SYMBOL(lufd_check_pages);
+
+static void __lufd_mark_pages(struct page *page, int nr, unsigned short luf_key)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		struct page_ext *page_ext;
+		struct luf_batch *lb;
+
+		page_ext = page_ext_get(page + i);
+		if (!page_ext)
+			continue;
+
+		lb = (struct luf_batch *)page_ext_data(page_ext, &luf_debug_ops);
+		fold_luf_batch(lb, &luf_batch[luf_key]);
+		page_ext_put(page_ext);
+	}
+}
+
+void lufd_mark_folio(struct folio *folio, unsigned short luf_key)
+{
+	struct page *page;
+	int nr;
+	bool warn;
+	static bool once = false;
+
+	if (!luf_key)
+		return;
+
+	page = folio_page(folio, 0);
+	nr = folio_nr_pages(folio);
+
+	warn = !__lufd_check_pages(page, nr);
+	__lufd_mark_pages(page, nr, luf_key);
+
+	if (warn && !READ_ONCE(once)) {
+		WRITE_ONCE(once, true);
+		VM_WARN(1, "LUFD: ugen(%lu) page(%p) nr(%d)\n",
+				atomic_long_read(&luf_ugen), page, nr);
+		print_lufd_arch();
+	}
+}
+
+void lufd_mark_pages(struct page *page, unsigned int order, unsigned short luf_key)
+{
+	bool warn;
+	static bool once = false;
+
+	if (!luf_key)
+		return;
+
+	warn = !__lufd_check_pages(page, 1 << order);
+	__lufd_mark_pages(page, 1 << order, luf_key);
+
+	if (warn && !READ_ONCE(once)) {
+		WRITE_ONCE(once, true);
+		VM_WARN(1, "LUFD: ugen(%lu) page(%p) order(%u)\n",
+				atomic_long_read(&luf_ugen), page, order);
+		print_lufd_arch();
+	}
+}
+#endif
+
 /**
  * page_address_in_vma - The virtual address of a page in this VMA.
  * @folio: The folio containing the page.
-- 
2.17.1


