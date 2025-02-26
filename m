Return-Path: <linux-kernel+bounces-533731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB5A45E20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D546178875
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B62222CA;
	Wed, 26 Feb 2025 12:01:57 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955E221720
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571316; cv=none; b=XtWc9HhC/IzE7gLyNaphtBTwM8hTVNriFgV9+d3TbWpFWA9dl3WH1vlWMY6e5oDuhajVFyMmBcRMR3SoftPxr14/ntQjEIOo+iFW+tXSDLWangJilRUzUuy9eDgWnxCNEXod4xTul3wb0P2UYc8KT3vZX2q91akpnjKoTvJ9Tj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571316; c=relaxed/simple;
	bh=4iVb5yuPmYTLZuOVv49V7Uhnq0iVXjEoivtmvCASALI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AU+OA9VAdmP1eXhYg2eszV/ZbJWjjabBGWkRBh+1w1ug9selaT/1PtXL+9emjB/eb2rUYgwYulbB5ngpHwZ7Hc8bSr6pgvz4gcfN/3F+p6IfAQOuxrpnkvP/qOY2y8x54fEOQjAWATWke8xClqMs+mNV1EkH9TZnZKM9h4zeqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-21-67bf02a7b6fa
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 19/25] mm: skip luf tlb flush for luf'd mm that already has been done
Date: Wed, 26 Feb 2025 21:01:26 +0900
Message-Id: <20250226120132.28469-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBpfmyFrMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV0bP9XlMBS12Fe/mb2JqYNxl1MXI
	ySEhYCKx+vBDVhh77pmLLCA2m4C6xI0bP5lBbBEBM4mDrX/Yuxi5OJgFljFJ7D3RwAbiCAu0
	Mkr8v7SUCaSKRUBVYvujF2AdvEAdVy78ZYaYKi+xesMBMJsTKP5v9292EFtIIFmiZf1vFpBB
	EgL32ST2tR9hhGiQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECA3tZ7Z/o
	HYyfLgQfYhTgYFTi4X1wZm+6EGtiWXFl7iFGCQ5mJRFezsw96UK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYkwR8lrRb/Zmp+9V1D0vUPqPYSZ6m4Yz5
	rSqrVp89wheqMdH1xtFtG6Ojfijt/XFoR2ULS8Y61Yu81qr3p1388Mm0+/D0eieDb7e7hAxO
	dl9ovWuZrmI4Y8mZEjuHZiPp1v9Z3FYH1rdYdQkbMv53cXPSWfKc7ycX19tzBXdk34unnnN+
	ZrRIiaU4I9FQi7moOBEA2Y0ne2gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrLucaX+6wdNNIhZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBl9Fyfx1TQYlfx
	bv4mpgbGXUZdjJwcEgImEnPPXGQBsdkE1CVu3PjJDGKLCJhJHGz9w97FyMXBLLCMSWLviQY2
	EEdYoJVR4v+lpUwgVSwCqhLbH70A6+AF6rhy4S8zxFR5idUbDoDZnEDxf7t/s4PYQgLJEi3r
	f7NMYORawMiwilEkM68sNzEzx1SvODujMi+zQi85P3cTIzBMl9X+mbiD8ctl90OMAhyMSjy8
	D87sTRdiTSwrrsw9xCjBwawkwsuZuSddiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6
	YklqdmpqQWoRTJaJg1OqgdGwWU7/2eG3U0+aWc06mVXAruR6rNdi46rfTyOMlvY5uuxY+Yr5
	a8zBWQxGR+ZsvX/EV8xPcOvK5Y8zf6/9fO2a9RVmnzemdlNf+GfuupbZ9ldviU2TaGnxEU6/
	BY5/jnQwsbQErQp2mTx/i+SOkL+rlDM7tiYqSmsuVNOPU3sQ9G55w4x9kg+UWIozEg21mIuK
	EwHu8XZ8TwIAAA==
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
index 4b7d29d8ea794..5be3487bd9192 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -570,7 +570,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	/*
 	 * Don't leave stale tlb entries for this vma.
 	 */
-	luf_flush(0);
+	luf_flush_vma(vma);
 
 	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
 		return;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 117f8e822e969..c32ef19a25056 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -39,8 +39,10 @@ struct luf_batch {
 	unsigned long ugen;
 	rwlock_t lock;
 };
+void luf_batch_init(struct luf_batch *lb);
 #else
 struct luf_batch {};
+static inline void luf_batch_init(struct luf_batch *lb) {}
 #endif
 
 /*
@@ -1073,6 +1075,9 @@ struct mm_struct {
 		 * moving a PROT_NONE mapped page.
 		 */
 		atomic_t tlb_flush_pending;
+
+		/* luf batch for this mm */
+		struct luf_batch luf_batch;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 		/* See flush_tlb_batched_pending() */
 		atomic_t tlb_flush_batched;
@@ -1355,8 +1360,12 @@ extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
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
index 364b2d4fd3efa..15274eabc727d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1265,6 +1265,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
 	spin_lock_init(&mm->arg_lock);
+	luf_batch_init(&mm->luf_batch);
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f4c5da800365..ec132abbbce6e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5275,7 +5275,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop_lazy_tlb_sched(mm);
-		luf_flush(0);
+		luf_flush_mm(mm);
 	}
 
 	if (unlikely(prev_state == TASK_DEAD)) {
diff --git a/mm/memory.c b/mm/memory.c
index e496d8deb887f..93e5879583b07 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6216,6 +6216,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
 	bool is_droppable;
+	struct address_space *mapping = NULL;
 	bool flush = false;
 
 	__set_current_state(TASK_RUNNING);
@@ -6247,9 +6248,17 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
@@ -6284,8 +6293,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
index d6678d6bac746..545d401db82c1 100644
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
index 579c75f46c170..fe9c4606ae542 100644
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
+		arch_tlbbatch_add_pending(&dst->batch.arch, mm, 0, -1UL);
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
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, start, end);
 	tlb_ubc->flush_required = true;
-- 
2.17.1


