Return-Path: <linux-kernel+bounces-236374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96891E148
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467D1B223BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08AE15ECEA;
	Mon,  1 Jul 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bs/kJmZq"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0915ECE4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841967; cv=none; b=kMJE52hpPkSHP57aC1UOkh1SlpfP3pzddUg6EOer2eoZeS/vhs+neCsOOjyHYsIp7xtzOsZAXCUiJJlKAES4tLxLvexO6w+WSW6LAh4jw0K1LTgvCJtFNB1TQuRA37nRjPZjLQ1NS3+cjxyRmYfNM3w5ANwMYqcdAR7oUYLpvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841967; c=relaxed/simple;
	bh=oZfktzUPI3IvvgR/NIDhpEaqQ3nKMo0bcmqAq2UgUnQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fzDqEU8cHq6QZ8D0VUw9LW1cJBEsYRAC902XXCSzQHSkK33p5dZ5MlvYzPk2SMJPi3x8adwfz6knbnCkejH/k58PBjfijelEjkL8WZAnOw+tbSWzA7fQwGhWyZzts13ahQXTYOMT2yP/ZVSbPSb/iU0D7fJxqiEk8NQ0N1Te0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bs/kJmZq; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=I7dexkcSvfu0hWvkAL
	sE+VerRAaqIqAKgBZEe4vrhOo=; b=bs/kJmZqcYUjdq6yhWqM2bBCWolOeeL+8M
	iDhNvO6nytk2ZjCuM4UlFr4QIqsuz7E13FaFytweFmE877YJkuHhsqb8juNhBh0n
	us7gYKyupiWcHj0DdYgpXsPpKDMLiZGIJk24bXtZ7R0UI8qt2MzxfAX8KLzYTAMj
	9Wnrx0TgM=
Received: from localhost.localdomain (unknown [120.229.10.135])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDnFxSDtIJmmQfdBA--.47600S2;
	Mon, 01 Jul 2024 21:52:04 +0800 (CST)
From: "yongfa.hu" <hushange@163.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hushange@163.com
Subject: [PATCH] mm: rename no_progress_loops to reclaim_retries
Date: Mon,  1 Jul 2024 21:51:50 +0800
Message-Id: <20240701135150.24623-1-hushange@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnFxSDtIJmmQfdBA--.47600S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrWxury3CFWUtFyDuF18Grg_yoW5XrWxpF
	4xu3W7KrZYvFnxtFZ5Aa109F18A3s7KFZ8Xr1fKryxZw1fJry29rW7Kry2vF18XF4DXayY
	qFZ8Ar40grn8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUeCJkUUUUU=
X-CM-SenderInfo: xkxvxtxqjhqiywtou0bp/1tbiLxMLnmVOEj4DuwACsU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

variable no_progress_loops exectly means reclaim retry counts,
renameing makes it easier to understand. and has the same style
as variable compaction_retries.

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


