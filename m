Return-Path: <linux-kernel+bounces-238805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77B9250C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC191F23F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B813B2B2;
	Wed,  3 Jul 2024 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCzHmjUT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93C745E2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979272; cv=none; b=Ll5bAVLV6jhcSjHnhxc/tzxvwmP7GZUwp02yVyahfhAaxRTXIYCb5+1Wo8dK+4PcIdjvNSHLFv2qZH1J3WJO6/nkLgqJASjEZMYRg2s6JOf3UwVPXkUzvve2A12xj/Sfc1oZKtRHSB/ZMq+HnsYSZov3Qlaa8xIAl12e5bxbhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979272; c=relaxed/simple;
	bh=81TBE+QYmpKV96rZHKgj6AZ1fYwMgRmX/nAJKqOjEgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkwoznrOCi+yjHv+0/QSy1mDuofYiigcwM7vXFUY3RecH52ECx68096w7+4SZR5W402upkmjwvd1kupk4COAPvXkQe6QRY6x87A/K+i1ywKYSj3tonleQKjNsKfc8KgW68Bp4SExYyI/IpIDMrP2NsH6bkU/JKYRNHvLSLIFzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCzHmjUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B957C4AF0E;
	Wed,  3 Jul 2024 04:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979271;
	bh=81TBE+QYmpKV96rZHKgj6AZ1fYwMgRmX/nAJKqOjEgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCzHmjUT1evH4SkSRoxBPGps9eH/wF60nNhj3DQNG4ErQlV8wVwU82WmzAWXzA5y5
	 tNO3t6uq+kDRXkCvQEm3UgnevwfPAZd+aDrqyXavCl02m57ofEk1Dt1hcPUzJtOjop
	 gd0kTeggPQkI95uQvc6hqhxPWTNb4CN4a9PVkgKsf31qyp1EigX1Qoo7g/J6tCb+wo
	 8OVHJ4Vl1xXn6zVz8lgE4djN+vj7ZPBLDcQ0yFanitjDZl4YfGv8IK6ywhb2l0jFAU
	 rApsfucEskaLl1ikSSmJ2Luh8OjWtfIst0jlXYgDc+lifp0qZ7yUhImyk/Ye/0C+br
	 CLWA3EZfbooCA==
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
Subject: [PATCH v2 01/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Wed,  3 Jul 2024 12:05:51 +0800
Message-ID: <20240703040613.681396-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703040613.681396-1-alexs@kernel.org>
References: <20240703040613.681396-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

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
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/zsmalloc.c | 21 ++++++++---------
 2 files changed, 74 insertions(+), 11 deletions(-)
 create mode 100644 mm/zpdesc.h

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
new file mode 100644
index 000000000000..4455a663ee84
--- /dev/null
+++ b/mm/zpdesc.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* zpdesc.h: zswap.zpool memory descriptor
+ *
+ * Written by Alex Shi <alexs@kernel.org>
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
+#ifdef CONFIG_SLAB_OBJ_EXT
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
+ZPDESC_MATCH(memcg_data, memcg_data);
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


