Return-Path: <linux-kernel+bounces-410240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A319CD6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6933C2832F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573FA18455B;
	Fri, 15 Nov 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fd0TRPyy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3317BB1A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650402; cv=none; b=Mhh7x/s+9EHeeuRVC9wzfjMImuNX+6PDLERJgPXLWheyDXbN4PPNBRxaibbY/deshL5KghVzgiS3Ark+ZfAYoxI3dCjuHFcYankJpThcAgeA2Lv+bNXfVwwlCnBMych9RCO/ppGN0BHhSP2wFHSY7lEGGwaAEssGIER1QOU4VpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650402; c=relaxed/simple;
	bh=Ef9qmy9/+YQFUZDAdflDMtwyWYsWVmEaFOO0KWemWBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYjf5mrDOCbXEHz2R8ZE/t4tM+Lo9YXRuYapomRgEoL5SxNEQn+Ub2cLrrxBKQKTgJSmIsfnrrc8RVscxZsdfB+rlEzXbk/ZrzgB3/ADgkVpQ9mQ+sqPx0SxLJ30+pN127Wca0CimIQ/HAKKmYUBpW84lltFu86Np95cNruNnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fd0TRPyy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731650401; x=1763186401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ef9qmy9/+YQFUZDAdflDMtwyWYsWVmEaFOO0KWemWBw=;
  b=fd0TRPyyJbdmBAhH32+9px9NYtcHW8zFiNrC07gnfQKaWZ5h+kwxDAuF
   QWzGXliG8T4E0/+cevPR8m8DjrS6rOIpGmJNvLH8SGkN04QW5VJBQ8JSD
   lA/VwoS97Vn/WcGV20Urp5welwTxEve0Pg3iWwEOkeNEvYeIdpsAd0er/
   Rw5oWVrv1SIaI4SFgQb66vymYwPNLy+p5g0Yn2RlbbYFZdHemo0GM+OoK
   S6wgiMHrtip4ow/jNB6WXjsa2QBz8i45tSHvVSCxvhSzwBLpjNjsEAgR0
   VKu03eiYOsGz6ZBoywU96EqumGQ4oqXGu/ovLoSn5JaCon5mbhCOo2Rt7
   A==;
X-CSE-ConnectionGUID: OvNGMZMzTYSOi50y8LiMVA==
X-CSE-MsgGUID: AwlZnciiQfm0mUSzAhXuDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="35563348"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="35563348"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 22:00:00 -0800
X-CSE-ConnectionGUID: KmwkdsQBRXq9/WOqEnA4lA==
X-CSE-MsgGUID: WJsufqrJR6SsarhutJCvzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="88846261"
Received: from linux-pnp-server-11.sh.intel.com ([10.239.176.178])
  by fmviesa009.fm.intel.com with ESMTP; 14 Nov 2024 21:59:58 -0800
From: Wangyang Guo <wangyang.guo@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: Wangyang Guo <wangyang.guo@intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tim Chen <tim.c.chen@linux.intel.com>,
	tianyou.li@intel.com,
	pan.deng@intel.com
Subject: [PATCH] workqueue: Reduce expensive locks for unbound workqueue
Date: Fri, 15 Nov 2024 13:49:36 +0800
Message-ID: <20241115054936.113567-1-wangyang.guo@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For unbound workqueue, pwqs usually map to just a few pools. Most of
the time, pwqs will be linked sequentially to wq->pwqs list by cpu
index.  Usually, consecutive CPUs have the same workqueue attribute
(e.g. belong to the same NUMA node). This makes pwqs with the same
pool cluster together in the pwq list.

Only do lock/unlock if the pool has changed in flush_workqueue_prep_pwqs().
This reduces the number of expensive lock operations.

The performance data shows this change boosts FIO by 65x in some cases
when multiple concurrent threads write to xfs mount points with fsync.

FIO Benchmark Details
- FIO version: v3.35
- FIO Options: ioengine=libaio,iodepth=64,norandommap=1,rw=write,
  size=128M,bs=4k,fsync=1
- FIO Job Configs: 64 jobs in total writing to 4 mount points (ramdisks
  formatted as xfs file system).
- Kernel Codebase: v6.12-rc5
- Test Platform: Xeon 8380 (2 sockets)

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Wangyang Guo <wangyang.guo@intel.com>
---
 kernel/workqueue.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9949ffad8df0..8b07576814a5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3833,16 +3833,28 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 {
 	bool wait = false;
 	struct pool_workqueue *pwq;
+	struct worker_pool *current_pool = NULL;
 
 	if (flush_color >= 0) {
 		WARN_ON_ONCE(atomic_read(&wq->nr_pwqs_to_flush));
 		atomic_set(&wq->nr_pwqs_to_flush, 1);
 	}
 
+	/*
+	 * For unbound workqueue, pwqs will map to only a few pools.
+	 * Most of the time, pwqs within the same pool will be linked
+	 * sequentially to wq->pwqs by cpu index. So in the majority
+	 * of pwq iters, the pool is the same, only doing lock/unlock
+	 * if the pool has changed. This can largely reduce expensive
+	 * lock operations.
+	 */
 	for_each_pwq(pwq, wq) {
-		struct worker_pool *pool = pwq->pool;
-
-		raw_spin_lock_irq(&pool->lock);
+		if (current_pool != pwq->pool) {
+			if (likely(current_pool))
+				raw_spin_unlock_irq(&current_pool->lock);
+			current_pool = pwq->pool;
+			raw_spin_lock_irq(&current_pool->lock);
+		}
 
 		if (flush_color >= 0) {
 			WARN_ON_ONCE(pwq->flush_color != -1);
@@ -3859,9 +3871,11 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 			pwq->work_color = work_color;
 		}
 
-		raw_spin_unlock_irq(&pool->lock);
 	}
 
+	if (current_pool)
+		raw_spin_unlock_irq(&current_pool->lock);
+
 	if (flush_color >= 0 && atomic_dec_and_test(&wq->nr_pwqs_to_flush))
 		complete(&wq->first_flusher->done);
 
-- 
2.43.5


