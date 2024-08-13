Return-Path: <linux-kernel+bounces-284349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA26950020
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162AA1F232FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92C18A6CF;
	Tue, 13 Aug 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7UIAcQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A94D8DA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538497; cv=none; b=tha9LJh8BepJteyJZi35knH0J+9xNXDt20TY6/1rOS2cQCHl9L5YRTCCW5pD51IQHKUqFNsJWvrSXGUX4mOExFLUWkU3yXp9t68i0y7RxgymwnE5jJn52o6ROAcyy4ED6XQ5/dWHwk2U2k4B6O5plmeu34E0XaZqowIhPlztTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538497; c=relaxed/simple;
	bh=WK8OGotBTrkxbKYhrb1ooiiEWg5GM27+9CUbteEDELE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRjQxVZtB/Gfk1rxf2yScYNRBP2RhXDJ6WNxNiz6Cbi2/dsFdZ/dtNrzsJdKOA8+84tOMJpLzqgXPezDWPwdSyGf97r6EsLJlLaIt5mBfNIq48/j/ICOhDQOHcvEjpWpxI2JsJN7J728MuHKIopk1F/5p+n+uMe2N1qKj168qP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7UIAcQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F52C4AF13;
	Tue, 13 Aug 2024 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538497;
	bh=WK8OGotBTrkxbKYhrb1ooiiEWg5GM27+9CUbteEDELE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7UIAcQ2ktZdGn1OWLy0E/zasMsvSF0kijBroHF8EHYacYxlB2MSlCDYeT7dZ5PEW
	 hKROAwVNCVMZVR+fwI0yTGPNoBq5EBrBecd+M52TBLNgx+wkv56wwvC12zZhUQ8mwT
	 +F+57D62/AqdkqlVTqT1n79ttTF99im4A3EcDPvAFtxW64q4kWkdhyQBTAd1UPNn6J
	 Jsjm3wHPRJ86FBV0xo8SRnIYWL6ysi77/wGwMHyBkg0DBonGQ/oe4+WZG14R5xU9Md
	 Pjw4a+uz84D61qulH54+gpXX+rMLGjKv/rwbp+re9WUDj8w72WRHBXQP9CHoAlNvBv
	 ceaxbBtYv1Beg==
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
Subject: [PATCH v6 08/21] mm/zsmalloc: convert init_zspage() to use zpdesc
Date: Tue, 13 Aug 2024 16:45:54 +0800
Message-ID: <20240813084611.4122571-9-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Replace get_first/next_page func series and kmap_atomic to new helper,
no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 69305ddc0e81..b07c14552276 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -942,16 +942,16 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -964,8 +964,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -975,7 +975,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
 		kunmap_atomic(vaddr);
-		page = next_page;
+		zpdesc = next_zpdesc;
 		off %= PAGE_SIZE;
 	}
 
-- 
2.43.0


