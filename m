Return-Path: <linux-kernel+bounces-275592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CBF948775
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF78D2865F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB82D38397;
	Tue,  6 Aug 2024 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWgzmYgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896136AF2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910731; cv=none; b=QR1gP1binUxPkF6PbgHJkPbpTFP7LxPk6Fb21thZIC3fts42tjsHMszLY0hfF/7AkEdu5hXC8nsXIlkEd86EVo7I3aR3QPj5pnJy6COqLdDqK25IXUftp1SFoylvvCo9o6M1hlcqlQm3x/UUyCrkLlxg3VuDchSIUB/Rbaz0Iqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910731; c=relaxed/simple;
	bh=ogZXEVMMW4vu3mmfL4ddTVfOtlodq8fb2Ek8tntegjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7HBcSErssquljakW/ES1G+1ScPEO5qQvA5VRTR/HQRWVA+bN48o5kBOuvC3gu0OZ/Eeks1OLzKeidzUFLBba7gkfT9qH0AL5y23DGwlgacTgZshFALobrbwPvPE+XeS221hr52x/Sl7hPAnGwqvyKdJ6SuFWm7voGichZlSpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWgzmYgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7538C4AF0C;
	Tue,  6 Aug 2024 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910730;
	bh=ogZXEVMMW4vu3mmfL4ddTVfOtlodq8fb2Ek8tntegjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWgzmYgv43cIb1Yiwb7X3nxE/pvVIH2czvwhcvBxw+2XWnAWknGn5a5R2zBnvcHX2
	 AN2G5vS7GEbGmHtuuwf4IQ+El+/Yo9rRX+lAukVEUWkiDn5Bk0XTE61vlWrhSNXtsw
	 h0RBltoj7fNzr7nTdqweZjWmT4+rVA5Ye+/YKu7LpAc6OM+i0DtFuwv/Xjziz4XPMJ
	 yykfc6l+Byh1PYyMscKofhgssFWWTA1a90SfMRPHgJDCsBwDIKx9Y7d+Jtld/GETLC
	 eaOgOHDsyvsotZXHSHWJd33trvlCMq2Ie47dpzUtR/Gs3xRP3Vg2pqkk72SXbUh0fa
	 OCih3mDoloK4w==
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
Subject: [PATCH v5 15/21] mm/zsmalloc: convert get_zspage() to take zpdesc
Date: Tue,  6 Aug 2024 10:23:02 +0800
Message-ID: <20240806022311.3924442-16-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806022311.3924442-1-alexs@kernel.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
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
index c8a533b516ea..7ae98d048590 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -759,9 +759,9 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	return newfg;
 }
 
-static struct zspage *get_zspage(struct page *page)
+static struct zspage *get_zspage(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = (struct zspage *)page_private(page);
+	struct zspage *zspage = zpdesc->zspage;
 
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 	return zspage;
@@ -769,7 +769,7 @@ static struct zspage *get_zspage(struct page *page)
 
 static struct page *get_next_page(struct page *page)
 {
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(page_zpdesc(page));
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -779,7 +779,7 @@ static struct page *get_next_page(struct page *page)
 
 static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -829,7 +829,7 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage))) {
 		VM_BUG_ON_PAGE(!is_first_zpdesc(zpdesc), zpdesc_page(zpdesc));
@@ -1245,7 +1245,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, class->lock
@@ -1295,7 +1295,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1459,7 +1459,7 @@ static void obj_free(int class_size, unsigned long obj)
 
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 
 	vaddr = zpdesc_kmap_atomic(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
@@ -1493,7 +1493,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_zpdesc(obj, &f_zpdesc);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
@@ -1826,7 +1826,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	__SetPageZsmalloc(zpdesc_page(newzpdesc));
 
 	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
 	/*
-- 
2.43.0


