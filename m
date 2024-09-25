Return-Path: <linux-kernel+bounces-338289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE959855F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A24CB2250D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F6015B115;
	Wed, 25 Sep 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loUMR//m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B6158DCC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254724; cv=none; b=jjRAK8ogncHfyH3rQIhh+mny36BrgyBVbWkYkcZ2uBj8jFYFuNbAeD//9LeltQJBqJneu1Kz5q9igYfw1Q2qLXlYNKPbo+f0Bwjbr5yK+zuW0BrnlxbXw0U7e6Mpvd7sQHWA5rSSzFbQ/0WfT/bW2XcsoPD9QOkbRQjkYKRv8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254724; c=relaxed/simple;
	bh=nMARnu08ub4CbQxmYHfbfHObJdrrHv6+xqmDLHZLyVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ikBgUR66WHlkj36i/f36ZmQLX2DHg9s3iyt1yLWtNdbEUAjWddt/7fcm/ldunjfBRt5j2H7l3F2H1NEsu3gqv2NEzQUnDtDS3lPiNJqp/Y7v9PjhNMiPQFPDUhYT1e87H0gbwKu54zcmEri9LnpYICAUbNzGtuFj/JWPccS1daI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loUMR//m; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727254722; x=1758790722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nMARnu08ub4CbQxmYHfbfHObJdrrHv6+xqmDLHZLyVs=;
  b=loUMR//mCl6cEZuW7RXrE2ZLxGRm/slL8TXd5nyDBTTuSkc5XXWgJTdk
   CRq2HQb/27WdL46eAUtBtMGBf3ZlWzcAitkvW7CnAyoCv4nAymsS4S9/D
   vWAlJMxrdSOOn28qyCAKLsbotzf6l8OKyjNCAOGDHqAhcbBQoRVi7zFIW
   6jAzZPtslb9Ue1VH5TocnXL4HCrTbCYNXixEzSZ6Rj07o+iAP5vKpcLsp
   Gos2TlyXild+A8+1O09tvmQxqICMvfc5FDxJ+UtxTqPfIxYjvXbkKVR1c
   y1OG5OyAwEnKw+sOXFGWWFh/Roc7sfMqRnLcs+L6aWI6cFfNsX9KfwsD5
   w==;
X-CSE-ConnectionGUID: 7Cg68wBfTBmgXiFqLClmjA==
X-CSE-MsgGUID: hQM8wf77TwmbITUMtVJFvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="13915175"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="13915175"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 01:58:42 -0700
X-CSE-ConnectionGUID: Qph6AFGJT6+3lw3rMFrBcA==
X-CSE-MsgGUID: RZsV1B2uTUOpHezjNd0U/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="76097964"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2024 01:58:38 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chunxin Zang <zangchunxin@lixiang.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running
Date: Wed, 25 Sep 2024 16:54:40 +0800
Message-Id: <20240925085440.358138-1-yu.c.chen@intel.com>
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
when the current task has ran out of time slice. But there is a scenario
that is problematic. Say, if there is 1 cfs task and 1 rt task, before
85e511df3cec, update_deadline() will not trigger a reschedule, and after
85e511df3cec, since rq->nr_running is 2 and resched is true, a resched_curr()
would happen.

Some workloads (like the hackbench reported by lkp) do not like
over-scheduling. We can see that the preemption rate has been
increased by 2.2%:

1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches

Restore its previous check criterion.

Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v1->v2:
    Check cfs_rq->nr_running instead of rq->nr_running(K Prateek Nayak)
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31aaee55..53a351b18740 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 
-	if (rq->nr_running == 1)
+	if (cfs_rq->nr_running == 1)
 		return;
 
 	if (resched || did_preempt_short(cfs_rq, curr)) {
-- 
2.25.1


