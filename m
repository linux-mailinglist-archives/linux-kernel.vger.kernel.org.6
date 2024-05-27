Return-Path: <linux-kernel+bounces-190731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9698D01CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4162B1F2639A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EDB16C860;
	Mon, 27 May 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TneleDLp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31916C6B8;
	Mon, 27 May 2024 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816866; cv=none; b=efvxKXS8z2bSVY9WjQ+z8fCiGQF3K8hr52MuFQSxd/N7/H7HkUw9uqCz4e2yRp9fYD+f09Juq7jRaVj6I6cKw8vVRx7gFXlVd/lq5yB4SXSDxhbQPmmQwAddRHceR7CGWFOChmlzIt7qdWrTV4HPdpKo9Ykn94UtXmNLOYVER+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816866; c=relaxed/simple;
	bh=7m7EnrDN3RIiTt0JMQn8+IrcaF3n+IhtARqEhXZMcf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXn6C0T6J/rXrJCaizFF5Va1lC8oQ7kSx/S6CYs1WWHLRjeyeg790fxrnoKm5qphrRbHF5UAgqjEHwlGbbhR5ntBUqO5KXwNe/Pmcee9t+rvA2BJHcXKhWPEie3CsNGJ60oI5QRAlr0jRZNEmPTe20J2t1oVTSx3j9tJxf9ePxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TneleDLp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816865; x=1748352865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7m7EnrDN3RIiTt0JMQn8+IrcaF3n+IhtARqEhXZMcf4=;
  b=TneleDLp2ESkvE7iSlSMBdTKFdWs2p/iKSPje0syGdX5Qbwtb3Fl/3Dp
   oWOCq4gJXe5stVd7vSdkonfdZdy2PeNyrVNsQLmAbudB6G89zufcVeJmq
   Fxymh0RCx8slWd8Ko+zHIlIIQffTH7SkGHcOl2crtTyJxT6lfjy9pWn95
   s2JmbxMpKrANLYmEfshUbTx5GFbvZi+n92hVIkxoMe0YRLbz60Cxnal0O
   X5D+PsXb1ZLRxci2eh/ly9TFgabu7hDUXSG6n7ftMJ1i5M/4EMz+9OCbc
   Oyf2fsnY6yDH5UpO1eq/KWemSYBD+YM0GRyFZl6xDjbnG7l6vK/DswMpP
   g==;
X-CSE-ConnectionGUID: ObhhZUwHTcyPIHJhCab6/A==
X-CSE-MsgGUID: LJvW60dcRZat13io+B4Mzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="11714383"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11714383"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:25 -0700
X-CSE-ConnectionGUID: +UaTdGz1TDieNGwg66a0pQ==
X-CSE-MsgGUID: XipUaksyQ6WVIanCx4+Xtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34848009"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.180])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:22 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5/6] platform/x86/intel/tpmi/plr: Add support for the plr mailbox
Date: Mon, 27 May 2024 16:29:37 +0300
Message-ID: <20240527133400.483634-6-tero.kristo@linux.intel.com>
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

Add support for reading fine grained power limit reasons via the PLR
mailbox.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/platform/x86/intel/intel_plr_tpmi.c | 159 +++++++++++++++++++-
 1 file changed, 155 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/intel_plr_tpmi.c b/drivers/platform/x86/intel/intel_plr_tpmi.c
index 5fd45dd3c396..c597c6052875 100644
--- a/drivers/platform/x86/intel/intel_plr_tpmi.c
+++ b/drivers/platform/x86/intel/intel_plr_tpmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/array_size.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -15,26 +16,50 @@
 #include <linux/gfp_types.h>
 #include <linux/intel_tpmi.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kstrtox.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/seq_file.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 
+#include "tpmi_power_domains.h"
+
 #define PLR_HEADER		0x00
+#define PLR_MAILBOX_INTERFACE	0x08
+#define PLR_MAILBOX_DATA	0x10
 #define PLR_DIE_LEVEL		0x18
 
+#define PLR_MODULE_ID_MASK	GENMASK_ULL(19, 12)
+#define PLR_RUN_BUSY		BIT_ULL(63)
+
+#define PLR_COMMAND_WRITE	1
+
 #define PLR_INVALID		GENMASK_ULL(63, 0)
 
+#define PLR_TIMEOUT_US		5
+#define PLR_TIMEOUT_MAX_US	1000
+
+#define PLR_COARSE_REASON_BITS	32
+
+struct tpmi_plr;
+
 struct tpmi_plr_die {
 	void __iomem *base;
+	struct mutex lock; /* Protect access to PLR mailbox */
+	int package_id;
+	int die_id;
+	struct tpmi_plr *plr;
 };
 
 struct tpmi_plr {
 	struct dentry *dbgfs_dir;
 	struct tpmi_plr_die *die_info;
 	int num_dies;
+	struct auxiliary_device *auxdev;
 };
 
 static const char * const plr_coarse_reasons[] = {
@@ -50,6 +75,39 @@ static const char * const plr_coarse_reasons[] = {
 	"DFC",
 };
 
+static const char * const plr_fine_reasons[] = {
+	"FREQUENCY_CDYN0",
+	"FREQUENCY_CDYN1",
+	"FREQUENCY_CDYN2",
+	"FREQUENCY_CDYN3",
+	"FREQUENCY_CDYN4",
+	"FREQUENCY_CDYN5",
+	"FREQUENCY_FCT",
+	"FREQUENCY_PCS_TRL",
+	"CURRENT_MTPMAX",
+	"POWER_FAST_RAPL",
+	"POWER_PKG_PL1_MSR_TPMI",
+	"POWER_PKG_PL1_MMIO",
+	"POWER_PKG_PL1_PCS",
+	"POWER_PKG_PL2_MSR_TPMI",
+	"POWER_PKG_PL2_MMIO",
+	"POWER_PKG_PL2_PCS",
+	"POWER_PLATFORM_PL1_MSR_TPMI",
+	"POWER_PLATFORM_PL1_MMIO",
+	"POWER_PLATFORM_PL1_PCS",
+	"POWER_PLATFORM_PL2_MSR_TPMI",
+	"POWER_PLATFORM_PL2_MMIO",
+	"POWER_PLATFORM_PL2_PCS",
+	"UNKNOWN(22)",
+	"THERMAL_PER_CORE",
+	"DFC_UFS",
+	"PLATFORM_PROCHOT",
+	"PLATFORM_HOT_VR",
+	"UNKNOWN(27)",
+	"UNKNOWN(28)",
+	"MISC_PCS_PSTATE",
+};
+
 static u64 plr_read(struct tpmi_plr_die *plr_die, int offset)
 {
 	return readq(plr_die->base + offset);
@@ -60,16 +118,68 @@ static void plr_write(u64 val, struct tpmi_plr_die *plr_die, int offset)
 	writeq(val, plr_die->base + offset);
 }
 
+static int plr_read_cpu_status(struct tpmi_plr_die *plr_die, int cpu,
+			       u64 *status)
+{
+	u64 regval;
+	int ret;
+
+	lockdep_assert_held(&plr_die->lock);
+
+	regval = FIELD_PREP(PLR_MODULE_ID_MASK, tpmi_get_punit_core_number(cpu));
+	regval |= PLR_RUN_BUSY;
+
+	plr_write(regval, plr_die, PLR_MAILBOX_INTERFACE);
+
+	ret = readq_poll_timeout(plr_die->base + PLR_MAILBOX_INTERFACE, regval,
+				 !(regval & PLR_RUN_BUSY), PLR_TIMEOUT_US,
+				 PLR_TIMEOUT_MAX_US);
+	if (ret)
+		return ret;
+
+	*status = plr_read(plr_die, PLR_MAILBOX_DATA);
+
+	return 0;
+}
+
+static int plr_clear_cpu_status(struct tpmi_plr_die *plr_die, int cpu)
+{
+	u64 regval;
+
+	lockdep_assert_held(&plr_die->lock);
+
+	regval = FIELD_PREP(PLR_MODULE_ID_MASK, tpmi_get_punit_core_number(cpu));
+	regval |= PLR_RUN_BUSY | PLR_COMMAND_WRITE;
+
+	plr_write(0, plr_die, PLR_MAILBOX_DATA);
+
+	plr_write(regval, plr_die, PLR_MAILBOX_INTERFACE);
+
+	return readq_poll_timeout(plr_die->base + PLR_MAILBOX_INTERFACE, regval,
+				  !(regval & PLR_RUN_BUSY), PLR_TIMEOUT_US,
+				  PLR_TIMEOUT_MAX_US);
+}
+
 static void plr_print_bits(struct seq_file *s, u64 val, int bits)
 {
 	const unsigned long mask[] = { BITMAP_FROM_U64(val) };
-	int bit;
+	const char *str;
+	int bit, index;
 
 	for_each_set_bit(bit, mask, bits) {
-		if (bit >= ARRAY_SIZE(plr_coarse_reasons))
-			seq_printf(s, " UNKNOWN(%d)", bit);
+		if (bit < PLR_COARSE_REASON_BITS) {
+			if (bit < ARRAY_SIZE(plr_coarse_reasons))
+				str = plr_coarse_reasons[bit];
+		} else {
+			index = bit - PLR_COARSE_REASON_BITS;
+			if (index < ARRAY_SIZE(plr_fine_reasons))
+				str = plr_fine_reasons[index];
+		}
+
+		if (str)
+			seq_printf(s, " %s", str);
 		else
-			seq_printf(s, " %s", plr_coarse_reasons[bit]);
+			seq_printf(s, " UNKNOWN(%d)", bit);
 	}
 
 	if (!val)
@@ -81,12 +193,33 @@ static void plr_print_bits(struct seq_file *s, u64 val, int bits)
 static int plr_status_show(struct seq_file *s, void *unused)
 {
 	struct tpmi_plr_die *plr_die = s->private;
+	int ret;
 	u64 val;
 
 	val = plr_read(plr_die, PLR_DIE_LEVEL);
 	seq_puts(s, "cpus");
 	plr_print_bits(s, val, 32);
 
+	guard(mutex)(&plr_die->lock);
+
+	for (int cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		if (plr_die->die_id != tpmi_get_power_domain_id(cpu))
+			continue;
+
+		if (plr_die->package_id != topology_physical_package_id(cpu))
+			continue;
+
+		seq_printf(s, "cpu%d", cpu);
+		ret = plr_read_cpu_status(plr_die, cpu, &val);
+		if (ret) {
+			dev_err(&plr_die->plr->auxdev->dev, "Failed to read PLR for cpu %d, ret=%d\n",
+				cpu, ret);
+			return ret;
+		}
+
+		plr_print_bits(s, val, 64);
+	}
+
 	return 0;
 }
 
@@ -107,6 +240,18 @@ static ssize_t plr_status_write(struct file *filp, const char __user *ubuf,
 
 	plr_write(0, plr_die, PLR_DIE_LEVEL);
 
+	guard(mutex)(&plr_die->lock);
+
+	for (int cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		if (plr_die->die_id != tpmi_get_power_domain_id(cpu))
+			continue;
+
+		if (plr_die->package_id != topology_physical_package_id(cpu))
+			continue;
+
+		plr_clear_cpu_status(plr_die, cpu);
+	}
+
 	return count;
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(plr_status);
@@ -145,6 +290,7 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 
 	plr->num_dies = num_resources;
 	plr->dbgfs_dir = debugfs_create_dir("plr", dentry);
+	plr->auxdev = auxdev;
 
 	for (i = 0; i < num_resources; i++) {
 		res = tpmi_get_resource_at_index(auxdev, i);
@@ -160,6 +306,10 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 		}
 
 		plr->die_info[i].base = base;
+		plr->die_info[i].package_id = plat_info->package_id;
+		plr->die_info[i].die_id = i;
+		plr->die_info[i].plr = plr;
+		mutex_init(&plr->die_info[i].lock);
 
 		if (plr_read(&plr->die_info[i], PLR_HEADER) == PLR_INVALID)
 			continue;
@@ -201,5 +351,6 @@ static struct auxiliary_driver intel_plr_aux_driver = {
 module_auxiliary_driver(intel_plr_aux_driver);
 
 MODULE_IMPORT_NS(INTEL_TPMI);
+MODULE_IMPORT_NS(INTEL_TPMI_POWER_DOMAIN);
 MODULE_DESCRIPTION("Intel TPMI PLR Driver");
 MODULE_LICENSE("GPL");
-- 
2.43.1


