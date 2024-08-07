Return-Path: <linux-kernel+bounces-277846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B262394A744
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1722A28196D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB21E4871;
	Wed,  7 Aug 2024 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQbaE0z1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F48171E69
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031723; cv=none; b=ddYU1oXwhW/dtbRkvBGRQYw4z0qj/S01uXB15FIqIAFiKL69S4VzIfgP1gnTijKp3u02lhQ2+IuK8E0MIJDIDLvvCEJhbswJ/Uk5dyvQoJrlsQG7ydtwzVgxZyYEZAPY67cqw1g1+h4poUe495xVbZ/8CaR+fS03MpTv1H8IJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031723; c=relaxed/simple;
	bh=NDx9TFn7hon9IP6K7N+qnaWC3lYRZqW3SVuChh+f90A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDiRJ1hkV9uuW35ZakiAf+o3JHO0PwlBh/drVo4HPJoC0pbHkbIb2arYwbBWSBoUsVBS6Dwzso+YnzgYtjfqwPR4eQtG6Kesm7bzD+MWe0RZtUMdBo4BhD4mA2PBC3xo5y2hkNgxqEZlhVb2Ir6Y7D0u9QXmWHvBRfVW/ogimFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQbaE0z1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723031720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oHtZRNKcWfmTYbMkkjOjAeZkU5EJx/xu0xbv9japU2A=;
	b=NQbaE0z13zpmNgXbnoeUMdtJBdhuZhll7GYHco3LFxk1zzr5swsfX7Yn0c3m0y5XJjz8dg
	m7yE14Wb1dF8TrT6IpaGkXnQatq3oM2i6ZUB8sWG10g70gSaAAsUb+CF+TUPxKIIiwFvub
	1mS8r/LOkKuN25cEXR2MR1XlGGKsKss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-IUlLYI8zMoq5PJFoImxIjA-1; Wed,
 07 Aug 2024 07:55:19 -0400
X-MC-Unique: IUlLYI8zMoq5PJFoImxIjA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD8E119560A2;
	Wed,  7 Aug 2024 11:55:18 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.165])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5204195605A;
	Wed,  7 Aug 2024 11:55:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/rmap: minimize folio->_nr_pages_mapped updates when batching PTE (un)mapping
Date: Wed,  7 Aug 2024 13:55:15 +0200
Message-ID: <20240807115515.1640951-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

It is not immediately obvious, but we can move the folio->_nr_pages_mapped
update out of the loop and reduce the number of atomic ops without
affecting the stats.

The important point to realize is that only removing the last PMD
mapping will result in _nr_pages_mapped going below ENTIRELY_MAPPED, not
the individual atomic_inc_return_relaxed() calls. Concurrent races with
removal of PMD mappings should be handled as expected, just like when
we would have such races right now on a single mapcount update.

In a simple munmap() microbenchmark [1] on 1 GiB of memory backed by the
same PTE-mapped folio size (only mapped by a single process such that they
will get completely unmapped), this change results in a speedup (positive
is good) per folio size on a x86-64 Intel machine of roughly (a bit of
noise expected):

* 16 KiB: +10%
* 32 KiB: +15%
* 64 KiB: +17%
* 128 KiB: +21%
* 256 KiB: +22%
* 512 KiB: +22%
* 1024 KiB: +23%
* 2048 KiB: +27%

[1] https://gitlab.com/davidhildenbrand/scratchspace/-/blob/main/pte-mapped-folio-benchmarks.c

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 901950200957..a6b9cd0b2b18 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1158,7 +1158,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	const int orig_nr_pages = nr_pages;
-	int first, nr = 0;
+	int first = 0, nr = 0;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
@@ -1170,13 +1170,13 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		}
 
 		do {
-			first = atomic_inc_and_test(&page->_mapcount);
-			if (first) {
-				first = atomic_inc_return_relaxed(mapped);
-				if (first < ENTIRELY_MAPPED)
-					nr++;
-			}
+			first += atomic_inc_and_test(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
+
+		if (first &&
+		    atomic_add_return_relaxed(first, mapped) < ENTIRELY_MAPPED)
+			nr = first;
+
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
@@ -1527,7 +1527,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		enum rmap_level level)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int last, nr = 0, nr_pmdmapped = 0;
+	int last = 0, nr = 0, nr_pmdmapped = 0;
 	bool partially_mapped = false;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
@@ -1541,14 +1541,13 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 
 		atomic_sub(nr_pages, &folio->_large_mapcount);
 		do {
-			last = atomic_add_negative(-1, &page->_mapcount);
-			if (last) {
-				last = atomic_dec_return_relaxed(mapped);
-				if (last < ENTIRELY_MAPPED)
-					nr++;
-			}
+			last += atomic_add_negative(-1, &page->_mapcount);
 		} while (page++, --nr_pages > 0);
 
+		if (last &&
+		    atomic_sub_return_relaxed(last, mapped) < ENTIRELY_MAPPED)
+			nr = last;
+
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
-- 
2.45.2


