Return-Path: <linux-kernel+bounces-341097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A247987B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F31F221C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BEC1B012D;
	Thu, 26 Sep 2024 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psM8YQFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D691B012A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390991; cv=none; b=gYGjZYuplyBGFGB/nQvW3hlBnfLalfpvsNYKiasOM9pbASHlL131d+1KkcopWhP7E1DVlM8Rv4XMoRkN47GzfnUUaAjyfyAUacqmFEl+dVBTwkIGerCvQvG6odLW4NP/l2l16ZVYhlevSCB87l1gsJhMsq/+TXrI8zb/SbdwCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390991; c=relaxed/simple;
	bh=7BtrEplH3qQrg9kZixHgQN9470zkhnd7tdHddmuV+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPctabkuGWUFG6gNZDf3lmOh0+dHWAf/hYo0H03YDFEvhhmvERq2MtbQ5TnEy/UNZJaz74Cu2K9/yYBXgnq30uyKOkqkNsEuhof0AX5qGLAw45FBhPcjRkptMFwlHGRaGleuT3XhwqFbrNKmyaEgsD7EzVCwv2bLwgZu4gngsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psM8YQFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F665C4CED0;
	Thu, 26 Sep 2024 22:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390991;
	bh=7BtrEplH3qQrg9kZixHgQN9470zkhnd7tdHddmuV+9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psM8YQFN5mZ3FzBukGKWEToWhZzCosyMS0j5KLWvaT8kWVGcT5tEVHkD15uycwmmo
	 tJ1LttkAxj4ZweWz/08s7Kgrwh2kGdoUVn4gLfJeqPwS+NB/xmOBSSQswp/UECwOIh
	 ImitrWdjMszxOjTusfjUOiF5fXo5SsImb1ftjw8izmEPoA7IYlRPXVL1aPmEFgkVha
	 uz9CHu3SywKw1F3hqctu0GEWLSFVSBAT7sCkOes64A/1ubJODn4AmG897NX7CnsoNf
	 6WWjkBU5HcTp5GdJ+RK/iH5GUuE618/1yJujZ9W5ZMCLOA21ySARoJat1rQNAlhCN2
	 tJrXoHP8jA27g==
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
Subject: [PATCH 14/20] mm: Create/affine kcompactd to its preferred node
Date: Fri, 27 Sep 2024 00:49:02 +0200
Message-ID: <20240926224910.11106-15-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
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


