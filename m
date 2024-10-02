Return-Path: <linux-kernel+bounces-348179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0898E3BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E201F24127
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D9216A0E;
	Wed,  2 Oct 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4VhlX0I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469581720
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898949; cv=none; b=ZzojoCt0WGCG1TEj2MScNKOSwO/ADtkWANhsMsmzSsZkH7t0Iqt58kDqu97eQfbhSNe8dXnlVftllrpoZ0SvORPPYS/ouTB9QwzXOVDo3RDbeC9TK4NCAL1WKzBugkuyy29DjO8pDcMPzMBANhj41/zINcZoTA8STxAsOiQr508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898949; c=relaxed/simple;
	bh=Ogwnbfg2qtIl4g8Wi+N+nSis960IJ0UkMBfdXyfl8/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DRhNEWodGhl6wjBVRs3gq1YBmzqp/mw6lrdQUnAWY67t7mrXTV5x6TgMVPkZJ+YSurKD+drWKwOkphoFlcSv3tbTcxcQgi2arkn/gUzzGztv8P8svWtcDza/6AfileKFzpkiklF5AQj8kZe/dGyzG9oj3q3taMqlBR8T/ey18bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4VhlX0I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727898948; x=1759434948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ogwnbfg2qtIl4g8Wi+N+nSis960IJ0UkMBfdXyfl8/Y=;
  b=d4VhlX0IQ4WANa+FaqN48qKUlzXwc10Ro7d88yNOnpYxMce6ocz3GlC7
   uwz/Ltm5VOTvl7bBJbV39J+ztU64Io71vXO+BRUNvbkEbMTkz3Ab261X7
   mpuacI+UG4tvRP/x4dsQEL54tbBYauAY8IuDAb2IAOZBL/cWxPgEFwvjt
   y2e2QcjpuZAJLUbrUirk4Tz0pZB4WrNZNn4EXdxQO42vD9gb/lqFa7wCA
   yCDtcB6B7U00Ht4haXaYQzMbZBCR41K5XHuN3A0ZSOBHgduN7FA3J7BZy
   dEG/DtL+KDuXlog2NwbywXly/bEnq/rzzDkaeTRzO1N9LmkL9lbFjfy9I
   g==;
X-CSE-ConnectionGUID: ftpSExP2T1CGfEhi5bCTUQ==
X-CSE-MsgGUID: n0+E8/pdS7mkBbr23TB8HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37746897"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="37746897"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 12:55:47 -0700
X-CSE-ConnectionGUID: YfADFU3DRweBhFhOJotHLw==
X-CSE-MsgGUID: lEPfNQ8IR960key3l/1kJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73971681"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa010.jf.intel.com with ESMTP; 02 Oct 2024 12:55:47 -0700
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
Subject: [PATCH v2] mm: swap: Call count_mthp_stat() outside ifdef CONFIG_TRANSPARENT_HUGEPAGE.
Date: Wed,  2 Oct 2024 12:55:47 -0700
Message-Id: <20241002195547.30617-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the call to count_mthp_stat() in count_swpout_vm_event()
and in shrink_folio_list() to be outside the
"ifdef CONFIG_TRANSPARENT_HUGEPAGE" based on changes made in commit
246d3aa3e531 ("mm: cleanup count_mthp_stat() definition").

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


