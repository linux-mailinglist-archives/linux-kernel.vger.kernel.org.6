Return-Path: <linux-kernel+bounces-205613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9758FFE25
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBEF1F2270F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07515B144;
	Fri,  7 Jun 2024 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKfPMHJY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098915443A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749452; cv=none; b=bF4DfBIMJkiubBRh1e5rtx/+CabBx5gx9DgAI8Yul+aRM9z7esEQfOvZLbkWmXOWukWz3pUPAGvIRInlUtM3ktOzIO0RpSUNhcWykjFP/hOync9WL9kBjOCFZ/lHO6QUrz+zviFuww9dapLWXg9YeKxe+B+o9ZX1Q/nKjrVrbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749452; c=relaxed/simple;
	bh=glKaYjB5J42JV8b5CgCtmrHMgZPtCivY3ElumdwM2/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR2OYX1wI1YUdUeZ8RR7jvP6szUSTibWy/ksYZMhxx3bnCmugORRpFlLaC0KUjDeAcaDu9nMnKesjtu2nemOGPl0HGeJt/OthNIVrgxQdsYqsFwJ1RFFJMGzhdtijhhaqZtUR2vYZRSAzXRN4mQVbewTAlIbJNFG34Vw8Wuj7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKfPMHJY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717749450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXWfwhzpgOX74lB6RIPXOSDING4fKwOkibJ9ziHUHsg=;
	b=XKfPMHJYie4gBW++0tGpiWkPQd9NKVyqB5B4LxHgIVm6l8cnFUmcFYO1h3wgrp2nBm1dUX
	k2//KaWGbOXgKKAUO001nG0fqCHfUKslzbieKB8t1br/L+48kRxsbUxkFEnXuijoB43LQd
	W28ZZ6QsdgYLFlr4emIwItQL9sQHj5w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-r8zPj0gAO9GFTjIA0KVXaw-1; Fri,
 07 Jun 2024 04:37:23 -0400
X-MC-Unique: r8zPj0gAO9GFTjIA0KVXaw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04444196DFC1;
	Fri,  7 Jun 2024 08:37:22 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC7F21956048;
	Fri,  7 Jun 2024 08:37:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 2/2] mm/highmem: make nr_free_highpages() return "unsigned long"
Date: Fri,  7 Jun 2024 10:37:11 +0200
Message-ID: <20240607083711.62833-3-david@redhat.com>
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

It looks rather weird that totalhigh_pages() returns an
"unsigned long" but nr_free_highpages() returns an "unsigned int".

Let's return an "unsigned long" from nr_free_highpages() to be
consistent.

While at it, use a plain "0" instead of a "0UL" in the !CONFIG_HIGHMEM
totalhigh_pages() implementation, to make these look alike as well.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/highmem-internal.h | 8 ++++----
 include/linux/highmem.h          | 2 +-
 mm/highmem.c                     | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 65f865fbbac04..dd100e849f5e0 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -131,10 +131,10 @@ static inline void __kunmap_atomic(const void *addr)
 		preempt_enable();
 }
 
-unsigned int __nr_free_highpages(void);
+unsigned long __nr_free_highpages(void);
 unsigned long __totalhigh_pages(void);
 
-static inline unsigned int nr_free_highpages(void)
+static inline unsigned long nr_free_highpages(void)
 {
 	return __nr_free_highpages();
 }
@@ -234,8 +234,8 @@ static inline void __kunmap_atomic(const void *addr)
 		preempt_enable();
 }
 
-static inline unsigned int nr_free_highpages(void) { return 0; }
-static inline unsigned long totalhigh_pages(void) { return 0UL; }
+static inline unsigned long nr_free_highpages(void) { return 0; }
+static inline unsigned long totalhigh_pages(void) { return 0; }
 
 static inline bool is_kmap_addr(const void *x)
 {
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6b0d6f3c8580c..930a591b9b616 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -179,7 +179,7 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
 static inline void *kmap_atomic(struct page *page);
 
 /* Highmem related interfaces for management code */
-static inline unsigned int nr_free_highpages(void);
+static inline unsigned long nr_free_highpages(void);
 static inline unsigned long totalhigh_pages(void);
 
 #ifndef ARCH_HAS_FLUSH_ANON_PAGE
diff --git a/mm/highmem.c b/mm/highmem.c
index 3c4e9f8c26dcd..1ece1e69031e7 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -111,10 +111,10 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
 }
 #endif
 
-unsigned int __nr_free_highpages(void)
+unsigned long __nr_free_highpages(void)
 {
+	unsigned long pages = 0;
 	struct zone *zone;
-	unsigned int pages = 0;
 
 	for_each_populated_zone(zone) {
 		if (is_highmem(zone))
-- 
2.45.1


