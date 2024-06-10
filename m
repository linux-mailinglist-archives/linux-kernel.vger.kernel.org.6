Return-Path: <linux-kernel+bounces-208846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5384C9029D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B661C233E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9A50275;
	Mon, 10 Jun 2024 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciL0f0J0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F11D52B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050673; cv=none; b=ZbWCbwTGNKdHaE5TwB6/GoiU4Velr5pIh5UC20ArvENLLb9GxZFWEQXbpn0PNrZcVENLcYDk7tl0I5G+4FM0M7OPRhoNTXYFuR3O5osQhEkGVujS+8vAUismPHhhZnBaV2ZOiFWrDuOPWc6NliuT+lE92NYZ+N+cByFgvxb6wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050673; c=relaxed/simple;
	bh=C6xjqndLj+e6gtlt2Yma5/jqWpSt+rn44YD5av9k7EY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VffPrYiQ09aO4JXoLqTFTTUSs/sk4zH437EXA/XWqt3lJNH/F+euDQgeVigCQr1etCZnfZzkgHlNomt8AZgx0kNVI4txUdh9aOjww0fAhZYMoRHfhd1AsT2k0fFDvDhLKK1VLk8ERGKwtKj3E25JXeI8Bo6ldSYjMsCxJetG75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciL0f0J0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050672; x=1749586672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C6xjqndLj+e6gtlt2Yma5/jqWpSt+rn44YD5av9k7EY=;
  b=ciL0f0J0UwxnE6yETa5ihSmuRgK5v+IM13xw48KWAhR1bWc31f0eEBvq
   w/dIEHrz6MN/M3xR3IwMQ86D/XIqO9q5lsgStKf6h/l9yyQsjETkD9dca
   H74V6zakmwP4s5H50Y0kd+NWT/ol/WtQOApC5LrsXWbtO+LbeeasiRhgo
   MOMiEewrjORJM6DkA3q8ZzMAMd0mgFyhEpMii9MB8traYxTcN9giOyKse
   Gmgw3fWzu36oPRnoOs+HHTMlLZ2Lv3QchR9FaHDRtW8f2DAatm6a8EBK9
   Xwrq8F23UTFe3Q9ZiwrbJegMWt1iPomYb4n4NcXJYk4mYlbIzONpXVVQq
   w==;
X-CSE-ConnectionGUID: xUAPqmmGQ2S6FXnul4zptQ==
X-CSE-MsgGUID: Otm0Ef7ASSaz96y8p+PrUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18561506"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18561506"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:17:50 -0700
X-CSE-ConnectionGUID: lCiUkvYxSnW/lCQJ5ejdZQ==
X-CSE-MsgGUID: 3DxEDLoGR/y3lbvzfsuF7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39169074"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2024 13:17:49 -0700
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
Subject: [PATCH 1/8] perf/x86/uncore: Save the unit control address of all units
Date: Mon, 10 Jun 2024 13:16:12 -0700
Message-Id: <20240610201619.884021-2-kan.liang@linux.intel.com>
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

The unit control address of some CXL units may be wrongly calculated
under some configuration on a EMR machine.

The current implementation only saves the unit control address of the
units from the first die, and the first unit of the rest of dies. Perf
assumed that the units from the other dies have the same offset as the
first die. So the unit control address of the rest of the units can be
calculated. However, the assumption is wrong, especially for the CXL
units.

Introduce an RB tree for each uncore type to save the unit control
address and ID information for all the units.

Compared with the current implementation, more space is required to save
the information of all units. The extra size should be acceptable.
For example, on EMR, there are 221 units at most. For a 2-socket machine,
the extra space is ~6KB at most.

Tested-by: Yunying Sun <yunying.sun@intel.com>
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


