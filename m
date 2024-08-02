Return-Path: <linux-kernel+bounces-272704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953F6946013
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B822B1C21E99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9F13633C;
	Fri,  2 Aug 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHjqZIjO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87321C19B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611765; cv=none; b=daGRzqtjOqDhks0pE8JO34+oVLUlCoCQe68TYVUnVl3ZvuQMPvuHlEbJ/BQdaQx14Fc8fC/k8WdlhWwbXgG/4NwIa698GWA0IZH1kcIeZ9Irx6kXAgaNj2EPY9GavEwWheB2H3tnudEaTtnISFtsTiuIcvtDIxMYzJ1QcK+Gvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611765; c=relaxed/simple;
	bh=+q6If9D2thIVk8mfxeitCcSfQbMYqV+Hm+rfEgc6qVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQPC7pwFt30+ay00RdoxrWRMOhhDVnhKqWvgSaRyXis0AHLM2t4UdOGtPCc3X1j8VB0mmLlNXUDJSxcOTYELZ1dHqfSFmduIvsEevzpOtPXAzMNcl4NFNiZ1UEZVJzboG5Vofbm5PXq+Uvtk762wakA14R3okLlPmpilbav3BjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHjqZIjO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611765; x=1754147765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+q6If9D2thIVk8mfxeitCcSfQbMYqV+Hm+rfEgc6qVY=;
  b=XHjqZIjOnZHEGALT25zFzby1673kf/zAJA8u/7/cweW+i0Pwa6kHOPsx
   qIWpllQ+pwxC0bAGGbaI8GdIUEtFvu75go8nmxHkKTm4OBM5MinJsMIzL
   P8ui5jzEAn2DZNmc1mB8mX1K7eBnx5hCTxaJD1LUgYRa2MYfRHSrRbD1x
   puRN21xjUU4/EU895tcj19Ipk5Y5yMZJx+xW1oCM0zcSkOkRlHt1PImVz
   EVlVJpoji3v24Q7B05pW7SCf+hoAkm+FyT2dwG8n3Id4jhbaXyWUGmF9c
   2KRqIMmg1Yw9Daeuc8ln8VAwZz6WLtO3TqTDjc5M8DWxyfnTJ2EOt2s6m
   g==;
X-CSE-ConnectionGUID: UPSow0eoReikZ55wkBuC3A==
X-CSE-MsgGUID: mt9aBvO4QgWcFlx3XMG0DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20473793"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20473793"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:16:00 -0700
X-CSE-ConnectionGUID: lWCROytnRfa3mMPq4w0L0Q==
X-CSE-MsgGUID: M/DABoEiRaWbfFYB4F/U5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55516942"
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
Subject: [PATCH 7/7] perf/x86/rapl: Clean up cpumask and hotplug
Date: Fri,  2 Aug 2024 08:16:43 -0700
Message-Id: <20240802151643.1691631-8-kan.liang@linux.intel.com>
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

The rapl pmu is die scope, which is supported by the generic perf_event
subsystem now.

Set the scope for the rapl PMU and remove all the cpumask and hotplug
codes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c     | 80 +-------------------------------------
 include/linux/cpuhotplug.h |  1 -
 2 files changed, 2 insertions(+), 79 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f8b6d504d03f..b70ad880c5bc 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -135,7 +135,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus;
-static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
@@ -340,8 +339,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
-
 	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
 		return -EINVAL;
 
@@ -360,7 +357,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	pmu = cpu_to_rapl_pmu(event->cpu);
 	if (!pmu)
 		return -EINVAL;
-	event->cpu = pmu->cpu;
 	event->pmu_private = pmu;
 	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
@@ -374,23 +370,6 @@ static void rapl_pmu_event_read(struct perf_event *event)
 	rapl_event_update(event);
 }
 
-static ssize_t rapl_get_attr_cpumask(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	return cpumap_print_to_pagebuf(true, buf, &rapl_cpu_mask);
-}
-
-static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
-
-static struct attribute *rapl_pmu_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL,
-};
-
-static struct attribute_group rapl_pmu_attr_group = {
-	.attrs = rapl_pmu_attrs,
-};
-
 RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
 RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
 RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
@@ -438,7 +417,6 @@ static struct attribute_group rapl_pmu_format_group = {
 };
 
 static const struct attribute_group *rapl_attr_groups[] = {
-	&rapl_pmu_attr_group,
 	&rapl_pmu_format_group,
 	&rapl_pmu_events_group,
 	NULL,
@@ -541,49 +519,6 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
-static int rapl_cpu_offline(unsigned int cpu)
-{
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
-	int target;
-
-	/* Check if exiting cpu is used for collecting rapl events */
-	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
-		return 0;
-
-	pmu->cpu = -1;
-	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
-
-	/* Migrate rapl events to the new target */
-	if (target < nr_cpu_ids) {
-		cpumask_set_cpu(target, &rapl_cpu_mask);
-		pmu->cpu = target;
-		perf_pmu_migrate_context(pmu->pmu, cpu, target);
-	}
-	return 0;
-}
-
-static int rapl_cpu_online(unsigned int cpu)
-{
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
-	int target;
-
-	if (!pmu)
-		return -ENOMEM;
-
-	/*
-	 * Check if there is an online cpu in the package which collects rapl
-	 * events already.
-	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
-	if (target < nr_cpu_ids)
-		return 0;
-
-	cpumask_set_cpu(cpu, &rapl_cpu_mask);
-	pmu->cpu = cpu;
-	return 0;
-}
-
 static int rapl_check_hw_unit(struct rapl_model *rm)
 {
 	u64 msr_rapl_power_unit_bits;
@@ -709,6 +644,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
+	rapl_pmus->pmu.scope		= PERF_PMU_SCOPE_DIE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 	return 0;
 }
@@ -856,24 +792,13 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	/*
-	 * Install callbacks. Core will call them for each online cpu.
-	 */
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_RAPL_ONLINE,
-				"perf/x86/rapl:online",
-				rapl_cpu_online, rapl_cpu_offline);
-	if (ret)
-		goto out;
-
 	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
 	if (ret)
-		goto out1;
+		goto out;
 
 	rapl_advertise();
 	return 0;
 
-out1:
-	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
 	cleanup_rapl_pmus();
@@ -883,7 +808,6 @@ module_init(rapl_pmu_init);
 
 static void __exit intel_rapl_exit(void)
 {
-	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 	perf_pmu_unregister(&rapl_pmus->pmu);
 	cleanup_rapl_pmus();
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 9ea6290ade56..f408521be568 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -207,7 +207,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
-	CPUHP_AP_PERF_X86_RAPL_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
-- 
2.38.1


