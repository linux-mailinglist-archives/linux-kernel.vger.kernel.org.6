Return-Path: <linux-kernel+bounces-272700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA794600D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AE51F23930
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0E43DABEE;
	Fri,  2 Aug 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ap42uIZQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D721C161
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611763; cv=none; b=MNsCVi2rMEadNZuS7OApPfLiLe//DwmQwOD+V6mmNqwgagmIQEEmZSo1cdbecGa373HAhV29Svt+yl/IZ4UUSe090nQjqt19fHwFI6BPk4/uZZWD0YqTfuZsgPLvavarUFgrYFIE+9ECeL10ifx8DRFtcJCVZl/rtCWxFn+kcMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611763; c=relaxed/simple;
	bh=+ZXXHiNZZA1BghCtWfCFfCi1+sxQltAZQN3WjRZyB5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZpfpla+Xtfn67mYdbKCpf/XqZ8PdKoouDfCIb0JgX7nxyJDmjyoUZPBcGXZ2fHpxmRecDeGFEDr/gs2U+9Ct+HvC8GWVZVdMeCgUpqc6y7GWeeTHdCDflekvZRpgEGMRgs0EiaCb6Ivkn4smzj+qaH+vE141xZcrCX+5iqWXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ap42uIZQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611762; x=1754147762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ZXXHiNZZA1BghCtWfCFfCi1+sxQltAZQN3WjRZyB5I=;
  b=Ap42uIZQ26wq/TjLdYcy3y56noPiRrMJRCUs0gpNeuB0KhN3SnKiFoJ8
   MVg3rP+tr4YKnceTu8abPhQpTu+CrnPF8+djlYG3JCB43lPKykt/3lmB8
   YAz3dklBx27gGnb/+mY+ld6qhCec+1DHp11izTkNT4VXmYmipnoFDGkaZ
   BymXAglvJIWymxhjrzXQabdSrmj58CKEScvB7YYkGi6rPqbYnkIkQOx3E
   Oq+rDG+E0gQqLpNfcoffvRKMOxeSHewMGYmQ2D2793EQJ2e3Y8tNt/rQu
   UaRD82MLoB5yhH7Q+ePxA1e7RDFbgP7n2oGj6VIhPJYt2bbYzi8u7li2T
   Q==;
X-CSE-ConnectionGUID: gVp1phrGSw6OwUFDt4pWrA==
X-CSE-MsgGUID: CfkKzYA8RVSsF3x90l/SVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20473767"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20473767"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:15:59 -0700
X-CSE-ConnectionGUID: WrbMoaqNQoiSplDd5WCrlg==
X-CSE-MsgGUID: PrwkPJI9Rs2eINuiBRNsaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55516932"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 02 Aug 2024 08:15:58 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/7] perf/x86/intel/cstate: Clean up cpumask and hotplug
Date: Fri,  2 Aug 2024 08:16:39 -0700
Message-Id: <20240802151643.1691631-4-kan.liang@linux.intel.com>
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

There are three cstate PMUs with different scopes, core, die and module.
The scopes are supported by the generic perf_event subsystem now.

Set the scope for each PMU and remove all the cpumask and hotplug codes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 142 ++-------------------------------
 include/linux/cpuhotplug.h     |   2 -
 2 files changed, 5 insertions(+), 139 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index be58cfb012dd..13d229f2cdda 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -128,10 +128,6 @@ static ssize_t __cstate_##_var##_show(struct device *dev,	\
 static struct device_attribute format_attr_##_var =		\
 	__ATTR(_name, 0444, __cstate_##_var##_show, NULL)
 
-static ssize_t cstate_get_attr_cpumask(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf);
-
 /* Model -> events mapping */
 struct cstate_model {
 	unsigned long		core_events;
@@ -206,22 +202,9 @@ static struct attribute_group cstate_format_attr_group = {
 	.attrs = cstate_format_attrs,
 };
 
-static cpumask_t cstate_core_cpu_mask;
-static DEVICE_ATTR(cpumask, S_IRUGO, cstate_get_attr_cpumask, NULL);
-
-static struct attribute *cstate_cpumask_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL,
-};
-
-static struct attribute_group cpumask_attr_group = {
-	.attrs = cstate_cpumask_attrs,
-};
-
 static const struct attribute_group *cstate_attr_groups[] = {
 	&cstate_events_attr_group,
 	&cstate_format_attr_group,
-	&cpumask_attr_group,
 	NULL,
 };
 
@@ -269,8 +252,6 @@ static struct perf_msr pkg_msr[] = {
 	[PERF_CSTATE_PKG_C10_RES] = { MSR_PKG_C10_RESIDENCY,	&group_cstate_pkg_c10,	test_msr },
 };
 
-static cpumask_t cstate_pkg_cpu_mask;
-
 /* cstate_module PMU */
 static struct pmu cstate_module_pmu;
 static bool has_cstate_module;
@@ -291,28 +272,9 @@ static struct perf_msr module_msr[] = {
 	[PERF_CSTATE_MODULE_C6_RES]  = { MSR_MODULE_C6_RES_MS,	&group_cstate_module_c6,	test_msr },
 };
 
-static cpumask_t cstate_module_cpu_mask;
-
-static ssize_t cstate_get_attr_cpumask(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct pmu *pmu = dev_get_drvdata(dev);
-
-	if (pmu == &cstate_core_pmu)
-		return cpumap_print_to_pagebuf(true, buf, &cstate_core_cpu_mask);
-	else if (pmu == &cstate_pkg_pmu)
-		return cpumap_print_to_pagebuf(true, buf, &cstate_pkg_cpu_mask);
-	else if (pmu == &cstate_module_pmu)
-		return cpumap_print_to_pagebuf(true, buf, &cstate_module_cpu_mask);
-	else
-		return 0;
-}
-
 static int cstate_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config;
-	int cpu;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -331,20 +293,13 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		if (!(core_msr_mask & (1 << cfg)))
 			return -EINVAL;
 		event->hw.event_base = core_msr[cfg].msr;
-		cpu = cpumask_any_and(&cstate_core_cpu_mask,
-				      topology_sibling_cpumask(event->cpu));
 	} else if (event->pmu == &cstate_pkg_pmu) {
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
 		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!(pkg_msr_mask & (1 << cfg)))
 			return -EINVAL;
-
-		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
-
 		event->hw.event_base = pkg_msr[cfg].msr;
-		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
-				      topology_die_cpumask(event->cpu));
 	} else if (event->pmu == &cstate_module_pmu) {
 		if (cfg >= PERF_CSTATE_MODULE_EVENT_MAX)
 			return -EINVAL;
@@ -352,16 +307,10 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		if (!(module_msr_mask & (1 << cfg)))
 			return -EINVAL;
 		event->hw.event_base = module_msr[cfg].msr;
-		cpu = cpumask_any_and(&cstate_module_cpu_mask,
-				      topology_cluster_cpumask(event->cpu));
 	} else {
 		return -ENOENT;
 	}
 
-	if (cpu >= nr_cpu_ids)
-		return -ENODEV;
-
-	event->cpu = cpu;
 	event->hw.config = cfg;
 	event->hw.idx = -1;
 	return 0;
@@ -412,84 +361,6 @@ static int cstate_pmu_event_add(struct perf_event *event, int mode)
 	return 0;
 }
 
-/*
- * Check if exiting cpu is the designated reader. If so migrate the
- * events when there is a valid target available
- */
-static int cstate_cpu_exit(unsigned int cpu)
-{
-	unsigned int target;
-
-	if (has_cstate_core &&
-	    cpumask_test_and_clear_cpu(cpu, &cstate_core_cpu_mask)) {
-
-		target = cpumask_any_but(topology_sibling_cpumask(cpu), cpu);
-		/* Migrate events if there is a valid target */
-		if (target < nr_cpu_ids) {
-			cpumask_set_cpu(target, &cstate_core_cpu_mask);
-			perf_pmu_migrate_context(&cstate_core_pmu, cpu, target);
-		}
-	}
-
-	if (has_cstate_pkg &&
-	    cpumask_test_and_clear_cpu(cpu, &cstate_pkg_cpu_mask)) {
-
-		target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
-		/* Migrate events if there is a valid target */
-		if (target < nr_cpu_ids) {
-			cpumask_set_cpu(target, &cstate_pkg_cpu_mask);
-			perf_pmu_migrate_context(&cstate_pkg_pmu, cpu, target);
-		}
-	}
-
-	if (has_cstate_module &&
-	    cpumask_test_and_clear_cpu(cpu, &cstate_module_cpu_mask)) {
-
-		target = cpumask_any_but(topology_cluster_cpumask(cpu), cpu);
-		/* Migrate events if there is a valid target */
-		if (target < nr_cpu_ids) {
-			cpumask_set_cpu(target, &cstate_module_cpu_mask);
-			perf_pmu_migrate_context(&cstate_module_pmu, cpu, target);
-		}
-	}
-	return 0;
-}
-
-static int cstate_cpu_init(unsigned int cpu)
-{
-	unsigned int target;
-
-	/*
-	 * If this is the first online thread of that core, set it in
-	 * the core cpu mask as the designated reader.
-	 */
-	target = cpumask_any_and(&cstate_core_cpu_mask,
-				 topology_sibling_cpumask(cpu));
-
-	if (has_cstate_core && target >= nr_cpu_ids)
-		cpumask_set_cpu(cpu, &cstate_core_cpu_mask);
-
-	/*
-	 * If this is the first online thread of that package, set it
-	 * in the package cpu mask as the designated reader.
-	 */
-	target = cpumask_any_and(&cstate_pkg_cpu_mask,
-				 topology_die_cpumask(cpu));
-	if (has_cstate_pkg && target >= nr_cpu_ids)
-		cpumask_set_cpu(cpu, &cstate_pkg_cpu_mask);
-
-	/*
-	 * If this is the first online thread of that cluster, set it
-	 * in the cluster cpu mask as the designated reader.
-	 */
-	target = cpumask_any_and(&cstate_module_cpu_mask,
-				 topology_cluster_cpumask(cpu));
-	if (has_cstate_module && target >= nr_cpu_ids)
-		cpumask_set_cpu(cpu, &cstate_module_cpu_mask);
-
-	return 0;
-}
-
 static const struct attribute_group *core_attr_update[] = {
 	&group_cstate_core_c1,
 	&group_cstate_core_c3,
@@ -526,6 +397,7 @@ static struct pmu cstate_core_pmu = {
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
 	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.scope		= PERF_PMU_SCOPE_CORE,
 	.module		= THIS_MODULE,
 };
 
@@ -541,6 +413,7 @@ static struct pmu cstate_pkg_pmu = {
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
 	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.scope		= PERF_PMU_SCOPE_PKG,
 	.module		= THIS_MODULE,
 };
 
@@ -556,6 +429,7 @@ static struct pmu cstate_module_pmu = {
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
 	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.scope		= PERF_PMU_SCOPE_CLUSTER,
 	.module		= THIS_MODULE,
 };
 
@@ -809,9 +683,6 @@ static int __init cstate_probe(const struct cstate_model *cm)
 
 static inline void cstate_cleanup(void)
 {
-	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_CSTATE_ONLINE);
-	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_CSTATE_STARTING);
-
 	if (has_cstate_core)
 		perf_pmu_unregister(&cstate_core_pmu);
 
@@ -826,11 +697,6 @@ static int __init cstate_init(void)
 {
 	int err;
 
-	cpuhp_setup_state(CPUHP_AP_PERF_X86_CSTATE_STARTING,
-			  "perf/x86/cstate:starting", cstate_cpu_init, NULL);
-	cpuhp_setup_state(CPUHP_AP_PERF_X86_CSTATE_ONLINE,
-			  "perf/x86/cstate:online", NULL, cstate_cpu_exit);
-
 	if (has_cstate_core) {
 		err = perf_pmu_register(&cstate_core_pmu, cstate_core_pmu.name, -1);
 		if (err) {
@@ -843,6 +709,8 @@ static int __init cstate_init(void)
 
 	if (has_cstate_pkg) {
 		if (topology_max_dies_per_package() > 1) {
+			/* CLX-AP is multi-die and the cstate is die-scope */
+			cstate_pkg_pmu.scope = PERF_PMU_SCOPE_DIE;
 			err = perf_pmu_register(&cstate_pkg_pmu,
 						"cstate_die", -1);
 		} else {
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 51ba681b915a..9ea6290ade56 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -152,7 +152,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
-	CPUHP_AP_PERF_X86_CSTATE_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
@@ -209,7 +208,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
 	CPUHP_AP_PERF_X86_RAPL_ONLINE,
-	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
-- 
2.38.1


