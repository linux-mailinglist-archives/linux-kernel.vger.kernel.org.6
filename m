Return-Path: <linux-kernel+bounces-303182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C787F9608B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DAD283E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6044D1A0AE0;
	Tue, 27 Aug 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7+dztS9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB01A08AD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758196; cv=none; b=UxA7mMrdzQCNW7KBpEc8zauYW7Uua11x5o2ch9H+r/7csAQV9wmeZTwFvd/SZHu8H1Q2dErizuyy33vqGJQlRB4c2n8r/QJ63Bk/5smhvqbrfKUAdwN0YdscoX9WYAId5+6jQ1OGyu1vxIN2bcatO1zYSH3Umq0zCRp1JWSYEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758196; c=relaxed/simple;
	bh=GkYKLfgfnNwC4VD+RaGs9j8NIwhkyZyTW1fbcrJQO9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HgsqvKtpmHhURJ10iYaqRNqbYysz7xcpznHM1+xL3X7U1RPALs6Gqlp42tT9wR7v0cDLgXFUvyIL6UJkeG5TfzrcCoHXTY0yEiiIApi2K9GkGxZMu6xPu3p4lASbz22B11X0LVgFB43kJJeaXgrAodW7VYMqjfrVXIAijaUeMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7+dztS9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724758195; x=1756294195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GkYKLfgfnNwC4VD+RaGs9j8NIwhkyZyTW1fbcrJQO9I=;
  b=U7+dztS9rCu89hnQcdDZ2fxp8eriDbRuezUEpH7A0nEDMZvMHmUJgomZ
   Grga0ngWg0YUuFytedAyJ6sQJ2fgr5QUBRK+zOKqwnBGIolWlqqVErLLf
   1vqXaaSnwGypIMYAH/OVbSkZK0UkQOOs5pUaZesS73jvQv+YnFCpB9PFH
   AIRV2HqYZ+Udli0M0uQwIy3zuqDh36DN73/nu3pi68mH1sGdpYCPq1jqo
   QwX0OcWlKr2dXDfx2Z+jCZKuOyJqGHoC4OaUDdhABbTgcAnQXhgZk3Pz8
   CfEgTHL8v+zYOWF65vXszaAOlErn94G5gypQ2wWpPUHu3VoXDR2ROkt3+
   g==;
X-CSE-ConnectionGUID: NpfW2Y8SR5K/I/N/pEjohQ==
X-CSE-MsgGUID: QSY1GzfwSaKsJVfWYsTTag==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23408212"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23408212"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:29:54 -0700
X-CSE-ConnectionGUID: pgyAvJwzTBiMDcYSOscqhw==
X-CSE-MsgGUID: 5wGp+HRqQ4uPCvEXv3aS9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63342969"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa007.jf.intel.com with ESMTP; 27 Aug 2024 04:29:52 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Qais Yousef <qyousef@layalina.io>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: [PATCH v5] sched/pelt: Use rq_clock_task() for hw_pressure
Date: Tue, 27 Aug 2024 19:26:07 +0800
Message-Id: <20240827112607.181206-1-yu.c.chen@intel.com>
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
Cc: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v4->v5:
  Added Vincent's Reviewed-by tag.
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


