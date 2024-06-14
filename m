Return-Path: <linux-kernel+bounces-214202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF3908124
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BF2B232E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F51836EC;
	Fri, 14 Jun 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrVumhDF"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720261836E2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329951; cv=none; b=DjBxGrSMezCYKuhOxB4HtzIUbEo96rR6mWJzKOYQv6wLvjmXuS7Bcr5Z8CjM1wtkmbB1Ci+NoMTAC5T7F57625qfI/tshLR4TkgY02gKR9/Nt7r/r0qXqH2PSvZGdGN3E8roUlBREATOhLrmIKybp58CoYVEqU0qglLmiAjngLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329951; c=relaxed/simple;
	bh=3a9FeUWHB8TvmQPb495/m7vd26mtQHq+6jEXIAin+D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iC9/kHgGl5CQwnTtqEDZXAqE4WH8tU92vo/htQ57UuqaEK/i2sEmfpvambO4wjw3mts/dk4bdlT981i4SNPjml73Am7Hz2h2dRXeb6Q7TDiJ6bEznI3jdxv+VMtXuJgyZXvTRCjWIiBBRHR3cuczjYeVngWBgL+sqxYTvssW6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrVumhDF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70413de08c7so1257428b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718329950; x=1718934750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/pT6ukJbZTbcHICd4lFILO7tOygQ9w7tdWCnznoYp8=;
        b=lrVumhDFNg3Fg3fHkxfmOC+kS0sbzQfXGrgHP51A9a/JndpINxlMxPiI8IPFa0kacy
         tIsSN43JRlsE6zykWx6bRg1hRis6CwQuKRwAhy+cIylvxv0voyeYx0/1rN/eFr5dPsnm
         868EhFslo9dClRDlymmIHmpCRPjfObmPo0AarS3EF/P2UlHKiwVD2GAsCxsbjOycAYI3
         eiZ1VQLI6ZFhaO+gelTsiQ6gTPDIkUmPKBerTDUeyApYZXi02TqMC7xeYXDdUtskIodf
         bNi3ROyPA5cQmT47WyRAgaO9RVrJ2P/yUhTkXvKXI9/FZf7iVTqMJ/UTrlYFiMrVCOHF
         67tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718329950; x=1718934750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/pT6ukJbZTbcHICd4lFILO7tOygQ9w7tdWCnznoYp8=;
        b=epVqU+Dxa1W5g0WfXJnbGwhCAfEK21//SXuM63z8DMKq8lLvrSdETlf4senw5inhL0
         j1/xXijU9UALRRuOxRrVDQ8fLIN+MsJTzo2GiUaJ/SWyYOiJo4cWPbudMGan/gYE/JWI
         TPZ1jUNXzSlEFCoYlRE8elCd01SF1YUcl0r13iCMdy5ZOjXXOe+X2Akdwym59qYkXBuB
         EudPYviqv+oOOHNYLNXsm9JpaZnAGgDOitEOMNz/bgYIMKOgNSTbNFNHWHuoRnmjmAsg
         gspWTkOnFbgt4BqnhJFz+MYZtF2sdDFi3XfJTUNbLtkQKzx0g44MtCuqAY7gp1yPlxpQ
         cZtg==
X-Forwarded-Encrypted: i=1; AJvYcCVl7E7QZ6VjjPq+HlJTAudYD/5B6X0gu5AqYJ9LeycIhJDfAVAVK4PIZmnINRUBqQhXXQNzk5Bb5+wPyBrNl7B3q4QJIWMavHduZUa/
X-Gm-Message-State: AOJu0YxAU6z44n5eOu2Pq7TFSdlwnqch2h7YXQLEXmJVYMlYk4eJjhYU
	ZybEMHQpTHWG+b6O0DLZE3Pai0M0t95svB2qRWi9ZeIJ7aK9iESt
X-Google-Smtp-Source: AGHT+IHa1l1GAHgQyasvK4lvnN2hIWQ3RAuc8OqBpVBkUd1r2gMswUPTOL3yjTTBw1mSXUjvCm3kSg==
X-Received: by 2002:a05:6a00:234c:b0:704:147b:d768 with SMTP id d2e1a72fcca58-705d71d0e4cmr1657112b3a.24.1718329949695;
        Thu, 13 Jun 2024 18:52:29 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96d4c3sm2000912b3a.59.2024.06.13.18.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 18:52:29 -0700 (PDT)
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
Subject: [PATCH v8 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Fri, 14 Jun 2024 09:51:38 +0800
Message-Id: <20240614015138.31461-4-ioworker0@gmail.com>
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
 mm/huge_memory.c        | 76 +++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c               | 27 +++++++++------
 3 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9f720b0731c4..212cca384d7e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -430,6 +430,8 @@ static inline bool thp_migration_supported(void)
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio);
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio);
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -497,6 +499,13 @@ static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
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
index e766d3f3a302..425374ae06ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2688,6 +2688,82 @@ static void unmap_folio(struct folio *folio)
 	try_to_unmap_flush();
 }
 
+static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
+					    unsigned long addr, pmd_t *pmdp,
+					    struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+
+	struct mm_struct *mm = vma->vm_mm;
+	int ref_count, map_count;
+	pmd_t orig_pmd = *pmdp;
+	struct page *page;
+
+	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
+		return false;
+
+	page = pmd_page(orig_pmd);
+	if (unlikely(page_folio(page) != folio))
+		return false;
+
+	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
+		return false;
+
+	orig_pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
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
+	 * If the folio or its PMD is redirtied at this point, or if there
+	 * are unexpected references, we will give up to discard this folio
+	 * and remap it.
+	 *
+	 * The only folio refs must be one from isolation plus the rmap(s).
+	 */
+	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd) ||
+	    ref_count != map_count + 1) {
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
+		return __discard_anon_folio_pmd_locked(vma, addr, pmdp, folio);
+
+	return false;
+}
+
 static void remap_page(struct folio *folio, unsigned long nr)
 {
 	int i = 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index dacf24bc82f0..7d97806f74cd 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1678,16 +1678,23 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			goto walk_abort;
 		}
 
-		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
-			/*
-			 * We temporarily have to drop the PTL and start once
-			 * again from that now-PTE-mapped page table.
-			 */
-			split_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
-					      false, folio);
-			flags &= ~TTU_SPLIT_HUGE_PMD;
-			page_vma_mapped_walk_restart(&pvmw);
-			continue;
+		if (!pvmw.pte) {
+			if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
+						  folio))
+				goto walk_done;
+
+			if (flags & TTU_SPLIT_HUGE_PMD) {
+				/*
+				 * We temporarily have to drop the PTL and start
+				 * once again from that now-PTE-mapped page
+				 * table.
+				 */
+				split_huge_pmd_locked(vma, pvmw.address,
+						      pvmw.pmd, false, folio);
+				flags &= ~TTU_SPLIT_HUGE_PMD;
+				page_vma_mapped_walk_restart(&pvmw);
+				continue;
+			}
 		}
 
 		/* Unexpected PMD-mapped THP? */
-- 
2.33.1


