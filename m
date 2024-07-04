Return-Path: <linux-kernel+bounces-240962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD2927519
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E75C28620F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976CA1AEFD8;
	Thu,  4 Jul 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IrS06H/i"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C91AD3E5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092322; cv=none; b=AQa7/aKmaT/NkfNL05kSJLZHqbJjlukELun24dgWjrxNKTVg9SBdiu5h7Mc7jkannzB+ubVs0evXCQSgnQxwkFt07A2mcwWD8o0mFS38wmL9rA/tU3ZhW7r/A+3TPN43WtarSW11CqaFlYTeTBz0tkjX4Hrh1XAyfwIF1bqpSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092322; c=relaxed/simple;
	bh=ExZ/jWRz3JNp2OD5lRM7K74HdX5ErPggTIbY4d/k8H8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4Y9Z4vEO2BmpcXPQLEQjhDjRRLr71hbsQdGaZNUWW3BwEnSektsm4jrKpNsfYM//Uby9o9mbIwwIKHhsYarUjd2Ntu+pJ5TF3cnDe9ossP8XH3i2jWheiffjZrUAOaF0+t1xNMkqvTyOE9+REkQ+j8KwekUmsEune+iLVtsDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IrS06H/i; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092318; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8wAGNXuI1qwPyzOykQd8DO+mgTfhYkp9bBwCtZr1ZS0=;
	b=IrS06H/iF5itsGarec0zMq66fvnKviknZOMpv4ixZNbFt+hT1k9Mc9heQNTieGwAT6uEDaE9DleKwhrlRIZNQasOBa/b1G+gd51Bt9fmVKlEyY3ZLachUipr7SzDEYDAZuCRw/laQw7Joig4PDNedgwDF+tgO1GmOJb2ZH38SYg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qWV5z_1720092316;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qWV5z_1720092316)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:17 +0800
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
Subject: [PATCH v3 09/10] mm: shmem: split large entry if the swapin folio is not large
Date: Thu,  4 Jul 2024 19:24:58 +0800
Message-Id: <7d831561b1daa14234c409cb1677a367d3ce5e0b.1720079976.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
References: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
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
 mm/shmem.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index eb030827f7fb..b4468076f0e9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1990,6 +1990,82 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
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
+		if (order == -1)
+			order = xas_get_order(&xas);
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
@@ -2026,12 +2102,31 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
+		int split_order, offset;
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
+		if (split_order > 0) {
+			offset = index - round_down(index, 1 << split_order);
+			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+		}
+
 		/* Here we actually start the io */
 		folio = shmem_swapin_cluster(swap, gfp, info, index);
 		if (!folio) {
-- 
2.39.3


