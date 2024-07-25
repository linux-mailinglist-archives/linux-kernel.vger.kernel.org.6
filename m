Return-Path: <linux-kernel+bounces-262376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE55893C62F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA244282AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB24019D097;
	Thu, 25 Jul 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8HLzu7a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E407482
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920280; cv=none; b=PXZVIpI95ZXNjCKP4dLSoClbTkCGr9UhawzxBUZtB89DmoeTovexfaSGTdFB5HIMrrIMLjyK22RvUn+JXiQtqor0x5duOVwbQnMi9lU3mT5ndyzicOoMR77CEhCjVcEjUVVJ7zrhLh5YXp74hv4EL84w2SmtIA/432ZVqyt0d7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920280; c=relaxed/simple;
	bh=RDA2VrRAE/IIlxWaSQLIDHC8rCsMYDyViCallkFB8d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HgW2EnO09eSExT0LDY+dAklxv01QzfnQ3qTEwYPZ6KyaHk3fusTtwIi1kXmdHYVOrKhh27VdSHQAmNTNkneb4DzjdDuCsxSrlDngq5olMYlj9hbuBIAO4/HO3q6zfrwyCF6myjD0msbSYfacXlk+LoZ/nOE34JL7TwACIKnNoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8HLzu7a; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721920279; x=1753456279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RDA2VrRAE/IIlxWaSQLIDHC8rCsMYDyViCallkFB8d8=;
  b=M8HLzu7ai6xYx2W4K5GUDGLd9Hh+XJIQNUUh7c0QaP73X3aEh7FOLGVO
   vaPrB0E3Zn0MK6Sdglghozjw7Yl91KP9UN4mipVCjYjfsf0FxgeFEdjpF
   SfE59zZ2C5kD5sX49o/YvwMA3vUELK2lDXHgwnz9BYlvN1aK6cvnEWQEX
   HAG1xGQXLZzQq7gJl5wsi7ZfaUAHMdP1+l7WfEp3iDYipqvitmsM2JVEv
   AltKvHLd/5AUOzp+GJ0hEZE5zZ+eVKKrth5ucevTkma5+2omDyCNB6zs/
   g0HsSZDqkDq4V0Vpaze6w02+yNUaIHN82AXhWlULvTQeCSwuFxYTVWpbV
   g==;
X-CSE-ConnectionGUID: LOCZz/kaTO2jc0/nDAo+Ww==
X-CSE-MsgGUID: A3WRBAu0SYOdvRDs6Sst4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="42195238"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="42195238"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 08:11:15 -0700
X-CSE-ConnectionGUID: UvIC7JJHTd6Llyt2P9lW5A==
X-CSE-MsgGUID: eiUJ9P8aQl6sO+m3BeFfzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="52645293"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmviesa006.fm.intel.com with ESMTP; 25 Jul 2024 08:11:12 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2] sched/pelt: Use rq_clock_task() for hw_pressure
Date: Thu, 25 Jul 2024 23:08:20 +0800
Message-Id: <20240725150820.376623-1-yu.c.chen@intel.com>
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
v1->v2:
  Added Hongyan's Reviewed-by tag.
  Removed the Reported-by/Closes tags because they are not related
  to this fix.(Hongyan Xia)
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


