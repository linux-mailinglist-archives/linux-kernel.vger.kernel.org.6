Return-Path: <linux-kernel+bounces-262123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5F93C111
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6841F221B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C4199249;
	Thu, 25 Jul 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9E3v+Xn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129A573440
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907895; cv=none; b=DNFKXLGi7qxrosTokjcntd6wDqLHGOpiDLckR7u4UF4zd2ZMk5qAdKaDCJpKFydnkZOs/InJiZH4I6FkJAsKd523YzU8xihoqvACRi8u0KPf8yuyO5bskyKgYKmDKd+suvyWdYTxNMfH/pFOeps9Y7yLH9huYmTc/6jfKaGijOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907895; c=relaxed/simple;
	bh=tTsn5Xrue7/wTYH4LTNBkBEx5HY2C2OIAknl1zukJDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c1cSATLIW7IY7U0P6X9n6Hc/zxZSZ4Alf1Gco9rk8WxgnA494X/vJPup+WsO2fyl33JZVDlu85q5my7FTbV1MU+2sjV2YcCQr7QKyVbXN1x7zKi0x5m1qp3dw6DoHn88U22Khg71iICZlAIPgd33EfPjjltsGcvQhYZiDmvQKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9E3v+Xn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721907894; x=1753443894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tTsn5Xrue7/wTYH4LTNBkBEx5HY2C2OIAknl1zukJDk=;
  b=a9E3v+Xn0My1HDlMlGw0eUqEKV5E4aU3Zr3pT8EtAw1MBpCxgoPeVts2
   jSHWwEZ6Imi5tDAci4/TO4hc1ZvwWEQIAAVOoSDL6fpWbi8XRJoSYsvkC
   3yWHUTKLvIcGfL+bUpbOq7JoEKSi/SY0+7w/3/rE0pommW+YJ2iBeQz/q
   Rspaf3biT2D6PJ8L1U0SiiTMPWBNAd1Ot972HQwzB11bp/BU3c2FKE1Mt
   LPYaTPxZllSi3G7vL14WiciAkgcNp5js2IkoHxfnwB0rM9YwNn+c6IcjB
   uIgd6659dhzD0nFepgIIRGPLezBtzvjN35eSDj+8jYWvEb6iqqWoJmihr
   A==;
X-CSE-ConnectionGUID: AnS/mCZiSPSEXvwVkmRX6Q==
X-CSE-MsgGUID: u3XLsDRkQcGsQrLKfktvSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19332718"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="19332718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 04:44:53 -0700
X-CSE-ConnectionGUID: f81p71tERLm2hi1Is+STxg==
X-CSE-MsgGUID: J6EPIztHQPuGZsv5xXqQPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="57044113"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jul 2024 04:44:51 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] sched/pelt: Use rq_clock_task() for hw_pressure
Date: Thu, 25 Jul 2024 19:42:00 +0800
Message-Id: <20240725114200.375611-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
removed the decay_shift for hw_pressure. While looking at a related
bug report, it is found that this commit uses the sched_clock_task()
in sched_tick() while replaces the sched_clock_task() with rq_clock_pelt()
in __update_blocked_others(). This could bring inconsistence. One possible
scenario I can think of is in ___update_load_sum():

u64 delta = now - sa->last_update_time

'now' could be calculated by rq_clock_pelt() from
__update_blocked_others(), and last_update_time was calculated by
rq_clock_task() previously from sched_tick(). Usually the former chases
after the latter, it cause a very large 'delta' and brings unexpected
behavior. Although this should not impact x86 platform in the bug report,
it should be fixed for other platforms.

Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407091527.bb0be229-lkp@intel.com
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..cfd4755954fd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(now, rq, hw_pressure) |
+		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
-- 
2.25.1


