Return-Path: <linux-kernel+bounces-190869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29078D03AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96961F24DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7940F181B9E;
	Mon, 27 May 2024 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk3lnNgz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1A18132B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819321; cv=none; b=oFr+y5bKSb+KPuY0jm7hSM5yWXhzGSAkGL6o2c8v+THw5eXBJBzWwE95N+eTt4odUB4wxdKLli9GNPHMxaIFWQVsZSx1M02nx1u+aoHyuHMOy2lirQI1uVOHqwxHDhJPRZmxhx4o3BIPv8AeQbEhh+hrMy3UghuQDBvgOc5MGjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819321; c=relaxed/simple;
	bh=8Uht8mV/4dL4gv3aNLttf2N6V942DMpHiSEPnfGBnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXTmmTfy+g3w6k20P00x3krR3IVJEK6o4uEA0iHCGIpq4iYfhztjaU8m1OEHesW2GPbyiCq9X75mTdRKT7kyhwnSJ7upgRwk9DlkpOacPaeTYZe5Dt830uUTG9zvVgGTWqmVd2Ms4A4erAOsdvP2vMe9JJOBW00MOtF/6X3U0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pk3lnNgz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716819319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvfl7fozsgrYXK/cOQK4fr4wIb0TzpdI/FqNXmQZaNc=;
	b=Pk3lnNgzuk5QsbvzvJweLCkT+dR+n7wLv5hG3T+yzmu/pdJkRJz7Zw+z6eSOPZw3kB5VeT
	r5AYaA02/sBt5R79eJHLmPzfHWhmcBzxQ2JijeLuWkcbYWEJFY1xymu1mvcpCWICL8jSzy
	KTDv13o7i8+V/beaswYxVeMJpqy1y4Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-fSndykL4PXGFfJJtu-ZbSQ-1; Mon, 27 May 2024 10:15:14 -0400
X-MC-Unique: fSndykL4PXGFfJJtu-ZbSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E79A8058D1;
	Mon, 27 May 2024 14:15:14 +0000 (UTC)
Received: from t490s.redhat.com (unknown [10.39.192.209])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A1631C00047;
	Mon, 27 May 2024 14:15:11 +0000 (UTC)
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
Subject: [PATCH v1 6/6] mm/mm_init: initialize page->_mapcount directly in __init_single_page()
Date: Mon, 27 May 2024 16:14:54 +0200
Message-ID: <20240527141454.113132-7-david@redhat.com>
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

Let's simply reinitialize the page->_mapcount directly. We can now
get rid of page_mapcount_reset().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 5 -----
 mm/mm_init.c       | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

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
2.45.1


