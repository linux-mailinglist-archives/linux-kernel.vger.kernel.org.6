Return-Path: <linux-kernel+bounces-428993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC5B9E15FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932B3163F26
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8B1DE3BD;
	Tue,  3 Dec 2024 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIevsxAS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F131DF268
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215121; cv=none; b=M9VU2mi6BOMxbtwB72V58MNp7kPSZ3xLnqVS2C56uDkjs4xzXSFozck17MdceXbpGnjJNVHNixzEEbiKfnBHuTP83dQQTzFNGWWh/H19GrejdvH1dMArATxMEfb9Yr08lTDCB9Or6V+p5wT5+GhnvAv9e1TEf2LEN8xX0hm3O10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215121; c=relaxed/simple;
	bh=zqRmnKKh1kPNJZoY6ULf4DwM5/SkuHAG0kEMtPX7EWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmyI85yfDVb786OPgKtgMGg47bRGNDxfX+dlBAYb4OtsUKA7EO74BtO9tzUdi91e73hJLffFsuQANt8VDUVuGyfYQjXBndOwf03zVcjo+O2uHgUulYVdFhaEeBW444DIGSGtENDn5EqtebXJ6Ua2aqBp30g3Wydh0UuQ1E0dxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIevsxAS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733215119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xX/Q3/3Rp0ILyMXyKGOcZrJDDur/TZdwfSuBal5fAnM=;
	b=UIevsxAS8F5TBVogyZ+cb5b4yylSncsvjVINHkdemesmvi5sJ9K843GqpuTvgx2DWuNtZv
	Oy6EMvFoIBgpHpjvmN1XIv/GUpSYZUw4XHUJ6xOMqVCsoJxaOORlY9NoC/l6GON6Lf0VGU
	tfIh3g0NAgA9PAOhIzaUhKqW8s/Vu+M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-KIBg8WfaPjq4ggDyQfJJqQ-1; Tue,
 03 Dec 2024 03:38:35 -0500
X-MC-Unique: KIBg8WfaPjq4ggDyQfJJqQ-1
X-Mimecast-MFC-AGG-ID: KIBg8WfaPjq4ggDyQfJJqQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B9DE1956058;
	Tue,  3 Dec 2024 08:38:34 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.88.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4C0930001A0;
	Tue,  3 Dec 2024 08:38:29 +0000 (UTC)
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
Subject: [PATCH v2 6/6] powernv/memtrace: use __GFP_ZERO with alloc_contig_pages()
Date: Tue,  3 Dec 2024 09:37:56 +0100
Message-ID: <20241203083756.112975-7-david@redhat.com>
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

alloc_contig_pages()->alloc_contig_range() now supports __GFP_ZERO,
so let's use that instead to resolve our TODO.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 31 +++++------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 877720c64515..4ac9808e55a4 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -88,26 +88,6 @@ static void flush_dcache_range_chunked(unsigned long start, unsigned long stop,
 	}
 }
 
-static void memtrace_clear_range(unsigned long start_pfn,
-				 unsigned long nr_pages)
-{
-	unsigned long pfn;
-
-	/* As HIGHMEM does not apply, use clear_page() directly. */
-	for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++) {
-		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
-			cond_resched();
-		clear_page(__va(PFN_PHYS(pfn)));
-	}
-	/*
-	 * Before we go ahead and use this range as cache inhibited range
-	 * flush the cache.
-	 */
-	flush_dcache_range_chunked((unsigned long)pfn_to_kaddr(start_pfn),
-				   (unsigned long)pfn_to_kaddr(start_pfn + nr_pages),
-				   FLUSH_CHUNK_SIZE);
-}
-
 static u64 memtrace_alloc_node(u32 nid, u64 size)
 {
 	const unsigned long nr_pages = PHYS_PFN(size);
@@ -119,17 +99,18 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
 	 * by alloc_contig_pages().
 	 */
 	page = alloc_contig_pages(nr_pages, GFP_KERNEL | __GFP_THISNODE |
-				  __GFP_NOWARN, nid, NULL);
+				  __GFP_NOWARN | __GFP_ZERO, nid, NULL);
 	if (!page)
 		return 0;
 	start_pfn = page_to_pfn(page);
 
 	/*
-	 * Clear the range while we still have a linear mapping.
-	 *
-	 * TODO: use __GFP_ZERO with alloc_contig_pages() once supported.
+	 * Before we go ahead and use this range as cache inhibited range
+	 * flush the cache.
 	 */
-	memtrace_clear_range(start_pfn, nr_pages);
+	flush_dcache_range_chunked((unsigned long)pfn_to_kaddr(start_pfn),
+				   (unsigned long)pfn_to_kaddr(start_pfn + nr_pages),
+				   FLUSH_CHUNK_SIZE);
 
 	/*
 	 * Set pages PageOffline(), to indicate that nobody (e.g., hibernation,
-- 
2.47.1


