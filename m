Return-Path: <linux-kernel+bounces-310705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC10E968050
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566D61F249EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE7185B5E;
	Mon,  2 Sep 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a24F2VQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A74185B50
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261410; cv=none; b=kdrOYlo4ZAFCC9odS/S/zRrruJZYrqUPrlxmETIBGKAP7hZc/rRUvho1Bf8coHzY7IQvrjQjqy43+xTx4MlPek7fL2fjEQeTMRHsKonGZap399/YDIR0Ev8avr79zNeDKMuyc60JA8QFxxByLVGw+++FgjYClumyhWS4bwqPUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261410; c=relaxed/simple;
	bh=8cxk8W9Xo69SGYBFRex8FDtZ09OrBx21iVwdBQgpsTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL3F9kQKZmF8ifwgRn8/FWBZnRgoC3urPqZv16iLui+VGSohKowoX5pzUfpqqswAp5jZX3aTfke2vk5yZTHo4k901mM9piqCbf1FH3qatvN0I0v4crlp+rz3Z8/oAjI1HC8iMK4CVuU7QyUChq/ynic3x7go9BzagjwLQzuebHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a24F2VQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61482C4CEC2;
	Mon,  2 Sep 2024 07:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261410;
	bh=8cxk8W9Xo69SGYBFRex8FDtZ09OrBx21iVwdBQgpsTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a24F2VQnLxBeAfFgzkncMF3h1rCsz0+HZE0mPCQdzHFzcAAnrpDMYveicOyyg990A
	 HmRfhw0p7bfJqGm+RryWkBgUWvMhBgTW/uBJbjvf7YLCMIMB0Vhm/l8hsaxn/+mhnw
	 7WmVG5f14hJSFBysA0DWgujyfNTa86E7yzPq54eu5mJsGTnETUbsPO3OMT5UMdw1Gg
	 cz7Ui+tx7hmuxYk8vVOCa9FxXonF+j/ayOHUXTuIvnRQlVH2Xg9xmlOKZML4wtJLfF
	 zwn28zh8Yv7cNLIzHsX8TjaUmmFlNH8WAh1EUFEf6gINm6luljXGdCM4Tb2JV9Vs6P
	 eYoSK2APZFQcg==
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
Subject: [PATCH v7 05/21] mm/zsmalloc: convert obj_malloc() to use zpdesc
Date: Mon,  2 Sep 2024 15:21:16 +0800
Message-ID: <20240902072136.578720-6-alexs@kernel.org>
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

Use get_first_zpdesc/get_next_zpdesc to replace
get_first_page/get_next_page. no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a7e73c0de039..664fff88a7f0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1315,12 +1315,12 @@ EXPORT_SYMBOL_GPL(zs_huge_class_size);
 static unsigned long obj_malloc(struct zs_pool *pool,
 				struct zspage *zspage, unsigned long handle)
 {
-	int i, nr_page, offset;
+	int i, nr_zpdesc, offset;
 	unsigned long obj;
 	struct link_free *link;
 	struct size_class *class;
 
-	struct page *m_page;
+	struct zpdesc *m_zpdesc;
 	unsigned long m_offset;
 	void *vaddr;
 
@@ -1328,14 +1328,14 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	obj = get_freeobj(zspage);
 
 	offset = obj * class->size;
-	nr_page = offset >> PAGE_SHIFT;
+	nr_zpdesc = offset >> PAGE_SHIFT;
 	m_offset = offset_in_page(offset);
-	m_page = get_first_page(zspage);
+	m_zpdesc = get_first_zpdesc(zspage);
 
-	for (i = 0; i < nr_page; i++)
-		m_page = get_next_page(m_page);
+	for (i = 0; i < nr_zpdesc; i++)
+		m_zpdesc = get_next_zpdesc(m_zpdesc);
 
-	vaddr = kmap_atomic(m_page);
+	vaddr = zpdesc_kmap_atomic(m_zpdesc);
 	link = (struct link_free *)vaddr + m_offset / sizeof(*link);
 	set_freeobj(zspage, link->next >> OBJ_TAG_BITS);
 	if (likely(!ZsHugePage(zspage)))
@@ -1348,7 +1348,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(m_page, obj);
+	obj = location_to_obj(zpdesc_page(m_zpdesc), obj);
 	record_obj(handle, obj);
 
 	return obj;
-- 
2.46.0


