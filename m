Return-Path: <linux-kernel+bounces-441556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4689ED018
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F361619C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35881D9A5F;
	Wed, 11 Dec 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9WYCmgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028A1DED63
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931678; cv=none; b=YMo6iYl1wsaf8rZoduRno+/LbZdddSIOyh8kVAsAn/Pip/b5ulXQbdTokA04Ev6J6RAuL03XsLG9oPfhIhUIdw9ouHQRRu3/GtW00GYJmj7GvMXu19fZytZkhdcJfqmNwFoq1YXM2LsWkP4w2Q7BMCBzKNnfaWbsHDg+1ufF8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931678; c=relaxed/simple;
	bh=suTQZYxIg8YKQDgrkF/Nr6nKfzRdV+Dy0JZZ2b4bJTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Guo5tP+oUMfj/VI/zGe6K9W9WdDjCH2BF5BQ7N3iwQriM1E6s2VoDC09p9eQWLuiYcasyLEFl6yRbTzlPfzcbzduRiQQ7B/zaF3KUjTgPkxWDeG38se4tVxWXvDK4ECZQhq4fsiuE1OJjEDlpmU6ifd2Ff1Fk5EQBaoHt+R48kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9WYCmgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70927C4CED7;
	Wed, 11 Dec 2024 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931678;
	bh=suTQZYxIg8YKQDgrkF/Nr6nKfzRdV+Dy0JZZ2b4bJTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9WYCmgxo2g6VtQBPGF75toF0DAsYCTyprqdP4MP/NL2WIApZWX+8uC1qH9sQ1YFW
	 v0y/ucaUndq8W/x+f1Q4cgbUtSg4zxiTNL7bcU+OEexhm+aII2nwqmXKZhl5fuWft/
	 oYJSOk3J2Vbvtq40KV4FImTLyFDGnLoTw64Bsu7uP2mqgYs/QG5SrvAfDzx0EOw8Uo
	 GwE42btpRiL/wjR3Iob8c8NqKwooftte+J87DnPtcu9yEJxo7/ta3eqkvxkBV2MG+S
	 745vWEMlgyYxNhaKejN77vOr5PpisfcJz8TCIyRhlGVTtyiMzo/gUbSXP2/GBZWb1g
	 zwFw/D33ikaZQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 14/19] mm: Create/affine kswapd to its preferred node
Date: Wed, 11 Dec 2024 16:40:27 +0100
Message-ID: <20241211154035.75565-15-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
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
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/vmscan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e3..ec4eab23fb19 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7182,10 +7182,6 @@ static int kswapd(void *p)
 	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-
-	if (!cpumask_empty(cpumask))
-		set_cpus_allowed_ptr(tsk, cpumask);
 
 	/*
 	 * Tell the memory management that we're a "memory allocator",
@@ -7354,13 +7350,15 @@ void __meminit kswapd_run(int nid)
 
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


