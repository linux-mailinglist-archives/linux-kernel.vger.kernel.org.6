Return-Path: <linux-kernel+bounces-233292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E4F91B53F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286331F21FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E4B47A60;
	Fri, 28 Jun 2024 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLwz/ccg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854D46453
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544028; cv=none; b=KeiSrJoIeAhupPFSAlJWHSeaLIn9VxVELZlulgCTkG6chjIOrjfhFnipDLQl+LajXauIk+Wq0mNEmpLyAxei6lHfg0k/UBynAXfjD/hUOKFx1Zkogkd4Nc6fOQHdbXQGYlnQoZ/bGh11wCReS8r8rPCvKW/ixqK9wt39AGC0GsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544028; c=relaxed/simple;
	bh=XjQFvUcS1LHsRYGu9jnBiByPT0wYykOdlBmIkN2FtBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4FRovMSYZXr/0X41VM3nL/ghdWdyQnesgZy44ghrpO8LvwCTVzq5AaTxyDnLiZt2JCVJZ/Y6ownDDXSx75R4eBlrC0CLwKIUeDTP9eiAgDhhB1k1PF+TSmBjsDDf1mIGm7Cq/0UVy2pXM+8+tAb++c+2p5hVAgeTDhOshFYukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLwz/ccg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB16C4AF0D;
	Fri, 28 Jun 2024 03:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544027;
	bh=XjQFvUcS1LHsRYGu9jnBiByPT0wYykOdlBmIkN2FtBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLwz/ccgEUbpiJOrFdS0JKWIACGuXo9B+lq1ll4r21yihrI4awNMbyxM+XE5ayHG3
	 XmK0O9G0zjrm7ibjLcKlK7WBFSzMn2Gj8217qv2X5CDFdM/u9I3EbeRkl+JrtaKfhk
	 fQ6Wq3h+qXPYeahBSmHYSfSArtmajGSvBL7BsbIMmiX7e2BxiJFzWn5ngTydX03V+G
	 LktDfp1xBOQ/s1nuxJRcdFMD2B//pwJQcQlM4wn4D+o3HzI8hd6yKYVAbQ7DLK6KOs
	 dKisWok1zVs65YDd7PhvkNMpwpefhHE0rYPzWAo64qeHnYsA5F9AxbF+bN17yxu3iJ
	 +IwgjYNBRM6JA==
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
Subject: [PATCH 05/20] mm/zsmalloc: convert obj_malloc() to use zpdesc
Date: Fri, 28 Jun 2024 11:11:20 +0800
Message-ID: <20240628031138.429622-6-alexs@kernel.org>
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

Use get_first_zpdesc/get_next_zpdesc to replace
get_first_page/get_next_page. no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index efb1d58b3c36..137b36515acf 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1324,12 +1324,12 @@ EXPORT_SYMBOL_GPL(zs_huge_class_size);
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
 
@@ -1338,14 +1338,14 @@ static unsigned long obj_malloc(struct zs_pool *pool,
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
@@ -1358,7 +1358,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(m_page, obj);
+	obj = location_to_obj(zpdesc_page(m_zpdesc), obj);
 
 	return obj;
 }
-- 
2.43.0


