Return-Path: <linux-kernel+bounces-280813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B624494CF85
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A13D1F22941
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF5194ACD;
	Fri,  9 Aug 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B78LbE9p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE81946B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204156; cv=none; b=H6IQ/gWHjZRYfB4x4bdlX7Px0DiGXXi2hYew6isUsmGYrg4SFDOqx57Qp4ygOrzJZxey+QPB+K/jdm6F414vo490p0vuyTsVp4GkuBlippMOlQNRq56OxPQV/TrWWz89JAJ9vS06X1Do1arLE0ETQM/2tegy+A0OAL+uHgQGWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204156; c=relaxed/simple;
	bh=UJtU8t95QJzWHwTNUBeTKKfK3Fj3/Vd+0O4Q8AZvnwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssFRtCc7b1JBVkGFJJYZeNsxYH5zJyXgkuAZL8c0YK5wFGsgA0+wuyyXhlmtMLyXBtfazRJR5EyfMWKAUQxLxBP6WN4npLVGEEkCpI6mSwk5rs7en7Hi+3e9J18eyGlEmXalu+DcYUEFLmjOeKAV2IKl/nUEdSTxUb4t5bJhdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B78LbE9p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204155; x=1754740155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJtU8t95QJzWHwTNUBeTKKfK3Fj3/Vd+0O4Q8AZvnwM=;
  b=B78LbE9ptf2xDQK1F8Ze65OSHQH837pi3AGUUOw9BZ9zO6Xy1Gjd/cpc
   gXCWAdPJhVTZ/EbDJkTQ7peKN0T2UzsU15p98OQF/fTZnHN9Jb28fERHV
   SXtcHlPHWbLXVD3FLxD8rYyuhk1d9/mPJVeb4S9O+1PD7EmYDbMq0MCrT
   A9lOqHoJffT5ZeOiIo1ScKyTL4rha711xSMPRaJAU9Fi7imMWPiCB8T2Q
   npkIBFF3TvxBmpoC5/69VbeZjW25J5hQ7gczMM1zzOdb6ju59glmws0m1
   rEdr/o5N1u1qI4PLG+CJ60TBdH80VWaNv0CZVZV1+RaK0/FX7vuxhzG13
   A==;
X-CSE-ConnectionGUID: 5we5DqPlQluNpBGa9Oevow==
X-CSE-MsgGUID: HG9E738MRI6P2olMZ9TLVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24280354"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24280354"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:14 -0700
X-CSE-ConnectionGUID: iyxUVt69T5KrH+8owVHsDA==
X-CSE-MsgGUID: 5BwJ2V4/SSyOgMZAXr93tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57506642"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 09 Aug 2024 04:49:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7A445A6B; Fri, 09 Aug 2024 14:49:02 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 8/8] mm: Accept to promo watermark
Date: Fri,  9 Aug 2024 14:48:54 +0300
Message-ID: <20240809114854.3745464-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c574bbe91703 ("NUMA balancing: optimize page placement for memory
tiering system") introduced a new watermark above "high" -- "promo".

Accept memory memory to the highest watermark which is WMARK_PROMO now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f0610c691ae5..84a7154fde93 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7046,8 +7046,8 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
-	/* How much to accept to get to high watermark? */
-	to_accept = high_wmark_pages(zone) -
+	/* How much to accept to get to promo watermark? */
+	to_accept = promo_wmark_pages(zone) -
 		    (zone_page_state(zone, NR_FREE_PAGES) -
 		    __zone_watermark_unusable_free(zone, order, 0) -
 		    zone_page_state(zone, NR_UNACCEPTED));
-- 
2.43.0


