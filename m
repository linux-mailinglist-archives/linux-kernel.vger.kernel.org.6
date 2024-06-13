Return-Path: <linux-kernel+bounces-212849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8EE906734
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8BEB27CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34158142900;
	Thu, 13 Jun 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="El6R5jRZ"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8E1428F5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267966; cv=none; b=InGqDZn9tduq3920klYOvY07Fwn+SLk9pPWSAuYFfnq7vk6X6vOPORkt65hpRkQIW3XfhPn4l43h18JzFF+RTyC9r7GEr/PoIMSkK6m0M2PRrprt8N3zKCvuANaI+GmVxBpbQS0XBbAkohrVZVw3RhlyLwm+G/KFHHbUrdG11tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267966; c=relaxed/simple;
	bh=o3mXUY/N7b/OpNwSmmjqL7RvyAw6IigAabnLHhCtYHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClC3aQtzHLL37jHw2QrpS7Mt/oxiuI2QXnY7C/Xr79M33bmJtD/3kmfMbss5R/jeOCTDbg1C+VuH9k4RZopeFsLGCBeGW2hV/hY92gP8fPJX+eg/2zDU34hyQtk6RNJR7hAA/EW3KUWN2elcRT1LGTwQCrFUK4PI3zcPaWXsmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=El6R5jRZ; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254ceab70e3so121235fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718267963; x=1718872763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CewtBWl7EeBPsRvYcQKXFLRJSGy2eXvxF5yP4Eq9hNE=;
        b=El6R5jRZMKjhbqNYWUfwdhsfj9ACpa4PVSvLckJ2On0Du9OaRJ9G+HJi0CSIpJnVg8
         dvEUs6GB744wsJ7itJuGdoB+3+dD+D5oFtn5touIP6mkJ2gnKEiKm52w0f9C9bRyvoLn
         Qla/VdH63zYEovDzxuFpSq9aPSqyNaeCexbOtjEeJ6VNRva8IK+PYhH0lBHDaZKsm0dn
         2RM9wVjBoSCbQWhutLTqUyKFyr60NJbez2pxxjJCOSoqgsulrqxkuLGwm7D8E9UVVWLj
         QBMtdgkVUdVB1Nui9h03z101wsLIms04MUjkv3mDYOmqXTN4xSJBDtstPzklLjuC62y4
         j1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267963; x=1718872763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CewtBWl7EeBPsRvYcQKXFLRJSGy2eXvxF5yP4Eq9hNE=;
        b=NXhz/MY6S/m7vfkGXviNdfhV1RJmd05k4M17jc7IN4QrUEgxlVnfnIEdKv2w5wRfBP
         ETs/xVqxlNnEBufKWZtzQwJ0pUijNW9GZm7XAyCDjzSUjrizOievyUHPcdwDY4qbYELX
         tw3Qh9LGhJjPwPDm/DmoFh4Jw/Koll4t15qtMzVhVBvxf8ZdPJWQDxlFUur7rAxlSORo
         a+LQqP3MOYppHG1zw+NKN+PG2UkWUkWZkk79akXJzP5D9psrEGiDdLagaGzyysKQmVhM
         earBpZrMij3CQby8Dv7hSmR0mUmTOlmyhMC6M6QJHaAb4r3pSYduQ0st7YDEBe7zR8Fg
         yHPw==
X-Forwarded-Encrypted: i=1; AJvYcCVhobsWZeuX9XvpsoxDhyGeTR85/R2xUyXJ60M587r/3u5MDqDGpzs0yTIrl9ZDtFzbkFz74mFXhv6oliO2BWXaK11v2um63g1dTbmO
X-Gm-Message-State: AOJu0Yz/0bWMCLCNjUIzHP8ZQS6k44angXNgbpxnz96v2qUGsgWL+2Ez
	A8OwWBSa2acsi3drriYdnzFmnALegRwRoNV/OuOPcA3GA6h447EATtBP8XB6aZA=
X-Google-Smtp-Source: AGHT+IF3BvBRGUqMq+LK1a8EUEuvL+E9w9pX4Nvfr12+FIihulto0pHvra8MZUn64vN2LmeV0o+qLQ==
X-Received: by 2002:a05:6870:95a8:b0:250:702f:8bab with SMTP id 586e51a60fabf-2551505f631mr4491220fac.3.1718267962761;
        Thu, 13 Jun 2024 01:39:22 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb980bdsm820856b3a.211.2024.06.13.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:39:22 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 3/3] mm: free empty user PTE pages
Date: Thu, 13 Jun 2024 16:38:10 +0800
Message-Id: <ae4b791a634572296b3b1f590c76a0a880e7eb9c.1718267194.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1718267194.git.zhengqi.arch@bytedance.com>
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now in order to pursue high performance, applications mostly use some
high-performance user-mode memory allocators, such as jemalloc or
tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
release page table memory, which may cause huge page table memory usage.

The following are a memory usage snapshot of one process which actually
happened on our server:

        VIRT:  55t
        RES:   590g
        VmPTE: 110g

In this case, most of the page table entries are empty. For such a PTE
page where all entries are empty, we can actually free it back to the
system for others to use.

Similar to numa_balancing, this commit adds a task_work to scan the
address space of the user process when it returns to user space. If a
suitable empty PTE page is found, it will be released.

The following code snippet can show the effect of optimization:

        mmap 50G
        while (1) {
                for (; i < 1024 * 25; i++) {
                        touch 2M memory
                        madvise MADV_DONTNEED 2M
                }
        }

As we can see, the memory usage of VmPTE is reduced:

                        before                          after
VIRT                   50.0 GB                        50.0 GB
RES                     3.1 MB                         3.1 MB
VmPTE                102640 kB                         756 kB (Even less)

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm_types.h |   4 +
 include/linux/pgtable.h  |  14 +++
 include/linux/sched.h    |   1 +
 kernel/sched/core.c      |   1 +
 kernel/sched/fair.c      |   2 +
 mm/Makefile              |   2 +-
 mm/freept.c              | 180 +++++++++++++++++++++++++++++++++++++++
 mm/khugepaged.c          |  18 +++-
 8 files changed, 220 insertions(+), 2 deletions(-)
 create mode 100644 mm/freept.c

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ef09c4eef6d3..bbc697fa4a83 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -839,6 +839,10 @@ struct mm_struct {
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
+		/* Next mm_pgtable scan (in jiffies) */
+		unsigned long mm_pgtable_next_scan;
+		/* Restart point for scanning and freeing empty user PTE pages */
+		unsigned long mm_pgtable_scan_offset;
 #endif
 		int map_count;			/* number of VMAs */
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index fbff20070ca3..4d1cfaa92422 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1589,6 +1589,20 @@ static inline unsigned long my_zero_pfn(unsigned long addr)
 }
 #endif /* CONFIG_MMU */
 
+#ifdef CONFIG_MMU
+#define MM_PGTABLE_SCAN_DELAY	100	/* 100ms */
+#define MM_PGTABLE_SCAN_SIZE	256	/* 256MB */
+void init_mm_pgtable_work(struct task_struct *p);
+void task_tick_mm_pgtable(struct task_struct *curr);
+#else
+static inline void init_mm_pgtable_work(struct task_struct *p)
+{
+}
+static inline void task_tick_mm_pgtable(struct task_struct *curr)
+{
+}
+#endif
+
 #ifdef CONFIG_MMU
 
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 73c874e051f7..5c0f3d96d608 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1485,6 +1485,7 @@ struct task_struct {
 #ifdef CONFIG_MMU
 	struct task_struct		*oom_reaper_list;
 	struct timer_list		oom_reaper_timer;
+	struct callback_head		pgtable_work;
 #endif
 #ifdef CONFIG_VMAP_STACK
 	struct vm_struct		*stack_vm_area;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c663075c86fb..d5f6df6f5c32 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4359,6 +4359,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->migration_pending = NULL;
 #endif
 	init_sched_mm_cid(p);
+	init_mm_pgtable_work(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..bbc7cbf22eaa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12696,6 +12696,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
+	task_tick_mm_pgtable(curr);
+
 	update_misfit_status(curr, rq);
 	check_update_overutilized_status(task_rq(curr));
 
diff --git a/mm/Makefile b/mm/Makefile
index 8fb85acda1b1..af1a324aa65e 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -54,7 +54,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o show_mem.o shmem_quota.o\
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o freept.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/freept.c b/mm/freept.c
new file mode 100644
index 000000000000..ed1ea5535e03
--- /dev/null
+++ b/mm/freept.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/userfaultfd_k.h>
+#include <linux/pagewalk.h>
+#include <linux/task_work.h>
+#include <linux/hugetlb.h>
+#include <asm/tlbflush.h>
+
+void task_tick_mm_pgtable(struct task_struct *curr)
+{
+	struct callback_head *work = &curr->pgtable_work;
+	unsigned long now = jiffies;
+
+	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
+	    work->next != work)
+		return;
+
+	if (time_before(now, READ_ONCE(curr->mm->mm_pgtable_next_scan)))
+		return;
+
+	task_work_add(curr, work, TWA_RESUME);
+}
+
+/*
+ * Locking:
+ *  - already held the mmap read lock to traverse the vma tree and pgtable
+ *  - use pmd lock for clearing pmd entry
+ *  - use pte lock for checking empty PTE page, and release it after clearing
+ *    pmd entry, then we can capture the changed pmd in pte_offset_map_lock()
+ *    etc after holding this pte lock. Thanks to this, we don't need to hold the
+ *    rmap-related locks.
+ *  - users of pte_offset_map_lock() etc all expect the PTE page to be stable by
+ *    using rcu lock, so use pte_free_defer() to free PTE pages.
+ */
+static int freept_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+			    struct mm_walk *walk)
+{
+	struct mmu_notifier_range range;
+	struct mm_struct *mm = walk->mm;
+	pte_t *start_pte, *pte;
+	pmd_t pmdval;
+	spinlock_t *pml = NULL, *ptl;
+	unsigned long haddr = addr;
+	int i;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+				haddr, haddr + PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	start_pte = pte_offset_map_nolock(mm, pmd, &pmdval, haddr, &ptl);
+	if (!start_pte)
+		goto out;
+
+	pml = pmd_lock(mm, pmd);
+	if (ptl != pml)
+		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd))))
+		goto out_ptl;
+
+	/* Check if it is empty PTE page */
+	for (i = 0, addr = haddr, pte = start_pte;
+	     i < PTRS_PER_PTE; i++, addr += PAGE_SIZE, pte++) {
+		if (!pte_none(ptep_get(pte)))
+			goto out_ptl;
+	}
+	pte_unmap(start_pte);
+
+	pmd_clear(pmd);
+	flush_tlb_range(walk->vma, haddr, haddr + PMD_SIZE);
+	pmdp_get_lockless_sync();
+	if (ptl != pml)
+		spin_unlock(ptl);
+	spin_unlock(pml);
+
+	mmu_notifier_invalidate_range_end(&range);
+
+	mm_dec_nr_ptes(mm);
+	pte_free_defer(mm, pmd_pgtable(pmdval));
+
+	return 0;
+
+out_ptl:
+	pte_unmap_unlock(start_pte, ptl);
+	if (pml != ptl)
+		spin_unlock(pml);
+out:
+	mmu_notifier_invalidate_range_end(&range);
+
+	return 0;
+}
+
+static const struct mm_walk_ops mm_pgtable_walk_ops = {
+	.pmd_entry = freept_pmd_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
+static void task_mm_pgtable_work(struct callback_head *work)
+{
+	unsigned long now = jiffies, old_scan, next_scan;
+	struct task_struct *p = current;
+	struct mm_struct *mm = p->mm;
+	struct vm_area_struct *vma;
+	unsigned long start, end;
+	struct vma_iterator vmi;
+
+	work->next = work;	/* Prevent double-add */
+	if (p->flags & PF_EXITING)
+		return;
+
+	if (!mm->mm_pgtable_next_scan) {
+		mm->mm_pgtable_next_scan = now + msecs_to_jiffies(MM_PGTABLE_SCAN_DELAY);
+		return;
+	}
+
+	old_scan = mm->mm_pgtable_next_scan;
+	if (time_before(now, old_scan))
+		return;
+
+	next_scan = now + msecs_to_jiffies(MM_PGTABLE_SCAN_DELAY);
+	if (!try_cmpxchg(&mm->mm_pgtable_next_scan, &old_scan, next_scan))
+		return;
+
+	if (!mmap_read_trylock(mm))
+		return;
+
+	start = mm->mm_pgtable_scan_offset;
+	vma_iter_init(&vmi, mm, start);
+	vma = vma_next(&vmi);
+	if (!vma) {
+		mm->mm_pgtable_scan_offset = 0;
+		start = 0;
+		vma_iter_set(&vmi, start);
+		vma = vma_next(&vmi);
+	}
+
+	do {
+		/* Skip hugetlb case  */
+		if (is_vm_hugetlb_page(vma))
+			continue;
+
+		/* Leave this to the THP path to handle */
+		if (vma->vm_flags & VM_HUGEPAGE)
+			continue;
+
+		/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
+		if (userfaultfd_wp(vma))
+			continue;
+
+		/* Only consider PTE pages that do not cross vmas */
+		start = ALIGN(vma->vm_start, PMD_SIZE);
+		end = ALIGN_DOWN(vma->vm_end, PMD_SIZE);
+		if (end - start < PMD_SIZE)
+			continue;
+
+		walk_page_range_vma(vma, start, end, &mm_pgtable_walk_ops, NULL);
+
+		if (end - mm->mm_pgtable_scan_offset >= (MM_PGTABLE_SCAN_SIZE << 20))
+			goto out;
+
+		cond_resched();
+	} for_each_vma(vmi, vma);
+
+out:
+	mm->mm_pgtable_scan_offset = vma ? end : 0;
+	mmap_read_unlock(mm);
+}
+
+void init_mm_pgtable_work(struct task_struct *p)
+{
+	struct mm_struct *mm = p->mm;
+	int mm_users = 0;
+
+	if (mm) {
+		mm_users = atomic_read(&mm->mm_users);
+		if (mm_users == 1)
+			mm->mm_pgtable_next_scan = jiffies + msecs_to_jiffies(MM_PGTABLE_SCAN_DELAY);
+	}
+	p->pgtable_work.next = &p->pgtable_work;	/* Protect against double add */
+	init_task_work(&p->pgtable_work, task_mm_pgtable_work);
+}
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2a8703ee876c..a2b96f4ba737 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1581,7 +1581,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, NULL, haddr, &ptl);
+	start_pte = pte_offset_map_nolock(mm, pmd, &pgt_pmd, haddr, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
@@ -1589,6 +1589,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	else if (ptl != pml)
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+	/* pmd entry may be changed by others */
+	if (unlikely(!pml && !pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
+		goto abort;
+
 	/* step 2: clear page table and adjust rmap */
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
@@ -1636,6 +1640,11 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		pml = pmd_lock(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+
+		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			spin_unlock(ptl);
+			goto unlock;
+		}
 	}
 	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
 	pmdp_get_lockless_sync();
@@ -1663,6 +1672,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	}
 	if (start_pte)
 		pte_unmap_unlock(start_pte, ptl);
+unlock:
 	if (pml && pml != ptl)
 		spin_unlock(pml);
 	if (notified)
@@ -1722,6 +1732,12 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		mmu_notifier_invalidate_range_start(&range);
 
 		pml = pmd_lock(mm, pmd);
+		/* check if the pmd is still valid */
+		if (check_pmd_still_valid(mm, addr, pmd) != SCAN_SUCCEED) {
+			spin_unlock(pml);
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
 		ptl = pte_lockptr(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
-- 
2.20.1


