Return-Path: <linux-kernel+bounces-335495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA897E681
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0932B1F21BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F334CDE;
	Mon, 23 Sep 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU7tYvU4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1AED529
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076381; cv=none; b=cAjESnvMKYR5pW6G/pMa98WVzBo6iJPQPw7sj4834mPXmxkKlQy3NnEYeCXgPSiy/6DOZD/pQ7bsWJgK2jfeRs8Vyu3cHuVkwcnyozgtdX+PHleSDSVWDT+kY4sRwd9TLp/oveL2EF/p0xFtxTdYLu1ck0k0RaG05RxbbG5HWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076381; c=relaxed/simple;
	bh=qN3BKWerCq+wWtizulAOp+Fsei3OLU3AZ6TMiP/YA/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVHUr1F2KpRwvfKVK/gi2f1d/mmA4ubIUbltqxZx3FS0Nis6F5h+Wcbs5Ivl/MMN5ZHj4zmPxoCOapSxokpqNWkc37q712hC4ZI02tC+iqEbFvL53V1XnK/P+e8dlmXiFUMO0Y6d2qScsGljSw6iFZEC/MGlrnukIs4Pm9ggXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU7tYvU4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727076379; x=1758612379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qN3BKWerCq+wWtizulAOp+Fsei3OLU3AZ6TMiP/YA/g=;
  b=PU7tYvU40obGseoAonhtoAQftA0+BxEcab3s6ZZyEvQqnnOsTkwPOvJ4
   e9MS2mFdh4nsBz4RFeilMRHaLCWIJX6avB/IyrzvSMnhiFHMngcBPVSDn
   EppRue5v0RLVyHffNQ27LGTrHO3j+0dTp5mA7MEGp13/ea9PR9LiJBCw0
   cV9KeM/jYP3OwD1VAuUAO1ue/fcYbRHtwn4n4eNz+MGPBD5JusImu0oF7
   JNUimI6M2teXu4h4gpfG5KL6GbPfVXlD+eyvovK6rct1Let2fmhsg53g7
   ihqMgoaf+lovdeA9ul65PMAu6bZzV751XLXZS75XDtCjs8IQfCtxeOdSI
   A==;
X-CSE-ConnectionGUID: SJsOSWU1QuWBtmdHyeSpNg==
X-CSE-MsgGUID: Jf3tLmrIQfmWfVELEZPlvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26201798"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26201798"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 00:26:18 -0700
X-CSE-ConnectionGUID: 7ux+OOnEQImvaaQ8V8iTTA==
X-CSE-MsgGUID: Ls/JKKZJT62fdYipoasu3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71004289"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa009.jf.intel.com with ESMTP; 23 Sep 2024 00:26:15 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Chunxin Zang <zangchunxin@lixiang.com>,
	linux-kernel@vger.kernel.org,
	Oliver Sang <oliver.sang@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running
Date: Mon, 23 Sep 2024 15:21:56 +0800
Message-Id: <20240923072156.343623-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
introduced a mechanism that a wakee with shorter slice could preempt
the current running task. It also lower the bar for the current task
to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
when the current task has ran out of time slice. Say, if there is 1 cfs
task and 1 rt task, before 85e511df3cec, update_deadline() will
not trigger a reschedule, and after 85e511df3cec, since rq->nr_running
is 2 and resched is true, a resched_curr() would happen.

Some workloads (like the hackbench reported by lkp) do not like
over-scheduling. We can see that the preemption rate has been
increased by 2.2%:

1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches

Restore its previous check criterion.

Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31aaee55..2859fc7e2da2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1025,7 +1025,7 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	/*
 	 * The task has consumed its request, reschedule.
 	 */
-	return true;
+	return (cfs_rq->nr_running > 1);
 }
 
 #include "pelt.h"
-- 
2.25.1


