Return-Path: <linux-kernel+bounces-190729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D65D8D01CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C365B1F24CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465016C694;
	Mon, 27 May 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqhgzWN0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8216C68D;
	Mon, 27 May 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816862; cv=none; b=tGftflWJzBZ9POjaTtdFCdWm/Z3FJqB+L0mnXDVaSA0sXJ/fnHOBzF5iqa/ZL1BquwtLz130yagKVU10MPgkXCY3xeTaQMppJLTJePQ99t5z9zAtvdwkZmqcT40bEa2qZSXrFcZQJX2tvf9TVMfvbq9cRhR+uQFRqFlJa3aFI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816862; c=relaxed/simple;
	bh=sh2VvgG56vb9vqBcIGMc7hPlriHew0qVWODi9xHc5dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXs2yH5EEWyWZlmtSnoKNqFw2sn2wCkHvJYVPFqWC0yfPJmypUKmW79yDgjfPiebRNe/cnnDMoU78B3KIu6xq4iTLscvNaF4aEKXSgHvJVR6IjM+6oEgY2WB+jcWYLEod/VtYZGeTSmygn0eXh+S2xUNjkZpOoEM0/CfmYQ3YOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqhgzWN0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816860; x=1748352860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sh2VvgG56vb9vqBcIGMc7hPlriHew0qVWODi9xHc5dA=;
  b=cqhgzWN095ugGYws/oSHbVxRxu/p/e7fCTry2miPxcVp1nA042Kv1C2m
   e8RfH8EVASN2NQNNNo3NJf4FwQKmqy97PwJhAYkC606Q+y46Dw3bf3o9+
   RJjUCIB5mr/3p1NCpLzQYwe70cdOhSatOedrg+JNNq970O13ofgnMlF97
   AqGLJnkLIM0Wk1WrNVtpYe+5TMqRA/y1Y6fpjWWa7S+57mSDs6IDQuUwZ
   45onRn7bKgfTo2KJzVtwlvIC7dK0ljEzN5NGD1ZyEKXSpOzLTdE7hmD7B
   4k8lwd+V1gcUPCPZNDsGSfVMgVyO7XSMQ7aG+oMnUAKcLCthwMUXxXYb6
   A==;
X-CSE-ConnectionGUID: LgDnlMqKTOi0nHXoOgnSVQ==
X-CSE-MsgGUID: Ci9fZpVISGWsPsyUSITvlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="11714377"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11714377"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:20 -0700
X-CSE-ConnectionGUID: SjmDAfFbTca7sZWXj5yxlg==
X-CSE-MsgGUID: w2dBxlCjQnyaQ8l0w0R5zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34847993"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.180])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:18 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/6] platform/x86/intel: TPMI domain id and CPU mapping
Date: Mon, 27 May 2024 16:29:35 +0300
Message-ID: <20240527133400.483634-4-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527133400.483634-1-tero.kristo@linux.intel.com>
References: <20240527133400.483634-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Each TPMI power domain includes a group of CPUs. Several power
management settings in this case applicable to a group of CPUs.
There can be several power domains in a CPU package. So, provide
interfaces for:
- Get power domain id for a Linux CPU
- Get mask of Linux CPUs in a power domain

Hardware Punit uses different CPU numbering, which is not based on
APIC (Advanced Programmable Interrupt Controller) CPU numbering.
The Linux CPU numbering is based on APIC CPU numbering. Some PM features
like Intel Speed Select, the CPU core mask provided by the hardware is
based on the Punit CPU numbering. To use the core mask, this mask
needs to be converted to a Linux CPUs mask. So, provide interfaces for:
- Convert to a Linux CPU number from a Punit CPU number
- Convert to a Punit CPU number from a Linux CPU number

On each CPU online, MSR 0x54 is used to read the mapping and stores in
a per cpu array. Create a hash for faster searching of a Linux CPU number
from a Punit CPU number.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
[tero.kristo: minor updates]
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/platform/x86/intel/Kconfig            |   4 +
 drivers/platform/x86/intel/Makefile           |   3 +
 .../platform/x86/intel/tpmi_power_domains.c   | 236 ++++++++++++++++++
 .../platform/x86/intel/tpmi_power_domains.h   |  19 ++
 4 files changed, 262 insertions(+)
 create mode 100644 drivers/platform/x86/intel/tpmi_power_domains.c
 create mode 100644 drivers/platform/x86/intel/tpmi_power_domains.h

diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index e9dc0c021029..e97a97355d5a 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -192,10 +192,14 @@ config INTEL_SMARTCONNECT
 	  This driver checks to determine whether the device has Intel Smart
 	  Connect enabled, and if so disables it.
 
+config INTEL_TPMI_POWER_DOMAINS
+	tristate
+
 config INTEL_TPMI
 	tristate "Intel Topology Aware Register and PM Capsule Interface (TPMI)"
 	depends on INTEL_VSEC
 	depends on X86_64
+	select INTEL_TPMI_POWER_DOMAINS
 	help
 	  The Intel Topology Aware Register and PM Capsule Interface (TPMI),
 	  provides enumerable MMIO interface for power management features.
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index c1d5fe05e3f3..10437e56027d 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -53,6 +53,9 @@ obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 intel_vsec_tpmi-y			:= tpmi.o
 obj-$(CONFIG_INTEL_TPMI)		+= intel_vsec_tpmi.o
 
+intel_tpmi_power_domains-y		:= tpmi_power_domains.o
+obj-$(CONFIG_INTEL_TPMI_POWER_DOMAINS)	+= intel_tpmi_power_domains.o
+
 # Intel Uncore drivers
 intel-rst-y				:= rst.o
 obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
new file mode 100644
index 000000000000..40f994814248
--- /dev/null
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mapping of TPMI power domains CPU mapping
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/hashtable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
+#include <linux/topology.h>
+#include <linux/types.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include <asm/msr.h>
+
+#include "tpmi_power_domains.h"
+
+#define MSR_PM_LOGICAL_ID       0x54
+
+/*
+ * Struct of MSR 0x54
+ * [15:11] PM_DOMAIN_ID
+ * [10:3] MODULE_ID (aka IDI_AGENT_ID)
+ * [2:0] LP_ID
+ * For Atom:
+ *   [2] Always 0
+ *   [1:0] core ID within module
+ * For Core
+ *   [2:1] Always 0
+ *   [0] thread ID
+ */
+
+#define LP_ID_MASK		GENMASK_ULL(2, 0)
+#define MODULE_ID_MASK		GENMASK_ULL(10, 3)
+#define PM_DOMAIN_ID_MASK	GENMASK_ULL(15, 11)
+
+/**
+ * struct tpmi_cpu_info - Mapping information for a CPU
+ * @hnode: Used to add mapping information to hash list
+ * @linux_cpu:	Linux CPU number
+ * @pkg_id: Package ID of this CPU
+ * @punit_thread_id: Punit thread id of this CPU
+ * @punit_core_id: Punit core id
+ * @punit_domain_id: Power domain id from Punit
+ *
+ * Structure to store mapping information for a Linux CPU
+ * to a Punit core, thread and power domain.
+ */
+struct tpmi_cpu_info {
+	struct hlist_node hnode;
+	int linux_cpu;
+	u8 pkg_id;
+	u8 punit_thread_id;
+	u8 punit_core_id;
+	u8 punit_domain_id;
+};
+
+static DEFINE_PER_CPU(struct tpmi_cpu_info, tpmi_cpu_info);
+
+/* The dynamically assigned cpu hotplug state to free later */
+static enum cpuhp_state tpmi_hp_state __read_mostly;
+
+#define MAX_POWER_DOMAINS	8
+
+static cpumask_t *tpmi_power_domain_mask;
+
+/* Lock to protect tpmi_power_domain_mask and tpmi_cpu_hash */
+static DEFINE_MUTEX(tpmi_lock);
+
+static const struct x86_cpu_id tpmi_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, tpmi_cpu_ids);
+
+static DECLARE_HASHTABLE(tpmi_cpu_hash, 8);
+
+static bool tpmi_domain_is_valid(struct tpmi_cpu_info *info)
+{
+	return info->pkg_id < topology_max_packages() &&
+		info->punit_domain_id < MAX_POWER_DOMAINS;
+}
+
+int tpmi_get_linux_cpu_number(int package_id, int domain_id, int punit_core_id)
+{
+	struct tpmi_cpu_info *info;
+	int ret = -EINVAL;
+
+	guard(mutex)(&tpmi_lock);
+	hash_for_each_possible(tpmi_cpu_hash, info, hnode, punit_core_id) {
+		if (info->punit_domain_id == domain_id && info->pkg_id == package_id) {
+			ret = info->linux_cpu;
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_linux_cpu_number, INTEL_TPMI_POWER_DOMAIN);
+
+int tpmi_get_punit_core_number(int cpu_no)
+{
+	if (cpu_no >= num_possible_cpus())
+		return -EINVAL;
+
+	return per_cpu(tpmi_cpu_info, cpu_no).punit_core_id;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_punit_core_number, INTEL_TPMI_POWER_DOMAIN);
+
+int tpmi_get_power_domain_id(int cpu_no)
+{
+	if (cpu_no >= num_possible_cpus())
+		return -EINVAL;
+
+	return per_cpu(tpmi_cpu_info, cpu_no).punit_domain_id;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_power_domain_id, INTEL_TPMI_POWER_DOMAIN);
+
+cpumask_t *tpmi_get_power_domain_mask(int cpu_no)
+{
+	struct tpmi_cpu_info *info;
+	cpumask_t *mask;
+	int index;
+
+	if (cpu_no >= num_possible_cpus())
+		return NULL;
+
+	info = &per_cpu(tpmi_cpu_info, cpu_no);
+	if (!tpmi_domain_is_valid(info))
+		return NULL;
+
+	index = info->pkg_id * MAX_POWER_DOMAINS + info->punit_domain_id;
+	guard(mutex)(&tpmi_lock);
+	mask = &tpmi_power_domain_mask[index];
+
+	return mask;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_power_domain_mask, INTEL_TPMI_POWER_DOMAIN);
+
+static int tpmi_get_logical_id(unsigned int cpu, struct tpmi_cpu_info *info)
+{
+	u64 data;
+	int ret;
+
+	ret = rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
+	if (ret)
+		return ret;
+
+	info->punit_domain_id = FIELD_GET(PM_DOMAIN_ID_MASK, data);
+	if (info->punit_domain_id >= MAX_POWER_DOMAINS)
+		return -EINVAL;
+
+	info->punit_thread_id = FIELD_GET(LP_ID_MASK, data);
+	info->punit_core_id = FIELD_GET(MODULE_ID_MASK, data);
+	info->pkg_id = topology_physical_package_id(cpu);
+	info->linux_cpu = cpu;
+
+	return 0;
+}
+
+static int tpmi_cpu_online(unsigned int cpu)
+{
+	struct tpmi_cpu_info *info = &per_cpu(tpmi_cpu_info, cpu);
+	int ret, index;
+
+	/* Don't fail CPU online for some bad mapping of CPUs */
+	ret = tpmi_get_logical_id(cpu, info);
+	if (ret)
+		return 0;
+
+	index = info->pkg_id * MAX_POWER_DOMAINS + info->punit_domain_id;
+
+	guard(mutex)(&tpmi_lock);
+	cpumask_set_cpu(cpu, &tpmi_power_domain_mask[index]);
+	hash_add(tpmi_cpu_hash, &info->hnode, info->punit_core_id);
+
+	return 0;
+}
+
+static int __init tpmi_init(void)
+{
+	const struct x86_cpu_id *id;
+	u64 data;
+	int ret;
+
+	id = x86_match_cpu(tpmi_cpu_ids);
+	if (!id)
+		return -ENODEV;
+
+	/* Check for MSR 0x54 presence */
+	ret = rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
+	if (ret)
+		return ret;
+
+	tpmi_power_domain_mask = kcalloc(size_mul(topology_max_packages(), MAX_POWER_DOMAINS),
+					 sizeof(*tpmi_power_domain_mask), GFP_KERNEL);
+	if (!tpmi_power_domain_mask)
+		return -ENOMEM;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"platform/x86/tpmi_power_domains:online",
+				tpmi_cpu_online, NULL);
+	if (ret < 0) {
+		kfree(tpmi_power_domain_mask);
+		return ret;
+	}
+
+	tpmi_hp_state = ret;
+
+	return 0;
+}
+module_init(tpmi_init)
+
+static void __exit tpmi_exit(void)
+{
+	cpuhp_remove_state(tpmi_hp_state);
+	kfree(tpmi_power_domain_mask);
+}
+module_exit(tpmi_exit)
+
+MODULE_DESCRIPTION("TPMI Power Domains Mapping");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/tpmi_power_domains.h b/drivers/platform/x86/intel/tpmi_power_domains.h
new file mode 100644
index 000000000000..0c2154bd941f
--- /dev/null
+++ b/drivers/platform/x86/intel/tpmi_power_domains.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mapping of TPMI power domain and CPUs
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ * All rights reserved.
+ */
+
+#ifndef _TPMI_POWER_DOMAINS_H_
+#define _TPMI_POWER_DOMAINS_H_
+
+#include <linux/cpumask.h>
+
+int tpmi_get_linux_cpu_number(int package_id, int die_id, int punit_core_id);
+int tpmi_get_punit_core_number(int cpu_no);
+int tpmi_get_power_domain_id(int cpu_no);
+cpumask_t *tpmi_get_power_domain_mask(int cpu_no);
+
+#endif
-- 
2.43.1


