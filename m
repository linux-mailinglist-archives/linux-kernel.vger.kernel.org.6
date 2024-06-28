Return-Path: <linux-kernel+bounces-233295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1391B542
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245A82840F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C16558BC;
	Fri, 28 Jun 2024 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/NycspK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7455897
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544039; cv=none; b=e7drSOndr5Fo4z5Q/WQjdIAsJZBwe9CYmAdNaA6CnW87NaJe9+gDBWiwcKWM3l+P94UKYX6x2IfzZQ9b4CCfzra2lgiu2//3TUg6VfGQswmnLaIoccnzz1V45gR6gMmbtlQR1fQZduliUIE2MZp5iNeroVUHaBBHKUMzFgClwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544039; c=relaxed/simple;
	bh=KxgG3cMNh41F6OEFoev4W8KoSH3YuCbiC9yyKNDszWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfzlKZ/kFhzYQ9eQffQSz/HEymow9eESVYLFPkeSSVrLKKB5EtS/4fTs7jkceGMBBX6uzaFn/DeqfYY2PJw1gCVff9m1H/ro4vNjQJkhJw8HZmA/O+sinaubwaHCfGGYsYSKHs21DpNIJy71CFSR3/nDS95r+OQ/qB/YMNYs+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/NycspK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECADC116B1;
	Fri, 28 Jun 2024 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544038;
	bh=KxgG3cMNh41F6OEFoev4W8KoSH3YuCbiC9yyKNDszWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/NycspKY6Agf3MdDX1SDFtv0XHJhE1/1Ar+c+DWV0XEmuLaiYftnIc+JENyd4fOp
	 daPtvZ95Qs3DI6xb3UCA8xlF8P5PlQ/U/k4ab1NL2hTXfOZIGYOVgEu4+CUaGkdhD7
	 tnIc259NZ3i5cYSavDbG2dHMBBjGtPv+RDgT2nUnnw/BAADyjfgVLMBjIpzXz5UpxI
	 XDHb0hrUPW3d/n2EGhhU1NGpmpuktWX3xvOYAhE08BtUB6xV847wDyefrPg9uwS2fC
	 4rwIcyKebgAB+DWqa/OMETiqGnf3sC98/n1MmdU220AjgU75XO+WRb8rdkVVaC1/UZ
	 ZRaOiC+UnURdg==
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
Subject: [PATCH 08/20] mm/zsmalloc: convert init_zspage() to use zpdesc
Date: Fri, 28 Jun 2024 11:11:23 +0800
Message-ID: <20240628031138.429622-9-alexs@kernel.org>
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

Replace get_first/next_page func series and kmap_atomic to new helper,
no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6efaa6279687..e90e3a638068 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -950,16 +950,16 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -972,8 +972,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -983,7 +983,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
 		kunmap_atomic(vaddr);
-		page = next_page;
+		zpdesc = next_zpdesc;
 		off %= PAGE_SIZE;
 	}
 
-- 
2.43.0


