Return-Path: <linux-kernel+bounces-331180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C194997A965
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F2C286395
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD117BEB6;
	Mon, 16 Sep 2024 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEoC805W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2216F858
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527011; cv=none; b=eAjoMg8Mk62hRZ//78svtaEnAuWycerdXxAfINHn0NOUCbaMgf4dlS6ZGs29x+9LuZLl9aGWsaOwBHStcc9xAVlqzr7EZ1DY+8WEcQyYgv2camo/VtcCJSHrwNnK8JSBGNEZpIfG9td4yyTMX1SHFjyDoWcpn8hstZJGfXawVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527011; c=relaxed/simple;
	bh=G//HPzoeqfpZXKC5DLATLC3AcQAMDmNkHz7pJ7brv/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZdMUv9TLsrhHc9m7ceYnJsavhKBqWq8iVBJd2XuxmEFZMFkrOsELjiew3rMtoYSFqg4Gx5FhZvSZ6xJamhl5VuGIMSmsrF0viD09zoDLxD+hxbFzy1C0btIOYvC0Vx9NX8IPRD9KSWw/XhtJjYEXV5OBfkg9OKWTX/AB2ydv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEoC805W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41614C4CECF;
	Mon, 16 Sep 2024 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726527011;
	bh=G//HPzoeqfpZXKC5DLATLC3AcQAMDmNkHz7pJ7brv/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEoC805WXjqBDwxV7eq88XdBPgl/1Aao31aSAp9FLezKIHwvZEL3AKGDJ2vy2zjPT
	 lu51to/xU4m9d8gbzURHBNR24ECfrEl6uPBmhAJ8jiIDQK6w9NuMBoL94o6vkxVAyZ
	 a3Ik8JPEZ2YjOM7fC6rW1Gn27PvEH20ANr9DG/djdGmNPpSkgU262JHq4F476uw6zI
	 5nzOvJiviekib1ZPhByMT/8Kfz2tOlRfJQSIl62ae/YQ+wohPmqzbee9Ih/c8ihaAI
	 MFXNtAjBEI29GG7vYZEbn4d0evySHTlPDGNYaPXXUry2Ey1hQBT+GWGyp3fI29MXYm
	 KYkRAwyfS2m2Q==
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
Date: Tue, 17 Sep 2024 00:49:18 +0200
Message-ID: <20240916224925.20540-15-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916224925.20540-1-frederic@kernel.org>
References: <20240916224925.20540-1-frederic@kernel.org>
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

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/vmscan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd489c1af228..00a7f1e92447 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7139,10 +7139,6 @@ static int kswapd(void *p)
 	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-
-	if (!cpumask_empty(cpumask))
-		set_cpus_allowed_ptr(tsk, cpumask);
 
 	/*
 	 * Tell the memory management that we're a "memory allocator",
@@ -7311,13 +7307,15 @@ void __meminit kswapd_run(int nid)
 
 	pgdat_kswapd_lock(pgdat);
 	if (!pgdat->kswapd) {
-		pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
+		pgdat->kswapd = kthread_create_on_node(kswapd, pgdat, nid, "kswapd%d", nid);
 		if (IS_ERR(pgdat->kswapd)) {
 			/* failure at boot is fatal */
 			pr_err("Failed to start kswapd on node %d，ret=%ld\n",
 				   nid, PTR_ERR(pgdat->kswapd));
 			BUG_ON(system_state < SYSTEM_RUNNING);
 			pgdat->kswapd = NULL;
+		} else {
+			wake_up_process(pgdat->kswapd);
 		}
 	}
 	pgdat_kswapd_unlock(pgdat);
-- 
2.46.0


