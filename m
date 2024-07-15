Return-Path: <linux-kernel+bounces-252364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DB393123C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FC81C226C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94C187559;
	Mon, 15 Jul 2024 10:24:24 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FC16CD36
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039064; cv=none; b=Bp3u0xu+YN6wY07x+yklM1rXaavm3NngUrNBgy2oV7e3+kduUyQ6k53fvemji+bL7nlYfHB+K/erNLzJikCJ47U8QWSkfodXN++4tuQJghcDfzs/x3ROqhhVDPqZ+jhNtMMgaF2yy4V9iRQU7sTC57krOn04Yn4igywoySJyBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039064; c=relaxed/simple;
	bh=1COjcnseOvJi+7+VS8eypiD4hYhv/caSJY8K5KQLDwM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IkhT3r/QpjucTE+PxRelrV6je5/lrpvGdAr3aFLUlT3PrNv4ud5urBi7MBUDjPMcdZmjAqlsbI2CPruzIK8OXbmmUbSfBSlAHcIOBylcosDv+E9XX1V48W0g5FQdDSjZ5pp06kv2nysWJ4nwk8nw81Mq6pX7VcjBVe6sZaA3AXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46FAK3YJ063713;
	Mon, 15 Jul 2024 18:20:03 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WMyjv2lsgz2KfjQx;
	Mon, 15 Jul 2024 18:14:43 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 15 Jul 2024 18:20:01 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH] mm: introduce reclaim throttle in MGLRU
Date: Mon, 15 Jul 2024 18:19:54 +0800
Message-ID: <20240715101954.2433102-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 46FAK3YJ063713

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Being like legacy LRU management, direct reclaim threads could isolate
over-sized folios and then be rescheduled, which could lead to
unwanted generation update as well as the thrashing things like before.
This commit would like to have direct_reclaim be throttled by judging
the numbers of isolated and inactive folios.

This patch is proved to be helpful by launching 8 costmem(an exe in Android)
concurrently and got no system hang like before.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..a7fdad1b2a78 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4481,6 +4481,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	int scanned;
 	int tier = -1;
 	DEFINE_MIN_SEQ(lruvec);
+	bool stalled = false;
 
 	/*
 	 * Try to make the obvious choice first, and if anon and file are both
@@ -4503,6 +4504,14 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	else
 		type = get_type_to_scan(lruvec, swappiness, &tier);
 
+	spin_unlock_irq(&lruvec->lru_lock);
+	while (unlikely(too_many_isolated(lruvec_pgdat(lruvec), type, sc))) {
+		if (stalled)
+			return 0;
+		reclaim_throttle(lruvec_pgdat(lruvec), VMSCAN_THROTTLE_ISOLATED);
+	}
+	spin_lock_irq(&lruvec->lru_lock);
+
 	for (i = !swappiness; i < ANON_AND_FILE; i++) {
 		if (tier < 0)
 			tier = get_tier_idx(lruvec, type);
@@ -4550,8 +4559,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	if (list_empty(&list))
 		return scanned;
 retry:
+	__mod_node_page_state(lruvec_pgdat(lruvec), NR_ISOLATED_ANON + type, scanned);
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
 	sc->nr_reclaimed += reclaimed;
+	__mod_node_page_state(lruvec_pgdat(lruvec), NR_ISOLATED_ANON + type, -scanned);
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
 			scanned, reclaimed, &stat, sc->priority,
 			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
-- 
2.25.1


