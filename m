Return-Path: <linux-kernel+bounces-356462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E499616A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8626828683F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC686185B6D;
	Wed,  9 Oct 2024 07:51:00 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C917C7A3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460260; cv=none; b=cXbFPCt8yz1LyJf8xdIzQrgvuVAPrgtnXl8aenGnwZyckuFpuZw3V8s9MPMd+8g3LlcRXIsVtQoxdy2PNy7f8k0+LVIxwg+oiSW9jmNXHhknag+ic5CU6AtGHuehT6ogkUtLR/bzDvKWjPqOtz46PqWR4DIkDSQxsY1D1guq/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460260; c=relaxed/simple;
	bh=6OOVqlOk9icEHZcCVArVCU/dmE92U6L/nULwjwBah7I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQp54G7gWGFR56CXTJuAIdw3VmQ2sogo5Gnd+zg0qQnAqJdTTocPgLr+hsRK/SADmMPV2DWZAVIDJ5xiR6mTsB/fX4ZmASzSDPLvsxrcxvPorBYSdDb69inTB4xMCvXNVRQ1NQ6g/ikMXqWm8Pbek+Wup51qCLCVqhmWAhShmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4997oJR8056751;
	Wed, 9 Oct 2024 15:50:19 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XNlG63rdRz2PD1VF;
	Wed,  9 Oct 2024 15:42:06 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 9 Oct 2024 15:50:16 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] mm: throttle and inc min_seq when both page types reach MIN_NR_GENS
Date: Wed, 9 Oct 2024 15:49:53 +0800
Message-ID: <20241009074953.608591-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4997oJR8056751

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

The test case of [1] leads to system hang which caused by a local
watchdog thread starved over 20s on a 5.5GB RAM ANDROID15(v6.6)
system. This commit solve the issue by have the reclaimer be throttled
and increase min_seq if both page types reach MIN_NR_GENS, which may
introduce a livelock of switching type with holding lruvec->lru_lock.

[1]
launch below script 8 times simutanously which allocates 1GB virtual
memory and access it from user space by each thread.
$ costmem -c1024000 -b12800 -o0 &

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cfa839284b92..83e450d0ce3c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4384,11 +4384,23 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	int remaining = MAX_LRU_BATCH;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
 	VM_WARN_ON_ONCE(!list_empty(list));
 
-	if (get_nr_gens(lruvec, type) == MIN_NR_GENS)
-		return 0;
+	if (get_nr_gens(lruvec, type) == MIN_NR_GENS) {
+		/*
+		 * throttle for a while and then increase the min_seq since
+		 * both page types reach the limit.
+		 */
+		if (get_nr_gens(lruvec, !type) == MIN_NR_GENS) {
+			spin_unlock_irq(&lruvec->lru_lock);
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED);
+			spin_lock_irq(&lruvec->lru_lock);
+			try_to_inc_min_seq(lruvec, get_swappiness(lruvec, sc));
+		} else
+			return 0;
+	}
 
 	gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
-- 
2.25.1


