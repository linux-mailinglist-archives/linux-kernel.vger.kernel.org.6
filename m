Return-Path: <linux-kernel+bounces-516908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33AA37983
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704C3188E92A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8DE14F9E2;
	Mon, 17 Feb 2025 01:53:00 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9160149E00
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757179; cv=none; b=NKKLcEf0wTOf5Lxmuup6l2VBVgLAbsKLrVB7uB1hmO6OZ4vnCu6Il9u7J9VKnOQPo0o8DdzQObutXSakNgOgIAXRVgAECx3WTKQMry5kWbyzRzch+/4LnFBs5Tf+7l23VRav5sNjxhnyAnSJqDKdu0Cgg7mbNK8bOfCjV96PimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757179; c=relaxed/simple;
	bh=q9jbMPlarU7oJg9mEj5aj3sjg4ret6lxK4pjJehmmsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISEQGH6qYpjUQTjDg4nsRz51pYBi8QJmrQnPiw4sE/MMg2iQElwKmQBNQLoKy0Y/KrFx/j7gWsDNPLBHwmFC65xHinaMPjteYiVOH0iKnNlyJXYXtKVhAO1l/A+59Vn0Ju9kONZmpCPgS+HAMnNsCGRVXUYtSYMpVUgwZ++YEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yx5Gv64C1z11P4m;
	Mon, 17 Feb 2025 09:51:19 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id E67D51A0171;
	Mon, 17 Feb 2025 09:52:47 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemg100017.china.huawei.com
 (7.202.181.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 09:52:47 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <mhocko@suse.com>
CC: <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] mm: memory-failure: update ttu flag inside unmap_poisoned_folio
Date: Mon, 17 Feb 2025 09:43:27 +0800
Message-ID: <20250217014329.3610326-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217014329.3610326-1-mawupeng1@huawei.com>
References: <20250217014329.3610326-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg100017.china.huawei.com (7.202.181.58)

From: Ma Wupeng <mawupeng1@huawei.com>

Commit 6da6b1d4a7df ("mm/hwpoison: convert TTU_IGNORE_HWPOISON to
TTU_HWPOISON") introduce TTU_HWPOISON to replace TTU_IGNORE_HWPOISON
in order to stop send SIGBUS signal when accessing an error page after
a memory error on a clean folio. However during page migration, anon
folio must be set with TTU_HWPOISON during unmap_*(). For pagecache
we need some policy just like the one in hwpoison_user_mappings to
set this flag. So move this policy from hwpoison_user_mappings to
unmap_poisoned_folio to handle this warning properly.

Warning will be produced during unamp poison folio with the following log:

  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 365 at mm/rmap.c:1847 try_to_unmap_one+0x8fc/0xd3c
  Modules linked in:
  CPU: 1 UID: 0 PID: 365 Comm: bash Tainted: G        W          6.13.0-rc1-00018-gacdb4bbda7ab #42
  Tainted: [W]=WARN
  Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
  pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : try_to_unmap_one+0x8fc/0xd3c
  lr : try_to_unmap_one+0x3dc/0xd3c
  Call trace:
   try_to_unmap_one+0x8fc/0xd3c (P)
   try_to_unmap_one+0x3dc/0xd3c (L)
   rmap_walk_anon+0xdc/0x1f8
   rmap_walk+0x3c/0x58
   try_to_unmap+0x88/0x90
   unmap_poisoned_folio+0x30/0xa8
   do_migrate_range+0x4a0/0x568
   offline_pages+0x5a4/0x670
   memory_block_action+0x17c/0x374
   memory_subsys_offline+0x3c/0x78
   device_offline+0xa4/0xd0
   state_store+0x8c/0xf0
   dev_attr_store+0x18/0x2c
   sysfs_kf_write+0x44/0x54
   kernfs_fop_write_iter+0x118/0x1a8
   vfs_write+0x3a8/0x4bc
   ksys_write+0x6c/0xf8
   __arm64_sys_write+0x1c/0x28
   invoke_syscall+0x44/0x100
   el0_svc_common.constprop.0+0x40/0xe0
   do_el0_svc+0x1c/0x28
   el0_svc+0x30/0xd0
   el0t_64_sync_handler+0xc8/0xcc
   el0t_64_sync+0x198/0x19c
  ---[ end trace 0000000000000000 ]---

Fixes: 6da6b1d4a7df ("mm/hwpoison: convert TTU_IGNORE_HWPOISON to TTU_HWPOISON")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h       |  5 ++--
 mm/memory-failure.c | 61 +++++++++++++++++++++++----------------------
 mm/memory_hotplug.c |  3 ++-
 3 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9826f7dce607..c9186ca8d7c2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1102,7 +1102,7 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
  * mm/memory-failure.c
  */
 #ifdef CONFIG_MEMORY_FAILURE
-void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu);
+int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
 void shake_folio(struct folio *folio);
 extern int hwpoison_filter(struct page *p);
 
@@ -1125,8 +1125,9 @@ unsigned long page_mapped_in_vma(const struct page *page,
 		struct vm_area_struct *vma);
 
 #else
-static inline void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
+static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
 {
+	return -EBUSY;
 }
 #endif
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a7b8ccd29b6f..b5212b6e330a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1556,8 +1556,34 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
 	return ret;
 }
 
-void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
+int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
 {
+	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
+	struct address_space *mapping;
+
+	if (folio_test_swapcache(folio)) {
+		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
+		ttu &= ~TTU_HWPOISON;
+	}
+
+	/*
+	 * Propagate the dirty bit from PTEs to struct page first, because we
+	 * need this to decide if we should kill or just drop the page.
+	 * XXX: the dirty test could be racy: set_page_dirty() may not always
+	 * be called inside page lock (it's recommended but not enforced).
+	 */
+	mapping = folio_mapping(folio);
+	if (!must_kill && !folio_test_dirty(folio) && mapping &&
+	    mapping_can_writeback(mapping)) {
+		if (folio_mkclean(folio)) {
+			folio_set_dirty(folio);
+		} else {
+			ttu &= ~TTU_HWPOISON;
+			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
+				pfn);
+		}
+	}
+
 	if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
 		struct address_space *mapping;
 
@@ -1572,7 +1598,7 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 		if (!mapping) {
 			pr_info("%#lx: could not lock mapping for mapped hugetlb folio\n",
 				folio_pfn(folio));
-			return;
+			return -EBUSY;
 		}
 
 		try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
@@ -1580,6 +1606,8 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 	} else {
 		try_to_unmap(folio, ttu);
 	}
+
+	return folio_mapped(folio) ? -EBUSY : 0;
 }
 
 /*
@@ -1589,8 +1617,6 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 		unsigned long pfn, int flags)
 {
-	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
-	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success;
 	int forcekill;
@@ -1613,29 +1639,6 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	if (!folio_mapped(folio))
 		return true;
 
-	if (folio_test_swapcache(folio)) {
-		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
-		ttu &= ~TTU_HWPOISON;
-	}
-
-	/*
-	 * Propagate the dirty bit from PTEs to struct page first, because we
-	 * need this to decide if we should kill or just drop the page.
-	 * XXX: the dirty test could be racy: set_page_dirty() may not always
-	 * be called inside page lock (it's recommended but not enforced).
-	 */
-	mapping = folio_mapping(folio);
-	if (!(flags & MF_MUST_KILL) && !folio_test_dirty(folio) && mapping &&
-	    mapping_can_writeback(mapping)) {
-		if (folio_mkclean(folio)) {
-			folio_set_dirty(folio);
-		} else {
-			ttu &= ~TTU_HWPOISON;
-			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
-				pfn);
-		}
-	}
-
 	/*
 	 * First collect all the processes that have the page
 	 * mapped in dirty form.  This has to be done before try_to_unmap,
@@ -1643,9 +1646,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	 */
 	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_poisoned_folio(folio, ttu);
-
-	unmap_success = !folio_mapped(folio);
+	unmap_success = !unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
 	if (!unmap_success)
 		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
 		       pfn, folio_mapcount(folio));
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c43b4e7fb298..3de661e57e92 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1806,7 +1806,8 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			if (WARN_ON(folio_test_lru(folio)))
 				folio_isolate_lru(folio);
 			if (folio_mapped(folio))
-				unmap_poisoned_folio(folio, TTU_IGNORE_MLOCK);
+				unmap_poisoned_folio(folio, pfn, false);
+
 			continue;
 		}
 
-- 
2.43.0


