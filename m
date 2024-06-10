Return-Path: <linux-kernel+bounces-208851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7FE9029DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D5F1C238CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4435A1514C8;
	Mon, 10 Jun 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3rB9oWf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD354FAD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050677; cv=none; b=JSt3vOmpD/9xc0/kKFrhBBdhRx+uHKKwAl8obwZ1NeYPz/tuDzhutn2lrIi9jKFlfDGSJ5BJjv6dZX0EQvHR7AOBLHuNNFa8ub91KPRallugiCDkztt6zjQ18jdyWUndmjFwKmF0AnGX8mRZ2i9RDBLE5VYqGD0aR3jhaBPhQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050677; c=relaxed/simple;
	bh=ZCYcl9i2NALecz/tlNlivIVc59evzPPmgbFMq/qolkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akLAWh0y4AhiCAv/1B7C/i/1n0AiQ67X7UlH9WTNE361N8UrqHSOw9qKaaln3lUtx7ibJjWoZ1A2X6WQN2i/NvtcslbYp8KAfPIxgXbuejmLL0SM/cmQzNnrpQmGWX8LxxSAFW8PU9672XXjfOe0n7xnNjCLO9q2Tdyj7IKxzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3rB9oWf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050675; x=1749586675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZCYcl9i2NALecz/tlNlivIVc59evzPPmgbFMq/qolkI=;
  b=R3rB9oWfmUPzrINXudoVTYMm55Qa6fMOB4S67uAoK+Y7YwElsaqQA0Dq
   Iu0si/uEdj7Hc9y1lbp7mw+rkJGD1VyRiV+cyFzdaKbG+wYqnpeH1Ox6Q
   DxJRc9K1UO3sWIl2klkNVfRu6wKSiT9d3iYTyEb4iSCBXrsty2s9saOqs
   zFigGnUjZs6emKi6+4XbuGwDrmrTzHqppjQBPpq2R8OAiTOJuesyPT7K0
   /mb9LnsiZAkdxt8OcSv8aph/p/hzvV927weLVr7nEuWQc0FLzB6F9xlWZ
   nApncql9rUm6I2Ntc+WKMkvzb8oYCsLhRRTj6OY9O6at5TRx7b025kYVM
   Q==;
X-CSE-ConnectionGUID: KSnHZt4HSbS7IlK81XU0iw==
X-CSE-MsgGUID: 6Ocehi6STo6gfq0AaeOeXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18561533"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18561533"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:17:52 -0700
X-CSE-ConnectionGUID: kuFkFM4VTuGFlB5izxhDUQ==
X-CSE-MsgGUID: svKQ1+pPTUi1MLWQybCrpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39169098"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2024 13:17:51 -0700
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/8] perf/x86/uncore: Apply the unit control RB tree to PCI uncore units
Date: Mon, 10 Jun 2024 13:16:17 -0700
Message-Id: <20240610201619.884021-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240610201619.884021-1-kan.liang@linux.intel.com>
References: <20240610201619.884021-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The unit control RB tree has the unit control and unit ID information
for all the PCI units. Use them to replace the box_ctls/pci_offsets to
get an accurate unit control address for PCI uncore units.

The UPI/M3UPI units in the discovery table are ignored. Please see the
commit 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR").
Manually allocate a unit control RB tree for UPI/M3UPI.
Add cleanup_extra_boxes to release such manual allocation.

Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           | 53 +++++++++++-----------
 arch/x86/events/intel/uncore.h           |  4 ++
 arch/x86/events/intel/uncore_discovery.c | 26 ++++++++---
 arch/x86/events/intel/uncore_discovery.h |  2 +
 arch/x86/events/intel/uncore_snbep.c     | 57 ++++++++++++++++++------
 5 files changed, 94 insertions(+), 48 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index bdb253a1bc3b..8859162adc94 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -970,6 +970,9 @@ static void uncore_type_exit(struct intel_uncore_type *type)
 	if (type->cleanup_mapping)
 		type->cleanup_mapping(type);
 
+	if (type->cleanup_extra_boxes)
+		type->cleanup_extra_boxes(type);
+
 	if (pmu) {
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			uncore_pmu_unregister(pmu);
@@ -1085,22 +1088,19 @@ static struct intel_uncore_pmu *
 uncore_pci_find_dev_pmu_from_types(struct pci_dev *pdev)
 {
 	struct intel_uncore_type **types = uncore_pci_uncores;
+	struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type;
-	u64 box_ctl;
-	int i, die;
+	struct rb_node *node;
 
 	for (; *types; types++) {
 		type = *types;
-		for (die = 0; die < __uncore_max_dies; die++) {
-			for (i = 0; i < type->num_boxes; i++) {
-				if (!type->box_ctls[die])
-					continue;
-				box_ctl = type->box_ctls[die] + type->pci_offsets[i];
-				if (pdev->devfn == UNCORE_DISCOVERY_PCI_DEVFN(box_ctl) &&
-				    pdev->bus->number == UNCORE_DISCOVERY_PCI_BUS(box_ctl) &&
-				    pci_domain_nr(pdev->bus) == UNCORE_DISCOVERY_PCI_DOMAIN(box_ctl))
-					return &type->pmus[i];
-			}
+
+		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
+			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
+			if (pdev->devfn == UNCORE_DISCOVERY_PCI_DEVFN(unit->addr) &&
+			    pdev->bus->number == UNCORE_DISCOVERY_PCI_BUS(unit->addr) &&
+			    pci_domain_nr(pdev->bus) == UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr))
+				return &type->pmus[unit->pmu_idx];
 		}
 	}
 
@@ -1376,28 +1376,25 @@ static struct notifier_block uncore_pci_notifier = {
 static void uncore_pci_pmus_register(void)
 {
 	struct intel_uncore_type **types = uncore_pci_uncores;
+	struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
+	struct rb_node *node;
 	struct pci_dev *pdev;
-	u64 box_ctl;
-	int i, die;
 
 	for (; *types; types++) {
 		type = *types;
-		for (die = 0; die < __uncore_max_dies; die++) {
-			for (i = 0; i < type->num_boxes; i++) {
-				if (!type->box_ctls[die])
-					continue;
-				box_ctl = type->box_ctls[die] + type->pci_offsets[i];
-				pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(box_ctl),
-								   UNCORE_DISCOVERY_PCI_BUS(box_ctl),
-								   UNCORE_DISCOVERY_PCI_DEVFN(box_ctl));
-				if (!pdev)
-					continue;
-				pmu = &type->pmus[i];
-
-				uncore_pci_pmu_register(pdev, type, pmu, die);
-			}
+
+		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
+			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
+			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
+							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
+							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
+
+			if (!pdev)
+				continue;
+			pmu = &type->pmus[unit->pmu_idx];
+			uncore_pci_pmu_register(pdev, type, pmu, unit->die);
 		}
 	}
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 0a49e304fe40..05c429c8cb93 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -99,6 +99,10 @@ struct intel_uncore_type {
 	int (*get_topology)(struct intel_uncore_type *type);
 	void (*set_mapping)(struct intel_uncore_type *type);
 	void (*cleanup_mapping)(struct intel_uncore_type *type);
+	/*
+	 * Optional callbacks for extra uncore units cleanup
+	 */
+	void (*cleanup_extra_boxes)(struct intel_uncore_type *type);
 };
 
 #define pmu_group attr_groups[0]
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 076ec1efe9cc..866493fda47c 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -215,8 +215,8 @@ uncore_find_unit(struct rb_root *root, unsigned int id)
 	return NULL;
 }
 
-static void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
-				 struct rb_root *root, u16 *num_units)
+void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
+			  struct rb_root *root, u16 *num_units)
 {
 	struct intel_uncore_discovery_unit *unit = uncore_find_unit(root, node->id);
 
@@ -560,7 +560,7 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 	if (!box->pmu->type->boxes)
 		return false;
 
-	if (box->pci_dev || box->io_addr) {
+	if (box->io_addr) {
 		hwc->config_base = uncore_pci_event_ctl(box, hwc->idx);
 		hwc->event_base  = uncore_pci_perf_ctr(box, hwc->idx);
 		return true;
@@ -570,16 +570,28 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 	if (!box_ctl)
 		return false;
 
+	if (box->pci_dev) {
+		box_ctl = UNCORE_DISCOVERY_PCI_BOX_CTRL(box_ctl);
+		hwc->config_base = box_ctl + uncore_pci_event_ctl(box, hwc->idx);
+		hwc->event_base  = box_ctl + uncore_pci_perf_ctr(box, hwc->idx);
+		return true;
+	}
+
 	hwc->config_base = box_ctl + box->pmu->type->event_ctl + hwc->idx;
 	hwc->event_base  = box_ctl + box->pmu->type->perf_ctr + hwc->idx;
 
 	return true;
 }
 
+static inline int intel_pci_uncore_box_ctl(struct intel_uncore_box *box)
+{
+	return UNCORE_DISCOVERY_PCI_BOX_CTRL(intel_generic_uncore_box_ctl(box));
+}
+
 void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
-	int box_ctl = uncore_pci_box_ctl(box);
+	int box_ctl = intel_pci_uncore_box_ctl(box);
 
 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
@@ -588,7 +600,7 @@ void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
-	int box_ctl = uncore_pci_box_ctl(box);
+	int box_ctl = intel_pci_uncore_box_ctl(box);
 
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
 }
@@ -596,7 +608,7 @@ void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
-	int box_ctl = uncore_pci_box_ctl(box);
+	int box_ctl = intel_pci_uncore_box_ctl(box);
 
 	pci_write_config_dword(pdev, box_ctl, 0);
 }
@@ -748,6 +760,8 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 		uncore->box_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl);
 		uncore->box_ctls = type->box_ctrl_die;
 		uncore->pci_offsets = type->box_offset;
+		uncore->boxes = &type->units;
+		uncore->num_boxes = type->num_units;
 		break;
 	case UNCORE_ACCESS_MMIO:
 		uncore->ops = &generic_uncore_mmio_ops;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 4a7a7c819d6f..0acf9b681f3b 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -171,3 +171,5 @@ int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
 					unsigned int pmu_idx);
 bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 					  struct intel_uncore_box *box);
+void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
+			  struct rb_root *root, u16 *num_units);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8b1cabff7ee3..fde123af9e3a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6199,6 +6199,24 @@ static u64 spr_upi_pci_offsets[SPR_UNCORE_UPI_NUM_BOXES] = {
 	0, 0x8000, 0x10000, 0x18000
 };
 
+static void spr_extra_boxes_cleanup(struct intel_uncore_type *type)
+{
+	struct intel_uncore_discovery_unit *pos;
+	struct rb_node *node;
+
+	if (!type->boxes)
+		return;
+
+	while (!RB_EMPTY_ROOT(type->boxes)) {
+		node = rb_first(type->boxes);
+		pos = rb_entry(node, struct intel_uncore_discovery_unit, node);
+		rb_erase(node, type->boxes);
+		kfree(pos);
+	}
+	kfree(type->boxes);
+	type->boxes = NULL;
+}
+
 static struct intel_uncore_type spr_uncore_upi = {
 	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
 	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
@@ -6213,10 +6231,11 @@ static struct intel_uncore_type spr_uncore_upi = {
 	.num_counters		= 4,
 	.num_boxes		= SPR_UNCORE_UPI_NUM_BOXES,
 	.perf_ctr_bits		= 48,
-	.perf_ctr		= ICX_UPI_PCI_PMON_CTR0,
-	.event_ctl		= ICX_UPI_PCI_PMON_CTL0,
+	.perf_ctr		= ICX_UPI_PCI_PMON_CTR0 - ICX_UPI_PCI_PMON_BOX_CTL,
+	.event_ctl		= ICX_UPI_PCI_PMON_CTL0 - ICX_UPI_PCI_PMON_BOX_CTL,
 	.box_ctl		= ICX_UPI_PCI_PMON_BOX_CTL,
 	.pci_offsets		= spr_upi_pci_offsets,
+	.cleanup_extra_boxes	= spr_extra_boxes_cleanup,
 };
 
 static struct intel_uncore_type spr_uncore_m3upi = {
@@ -6226,11 +6245,12 @@ static struct intel_uncore_type spr_uncore_m3upi = {
 	.num_counters		= 4,
 	.num_boxes		= SPR_UNCORE_UPI_NUM_BOXES,
 	.perf_ctr_bits		= 48,
-	.perf_ctr		= ICX_M3UPI_PCI_PMON_CTR0,
-	.event_ctl		= ICX_M3UPI_PCI_PMON_CTL0,
+	.perf_ctr		= ICX_M3UPI_PCI_PMON_CTR0 - ICX_M3UPI_PCI_PMON_BOX_CTL,
+	.event_ctl		= ICX_M3UPI_PCI_PMON_CTL0 - ICX_M3UPI_PCI_PMON_BOX_CTL,
 	.box_ctl		= ICX_M3UPI_PCI_PMON_BOX_CTL,
 	.pci_offsets		= spr_upi_pci_offsets,
 	.constraints		= icx_uncore_m3upi_constraints,
+	.cleanup_extra_boxes	= spr_extra_boxes_cleanup,
 };
 
 enum perf_uncore_spr_iio_freerunning_type_id {
@@ -6517,10 +6537,11 @@ void spr_uncore_cpu_init(void)
 
 static void spr_update_device_location(int type_id)
 {
+	struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type;
 	struct pci_dev *dev = NULL;
+	struct rb_root *root;
 	u32 device, devfn;
-	u64 *ctls;
 	int die;
 
 	if (type_id == UNCORE_SPR_UPI) {
@@ -6534,27 +6555,35 @@ static void spr_update_device_location(int type_id)
 	} else
 		return;
 
-	ctls = kcalloc(__uncore_max_dies, sizeof(u64), GFP_KERNEL);
-	if (!ctls) {
+	root = kzalloc(sizeof(struct rb_root), GFP_KERNEL);
+	if (!root) {
 		type->num_boxes = 0;
 		return;
 	}
+	*root = RB_ROOT;
 
 	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
-		if (devfn != dev->devfn)
-			continue;
 
 		die = uncore_device_to_die(dev);
 		if (die < 0)
 			continue;
 
-		ctls[die] = pci_domain_nr(dev->bus) << UNCORE_DISCOVERY_PCI_DOMAIN_OFFSET |
-			    dev->bus->number << UNCORE_DISCOVERY_PCI_BUS_OFFSET |
-			    devfn << UNCORE_DISCOVERY_PCI_DEVFN_OFFSET |
-			    type->box_ctl;
+		unit = kzalloc(sizeof(*unit), GFP_KERNEL);
+		if (!unit)
+			continue;
+		unit->die = die;
+		unit->id = PCI_SLOT(dev->devfn) - PCI_SLOT(devfn);
+		unit->addr = pci_domain_nr(dev->bus) << UNCORE_DISCOVERY_PCI_DOMAIN_OFFSET |
+			     dev->bus->number << UNCORE_DISCOVERY_PCI_BUS_OFFSET |
+			     devfn << UNCORE_DISCOVERY_PCI_DEVFN_OFFSET |
+			     type->box_ctl;
+
+		unit->pmu_idx = unit->id;
+
+		uncore_find_add_unit(unit, root, NULL);
 	}
 
-	type->box_ctls = ctls;
+	type->boxes = root;
 }
 
 int spr_uncore_pci_init(void)
-- 
2.35.1


