Return-Path: <linux-kernel+bounces-253572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C32932336
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2471F2381F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A480197A88;
	Tue, 16 Jul 2024 09:44:34 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140B19884B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123073; cv=none; b=RxvVfGEJTy1hgGuC757D83JZi7RSHAmXAxm+a+ARky/ItVSeJb2igIfGLIwz8sQxD7ZnB8vieVfDvlQOdgvtmpjblpaZAcuOFAJxeSmco3Vp8Y9Mob31vBmECGEfpZ6xvd+lHgP6XqoOo7nLmKHad7JyCE/AUVpLM3B2sXxYj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123073; c=relaxed/simple;
	bh=AaRySYf9zsmpura29YKROYSICIYrW+9IDE5VSrjWshI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BognoYmOvwyoUNL0xNyMj7ADlQ4KSv8/GA2VFomCzV04sNQVx08baB7WdXqH4PeAamnqgJD23HUYlY5KHe+tj/rPlfkQma0DizTa5pOMEqgN4XoOD+seH+JAkkYot9eioDOnVNhMWdtB0H9woN8OuWPWMSyX06Wzyzx4XPNqeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46G9huGX055900;
	Tue, 16 Jul 2024 17:43:56 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WNYsk3wkTz2KmSNc;
	Tue, 16 Jul 2024 17:38:34 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 16 Jul 2024 17:43:54 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCHv2] mm: introduce reclaim throttle in MGLRU
Date: Tue, 16 Jul 2024 17:43:48 +0800
Message-ID: <20240716094348.2451312-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 46G9huGX055900

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Being like legacy LRU management, direct reclaim threads could isolate
over-sized folios and then be rescheduled, which could lead to
unwanted generation update as well as the thrashing things like before.
This commit would like to have direct_reclaim be throttled by judging
the numbers of isolated and inactive folios.

This patch is verified by launching 8 costmem(malloc and access 1GB VM
in an 5.5GB v6.6 Android system) concurrently and got no system hang
any more(adb shell recovered in 10s which hanged 100% in mainline).

test script under Android14

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: fix a possible unpaired spin_lock/unlock and commit message
---
---
 mm/vmscan.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..13e5ed9060ad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4481,6 +4481,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	int scanned;
 	int tier = -1;
 	DEFINE_MIN_SEQ(lruvec);
+	bool stalled = false;
 
 	/*
 	 * Try to make the obvious choice first, and if anon and file are both
@@ -4503,6 +4504,16 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	else
 		type = get_type_to_scan(lruvec, swappiness, &tier);
 
+	spin_unlock_irq(&lruvec->lru_lock);
+	while (unlikely(too_many_isolated(lruvec_pgdat(lruvec), type, sc))) {
+		if (stalled) {
+			spin_lock_irq(&lruvec->lru_lock);
+			return 0;
+		}
+		reclaim_throttle(lruvec_pgdat(lruvec), VMSCAN_THROTTLE_ISOLATED);
+	}
+	spin_lock_irq(&lruvec->lru_lock);
+
 	for (i = !swappiness; i < ANON_AND_FILE; i++) {
 		if (tier < 0)
 			tier = get_tier_idx(lruvec, type);
@@ -4550,8 +4561,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
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


