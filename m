Return-Path: <linux-kernel+bounces-293948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01F9586D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FC5B2179A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393DE18F2FC;
	Tue, 20 Aug 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Go6N2olY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7C18637
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156541; cv=none; b=lNcFWDCJxzcEv1zYex/sNTiyGBGayBBBdUsmgcpDlk9UtNYaE8styrjUcsNPaR+TeZ8nBrJWDq88k4z3hcPFH9VlkCaS3g2OfjBSE9IVGNZgwyXQjwkVG2Vh/q16yStHjFfEL3kOZqPJgGEtu5T4UWhapOaPysmgD96vOaCsQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156541; c=relaxed/simple;
	bh=/1jHvDeO9ZZesnfUhKu8wSQUk5SU12En7h6Awon5ijo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QG0jhsYz8brKT5rIhMRYHjlBH8rDfe22VMoFO8fUZBdHtsc1leB2NoUpDbAPlVaMw64wwZIxgO+VjEI5s/J63h0kX7bJS6evQDcafopYQv4EbnH0IaXhDgrGrqbrsHlyzqvT5wdZsU/MjUS+E+19I7die+ZgakztjNNzmuAY/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Go6N2olY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724156538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VjujtiGU7dij70tk/CDjYPdobVrS/ZRJontXr8mA6JU=;
	b=Go6N2olYHiDMRjnVKdmbegFrRMJFtik9cKWm80v00f3TysSbM8o3xGHQ0QrzaLQVyEbT71
	yYyjBn56B23gqQzspDIYD/NrIw73vj5ivOLP/oui+PpHJrw1xum1mw9OEBLsoqA8Jkypag
	9tHza+Q5THQuUsYPIsxADVP+hKpYF+o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-2RViYE6yP1qSqPNUHQwTbA-1; Tue,
 20 Aug 2024 08:22:17 -0400
X-MC-Unique: 2RViYE6yP1qSqPNUHQwTbA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A703E19560BF;
	Tue, 20 Aug 2024 12:22:15 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.16.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D9CD1956053;
	Tue, 20 Aug 2024 12:22:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	kernel test robot <oliver.sang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1] mm: always inline _compound_head() with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
Date: Tue, 20 Aug 2024 14:22:10 +0200
Message-ID: <20240820122210.660140-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We already force-inline page_fixed_fake_head(), page_is_fake_head()
and PageTail(), however the compiler might decide that _compound_head()
is not worthy to be inlined, because of page_fixed_fake_head().

The result is that, for example, PageAnonExclusive() now might involve
a function call when checking PageHuge(), which performs a
page_folio()->_compound_head() call. This can lead to a slight regression
of the stress-ng.clone benchmark.

This is not super-urgent to fix, but always inlining _compound_head()
seems like the obvious thing to do for this primitive, similar to the
other ones.

This change restores the slight regression and a compilation with
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y shows no relevant bloat [2]:

	add/remove: 15/14 grow/shrink: 79/87 up/down: 12836/-13917 (-1081)
	...
	Total: Before=32786363, After=32785282, chg -0.00%

[1] https://lkml.kernel.org/r/817150f2-abf7-430f-9973-540bd6cdd26f@intel.com
[2] https://lore.kernel.org/all/116e117c-2821-401d-8e62-b85cdec37f4a@redhat.com/

Fixes: c0bff412e67b ("mm: allow anon exclusive check over hugetlb tail pages")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407301049.5051dc19-oliver.sang@intel.com
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b753d158762fc..af58b2ad854c3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -233,7 +233,7 @@ static __always_inline int page_is_fake_head(const struct page *page)
 	return page_fixed_fake_head(page) != page;
 }
 
-static inline unsigned long _compound_head(const struct page *page)
+static __always_inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
-- 
2.46.0


