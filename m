Return-Path: <linux-kernel+bounces-275585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94994876E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F82C281204
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABE5482E4;
	Tue,  6 Aug 2024 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsMWYRZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38547F7A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910705; cv=none; b=Q8WEBiRU6A5Qemcx76cAgisXWcqmhwqbhnBk5l1l696I8AFnPOPyUfHYtyFLi69okyPqdVy29shPTCvwFUEznki54fcMfge0Zozjn3lEoIWv6++np6fzTG233K05ukQ5zI3ohq5RIDDMPouwIQZH2/dx5HZ1XWE3Efr1Eih9924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910705; c=relaxed/simple;
	bh=vNwIGyy8uUag3zQP5bXF/PNe/niCN1bQWoZ3dk5XDpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1p2nqn2xd/zaT+FoVMR0Qtvs7Fb7Pnm70hhZA+2vQMZ+sj1WpWDYmDZ7f+KIqaDD8pZo+7SCqfK66qNkSCB+Pt+yvrOfHaeDQsABvaKXn51WZS2sLlVwMhjfbjWlKPSKml4gWFriifWuv7P2bnQdM7ProM/KWnJcpcYJIFFis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsMWYRZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9359EC32782;
	Tue,  6 Aug 2024 02:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910704;
	bh=vNwIGyy8uUag3zQP5bXF/PNe/niCN1bQWoZ3dk5XDpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsMWYRZJUqU0Itrt3J8567cHgcx7ZWcgbPSnbOQZy70q7mwkndUTL+/3BqxOm3jLe
	 1JRXz3aiwZLokB5iJOIAxSzflNxhwrdBNUmQ0yr+fTHmP6UHPnfZXf7ixPXMndCYtR
	 Xvx0NYmeEH8VFJaWIPEcpkE44VAf3Iq0589/x9KYqXkzoR1v4hFCn9gXAp43FRTRuB
	 3gwiRk+9fT3CtV1V1KDMvvYsPFFrtc+3sl1sU18WkpAkEgFNlSYItJMcheDweCDUcj
	 x6cS/1tCwsSUmImOLOvc1iIP45X2TJ1nhJOZhMkYGSHW81OmWHotixv+CqQ+uO3/q4
	 WUgiwGNqY5X+w==
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
Subject: [PATCH v5 08/21] mm/zsmalloc: convert init_zspage() to use zpdesc
Date: Tue,  6 Aug 2024 10:22:55 +0800
Message-ID: <20240806022311.3924442-9-alexs@kernel.org>
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

Replace get_first/next_page func series and kmap_atomic to new helper,
no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3c1755227706..d7400acd0f01 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -928,16 +928,16 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -950,8 +950,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -961,7 +961,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
 		kunmap_atomic(vaddr);
-		page = next_page;
+		zpdesc = next_zpdesc;
 		off %= PAGE_SIZE;
 	}
 
-- 
2.43.0


