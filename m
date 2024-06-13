Return-Path: <linux-kernel+bounces-212395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D09905F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE50283577
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BA123A0;
	Thu, 13 Jun 2024 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMLZ63CG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266117FD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237276; cv=none; b=QkNtol0AbL5v7fPVkqa0ArvfEK1avvefYkgW+c7Mbvp0t4bsUAyLWkSOG9ou9ib7itVgWNv52n+vPiqepbv1IAZAMIIOWozwYKVKK6FEhnzcPPgEhlEl96GAUyBkxR3yaobxLxL9Dho/whW3YzVWpb6cxC/6RyXZaoXj0rJ4KrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237276; c=relaxed/simple;
	bh=B2acvhahLEtG+ufScIt/M8IFhSN1fqjqbFneKLjo2SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOhAq2evPSNTrLdplc68CLR7DTC0lvnybyrzLyvlTqZQMIq8NcL0kR6BI1bSuRx+wVGFL0d+Zo3VQqdXobozVubcMqID1th9VRYb3GUBTH3Bpg0AwtxqiNX+PrhRWuDrlSCCNreWtoyNwxUwyMPJaWzIznTgsnyK0j9Y1r5SQlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMLZ63CG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f8507aac31so3123435ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718237274; x=1718842074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NpqziHdDLqAIiqSY8F5xKMZFmANNGDCABcj+bnMA4Y=;
        b=UMLZ63CGX81Tdw0N1CKJNqDINfVahOuQuFCXo0nd9Ws5u6LApsAx5dU1+8z/Qhj8YA
         vVBbtCNdk4lxCSe8PcVnuDuvdSqfGmyg1UkjQgfY2fC1uYYDSw5iaPdW/5k8csSKeT87
         vqJU4dk3MnHjXSK3CZi9C0AneIdGwNplzwykTmFyCcAj1KrBicWsg6MMvW/ERV5z1QJn
         G8dWnQ+GJLRf01NqiNu4CZklD541DBCDxfjbgaVMq5rWJPQRfBityptkUA21qvj8q73g
         w7E0wff3pJ0Agi4LVA6UDAX5JK0D1k27QKIzz1CsuqVtmzl4jbVyvJ3w/OH9dpEOS6KF
         +jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718237274; x=1718842074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NpqziHdDLqAIiqSY8F5xKMZFmANNGDCABcj+bnMA4Y=;
        b=lRH1TbHzATYGomzwMOU+BkE7AuT84qEc1rCVMdXTAhjooNZhq7HMeY6ZW+5/xt4ETs
         XAnWopCScfUvTGTsT/YiyIdhU/4IVepk+zvnrCW1N7f121CLhizf1pywEJXC93hHxa+7
         ew2+9b0b+cTQtkmooHDQh3DLA7rH8Ytz+vV1DrLHWLKwrAMYEgeKwAje+YyChcY+bYpq
         tffYd5QqJ97m3h57TStVTB2u0fMmERKqsnFAUUbn6pMj/vECfxtC3rU1Uw/wdSyYR1LZ
         9n6IzfqdU/td9FroxS/oqTllojZuZe2+4FolMnLJAp8xgkN+DIhrvH2LXw8DG9o4+irT
         +emQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6KVknKv2AcnEDrY2tpH2Z5h4+rVn9y7JTQcqrgmP2TaSh2FYtHC9GNA9RzYKFRiA7yyLueoe+Ywm7DpJhdHPaffsNv+g7pKHt87sW
X-Gm-Message-State: AOJu0YzFgHpJLZOvW1r0S/cnEKhz6l1+GuSbYz3hxOA71Z+K20J1e+rU
	sSXD4RWjbKL9ek0Dxq/Yq48A+o+z9oU39t6uYKd5iQGl2Eedkoay
X-Google-Smtp-Source: AGHT+IFqnSJUmDgIo8AipknzKgGcCL0uU9MekGnVAVXd4ZlmgCCLwGt5Rq6fxNTCV4HDqJOXsCvfbw==
X-Received: by 2002:a17:902:d482:b0:1f6:7815:2325 with SMTP id d9443c01a7336-1f83b71a137mr39747405ad.56.1718237274424;
        Wed, 12 Jun 2024 17:07:54 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1af16sm525515ad.246.2024.06.12.17.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 17:07:53 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	yosryahmed@google.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yuzhao@google.com
Subject: [PATCH RFC 1/3] mm: extend rmap flags arguments for folio_add_new_anon_rmap
Date: Thu, 13 Jun 2024 12:07:19 +1200
Message-Id: <20240613000721.23093-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613000721.23093-1-21cnbao@gmail.com>
References: <20240613000721.23093-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

In the case of do_swap_page(), a new anonymous folio isn’t necessarily
exclusive. This patch extends the rmap flags to allow treating a new
anon folio as either exclusive or non-exclusive. To maintain the current
behavior, we always use EXCLUSIVE as arguments.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/rmap.h    |  2 +-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             | 10 +++++-----
 mm/migrate_device.c     |  2 +-
 mm/rmap.c               | 15 +++++++++------
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 9 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index cae38a2a643d..01a64e7e72b9 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -244,7 +244,7 @@ void folio_add_anon_rmap_ptes(struct folio *, struct page *, int nr_pages,
 void folio_add_anon_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *, unsigned long address, rmap_t flags);
 void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
-		unsigned long address);
+		unsigned long address, rmap_t flags);
 void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_add_file_rmap_pte(folio, page, vma) \
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..c20368aa33dd 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -181,7 +181,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		folio_get(new_folio);
-		folio_add_new_anon_rmap(new_folio, vma, addr);
+		folio_add_new_anon_rmap(new_folio, vma, addr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(new_folio, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f409ea9fcc18..09a83e43c71a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -973,7 +973,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		folio_add_new_anon_rmap(folio, vma, haddr);
+		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 774a97e6e2da..4d759a7487d0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1213,7 +1213,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
-	folio_add_new_anon_rmap(folio, vma, address);
+	folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(folio, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
diff --git a/mm/memory.c b/mm/memory.c
index 54d7d2acdf39..2f94921091fb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -930,7 +930,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	*prealloc = NULL;
 	copy_user_highpage(&new_folio->page, page, addr, src_vma);
 	__folio_mark_uptodate(new_folio);
-	folio_add_new_anon_rmap(new_folio, dst_vma, addr);
+	folio_add_new_anon_rmap(new_folio, dst_vma, addr, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(new_folio, dst_vma);
 	rss[MM_ANONPAGES]++;
 
@@ -3400,7 +3400,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * some TLBs while the old PTE remains in others.
 		 */
 		ptep_clear_flush(vma, vmf->address, vmf->pte);
-		folio_add_new_anon_rmap(new_folio, vma, vmf->address);
+		folio_add_new_anon_rmap(new_folio, vma, vmf->address, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(new_folio, vma);
 		BUG_ON(unshare && pte_write(entry));
 		set_pte_at(mm, vmf->address, vmf->pte, entry);
@@ -4337,7 +4337,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(folio != swapcache && swapcache)) {
-		folio_add_new_anon_rmap(folio, vma, address);
+		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 	} else {
 		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
@@ -4592,7 +4592,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
 #endif
-	folio_add_new_anon_rmap(folio, vma, addr);
+	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(folio, vma);
 setpte:
 	if (vmf_orig_pte_uffd_wp(vmf))
@@ -4790,7 +4790,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		VM_BUG_ON_FOLIO(nr != 1, folio);
-		folio_add_new_anon_rmap(folio, vma, addr);
+		folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 	} else {
 		folio_add_file_rmap_ptes(folio, page, nr, vma);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 051d0a3ccbee..6d66dc1c6ffa 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -658,7 +658,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto unlock_abort;
 
 	inc_mm_counter(mm, MM_ANONPAGES);
-	folio_add_new_anon_rmap(folio, vma, addr);
+	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 	if (!folio_is_zone_device(folio))
 		folio_add_lru_vma(folio, vma);
 	folio_get(folio);
diff --git a/mm/rmap.c b/mm/rmap.c
index b9e5943c8349..e612d999811a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1406,14 +1406,14 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
  * This means the inc-and-test can be bypassed.
  * The folio does not have to be locked.
  *
- * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
- * is new, it's assumed to be mapped exclusively by a single process.
+ * If the folio is pmd-mappable, it is accounted as a THP.
  */
 void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
-		unsigned long address)
+		unsigned long address, rmap_t flags)
 {
 	int nr = folio_nr_pages(folio);
 	int nr_pmdmapped = 0;
+	bool exclusive = flags & RMAP_EXCLUSIVE;
 
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
@@ -1424,7 +1424,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	if (likely(!folio_test_large(folio))) {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_mapcount, 0);
-		SetPageAnonExclusive(&folio->page);
+		if (exclusive)
+			SetPageAnonExclusive(&folio->page);
 	} else if (!folio_test_pmd_mappable(folio)) {
 		int i;
 
@@ -1433,7 +1434,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 
 			/* increment count (starts at -1) */
 			atomic_set(&page->_mapcount, 0);
-			SetPageAnonExclusive(page);
+			if (exclusive)
+				SetPageAnonExclusive(page);
 		}
 
 		/* increment count (starts at -1) */
@@ -1445,7 +1447,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_large_mapcount, 0);
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
-		SetPageAnonExclusive(&folio->page);
+		if (exclusive)
+			SetPageAnonExclusive(&folio->page);
 		nr_pmdmapped = nr;
 	}
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9c6d8e557c0f..ae1d2700f6a3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1911,7 +1911,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 
 		folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
 	} else { /* ksm created a completely new copy */
-		folio_add_new_anon_rmap(folio, vma, addr);
+		folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 	}
 	new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5e7f2801698a..8dedaec00486 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -216,7 +216,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 			folio_add_lru(folio);
 		folio_add_file_rmap_pte(folio, page, dst_vma);
 	} else {
-		folio_add_new_anon_rmap(folio, dst_vma, dst_addr);
+		folio_add_new_anon_rmap(folio, dst_vma, dst_addr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, dst_vma);
 	}
 
-- 
2.34.1


