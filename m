Return-Path: <linux-kernel+bounces-214957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D87908CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC101F2276A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E35BA37;
	Fri, 14 Jun 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp8oSRDD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C16919D896
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372873; cv=none; b=ngom3A1O90Eb5NoTCgQr8OVl9vvyRluyPbUQOYnxiTTBZuItJs2uogLZELwSzFlEUfXtM7mQgJdLv0VP4Fb9VtqvbY51GjqG2RMBLr4xsW1THd2aKSBbX8saa9eRRnGHA1aD4vTrnNhPeEtg2siuqm7Sa5Vv5xpK43MDQdq0Bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372873; c=relaxed/simple;
	bh=dSRu79zPsFMjSz7soAdAwuKfJ58eR3YhLRJFc8yq9m4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fkZ7UsdHICVXKDJ9Me5D4m9VwjXWHKLcg+95z0a8m/oyPRrg6zCapLrY4dcPvJ/bYZuCPtAVuIvsy4UMqRoksyKjFi1/ipoJvJUCmZKqSIdW929xHMv3XWWheysH5UWWWkan1QiUG8ZVbEZpToHFVZJybHdzzfJIua0KYVb2XxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp8oSRDD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372872; x=1749908872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dSRu79zPsFMjSz7soAdAwuKfJ58eR3YhLRJFc8yq9m4=;
  b=Vp8oSRDDjHaUNrUUuMJkj7Ng/5hP+pq0kgxNjpcxRajrLk9EExizmSyD
   0eSfv+qAyR7oh35sqNENm9oQlTZ8oxqYsTWQ0ba28SwA2O/pnHZl042Fo
   OmZENZWjKPCXkbIz9IO5ofbIEECYHbuVbnF0ic4Z2h7gsqkOk6YTnhopI
   gyALBTVTj0cZJtUAMTecilCA50BnY6q/vp2k5mTzDuHO3z/NgEEN1+NHt
   nyurxttyelgzzJfTgUEHOI20inKIliXplitySqV6oxiRSWWFA5y7N21zg
   W1t8BuAqIsUhopcNWiUmjTxWO6QmpX24BRiXDI3SMmCVwr01gY46hpsDk
   A==;
X-CSE-ConnectionGUID: ltnUYSnZR1W6iqGD/7LBng==
X-CSE-MsgGUID: bcxGcsGUSg+hEUgfgAvGjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19079147"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19079147"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:47:51 -0700
X-CSE-ConnectionGUID: bwb/n8h4Svy/LrE+iGQ9cQ==
X-CSE-MsgGUID: Xi9mFQNDToeOD2LNcGvQTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40386664"
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
Subject: [PATCH V2 1/8] perf/x86/uncore: Save the unit control address of all units
Date: Fri, 14 Jun 2024 06:46:24 -0700
Message-Id: <20240614134631.1092359-2-kan.liang@linux.intel.com>
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

The unit control address of some CXL units may be wrongly calculated
under some configuration on a EMR machine.

The current implementation only saves the unit control address of the
units from the first die, and the first unit of the rest of dies. Perf
assumed that the units from the other dies have the same offset as the
first die. So the unit control address of the rest of the units can be
calculated. However, the assumption is wrong, especially for the CXL
units.

Introduce an RB tree for each uncore type to save the unit control
address and three kinds of ID information (unit ID, PMU ID, and die ID)
for all units.
The unit ID is a physical ID of a unit.
The PMU ID is a logical ID assigned to a unit. The logical IDs start
from 0 and must be contiguous. The physical ID and the logical ID are
1:1 mapping. The units with the same physical ID in different dies share
the same PMU.
The die ID indicates which die a unit belongs to.

The RB tree can be searched by two different keys (unit ID or PMU ID +
die ID). During the RB tree setup, the unit ID is used as a key to look
up the RB tree. The perf can create/assign a proper PMU ID to the unit.
Later, after the RB tree is setup, PMU ID + die ID is used as a key to
look up the RB tree to fill the cpumask of a PMU. It's used more
frequently, so PMU ID + die ID is compared in the unit_less().
The uncore_find_unit() has to be O(N). But the RB tree setup only occurs
once during the driver load time. It should be acceptable.

Compared with the current implementation, more space is required to save
the information of all units. The extra size should be acceptable.
For example, on EMR, there are 221 units at most. For a 2-socket machine,
the extra space is ~6KB at most.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 79 +++++++++++++++++++++++-
 arch/x86/events/intel/uncore_discovery.h | 10 +++
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 9a698a92962a..ce520e69a3c1 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -93,6 +93,8 @@ add_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	if (!type->box_ctrl_die)
 		goto free_type;
 
+	type->units = RB_ROOT;
+
 	type->access_type = unit->access_type;
 	num_discovered_types[type->access_type]++;
 	type->type = unit->box_type;
@@ -120,10 +122,59 @@ get_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	return add_uncore_discovery_type(unit);
 }
 
+static inline bool unit_less(struct rb_node *a, const struct rb_node *b)
+{
+	struct intel_uncore_discovery_unit *a_node, *b_node;
+
+	a_node = rb_entry(a, struct intel_uncore_discovery_unit, node);
+	b_node = rb_entry(b, struct intel_uncore_discovery_unit, node);
+
+	if (a_node->pmu_idx < b_node->pmu_idx)
+		return true;
+	if (a_node->pmu_idx > b_node->pmu_idx)
+		return false;
+
+	if (a_node->die < b_node->die)
+		return true;
+	if (a_node->die > b_node->die)
+		return false;
+
+	return 0;
+}
+
+static inline struct intel_uncore_discovery_unit *
+uncore_find_unit(struct rb_root *root, unsigned int id)
+{
+	struct intel_uncore_discovery_unit *unit;
+	struct rb_node *node;
+
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
+		if (unit->id == id)
+			return unit;
+	}
+
+	return NULL;
+}
+
+static void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
+				 struct rb_root *root, u16 *num_units)
+{
+	struct intel_uncore_discovery_unit *unit = uncore_find_unit(root, node->id);
+
+	if (unit)
+		node->pmu_idx = unit->pmu_idx;
+	else if (num_units)
+		node->pmu_idx = (*num_units)++;
+
+	rb_add(&node->node, root, unit_less);
+}
+
 static void
 uncore_insert_box_info(struct uncore_unit_discovery *unit,
 		       int die, bool parsed)
 {
+	struct intel_uncore_discovery_unit *node;
 	struct intel_uncore_discovery_type *type;
 	unsigned int *ids;
 	u64 *box_offset;
@@ -136,14 +187,26 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 		return;
 	}
 
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return;
+
+	node->die = die;
+	node->id = unit->box_id;
+	node->addr = unit->ctl;
+
 	if (parsed) {
 		type = search_uncore_discovery_type(unit->box_type);
 		if (!type) {
 			pr_info("A spurious uncore type %d is detected, "
 				"Disable the uncore type.\n",
 				unit->box_type);
+			kfree(node);
 			return;
 		}
+
+		uncore_find_add_unit(node, &type->units, &type->num_units);
+
 		/* Store the first box of each die */
 		if (!type->box_ctrl_die[die])
 			type->box_ctrl_die[die] = unit->ctl;
@@ -152,16 +215,18 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 
 	type = get_uncore_discovery_type(unit);
 	if (!type)
-		return;
+		goto free_node;
 
 	box_offset = kcalloc(type->num_boxes + 1, sizeof(u64), GFP_KERNEL);
 	if (!box_offset)
-		return;
+		goto free_node;
 
 	ids = kcalloc(type->num_boxes + 1, sizeof(unsigned int), GFP_KERNEL);
 	if (!ids)
 		goto free_box_offset;
 
+	uncore_find_add_unit(node, &type->units, &type->num_units);
+
 	/* Store generic information for the first box */
 	if (!type->num_boxes) {
 		type->box_ctrl = unit->ctl;
@@ -201,6 +266,8 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 free_box_offset:
 	kfree(box_offset);
 
+free_node:
+	kfree(node);
 }
 
 static bool
@@ -339,8 +406,16 @@ bool intel_uncore_has_discovery_tables(int *ignore)
 void intel_uncore_clear_discovery_tables(void)
 {
 	struct intel_uncore_discovery_type *type, *next;
+	struct intel_uncore_discovery_unit *pos;
+	struct rb_node *node;
 
 	rbtree_postorder_for_each_entry_safe(type, next, &discovery_tables, node) {
+		while (!RB_EMPTY_ROOT(&type->units)) {
+			node = rb_first(&type->units);
+			pos = rb_entry(node, struct intel_uncore_discovery_unit, node);
+			rb_erase(node, &type->units);
+			kfree(pos);
+		}
 		kfree(type->box_ctrl_die);
 		kfree(type);
 	}
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 22e769a81103..5190017aba51 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -113,17 +113,27 @@ struct uncore_unit_discovery {
 	};
 };
 
+struct intel_uncore_discovery_unit {
+	struct rb_node	node;
+	unsigned int	pmu_idx;	/* The idx of the corresponding PMU */
+	unsigned int	id;		/* Unit ID */
+	unsigned int	die;		/* Die ID */
+	u64		addr;		/* Unit Control Address */
+};
+
 struct intel_uncore_discovery_type {
 	struct rb_node	node;
 	enum uncore_access_type	access_type;
 	u64		box_ctrl;	/* Unit ctrl addr of the first box */
 	u64		*box_ctrl_die;	/* Unit ctrl addr of the first box of each die */
+	struct rb_root	units;		/* Unit ctrl addr for all units */
 	u16		type;		/* Type ID of the uncore block */
 	u8		num_counters;
 	u8		counter_width;
 	u8		ctl_offset;	/* Counter Control 0 offset */
 	u8		ctr_offset;	/* Counter 0 offset */
 	u16		num_boxes;	/* number of boxes for the uncore block */
+	u16		num_units;	/* number of units */
 	unsigned int	*ids;		/* Box IDs */
 	u64		*box_offset;	/* Box offset */
 };
-- 
2.35.1


