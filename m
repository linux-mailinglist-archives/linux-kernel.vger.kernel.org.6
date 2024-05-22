Return-Path: <linux-kernel+bounces-186707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDE08CC7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC91C20E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5C146A78;
	Wed, 22 May 2024 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7hw2T1l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6777CF30
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411832; cv=none; b=Q6+HfNW933qcBVcZHtRNNwRw5HcyENBPzwCqiZjoUiGX1Fs8lfQbe+JssWLHDv8AVMGRV4dOwgc6tsl3/kXtPn42bxcQclPU87IEN9DLWxX8GVEixGNDQaPys0KhvqGac06ItE0Gtk92hpYKa9LuYciyFCsHuOPD3eKVmnJm62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411832; c=relaxed/simple;
	bh=yHbV7bClt89198/dDEq89L+L/KeiofrkagrD4RuOaeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkCts/2qOHmJhQtCbn4lhJ1ijH7TYTH9Jc8gILPe9W9iWkEStAyIc8/UlDxK1ecWyZxlZfXPUzBvWt3N0vvvXccMIQPpLXs84ewublWGR/7g0S4E99J6FR/HmTb5toObeTxFC3mFNMdcjvvzm6V4E2ZiEJbconkFNtADdFb9KIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7hw2T1l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716411830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02LYfptPkP3NVWI/Y1/skwE/AqJ4JQacKiY+62xb+tg=;
	b=S7hw2T1lzXSjzjaAOfJSljMeC3dixA0KUyjXQWYPIRZeoi/7HQWyq7BHAHkCnf0o1Ca0Lu
	igQ/yzmFhyDkaGcE+uP+P8UrG6n2mkh3bQhB9KVZqfdSr73XL45XPiq4p2w8LGpCjhmsOs
	gFwfVJYytBXsiyEshoH8djsd+KqrxM4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-cKasN1UEODSQMPyfVtjrrA-1; Wed,
 22 May 2024 17:03:48 -0400
X-MC-Unique: cKasN1UEODSQMPyfVtjrrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC5A729AA3B8;
	Wed, 22 May 2024 21:03:47 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61F1F28E2;
	Wed, 22 May 2024 21:03:45 +0000 (UTC)
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
Subject: [PATCH RFC 1/6] mm: update _mapcount and page_type documentation
Date: Wed, 22 May 2024 23:03:36 +0200
Message-ID: <20240522210341.1030552-2-david@redhat.com>
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

Let's make it clearer that _mapcount must no longer be used for own
purposes, and how _mapcount and page_type behaves nowadays (also in the
context of hugetlb folios, which are typed folios that will be mapped
to user space).

Move the documentation regarding "-1" over from page_mapcount_reset(),
which we will remove next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       |  5 -----
 include/linux/mm_types.h | 24 +++++++++++++++---------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..018e7c0265ca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1206,11 +1206,6 @@ static inline int folio_entire_mapcount(const struct folio *folio)
 	return atomic_read(&folio->_entire_mapcount) + 1;
 }
 
-/*
- * The atomic page->_mapcount, starts from -1: so that transitions
- * both from it and to it can be tracked, using atomic_inc_and_test
- * and atomic_add_negative(-1).
- */
 static inline void page_mapcount_reset(struct page *page)
 {
 	atomic_set(&(page)->_mapcount, -1);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 24323c7d0bd4..532a3030405d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -46,9 +46,7 @@ struct mem_cgroup;
  * which is guaranteed to be aligned.  If you use the same storage as
  * page->mapping, you must restore it to NULL before freeing the page.
  *
- * If your page will not be mapped to userspace, you can also use the four
- * bytes in the mapcount union, but you must call page_mapcount_reset()
- * before freeing it.
+ * The mapcount field must not be used for own purposes.
  *
  * If you want to use the refcount field, it must be used in such a way
  * that other CPUs temporarily incrementing and then decrementing the
@@ -152,16 +150,24 @@ struct page {
 
 	union {		/* This union is 4 bytes in size. */
 		/*
-		 * If the page can be mapped to userspace, encodes the number
-		 * of times this page is referenced by a page table.
+		 * For pages part of non-typed folios for which mappings are
+		 * tracked via the RMAP, encodes the number of times this page
+		 * is directly referenced by a page table.
+		 *
+		 * Note that the mapcount is always initialized to -1, so that
+		 * transitions both from it and to it can be tracked, using
+		 * atomic_inc_and_test() and atomic_add_negative(-1).
 		 */
 		atomic_t _mapcount;
 
 		/*
-		 * If the page is neither PageSlab nor mappable to userspace,
-		 * the value stored here may help determine what this page
-		 * is used for.  See page-flags.h for a list of page types
-		 * which are currently stored here.
+		 * For head pages of typed folios, the value stored here
+		 * allows for determining what this page is used for. The
+		 * tail pages of typed folios will not store a type
+		 * (mapcount == -1).
+		 *
+		 * See page-flags.h for a list of page types which are currently
+		 * stored here.
 		 */
 		unsigned int page_type;
 	};
-- 
2.45.0


