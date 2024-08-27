Return-Path: <linux-kernel+bounces-303174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3496088F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273421F23960
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF8119F499;
	Tue, 27 Aug 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAxEbDJC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612919EEC0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758029; cv=none; b=Yuyh0mTH5ogoCVEVOdYMA03Y0Ro63+ikoLTwQ4UI9FkXN5Jnhgm9m5iS85nMIbMum3fy0FGigoCO0zuV5NVaUBq+ymHTc2SL5Maadv4zSohb7U50DxZbFPVsu6YEQeYmn3fSTImihZ7rDowqkNJxsY+/t2XEr0W9/2eJZft7RD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758029; c=relaxed/simple;
	bh=UnQ4bzcS+gFG0H7WmGJ7tOO/jaQPpRteSKoLaUg1bMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Az351T9xRvgIPA9Lbal0b/GSkWXkI5DadQMO7DpIt7F1XIp6+4Hjnshng6Lqb+kIoGvlFJr+KdzAhTF0ALC0wbQr9YFw9tIP+V3xYE2sQ9lwqBHTqZcW2WxwVQofHnd2G2eI9wyJUsGDWsswWSfzaXZJo0aqlV400LCd/XgpXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAxEbDJC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724758027; x=1756294027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UnQ4bzcS+gFG0H7WmGJ7tOO/jaQPpRteSKoLaUg1bMM=;
  b=SAxEbDJC5gKAAWZRTuRrABed8uuqKneZv+MPzIuNfI8SMExIRFQU6O91
   4Kaua6g1f9U4ZElel2Uv7jnaf9cJ4gQk/DYCm32Xi2wb2b9XDlq31i9zP
   Vtupz1vXgr+PpzCgDojHQTkfw/4OG1LmXlJ/JN7rbN3EqHUB3uVQPeDLN
   y89vyBWLJJFAp6kBb4+eEIJuSuHiIRlKkdPgs/48+FT2fGVslD9Gtpnd+
   wu0KU6RiQOqPapNqC28S9wlIZ2TSw16nXx4gbcv8tSwxnsgpoNDfMgkFz
   0VAV7ioK2X/b+58wcIIpvcckbuxRT0udrRHE3P1f2Pbgu1znHsDCyZN16
   g==;
X-CSE-ConnectionGUID: ZYfM+JgLSTyvZUs5yy0+wA==
X-CSE-MsgGUID: 4LE3qTYMQ1uYF1cd8qdJNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40699074"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40699074"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:27:07 -0700
X-CSE-ConnectionGUID: /ep0O2LQQIm2reksQ7VY1g==
X-CSE-MsgGUID: l0AJ8tEDShuGjYiJYEJ7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67703794"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa005.jf.intel.com with ESMTP; 27 Aug 2024 04:27:03 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Mickael Salaun <mic@digikod.net>,
	Tejun Heo <tj@kernel.org>,
	David Gow <davidgow@google.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2] kthread: fix task state in kthread worker if being frozen
Date: Tue, 27 Aug 2024 19:23:08 +0800
Message-Id: <20240827112308.181081-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When analyzing a kernel waring message, Peter pointed out that there is a race
condition when the kworker is being frozen and falls into try_to_freeze() with
TASK_INTERRUPTIBLE, which could trigger a might_sleep() warning in try_to_freeze().
Although the root cause is not related to freeze()[1], it is still worthy to fix
this issue ahead.

One possible race scenario:

        CPU 0                                           CPU 1
        -----                                           -----

        // kthread_worker_fn
        set_current_state(TASK_INTERRUPTIBLE);
                                                       suspend_freeze_processes()
                                                         freeze_processes
                                                           static_branch_inc(&freezer_active);
                                                         freeze_kernel_threads
                                                           pm_nosig_freezing = true;
        if (work) { //false
          __set_current_state(TASK_RUNNING);

        } else if (!freezing(current)) //false, been frozen

                      freezing():
                      if (static_branch_unlikely(&freezer_active))
                        if (pm_nosig_freezing)
                          return true;
          schedule()
	}

        // state is still TASK_INTERRUPTIBLE
        try_to_freeze()
          might_sleep() <--- warning

Fix this by explicitly set the TASK_RUNNING before entering
try_to_freeze().

Link: https://lore.kernel.org/lkml/Zs2ZoAcUsZMX2B%2FI@chenyu5-mobl2/ [1]
Fixes: b56c0d8937e6 ("kthread: implement kthread_worker")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v1->v2: Describe the race condition in commit log and
        refined the code. (Andrew Morton)
---
 kernel/kthread.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976ff88a..db4ceb0f503c 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -845,8 +845,16 @@ int kthread_worker_fn(void *worker_ptr)
 		 * event only cares about the address.
 		 */
 		trace_sched_kthread_work_execute_end(work, func);
-	} else if (!freezing(current))
+	} else if (!freezing(current)) {
 		schedule();
+	} else {
+		/*
+		 * Handle the case where the current remains
+		 * TASK_INTERRUPTIBLE. try_to_freeze() expects
+		 * the current to be TASK_RUNNING.
+		 */
+		__set_current_state(TASK_RUNNING);
+	}
 
 	try_to_freeze();
 	cond_resched();
-- 
2.25.1


