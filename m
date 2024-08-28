Return-Path: <linux-kernel+bounces-304596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C196224C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BF9B22F60
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6215B99D;
	Wed, 28 Aug 2024 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fhQw7N/w"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C24115B55D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833738; cv=none; b=PU7BxagJ33hFxkQ3lUYZVJNIAKkZwkVWOJH8RPuj8hSu3dRxtKCIIb6mWqPe75GPQbnrDlE4sv4PI+zJyUQUvNQbr4/Fz6HZn43KrWZcymx1mQ0sytwuuGJGiVnEw4FZCL4oPznXxSImAJ/M05B/XSq0Ho4ATNJPgqeaM3jctIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833738; c=relaxed/simple;
	bh=vt/PKqQxRCSOhFcPYuvlwld6ugqPfAInUau/Lp3kCH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZAjWpQbIXpwxWgdP8udIDaaj3QK/Nqug0gybJ5osbA6F2xJ4mLCZK5S+XGp8cCKFHNb8NnMRe9Nk1rArea3SiAgyU2Xp38Iq3+U/rMpVzhxNKOp98Gg081Fpzu5fTkF+siMm9FLWp0vPcxLmX5PNfqBOaEiqS1+F5Ot9tjaaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fhQw7N/w; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724833733; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=97ju4RMpYK6Qa1Bay+6iKFFpZc4GsCYy2UsOfQ1P8ao=;
	b=fhQw7N/wP72lmcfsgIVApmrztLKYr0nXZYLTYdY7ahBtoIH3ws2gdc4W2molYzuBWybN2RIOUsskk/94siMCndItDOxhF02KyM5tbS7fkqUnoGgjvsfocjLRFB19JQTI/bUdyKwYdZNPBuCjJkASdgEMarh6iq8m8k/Y9HjWXsk=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDpB22x_1724833730)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 16:28:51 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: hughd@google.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	da.gomez@samsung.com,
	david@redhat.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	p.raghav@samsung.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: [PATCH] mm: shmem: support large folio swap out fix 2
Date: Wed, 28 Aug 2024 16:28:38 +0800
Message-Id: <1236a002daa301b3b9ba73d6c0fab348427cf295.1724833399.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <aef55f8d-6040-692d-65e3-16150cce4440@google.com>
References: <aef55f8d-6040-692d-65e3-16150cce4440@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Hugh said:
"
The i915 THP splitting inshmem_writepage() was to avoid mm VM_BUG_ONs and
crashes when shmem.c did not support huge page swapout: but now you are
enabling that support, and such VM_BUG_ONs and crashes are gone (so far
as I can see: and this is written on a laptop using the i915 driver).

I cannot think of why i915 itself would care how mm implements swapout
(beyond enjoying faster): I think all the wbc->split_large_folio you
introduce here should be reverted.
"

So this fixup patch will remove the wbc->split_large_folio as suggested
by Hugh.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
This fixup patch is based on 2024-08-28 mm-unstable branch.
Andrew, please help to squash this fixup patch. Thanks.
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 1 -
 include/linux/writeback.h                 | 1 -
 mm/shmem.c                                | 9 ++++-----
 mm/vmscan.c                               | 4 +---
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index c66cb9c585e1..c5e1c718a6d2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -308,7 +308,6 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 		.range_start = 0,
 		.range_end = LLONG_MAX,
 		.for_reclaim = 1,
-		.split_large_folio = 1,
 	};
 	unsigned long i;
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 10100e22d5c6..51278327b3c6 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -63,7 +63,6 @@ struct writeback_control {
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
 	unsigned unpinned_netfs_wb:1;	/* Cleared I_PINNING_NETFS_WB */
-	unsigned split_large_folio:1;	/* Split large folio for shmem writeback */
 
 	/*
 	 * When writeback IOs are bounced through async layers, only the
diff --git a/mm/shmem.c b/mm/shmem.c
index 16099340ca1d..2b0209d6ac9c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1473,19 +1473,18 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		goto redirty;
 
 	/*
-	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
-	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
-	 * and its shmem_writeback() needs them to be split when swapping.
+	 * If CONFIG_THP_SWAP is not enabled, the large folio should be
+	 * split when swapping.
 	 *
 	 * And shrinkage of pages beyond i_size does not split swap, so
 	 * swapout of a large folio crossing i_size needs to split too
 	 * (unless fallocate has been used to preallocate beyond EOF).
 	 */
 	if (folio_test_large(folio)) {
-		split = wbc->split_large_folio;
 		index = shmem_fallocend(inode,
 			DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
-		if (index > folio->index && index < folio_next_index(folio))
+		if ((index > folio->index && index < folio_next_index(folio)) ||
+		    !IS_ENABLED(CONFIG_THP_SWAP))
 			split = true;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 283e3f9d652b..f27792e77a0f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -681,10 +681,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 		 * not enabled or contiguous swap entries are failed to
 		 * allocate.
 		 */
-		if (shmem_mapping(mapping) && folio_test_large(folio)) {
+		if (shmem_mapping(mapping) && folio_test_large(folio))
 			wbc.list = folio_list;
-			wbc.split_large_folio = !IS_ENABLED(CONFIG_THP_SWAP);
-		}
 
 		folio_set_reclaim(folio);
 		res = mapping->a_ops->writepage(&folio->page, &wbc);
-- 
2.39.3


