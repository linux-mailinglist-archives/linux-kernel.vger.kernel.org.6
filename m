Return-Path: <linux-kernel+bounces-205612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04458FFE24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552721F23F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6288015B127;
	Fri,  7 Jun 2024 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uex4DVjL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524B15B117
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749451; cv=none; b=lcpShH+7WvgTzgpvZOfmqxXOVqpZ9GAbEbFCwrrX4dCuNmCCuRJNs0sbJbKR4F5+Pt8sCz9/hABeO46aZ5RWf7mZqEOjFBhqnJCSStlTViaZuQmEeVY7omYEi0N2ipNSNxdvQMJohnpjUGS7XttHegpfdY89FA/Rv3UE9lo6sx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749451; c=relaxed/simple;
	bh=VWNhSrA1Y1LZu/0IWk3/d2HB7oDgR32bVMKuc3XnPbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwoPahy7qCWHH2KnjQvFVOXrfoqmjvXQx4pl1MYgzFFv1Bfjb76HY5Ql7S914et6FYKqe+aEqTESmqVNjLs7lT31seWD0moNJGLbIx7Da+V9e0YAjIC+zwxNale+fLUKOiAVhOSIPtdnex/qb5hZR7TJdRrk+57Fj1Qkr7l6ieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uex4DVjL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717749449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fwBtdoh3359SXZDjchmPGzkh5xSmHZDLRHxcqN3RR4=;
	b=Uex4DVjLckx6UQfA7iU0GDJsB1F9zWZLzHhlrkYEVm74DkZIVOBPcnetDTEzenCcX6nXSB
	kuKJ9/KW7MZTo8UgNvVw4zhaSXMYg5ItHic+4Im/HwNUljKeISAsBcs5ZiaKx2mCNMYWnc
	k6kXDY5RsyvfBmKZSiLz92leuaezP4E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-d4bJ3LKmP7WWgT8xzXdCtQ-1; Fri,
 07 Jun 2024 04:37:20 -0400
X-MC-Unique: d4bJ3LKmP7WWgT8xzXdCtQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60B4D193D899;
	Fri,  7 Jun 2024 08:37:19 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E46551956048;
	Fri,  7 Jun 2024 08:37:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 1/2] mm/highmem: reimplement totalhigh_pages() by walking zones
Date: Fri,  7 Jun 2024 10:37:10 +0200
Message-ID: <20240607083711.62833-2-david@redhat.com>
In-Reply-To: <20240607083711.62833-1-david@redhat.com>
References: <20240607083711.62833-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Can we get rid of the highmem ifdef in adjust_managed_page_count()?
Likely yes: we don't have that many totalhigh_pages() users, and they
all don't seem to be very performance critical.

So let's implement totalhigh_pages() like nr_free_highpages(),
collecting information from all zones. This is now similar to what we do
in si_meminfo_node() to collect the per-node highmem page count.

In the common case (single node, 3-4 zones), we really shouldn't care.
We could optimize a bit further (only walk ZONE_HIGHMEM and ZONE_MOVABLE
if required), but there doesn't seem a real need for that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/highmem-internal.h |  9 ++-------
 mm/highmem.c                     | 16 +++++++++++++---
 mm/page_alloc.c                  |  4 ----
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a3028e400a9c6..65f865fbbac04 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -132,7 +132,7 @@ static inline void __kunmap_atomic(const void *addr)
 }
 
 unsigned int __nr_free_highpages(void);
-extern atomic_long_t _totalhigh_pages;
+unsigned long __totalhigh_pages(void);
 
 static inline unsigned int nr_free_highpages(void)
 {
@@ -141,12 +141,7 @@ static inline unsigned int nr_free_highpages(void)
 
 static inline unsigned long totalhigh_pages(void)
 {
-	return (unsigned long)atomic_long_read(&_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_add(long count)
-{
-	atomic_long_add(count, &_totalhigh_pages);
+	return __totalhigh_pages();
 }
 
 static inline bool is_kmap_addr(const void *x)
diff --git a/mm/highmem.c b/mm/highmem.c
index bd48ba445dd41..3c4e9f8c26dcd 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -111,9 +111,6 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
 }
 #endif
 
-atomic_long_t _totalhigh_pages __read_mostly;
-EXPORT_SYMBOL(_totalhigh_pages);
-
 unsigned int __nr_free_highpages(void)
 {
 	struct zone *zone;
@@ -127,6 +124,19 @@ unsigned int __nr_free_highpages(void)
 	return pages;
 }
 
+unsigned long __totalhigh_pages(void)
+{
+	unsigned long pages = 0;
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		if (is_highmem(zone))
+			pages += zone_managed_pages(zone);
+	}
+
+	return pages;
+}
+
 static int pkmap_count[LAST_PKMAP];
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fc98082a9cf9c..2224965ada468 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5794,10 +5794,6 @@ void adjust_managed_page_count(struct page *page, long count)
 {
 	atomic_long_add(count, &page_zone(page)->managed_pages);
 	totalram_pages_add(count);
-#ifdef CONFIG_HIGHMEM
-	if (PageHighMem(page))
-		totalhigh_pages_add(count);
-#endif
 }
 EXPORT_SYMBOL(adjust_managed_page_count);
 
-- 
2.45.1


