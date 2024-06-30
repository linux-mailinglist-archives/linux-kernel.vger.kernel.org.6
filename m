Return-Path: <linux-kernel+bounces-235250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9F91D244
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1925E1F213BD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33218152E1D;
	Sun, 30 Jun 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6pYORSP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C1135A65
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719760120; cv=none; b=I+q6Yi0dC2XAjuoaRWsthYbozVa7I8DrAPo4zkgyj1twD3xuAiDcR5W19PCuHMkFcxRvOXh0ERlynInvumN1MEodOxUoAuCbP0wx0Y5iEfF0R7qiKSayHnMaT+4r88CtHxdAqkneN+73E7EWLylCQSrcgLAUeX1s+P5ZaxzV7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719760120; c=relaxed/simple;
	bh=XDlHX7vB06dlI0FB/kmh5YzexLPIrUG8oMS3uEbh79c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KbeOIwbsQUcE/YUOT8SqEwuBUvgWWB7Rgs7m3y51B525If7cUCAUbyWGK+qD29SQGVpdu1XpWHUAbkI1FzV9ydIU9eU4L67HuBxXASC9b/do1tkO8Vm/r1PrhIe5UtUjlntISP7oYYGVtvuU5ForqyHWi20Nd7jaRDvf/k/6GTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6pYORSP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719760119; x=1751296119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XDlHX7vB06dlI0FB/kmh5YzexLPIrUG8oMS3uEbh79c=;
  b=a6pYORSPjdlTcMU6DpwxITuRW9WL0WC6saIXkUIRNerERJ+CZJo0qNoV
   f8SqRQpAsLtUzrLoRgWjEvTymFCyrVcTYWgfI1yf53qOGLTaogVa73v3H
   fDqVz1PZKNWwJRVrEVgwZ4PnFKoYQpXtwdxPWowR+FReYWL8dDFZBD3WJ
   ph0N80Wm+8vBlmhenPAgVE+2xenZw3ItBhEDWR5Iw8ZHF4smgVH0Q9y1G
   6oDIrOPB1HXHO4IklI8ee7ZdGakJdyNDNtf87U9/XgWdzjzc/c6fDKH32
   wrvSC1nV/UxIVe/kQzLi8UiiIirfYO93iRuJyK7P4dEeY7BZEJ0Hv8KIU
   A==;
X-CSE-ConnectionGUID: gKQWseIlQgaIH1MjDWoN6Q==
X-CSE-MsgGUID: 6gGRMBnZQEuYXnafHqbgsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17009517"
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="17009517"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 08:08:38 -0700
X-CSE-ConnectionGUID: N3oGZCqvQ5eBMRwvf9AWjA==
X-CSE-MsgGUID: oxygJ/xKRQCLxR5SiyUHtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="49579038"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 08:08:34 -0700
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
Subject: [PATCH] sched/numa: scan the vma if it has not been scanned for a while
Date: Sun, 30 Jun 2024 23:00:32 +0800
Message-Id: <20240630150032.533210-1-yujie.liu@intel.com>
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
Numa vma scan overhead has been reduced a lot. Meanwhile, it could be
a double-sword that, the reducing of the vma scan might create less Numa
page fault information. The insufficient information makes it harder for
the Numa balancer to make decision. Later,
commit b7a5b537c55c08 ("sched/numa: Complete scanning of partial VMAs
regardless of PID activity") and commit 84db47ca7146d7 ("sched/numa: Fix
mm numa_scan_seq based unconditional scan") are found to bring back part
of the performance.

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

solution 1 is to extend the pids_active[] from 2 to N, which was proposed
by Raghavendra[1]. And it is under investigation how to choose the N.

solution 2 is to compare the diff between mm->numa_scan_seq and
vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
scan the vma.

solution 2 can be used to especially help the cases where there are
limited number of shared VMAs, the process-based SPECcpu eg. Without
solution 2, it is possible that, if the single process access the vma
at the beginning, then sleeps for a long time(the pid_active array
been cleared), when this process is woken up, it will never get a
chance to set prot_none anymore. Because only the first 2 times of
access is regarded as accessed:
(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
and no other threads within the task can help set the prot_none.

Raghavendra helped test current patch and got the positive result
on AMD platform:

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
autonuma benchmark also shows some improvements:

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

Link: https://lore.kernel.org/lkml/88d16815ef4cc2b6c08b4bb713b25421b5589bc7.1710829750.git.raghavendra.kt@amd.com/ #1
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
Reviewed-and-Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..2b74fc06fb95 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3188,6 +3188,14 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 		return true;
 	}
 
+	/*
+	 * This vma has not been accessed for a while, and has limited number of threads
+	 * within the current task can help.
+	 */
+	if (READ_ONCE(mm->numa_scan_seq) >
+	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
+		return true;
+
 	return false;
 }
 
-- 
2.34.1


