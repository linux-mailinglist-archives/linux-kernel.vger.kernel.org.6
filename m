Return-Path: <linux-kernel+bounces-208133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7B2902145
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC81C214CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39127E575;
	Mon, 10 Jun 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgXtpv0Q"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4056444
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021303; cv=none; b=d7oXaaTpgVaDp6wLiJFvcLsDswtVFckMrdFrSVdDBDtpt2pgA9XmfdAp58T4h4zt5KK5R9BPbtdruWAX9fZekM7cie0GVEG0dK3bVlnuCCTgUS5WvjitAAwbUiKthQdYwrdpPlV8tLLVkeJrwjh2bVKSaA9YKUus+feFHTWVtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021303; c=relaxed/simple;
	bh=8zF6nJ1lU41KTQQbpcXIcwPW+iqqy1WM7zfobETrTlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIcC9qYydOPRY/Q0bqB+JFIUxNlFmVZKTUBLoALNt0Gd4uaXxL36oa6UstFxqslW55QVBJHaC9EcGT7WwfvZT9Vj3Y/90n0kA4PoHPDu+ka/0jmdm4MioSbJo7lzaSduyxlCW3zzX2+J2mNvSDLAG5bdq/xlatEW9fvZxWJZzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgXtpv0Q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so3325713a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718021302; x=1718626102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOCokgIFZnMYHU7kHatHCs1R7LhgAcEFFxJDcineuXY=;
        b=XgXtpv0QsZQYL4+gTZzk7wnnTBIDbpj+Y8rcZ54qUIZigbouimRLxa6KJv3NaJK2Xp
         MbZ1/1IgRw7sTtWxfS0aIpyOj5uC06ych836uchbiKNvl60oTuJRMbrgp1I92v0qzYF4
         Oy27EIXRUuhoPNS4f3KAUO+ZEOoCJHQO1T261yNEOm35jn/Z6T8ZQb1K95zwfXX/Pct8
         42KbQfK3cvb5YUJpj2U3yNAMl4iAAwpSOwHw3/8iqw0MDPSdui/Ss5xK8FZTaghnv64n
         zIav57hmc75N6blDxy0h1zqpsUbDgzk3u3jhd6+IZ2o8qBLdAxwtksZZbGMJCUtuxORM
         bFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718021302; x=1718626102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOCokgIFZnMYHU7kHatHCs1R7LhgAcEFFxJDcineuXY=;
        b=C/vrvns31M+7qmryqN39woVZUNFSGrfNf7p6ubebEWFxBhCO2uYYwVxYB8uTLabvJH
         r+ZXL8pTEYVn0y8qQ+j5595ze09Gh5UTJgtdwZ40gUn7K4gehO5662K17iCfRPq3cABS
         nvHWtJkjFO+Uuf+va0HtIMqyKHdp6WD1rK79fDomoY6KjSDjoeKvGEgzPkk+1UhuP8m5
         k4X69Vm2b79k1n5rEJZPXoeMe8x1/lQPwnsOAxfjatXSfS9JAdxcYXzAuXbIfvg9TPBE
         rPlO6Rs4uVXy0rC5KRdO/CAOlJQS401ICIIhd+5BCThZ0EJNMl1Sv64OwiJLF0ke8svE
         6Ifg==
X-Forwarded-Encrypted: i=1; AJvYcCVXSI4ic7TBCWMpPm93OmVVlD3aUvb2D/Xor6b5NGhcFXTNdw/NzZ0n00LABlp+l9sfWWqIXqvy5y/WP1uHCmLDjVTyzBEFfOCKVNF/
X-Gm-Message-State: AOJu0YwThX5Hln6U4pzTwgim1bMl3o2nwB/a5ZJV3gZh35KGvCV5DhUT
	xxM8au4G3KRJdGIpI/kIvD4UqB9HIJT2yTl8rhpEl0/6O4bGpP3U
X-Google-Smtp-Source: AGHT+IGiVdBdiRyrTFD3fLPkOV4Q3GrQwZQWB402am+vntnYPikYw03+qIKJb0cFryGT4hjcfjPjvA==
X-Received: by 2002:a17:903:2b0e:b0:1f4:5dc0:5fe8 with SMTP id d9443c01a7336-1f6d02e22efmr107290335ad.15.1718021301570;
        Mon, 10 Jun 2024 05:08:21 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76c1d2sm81011355ad.107.2024.06.10.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:08:21 -0700 (PDT)
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
Subject: [PATCH v7 4/4] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Mon, 10 Jun 2024 20:08:09 +0800
Message-Id: <20240610120809.66601-1-ioworker0@gmail.com>
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
 mm/huge_memory.c        | 80 +++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c               | 36 +++++++++++++------
 3 files changed, 114 insertions(+), 11 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4670c6ee118b..020e2344eb86 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -417,6 +417,8 @@ static inline bool thp_migration_supported(void)
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio);
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio);
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -484,6 +486,13 @@ static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
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
index d2697cc8f9d4..19592d3f1167 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2687,6 +2687,86 @@ static void unmap_folio(struct folio *folio)
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
+	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd)) {
+		folio_set_swapbacked(folio);
+		return false;
+	}
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
+	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
+		folio_set_swapbacked(folio);
+
+	if (folio_test_swapbacked(folio) || ref_count != map_count + 1) {
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
index b77f88695588..8e901636ade9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1630,6 +1630,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	bool pmd_mapped = false;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1676,16 +1677,24 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			goto walk_done_err;
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
+			pmd_mapped = true;
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
@@ -1813,7 +1822,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			if (unlikely(folio_test_swapbacked(folio) !=
 					folio_test_swapcache(folio))) {
-				WARN_ON_ONCE(1);
+				/*
+				 * unmap_huge_pmd_locked() will unmark a
+				 * PMD-mapped folio as lazyfree if the folio or
+				 * its PMD was redirtied.
+				 */
+				WARN_ON_ONCE(!pmd_mapped);
 				goto walk_done_err;
 			}
 
-- 
2.33.1


