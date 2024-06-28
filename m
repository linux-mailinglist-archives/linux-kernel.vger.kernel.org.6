Return-Path: <linux-kernel+bounces-233302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B891B549
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F06D281111
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43955466C;
	Fri, 28 Jun 2024 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ/oDvEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F444D8C2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544065; cv=none; b=JoPLPrAnhjduLDNcJIoi+hklNxSu7fOFLTjqBSItSRBWVII7S5MqJ2Sn+NI9duH9zlt9Kh2Ark/6pOGhCGBmdBoBzvHu+jKv075FtG+VUcT7rzBHT95oQtWmkYqGCQy51Kt4EpR7LF72KCK44NBtb4PJp+oyG+XJ+lptWlnO4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544065; c=relaxed/simple;
	bh=vusdBHzfqHkaDK8baoOjr47f4AAjSRZFJhrtyFn5Ac8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocHnMChfoH3Por8OMrZqrnikMamat1y7DB4GoriRgA1sg6oiisjPYBl0ML6C/YyaiOZx8iCoCetoJ9bonfLDyMPjh1SeiTvu64AKO4EUEgSAx28j34EzCY56ENqaI0S2fuUmo6YZWZUrNHXIdhRCddx7A7KUjcQf6TV/0QITMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ/oDvEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84569C116B1;
	Fri, 28 Jun 2024 03:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544064;
	bh=vusdBHzfqHkaDK8baoOjr47f4AAjSRZFJhrtyFn5Ac8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZ/oDvEHhBu8s6dToln3pesB6GaFXokhxzB7lNQwP7xSG6j/NBhslRWc1e3jMBzEO
	 kiPYgyN2CWYo+tKF0U246DL7nSEXR4GnlsXz+SrRPmAc2lbptCrK5YiJF2xKiZdbnZ
	 hv+O/C6NuSsMex3Y3mffzQo0IqaUOvYQc3E9iDlogODu7Y6/LHWRVBJwFSQnHwjGE7
	 GPzFRFyB0QXF9PAMKQW1jWAmIuF5gguivX0DnSVuME3aIdikODNiyyUvaqE/uv4A/9
	 PxxgTIaZaU8gQeEhxtl35LiMSPjI6rNW8ra32YGAVam6NcgKExAEY3Xxq9dui01BGi
	 68jFL4HIjdE6g==
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
Subject: [PATCH 15/20] mm/zsmalloc: convert get_zspage() to take zpdesc
Date: Fri, 28 Jun 2024 11:11:30 +0800
Message-ID: <20240628031138.429622-16-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Now that all users except get_next_page() (which will be removed in
later patch) use zpdesc, convert get_zspage() to take zpdesc instead
of page.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a10af49d8d08..c136124adb10 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -781,9 +781,9 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	return newfg;
 }
 
-static struct zspage *get_zspage(struct page *page)
+static struct zspage *get_zspage(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = (struct zspage *)page_private(page);
+	struct zspage *zspage = zpdesc->zspage;
 
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 	return zspage;
@@ -791,7 +791,7 @@ static struct zspage *get_zspage(struct page *page)
 
 static struct page *get_next_page(struct page *page)
 {
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(page_zpdesc(page));
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -801,7 +801,7 @@ static struct page *get_next_page(struct page *page)
 
 static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -851,7 +851,7 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage))) {
 		VM_BUG_ON_PAGE(!is_first_zpdesc(zpdesc), zpdesc_page(zpdesc));
@@ -1267,7 +1267,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, class->lock
@@ -1317,7 +1317,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1483,7 +1483,7 @@ static void obj_free(int class_size, unsigned long obj)
 
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 
 	vaddr = zpdesc_kmap_atomic(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
@@ -1517,7 +1517,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_zpdesc(obj, &f_zpdesc);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
@@ -1851,7 +1851,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	__SetPageZsmalloc(zpdesc_page(newzpdesc));
 
 	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
 	/*
-- 
2.43.0


