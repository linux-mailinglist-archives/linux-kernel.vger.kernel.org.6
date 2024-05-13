Return-Path: <linux-kernel+bounces-177280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F28C3C57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C43B1C20ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67410146D5F;
	Mon, 13 May 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB9Gjcez"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A6146D50
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586482; cv=none; b=o3FUl1rYf/BayOIELTklUG1vMdIg7HJLyGSvtGuImIP1eRXFyidrYOeIjDIhXOE85MQ0Ift2bE3DoA6sjuwddq8izRBdpsyzDhwpSrgakVbzFydxDhw3dxdm9DnhrvK+K8lg9oDgP374iqQV6aNkIdIn+9g64fRKo/qjfU/AlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586482; c=relaxed/simple;
	bh=m8kCWF+iFQvI3coxrWVJ4qOZShVff4EWXPdFeXxO6lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dedUT/QLZz6aV8OREUGeE1018TAeqDJPFkLJjqIqYLg/Fq56O7JwdsDOFTGqcyue/iTXiCHUsl5vhRXkbE88V+G1LD28SXDJTDoZJBJl2DAEK30lQOVt8nQZ+o1atJv8rny5vVUW2atUkw5HCh1jBnEK12gMiyoeWzboVQaWQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB9Gjcez; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f5053dc057so536318b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715586480; x=1716191280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW0xsCDY7mre2haGnv0Xg6zNVS1x+avy2x5g7mykcSU=;
        b=aB9GjcezXIQuUsJ4w/rGYE53vOWAVmuj1x5X5ltFJcN270NXvwfh2NxB+z/+E5H09Z
         hZ6z4yaHdFUBd+4ntTZzpSYyyMB82U9v+ALtuaalCIZLRcJ1hqMqZnipreIM4nb79fsw
         8SAivPuYT4RSRhiUJeAGu3VGWjIiiEPVHlIj/2JaZgzgO9Mgd3bh7XKioYCgZRFVsChf
         0+APIA0+Yycpz8jT3ULQwqTNXWqikY1RbiYtalkXS1Q86JHlBE0P24Xc7nX6dZhsh1uc
         5HUNl4Oj4iP7+t07Qemvn1zdtorxpokh62EnE6I0V4pWqdAE6wciYfNUbsv4SqYYgQwT
         RIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586480; x=1716191280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW0xsCDY7mre2haGnv0Xg6zNVS1x+avy2x5g7mykcSU=;
        b=wwRoJPzK6TgcE9Ky6UCi4pWECIjZbT6fENUUbOdbScX6ikU2e8Ox/5/55mDkaS109e
         BKhnqtChZsZFEx9Mr/qihutTdnmCpHTZhYLUGR0UnJ2t2nQu6qjKaCgYVyiBEOZejkE5
         OZ3w9CCu8+RkyCwD83tqsQX+zY+Xo2aba6oWyOMluiBgGhzvjayzUlu5s5KnJ62jMwMs
         AXdUS6GD7/IOLHDi14L9lDaqQzxiT5hyj4ipxavajZvCgrQjl/cFotIVib5Kc9IgPCIX
         zbGXTZ0TqlxOS5I7799p3RdYdaSet7YIRthHm9TEJ1odewSFSBtGZ8Q8u219GZY4jvp8
         RkzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcT+/2S8p2E33P1WOsD2lotkBfw5XRhCvVRiOR9DkfhZOdzVt9E8Rrz/b9HT6BejwpOlthnceENIiemzqJ/w7v+8zAziUfHSPjqGQC
X-Gm-Message-State: AOJu0Yy73Hc2G4C2ncOZnT8DkcCco4/LsUhXhLdvZEsSOKUBwhEzAri/
	Ch7351BypB4MXAEbefFPzfhSvH+w1ZL/dJxdy4HTc/9efnEZ21L2
X-Google-Smtp-Source: AGHT+IEIpuabuqonhYE79on+MmpCBMiXOyD1MynjuJ+zgMt6P3Xc90pOg4tUdHHFiZ9X3J2Nmmenng==
X-Received: by 2002:a05:6a00:4f8f:b0:6ea:d114:5ea1 with SMTP id d2e1a72fcca58-6f4e02cae54mr13273237b3a.17.1715586480465;
        Mon, 13 May 2024 00:48:00 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66621sm7008967b3a.13.2024.05.13.00.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:48:00 -0700 (PDT)
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
Subject: [PATCH RESEND v5 2/4] mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
Date: Mon, 13 May 2024 15:47:10 +0800
Message-Id: <20240513074712.7608-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240513074712.7608-1-ioworker0@gmail.com>
References: <20240513074712.7608-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
folios, start the pagewalk first, then call split_huge_pmd_address()
to split the folio.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  6 ++++++
 mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
 mm/rmap.c               | 23 ++++++++++++++++------
 3 files changed, 45 insertions(+), 26 deletions(-)

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
index ddffa30c79fb..4c4d14325f2e 100644
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
@@ -1682,6 +1676,23 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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


