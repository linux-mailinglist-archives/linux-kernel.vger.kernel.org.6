Return-Path: <linux-kernel+bounces-184855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B26F8CAD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDB71C21EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870CA74404;
	Tue, 21 May 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JSbbCpxS"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863479B9D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289433; cv=none; b=cr0H+VLJdIsQYMhWcN9KjG9hfR+vfP87/4KVqA0bI/uVebuxPJY9s1FbGfOfhysWFdGRH2vg9A9NbcKvVQp5jN3aQYj4hi6VDQGI6mq/FH8pkBReNXq3GClob5CxRAs9NE/tLDqlLheHv3QmTpEV6BHAiRuZeFjBcZy+XPNTyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289433; c=relaxed/simple;
	bh=gsjyHEcCKLsatizaYh93zXZYrs2WIQaycqvPWmajK+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RK+nNBY5oF+BmZbTF1xlwHDxntdILSNLL7Fvae0ZUfn6U7xubykbn9BhDBF1yYSHeyUZ6CsuVwfQ1T4+fU/AQpc1VAR5cF48ELaOO2XJOJ8REjgoyXTzSXLqxst5m2QWiohQWQZBWFCvaLUlM0b8YsjhsVcsuJGoorqqrt4jyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JSbbCpxS; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716289424; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3ZBjHevxDMMp9OTvEWxh5sKqkBiotmw21gIhPQdkVy8=;
	b=JSbbCpxSuHCmM8c8wQVf7vJ92cG/QxZ9CgqZn8gfNjkl1dkF+01Sx0t1M9gEimdaz/cssXeJpAmw+ZMx9yede5bRvO9tEThPVavcjSG6um/Kt7J7zxhOoFk/YhXXH2wXEuFfm0wf/lMDZgu6zO65tXQohpf0OVhk/2reNUSXYHo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W6xl98k_1716289421;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6xl98k_1716289421)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 19:03:42 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	hrisl@kernel.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/8] mm: shmem: support large folio swap out
Date: Tue, 21 May 2024 19:03:18 +0800
Message-Id: <1f50ac5f9dfa69c3c7cc57440eae2b1728178cca.1716285099.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
References: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shmem will support large folio allocation [1] [2] to get a better performance,
however, the memory reclaim still splits the precious large folios when trying
to swap out shmem, which may lead to the memory fragmentation issue and can not
take advantage of the large folio for shmeme.

Moreover, the swap code already supports for swapping out large folio without
split, hence this patch set supports the large folio swap out for shmem.

Note the i915_gem_shmem driver still need to be split when swapping, thus
add a new flag 'split_large_folio' for writeback_control to indicate spliting
the large folio.

[1] https://lore.kernel.org/all/cover.1715571279.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  1 +
 include/linux/writeback.h                 |  1 +
 mm/shmem.c                                |  3 +--
 mm/vmscan.c                               | 14 ++++++++++++--
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 38b72d86560f..968274be14ef 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -308,6 +308,7 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 		.range_start = 0,
 		.range_end = LLONG_MAX,
 		.for_reclaim = 1,
+		.split_large_folio = 1,
 	};
 	unsigned long i;
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 112d806ddbe4..6f2599244ae0 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -63,6 +63,7 @@ struct writeback_control {
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
 	unsigned unpinned_netfs_wb:1;	/* Cleared I_PINNING_NETFS_WB */
+	unsigned split_large_folio:1;	/* Split large folio for shmem writeback */
 
 	/*
 	 * When writeback IOs are bounced through async layers, only the
diff --git a/mm/shmem.c b/mm/shmem.c
index fdc71e14916c..6645169aa913 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -776,7 +776,6 @@ static int shmem_add_to_page_cache(struct folio *folio,
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
-	VM_BUG_ON(expected && folio_test_large(folio));
 
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -1460,7 +1459,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
 	 * and its shmem_writeback() needs them to be split when swapping.
 	 */
-	if (folio_test_large(folio)) {
+	if (wbc->split_large_folio && folio_test_large(folio)) {
 		/* Ensure the subpages are still dirty */
 		folio_test_set_dirty(folio);
 		if (split_huge_page(page) < 0)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bf11c0cbf12e..856286e84d62 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1260,8 +1260,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			if (!total_swap_pages)
 				goto activate_locked;
 
-			/* Split shmem folio */
-			if (split_folio_to_list(folio, folio_list))
+			/*
+			 * Only split shmem folio when CONFIG_THP_SWAP
+			 * is not enabled.
+			 */
+			if (!IS_ENABLED(CONFIG_THP_SWAP) &&
+			    split_folio_to_list(folio, folio_list))
 				goto keep_locked;
 		}
 
@@ -1363,10 +1367,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
+try_pageout:
 			switch (pageout(folio, mapping, &plug)) {
 			case PAGE_KEEP:
 				goto keep_locked;
 			case PAGE_ACTIVATE:
+				if (shmem_mapping(mapping) && folio_test_large(folio) &&
+				    !split_folio_to_list(folio, folio_list)) {
+					nr_pages = 1;
+					goto try_pageout;
+				}
 				goto activate_locked;
 			case PAGE_SUCCESS:
 				stat->nr_pageout += nr_pages;
-- 
2.39.3


