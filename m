Return-Path: <linux-kernel+bounces-200416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F878FAFBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E741F230BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA55145A0A;
	Tue,  4 Jun 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WAS1r96U"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D51145344
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496302; cv=none; b=XWRo8qwGamiUlKCfSLg8UBqW5rX9FYG7gtapOVBoFpzcBycpd40enPHe2vScxfkZbYam0QL+vyUu8Y6HuKDpI92jcGlFD95WKt/ursRIDvNajNNw1mWryMrD9taaNNG7rZWPGt1OIo+8l3FvHmm6rCgrIwZ8E9zYX73YvmNd2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496302; c=relaxed/simple;
	bh=bnOpRzV0MPKnJ0LrNIyRkUZWXq3NrrU+3Jw5N+ciYAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VsXYYyd/A/AdYuNj7oUZsUOju/r2SnxIg2PzdW7ay+KHJ5gTbNdlNgX9QOkYnwbEpa2vQ3Pjfh0ZtSZBaol4aRWgoNHh+VZ/ictLy9is2rZBy8WInp4tj57IYGwEoOZmVcAKBSwNRfzuMG3G76QDsWW0LPVnhWZhqALH6aQf30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WAS1r96U; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717496292; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hr324HRcgNNfrgZ8GDchBNfhicaPktU9TGw54OvPLi4=;
	b=WAS1r96UnP3OMajpmB6whj5Okr5epNxbueTWqTZ0Z2j+Ca6uOw1e8zZPCHAUNxPSHh/0utQEhaUMg3TQDos73p5sKCdwkjoqo90+UaV1OjAS1D1aP43AXVD0NXsogLwXqwRaPVdTqBrb8i1t6rNdjRm9XZIDydkfeePBctP61SY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7qsp1y_1717496290;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7qsp1y_1717496290)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 18:18:10 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
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
Subject: [PATCH v4 6/6] mm: shmem: add mTHP counters for anonymous shmem
Date: Tue,  4 Jun 2024 18:17:50 +0800
Message-Id: <f3c8f7a1c9fd17a48ffa22f7e7d236ac96caced6.1717495894.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mTHP counters for anonymous shmem.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h |  3 +++
 mm/huge_memory.c        |  6 ++++++
 mm/shmem.c              | 18 +++++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 909cfc67521d..212cca384d7e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -281,6 +281,9 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
+	MTHP_STAT_FILE_ALLOC,
+	MTHP_STAT_FILE_FALLBACK,
+	MTHP_STAT_FILE_FALLBACK_CHARGE,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1360a1903b66..3fbcd77f5957 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
+DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
 
 static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] = {
 	&anon_fault_fallback_charge_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
+	&file_alloc_attr.attr,
+	&file_fallback_attr.attr,
+	&file_fallback_charge_attr.attr,
 	NULL,
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 2ecc41521dbb..d9a11950c586 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1773,6 +1773,9 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
+#endif
 			order = next_order(&suitable_orders, order);
 		}
 	} else {
@@ -1792,9 +1795,15 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 		if (xa_find(&mapping->i_pages, &index,
 				index + pages - 1, XA_PRESENT)) {
 			error = -EEXIST;
-		} else if (pages == HPAGE_PMD_NR) {
-			count_vm_event(THP_FILE_FALLBACK);
-			count_vm_event(THP_FILE_FALLBACK_CHARGE);
+		} else if (pages > 1) {
+			if (pages == HPAGE_PMD_NR) {
+				count_vm_event(THP_FILE_FALLBACK);
+				count_vm_event(THP_FILE_FALLBACK_CHARGE);
+			}
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK_CHARGE);
+#endif
 		}
 		goto unlock;
 	}
@@ -2168,6 +2177,9 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		if (!IS_ERR(folio)) {
 			if (folio_test_pmd_mappable(folio))
 				count_vm_event(THP_FILE_ALLOC);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
+#endif
 			goto alloced;
 		}
 		if (PTR_ERR(folio) == -EEXIST)
-- 
2.39.3


