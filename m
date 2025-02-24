Return-Path: <linux-kernel+bounces-528443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B70A417BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FC07A26B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21492309A3;
	Mon, 24 Feb 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UByL+kZK"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43E22FDF9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386847; cv=none; b=Vu9ifpo753Oo0QRsBFwgDaheTfTymGaO24VtDvAAtXsUPYIyYdnj9UE7RH/W7BvXm2kgUxcK0a0lktkFTvw4zaGu9oj3lHnbRvO2w988hcWMsckV6gHf7bXT3YlaOKUw0YP9PRN3i9YmIfNZMgzKPxQIiA+20Ss4KmBzFzvJIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386847; c=relaxed/simple;
	bh=Lh/yg5fBeis/GsEH7ff6hHTI5CJ2QWqKxx/BUIhAT/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ix1ULLbgGKdEADIeSsiSulcTT5DHRsMRgzIOBNb4IrmWyUkJbooAlzpUEFVf9Vr6LXySkif5emJo42qhizVgVNwOsuwxmM/MclDw5LXJydFRUPuGsKlcb8kvOPRVCQ/sCWt5iTMfK2kJDi2S9xlu0cwKQf2o42fitCxb1HWtaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UByL+kZK; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740386840; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1wAqTABFtap9/80glYuFE9desGOh24Rf37lI4QWi5Yc=;
	b=UByL+kZKJG6m4N+//sPCtpBkNNuWzdguc4goydt4s1wJk6TY/nv795e/YJaGCHxvWAnbudZOllvBXSRzp3yObNJ70oUKsWt03BjEVLXfmINs/hwz8NibRNBgZvMWMeXkP/K4G3kv/MEKHjdkK+77ZDnzfCocsRMOIrGpEOcZ3ws=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQ5905j_1740386838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 16:47:18 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: baolin.wang@linux.alibaba.com
Cc: akpm@linux-foundation.org,
	alex_y_xu@yahoo.ca,
	baohua@kernel.org,
	da.gomez@samsung.com,
	david@redhat.com,
	hughd@google.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	ziy@nvidia.com
Subject: [PATCH] mm: shmem: fix potential data corruption during shmem swapin
Date: Mon, 24 Feb 2025 16:47:10 +0800
Message-ID: <53e610af72302667475821e5b3c84c382da4efbc.1740386576.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <731904cf-d862-4c0e-ae5b-26444faff253@linux.alibaba.com>
References: <731904cf-d862-4c0e-ae5b-26444faff253@linux.alibaba.com>
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
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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


