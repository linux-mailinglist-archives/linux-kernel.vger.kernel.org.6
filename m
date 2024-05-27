Return-Path: <linux-kernel+bounces-190864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E088D03A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AAD1F24C52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2B1802D0;
	Mon, 27 May 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c17uarff"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A817F36B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819315; cv=none; b=h4MOUcfgk6IUMuvz7cGeWp1Z0fVeIGfK4WmhPxbLbmIdBQi51MePwiS1wQGw5Z8Ta3Gdga1aT2GmptIkZKgZB43MQm9GEWUV/9P9THnblPv7eq8fO1oSUKvCA7Bl4DA6wGtE+oIw4K1GJhBE0aa1g0dO1cHJTvCtL54f2SJMuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819315; c=relaxed/simple;
	bh=TuHCmrWuZwGpoZ5sT8ZAtkpr/leRSP9V4NWCvIzzY08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWkOO+WUgrV4h4cShbn2EuucPxkMpVzL1e+QS3PAMj++zTm28/CzWotMhIHtGvbn8OdZE55bGvCYxxtqzyVpBko9wAk3AmJaPiXzPioha9Gasy/Q12nS5bSckEcTF2KzToBLiao+ONgLfgNcKz6mtPXQGZzoVUrcS09VvYRFmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c17uarff; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716819309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cG/bHQ4quJa6Sy8Ny8W5KhH3qb/Pwqg5bjhVWAnFcjs=;
	b=c17uarffuFCXg/QqNYa2aTjQCM+LpsSymliHHPxZ9jLcJ0r5qokrTTH7xldI/Tv/AvXLIQ
	gnKsFHWGPvJ/thgIwfpBFpdhQ3yAk8zBul2GvdfrVo5eQjmyDLghIUIOynm2496HUu9/MT
	hsWTgkvm2LrehG6ruDU5ll1dgcUu2d4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-eU3y4psHO9CVn5thPdziNg-1; Mon,
 27 May 2024 10:15:05 -0400
X-MC-Unique: eU3y4psHO9CVn5thPdziNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3E611C0512D;
	Mon, 27 May 2024 14:15:04 +0000 (UTC)
Received: from t490s.redhat.com (unknown [10.39.192.209])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 39E141C00047;
	Mon, 27 May 2024 14:15:02 +0000 (UTC)
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
Subject: [PATCH v1 2/6] mm: allow reuse of the lower 16 bit of the page type with an actual type
Date: Mon, 27 May 2024 16:14:50 +0200
Message-ID: <20240527141454.113132-3-david@redhat.com>
In-Reply-To: <20240527141454.113132-1-david@redhat.com>
References: <20240527141454.113132-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

As long as the owner sets a page type first, we can allow reuse of the
lower 18 bit: sufficient to store an offset into a 64 KiB page, which
is the maximum base page size in *common* configurations (ignoring the
256 KiB variant). Restrict it to the head page.

We'll use that for zsmalloc next, to set a proper type while still
reusing that field to store information (offset into a base page) that
cannot go elsewhere for now.

Fear of running out of bits for storing the actual type? Actually, we
don't need one bit per type, we could store a single value instead.
Further, we could likely limit PAGE_TYPE_BASE to a single (highest) bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h   |  5 +++++
 include/linux/page-flags.h | 20 ++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6b2aeba792c4..598cfedbbfa0 100644
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
index 104078afe0b1..b43e380ffa0b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -945,14 +945,18 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
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
+#define PG_buddy	0x00010000
+#define PG_offline	0x00020000
+#define PG_table	0x00040000
+#define PG_guard	0x00080000
+#define PG_hugetlb	0x00100800
+#define PG_slab		0x00200000
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-- 
2.45.1


