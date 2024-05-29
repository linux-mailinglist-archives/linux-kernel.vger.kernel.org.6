Return-Path: <linux-kernel+bounces-194006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB198D3555
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BDC1C224CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49E16C87F;
	Wed, 29 May 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH9Xr/a7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC617B43A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981557; cv=none; b=nuUzxS5eTtw0VCp8DzIdpxupS2MpbHL+Ofjae+f0rvC4kip9jkIR6iPY7q2eH6qzz9pBPTpvVUbvnBRWp9GfG2S2eCpFkGL/BdPirfjrlDzBP/G73qYxjf1+qPB5DY9cUNaY0CgbV5cjWqZjR2tDasbiH9+8HW1uQ4MtjEbT+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981557; c=relaxed/simple;
	bh=VvacQpudkRgTka6HEMDXAxvdAjKpN7bLGzx8y9wQUM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsXMOlkkfLdnN4qbZOvGgz8rOQNVACff3jXNyIwL1eiMbpEc9zs9N347qHNnhv6oDEgiODLNlaPeaQFoA3gOefdF/vF+134RpFZGBuRJtnr7FOwVaZYuW5rWiupmrLzGjz7AjlAoi2hj7VrWMzxnvb4g3TcZlMFqcGaDodtCEgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DH9Xr/a7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716981555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDhi0IPu97eWFC0P0dRcSpVPyCoXJ2Cz890fKbkcPeQ=;
	b=DH9Xr/a7n8eAxetVQSfasBy4xd6J3ZwLuf9asLuEQQ0RzokDxnyu4+kpuBwAgfo5qxFXkI
	2AWg5XvYiifAmecSucnslXCzu6ui7i1m4WqUs63AdLH/+kqYNf0fkft9iWHVSxms6mNjRt
	4LzRURuLCKWgi35DV9viUgmgD5RFE7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-x4msqaDFNAKN7DdXTTBhqQ-1; Wed, 29 May 2024 07:19:11 -0400
X-MC-Unique: x4msqaDFNAKN7DdXTTBhqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BC6B800169;
	Wed, 29 May 2024 11:19:11 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5868CC15BB1;
	Wed, 29 May 2024 11:19:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v2 2/6] mm: allow reuse of the lower 16 bit of the page type with an actual type
Date: Wed, 29 May 2024 13:19:00 +0200
Message-ID: <20240529111904.2069608-3-david@redhat.com>
In-Reply-To: <20240529111904.2069608-1-david@redhat.com>
References: <20240529111904.2069608-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

As long as the owner sets a page type first, we can allow reuse of the
lower 16 bit: sufficient to store an offset into a 64 KiB page, which
is the maximum base page size in *common* configurations (ignoring the
256 KiB variant). Restrict it to the head page.

We'll use that for zsmalloc next, to set a proper type while still
reusing that field to store information (offset into a base page) that
cannot go elsewhere for now.

Let's reserve the lower 16 bit for that purpose and for catching
mapcount underflows, and let's reduce PAGE_TYPE_BASE to a single bit.

Note that we will still have to overflow the mapcount quite a lot until
we would actually indicate a valid page type.

Start handing out the type bits from highest to lowest, to make it
clearer how many bits for types we have left. Out of 15 bit we can use
for types, we currently use 6. If we run out of bits before we have
better typing (e.g., memdesc), we can always investigate storing a value
instead [1].

[1] https://lore.kernel.org/all/00ba1dff-7c05-46e8-b0d9-a78ac1cfc198@redhat.com/

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h   |  5 +++++
 include/linux/page-flags.h | 22 +++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index dd2ce1b3ec80e..791afaf1b1ec3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -157,6 +157,11 @@ struct page {
 		 *
 		 * See page-flags.h for a list of page types which are currently
 		 * stored here.
+		 *
+		 * Owners of typed folios may reuse the lower 16 bit of the
+		 * head page page_type field after setting the page type,
+		 * but must reset these 16 bit to -1 before clearing the
+		 * page type.
 		 */
 		unsigned int page_type;
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d1bdbaaccc964..f060db808102c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -945,15 +945,19 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
  * mistaken for a page type value.
  */
 
-#define PAGE_TYPE_BASE	0xf0000000
-/* Reserve		0x0000007f to catch underflows of _mapcount */
-#define PAGE_MAPCOUNT_RESERVE	-128
-#define PG_buddy	0x00000080
-#define PG_offline	0x00000100
-#define PG_table	0x00000200
-#define PG_guard	0x00000400
-#define PG_hugetlb	0x00000800
-#define PG_slab		0x00001000
+#define PAGE_TYPE_BASE	0x80000000
+/*
+ * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
+ * allow owners that set a type to reuse the lower 16 bit for their own
+ * purposes.
+ */
+#define PG_buddy	0x40000000
+#define PG_offline	0x20000000
+#define PG_table	0x10000000
+#define PG_guard	0x08000000
+#define PG_hugetlb	0x04008000
+#define PG_slab		0x02000000
+#define PAGE_MAPCOUNT_RESERVE	(~0x0000ffff)
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-- 
2.45.1


