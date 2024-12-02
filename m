Return-Path: <linux-kernel+bounces-427304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608289DFF8F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C010116053C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7AB1FBCAF;
	Mon,  2 Dec 2024 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEb6KN+Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422511F9EA4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137278; cv=none; b=KIO8lcX0yE14ToMPU7CiJERuVY5dFSpvygoUGKPvp+W4GfcTHUAOLHxTwXng/n73uCcv8lsSGholJ7+tAl9jRZhaA9eTM8bPLVf3mO6D7sCZP9SH3yTUDihJ+XdnXKtZagLl8DY4hpVQq7dPfL/wSAmyAnE1NlJ9bPyuEmZX8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137278; c=relaxed/simple;
	bh=6X1riY+VHXRDka4H1B+wNDkstNqFukhW6/fU6njkVS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBXlcRyL/GDAM/H7mCoDP4qeq7pA/VFQ4NfB4idCjeKkABIQ9h41+Pk7OCkcPlJLVk2QYxz3DckU3MUa59SjUwbErwk2DFHJsXDxwm0FE2ZolNkpkkofMbjm5IfK+VbYBLJGXkNb7SkpftYuPUQBaJYXb++QRi1U/U4uusueq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEb6KN+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733137275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5qe+kacRTUMIlGtiIXxBuiYgdy3mvLZJuJ7npnuXvo4=;
	b=fEb6KN+QQaXnsIYUI8PJMjDpHQljP/yR3XCSguJOixBl/a8w/9Ac510soO72c82K8NIPxN
	pgok7sf6+LpSv1VTVb+2s1HpOyC3fX2cgY0Fwt44e58Hq32N1wKoKr8y6ALOjFNm7s8kBQ
	WqQWhtrvozKERF4jv7D8yAZAYxfeTNI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-KK3CtWbxPzCZTC6blB60FQ-1; Mon,
 02 Dec 2024 06:01:14 -0500
X-MC-Unique: KK3CtWbxPzCZTC6blB60FQ-1
X-Mimecast-MFC-AGG-ID: KK3CtWbxPzCZTC6blB60FQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDEE0195421D;
	Mon,  2 Dec 2024 11:01:12 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.194.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 370C130000DF;
	Mon,  2 Dec 2024 11:01:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1] mm/memory_hotplug: move debug_pagealloc_map_pages() into online_pages_range()
Date: Mon,  2 Dec 2024 12:01:08 +0100
Message-ID: <20241202110108.451522-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In the near future, we want to have a single way to handover PageOffline
pages to the buddy, whereby they could have:

(a) Never been exposed to the buddy before: kept PageOffline when onlining
    the memory block.
(b) Been allocated from the buddy, for example using
    alloc_contig_range() to then be set PageOffline,

Let's start by making generic_online_page() less special compared to
ordinary page freeing (e.g., free_contig_range()), and perform the
debug_pagealloc_map_pages() call unconditionally, even when the online
callback might decide to keep the pages offline.

All pages are already initialized with PageOffline, so nobody touches
them either way.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 10 +++++++++-
 mm/page_alloc.c     |  6 ------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c43b4e7fb298..20af14e695c7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -650,6 +650,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	 * this and the first chunk to online will be pageblock_nr_pages.
 	 */
 	for (pfn = start_pfn; pfn < end_pfn;) {
+		struct page *page = pfn_to_page(pfn);
 		int order;
 
 		/*
@@ -664,7 +665,14 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 		else
 			order = MAX_PAGE_ORDER;
 
-		(*online_page_callback)(pfn_to_page(pfn), order);
+		/*
+		 * Exposing the page to the buddy by freeing can cause
+		 * issues with debug_pagealloc enabled: some archs don't
+		 * like double-unmappings. So treat them like any pages that
+		 * were allocated from the buddy.
+		 */
+		debug_pagealloc_map_pages(page, 1 << order);
+		(*online_page_callback)(page, order);
 		pfn += (1UL << order);
 	}
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cc3296cf8c95..01927f03af0b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1293,12 +1293,6 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 			set_page_count(p, 0);
 		}
 
-		/*
-		 * Freeing the page with debug_pagealloc enabled will try to
-		 * unmap it; some archs don't like double-unmappings, so
-		 * map it first.
-		 */
-		debug_pagealloc_map_pages(page, nr_pages);
 		adjust_managed_page_count(page, nr_pages);
 	} else {
 		for (loop = 0; loop < nr_pages; loop++, p++) {
-- 
2.47.1


