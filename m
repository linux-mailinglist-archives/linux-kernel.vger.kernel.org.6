Return-Path: <linux-kernel+bounces-193750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C48D317D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E0028DDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF49C16A375;
	Wed, 29 May 2024 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMyE4q/2"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018516A36D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971371; cv=none; b=AoehRg/TNaHzEPJc5Nz3C4sGMooF/fGncoHwgCnVyiTQl9dbbf5dD5DIiJmICST2B3NFrSzAyvg2ghWffE+MLFKVHPh/wpR5kkVx76i14bqiSHe9cJYv0t5CMGF0JTeBOwHrsg9Hk2aput2VosBSmYOLuc4hpAyzw1qpyh39Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971371; c=relaxed/simple;
	bh=XCAlxfa4dcd7ZXSZyKWnqYITEwMpdGHxcWPUNoGZmLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htna/LYZMblwehCpVZgauMd0mIuMBfWvqdYDXf8lYG9wxD3ka3s973X+9FpXzMnJXkcTsvkDZSp5uoLCWRPui6DWd75oPfvBkyZq+GtQm3dgung1z7LDNlfjGO8PyFZ+4isTYDywnu5g1vtYGwc5HaDHDk0YQmXN8UOyN36ph84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMyE4q/2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso482543b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971369; x=1717576169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxE2mAKSIadz3iJIa+4kx5y9ZNqImGpGMb9QcvFrG9A=;
        b=BMyE4q/2Rx12IicJL0GHmfnuvgS3MljR1+LDx3lHyRRrEfbtveSSE3sl+q2hXSoyLa
         iwULnpLvj6eY/oUDFvefvHgD6plYLrdbsLbLdzX55lEj8hipWZ3QSOLVeTxja85H3s+c
         D4gQPW5xrE+EvxK8g+bAvJsiS14M2XtIrkKjmUk0oWA5WOfuBXO9Y/oPsFuUlpEH73BY
         lx/k9ao7xT4+gR9+QclNpj+XTN/0v+kfdS2m/wU72azqh02GkkEZiPKDEiWO5ewgBpxM
         7dx9Xyc/z+lCY8GS5gxFBr4pJlM0s3H9OxKtff4hYRAHjba80g2GkMD1X4sNsUruUhOd
         0l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971369; x=1717576169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxE2mAKSIadz3iJIa+4kx5y9ZNqImGpGMb9QcvFrG9A=;
        b=Yncn1jzCQDpfjLqi21JXPf84kt/agKsHFojelstrokk4Asa3TQROBxoQXfEvzN2EZP
         V8gQm2LaW51/PTKxOu92d0IMu6Yu/ZSgiaHcMIqBvFNU3UWg85K6CvIQkDKbSXUiTIWt
         6KyhtrLrBk/QqeoWybl/8mwhWOE/YExCH/cjC9HhsYFKyoMwa182ck+Fhu9HwXnuY0OO
         yIT8yWWcivCkZg6ICdV7zovSMESIcwpeeYlbbcNQPbCl+YdOZwMrYiersN/0JTk2i9XX
         tvuNo3lkgO9TDO+c9ELul9uXLM67T98pJfGpeuuMsDBHWYtNaICMrUaAibJ+DoMuyQQy
         XcRg==
X-Forwarded-Encrypted: i=1; AJvYcCXjn2cDbhX3WYniJ5ottIBVGvwHkSJoFTZAUiMYbuL6XY7UQsEMyRONBVTmeyfRO9/6HQYkQawr8eux7H9hS+sbPeyrRx57FzWEO5a7
X-Gm-Message-State: AOJu0YzRCyo7YzqfVyTCi2eFQYg//VDo2+ZKWTSKT69rOLkEYn5oHIq7
	aA5cJaj2N+qViMUzVGDRmfOiBTLSatHgumwuk+DcHwE0y53loJYr
X-Google-Smtp-Source: AGHT+IEbSGge22ETQ01VYggngJlR3UpTZl4VLPzOebNpH6caOUJ2L4BysvKHtwvqOmVKwJG58Oyn5g==
X-Received: by 2002:a05:6a00:2fd1:b0:702:1d51:98f7 with SMTP id d2e1a72fcca58-7021d519c44mr490666b3a.2.1716971368774;
        Wed, 29 May 2024 01:29:28 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702220d948bsm174916b3a.131.2024.05.29.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:29:28 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v5 6/6] mm: swap: entirely map large folios found in swapcache
Date: Wed, 29 May 2024 20:28:24 +1200
Message-Id: <20240529082824.150954-7-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082824.150954-1-21cnbao@gmail.com>
References: <20240529082824.150954-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

When a large folio is found in the swapcache, the current implementation
requires calling do_swap_page() nr_pages times, resulting in nr_pages
page faults. This patch opts to map the entire large folio at once to
minimize page faults. Additionally, redundant checks and early exits
for ARM64 MTE restoring are removed.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/memory.c | 59 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 10719e5afecb..eef4e482c0c2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4016,6 +4016,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
+	int nr_pages;
+	unsigned long page_idx;
+	unsigned long address;
+	pte_t *ptep;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4214,6 +4218,38 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
+	nr_pages = 1;
+	page_idx = 0;
+	address = vmf->address;
+	ptep = vmf->pte;
+	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
+		int nr = folio_nr_pages(folio);
+		unsigned long idx = folio_page_idx(folio, page);
+		unsigned long folio_start = address - idx * PAGE_SIZE;
+		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
+		pte_t *folio_ptep;
+		pte_t folio_pte;
+
+		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
+			goto check_folio;
+		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
+			goto check_folio;
+
+		folio_ptep = vmf->pte - idx;
+		folio_pte = ptep_get(folio_ptep);
+		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
+		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
+			goto check_folio;
+
+		page_idx = idx;
+		address = folio_start;
+		ptep = folio_ptep;
+		nr_pages = nr;
+		entry = folio->swap;
+		page = &folio->page;
+	}
+
+check_folio:
 	/*
 	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
 	 * must never point at an anonymous page in the swapcache that is
@@ -4273,12 +4309,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.
 	 */
-	swap_free(entry);
+	swap_free_nr(entry, nr_pages);
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -4295,27 +4331,28 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-	flush_icache_page(vma, page);
+	folio_ref_add(folio, nr_pages - 1);
+	flush_icache_pages(vma, page, nr_pages);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
 	if (pte_swp_uffd_wp(vmf->orig_pte))
 		pte = pte_mkuffd_wp(pte);
-	vmf->orig_pte = pte;
+	vmf->orig_pte = pte_advance_pfn(pte, page_idx);
 
 	/* ksm created a completely new copy */
 	if (unlikely(folio != swapcache && swapcache)) {
-		folio_add_new_anon_rmap(folio, vma, vmf->address);
+		folio_add_new_anon_rmap(folio, vma, address);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
 					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
-			pte, vmf->orig_pte, 1);
+	set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
+	arch_do_swap_page_nr(vma->vm_mm, vma, address,
+			pte, pte, nr_pages);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
@@ -4339,7 +4376,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.34.1


