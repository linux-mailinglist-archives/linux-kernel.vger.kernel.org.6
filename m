Return-Path: <linux-kernel+bounces-310717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF196805E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CE8B2435D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AE183CCB;
	Mon,  2 Sep 2024 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQujTYAA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA715FA92
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261452; cv=none; b=gpowSe6ISp7ghqKtmR1Pn0WqbE941plVXeXUsbVvihfvuV1gpxwZp6bnbAea+hz605ag6DXIQcA5AAupM9CgzpCNz/6jjJrk0YKX0dDdJR6BD7zRJJx4s9Ea/yBoqIZzPJRM3XTLOXX2Vt/nf1b1zTn2yu9DRYM6cAdj31YAmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261452; c=relaxed/simple;
	bh=mUt+2jl57a1O3x/5Q9wSnZvk6+ZzUwzDrkQBYoscUAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFNltA5HOJnGAD980hjSj05u5e9qoSYbJlNzrLO8tiMYJ2/wilw1R1LgOJ6ky4Z5J2P+UJPSoRvOaN8jlv2OdgSCC4tIAtNAqTMoAS11yn0ZikRkhqGQw3fRo0NKszGTlNMpJrWIADAGyj6yRx7AzpiENZI+biB/2uyfOUItPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQujTYAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A176C4CEC4;
	Mon,  2 Sep 2024 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261452;
	bh=mUt+2jl57a1O3x/5Q9wSnZvk6+ZzUwzDrkQBYoscUAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQujTYAAUF38D+/6f3rqz71xwGDllZgvbzpatRIu87HIi30swSwSE/K0ycx4vmIfl
	 oqE0HY3KHgIE50k9iKI7PrQXI8TUzZPYgpAjpYabGLaVvtX4eEVL8YXBVMy0OBYb5x
	 DpNOctRFE/8cBs7OB5UGid0JG7sHC1jSAOTOdVaee2LWSE6ozbnSHn+RgjVD2KI3fo
	 KrMqJoCwDNOUe+Uz+r2k/5fJzP2DdEmhbb2/VhBxuab4pmB5bfiXjdaRYI2KKOWJTX
	 FPGJ3k9WoBD36mKBgspStCsQzlzxftZjTo8/Hx22ZT38TQFA0rdz/+7aYpDWxNCHVG
	 3JwYu5XumfIUA==
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
Subject: [PATCH v7 17/21] mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
Date: Mon,  2 Sep 2024 15:21:28 +0800
Message-ID: <20240902072136.578720-18-alexs@kernel.org>
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

Now that all users of get/set_first_obj_offset() are converted
to use zpdesc, convert them to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3b98daa63ece..839fe7eaca8a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -488,20 +488,20 @@ static struct zpdesc *get_first_zpdesc(struct zspage *zspage)
 
 #define FIRST_OBJ_PAGE_TYPE_MASK	0xffffff
 
-static inline unsigned int get_first_obj_offset(struct page *page)
+static inline unsigned int get_first_obj_offset(struct zpdesc *zpdesc)
 {
-	VM_WARN_ON_ONCE(!PageZsmalloc(page));
-	return page->page_type & FIRST_OBJ_PAGE_TYPE_MASK;
+	VM_WARN_ON_ONCE(!PageZsmalloc(zpdesc_page(zpdesc)));
+	return zpdesc->first_obj_offset & FIRST_OBJ_PAGE_TYPE_MASK;
 }
 
-static inline void set_first_obj_offset(struct page *page, unsigned int offset)
+static inline void set_first_obj_offset(struct zpdesc *zpdesc, unsigned int offset)
 {
-	/* With 24 bits available, we can support offsets into 16 MiB pages. */
-	BUILD_BUG_ON(PAGE_SIZE > SZ_16M);
-	VM_WARN_ON_ONCE(!PageZsmalloc(page));
+	/* With 16 bit available, we can support offsets into 64 KiB pages. */
+	BUILD_BUG_ON(PAGE_SIZE > SZ_64K);
+	VM_WARN_ON_ONCE(!PageZsmalloc(zpdesc_page(zpdesc)));
 	VM_WARN_ON_ONCE(offset & ~FIRST_OBJ_PAGE_TYPE_MASK);
-	page->page_type &= ~FIRST_OBJ_PAGE_TYPE_MASK;
-	page->page_type |= offset & FIRST_OBJ_PAGE_TYPE_MASK;
+	zpdesc->first_obj_offset &= ~FIRST_OBJ_PAGE_TYPE_MASK;
+	zpdesc->first_obj_offset |= offset & FIRST_OBJ_PAGE_TYPE_MASK;
 }
 
 static inline unsigned int get_freeobj(struct zspage *zspage)
@@ -921,7 +921,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		struct link_free *link;
 		void *vaddr;
 
-		set_first_obj_offset(zpdesc_page(zpdesc), off);
+		set_first_obj_offset(zpdesc, off);
 
 		vaddr = zpdesc_kmap_atomic(zpdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
@@ -1576,7 +1576,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	unsigned long handle = 0;
 	void *addr = zpdesc_kmap_atomic(zpdesc);
 
-	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	offset = get_first_obj_offset(zpdesc);
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
@@ -1771,8 +1771,8 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
 	create_page_chain(class, zspage, zpdescs);
-	first_obj_offset = get_first_obj_offset(zpdesc_page(oldzpdesc));
-	set_first_obj_offset(zpdesc_page(newzpdesc), first_obj_offset);
+	first_obj_offset = get_first_obj_offset(oldzpdesc);
+	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
 		newzpdesc->handle = oldzpdesc->handle;
 	__zpdesc_set_movable(newzpdesc, &zsmalloc_mops);
@@ -1827,7 +1827,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
-	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	offset = get_first_obj_offset(zpdesc);
 	s_addr = zpdesc_kmap_atomic(zpdesc);
 
 	/*
-- 
2.46.0


