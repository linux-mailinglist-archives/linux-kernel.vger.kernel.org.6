Return-Path: <linux-kernel+bounces-235851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EEB91DA70
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC2E1F22A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17577BAF7;
	Mon,  1 Jul 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AMg7PV1w"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F827E0F0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823691; cv=none; b=sKe6SbboN0uleNRNmJVByHIsKmIgo8RR4dI69563ObTROfcAR+1ewhJhwKJN6k7ES6JND5pYPGHahGpvkjrIXe2N/gY9HNQpLIV/tU4Wgo97pZJAeRDEe49eYkLeXlO0OZchWFpUxfy8dzo5o2vVs14g1HnG8Js4mS/XOPMiVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823691; c=relaxed/simple;
	bh=57pyErQ/lQI1jaoNtZJZVniKMVd85FM8A2zYAkEXh6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1QOEQ7cgYuDW4YGbV5DnIjsMPMdX5lYtKFbkj/VYAmr1QHubZC8WNitDoCaP9MBFzCl2veeQA/aktH5yEMnhFJ4hzXKEqGMighZ9D4TXJ3/ZVIPGQwYrqowNGV2QXdHJTBqStCkbXEAF/lAQJbn7C592Q4EmjqYMVKCXJzwdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AMg7PV1w; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f4cfed0fddso7155639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719823689; x=1720428489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FEjQRmnZwv5IniDvqPInjdkphsULH24MtgWxf3WNnc=;
        b=AMg7PV1w9+lAmBI+y79TWPN+u3lrH3FaJjoAboRoHBPmxnTIVMrFjNs/tQLJpbGX0X
         WSV5wzroVVlQvUFRiyrGtPr/YJD7SQvoMob3xeWIOkcpQz7AgDumI9//XMSwt/OA5Fyr
         K+uCdQ9aZg1Y8TbOQVfGbiFwzOBQgLt/+7gdoIeuJc9AwN3adxMtUnNOkHVIJxMXPOyo
         9mnU4Ry9V0HIe4kVLIVBDzsd2Lrbb1VwGjTbVMGjBL9wNSTSIgy9FgAc5clXWfGm7sX1
         iHbpHT4xa6hd9zdP/2+h06zfsUT+HFrEX25/A2kWyHOofFkKCBJvANSJ2krmp/Zder4N
         b+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823689; x=1720428489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FEjQRmnZwv5IniDvqPInjdkphsULH24MtgWxf3WNnc=;
        b=dXSDKgIwDperOv+sFCv9Un5M08giGKuv+o6ZZWJ3dzeqMr7TxqBGt8K5g9jIZ/TNnU
         sl5Kfk5s3qQfmO4tNpy7uD15Bm5X6c2+pE/NtcUozJ/5sM86U7nJmnLtUYQoR/nNIeoX
         79i3tbU7wsUtqlqLxecmKtayJc5McJzeRd7EUX6t4jsszUC+Gc0Vp7og6ZhE+wGSGEd5
         togRLz/Yv6grCun5mUwtSIwAqzHbONpV8KSwGyOg0QTFFKdf09An2bxmnfnQJ2IZp88f
         ioc8IQ76HFveWNKmyNvNflVRTeG3nt7a0jVU885tWiwAdDI4VgpIBjrt8TRfPIJnNB6J
         DLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMhX1FiK3LKpuWKDOqdpDcL5yOfmLBzug9NEJ0iWgG2BpRviqIRmKYvzQ7E9QP9MiMAk/5o6fuv5C1qHff5IWi6DoIl6mJ3lja63qW
X-Gm-Message-State: AOJu0Yy8s5Nzsu6s+fo1tCN3sDvEnB3pjv/9hD8iAJmq4ebBjVUB1Hk+
	ZnKCYptNKfcsiSqME+v/RU07WELxqxZFrjSJl1/r7Nmy7BrfryIQnXh94E8t+TU=
X-Google-Smtp-Source: AGHT+IFNREJpAukQmSF+e3y8DudZ+fBumzStMqKfWS9xBvY6s+QthbSABnLkfofffgxBCHUpAfSNuw==
X-Received: by 2002:a5d:9b8e:0:b0:7f3:a20e:c38f with SMTP id ca18e2360f4ac-7f62ed4cf57mr403632739f.0.1719823688743;
        Mon, 01 Jul 2024 01:48:08 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a7e7e0sm5932374b3a.204.2024.07.01.01.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:48:08 -0700 (PDT)
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
Subject: [RFC PATCH 1/7] mm: pgtable: make pte_offset_map_nolock() return pmdval
Date: Mon,  1 Jul 2024 16:46:42 +0800
Message-Id: <7f5233f9f612c7f58abf218852fb1042d764940b.1719570849.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1719570849.git.zhengqi.arch@bytedance.com>
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
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
index e4f6972eb6c0..e6a47d57531c 100644
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
index 2286c2ea60ec..3e4ed99b9330 100644
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
index 9e7ba9c3851f..ab0250f1b226 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -350,7 +350,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	 */
 	if (pmd_none(*pmd))
 		return;
-	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+	pte = pte_offset_map_nolock(mm, pmd, NULL, addr, &ptl);
 	BUG_ON(!pte);
 	assert_spin_locked(ptl);
 	pte_unmap(pte);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7d044e737dba..396bdc3b3726 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2979,8 +2979,8 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	return pte;
 }
 
-pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp);
+pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdvalp,
+			     unsigned long addr, spinlock_t **ptlp);
 
 #define pte_unmap_unlock(pte, ptl)	do {		\
 	spin_unlock(ptl);				\
diff --git a/mm/filemap.c b/mm/filemap.c
index 6835977ee99a..35bbba960447 100644
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
index 2e017585f813..7b7c858d5f99 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -989,7 +989,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		};
 
 		if (!pte++) {
-			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
+			pte = pte_offset_map_nolock(mm, pmd, NULL, address, &ptl);
 			if (!pte) {
 				mmap_read_unlock(mm);
 				result = SCAN_PMD_NULL;
@@ -1578,7 +1578,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
+	start_pte = pte_offset_map_nolock(mm, pmd, NULL, haddr, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
diff --git a/mm/memory.c b/mm/memory.c
index 0a769f34bbb2..1c9068b0b067 100644
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
@@ -5507,7 +5507,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * it into a huge pmd: just retry later if so.
 		 */
 		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
-						 vmf->address, &vmf->ptl);
+						 NULL, vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
 		vmf->orig_pte = ptep_get_lockless(vmf->pte);
diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc640..f672d0218a6f 100644
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
index ae5cc42aa208..507701b7bcc1 100644
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
index a78a4adf711a..443e3b34434a 100644
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
index 8dedaec00486..61c1d228d239 100644
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
index 3d4c681c6d40..c9a4cd31e6b4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3373,7 +3373,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	DEFINE_MAX_SEQ(walk->lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(max_seq);
 
-	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
+	pte = pte_offset_map_nolock(args->mm, pmd, NULL, start & PMD_MASK, &ptl);
 	if (!pte)
 		return false;
 	if (!spin_trylock(ptl)) {
-- 
2.20.1


