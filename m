Return-Path: <linux-kernel+bounces-194008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629728D3557
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F67A28625E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EAF180A90;
	Wed, 29 May 2024 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6+VH6/r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73496180A6C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981561; cv=none; b=qWNN45Y0gLDstfKY68ZooHWkRQdDJYevxcbx9d9NdOhLwQAZI5UCAQg3YNJ94At1l7vtFH2ykqmkEIW0tkmKsN/hs5tY+/7uHkrbaC12hvAR8XEy217QDGCcE+jtOJf/rM/jY8gwZGtPMNfdHrAnzcFFywh2SndccNJ723h6sKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981561; c=relaxed/simple;
	bh=G8bCvqh1wqCa8uGv9DTnkX6odqXl+cfD6if2DoZ6U5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrpnpmVK7/Te6ivyWxs3MMt/yxNFSgB7f8BwCJ8COHP8FdkABklEWPmfhP2APurt+lk83Q3hCq9/k6YV1vHFenB52PZBe5IbXaYXaBV1XbxYWHycU0LPjY88LT2r8bGS8W+6jewN+pT6MTtG+u9OlcUkHjegpUE63fPdoTFqCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6+VH6/r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716981559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXRirrIvNUFDVUMts2hQOYTUr+V+4XzCDnXRbx7dYx4=;
	b=D6+VH6/rfsbp9G3uogE9uy/Aek3kjZ5/wsKcTSgBtqE+X8RAtTUehwOicGI7lESEiMfP/f
	Zwhs6L22CpZA0DVnyu0pYTMhDFgSTRp5y7AUf0+T1+ty5yaDtEIXvXAJC0auMgJ97rCJ7/
	icahycXB7CIg5HqNk5ZkgZY5CZyD6fg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-I5NU4P9fO96nrEfFJX_p9Q-1; Wed,
 29 May 2024 07:19:16 -0400
X-MC-Unique: I5NU4P9fO96nrEfFJX_p9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EDCE1C0512D;
	Wed, 29 May 2024 11:19:15 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1F68C15BB9;
	Wed, 29 May 2024 11:19:13 +0000 (UTC)
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
Subject: [PATCH v2 4/6] mm/page_alloc: clear PageBuddy using __ClearPageBuddy() for bad pages
Date: Wed, 29 May 2024 13:19:02 +0200
Message-ID: <20240529111904.2069608-5-david@redhat.com>
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

Let's stop using page_mapcount_reset() and clear PageBuddy using
__ClearPageBuddy() instead.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b1e3eb5787de1..591d28b9f3e48 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -498,7 +498,8 @@ static void bad_page(struct page *page, const char *reason)
 	dump_stack();
 out:
 	/* Leave bad fields for debug, except PageBuddy could make trouble */
-	page_mapcount_reset(page); /* remove PageBuddy */
+	if (PageBuddy(page))
+		__ClearPageBuddy(page);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
@@ -1346,7 +1347,8 @@ static void check_new_page_bad(struct page *page)
 {
 	if (unlikely(page->flags & __PG_HWPOISON)) {
 		/* Don't complain about hwpoisoned pages */
-		page_mapcount_reset(page); /* remove PageBuddy */
+		if (PageBuddy(page))
+			__ClearPageBuddy(page);
 		return;
 	}
 
-- 
2.45.1


