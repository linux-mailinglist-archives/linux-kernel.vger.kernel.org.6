Return-Path: <linux-kernel+bounces-359262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6CB9989AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9674BB32DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F91CBEAA;
	Thu, 10 Oct 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhaTN2+F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5901CB31A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570305; cv=none; b=ZUUj5TQCP+M/cL95jGmgFIiH2GaNfWJ45n3PjA4pkDKWQ5/9ZnkRC1J7mdkDTiIGzYLp4nQEeBTKko6rJqgmIzVpkeSDgB7EZ2Ad8x5fILQ1Nu0eODRToEv/DMm1ppABL/hk57isk5Rj/MM0UJVXO2bOF2NaXuvl26F7i0J8bhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570305; c=relaxed/simple;
	bh=V0YGE1YEigr+ZaMkTbT0zkpMKQ2IH2dBz2go4n9RBqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MJIKsl9D2I4ANn+2wE1jK8bs3pr68g+bXCKSsxLZ3RWDggqqcHQ86gBfgM4ghw/FUAJ/ySwg6WSlhTTzGWS/iDtsyzMwKgD/+CLgh39I+y1qjj6Hebi5Mf28V+0qFez+T5EXJ6ZZ+HQVOnQUUIODcNUhO1Ef8s2lekM8bhNVwlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhaTN2+F; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570304; x=1760106304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V0YGE1YEigr+ZaMkTbT0zkpMKQ2IH2dBz2go4n9RBqo=;
  b=JhaTN2+FLfMvjplD5gpRvuiju0b8a+h2KCgjIIcFlZgfVFGzIhJWeBnk
   VAy9pLPwBkTCwosB+2aQpais2q2MQ5cFEvyJlbstY/HzEI4pzFAY25LfQ
   eFUfnKxWIqsvmdeOQpQVFDvWWDLnRiiUB58yrH6SqipJKb/oOX7rDJmqF
   UntxlHpGqYPsrseEJl5FEfEAtvTJCKJn1y65PUEyWqC5jBBHp+TCigwWd
   4U5e1C0922N4KBzrSi/r8rNEA7+7mzlBHEJVV7RPJUmtyxOEvwwyM/cB9
   9cZPyhX8H9X4ISoWx6w/Kvc+JdQW0PZCTPXVBTijOuuq7y52I/bz3B2RY
   A==;
X-CSE-ConnectionGUID: aC8/81WgRdyuXDNgZXzCYQ==
X-CSE-MsgGUID: VdXOZ5AJRdGACtdAhA+l1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38501284"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="38501284"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:25:03 -0700
X-CSE-ConnectionGUID: h5bJ3OXYS4uMZl84oWFKUA==
X-CSE-MsgGUID: vVJII0n0RlC0KbqDlZBwwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="77422954"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa008.jf.intel.com with ESMTP; 10 Oct 2024 07:25:03 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH V2 1/2] perf/x86/rapl: Move the pmu allocation out of CPU hotplug
Date: Thu, 10 Oct 2024 07:26:03 -0700
Message-Id: <20241010142604.770192-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

There are extra codes in the CPU hotplug function to allocate rapl pmus.
The generic PMU hotplug support is hard to be applied.

As long as the rapl pmus can be allocated upfront for each die/socket,
the code doesn't need to be implemented in the CPU hotplug function.
Move the code to the init_rapl_pmus(), and allocate a PMU for each
possible die/socket.

Tested-by: Oliver Sang <oliver.sang@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 44 ++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a481a939862e..7764f739fa0a 100644
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
@@ -707,6 +696,32 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static int __init init_rapl_pmu(void)
+{
+	struct rapl_pmu *pmu;
+	int idx;
+
+	for (idx = 0; idx < rapl_pmus->nr_rapl_pmu; idx++) {
+		pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
+		if (!pmu)
+			goto free;
+
+		raw_spin_lock_init(&pmu->lock);
+		INIT_LIST_HEAD(&pmu->active_list);
+		pmu->pmu = &rapl_pmus->pmu;
+		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
+		rapl_hrtimer_init(pmu);
+
+		rapl_pmus->pmus[idx] = pmu;
+	}
+
+	return 0;
+free:
+	for (; idx > 0; idx--)
+		kfree(rapl_pmus->pmus[idx - 1]);
+	return -ENOMEM;
+}
+
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages();
@@ -730,7 +745,8 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
-	return 0;
+
+	return init_rapl_pmu();
 }
 
 static struct rapl_model model_snb = {
-- 
2.38.1


