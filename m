Return-Path: <linux-kernel+bounces-210893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA79049C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BC51C23682
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61CA17554;
	Wed, 12 Jun 2024 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6qAIx3s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802FC21362;
	Wed, 12 Jun 2024 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164450; cv=none; b=bhDukZ7sRbavQN7mABYxMo1OM6FE9/+cWLIhSOsq/TxereODJY0go963b0bYdgoMXmQoNRaMbPFwpxnDtyIXdHYfVcLysTEQSV9Kh+zfo89z8zDcNdpCHoBOP0Iu0k1wJn1QDH5lBR/ZjHlkB75nGrBjBCXugyJk7/ckyct2MKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164450; c=relaxed/simple;
	bh=EwtZfeuYyvQEr/AjxRycPI/pvIPFOtH8D1SZ5xPbbAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnNcVDFxrWvyGACtDMpaq4rnnIpL97J9DKSlEZ1poU5rYbDLJeziwFU+cNzFGHrZRarRnbixUGrafb0bxgDYZGFBLUegvFB+FifcTHVt2n8FeSAGZgzQVfHVu+9WsKgtgUbboiIv8kiDPEyzAvAjuJ0pzMx8c5vfiSkMU+jPt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6qAIx3s; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718164448; x=1749700448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EwtZfeuYyvQEr/AjxRycPI/pvIPFOtH8D1SZ5xPbbAo=;
  b=H6qAIx3see4gbYdSoMqpFviHW4vyEQtjwlAuEXYd4SHiZGXVQYtJpvgs
   wo44nMNeC4Q857VXHZ5ljJ+KWbZvUVM/pXbT8kiU1lkOHSaxah/ynt4kU
   /oK/vJVPxFIyQP9dFYZEoGPbFZ8xb9TKkXqfVxh7zWDBEXYl9QKUosORZ
   D3WEmaiZy0McnGe7fGmIhoOypfESqxRRNXpD8RP7LEzptpHaDf8fFT1/n
   jizi78DzkGBiqbRgwfLdYQrUrRcyNSTJSTQ5qyZY0hQR6+KUYqF4ooSYa
   N4RbJx9UVaDlQn92jXtyvBC0I1Ep0l16gofzauPkkfPP41bVqmKY3dcPu
   w==;
X-CSE-ConnectionGUID: vr0NTeVYTrqZomeRF43nvg==
X-CSE-MsgGUID: DY5ioSDhQVylAifPgThKbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="37433734"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="37433734"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 20:54:08 -0700
X-CSE-ConnectionGUID: tJTAxEC3TLOepkAqKaCAqg==
X-CSE-MsgGUID: gjOsklThTQ2q9OPF1lp7ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39758570"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jun 2024 20:54:04 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v10 1/3] pps: generators: Add PPS Generator TIO Driver
Date: Wed, 12 Jun 2024 09:23:57 +0530
Message-Id: <20240612035359.7307-2-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The Intel Timed IO PPS generator driver outputs a PPS signal using
dedicated hardware that is more accurate than software actuated PPS.
The Timed IO hardware generates output events using the ART timer.
The ART timer period varies based on platform type, but is less than 100
nanoseconds for all current platforms. Timed IO output accuracy is
within 1 ART period.

PPS output is enabled by writing '1' the 'enable' sysfs attribute. The
driver uses hrtimers to schedule a wake-up 10 ms before each event
(edge) target time. At wakeup, the driver converts the target time in
terms of CLOCK_REALTIME to ART trigger time and writes this to the Timed
IO hardware. The Timed IO hardware generates an event precisely at the
requested system time without software involvement.

Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Co-developed-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
Signed-off-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Eddie Dong <eddie.dong@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/pps/generators/Kconfig       |  16 ++
 drivers/pps/generators/Makefile      |   1 +
 drivers/pps/generators/pps_gen_tio.c | 264 +++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
index d615e640fcad..0f090932336f 100644
--- a/drivers/pps/generators/Kconfig
+++ b/drivers/pps/generators/Kconfig
@@ -12,3 +12,19 @@ config PPS_GENERATOR_PARPORT
 	  If you say yes here you get support for a PPS signal generator which
 	  utilizes STROBE pin of a parallel port to send PPS signals. It uses
 	  parport abstraction layer and hrtimers to precisely control the signal.
+
+config PPS_GENERATOR_TIO
+	tristate "TIO PPS signal generator"
+	depends on X86 && CPU_SUP_INTEL
+	help
+	  If you say yes here you get support for a PPS TIO signal generator
+	  which generates a pulse at a prescribed time based on the system clock.
+	  It uses time translation and hrtimers to precisely generate a pulse.
+	  This hardware is present on 2019 and newer Intel CPUs. However, this
+	  driver is not useful without adding highly specialized hardware outside
+	  the Linux system to observe these pulses.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pps_gen_tio.
+
+	  If unsure, say N.
diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index 2589fd0f2481..714e847ae193 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -4,5 +4,6 @@
 #
 
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
+obj-$(CONFIG_PPS_GENERATOR_TIO) += pps_gen_tio.o
 
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
new file mode 100644
index 000000000000..c4142aa8f356
--- /dev/null
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel PPS signal Generator Driver
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hrtimer.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
+#include <linux/timekeeping.h>
+#include <linux/types.h>
+
+#include <asm/cpu_device_id.h>
+
+#define TIOCTL			0x00
+#define TIOCOMPV		0x10
+#define TIOEC			0x30
+
+/* Control Register */
+#define TIOCTL_EN			BIT(0)
+#define TIOCTL_DIR			BIT(1)
+#define TIOCTL_EP			GENMASK(3, 2)
+#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
+#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
+#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
+
+#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC) /* Safety time to set hrtimer early */
+#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
+#define ART_HW_DELAY_CYCLES		2
+
+struct pps_tio {
+	struct hrtimer timer;
+	struct device *dev;
+	spinlock_t lock;
+	struct attribute_group attrs;
+	void __iomem *base;
+	bool enabled;
+	u32 prev_count;
+};
+
+static inline u32 pps_tio_read(struct pps_tio *tio, u32 offset)
+{
+	return readl(tio->base + offset);
+}
+
+static inline void pps_ctl_write(struct pps_tio *tio, u32 value)
+{
+	writel(value, tio->base + TIOCTL);
+}
+
+/* For COMPV register, It's safer to write higher 32-bit followed by lower 32-bit */
+static inline void pps_compv_write(struct pps_tio *tio, u64 value)
+{
+	hi_lo_writeq(value, tio->base + TIOCOMPV);
+}
+
+static inline ktime_t first_event(struct pps_tio *tio)
+{
+	return ktime_set(ktime_get_real_seconds() + 1, MAGIC_CONST);
+}
+
+static u32 pps_tio_disable(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_tio_read(tio, TIOCTL);
+	pps_compv_write(tio, 0);
+
+	ctrl &= ~TIOCTL_EN;
+	pps_ctl_write(tio, ctrl);
+	tio->enabled = false;
+	tio->prev_count = 0;
+
+	return ctrl;
+}
+
+static void pps_tio_enable(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_tio_read(tio, TIOCTL);
+	ctrl |= TIOCTL_EN;
+	pps_ctl_write(tio, ctrl);
+	tio->enabled = true;
+}
+
+static void pps_tio_direction_output(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_tio_disable(tio);
+
+	/* We enable the device, be sure that the 'compare' value is invalid */
+	pps_compv_write(tio, 0);
+
+	ctrl &= ~(TIOCTL_DIR | TIOCTL_EP);
+	ctrl |= TIOCTL_EP_TOGGLE_EDGE;
+	pps_ctl_write(tio, ctrl);
+	pps_tio_enable(tio);
+}
+
+static bool pps_generate_next_pulse(struct pps_tio *tio, ktime_t expires)
+{
+	u64 art;
+
+	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art)) {
+		pps_tio_disable(tio);
+		return false;
+	}
+
+	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
+	return true;
+}
+
+static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
+{
+	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
+	ktime_t expires, now;
+	u32 event_count;
+
+	guard(spinlock)(&tio->lock);
+
+	/* Check if any event is missed. If an event is missed, TIO will be disabled*/
+	event_count = pps_tio_read(tio, TIOEC);
+	if (tio->prev_count && tio->prev_count == event_count)
+		goto err;
+	tio->prev_count = event_count;
+	expires = hrtimer_get_expires(timer);
+	now = ktime_get_real();
+
+	if (now - expires >= SAFE_TIME_NS)
+		goto err;
+
+	tio->enabled = pps_generate_next_pulse(tio, expires + SAFE_TIME_NS);
+	if (!tio->enabled)
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
+	return HRTIMER_RESTART;
+err:
+	dev_err(tio->dev, "Event missed, Disabling Timed I/O");
+	pps_tio_disable(tio);
+	return HRTIMER_NORESTART;
+}
+
+static ssize_t enable_store(struct device *dev, struct device_attribute *attr, const char *buf,
+			    size_t count)
+{
+	struct pps_tio *tio = dev_get_drvdata(dev);
+	bool enable;
+	int err;
+
+	if (!timekeeping_clocksource_has_base(CSID_X86_ART)) {
+		dev_err_once(dev, "PPS cannot be used as clock is not related to ART");
+		return -ENODEV;
+	}
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	guard(spinlock_irqsave)(&tio->lock);
+	if (enable && !tio->enabled) {
+		pps_tio_direction_output(tio);
+		hrtimer_start(&tio->timer, first_event(tio), HRTIMER_MODE_ABS);
+	} else if (!enable && tio->enabled) {
+		hrtimer_cancel(&tio->timer);
+		pps_tio_disable(tio);
+	}
+	return count;
+}
+
+static ssize_t enable_show(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct pps_tio *tio = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", tio->enabled);
+}
+static DEVICE_ATTR_RW(enable);
+
+static struct attribute *pps_tio_attrs[] = {
+	&dev_attr_enable.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pps_tio);
+
+static int pps_gen_tio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pps_tio *tio;
+
+	if (!(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ) &&
+	      cpu_feature_enabled(X86_FEATURE_ART))) {
+		dev_warn(dev, "TSC/ART is not enabled");
+		return -ENODEV;
+	}
+
+	tio = devm_kzalloc(dev, sizeof(*tio), GFP_KERNEL);
+	if (!tio)
+		return -ENOMEM;
+
+	tio->dev = dev;
+	tio->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tio->base))
+		return PTR_ERR(tio->base);
+
+	pps_tio_disable(tio);
+	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	tio->timer.function = hrtimer_callback;
+	spin_lock_init(&tio->lock);
+	platform_set_drvdata(pdev, tio);
+
+	return 0;
+}
+
+static int pps_gen_tio_remove(struct platform_device *pdev)
+{
+	struct pps_tio *tio = platform_get_drvdata(pdev);
+
+	hrtimer_cancel(&tio->timer);
+	pps_tio_disable(tio);
+
+	return 0;
+}
+
+static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
+	{ "INTC1021" },
+	{ "INTC1022" },
+	{ "INTC1023" },
+	{ "INTC1024" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, intel_pmc_tio_acpi_match);
+
+static struct platform_driver pps_gen_tio_driver = {
+	.probe          = pps_gen_tio_probe,
+	.remove         = pps_gen_tio_remove,
+	.driver         = {
+		.name                   = "intel-pps-gen-tio",
+		.acpi_match_table       = intel_pmc_tio_acpi_match,
+		.dev_groups             = pps_tio_groups,
+	},
+};
+module_platform_driver(pps_gen_tio_driver);
+
+MODULE_AUTHOR("Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>");
+MODULE_AUTHOR("Christopher Hall <christopher.s.hall@intel.com>");
+MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
+MODULE_AUTHOR("Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>");
+MODULE_DESCRIPTION("Intel PMC Time-Aware IO Generator Driver");
+MODULE_LICENSE("GPL");
-- 
2.35.3


