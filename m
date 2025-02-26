Return-Path: <linux-kernel+bounces-533755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A4A45E36
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25097A6443
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC8522A7E9;
	Wed, 26 Feb 2025 12:03:59 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3CD227EB2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571438; cv=none; b=YE5ZONAQwF4GyO+5CjgNtkmbRFLXEWjiAera/s/Zktew9eJlGcA3c9O+z3AeZhuxAFJHV7biN+MDPWaRX/m2kg0SG0PvxsfxtkDrpxmwG8QQQLsagxftAqwcnSn1CkQawy1m8cTIR+E4+8RcVoFJxMbCKa2+yotvIYM4Lq5RkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571438; c=relaxed/simple;
	bh=CwH0kpoPbYzFiB52aHinMgJ0h9sta5Vu6UTGrqZ7GTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EbzZMOLfHlvj3bRZ+HdUnWMR23LWInB8xEwgvK5kZSfJMM+qAavqqfqFWwKoBlg7ayb8jRVfqNfaJ5uSTHZKuyoYdcZB8TgbsrDNwTP5ljhqQuCjZkAt4135gvDDTsEKC3N+ojrGae/xb+cJB1u14YdxZmlC4AoxzrWj0m6GVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-52-67bf03233e22
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
Subject: [RFC PATCH v12 based on v6.14-rc4 19/25] mm: skip luf tlb flush for luf'd mm that already has been done
Date: Wed, 26 Feb 2025 21:03:30 +0900
Message-Id: <20250226120336.29565-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnoa4y8/50gz3n+S3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2PWpBVMBWdtK/bNXsbawNhu1MXI
	ySEhYCLxeNoM9i5GDjC75bMrSJhNQF3ixo2fzCC2iICZxMHWP0AlXBzMAsuYJPaeaGADSQgL
	FEhMmrmfEcRmEVCV+Pv+CTuIzQvUsLnhLRPEfHmJ1RsOgA3iBIp/mnYMrFdIIFli5+8/TCBD
	JQTus0n0ta1khWiQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECg3pZ7Z/o
	HYyfLgQfYhTgYFTi4X1wZm+6EGtiWXFl7iFGCQ5mJRFezsw96UK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYLWuFs1caPNJW0LW7t3XVH9dpa/T+fck/
	22Sw+OdPX8dL1hsm6+avWv12Jg+z4dX4XJdPOsczszbvtIuf+i/yvOqOiKgLX564J/04N//B
	kmihBwult+6UOq4yQ643tPzz+ltvnJLKf/Tlf9/nu1lldcMv2eKw7D+nl+V4bZ7JyGx2bp+h
	WHlTshJLcUaioRZzUXEiAJJ5FJJmAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvMvD/dYNdRNos569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyZk1awVRw1rZi
	3+xlrA2M7UZdjBwcEgImEi2fXbsYOTnYBNQlbtz4yQxiiwiYSRxs/cPexcjFwSywjEli74kG
	NpCEsECBxKSZ+xlBbBYBVYm/75+wg9i8QA2bG94ygdgSAvISqzccABvECRT/NO0YWK+QQLLE
	zt9/mCYwci1gZFjFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGKLLav9M3MH45bL7IUYBDkYl
	Ht4HZ/amC7EmlhVX5h5ilOBgVhLh5czcky7Em5JYWZValB9fVJqTWnyIUZqDRUmc1ys8NUFI
	ID2xJDU7NbUgtQgmy8TBKdXAWLFP/nnHxW1xMxp+7f5nydUtOnN7T2jh9N8tPc+uMkdef9NW
	vVxtwtzV4tMzzAwf7H8pcfUFb+OyNbqJXHfFPaptWzvk9DqNRfkyLa9fZf97szv1ze7TiRKO
	Ok1+p7tkD4V9nxzxJ/RDv1pjiOM3rksWOmfbdj5/1Kjwq+Z481UpaakLVRZblFiKMxINtZiL
	ihMBcPghPE0CAAA=
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
index 5bb6b05bd3549..f156e8cb3bd4a 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -568,7 +568,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	/*
 	 * Don't leave stale tlb entries for this vma.
 	 */
-	luf_flush(0);
+	luf_flush_vma(vma);
 
 	if (tlb->fullmm)
 		return;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cb9e6282b7ad1..2ac93d4f67c15 100644
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
@@ -1059,6 +1061,9 @@ struct mm_struct {
 		 * moving a PROT_NONE mapped page.
 		 */
 		atomic_t tlb_flush_pending;
+
+		/* luf batch for this mm */
+		struct luf_batch luf_batch;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 		/* See flush_tlb_batched_pending() */
 		atomic_t tlb_flush_batched;
@@ -1341,8 +1346,12 @@ extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
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
index 735405a9c5f32..ece87fece2113 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1280,6 +1280,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
index c1d2d2b0112cd..52bd45fe00f55 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6181,6 +6181,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
 	bool is_droppable;
+	struct address_space *mapping = NULL;
 	bool flush = false;
 
 	__set_current_state(TASK_RUNNING);
@@ -6212,9 +6213,17 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
@@ -6249,8 +6258,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
index fcd27200efa04..d68cfd28e0939 100644
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


