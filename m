Return-Path: <linux-kernel+bounces-228443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD51915FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE6A1C20A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C013146A83;
	Tue, 25 Jun 2024 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIlxpA4J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B21146A93
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300326; cv=none; b=oJLsWx2R0Y0J1mN2iYtrp6D3gVpg0HBu8+htkKC5ztInojLU7d/euFnM84G2Q9Ia1D7ZCzPIYjR/tmnyWiSdUDDhACqfDwtejcVBr9fcN5tXMqtRMAmXamUTBHoV5etZ1qd3RJQQTfYU+0qC0yGjwBOwkYDBm9Uo0lJWO/RkRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300326; c=relaxed/simple;
	bh=iJxaoY6Y6nhbCUJeRWFve7w+uu5jiiKdXQI/5whnEEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIDIbXvnerkaFbtEqSX2jbaHoT0jChocL7o6VDFJQSpKHeFTy+Uve5zO/dAV3apiL/1o3ftee4/N/Z//SmFzB0sRpETZo1FaNYkg0Z8ztzbwbikb/I/WbSKfOftqXScrN/gYx8n/wKl5g3Gqn+aLVryvecViZRMM3+ZYu7oJeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIlxpA4J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719300324; x=1750836324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iJxaoY6Y6nhbCUJeRWFve7w+uu5jiiKdXQI/5whnEEg=;
  b=AIlxpA4JXJSB1srD7rw5/JSHJ0ekkJlHHcDqBdY8JH3b4844oitkWPCc
   vYnXs1o0otMBmpBAjFRhc/e4OcyIsftFX6I00J4dQ5p+nM8M/isDDUK/r
   Fj5PV9kD8Nour90FgeTQ0DCUZpIhN+wxLSD9MY6FEiInFMt8i0oY1EDfi
   LhQKM6GUByjYwhbBin+Jx6N4DUvWgkFK2xRlA0UVRo0uIYQtM1fo9nv08
   PfFLmRDCipLLgAPLr8uksHtI7Z/zAVkrTItq7Kz0O98xLDJl0E+tvvH+e
   21TRXfuVx0RJPnoKbTcf7J19pCwUV7OUTZ55UYqNzd7kTxfmuaDfRb+4Y
   A==;
X-CSE-ConnectionGUID: 45eIGy6RR2KIuxdK4Brf6Q==
X-CSE-MsgGUID: stnr6bu6TRu8fQUtNQa2Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20111595"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="20111595"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 00:25:23 -0700
X-CSE-ConnectionGUID: WvC7ntS/R+2LG+lBZVjurQ==
X-CSE-MsgGUID: sguCs3kERiOkfmSXfAEzYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43651833"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orviesa009.jf.intel.com with ESMTP; 25 Jun 2024 00:25:21 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Mike Galbraith <efault@gmx.de>,
	Tim Chen <tim.c.chen@intel.com>,
	Yujie Liu <yujie.liu@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2] sched/fair: Enhance sync wakeup for short duration tasks
Date: Tue, 25 Jun 2024 15:22:22 +0800
Message-Id: <383932811ae0cb4df0bb131fa968e746de979417.1719295669.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1719295669.git.yu.c.chen@intel.com>
References: <cover.1719295669.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Problem Statement]
On platforms where there are many CPUs, one bottleneck is the high
Cache-to-Cache latency. This issue is exacerbated when the tasks sharing
data are running on different CPUs: When the tasks access different
part of the same cache, false sharing happens. One example is the network
client/server workload with small packages. A simple example:

On a system with 240 CPUs, 2 sockets,
taskset -c 2 netserver

taskset -c 1 netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 100
Trans Rate per sec: 83528.11

taskset -c 2 netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 100
Trans Rate per sec: 134504.35

[Problem Analysis]

TL;DR
When netperf and nerserver are running on difference cores, the cache
false sharing on the TCP/IP stack hurts the performance. As long as the
netperf and netserver are on the same system, and within the same
network namespace, this issue exists.

Detail
With the help of perf topdown, when netperf and netserver are both on CPU2:
28.1 %  tma_backend_bound
	13.7 %  tma_memory_bound
		3.3 %  tma_l2_bound
		9.3 %  tma_l1_bound

When netperf is on CPU1, netserver is on CPU2:
30.5 %  tma_backend_bound
	16.8 %  tma_memory_bound
		11.0 %  tma_l1_bound
		32.4 %  tma_l3_bound
			59.5 %  tma_contested_accesses  <----
			11.1 %  tma_data_sharing

The contested_accesses has increased a lot when netperf and netserver
are on different CPUs. Contested accesses occur when data written by one
thread is read by another thread on a different core. This indicates the
cache false sharing.

Use perf c2c to figure out the place where cache false sharing happens.
top 2 offenders:

----- HITM -----  ------- Store Refs ------  --------- Data address -------
RmtHitm  LclHitm   L1 Hit  L1 Miss                     Offset  Node
0.00%    55.17%    0.00%    0.00%                      0x1c         <---- read
0.00%    0.00%     20.00%   0.00%                      0x1f         <---- write

To be more specific, there are frequent read/write on the same cache line
in the:
struct tcp_sock {

	new cache line
	...
	u16     tcp_header_len; <----- read
        u8      scaling_ratio;
        u8      chrono_type : 2, <---- write
                repair      : 1,
                tcp_usec_ts : 1,
                is_sack_reneg:1,
                is_cwnd_limited:1; < ---- write

	new cache line

	u32     copied_seq;   <----- write
	u32     rcv_tstamp;   <---- write
	u32     snd_wl1;   <---- write
	...
	u32     urg_seq;   <--- read

Re-arranging the layout of struct tcp_sock could become a seesaw. As the variables
mentioned above are frequently accessed by different path of TCP/IP stack.

Propose a more generic solution:
1. if the waker and the wakee are both short duration tasks,
2. if the wakeup is WF_SYNC,
3. if there is no idle Core in the system,
4. if the waker and the wakee wake up each other,

Wake up the wakee on the same CPU as waker.

N.B. The bar to regard the task as a short duration one depends on the number
of CPUs. Normally we don't want to enable this wakeup feature on desktop or mobile.
Because the overhead of Cache-to-Cache latency is negligible on small systems.

[Benchmark results]
Tested on 4 platforms, significant throughput improvement on tbench, netperf,
stress-ng, will-it-scale, and latency reduced of lmbench.

Platform1, 240 CPUs, 2 sockets Intel(R) Xeon(R)
========================================================================
netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	60-threads	 1.00 (  1.04)	 -0.03 (  1.27)
TCP_RR          	120-threads	 1.00 (  2.31)	 -0.09 (  2.46)
TCP_RR          	180-threads	 1.00 (  1.77)	 +0.93 (  1.16)
TCP_RR          	240-threads	 1.00 (  9.39)	+190.13 (  3.66)
TCP_RR          	300-threads	 1.00 ( 45.28)	+120.07 ( 19.41)
TCP_RR          	360-threads	 1.00 ( 20.13)	 +0.27 ( 30.57)
TCP_RR          	420-threads	 1.00 ( 30.85)	+13.39 ( 46.38)
UDP_RR          	60-threads	 1.00 ( 11.86)	 -0.29 (  2.66)
UDP_RR          	120-threads	 1.00 ( 16.28)	 +0.42 ( 13.41)
UDP_RR          	180-threads	 1.00 ( 15.34)	 +0.31 ( 17.45)
UDP_RR          	240-threads	 1.00 ( 16.27)	 -0.36 ( 18.78)
UDP_RR          	300-threads	 1.00 ( 20.42)	 -2.54 ( 32.42)
UDP_RR          	360-threads	 1.00 ( 31.59)	 +0.28 ( 35.66)
UDP_RR          	420-threads	 1.00 ( 30.44)	 -0.27 ( 37.12)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	60-threads	 1.00 (  0.27)	 +0.04 (  0.11)
loopback        	120-threads	 1.00 (  0.65)	 -1.01 (  0.41)
loopback        	180-threads	 1.00 (  0.42)	+62.05 ( 26.22)
loopback        	240-threads	 1.00 ( 30.43)	+77.61 ( 15.27)

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  6.92)	 +4.70 (  5.85)
process-pipe    	2-groups	 1.00 (  6.45)	 +7.66 (  2.39)
process-pipe    	4-groups	 1.00 (  2.82)	 -1.82 (  1.47)

schbench
========
No noticeable difference of 99.0th wakeup/request latency, 50.0th RPS percentiles.
schbench -m 2 -r 100

                                  baseline                       sis_sync

Wakeup Latencies 99.0th usec            27                            25
Request Latencies 99.0th usec        15376                         15376
RPS percentiles 50.0th               16608                         16608

Platform2, 48 CPUs 2 sockets Intel(R) Xeon(R) CPU E5-2697
========================================================================
lmbench3: lmbench3.PIPE.latency.us 33.8% improvement
lmbench3: lmbench3.AF_UNIX.sock.stream.latency.us 30.6% improvement

Platform3: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480
=======================================================================
stress-ng: stress-ng.vm-rw.ops_per_sec 250.8% improvement
will-it-scale: will-it-scale.per_process_ops 42.1% improvement

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 62 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/features.h |  1 +
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 445877069fbf..d749397249ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1003,7 +1003,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, int sync);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -7410,12 +7410,55 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+/*
+ *    threshold of the short duration task:
+ *    sysctl_sched_migration_cost * llc_weight^2 / 256^2
+ *
+ *                            threshold
+ *  LLC_WEIGHT=8               0.5 usec
+ *  LLC_WEIGHT=16              2 usec
+ *  LLC_WEIGHT=32              8 usec
+ *  LLC_WEIGHT=64              31 usec
+ *  LLC_WEIGHT=128             125 usec
+ *  LLC_WEIGHT=256             500 usec
+ */
+static int short_task(struct task_struct *p, int llc)
+{
+	return ((p->duration_avg << 16) <
+	    (sysctl_sched_migration_cost * llc * llc));
+}
+
+static int mutual_wakeup(struct task_struct *p, int target)
+{
+	int llc_weight;
+
+	if (!sched_feat(SIS_SYNC))
+		return 0;
+
+	if (target != smp_processor_id())
+		return 0;
+
+	if (this_rq()->nr_running > 1)
+		return 0;
+
+	llc_weight = per_cpu(sd_llc_size, target);
+
+	if (!short_task(p, llc_weight) ||
+	    !short_task(current, llc_weight))
+		return 0;
+
+	if (current->last_wakee != p || p->last_wakee != current)
+		return 0;
+
+	return 1;
+}
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target,
+			   int sync)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
@@ -7458,6 +7501,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	/*
+	 * The Cache-to-Cache latency could be large on big system.
+	 * Before trying to find a compelete idle CPU than the current one,
+	 * give the current CPU another chance if waker and wakee are mutually
+	 * waking up each other.
+	 */
+	if (!has_idle_core && sync && mutual_wakeup(p, target))
+		return target;
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -7550,7 +7602,7 @@ static inline bool asym_fits_cpu(unsigned long util,
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target, int sync)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
@@ -7659,7 +7711,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
-	i = select_idle_cpu(p, sd, has_idle_core, target);
+	i = select_idle_cpu(p, sd, has_idle_core, target, sync);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
@@ -8259,7 +8311,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, sync);
 	}
 	rcu_read_unlock();
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55df890b..7e5968d01dcb 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -50,6 +50,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_SYNC, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.25.1


