Return-Path: <linux-kernel+bounces-307348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D167964C43
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6968B23FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066A1B6533;
	Thu, 29 Aug 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQl1Jd7M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAA1B6544
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950639; cv=none; b=EFjLa3hFbOUT1PguOkpGdOlQBdP0wOu2uwHb15Fe19n54i24sHEOXWECJu2txUopgF9Sj2vvAFOiGkxx/OL9+bjKOfOGIpWkdEOJo3FkFoLawpwoMilAoY8FXCJbMtfH0oyRaVK/w1WdRKYadTkCyyNSTSAvvfW7Rq4aQeiDiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950639; c=relaxed/simple;
	bh=8+9llz8sONFJSvcYrwkIc951NwGN6B5PLjuzJF6J33I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuOG33DtRhzrpTFrDYAL8+2mzhmACkdjY1+Lrnj+bHdsrqUiEFIV68YGrVY/FxOwpK1KV8cJwnhJwSVsGShLGRYcdOQbdRt3w7KJPWo86SvPW3OsKsuPG1KOkanyQzZreKbZliSPe0ATUaSTJDIOaP+FesIeKy6H1ROOOJ9PnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQl1Jd7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJMXjWc4+IBsQZT+SpDHJ06KBG+eQaVO9mpec+pSrAQ=;
	b=GQl1Jd7McO5TObl9RlNHeWoKp8aNhMTI+iP8KKXc0WuFiK2aIMGbTWBK1UaXNFAD/otGTa
	/oEABkQPKMG10bH6P7ryT0H3LqMdQUeKIWW26VIlCldbLP7aS1vTENz78kh9H5vLiIgx71
	eljxBmyRsg5X8Z0+yJXVrgUYwOnLz3s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-deQlVP0ONhqTZhWhlLdllw-1; Thu,
 29 Aug 2024 12:57:11 -0400
X-MC-Unique: deQlVP0ONhqTZhWhlLdllw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36A261954B00;
	Thu, 29 Aug 2024 16:57:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E03F91955F66;
	Thu, 29 Aug 2024 16:56:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 02/17] mm: factor out large folio handling from folio_nr_pages() into folio_large_nr_pages()
Date: Thu, 29 Aug 2024 18:56:05 +0200
Message-ID: <20240829165627.2256514-3-david@redhat.com>
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
References: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

Make use of it in internal.h and mm.h, where applicable.

While at it, let's consistently return a "long" value from all these
similar functions. Note that we cannot use "unsigned int" (even though
_folio_nr_pages is of that type), because it would break some callers
that do stuff like "-folio_nr_pages()". Both "int" or "unsigned long"
would work as well.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 27 ++++++++++++++-------------
 mm/internal.h      |  2 +-
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3c6270f87bdc3..fa8b6ce54235c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1076,6 +1076,15 @@ static inline unsigned int folio_large_order(const struct folio *folio)
 	return folio->_flags_1 & 0xff;
 }
 
+static inline long folio_large_nr_pages(const struct folio *folio)
+{
+#ifdef CONFIG_64BIT
+	return folio->_folio_nr_pages;
+#else
+	return 1L << folio_large_order(folio);
+#endif
+}
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -2037,11 +2046,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << folio_large_order(folio);
-#endif
+	return folio_large_nr_pages(folio);
 }
 
 /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
@@ -2056,24 +2061,20 @@ static inline long folio_nr_pages(const struct folio *folio)
  * page.  compound_nr() can be called on a tail page, and is defined to
  * return 1 in that case.
  */
-static inline unsigned long compound_nr(struct page *page)
+static inline long compound_nr(struct page *page)
 {
 	struct folio *folio = (struct folio *)page;
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << folio_large_order(folio);
-#endif
+	return folio_large_nr_pages(folio);
 }
 
 /**
  * thp_nr_pages - The number of regular pages in this huge page.
  * @page: The head page of a huge page.
  */
-static inline int thp_nr_pages(struct page *page)
+static inline long thp_nr_pages(struct page *page)
 {
 	return folio_nr_pages((struct folio *)page);
 }
@@ -2183,7 +2184,7 @@ static inline bool folio_likely_mapped_shared(struct folio *folio)
 		return false;
 
 	/* If any page is mapped more than once we treat it "mapped shared". */
-	if (folio_entire_mapcount(folio) || mapcount > folio_nr_pages(folio))
+	if (folio_entire_mapcount(folio) || mapcount > folio_large_nr_pages(folio))
 		return true;
 
 	/* Let's guess based on the first subpage. */
diff --git a/mm/internal.h b/mm/internal.h
index 44c8dec1f0d75..97d6b94429ebd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -159,7 +159,7 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
 		bool *any_writable, bool *any_young, bool *any_dirty)
 {
-	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
+	unsigned long folio_end_pfn = folio_pfn(folio) + folio_large_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte, *ptep;
 	bool writable, young, dirty;
-- 
2.46.0


