Return-Path: <linux-kernel+bounces-177283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2BA8C3C60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5751F20EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C11146D57;
	Mon, 13 May 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw21qV9d"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98161474D1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586496; cv=none; b=kMv888chqziSXVqGyg1UICiItYweZjdLdkwgaHHFnzZA+jlSSa+tjUHcL6tZUWt+a+mrl1VJDFvproP9qQc9xLfiCNf/vFAZTRmeBtA4PolsLmBFK0SmCa5iF1Ea7/UI6uQPNJJl4oIvFZiGqb5A2ahzSOokTNzYHBLbqGhmtGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586496; c=relaxed/simple;
	bh=8oylBjrPA3UkDtruPJmckDAw7S/IjFxo/+MNRa/XCig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9Q6CHkcnh0tmiNUzbmBn9dkD8Wonbkz9iW5nPbjbMHQXpuu/ZgMpt4IeMa1ksIV+qJkhlOFVrE6DSCb1jqAQbRtuxtYmhNdFX9K/tCAFxmOcUUiaEq2QyCphOhCvRVEtnll/NElMDqUmccfB0iA7AWl/i5ETM3wTWZITsKL2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw21qV9d; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23ee34c33ceso2732258fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715586494; x=1716191294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHDREbDidUboYr6GnUNHG4W7oH+tz8aegBIo3ouG4XE=;
        b=lw21qV9diH8KeXZSM2qvhPAaVM7e7M3dt9V5s9uWCICbt4L6KqSsy4HxSpGCWF9uFG
         yRVm/Oao0SEvfdqAeNOuHJnWqWBkb8y+jYNoqCdm2FY3UqjZA1ewmwYnlCrflxq8LsOG
         iPPiZKTNOV0psOOTQF2G3O0rOIKyxbtbIBc6r7JcpnFJai9/HnxNA+qGlj9kfeu+PWbr
         RQiThL0ZgVsQLwyPDzk3PbPcZbjarysIU+dY9EQI2X9UKkMLJfJhCJ5FS3CSk6RlmD9x
         VGBTQncSPBlE12rnAFcmnqGDAI1I0PfljIK6pHX3X/xlKuir78EOtX/43/qPiEDyWg3T
         iH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586494; x=1716191294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHDREbDidUboYr6GnUNHG4W7oH+tz8aegBIo3ouG4XE=;
        b=A9YLIwCW2Zoh4bupSAuRAeeWne7WHc9FwLScZF9q+vkCUBy9324lcKKKuLrxnbM4L5
         R+W4QagPy9pPe3ZajFLPkXVjjvBWNs5N25QAYdQhuDsZ1RyxmpVPj0DHAblVRwM/4DRx
         PlFBqSn2iCuSurOeO4zTR7MyNSa6T6yIM+5hDbnT0wd97XWSxlyk/Byc+vnjCQwwrYLA
         ICk1AAkhpBiZKpe8VugfE/LFnDj5dD42cb0ru23R7qX+CtLjMnMKQIpbb4O+Q/G+9XB/
         SjkfHWVZ3BJhbgbqmMxIQi7viS2i1lR2X32UUP4BsmHDt+kSdoeD1NK9Wf4KHGA6fQXd
         VxVg==
X-Forwarded-Encrypted: i=1; AJvYcCXKtwkqwD75U83ElTJ5yJ/YVHHM8Nx1upXpaV61q/QWxI3BCF59WBzIn+c9+E4Et9TCGv+gx8bqwglVPVAHPS5U+OsEZEOFPIu59Ldg
X-Gm-Message-State: AOJu0YwDRUhpeUMDTJbhzXHS45AzeFUGq+7unbFUnUPmFafK0b3Jvbha
	LW9TfE39/wdWuDJVkb7AQ27e3FTLwLQgQ4eGXumDkPxoRuUUpicE
X-Google-Smtp-Source: AGHT+IGWP4QQxcq2qCQ2sZa1iPOyt28+tz+E8mRQ1zmnhWzt3PbQUI3aIYx7WgDuIqeI+fL5E7v2Ug==
X-Received: by 2002:a05:6871:a9c3:b0:23e:b42a:49d with SMTP id 586e51a60fabf-24172f67492mr11117705fac.43.1715586493775;
        Mon, 13 May 2024 00:48:13 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66621sm7008967b3a.13.2024.05.13.00.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:48:13 -0700 (PDT)
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
Subject: [PATCH RESEND v5 4/4] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Mon, 13 May 2024 15:47:12 +0800
Message-Id: <20240513074712.7608-5-ioworker0@gmail.com>
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

When the user no longer requires the pages, they would use
madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
typically would not re-write to that memory again.

During memory reclaim, if we detect that the large folio and its PMD are
both still marked as clean and there are no unexpected references
(such as GUP), so we can just discard the memory lazily, improving the
efficiency of memory reclamation in this case.

On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
mem_cgroup_force_empty() results in the following runtimes in seconds
(shorter is better):

--------------------------------------------
|     Old       |      New       |  Change  |
--------------------------------------------
|   0.683426    |    0.049197    |  -92.80% |
--------------------------------------------

Suggested-by: Zi Yan <ziy@nvidia.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  9 +++++
 mm/huge_memory.c        | 75 +++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c               | 31 ++++++++++-------
 3 files changed, 103 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9fcb0b0b6ed1..cfd7ec2b6d0a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio);
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio);
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -478,6 +480,13 @@ static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
 					 unsigned long address, pmd_t *pmd,
 					 bool freeze, struct folio *folio) {}
 
+static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
+					 unsigned long addr, pmd_t *pmdp,
+					 struct folio *folio)
+{
+	return false;
+}
+
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 425272c6c50b..3ceeeb2f42d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2687,6 +2687,81 @@ static void unmap_folio(struct folio *folio)
 	try_to_unmap_flush();
 }
 
+static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
+				       unsigned long addr, pmd_t *pmdp,
+				       struct folio *folio)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int ref_count, map_count;
+	pmd_t orig_pmd = *pmdp;
+	struct mmu_gather tlb;
+	struct page *page;
+
+	if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
+		return false;
+	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
+		return false;
+
+	page = pmd_page(orig_pmd);
+	if (unlikely(page_folio(page) != folio))
+		return false;
+
+	tlb_gather_mmu(&tlb, mm);
+	orig_pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
+	tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
+
+	/*
+	 * Syncing against concurrent GUP-fast:
+	 * - clear PMD; barrier; read refcount
+	 * - inc refcount; barrier; read PMD
+	 */
+	smp_mb();
+
+	ref_count = folio_ref_count(folio);
+	map_count = folio_mapcount(folio);
+
+	/*
+	 * Order reads for folio refcount and dirty flag
+	 * (see comments in __remove_mapping()).
+	 */
+	smp_rmb();
+
+	/*
+	 * If the PMD or folio is redirtied at this point, or if there are
+	 * unexpected references, we will give up to discard this folio
+	 * and remap it.
+	 *
+	 * The only folio refs must be one from isolation plus the rmap(s).
+	 */
+	if (ref_count != map_count + 1 || folio_test_dirty(folio) ||
+	    pmd_dirty(orig_pmd)) {
+		set_pmd_at(mm, addr, pmdp, orig_pmd);
+		return false;
+	}
+
+	folio_remove_rmap_pmd(folio, page, vma);
+	zap_deposited_table(mm, pmdp);
+	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+	if (vma->vm_flags & VM_LOCKED)
+		mlock_drain_local();
+	folio_put(folio);
+
+	return true;
+}
+
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
+
+	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
+		return __discard_trans_pmd_locked(vma, addr, pmdp, folio);
+
+	return false;
+}
+
 static void remap_page(struct folio *folio, unsigned long nr)
 {
 	int i = 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index 08a93347f283..e09f2141b8dc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1677,18 +1677,25 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			goto walk_done_err;
 		}
 
-		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
-			/*
-			 * We temporarily have to drop the PTL and start once
-			 * again from that now-PTE-mapped page table.
-			 */
-			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
-					      folio);
-			pvmw.pmd = NULL;
-			spin_unlock(pvmw.ptl);
-			pvmw.ptl = NULL;
-			flags &= ~TTU_SPLIT_HUGE_PMD;
-			continue;
+		if (!pvmw.pte) {
+			if (unmap_huge_pmd_locked(vma, range.start, pvmw.pmd,
+						  folio))
+				goto walk_done;
+
+			if (flags & TTU_SPLIT_HUGE_PMD) {
+				/*
+				 * We temporarily have to drop the PTL and start
+				 * once again from that now-PTE-mapped page
+				 * table.
+				 */
+				split_huge_pmd_locked(vma, range.start,
+						      pvmw.pmd, false, folio);
+				pvmw.pmd = NULL;
+				spin_unlock(pvmw.ptl);
+				pvmw.ptl = NULL;
+				flags &= ~TTU_SPLIT_HUGE_PMD;
+				continue;
+			}
 		}
 
 		/* Unexpected PMD-mapped THP? */
-- 
2.33.1


