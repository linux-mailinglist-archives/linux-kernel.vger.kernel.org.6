Return-Path: <linux-kernel+bounces-177158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76E8C3ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF66B20D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051F146D69;
	Mon, 13 May 2024 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xApeZUPZ"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13C14600B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576935; cv=none; b=cshddrtzVYfhQ/IERErSKFIH6izh4e84f83rabxFYtdcIEpICWoCGLKKlHYuvuVl/iEasaCEKH3CRFS3CM9y/KQpgx0ogTtfUX5FLPtiNps4NyGq4J63QQb2Nw0it0vwPaOF2K0ysspTxOK4eHFDZy8QvXdtmzMZlcM5dbYzIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576935; c=relaxed/simple;
	bh=a8YAPu6NbKPuP9q8NY35W/OW7WuX38VQbh3a6oAHFTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5sxP73HGtdsnvsE27SOjSuG/i8Pt9hlYIxlYi3OCOgx460Ebx7ECWNP/eapOkNGKKQobGq0h7oBQK6XtSyg/M2zpHml/xSR7ANB6orAju3nlNPa/c7l48Z+9fQ6IBwr55UvRyccE1Ima1m1EXQrivztQvHEPoG1dDrKzchlcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xApeZUPZ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715576926; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+jNNX3W26VDDLfggMRp8CMmTsrteBwo6mbmSEbiS2X4=;
	b=xApeZUPZeXrum9Ps6AU5QTTCUm/MxXv1SuULma+sdMTEeF41YOgwImlYZFYcszVZWkjk4+l4njfUAG3xT6l+Z7H0LueS8hGT2/sWayLEeliP9YHHp0GXa5cT64LFtAHgHoyC+D+yJCazxnErlUm6jnvaTRteIRSGXvErDkuwrXo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6HN0Qb_1715576922;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6HN0Qb_1715576922)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 13:08:43 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] mm: shmem: add mTHP counters for anonymous shmem
Date: Mon, 13 May 2024 13:08:17 +0800
Message-Id: <b9babe1857917ff217ed0988d95ba3468845479c.1715571279.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
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
index b5339210268d..e162498fef82 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -281,6 +281,9 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_ANON_SWPOUT,
 	MTHP_STAT_ANON_SWPOUT_FALLBACK,
+	MTHP_STAT_FILE_ALLOC,
+	MTHP_STAT_FILE_FALLBACK,
+	MTHP_STAT_FILE_FALLBACK_CHARGE,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3080a8843f2..fcda6ae604f6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
+DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
 
 static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] = {
 	&anon_fault_fallback_charge_attr.attr,
 	&anon_swpout_attr.attr,
 	&anon_swpout_fallback_attr.attr,
+	&file_alloc_attr.attr,
+	&file_fallback_attr.attr,
+	&file_fallback_charge_attr.attr,
 	NULL,
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 8b020ff09c72..fd2cb2e73a21 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1786,6 +1786,9 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
+#endif
 			order = next_order(&suitable_orders, order);
 		}
 	} else {
@@ -1805,9 +1808,15 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
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
@@ -2178,6 +2187,9 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
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


