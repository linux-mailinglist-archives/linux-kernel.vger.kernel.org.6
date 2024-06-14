Return-Path: <linux-kernel+bounces-214964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4E9908CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43EE1C25E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A52BCFF;
	Fri, 14 Jun 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfiE2X/J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59358D50F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372877; cv=none; b=JKknuAOOJxdFvCkN9jjHiF6+ehQJ/WpIZZNcdIufTXoKeUKbc0MmEc5MK0W4EwNM353HJTEJo9Ppje7JLcwjewW0fYSO4srcVRFon6tfMyrnA+UnYVKxtu7rF5owJerV0U5i5T0JzsMOF8BX2xI6kvXALO/hatk7miE2R44Yuz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372877; c=relaxed/simple;
	bh=SODi3fU4/Hsmgv9WKYtCnU9986tJ7Aakp3djKkB7324=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nmvaOtRZFljZBp1WBQY4yBcKypfgNVJQLOFuTyZzYdit+wzl2QqO1K9xj7VCAd+BacJJHy0jD5nYfuQwAFVF0HSjKF61OZvICC0Rt8EoQgvFNBOiclPiGFjtRDSMap+eQC6DDmpnoUSdxAPYOTnPA7lbZnXdXvaiteFEEh4/IyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfiE2X/J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372876; x=1749908876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SODi3fU4/Hsmgv9WKYtCnU9986tJ7Aakp3djKkB7324=;
  b=jfiE2X/JSPwtR8bup6alXkZLebs0gHbObJZvA01nm7glDdgZupzR5aYI
   Vv33aTOQ1ER9uWL0J80w1J+zpeD/9V7/LA2saefJAs/b5i6c+169fG+Pu
   OJPPx7ABZpLHUh9PxOSEdVo6cHVcHXPsCbi6a+Id93ygrOnlWVMQe+mZ5
   SwK8LeA8U7p8bs7EThxP74zfGakEqT9T8/AewZKP+32gNPuZDbgoLMn9t
   SJgt+6uDw4Lsq8EvmNJK7bb+jzr2UUGmv9slMbkk3YY9sp5h0i54njnaV
   045quL4ee63GWAiG76haNcwLaEJOudCJ/ERkEJD5cJsWtEAff4z8Sxt9J
   Q==;
X-CSE-ConnectionGUID: 0VMThmxhS1qXvpMoI4AhKQ==
X-CSE-MsgGUID: wHyrh2r6SbO07rZtLwMgxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19079171"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19079171"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:47:53 -0700
X-CSE-ConnectionGUID: qufPR6TDQZSYmt3moRs2ow==
X-CSE-MsgGUID: VwZc0qLFRjenND7tSd7Cjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40386687"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jun 2024 06:47:52 -0700
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
Subject: [PATCH V2 7/8] perf/x86/uncore: Cleanup unused unit structure
Date: Fri, 14 Jun 2024 06:46:30 -0700
Message-Id: <20240614134631.1092359-8-kan.liang@linux.intel.com>
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

The unit control and ID information are retrieved from the unit control
RB tree. No one uses the old structure anymore. Remove them.

Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           |   7 +-
 arch/x86/events/intel/uncore.h           |   2 -
 arch/x86/events/intel/uncore_discovery.c | 110 +++--------------------
 arch/x86/events/intel/uncore_discovery.h |   5 --
 4 files changed, 12 insertions(+), 112 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 79449c5b9256..0c724b804e7b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -868,7 +868,7 @@ static inline int uncore_get_box_id(struct intel_uncore_type *type,
 	if (type->boxes)
 		return intel_uncore_find_discovery_unit_id(type->boxes, -1, pmu->pmu_idx);
 
-	return type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx;
+	return pmu->pmu_idx;
 }
 
 void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
@@ -980,10 +980,7 @@ static void uncore_type_exit(struct intel_uncore_type *type)
 		kfree(type->pmus);
 		type->pmus = NULL;
 	}
-	if (type->box_ids) {
-		kfree(type->box_ids);
-		type->box_ids = NULL;
-	}
+
 	kfree(type->events_group);
 	type->events_group = NULL;
 }
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 05c429c8cb93..027ef292c602 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -62,7 +62,6 @@ struct intel_uncore_type {
 	unsigned fixed_ctr;
 	unsigned fixed_ctl;
 	unsigned box_ctl;
-	u64 *box_ctls;	/* Unit ctrl addr of the first box of each die */
 	union {
 		unsigned msr_offset;
 		unsigned mmio_offset;
@@ -76,7 +75,6 @@ struct intel_uncore_type {
 		u64 *pci_offsets;
 		u64 *mmio_offsets;
 	};
-	unsigned *box_ids;
 	struct event_constraint unconstrainted;
 	struct event_constraint *constraints;
 	struct intel_uncore_pmu *pmus;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 866493fda47c..571e44b49691 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -89,10 +89,6 @@ add_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	if (!type)
 		return NULL;
 
-	type->box_ctrl_die = kcalloc(__uncore_max_dies, sizeof(u64), GFP_KERNEL);
-	if (!type->box_ctrl_die)
-		goto free_type;
-
 	type->units = RB_ROOT;
 
 	type->access_type = unit->access_type;
@@ -102,12 +98,6 @@ add_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	rb_add(&type->node, &discovery_tables, __type_less);
 
 	return type;
-
-free_type:
-	kfree(type);
-
-	return NULL;
-
 }
 
 static struct intel_uncore_discovery_type *
@@ -230,13 +220,10 @@ void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
 
 static void
 uncore_insert_box_info(struct uncore_unit_discovery *unit,
-		       int die, bool parsed)
+		       int die)
 {
 	struct intel_uncore_discovery_unit *node;
 	struct intel_uncore_discovery_type *type;
-	unsigned int *ids;
-	u64 *box_offset;
-	int i;
 
 	if (!unit->ctl || !unit->ctl_offset || !unit->ctr_offset) {
 		pr_info("Invalid address is detected for uncore type %d box %d, "
@@ -253,79 +240,21 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 	node->id = unit->box_id;
 	node->addr = unit->ctl;
 
-	if (parsed) {
-		type = search_uncore_discovery_type(unit->box_type);
-		if (!type) {
-			pr_info("A spurious uncore type %d is detected, "
-				"Disable the uncore type.\n",
-				unit->box_type);
-			kfree(node);
-			return;
-		}
-
-		uncore_find_add_unit(node, &type->units, &type->num_units);
-
-		/* Store the first box of each die */
-		if (!type->box_ctrl_die[die])
-			type->box_ctrl_die[die] = unit->ctl;
+	type = get_uncore_discovery_type(unit);
+	if (!type) {
+		kfree(node);
 		return;
 	}
 
-	type = get_uncore_discovery_type(unit);
-	if (!type)
-		goto free_node;
-
-	box_offset = kcalloc(type->num_boxes + 1, sizeof(u64), GFP_KERNEL);
-	if (!box_offset)
-		goto free_node;
-
-	ids = kcalloc(type->num_boxes + 1, sizeof(unsigned int), GFP_KERNEL);
-	if (!ids)
-		goto free_box_offset;
-
 	uncore_find_add_unit(node, &type->units, &type->num_units);
 
 	/* Store generic information for the first box */
-	if (!type->num_boxes) {
-		type->box_ctrl = unit->ctl;
-		type->box_ctrl_die[die] = unit->ctl;
+	if (type->num_units == 1) {
 		type->num_counters = unit->num_regs;
 		type->counter_width = unit->bit_width;
 		type->ctl_offset = unit->ctl_offset;
 		type->ctr_offset = unit->ctr_offset;
-		*ids = unit->box_id;
-		goto end;
 	}
-
-	for (i = 0; i < type->num_boxes; i++) {
-		ids[i] = type->ids[i];
-		box_offset[i] = type->box_offset[i];
-
-		if (unit->box_id == ids[i]) {
-			pr_info("Duplicate uncore type %d box ID %d is detected, "
-				"Drop the duplicate uncore unit.\n",
-				unit->box_type, unit->box_id);
-			goto free_ids;
-		}
-	}
-	ids[i] = unit->box_id;
-	box_offset[i] = unit->ctl - type->box_ctrl;
-	kfree(type->ids);
-	kfree(type->box_offset);
-end:
-	type->ids = ids;
-	type->box_offset = box_offset;
-	type->num_boxes++;
-	return;
-
-free_ids:
-	kfree(ids);
-
-free_box_offset:
-	kfree(box_offset);
-
-free_node:
-	kfree(node);
 }
 
 static bool
@@ -404,7 +333,7 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 		if (uncore_ignore_unit(&unit, ignore))
 			continue;
 
-		uncore_insert_box_info(&unit, die, *parsed);
+		uncore_insert_box_info(&unit, die);
 	}
 
 	*parsed = true;
@@ -474,7 +403,6 @@ void intel_uncore_clear_discovery_tables(void)
 			rb_erase(node, &type->units);
 			kfree(pos);
 		}
-		kfree(type->box_ctrl_die);
 		kfree(type);
 	}
 }
@@ -738,41 +666,23 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 				      struct intel_uncore_discovery_type *type)
 {
 	uncore->type_id = type->type;
-	uncore->num_boxes = type->num_boxes;
 	uncore->num_counters = type->num_counters;
 	uncore->perf_ctr_bits = type->counter_width;
-	uncore->box_ids = type->ids;
+	uncore->perf_ctr = (unsigned int)type->ctr_offset;
+	uncore->event_ctl = (unsigned int)type->ctl_offset;
+	uncore->boxes = &type->units;
+	uncore->num_boxes = type->num_units;
 
 	switch (type_id) {
 	case UNCORE_ACCESS_MSR:
 		uncore->ops = &generic_uncore_msr_ops;
-		uncore->perf_ctr = (unsigned int)type->ctr_offset;
-		uncore->event_ctl = (unsigned int)type->ctl_offset;
-		uncore->box_ctl = (unsigned int)type->box_ctrl;
-		uncore->msr_offsets = type->box_offset;
-		uncore->boxes = &type->units;
-		uncore->num_boxes = type->num_units;
 		break;
 	case UNCORE_ACCESS_PCI:
 		uncore->ops = &generic_uncore_pci_ops;
-		uncore->perf_ctr = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl) + type->ctr_offset;
-		uncore->event_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl) + type->ctl_offset;
-		uncore->box_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl);
-		uncore->box_ctls = type->box_ctrl_die;
-		uncore->pci_offsets = type->box_offset;
-		uncore->boxes = &type->units;
-		uncore->num_boxes = type->num_units;
 		break;
 	case UNCORE_ACCESS_MMIO:
 		uncore->ops = &generic_uncore_mmio_ops;
-		uncore->perf_ctr = (unsigned int)type->ctr_offset;
-		uncore->event_ctl = (unsigned int)type->ctl_offset;
-		uncore->box_ctl = (unsigned int)type->box_ctrl;
-		uncore->box_ctls = type->box_ctrl_die;
-		uncore->mmio_offsets = type->box_offset;
 		uncore->mmio_map_size = UNCORE_GENERIC_MMIO_SIZE;
-		uncore->boxes = &type->units;
-		uncore->num_boxes = type->num_units;
 		break;
 	default:
 		return false;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 0acf9b681f3b..0e94aa7db8e7 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -124,18 +124,13 @@ struct intel_uncore_discovery_unit {
 struct intel_uncore_discovery_type {
 	struct rb_node	node;
 	enum uncore_access_type	access_type;
-	u64		box_ctrl;	/* Unit ctrl addr of the first box */
-	u64		*box_ctrl_die;	/* Unit ctrl addr of the first box of each die */
 	struct rb_root	units;		/* Unit ctrl addr for all units */
 	u16		type;		/* Type ID of the uncore block */
 	u8		num_counters;
 	u8		counter_width;
 	u8		ctl_offset;	/* Counter Control 0 offset */
 	u8		ctr_offset;	/* Counter 0 offset */
-	u16		num_boxes;	/* number of boxes for the uncore block */
 	u16		num_units;	/* number of units */
-	unsigned int	*ids;		/* Box IDs */
-	u64		*box_offset;	/* Box offset */
 };
 
 bool intel_uncore_has_discovery_tables(int *ignore);
-- 
2.35.1


