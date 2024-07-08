Return-Path: <linux-kernel+bounces-243903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6CF929C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911C028549F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EE224F2;
	Mon,  8 Jul 2024 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL80aVHo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761B20B33
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420177; cv=none; b=MlvvIXJX3b2KGWumbbo308q/M3w8VUN3yn21E89S49mnNIpPhc9r6bs3/DRur3Cv91GBKouef7O9y9vj6fVCEvFggZbxXzvWEDTX32qV9WueBGRf/9fr7e/eCPa0Xe9Ov7b2EpFK0zWR3RJ1u0MVbdNnKFfkHDlKCDtnpUPz5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420177; c=relaxed/simple;
	bh=7eF5F3tLj5M84TMn26AMq8BpyTBKqnCtBSnMwvbth1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kstACSrpsJ3lPJFRMFUgX41t7CPvaPtR1I54EP2Xyke8SPxRQbnrqjSNVzrlPwai+tGjIIclp4beynRMmhh44JQ0DkENdKCIKyoaRb2jU26rEEj/bDFWPPoXtV02nUG3tSGZ2xJh3Dkoil1riFh7yRKLmWM+XFd2FWhq/9dT5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL80aVHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365C6C116B1;
	Mon,  8 Jul 2024 06:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420177;
	bh=7eF5F3tLj5M84TMn26AMq8BpyTBKqnCtBSnMwvbth1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YL80aVHoDjsPpQiEFbQTkgxQsZ584pywl8w3bPOSXFSqwYmZXgdEwogm6GaWDr7Jz
	 IL40gwAKS4R5HieLcR2aixdW1ZSNWXe2OK3CXRIKSoqf6zPhWdbVbWekFTy2yUNuAM
	 qPrnz32NbPsJ3fKvenqrjhmV08ZQio/iPNunbTc3ItLjwdwL7FM7J9vSZcOQxmzurn
	 6tByRNjMwTTOFDhCdCinryOYpSJDfCLxfgx27Q4A75DaxcaCPsMDUkvPp76JmkCXIH
	 1/sC7c74gsr+OeCq7Vh8ij43eR84+rzJcYe23EQgfrfR8uwEZSnKwA2xlTFVEXYTcO
	 ebeTPLAH4yTSw==
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
Subject: [PATCH v3 15/20] mm/zsmalloc: convert get_zspage() to take zpdesc
Date: Mon,  8 Jul 2024 14:33:36 +0800
Message-ID: <20240708063344.1096626-16-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Now that all users except get_next_page() (which will be removed in
later patch) use zpdesc, convert get_zspage() to take zpdesc instead
of page.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7d039b0c66db..458ad696b473 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -779,9 +779,9 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	return newfg;
 }
 
-static struct zspage *get_zspage(struct page *page)
+static struct zspage *get_zspage(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = (struct zspage *)page_private(page);
+	struct zspage *zspage = zpdesc->zspage;
 
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 	return zspage;
@@ -789,7 +789,7 @@ static struct zspage *get_zspage(struct page *page)
 
 static struct page *get_next_page(struct page *page)
 {
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(page_zpdesc(page));
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -799,7 +799,7 @@ static struct page *get_next_page(struct page *page)
 
 static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -849,7 +849,7 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage))) {
 		VM_BUG_ON_PAGE(!is_first_zpdesc(zpdesc), zpdesc_page(zpdesc));
@@ -1265,7 +1265,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, class->lock
@@ -1315,7 +1315,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1479,7 +1479,7 @@ static void obj_free(int class_size, unsigned long obj)
 
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 
 	vaddr = zpdesc_kmap_atomic(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
@@ -1513,7 +1513,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_zpdesc(obj, &f_zpdesc);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
@@ -1846,7 +1846,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	__SetPageZsmalloc(zpdesc_page(newzpdesc));
 
 	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
 	/*
-- 
2.43.0


