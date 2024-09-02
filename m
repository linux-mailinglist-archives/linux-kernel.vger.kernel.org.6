Return-Path: <linux-kernel+bounces-310721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D123968063
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE21BB2450E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5964A18893E;
	Mon,  2 Sep 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luyybGbQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5718595B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261466; cv=none; b=UcLvGY5vfllXJuF7vow73gQiBqDwjRFKfqMM+jr0FjSKU4oN7ovAee7Ypfo52COq+rEgkj5eQCx2E7wnPuoUTPaoSGqB0qV/jA5uN/hQ4bnQfIsLHT3MVDasuMGObHEQ+GWf8FG+dFr2p+htdidcljpNlMSDEjadlx94FsaGQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261466; c=relaxed/simple;
	bh=8NP5E97AtP/kem4IUjjLi+FAumtWmwCjNYRbQZ4Zmwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEfumxtfGx3cagMFFOlpsUNms3ktLLQqQv29rFOMAGA3C7C+lKlaMlZPbqyjonmeCnxcwYYaIwsPigD2+YxlQUF8dSfASE/TCHxcIRfbODIAitYVlZY35rOpA9YhIqenXqBq/8XYaftsdzH8VD3pC3cBJ1JH5IU5FYeBB2XVpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luyybGbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1060BC4CEC2;
	Mon,  2 Sep 2024 07:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261466;
	bh=8NP5E97AtP/kem4IUjjLi+FAumtWmwCjNYRbQZ4Zmwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luyybGbQP4t9sYIyrJgDKuirEOXTx1BKnq3ONcswGeFiP+L0aMFR8Iec24a+I+X6u
	 DrKhRpC/OLMgaJziuSmQlKpnzOYKyvR/Vh1yQ7aDSjErHfjApKkVdb/q/2ag0XSK/B
	 chTwLoZUDipz8l1hXp7+h3YMah7dJUleabEjOxfGT3ru9pVV5+oNWZ8b0EElUFt3q3
	 ZcD8H2E6p/WxIAyU7fXdmEmIjqSnXdOZHhVx6nBIht4bV2himfEqtGPEx2/cx23eoq
	 is6MR0afprQ7E1x9B9EySSyJw7/VDVGw+49zdYW7k/vImFfc7UupAym3vgCuVPrMtk
	 pjSj/AX+ltH6w==
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
Subject: [PATCH v7 21/21] mm/zsmalloc: update comments for page->zpdesc changes
Date: Mon,  2 Sep 2024 15:21:32 +0800
Message-ID: <20240902072136.578720-22-alexs@kernel.org>
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

After the page to zpdesc conversion, there still left few comments or
function named with page not zpdesc, let's update the comments and
rename function create_page_chain() as create_zpdesc_chain().

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 61 ++++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 849f192d4937..1e47cda05c83 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -13,20 +13,19 @@
 
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
+ *	zpdesc->next: links together all component zpdescs of a zspage
  *		For the huge page, this is always 0, so we use this field
  *		to store handle.
- *	page->page_type: PGTY_zsmalloc, lower 24 bits locate the first object
- *		offset in a subpage of a zspage
- *
- * Usage of struct page flags:
- *	PG_private: identifies the first component page
- *	PG_owner_priv_1: identifies the huge component page
+ *	zpdesc->first_obj_offset: PGTY_zsmalloc, lower 24 bits locate the first
+ *		object offset in a subpage of a zspage
  *
+ * Usage of struct zpdesc(page) flags:
+ *	PG_private: identifies the first component zpdesc
+ *	PG_lock: lock all component zpdescs for a zspage free, serialize with
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -191,7 +190,10 @@ struct size_class {
 	 */
 	int size;
 	int objs_per_zspage;
-	/* Number of PAGE_SIZE sized pages to combine to form a 'zspage' */
+	/*
+	 * Number of PAGE_SIZE sized zpdescs/pages to combine to
+	 * form a 'zspage'
+	 */
 	int pages_per_zspage;
 
 	unsigned int index;
@@ -900,7 +902,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	/*
 	 * Since zs_free couldn't be sleepable, this function cannot call
-	 * lock_page. The page locks trylock_zspage got will be released
+	 * lock_page. The zpdesc locks trylock_zspage got will be released
 	 * by __free_zspage.
 	 */
 	if (!trylock_zspage(zspage)) {
@@ -957,7 +959,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	set_freeobj(zspage, 0);
 }
 
-static void create_page_chain(struct size_class *class, struct zspage *zspage,
+static void create_zpdesc_chain(struct size_class *class, struct zspage *zspage,
 				struct zpdesc *zpdescs[])
 {
 	int i;
@@ -966,9 +968,9 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 	int nr_zpdescs = class->pages_per_zspage;
 
 	/*
-	 * Allocate individual pages and link them together as:
-	 * 1. all pages are linked together using zpdesc->next
-	 * 2. each sub-page point to zspage using zpdesc->zspage
+	 * Allocate individual zpdescs and link them together as:
+	 * 1. all zpdescs are linked together using zpdesc->next
+	 * 2. each sub-zpdesc point to zspage using zpdesc->zspage
 	 *
 	 * we set PG_private to identify the first zpdesc (i.e. no other zpdesc
 	 * has this flag set).
@@ -1026,7 +1028,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		zpdescs[i] = zpdesc;
 	}
 
-	create_page_chain(class, zspage, zpdescs);
+	create_zpdesc_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
 	zspage->class = class->index;
@@ -1353,7 +1355,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		/* record handle in the header of allocated chunk */
 		link->handle = handle | OBJ_ALLOCATED_TAG;
 	else
-		/* record handle to page->index */
+		/* record handle to zpdesc->handle */
 		zspage->first_zpdesc->handle = handle | OBJ_ALLOCATED_TAG;
 
 	kunmap_atomic(vaddr);
@@ -1443,7 +1445,6 @@ static void obj_free(int class_size, unsigned long obj)
 	unsigned int f_objidx;
 	void *vaddr;
 
-
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
 	zspage = get_zspage(f_zpdesc);
@@ -1686,19 +1687,19 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
 #ifdef CONFIG_COMPACTION
 /*
  * To prevent zspage destroy during migration, zspage freeing should
- * hold locks of all pages in the zspage.
+ * hold locks of all component zpdesc in the zspage.
  */
 static void lock_zspage(struct zspage *zspage)
 {
 	struct zpdesc *curr_zpdesc, *zpdesc;
 
 	/*
-	 * Pages we haven't locked yet can be migrated off the list while we're
+	 * Zpdesc we haven't locked yet can be migrated off the list while we're
 	 * trying to lock them, so we need to be careful and only attempt to
-	 * lock each page under migrate_read_lock(). Otherwise, the page we lock
-	 * may no longer belong to the zspage. This means that we may wait for
-	 * the wrong page to unlock, so we must take a reference to the page
-	 * prior to waiting for it to unlock outside migrate_read_lock().
+	 * lock each zpdesc under migrate_read_lock(). Otherwise, the zpdesc we
+	 * lock may no longer belong to the zspage. This means that we may wait
+	 * for the wrong zpdesc to unlock, so we must take a reference to the
+	 * zpdesc prior to waiting for it to unlock outside migrate_read_lock().
 	 */
 	while (1) {
 		migrate_read_lock(zspage);
@@ -1773,7 +1774,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 		idx++;
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
-	create_page_chain(class, zspage, zpdescs);
+	create_zpdesc_chain(class, zspage, zpdescs);
 	first_obj_offset = get_first_obj_offset(oldzpdesc);
 	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
@@ -1784,8 +1785,8 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	/*
-	 * Page is locked so zspage couldn't be destroyed. For detail, look at
-	 * lock_zspage in free_zspage.
+	 * Page/zpdesc is locked so zspage couldn't be destroyed. For detail,
+	 * look at lock_zspage in free_zspage.
 	 */
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
@@ -1812,7 +1813,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* We're committed, tell the world that this is a Zsmalloc page. */
 	__zpdesc_set_zsmalloc(newzpdesc);
 
-	/* The page is locked, so this pointer must remain valid */
+	/* The zpdesc/page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
@@ -1885,7 +1886,7 @@ static const struct movable_operations zsmalloc_mops = {
 };
 
 /*
- * Caller should hold page_lock of all pages in the zspage
+ * Caller should hold zpdesc locks of all in the zspage
  * In here, we cannot use zspage meta data.
  */
 static void async_free_zspage(struct work_struct *work)
-- 
2.46.0


