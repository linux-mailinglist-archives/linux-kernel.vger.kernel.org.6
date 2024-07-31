Return-Path: <linux-kernel+bounces-268373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9B89423D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012D4283F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370AEDF51;
	Wed, 31 Jul 2024 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSU3uVTS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C700523A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385835; cv=none; b=NnEXmEO2cyX/2mcgCvb9Gw3MXhcUh05zmz1fxjexrg2ax3GsK3EQDi8Um/U3M72xkWohQmJOhfYxpX2zo8Izijmv+vOnWVNrNko1iEFBxcCnRYC9zAOyF5niF42nFy95t/QHRxNVjzSEZDd9pNJNz9zkwhUN9J34+kSGN4iWeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385835; c=relaxed/simple;
	bh=ptiJFpcxcUokqaP9PdFq+FGJm+jDe2svhscYd8NXJ0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrM3i0XsKzozHm87XOtldsepvGpYgeDDZisi2GLFgSb5XQwO9RaeHDfnuKccr+/7OYjyc7IHBL+R1wM0XdPSKumQ0nmrlimkSVFc2JXedDoAWeBmGBiYpsYFyfHpeCrC0BBdPaJqHP78RPAI8253ZbIY4TvYy9sHd7jZA6d7ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSU3uVTS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722385834; x=1753921834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ptiJFpcxcUokqaP9PdFq+FGJm+jDe2svhscYd8NXJ0M=;
  b=kSU3uVTS7cEAmx16NrLOx8oUXRNcRybYO0TjcAbUWsesPcbS069AWfQi
   Nfy46T+kEWNiLBegg1r8Q4Y9VHFiADcRw+6kE9KA3/SoqUgQ7IQJigI4i
   f3mDi251crEsoDsnzHjOPj/QixHOFDBRhcrMp7yoluMVwGSYz9JDl3Tj/
   9Y9N2wiqcbraIMdC4r3zqE3FwmopyICCNB7kTKN0bu8T1RCSI1kLXg490
   AoUEK4lpwe+8XPIuFRXb+acctYY4NSvVkmIW5VoQjjQan+z57km09di24
   t14kmz/IlbSJM2+4RXqnbnJp/nZ3V59rO9RdBfGe1smE+IFQB+z3gGJMW
   g==;
X-CSE-ConnectionGUID: s+CtFGksSTiTtmEEY6hGAA==
X-CSE-MsgGUID: 0tdvTzR0Ru2jNiixyVPSlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="23156093"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23156093"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
X-CSE-ConnectionGUID: iSfPjd5kQ5icKwrUydTiXg==
X-CSE-MsgGUID: fB0Js/7+TwuoyWm2ZHUMug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="77781800"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v2 4/5] drm/sched: Use drm sched lockdep map for submit_wq
Date: Tue, 30 Jul 2024 17:31:18 -0700
Message-Id: <20240731003119.2422940-5-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731003119.2422940-1-matthew.brost@intel.com>
References: <20240731003119.2422940-1-matthew.brost@intel.com>
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

v2:
 - Use alloc_ordered_workqueue_lockdep_map (Tejun)

Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index ab53ab486fe6..cf79d348cb32 100644
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
 
@@ -1272,7 +1278,12 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 		sched->submit_wq = submit_wq;
 		sched->own_submit_wq = false;
 	} else {
+#ifdef CONFIG_LOCKDEP
+		sched->submit_wq = alloc_ordered_workqueue_lockdep_map(name, 0,
+								       &drm_sched_lockdep_map);
+#else
 		sched->submit_wq = alloc_ordered_workqueue(name, 0);
+#endif
 		if (!sched->submit_wq)
 			return -ENOMEM;
 
-- 
2.34.1


