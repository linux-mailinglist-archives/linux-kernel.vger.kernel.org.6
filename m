Return-Path: <linux-kernel+bounces-310701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE996804B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E391C205BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F163177992;
	Mon,  2 Sep 2024 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agYKSAil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293F2B9BB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261396; cv=none; b=JBwvxeYEhOcB/E1pEEyN/xyUDBFEcPqNWZxNfLsAiUVN5MKaQ0ZBLKUH3BuOX8Ixyil4hXr5nLCcKEMJ17CMZgurk7n+mTLPhEfnU8Lw1HdiCvsMchzNWQ86ol0blXoBrpvKViFALr0QOCBny9fdVf84rYqEekyX+oD0fyQJEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261396; c=relaxed/simple;
	bh=35oS5cqvsOoGfro8SlCHvjRjEwfOQy4xgC0vABlxtJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dujYXoB1lhG3XrTMMvZsuSxMIcT4QReqhJ4qn0z5bVHo6GAW6CisAA0OxRVppSXOJOnlG1MATpnqxjQ0pKDUJfNmuwPZEeRUg0R0W82Z9SdI1cLtQFh+DX+8LCyMJoWFOFupqt7jTjoeD8QMpyFgr5xaoF+sXaXIb747nNma0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agYKSAil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAB1C4CEC2;
	Mon,  2 Sep 2024 07:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261396;
	bh=35oS5cqvsOoGfro8SlCHvjRjEwfOQy4xgC0vABlxtJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agYKSAilfuYO5J7eGOLpdxzw52rI9hxDd1DKce1cIpm9Fjt0aSVLplL3wmg3sHr/G
	 HcnCqtqK+RRS9/TCwa5CYuM7L/NqpTsTB4pDnREzgFVbLECV8qmZhLyt0sh+yUJ0TS
	 FRx3J5kf7s+dBjFhx4zq5oHD+lnChGZzvxxnvQkR9PX/G6oLAS0039chUbgygF+8tp
	 8ZPsA6lo80t4DbiB6RX9oxVQLDuR6S6ekvtWBhywuT7ZpbwpxXZEVZhDdCjGsMqA2d
	 2YOFTQU8dknUtnJQPcYzUM2Dpjx2Gq7vW03RUznWSZB8bJNXXeiZPGqYcGs17eJXul
	 wy6Zp76/km4Ug==
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
Subject: [PATCH v7 01/21] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Mon,  2 Sep 2024 15:21:12 +0800
Message-ID: <20240902072136.578720-2-alexs@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902072136.578720-1-alexs@kernel.org>
References: <20240902072136.578720-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The 1st patch introduces new memory descriptor zpdesc and rename
zspage.first_page to zspage.first_zpdesc, no functional change.

We removed PG_owner_priv_1 since it was moved to zspage after
commit a41ec880aa7b ("zsmalloc: move huge compressed obj from
page to zspage").

And keep the memcg_data member, since as Yosry pointed out:
"When the pages are freed, put_page() -> folio_put() -> __folio_put()
will call mem_cgroup_uncharge(). The latter will call folio_memcg()
(which reads folio->memcg_data) to figure out if uncharging needs to
be done.

There are also other similar code paths that will check
folio->memcg_data. It is currently expected to be present for all
folios. So until we have custom code paths per-folio type for
allocation/freeing/etc, we need to keep folio->memcg_data present and
properly initialized."

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/zsmalloc.c |  9 ++++---
 2 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100644 mm/zpdesc.h

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
new file mode 100644
index 000000000000..721ef8861131
--- /dev/null
+++ b/mm/zpdesc.h
@@ -0,0 +1,72 @@
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
+ * @zspage:		Points to the zspage this zpdesc is a part of
+ * @first_obj_offset:	First object offset in zsmalloc zpool
+ * @_refcount:		Indirectly use by page migration
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
+	unsigned int first_obj_offset;
+	atomic_t _refcount;
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
+ZPDESC_MATCH(page_type, first_obj_offset);
+ZPDESC_MATCH(_refcount, _refcount);
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
+/* Using folio conversion to skip compound_head checking */
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
index 73a3ec5b21ad..5d3e27083c72 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -64,6 +64,7 @@
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/local_lock.h>
+#include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
 
@@ -251,7 +252,7 @@ struct zspage {
 	};
 	unsigned int inuse;
 	unsigned int freeobj;
-	struct page *first_page;
+	struct zpdesc *first_zpdesc;
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
 	rwlock_t lock;
@@ -446,7 +447,7 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 
 static inline struct page *get_first_page(struct zspage *zspage)
 {
-	struct page *first_page = zspage->first_page;
+	struct page *first_page = zpdesc_page(zspage->first_zpdesc);
 
 	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 	return first_page;
@@ -939,7 +940,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 		set_page_private(page, (unsigned long)zspage);
 		page->index = 0;
 		if (i == 0) {
-			zspage->first_page = page;
+			zspage->first_zpdesc = page_zpdesc(page);
 			SetPagePrivate(page);
 			if (unlikely(class->objs_per_zspage == 1 &&
 					class->pages_per_zspage == 1))
@@ -1315,7 +1316,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		link->handle = handle | OBJ_ALLOCATED_TAG;
 	else
 		/* record handle to page->index */
-		zspage->first_page->index = handle | OBJ_ALLOCATED_TAG;
+		zspage->first_zpdesc->handle = handle | OBJ_ALLOCATED_TAG;
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
-- 
2.46.0


