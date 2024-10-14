Return-Path: <linux-kernel+bounces-363849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9899C7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D861F223EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92E19F128;
	Mon, 14 Oct 2024 10:59:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07183197A6E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903580; cv=none; b=F0XG+BvSenQtixaB41XG07usbZeshVZOJ7XqX9je7SOl+ejD58RpUhRWqwod5xzXlXAXtyKN1VawDCZuwMs0GDNFFDM3pQldygdK6xPcrKMTYuo//gvMpZEbVUyyDaFxsQykU4sBFIczL+XEVwc3gys9vX6uenJXMFNkChJN1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903580; c=relaxed/simple;
	bh=MGQfBxoaOxqaY4H/EUExAuKSVTLdBa39T9c0XT1PIBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmjP+7pkeFuamJiHlQgmipRhC7kZkN5aSGluN2XChRYnGHhZuWWd2wea6E5AUpraueHczX8fop1rhhAGIhlUO80hPk1l8MGU4YUIikoi1QJOoRYTgMYyj7jSYkjoAFBf6eUSYaHTWdEaF521zCzIwctcudcXbuos8TVX/5PY7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 405271688;
	Mon, 14 Oct 2024 04:00:08 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 403163F51B;
	Mon, 14 Oct 2024 03:59:36 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 04/57] mm/page_alloc: Make page_frag_cache boot-time page size compatible
Date: Mon, 14 Oct 2024 11:58:11 +0100
Message-ID: <20241014105912.3207374-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"struct page_frag_cache" has some optimizations that depend on page
size. Let's refactor it a bit so that those optimizations can be
determined at run-time for the case where page size is a boot-time
parameter. For compile-time page size, the compiler should dead code
strip and the result is very similar to before.

One wrinkle is that we don't know if we need the size member until
runtime. So remove the ifdeffery and always define offset as u32 (needed
if PAGE_SIZE is >= 64K) and size as u16 (only used when PAGE_SIZE <=
32K). We move the members around a bit so that the overall size of the
struct remains the same; 24 bytes for 64-bit and 16 bytes on 32 bit.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

page_alloc
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 include/linux/mm_types.h | 13 ++++++-------
 mm/page_alloc.c          | 31 ++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4854249792545..0844ed7cfaa53 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -544,16 +544,15 @@ static inline void *folio_get_private(struct folio *folio)
 
 struct page_frag_cache {
 	void * va;
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	__u16 offset;
-	__u16 size;
-#else
-	__u32 offset;
-#endif
 	/* we maintain a pagecount bias, so that we dont dirty cache line
 	 * containing page->_refcount every time we allocate a fragment.
 	 */
-	unsigned int		pagecnt_bias;
+	unsigned int pagecnt_bias;
+	__u32 offset;
+	/* size only used when PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE, in which
+	 * case PAGE_FRAG_CACHE_MAX_SIZE is 32K and 16 bits is sufficient.
+	 */
+	__u16 size;
 	bool pfmemalloc;
 };
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91ace8ca97e21..8678103b1b396 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4822,13 +4822,18 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
-		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
-				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
-#endif
+	if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) {
+		gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
+			   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
+		page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
+					PAGE_FRAG_CACHE_MAX_ORDER);
+		/*
+		 * Cast to silence warning due to 16-bit nc->size. Not real
+		 * because PAGE_SIZE only less than PAGE_FRAG_CACHE_MAX_SIZE
+		 * when PAGE_FRAG_CACHE_MAX_SIZE is 32K.
+		 */
+		nc->size = (__u16)(page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE);
+	}
 	if (unlikely(!page))
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
 
@@ -4870,10 +4875,10 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		if (!page)
 			return NULL;
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
+		if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+			size = nc->size;
+
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
@@ -4897,10 +4902,10 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 		}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
+		if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+			size = nc->size;
+
 		/* OK, page count is 0, we can safely set it */
 		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
-- 
2.43.0


