Return-Path: <linux-kernel+bounces-265641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D893F3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545511C21DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E622156227;
	Mon, 29 Jul 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRs0YtQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AE3155CB3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252089; cv=none; b=GYv7ZBnkq5WF8bjEaH1LQDdOFAZY+UpKe8nKVMjPlBZ7m1U/ePHTPzWzF80Btg0gHJ8TlkwxxfXBNwgMOyiuMS3xVBXT618x+iyYCI5VVfracJhBlHj4Mu6jw4wVA+YCpNYz9q3e+2HO6CvoIz3QB7YGAMg0KZ/tkL01WN5+fFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252089; c=relaxed/simple;
	bh=rElfU0d71iABwZ67rvpmRaqaEhOUs/Njjel6X7x+ZZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7ksORC8/0ieUVy5tMyLSQlXFAFCdTlVB1mKGlw/mfUML2l5/yxVZwx1b/3elyccGhrHh2giA9hA8+D+zNZFsCWsllLXGGBC1jUYLrl7022Okq1dZpVtm1fcBuyk5JR0Bz4HP67IinCkTtVbdLm8g1vmTOkAvTy4POOFlpGMU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRs0YtQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8204C32786;
	Mon, 29 Jul 2024 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252089;
	bh=rElfU0d71iABwZ67rvpmRaqaEhOUs/Njjel6X7x+ZZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRs0YtQX+izREwBhLyXvqNE4b9sY2v23cdCN/KVwRcfz69oPiD+Hvnh90SwhTsaPb
	 Vkx9r2ZgMQTy4rmd0MnKCimmI3w9vx/KaFmcPpT3SCdLMXKPYzhSEKbXTYzzNr3oN7
	 m26rXcx/pzAXE1R5k5eAqJYKMvinugxhBLA8twMfBgA+zJMoWYPl02pDo+cWmUbHLa
	 Dm5UOuCX5Ae3mcSJ3o7Ckxn/IDqSbGnvEiu5bcPkEHVnYDBb3x2T6p1MDJsrdwE0E3
	 yqlmrYcH1BamgQHFciiWbXWkrO8PfJIgvAik/Cpka48aj+BCo5XT+UZrbc0mlt8Fu+
	 Okqo2hQrbz3mQ==
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
Subject: [PATCH v4 22/22] mm/zsmalloc: update comments for page->zpdesc changes
Date: Mon, 29 Jul 2024 19:25:34 +0800
Message-ID: <20240729112534.3416707-23-alexs@kernel.org>
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

From: Alex Shi <alexs@kernel.org>

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 64e523ae71f8..50ce4a3b8279 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -967,7 +967,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	set_freeobj(zspage, 0);
 }
 
-static void create_page_chain(struct size_class *class, struct zspage *zspage,
+static void create_zpdesc_chain(struct size_class *class, struct zspage *zspage,
 				struct zpdesc *zpdescs[])
 {
 	int i;
@@ -976,9 +976,9 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 	int nr_zpdescs = class->pages_per_zspage;
 
 	/*
-	 * Allocate individual pages and link them together as:
-	 * 1. all pages are linked together using zpdesc->next
-	 * 2. each sub-page point to zspage using zpdesc->zspage
+	 * Allocate individual zpdescs and link them together as:
+	 * 1. all zpdescs are linked together using zpdesc->next
+	 * 2. each sub-zpdesc point to zspage using zpdesc->zspage
 	 *
 	 * we set PG_private to identify the first zpdesc (i.e. no other zpdesc
 	 * has this flag set).
@@ -1036,7 +1036,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		zpdescs[i] = zpdesc;
 	}
 
-	create_page_chain(class, zspage, zpdescs);
+	create_zpdesc_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
 	zspage->class = class->index;
@@ -1363,7 +1363,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		/* record handle in the header of allocated chunk */
 		link->handle = handle | OBJ_ALLOCATED_TAG;
 	else
-		/* record handle to page->index */
+		/* record handle to zpdesc->handle */
 		zspage->first_zpdesc->handle = handle | OBJ_ALLOCATED_TAG;
 
 	kunmap_atomic(vaddr);
@@ -1783,7 +1783,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 		idx++;
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
-	create_page_chain(class, zspage, zpdescs);
+	create_zpdesc_chain(class, zspage, zpdescs);
 	first_obj_offset = get_first_obj_offset(oldzpdesc);
 	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
-- 
2.43.0


