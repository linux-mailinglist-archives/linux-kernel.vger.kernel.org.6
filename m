Return-Path: <linux-kernel+bounces-208850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93289029DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF71F23ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464314F9E0;
	Mon, 10 Jun 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPcaH5ZS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE04D9EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050675; cv=none; b=pDk73c6OsoymJV5wp6HM+qClDTSrbhADxBuJxi8wrTnGNQ4CRHuG2PsOFrNMu/cWWwHq7cQ1anWXjStPFZmheA/64HMMY0PP+9iwqwYyjGMzMwKhA3uFHoFrFT8CASbgVeJTlXlY7sxwy5/kTrUasUhatKKUMfqbGI5su0sjkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050675; c=relaxed/simple;
	bh=kLr54QFbf/02KbIzN+8gT4RlmHSZj0T4yj3bzu8+hYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruVv8Z5cLHarQKH6y68QCqIKz28udkJo62D05BPh7ZAFoH9gebN5nDz4KUbAtah8ZqzdZK9nQxcLoyabo2DVCs7xyFWmQCc+UlvaibM0HORkmHQVc19+ChPb4M7DhboUfjQfNxsWoQ16wBe+LMTKUNI/ZJ0VHFNWga7EXCIcFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPcaH5ZS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050674; x=1749586674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLr54QFbf/02KbIzN+8gT4RlmHSZj0T4yj3bzu8+hYQ=;
  b=nPcaH5ZSdvNJziepX4aGzplrsSOY1H68E4sViZYGB26Dek3q3V5qvXzd
   tPGm88fKBjBHZ3fL5CKkDiig41c8x5exjqpa659KUuHLxIc/WThUAIMnL
   e8ghDvkFk2U8egb70E+X2BYM5NgkOqz2m+GHRrhco4LBLKTcvxfUUqKfF
   3PHrp/1Jl4rvPliNJI4UdK0eepHbPc9jogjW9ldX6GVZQZV2IbFCpmA1l
   3RFOjuZFKx2QPEG96WohylNg7IsGoVKXT5/IUGQHfamZmArVE7fOH2XRz
   tE4CsP28omt5iwpD+kUd87jkFAXUKXn2Fm/HEliQ4/bo+XufJAm7kbBLG
   w==;
X-CSE-ConnectionGUID: uRVDsYuoQ1CtkXUYOpyoZA==
X-CSE-MsgGUID: HWzTxfZwTO+RTawVYhvqcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18561527"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18561527"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:17:51 -0700
X-CSE-ConnectionGUID: eN/u640+ToeRuuwkN9L3gQ==
X-CSE-MsgGUID: BrwsKLQqSS+ofUP6RTDigA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39169095"
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
Subject: [PATCH 5/8] perf/x86/uncore: Apply the unit control RB tree to MSR uncore units
Date: Mon, 10 Jun 2024 13:16:16 -0700
Message-Id: <20240610201619.884021-6-kan.liang@linux.intel.com>
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
index 27a0cda5cc91..bdb253a1bc3b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -264,6 +264,9 @@ static void uncore_assign_hw_event(struct intel_uncore_box *box,
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
index 74b8b21e8990..8b1cabff7ee3 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5933,10 +5933,11 @@ static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
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
@@ -6460,18 +6461,21 @@ uncore_find_type_by_id(struct intel_uncore_type **types, int type_id)
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


