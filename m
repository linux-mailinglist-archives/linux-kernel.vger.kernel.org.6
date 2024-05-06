Return-Path: <linux-kernel+bounces-169525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881ED8BC9F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB881F21F21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9900142E8D;
	Mon,  6 May 2024 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PePZSSIR"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E501420C9
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985220; cv=none; b=d81f5/4vfuuWxWfaz8xaMkxIARpQ9ufATAxFurDEHSDZ2av3//d0dMWIfXJMdSp1HMP3ztqETMNfU36UrccsQU8cKR+di4YMk590qHxulZjSXpyFRgO5CANhmNjfYUQktNe84OljzmXkUClva6+GiirprSYmakmjugi+6jm3t1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985220; c=relaxed/simple;
	bh=NgEah7MUwkhHAMNvDN85ACnVMl/BukF5fiwdC+Ik/yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSp90nxhi5WAGkfR364qf0xirZeaEA/W4zTkucw9r/B8kB6UfeZK7YJ7rupqjG6Bmuu5I+XeIs7IQm5uVflpe4wS185rs6pjGYC1twXVKWeCQNwaCqOtEMtcRei9q0+c6uzGS2wSpux0Vv6oRFJs7NOn7bWUx10Ce6asRx5Eg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PePZSSIR; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714985216; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NqOIe5Oq6MCM0KXK59PH5ZOetWOLxng8pqZWeky8+zw=;
	b=PePZSSIR7Zy3SdTVOpJG6XIksJNZ/2YXBqeelftayVhbeicfe26qlXpoHEpkYHDcDbE4wRscwgRPEy5RvL1127WzsCeJ7ax1P5kwPNQYcxTd6OuZOFGBR52+KxOk4CZKQhFjxeU+WiUiCTwUIkfGnjvKpycN1GfxCZxC1D16LLs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W5weiNH_1714985213;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5weiNH_1714985213)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 16:46:54 +0800
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
Subject: [PATCH 8/8] mm: shmem: add mTHP counters for anonymous shmem
Date: Mon,  6 May 2024 16:46:32 +0800
Message-Id: <34f0b24f7c061f796d91ade9766e20a9da0c7651.1714978902.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
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
index dbd6b3f56210..c15bebb2cf53 100644
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
index 27107afdff9e..1af2f0aa384d 100644
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


