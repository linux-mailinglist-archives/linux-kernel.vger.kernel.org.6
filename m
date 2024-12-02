Return-Path: <linux-kernel+bounces-427555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588AD9E053C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249F3B41EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB31FF5E3;
	Mon,  2 Dec 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMc32Wzc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A7207A37
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144318; cv=none; b=nQaLflLn25WTr1sDWwuk7iG5RPYFqUkwZ/3vTai7o0Aj+3GZZvUcPuyYSxOBp/wLSByvA11c9Je3xSNJTHyRezHrHA6lLKCBgy3D12qFMDsZpuKs7jjurqHqHe1fjHRva0ltwEwBMYlRS1H5bhMCrw9PRC5KGWAKsSgPj4WjYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144318; c=relaxed/simple;
	bh=JEGS3C3TCPmnhChhJrG3oxHow5MoN9iH1s1WpAV4ziw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjoDkitRIDCKCE+bTMcjoYUV53lWXxbC6BAJyQoXMjlN1nszU6koHFxaM7RfD73wSkHwF+sbei1Gh/C823gd2Gsn8qTeZrKggmUbHR+DijRd1Wt5AGWr3mYMEJUYchVKRKsBm5fvVapogUUT14zJbL5xHJNfj2iEXjz/iCWs/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMc32Wzc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733144315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXUMaNNR7Vq6MIOYC8hJbP2dJElyfdgC2J/3Ji8PmA0=;
	b=jMc32WzcpzbZfE65phW6SRD0/ftczKV0ZITkM3wLBalneEGGxKV7ycr5Udws1BYXzZtwO8
	vnH2ndQvFZQASyR35V1JSMf4c2nc/mGbWyOuy5o9EOHTFZp8cRhCtN/rr2zueooMiS8zQS
	IPUE8g42VJZvgD5tuNoZhkSrpantxZ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-OSMYzBRLMp-I564LqkqeBg-1; Mon,
 02 Dec 2024 07:58:32 -0500
X-MC-Unique: OSMYzBRLMp-I564LqkqeBg-1
X-Mimecast-MFC-AGG-ID: OSMYzBRLMp-I564LqkqeBg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E680A18DA5D1;
	Mon,  2 Dec 2024 12:58:29 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.194.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1BDE195605A;
	Mon,  2 Dec 2024 12:58:24 +0000 (UTC)
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
Subject: [PATCH v1 2/6] mm/page_isolation: don't pass gfp flags to start_isolate_page_range()
Date: Mon,  2 Dec 2024 13:58:08 +0100
Message-ID: <20241202125812.561028-3-david@redhat.com>
In-Reply-To: <20241202125812.561028-1-david@redhat.com>
References: <20241202125812.561028-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The parameter is unused, so let's stop passing it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-isolation.h | 2 +-
 mm/memory_hotplug.c            | 3 +--
 mm/page_alloc.c                | 2 +-
 mm/page_isolation.c            | 4 +---
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 73dc2c1841ec..898bb788243b 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -31,7 +31,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 				  int migratetype);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype, int flags, gfp_t gfp_flags);
+			     int migratetype, int flags);
 
 void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c43b4e7fb298..9b184ba064a0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1992,8 +1992,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
-				       MEMORY_OFFLINE | REPORT_FAILURE,
-				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
+				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
 		reason = "failure to isolate range";
 		goto failed_removal_pcplists_disabled;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cc3296cf8c95..f371fbf2145b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6451,7 +6451,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
+	ret = start_isolate_page_range(start, end, migratetype, 0);
 	if (ret)
 		goto done;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e680d40d96de..c608e9d72865 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -442,8 +442,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  *					 and PageOffline() pages.
  *			REPORT_FAILURE - report details about the failure to
  *			isolate the range
- * @gfp_flags:		GFP flags used for migrating pages that sit across the
- *			range boundaries.
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
  * the range will never be allocated. Any free pages and pages freed in the
@@ -476,7 +474,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype, int flags, gfp_t gfp_flags)
+			     int migratetype, int flags)
 {
 	unsigned long pfn;
 	struct page *page;
-- 
2.47.1


