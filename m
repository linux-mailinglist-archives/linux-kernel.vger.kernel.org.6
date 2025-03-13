Return-Path: <linux-kernel+bounces-559555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD7EA5F577
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004C87AE2CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32E26770E;
	Thu, 13 Mar 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebAhNtxo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD26261396
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871324; cv=none; b=sTQsVfu5LVAp3lVSAyHV+jNq3H9Tjhd8JhtmKqGqw8rq/ndZi2gel85+8np61f/vzvz8OUEeSOvUQCvmXjTnuzUxOr9cLK2T4yjM3iRcTnKNPElpcXxEeAxoQDWgn93MW7Nht2qgMNj3eUSbLuZQWxJF8aZpeOSHnAhgOEE2j4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871324; c=relaxed/simple;
	bh=4sgJP4yokk61l7eFyLchQfJsl+tBmG20NMrzh6DyHL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfRR3S0I3AbTyJOnMTWo9HC3x/xDhOANI4c4IjQVYidLvkNX00fxAXdRcmT45C2OdgzdifOAB31ib0E66WafZWVwF1w43iHFenl5RD5Y45nStu2JU14qz8w7pTPGhy551ERj8AnOHlsaMERXqyrQeHQk3b225ZYYwbUN29pG5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebAhNtxo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741871323; x=1773407323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4sgJP4yokk61l7eFyLchQfJsl+tBmG20NMrzh6DyHL8=;
  b=ebAhNtxoMeSKMIUh5q50PAg1xEWdVdIWUtWHI0mktiTnfuOsLG/zV/xS
   DL/r90JFZjFpJalcpCqbBX0WTwyKzXxdxEHa0VcQX0XgI0b4H5GaFHKet
   zYMvlX89pD88aME9QmprbSzaE6CJ3hZIlJFnbgDUuhGY2hVaVw3zUvHpJ
   XrF32eCALA2ii9iu0FNnXGPhtPxS4JyiGP+oCMnbgIj4af1/sDinGQ+gY
   ytdR905777MwK6g3yExLGYPlopWXtwJSb3X/3f9s7Acr9ILf9xanCAqWs
   gGR/xA912aTXVzkqfPEmwwppTPLYxKGnz6SkDW3fRBV9YyoSjWduL1beb
   A==;
X-CSE-ConnectionGUID: T53y1RAyQYqnev5/ftBWMg==
X-CSE-MsgGUID: cUPhXTzGSh2qyLlz3ieZPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53191633"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53191633"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:08:41 -0700
X-CSE-ConnectionGUID: pxnZjseOTzaPeHUiD4NXpQ==
X-CSE-MsgGUID: K2DFXMhZQji/adqEfvfI5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126011491"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 06:08:41 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/4] perf/x86/intel/uncore: Support MSR portal for discovery tables
Date: Thu, 13 Mar 2025 06:08:44 -0700
Message-Id: <20250313130847.4081079-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Starting from the Panther Lake, the discovery table mechanism is also
supported in client platforms. The difference is that the portal of the
global discovery table is retrieved from an MSR.

The layout of discovery tables are the same as the server platforms.
Factor out __parse_discovery_table() to parse discover tables.

The uncore PMON is Die scope. Need to parse the discovery tables for
each die.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 arch/x86/events/intel/uncore_discovery.c | 87 ++++++++++++++++++------
 arch/x86/events/intel/uncore_discovery.h |  3 +
 2 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 251e1f8fabb1..8dc9b712dafb 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -273,32 +273,15 @@ uncore_ignore_unit(struct uncore_unit_discovery *unit, int *ignore)
 	return false;
 }
 
-static int parse_discovery_table(struct pci_dev *dev, int die,
-				 u32 bar_offset, bool *parsed,
-				 int *ignore)
+static int __parse_discovery_table(resource_size_t addr, int die,
+				   bool *parsed, int *ignore)
 {
 	struct uncore_global_discovery global;
 	struct uncore_unit_discovery unit;
 	void __iomem *io_addr;
-	resource_size_t addr;
 	unsigned long size;
-	u32 val;
 	int i;
 
-	pci_read_config_dword(dev, bar_offset, &val);
-
-	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
-		return -EINVAL;
-
-	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
-#ifdef CONFIG_PHYS_ADDR_T_64BIT
-	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		u32 val2;
-
-		pci_read_config_dword(dev, bar_offset + 4, &val2);
-		addr |= ((resource_size_t)val2) << 32;
-	}
-#endif
 	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
 	io_addr = ioremap(addr, size);
 	if (!io_addr)
@@ -346,7 +329,32 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	return 0;
 }
 
-bool intel_uncore_has_discovery_tables(int *ignore)
+static int parse_discovery_table(struct pci_dev *dev, int die,
+				 u32 bar_offset, bool *parsed,
+				 int *ignore)
+{
+	resource_size_t addr;
+	u32 val;
+
+	pci_read_config_dword(dev, bar_offset, &val);
+
+	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
+		return -EINVAL;
+
+	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		u32 val2;
+
+		pci_read_config_dword(dev, bar_offset + 4, &val2);
+		addr |= ((resource_size_t)val2) << 32;
+	}
+#endif
+
+	return __parse_discovery_table(addr, die, parsed, ignore);
+}
+
+static bool intel_uncore_has_discovery_tables_pci(int *ignore)
 {
 	u32 device, val, entry_id, bar_offset;
 	int die, dvsec = 0, ret = true;
@@ -395,6 +403,45 @@ bool intel_uncore_has_discovery_tables(int *ignore)
 	return ret;
 }
 
+static bool intel_uncore_has_discovery_tables_msr(int *ignore)
+{
+	unsigned long *die_mask;
+	bool parsed = false;
+	int cpu, die;
+	u64 base;
+
+	die_mask = kcalloc(BITS_TO_LONGS(__uncore_max_dies),
+			   sizeof(unsigned long), GFP_KERNEL);
+	if (!die_mask)
+		return false;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		die = topology_logical_die_id(cpu);
+		if (__test_and_set_bit(die, die_mask))
+			continue;
+
+		if (rdmsrl_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
+			continue;
+
+		if (!base)
+			continue;
+
+		__parse_discovery_table(base, die, &parsed, ignore);
+	}
+
+	cpus_read_unlock();
+
+	kfree(die_mask);
+	return parsed;
+}
+
+bool intel_uncore_has_discovery_tables(int *ignore)
+{
+	return intel_uncore_has_discovery_tables_msr(ignore) ||
+	       intel_uncore_has_discovery_tables_pci(ignore);
+}
+
 void intel_uncore_clear_discovery_tables(void)
 {
 	struct intel_uncore_discovery_type *type, *next;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 0e94aa7db8e7..690f737e6837 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+/* Store the full address of the global discovery table */
+#define UNCORE_DISCOVERY_MSR			0x201e
+
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
 /* Capability ID for a discovery table device */
-- 
2.38.1


