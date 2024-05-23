Return-Path: <linux-kernel+bounces-186920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB458CCAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A2AB213E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4813A41C;
	Thu, 23 May 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FGrfBGOk"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0F12BEAC
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431821; cv=none; b=PAL9rJ82UjYAGPQoRFtSVL4YYUTT/gvJI1W8XMvik0yz3SGqXs63skNAdjYNMpio0S2jzafQSVxEM/T/eCqqg9SF4LKpK82kcgQyjY7EL2L2RVaRILfGnzdBBv20IVl/Y4VDr5CP8NXvg6/cshz7L7xhnuBFR9N2B3KDmXGQLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431821; c=relaxed/simple;
	bh=ErWusodSOv/e3o+abesqRV+s9HhWhrOGK+H/kURZPLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jZBJbPntYHLwd9tgzfFITTwdyGmUyKMZ0dY2nrLzNjFZHz+IBwOCQejH+shqt3QEmOF3jv9yVPT81zT6EsXOZ5QFiJus3JbBcApT34Bkx2dE3F0EyoLE5v6chVQkkQMXNpdbanY58f6N2cJArUIMUAr//UEKkEC4/MEX5hdqf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FGrfBGOk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716431816; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JVChZ69GThIydiZ/f0r5OTM5qoAa0M96sdBUhghMrlc=;
	b=FGrfBGOkrIMepZ66ZzvKM8u4BOWq8cVqGdmvaVYd4zkoY/rc8yZzeUGuDpMzbYweMTSDhuG/LIc9uGR/xInuf4igP/etqiGPnY9/8rl1dzWltCSiZLnoU3HFMdtfhMzmwy8VqntG/N1E8CErcnbo8OJFbspvu0DChEKertZ+Y08=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W715RNx_1716431814;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W715RNx_1716431814)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 10:36:55 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	david@redhat.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: drop the 'anon_' prefix for swap-out mTHP counters
Date: Thu, 23 May 2024 10:36:39 +0800
Message-Id: <7a8989c13299920d7589007a30065c3e2c19f0e0.1716431702.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mTHP swap related counters: 'anon_swpout' and 'anon_swpout_fallback' are
confusing with an 'anon_' prefix, since the shmem can swap out non-anonymous
pages. So drop the 'anon_' prefix to keep consistent with the old swap counter
names.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Hi Andrew,

Hope this patch can be merged into kernel 6.10-rc to maintain ABI compatibility.
Thanks.

Changes from v1:
 - Update the documentation per Barry Song.
---
 Documentation/admin-guide/mm/transhuge.rst | 4 ++--
 include/linux/huge_mm.h                    | 4 ++--
 mm/huge_memory.c                           | 8 ++++----
 mm/page_io.c                               | 2 +-
 mm/vmscan.c                                | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 076443cc10a6..d414d3f5592a 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -467,11 +467,11 @@ anon_fault_fallback_charge
 	instead falls back to using huge pages with lower orders or
 	small pages even though the allocation was successful.
 
-anon_swpout
+swpout
 	is incremented every time a huge page is swapped out in one
 	piece without splitting.
 
-anon_swpout_fallback
+swpout_fallback
 	is incremented if a huge page has to be split before swapout.
 	Usually because failed to allocate some continuous swap space
 	for the huge page.
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c8d3ec116e29..8c72d3786583 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -269,8 +269,8 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
-	MTHP_STAT_ANON_SWPOUT,
-	MTHP_STAT_ANON_SWPOUT_FALLBACK,
+	MTHP_STAT_SWPOUT,
+	MTHP_STAT_SWPOUT_FALLBACK,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 317de2afd371..89932fd0f62e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -558,15 +558,15 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
-DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
-DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
+DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 
 static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
-	&anon_swpout_attr.attr,
-	&anon_swpout_fallback_attr.attr,
+	&swpout_attr.attr,
+	&swpout_fallback_attr.attr,
 	NULL,
 };
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 46c603dddf04..0a150c240bf4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -217,7 +217,7 @@ static inline void count_swpout_vm_event(struct folio *folio)
 		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
 	}
-	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
+	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 #endif
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6981a71c8ef0..18b796605aa5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1244,7 +1244,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 							THP_SWPOUT_FALLBACK, 1);
 						count_vm_event(THP_SWPOUT_FALLBACK);
 					}
-					count_mthp_stat(order, MTHP_STAT_ANON_SWPOUT_FALLBACK);
+					count_mthp_stat(order, MTHP_STAT_SWPOUT_FALLBACK);
 #endif
 					if (!add_to_swap(folio))
 						goto activate_locked_split;
-- 
2.39.3


