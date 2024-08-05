Return-Path: <linux-kernel+bounces-274363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E527E947756
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE3DB20D4F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E77F14A639;
	Mon,  5 Aug 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4Xm92Ss"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054916BFB5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846677; cv=none; b=kFDPUu2eDykoDIY3HTtw32UNxRoKpvEpzKQEtJWJM8jqk38+8vqclNnrtSO+5/DkThxjIaBNvJs99nfOzGeF7CuG4/yb+ZKAASUDTs962e9AuQFHDf3qOH6IEcdrzlIvAImztbmk0DaPC5u3D01K53nc3r4oMFq8vDHFYcJdU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846677; c=relaxed/simple;
	bh=HfVu9eXojrhVUXg/c6fj+fGobXf1NH7gBz3P9eiXf+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RNVhldw8GMuiEpqLuzRCKN6r8zK0BqpWVg7wXnxnYaETNGhXbSgzZGln77E5pzZGOgd/v+5hLx20MNV6JXuQDdY0QPsScJxBE5rA3LrEShOw4EWbDOgR+Za2eT3xdlG4Wp1XeFpR6v1QPb21o1czoKPR63mtJvG4Yp23IP/qlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4Xm92Ss; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722846675; x=1754382675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HfVu9eXojrhVUXg/c6fj+fGobXf1NH7gBz3P9eiXf+M=;
  b=L4Xm92SsMoKF7c4N+Su1E2qY8fIKaX1hEybQ8itYdBw8CbUNoCsmuF4s
   Bw5mLzvs053R2E8XfY0o4C3TsR+Ta+S7KW36SKCs16FrUBQqxvzrKlPjv
   5vcDX6bkoWd33sMmxv+KlQonBlHhRCtSZJXdLoGVsVg2NVbWT4WLIYZib
   Me+PNQHv4esOYjXRfKqVZ7lL/tMsxNzHmN+s+T5ZOdbwnhjWJz9w6le/T
   3tRb7evlAugwVLwUfVAOp6msSIW4IINt2HY4VkCQ5EtwljzmUBj8+AnZo
   xvqWpib6FEQaO9ngcDdwtQwRWupho7BudXXNrLnVuqNt6mNGpATnoc8Yh
   g==;
X-CSE-ConnectionGUID: 21qOW8mmRSO7bXir8FBP7w==
X-CSE-MsgGUID: x3mKrhxPR2y/JPjvBM61rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20948145"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20948145"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 01:31:14 -0700
X-CSE-ConnectionGUID: KoCfHx0FSCGK2dC+C9OZzw==
X-CSE-MsgGUID: yr2oN9dTQMaRVsWI726jhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="60460452"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 01:31:12 -0700
From: Yujie Liu <yujie.liu@intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Chen Yu <yu.chen.surf@gmail.com>,
	Tim Chen <tim.c.chen@intel.com>,
	linux-kernel@vger.kernel.org,
	Xiaoping Zhou <xiaoping.zhou@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Yujie Liu <yujie.liu@intel.com>
Subject: [PATCH v2] sched/numa: Fix the vma scan starving issue
Date: Mon,  5 Aug 2024 16:22:28 +0800
Message-Id: <20240805082228.4082656-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
v1->v2: Refine the commit log and comments in the code.
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


