Return-Path: <linux-kernel+bounces-190730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C68D01CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE65E293115
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F216C6B9;
	Mon, 27 May 2024 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoSzox7u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC694161935;
	Mon, 27 May 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816864; cv=none; b=Ol+tRCT5yM0II6j2PpTqc6q8oTbrqAriAzglk1xwf6J5jYdIDTln0VbSmWJFzT37p7qpxewnQeFK7NCuJSvWSQftImX1xH95RH6js7Qx7RpNFCmeb8cYHgWALEHu0SP0k2EZGoeLboi2Xii0YhOOSOPRqUGOsKuL0AVjsk8W2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816864; c=relaxed/simple;
	bh=7C1664IX3uxrPElOvmbt3RewRm+qMJNXNw2O5UgCkug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a++0gJsPTZ2ACCCognJCS7OPMPBbZ29MtYcqazvYqYulKiI/GLDlm/X26KtCY2+iZ9sxcQDR+ESoAlTb7UD/HG1pSfFxvnKGhZZceVz1JdHtY/3KS5cLRGe7pIoTINKQRG0tTUGCWIckgVJlcdOUY0o4E5t5ivPyFs//29DLm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoSzox7u; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816863; x=1748352863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7C1664IX3uxrPElOvmbt3RewRm+qMJNXNw2O5UgCkug=;
  b=CoSzox7uN8xMLfFpfHcBDGki1HIuB3wnTgrJcgHw2gEZfYWXhAmnAm76
   I5ZF6zRqtb29sK/QEDnZmzQ/EJiKUVvG1aA4rRZFikJ83FzZr5BrHoqQr
   gM5vOB4TeV57PTklERYHL8oYfh3tk9bkZDSZMpmef1idEJwrhMLnF+c1J
   6FvSYxnSF1NxNXAyV1+IzMgxV9gyXJiqg/yJpJlNI3UAKVV62rRKQbJSJ
   QKhpb6sRapQh8OEMDv7d0HicnXMDn8iOFF0Na3oAlp4IDherSBSE/2Tjx
   01gGk2LN4cGaWq5NeFSWq1SKSqfXMrWtyOOzG9mv4y4w/X2N4BrO6Bcin
   Q==;
X-CSE-ConnectionGUID: Ru49L/HlS0GZdarWXjQjiA==
X-CSE-MsgGUID: IlzAjJ7oT5OkgesqxqKrWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="11714380"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11714380"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:22 -0700
X-CSE-ConnectionGUID: sjmRjmxER6WYZ5eEgglCGA==
X-CSE-MsgGUID: YA4LOdgOQnS32fO+bt3Ixg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34848004"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.180])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:20 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/6] platform/x86/intel/tpmi: Add new auxiliary driver for performance limits
Date: Mon, 27 May 2024 16:29:36 +0300
Message-ID: <20240527133400.483634-5-tero.kristo@linux.intel.com>
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

Add new auxiliary driver that exposes the SoC performance limit reasons
via debugfs interface.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/platform/x86/intel/Kconfig          |   7 +
 drivers/platform/x86/intel/Makefile         |   1 +
 drivers/platform/x86/intel/intel_plr_tpmi.c | 205 ++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/platform/x86/intel/intel_plr_tpmi.c

diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index e97a97355d5a..ad50bbabec61 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -209,6 +209,13 @@ config INTEL_TPMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_vsec_tpmi.
 
+config INTEL_PLR_TPMI
+        tristate "Intel SoC TPMI Power Limit Reasons driver"
+        depends on INTEL_TPMI
+        help
+          This driver provides the TPMI power limit reasons status information
+          via debugfs files.
+
 config INTEL_TURBO_MAX_3
 	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
 	depends on X86_64 && SCHED_MC_PRIO
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 10437e56027d..74db065c82d6 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 # TPMI drivers
 intel_vsec_tpmi-y			:= tpmi.o
 obj-$(CONFIG_INTEL_TPMI)		+= intel_vsec_tpmi.o
+obj-$(CONFIG_INTEL_PLR_TPMI)		+= intel_plr_tpmi.o
 
 intel_tpmi_power_domains-y		:= tpmi_power_domains.o
 obj-$(CONFIG_INTEL_TPMI_POWER_DOMAINS)	+= intel_tpmi_power_domains.o
diff --git a/drivers/platform/x86/intel/intel_plr_tpmi.c b/drivers/platform/x86/intel/intel_plr_tpmi.c
new file mode 100644
index 000000000000..5fd45dd3c396
--- /dev/null
+++ b/drivers/platform/x86/intel/intel_plr_tpmi.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Limit Reasons via TPMI
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bitmap.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp_types.h>
+#include <linux/intel_tpmi.h>
+#include <linux/io.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/seq_file.h>
+#include <linux/sprintf.h>
+#include <linux/types.h>
+
+#define PLR_HEADER		0x00
+#define PLR_DIE_LEVEL		0x18
+
+#define PLR_INVALID		GENMASK_ULL(63, 0)
+
+struct tpmi_plr_die {
+	void __iomem *base;
+};
+
+struct tpmi_plr {
+	struct dentry *dbgfs_dir;
+	struct tpmi_plr_die *die_info;
+	int num_dies;
+};
+
+static const char * const plr_coarse_reasons[] = {
+	"FREQUENCY",
+	"CURRENT",
+	"POWER",
+	"THERMAL",
+	"PLATFORM",
+	"MCP",
+	"RAS",
+	"MISC",
+	"QOS",
+	"DFC",
+};
+
+static u64 plr_read(struct tpmi_plr_die *plr_die, int offset)
+{
+	return readq(plr_die->base + offset);
+}
+
+static void plr_write(u64 val, struct tpmi_plr_die *plr_die, int offset)
+{
+	writeq(val, plr_die->base + offset);
+}
+
+static void plr_print_bits(struct seq_file *s, u64 val, int bits)
+{
+	const unsigned long mask[] = { BITMAP_FROM_U64(val) };
+	int bit;
+
+	for_each_set_bit(bit, mask, bits) {
+		if (bit >= ARRAY_SIZE(plr_coarse_reasons))
+			seq_printf(s, " UNKNOWN(%d)", bit);
+		else
+			seq_printf(s, " %s", plr_coarse_reasons[bit]);
+	}
+
+	if (!val)
+		seq_puts(s, " none");
+
+	seq_putc(s, '\n');
+}
+
+static int plr_status_show(struct seq_file *s, void *unused)
+{
+	struct tpmi_plr_die *plr_die = s->private;
+	u64 val;
+
+	val = plr_read(plr_die, PLR_DIE_LEVEL);
+	seq_puts(s, "cpus");
+	plr_print_bits(s, val, 32);
+
+	return 0;
+}
+
+static ssize_t plr_status_write(struct file *filp, const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	struct seq_file *s = filp->private_data;
+	struct tpmi_plr_die *plr_die = s->private;
+	bool val;
+	int ret;
+
+	ret = kstrtobool_from_user(ubuf, count, &val);
+	if (ret)
+		return ret;
+
+	if (val != 0)
+		return -EINVAL;
+
+	plr_write(0, plr_die, PLR_DIE_LEVEL);
+
+	return count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(plr_status);
+
+static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
+{
+	struct intel_tpmi_plat_info *plat_info;
+	struct dentry *dentry;
+	int i, num_resources;
+	struct resource *res;
+	struct tpmi_plr *plr;
+	void __iomem *base;
+	char name[16];
+	int err;
+
+	plat_info = tpmi_get_platform_data(auxdev);
+	if (!plat_info)
+		return dev_err_probe(&auxdev->dev, -EINVAL, "No platform info\n");
+
+	dentry = tpmi_get_debugfs_dir(auxdev);
+	if (!dentry)
+		return dev_err_probe(&auxdev->dev, -ENODEV, "No TPMI debugfs directory.\n");
+
+	num_resources = tpmi_get_resource_count(auxdev);
+	if (!num_resources)
+		return -EINVAL;
+
+	plr = devm_kzalloc(&auxdev->dev, sizeof(*plr), GFP_KERNEL);
+	if (!plr)
+		return -ENOMEM;
+
+	plr->die_info = devm_kcalloc(&auxdev->dev, num_resources, sizeof(*plr->die_info),
+				     GFP_KERNEL);
+	if (!plr->die_info)
+		return -ENOMEM;
+
+	plr->num_dies = num_resources;
+	plr->dbgfs_dir = debugfs_create_dir("plr", dentry);
+
+	for (i = 0; i < num_resources; i++) {
+		res = tpmi_get_resource_at_index(auxdev, i);
+		if (!res) {
+			err = dev_err_probe(&auxdev->dev, -EINVAL, "No resource\n");
+			goto err;
+		}
+
+		base = devm_ioremap_resource(&auxdev->dev, res);
+		if (IS_ERR(base)) {
+			err = PTR_ERR(base);
+			goto err;
+		}
+
+		plr->die_info[i].base = base;
+
+		if (plr_read(&plr->die_info[i], PLR_HEADER) == PLR_INVALID)
+			continue;
+
+		snprintf(name, sizeof(name), "domain%d", i);
+
+		dentry = debugfs_create_dir(name, plr->dbgfs_dir);
+		debugfs_create_file("status", 0444, dentry, &plr->die_info[i],
+				    &plr_status_fops);
+	}
+
+	auxiliary_set_drvdata(auxdev, plr);
+
+	return 0;
+
+err:
+	debugfs_remove_recursive(plr->dbgfs_dir);
+	return err;
+}
+
+static void intel_plr_remove(struct auxiliary_device *auxdev)
+{
+	struct tpmi_plr *plr = auxiliary_get_drvdata(auxdev);
+
+	debugfs_remove_recursive(plr->dbgfs_dir);
+}
+
+static const struct auxiliary_device_id intel_plr_id_table[] = {
+	{ .name = "intel_vsec.tpmi-plr" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, intel_plr_id_table);
+
+static struct auxiliary_driver intel_plr_aux_driver = {
+	.id_table       = intel_plr_id_table,
+	.remove         = intel_plr_remove,
+	.probe          = intel_plr_probe,
+};
+module_auxiliary_driver(intel_plr_aux_driver);
+
+MODULE_IMPORT_NS(INTEL_TPMI);
+MODULE_DESCRIPTION("Intel TPMI PLR Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.1


