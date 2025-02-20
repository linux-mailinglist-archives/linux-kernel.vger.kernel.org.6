Return-Path: <linux-kernel+bounces-522999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B25A3D0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B27716C047
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD51EE008;
	Thu, 20 Feb 2025 05:36:13 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21951E9919
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029771; cv=none; b=VinOnqMiZtIDAj2GuFQGNBEKyPgELnvcY9HTX81WGc2ZsZsHGFr5BNqO6O/2HJXRsV3hZfe0+ZFkXpeuFTh7D1e4wSVypqSCqLZ8ZCxsdrvIgYOPs901cbUcz4VDXKgZ3CN6vXBthX5FQHxEaOBVAPZgjPXu8LkzxU5syqUKxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029771; c=relaxed/simple;
	bh=JbvgcH015+NA/RjyJRa1CVDlVMj9X3fQL4RUWiaByBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=J0nRGOBVMRVThUy5Pp2YrJHWG088xrMSriYM+exeZEuw8CtHMrqI4SW+h9O+U/7IdE9knXCprtI63uR+gzUaWyDvGw20nSrpv9/PikhgAYDvvHgDSSVTfKHwki5SWkLe4j8kyVEq1tUWvB5dUwbx8LbKtvhMi0oE12s0pbrCe/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-0d-67b6bba748fa
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
Subject: [RFC PATCH v12 19/26] mm: skip luf tlb flush for luf'd mm that already has been done
Date: Thu, 20 Feb 2025 14:20:20 +0900
Message-Id: <20250220052027.58847-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe7y3dvSDWbM4bWYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	K7ofsRacta3YcNyhgbHdqIuRk0NCwESieeZ5Zhj76YtjTCA2m4C6xI0bP8HiIgJmEgdb/7CD
	2MwCd5kkDvSzgdjCArESs3asZgGxWQRUJd7sOwVWzwtU3/nhFdRMeYnVGw6A2ZxA8R8zesF6
	hQRMJd4tuAS0iwuo5j2bxLYzH6EaJCUOrrjBMoGRdwEjwypGocy8stzEzBwTvYzKvMwKveT8
	3E2MwMBfVvsnegfjpwvBhxgFOBiVeHhntG5LF2JNLCuuzD3EKMHBrCTC21a/JV2INyWxsiq1
	KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QD49p/iQEPVnjsjfuRceze
	+ic5Rclr1rxfW5dq35Tnm73DpiN2Tl7cIbHeqbz8npyZH0QSY9sX1bE4iyi8TuQN1Nfj03rt
	p+lhWPKi5cefyrW7L213EX8vETnzq3plkq3QJRu2W66B0g7JHh5Pw7d+2+9tcWfRn4cNsRXL
	WHmfVwj+2OT07MEUJZbijERDLeai4kQAqLvAnngCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLt897Z0g1PtzBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyljR/Yi14KxtxYbjDg2M7UZdjJwcEgImEk9fHGMCsdkE1CVu3PjJDGKLCJhJ
	HGz9ww5iMwvcZZI40M8GYgsLxErM2rGaBcRmEVCVeLPvFFg9L1B954dXzBAz5SVWbzgAZnMC
	xX/M6AXrFRIwlXi34BLTBEauBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLDeFntn4k7
	GL9cdj/EKMDBqMTD++Dx1nQh1sSy4srcQ4wSHMxKIrxt9VvShXhTEiurUovy44tKc1KLDzFK
	c7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhgVkh5HP29I0P5TYnToldmyfXmbbaZdK/y8
	1e7HjO2sKQe+ann5Lz3otuF5kXndQdW0JlXlYJf5/Tsfl9yO+f7pOaM9i1NtV8HRDp/eqU9P
	/uudv+LdXRX+t8KPf2raLta9t/iK0+8zGpOsD7198Siu6fP3qvdlMlO9ZqYqxPtZP3EQC+DL
	c61RYinOSDTUYi4qTgQATtMI518CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fault hander performs tlb flush pended by luf when a new pte becomes
to have write permission, no matter whether tlb flush required has been
performed or not.

By storing luf generation number, luf_ugen, in struct mm_struct, we can
skip unnecessary tlb flush.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/asm-generic/tlb.h |  2 +-
 include/linux/mm_types.h  |  9 +++++
 kernel/fork.c             |  1 +
 kernel/sched/core.c       |  2 +-
 mm/memory.c               | 22 ++++++++++--
 mm/pgtable-generic.c      |  2 +-
 mm/rmap.c                 | 74 +++++++++++++++++++++++++++++++++++++--
 7 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4a99351be111e..94b329a5127a7 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -552,7 +552,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	/*
 	 * Don't leave stale tlb entries for this vma.
 	 */
-	luf_flush(0);
+	luf_flush_vma(vma);
 
 	if (tlb->fullmm)
 		return;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b3eb5a4e45efb..8de4c190ad514 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -38,8 +38,10 @@ struct luf_batch {
 	unsigned long ugen;
 	rwlock_t lock;
 };
+void luf_batch_init(struct luf_batch *lb);
 #else
 struct luf_batch {};
+static inline void luf_batch_init(struct luf_batch *lb) {}
 #endif
 
 /*
@@ -1022,6 +1024,9 @@ struct mm_struct {
 		 * moving a PROT_NONE mapped page.
 		 */
 		atomic_t tlb_flush_pending;
+
+		/* luf batch for this mm */
+		struct luf_batch luf_batch;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 		/* See flush_tlb_batched_pending() */
 		atomic_t tlb_flush_batched;
@@ -1272,8 +1277,12 @@ extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 void luf_flush(unsigned short luf_key);
+void luf_flush_mm(struct mm_struct *mm);
+void luf_flush_vma(struct vm_area_struct *vma);
 #else
 static inline void luf_flush(unsigned short luf_key) {}
+static inline void luf_flush_mm(struct mm_struct *mm) {}
+static inline void luf_flush_vma(struct vm_area_struct *vma) {}
 #endif
 
 struct vm_fault;
diff --git a/kernel/fork.c b/kernel/fork.c
index 0061cf2450efd..593e74235ea8a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1268,6 +1268,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
 	spin_lock_init(&mm->arg_lock);
+	luf_batch_init(&mm->luf_batch);
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aea08d8a9e258..c7665cb93f617 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5225,7 +5225,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop_lazy_tlb_sched(mm);
-		luf_flush(0);
+		luf_flush_mm(mm);
 	}
 
 	if (unlikely(prev_state == TASK_DEAD)) {
diff --git a/mm/memory.c b/mm/memory.c
index 0e85c49bc5028..b02f86b1adb91 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6081,6 +6081,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
 	bool is_droppable;
+	struct address_space *mapping = NULL;
 	bool flush = false;
 
 	__set_current_state(TASK_RUNNING);
@@ -6112,9 +6113,17 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	 * should be considered.
 	 */
 	if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE) ||
-			flags & FAULT_FLAG_WRITE)
+			flags & FAULT_FLAG_WRITE) {
 		flush = true;
 
+		/*
+		 * Doesn't care the !VM_SHARED cases because it won't
+		 * update the pages that might be shared with others.
+		 */
+		if (vma->vm_flags & VM_SHARED && vma->vm_file)
+			mapping = vma->vm_file->f_mapping;
+	}
+
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
 	else
@@ -6149,8 +6158,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	/*
 	 * Ensure to clean stale tlb entries for this vma.
 	 */
-	if (flush)
-		luf_flush(0);
+	if (flush) {
+		/*
+		 * If it has a VM_SHARED mapping, all the mms involved
+		 * should be luf_flush'ed.
+		 */
+		if (mapping)
+			luf_flush(0);
+		luf_flush_mm(mm);
+	}
 
 	return ret;
 }
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 215d8d93560fd..5a876c1c93a80 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -100,7 +100,7 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	if (pte_accessible(mm, pte))
 		flush_tlb_page(vma, address);
 	else
-		luf_flush(0);
+		luf_flush_vma(vma);
 	return pte;
 }
 #endif
diff --git a/mm/rmap.c b/mm/rmap.c
index cf6667fb18fe2..e0304dc74c3a7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -695,7 +695,7 @@ void fold_batch(struct tlbflush_unmap_batch *dst,
  */
 struct luf_batch luf_batch[NR_LUF_BATCH];
 
-static void luf_batch_init(struct luf_batch *lb)
+void luf_batch_init(struct luf_batch *lb)
 {
 	rwlock_init(&lb->lock);
 	reset_batch(&lb->batch);
@@ -778,6 +778,31 @@ void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src)
 	read_unlock_irqrestore(&src->lock, flags);
 }
 
+static void fold_luf_batch_mm(struct luf_batch *dst,
+		struct mm_struct *mm)
+{
+	unsigned long flags;
+	bool need_fold = false;
+
+	read_lock_irqsave(&dst->lock, flags);
+	if (arch_tlbbatch_need_fold(&dst->batch.arch, mm))
+		need_fold = true;
+	read_unlock(&dst->lock);
+
+	write_lock(&dst->lock);
+	if (unlikely(need_fold))
+		arch_tlbbatch_add_pending(&dst->batch.arch, mm, 0);
+
+	/*
+	 * dst->ugen represents sort of request for tlb shootdown.  The
+	 * newer it is, the more tlb shootdown might be needed to
+	 * fulfill the newer request.  Keep the newest one not to miss
+	 * necessary tlb shootdown.
+	 */
+	dst->ugen = new_luf_ugen();
+	write_unlock_irqrestore(&dst->lock, flags);
+}
+
 static unsigned long tlb_flush_start(void)
 {
 	/*
@@ -894,6 +919,49 @@ void luf_flush(unsigned short luf_key)
 }
 EXPORT_SYMBOL(luf_flush);
 
+void luf_flush_vma(struct vm_area_struct *vma)
+{
+	struct mm_struct *mm;
+	struct address_space *mapping = NULL;
+
+	if (!vma)
+		return;
+
+	mm = vma->vm_mm;
+	/*
+	 * Doesn't care the !VM_SHARED cases because it won't
+	 * update the pages that might be shared with others.
+	 */
+	if (vma->vm_flags & VM_SHARED && vma->vm_file)
+		mapping = vma->vm_file->f_mapping;
+
+	if (mapping)
+		luf_flush(0);
+	luf_flush_mm(mm);
+}
+
+void luf_flush_mm(struct mm_struct *mm)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct luf_batch *lb;
+	unsigned long flags;
+	unsigned long lb_ugen;
+
+	if (!mm)
+		return;
+
+	lb = &mm->luf_batch;
+	read_lock_irqsave(&lb->lock, flags);
+	fold_batch(tlb_ubc, &lb->batch, false);
+	lb_ugen = lb->ugen;
+	read_unlock_irqrestore(&lb->lock, flags);
+
+	if (arch_tlbbatch_diet(&tlb_ubc->arch, lb_ugen))
+		return;
+
+	try_to_unmap_flush();
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -962,8 +1030,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 
 	if (!can_luf_test())
 		tlb_ubc = &current->tlb_ubc;
-	else
+	else {
 		tlb_ubc = &current->tlb_ubc_ro;
+		fold_luf_batch_mm(&mm->luf_batch, mm);
+	}
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
 	tlb_ubc->flush_required = true;
-- 
2.17.1


