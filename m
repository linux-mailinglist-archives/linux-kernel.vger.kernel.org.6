Return-Path: <linux-kernel+bounces-214201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B0908123
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5619F1F23323
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB43211;
	Fri, 14 Jun 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITWv/ljT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A7183086
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329946; cv=none; b=EBVjNm6Ht6ggnNtrWKjCklYeIqm8Z0IdzW3uU+3grUHvCufJBkTBojb1c4KpOt4IV7vVvZvC9ft8Z0imp1M1wZPAvbZAjibhotzM44m/kDe6b/arqFCZ3kajXrgK5E5cx67FHNINrOv41G6gPQeFAmsye+M0rAaVGTY0P25r6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329946; c=relaxed/simple;
	bh=t646EUoWg9Y2eZj/rbYb/go7sM5ZSweo3vqKLyVYdZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOCOVylYu+wC+je73Vz6kP5fhM5MnorbT6sDcmsb43W4/PUMaUc3orFBuucpRliivA2GYWpvEWcfx6S632hhFg3UR/eCHy8bwkN7Q2+AmyYTkalr4BcaCIxe4AWkKM2EEfoFEXTmKDIveXxkLjDbSqBJ/exP5VFdKxjpuCBFpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITWv/ljT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7024d571d8eso1368361b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718329944; x=1718934744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHYSOK8Z4m4YeRSSbyiRoNr7hsC5jb5TLSRL1KlNI3w=;
        b=ITWv/ljTggXzPCDpr+UQcE6xbfDHYMQpZFADVNbYEKCjHQzU48QJj2B+kFSKTiiBh8
         pIhwpw/+dNLUTwYZnePzDzKzGxXpHUeGlRWFI4xxQ9VsUTd1VHdAOpUCEhhF7P1/xRaK
         dRwOVnpzWBgE/gjniRrFC6tLWgYUd8Ncd1bP+Qsr06lVgMfyhUZ4n00BoSVGDKh+tj0B
         OXEl7IqWgEF9/idJM7ZeBZuAd9FTFmEmDt3KMR3Q4iub4HHcSo9jus2KHA8/tdjugWxe
         FOvklg5HWZQ8cg3hip39pa4XSXBFLdgXN8njbGPACSr1UsfgY0PFfU70uTPwv6xX6+Tn
         8eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718329944; x=1718934744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHYSOK8Z4m4YeRSSbyiRoNr7hsC5jb5TLSRL1KlNI3w=;
        b=U+iFJLbMgcEdDGculqKOk4YDGLujOugRoicdZqJHqnn02RRNlMhHkHx3lHyYRLNGXn
         qjF/aFW/Qmz26CQIbZuvm/3VIZRe+cj3zhFp9E4tPZ6PVSM4/WU1nL19QH/qSRn8KjxF
         OUjMnhts1GU84foO1NfvMzlQMGfR1M+ovk3Azf99YIv1DS3cwE3xdtxJvQXFX9pbhiAg
         WjV+CSx3Qu5/gwkGCWAljWy9A7nRKFz0RZXn8g0cHxZsnLEMFYdF2KNWEyT4sNAa/CEo
         fclrl+w4Jot5TB+AjcK3fjyz99iDOtYRPDz0YIu5ygu9A2+khI/oX6r9Y6uI7bD7PA/r
         qQzA==
X-Forwarded-Encrypted: i=1; AJvYcCWegjL6Tw8fzlQLLgiEfN10zqnviWQ8/PvdDB9ut9BHwX79LwEH8YAv64xib8pC8NShGVP/HcLIKI6a8qLnXntPl/zJD8KZQ43mAHc1
X-Gm-Message-State: AOJu0YyoeAJ7F/u5BPB6fmQTX8yVOfhLyXo2PVYYyVSSiX+3WjPF2HeZ
	/dYQBxuOZPp6NuD3vDMrMgebDcJq1aF3Arv2Y+YByRAZu5VWyV/M
X-Google-Smtp-Source: AGHT+IETJKQrVb03Zu4RAVjG/Fn0yAZeYe0tcBOczpJ9Oj2zKKIy6GQvO0xxxOPWMdvyD7IL203kLg==
X-Received: by 2002:a05:6a20:3d89:b0:1b5:d10a:1b70 with SMTP id adf61e73a8af0-1bae7d840cfmr2048147637.11.1718329943752;
        Thu, 13 Jun 2024 18:52:23 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96d4c3sm2000912b3a.59.2024.06.13.18.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 18:52:23 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v8 2/3] mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
Date: Fri, 14 Jun 2024 09:51:37 +0800
Message-Id: <20240614015138.31461-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240614015138.31461-1-ioworker0@gmail.com>
References: <20240614015138.31461-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
folios, start the pagewalk first, then call split_huge_pmd_address() to
split the folio.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  6 ++++++
 include/linux/rmap.h    | 24 +++++++++++++++++++++++
 mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
 mm/rmap.c               | 21 +++++++++++++++------
 4 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7ad41de5eaea..9f720b0731c4 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -428,6 +428,9 @@ static inline bool thp_migration_supported(void)
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
 }
 
+void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
+			   pmd_t *pmd, bool freeze, struct folio *folio);
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
@@ -490,6 +493,9 @@ static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio) {}
 static inline void split_huge_pmd_address(struct vm_area_struct *vma,
 		unsigned long address, bool freeze, struct folio *folio) {}
+static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
+					 unsigned long address, pmd_t *pmd,
+					 bool freeze, struct folio *folio) {}
 
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0fd9bebce54c..d1c5e2d694b2 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -703,6 +703,30 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		spin_unlock(pvmw->ptl);
 }
 
+/**
+ * page_vma_mapped_walk_restart - Restart the page table walk.
+ * @pvmw: Pointer to struct page_vma_mapped_walk.
+ *
+ * It restarts the page table walk when changes occur in the page
+ * table, such as splitting a PMD. Ensures that the PTL held during
+ * the previous walk is released and resets the state to allow for
+ * a new walk starting at the current address stored in pvmw->address.
+ */
+static inline void
+page_vma_mapped_walk_restart(struct page_vma_mapped_walk *pvmw)
+{
+	WARN_ON_ONCE(!pvmw->pmd && !pvmw->pte);
+
+	if (likely(pvmw->ptl))
+		spin_unlock(pvmw->ptl);
+	else
+		WARN_ON_ONCE(1);
+
+	pvmw->ptl = NULL;
+	pvmw->pmd = NULL;
+	pvmw->pte = NULL;
+}
+
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 70d20fefc6db..e766d3f3a302 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2582,6 +2582,27 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	pmd_populate(mm, pmd, pgtable);
 }
 
+void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
+			   pmd_t *pmd, bool freeze, struct folio *folio)
+{
+	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
+	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
+	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
+	VM_BUG_ON(freeze && !folio);
+
+	/*
+	 * When the caller requests to set up a migration entry, we
+	 * require a folio to check the PMD against. Otherwise, there
+	 * is a risk of replacing the wrong folio.
+	 */
+	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
+	    is_pmd_migration_entry(*pmd)) {
+		if (folio && folio != pmd_folio(*pmd))
+			return;
+		__split_huge_pmd_locked(vma, pmd, address, freeze);
+	}
+}
+
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio)
 {
@@ -2593,26 +2614,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pmd_lock(vma->vm_mm, pmd);
-
-	/*
-	 * If caller asks to setup a migration entry, we need a folio to check
-	 * pmd against. Otherwise we can end up replacing wrong folio.
-	 */
-	VM_BUG_ON(freeze && !folio);
-	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
-
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
-		/*
-		 * It's safe to call pmd_page when folio is set because it's
-		 * guaranteed that pmd is present.
-		 */
-		if (folio && folio != pmd_folio(*pmd))
-			goto out;
-		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
-	}
-
-out:
+	split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 2d778725e4f5..dacf24bc82f0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1642,9 +1642,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	if (flags & TTU_SYNC)
 		pvmw.flags = PVMW_SYNC;
 
-	if (flags & TTU_SPLIT_HUGE_PMD)
-		split_huge_pmd_address(vma, address, false, folio);
-
 	/*
 	 * For THP, we have to assume the worse case ie pmd for invalidation.
 	 * For hugetlb, it could be much worse if we need to do pud
@@ -1670,9 +1667,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
-		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
@@ -1684,6 +1678,21 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			goto walk_abort;
 		}
 
+		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
+			/*
+			 * We temporarily have to drop the PTL and start once
+			 * again from that now-PTE-mapped page table.
+			 */
+			split_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
+					      false, folio);
+			flags &= ~TTU_SPLIT_HUGE_PMD;
+			page_vma_mapped_walk_restart(&pvmw);
+			continue;
+		}
+
+		/* Unexpected PMD-mapped THP? */
+		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
+
 		pfn = pte_pfn(ptep_get(pvmw.pte));
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
-- 
2.33.1


