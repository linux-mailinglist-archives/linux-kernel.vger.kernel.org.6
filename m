Return-Path: <linux-kernel+bounces-188273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57A8CDFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE531C22252
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0037707;
	Fri, 24 May 2024 03:44:24 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D83218B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522264; cv=none; b=RJuajBi/cz2EOe26Sapky41MyxHzZZC9t3Ff3WicL1KId0HlcZieq0WIVb2O1jewsM53RYSTyjDJ3Xsvjb8KuHtDZHAXiUudwDmAPeiTLOXsncZ4gGfyNpfWaFBswtLcQe1V0zzGnpy08Px7tUoP9pXY7YCx96D526UKRLSoDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522264; c=relaxed/simple;
	bh=klsTIeFbdYfDx4VJSsLFgsWBOMnxnPJz0jKegjHG1J8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q2sNN/wvf8fzdmKtse6xBnv+qJgqrv813jjOTRIvjx9b/VeWzp17xV2v93d4CnrMczjEarbYTc6tJFI7wkV0orZdoIJ8Mb2wWEE2OEve8RhNwNBJJa0Wk3GC1Bmmym4wjMh34UeMCiqAWA+rf51QksK/x8jKldELPSvkso0cngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VlrQW3t8lzjZC5;
	Fri, 24 May 2024 11:40:03 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (unknown [7.185.36.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D2B3140109;
	Fri, 24 May 2024 11:44:18 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.53) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 24 May 2024 11:44:17 +0800
From: Zhao Wenhui <zhaowenhui8@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <zhaowenhui8@huawei.com>, <tanghui20@huawei.com>
Subject: [PATCH] sched/rt: Fix rt_runtime leaks with cpu hotplug and RT_RUNTIME_SHARE
Date: Fri, 24 May 2024 03:42:27 +0000
Message-ID: <20240524034227.1871565-1-zhaowenhui8@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)

When using cgroup rt_bandwidth with RT_RUNTIME_SHARE, if there are cpu
hotplug and cpu.rt_runtime_us changing concurrently, the warning in
__disable_runtime may occur:
[  991.697692] WARNING: CPU: 0 PID: 49573 at kernel/sched/rt.c:802
rq_offline_rt+0x24d/0x260
[  991.697795] CPU: 0 PID: 49573 Comm: kworker/1:0 Kdump: loaded Not
tainted 6.9.0-rc1+ #4
[  991.697800] Workqueue: events cpuset_hotplug_workfn
[  991.697803] RIP: 0010:rq_offline_rt+0x24d/0x260
[  991.697825] Call Trace:
[  991.697827]  <TASK>
[  991.697858]  set_rq_offline.part.125+0x2d/0x70
[  991.697864]  rq_attach_root+0xda/0x110
[  991.697867]  cpu_attach_domain+0x433/0x860
[  991.697880]  partition_sched_domains_locked+0x2a8/0x3a0
[  991.697885]  rebuild_sched_domains_locked+0x608/0x800
[  991.697895]  rebuild_sched_domains+0x1b/0x30
[  991.697897]  cpuset_hotplug_workfn+0x4b6/0x1160
[  991.697909]  process_scheduled_works+0xad/0x430
[  991.697917]  worker_thread+0x105/0x270
[  991.697922]  kthread+0xde/0x110
[  991.697928]  ret_from_fork+0x2d/0x50
[  991.697935]  ret_from_fork_asm+0x11/0x20
[  991.697940]  </TASK>
[  991.697941] ---[ end trace 0000000000000000 ]---

That's how it happens:
CPU0                                   CPU1
-----                                  -----

set_rq_offline(rq)
    __disable_runtime(rq) (1)
                                      tg_set_rt_bandwidth (2)
                                      do_balance_runtime  (3)
set_rq_online(rq)
    __enable_runtime(rq)  (4)

In step(1) rt_rq->rt_runtime is set to RUNTIME_INF, and this rtrq's
runtime is not supposed to change until its rq gets online. However,
in step(2) tg_set_rt_bandwidth can set rt_rq->rt_runtime to
rt_bandwidth.rt_runtime. Then, in step(3) rtrq's runtime is not
RUNTIME_INF, so others can borrow rt_runtime from it. Finally, in
step(4) the rq gets online, so its rtrq's runtime is set to
rt_bandwidth.rt_runtime again, and Since then the total rt_runtime in
the domain is increased by this way. After these steps, when offline cpu,
rebuilding the sched_domain will offline all rq, and the last rq will
find the rt_runtime is increased but nowhere to return.

To fix this, we can add a state RUNTIME_DISABLED, which means the runtime
is disabled and should not be used. When rq get offline, we can set its
rtrq's rt_runtime to RUNTIME_DISABLED, and when rq get online, reset it.
And in tg_set_rt_bandwidth and do_balance_runtime, never change a
disabled rt_runtime.

Fixes: 7def2be1dc67 ("sched: fix hotplug cpus on ia64")
Closes: https://lore.kernel.org/all/47b4a790-9a27-2fc5-f2aa-f9981c6da015@huawei.com/
Co-developed-by: Hui Tang <tanghui20@huawei.com>
Signed-off-by: Hui Tang <tanghui20@huawei.com>
Signed-off-by: Zhao Wenhui <zhaowenhui8@huawei.com>
---
 kernel/sched/rt.c    | 15 +++++++++------
 kernel/sched/sched.h |  5 +++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index aa4c1c874fa4..44b8cc5a2f5f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -704,7 +704,8 @@ static void do_balance_runtime(struct rt_rq *rt_rq)
 		 * or __disable_runtime() below sets a specific rq to inf to
 		 * indicate its been disabled and disallow stealing.
 		 */
-		if (iter->rt_runtime == RUNTIME_INF)
+		if (iter->rt_runtime == RUNTIME_INF ||
+				iter->rt_runtime == RUNTIME_DISABLED)
 			goto next;
 
 		/*
@@ -775,7 +776,9 @@ static void __disable_runtime(struct rq *rq)
 			/*
 			 * Can't reclaim from ourselves or disabled runqueues.
 			 */
-			if (iter == rt_rq || iter->rt_runtime == RUNTIME_INF)
+			if (iter == rt_rq ||
+					iter->rt_runtime == RUNTIME_INF ||
+					iter->rt_runtime == RUNTIME_DISABLED)
 				continue;
 
 			raw_spin_lock(&iter->rt_runtime_lock);
@@ -801,10 +804,9 @@ static void __disable_runtime(struct rq *rq)
 		WARN_ON_ONCE(want);
 balanced:
 		/*
-		 * Disable all the borrow logic by pretending we have inf
-		 * runtime - in which case borrowing doesn't make sense.
+		 * Disable all the borrow logic by marking runtime disabled.
 		 */
-		rt_rq->rt_runtime = RUNTIME_INF;
+		rt_rq->rt_runtime = RUNTIME_DISABLED;
 		rt_rq->rt_throttled = 0;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 		raw_spin_unlock(&rt_b->rt_runtime_lock);
@@ -2827,7 +2829,8 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 		struct rt_rq *rt_rq = tg->rt_rq[i];
 
 		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		rt_rq->rt_runtime = rt_runtime;
+		if (rt_rq->rt_runtime != RUNTIME_DISABLED)
+			rt_rq->rt_runtime = rt_runtime;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 	}
 	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a831af102070..c2ad9102b8fa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -183,6 +183,11 @@ extern struct list_head asym_cap_list;
  */
 #define RUNTIME_INF		((u64)~0ULL)
 
+/*
+ * Single value that denotes runtime is disabled, and it should not be used.
+ */
+#define RUNTIME_DISABLED	(-2ULL)
+
 static inline int idle_policy(int policy)
 {
 	return policy == SCHED_IDLE;
-- 
2.34.1


