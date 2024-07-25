Return-Path: <linux-kernel+bounces-262544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A793C871
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D481C20AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4AB5C8FC;
	Thu, 25 Jul 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kh0dQ1AM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960DF558BB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932810; cv=none; b=uElY0qUYNQylnNWzNZIJdmDRzzwAdPtJdGLXFCfXraXVT2S5wX3LB4kX1eknlorENRCL6RpmuaO2kDz7o9SFSUEzP8qZL+hsSElZe2vx/F6BKcHzxDJEhI9n4KBYz1F8GPGdIdvu3LwTdAfI5D/7gQDINwPAeXsgtpPIlxiiWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932810; c=relaxed/simple;
	bh=HNC1nBhC+RD9R8NBqCRJXTEEe2CLskm9iBsb/+CJ2vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKQayFZY4VWcFP1UrTZgAAN0wh5d2NUaYXXaLX7KLDvkBgq3wH+BJ4TqgFMJxF8PUGFKGGLqvpnZZZjZ2uqg9IDuATil0MWYUmNFdAt6rhpjeidXtOsPiKMfRYpHhS+6uaXzAa9cw/RN2pH3Qch6fXL8LNKMrI9HBF5aoUa1XfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kh0dQ1AM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721932807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6pZb0N/kLDE9N4DI8onERCvts5vm83WGgR5AndUh35M=;
	b=Kh0dQ1AMYuLmLmVk0kUlGBfiqONOjf4psNrX4GXiqm+ekLmsUZfZ5vq6BNjnK2xWj/Omym
	rsyWMb7OfwLkEnx/1GsqnW1+GsoadzzPf0MxpiW0xaWVZ7BBjwnXSAtCqn8/qk8djIqzbz
	0Wxu0q2nUkhRN1a9XepvT3jDl03N+TE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-UZaOshO6MOaEgq3uezcFDQ-1; Thu,
 25 Jul 2024 14:40:01 -0400
X-MC-Unique: UZaOshO6MOaEgq3uezcFDQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4D5B1955D48;
	Thu, 25 Jul 2024 18:39:59 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C906F1955D48;
	Thu, 25 Jul 2024 18:39:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 0/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Date: Thu, 25 Jul 2024 20:39:53 +0200
Message-ID: <20240725183955.2268884-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Working on another generic page table walker that tries to avoid
special-casing hugetlb, I found a page table locking issue with hugetlb
folios that are not mapped using a single PMD/PUD.

For some hugetlb folio sizes, GUP will take different page table locks
when walking the page tables than hugetlb when modifying the page tables.

I did not actually try reproducing an issue, but looking at
follow_pmd_mask() where we might be rereading a PMD value multiple times
it's rather clear that concurrent modifications are rather unpleasant.

In follow_page_pte() we might be better in that regard -- ptep_get() does
a READ_ONCE() -- but who knows what else could happen concurrently in
some weird corner cases (e.g., hugetlb folio getting unmapped and freed).

Did some basic sanity testing with various hugetlb sizes on x86-64 and
arm64. Maybe I'll find some time to actually write a simple reproducer in
the common weeks, so this wouldn't have to be all-theoretical for now.

Only v6.10 is affected, so the #1 can be simply backported as a prereq
patch along with the real fix.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>

David Hildenbrand (2):
  mm: let pte_lockptr() consume a pte_t pointer
  mm/hugetlb: fix hugetlb vs. core-mm PT locking

 include/linux/hugetlb.h | 25 ++++++++++++++++++++++---
 include/linux/mm.h      |  7 ++++---
 mm/khugepaged.c         | 21 +++++++++++++++------
 mm/pgtable-generic.c    |  4 ++--
 4 files changed, 43 insertions(+), 14 deletions(-)


base-commit: cca1345bd26a67fc61a92ff0c6d81766c259e522
-- 
2.45.2


