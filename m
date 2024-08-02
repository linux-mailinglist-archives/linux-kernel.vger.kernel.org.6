Return-Path: <linux-kernel+bounces-272703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E6946010
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E63284A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7E3DAC17;
	Fri,  2 Aug 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+u4TLE/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060221C189
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611765; cv=none; b=Nui7bj7aLN8JGzilEFnRLCjzrGQz1IT/a9NK0QaYMmRb1a6lTtABIGHmBAx3N1wJ1Z86lMyy7g54fxnHLHEoQJZeDYC6ee/5dAQdYhrID2XgfT0SeWYmLHy1j28LXCUH9Re9HTG6ni7Z4W20faF4LxHJmXUc6o1SEIaFjN7O9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611765; c=relaxed/simple;
	bh=p+4Lv+dh60cpYo7aE7ItjBxEiUBNsC63EBfUh4dALaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRmOJ2VCvqXhko2oAuUbO7jh1Br4U9dPpmpZB83dS/xHF7AJyD87/C47ka8rCPIYozw5CzJQ2/Qe+oRrQa1ygz9Yicf5YDvpo5aXdoFdLuFrAno0zNZGTWw6xyqXXMoL25bRsH9gEnkJdEi3IDQ+IX9j+ZMaXXbd5JP6nVPuUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+u4TLE/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611764; x=1754147764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+4Lv+dh60cpYo7aE7ItjBxEiUBNsC63EBfUh4dALaQ=;
  b=b+u4TLE/TZuJ9nU4v8mHMhjPOPqJoDnSYD7yhhQsAZqVWpMNszyJHJWg
   Cx+xMGmFX4sXC3jsQQzIfi4QAjx1CUPkLqsosxraoXntvyRtH+IMWM9xw
   Csbjo+R3ZxCMKQ3O6mR+GIw1JDtxPd3F2VMS2Q6WawNOJ+RHZoiv5vcyK
   JQdb9wzXe/CXmDwa8j3QUysXxrhUg5YskTHHV3ZQzqXKh2A6gRv5SUUar
   lM8ywlBAJhJ6OqFMeDN/RoI86rnVWN7rXLoFgXwofHys0ETO2oBUkE48E
   s3t+T7WVRtV62yza4pSfTqPlAs3mYkZWSI6j5/eAZZg2YiIijerNnpsKy
   w==;
X-CSE-ConnectionGUID: Ztjvnc7bSAG72Zem/7QZEA==
X-CSE-MsgGUID: SSt7KGZNT8ilVFeWzOEdyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20473785"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20473785"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:16:00 -0700
X-CSE-ConnectionGUID: wky1+X3RS6WfkZNXZoenQQ==
X-CSE-MsgGUID: Ln4DiuWVSPamDeM35Cs3Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55516940"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 02 Aug 2024 08:15:59 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 6/7] perf/x86/rapl: Move the pmu allocation out of CPU hotplug
Date: Fri,  2 Aug 2024 08:16:42 -0700
Message-Id: <20240802151643.1691631-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240802151643.1691631-1-kan.liang@linux.intel.com>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 43 +++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b985ca79cf97..f8b6d504d03f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -568,19 +568,8 @@ static int rapl_cpu_online(unsigned int cpu)
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
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
-	}
+	if (!pmu)
+		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
@@ -673,6 +662,32 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static void __init init_rapl_pmu(void)
+{
+	struct rapl_pmu *pmu;
+	int cpu;
+
+	cpus_read_lock();
+
+	for_each_cpu(cpu, cpu_online_mask) {
+		pmu = cpu_to_rapl_pmu(cpu);
+		if (pmu)
+			continue;
+		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
+		if (!pmu)
+			continue;
+		raw_spin_lock_init(&pmu->lock);
+		INIT_LIST_HEAD(&pmu->active_list);
+		pmu->pmu = &rapl_pmus->pmu;
+		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
+		rapl_hrtimer_init(pmu);
+
+		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
+	}
+
+	cpus_read_unlock();
+}
+
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
@@ -681,6 +696,8 @@ static int __init init_rapl_pmus(void)
 	if (!rapl_pmus)
 		return -ENOMEM;
 
+	init_rapl_pmu();
+
 	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.attr_update	= rapl_attr_update;
-- 
2.38.1


