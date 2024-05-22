Return-Path: <linux-kernel+bounces-185952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD78CBD47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746591F227A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC380BFF;
	Wed, 22 May 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q1Iwr4rK"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D58060A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367899; cv=none; b=TpkyFSWNi+E3GCETyEPio+Z9purKmKAN+mzY4KU2IdLIaR7d5fplCtTwqR6t3+2TESiJfRRghnJawKyJ7ICZI8XEZzBd4J1D6XJZq6oR1HrMsS3Xkh9CZCFOM3QOhcpet9ZK01r+QQrTKKfLkifP70D71Ln5rT/asg2fcMnI4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367899; c=relaxed/simple;
	bh=Z+SQTWPV13FQWbRr09eyjhpFV5Zzd6NjwvSrlWxAgAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEax/jc0FNmArc/lG8EytjZxyrBXdqCY9DP+RmmJPPqNbwpbaTbS3vfM4dwq0MDXqd/AIDVb5hQeXL1LJ1973/f+Z+gklHusQgdomARYKo24k4RBftDABdsJgRFOTqPFnchbaLiO3ugJ5zZPWD2fjyHuEebXupTjiG3Q7HO7MYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q1Iwr4rK; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716367894; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2ACntvDvoDc3et3+Fy67VpABuhloTFZCY5dsdRNUwpE=;
	b=Q1Iwr4rKTs7TwBWUl+WBgm2r4J+qhmuFw3XXV4FCn6OHrdFLN3YEJL/qyLe8lunhsLiz20QZEoR0HRhwiKpApKmLfYGaeAx6Z2jr3JGW/jVPgztRaBCB6MqAj1bA6d9Z9w4Xldwt/kUEBVuIPBsSAcxY6Vli8TbXSZ1OU4y+tSc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7-qM3v_1716367892;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7-qM3v_1716367892)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 16:51:33 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	david@redhat.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
Date: Wed, 22 May 2024 16:51:22 +0800
Message-Id: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
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
 include/linux/huge_mm.h | 4 ++--
 mm/huge_memory.c        | 8 ++++----
 mm/page_io.c            | 2 +-
 mm/vmscan.c             | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

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


