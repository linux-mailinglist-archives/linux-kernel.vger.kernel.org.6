Return-Path: <linux-kernel+bounces-244815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE392A9DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F122829A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD2E14D6F6;
	Mon,  8 Jul 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqlDL/Af"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2441CF8A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467166; cv=none; b=rjymiN1wuJnRp3ZO1MtnZBdY5Ycxt8eL1OBn0MpOlzELbHMQ1zgJh6x6PMzsklso+Od93fXNDBJD6tgKU9TaUPi8gG/zkhwhSYTaUDrA4qQqhYKjzF4f3LEwKjubf23EC4Pm2OLTtY6SWDUeCDBqFW89Ood8u+Jaa9INgf0gPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467166; c=relaxed/simple;
	bh=mvYpcvn8HdNEeFCNfMxdpJeijYhFR0AMPQTvbjyZGx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AyHlpsZ/ChrSlq+dgFpCaB7STAQuTSWdv4vcM7ls8TqR4EgEL1DQ7Y+op31mDEdqxmyGSOs7K5nU6pGPnOP5y+bE0VlA7Z/7wfzFkdm2wVV5WbxtYLMm8MDfOulpvGaRLT7D+8YFGXOk6By22uO0gOERkmjvCjUpbU75VhTAi1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqlDL/Af; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720467164; x=1752003164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mvYpcvn8HdNEeFCNfMxdpJeijYhFR0AMPQTvbjyZGx0=;
  b=hqlDL/AfJwXeXwucBM8uwS4I3qxwYF0Rcto4bwrjQEx1K6Tr9qfn9rne
   1ymVJ5/898sL6ovXEg817DGYPTc/22xnreA/DCHB3fFlBJlkItpmHDFJs
   Pg/U6FHylRCQLVTygJQQo5/Z7PJW3bw5tRkBCvVIhyrZXSRQnY7xk0ayO
   43ks6FA4oi0HIswNoga/OJ9X3N+0wx3B+z6DhAkQEFy4bwtNZgXpQIyWA
   vQoN69hAoEvPxzDzNZxFChpqNqnQoR9m4IUtrQjincSyy7zD4hTuJQmqf
   Sro2ZjkkC0IhEJ6WGRzordLXTkNyrDPPvGHVaWWZSS9oG4rUMEk296Cky
   Q==;
X-CSE-ConnectionGUID: VnWL6Zn8SQG/NJHUyrEveQ==
X-CSE-MsgGUID: yNNZaNmmTb++LUkavmteBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17520486"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17520486"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:32:42 -0700
X-CSE-ConnectionGUID: TNRPMLeeRM+RzvuTgx3hyA==
X-CSE-MsgGUID: 262OQIxyTqCm+g64Y09VOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="48265594"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 08 Jul 2024 12:32:42 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH 1/3] perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
Date: Mon,  8 Jul 2024 12:33:34 -0700
Message-Id: <20240708193336.1192217-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240708193336.1192217-1-kan.liang@linux.intel.com>
References: <20240708193336.1192217-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The below error is observed on Ice Lake VM.

$ perf stat
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (slots).
/bin/dmesg | grep -i perf may provide additional information.

In a virtualization env, the Topdown metrics and the slots event haven't
been supported yet. The guest CPUID doesn't enumerate them. However, the
current kernel unconditionally exposes the slots event and the Topdown
metrics events to sysfs, which misleads the perf tool and triggers the
error.

Hide the perf-metrics topdown events and the slots event if the
perf-metrics feature is not enumerated.

The big core of a hybrid platform can also supports the perf-metrics
feature. Fix the hybrid platform as well.

Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Closes: https://lore.kernel.org/lkml/CAM9d7cj8z+ryyzUHR+P1Dcpot2jjW+Qcc4CPQpfafTXN=LEU0Q@mail.gmail.com/
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cd8f2db6cdf6..b61367991a16 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5830,8 +5830,22 @@ exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.version >= 2 ? attr->mode : 0;
 }
 
+static umode_t
+td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	/*
+	 * Hide the perf metrics topdown events
+	 * if the feature is not enumerated.
+	 */
+	if (x86_pmu.num_topdown_events)
+		return x86_pmu.intel_cap.perf_metrics ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
+	.is_visible = td_is_visible,
 };
 
 static struct attribute_group group_events_mem = {
@@ -6057,9 +6071,27 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
 	return (cpu >= 0) && (pmu->pmu_type & pmu_attr->pmu_type) ? attr->mode : 0;
 }
 
+static umode_t hybrid_td_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct x86_hybrid_pmu *pmu =
+		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+
+	if (!is_attr_for_this_pmu(kobj, attr))
+		return 0;
+
+
+	/* Only the big core supports perf metrics */
+	if (pmu->pmu_type == hybrid_big)
+		return pmu->intel_cap.perf_metrics ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group hybrid_group_events_td  = {
 	.name		= "events",
-	.is_visible	= hybrid_events_is_visible,
+	.is_visible	= hybrid_td_is_visible,
 };
 
 static struct attribute_group hybrid_group_events_mem = {
-- 
2.38.1


