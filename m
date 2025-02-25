Return-Path: <linux-kernel+bounces-530939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0769A43A55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4698D1884550
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB71519A5;
	Tue, 25 Feb 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uj5DyjEp"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB58494
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477203; cv=none; b=qqlp1Io1a0GexiX4Rn0PFNhas3NWzEMAFiwHeSjHEJm2RStmkHFghWgkXwGY/BYsGa84mAzR7vJXaOwTRAVMevkGBydJxkNWKf6NehsLgB4lAPePNMkUKOZdqcXpTELJqlBx75nq/Td7LGP/u+kysWZHpYrWX6ipICXu8HjCN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477203; c=relaxed/simple;
	bh=G0sFW0Mo6iUqWeHZuGXwZDimuwqPDerwTIjkQQh8+Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnKkLNH3eycVoNPRSym+nJmpU22QnQkn4SF2JzxOX71NYI+o+i9KUuiPy6vhDhCoF6oNVcRkPjSvdyVfmx2ZllDhqNcvFo56qMQlKTelC82lCRetvsYnjS//r2p8jh2OAMSMutGHvVnyI2XLw+e3wbXShV/HeG7ytulqVJRZY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uj5DyjEp; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740477191; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VVoLc33zPMeaiAyTcxHiedjnEIt4XQjILMkv0uRR958=;
	b=uj5DyjEpO5VItRSzbsL/s5ik26t8ZyklVFbPcvJcDJg1D3kgfAzM4v6btBCzZ/APb7yVkyLpNG16TspAvV2QHsAtJwd569hLYKoOOpIeeeAiWxmHUi1u5zSwrqwLGuxo9JsF1+nvmA8MAHrNnMCnhlSzz1c+jxVoryBqSCdGsCk=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQELTmb_1740477190 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 17:53:10 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	alex_y_xu@yahoo.ca,
	ryncsn@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: shmem: fix potential data corruption during shmem swapin
Date: Tue, 25 Feb 2025 17:52:55 +0800
Message-ID: <2fe47c557e74e9df5fe2437ccdc6c9115fa1bf70.1740476943.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alex and Kairui reported some issues (system hang or data corruption) when
swapping out or swapping in large shmem folios. This is especially easy to
reproduce when the tmpfs is mount with the 'huge=within_size' parameter.
Thanks to Kairui's reproducer, the issue can be easily replicated.

The root cause of the problem is that swap readahead may asynchronously
swap in order 0 folios into the swap cache, while the shmem mapping can
still store large swap entries. Then an order 0 folio is inserted into
the shmem mapping without splitting the large swap entry, which overwrites
the original large swap entry, leading to data corruption.

When getting a folio from the swap cache, we should split the large swap
entry stored in the shmem mapping if the orders do not match, to fix this
issue.

Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
Reported-by: Kairui Song <ryncsn@gmail.com>
Closes: https://lore.kernel.org/all/1738717785.im3r5g2vxc.none@localhost/
Tested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Add the tested tag from Kairui. Thanks Kairui.
 - Add Closes information to the commit message.
---
 mm/shmem.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a8043..cebbac97a221 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2253,7 +2253,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct folio *folio = NULL;
 	bool skip_swapcache = false;
 	swp_entry_t swap;
-	int error, nr_pages;
+	int error, nr_pages, order, split_order;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
 	swap = radix_to_swp_entry(*foliop);
@@ -2272,10 +2272,9 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
+	order = xa_get_order(&mapping->i_pages, index);
 	if (!folio) {
-		int order = xa_get_order(&mapping->i_pages, index);
 		bool fallback_order0 = false;
-		int split_order;
 
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
@@ -2339,6 +2338,29 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			error = -ENOMEM;
 			goto failed;
 		}
+	} else if (order != folio_order(folio)) {
+		/*
+		 * Swap readahead may swap in order 0 folios into swapcache
+		 * asynchronously, while the shmem mapping can still stores
+		 * large swap entries. In such cases, we should split the
+		 * large swap entry to prevent possible data corruption.
+		 */
+		split_order = shmem_split_large_entry(inode, index, swap, gfp);
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
 	}
 
 alloced:
@@ -2346,7 +2368,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	folio_lock(folio);
 	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
 	    folio->swap.val != swap.val ||
-	    !shmem_confirm_swap(mapping, index, swap)) {
+	    !shmem_confirm_swap(mapping, index, swap) ||
+	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
 		error = -EEXIST;
 		goto unlock;
 	}
-- 
2.43.5


