Return-Path: <linux-kernel+bounces-406032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229D59C5A42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3A72811DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1B200C90;
	Tue, 12 Nov 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwym0DBh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D491FEFA8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421416; cv=none; b=rc0rrmovpfYNmCNicdi+fN6fcNS4kaPE92KNrNqyZuOKneAX1nI7ceRcZPAKz0okZ7q9jjSrcaLItD4vgScVMPCCAUe1Cc0ODXmRSsqimqXHEI2hmQXj0iqMEdRs2GO0cNKzG+mY8E/uaMjHC75fsrWmoKk+rKoYxNVHxGHVcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421416; c=relaxed/simple;
	bh=7BtrEplH3qQrg9kZixHgQN9470zkhnd7tdHddmuV+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVK3S9zAvcWLwClK5R1/HJiWaBF4pW4q9MVQgezZrmIG46PKKl5165Xi1F83i2ihe1KDUBgjxw5gv2ZHaoqsIgGl40PzotcU6HAPZW39jbQmrWeGwau8iejK7ye4wmXaqUpuBjoBC3FgbaGvFryOg9IMDapoGVkjQy0QxoM5Vwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwym0DBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AD8C4CECD;
	Tue, 12 Nov 2024 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421416;
	bh=7BtrEplH3qQrg9kZixHgQN9470zkhnd7tdHddmuV+9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nwym0DBhhcTIwnkBrtiXN0Zp9WMkosF7kKibRx7BQA2VpqG9VTmW7/kNN32GigUWh
	 eGEyA7c0DhVnewNn5JsR7G4Y/OS87vA3OTF+26Cyk9BPin48X3G26F0212UQzRdxs5
	 2fF4KMleehk7g1LT102UKvgu3K+Kgb+CRtd8OYe5N8PsO8gmkRaDdYTQOHPDuYoLnH
	 uUCMVkYtOmeqfNL3fXTDdopjA1jGPL9L7PaS1xyiXrP/Maw2ThvyAqaxbOsjspiRgA
	 QaWbRGasHp2OEqfAng5Ky7fOBZL8hRp0+PYYsUFsd6A984tK0DIanGey074Rcajr58
	 AE9BAL0WVPomQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 15/21] mm: Create/affine kcompactd to its preferred node
Date: Tue, 12 Nov 2024 15:22:39 +0100
Message-ID: <20241112142248.20503-16-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
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
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/compaction.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a2b16b08cbbf..a31c0f5758cf 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3154,15 +3154,9 @@ void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx)
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
@@ -3233,10 +3227,12 @@ void __meminit kcompactd_run(int nid)
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
 
@@ -3254,30 +3250,6 @@ void __meminit kcompactd_stop(int nid)
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
@@ -3337,15 +3309,6 @@ static struct ctl_table vm_compaction[] = {
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


