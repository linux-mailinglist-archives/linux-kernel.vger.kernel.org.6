Return-Path: <linux-kernel+bounces-190860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F38D039A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0CF1F25691
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658317F371;
	Mon, 27 May 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaxaNOqm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E004163A97
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819309; cv=none; b=epwiv6CIsRPb8ELoO2f/4wbnp6cogSPsLOl15ZyUgicRx9ej+a0znKxKN9NzHvmSO4Fvo3RTvW1EjswxHKQ0WoN52fQ7P/BTfLrnctwYSdhKBINn4hzT88MkqaqFWkrJ9YqhtAgFwF0XLJyzDWhKUALlYc9Go25JfFUP0HLkJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819309; c=relaxed/simple;
	bh=z4n3mZWA/a7cnUz8UErNnCGa/NYYJfT1fQxIgQIa0q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a49XOEtpWnYrCSGphOqTnGqMvOpPghzw9+ZsGndygqCCO9OWYotkGaKcSjb3koxbuhMtDxk2Kl5w170cqoKgt3AAJHh1cUl8i4phaknkD0xXpZax/ma0dlTJWVQAkpmHpEM/WG3zktD8YLoeTkkG+PehNfqlnXcnDkSC6BpY6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaxaNOqm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716819307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fI7k3N6P8qJ4FuS4bDw6lNsnGteHRLAJN+b2iNRt+tE=;
	b=BaxaNOqmFo4OQwCw2NeWbk9DVC18uQoXni/tWetHd254iaayZ7RoZI62L8okNMoRjUyt0S
	DR8nqaKRUWFudK3n7sKN1QzTrXVog5W1O+WFCqw4nDDixreKf1cQ93mEYQJWuj0Vtsydc6
	1uvHW1u9I0Uq30pOk5etSu79NSs3tug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-kXZuQwgiNe2ZxgXhztVTPw-1; Mon, 27 May 2024 10:15:03 -0400
X-MC-Unique: kXZuQwgiNe2ZxgXhztVTPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA8BD8029E1;
	Mon, 27 May 2024 14:15:02 +0000 (UTC)
Received: from t490s.redhat.com (unknown [10.39.192.209])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0613A1C0654B;
	Mon, 27 May 2024 14:15:00 +0000 (UTC)
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
Subject: [PATCH v1 1/6] mm: update _mapcount and page_type documentation
Date: Mon, 27 May 2024 16:14:49 +0200
Message-ID: <20240527141454.113132-2-david@redhat.com>
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

Let's make it clearer that _mapcount must no longer be used for own
purposes, and how _mapcount and page_type behaves nowadays (also in the
context of hugetlb folios, which are typed folios that will be mapped
to user space).

Move the documentation regarding "-1" over from page_mapcount_reset(),
which we will remove next. Move "page_type" before "mapcount", to make
it clearer what typed folios are.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       |  5 -----
 include/linux/mm_types.h | 28 +++++++++++++++++-----------
 2 files changed, 17 insertions(+), 16 deletions(-)

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
index 24323c7d0bd4..6b2aeba792c4 100644
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
@@ -152,18 +150,26 @@ struct page {
 
 	union {		/* This union is 4 bytes in size. */
 		/*
-		 * If the page can be mapped to userspace, encodes the number
-		 * of times this page is referenced by a page table.
+		 * For head pages of typed folios, the value stored here
+		 * allows for determining what this page is used for. The
+		 * tail pages of typed folios will not store a type
+		 * (mapcount == -1).
+		 *
+		 * See page-flags.h for a list of page types which are currently
+		 * stored here.
 		 */
-		atomic_t _mapcount;
+		unsigned int page_type;
 
 		/*
-		 * If the page is neither PageSlab nor mappable to userspace,
-		 * the value stored here may help determine what this page
-		 * is used for.  See page-flags.h for a list of page types
-		 * which are currently stored here.
+		 * For pages that are part of non-typed folios for which mappings
+		 * are tracked via the RMAP, encodes the number of times this page
+		 * is directly referenced by a page table.
+		 *
+		 * Note that the mapcount is always initialized to -1, so that
+		 * transitions both from it and to it can be tracked, using
+		 * atomic_inc_and_test() and atomic_add_negative(-1).
 		 */
-		unsigned int page_type;
+		atomic_t _mapcount;
 	};
 
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
-- 
2.45.1


