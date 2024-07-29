Return-Path: <linux-kernel+bounces-265622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C293F3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45377282ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC01146D63;
	Mon, 29 Jul 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1dl0pOc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A5146A8C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252034; cv=none; b=lu9Z+TEKF2uo+UenyEDY7jJmpx5tf+4knmg4G5emWzayl+zJZzsph4iSEU5dTBtsAtzcYl0M5FmfuiGH9TnCKQSiiNYVLQ+s7pvFjMEMED4kPvy+Wh9g7x6HORFs5zqOkBrBB5XyMsLBpOiTtyT1Q3C9SQRcKxoh77fz0AGA3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252034; c=relaxed/simple;
	bh=OUw0L1+EEkxStexhrY6FwqktPPZ5HwiknqjqfzU6PXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtYjHkhfzfyV9gRyRGDBlp4agjA0VoTvTe9WeJSKgKINeZKRXNAj+hgRWWoP953nROcbhrW0IoHdSaljNvLeYMvyObI5R5lDopLuNb1PESe4a8ShgzrMHFZvEVmLEEZsBY+oxcyfMea4bj9D2/mZxU6X77R59IhZVTKEymLGAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1dl0pOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F00FC32786;
	Mon, 29 Jul 2024 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252034;
	bh=OUw0L1+EEkxStexhrY6FwqktPPZ5HwiknqjqfzU6PXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1dl0pOcTFgdmJMCVClV0yXxSZWm7Os6wsGJ8ws8QQxeG1j3yfc4V0ckuKv4YRMv/
	 N5hoiL5nFmBw9n5kMO//6XdEuvI1hUezsU07uTtuoLOWXZf9d7IUGz7qr8PrG7Ou9P
	 oz3DyQNNb766EmVqx/Ph2tCIOxiJYm8TzWmi0nRSA3dytbAskWr3IWIfrIMpzw9y/D
	 oVY3NFI/tP0Wjs+PVcxCpfRBSSKz1lDKt0FCv6Aznv+WWyn5nND3SBVMP8rLdaRzof
	 H7D20CRe1/5dp+pGZF7Nyz3t615VHG60okruZFTRx/u9cA4QYBXyElY4tQZktkitMc
	 /UvAS8vIlC8Bw==
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
Subject: [PATCH v4 05/22] mm/zsmalloc: convert obj_malloc() to use zpdesc
Date: Mon, 29 Jul 2024 19:25:17 +0800
Message-ID: <20240729112534.3416707-6-alexs@kernel.org>
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

Use get_first_zpdesc/get_next_zpdesc to replace
get_first_page/get_next_page. no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 149fe2b332cb..bbc165cb587d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1322,12 +1322,12 @@ EXPORT_SYMBOL_GPL(zs_huge_class_size);
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
 
@@ -1335,14 +1335,14 @@ static unsigned long obj_malloc(struct zs_pool *pool,
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
@@ -1355,7 +1355,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(m_page, obj);
+	obj = location_to_obj(zpdesc_page(m_zpdesc), obj);
 	record_obj(handle, obj);
 
 	return obj;
-- 
2.43.0


