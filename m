Return-Path: <linux-kernel+bounces-220800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCBF90E740
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F74EB213C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E426B7E785;
	Wed, 19 Jun 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bHCk9FS6"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20034654D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790534; cv=none; b=HyvVpXBShXmmIda13HlIiuOaI/ktQF4kHDDKOP1oSDMg0zOjCIYivzLiUTjqyNAYJPxONZB/K2b5vyxkeYavnMTnQ5BM8nXWEax3NG4AcBZar+oCRqckdYmspp2LyDeG6caTeMO5Kt7v4bWs8/jDbRnsLcPuGZI9RHh1GXwCx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790534; c=relaxed/simple;
	bh=gkKoWR47Leibhir8paEj+KTHmunKqKi1xA7VVljdrSw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CpOfFsMJrZd/Fa3Mk9mlrqR6aI5VrYK7zfiaxRm/FlD7oSYA3tPoWgMdXMntlXge99WBBKBA9SJ+qGqBJKSE8H7kxPoyWFtDbxSXfQRTkbu6d6fMbzZKbjjz3CzddK47alR2wdcVEd4OJZt3oYzLWbNfkvimJew4Al7lTpCfgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bHCk9FS6; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Y8DxonlczYBTK4ErHD
	jFK14pvQyoYGA2Il/eyFLdS/o=; b=bHCk9FS6AagSsJ1J9zFrFce2YCBdDySru2
	jpmLN+3K6Y9eI5/w822qFJWBg1wNIhSaU6b5tSuoH29OZHuuQmuFWME0Gsz30Utk
	zu7HuLuZ/0PZN4mksUqMwt5PY1wk8j4IDWQAQIBV94PDFpNurxNgmUXzQo1PEuVr
	aw7eawR+s=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3H3NlqXJmPcTQBw--.9650S2;
	Wed, 19 Jun 2024 17:48:23 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/page_alloc: add one PCP list for THP
Date: Wed, 19 Jun 2024 17:48:19 +0800
Message-Id: <1718790499-28151-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wD3H3NlqXJmPcTQBw--.9650S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWUtF17Xw18JF1UuFWDXFb_yoWrGrW8pF
	WxJr4av3yjq34Yyr1xA3Wqkrn5C3ZxGFsrur1I9ry8ZwsxJFyS9a4xKF1qvF95ArW7AFWx
	Xr9rK343CF4DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Umg4DUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgsDG2VEw4oP+AAAs2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
THP-sized allocations") no longer differentiates the migration type
of pages in THP-sized PCP list, it's possible that non-movable
allocation requests may get a CMA page from the list, in some cases,
it's not acceptable.

If a large number of CMA memory are configured in system (for
example, the CMA memory accounts for 50% of the system memory),
starting a virtual machine with device passthrough will get stuck.
During starting the virtual machine, it will call
pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory. Normally
if a page is present and in CMA area, pin_user_pages_remote() will
migrate the page from CMA area to non-CMA area because of
FOLL_LONGTERM flag. But if non-movable allocation requests return
CMA memory, migrate_longterm_unpinnable_pages() will migrate a CMA
page to another CMA page, which will fail to pass the check in
check_and_migrate_movable_pages() and cause migration endless.
Call trace:
pin_user_pages_remote
--__gup_longterm_locked // endless loops in this function
----_get_user_pages_locked
----check_and_migrate_movable_pages
------migrate_longterm_unpinnable_pages
--------alloc_migration_target

To fix the problem above, we add one PCP list for THP, which will
not introduce a new cacheline. THP will have 2 PCP lists, one PCP
list is used by MOVABLE allocation, and the other PCP list is used
by UNMOVABLE allocation. MOVABLE allocation contains GPF_MOVABLE,
and UNMOVABLE allocation contains GFP_UNMOVABLE and GFP_RECLAIMABLE.

Link: https://lore.kernel.org/all/1717492460-19457-1-git-send-email-yangge1116@126.com/
Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
Signed-off-by: yangge <yangge1116@126.com>
---
 include/linux/mmzone.h | 9 ++++-----
 mm/page_alloc.c        | 9 +++++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b7546dd..cb7f265 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -656,13 +656,12 @@ enum zone_watermarks {
 };
 
 /*
- * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional list
- * for THP which will usually be GFP_MOVABLE. Even if it is another type,
- * it should not contribute to serious fragmentation causing THP allocation
- * failures.
+ * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional lists
+ * are added for THP. One PCP list is used by GPF_MOVABLE, and the other PCP list
+ * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
  */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define NR_PCP_THP 1
+#define NR_PCP_THP 2
 #else
 #define NR_PCP_THP 0
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8f416a0..0ecbde3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -504,10 +504,15 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+	bool __maybe_unused movable;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != HPAGE_PMD_ORDER);
-		return NR_LOWORDER_PCP_LISTS;
+
+		movable = migratetype == MIGRATE_MOVABLE;
+
+		return NR_LOWORDER_PCP_LISTS + movable;
 	}
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
@@ -521,7 +526,7 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex == NR_LOWORDER_PCP_LISTS)
+	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		order = HPAGE_PMD_ORDER;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-- 
2.7.4


