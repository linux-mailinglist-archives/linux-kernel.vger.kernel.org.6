Return-Path: <linux-kernel+bounces-235854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078991DA75
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F07BB247BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4E83CD2;
	Mon,  1 Jul 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hw2M6CIu"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160F1422D6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823700; cv=none; b=DkvmpJCRalpR6P77D4WpzHGZcbrjXsU7jaQbCdrlogq1thouH578uW6p2nFd1mTfo0y0m0hf6G26WbsN37IwPQhehVd1b6ZnD7skU1hojLslO4acbWYwe86LRDoEARMmbLCzAc+QuflBEV5UpyqPztpY8poiSkmyx4Sd1Ocl+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823700; c=relaxed/simple;
	bh=1Em7AXJPWdgt61EPZ6VQJawCRR1SjB0ps0MYBWKKCVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDnWXr4tKMCU6eJQpur/y/oZL7XQjc/y7Lx8fnEyJuPU/RbVhBu5AsjO3wmAxYn7FDFAgrSZoptzg6Ah+0uT5WaseJ6eOOuZ7g2Xcj4fk6CP0AAye06Hbg/ETyJmbFFnBfP5tmiJDfw9KsEkFo3LIjCNrSeVmzRhgBcQt7y2FO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hw2M6CIu; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25075f3f472so403766fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719823697; x=1720428497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heRFBrzmiSFbf80Ldx88bwYUpXRT+UgzgGRtnFqgbfo=;
        b=Hw2M6CIuH/gjWNhW8sDj7rX6IG3i2PuKysulRDbkhBqXTsScNnAlcttxMjo0UCptKU
         is+vUndLOhQJa3I7k6IuxH+9E/3ZfvxPcI0rwEhQejqQWSoRMX4LDapdOCE59/5JvNeB
         jfDL7ow2dXFBUft3e45WHopqA4l7iOo5wmSllTIsMEI0k/0IRvFqCncoAZ742oOEVXg4
         86QuVcEOcM0jVwdEd3k6lMGl+Wd7Z8IQlxAjLzb8W9I+W5LinzyYOQE26yhIibH3egux
         ryPxeEZed3EnCgNy6GgL9MxbiBwWB4Jx4MDzcIGu1Htv3eC2kUXLtoOOIaHyAU0u/kCb
         LZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823697; x=1720428497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heRFBrzmiSFbf80Ldx88bwYUpXRT+UgzgGRtnFqgbfo=;
        b=DlgnCmPpuFxue/8vnXSVb4OOtVRKfE1Kc7JOEYugPC4WFNwtBH/YWg2tB/RYbBN3T3
         wPv4X1qzqpXmINA6Ec8EgBA3P5FThZhIlVqB8ebVqbJWHvgpoZvicHLGAQDm7HITQZ3a
         yLnRH/+LWoKibvX9/XpcmjGimzlmiM7l5RGEBfNVl+MAEpcIIdSUQYXbNRHmNAXL0lrC
         CsNuFgzRIaD+jY2tBQcc9oOBGZLZ8DWbvWpdd+YlcUF8i8Na9qEUFqJY90IdHjGcEhUJ
         XDsRS6p77MTf1SMtJa85klsyKQbWsv4aXB3j+voQRKV2QV/2GIhdZnvCkaeLLc4busNI
         Z+bg==
X-Forwarded-Encrypted: i=1; AJvYcCWUG6oypSVCgZq4jcN5zX6+7CHlMVwbHBAIM1+Hp0Xt9t3owVIk+sfiglSr4LWciI9ASsDNvf9h37i7/6abfjN3cE5rTssN0YVqvkyE
X-Gm-Message-State: AOJu0YyOqCPTR3tu7f1EA8JcsKluVzCgZt2Z5M81/PJTZgMsG2uhAY+4
	iCtvUpi01p/F3bs3eamHT7mK4y97pOmnOM55MES5uis56hSGEUIffdWMF/DReVM=
X-Google-Smtp-Source: AGHT+IFFB2WixvwXraavN9qiwzLbm4r9XSaP2jQhzM0/LqY8bBCt0wrI3ZybaGE0lHA7u/jpjEN+uQ==
X-Received: by 2002:a05:6870:3751:b0:254:affe:5a08 with SMTP id 586e51a60fabf-25db340a2d2mr4729423fac.2.1719823697112;
        Mon, 01 Jul 2024 01:48:17 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a7e7e0sm5932374b3a.204.2024.07.01.01.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:48:16 -0700 (PDT)
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
Subject: [RFC PATCH 3/7] mm: pass address information to pmd_install()
Date: Mon,  1 Jul 2024 16:46:44 +0800
Message-Id: <e4159f85fea52587a4586dcdef70d1630681ebf8.1719570849.git.zhengqi.arch@bytedance.com>
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

In the subsequent implementation of freeing empty page table pages,
we need the address information to flush tlb, so pass address to
pmd_install() in advance.

No functional changes.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/hugetlb.h |  2 +-
 include/linux/mm.h      |  9 +++++----
 mm/debug_vm_pgtable.c   |  2 +-
 mm/filemap.c            |  2 +-
 mm/gup.c                |  2 +-
 mm/internal.h           |  3 ++-
 mm/memory.c             | 15 ++++++++-------
 mm/migrate_device.c     |  2 +-
 mm/mprotect.c           |  8 ++++----
 mm/mremap.c             |  2 +-
 mm/userfaultfd.c        |  6 +++---
 11 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a951c0d06061..55715eb5cb34 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -198,7 +198,7 @@ static inline pte_t *pte_offset_huge(pmd_t *pmd, unsigned long address)
 static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
 				    unsigned long address)
 {
-	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
+	return pte_alloc(mm, pmd, address) ? NULL : pte_offset_huge(pmd, address);
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 396bdc3b3726..880100a8b472 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2800,7 +2800,7 @@ static inline void mm_inc_nr_ptes(struct mm_struct *mm) {}
 static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
 #endif
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
 int __pte_alloc_kernel(pmd_t *pmd);
 
 #if defined(CONFIG_MMU)
@@ -2987,13 +2987,14 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdvalp,
 	pte_unmap(pte);					\
 } while (0)
 
-#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
+#define pte_alloc(mm, pmd, addr)			\
+	(unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd, addr))
 
 #define pte_alloc_map(mm, pmd, address)			\
-	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
+	(pte_alloc(mm, pmd, address) ? NULL : pte_offset_map(pmd, address))
 
 #define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
-	(pte_alloc(mm, pmd) ?			\
+	(pte_alloc(mm, pmd, address) ?			\
 		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
 
 #define pte_alloc_kernel(pmd, address)			\
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index e4969fb54da3..18375744e184 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1246,7 +1246,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 	args->start_pmdp = pmd_offset(args->pudp, 0UL);
 	WARN_ON(!args->start_pmdp);
 
-	if (pte_alloc(args->mm, args->pmdp)) {
+	if (pte_alloc(args->mm, args->pmdp, args->vaddr)) {
 		pr_err("Failed to allocate pte entries\n");
 		ret = -ENOMEM;
 		goto error;
diff --git a/mm/filemap.c b/mm/filemap.c
index 35bbba960447..d8b936d87eb4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3453,7 +3453,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	}
 
 	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
-		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
+		pmd_install(mm, vmf->pmd, vmf->address, &vmf->prealloc_pte);
 
 	return false;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 8bea9ad80984..b87b1ea9d008 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1105,7 +1105,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		split_huge_pmd(vma, pmd, address);
 		/* If pmd was left empty, stuff a page table in there quickly */
-		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
+		return pte_alloc(mm, pmd, address) ? ERR_PTR(-ENOMEM) :
 			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
 	page = follow_huge_pmd(vma, address, pmd, flags, ctx);
diff --git a/mm/internal.h b/mm/internal.h
index 2ea9a88dcb95..1dfdad110a9a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -320,7 +320,8 @@ void folio_activate(struct folio *folio);
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked);
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		 pgtable_t *pte);
 
 struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
diff --git a/mm/memory.c b/mm/memory.c
index 1c9068b0b067..09db2c97cc5c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -417,7 +417,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 	} while (vma);
 }
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		 pgtable_t *pte)
 {
 	spinlock_t *ptl = pmd_lock(mm, pmd);
 
@@ -443,13 +444,13 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 	spin_unlock(ptl);
 }
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
 {
 	pgtable_t new = pte_alloc_one(mm);
 	if (!new)
 		return -ENOMEM;
 
-	pmd_install(mm, pmd, &new);
+	pmd_install(mm, pmd, addr, &new);
 	if (new)
 		pte_free(mm, new);
 	return 0;
@@ -2115,7 +2116,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 	/* Allocate the PTE if necessary; takes PMD lock once only. */
 	ret = -ENOMEM;
-	if (pte_alloc(mm, pmd))
+	if (pte_alloc(mm, pmd, addr))
 		goto out;
 
 	while (pages_to_write_in_pmd) {
@@ -4521,7 +4522,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 * Use pte_alloc() instead of pte_alloc_map(), so that OOM can
 	 * be distinguished from a transient failure of pte_offset_map().
 	 */
-	if (pte_alloc(vma->vm_mm, vmf->pmd))
+	if (pte_alloc(vma->vm_mm, vmf->pmd, vmf->address))
 		return VM_FAULT_OOM;
 
 	/* Use the zero-page for reads */
@@ -4868,8 +4869,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		}
 
 		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
+			pmd_install(vma->vm_mm, vmf->pmd, vmf->address, &vmf->prealloc_pte);
+		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd, vmf->address)))
 			return VM_FAULT_OOM;
 	}
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1c6ffa..e4d2e19e6611 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -598,7 +598,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto abort;
 	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
 		goto abort;
-	if (pte_alloc(mm, pmdp))
+	if (pte_alloc(mm, pmdp, addr))
 		goto abort;
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 222ab434da54..1a1537ddffe4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -330,11 +330,11 @@ pgtable_populate_needed(struct vm_area_struct *vma, unsigned long cp_flags)
  * allocation failures during page faults by kicking OOM and returning
  * error.
  */
-#define  change_pmd_prepare(vma, pmd, cp_flags)				\
+#define  change_pmd_prepare(vma, pmd, addr, cp_flags)			\
 	({								\
 		long err = 0;						\
 		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {	\
-			if (pte_alloc(vma->vm_mm, pmd))			\
+			if (pte_alloc(vma->vm_mm, pmd, addr))		\
 				err = -ENOMEM;				\
 		}							\
 		err;							\
@@ -375,7 +375,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 again:
 		next = pmd_addr_end(addr, end);
 
-		ret = change_pmd_prepare(vma, pmd, cp_flags);
+		ret = change_pmd_prepare(vma, pmd, addr, cp_flags);
 		if (ret) {
 			pages = ret;
 			break;
@@ -402,7 +402,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 				 * cleared; make sure pmd populated if
 				 * necessary, then fall-through to pte level.
 				 */
-				ret = change_pmd_prepare(vma, pmd, cp_flags);
+				ret = change_pmd_prepare(vma, pmd, addr, cp_flags);
 				if (ret) {
 					pages = ret;
 					break;
diff --git a/mm/mremap.c b/mm/mremap.c
index f672d0218a6f..7723d11e77cd 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -628,7 +628,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		}
 		if (pmd_none(*old_pmd))
 			continue;
-		if (pte_alloc(new_vma->vm_mm, new_pmd))
+		if (pte_alloc(new_vma->vm_mm, new_pmd, new_addr))
 			break;
 		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
 			      new_vma, new_pmd, new_addr, need_rmap_locks) < 0)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 61c1d228d239..e1674580b54f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -796,7 +796,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			break;
 		}
 		if (unlikely(pmd_none(dst_pmdval)) &&
-		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
+		    unlikely(__pte_alloc(dst_mm, dst_pmd, dst_addr))) {
 			err = -ENOMEM;
 			break;
 		}
@@ -1713,13 +1713,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 					err = -ENOENT;
 					break;
 				}
-				if (unlikely(__pte_alloc(mm, src_pmd))) {
+				if (unlikely(__pte_alloc(mm, src_pmd, src_addr))) {
 					err = -ENOMEM;
 					break;
 				}
 			}
 
-			if (unlikely(pte_alloc(mm, dst_pmd))) {
+			if (unlikely(pte_alloc(mm, dst_pmd, dst_addr))) {
 				err = -ENOMEM;
 				break;
 			}
-- 
2.20.1


