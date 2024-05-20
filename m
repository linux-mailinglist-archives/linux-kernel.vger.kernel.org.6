Return-Path: <linux-kernel+bounces-184125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542A8CA2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392621C20C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441131386B3;
	Mon, 20 May 2024 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf9PJgQ4"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791718EBF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234530; cv=none; b=fOSKnay25AfYfX+91muqMjslou7+HnyaLU8i/qqUZ8C6sfveypa89OqwIlz8vLaOuMKjmy6mM0DbwkrCCz5W+2ldEo7Oo8Yk5CdQk1OP3m9njceRiZNIa87BQBsBcBxURIxDLIKNNtbioJ7mI1e6kQslmJHB2yefxHEBJozU9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234530; c=relaxed/simple;
	bh=HEsM47HF6mcipvDTHY2N5vZlfa3QUdtia5u5E/euMOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UbMMFqpVdltLPBKFPn8WbtsmKHoAoZ2ZRdwU/pTRZfUbSp1FW+zIy6yIJyptgZ6FMRGx65euY9WuaDcVm+FYw5+8uLMk5g72NfjAl4SV/FuIBfAurM0orEcZ6UTc3tDZn1/LOtGjeImxFDWKTw1vZzk6qk2hMUG/WmumOncLO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf9PJgQ4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-622ce869e9bso33903317b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716234527; x=1716839327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CxHZ56zm4ItHAREln0MAqCnqcbTO0AQUe9UM1z9zLfY=;
        b=hf9PJgQ4wNmsLJI/3iVtq/KQD0lN1Ax5vyAS/taMpJOcbtY/+LkGeuEMbPxdD5DSd0
         +IGw7sqplzsgkL0pWyt2XFxOQOz8A/V2oaMXo1k7Kv453wiXe2Oda4//gdnas2v3k9wK
         dzxtCW9U6wHTSinjcpV1u03iI6J221xAGbwXYUCf5kGKOophWb2Z2m19zhRxZxd0LsAs
         tTrvqwcSdRHcvLUhSB4bMGJpqUg90BV3QUArK3SxANCuryupaMdlPWaGLTYa8XoY62BL
         mdrrE7MQCkfWFiqvsy6sfsqB4xhJ6jGSjL2GpJfQhtxW+ffAgsswSvxVvA6rqqHT7nFM
         u1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716234527; x=1716839327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxHZ56zm4ItHAREln0MAqCnqcbTO0AQUe9UM1z9zLfY=;
        b=Fx8WhtDBSATeHRiiiSCvFAgkp8skpsRIiZokQLlu7P3Sl7WMyCR2s49EjvKOxFD9PY
         Vbu4PlbkaVwxvxjMxj1uk/48bnY+gd5z4bXf8Rs40+6OAWt9T/yGCbIt8606oWN1kW9y
         zXwK5/2AykTRbFcUNnjTV9Lp88FWJz1MfDbkvfBNc+d0vKc6O5eMZYa0tnwJioVTzds9
         pxcqf/dXRy3j23yzzoTBaWgVMAjNH/hToTXKVTG+dvzHk/JEDwEGO7e1BDwBYoXPV9z+
         sJpidyHNxMIRwzGqkFd0gMSnswkUkw4ZBOllgaPyaC+FVknAbXWEOd/1yV5LWzSKoten
         EFmg==
X-Forwarded-Encrypted: i=1; AJvYcCUeEJChAkyhcE1pXnllESGKkJJL1TZyQRMN8KyRGEQmILhgF8h52nslgmqIdGUFxxEVfkKSXIeMSxcTSM71QcVRaFMoEUgCB4TM9dyh
X-Gm-Message-State: AOJu0Yyaox2QjH3SdLLfrbUifWCE+yrVS0FpMVKfli1kC7KRSFBDbFp2
	r68cn2fEiUeJ/5qvQUeBQcTxtkU7rWUN19t+cJ1hfQ+3nT2RKeoR
X-Google-Smtp-Source: AGHT+IGRVnzRuJy3FzjwWKxx39LtXKiCJCYMf1/eg0CGPu5354+L2uqAHc6D7tg5dpC89Hd4MY3IAg==
X-Received: by 2002:a81:e24d:0:b0:61a:c316:9953 with SMTP id 00721157ae682-622aff42b46mr301350797b3.11.1716234527493;
        Mon, 20 May 2024 12:48:47 -0700 (PDT)
Received: from fedora.attlocal.net ([2600:1700:2f7d:1800::42])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6209e346760sm50695827b3.78.2024.05.20.12.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:48:47 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] Convert __unmap_hugepage_range() to folios
Date: Mon, 20 May 2024 12:47:49 -0700
Message-ID: <20240520194749.334896-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces 4 calls to compound_head() with one. Also converts
unmap_hugepage_range() and unmap_ref_private() to take in folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/hugetlb.h |  6 ++---
 mm/hugetlb.c            | 50 ++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 68244bb3637a..6c7ce8679950 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -137,12 +137,12 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 				      unsigned long address, unsigned int flags,
 				      unsigned int *page_mask);
 void unmap_hugepage_range(struct vm_area_struct *,
-			  unsigned long, unsigned long, struct page *,
+			  unsigned long, unsigned long, struct folio *,
 			  zap_flags_t);
 void __unmap_hugepage_range(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
-			  struct page *ref_page, zap_flags_t zap_flags);
+			  struct folio *ref_folio, zap_flags_t zap_flags);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo_node(int nid);
@@ -458,7 +458,7 @@ static inline long hugetlb_change_protection(
 
 static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page,
+			unsigned long end, struct folio *ref_folio,
 			zap_flags_t zap_flags)
 {
 	BUG();
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..02f40bfa3686 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5643,14 +5643,14 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			    unsigned long start, unsigned long end,
-			    struct page *ref_page, zap_flags_t zap_flags)
+			    struct folio *ref_folio, zap_flags_t zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
 	pte_t *ptep;
 	pte_t pte;
 	spinlock_t *ptl;
-	struct page *page;
+	struct folio *folio;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
 	bool adjust_reservation = false;
@@ -5663,7 +5663,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	/*
 	 * This is a hugetlb vma, all the pte entries should point
-	 * to huge page.
+	 * to huge folio.
 	 */
 	tlb_change_page_size(tlb, sz);
 	tlb_start_vma(tlb, vma);
@@ -5714,19 +5714,19 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			continue;
 		}
 
-		page = pte_page(pte);
+		folio = page_folio(pte_page(pte));
 		/*
-		 * If a reference page is supplied, it is because a specific
-		 * page is being unmapped, not a range. Ensure the page we
-		 * are about to unmap is the actual page of interest.
+		 * If a reference folio is supplied, it is because a specific
+		 * folio is being unmapped, not a range. Ensure the folio we
+		 * are about to unmap is the actual folio of interest.
 		 */
-		if (ref_page) {
-			if (page != ref_page) {
+		if (ref_folio) {
+			if (folio != ref_folio) {
 				spin_unlock(ptl);
 				continue;
 			}
 			/*
-			 * Mark the VMA as having unmapped its page so that
+			 * Mark the VMA as having unmapped its folio so that
 			 * future faults in this VMA will fail rather than
 			 * looking like data was lost
 			 */
@@ -5736,7 +5736,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		pte = huge_ptep_get_and_clear(mm, address, ptep);
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
-			set_page_dirty(page);
+			folio_mark_dirty(folio);
 		/* Leave a uffd-wp pte marker if needed */
 		if (huge_pte_uffd_wp(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
@@ -5744,17 +5744,17 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 					make_pte_marker(PTE_MARKER_UFFD_WP),
 					sz);
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		hugetlb_remove_rmap(page_folio(page));
+		hugetlb_remove_rmap(folio);
 
 		/*
-		 * Restore the reservation for anonymous page, otherwise the
-		 * backing page could be stolen by someone.
+		 * Restore the reservation for anonymous folio, otherwise the
+		 * backing folio could be stolen by someone.
 		 * If there we are freeing a surplus, do not set the restore
 		 * reservation bit.
 		 */
 		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
-		    folio_test_anon(page_folio(page))) {
-			folio_set_hugetlb_restore_reserve(page_folio(page));
+		    folio_test_anon(folio)) {
+			folio_set_hugetlb_restore_reserve(folio);
 			/* Reservation to be adjusted after the spin lock */
 			adjust_reservation = true;
 		}
@@ -5771,11 +5771,11 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (adjust_reservation && vma_needs_reservation(h, vma, address))
 			vma_add_reservation(h, vma, address);
 
-		tlb_remove_page_size(tlb, page, huge_page_size(h));
+		tlb_remove_page_size(tlb, &folio->page, huge_page_size(h));
 		/*
-		 * Bail out after unmapping reference page if supplied
+		 * Bail out after unmapping reference folio if supplied
 		 */
-		if (ref_page)
+		if (ref_folio)
 			break;
 	}
 	tlb_end_vma(tlb, vma);
@@ -5837,7 +5837,7 @@ void __hugetlb_zap_end(struct vm_area_struct *vma,
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, struct page *ref_page,
+			  unsigned long end, struct folio *ref_folio,
 			  zap_flags_t zap_flags)
 {
 	struct mmu_notifier_range range;
@@ -5849,7 +5849,7 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 	mmu_notifier_invalidate_range_start(&range);
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
-	__unmap_hugepage_range(&tlb, vma, start, end, ref_page, zap_flags);
+	__unmap_hugepage_range(&tlb, vma, start, end, ref_folio, zap_flags);
 
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
@@ -5862,7 +5862,7 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
  * same region.
  */
 static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
-			      struct page *page, unsigned long address)
+			      struct folio *folio, unsigned long address)
 {
 	struct hstate *h = hstate_vma(vma);
 	struct vm_area_struct *iter_vma;
@@ -5898,7 +5898,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 
 		/*
-		 * Unmap the page from other VMAs without their own reserves.
+		 * Unmap the folio from other VMAs without their own reserves.
 		 * They get marked to be SIGKILLed if they fault in these
 		 * areas. This is because a future no-page fault on this VMA
 		 * could insert a zeroed page instead of the data existing
@@ -5906,7 +5906,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h), page, 0);
+					     address + huge_page_size(h), folio, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
@@ -6035,7 +6035,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-			unmap_ref_private(mm, vma, &old_folio->page,
+			unmap_ref_private(mm, vma, old_folio,
 					vmf->address);
 
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
-- 
2.45.0


