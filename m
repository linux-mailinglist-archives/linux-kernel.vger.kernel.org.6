Return-Path: <linux-kernel+bounces-268279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027AF9422A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854BBB24EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA81917E3;
	Tue, 30 Jul 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5oVYFx4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72E18E056
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377820; cv=none; b=OKGFL9IRu5dpe2RSWqrb2/Q3BSUh5iOgcyAirPBEYMScAe6L3a5Bpoa18bJfFAxyPNkqkXzsaKnRO5Bge3UhpO6DLqTCkX/lb/Plimv3qSe9KcmU4rj543LbH0li099+Xc/f6c0HSSm+V6462aBwqv6RoZOC+YmuEvHHMoRXmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377820; c=relaxed/simple;
	bh=y++SgnKsOkD1w3+gC/PYkBw3ruX/r97HkH5EBfT9tg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jq4S3QoMDnWfeNyaabSghhrSONhoXeY07wIAZhUW17cCL7dBW7K5swr8Yl1LAWNOSa0Ai31wKob7QADcj1r/QMeecRHBwukDt8TKWFGftCosaSQeOVG9g6Grwfu+XrZ1iUecXXFMLTdUm8cCOyIjrUHgTSbSc0tg9goJXUfWn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5oVYFx4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722377818; x=1753913818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y++SgnKsOkD1w3+gC/PYkBw3ruX/r97HkH5EBfT9tg0=;
  b=Q5oVYFx40eX0INVpDgErz+D55kce3EwiCex/3igoY1TKmCBqZX4G0AUG
   8ThFty61moYCu+6fJoXSXGyqOVdeJwi7vF+soAMW/9nOhQQ0G4csPtU11
   67uvHrvTzuohuUV6c6Hj4JcOK9Fpl3AYcXXSQV2G+QUU7RlEAQYFPE+VT
   LAMxMXRErOA3jyQaTaLomYDP0OyunZpLp9KWLnl0QfJrJs8jTrb/u1l7a
   jjxCKi/N+nhYfJ9xiFy42/PWnHJaTh3XiZaVjyQsa3tNfsEwqF8XwVN9O
   L8t/xvvv/CgIvfhwOdEEZTUxHYM5twN4jTe+PjP1QZg0rYYnWjfht5uLe
   g==;
X-CSE-ConnectionGUID: Wf1XxqusRCi1OIoBtnGyUg==
X-CSE-MsgGUID: vUjyMCICT1Cadil6rIfKOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="24094128"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24094128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 15:16:55 -0700
X-CSE-ConnectionGUID: UyTdp70ORjW+jKpD1cQbHQ==
X-CSE-MsgGUID: M+gAdEy3QNqg8wkpDRBsSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58613344"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 15:16:56 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [RFC PATCH 2/3] drm/sched: Use drm sched lockdep map for submit_wq
Date: Tue, 30 Jul 2024 15:17:41 -0700
Message-Id: <20240730221742.2248527-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730221742.2248527-1-matthew.brost@intel.com>
References: <20240730221742.2248527-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid leaking a lockdep map on each drm sched creation and destruction
by using a single lockdep map for all drm sched allocated submit_wq.

Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index ab53ab486fe6..9849fd64aff9 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -87,6 +87,12 @@
 #define CREATE_TRACE_POINTS
 #include "gpu_scheduler_trace.h"
 
+#ifdef CONFIG_LOCKDEP
+static struct lockdep_map drm_sched_lockdep_map = {
+	.name = "drm_sched_lockdep_map"
+};
+#endif
+
 #define to_drm_sched_job(sched_job)		\
 		container_of((sched_job), struct drm_sched_job, queue_node)
 
@@ -1272,9 +1278,13 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 		sched->submit_wq = submit_wq;
 		sched->own_submit_wq = false;
 	} else {
-		sched->submit_wq = alloc_ordered_workqueue(name, 0);
+		sched->submit_wq = alloc_ordered_workqueue(name, WQ_USER_OWNED_LOCKDEP);
 		if (!sched->submit_wq)
 			return -ENOMEM;
+#ifdef CONFIG_LOCKDEP
+		wq_init_user_lockdep_map(sched->submit_wq,
+					 &drm_sched_lockdep_map);
+#endif
 
 		sched->own_submit_wq = true;
 	}
-- 
2.34.1


