Return-Path: <linux-kernel+bounces-292249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD7956D09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1CF281951
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416016CD12;
	Mon, 19 Aug 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCJEEcK0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BC165EF9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077198; cv=none; b=CvEw+BYvD1D4b3h7XoleRkiEbUbiEQgrHQL6fwQGBV+0KODhZGDht/lQAjaTcM32jXHPTW85LMHtPYtoDOT3+AZiAQXPjnA1V3cc0CYU8a83dVmGpzlozZovtxrsa1ldU2p/Bso/uZ1c51JHs1GwiSkFe2wHFa9EfRuuNApY1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077198; c=relaxed/simple;
	bh=ZY84X+naWCxZF1uB0a9Y3/UeATvV+nCtMbh5bQ77fLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ewIOt/A7tiI1grM2VOR70RgjUfL3Cuu7EvNIEleNDu/o0qN+GA4Cj8QKV4/4iMPyBrQ2VqRoid1WwHmcJF1hvysd0IpzBdKpQM4IIO5V5fetZ/Z4uAKuFFHtkCb3aHb5hGdYIGB++DYUxBCzeFjfKUXVMeZ1v8CZM2FmCL9zrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCJEEcK0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724077196; x=1755613196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZY84X+naWCxZF1uB0a9Y3/UeATvV+nCtMbh5bQ77fLg=;
  b=mCJEEcK0gNXGtvk0qoquM9ssWhCHutDyntIWV7G69MuTsMII5jo4/5mv
   E4eDzSHMKYg5WceZnCAWF9ZROeffSnxmqcadb+HCwjdYTnU58rl4TemYy
   jTci+hHNcWDsy+JpNloaM9yc4czN65OpLQSYpbB6Qa80cdtOmRIjlyRo/
   5CzTrfIiUohmAbEriZAkICH6q1HAKc3ywkV4aEsGjLzh45/Wxumg/DQo5
   Qf0EKbYAT2zpha0IBA4BSlveKH9e+8VhfFWeRudSbVrWcPs1TomIPzfbz
   WBcqUb6d8uyZsVwsyJnyaeDBpeAK4IMvAmSX2R9jNN8Alb50eMGzVz1hg
   w==;
X-CSE-ConnectionGUID: XwrylCUBTrmSIP9W5kdkUQ==
X-CSE-MsgGUID: ZdFFtsw+Q0ms8FtbQxM0TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="21872801"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="21872801"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:19:55 -0700
X-CSE-ConnectionGUID: df/vEx8pR3afJWkNqwuTww==
X-CSE-MsgGUID: olgkIJfSThybBnmfEw1GiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="65349000"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa004.jf.intel.com with ESMTP; 19 Aug 2024 07:19:53 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Mickael Salaun" <mic@digikod.net>,
	linux-kernel@vger.kernel.org
Cc: Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] kthread: fix task state in kthread worker if being frozen
Date: Mon, 19 Aug 2024 22:15:51 +0800
Message-Id: <20240819141551.111610-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that during cpu hotplug test, the following
error was triggered:

 do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?)
 WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep

 handle_bug
 exc_invalid_op
 asm_exc_invalid_op
 __might_sleep
 __might_sleep
 kthread_worker_fn
 kthread_worker_fn
 kthread
 __cfi_kthread_worker_fn
 ret_from_fork
 __cfi_kthread
 ret_from_fork_asm

Peter pointed out that there is a race condition when the kworker is being
frozen and falls into try_to_freeze() with TASK_INTERRUPTIBLE, which
triggeres the warning.

Fix this by explicitly set the TASK_RUNNING before entering try_to_freeze().

Fixes: b56c0d8937e6 ("kthread: implement kthread_worker")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408161619.9ed8b83e-lkp@intel.com
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/kthread.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976ff88a..06ab3ada9cf1 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -848,6 +848,12 @@ int kthread_worker_fn(void *worker_ptr)
 	} else if (!freezing(current))
 		schedule();
 
+	/*
+	 * Explicitly set the running state in case we are being
+	 * frozen and skip the schedule() above. try_to_freeze()
+	 * expects the current task to be in the running state.
+	 */
+	__set_current_state(TASK_RUNNING);
 	try_to_freeze();
 	cond_resched();
 	goto repeat;
-- 
2.25.1


