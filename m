Return-Path: <linux-kernel+bounces-277471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5D694A1CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CB51F2755B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD4C1C823E;
	Wed,  7 Aug 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yPx/XrFW"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11B1CCB5C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015909; cv=none; b=BzX8JNOFqqv011Y1BBl4pUHzqk/bNtNrlZ+3ODzaIuLnIXBs/w8W6esggAw3a0ROMTK9iVnXDy2vkKc4HxlYymlAl3EoupSdvjUmuhoeyQd+BXnJ6EVZ+mzOX5S+U9TcCiUlmpvJG2LDgl/5c9h/Vgu5D+d3t17pPV2lM3PIHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015909; c=relaxed/simple;
	bh=2KhQNGU6e+kAS+zjUhidX5/85PALtRlyVn3/p0KAAVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2Z9Upt9GapFWazMJr1BnRQXT+9PfV3VpcC4SRCn/crPToNaQbwVPrPxY0hJIxAMDd4pORybnwgO/alB54Rew256x+NIlJlecIa3mVlMRlBhqaVC18jxAH5xOLJVpsCyZ5AVav91was9rpRLiZ88Ox/KOS3NSVwIxfSforfX1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yPx/XrFW; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015899; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XLdaxVnaY8exdxuocJxch8tgZFD8ONcm7TklvWpmdt0=;
	b=yPx/XrFW5q9Zzz0eKZ/ZmzSLtD26dyosnWdsdmAFUfDOC5rKzRGvFAhYSOkcq7ymCqfaPAc4fiNGNXCkDof96usrZfXIe1XvbXLjXwf06IivImzdv+3/NxtgX4+ZjcFWpdmzE0H1qJpC/0vUxJLX00pDbsXCPex+vW81vpvMFeA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI1T1O_1723015897;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI1T1O_1723015897)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:37 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/10] mm: shmem: support large folio swap out
Date: Wed,  7 Aug 2024 15:31:15 +0800
Message-Id: <a7f632e1d8976e6de37e3e60358e1406048b4e7e.1723012159.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
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

[1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  1 +
 include/linux/writeback.h                 |  1 +
 mm/shmem.c                                |  3 +--
 mm/vmscan.c                               | 14 ++++++++++++--
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index c5e1c718a6d2..c66cb9c585e1 100644
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
index 1a54676d843a..75196b0f894f 100644
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
index 996062dc196b..68c9a31bc763 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -795,7 +795,6 @@ static int shmem_add_to_page_cache(struct folio *folio,
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
-	VM_BUG_ON(expected && folio_test_large(folio));
 
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -1482,7 +1481,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
 	 * and its shmem_writeback() needs them to be split when swapping.
 	 */
-	if (folio_test_large(folio)) {
+	if (wbc->split_large_folio && folio_test_large(folio)) {
 		/* Ensure the subpages are still dirty */
 		folio_test_set_dirty(folio);
 		if (split_huge_page(page) < 0)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 796f65781f4f..21acd6c2fbab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1267,8 +1267,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
 
@@ -1370,10 +1374,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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


