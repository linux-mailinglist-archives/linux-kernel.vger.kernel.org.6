Return-Path: <linux-kernel+bounces-303188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296E9608C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB76A280BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606619FA96;
	Tue, 27 Aug 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nt5ccoVD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50519EED8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758432; cv=none; b=RHOjif2TpLlq1QM5U54PhX41jz2Da3zhohxzsviY4iZB1ZirDIuPGzEqqgFr1zXblio3M4eG1O5wms/uwMyUmuimjJ3SIvCd5ICZfzjT6V3bftr9tdklzs19cFMttbEQuXuhn+gXsSaHt/r0/pP9WIz/qw3EJ9c5+3kvezLRqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758432; c=relaxed/simple;
	bh=bdGySYKJL1Iz+OP5sgGFrHlx5VVIj1BMpbMI0D+UKjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aL7NuHM8tBOzi3zM27YyXI+zI81iYE/h6NBntVwl9sZJOn7Y64LMdJwttrlA5h2ObUTY3spge2CfRiMrvNLIJ9RZVtuJW2UMBP6o7deMtfc3DIyotOv2VRezWJ/bUIVlq4Fqm69g85Z4dmPP9lURxC7b58J2+AQaDT6E1z34wSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nt5ccoVD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724758432; x=1756294432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bdGySYKJL1Iz+OP5sgGFrHlx5VVIj1BMpbMI0D+UKjs=;
  b=nt5ccoVDCLILaQtzHk667xxdAFw1ke0D4R48wjzWXOshkFgLFV/2ycpY
   DXGDBo4kOJZG30XvSnptSW66Pi2ee0A6hIJM1yCFuJKiDYci9WqPVuGtc
   iqgIkV6ZCfEECkoBzGI80BUMjc6O1tB72bs4MRay4vhljxdW1MVrGqfm0
   Ua2wunNMC6rUbasTVFZQEppohEpVuUJAMu8rLIN7DyaWa1JQocxkXDshc
   w6Fecu5QEd35duX6mGNOmSJ3UvA6COgRPY8sMK4bUuFKjpKIrIyIhi54s
   +X9bWqEA/t9b7hI8+dpFv5FCmcmm2lowaDM058RjbzvOXLCPnKN3VLspn
   Q==;
X-CSE-ConnectionGUID: Rc2NPudETCWRXyE87dMxJA==
X-CSE-MsgGUID: CSFv8t5aQcy37K1Lh3rcVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34604626"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="34604626"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:33:50 -0700
X-CSE-ConnectionGUID: FIoxd3sjSfqAjF0TIGeDOA==
X-CSE-MsgGUID: Ii7cSr2RSSKFCoJ+oCYCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62535796"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa007.fm.intel.com with ESMTP; 27 Aug 2024 04:33:47 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	linux-kernel@vger.kernel.org,
	Tim Chen <tim.c.chen@intel.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Xiaoping Zhou <xiaoping.zhou@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v3] sched/numa: Fix the vma scan starving issue
Date: Tue, 27 Aug 2024 19:29:58 +0800
Message-Id: <20240827112958.181388-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yujie Liu <yujie.liu@intel.com>

Problem statement:
Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic"), the
Numa vma scan overhead has been reduced a lot. Meanwhile, the reducing of
the vma scan might create less Numa page fault information. The
insufficient information makes it harder for the Numa balancer to make
decision. Later, commit b7a5b537c55c08 ("sched/numa: Complete scanning of
partial VMAs regardless of PID activity") and commit 84db47ca7146d7
("sched/numa: Fix mm numa_scan_seq based unconditional scan") are found
to bring back part of the performance.

Recently when running SPECcpu omnetpp_r on a 320 CPUs/2 Sockets system,
a long duration of remote Numa node read was observed by PMU events:
A few cores having ~500MB/s remote memory access for ~20 seconds.
It causes high core-to-core variance and performance penalty. After the
investigation, it is found that many vmas are skipped due to the active
PID check. According to the trace events, in most cases, vma_is_accessed()
returns false because the history access info stored in pids_active
array has been cleared.

Proposal:
The main idea is to adjust vma_is_accessed() to let it return true easier.
Thus compare the diff between mm->numa_scan_seq and
vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
scan the vma.

This patch especially helps the cases where there are small number of
threads, like the process-based SPECcpu. Without this patch, if the
SPECcpu process access the vma at the beginning, then sleeps for a long
time, the pid_active array will be cleared. A a result, if this process
is woken up again, it never has a chance to set prot_none anymore.
Because only the first 2 times of access is granted for vma scan:
(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
to be worse, no other threads within the task can help set the prot_none.
This causes information lost.

Raghavendra helped test current patch and got the positive result
on the AMD platform:

autonumabench NUMA01
                            base                  patched
Amean     syst-NUMA01      194.05 (   0.00%)      165.11 *  14.92%*
Amean     elsp-NUMA01      324.86 (   0.00%)      315.58 *   2.86%*

Duration User      380345.36   368252.04
Duration System      1358.89     1156.23
Duration Elapsed     2277.45     2213.25

autonumabench NUMA02

Amean     syst-NUMA02        1.12 (   0.00%)        1.09 *   2.93%*
Amean     elsp-NUMA02        3.50 (   0.00%)        3.56 *  -1.84%*

Duration User        1513.23     1575.48
Duration System         8.33        8.13
Duration Elapsed       28.59       29.71

kernbench

Amean     user-256    22935.42 (   0.00%)    22535.19 *   1.75%*
Amean     syst-256     7284.16 (   0.00%)     7608.72 *  -4.46%*
Amean     elsp-256      159.01 (   0.00%)      158.17 *   0.53%*

Duration User       68816.41    67615.74
Duration System     21873.94    22848.08
Duration Elapsed      506.66      504.55

Intel 256 CPUs/2 Sockets:
autonuma benchmark also shows improvements:

                                               v6.10-rc5              v6.10-rc5
                                                                         +patch
Amean     syst-NUMA01                  245.85 (   0.00%)      230.84 *   6.11%*
Amean     syst-NUMA01_THREADLOCAL      205.27 (   0.00%)      191.86 *   6.53%*
Amean     syst-NUMA02                   18.57 (   0.00%)       18.09 *   2.58%*
Amean     syst-NUMA02_SMT                2.63 (   0.00%)        2.54 *   3.47%*
Amean     elsp-NUMA01                  517.17 (   0.00%)      526.34 *  -1.77%*
Amean     elsp-NUMA01_THREADLOCAL       99.92 (   0.00%)      100.59 *  -0.67%*
Amean     elsp-NUMA02                   15.81 (   0.00%)       15.72 *   0.59%*
Amean     elsp-NUMA02_SMT               13.23 (   0.00%)       12.89 *   2.53%*

                   v6.10-rc5   v6.10-rc5
                                  +patch
Duration User     1064010.16  1075416.23
Duration System      3307.64     3104.66
Duration Elapsed     4537.54     4604.73

The SPECcpu remote node access issue disappears with the patch applied.

Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Reviewed-and-tested-by: Raghavendra K T <raghavendra.kt@amd.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
v2->v3:
  Added Mel's Acked by.
v1->v2:
  Refine the commit log and comments in the code.
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..9be6d6f0ab3f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3188,6 +3188,15 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 		return true;
 	}
 
+	/*
+	 * This vma has not been accessed for a while, and if the number
+	 * the threads in the same process is low, which means no other
+	 * threads can help scan this vma, force a vma scan.
+	 */
+	if (READ_ONCE(mm->numa_scan_seq) >
+	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
+		return true;
+
 	return false;
 }
 
-- 
2.25.1


