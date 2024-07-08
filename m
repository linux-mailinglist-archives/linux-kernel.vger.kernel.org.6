Return-Path: <linux-kernel+bounces-243889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2522929C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3271F21AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0718E1E;
	Mon,  8 Jul 2024 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCMJo9/v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853F18643
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420125; cv=none; b=OlF4Ex144xnSu1PVz580SqgHUGSZhAzGrPSVpIuw4Q0n/I0RV/i8l7UwXq8PKcOPI4xPzDyWScRXTgBuRja8X8oBdFdwmdi8QM/A9Lo152vzYl+otcP91tz7seR87V1qbPfUR/N0EYz7Xas6RHXxy1Lj6qxoODVOXt8scM9oG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420125; c=relaxed/simple;
	bh=QwfKZsyWKxmeoIlS8kXArrgVhPn5VQ2gqaeTqGCWsTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM0WqXr0Rb0cto2sAawWqiPXGxZ8uPJboKtmtO2OHGpLuFMmC/0wsz8UMIbHzBGQEdWUTudK4Svczz4KHfF1ZdoyI0QskYwbna/eWkiq99Li6cf3StPiraYtQHT4zWsZSkcJZ67IvoF/hOY8B/H14tzhaz4GQLHuaqRfNqenrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCMJo9/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B319C116B1;
	Mon,  8 Jul 2024 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420125;
	bh=QwfKZsyWKxmeoIlS8kXArrgVhPn5VQ2gqaeTqGCWsTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCMJo9/vSPJSaeCJLkrFmQWg/h52GHkcjcL/5WtAlAGBH2Z4f7gCFaUwqdR2huO8c
	 Hwmd96q7j0coqLb4+LdNtXrNHxHdguBuIYmjcIhrtNwx13cWhtxmySF5Qrz/+kUbxx
	 7TzYzdagLRPIChRZyMH0KvB7i5rlieVZ2Ru7AG1kQHyKqV9i6t4CIGb6XfjX8oFJ5Y
	 J/TDVncXA3cM0o6WbE680pKILmn1EN73ArAVKswe8XIV6yt6Px/OwQejHwmv8tNvwH
	 FJnQyCW7Vx36BZdU0k8z3rko9+zlTh6ZqXsDTpwqXafp80NJ8VnP+r0C/UxT+b0ZGD
	 wYjHHXaqvBdIg==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v3 01/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Mon,  8 Jul 2024 14:33:22 +0800
Message-ID: <20240708063344.1096626-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
References: <20240708063344.1096626-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi (Tencent) <alexs@kernel.org>

The 1st patch introduces new memory decriptor zpdesc and rename
zspage.first_page to zspage.first_zpdesc, no functional change.

We removed PG_owner_priv_1 since it was moved to zspage after
commit a41ec880aa7b ("zsmalloc: move huge compressed obj from
page to zspage").

And keep the memcg_data member, since as Yosry pointed out:
"When the pages are freed, put_page() -> folio_put() -> __folio_put() will call
mem_cgroup_uncharge(). The latter will call folio_memcg() (which reads
folio->memcg_data) to figure out if uncharging needs to be done.

There are also other similar code paths that will check
folio->memcg_data. It is currently expected to be present for all
folios. So until we have custom code paths per-folio type for
allocation/freeing/etc, we need to keep folio->memcg_data present and
properly initialized."

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zpdesc.h   | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/zsmalloc.c | 21 ++++++++--------
 2 files changed, 76 insertions(+), 11 deletions(-)
 create mode 100644 mm/zpdesc.h

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
new file mode 100644
index 000000000000..2dbef231f616
--- /dev/null
+++ b/mm/zpdesc.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* zpdesc.h: zswap.zpool memory descriptor
+ *
+ * Written by Alex Shi (Tencent) <alexs@kernel.org>
+ *	      Hyeonggon Yoo <42.hyeyoo@gmail.com>
+ */
+#ifndef __MM_ZPDESC_H__
+#define __MM_ZPDESC_H__
+
+/*
+ * struct zpdesc -	Memory descriptor for zpool memory, now is for zsmalloc
+ * @flags:		Page flags, PG_private: identifies the first component page
+ * @lru:		Indirectly used by page migration
+ * @mops:		Used by page migration
+ * @next:		Next zpdesc in a zspage in zsmalloc zpool
+ * @handle:		For huge zspage in zsmalloc zpool
+ * @zspage:		Pointer to zspage in zsmalloc
+ * @memcg_data:		Memory Control Group data.
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct zpdesc {
+	unsigned long flags;
+	struct list_head lru;
+	struct movable_operations *mops;
+	union {
+		/* Next zpdescs in a zspage in zsmalloc zpool */
+		struct zpdesc *next;
+		/* For huge zspage in zsmalloc zpool */
+		unsigned long handle;
+	};
+	struct zspage *zspage;
+	unsigned long _zp_pad_1;
+#ifdef CONFIG_MEMCG
+	unsigned long memcg_data;
+#endif
+};
+#define ZPDESC_MATCH(pg, zp) \
+	static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
+
+ZPDESC_MATCH(flags, flags);
+ZPDESC_MATCH(lru, lru);
+ZPDESC_MATCH(mapping, mops);
+ZPDESC_MATCH(index, next);
+ZPDESC_MATCH(index, handle);
+ZPDESC_MATCH(private, zspage);
+#ifdef CONFIG_MEMCG
+ZPDESC_MATCH(memcg_data, memcg_data);
+#endif
+#undef ZPDESC_MATCH
+static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
+
+#define zpdesc_page(zp)			(_Generic((zp),			\
+	const struct zpdesc *:		(const struct page *)(zp),	\
+	struct zpdesc *:		(struct page *)(zp)))
+
+#define zpdesc_folio(zp)		(_Generic((zp),			\
+	const struct zpdesc *:		(const struct folio *)(zp),	\
+	struct zpdesc *:		(struct folio *)(zp)))
+
+#define page_zpdesc(p)			(_Generic((p),			\
+	const struct page *:		(const struct zpdesc *)(p),	\
+	struct page *:			(struct zpdesc *)(p)))
+
+#endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d6581ab7c07..a532851025f9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -13,20 +13,18 @@
 
 /*
  * Following is how we use various fields and flags of underlying
- * struct page(s) to form a zspage.
+ * struct zpdesc(page) to form a zspage.
  *
- * Usage of struct page fields:
- *	page->private: points to zspage
- *	page->index: links together all component pages of a zspage
+ * Usage of struct zpdesc fields:
+ *	zpdesc->zspage: points to zspage
+ *	zpdesc->next: links together all component pages of a zspage
  *		For the huge page, this is always 0, so we use this field
  *		to store handle.
  *	page->page_type: PG_zsmalloc, lower 16 bit locate the first object
  *		offset in a subpage of a zspage
  *
- * Usage of struct page flags:
+ * Usage of struct zpdesc(page) flags:
  *	PG_private: identifies the first component page
- *	PG_owner_priv_1: identifies the huge component page
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -64,6 +62,7 @@
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/local_lock.h>
+#include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
 
@@ -253,7 +252,7 @@ struct zspage {
 	};
 	unsigned int inuse;
 	unsigned int freeobj;
-	struct page *first_page;
+	struct zpdesc *first_zpdesc;
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
 	rwlock_t lock;
@@ -448,7 +447,7 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 
 static inline struct page *get_first_page(struct zspage *zspage)
 {
-	struct page *first_page = zspage->first_page;
+	struct page *first_page = zpdesc_page(zspage->first_zpdesc);
 
 	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 	return first_page;
@@ -948,7 +947,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 		set_page_private(page, (unsigned long)zspage);
 		page->index = 0;
 		if (i == 0) {
-			zspage->first_page = page;
+			zspage->first_zpdesc = page_zpdesc(page);
 			SetPagePrivate(page);
 			if (unlikely(class->objs_per_zspage == 1 &&
 					class->pages_per_zspage == 1))
@@ -1324,7 +1323,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		link->handle = handle | OBJ_ALLOCATED_TAG;
 	else
 		/* record handle to page->index */
-		zspage->first_page->index = handle | OBJ_ALLOCATED_TAG;
+		zspage->first_zpdesc->handle = handle | OBJ_ALLOCATED_TAG;
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
-- 
2.43.0


