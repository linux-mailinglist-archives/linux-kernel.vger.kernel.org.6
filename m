Return-Path: <linux-kernel+bounces-309790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F98967075
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2508D1F23339
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209EE172BAE;
	Sat, 31 Aug 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiyoCS7r"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DB16CD1D
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725096234; cv=none; b=e3y6X2PCIU5Dv+f4TYzbZfQvuK83xvi+AdkogC3KA454IJZz6oi/unx2nEjJ3utIHaySyK/sb5nPfBEVQU7Ie1Xx+gn5DuYnZJZU7eYFxMbGjhCSZ24ZvUJp1mbkq55Yns0BfposiHGbTkcxifL/MVykrCKiFBhXmfVmYXEcNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725096234; c=relaxed/simple;
	bh=LDDnrvUiospCxEoMOPC5RJUcdkqu+59rkT88lSSUM0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NrOVs/86MpcOU2kTyLXNanpmPieHlDkUp7Rz/nnUqvqDLfQgXhQr2o7pnsVXBxNCiyn7sAlBdWsord8Mqtq2tx/ZA0d2erhSUzD2h5uOPv0LvckoF+dDjVnpsioplMT3aDR+atiM+NLYgTOoO3vlTKJQks9FBD0vzGtf1xsf/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiyoCS7r; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso2209461b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725096232; x=1725701032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fv9dkRqIourVqSwVBm4LPpK+gxgzxpTEuDUkvn84/4c=;
        b=AiyoCS7r/IrpjF+xQvEoSESFIkC5njS1MA/tueYiNB5tmLX/FkSshupFCTOmTWdMsn
         I6NgFIwttbqizVtaIVR7Hlb1hWCPoM+B+pB5vy5eFErc/2YcD9KcMUXucFXUXDfF2CE6
         l1mgB9KZIvhOycWgu8HPoONwI+OT8XDkbbzZUTWGHCgtDpYhMx29DyKWbhV7fhibiGF0
         BSnq3OxkhyNmsDWp2dH7FGahgX364fGzpaPksKZXS4rHznSaoyFq4tfCfts4UMRfvbFX
         dtFyYF7xIQ/MvsNhs6za5e73x0zKPLz4PFGrWATez5l3vcTmC3uoKLkHj82XQrSapkFi
         UM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725096232; x=1725701032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fv9dkRqIourVqSwVBm4LPpK+gxgzxpTEuDUkvn84/4c=;
        b=o4taeqUyZeSCfk5f/LgWtDkoesvCJasJV3zpdwRvWES3WNZmxByXbqH1/AQKP9/YER
         Acegt3KHUffgoeZDalMGXnU8UNpsBQxgQpmi+AccCL6Jc283XMkJ4oJieM1e2mBRX3EA
         yTyiY/VYOguHSGFugyS43YY2LItwxDVn6/riO+2aJkrw0BxBJVgTtKTJAWVMNCag5/95
         7HZ0G4pJEeMCcjxEepPswQp+M4cLqwqzhSLcVbl7n4HG+JPxy2G//w8zi0tRR4D9q9IT
         NFModrTkgc2mv+mW8qTerFehvg67PfURBlBuG38TKTwR7NnVlILDAlvm2IN0UbQOK489
         90dg==
X-Gm-Message-State: AOJu0YyCJnJoITvh6wFepykJ5qH9U3ZnHzPzpMG87KRmakRJcnKMDQsq
	c3cJ9t4J0V6QEnWAcb+FgWw/w/Dl3KtS2hTfVSOz05WDXvBm2SrG
X-Google-Smtp-Source: AGHT+IEtNxeamvVQYRZG0BNxj4HrNxEbLU91xbnPcafwDm7ML9sK5hegUilwUujyxzU4VwlCjTjlHg==
X-Received: by 2002:a05:6a00:2d8f:b0:70d:2cf6:5e6 with SMTP id d2e1a72fcca58-717457cef02mr338224b3a.15.1725096231596;
        Sat, 31 Aug 2024 02:23:51 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:198b:37cd:b0d:f4fa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77f32fsm4262995a12.44.2024.08.31.02.23.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Aug 2024 02:23:51 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
Date: Sat, 31 Aug 2024 21:23:39 +1200
Message-Id: <20240831092339.66085-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

On a physical phone, it's sometimes observed that deferred_split
mTHPs account for over 15% of the total mTHPs. Profiling by Chuanhua
indicates that the majority of these originate from the typical fork
scenario.
When the child process either execs or exits, the parent process should
ideally be able to reuse the entire mTHP. However, the current kernel
lacks this capability and instead places the mTHP into split_deferred,
performing a CoW (Copy-on-Write) on just a single subpage of the mTHP.

 main()
 {
 #define SIZE 1024 * 1024UL
         void *p = malloc(SIZE);
         memset(p, 0x11, SIZE);
         if (fork() == 0)
                 exec(....);
        /*
 	 * this will trigger cow one subpage from
 	 * mTHP and put mTHP into split_deferred
 	 * list
 	 */
 	*(int *)(p + 10) = 10;
 	printf("done\n");
 	while(1);
 }

This leads to two significant issues:

* Memory Waste: Before the mTHP is fully split by the shrinker,
it wastes memory. In extreme cases, such as with a 64KB mTHP,
the memory usage could be 64KB + 60KB until the last subpage
is written, at which point the mTHP is freed.

* Fragmentation and Performance Loss: It destroys large folios
(negating the performance benefits of CONT-PTE) and fragments memory.

To address this, we should aim to reuse the entire mTHP in such cases.

Hi David,

I’ve renamed wp_page_reuse() to wp_folio_reuse() and added an
entirely_reuse argument because I’m not sure if there are still cases
where we reuse a subpage within an mTHP. For now, I’m setting
entirely_reuse to true only for the newly supported case, while all
other cases still get false. Please let me know if this is incorrect—if
we don’t reuse subpages at all, we could remove the argument.

Hi Ryan,

Ideally, I’d like to see ptep_set_access_flags_nr() support setting
write-permission for the entire mTHP. Since we don’t currently have
this capability, I’m doing it in a rather inefficient way—setting
permissions one by one, which involves redundant unfolding and
folding of CONTPTE. I wonder if we could collaborate on providing
a batched ptep_set_access_flags_nr().

Cc: Chuanhua Han <hanchuanhua@oppo.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 91 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 25 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b95fce7d190f..c51980d14e41 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3205,18 +3205,26 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
 	return 0;
 }
 
-/*
+ /*
  * Handle write page faults for pages that can be reused in the current vma
  *
  * This can happen either due to the mapping being with the VM_SHARED flag,
  * or due to us being the last reference standing to the page. In either
  * case, all we need to do here is to mark the page as writable and update
  * any related book-keeping.
+ * If entirely_reuse is true, we are reusing the whole large folio; otherwise,
+ * we are reusing a subpage even though folio might be large one.
  */
-static inline void wp_page_reuse(struct vm_fault *vmf, struct folio *folio)
+static inline void wp_folio_reuse(struct vm_fault *vmf, struct folio *folio,
+				  bool entirely_reuse)
 	__releases(vmf->ptl)
 {
+	unsigned long idx = entirely_reuse ? folio_page_idx(folio, vmf->page) : 0;
+	int nr = entirely_reuse ? folio_nr_pages(folio) : 1;
+	unsigned long start = vmf->address - idx * PAGE_SIZE;
+	unsigned long end = start + nr * PAGE_SIZE;
 	struct vm_area_struct *vma = vmf->vma;
+	pte_t *ptep = vmf->pte - idx;
 	pte_t entry;
 
 	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
@@ -3233,11 +3241,15 @@ static inline void wp_page_reuse(struct vm_fault *vmf, struct folio *folio)
 		folio_xchg_last_cpupid(folio, (1 << LAST_CPUPID_SHIFT) - 1);
 	}
 
-	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-	entry = pte_mkyoung(vmf->orig_pte);
-	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
-		update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	flush_cache_range(vma, start, end);
+	for (int i = 0; i < nr; i++) {
+		entry = ptep_get(ptep + i);
+		entry = pte_mkyoung(entry);
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		if (ptep_set_access_flags(vma, start + i * PAGE_SIZE,
+				ptep + i, entry, 1))
+			update_mmu_cache_range(vmf, vma, start, ptep + i, 1);
+	}
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	count_vm_event(PGREUSE);
 }
@@ -3493,7 +3505,7 @@ static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf, struct folio *folio
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return VM_FAULT_NOPAGE;
 	}
-	wp_page_reuse(vmf, folio);
+	wp_folio_reuse(vmf, folio, false);
 	return 0;
 }
 
@@ -3519,7 +3531,7 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 			return ret;
 		return finish_mkwrite_fault(vmf, NULL);
 	}
-	wp_page_reuse(vmf, NULL);
+	wp_folio_reuse(vmf, NULL, false);
 	return 0;
 }
 
@@ -3554,7 +3566,7 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 			return tmp;
 		}
 	} else {
-		wp_page_reuse(vmf, folio);
+		wp_folio_reuse(vmf, folio, false);
 		folio_lock(folio);
 	}
 	ret |= fault_dirty_shared_page(vmf);
@@ -3564,17 +3576,41 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 }
 
 static bool wp_can_reuse_anon_folio(struct folio *folio,
-				    struct vm_area_struct *vma)
+				    struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
+	int nr = folio_nr_pages(folio);
+
 	/*
-	 * We could currently only reuse a subpage of a large folio if no
-	 * other subpages of the large folios are still mapped. However,
-	 * let's just consistently not reuse subpages even if we could
-	 * reuse in that scenario, and give back a large folio a bit
-	 * sooner.
+	 * reuse a large folio while it is entirely mapped and
+	 * exclusive (mapcount == folio_nr_pages)
 	 */
-	if (folio_test_large(folio))
-		return false;
+	if (folio_test_large(folio)) {
+		unsigned long folio_start, folio_end, idx;
+		unsigned long address = vmf->address;
+		pte_t *folio_ptep;
+		pte_t folio_pte;
+		if (folio_likely_mapped_shared(folio))
+			return false;
+
+		idx = folio_page_idx(folio, vmf->page);
+		folio_start = address - idx * PAGE_SIZE;
+		folio_end = folio_start + nr * PAGE_SIZE;
+
+		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
+			return false;
+		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
+			return false;
+		folio_ptep = vmf->pte - idx;
+		folio_pte = ptep_get(folio_ptep);
+		if (!pte_present(folio_pte) || pte_pfn(folio_pte) != folio_pfn(folio))
+			return false;
+		if (folio_pte_batch(folio, folio_start, folio_ptep, folio_pte, nr, 0,
+				NULL, NULL, NULL) != nr)
+			return false;
+		if (folio_mapcount(folio) != nr)
+			return false;
+	}
 
 	/*
 	 * We have to verify under folio lock: these early checks are
@@ -3583,7 +3619,7 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
 	 *
 	 * KSM doesn't necessarily raise the folio refcount.
 	 */
-	if (folio_test_ksm(folio) || folio_ref_count(folio) > 3)
+	if (folio_test_ksm(folio) || folio_ref_count(folio) > 2 + nr)
 		return false;
 	if (!folio_test_lru(folio))
 		/*
@@ -3591,13 +3627,13 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
 		 * remote LRU caches or references to LRU folios.
 		 */
 		lru_add_drain();
-	if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
+	if (folio_ref_count(folio) > nr + folio_test_swapcache(folio))
 		return false;
 	if (!folio_trylock(folio))
 		return false;
 	if (folio_test_swapcache(folio))
 		folio_free_swap(folio);
-	if (folio_test_ksm(folio) || folio_ref_count(folio) != 1) {
+	if (folio_test_ksm(folio) || folio_ref_count(folio) != nr) {
 		folio_unlock(folio);
 		return false;
 	}
@@ -3639,6 +3675,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
+	int nr = 1;
 	pte_t pte;
 
 	if (likely(!unshare)) {
@@ -3702,14 +3739,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	 * the page without further checks.
 	 */
 	if (folio && folio_test_anon(folio) &&
-	    (PageAnonExclusive(vmf->page) || wp_can_reuse_anon_folio(folio, vma))) {
-		if (!PageAnonExclusive(vmf->page))
-			SetPageAnonExclusive(vmf->page);
+	    (PageAnonExclusive(vmf->page) || wp_can_reuse_anon_folio(folio, vmf))) {
+		/* this is the case we are going to reuse the entire folio */
+		if (!PageAnonExclusive(vmf->page)) {
+			nr = folio_nr_pages(folio);
+			for (int i = 0; i < nr; i++)
+				SetPageAnonExclusive(folio_page(folio, i));
+		}
 		if (unlikely(unshare)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return 0;
 		}
-		wp_page_reuse(vmf, folio);
+		wp_folio_reuse(vmf, folio, nr > 1);
 		return 0;
 	}
 	/*
-- 
2.39.3 (Apple Git-146)


