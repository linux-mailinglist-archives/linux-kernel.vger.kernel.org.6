Return-Path: <linux-kernel+bounces-214345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7994290831C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D111C21162
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB961474A0;
	Fri, 14 Jun 2024 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCIaFI1P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72887B646
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341213; cv=none; b=uJm6nN+9eAwxWGGmv2Q9VhJPrX7snzQhIhdBbCd1QC2Qos6vKHh2UfiQDVw5OkaMyLxw96+N+lMkA6V3sTztouyyq9jKO8+F+R+jjEX5IQ3zKzR2FoWmYJs6X95ICn7OEdWS73bbBpCQT8BH7kqLRWKnhUHnVl4+4/uLDpxUKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341213; c=relaxed/simple;
	bh=16fyQeZoY7zldfy9Xr/pGTCm6ymupo3MzZjwBmtfuQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XEAbAJIFwOrXOxh4wAt9n1305R3B9FlugouyMU+P47hAnDiF9NRUaX4tOVdJVoXyf3+EuyVbid8rhkqtju1XRj0rgm9/HF90qSXz2XB5NdZEGwtKMihSCFVMi+/zrosaoRaAQ7aDz/EmJXN3KYRcixFsJflvqbK0DO8MCTqE7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCIaFI1P; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718341212; x=1749877212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=16fyQeZoY7zldfy9Xr/pGTCm6ymupo3MzZjwBmtfuQo=;
  b=iCIaFI1PXiS+DETK3YlOdtp+PSKxniIWu0rn+1wWLF0aXezGhxx4Rnl2
   h8QiIuXQyBAfRP5mf7t4jWyYQ9MxkeYP3AiCUAp3kQAegnBwZVwb1pseI
   yNqBkQk8V/FFVXWfFPnlF9F8UqK4SXzlFzWRF+MjqfFD3fooNfWqUEK0b
   q0dFtqbucJdxfGyBvUp51Wf37hshftLai5eVbZCV/FiGBwl/sDQJXZOJA
   +UC9zo3/AnxTYhNiJ6qbf7Vce141Mpi0zKuothpffi23kpI2M+PLdeVud
   sl6P+W1/fad74WARMe5xOsgz61EFWjoTOwAA3AUsgEiA62wDiLkl4jEmo
   g==;
X-CSE-ConnectionGUID: c4BXLBj+QTOidrKso905EQ==
X-CSE-MsgGUID: vmiIOQhVQuKFzWYcKWaYSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="12069247"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="12069247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 22:00:10 -0700
X-CSE-ConnectionGUID: APaAOoNaSrG7gfwnS2LS7A==
X-CSE-MsgGUID: 9N3Ko1OcT8y3t4ShvKdcig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="71593883"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmviesa001.fm.intel.com with ESMTP; 13 Jun 2024 22:00:05 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Chen Yu <yu.chen.surf@gmail.com>,
	Tim Chen <tim.c.chen@intel.com>,
	linux-kernel@vger.kernel.org,
	Yujie Liu <yujie.liu@intel.com>,
	Xiaoping Zhou <xiaoping.zhou@intel.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH] sched/numa: scan the vma if it has not been scanned for a while
Date: Fri, 14 Jun 2024 12:56:49 +0800
Message-Id: <20240614045649.133878-1-yu.c.chen@intel.com>
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
Numa vma scan overhead has been reduced a lot. Meanwhile, it could be
a double-sword that, the reducing of the vma scan might create less Numa
page fault information. The insufficient information makes it harder for
the Numa balancer to make decision. Later,
commit b7a5b537c55c08 ("sched/numa: Complete scanning of partial VMAs
regardless of PID activity") and commit 84db47ca7146d7 ("sched/numa: Fix
mm numa_scan_seq based unconditional scan") are found to bring back part
of the performance.

Recently when running SPECcpu on a 320 CPUs/2 Sockets system, a long
duration of remote Numa node read was observed by PMU events. It causes
high core-to-core variance and performance penalty. After the
investigation, it is found that many vmas are skipped due to the active
PID check. According to the trace events, in most cases, vma_is_accessed()
returns false because both pids_active[0] and pids_active[1] have been
cleared.

As an experiment, if the vma_is_accessed() is hacked to always return true,
the long duration remote Numa access is gone.

Proposal:
The main idea is to adjust vma_is_accessed() to let it return true easier.

solution 1 is to extend the pids_active[] from 2 to N, which has already
been proposed by Peter[1]. And how to decide N needs investigation.

solution 2 is to compare the diff between mm->numa_scan_seq and
vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
scan the vma.

solution 2 can be used to cover process-based workload(SPECcpu eg). The
reason is: There is only 1 thread within this process. If this process
access the vma at the beginning, then sleeps for a long time, the
pid_active array will be cleared. When this process is woken up, it will
never get a chance to set prot_none anymore. Because only the first 2
times of access is regarded as accessed:
(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
and no other threads can help set this prot_none.

This patch is mainly to raise this question, and seek for suggestion from
the community to handle it properly. Thanks in advance for any suggestion.

Link: https://lore.kernel.org/lkml/Y9zxkGf50bqkucum@hirez.programming.kicks-ass.net/ #1
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
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
2.25.1


