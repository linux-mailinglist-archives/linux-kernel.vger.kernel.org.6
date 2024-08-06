Return-Path: <linux-kernel+bounces-275549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB894871A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0229E1F2374F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4EA94A;
	Tue,  6 Aug 2024 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTYHvLOm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01055680
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909290; cv=none; b=oiy73O132M2dRZ4nl26GjB/K1oZZSMvN8xaVkqWpWJn3+P5+ZmJStZk7Nh7g6HOImpjJhDHvvX65JzqhZxZEZvRaLpUKN7MECRtXb/esvnBQGOc1iYTjEESJEZM254I85eK24ArxyVxyLqC2adJpmIqAaMyqXib5aeLrmYBQUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909290; c=relaxed/simple;
	bh=l3P+sWlG49dEajhUZVn/VpXxf0aNd7VSFLiaIGNd8U8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8WHliECGkGjAQj219UGuZ6y7k65NBDSLXouKEMX/pNow6iZhqfoU9KyLmmxyFttRKcJD2ATIpS0YCvmvPkRblXxcWjp+3KCYJnzb8UcTErCA/oYcUuz0oswWRCXJzLrW+fBjluGi7ym8mQBSfHDyWLZ5+/Z55xFtkoIwhNXn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTYHvLOm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722909288; x=1754445288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l3P+sWlG49dEajhUZVn/VpXxf0aNd7VSFLiaIGNd8U8=;
  b=gTYHvLOmZqIgvKNDPqFQE+Xe+fye6BnZ6utXofRUtPWb3xhs0hz8KXvE
   RVJN/xtAqXkEYcXQJrx3+ycUhQlXj4hHNzjS58XdLEeIhBvQysZm/E3To
   NaJiQxJSn9eN/TY1rs6iLdcsKGKwcI37fjVilzEv0pjqMyytYJxlcwmzW
   piVDzQyBg1I5atEGwaZksvFENLBTZERiNCySqlOUZ0r1LP9ypat5Y9YVo
   heC1ZcybyYabOxycNPo5mege38yH0nHQb/Q6Xp0xzDsQg5BSsBtTGqnSx
   dQk+0on5zIYIjolQuxtTG1+qfYX91N27kUABdX883GYPiLjD37FxcIbIS
   g==;
X-CSE-ConnectionGUID: OCP9HaIFR6Kil8K3TQHvLQ==
X-CSE-MsgGUID: Mhcvk1iNT96Mp8xkOPPtqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38356161"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="38356161"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:54:47 -0700
X-CSE-ConnectionGUID: xeLk48JMQx+xDopx3UqIEA==
X-CSE-MsgGUID: cYkfx0NqTmiWCtNuL5iKDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56024398"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmviesa006.fm.intel.com with ESMTP; 05 Aug 2024 18:54:44 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v4] sched/pelt: Use rq_clock_task() for hw_pressure
Date: Tue,  6 Aug 2024 09:50:34 +0800
Message-Id: <20240806015034.27137-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
removed the decay_shift for hw_pressure. This commit uses the
sched_clock_task() in sched_tick() while it replaces the
sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
This could bring inconsistence. One possible scenario I can think of
is in ___update_load_sum():

u64 delta = now - sa->last_update_time

'now' could be calculated by rq_clock_pelt() from
__update_blocked_others(), and last_update_time was calculated by
rq_clock_task() previously from sched_tick(). Usually the former
chases after the latter, it cause a very large 'delta' and brings
unexpected behavior.

Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v3->v4:
  Revert to v2 to keep the clock outside of pelt functions.
  (Vincent Guittot)
  Added comments for hw_pressure within __update_blocked_others().
  (Qais Yousef)
v2>v3:
  call rq_clock_task() inside update_hw_load_avg() to avoid any
  inconsistence in the future. (Qais Yousef)
  Added comments around update_hw_load_avg(). (Qais Yousef)
v1->v2:
  Added Hongyan's Reviewed-by tag.
  Removed the Reported-by/Closes tags because they are not related
  to this fix.(Hongyan Xia)
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..5176db6ae13d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9360,9 +9360,10 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 
+	/* hw_pressure doesn't care about invariance */
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(now, rq, hw_pressure) |
+		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
-- 
2.25.1


