Return-Path: <linux-kernel+bounces-281605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7038094D8B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5F02843F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5F516D315;
	Fri,  9 Aug 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhRYautH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644116A957
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242468; cv=none; b=dBPHa3s6pfRHIEZg6QZvA+VWiYExAQw3Dc3Ctu697WGG5bEntVQBD1VO0Oj+EJ7PARnYfwRUKsA6gpHP5Pqb9lSEZxFNZbkcn0UWcEIffqIWUwwW7lXfcOMXvMVArQ8+ay+4t8k1AAIHExaKtd5cUyThlTLL7F1oSXB4TWisbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242468; c=relaxed/simple;
	bh=ptiJFpcxcUokqaP9PdFq+FGJm+jDe2svhscYd8NXJ0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vu7xK0BVSUkePUgmuJUymFPG3grBEAPiYVarUQPGAle1IiRP5KE2S9afdQnhEf4NTSjqJ2YhWKAVKXmRQfoEwlsDzH7dzgGx74HXrOWCb8i6OStQeb4AM3BMfoTcN8HAyhM1wB1/gFvN40KkWLjkO5lkHEcILGrUeZS90cBsrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhRYautH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723242467; x=1754778467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ptiJFpcxcUokqaP9PdFq+FGJm+jDe2svhscYd8NXJ0M=;
  b=AhRYautH4xvkv/vioes3LNNdwIfSIYUQAKVkaN8Ld1c5nDFjwG+sgVhE
   YZfriy0A6ocDkaESxKALNHPdF/D+61lpMyPBktS8NEUYR91wrUFvkuDjZ
   1VLE0lrbZ4b44a5dSsJo8NMQMjhyZu4M06mXRttNyRkwAF5rMuN28LcwT
   6X+OlECWha2EAXLR0Y0YbJca5vOLA3Z96r9dK9GjGSqE786GDgt8fQ15y
   GjqWWjgTAmx4JTJAs4m02kSXojnxZFxaFmRx+8A9cpz8I45blSkqcQORU
   25IXNYEnRY4w7KxniDQTWkpOQn0C1V2eTkP5g7e+/Ts3izAHv6N02Z3xw
   A==;
X-CSE-ConnectionGUID: PXxUshVaRdS2pUM+QTovmQ==
X-CSE-MsgGUID: 4OCspbBNTsepapYQd4+5Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25229659"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25229659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
X-CSE-ConnectionGUID: s8KxR0Z2R42/B+NEObfnew==
X-CSE-MsgGUID: PT9E3ignQ3m6u8bx2QvGBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62641785"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v3 4/5] drm/sched: Use drm sched lockdep map for submit_wq
Date: Fri,  9 Aug 2024 15:28:26 -0700
Message-Id: <20240809222827.3211998-5-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809222827.3211998-1-matthew.brost@intel.com>
References: <20240809222827.3211998-1-matthew.brost@intel.com>
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


