Return-Path: <linux-kernel+bounces-359263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EFB998999
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A1B32EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A517F1CEAB2;
	Thu, 10 Oct 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzAdlsPC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770521C9EDD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570307; cv=none; b=rU1QXpq+bH00IagGptfN3Y9mbVazFdlhQZQ78y8NhDA9Tk/eOKZ49PCQy7vG15xTzCsDedhofNh/3Bnop3wK2oNR7u7voMu9YnSFucNE4rVEG1Ug00t8bhcos8lgLi9hMcaEyJi+CBjXGLRIZQHcQT5cgl4CXBIZYoaSWC21+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570307; c=relaxed/simple;
	bh=07IHBqe0x7mnj5OgnPKWfH1fUuPyPW4DDXp9KhJ5B4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0bhgHpMj08cvTV3ABdP4rk3K+mnZZEPyxSM46mry6TKBv2s0btaCrgraUwUD/maOXgbQ3PRVgMzq9IN2LyfulkUiJ96fy79a14qxL8DCVxvxNKBdiW49lkBu2Oya0G9U53D9eznKoJbuS/HHSw4RpZx5p0o4G+AVcai56GnA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzAdlsPC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570306; x=1760106306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=07IHBqe0x7mnj5OgnPKWfH1fUuPyPW4DDXp9KhJ5B4M=;
  b=DzAdlsPClEqhcwJsoA0J2PlHf0HIMFnr58DZdcXBYR/evJ36AHDSOoYo
   P16EBAC9ivLvX5QT7Z88FrlX6ioJ/XYeagNhYIbnT4PHQxvAVHc6GAHMy
   AMXzb5ziZxPZVlJIt2vH9f9a35XgwaEJHbgLUEe6tKh2hNwVyCypB2cta
   EHZsSDELJOUpwTS/sLwiw5Rg+D8K+Ux2Gf5n8wfj6XaIdvbsRVE0aeVyE
   ynwwsFQnSH3lDUBlejLVObgqIglS2VUw18/HFncVnyjVcCF1smxuhdwc0
   hmgPfC8wQmro110bEr4gJ49j8h8jM143WCMtU1ekScIbMnN5xIT5ESSiA
   g==;
X-CSE-ConnectionGUID: G/SB9nXORO6W/4igDb1RYg==
X-CSE-MsgGUID: jmh4MsANSzy6XOoeaAF5Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38501288"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="38501288"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:25:03 -0700
X-CSE-ConnectionGUID: vv0l93CCT5iXHEtkvMpRWw==
X-CSE-MsgGUID: EwHck765SLOaqewCpaWH9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="77422959"
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
Subject: [PATCH V2 2/2] perf/x86/rapl: Clean up cpumask and hotplug
Date: Thu, 10 Oct 2024 07:26:04 -0700
Message-Id: <20241010142604.770192-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241010142604.770192-1-kan.liang@linux.intel.com>
References: <20241010142604.770192-1-kan.liang@linux.intel.com>
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

Tested-by: Oliver Sang <oliver.sang@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c     | 90 +++-----------------------------------
 include/linux/cpuhotplug.h |  1 -
 2 files changed, 6 insertions(+), 85 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7764f739fa0a..0ae9fd5e619c 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -148,7 +148,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus;
-static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
@@ -369,8 +368,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
-
 	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
 		return -EINVAL;
 
@@ -389,7 +386,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	pmu = cpu_to_rapl_pmu(event->cpu);
 	if (!pmu)
 		return -EINVAL;
-	event->cpu = pmu->cpu;
 	event->pmu_private = pmu;
 	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
@@ -403,23 +399,6 @@ static void rapl_pmu_event_read(struct perf_event *event)
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
@@ -467,7 +446,6 @@ static struct attribute_group rapl_pmu_format_group = {
 };
 
 static const struct attribute_group *rapl_attr_groups[] = {
-	&rapl_pmu_attr_group,
 	&rapl_pmu_format_group,
 	&rapl_pmu_events_group,
 	NULL,
@@ -570,54 +548,6 @@ static struct perf_msr amd_rapl_msrs[] = {
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
-	target = cpumask_any_but(get_rapl_pmu_cpumask(cpu), cpu);
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
-	s32 rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-	if (rapl_pmu_idx < 0) {
-		pr_err("topology_logical_(package/die)_id() returned a negative value");
-		return -EINVAL;
-	}
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
-	target = cpumask_any_and(&rapl_cpu_mask, get_rapl_pmu_cpumask(cpu));
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
@@ -725,9 +655,12 @@ static int __init init_rapl_pmu(void)
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages();
+	int rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
 
-	if (!rapl_pmu_is_pkg_scope())
+	if (!rapl_pmu_is_pkg_scope()) {
 		nr_rapl_pmu *= topology_max_dies_per_package();
+		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
+	}
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
@@ -743,6 +676,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.start		= rapl_pmu_event_start;
 	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
+	rapl_pmus->pmu.scope		= rapl_pmu_scope;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
@@ -892,24 +826,13 @@ static int __init rapl_pmu_init(void)
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
@@ -919,7 +842,6 @@ module_init(rapl_pmu_init);
 
 static void __exit intel_rapl_exit(void)
 {
-	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 	perf_pmu_unregister(&rapl_pmus->pmu);
 	cleanup_rapl_pmus();
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 2361ed4d2b15..37a9afffb59e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -208,7 +208,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
-	CPUHP_AP_PERF_X86_RAPL_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
-- 
2.38.1


