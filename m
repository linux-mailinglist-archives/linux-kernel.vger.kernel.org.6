Return-Path: <linux-kernel+bounces-243896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D1929C35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6991C214FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739039FFE;
	Mon,  8 Jul 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udx6ZKiI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBE39AEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420151; cv=none; b=Jqb8CxY6oOSVHNUIye5+SBjXqHq1L3LldUrZwP3cRIrTw9o7E5ss5CiqFGKBq5+hamAcaEFrt/HZmfdgbJtD0HK+vwHeiQyoTfINQVBgQBJPVUnQDiycqWqtMYKvNELWH7haO12L/kBQi9NQI6k9tmCk/iQc9uyjN2QdkrtRAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420151; c=relaxed/simple;
	bh=kTQuh9UlyfPp1whk32zz/TIJv5bm40Slp4CbPrYPxLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+Vt1DXs2eLfk9HSgeWkuNxrh8As2kvk/+h7xhH7qJz48wwPrRvawY/UHouRRdvHbgiO6BTHCpou/sRxhyRxNr4Z9HGSkz2pYObhOBs3pNgERKuK21HzQhqRgMe+oKabIaQH7QHspXO2IupVh98zvNHv2ZYkf3B9aBVuh0ao0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udx6ZKiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E6FC116B1;
	Mon,  8 Jul 2024 06:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420151;
	bh=kTQuh9UlyfPp1whk32zz/TIJv5bm40Slp4CbPrYPxLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Udx6ZKiI6UdDrWncO84TIziVamqJ5fINWm6oO/wLz3/XChs2OG1+FQ3/2CXFk5bsB
	 +xnt0gGqyIejEqOGH8mFMn3jHKC05UXg68HadyIlWmoZJevSRe1mMUblw0apD2CvLE
	 VVDiiNoSjd3uqsz3OlEEfcUkLSZ9kpfZB1DNcQ5zm1oZJOptjMhdj7m84Q8I/TYLUA
	 Uyghf4PZ+BvaS3mhbU6a5VGy9FfQEJAtExYAJoU6t+X34kjcmzv8Z3mYH4eXeu+65d
	 Qot4m1jNXsFwaryY0Q6swUwKwKZdsvF0NOycLP9VHpe5l9TAuhtbK8/5ogoE++r8jW
	 umZhKDt6S3Gog==
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
Subject: [PATCH v3 08/20] mm/zsmalloc: convert init_zspage() to use zpdesc
Date: Mon,  8 Jul 2024 14:33:29 +0800
Message-ID: <20240708063344.1096626-9-alexs@kernel.org>
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

Replace get_first/next_page func series and kmap_atomic to new helper,
no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 29b9fa5baa46..d3558f3f8bc3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -948,16 +948,16 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 {
 	unsigned int freeobj = 1;
 	unsigned long off = 0;
-	struct page *page = get_first_page(zspage);
+	struct zpdesc *zpdesc = get_first_zpdesc(zspage);
 
-	while (page) {
-		struct page *next_page;
+	while (zpdesc) {
+		struct zpdesc *next_zpdesc;
 		struct link_free *link;
 		void *vaddr;
 
-		set_first_obj_offset(page, off);
+		set_first_obj_offset(zpdesc_page(zpdesc), off);
 
-		vaddr = kmap_atomic(page);
+		vaddr = zpdesc_kmap_atomic(zpdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
 
 		while ((off += class->size) < PAGE_SIZE) {
@@ -970,8 +970,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		 * page, which must point to the first object on the next
 		 * page (if present)
 		 */
-		next_page = get_next_page(page);
-		if (next_page) {
+		next_zpdesc = get_next_zpdesc(zpdesc);
+		if (next_zpdesc) {
 			link->next = freeobj++ << OBJ_TAG_BITS;
 		} else {
 			/*
@@ -981,7 +981,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
 		kunmap_atomic(vaddr);
-		page = next_page;
+		zpdesc = next_zpdesc;
 		off %= PAGE_SIZE;
 	}
 
-- 
2.43.0


