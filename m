Return-Path: <linux-kernel+bounces-284364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DC0950035
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E582845CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACCB19D896;
	Tue, 13 Aug 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmh3whJ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98E19D891
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538549; cv=none; b=JEsCpbINKuVNwqyarVw3bVptJEhJOBRsPJacGobOj5IqAhoIHOW5WW6aoqha49BXMFQUpX34900x3DJMoQjLIMzXBuL+Uw6tvFDFOiUD/yU6YG7hyRxTUm3MAuferKFh0X1X+jQcjk8Wsd3hVnXloaGbxV6MsX8qa4kQhxUjwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538549; c=relaxed/simple;
	bh=LliY088wtfrFrkEgAuCs8QB3X7nNhs8HeH2Nz6Y9mEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrSyDMnkAHj4YEbR59FA5B8qv1+Y0YQDS/O6nRFwH+8WoR2mnaTvb/pTPgZVLQdIki/Wcy7qbhxQ4G9gR1e3QIaPGKx59tTFvG/kTYPhpOvqJ4XPyafWw6Xx/3cIt1mgie5edunQR+6N2+nZGD3fyHmszMbzGXCdTFLV8SXdEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmh3whJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22CAC4AF0B;
	Tue, 13 Aug 2024 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538549;
	bh=LliY088wtfrFrkEgAuCs8QB3X7nNhs8HeH2Nz6Y9mEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nmh3whJ7Km/PF9o1d6vjECtU9Q80lnjNCgYP9PH9/NyPaAXEUHXt67dUXagF2kxJN
	 iRDLDAo3ER+9SiJxE5n9vGjNdT/ystypfHXN7rz2cDxps/B76wJ1GXiO9x7Svsqary
	 uIeHzEY7e575DxDpwD7wIG5T4JVhCNm2AuRWmHrw4z+gMy9A7dSCRxFv7E1XjDJFyl
	 4aJmKyjQ4Miw0W6rZon7W/bWTIIPlWusKE7wnMSAoqCIsVfv2RBunbaMWUR2kJNKLl
	 G5Ckm23NitU1OBGjeMAD202eP27uIhCa7dduav/25zMWGJX2zZuJJuyj0w8f4xmKiU
	 yrOb2BecslR9g==
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
Subject: [PATCH v6 21/21] mm/zsmalloc: update comments for page->zpdesc changes
Date: Tue, 13 Aug 2024 16:46:07 +0800
Message-ID: <20240813084611.4122571-22-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813084611.4122571-1-alexs@kernel.org>
References: <20240813084611.4122571-1-alexs@kernel.org>
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
 mm/zsmalloc.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3dbe6bfa656b..37619f4b074b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -17,14 +17,16 @@
  *
  * Usage of struct zpdesc fields:
  *	zpdesc->zspage: points to zspage
- *	zpdesc->next: links together all component pages of a zspage
+ *	zpdesc->next: links together all component zpdescs of a zspage
  *		For the huge page, this is always 0, so we use this field
  *		to store handle.
  *	zpdesc->first_obj_offset: PG_zsmalloc, lower 16 bit locate the first
  *		object offset in a subpage of a zspage
  *
  * Usage of struct zpdesc(page) flags:
- *	PG_private: identifies the first component page
+ *	PG_private: identifies the first component zpdesc
+ *	PG_lock: lock all component zpdescs for a zspage free, serialize with
+ *		 migration
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -191,7 +193,10 @@ struct size_class {
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
@@ -907,7 +912,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	/*
 	 * Since zs_free couldn't be sleepable, this function cannot call
-	 * lock_page. The page locks trylock_zspage got will be released
+	 * lock_page. The zpdesc locks trylock_zspage got will be released
 	 * by __free_zspage.
 	 */
 	if (!trylock_zspage(zspage)) {
@@ -964,7 +969,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	set_freeobj(zspage, 0);
 }
 
-static void create_page_chain(struct size_class *class, struct zspage *zspage,
+static void create_zpdesc_chain(struct size_class *class, struct zspage *zspage,
 				struct zpdesc *zpdescs[])
 {
 	int i;
@@ -973,9 +978,9 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
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
@@ -1033,7 +1038,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		zpdescs[i] = zpdesc;
 	}
 
-	create_page_chain(class, zspage, zpdescs);
+	create_zpdesc_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
 	zspage->class = class->index;
@@ -1360,7 +1365,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		/* record handle in the header of allocated chunk */
 		link->handle = handle | OBJ_ALLOCATED_TAG;
 	else
-		/* record handle to page->index */
+		/* record handle to zpdesc->handle */
 		zspage->first_zpdesc->handle = handle | OBJ_ALLOCATED_TAG;
 
 	kunmap_atomic(vaddr);
@@ -1693,19 +1698,19 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -1780,7 +1785,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 		idx++;
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
-	create_page_chain(class, zspage, zpdescs);
+	create_zpdesc_chain(class, zspage, zpdescs);
 	first_obj_offset = get_first_obj_offset(oldzpdesc);
 	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
@@ -1791,8 +1796,8 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	/*
-	 * Page is locked so zspage couldn't be destroyed. For detail, look at
-	 * lock_zspage in free_zspage.
+	 * Page/zpdesc is locked so zspage couldn't be destroyed. For detail,
+	 * look at lock_zspage in free_zspage.
 	 */
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
@@ -1819,7 +1824,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* We're committed, tell the world that this is a Zsmalloc page. */
 	__zpdesc_set_zsmalloc(newzpdesc);
 
-	/* The page is locked, so this pointer must remain valid */
+	/* The zpdesc/page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
@@ -1892,7 +1897,7 @@ static const struct movable_operations zsmalloc_mops = {
 };
 
 /*
- * Caller should hold page_lock of all pages in the zspage
+ * Caller should hold zpdesc locks of all in the zspage
  * In here, we cannot use zspage meta data.
  */
 static void async_free_zspage(struct work_struct *work)
-- 
2.43.0


