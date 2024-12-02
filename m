Return-Path: <linux-kernel+bounces-427556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B09E0664
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF83B421A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89F208981;
	Mon,  2 Dec 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hl+ROWFr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6B20897F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144322; cv=none; b=CLthLgv3vj95BWXSVfNAQEGfokrzMqRy1Y3OI8beEAi3j0Hfpg+eUfa1kWe+XSBeMKbtzM/cp8U7/M9HIFEyeVmOfvRxSv1rCkpLZ1wV7ecSOpzbdb+u1C+CPsIubGjDaNMiUSmdWrn/paQ+6WY4qB85IDODh4IkIWOwKVl1Sx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144322; c=relaxed/simple;
	bh=pImGXTj0n9a6PzobleoeQUdS0WcyAe37pWo2dVmAMsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfdWClqwy9mvCgAwjguuYSG3d5q7ocEqmiGGRWEkukMK/rJQWzGA8MIcXD3xho4OiB8reNZZMldoj1Q/9ynQ3B+A0Yc1EStxp46Jpmg8o10s/j5SfxZgUaqIEmIQpSxZxj3NWhU34AuHL2225o60XhZPFd2MVbQ2DwSLZuI9+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hl+ROWFr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733144320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUyVMeCRN6dieaM+cMlV+AJS5EnHgADa23V603hh+n4=;
	b=Hl+ROWFregJ9yrRJqkC3slc457lZu6pESU4WY63oq5Jz0f43xcJTVlfr3VUL22A7RrPpgQ
	PEMk0YiKXNFd2s0uJx4npw9ZFYqJaSdokEoRwbgwOopteBxSKtmwkbsUbeGLiiGs0QvG0E
	u2tLxkIWDYfNesL8/NFHUTCt66vLKZU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-IvBmzQ_7PqKMDv2FdB_o2Q-1; Mon,
 02 Dec 2024 07:58:37 -0500
X-MC-Unique: IvBmzQ_7PqKMDv2FdB_o2Q-1
X-Mimecast-MFC-AGG-ID: IvBmzQ_7PqKMDv2FdB_o2Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E6DB1954229;
	Mon,  2 Dec 2024 12:58:35 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.194.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82C4E1955EA7;
	Mon,  2 Dec 2024 12:58:30 +0000 (UTC)
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
Subject: [PATCH v1 3/6] mm/page_alloc: make __alloc_contig_migrate_range() static
Date: Mon,  2 Dec 2024 13:58:09 +0100
Message-ID: <20241202125812.561028-4-david@redhat.com>
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

The single user is in page_alloc.c.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h   | 4 ----
 mm/page_alloc.c | 5 ++---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 0d17095c2dee..5656089eea7c 100644
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


