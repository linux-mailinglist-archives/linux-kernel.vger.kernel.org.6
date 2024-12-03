Return-Path: <linux-kernel+bounces-428990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C19E165B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F2CB2D6C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148711DE882;
	Tue,  3 Dec 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+dwj/SN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89191DE3A2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215110; cv=none; b=H/ZB+TY0GWZ/8XIJTiJoU2TOWwDJu6GXt8CHUKB4FLQfLX/ECTSajfi84MfoOSQ59uNY9mHIh0AW3rA83bY2U9v4AKnjTCK285qBhN/5XhcRFlShaMZnwJPOieY0PfaWAEK6AvlMzGwR3xFwhvrXFrHsUkQMPXZB+Jv2By1H6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215110; c=relaxed/simple;
	bh=n45GhTq8SepWMrRk6KmDNVm5gUB+gB/12JUs1rFL2Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0XRrTH4+Ilf2Nzf8PfCL/qBsNb8XJRA0WxoRCFS0OEgERnO1iY98v3pkJB67XUsq21b1JyROZR3oaP/1K0BiTz0xYWi/w3iTKAAahnBbwG/7iV9kWqbh2vjViMjNr/SI4Hf82WW+g08laUeX2iL+6CiwmjMM2PWPt24VVGgV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+dwj/SN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733215106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LU3Y8BABokL9EuVXZz3YTSIe3emDP78aZncO4AsTCRE=;
	b=X+dwj/SNBbgNSQ63HjCvkjhc4aBBaEZygfKPs3/1ENO42X/4GxKTh6NWHCzPyTP65y74cf
	s5qL8AUIUmEofRtpdT1BNJHmTTS2y/aQBqW1arZ/lSZkpImYZxJBUpq6QmWVrVBrThfJXR
	JAD+Hep5gJ/Einp+SvVXm0vviwJZHAs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-KsYeB2QvPViavZaAQQOzig-1; Tue,
 03 Dec 2024 03:38:21 -0500
X-MC-Unique: KsYeB2QvPViavZaAQQOzig-1
X-Mimecast-MFC-AGG-ID: KsYeB2QvPViavZaAQQOzig
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D7EA1955DC2;
	Tue,  3 Dec 2024 08:38:19 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.88.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1C8F30001A0;
	Tue,  3 Dec 2024 08:38:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v2 3/6] mm/page_alloc: make __alloc_contig_migrate_range() static
Date: Tue,  3 Dec 2024 09:37:53 +0100
Message-ID: <20241203083756.112975-4-david@redhat.com>
In-Reply-To: <20241203083756.112975-1-david@redhat.com>
References: <20241203083756.112975-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The single user is in page_alloc.c.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h   | 4 ----
 mm/page_alloc.c | 5 ++---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 74713b44bedb..4bd3685c33ef 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -839,10 +839,6 @@ int
 isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
 
-int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end,
-					int migratetype);
-
 /* Free whole pageblock and set its migration type to MIGRATE_CMA. */
 void init_cma_reserved_pageblock(struct page *page);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f371fbf2145b..ce7589a4ec01 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6284,9 +6284,8 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
  * @migratetype: using migratetype to filter the type of migration in
  *		trace_mm_alloc_contig_migrate_range_info.
  */
-int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end,
-					int migratetype)
+static int __alloc_contig_migrate_range(struct compact_control *cc,
+		unsigned long start, unsigned long end, int migratetype)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned int nr_reclaimed;
-- 
2.47.1


