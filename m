Return-Path: <linux-kernel+bounces-184478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59D78CA736
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641CE1F21B06
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398B288B1;
	Tue, 21 May 2024 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmbWp/U/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F72E85A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264216; cv=none; b=JSRYab7CzY/IaWI4u9JajakT/UyApirDIqz7zAnjvV168GDEMPLvqVi7UVuY8JrR0ipp6b1JULWGL7gVIDJ+M6721i0YzXAI8Ma9ZWILfcOYIFP6fP2TFapfOCqbfUe7edO1dO4gE0G+hBQCSzUR5iIrPdF9gVQvl9n7NYYkHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264216; c=relaxed/simple;
	bh=pB54FCYLuOqVU6o5Vr5mZuRmbZq3u3WXivEEdUWWzYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIXL7xywr0oq2uCfV/GmOGRftMbjXTNpVgMDWXhNtc+BtdVcKQ9nopSsdm3t23cQm9kQjCpLVvdxtDh/4ccYz/4sM46uCcKmR1JFg3CQzqqKrxsdGq+2WlPPz69q6LHJ8aj1+ZMITxNKu0yJuCF+UOx0IXIz/ujDBSqmsyT+X8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmbWp/U/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecd3867556so98257155ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716264214; x=1716869014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr99+UnOmjT7S1avYjwp5ZtjL07TKstHpgea7ghLKEc=;
        b=OmbWp/U//10dXmT7PQPAn65nl5OqI3OJ/Dc9OJ2SBvDmsYLohht5h3H0ynRkbcQ8D7
         zvALyEETJCGQiEGFz9wqM59gdzORCB/TqUFJtU/swpmESv37Sgth4ZI3I5k8Uo4Tky+k
         PJggneZNSOfGhrBy4q4pmqI5+PAUjTxEyrlKRtjD6wpdVurvxBNcoGuLChtHeqD1BOOK
         xj8qOriAUCrIgmc+eooDl5LzGAsU/4CtZnF5U1BsdfC7ZAW5emdPMZBCHiFWmKGTlBkV
         M3hkOn/zUivBie+ioFutpWhWR4kgIy7WbwNdQGhmXpeE8Gv7xTv7V5ANIw+Hk2TU9WdF
         /EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716264214; x=1716869014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr99+UnOmjT7S1avYjwp5ZtjL07TKstHpgea7ghLKEc=;
        b=tjI8KID6KXJJeL33OZdixd3vRLbrZq5NWfaChgytFgHm+nRpDbCCD0cq4PM1K8dnQI
         I6Lc9t40q9jATFSMOkeQt2W5wedd5oYcuBHTdBsbBpuLWIa44V11aMs/n/aXUIoGxtij
         /PYHtvZXcJaq/Uo0mUk649ImTCC4sTnCF2hudJyo1LrNZTXjhe4tiIiWX1S3zwOm3Jt9
         wKCU4FR12J6p2q/9Y84mUc5wgM4Kucqbe9h09vhseI3rA4feuRNo96V77YKujc5UId2G
         WG2aIIWsAftEI6I//BCg9JOpbwaIJU3uOe0OR89yKaaBsKCVVdaca02ILhoqv/+OJz7D
         b56Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDkq4HYsTr7qqjhyyG+kZXcxua34VKWAtnj9LgjDxU2wTE3purDH+6Icxp0gsuc/G7iY8aYlDrlbX84iortZEnnzYP/DZR5p2QPlCF
X-Gm-Message-State: AOJu0YxNwxNmmA2CiFZUQmLJ1/Wd5SwbmdA6PJuH4ZdLywi551VFWO+g
	1hUFBRVK9ojS4kQFqLykk7mjy5wxOzAt5Mq/fX6X0DNIEzthpKOC
X-Google-Smtp-Source: AGHT+IHNlRE9Ql30bKl4wf8mPivbg9Uu62KGA61WCjKuW56gBBFvSattqBS4RrJD3TWyboPzl/3vNg==
X-Received: by 2002:a17:902:d2cf:b0:1f3:dd7:ad42 with SMTP id d9443c01a7336-1f30dd7af64mr10263255ad.0.1716264214253;
        Mon, 20 May 2024 21:03:34 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad62bfsm211683945ad.74.2024.05.20.21.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 21:03:33 -0700 (PDT)
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
Subject: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
Date: Tue, 21 May 2024 12:02:43 +0800
Message-Id: <20240521040244.48760-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240521040244.48760-1-ioworker0@gmail.com>
References: <20240521040244.48760-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
folios, start the pagewalk first, then call split_huge_pmd_address() to
split the folio.

Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we might
encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range during
the page walk. It’s probably necessary to mlock this THP to prevent it from
being picked up during page reclaim.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  6 ++++++
 mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
 mm/rmap.c               | 26 ++++++++++++++++++-------
 3 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c8d3ec116e29..9fcb0b0b6ed1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -409,6 +409,9 @@ static inline bool thp_migration_supported(void)
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
 }
 
+void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
+			   pmd_t *pmd, bool freeze, struct folio *folio);
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
@@ -471,6 +474,9 @@ static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio) {}
 static inline void split_huge_pmd_address(struct vm_area_struct *vma,
 		unsigned long address, bool freeze, struct folio *folio) {}
+static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
+					 unsigned long address, pmd_t *pmd,
+					 bool freeze, struct folio *folio) {}
 
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 317de2afd371..425272c6c50b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2581,6 +2581,27 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -2592,26 +2613,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
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
index ddffa30c79fb..08a93347f283 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	if (flags & TTU_SYNC)
 		pvmw.flags = PVMW_SYNC;
 
-	if (flags & TTU_SPLIT_HUGE_PMD)
-		split_huge_pmd_address(vma, address, false, folio);
-
 	/*
 	 * For THP, we have to assume the worse case ie pmd for invalidation.
 	 * For hugetlb, it could be much worse if we need to do pud
@@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
-		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
 			/* Restore the mlock which got missed */
-			if (!folio_test_large(folio))
+			if (!folio_test_large(folio) ||
+			    (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
 				mlock_vma_folio(folio, vma);
 			goto walk_done_err;
 		}
 
+		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
+			/*
+			 * We temporarily have to drop the PTL and start once
+			 * again from that now-PTE-mapped page table.
+			 */
+			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
+					      folio);
+			pvmw.pmd = NULL;
+			spin_unlock(pvmw.ptl);
+			pvmw.ptl = NULL;
+			flags &= ~TTU_SPLIT_HUGE_PMD;
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


