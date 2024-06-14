Return-Path: <linux-kernel+bounces-214961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20FF908CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892D028A1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A717559;
	Fri, 14 Jun 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pb+7IbiS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57F944D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372875; cv=none; b=h3cf83kqpHA+E2g98mePwszMxKgl8ZLnvuEEPqgbGpaymge/VIlwtCXKDEQ5NlqLqwvvNLrbBX+wIZQiYK41WD4WprBr8simzcoGroI2+0ny7gvfV3lPjd2Mpze/Wgz8UzK5vKkwEDrR9rjKztiXGxdo0zuZo0XYMHqHAG6R/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372875; c=relaxed/simple;
	bh=T7VfAuXntkqtlBPwES88Zok8fSlDANCcRRFjiGYcm6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPzAzSFuaIDa8XW634nXVOVfYgOr8qCxqtP4REqu710IGN/h8fIFC+wauqtqngtS8LQCttHMCiiwd3RkUTj+TmUSaUbB6QIMj0H8VzcpSyImbby0PfLJ8tXgqO4pIigcd/7WTf3bvElILlAVutP4d5UYlesfPCNoJs1HIdoKkvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pb+7IbiS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372875; x=1749908875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7VfAuXntkqtlBPwES88Zok8fSlDANCcRRFjiGYcm6Y=;
  b=Pb+7IbiSsdwrSZZ2AMJgIPcvnZEKBTDxlWp38EUW793TyhLqGAnHmBE5
   ny4JBJYYQe6o7XPHyOVyTwGAuCbOY9ozeGD15dvrLTFZfwEdSSyUcAuiB
   B8mFMUKDUx2U3obBRIiGBoXGHX3bYejBaqOdbTgtyS1a5n98LLEQ2FXEJ
   YeckRriag4TBL9PRMfrNwkeRz1FPMISliUwn6tKHbWEee2Nb3w21VhfOn
   TPCC5T5YDEEop7/iMhHrYVPfP5TuEBqpuuKXxzgRXaAa3sLPCdXiREY3P
   z380xkqguJTAzyPIekkzHHZRYvdumgh1ZpeGklntDqhlswUaoEtzUZ9BP
   w==;
X-CSE-ConnectionGUID: G+tCZSzrTlOgdzmMNToL5w==
X-CSE-MsgGUID: PHVbQl7sRn2AMaMBiyBVdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19079163"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19079163"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:47:52 -0700
X-CSE-ConnectionGUID: gtSPbkBsQnKzwYBuuuxq2w==
X-CSE-MsgGUID: 9jVkj7YnSgC30Pw1lmhxaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40386677"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jun 2024 06:47:51 -0700
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
Subject: [PATCH V2 5/8] perf/x86/uncore: Apply the unit control RB tree to MSR uncore units
Date: Fri, 14 Jun 2024 06:46:28 -0700
Message-Id: <20240614134631.1092359-6-kan.liang@linux.intel.com>
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

The unit control RB tree has the unit control and unit ID information
for all the MSR units. Use them to replace the box_ctl and
uncore_msr_box_ctl() to get an accurate unit control address for MSR
uncore units.

Add intel_generic_uncore_assign_hw_event(), which utilizes the accurate
unit control address from the unit control RB tree to calculate the
config_base and event_base.

The unit id related information should be retrieved from the unit
control RB tree as well.

Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           |  3 ++
 arch/x86/events/intel/uncore_discovery.c | 49 +++++++++++++++++++++---
 arch/x86/events/intel/uncore_discovery.h |  2 +
 arch/x86/events/intel/uncore_snbep.c     | 16 +++++---
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 3ad23527833a..f48c7049d2ed 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -263,6 +263,9 @@ static void uncore_assign_hw_event(struct intel_uncore_box *box,
 		return;
 	}
 
+	if (intel_generic_uncore_assign_hw_event(event, box))
+		return;
+
 	hwc->config_base = uncore_event_ctl(box, hwc->idx);
 	hwc->event_base  = uncore_perf_ctr(box, hwc->idx);
 }
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index ece761c9f17a..076ec1efe9cc 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -499,19 +499,31 @@ static const struct attribute_group generic_uncore_format_group = {
 	.attrs = generic_uncore_formats_attr,
 };
 
+static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
+{
+	struct intel_uncore_discovery_unit *unit;
+
+	unit = intel_uncore_find_discovery_unit(box->pmu->type->boxes,
+						-1, box->pmu->pmu_idx);
+	if (WARN_ON_ONCE(!unit))
+		return 0;
+
+	return unit->addr;
+}
+
 void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
 {
-	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
+	wrmsrl(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
 }
 
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
+	wrmsrl(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
 }
 
 void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(uncore_msr_box_ctl(box), 0);
+	wrmsrl(intel_generic_uncore_box_ctl(box), 0);
 }
 
 static void intel_generic_uncore_msr_enable_event(struct intel_uncore_box *box,
@@ -539,6 +551,31 @@ static struct intel_uncore_ops generic_uncore_msr_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
+bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
+					  struct intel_uncore_box *box)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 box_ctl;
+
+	if (!box->pmu->type->boxes)
+		return false;
+
+	if (box->pci_dev || box->io_addr) {
+		hwc->config_base = uncore_pci_event_ctl(box, hwc->idx);
+		hwc->event_base  = uncore_pci_perf_ctr(box, hwc->idx);
+		return true;
+	}
+
+	box_ctl = intel_generic_uncore_box_ctl(box);
+	if (!box_ctl)
+		return false;
+
+	hwc->config_base = box_ctl + box->pmu->type->event_ctl + hwc->idx;
+	hwc->event_base  = box_ctl + box->pmu->type->perf_ctr + hwc->idx;
+
+	return true;
+}
+
 void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
@@ -697,10 +734,12 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 	switch (type_id) {
 	case UNCORE_ACCESS_MSR:
 		uncore->ops = &generic_uncore_msr_ops;
-		uncore->perf_ctr = (unsigned int)type->box_ctrl + type->ctr_offset;
-		uncore->event_ctl = (unsigned int)type->box_ctrl + type->ctl_offset;
+		uncore->perf_ctr = (unsigned int)type->ctr_offset;
+		uncore->event_ctl = (unsigned int)type->ctl_offset;
 		uncore->box_ctl = (unsigned int)type->box_ctrl;
 		uncore->msr_offsets = type->box_offset;
+		uncore->boxes = &type->units;
+		uncore->num_boxes = type->num_units;
 		break;
 	case UNCORE_ACCESS_PCI:
 		uncore->ops = &generic_uncore_pci_ops;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 96265cf1fc86..4a7a7c819d6f 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -169,3 +169,5 @@ intel_uncore_generic_init_uncores(enum uncore_access_type type_id, int num_extra
 
 int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
 					unsigned int pmu_idx);
+bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
+					  struct intel_uncore_box *box);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2eaf0f339849..c42b170886d2 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5932,10 +5932,11 @@ static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
 	bool tie_en = !!(event->hw.config & SPR_CHA_PMON_CTL_TID_EN);
 	struct intel_uncore_type *type = box->pmu->type;
+	int id = intel_uncore_find_discovery_unit_id(type->boxes, -1, box->pmu->pmu_idx);
 
 	if (tie_en) {
 		reg1->reg = SPR_C0_MSR_PMON_BOX_FILTER0 +
-			    HSWEP_CBO_MSR_OFFSET * type->box_ids[box->pmu->pmu_idx];
+			    HSWEP_CBO_MSR_OFFSET * id;
 		reg1->config = event->attr.config1 & SPR_CHA_PMON_BOX_FILTER_TID;
 		reg1->idx = 0;
 	}
@@ -6459,18 +6460,21 @@ uncore_find_type_by_id(struct intel_uncore_type **types, int type_id)
 static int uncore_type_max_boxes(struct intel_uncore_type **types,
 				 int type_id)
 {
+	struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type;
-	int i, max = 0;
+	struct rb_node *node;
+	int max = 0;
 
 	type = uncore_find_type_by_id(types, type_id);
 	if (!type)
 		return 0;
 
-	for (i = 0; i < type->num_boxes; i++) {
-		if (type->box_ids[i] > max)
-			max = type->box_ids[i];
-	}
+	for (node = rb_first(type->boxes); node; node = rb_next(node)) {
+		unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
 
+		if (unit->id > max)
+			max = unit->id;
+	}
 	return max + 1;
 }
 
-- 
2.35.1


