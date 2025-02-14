Return-Path: <linux-kernel+bounces-514647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43CDA359BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47703AE23E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD822D4DC;
	Fri, 14 Feb 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEVNfcZt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82F22D78E;
	Fri, 14 Feb 2025 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524110; cv=none; b=OCtRujJYypJmXd1uSRah7ARNlaeQposaRWiB4dmaS0VGy2iUB/MCvr3WaCHrBnjydPG0Qwj5S4PPO1zvxbhGwVGJUgqtR98SBDx5lKDGDHSpwiZT4/RdzIi6OtrFHBNYMMBv6jItZkkeiOsHdb4xkO0pkrC03zMbQwzocsqlHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524110; c=relaxed/simple;
	bh=lXnHQogEmGMJQi1neQwdfYeWkUx0B3xCb1duJK0bZjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWJCMkrFUUnonjNJlPZ/gh6+Y9PyhQfDZ0uGBk8qSp92WSTHhYF0hX1QPPcZGYB4HP//G73OXejjkNi4oei7VenC9m3ZUc492vLspP7NBOntAZSd5STuxpkgPmGzjYlmQqYSjWAiuj7xK0uJ2j9a6qhH7er9/uXzp1p+d3C9xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEVNfcZt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524108; x=1771060108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lXnHQogEmGMJQi1neQwdfYeWkUx0B3xCb1duJK0bZjQ=;
  b=PEVNfcZtnHoZJ242HP1cklONyTJ8M4/4ONaBuTAk97g2TiFlEyWYeagn
   lIYT/qmlF5iPh/Qs2SUjJ0QNtu3jO6DZR9gTU8RyX8NQXTh21T1yJBzhT
   2cb7I7l/Tm0IM3QP98PDUVHLhyPUZ+qq4gvpnOhbQfUVLhz2daXRgpNig
   Y0cSxcyt46vRW0BFq08PJzypd7biRMHmOnz2S2uxki4wPy75CZrTIRfTz
   08J/C48OIXHsCQrqV1fWkElDed4Szrkih5xDPibLi5M2whHu0wD9DNcFl
   IZ8o2/PW1V0NDZWk4M2dPdVj04ig8SFRGoIakTb2hxprm8b95pNTe40S2
   Q==;
X-CSE-ConnectionGUID: 8XAEwvOJQB+In060lNV47A==
X-CSE-MsgGUID: ZsVr/37fQDuFriRLu8KyJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51694765"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51694765"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:08:26 -0800
X-CSE-ConnectionGUID: Ny9G3qn8S1+NLeR5RgWO9A==
X-CSE-MsgGUID: C9S4XPjeT1uoXuQ0vEhriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114303098"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa008.jf.intel.com with ESMTP; 14 Feb 2025 01:08:09 -0800
From: subramanian.mohan@intel.com
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	giometti@enneenne.com,
	tglx@linutronix.de,
	corbet@lwn.net
Cc: eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com,
	david.zage@intel.com,
	srinivasan.chinnadurai@intel.com,
	subramanian.mohan@intel.com
Subject: [PATCH v14 2/4] pps: generators: Add PPS Generator TIO Driver
Date: Fri, 14 Feb 2025 14:37:53 +0530
Message-Id: <20250214090755.37450-3-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214090755.37450-1-subramanian.mohan@intel.com>
References: <20250214090755.37450-1-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Subramanian Mohan <subramanian.mohan@intel.com>

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
Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
---
 drivers/pps/generators/Kconfig       |  16 ++
 drivers/pps/generators/Makefile      |   1 +
 drivers/pps/generators/pps_gen_tio.c | 272 +++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
index cd94bf3bfaf2..b3f340ed3163 100644
--- a/drivers/pps/generators/Kconfig
+++ b/drivers/pps/generators/Kconfig
@@ -31,4 +31,20 @@ config PPS_GENERATOR_PARPORT
 	  utilizes STROBE pin of a parallel port to send PPS signals. It uses
 	  parport abstraction layer and hrtimers to precisely control the signal.
 
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
+
 endif # PPS_GENERATOR
diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index dc1aa5a4688b..e109920e8a2d 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_PPS_GENERATOR)	:= pps_gen_core.o
 
 obj-$(CONFIG_PPS_GENERATOR_DUMMY)   += pps_gen-dummy.o
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
+obj-$(CONFIG_PPS_GENERATOR_TIO)     += pps_gen_tio.o
 
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
new file mode 100644
index 000000000000..6c46b46c66cd
--- /dev/null
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel PPS signal Generator Driver
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/hrtimer.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pps_gen_kernel.h>
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
+/* Safety time to set hrtimer early */
+#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC)
+
+#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
+#define ART_HW_DELAY_CYCLES		2
+
+struct pps_tio {
+	struct pps_gen_source_info gen_info;
+	struct pps_gen_device *pps_gen;
+	struct hrtimer timer;
+	void __iomem *base;
+	u32 prev_count;
+	spinlock_t lock;
+	struct device *dev;
+};
+
+static inline u32 pps_tio_read(u32 offset, struct pps_tio *tio)
+{
+	return readl(tio->base + offset);
+}
+
+static inline void pps_ctl_write(u32 value, struct pps_tio *tio)
+{
+	writel(value, tio->base + TIOCTL);
+}
+
+/*
+ * For COMPV register, It's safer to write
+ * higher 32-bit followed by lower 32-bit
+ */
+static inline void pps_compv_write(u64 value, struct pps_tio *tio)
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
+	ctrl = pps_tio_read(TIOCTL, tio);
+	pps_compv_write(0, tio);
+
+	ctrl &= ~TIOCTL_EN;
+	pps_ctl_write(ctrl, tio);
+	tio->pps_gen->enabled = false;
+	tio->prev_count = 0;
+	return ctrl;
+}
+
+static void pps_tio_enable(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_tio_read(TIOCTL, tio);
+	ctrl |= TIOCTL_EN;
+	pps_ctl_write(ctrl, tio);
+	tio->pps_gen->enabled = true;
+}
+
+static void pps_tio_direction_output(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_tio_disable(tio);
+
+	/*
+	 * We enable the device, be sure that the
+	 * 'compare' value is invalid
+	 */
+	pps_compv_write(0, tio);
+
+	ctrl &= ~(TIOCTL_DIR | TIOCTL_EP);
+	ctrl |= TIOCTL_EP_TOGGLE_EDGE;
+	pps_ctl_write(ctrl, tio);
+	pps_tio_enable(tio);
+}
+
+static bool pps_generate_next_pulse(ktime_t expires, struct pps_tio *tio)
+{
+	u64 art;
+
+	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art)) {
+		pps_tio_disable(tio);
+		return false;
+	}
+
+	pps_compv_write(art - ART_HW_DELAY_CYCLES, tio);
+	return true;
+}
+
+static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
+{
+	ktime_t expires, now;
+	u32 event_count;
+	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
+
+	guard(spinlock)(&tio->lock);
+
+	/*
+	 * Check if any event is missed.
+	 * If an event is missed, TIO will be disabled.
+	 */
+	event_count = pps_tio_read(TIOEC, tio);
+	if (tio->prev_count && tio->prev_count == event_count)
+		goto err;
+	tio->prev_count = event_count;
+
+	expires = hrtimer_get_expires(timer);
+
+	now = ktime_get_real();
+	if (now - expires >= SAFE_TIME_NS)
+		goto err;
+
+	tio->pps_gen->enabled = pps_generate_next_pulse(expires + SAFE_TIME_NS, tio);
+	if (!tio->pps_gen->enabled)
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
+	return HRTIMER_RESTART;
+
+err:
+	dev_err(tio->dev, "Event missed, Disabling Timed I/O");
+	pps_tio_disable(tio);
+	pps_gen_event(tio->pps_gen, PPS_GEN_EVENT_MISSEDPULSE, NULL);
+	return HRTIMER_NORESTART;
+}
+
+static int pps_tio_gen_enable(struct pps_gen_device *pps_gen, bool enable)
+{
+	struct pps_tio *tio = container_of(pps_gen->info, struct pps_tio, gen_info);
+
+	if (!timekeeping_clocksource_has_base(CSID_X86_ART)) {
+		dev_err_once(tio->dev, "PPS cannot be used as clock is not related to ART");
+		return -ENODEV;
+	}
+
+	guard(spinlock_irqsave)(&tio->lock);
+	if (enable && !pps_gen->enabled) {
+		pps_tio_direction_output(tio);
+		hrtimer_start(&tio->timer, first_event(tio), HRTIMER_MODE_ABS);
+	} else if (!enable && pps_gen->enabled) {
+		hrtimer_cancel(&tio->timer);
+		pps_tio_disable(tio);
+	}
+
+	return 0;
+}
+
+static int pps_tio_get_time(struct pps_gen_device *pps_gen,
+			    struct timespec64 *time)
+{
+	struct system_time_snapshot snap;
+
+	ktime_get_snapshot(&snap);
+	*time = ktime_to_timespec64(snap.real);
+
+	return 0;
+}
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
+	tio->gen_info.use_system_clock = true;
+	tio->gen_info.enable = pps_tio_gen_enable;
+	tio->gen_info.get_time = pps_tio_get_time;
+	tio->gen_info.owner = THIS_MODULE;
+
+	tio->pps_gen = pps_gen_register_source(&tio->gen_info);
+	if (IS_ERR(tio->pps_gen))
+		return PTR_ERR(tio->pps_gen);
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
+	platform_set_drvdata(pdev, &tio);
+
+	return 0;
+}
+
+static void pps_gen_tio_remove(struct platform_device *pdev)
+{
+	struct pps_tio *tio = platform_get_drvdata(pdev);
+
+	hrtimer_cancel(&tio->timer);
+	pps_tio_disable(tio);
+	pps_gen_unregister_source(tio->pps_gen);
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
+	},
+};
+module_platform_driver(pps_gen_tio_driver);
+
+MODULE_AUTHOR("Christopher Hall <christopher.s.hall@intel.com>");
+MODULE_AUTHOR("Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>");
+MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
+MODULE_AUTHOR("Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>");
+MODULE_AUTHOR("Subramanian Mohan <subramanian.mohan@intel.com>");
+MODULE_DESCRIPTION("Intel PMC Time-Aware IO Generator Driver");
+MODULE_LICENSE("GPL");
-- 
2.35.3


