Return-Path: <linux-kernel+bounces-265625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CEE93F3DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA62282652
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570D1482E9;
	Mon, 29 Jul 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxZcivsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F1146A60
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252044; cv=none; b=P0ZIit9Wbj9o2SNha7fRFfCgEUYWpD4InrbMKwwSmyXrafMDvajXqVUPBxoufkNpMGFNuO/vB4Gj4kFTFnJOXQ0HAkAKR9/ulgbY4q96kOMcmK4IicEDDcP+bC73fwsmIhkCXEuP2YJtiLD937K9uvSI0FZzvOZl+ph4wW2m2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252044; c=relaxed/simple;
	bh=hCA+Wp2koQFPErK04B2puEI5lWDR1Rh4V60AMISo3bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbjjQ/mRaXjNz/jkArCzdeOWaM+uya82qod5WDQ6FxDhlFTDa8O9G2PfeJKzANyHvqWxYFQQbiexC2z1EWGSJEwtWfnO0MK2JGyNZ4rM8ftFHo72IqSRxmQv4PHscx4pADM2/xhQu0chx81KhkyAXgM3wko4kU/v9xQyA710eik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxZcivsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232D0C4AF0A;
	Mon, 29 Jul 2024 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252043;
	bh=hCA+Wp2koQFPErK04B2puEI5lWDR1Rh4V60AMISo3bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxZcivsxHrV7ru1KjcEzOlOvSeKDf/VpS35R1Jm/ckHCF5FkBHfPZZlKMLo1HZlJZ
	 e+mZIYJdkYGOoowl74xkpbxMv+5NuCg1KbSFCL4kZ00Tqa3dTGnIiwH50thl+3pYVa
	 Geh9a7OSmgGpOqv0ZOW2hZIUlBaMFwvD0xV8t4bdMzCjwlGp7rgp+nn3EGq3oahway
	 16a0c1+b0SjHzRW7oSgs1/gNsL+p0Ht9S6hgw8Abb/W7bj3eI4av9N4IaeoQx0Ogp7
	 ZP2Xcf2MLAk4ozA193cBosfrjL0qJE8Q7nrWXzuslYTjAjYJOrSlnhZ9DJHaPEbYhC
	 GG/xWcMb4MZ4Q==
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
Subject: [PATCH v4 08/22] mm/zsmalloc: convert init_zspage() to use zpdesc
Date: Mon, 29 Jul 2024 19:25:20 +0800
Message-ID: <20240729112534.3416707-9-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729112534.3416707-1-alexs@kernel.org>
References: <20240729112534.3416707-1-alexs@kernel.org>
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


