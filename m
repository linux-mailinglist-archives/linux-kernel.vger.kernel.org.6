Return-Path: <linux-kernel+bounces-208131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D190213F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE89B20E14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60C7E575;
	Mon, 10 Jun 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwYnUqMH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52291F171
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021194; cv=none; b=h8aIBe0VK1YKO0q22Bw5Ip9FO0QoUtaXhJ+btacJSUQdtmCWqrZRLWm2v6cuH1xzzX2ciHsAKb6JE5toxuKZbCsvy9M9FPdOzDMxpo0et3UB0oXXZXOWl25kSPleDzSJd37W3uHzuJ2JQp9IUi1rqnyGnJxy/9+6t437PT8jmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021194; c=relaxed/simple;
	bh=RgmkqwOeLDy5DxsGKQkSYd477fFHSA3uoHghvi9luWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjTyQsRSSPZyrTiZw8ABied/GYVbvGgeOoCH4evP1g3cNHVqT5HU5uSiLABn0QKMmKDrhW9niFrUjiT43cMq8Ej8w/3JTAE0DBZpq+ZzkrdAR0Tw4GEhGJfiEeuadQBmqLL83jj7Q++GazJReCXI4u1tmlc9upnazSnLxzry5Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwYnUqMH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7042882e741so1243438b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718021192; x=1718625992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOOpP3mhn3ktm+AdbLZ/EN2VmROk6QDShkqGnjdgrDU=;
        b=BwYnUqMHKCrIieS+ybqIjtcHGSU68ojqcBl4jr+qFVZ7+xHguCZyksyH3IIooFVY1p
         X9WsLcl4Yw7rjBf5yTBruRLRjVZllujKtiNzEOv31ApW9tkK+4easgMhn4QfcRrU4FAU
         YBlQYUUuGNDEjpChAgQywWoiumPwQO/lKOrfqcN1K0ZHsMiglRg6XkcyoNRWNg0mX0yP
         DD+oY9OAFjWaB0bWeLlB27xNPpVVMpDvI0MoiB31UvwdtU1vV00bb4jba7ArkuD8aXW3
         pFIzmzDC27JQU05R4PJ2LiTXJj47dtAIotrRbPjXLmlQkcE4UKzg4pqpd0Yre1nelz2Z
         jpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718021192; x=1718625992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOOpP3mhn3ktm+AdbLZ/EN2VmROk6QDShkqGnjdgrDU=;
        b=a2HyUirPUCO5sAUMFpkyY6AsAkpWRC1HI7eSv8NspQ2V9CnrZuqRZ1GJVl+i8tX9c8
         iIl9EqhT/dHdQVz+NBcPe49me7vbeeTm3oI5MsQK7e5FXcAAWsGqfc8DlR5eY6vMLxIp
         LsY0q7ECJXuGk4KlGGtkShA8wpkbixXoHeM6Oovk3YtOsqT2hhAt+ItgXxnFB4eoU7Je
         8oAK+ckMrgIN1gXdu1wOtlVkKdf1oBxoPMuxK/OPngKhnMo3pf0dn4gJ9YTsewQtCcJs
         TdjQgS/KiaTpJf2+DGqLcMFV46WLE+auZDrxDA/WoisS0UY96d/+dIX+PkV3QZ/pRKf3
         BHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWFRLSuigDxfCAe5zsBPDaiCD64hyxBtp2R7RvvOZmX/jte7aGNwUln9LoVhJYWHZXcLr8/OyN6EHTsxsHfSJbd68iN6D9JrLgLRYH
X-Gm-Message-State: AOJu0Yxo8xGVKFHUz9zM5h5qngbk88zO9kuqR0MxN3aA5shFbHHKx8kp
	lPEEI7QxebE9UYfCyUsdUr3IwKSi5gLYaqqGGhHItt4y72TjozpA
X-Google-Smtp-Source: AGHT+IHuuLA3IkOVWnemUAiXi6DwNGqf6nD+qxo5av/4Kb4vZP8/N6Adb31SMqw2zaGmXf2b8MhZIQ==
X-Received: by 2002:a05:6a20:8423:b0:1af:7646:fc14 with SMTP id adf61e73a8af0-1b2f151f841mr9176853637.0.1718021191815;
        Mon, 10 Jun 2024 05:06:31 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7043aa52899sm2182250b3a.25.2024.06.10.05.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:06:31 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: ioworker0@gmail.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	fengwei.yin@intel.com,
	libang.li@antgroup.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maskray@google.com,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	sj@kernel.org,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiehuan09@gmail.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: [PATCH v7 3/4] mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
Date: Mon, 10 Jun 2024 20:06:18 +0800
Message-Id: <20240610120618.66520-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240610120209.66311-1-ioworker0@gmail.com>
References: <20240610120209.66311-1-ioworker0@gmail.com>
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
 mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
 mm/rmap.c               | 21 +++++++++++++++------
 3 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 088d66a54643..4670c6ee118b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -415,6 +415,9 @@ static inline bool thp_migration_supported(void)
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
 }
 
+void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
+			   pmd_t *pmd, bool freeze, struct folio *folio);
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
@@ -477,6 +480,9 @@ static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio) {}
 static inline void split_huge_pmd_address(struct vm_area_struct *vma,
 		unsigned long address, bool freeze, struct folio *folio) {}
+static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
+					 unsigned long address, pmd_t *pmd,
+					 bool freeze, struct folio *folio) {}
 
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e6d26c2eb670..d2697cc8f9d4 100644
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
index ddffa30c79fb..b77f88695588 100644
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
@@ -1668,9 +1665,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
-		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
@@ -1682,6 +1676,21 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			goto walk_done_err;
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


