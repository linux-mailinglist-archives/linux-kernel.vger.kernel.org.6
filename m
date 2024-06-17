Return-Path: <linux-kernel+bounces-218426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208D90BFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9DA283FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9443219AD87;
	Mon, 17 Jun 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aejLL0LO"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515719AD86
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665923; cv=none; b=K/gMcLzKbFgIujB7HAkVi3KprhZ7+eGqt62r+rNfoaEnkMylEb1wJC4N9EPCqoX/KtYdZaw2n59JwA0tWxUx94I9yVDRrgzUKDbdJQWVGYrcBbo13HNuy5HFRtjnhMtlvc2JVJ31Hpz2fQNDLYHkFDj+ytnmXctnV+OgpSJmOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665923; c=relaxed/simple;
	bh=cycZ+nkodD7Q4bf2Z863Lhw9039mJVhY+1krOpzjnME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXxUUGp/izVtRh2APC25l9eub2MoX1nse+PScMLUsUK/Z6O+AW3NdSO6mwQy7jVIuu3bC/lhNZSdI1wQ2u5Gym2P7fr83fOmnsbIGJWf2I112CJ02/z19ye9JnblfOjSWTkQBG+igTmjGrmSP619VUoQB/1rcByGwFrvNI4msBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aejLL0LO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-70346ae2c43so2158435a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665921; x=1719270721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvhtOkp6Hw1ojSxAohAyFTdYS+FS6nTiQQWXEJjk460=;
        b=aejLL0LOk7e6cJm6tMlWhbrU9lmE1Z2z6TxAY8dvcyOAplH0lzOViPl+/WVMp9gzkA
         CUZrvkiQk9278PetDrpoLXA2QhvloXo2vfwKK3mcBoXPE4CSWByoapW7IXTuHcQJchFA
         KcTZByD+rxQgiCYEARTX191lwB2LscfJOpPrHAumiiOa9Dt065C0wMOgepDyva6OR63y
         G3TuAkWmzdmsL6CNdadma5M61cHWEiricOmxgT+ESWpMTbri89dMQdPU82WeAIw1YfdP
         ESRqqavAkbDJvk8rhkvvIgVF3xh87IAE5tnBaT/xwgppjEZ6k1Cjx5uZBMIy/IT8y9yX
         g0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665921; x=1719270721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvhtOkp6Hw1ojSxAohAyFTdYS+FS6nTiQQWXEJjk460=;
        b=Ru9cZx34vU3LNuXx3BNRIJw2IsOZy4SkmaqfneXiZfGeBQz/Op5YSRPyJlvi3fMGqs
         wntKrr7fdNUcoYOQadH4WcFLaDmi+JSrs6E7mBRWlA9SI6PwVR+mkc6bFPZ9IeVHpHN4
         TyBW4F/GmqHUBvMCgTc9ph2rFrIqjmoRuQdwHWyiJ4K4SKbw45UwQuXM+TMS3LUu6lrz
         pPnMpAnZxXerZRYkRww+Ge224KyczQSO8b6hIl22d6V2I3IktHMQaSyzgISv/Zu0r4I4
         gs0rv1qSH5fOxpa3oblEExOze4EPG0+ffNqa7eq7JuX/YPQBitA1v38Z/AzGX20FqKb2
         n0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoqWfcyIDnr5SKs2HwboqQBJM8PSIAk28YZm3/IU28z1dmQvB2dZ/v5KgM/zk+OLn5Z5CCqYU/Y469hFOBw9mAwh9iRyRkCA7whBcs
X-Gm-Message-State: AOJu0YzJq3fXrkN1UpDsrQMlszh0dqDq0IOv28mRsqh+ZnhMe2ugOrla
	bIjkA81f0DKtUlNW4d0LD5EjnZ9LTrXc8jh5on8RcsMrdh6vRq3a+cVX+rls
X-Google-Smtp-Source: AGHT+IEqogOoRViu3dOHOoOaWtAQ5vCl8sRMCFCuC7Yuj7hzSrXBJwI06s26PAHRuB+06AGttKgb1A==
X-Received: by 2002:a17:902:e546:b0:1f7:3a70:9e71 with SMTP id d9443c01a7336-1f98b22ddd8mr13264205ad.13.1718665921157;
        Mon, 17 Jun 2024 16:12:01 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5a0d5sm84658605ad.43.2024.06.17.16.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:12:00 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Shuai Yuan <yuanshuai@oppo.com>
Subject: [PATCH v2 1/3] mm: extend rmap flags arguments for folio_add_new_anon_rmap
Date: Tue, 18 Jun 2024 11:11:35 +1200
Message-Id: <20240617231137.80726-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617231137.80726-1-21cnbao@gmail.com>
References: <20240617231137.80726-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

In the case of a swap-in, a new anonymous folio is not necessarily
exclusive. This patch updates the rmap flags to allow a new anonymous
folio to be treated as either exclusive or non-exclusive. To maintain
the existing behavior, we always use EXCLUSIVE as the default setting.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Shuai Yuan <yuanshuai@oppo.com>
---
 include/linux/rmap.h    |  2 +-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             | 10 +++++-----
 mm/migrate_device.c     |  2 +-
 mm/rmap.c               | 17 ++++++++++-------
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 9 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b1bbe237ea4c..23d336e5d502 100644
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
index 425374ae06ed..9e2357ab9b9a 100644
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
index b7137d9c99a9..1f24ecdafe05 100644
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
index a3c99ac63155..2b19bb92eda5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1406,25 +1406,26 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
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
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
 	__folio_set_swapbacked(folio);
-	__folio_set_anon(folio, vma, address, true);
+	__folio_set_anon(folio, vma, address, exclusive);
 
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


