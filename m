Return-Path: <linux-kernel+bounces-272698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EFF94600B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C732842D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553821C182;
	Fri,  2 Aug 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LE3Vl+Gn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3F1E287F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611762; cv=none; b=auCg7ubFDXXmh951maaLUDyFWbT6hQKEUrafqxh7PikE5ACNC2yHjRdYdef4ScHszhEfJ3VLXmn4J4fnFhiJcQ2fxhwJxUZB0i5iJ78Xu5gAJmmaZt3/2ciUAAPOQwR7HG6vKp5FXQpNJuF20MyIhPYcBxNzxXcIa1y8Zyiz1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611762; c=relaxed/simple;
	bh=mGTuL2K61dIMThg7S4YuzF8bs4faqy5BjuNQiiLUyOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJU+/6szPqD84jz7Dguy3oI1vuPXdcqNYJy8u6UNT0ifJh5ZYyj9EjIxtMLhxPhKSL3zi6NP2MaEj0HJPqvJfstY3oSz24skMRnd3pPCpD9Kvc8RTTTDMC791JTOgs+oqR1zCRRIrE1P9XnEW0jgWU5Sr2qPt4GXW1YFLoveiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LE3Vl+Gn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611761; x=1754147761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mGTuL2K61dIMThg7S4YuzF8bs4faqy5BjuNQiiLUyOs=;
  b=LE3Vl+Gn19cNK/c1Wy7BTIhkMW9vR/Tl7a4hVBndP63K0VLHSWy18Neu
   5Uth9AD/RPo5lpd69BXEjMwul9CtvkPr16H0feIPWLc1lBbTHJjGOd5jB
   wZEgp0KYpoKMjwZ36kJtEu+1klpT9b16oN0hU4ty5AJZSHyV20qGxqw9T
   88BxoGozuOlIYouM5RvDm3ogKnnn/Mjdxqb6zzi8uc1GCu23kI87n4iop
   JjXD1aDFppyUAiyP8VOqNE7DIAdZBwfBfkZl9s+qb2X30Msi2fRk2ucGx
   ga/X8D+4r1Y9PmQ0Dd3qu1w2uyutknIif/pdMoABeKQrYoOF79BAQde9H
   A==;
X-CSE-ConnectionGUID: b6RuXe6nQk6Ylv4DMfmXHA==
X-CSE-MsgGUID: N26qlOykRfCpI9Qxlw4ZuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20473757"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20473757"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:15:59 -0700
X-CSE-ConnectionGUID: g6z1q1fmTtuODGljGYlXxw==
X-CSE-MsgGUID: bX92xgvKTDGPP7XcfSNrtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55516929"
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
Subject: [PATCH 1/7] perf: Generic hotplug support for a PMU with a scope
Date: Fri,  2 Aug 2024 08:16:37 -0700
Message-Id: <20240802151643.1691631-2-kan.liang@linux.intel.com>
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

The perf subsystem assumes that the counters of a PMU are per-CPU. So
the user space tool reads a counter from each CPU in the system wide
mode. However, many PMUs don't have a per-CPU counter. The counter is
effective for a scope, e.g., a die or a socket. To address this, a
cpumask is exposed by the kernel driver to restrict to one CPU to stand
for a specific scope. In case the given CPU is removed,
the hotplug support has to be implemented for each such driver.

The codes to support the cpumask and hotplug are very similar.
- Expose a cpumask into sysfs
- Pickup another CPU in the same scope if the given CPU is removed.
- Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
- In event init, always set the CPU in the cpumask to event->cpu

Similar duplicated codes are implemented for each such PMU driver. It
would be good to introduce a generic infrastructure to avoid such
duplication.

5 popular scopes are implemented here, core, die, cluster, pkg, and
the system-wide. The scope can be set when a PMU is registered. If so, a
"cpumask" is automatically exposed for the PMU.

The "cpumask" is from the perf_online_<scope>_mask, which is to track
the active CPU for each scope. They are set when the first CPU of the
scope is online via the generic perf hotplug support. When a
corresponding CPU is removed, the perf_online_<scope>_mask is updated
accordingly and the PMU will be moved to a new CPU from the same scope
if possible.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |  18 ++++
 kernel/events/core.c       | 164 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 180 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..1102d5c2be70 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -292,6 +292,19 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 
+/**
+ * pmu::scope
+ */
+enum perf_pmu_scope {
+	PERF_PMU_SCOPE_NONE	= 0,
+	PERF_PMU_SCOPE_CORE,
+	PERF_PMU_SCOPE_DIE,
+	PERF_PMU_SCOPE_CLUSTER,
+	PERF_PMU_SCOPE_PKG,
+	PERF_PMU_SCOPE_SYS_WIDE,
+	PERF_PMU_MAX_SCOPE,
+};
+
 struct perf_output_handle;
 
 #define PMU_NULL_DEV	((void *)(~0UL))
@@ -315,6 +328,11 @@ struct pmu {
 	 */
 	int				capabilities;
 
+	/*
+	 * PMU scope
+	 */
+	unsigned int			scope;
+
 	int __percpu			*pmu_disable_count;
 	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..5e1877c4cb4c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -407,6 +407,11 @@ static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
 static struct srcu_struct pmus_srcu;
 static cpumask_var_t perf_online_mask;
+static cpumask_var_t perf_online_core_mask;
+static cpumask_var_t perf_online_die_mask;
+static cpumask_var_t perf_online_cluster_mask;
+static cpumask_var_t perf_online_pkg_mask;
+static cpumask_var_t perf_online_sys_mask;
 static struct kmem_cache *perf_event_cache;
 
 /*
@@ -11477,10 +11482,60 @@ perf_event_mux_interval_ms_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
 
+static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int scope, int cpu)
+{
+	switch (scope) {
+	case PERF_PMU_SCOPE_CORE:
+		return topology_sibling_cpumask(cpu);
+	case PERF_PMU_SCOPE_DIE:
+		return topology_die_cpumask(cpu);
+	case PERF_PMU_SCOPE_CLUSTER:
+		return topology_cluster_cpumask(cpu);
+	case PERF_PMU_SCOPE_PKG:
+		return topology_core_cpumask(cpu);
+	case PERF_PMU_SCOPE_SYS_WIDE:
+		return cpu_online_mask;
+	}
+
+	return NULL;
+}
+
+static inline struct cpumask *perf_scope_cpumask(unsigned int scope)
+{
+	switch (scope) {
+	case PERF_PMU_SCOPE_CORE:
+		return perf_online_core_mask;
+	case PERF_PMU_SCOPE_DIE:
+		return perf_online_die_mask;
+	case PERF_PMU_SCOPE_CLUSTER:
+		return perf_online_cluster_mask;
+	case PERF_PMU_SCOPE_PKG:
+		return perf_online_pkg_mask;
+	case PERF_PMU_SCOPE_SYS_WIDE:
+		return perf_online_sys_mask;
+	}
+
+	return NULL;
+}
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct cpumask *mask = perf_scope_cpumask(pmu->scope);
+
+	if (mask)
+		return cpumap_print_to_pagebuf(true, buf, mask);
+	return 0;
+}
+
+static DEVICE_ATTR_RO(cpumask);
+
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_perf_event_mux_interval_ms.attr,
 	&dev_attr_nr_addr_filters.attr,
+	&dev_attr_cpumask.attr,
 	NULL,
 };
 
@@ -11492,6 +11547,10 @@ static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int
 	if (n == 2 && !pmu->nr_addr_filters)
 		return 0;
 
+	/* cpumask */
+	if (n == 3 && pmu->scope == PERF_PMU_SCOPE_NONE)
+		return 0;
+
 	return a->mode;
 }
 
@@ -11576,6 +11635,11 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		goto free_pdc;
 	}
 
+	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
+		ret = -EINVAL;
+		goto free_pdc;
+	}
+
 	pmu->name = name;
 
 	if (type >= 0)
@@ -11730,6 +11794,22 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		    event_has_any_exclude_flag(event))
 			ret = -EINVAL;
 
+		if (pmu->scope != PERF_PMU_SCOPE_NONE && event->cpu >= 0) {
+			const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope, event->cpu);
+			struct cpumask *pmu_cpumask = perf_scope_cpumask(pmu->scope);
+			int cpu;
+
+			if (pmu_cpumask && cpumask) {
+				cpu = cpumask_any_and(pmu_cpumask, cpumask);
+				if (cpu >= nr_cpu_ids)
+					ret = -ENODEV;
+				else
+					event->cpu = cpu;
+			} else {
+				ret = -ENODEV;
+			}
+		}
+
 		if (ret && event->destroy)
 			event->destroy(event);
 	}
@@ -13681,6 +13761,12 @@ static void __init perf_event_init_all_cpus(void)
 	int cpu;
 
 	zalloc_cpumask_var(&perf_online_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_core_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_die_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_cluster_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_pkg_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_sys_mask, GFP_KERNEL);
+
 
 	for_each_possible_cpu(cpu) {
 		swhash = &per_cpu(swevent_htable, cpu);
@@ -13730,6 +13816,40 @@ static void __perf_event_exit_context(void *__info)
 	raw_spin_unlock(&ctx->lock);
 }
 
+static void perf_event_clear_cpumask(unsigned int cpu)
+{
+	int target[PERF_PMU_MAX_SCOPE];
+	unsigned int scope;
+	struct pmu *pmu;
+
+	cpumask_clear_cpu(cpu, perf_online_mask);
+
+	for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
+		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(scope, cpu);
+		struct cpumask *pmu_cpumask = perf_scope_cpumask(scope);
+
+		target[scope] = -1;
+		if (WARN_ON_ONCE(!pmu_cpumask || !cpumask))
+			continue;
+
+		if (!cpumask_test_and_clear_cpu(cpu, pmu_cpumask))
+			continue;
+		target[scope] = cpumask_any_but(cpumask, cpu);
+		if (target[scope] < nr_cpu_ids)
+			cpumask_set_cpu(target[scope], pmu_cpumask);
+	}
+
+	/* migrate */
+	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
+		if (pmu->scope == PERF_PMU_SCOPE_NONE ||
+		    WARN_ON_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE))
+			continue;
+
+		if (target[pmu->scope] >= 0 && target[pmu->scope] < nr_cpu_ids)
+			perf_pmu_migrate_context(pmu, cpu, target[pmu->scope]);
+	}
+}
+
 static void perf_event_exit_cpu_context(int cpu)
 {
 	struct perf_cpu_context *cpuctx;
@@ -13737,6 +13857,11 @@ static void perf_event_exit_cpu_context(int cpu)
 
 	// XXX simplify cpuctx->online
 	mutex_lock(&pmus_lock);
+	/*
+	 * Clear the cpumasks, and migrate to other CPUs if possible.
+	 * Must be invoked before the __perf_event_exit_context.
+	 */
+	perf_event_clear_cpumask(cpu);
 	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
 	ctx = &cpuctx->ctx;
 
@@ -13744,7 +13869,6 @@ static void perf_event_exit_cpu_context(int cpu)
 	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
 	cpuctx->online = 0;
 	mutex_unlock(&ctx->mutex);
-	cpumask_clear_cpu(cpu, perf_online_mask);
 	mutex_unlock(&pmus_lock);
 }
 #else
@@ -13753,6 +13877,42 @@ static void perf_event_exit_cpu_context(int cpu) { }
 
 #endif
 
+static void perf_event_setup_cpumask(unsigned int cpu)
+{
+	struct cpumask *pmu_cpumask;
+	unsigned int scope;
+
+	cpumask_set_cpu(cpu, perf_online_mask);
+
+	/*
+	 * Early boot stage, the cpumask hasn't been set yet.
+	 * The perf_online_<domain>_masks includes the first CPU of each domain.
+	 * Always uncondifionally set the boot CPU for the perf_online_<domain>_masks.
+	 */
+	if (!topology_sibling_cpumask(cpu)) {
+		for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
+			pmu_cpumask = perf_scope_cpumask(scope);
+			if (WARN_ON_ONCE(!pmu_cpumask))
+				continue;
+			cpumask_set_cpu(cpu, pmu_cpumask);
+		}
+		return;
+	}
+
+	for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
+		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(scope, cpu);
+
+		pmu_cpumask = perf_scope_cpumask(scope);
+
+		if (WARN_ON_ONCE(!pmu_cpumask || !cpumask))
+			continue;
+
+		if (!cpumask_empty(cpumask) &&
+		    cpumask_any_and(pmu_cpumask, cpumask) >= nr_cpu_ids)
+			cpumask_set_cpu(cpu, pmu_cpumask);
+	}
+}
+
 int perf_event_init_cpu(unsigned int cpu)
 {
 	struct perf_cpu_context *cpuctx;
@@ -13761,7 +13921,7 @@ int perf_event_init_cpu(unsigned int cpu)
 	perf_swevent_init_cpu(cpu);
 
 	mutex_lock(&pmus_lock);
-	cpumask_set_cpu(cpu, perf_online_mask);
+	perf_event_setup_cpumask(cpu);
 	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
 	ctx = &cpuctx->ctx;
 
-- 
2.38.1


