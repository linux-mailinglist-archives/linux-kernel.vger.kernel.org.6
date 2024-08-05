Return-Path: <linux-kernel+bounces-274684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34195947B6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF21F282266
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEAC15D5C7;
	Mon,  5 Aug 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JIIRD1Rm"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1F15B995
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862563; cv=none; b=McMc1U2bcjSK8i8aqG9WjjvVY7aKc47hAggMlqjLxpcYqCAD/IMRE2auYodEidyPHuKdMb+6urMJs0Uo8WIgZ7ulioh7E7ex+RgIP4ZsCFLa+GWNZOHOMOUQTbJETHclSZSniabO9u1ek9tr4rKvD/R0QhyoZvZ4aSSFb2QS2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862563; c=relaxed/simple;
	bh=Nwv1k6bT3cXMhwbJoDYqVUEvjQvNxaIfaxouQYBgczY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZuhzgjRi1vaSIMG95mwKa6hxloq4wSL5KZ8ERpOjJwxDoETsgO5Rd0BTCB4hTmqtpwaTgGrxIMW9+9E2kZfxTyXcgaDNA0SZT9CwTJ4cbiq9aWeMlPYR3oxkAd45SiDEGI21Xi9Rhss+JCqEB5RZq2Hzxs5qwY2aBvyNT9gLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JIIRD1Rm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d19bfdabbso252651b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722862561; x=1723467361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhrH1Q9NnZeRUJcj26yTP/GgTj/smFAH27zlkHuMnIM=;
        b=JIIRD1RmBcBzuoyJUWMY9E3Ggdn6xWnJihL7QgzerdfO6rpid412F+gzMb8xRpuI9i
         ZYDGGa4/aiYyrmukmg21uRl65e0xOX/zvTKxtRWGczEgtpTwxaRIhNZngf1YEhBWY7Ii
         RIJ1oN4CVJXli76O/gDv3S6566AbD7MIb9moc7AWcglI8RlseLFOOverlBJNRFVm0PSK
         FRkxA/LoBnXZbjv3DtAAIOnlngh2MP14OzqgQ8873rUq2UDFMn9ZmidtqbF9Wghs6Ra8
         Z84N5eeqvS8TsZ+c8ljP4E40RoxhSkLLCz0O0kW6rKvgSDe6/WU9+9+CeUrsrW3xFsyv
         4sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862561; x=1723467361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhrH1Q9NnZeRUJcj26yTP/GgTj/smFAH27zlkHuMnIM=;
        b=jUw0zSNvU4/IEIgaFGlvJ4iVHBb/4abMIWMAiz0AYa1YSgbTZD9SVpLBaOVyqPgx4N
         gchcbEXYvH1Mn5tnYpCSTpwoa1yH4WPNjqNoeDrRnKO5K9ioJl3O95BiHyBKqGa2XRrz
         qt4DW8iPS2aZga0J81IFtNbE4zhPOXSbik8QLPNQ4uYFW7X1gXWIg78uqoxn32gA5dKC
         wdnztjy2EfnN1IyoBTPUPfsYWrOoYW/ckDqrPL7RWDPo1OO/ci5c+gkrdYbr7ymiBS81
         joJ7XZakH0s2hkGXu6vxE+U6WhtZO1Eghs6qtJ44PYKOo0jJynlI5mmOUzY/wdmX7Nlt
         +8dg==
X-Forwarded-Encrypted: i=1; AJvYcCUx9DXVgmzuEMWHb7QBvBquFbYUapGHOn/7Ev+hpBLoXdIjPb/3ZosH0xZLb9QfUcAWytdhB/nbGbiF3sZOQZRyKvgm9mT0w0TKJGZ/
X-Gm-Message-State: AOJu0YwUHV/aciDf0WfcaJsi37fimqScpaIt3NOppezlk3RSnposkI15
	CS7y1Zm8uMndLp4E52x9IXAk088g9rk/MkNjSSQNDMhkXAYGLdpoWozLICCuyGY=
X-Google-Smtp-Source: AGHT+IFKE0ajxoQQC50+uF8r9y1IJZQgbjRdiBt9JdNBowXPi+FU6ZnE1IQEVkFfZ4V1YKUGUyQ/8Q==
X-Received: by 2002:a05:6a00:a17:b0:710:5d11:ec2f with SMTP id d2e1a72fcca58-7106cdd9fd4mr9461205b3a.0.1722862560754;
        Mon, 05 Aug 2024 05:56:00 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm5503030b3a.142.2024.08.05.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:55:59 -0700 (PDT)
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
Subject: [RFC PATCH v2 3/7] mm: pass address information to pmd_install()
Date: Mon,  5 Aug 2024 20:55:07 +0800
Message-Id: <095dc55b68ef4650e2eaf66ad7dd2feabe87f89e.1722861064.git.zhengqi.arch@bytedance.com>
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
index a76db143bffee..fcdcef367fffe 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -189,7 +189,7 @@ static inline pte_t *pte_offset_huge(pmd_t *pmd, unsigned long address)
 static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
 				    unsigned long address)
 {
-	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
+	return pte_alloc(mm, pmd, address) ? NULL : pte_offset_huge(pmd, address);
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b1ef2afe620c5..f0b821dcb085b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2758,7 +2758,7 @@ static inline void mm_inc_nr_ptes(struct mm_struct *mm) {}
 static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
 #endif
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
 int __pte_alloc_kernel(pmd_t *pmd);
 
 #if defined(CONFIG_MMU)
@@ -2945,13 +2945,14 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdvalp,
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
index e4969fb54da34..18375744e1845 100644
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
index 3285dffb64cf8..efcb8ae3f235f 100644
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
index d19884e097fd2..53c3b73810150 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -972,7 +972,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		split_huge_pmd(vma, pmd, address);
 		/* If pmd was left empty, stuff a page table in there quickly */
-		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
+		return pte_alloc(mm, pmd, address) ? ERR_PTR(-ENOMEM) :
 			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
 	page = follow_huge_pmd(vma, address, pmd, flags, ctx);
diff --git a/mm/internal.h b/mm/internal.h
index 52f7fc4e8ac30..dfc992de01115 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -325,7 +325,8 @@ void folio_activate(struct folio *folio);
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked);
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		 pgtable_t *pte);
 
 struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
diff --git a/mm/memory.c b/mm/memory.c
index afd8a967fb953..fef1e425e4702 100644
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
@@ -4686,7 +4687,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 * Use pte_alloc() instead of pte_alloc_map(), so that OOM can
 	 * be distinguished from a transient failure of pte_offset_map().
 	 */
-	if (pte_alloc(vma->vm_mm, vmf->pmd))
+	if (pte_alloc(vma->vm_mm, vmf->pmd, vmf->address))
 		return VM_FAULT_OOM;
 
 	/* Use the zero-page for reads */
@@ -5033,8 +5034,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		}
 
 		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
+			pmd_install(vma->vm_mm, vmf->pmd, vmf->address, &vmf->prealloc_pte);
+		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd, vmf->address)))
 			return VM_FAULT_OOM;
 	}
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1c6ffa0..e4d2e19e6611d 100644
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
index 37cf8d249405d..7b58db622f825 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -329,11 +329,11 @@ pgtable_populate_needed(struct vm_area_struct *vma, unsigned long cp_flags)
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
@@ -374,7 +374,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 again:
 		next = pmd_addr_end(addr, end);
 
-		ret = change_pmd_prepare(vma, pmd, cp_flags);
+		ret = change_pmd_prepare(vma, pmd, addr, cp_flags);
 		if (ret) {
 			pages = ret;
 			break;
@@ -401,7 +401,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 				 * cleared; make sure pmd populated if
 				 * necessary, then fall-through to pte level.
 				 */
-				ret = change_pmd_prepare(vma, pmd, cp_flags);
+				ret = change_pmd_prepare(vma, pmd, addr, cp_flags);
 				if (ret) {
 					pages = ret;
 					break;
diff --git a/mm/mremap.c b/mm/mremap.c
index f672d0218a6fe..7723d11e77cd2 100644
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
index aa3c9cc51cc36..41d659bd2589c 100644
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


