Return-Path: <linux-kernel+bounces-243895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C6D929C33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8335B20D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD12F381BD;
	Mon,  8 Jul 2024 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZUatPhA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D749376E9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420148; cv=none; b=T7fegP5Jp2tBK6RG+75P7JpoAXFEn9O0eXBGGuauukUuCePdn3bNsnAZY0mITEs7e9X31i4SMLX+b6EbsHd8LqraesvcgSLLjd6Fbme9pAVqn8EkmxX6NSx1s1oQRTArv882E6uXtdGv87PuFt6xkTo2k/322Y1liC7ECNQt6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420148; c=relaxed/simple;
	bh=eUVr/nevUiypHdkqs90LAQGcxdPsPYteX43+BHTjXcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiEMff3RsLUsVX1fBSXuzjNCqzQCIv8AAiI3+hzFVjgIRh4S/ctk+oqJRGaroYcIF7pgeG+Y4njwoaGHdavZsOfl4agpvN5V4XWBvyd2YyaQyhOjNjCMwuwpAaaITyPwTPd2dQ78YrgGhVEq8AI3vnPAQgOdHn8qI9sA8JlZAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZUatPhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47754C116B1;
	Mon,  8 Jul 2024 06:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420147;
	bh=eUVr/nevUiypHdkqs90LAQGcxdPsPYteX43+BHTjXcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZUatPhAeDrGrCo7sj3uta4gUIoHLfsfvRqLImOTiu9Ew6pEEgEFIOq0FSp+n5nwr
	 QUQtfQqHNsuPdOaitMA8AzGvFRLInyN24C77Tk7y0e98ECidpaZy2xPt6WcuarP7L5
	 TBOyX1bZOTr7g5ZtY4U7xHoKTOGv9CJ0Ii9hB6TgLH4X+XjfqtBiqYubR/UrpapQHY
	 bvCJQvBU/k1baFZ5PsaTYfxcJGwbs7QtuI7RelgsDIjmtrGKew2vbFGQE177XxhgdU
	 bkpQ0aVFkhdhzwcff+LWaITeqGvljAUNPo8L8o/7dFg4yBfq34RKmo2O+m8jrmccwF
	 WyP+xYNxqjE0g==
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
Subject: [PATCH v3 07/20] mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
Date: Mon,  8 Jul 2024 14:33:28 +0800
Message-ID: <20240708063344.1096626-8-alexs@kernel.org>
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

Convert obj_allocated(), and related helpers to take zpdesc. Also make
its callers to cast (struct page *) to (struct zpdesc *) when calling them.
The users will be converted gradually as there are many.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a8f390beeab8..29b9fa5baa46 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -845,15 +845,15 @@ static unsigned long handle_to_obj(unsigned long handle)
 	return *(unsigned long *)handle;
 }
 
-static inline bool obj_allocated(struct page *page, void *obj,
+static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
 
 	if (unlikely(ZsHugePage(zspage))) {
-		VM_BUG_ON_PAGE(!is_first_page(page), page);
-		handle = page->index;
+		VM_BUG_ON_PAGE(!is_first_zpdesc(zpdesc), zpdesc_page(zpdesc));
+		handle = zpdesc->handle;
 	} else
 		handle = *(unsigned long *)obj;
 
@@ -1603,18 +1603,18 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
  * return handle.
  */
 static unsigned long find_alloced_obj(struct size_class *class,
-				      struct page *page, int *obj_idx)
+				      struct zpdesc *zpdesc, int *obj_idx)
 {
 	unsigned int offset;
 	int index = *obj_idx;
 	unsigned long handle = 0;
-	void *addr = kmap_atomic(page);
+	void *addr = zpdesc_kmap_atomic(zpdesc);
 
-	offset = get_first_obj_offset(page);
+	offset = get_first_obj_offset(zpdesc_page(zpdesc));
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
-		if (obj_allocated(page, addr + offset, &handle))
+		if (obj_allocated(zpdesc, addr + offset, &handle))
 			break;
 
 		offset += class->size;
@@ -1638,7 +1638,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, s_page, &obj_idx);
+		handle = find_alloced_obj(class, page_zpdesc(s_page), &obj_idx);
 		if (!handle) {
 			s_page = get_next_page(s_page);
 			if (!s_page)
@@ -1871,7 +1871,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(page, addr, &handle)) {
+		if (obj_allocated(page_zpdesc(page), addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-- 
2.43.0


