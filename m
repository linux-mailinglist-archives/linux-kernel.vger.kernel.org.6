Return-Path: <linux-kernel+bounces-577059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD6A717D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3263B24C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB11EEA59;
	Wed, 26 Mar 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c36Wb3YI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E7189919
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997176; cv=none; b=Pqlo1SUbfnazH+6qk0UL1rQ9k6KU1/9XpqVk1zzM4KlP1oJwDUVDTKn6sTM0INKk3aCFMifbGQfwTIbQQFlJTobmPtDnFJU8egPFTF2Ki3ctiJAyWNq99XFoOgRS8NW6+W7Vgb9oACBwYF4oVd/myE81R78ZD3Ck15mhcIkZuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997176; c=relaxed/simple;
	bh=9EZH2RNbfr3zOJTrviD/ohDEVUX3zOe1FaKhtPJ1qWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eIj4eN1m2e66chEsSqEY+IcPJZ6Z6HXokHsZHg0ikNBN15qAdj9qJ23uV6HXD+KEahI3d2tc6x6ppvbqR1230UUg1NfjDY+BS0N6dDga2cf6ECVbHK9cyYhj5pR8FUe98+zcr8mDU/6OmOJ/ev9fNEwz/M37VHFZd9hD+BcC/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c36Wb3YI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742997175; x=1774533175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9EZH2RNbfr3zOJTrviD/ohDEVUX3zOe1FaKhtPJ1qWY=;
  b=c36Wb3YIfINZxxthuB5Ca7BhvN5ceefQ4HCBiA9boX500B7ZNnjPvCz+
   W0f6jYH22eslwIONb4vCbAsjna5IRlivKeHdcLy3+0GuGC2ZwmTs+R9J/
   ABSXZDqQ6PSBtMQ6nW3Xgtc2v905wp+dFsA+EVxanSIR22RtHqpU9F8t+
   lTVhIc3zrjhViy4yXr1P8qJUyg6iM/OS/WYfgwxLfBbEXi8lKSzPz+50Y
   kq5g+wCyLgACtE6wwTD4pbUK2VX1iCFja+D0vuttXEoTJIrTK/VAHgPQ+
   /LDUoYUfE20A9qN7AK0MRfZuDd8j/vGx9NF227E+OKqn1LhmiCwRNemM1
   A==;
X-CSE-ConnectionGUID: 3S5hm4JhSH+X7q3zRqFy3Q==
X-CSE-MsgGUID: P+kSOitPRyyNNrOx4A3P1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44173740"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44173740"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 06:52:55 -0700
X-CSE-ConnectionGUID: FBIaRJkOQh2bIuWGS1lmYg==
X-CSE-MsgGUID: oxyIoJwERFy2YAXZ4aWn6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="125286811"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2025 06:52:55 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf: Only one Kmem cache for the per-task PMU-specific data
Date: Wed, 26 Mar 2025 06:52:52 -0700
Message-Id: <20250326135252.1690293-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Some PMU-specific data has to be saved/restored during context switch,
e.g. LBR call stack data. The data is saved in the kmem_cache *ctx_cache
of task_struct. However, the current implementation only supports one
user.

There is no problem for now, because the Intel LBR call stack is the
only user. But if other PMUs also want to add a new kmem_cache to save
their specific data later, there must be a bug.

Add a global pointer perf_ctx_cache to save the kmem_cache address of a
PMU for the PMU-specific data. If a later PMU claims a different
address, fail the registration.
(There could be two or more PMUs which share the same kmem_cache
address, e.g., Intel hybrid. So, here can only use the address rather
than the number of PMUs for the check.)

Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Closes: https://lore.kernel.org/lkml/20250317111045.GA36386@noisy.programming.kicks-ass.net/
---
 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ce9795e5519..106fd554fc42 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -443,6 +443,7 @@ static cpumask_var_t perf_online_cluster_mask;
 static cpumask_var_t perf_online_pkg_mask;
 static cpumask_var_t perf_online_sys_mask;
 static struct kmem_cache *perf_event_cache;
+static struct kmem_cache *perf_ctx_cache;
 
 /*
  * perf event paranoia level:
@@ -12189,6 +12190,21 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 		      "Can not register a pmu with an invalid scope.\n"))
 		return -EINVAL;
 
+	if (pmu->task_ctx_cache) {
+		/*
+		 * The PMU-specific data is saved in the Kmem cache
+		 * ctx_cache of task_struct. It only supports one
+		 * user. Check and fail the registration if there
+		 * are more potential users.
+		 */
+		if (!perf_ctx_cache)
+			perf_ctx_cache = pmu->task_ctx_cache;
+		if (WARN_ONCE(perf_ctx_cache != pmu->task_ctx_cache,
+			      "The PMU-specific buffer of task has been reserved by other PMUs.\n"))
+			return -EINVAL;
+
+	}
+
 	pmu->name = name;
 
 	if (type >= 0)
-- 
2.38.1


