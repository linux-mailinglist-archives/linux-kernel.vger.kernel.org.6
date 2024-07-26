Return-Path: <linux-kernel+bounces-263781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34F093DA66
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F08A1C23353
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1254215921B;
	Fri, 26 Jul 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKF0qw8o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4D158DAC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031060; cv=none; b=bJ5DpKnEJNuBByhwVh6v7xvucW1SuiTjbqqeaDRIRqGIlwC/u9szXOZXzh1i7DvnL457rjMHtaAhARgMvjPx8vg2nSw/a+hNUSpQ+ociDyJPdcjKI7L0rcjwkAU2WSALvdxom9OuZzv+vOwZ720KECLmiVGkCcK/4IGpQXODwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031060; c=relaxed/simple;
	bh=Rndu056GW69+sdbAKM3F/CfIuWiCWMVJcK3IHpS2rDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP5UO36U6nCkywzf8BJQylSDQvygkOssCTnvP9ApqwEyGF0OVBm539NijDNqewrzVMpfqFJwPMpGOAtiMUGmeDkmbGM1qo1SyHWSdh6rHPGhbIp+xbSyowC5lL339gqFaMD5maOfSUPQiUKXsGG72jbyBlnVArp7D75+ZtXVJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKF0qw8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB2C4AF0E;
	Fri, 26 Jul 2024 21:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031059;
	bh=Rndu056GW69+sdbAKM3F/CfIuWiCWMVJcK3IHpS2rDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKF0qw8oA9DB/ULKFIjWqBbIOivCNKNnP+icJQt71lrPxYLykaWaAGlKghIpOZukx
	 fb58LWldjmjvwQJ8wN4PuM2kjFU9SJrJ0EQAa5gu2Y6Y6vor0u0/bX79kSl5BiQouI
	 izJpmQ21q4aeCG1vc1o7OLlVRd41dYSzwgoq6ZMqQj4V1yb4DnBw3ecF9leZKgYXsx
	 vV6HUhfxUkd+67VNqXhahAUB071lXMNcM8UxLLi/e8aPVCHWvrijo96H21LzJW8fZY
	 zUAm9K9yimYovCNXHgUrc0q0g0ZhyzvyFhcNRS66sqXsaIdUtmQc8VnJ1pN3JpEHYu
	 zVLO0zCMmrnRA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 13/20] mm: Make Kcompactd use kthread's preferred affinity
Date: Fri, 26 Jul 2024 23:56:49 +0200
Message-ID: <20240726215701.19459-14-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that kthreads have an infrastructure to handle preferred affinity
against CPU hotplug and housekeeping cpumask, convert Kcompactd to use
it instead of handling halfway all the constraints by itself.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/compaction.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 739b1bf3d637..64a6486f06e1 100644
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
@@ -3258,11 +3252,13 @@ void __meminit kcompactd_run(int nid)
 	if (pgdat->kcompactd)
 		return;
 
-	pgdat->kcompactd = kthread_run(kcompactd, pgdat, "kcompactd%d", nid);
+	pgdat->kcompactd = kthread_create(kcompactd, pgdat, "kcompactd%d", nid);
 	if (IS_ERR(pgdat->kcompactd)) {
 		pr_err("Failed to start kcompactd on node %d\n", nid);
 		pgdat->kcompactd = NULL;
 	}
+	kthread_affine_preferred(pgdat->kcompactd, cpumask_of_node(pgdat->node_id));
+	wake_up_process(pgdat->kcompactd);
 }
 
 /*
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
 static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
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
2.45.2


