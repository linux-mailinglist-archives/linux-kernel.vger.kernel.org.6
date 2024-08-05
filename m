Return-Path: <linux-kernel+bounces-274682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1B8947B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926B81C2127C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC615B977;
	Mon,  5 Aug 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RDJbBh3n"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E06915B0FF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862553; cv=none; b=cP9Itgf62kkGwftFPuy7My05GZK7c7Uby7FzOia4DiFrTZ2HUqCoqoMy7erp9ZkcMjJ65TcDxM27BvZRfuijtUNpwjbadRc2wHi1dXvUI7EyMJz9GUNJEuWVp6akJfQ4FqQMerqY9AVCAvXqheA0e6rMSlQh53BBk6LIV9POxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862553; c=relaxed/simple;
	bh=K7Alr5MmTYl8M2Nek6l/USUCt8iBbjOZ/iyVmgmRNig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GncSM8JY3gF+/FEPuy5vMqZCCaxr+NfAR9q2J0ElVYoDPCvIIs6mFmHi9dokFqXl+mk0iDZZJWr5qwIHsBr/LHVNBHa/qM443PLUa020r1Zk0Yoq/pxhAd6LkljneLNcqcfffv3yJr/usUaIlqkly6HipwZGD2U/1javKAnXWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RDJbBh3n; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2635abdc742so1417945fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722862550; x=1723467350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E/n3u69l82MknfkBVWlLtitLQrhUjJGa1Gd08uFtUg=;
        b=RDJbBh3nhWBaUUfIY5GnXrkZbBqKEaX+6luBxBMXpwoAUCzoZTNRVT3SJ+3/0F1DMR
         CCYs8kU8Ap7k0Vtma/JxLyNgFnazSebtwWgr5dIFeBwpeAmSoEMg24lFCzmiCgdT0n6L
         UhKL+IhF+54osZ8oL/uBc2X79Ak4HDu41xINIJoFwPcwpvP87+Ot52/KODPpF0NPHBjS
         V+RrfXX35gUgRWO7qIBt8B+nWyK813tekY7P26T1XrAXiXPf0Oy4dCsup843LVkCV1XW
         3Yo+6e5gi5Itmvw17GyJERglzxfUIrXkGrk4nzjLSCPF0A0Qs6aX9MHTsvKZ28FmKiob
         F/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862550; x=1723467350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E/n3u69l82MknfkBVWlLtitLQrhUjJGa1Gd08uFtUg=;
        b=MfhDNBIH8i5aNBciKxrYnyCKCLnPRAG7BQ32PSUE1UqsahCwNs7yCGhJMd2ycP9B1q
         Z3JE+S3x1XNRlVFgUcDeCZS8IRGe1xLAd9130UYobLtb+VpWb/knyGjP2Z4xCCL+CAMx
         6LyZ51q2kX82LJadAUfKcbLWDy0ub5zLWDHBsPOhT8IMPi3pCLheDB/noZnWiaOsoPhk
         BWXhG54H+W0WRkaUFby+l5kMZZpVoSB6o/Jd5addrwqG/Z5RDgS5zDf5ShtWUNunWpnq
         sSoThPjbynEPZaPMCVPZDbr4EP38yLxORH0RnUBVZSbQv0r2v+LkxOxeDKCtIJmX0m+E
         wMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4iADmgSJ1uWh+z8DfaOq4e3aUzwP/48480fASFhxaPQ6kwHK7ZX0FccLQnuE438BF3lPP5O7gPnkBGws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XEa7aZkXPKWSGmkBiH3L3snifuChH7wcZ0FQJ/CNJybEE25G
	CjE3FpoAAwJ8HEUwuIPs6vkjrmeDZ1mjA34yNjL/ULPJA5tMnrEwyVt0jFNLAm0=
X-Google-Smtp-Source: AGHT+IFv0DoB3b0vEye0FjjGUQbE4c0I7YpIv3kq3xPjqljbSw0tByADYY9Wsgd4q3ipuhDCRO/jUQ==
X-Received: by 2002:a05:6871:338c:b0:25e:44b9:b2ee with SMTP id 586e51a60fabf-26891aa626amr6693054fac.2.1722862550191;
        Mon, 05 Aug 2024 05:55:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm5503030b3a.142.2024.08.05.05.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:55:49 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH v2 1/7] mm: pgtable: make pte_offset_map_nolock() return pmdval
Date: Mon,  5 Aug 2024 20:55:05 +0800
Message-Id: <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1722861064.git.zhengqi.arch@bytedance.com>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make pte_offset_map_nolock() return pmdval so that we can recheck the
*pmd once the lock is taken. This is a preparation for freeing empty
PTE pages, no functional changes are expected.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/mm/split_page_table_lock.rst |  3 ++-
 arch/arm/mm/fault-armv.c                   |  2 +-
 arch/powerpc/mm/pgtable.c                  |  2 +-
 include/linux/mm.h                         |  4 ++--
 mm/filemap.c                               |  2 +-
 mm/khugepaged.c                            |  4 ++--
 mm/memory.c                                |  4 ++--
 mm/mremap.c                                |  2 +-
 mm/page_vma_mapped.c                       |  2 +-
 mm/pgtable-generic.c                       | 21 ++++++++++++---------
 mm/userfaultfd.c                           |  4 ++--
 mm/vmscan.c                                |  2 +-
 12 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
index e4f6972eb6c04..e6a47d57531cd 100644
--- a/Documentation/mm/split_page_table_lock.rst
+++ b/Documentation/mm/split_page_table_lock.rst
@@ -18,7 +18,8 @@ There are helpers to lock/unlock a table and other accessor functions:
 	pointer to its PTE table lock, or returns NULL if no PTE table;
  - pte_offset_map_nolock()
 	maps PTE, returns pointer to PTE with pointer to its PTE table
-	lock (not taken), or returns NULL if no PTE table;
+	lock (not taken) and the value of its pmd entry, or returns NULL
+	if no PTE table;
  - pte_offset_map()
 	maps PTE, returns pointer to PTE, or returns NULL if no PTE table;
  - pte_unmap()
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 831793cd6ff94..db07e6a05eb6e 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -117,7 +117,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
+	pte = pte_offset_map_nolock(vma->vm_mm, pmd, NULL, address, &ptl);
 	if (!pte)
 		return 0;
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 7316396e452d8..9b67d2a1457ed 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -398,7 +398,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	 */
 	if (pmd_none(*pmd))
 		return;
-	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+	pte = pte_offset_map_nolock(mm, pmd, NULL, addr, &ptl);
 	BUG_ON(!pte);
 	assert_spin_locked(ptl);
 	pte_unmap(pte);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 43b40334e9b28..b1ef2afe620c5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2937,8 +2937,8 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	return pte;
 }
 
-pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp);
+pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdvalp,
+			     unsigned long addr, spinlock_t **ptlp);
 
 #define pte_unmap_unlock(pte, ptl)	do {		\
 	spin_unlock(ptl);				\
diff --git a/mm/filemap.c b/mm/filemap.c
index 67c3f5136db33..3285dffb64cf8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3231,7 +3231,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return 0;
 
-	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
+	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, NULL, vmf->address,
 				     &vmf->ptl);
 	if (unlikely(!ptep))
 		return VM_FAULT_NOPAGE;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdd1d8655a76b..91b93259ee214 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1009,7 +1009,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		};
 
 		if (!pte++) {
-			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
+			pte = pte_offset_map_nolock(mm, pmd, NULL, address, &ptl);
 			if (!pte) {
 				mmap_read_unlock(mm);
 				result = SCAN_PMD_NULL;
@@ -1598,7 +1598,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
+	start_pte = pte_offset_map_nolock(mm, pmd, NULL, haddr, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
diff --git a/mm/memory.c b/mm/memory.c
index d6a9dcddaca4a..afd8a967fb953 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1108,7 +1108,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		ret = -ENOMEM;
 		goto out;
 	}
-	src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
+	src_pte = pte_offset_map_nolock(src_mm, src_pmd, NULL, addr, &src_ptl);
 	if (!src_pte) {
 		pte_unmap_unlock(dst_pte, dst_ptl);
 		/* ret == 0 */
@@ -5671,7 +5671,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * it into a huge pmd: just retry later if so.
 		 */
 		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
-						 vmf->address, &vmf->ptl);
+						 NULL, vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
 		vmf->orig_pte = ptep_get_lockless(vmf->pte);
diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc6409..f672d0218a6fe 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -175,7 +175,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		err = -EAGAIN;
 		goto out;
 	}
-	new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
+	new_pte = pte_offset_map_nolock(mm, new_pmd, NULL, new_addr, &new_ptl);
 	if (!new_pte) {
 		pte_unmap_unlock(old_pte, old_ptl);
 		err = -EAGAIN;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae5cc42aa2087..507701b7bcc1e 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -33,7 +33,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	 * Though, in most cases, page lock already protects this.
 	 */
 	pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
-					  pvmw->address, ptlp);
+					  NULL, pvmw->address, ptlp);
 	if (!pvmw->pte)
 		return false;
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4adf711ac..443e3b34434a5 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -305,7 +305,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 	return NULL;
 }
 
-pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
+pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdvalp,
 			     unsigned long addr, spinlock_t **ptlp)
 {
 	pmd_t pmdval;
@@ -314,6 +314,8 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 	pte = __pte_offset_map(pmd, addr, &pmdval);
 	if (likely(pte))
 		*ptlp = pte_lockptr(mm, &pmdval);
+	if (pmdvalp)
+		*pmdvalp = pmdval;
 	return pte;
 }
 
@@ -347,14 +349,15 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
  * and disconnected table.  Until pte_unmap(pte) unmaps and rcu_read_unlock()s
  * afterwards.
  *
- * pte_offset_map_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_map();
- * but when successful, it also outputs a pointer to the spinlock in ptlp - as
- * pte_offset_map_lock() does, but in this case without locking it.  This helps
- * the caller to avoid a later pte_lockptr(mm, *pmd), which might by that time
- * act on a changed *pmd: pte_offset_map_nolock() provides the correct spinlock
- * pointer for the page table that it returns.  In principle, the caller should
- * recheck *pmd once the lock is taken; in practice, no callsite needs that -
- * either the mmap_lock for write, or pte_same() check on contents, is enough.
+ * pte_offset_map_nolock(mm, pmd, pmdvalp, addr, ptlp), above, is like
+ * pte_offset_map(); but when successful, it also outputs a pointer to the
+ * spinlock in ptlp - as pte_offset_map_lock() does, but in this case without
+ * locking it.  This helps the caller to avoid a later pte_lockptr(mm, *pmd),
+ * which might by that time act on a changed *pmd: pte_offset_map_nolock()
+ * provides the correct spinlock pointer for the page table that it returns.
+ * In principle, the caller should recheck *pmd once the lock is taken; But in
+ * most cases, either the mmap_lock for write, or pte_same() check on contents,
+ * is enough.
  *
  * Note that free_pgtables(), used after unmapping detached vmas, or when
  * exiting the whole mm, does not take page table lock before freeing a page
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3b7715ecf292a..aa3c9cc51cc36 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1143,7 +1143,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				src_addr, src_addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 retry:
-	dst_pte = pte_offset_map_nolock(mm, dst_pmd, dst_addr, &dst_ptl);
+	dst_pte = pte_offset_map_nolock(mm, dst_pmd, NULL, dst_addr, &dst_ptl);
 
 	/* Retry if a huge pmd materialized from under us */
 	if (unlikely(!dst_pte)) {
@@ -1151,7 +1151,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		goto out;
 	}
 
-	src_pte = pte_offset_map_nolock(mm, src_pmd, src_addr, &src_ptl);
+	src_pte = pte_offset_map_nolock(mm, src_pmd, NULL, src_addr, &src_ptl);
 
 	/*
 	 * We held the mmap_lock for reading so MADV_DONTNEED
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 31d13462571e6..b00cd560c0e43 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3378,7 +3378,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	DEFINE_MAX_SEQ(walk->lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(max_seq);
 
-	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
+	pte = pte_offset_map_nolock(args->mm, pmd, NULL, start & PMD_MASK, &ptl);
 	if (!pte)
 		return false;
 	if (!spin_trylock(ptl)) {
-- 
2.20.1


