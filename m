Return-Path: <linux-kernel+bounces-331179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86797A964
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1691C27296
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD115FD16;
	Mon, 16 Sep 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhfUIBhA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DDB166302
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527010; cv=none; b=ghIWVcTO5nON1AEBz6zaPyBHRFDH4yrga4CKCmQT51cnhMzFZXjEuh68Jt2zIJxJwR8aQQ6MXxTDd0xViKIcFf1uPZLP9n7lt6g0kCsTmd2fk0XJLrsfsQBb7rglknB+2py5JN0bXUwO03IY87jk0zXw7BB0GCG8SdUNEC0c2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527010; c=relaxed/simple;
	bh=1dQPDIVHNJsgLLnrV38mW03au9nJKUebQ1/0avtuUj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+6zn94JzYmpNCwNcIe4h2h9+QmpmuvUAdNfFxdzq/9ZOPqiNg+ca/VGGIeVCcsigEgaRKDLRf/ui5zBylh14Mr6UO1noLxjtsQK1QBVM3o0CANFjIB+hDJi8zUxk9DGtGiul2T6Rz9mIiYYqzR6fUafInxIN9AICjA9amnV47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhfUIBhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD651C4CEC5;
	Mon, 16 Sep 2024 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726527008;
	bh=1dQPDIVHNJsgLLnrV38mW03au9nJKUebQ1/0avtuUj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhfUIBhAeAVryTWFiKasVSqw5MFlegVH7koZBy6i2ei3w5rs8Wnm9dgPRZQY4GDBn
	 4fl51kEz1frYX0j0VM2HioDgBcg+TJ0VbJNqf7v5DAUecT62MfuIu1iQ9MOXCqtyhz
	 kurDRtRmFVva0mvmG1HVc1GfZrty3Rw+4o7YdbDB/Z0BIzlxsgDu8eBec0XdMRcH8J
	 7I4B2oDHu940+26pUyy3x2sRof5wlBHNnu1AsPJqoY+hGfQRBpns2jzyH/9Z+OM1yl
	 M60rhPxS4I0t6UkNl5fbahTaUUHYUzC+ZRrQ2o6O7IKYV/JkFERinmCYez1pOlXFAE
	 jeMI4sONDWy7w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 13/19] mm: Create/affine kcompactd to its preferred node
Date: Tue, 17 Sep 2024 00:49:17 +0200
Message-ID: <20240916224925.20540-14-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916224925.20540-1-frederic@kernel.org>
References: <20240916224925.20540-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kcompactd is dedicated to a specific node. As such it wants to be
preferrably affine to it, memory and CPUs-wise.

Use the proper kthread API to achieve that. As a bonus it takes care of
CPU-hotplug events and CPU-isolation on its behalf.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/compaction.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index eb95e9b435d0..69742555f2e5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3179,15 +3179,9 @@ void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx)
 static int kcompactd(void *p)
 {
 	pg_data_t *pgdat = (pg_data_t *)p;
-	struct task_struct *tsk = current;
 	long default_timeout = msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC);
 	long timeout = default_timeout;
 
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-
-	if (!cpumask_empty(cpumask))
-		set_cpus_allowed_ptr(tsk, cpumask);
-
 	set_freezable();
 
 	pgdat->kcompactd_max_order = 0;
@@ -3258,10 +3252,12 @@ void __meminit kcompactd_run(int nid)
 	if (pgdat->kcompactd)
 		return;
 
-	pgdat->kcompactd = kthread_run(kcompactd, pgdat, "kcompactd%d", nid);
+	pgdat->kcompactd = kthread_create_on_node(kcompactd, pgdat, nid, "kcompactd%d", nid);
 	if (IS_ERR(pgdat->kcompactd)) {
 		pr_err("Failed to start kcompactd on node %d\n", nid);
 		pgdat->kcompactd = NULL;
+	} else {
+		wake_up_process(pgdat->kcompactd);
 	}
 }
 
@@ -3279,30 +3275,6 @@ void __meminit kcompactd_stop(int nid)
 	}
 }
 
-/*
- * It's optimal to keep kcompactd on the same CPUs as their memory, but
- * not required for correctness. So if the last cpu in a node goes
- * away, we get changed to run anywhere: as the first one comes back,
- * restore their cpu bindings.
- */
-static int kcompactd_cpu_online(unsigned int cpu)
-{
-	int nid;
-
-	for_each_node_state(nid, N_MEMORY) {
-		pg_data_t *pgdat = NODE_DATA(nid);
-		const struct cpumask *mask;
-
-		mask = cpumask_of_node(pgdat->node_id);
-
-		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
-			/* One of our CPUs online: restore mask */
-			if (pgdat->kcompactd)
-				set_cpus_allowed_ptr(pgdat->kcompactd, mask);
-	}
-	return 0;
-}
-
 static int proc_dointvec_minmax_warn_RT_change(const struct ctl_table *table,
 		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -3362,15 +3334,6 @@ static struct ctl_table vm_compaction[] = {
 static int __init kcompactd_init(void)
 {
 	int nid;
-	int ret;
-
-	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-					"mm/compaction:online",
-					kcompactd_cpu_online, NULL);
-	if (ret < 0) {
-		pr_err("kcompactd: failed to register hotplug callbacks.\n");
-		return ret;
-	}
 
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
-- 
2.46.0


