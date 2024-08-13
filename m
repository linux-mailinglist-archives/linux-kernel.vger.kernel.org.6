Return-Path: <linux-kernel+bounces-284346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA095001D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983261C22A08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000C187341;
	Tue, 13 Aug 2024 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRCXz/JP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC3186298
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538486; cv=none; b=ugUzbMWpr9sENqTDc9I4TwQXxiccz93J3ClSxb5sTRS9sI0TlDxDay9sOqzCNClhjkVSCtjVI/1eMei7vRUSPhXlhnEUHzewrw9FBeBWzs/W8JBzqLzbCoNMUiYRluyUW0V5eQRBhoFNrMLni5omVaD5C4pv/nlRRN+N0BntZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538486; c=relaxed/simple;
	bh=j9RlWiCV98maWH46GH8LQqP9KXOBrIEnE2eMblguIA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+tvnrYB/Ule2rCxkAcLjPZOUeTQ58gcnjMtCBmS3g89szMnyAjmxyP7cK1NLwj4U1zkTBMShPt8y0Ucmhz/18epMt9H+3HGAFOmjQRV+hP/tO/3ot/B+Qou2jP+jlTuPgAwzbp/orcS7b9m88bdmIYLnQFvjBJNx95V5ztsPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRCXz/JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC2AC4AF09;
	Tue, 13 Aug 2024 08:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538486;
	bh=j9RlWiCV98maWH46GH8LQqP9KXOBrIEnE2eMblguIA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tRCXz/JP3Ty7JtZpW73rKxJ1lhhYk9Ol1Cmy9UFewuVw/ovD7dnyJn3Fbc0FM9JyH
	 mbyqFfGvvltrcRIkhc4Kqz8hdrpnbnVVrP2SWs7vG5U6rft8AnC4LlOKPQGi5ClCVH
	 3Mn+kEiwvynvpeD3qsCqqNS3lbmOLEQg0BQgJID9O7ZBmqUXu/9Ptl/7Ocu0ngA7bQ
	 AxxymPJxLhXJdFG2aFdsZZLVsIwDpMKZsq9uEsIf4ZtIkaZnzsGRiYyyQzOnk/d8WL
	 eoFkQ512SDtJmPOshzJRwq8BO4kzCBEv+6GJFUI/d80irjxb7cVWmkqi+WJHy3Gh2y
	 VvTRBPTeO0Y5Q==
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
Subject: [PATCH v6 05/21] mm/zsmalloc: convert obj_malloc() to use zpdesc
Date: Tue, 13 Aug 2024 16:45:51 +0800
Message-ID: <20240813084611.4122571-6-alexs@kernel.org>
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

Use get_first_zpdesc/get_next_zpdesc to replace
get_first_page/get_next_page. no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 384a5ba49788..7421d7678880 100644
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


