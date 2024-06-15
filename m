Return-Path: <linux-kernel+bounces-215767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899249096CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D561F22ABF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AD18638;
	Sat, 15 Jun 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DG1usZIT"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6D17C8D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439193; cv=none; b=C0S5/5In16vT1aegiAMosAAZ/g1+AaQ0BvRx6YKvMGamHWij/Qn+XCDBT9CvoA8nRiVtn4ALpXDQydamw89d83ozgCf4WwOGI87fg534NMl/gN+gJepueWByVv6nORxnWd/j0vMPIS+UhTqFNbsnkqgbiuZ8Ho1ynPYD0HwqfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439193; c=relaxed/simple;
	bh=3ACpS9KjoGNBwd3Y4kjm8V6B0xgL1wsK3QBEDIP40K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLN6G3w9cbhHh5721Z951Px8tB+YfS+g67kERFjvw1na4hsNKXw8atgOYHfIPUrgRGbfhP0DTe6PX32Ql6txT2C8NNFQLqRTcTPdhiovcWEgrcBZ/SwOQH4cB3NOZToa6cRFZoXJheDm9lxlZeJ6nfr3c4RXXp/CZNx/XWkZfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DG1usZIT; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718439189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jxg5iGIBzjKKqOE5wby7nB9Gf0RymHtTU7fYqI4F+Xs=;
	b=DG1usZITPymN0SlTEM3Q6jayWvQCADocjZqcuCKEp0kDmOE+15ngQnACof3b5k6yXW+tw7
	LbnSIxp2RWzO2YDZKRBKn+xplpxnCF6/wE4O7jnQspLRwJpjZn6nV4KioEB2oHCEZ2Vn1l
	ZUeMQc/spEe22ZuMj5sReeChPnVIgRo=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@suse.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: hawk@kernel.org
X-Envelope-To: yuzhao@google.com
X-Envelope-To: songmuchun@bytedance.com
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Facebook Kernel Team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memcg: use ratelimited stats flush in the reclaim
Date: Sat, 15 Jun 2024 01:12:57 -0700
Message-ID: <20240615081257.3945587-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The Meta prod is seeing large amount of stalls in memcg stats flush
from the memcg reclaim code path. At the moment, this specific callsite
is doing a synchronous memcg stats flush. The rstat flush is an
expensive and time consuming operation, so concurrent relaimers will
busywait on the lock potentially for a long time. Actually this issue is
not unique to Meta and has been observed by Cloudflare [1] as well. For
the Cloudflare case, the stalls were due to contention between kswapd
threads running on their 8 numa node machines which does not make sense
as rstat flush is global and flush from one kswapd thread should be
sufficient for all. Simply replace the synchronous flush with the
ratelimited one.

One may raise a concern on potentially using 2 sec stale (at worst)
stats for heuristics like desirable inactive:active ratio and preferring
inactive file pages over anon pages but these specific heuristics do not
require very precise stats and also are ignored under severe memory
pressure. This patch has been running on Meta fleet for more than a
month and we have not observed any issues. Please note that MGLRU is not
impacted by this issue at all as it avoids rstat flushing completely.

Link: https://lore.kernel.org/all/6ee2518b-81dd-4082-bdf5-322883895ffc@kernel.org [1]
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c0429fd6c573..bda4f92eba71 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2263,7 +2263,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats(sc->target_mem_cgroup);
+	mem_cgroup_flush_stats_ratelimited(sc->target_mem_cgroup);
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
-- 
2.43.0


