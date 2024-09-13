Return-Path: <linux-kernel+bounces-328611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0AA97866F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C781F23794
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982DD77103;
	Fri, 13 Sep 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBnmKv1K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C38060A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247408; cv=none; b=J8gg+Jf434bX6ByHVHz9W3e53ukNUEPqMmYO5zDh2tTrVmS+XPRLeL8bag6OOukhQHzHBq1BYRx0RBu4uAzfJvreXSeenYeVIIv+kibvoNRKGOLwOFkA/qCvn6OJRndn/wROn/gJgTNaBNAlTUaojSptJdrvoZzJKCosJLj18Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247408; c=relaxed/simple;
	bh=rHT25i/hqDVVe1It884TfoF0+3guk57mQru2dJ2+Cic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l6BurYzriQURM+YwdNtTBJGR9tSRwUP6fSkWfNBWf6jbZQNNceGpU7XInUgXPxxzRIgb3+h0CN430VUawysFHxnQ0nMoOzbv77Rq7vB1xM2TWMTJeBs+d1Tray8OlDfJLu6TSESPEUjMMHe3cy0DHdRRG3IPMm+MCp0nutxHsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBnmKv1K; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726247406; x=1757783406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rHT25i/hqDVVe1It884TfoF0+3guk57mQru2dJ2+Cic=;
  b=OBnmKv1K9xPp+nPtDRqhYKNBXyOvB0iTcyQAsvKcDxwUnJJNfSC394pp
   SWA3kog89c0K0JL4LzAe2OfaUbChJRJu2wnCnmCmMFMmZFk4uqGrkIpqG
   /So/xQvrMG9NeKvEzRspp0AGzD1s9g0UDoaKoro3Cn2T0ycW+9WQREjG1
   b5eTXit73ZKw0XB5zFzqbi6d4K3dre3jQLo3+7m4dm3uWOghGvk+JL5mI
   v8ZOpf+/uhKsbYVPRk027pGFiK3xRroUvJbqIyklsK9UCPAmwWyzt5e+8
   Sj5+0AFlTezRURJooNjvSVTt0B6oXp/ObhEPvPktZjNRcPKa6b5v66mFV
   A==;
X-CSE-ConnectionGUID: rOQUN39VQGymoz7voDX6ng==
X-CSE-MsgGUID: yhkwIhVeRkOj6MZJ8GE9Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28071595"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="28071595"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:10:04 -0700
X-CSE-ConnectionGUID: 1rDqj6M2QxypqcmpmC/B5A==
X-CSE-MsgGUID: 08zOq9KfRqmeJlo1M7cTgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72888979"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 13 Sep 2024 10:10:04 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 1/2] perf/x86/rapl: Move the pmu allocation out of CPU hotplug
Date: Fri, 13 Sep 2024 10:10:32 -0700
Message-Id: <20240913171033.2144124-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The rapl pmu just needs to be allocated once. It doesn't matter to be
allocated at each CPU hotplug, or the global init_rapl_pmus().

Move the pmu allocation to the init_rapl_pmus(). So the generic hotplug
supports can be applied.

Tested-by: Oliver Sang <oliver.sang@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---

Rebase on top of perf/core branch
commit bac2a553dbf2 ("perf/x86/intel: Add PMU support for ArrowLake-H")
Close the UBSAN issue.
https://lore.kernel.org/oe-lkp/202409111521.c7c6d56f-lkp@intel.com/

 arch/x86/events/rapl.c | 50 +++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a481a939862e..a6f31978a5b4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -602,19 +602,8 @@ static int rapl_cpu_online(unsigned int cpu)
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
-	if (!pmu) {
-		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
-		if (!pmu)
-			return -ENOMEM;
-
-		raw_spin_lock_init(&pmu->lock);
-		INIT_LIST_HEAD(&pmu->active_list);
-		pmu->pmu = &rapl_pmus->pmu;
-		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
-		rapl_hrtimer_init(pmu);
-
-		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
-	}
+	if (!pmu)
+		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
@@ -707,6 +696,38 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static void __init init_rapl_pmu(void)
+{
+	struct rapl_pmu *pmu;
+	s32 rapl_pmu_idx;
+	int cpu;
+
+	cpus_read_lock();
+
+	for_each_cpu(cpu, cpu_online_mask) {
+		pmu = cpu_to_rapl_pmu(cpu);
+		if (pmu)
+			continue;
+		rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+		if (WARN_ON_ONCE(rapl_pmu_idx < 0))
+			continue;
+
+		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
+		if (!pmu)
+			continue;
+
+		raw_spin_lock_init(&pmu->lock);
+		INIT_LIST_HEAD(&pmu->active_list);
+		pmu->pmu = &rapl_pmus->pmu;
+		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
+		rapl_hrtimer_init(pmu);
+
+		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
+	}
+
+	cpus_read_unlock();
+}
+
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages();
@@ -730,6 +751,9 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+
+	init_rapl_pmu();
+
 	return 0;
 }
 
-- 
2.38.1


