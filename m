Return-Path: <linux-kernel+bounces-214960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16490908CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0693B25947
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D36410A01;
	Fri, 14 Jun 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYvNKa24"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18D8BFC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372875; cv=none; b=gP2hijv4cgkgY0Nc++HQo0Ubp5uZY8tX0CZCM3tOwSYpJiDknYyUy7yb81JhR2wpOp9u3esmtxJ4d++ViFKjb+WOgvCvS5QfwiklaBLQdyFI4aktkgLKObd/YQfGic4GsSjBh+wCcJum7t38zfjbD0ZI2vBmCq7s9mtlR78/s0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372875; c=relaxed/simple;
	bh=BIopyuEiippERL55Q+YUB/F51kO/pgwegBOMEDJyk+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4sXIp50RiIiBrIhTZYm6jrQMzFqyPpThJcI94Uz3YjaZNL4XgioPQNjEhOMNwS7hjVMCAx4iKDAh0TLJLWRZVAG0OEFK7Isy1K8SecMaeBCd7a88ZW4evX3QT7VOMUl2bYS8KmU+C1rjThwk6cH5Nl+aLmLEX8grwOVa9Htn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYvNKa24; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372874; x=1749908874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BIopyuEiippERL55Q+YUB/F51kO/pgwegBOMEDJyk+c=;
  b=IYvNKa24ih2XYg/NvWL3vRHHEYE67VMhKkUdQQQgUa+XGFaPz3juMXsX
   hGHlB4aYvToN3I/es1crS1v4KePB+1D3B50IR7FvHBb8fNy7Hx0rgm12T
   5TVGvuyx5Ts7WytqDLZLFt6on/nu5e6jCtogmptdfVQB31KdlEoSvNBzp
   d79RnFbI0yuoPi/iHUk6nT2DheRC7Gk0n6uKrZ/veNJ8pjhFK5bo/jxyi
   LmPsNIHKh2xL3PlTbCDesii9kU+JZFp9SlTldaGoyEknpzQv7XMzl5/hi
   ddPIDKDajd+q+NUB1yIzzzmMBdyufBbD40CKDXoAmfrDzlxcIydbNtuwo
   w==;
X-CSE-ConnectionGUID: 23kuTPzTQnm4l3XBnXnJqw==
X-CSE-MsgGUID: nfQ1/hZERGemJowzV9aNBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19079159"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19079159"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:47:52 -0700
X-CSE-ConnectionGUID: XFRdpkM5T7GaMvL8/YssQw==
X-CSE-MsgGUID: iqvbjXGqR/+0gaqbkB8YfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40386674"
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
Subject: [PATCH V2 4/8] perf/x86/uncore: Apply the unit control RB tree to MMIO uncore units
Date: Fri, 14 Jun 2024 06:46:27 -0700
Message-Id: <20240614134631.1092359-5-kan.liang@linux.intel.com>
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


