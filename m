Return-Path: <linux-kernel+bounces-225528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E99131CB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0936B2836C1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0E8F5D;
	Sat, 22 Jun 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bB+md6x0"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8A8748E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719027573; cv=none; b=tMAWaFQummRh9oPBASwzqgQ+zoKxY4DQ3OUZu6RfpmO+5XmaHtYdRW7ZxpqUa2NP9WwyKN/AkVaTUr8Sg/QK2zBzSMRCkxWC+CP/sjF9JOJrai372TsdSMmcd2sxuZ4FhOn9ZXE6SZtuIblOcVenn/ADsLlLIHf3SvcsMZQ5Nrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719027573; c=relaxed/simple;
	bh=BMw5JAzkP46NHEAdfpVxC+yvO2GvFSbohkUjQ+PGMyc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=r/kqEoFrLMc6TiPRMDfRpGs/vG5ujeFCGg5ca/+qsFrIyH8CTOXn7hQrdAH9n0t4QyYbR3KoUzs33AtfbdL/+j8/EnHCWHCGddZG+21v5I4uKrAoV2IdKUo1fKsNxuiVgnk41n4Ezyt+svaTC07gzHT4wX3HK7M8t6KdiVMvrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bB+md6x0; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=lIGxqX9x+SGOnQIbd5
	VQLVmLF3zctLikoC965VXpZOc=; b=bB+md6x0/Nl4yd8sHTfCFwsPdM+God2ByX
	itjAYN8Plm1LryGKMV09fz+ihx8Zw4XeAb/GMDjk9qKYyOsZV32wCkvDWIo29K1J
	IS2x40Tyq8oFacW2nxqkv6iul9cW3sjN8f4O9AOMWjSO9tjDf6MyNfWrAUR/y/1U
	Sm35KowAM=
Received: from localhost.localdomain (unknown [120.229.10.157])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3f4XMQ3ZmXFf2CQ--.59476S2;
	Sat, 22 Jun 2024 11:23:57 +0800 (CST)
From: "yongfa.hu" <hushange@163.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hushange@163.com
Subject: [PATCH] mm: rename no_progress_loops to reclaim_retris variable no_progress_loops exectly means reclaim retry counts, renameing makes it easier to understand. and has the same style as variable compaction_retries.
Date: Sat, 22 Jun 2024 11:23:46 +0800
Message-Id: <20240622032346.12250-1-hushange@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3f4XMQ3ZmXFf2CQ--.59476S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4kCr4DAFWrXF1fCF4kZwb_yoW5Jw4fpF
	4xu3ZrGrZYqFnxJFZ5Aa109F18A3s7KFZ8Xr1xKryxZw1fJrya9rW7Kry2vF18XF4DXayY
	vFs8Ar40grn8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRYg4-UUUUU=
X-CM-SenderInfo: xkxvxtxqjhqiywtou0bp/1tbiRQ8GnmXAnBlJXgAAsl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Signed-off-by: yongfa.hu <hushange@163.com>
---
 mm/page_alloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9054645ed..1435a9587 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4107,7 +4107,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 static inline bool
 should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		     struct alloc_context *ac, int alloc_flags,
-		     bool did_some_progress, int *no_progress_loops)
+		     bool did_some_progress, int *reclaim_retries)
 {
 	struct zone *zone;
 	struct zoneref *z;
@@ -4119,11 +4119,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * always increment the no progress counter for them
 	 */
 	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
-		*no_progress_loops = 0;
+		*reclaim_retries = 0;
 	else
-		(*no_progress_loops)++;
+		(*reclaim_retries)++;
 
-	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
+	if (*reclaim_retries > MAX_RECLAIM_RETRIES)
 		goto out;
 
 
@@ -4150,7 +4150,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
 				ac->highest_zoneidx, alloc_flags, available);
 		trace_reclaim_retry_zone(z, order, reclaimable,
-				available, min_wmark, *no_progress_loops, wmark);
+				available, min_wmark, *reclaim_retries, wmark);
 		if (wmark) {
 			ret = true;
 			break;
@@ -4222,14 +4222,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	enum compact_priority compact_priority;
 	enum compact_result compact_result;
 	int compaction_retries;
-	int no_progress_loops;
+	int reclaim_retries;
 	unsigned int cpuset_mems_cookie;
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
 
 restart:
 	compaction_retries = 0;
-	no_progress_loops = 0;
+	reclaim_retries = 0;
 	compact_priority = DEF_COMPACT_PRIORITY;
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	zonelist_iter_cookie = zonelist_iter_begin();
@@ -4390,7 +4390,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto nopage;
 
 	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
-				 did_some_progress > 0, &no_progress_loops))
+				 did_some_progress > 0, &reclaim_retries))
 		goto retry;
 
 	/*
@@ -4427,7 +4427,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	/* Retry as long as the OOM killer is making progress */
 	if (did_some_progress) {
-		no_progress_loops = 0;
+		reclaim_retries = 0;
 		goto retry;
 	}
 
-- 
2.17.1


