Return-Path: <linux-kernel+bounces-214958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB8908CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E8A289337
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D8C152;
	Fri, 14 Jun 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmCdkGSs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ED5523D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372874; cv=none; b=fzqQVq7LJBQkxVbeFm5kqd1ENzopkKnX+rwn980ar+0ttZ+HWN4hbTQSBQXcV555Gp5UNA86kFcTX2wIDkHzEaKHsRTH63834r+tA+8g5IzL5517qvTQU/hfmrr/e/8jKYCfjzfARCuxdVZ04XQaOhthso+/JigWXyDGAOtFAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372874; c=relaxed/simple;
	bh=VTtdyC2NsuHT44Nr0ys9g8RojgFenib/2fJcDi831bA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiBG3C2pgxfR2z/D01b8UNGRTdczmhEH0PjVXIn53FXyvT+4TYmVnH5bfOuXQmaBMa8JVUgODbDmCRIgk1uNXlwipYT3w/jaYS4tHfItBHdTFJ71jXCLLYzp7ppgoL93GpKYFgOT7bc5/uD8SRU67NstlUlNyi3Bj55ITlUw0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmCdkGSs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372873; x=1749908873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VTtdyC2NsuHT44Nr0ys9g8RojgFenib/2fJcDi831bA=;
  b=JmCdkGSsbqVa7JyvzL8Irm/TJ+XcSNpt2zhaLn4l1749XiK96yPOV3zr
   uzHi6rB3CO5MAEpe5Xqkt91JWyrd53shN2mawDnvpi/si9ylF3Q4qroxc
   AGTNm9I2cwrLLlZko8M5PeYEijQwMIboX69jUrc4No4MqBiPog/erh166
   /r8Ee7Dwk0J0S+3F0hVj4Euf3GtAG5IlUe5Y7Us+seMkihwR8fJ5RxnWo
   z7fPMHsYgVy6A8c016fRCEGb/jWq84e8SjeAuB9Tii8XTq0tjAcmv/j5s
   MgUX3qrsTKHiO63EHk772w2oGKeiIif/poh2zV9p9/xtWAt+kY9br0M9S
   g==;
X-CSE-ConnectionGUID: GtZEXfBkTueBC3uGNtX6dA==
X-CSE-MsgGUID: sRklepnsSUGH6RqLALhB8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19079151"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19079151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:47:51 -0700
X-CSE-ConnectionGUID: UnAnfDPJSsKqwapmnwviZA==
X-CSE-MsgGUID: g4gp7JNgTz2AZaMh1uQeNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40386667"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jun 2024 06:47:50 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	yunying.sun@intel.com,
	tim.c.chen@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/8] perf/x86/uncore: Support per PMU cpumask
Date: Fri, 14 Jun 2024 06:46:25 -0700
Message-Id: <20240614134631.1092359-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240614134631.1092359-1-kan.liang@linux.intel.com>
References: <20240614134631.1092359-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The cpumask of some uncore units, e.g., CXL uncore units, may be wrong
under some configurations. Perf may access an uncore counter of a
non-existent uncore unit.

The uncore driver assumes that all uncore units are symmetric among
dies. A global cpumask is shared among all uncore PMUs. However, some
CXL uncore units may only be available on some dies.

A per PMU cpumask is introduced to track the CPU mask of this PMU.
The driver searches the unit control RB tree to check whether the PMU is
available on a given die, and updates the per PMU cpumask accordingly.

Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           | 31 +++++++++++--
 arch/x86/events/intel/uncore.h           |  2 +
 arch/x86/events/intel/uncore_discovery.c | 58 ++++++++++++++++++++++++
 arch/x86/events/intel/uncore_discovery.h |  3 ++
 4 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 258e2cdf28fa..c2d877d20e31 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -843,7 +843,9 @@ static void uncore_pmu_disable(struct pmu *pmu)
 static ssize_t uncore_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &uncore_cpu_mask);
+	struct intel_uncore_pmu *pmu = container_of(dev_get_drvdata(dev), struct intel_uncore_pmu, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu->cpu_mask);
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
@@ -1453,6 +1455,18 @@ static void uncore_pci_exit(void)
 	}
 }
 
+static bool uncore_die_has_box(struct intel_uncore_type *type,
+			       int die, unsigned int pmu_idx)
+{
+	if (!type->boxes)
+		return true;
+
+	if (intel_uncore_find_discovery_unit_id(type->boxes, die, pmu_idx) < 0)
+		return false;
+
+	return true;
+}
+
 static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 				   int new_cpu)
 {
@@ -1468,18 +1482,25 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 
 		if (old_cpu < 0) {
 			WARN_ON_ONCE(box->cpu != -1);
-			box->cpu = new_cpu;
+			if (uncore_die_has_box(type, die, pmu->pmu_idx)) {
+				box->cpu = new_cpu;
+				cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
+			}
 			continue;
 		}
 
-		WARN_ON_ONCE(box->cpu != old_cpu);
+		WARN_ON_ONCE(box->cpu != -1 && box->cpu != old_cpu);
 		box->cpu = -1;
+		cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
 		if (new_cpu < 0)
 			continue;
 
+		if (!uncore_die_has_box(type, die, pmu->pmu_idx))
+			continue;
 		uncore_pmu_cancel_hrtimer(box);
 		perf_pmu_migrate_context(&pmu->pmu, old_cpu, new_cpu);
 		box->cpu = new_cpu;
+		cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
 	}
 }
 
@@ -1502,7 +1523,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			box = pmu->boxes[id];
-			if (box && atomic_dec_return(&box->refcnt) == 0)
+			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
 				uncore_box_exit(box);
 		}
 	}
@@ -1592,7 +1613,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			box = pmu->boxes[id];
-			if (box && atomic_inc_return(&box->refcnt) == 1)
+			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
 				uncore_box_init(box);
 		}
 	}
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 4838502d89ae..0a49e304fe40 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -86,6 +86,7 @@ struct intel_uncore_type {
 	const struct attribute_group *attr_groups[4];
 	const struct attribute_group **attr_update;
 	struct pmu *pmu; /* for custom pmu ops */
+	struct rb_root *boxes;
 	/*
 	 * Uncore PMU would store relevant platform topology configuration here
 	 * to identify which platform component each PMON block of that type is
@@ -125,6 +126,7 @@ struct intel_uncore_pmu {
 	int				func_id;
 	bool				registered;
 	atomic_t			activeboxes;
+	cpumask_t			cpu_mask;
 	struct intel_uncore_type	*type;
 	struct intel_uncore_box		**boxes;
 };
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index ce520e69a3c1..e61e460520a8 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -122,6 +122,64 @@ get_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	return add_uncore_discovery_type(unit);
 }
 
+static inline int pmu_idx_cmp(const void *key, const struct rb_node *b)
+{
+	struct intel_uncore_discovery_unit *unit;
+	const unsigned int *id = key;
+
+	unit = rb_entry(b, struct intel_uncore_discovery_unit, node);
+
+	if (unit->pmu_idx > *id)
+		return -1;
+	else if (unit->pmu_idx < *id)
+		return 1;
+
+	return 0;
+}
+
+static struct intel_uncore_discovery_unit *
+intel_uncore_find_discovery_unit(struct rb_root *units, int die,
+				 unsigned int pmu_idx)
+{
+	struct intel_uncore_discovery_unit *unit;
+	struct rb_node *pos;
+
+	if (!units)
+		return NULL;
+
+	pos = rb_find_first(&pmu_idx, units, pmu_idx_cmp);
+	if (!pos)
+		return NULL;
+	unit = rb_entry(pos, struct intel_uncore_discovery_unit, node);
+
+	if (die < 0)
+		return unit;
+
+	for (; pos; pos = rb_next(pos)) {
+		unit = rb_entry(pos, struct intel_uncore_discovery_unit, node);
+
+		if (unit->pmu_idx != pmu_idx)
+			break;
+
+		if (unit->die == die)
+			return unit;
+	}
+
+	return NULL;
+}
+
+int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
+					unsigned int pmu_idx)
+{
+	struct intel_uncore_discovery_unit *unit;
+
+	unit = intel_uncore_find_discovery_unit(units, die, pmu_idx);
+	if (unit)
+		return unit->id;
+
+	return -1;
+}
+
 static inline bool unit_less(struct rb_node *a, const struct rb_node *b)
 {
 	struct intel_uncore_discovery_unit *a_node, *b_node;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 5190017aba51..96265cf1fc86 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -166,3 +166,6 @@ u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
 
 struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id, int num_extra);
+
+int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
+					unsigned int pmu_idx);
-- 
2.35.1


