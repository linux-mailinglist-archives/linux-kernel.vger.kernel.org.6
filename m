Return-Path: <linux-kernel+bounces-574848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79013A6EAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6516A060
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD989225410;
	Tue, 25 Mar 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TfdPq0JA"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238F25776
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888337; cv=none; b=iIYkoCQdktToCPmkQviB/L463V3J4UINuI7UuJfYiUj+n4TsRc5eu4trJ80DUSNCfIBWmDjvgEK+rOkCZP3DQyIcg5UDcYQoABKlPgOIVLhzdNs7zIdRAJzHzKTi48MoKN4gln1Y5CRIwxQq57vR52TRuXGc44cKtTVM5VG21uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888337; c=relaxed/simple;
	bh=OrqPIgW6wKqiMBeDwqznevoSR4HYkl3CaCBU34Axc+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPfdw/r3yZJApPl7v6w17xZW8ean3QW2WelVcsXc6WS3sYHmrB7mnN/OgCbKTQ8zb8A/yh5cb+im7LBiATUT7zgm5udLEhSvXkoDFF9wFiWpTvY+tANOiX0SKaa4JLtUCAoItKRMLAMI3sC5ksu3FCMasz30gpndMEyTR5YH/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TfdPq0JA; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742888332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0qYHm+OPT6IV7+LE22/Lp+MT8DP0sV63My/n7IOeY/A=;
	b=TfdPq0JAGCc74oiJ/LrPNg5urNEWTRvjtFTXk8beTBmt/F6+g8g4XAx1cQ4aoI55eaBqNf
	MZ+xxuCvph9rHOijiUbNLlOKZH01seZttbMYxyIT9fXG6T3k1T4J6XEEzixA8Edp9mX7oV
	znOLPkIb8X3SASnbCAGiqPXgLK8x1pQ=
From: Ye Liu <ye.liu@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH] mm/show_mem: Optimize si_meminfo_node by reducing redundant code
Date: Tue, 25 Mar 2025 15:38:03 +0800
Message-Id: <20250325073803.852594-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Refactors the si_meminfo_node() function by reducing redundant code and
improving readability.

Moved the calculation of managed_pages inside the existing loop that
processes pgdat->node_zones, eliminating the need for a separate loop.

Simplified the logic by removing unnecessary preprocessor conditionals.

Ensured that both totalram, totalhigh, and other memory statistics are
consistently set without duplication.

This change results in cleaner and more efficient code without altering
functionality.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/show_mem.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 6af13bcd2ab3..ad373b4b6e39 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -94,26 +94,20 @@ void si_meminfo_node(struct sysinfo *val, int nid)
 	unsigned long free_highpages = 0;
 	pg_data_t *pgdat = NODE_DATA(nid);
 
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
-		managed_pages += zone_managed_pages(&pgdat->node_zones[zone_type]);
-	val->totalram = managed_pages;
-	val->sharedram = node_page_state(pgdat, NR_SHMEM);
-	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
-#ifdef CONFIG_HIGHMEM
 	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
 		struct zone *zone = &pgdat->node_zones[zone_type];
-
+		managed_pages += zone_managed_pages(zone);
 		if (is_highmem(zone)) {
 			managed_highpages += zone_managed_pages(zone);
 			free_highpages += zone_page_state(zone, NR_FREE_PAGES);
 		}
 	}
+
+	val->totalram = managed_pages;
+	val->sharedram = node_page_state(pgdat, NR_SHMEM);
+	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
 	val->totalhigh = managed_highpages;
 	val->freehigh = free_highpages;
-#else
-	val->totalhigh = managed_highpages;
-	val->freehigh = free_highpages;
-#endif
 	val->mem_unit = PAGE_SIZE;
 }
 #endif
-- 
2.25.1


