Return-Path: <linux-kernel+bounces-233288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EAF91B53B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7482B21818
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFCA208B8;
	Fri, 28 Jun 2024 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C87rd9lC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00A1F934
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544013; cv=none; b=ip50CXDHpsQdohYjjpih0qV2cQlm9xUkN34n9sKDNEO8pcXbLSZcc9wFvWgIxVEWRWkhmbtH1G0bu+5x6t+GCbJi1NtcA8DwkJ47UW+YMPA3mYBDWcV7NO5gIbgLuLBdygviIuurn9prFgG31ldPTGH+H3CppzPPexbx3/jYRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544013; c=relaxed/simple;
	bh=Cr0rk228Nf4Ejmcf123tMGr+wVgBtKk7ChztlR6oqcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhGgOWJ/NnYRjFtQ9auYU0yUrQd2KuoykgqME+ROqw0ex03iTif0MHxTK/7rAclIlAzOBZxc7oEfW832dv5voSgdYdWL9itA7jVDOM8mxEvlWd52Ep0D+79odJV1Osova+7KlxxyD2OgnXhtjAeDJtEhlm6LMga0VciQjh03KxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C87rd9lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F3FC4AF09;
	Fri, 28 Jun 2024 03:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544012;
	bh=Cr0rk228Nf4Ejmcf123tMGr+wVgBtKk7ChztlR6oqcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C87rd9lCAIEm3gmgN1HsqdNpdHVQnk+7Q4Nv5dOer+u/gx8+vllp84o4qmsNwEaZg
	 +Fe1YLW2saEdNkRrbeqC8q7l72FvR+c0OCa5xkz+05L0MavtAPM7hr/UDfktBh/QSb
	 oJjlWdO597SbcB/MMgnDSkhzMxI2B6jMBPx9yG08XhP6Go5Ay+7NS4e/baBvqUc1sO
	 eFslcQG/0/9QdUnqkjnahncWxOulT4eXMZVUN0hMXgwqy8SzeqVX0Aj7BXIoByXD3F
	 WgfD365aGDEcOL1toHZ63a0fAY+j4Rit+f8tKukzw1F/O63OwIGXMV+jk/g1251juN
	 woROqUiGIiSlQ==
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
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 01/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Fri, 28 Jun 2024 11:11:16 +0800
Message-ID: <20240628031138.429622-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628031138.429622-1-alexs@kernel.org>
References: <20240628031138.429622-1-alexs@kernel.org>
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

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/zsmalloc.c | 19 ++++++++---------
 2 files changed, 66 insertions(+), 9 deletions(-)
 create mode 100644 mm/zpdesc.h

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
new file mode 100644
index 000000000000..a1ab5ebaa936
--- /dev/null
+++ b/mm/zpdesc.h
@@ -0,0 +1,56 @@
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
+ * @lru:		Indirected used by page migration
+ * @next:		Next zpdesc in a zspage in zsmalloc zpool
+ * @handle:		For huge zspage in zsmalloc zpool
+ * @zspage:		Pointer to zspage in zsmalloc
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct zpdesc {
+	unsigned long flags;
+	struct list_head lru;
+	unsigned long _zp_pad_1;
+	union {
+		/* Next zpdescs in a zspage in zsmalloc zpool */
+		struct zpdesc *next;
+		/* For huge zspage in zsmalloc zpool */
+		unsigned long handle;
+	};
+	struct zspage *zspage;
+};
+#define ZPDESC_MATCH(pg, zp) \
+	static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
+
+ZPDESC_MATCH(flags, flags);
+ZPDESC_MATCH(lru, lru);
+ZPDESC_MATCH(index, next);
+ZPDESC_MATCH(index, handle);
+ZPDESC_MATCH(private, zspage);
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
index fec1a39e5bbe..67bb80b7413a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -13,17 +13,17 @@
 
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
  *	PG_owner_priv_1: identifies the huge component page
  *
@@ -64,6 +64,7 @@
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/local_lock.h>
+#include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
 
@@ -253,7 +254,7 @@ struct zspage {
 	};
 	unsigned int inuse;
 	unsigned int freeobj;
-	struct page *first_page;
+	struct zpdesc *first_zpdesc;
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
 	rwlock_t lock;
@@ -448,7 +449,7 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 
 static inline struct page *get_first_page(struct zspage *zspage)
 {
-	struct page *first_page = zspage->first_page;
+	struct page *first_page = zpdesc_page(zspage->first_zpdesc);
 
 	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 	return first_page;
@@ -948,7 +949,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 		set_page_private(page, (unsigned long)zspage);
 		page->index = 0;
 		if (i == 0) {
-			zspage->first_page = page;
+			zspage->first_zpdesc = page_zpdesc(page);
 			SetPagePrivate(page);
 			if (unlikely(class->objs_per_zspage == 1 &&
 					class->pages_per_zspage == 1))
@@ -1325,7 +1326,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		link->handle = handle;
 	else
 		/* record handle to page->index */
-		zspage->first_page->index = handle;
+		zspage->first_zpdesc->handle = handle;
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
-- 
2.43.0


