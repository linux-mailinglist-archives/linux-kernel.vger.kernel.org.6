Return-Path: <linux-kernel+bounces-278224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB994AD95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDAD282384
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A510313A258;
	Wed,  7 Aug 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD7vQZYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43091459FA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046595; cv=none; b=k46pj3UVFTp2DpuNtcpkkJKLsnGTdcbQgJB0A0pXJLvEUFrtts6angtBGe2peUW2ldGytRvg1p+jle4etEpLPMBRAS4x/DZVIVNPv1sYWm+EYtOoaZAfNYi+pmwsbH50ZgZvpyieewWpqMDQQtExkZxdGR/t5wX29UzMuA4kpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046595; c=relaxed/simple;
	bh=xXlA9TsBfLiZ6uqDZSI4IFNRA0ULAk2nFj22IYy8NJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rm+b+I+Ye135Ry+xXyjtUn5fU8O82jr7ccG8jlYonHNSIEieT5I2kRu5q+4yI7N6yrpSa4rfkVEL3+biSn/y3dOW/6v9rSqruhOQT/EX2smxQRq9M+ILtzWIxFBy7zOxObbeRLtdLMow2oMUI4M14YaCZb70xFAM3U3sadeLYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD7vQZYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D93C4AF0D;
	Wed,  7 Aug 2024 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046594;
	bh=xXlA9TsBfLiZ6uqDZSI4IFNRA0ULAk2nFj22IYy8NJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mD7vQZYkIYLdPn0xySeUGYafRgjLTexhWaSL7sKgQvDPOmmhN/Bott9ekQBM0u04T
	 IoOWeFPUGNXSJs3kXOIIsrxRqixyd4YOd1Lp/vdX1WRU4HUYkAx5SbndG48ydUdp1W
	 uHGVO1EjtNdWlw0lWqVdj9ZJjAGMxjXvLyFjk6ZODGzQNO6gOhuS8AVNnbJfwZ9EGK
	 gkdpCgAN9oQNaDoq6XZBOZQ5tyWlxjcmQdoVbD8ZO4S1N2WcKeXUWsZP7qZHiWDRAG
	 9G3HPgX1cUA7c+S0hRShqdmm+SeN0UA+R59lBlihoHIXxFCFkGx+LCKzKlsGA+s8HD
	 hpWMCFQxPYXuw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 14/19] mm: Create/affine kswapd to its preferred node
Date: Wed,  7 Aug 2024 18:02:20 +0200
Message-ID: <20240807160228.26206-15-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160228.26206-1-frederic@kernel.org>
References: <20240807160228.26206-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kswapd is dedicated to a specific node. As such it wants to be
preferrably affine to it, memory and CPUs-wise.

Use the proper kthread API to achieve that. As a bonus it takes care of
CPU-hotplug events and CPU-isolation on its behalf.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/vmscan.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cfa839284b92..b8ee3bf8fa29 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7159,10 +7159,6 @@ static int kswapd(void *p)
 	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-
-	if (!cpumask_empty(cpumask))
-		set_cpus_allowed_ptr(tsk, cpumask);
 
 	/*
 	 * Tell the memory management that we're a "memory allocator",
@@ -7331,7 +7327,7 @@ void __meminit kswapd_run(int nid)
 
 	pgdat_kswapd_lock(pgdat);
 	if (!pgdat->kswapd) {
-		pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
+		pgdat->kswapd = kthread_create_on_node(kswapd, pgdat, nid, "kswapd%d", nid);
 		if (IS_ERR(pgdat->kswapd)) {
 			/* failure at boot is fatal */
 			pr_err("Failed to start kswapd on node %d，ret=%ld\n",
@@ -7339,6 +7335,7 @@ void __meminit kswapd_run(int nid)
 			BUG_ON(system_state < SYSTEM_RUNNING);
 			pgdat->kswapd = NULL;
 		}
+		wake_up_process(pgdat->kswapd);
 	}
 	pgdat_kswapd_unlock(pgdat);
 }
-- 
2.45.2


