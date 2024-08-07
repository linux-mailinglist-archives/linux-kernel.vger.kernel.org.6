Return-Path: <linux-kernel+bounces-277466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ECB94A1C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09813281A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5621C57AC;
	Wed,  7 Aug 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V0WVulDR"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58F1C9DF1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015900; cv=none; b=pXLK9618tpbXjRGaZq+X5H71JxX1ASoovmX5iVn9FGUr13FqJ+LF/80SQ0szNodi1Z4g29W1eD01YPNddh9kk5/WfHG6n4oRA9VNZo/kUJd94TkNxTKisP3QGNLum5EyDo1qN/Dwp3hZs5Cbyo/7YHT9tWerrtr5FmPFKKbERR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015900; c=relaxed/simple;
	bh=u9rNPtYk720ssVEKO/QfyAhPgGcp45dwY7nlKRUHczU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiAGktlayy5ScHMqTyPtqGh0DhT5K31kE9ClPMvlgFBBTVuyxs8takIZ9Xx3qOgU35fI3fmpVYMvpE5j+FJfp+qiZLxn6/gLs30ITf98ajv3BKQV3OfQ3igFDdJkfBsghP/+JkpcqcplMHqHSXKVBFP98db4f5413dPID4VDhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V0WVulDR; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015897; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HTq6ByUKYopHbBOucaa7TnUS458Ur1YounHQqWHqN9Y=;
	b=V0WVulDRA717tUNm1deCfVhvqRQBx7a4jGC4iVbOYbcLdbfJ/1mJaBqhXc15NXEEZXGG0z/9/NVA0CTiDp+Wlp8wcYDIH8b/9ZnoRHhd82sncLRPP7S0EgE1XGT+SsPx9qWB/77mww89STbvgWQaAoYEKlDvfRTRaULhJr9xYAM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI3gik_1723015895;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI3gik_1723015895)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:35 +0800
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
Subject: [PATCH v4 08/10] mm: shmem: drop folio reference count using 'nr_pages' in shmem_delete_from_page_cache()
Date: Wed,  7 Aug 2024 15:31:13 +0800
Message-Id: <e535fe0f7f313a72a8c89c8e88d150930662d777.1723012159.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support large folio swapin/swapout for shmem in the following patches,
drop the folio's reference count by the number of pages contained in the
folio when a shmem folio is deleted from shmem pagecache after adding
into swap cache.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d94f02ad7bd1..345e25425e37 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -851,7 +851,7 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
 	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
 	__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
 	xa_unlock_irq(&mapping->i_pages);
-	folio_put(folio);
+	folio_put_refs(folio, nr);
 	BUG_ON(error);
 }
 
-- 
2.39.3


