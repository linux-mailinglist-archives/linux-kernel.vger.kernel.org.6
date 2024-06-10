Return-Path: <linux-kernel+bounces-208848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149699029DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D026B24F41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE314BF89;
	Mon, 10 Jun 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZ9u9jjO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35D47A60
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050675; cv=none; b=tNwQsCOHxAf9fWMifC5mUZwiSOPkR3w+IgMzaBh46bk338KHrGi0/SeoASApCudFVdt1FNGZmbNE2O57U/cCLdswbNxk0P0VdubLejzqSnfYMGo+dGmbaBUVpugUn1xEOIUqKD5fncrEGYtVF8RHAeYX4f4JqcGNyGoO56QsaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050675; c=relaxed/simple;
	bh=BIopyuEiippERL55Q+YUB/F51kO/pgwegBOMEDJyk+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EE1RyI5dyQbgwvSJJv9EXSzIN7Do2gHgK/vIIiuNCAcvR9OpFoMhULkuLz1eOuQ8lTM8n77tgNZy/LJRHpeu6lo7Ajfbj9m/KMDnFqHlNaDSwKPQ1kyvjWLN9GFYuUsXwLALwdfmDQutAhVKeVZNp1ChCghZRLuQm02bV8Xn7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZ9u9jjO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050674; x=1749586674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BIopyuEiippERL55Q+YUB/F51kO/pgwegBOMEDJyk+c=;
  b=GZ9u9jjOzVe9XgLzFDXubD/bP6vCea26YM8DMffKMhfDFN05p0oXEafP
   0GRjLhdoDK91AJndUCN4Lpngi0DVSSuOnns5wH/B62ctYY0kw9K1FEtt0
   yjICeR3dnNl7wQJo0ccgLLtA+4Ee4QCUQzEYj9I10IBpm2/Esm48U/+Q1
   KFdh5dFI/iINanO0S0mJG+HnraudD/w0CQ296AEk4Z5Tuum8Iavm5WiOL
   70hPPMo/GcbgZY7qQ1h+0KfFvU/ss6K0oT3ifq3Toe81CSFEjJVW1F2D5
   i7x/iWGgSc9n3TvFMwNPAQKI6+R66hop0NmDzzCSRaHn2ofquph1kH8ja
   w==;
X-CSE-ConnectionGUID: kK3a4F5uRwCw0I9GUe20QQ==
X-CSE-MsgGUID: 7HIEHBmNTkagmHcGumpB8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18561523"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18561523"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:17:51 -0700
X-CSE-ConnectionGUID: TqqqL0ceQMyY8ogtSS/V0A==
X-CSE-MsgGUID: O7AfG8x/QO69ZUyklXx/ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39169090"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2024 13:17:50 -0700
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
Subject: [PATCH 4/8] perf/x86/uncore: Apply the unit control RB tree to MMIO uncore units
Date: Mon, 10 Jun 2024 13:16:15 -0700
Message-Id: <20240610201619.884021-5-kan.liang@linux.intel.com>
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
for all the units. Use it to replace the box_ctls/mmio_offsets to get
an accurate unit control address for MMIO uncore units.

Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 30 +++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index e61e460520a8..ece761c9f17a 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -606,34 +606,30 @@ static struct intel_uncore_ops generic_uncore_pci_ops = {
 
 #define UNCORE_GENERIC_MMIO_SIZE		0x4000
 
-static u64 generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
-{
-	struct intel_uncore_type *type = box->pmu->type;
-
-	if (!type->box_ctls || !type->box_ctls[box->dieid] || !type->mmio_offsets)
-		return 0;
-
-	return type->box_ctls[box->dieid] + type->mmio_offsets[box->pmu->pmu_idx];
-}
-
 void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
-	u64 box_ctl = generic_uncore_mmio_box_ctl(box);
+	static struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type = box->pmu->type;
 	resource_size_t addr;
 
-	if (!box_ctl) {
+	unit = intel_uncore_find_discovery_unit(type->boxes, box->dieid, box->pmu->pmu_idx);
+	if (!unit) {
+		pr_warn("Uncore type %d id %d: Cannot find box control address.\n",
+			type->type_id, box->pmu->pmu_idx);
+		return;
+	}
+
+	if (!unit->addr) {
 		pr_warn("Uncore type %d box %d: Invalid box control address.\n",
-			type->type_id, type->box_ids[box->pmu->pmu_idx]);
+			type->type_id, unit->id);
 		return;
 	}
 
-	addr = box_ctl;
+	addr = unit->addr;
 	box->io_addr = ioremap(addr, UNCORE_GENERIC_MMIO_SIZE);
 	if (!box->io_addr) {
 		pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.\n",
-			type->type_id, type->box_ids[box->pmu->pmu_idx],
-			(unsigned long long)addr);
+			type->type_id, unit->id, (unsigned long long)addr);
 		return;
 	}
 
@@ -722,6 +718,8 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 		uncore->box_ctls = type->box_ctrl_die;
 		uncore->mmio_offsets = type->box_offset;
 		uncore->mmio_map_size = UNCORE_GENERIC_MMIO_SIZE;
+		uncore->boxes = &type->units;
+		uncore->num_boxes = type->num_units;
 		break;
 	default:
 		return false;
-- 
2.35.1


