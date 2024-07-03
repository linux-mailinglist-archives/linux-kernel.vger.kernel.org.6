Return-Path: <linux-kernel+bounces-238810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E969250FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EBA5B2C4AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C0813775C;
	Wed,  3 Jul 2024 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygl1r0eG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461713D88D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979288; cv=none; b=AmprXsSIPGog62Z/7wsh6KD1BCgc3sSleZAtNYRWo8RSYS/G02p39dWabLOKK4Rq3XbE7SJ1D13eOlbexhdzw7LflhArNikh+MaDQeDoWXnwCQmuzbueemhXotSBW2KHuEU55K4mgQS30Qe6TrtZQ1CPItO64+agVwKIeH7m13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979288; c=relaxed/simple;
	bh=OUw0L1+EEkxStexhrY6FwqktPPZ5HwiknqjqfzU6PXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+uakoV44hfjSeVNRG4ol7IXRX3um7foebtV2OgJlKg4Z21lCRqH46jVMnoLeCi7ElFnLQJYQdoBsz6GuyyqxKAELsBkfqEhTAFKCDShyyip8ux8/PLsfRrRgXwzjHb7lbzFI0+4PM5FQ8MpTki1RR/WuXQtaDhtIKvD6WqNi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygl1r0eG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69877C4AF0E;
	Wed,  3 Jul 2024 04:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979287;
	bh=OUw0L1+EEkxStexhrY6FwqktPPZ5HwiknqjqfzU6PXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ygl1r0eGWf9A8ASCCyxxwaRcR/wNniNavWp/6Cp1Fb7i1Ie3OgUnLu+kb/x83qU4R
	 Rtf1OTjVxaWrDtnC9EgWP60cL+fwY6UmOlhSy0g4md3TDCs0I58Xpeo2fYMQQIC7oa
	 mWGA7aDYGYwcXPiw7U3+CqO0HQFqXZbuFcR1HrgtLk0mCgqKSqgQeVqgpEC7iJDFyx
	 Q4W+t234bRMiEvLqUICPWSBBwtKPv/pZtcYWjGAGrHvheKJd7nLq5kdFh/6V+jbw9b
	 EBrXUKpPCHP3lHr26GXnoTiIoogZTVS7XgIzHuJjYkhr/Qv66r8sBvtyhi/jVwGPTl
	 5r1Wts9gy5n2w==
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
Subject: [PATCH v2 05/20] mm/zsmalloc: convert obj_malloc() to use zpdesc
Date: Wed,  3 Jul 2024 12:05:55 +0800
Message-ID: <20240703040613.681396-6-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703040613.681396-1-alexs@kernel.org>
References: <20240703040613.681396-1-alexs@kernel.org>
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


