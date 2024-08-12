Return-Path: <linux-kernel+bounces-282737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D372F94E804
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF082825E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFF16D9D9;
	Mon, 12 Aug 2024 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sDCzgibt"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47715886B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448559; cv=none; b=ZQwEzlSFvmISheI8JwBpfJRAA7F7N7NZyyPT+kXbKMhxO+4078LbdnqUX1ifu9bw2Pp7d69fy8rSaBmAP//OgEy8lIdVdyHqGcA1gOjD6n2km7etdYVyL2XJ3t5wNwdJngjTOWSTLxdWMhmYBbmLUYzpQMfUoDuZ14uhfDziNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448559; c=relaxed/simple;
	bh=L1tUkGG2sobTCu0i+kAP6ENbalJz5VP6gTOk0FbXJNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmlDf0oIupRrAa7ahk1u1z7dLXisEexhT3WxmAbCuc4eIfBIv7A6vbdkMHFoi6kWWzSmB4yXU3AEnESoM5BTZsTcPt8/ZrvN8yMioxF6AXYzhXjEyDEQNSiINbuxa637L8imZrR6oFCIFjn7RJv1citD0YyJyQjNZEoTdePnVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sDCzgibt; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723448547; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PZslh3xDjv8KO1NsIQv9gTqVJj0244TUIWHfHI4JVZY=;
	b=sDCzgibtglDth7yEb06ZF+JPV3a7P8kXlyjen9puTazzWqLXGurUo8JQLXMwluUBT2ZI2zlqp6a2wd2202r6sJhrj95PZg2es7ua5U+8+ZzeZALsl7bVluIDLiYwHcl9Z5vC4mBgPexIiw4XxvUHBXd3x3pUf1SgzJ2VMIFzXZs=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCbU5vC_1723448545)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 15:42:26 +0800
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
Subject: [PATCH v5 8/9] mm: shmem: split large entry if the swapin folio is not large
Date: Mon, 12 Aug 2024 15:42:09 +0800
Message-Id: <4a0f12f27c54a62eb4d9ca1265fed3a62531a63e.1723434324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the swap device can only swap-in order 0 folio, even though a large
folio is swapped out. This requires us to split the large entry previously
saved in the shmem pagecache to support the swap in of small folios.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 345e25425e37..996062dc196b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1990,6 +1990,81 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	swap_free_nr(swap, nr_pages);
 }
 
+static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
+				   swp_entry_t swap, int new_order, gfp_t gfp)
+{
+	struct address_space *mapping = inode->i_mapping;
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, new_order);
+	void *alloced_shadow = NULL;
+	int alloced_order = 0, i;
+
+	for (;;) {
+		int order = -1, split_order = 0;
+		void *old = NULL;
+
+		xas_lock_irq(&xas);
+		old = xas_load(&xas);
+		if (!xa_is_value(old) || swp_to_radix_entry(swap) != old) {
+			xas_set_err(&xas, -EEXIST);
+			goto unlock;
+		}
+
+		order = xas_get_order(&xas);
+
+		/* Swap entry may have changed before we re-acquire the lock */
+		if (alloced_order &&
+		    (old != alloced_shadow || order != alloced_order)) {
+			xas_destroy(&xas);
+			alloced_order = 0;
+		}
+
+		/* Try to split large swap entry in pagecache */
+		if (order > 0 && order > new_order) {
+			if (!alloced_order) {
+				split_order = order;
+				goto unlock;
+			}
+			xas_split(&xas, old, order);
+
+			/*
+			 * Re-set the swap entry after splitting, and the swap
+			 * offset of the original large entry must be continuous.
+			 */
+			for (i = 0; i < 1 << order; i += (1 << new_order)) {
+				pgoff_t aligned_index = round_down(index, 1 << order);
+				swp_entry_t tmp;
+
+				tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
+				__xa_store(&mapping->i_pages, aligned_index + i,
+					   swp_to_radix_entry(tmp), 0);
+			}
+		}
+
+unlock:
+		xas_unlock_irq(&xas);
+
+		/* split needed, alloc here and retry. */
+		if (split_order) {
+			xas_split_alloc(&xas, old, split_order, gfp);
+			if (xas_error(&xas))
+				goto error;
+			alloced_shadow = old;
+			alloced_order = split_order;
+			xas_reset(&xas);
+			continue;
+		}
+
+		if (!xas_nomem(&xas, gfp))
+			break;
+	}
+
+error:
+	if (xas_error(&xas))
+		return xas_error(&xas);
+
+	return alloced_order;
+}
+
 /*
  * Swap in the folio pointed to by *foliop.
  * Caller has to make sure that *foliop contains a valid swapped folio.
@@ -2026,12 +2101,37 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
+		int split_order;
+
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
 			*fault_type |= VM_FAULT_MAJOR;
 			count_vm_event(PGMAJFAULT);
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
+
+		/*
+		 * Now swap device can only swap in order 0 folio, then we
+		 * should split the large swap entry stored in the pagecache
+		 * if necessary.
+		 */
+		split_order = shmem_split_large_entry(inode, index, swap, 0, gfp);
+		if (split_order < 0) {
+			error = split_order;
+			goto failed;
+		}
+
+		/*
+		 * If the large swap entry has already been split, it is
+		 * necessary to recalculate the new swap entry based on
+		 * the old order alignment.
+		 */
+		if (split_order > 0) {
+			pgoff_t offset = index - round_down(index, 1 << split_order);
+
+			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+		}
+
 		/* Here we actually start the io */
 		folio = shmem_swapin_cluster(swap, gfp, info, index);
 		if (!folio) {
-- 
2.39.3


