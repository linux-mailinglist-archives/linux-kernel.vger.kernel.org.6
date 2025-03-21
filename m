Return-Path: <linux-kernel+bounces-572082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019EBA6C654
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028E31B611A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0B2356A4;
	Fri, 21 Mar 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOH9ZsS9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED9233D86
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742598988; cv=none; b=tjv3vlCnvqJndoFqBtEZeom/RPdCjVfT8hKStVfxwNBiXDLnqy2193wfAfLkj/Ti3Yk7hKO93H2Ck6fBt/+MGk4KBUiVwBgi0Ngny/cW6f0ayxdu2EsgWBEd29KrMEbWL8mBJLKxl62zetlFaYyxGjPjRpEFJQD/aHIvYbXdknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742598988; c=relaxed/simple;
	bh=EelZRvoSNl3GeFDTwR9XrsX4puLt4kUGCZtESpc/1Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8UPao7Xbu2A7Er1hkTu9seUuK2/ToomXGlfIGqOH8Wsg7X7zY7pa9BZneSV0+0jJgWxrms6mdtQ55qkKTSClj+MMz2gGQ58nEhXVErzaQ/WUZzYCrnKp/uDPt/F9McAS8K8FkqlsrPZAf92V+iotmHi5H6u6K0yKYoB3n/iNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOH9ZsS9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742598987; x=1774134987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EelZRvoSNl3GeFDTwR9XrsX4puLt4kUGCZtESpc/1Zw=;
  b=WOH9ZsS9GYOdZwuj7oSJ0T6L3M4PiS9NRx5wNK1R3reZ922yN2HpnQTj
   ybwpEuBxlhngp8p6eTY89tv1nH6OJdaYKw3UX78MNKQhlBOYJGnG2Elis
   QY8+Uf9zdoyN1HJZH9Qsj8+HKkTl0JfG5GSDXdqF3rQOOacVFoOGDbJ6U
   Qy+o5B7bK92A1UDsanE21LP11b3rLX7H7Y9ccni4p7qNrHUyYZHl3aFS6
   7+zru623AFJLGGqqSSyBSOcHJpFgHHuAKHv+8vh7hma/v+CELlWhrJcEH
   B6Efg9tx9UOH9T3SmX3n3ROs4v/V726WTkFF5TfwRUTycLCnNmiQ913Gu
   A==;
X-CSE-ConnectionGUID: qjw1EKbuRIy7rf2H2lZDxA==
X-CSE-MsgGUID: M35qyD8NRiWimTZ6iVtG6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43604603"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="43604603"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:22 -0700
X-CSE-ConnectionGUID: VNVNbhtLTh6z9ePbxiQRzg==
X-CSE-MsgGUID: fQOcj1/pSvaITgqDnDlzXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="128354315"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:22 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 09/16] x86/resctrl: Add detailed descriptions for Clearwater Forest events
Date: Fri, 21 Mar 2025 16:15:59 -0700
Message-ID: <20250321231609.57418-10-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321231609.57418-1-tony.luck@intel.com>
References: <20250321231609.57418-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two event groups one for energy reporting and another
for "perf" events.

See the XML description files in https://github.com/intel/Intel-PMT
in the xml/CWF/OOBMSM/{RMID-ENERGY,RMID-PERF}/ for the detailed
descriptions that were used to derive these descriptions.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 9a8ccb62b4ab..67862e81b9e0 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -94,8 +94,62 @@ struct telem_entry {
 	struct pmt_event evts[];
 };
 
+/*
+ * Known events from Intel Clearwater Forest CPU.
+ */
+#define CWF_NUM_RMIDS	576
+#define CWF_ENERGY_GUID	0x26696143
+#define CWF_PERF_GUID	0x26557651
+#define	CWF_ENERGY_STRIDE	0x10
+#define CWF_PERF_STRIDE	0x38
+
+/*
+ * https://github.com/intel/Intel-PMT
+ * xml/CWF/OOBMSM/RMID-ENERGY *.xml
+ */
+static struct telem_entry cwf_energy = {
+	.name				= "energy",
+	.guid				= CWF_ENERGY_GUID,
+	.num_rmids			= CWF_NUM_RMIDS,
+	.stride				= CWF_ENERGY_STRIDE,
+	.overflow_counter_off		= CWF_NUM_RMIDS * CWF_ENERGY_STRIDE,
+	.last_overflow_tstamp_off	= CWF_NUM_RMIDS * CWF_ENERGY_STRIDE + 8,
+	.last_update_tstamp_off		= CWF_NUM_RMIDS * CWF_ENERGY_STRIDE + 16,
+	.evts				= {
+		EVT(PMT_EVENT_ENERGY, "core_energy", 0x0, EVT_U46_18),
+		EVT(PMT_EVENT_ACTIVITY, "activity", 0x8, EVT_U46_18),
+		{ }
+	}
+};
+
+/*
+ * https://github.com/intel/Intel-PMT
+ * xml/CWF/OOBMSM/RMID-PERF *.xml
+ */
+static struct telem_entry cwf_perf = {
+	.name				= "perf",
+	.guid				= CWF_PERF_GUID,
+	.num_rmids			= CWF_NUM_RMIDS,
+	.stride				= CWF_PERF_STRIDE,
+	.overflow_counter_off		= CWF_NUM_RMIDS * CWF_PERF_STRIDE,
+	.last_overflow_tstamp_off	= CWF_NUM_RMIDS * CWF_PERF_STRIDE + 8,
+	.last_update_tstamp_off		= CWF_NUM_RMIDS * CWF_PERF_STRIDE + 16,
+	.evts				= {
+		EVT(PMT_EVENT_STALLS_LLC_HIT, "stalls_llc_hit", 0x0, EVT_U64),
+		EVT(PMT_EVENT_C1_RES, "c1_res", 0x8, EVT_U64),
+		EVT(PMT_EVENT_UNHALTED_CORE_CYCLES, "unhalted_core_cycles", 0x10, EVT_U64),
+		EVT(PMT_EVENT_STALLS_LLC_MISS, "stalls_llc_miss", 0x18, EVT_U64),
+		EVT(PMT_EVENT_AUTO_C6_RES, "c6_res", 0x20, EVT_U64),
+		EVT(PMT_EVENT_UNHALTED_REF_CYCLES, "unhalted_ref_cycles", 0x28, EVT_U64),
+		EVT(PMT_EVENT_UOPS_RETIRED, "uops_retired", 0x30, EVT_U64),
+		{ }
+	}
+};
+
 /* All known telemetry event groups */
 static struct telem_entry *telem_entry[] = {
+	&cwf_energy,
+	&cwf_perf,
 	NULL
 };
 
-- 
2.48.1


