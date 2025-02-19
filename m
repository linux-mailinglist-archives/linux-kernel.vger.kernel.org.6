Return-Path: <linux-kernel+bounces-520806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F6A3AF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78D83B2603
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52213D891;
	Wed, 19 Feb 2025 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkmQiIq8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA2192580
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931509; cv=none; b=U0yuZotZW7bo+HTxnzR0gOzToQeLRC4snZoPwtTcJ0Jlrox6IOYd1futjwFgcWxwOxJPqhH5eN3VQI9c9jDvUrGt0nNx59XShvE/t8CqEnVjxVOezUx5HKqFBF0/fQnQPlYCh46HD2XeyKcWpKZdPnPQ7gz/Z72sLpLhWDENyIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931509; c=relaxed/simple;
	bh=7970QM1xZmqq/TgEZxRgA2G329dagmUAvSBDdehiCKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIOzp8/08j/grPFYw43XpRCRyfGAAcUhd94H8W4JEfBEULHxWRdfUuyVi3x3YNRkhEUwHDsydO+KvR7fgfdb91f4bSovOo9u21EzSUo5cPKQjX4lwbdLa9ucb13Ks7KW9L29vIZS/d8r0hFO2ZKaYNgqI2JhrZc5/CNE2DITjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkmQiIq8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739931506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8m9/U7uQSSFPcBA25A4fBqyiaCO54n8VIlpbaNJ5EU=;
	b=TkmQiIq8dvhrjJ7Uy+wOzn0vbDG2zHIb51mz14aF3FEk6T6gIeRY3fnMeNYhBywLLb26ts
	HH7fn1mp2BAz8rAuS2lx1uoYeJzzRQNDqXsmAXu1LtAoXmmNjVTg5iudB0PBhdD+KCIseU
	hITS/D6rjb+y6r8jLcx+AvzE7/psx/o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-rLhuEFm1MNKyofazmyW6_g-1; Tue,
 18 Feb 2025 21:18:23 -0500
X-MC-Unique: rLhuEFm1MNKyofazmyW6_g-1
X-Mimecast-MFC-AGG-ID: rLhuEFm1MNKyofazmyW6_g_1739931502
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4186619373DC;
	Wed, 19 Feb 2025 02:18:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44EAA1956094;
	Wed, 19 Feb 2025 02:18:20 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@redhat.com,
	yuzhao@google.com,
	pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	luizcap@redhat.com
Subject: [PATCH 4/4] mm: page_ext: make page_ext_next() private to page_ext
Date: Tue, 18 Feb 2025 21:17:50 -0500
Message-ID: <5794ff5b322febd376728c8e22c802c15827dcc8.1739931468.git.luizcap@redhat.com>
In-Reply-To: <cover.1739931468.git.luizcap@redhat.com>
References: <cover.1739931468.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Previous commits removed page_ext_next() use from page_ext clients. Make
it private.

Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 include/linux/page_ext.h | 7 -------
 mm/page_ext.c            | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index a99da12e59fa7..3a4f0f825aa59 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -101,13 +101,6 @@ static inline void *page_ext_data(struct page_ext *page_ext,
 	return (void *)(page_ext) + ops->offset;
 }
 
-static inline struct page_ext *page_ext_next(struct page_ext *curr)
-{
-	void *next = curr;
-	next += page_ext_size;
-	return next;
-}
-
 struct page_ext_iter {
 	unsigned long pfn;
 	unsigned long index;
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 508deb04d5ead..f9e515d353005 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -567,6 +567,13 @@ struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *pa
 	return iter->page_ext;
 }
 
+static struct page_ext *page_ext_next(struct page_ext *curr)
+{
+	void *next = curr;
+	next += page_ext_size;
+	return next;
+}
+
 /**
  * page_ext_iter_next() - Get next page extension
  * @iter: page extension iterator.
-- 
2.48.1


