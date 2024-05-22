Return-Path: <linux-kernel+bounces-186712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB78CC7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA17BB2193D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1AD14830E;
	Wed, 22 May 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhsJd9Qb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E706146D46
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411853; cv=none; b=PQHVKPJZRWGIVaH2cscB4H4uk3+tus6CSS9r5hFvkxKYhtRRBwLE4VD6CuGGMMzO43iVhEXE45RPGQ0FbyXX2BuevQqG5grpU+iliv/W0l8sOWNj+YK938Vb3sSHhxDkwXXMvCFiEsHCYIl2oa5RcSKrZ/jfFvdS7hqxq4Wq+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411853; c=relaxed/simple;
	bh=2+I4E7+1vmTeq+NzomJw1rLPkZCo+eWCc5UNkyJyVFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX/oMRJ83YD4L1MxVsSoQg8s/iryLposDP8Rhd3a8A5kdLPOXdiXfjvQYfYKMxelIMu5ScxofThL6UAMJuvrP+4fRz4PI27tb9iJg1+Z7szUHdL9bXqbsEDydfv86v8Dctm1i895LB/7i+zYWkeS6TApWw1SopfpQTPiycD2Hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhsJd9Qb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716411850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bs73/DhQAjKCEOqgI5WjSruY0e+O/eQEazhESJihTfc=;
	b=LhsJd9QbkCpmzUyoTqYWnVRq1BtoeiUn1vI6cDCN2pN0DrCXLZP/nZ6HDwzWzPGULu22XI
	kHPPh3ZZbbZJWNW62Y/x4Z30oPpmfT1vJcYr7vTbA+5/m3W7ocr6bFFYMWaTceSAxbSaMX
	1QrsoPLy1hdt1UXGu6LNGilq6wEZSLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-HtzN_wyHOzWPGa337eP5gw-1; Wed, 22 May 2024 17:03:50 -0400
X-MC-Unique: HtzN_wyHOzWPGa337eP5gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B0D6185A78E;
	Wed, 22 May 2024 21:03:50 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2949B7414;
	Wed, 22 May 2024 21:03:47 +0000 (UTC)
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
Subject: [PATCH RFC 2/6] mm: allow reuse of the lower 16bit of the page type with an actual type
Date: Wed, 22 May 2024 23:03:37 +0200
Message-ID: <20240522210341.1030552-3-david@redhat.com>
In-Reply-To: <20240522210341.1030552-1-david@redhat.com>
References: <20240522210341.1030552-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

As long as the owner sets a page type first, we can allow reuse of the
lower 16bit! Restrict it to the head page.

We'll use that for zsmalloc next, to set a proper type while still
reusing that field to store information that cannot go elsewhere for
now.

Fear of running out of bits for storing the actual type? Actually, we
don't need one bit per type, we could store a single value instead.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h   |  5 +++++
 include/linux/page-flags.h | 22 ++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 532a3030405d..6dae8e15037b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -168,6 +168,11 @@ struct page {
 		 *
 		 * See page-flags.h for a list of page types which are currently
 		 * stored here.
+		 *
+		 * Owners of typed folios may reuse the lower 16bit of the
+		 * head page page_type field after setting the page type,
+		 * but must reset these 16 bit to -1 before clearing the
+		 * page type.
 		 */
 		unsigned int page_type;
 	};
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 104078afe0b1..ed9ac4b5233d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -942,17 +942,23 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
  * __ClearPageFoo *sets* the bit used for PageFoo.  We reserve a few high and
  * low bits so that an underflow or overflow of _mapcount won't be
  * mistaken for a page type value.
+ *
+ * The highest bit must always be 1, to make page_has_type() work as expected.
  */
 
 #define PAGE_TYPE_BASE	0xf0000000
-/* Reserve		0x0000007f to catch underflows of _mapcount */
-#define PAGE_MAPCOUNT_RESERVE	-128
-#define PG_buddy	0x00000080
-#define PG_offline	0x00000100
-#define PG_table	0x00000200
-#define PG_guard	0x00000400
-#define PG_hugetlb	0x00000800
-#define PG_slab		0x00001000
+/*
+ * Reserve		0x0000ffff to catch underflows of _mapcount and
+ * allow owners that set a type to reuse the lower 16 bit for their own
+ * purposes.
+ */
+#define PAGE_MAPCOUNT_RESERVE	-65536
+#define PG_buddy	0x00010080
+#define PG_offline	0x00020000
+#define PG_table	0x00040000
+#define PG_guard	0x00080000
+#define PG_hugetlb	0x00100800
+#define PG_slab		0x00200000
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-- 
2.45.0


