Return-Path: <linux-kernel+bounces-310708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE007968054
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A116280F43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61738185E7A;
	Mon,  2 Sep 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjz9s9qe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5F185B7B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261420; cv=none; b=Ppdr7O46LtTcJFcQL8Fvv9QV4C3dBb5GTxsdj/IjqfYevtpGRrtVstmvgCGw7PLwNfLB6B/2JEQxDRnTGzwlHS1uI6JkHC/9N6aAXtlaR8f3+6bz7MAD68cmb/vphYlz0Y/vPO7InlU3ZNI58+NpZX9r0D86amk7pXZuQxNio+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261420; c=relaxed/simple;
	bh=PNe+PCWyOI4z40ocTHR27DhffZO/+69yc298dwmlSes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlO3g3RwFrfX9KZmxlIhOJCGHfIQCiIceCeOB+NWskgszd10axW5TlAINnhwZGZWqja6EMUJhyjKJbgyxmQYBGEnMLgFiB1moloxJuI9dTIOEMZX8JxCxvNUTioqCZKTATmUcLXHkrMoa749Nf2YG3WY2M08fpvXlXWX9zOnU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tjz9s9qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3069C4CEC9;
	Mon,  2 Sep 2024 07:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261420;
	bh=PNe+PCWyOI4z40ocTHR27DhffZO/+69yc298dwmlSes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tjz9s9qeCkxm3K4mcUE5debLCDqO25YRhRFWJ/avcEDhpY4b8AFlwwm6cq1qeRVSM
	 TGzZdBTjO0kyKpbF/Z7DIxsvEizBwlGCw9sJadLQCvWyAzoTTek19qzxsiyEkUhEak
	 u0KMdnQ6O+BTfJOhcIz2D04qnh0DCeQ4IOyceUrOokKwmSLO7zYm58lT2aGv38l27n
	 ISkuZaS3xI44QuXK7+MXr0ymkpKO43OncUVwMQJoGL/cZpb3Er7s5xJojvxNtbKHEN
	 vMl9o5p/VP+DNo/4sqQvC5TySyWuu0k5MImEY96NjGNU+enX0pdUQJ91RPuVGMeLfg
	 dviBzU7NaaG7w==
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
Subject: [PATCH v7 08/21] mm/zsmalloc: convert init_zspage() to use zpdesc
Date: Mon,  2 Sep 2024 15:21:19 +0800
Message-ID: <20240902072136.578720-9-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Replace get_first/next_page func series and kmap_atomic to new helper,
no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 46d8be5cb4b7..01c5be6f4c96 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -935,16 +935,16 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -957,8 +957,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
@@ -968,7 +968,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
 		kunmap_atomic(vaddr);
-		page = next_page;
+		zpdesc = next_zpdesc;
 		off %= PAGE_SIZE;
 	}
 
-- 
2.46.0


