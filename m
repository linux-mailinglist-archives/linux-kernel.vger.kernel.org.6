Return-Path: <linux-kernel+bounces-186711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DFE8CC7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2041C20E84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3517146A8C;
	Wed, 22 May 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4cb8Ppd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3921482F2
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411848; cv=none; b=JYQaMw60jGakkyVdWhXCH+my4JNnRip/uvwgfYzAoHZH2RGedqBj0dIN2IBDzBPEa2yWulD9UmWLbIF15WF+YetPh2qJK9rzLZVvTWFwnPV3GHTOjlSkUCG/eOetvKtSPlI88Px+eFCWxibSeO+01Dx0TaOeBN7/IS+wb2K2gpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411848; c=relaxed/simple;
	bh=VREeDSWzeQL6HFzOo4DCIAgPmrdV23oWLwOUQziKCX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H300EcYEwJx4iWH+qz64QW8ScmFMTl5hSmr7NVksOl39whqA/rq8sFCZZ3i9EmfBHiJu0eFCV9E7fm6ggBVLxbMxnsZpSV4C/c5ttju3dFgl37xNTXqBJde7+191ap2PBvDVAFZqMjmkTlMCVb50+NKVYnmEGPXgqhwC/J6F+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4cb8Ppd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716411845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNNk1s4j6/1176F8MI21H7X7UFnb72xKHXVGsllS3eQ=;
	b=O4cb8Ppd/DC99x9KdH6ni1RdJOrw6k1pX6mdgQ/C5zAEODPlYObkpIHyCWqHp72YthmaDJ
	H+pQOrdw1Ud5lCxw4TNu57CXi5IdPGE6auCl69KwY3HG8DNeMz6epHdlGkirBBQ4Traq/f
	zMBRgCGydYo4w+PFItRf0gGZfgeuL0w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ye0R7uQTPwaFaQc8HubRsQ-1; Wed, 22 May 2024 17:04:02 -0400
X-MC-Unique: ye0R7uQTPwaFaQc8HubRsQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A68A680118E;
	Wed, 22 May 2024 21:04:00 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 315BF28E3;
	Wed, 22 May 2024 21:03:58 +0000 (UTC)
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
Subject: [PATCH RFC 6/6] mm/mm_init: initialize page->_mapcount directly in__init_single_page()
Date: Wed, 22 May 2024 23:03:41 +0200
Message-ID: <20240522210341.1030552-7-david@redhat.com>
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

Let's simply reinitialize the page->_mapcount directly. We can now
get rid of page_mapcount_reset().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       | 5 -----
 include/linux/mm_types.h | 2 +-
 mm/mm_init.c             | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 018e7c0265ca..3e1d3b0d545e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1206,11 +1206,6 @@ static inline int folio_entire_mapcount(const struct folio *folio)
 	return atomic_read(&folio->_entire_mapcount) + 1;
 }
 
-static inline void page_mapcount_reset(struct page *page)
-{
-	atomic_set(&(page)->_mapcount, -1);
-}
-
 /**
  * page_mapcount() - Number of times this precise page is mapped.
  * @page: The page.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6dae8e15037b..c377c040f87d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -169,7 +169,7 @@ struct page {
 		 * See page-flags.h for a list of page types which are currently
 		 * stored here.
 		 *
-		 * Owners of typed folios may reuse the lower 16bit of the
+		 * Owners of typed folios may reuse the lower 16 bit of the
 		 * head page page_type field after setting the page type,
 		 * but must reset these 16 bit to -1 before clearing the
 		 * page type.
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f72b852bd5b8..b4916751edce 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -568,7 +568,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
-	page_mapcount_reset(page);
+	atomic_set(&page->_mapcount, -1);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
 
-- 
2.45.0


