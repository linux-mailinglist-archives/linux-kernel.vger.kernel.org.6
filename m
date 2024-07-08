Return-Path: <linux-kernel+bounces-243893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862C929C31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395131C20C86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D7C2230F;
	Mon,  8 Jul 2024 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+9GU7+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D891F94D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420140; cv=none; b=hSWEnibX4AYGLLfNWo7RCFhB7XNXm6tZTheMPFvpDSkJGmfy++EY7QFYBcEuN+u2EgcqSt81r1phRhDby1fQZ19mwiehT2rQ/M5lTiIEVHkc6wNtdDZGnld8w8q3TcCmqEYXNujRZvEdL7zuH8wbTqJeB3EseTB0rLSgq7T31PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420140; c=relaxed/simple;
	bh=Kaf63ckMzfd8JfdGDWbfHAhpNFgdzACIKJu7j9bsBGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SingpfeVkfsB5M3STCIPUv9DWPXDpOTzC35D6MHFFJyUEZiYXRw6209lhJgVd6iVUWxe5plcOeS8461ZWxr4tVPo2B2Rbg1M7GhRrYBVoyuzh4kpC896o76TatFHd/z7jTILOeSJ5IuXRIaMP8I1z5aI/1OFJqrJR+HH9p19Ljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+9GU7+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9ABC116B1;
	Mon,  8 Jul 2024 06:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420139;
	bh=Kaf63ckMzfd8JfdGDWbfHAhpNFgdzACIKJu7j9bsBGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+9GU7+OFriAgyhewgBuS4MpJ13g2HtbEpGw2kuHmhxZGAFHfZrMhm5wfrLZt6eSu
	 MF2wyNfgAdjMs9E8qq5ZSCV9PMJAr4/A1OaqAx8uKJabfBUQR38cugW/jaeyMk42rK
	 RQMEpRHjPzDEPwQrXf+OZ6N9tpRgoJRDv++LCDOZxvLEdvf+FMPtlmENm8JmLvLO6a
	 +/RnpebZBStyMYM1IHwbCJKZpxkRFUUEpCMF/DK5JHekR4mjFG/ANV615+EmvR0SLR
	 OXmgjPJq0yh2NRtIZKeP5dQYB1AQ/luVVGcKmwcAKJT4Lg43bXs4RbfPa+gouK3IQm
	 ul+eMziT36sgg==
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
Subject: [PATCH v3 05/20] mm/zsmalloc: convert obj_malloc() to use zpdesc
Date: Mon,  8 Jul 2024 14:33:26 +0800
Message-ID: <20240708063344.1096626-6-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
References: <20240708063344.1096626-1-alexs@kernel.org>
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
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
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


