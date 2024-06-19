Return-Path: <linux-kernel+bounces-220694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA12090E56F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8252D1F21896
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7801E78C91;
	Wed, 19 Jun 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Iw19GNkp"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8FD224D4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785326; cv=none; b=n4J77bMg8hxZRTPcHpXcsPwO8BxU98Dtmwa/GQ4XDgvTZ1vzEFr8l86vBO3AK7G+86dxoO7TwkJ2SvrcFAT+bPgBsASU2i0Ca/IIcEf9VSgg4JBMfl+pPzR1S3VXvfMRhLeptDIlzb47OVNmMsQ1Z0UVheEznKuIZfb5j+meBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785326; c=relaxed/simple;
	bh=9YrFkyQZ7Pkv9wm+cg1dZgrrMxhRuwnou748YHmzYA8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s99WnRW9Irbe6waswNZzaAdHZLhmXGPXk5Bp+KQiUYMjvVtBVQJmT+MQMJjzFpdBDmHI+saitgmjcULds2gUkhPUzMhLKlBH9nDH01/k+BO9zXN0TQE089AqvDrA5j0fUk5GQSFP5oENyWYvCz0uix+kcy6345DVyBBOyxF8DrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Iw19GNkp; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Ljn9sb++6gHyMC40Zg
	cwaQQrbP0466Fkz3naK5umj9I=; b=Iw19GNkpgFYNrkCpmHa21ZN1ZmbKDyU1w8
	mrCjNemCxv17fI7g8xLIAyeNMJO0FOe7pOSCRH1fuBaqC7Dm3qmkpkOO2lYxXakp
	OPN+ltkXmL62wu2ycBubve3NBInFBAyHne7spl6gdOQlVgev/DS/9SqzRttLI/GK
	spbNNdMas=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDnV80SlXJmFM7xAw--.9288S2;
	Wed, 19 Jun 2024 16:21:40 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/page_alloc: add one PCP list for THP
Date: Wed, 19 Jun 2024 16:21:34 +0800
Message-Id: <1718785294-26713-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDnV80SlXJmFM7xAw--.9288S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWUtF17Xw18JF1UuFWDXFb_yoWrWw17pF
	Wxtw4Syayjq343Aw18A3Wqkr1rCasxGFsrCr1fuw18ZwsxXFWS9a4fKFnFvFyrZrWUAFWx
	Xr9rt34fCF4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Umg4DUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQkDG2VLa0vv-QAAsU
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
 include/linux/mmzone.h | 11 ++++++-----
 mm/page_alloc.c        | 14 +++++++++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b7546dd..7e6989d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -656,13 +656,14 @@ enum zone_watermarks {
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
+#define PCP_THP_MOVABLE 0
+#define PCP_THP_UNMOVABLE 1
 #else
 #define NR_PCP_THP 0
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8f416a0..5eac18e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -504,16 +504,24 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+	int pcp_type = migratetype;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != HPAGE_PMD_ORDER);
-		return NR_LOWORDER_PCP_LISTS;
+
+		if (migratetype != MIGRATE_MOVABLE)
+			pcp_type = PCP_THP_UNMOVABLE;
+		else
+			pcp_type = PCP_THP_MOVABLE;
+
+		return NR_LOWORDER_PCP_LISTS + pcp_type;
 	}
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
 #endif
 
-	return (MIGRATE_PCPTYPES * order) + migratetype;
+	return (MIGRATE_PCPTYPES * order) + pcp_type;
 }
 
 static inline int pindex_to_order(unsigned int pindex)
@@ -521,7 +529,7 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex == NR_LOWORDER_PCP_LISTS)
+	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		order = HPAGE_PMD_ORDER;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-- 
2.7.4


