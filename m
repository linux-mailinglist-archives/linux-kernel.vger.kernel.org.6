Return-Path: <linux-kernel+bounces-348353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728598E686
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28FFB20F49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225C19CC0E;
	Wed,  2 Oct 2024 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0DsJIM1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B73DDD2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909906; cv=none; b=EJMUpDVZiCqZ7d4aPmaIU1ACFSgoQMZHgtWmAy0bAQeWj+nMRFmRDeXHSSCxJOv5UhE1aiVc0xarchLnN3fX31bLTn9ndE0zcS83f8n9sH4y+Jvg+IzQvoIeOEP7lqSs6x7JAe3nWJNzxog6tngndxn+Bo3z9rtoGYPTinOBrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909906; c=relaxed/simple;
	bh=SQEhVMAwSnwMZnCw6ffBTDahTYRYzjlj1IySflcrx8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZ6gKb19UxwxoqlC0KrwgmZDdtLkAbGocPqrc5qKemO1p/VzNEMvn/8DAq9h+aoH6PqVMBxPG7pZEPxBsnmO4BgDQ+oUgztA0BdRcVGT0Yr1YtUBzVifF4miwxveHxytfMTYGJ3RpeUSqrY3kl7poVUd6RudOzmF4Wbk94dsuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0DsJIM1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727909904; x=1759445904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SQEhVMAwSnwMZnCw6ffBTDahTYRYzjlj1IySflcrx8Y=;
  b=n0DsJIM1jSvFYX5eM7wIx/Ap4B7xKpq0IgYUU5aYw/fvilq34M30dmjR
   HV6Enj5xfA7clEByoiUlaqT+y28TOD3oHwsfi+GsJkVQnUdIKQh/90aSU
   igdA6abJQw30l93IerNuq/lAL1ibhp9DEURqkQddzfIFP4caMtJQILV/M
   060J1c2uj0TxxXjV9DGQjkzSW9Hnpwo2KrmQbYZkGbe09l7C/RJAiOmAr
   Orxbl+x3etZwTd80ffyUub4CX9xUnorDsq7xcoiDJj+Vsmj7py/68z6cT
   QTn4Nlsq2Hq+gEuGBbvR2TkIWhJgRtZYyrfx9uz/RJNv4jqc1oS/rzEPx
   Q==;
X-CSE-ConnectionGUID: RZ5OyXnlSFmKjvjyboK/+w==
X-CSE-MsgGUID: JkoKAZD9T+SIbV/GSek+/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37760093"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="37760093"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:58:23 -0700
X-CSE-ConnectionGUID: 9nswhxPHR5O16PHhiid8Eg==
X-CSE-MsgGUID: 2s9FTVVUSqyq3SS2FzLT+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="78170025"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2024 15:58:23 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v3] mm: swap: Make some count_mthp_stat() call-sites be THP-agnostic.
Date: Wed,  2 Oct 2024 15:58:22 -0700
Message-Id: <20241002225822.9006-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 246d3aa3e531 ("mm: cleanup count_mthp_stat() definition"),
Ryan Roberts has pointed out the merits of mm code that does not require
THP, to be compile-able without requiring THP ifdefs. As a step in that
direction, he has moved count_mthp_stat() to be always defined, resolving
to a no-op if THP is not defined.

Barry Song had referred me to Ryan's commit when I was working on the
"mm: zswap swap-out of large folios" patch-series [1].

This patch propagates the benefits of the above change to page_io.c and
vmscan.c. As a result, there is one less reason to have the ifdef THP in
these code sections.

[1]: https://patchwork.kernel.org/project/linux-mm/list/?series=894347

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/page_io.c | 2 +-
 mm/vmscan.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 4aa34862676f..a28d28b6b3ce 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -289,8 +289,8 @@ static inline void count_swpout_vm_event(struct folio *folio)
 		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
 	}
-	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 #endif
+	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 	count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index dc7a285b256b..50dc06d55b1d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1257,8 +1257,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 							THP_SWPOUT_FALLBACK, 1);
 						count_vm_event(THP_SWPOUT_FALLBACK);
 					}
-					count_mthp_stat(order, MTHP_STAT_SWPOUT_FALLBACK);
 #endif
+					count_mthp_stat(order, MTHP_STAT_SWPOUT_FALLBACK);
 					if (!add_to_swap(folio))
 						goto activate_locked_split;
 				}
-- 
2.27.0


