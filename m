Return-Path: <linux-kernel+bounces-225526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C11A9131C8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403351C219A9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9178F5B;
	Sat, 22 Jun 2024 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AWiB9So9"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF58C09
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719026953; cv=none; b=OVPGEvH3ssM8nDWq9MCN9KlXQiUmIlAa84ZSodwpHk6o2+za+4Y6UtmZcWlgkd6nSyDcXAUibY/z71UlGkapSNG67iNUqo4/oaRjmbpWuRYPuUKQ0AkV6MQ0qaqGVdMVhHX6uLhtBKlMIFG7kPtZvpBWsnrcPw62IG/Fgu9pgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719026953; c=relaxed/simple;
	bh=BMw5JAzkP46NHEAdfpVxC+yvO2GvFSbohkUjQ+PGMyc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oZTcv4nuh86s0tIHFfCOQRPukaUFK/PWcb7Iimfh+GFNFA0PumYg0pTY/koRDu0191d9lfuW07ZhU7DRHPhNUfl07tSmNVdfe/Z0+cIylwBLzMghs1+1iFs8YpA2q+tApwNwVdimARf2zB8luDYLWB+qmtoUdal4PFjiyJoHgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AWiB9So9; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=lIGxqX9x+SGOnQIbd5
	VQLVmLF3zctLikoC965VXpZOc=; b=AWiB9So9B+6nRX3D0g9qlRUW1XrdR29XZx
	GozJXLFbY34FGVOYak6tckCArfKSafYFjqnTyxEGdcKtZ9PQuOGyHQ9EFLZ1O2GT
	vnQZVC0RPclEg+n/MBlb1ze8slxSlQGRiiExT2EbS+y1JBS+XeQB6gvPpjA02AIY
	CL7fraw60=
Received: from localhost.localdomain (unknown [120.229.10.157])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3_xjaRHZm8F+GBw--.59538S2;
	Sat, 22 Jun 2024 11:28:27 +0800 (CST)
From: "yongfa.hu" <hushange@163.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hushange@163.com
Subject: [PATCH] mm: rename no_progress_loops to reclaim_retries. variable no_progress_loops exectly means reclaim retry counts, renameing makes it easier to understand. and has the same style as variable compaction_retries.
Date: Sat, 22 Jun 2024 11:28:17 +0800
Message-Id: <20240622032817.24064-1-hushange@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3_xjaRHZm8F+GBw--.59538S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4kCr4DAFWrXF1fCF4kZwb_yoW5Jw4fpF
	4xu3ZrGrZYqFnxJFZ5Aa109F18A3s7KFZ8Xr1xKryxZw1fJrya9rW7Kry2vF18XF4DXayY
	vFs8Ar40grn8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRo5lbUUUUU=
X-CM-SenderInfo: xkxvxtxqjhqiywtou0bp/1tbiLxwGnmVOEcRDEgAAsE
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


