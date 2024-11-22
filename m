Return-Path: <linux-kernel+bounces-417808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B09D594D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28066B23099
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2D516F910;
	Fri, 22 Nov 2024 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FuPFz1g3"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71216DEB3;
	Fri, 22 Nov 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256365; cv=none; b=mHcuNTGKVQTV7nu9ZZghyN26ihdZxHmtcp5auPnFwu2pMVs0b0DJ+eeaN6FmKJZfMReudaIKLSr6nUcReFZ/NSEre1GtgRYpJdoHtDybkPVocY+81smsT4y1OFwN+D+JsIIYgWBrHj973l6wbOGRipzvzo3/ZjAea6vHG4cSlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256365; c=relaxed/simple;
	bh=Jj0YueaGcpsP4wADBIhgRVeamnNctO7XiSVKZHXtztw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bR/NJ3RonjSmbQUlSNUmO2+6Vp+nP9okTRuDrTdRLwtGf4lgENpvxhJP7E88ScG7zRIXN9CZi7iZHG3vVPM+0nOqgi+6JxsYpXiKiswWa3jcpePscF/FqPQQP6kyotLa9dCL4jAPb8Oe82y81NV88y//xa+7C9H3GDwN+jUZmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FuPFz1g3; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732256362; x=1763792362;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Jj0YueaGcpsP4wADBIhgRVeamnNctO7XiSVKZHXtztw=;
  b=FuPFz1g3CW1QCbHEp5sHqP8D/GHmz4v2tuOqK2I7mI4hzdJf2tiE5l9H
   epKL7oaC4W0TC49QbnrdpJM/RHt9hnaP0NcJ1j/gSZ9BliMhEK0sMcXSI
   Ph3LiwRmJwWbdmn7rq+MPb2M7JpuZ6X5gspbjOJ2uc80Ya6j6sE1S1Clc
   ndIDONoRnpr/+CSXwipW2VWxxo9w4OeE66q4yDSVddRaND+UgsCHbMlCj
   l3fHotw2jUCU3xqXBNpNRzgSsQkhAAs9E2WXv4xhLNSKjLfvXvHuggWaS
   xdC5VHYjY8uCHY2rCpiQC1xD874qS16o86VvjMRLkurN+ELmHJB4G4ubg
   w==;
X-CSE-ConnectionGUID: +KExfMHYQWGYzuVygevj5A==
X-CSE-MsgGUID: 6soMNe0yQy+8GzL4/9cr1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="180478661"
X-IronPort-AV: E=Sophos;i="6.12,174,1728918000"; 
   d="scan'208";a="180478661"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:18:10 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 41F46DBB97;
	Fri, 22 Nov 2024 15:18:08 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B6EE1D6035;
	Fri, 22 Nov 2024 15:18:07 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by oym-om1.fujitsu.com (Postfix) with ESMTP id 78E784007A424;
	Fri, 22 Nov 2024 15:18:07 +0900 (JST)
From: Yoshihiro Furudera <fj5100bi@fujitsu.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>
Subject: [PATCH v2 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
Date: Fri, 22 Nov 2024 06:17:53 +0000
Message-Id: <20241122061753.2598688-3-fj5100bi@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122061753.2598688-1-fj5100bi@fujitsu.com>
References: <20241122061753.2598688-1-fj5100bi@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new dynamic PMU to the Perf Events framework to program and
control the Uncore PCI PMUs in Fujitsu chips.

This driver was created with reference to drivers/perf/qcom_l3_pmu.c.

This driver exports formatting and event information to sysfs so it can
be used by the perf user space tools with the syntaxes:

perf stat -e pci_iod0_pci0/ea-pci/ ls
perf stat -e pci_iod0_pci0/event=0x80/ ls

FUJITSU-MONAKA Specification URL:
https://github.com/fujitsu/FUJITSU-MONAKA

Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
---
 .../admin-guide/perf/fujitsu_pci_pmu.rst      |  50 ++
 Documentation/admin-guide/perf/index.rst      |   1 +
 drivers/perf/Kconfig                          |   9 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/fujitsu_pci_pmu.c                | 550 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 6 files changed, 612 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
 create mode 100644 drivers/perf/fujitsu_pci_pmu.c

diff --git a/Documentation/admin-guide/perf/fujitsu_pci_pmu.rst b/Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
new file mode 100644
index 000000000000..ff72dacc2364
--- /dev/null
+++ b/Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
@@ -0,0 +1,50 @@
+====================================================
+Fujitsu Uncore PCI Performance Monitoring Unit (PMU)
+====================================================
+
+This driver supports the Uncore PCI PMUs found in Fujitsu chips.
+Each PCI PMU on these chips is exposed as a uncore perf PMU with device name
+pci_iod<iod>_pci<pci>.
+
+The driver provides a description of its available events and configuration
+options in sysfs, see /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
+This driver exports:
+- formats, used by perf user space and other tools to configure events
+- events, used by perf user space and other tools to create events
+  symbolically, e.g.:
+    perf stat -a -e pci_iod0_pci0/event=0x24/ ls
+- cpumask, used by perf user space and other tools to know on which CPUs
+  to open the events
+
+This driver supports the following events:
+- pci-port0-cycles
+  This event counts PCI cycles at PCI frequency in port0.
+- pci-port0-read-count
+  This event counts read transactions for data transfer in port0.
+- pci-port0-read-count-bus
+  This event counts read transactions for bus usage in port0.
+- pci-port0-write-count
+  This event counts write transactions for data transfer in port0.
+- pci-port0-write-count-bus
+  This event counts write transactions for bus usage in port0.
+- pci-port1-cycles
+  This event counts PCI cycles at PCI frequency in port1.
+- pci-port1-read-count
+  This event counts read transactions for data transfer in port1.
+- pci-port1-read-count-bus
+  This event counts read transactions for bus usage in port1.
+- pci-port1-write-count
+  This event counts write transactions for data transfer in port1.
+- pci-port1-write-count-bus
+  This event counts write transactions for bus usage in port1.
+- ea-pci
+  This event counts energy consumption of the PCI.
+
+  'ea' is the abbreviation for 'Energy Analyzer'.
+
+Examples for use with perf::
+
+  perf stat -e pci_iod0_pci0/ea-pci/ ls
+
+Given that these are uncore PMUs the driver does not support sampling, therefore
+"perf record" will not work. Per-task perf sessions are not supported.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 8cdcb426c6b4..475a730e27fe 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -28,3 +28,4 @@ Performance monitor support
    ampere_cspmu
    mrvl-pem-pmu
    fujitsu_mac_pmu
+   fujitsu_pci_pmu
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 3786aaffaee4..af682036fafa 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -187,6 +187,15 @@ config FUJITSU_MAC_PMU
 	 Adds the Uncore MAC PMU into the perf events subsystem for
 	 monitoring Uncore MAC events.
 
+config FUJITSU_PCI_PMU
+	bool "Fujitsu Uncore PCI PMU"
+	depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
+	help
+	 Provides support for the Uncore PCI performance monitor unit (PMU)
+	 in Fujitsu processors.
+	 Adds the Uncore PCI PMU into the perf events subsystem for
+	 monitoring Uncore PCI events.
+
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && ACPI
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index c9a2ba78d34f..30717ebb4801 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
 obj-$(CONFIG_FSL_IMX9_DDR_PMU) += fsl_imx9_ddr_perf.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_FUJITSU_MAC_PMU) += fujitsu_mac_pmu.o
+obj-$(CONFIG_FUJITSU_PCI_PMU) += fujitsu_pci_pmu.o
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
diff --git a/drivers/perf/fujitsu_pci_pmu.c b/drivers/perf/fujitsu_pci_pmu.c
new file mode 100644
index 000000000000..ceefd5df7525
--- /dev/null
+++ b/drivers/perf/fujitsu_pci_pmu.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Uncore PCI PMUs in Fujitsu chips.
+ *
+ * See Documentation/admin-guide/perf/fujitsu_pci_pmu.rst for more details.
+ *
+ * This driver is based on drivers/perf/qcom_l3_pmu.c
+ * Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Fujitsu. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+/* Number of counters on each PMU */
+#define PCI_NUM_COUNTERS  8
+/* Mask for the event type field within perf_event_attr.config and EVTYPE reg */
+#define PCI_EVTYPE_MASK   0xFF
+
+/* Perfmon registers */
+#define PCI_PM_EVCNTR(__cntr) (0x000 + ((__cntr) & 0x7) * 8)
+#define PCI_PM_CNTCTL(__cntr) (0x100 + ((__cntr) & 0x7) * 8)
+#define PCI_PM_EVTYPE(__cntr) (0x200 + ((__cntr) & 0x7) * 8)
+#define PCI_PM_CR         0x400
+#define PCI_PM_CNTENSET   0x410
+#define PCI_PM_CNTENCLR   0x418
+#define PCI_PM_INTENSET   0x420
+#define PCI_PM_INTENCLR   0x428
+#define PCI_PM_OVSR       0x440
+
+/* PCI_PM_CNTCTLx */
+#define PMCNT_RESET           0
+
+/* PCI_PM_EVTYPEx */
+#define EVSEL(__val)          ((__val) & PCI_EVTYPE_MASK)
+
+/* PCI_PM_CR */
+#define PM_RESET              (1UL << 1)
+#define PM_ENABLE             (1UL << 0)
+
+/* PCI_PM_CNTENSET */
+#define PMCNTENSET(__cntr)    (1UL << ((__cntr) & 0x7))
+
+/* PCI_PM_CNTENCLR */
+#define PMCNTENCLR(__cntr)    (1UL << ((__cntr) & 0x7))
+#define PM_CNTENCLR_RESET     0xFF
+
+/* PCI_PM_INTENSET */
+#define PMINTENSET(__cntr)    (1UL << ((__cntr) & 0x7))
+
+/* PCI_PM_INTENCLR */
+#define PMINTENCLR(__cntr)    (1UL << ((__cntr) & 0x7))
+#define PM_INTENCLR_RESET     0xFF
+
+/* PCI_PM_OVSR */
+#define PMOVSRCLR(__cntr)     (1UL << ((__cntr) & 0x7))
+#define PMOVSRCLR_RESET       0xFF
+
+#define PCI_EVENT_PORT0_CYCLES		0x000
+#define PCI_EVENT_PORT0_READ_COUNT	0x010
+#define PCI_EVENT_PORT0_READ_COUNT_BUS	0x014
+#define PCI_EVENT_PORT0_WRITE_COUNT	0x020
+#define PCI_EVENT_PORT0_WRITE_COUNT_BUS	0x024
+#define PCI_EVENT_PORT1_CYCLES		0x040
+#define PCI_EVENT_PORT1_READ_COUNT	0x050
+#define PCI_EVENT_PORT1_READ_COUNT_BUS	0x054
+#define PCI_EVENT_PORT1_WRITE_COUNT	0x060
+#define PCI_EVENT_PORT1_WRITE_COUNT_BUS	0x064
+#define PCI_EVENT_EA_PCI		0x080
+
+struct pci_pmu {
+	struct pmu		pmu;
+	struct hlist_node	node;
+	void __iomem		*regs;
+	struct perf_event	*events[PCI_NUM_COUNTERS];
+	unsigned long		used_mask[BITS_TO_LONGS(PCI_NUM_COUNTERS)];
+	cpumask_t		cpumask;
+};
+
+#define to_pci_pmu(p) (container_of(p, struct pci_pmu, pmu))
+
+static void fujitsu_pci_counter_start(struct perf_event *event)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	/* Initialize the hardware counter and reset prev_count*/
+	local64_set(&event->hw.prev_count, 0);
+	writeq_relaxed(0, pcipmu->regs + PCI_PM_EVCNTR(idx));
+
+	/* Set the event type */
+	writeq_relaxed(EVSEL(event->attr.config), pcipmu->regs + PCI_PM_EVTYPE(idx));
+
+	/* Enable interrupt generation by this counter */
+	writeq_relaxed(PMINTENSET(idx), pcipmu->regs + PCI_PM_INTENSET);
+
+	/* Finally, enable the counter */
+	writeq_relaxed(PMCNT_RESET, pcipmu->regs + PCI_PM_CNTCTL(idx));
+	writeq_relaxed(PMCNTENSET(idx), pcipmu->regs + PCI_PM_CNTENSET);
+}
+
+static void fujitsu_pci_counter_stop(struct perf_event *event,
+					      int flags)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	/* Disable the counter */
+	writeq_relaxed(PMCNTENCLR(idx), pcipmu->regs + PCI_PM_CNTENCLR);
+
+	/* Disable interrupt generation by this counter */
+	writeq_relaxed(PMINTENCLR(idx), pcipmu->regs + PCI_PM_INTENCLR);
+}
+
+static void fujitsu_pci_counter_update(struct perf_event *event)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u64 prev, new;
+
+	do {
+		prev = local64_read(&event->hw.prev_count);
+		new = readq_relaxed(pcipmu->regs + PCI_PM_EVCNTR(idx));
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, new) != prev);
+
+	local64_add(new - prev, &event->count);
+}
+
+static inline void fujitsu_pci__init(struct pci_pmu *pcipmu)
+{
+	int i;
+
+	writeq_relaxed(PM_RESET, pcipmu->regs + PCI_PM_CR);
+
+	writeq_relaxed(PM_CNTENCLR_RESET, pcipmu->regs + PCI_PM_CNTENCLR);
+	writeq_relaxed(PM_INTENCLR_RESET, pcipmu->regs + PCI_PM_INTENCLR);
+	writeq_relaxed(PMOVSRCLR_RESET, pcipmu->regs + PCI_PM_OVSR);
+
+	for (i = 0; i < PCI_NUM_COUNTERS; ++i) {
+		writeq_relaxed(PMCNT_RESET, pcipmu->regs + PCI_PM_CNTCTL(i));
+		writeq_relaxed(EVSEL(0), pcipmu->regs + PCI_PM_EVTYPE(i));
+	}
+
+	/*
+	 * Use writeq here to ensure all programming commands are done
+	 * before proceeding
+	 */
+	writeq(PM_ENABLE, pcipmu->regs + PCI_PM_CR);
+}
+
+static irqreturn_t fujitsu_pci__handle_irq(int irq_num, void *data)
+{
+	struct pci_pmu *pcipmu = data;
+	/* Read the overflow status register */
+	long status = readq_relaxed(pcipmu->regs + PCI_PM_OVSR);
+	int idx;
+
+	if (status == 0)
+		return IRQ_NONE;
+
+	/* Clear the bits we read on the overflow status register */
+	writeq_relaxed(status, pcipmu->regs + PCI_PM_OVSR);
+
+	for_each_set_bit(idx, &status, PCI_NUM_COUNTERS) {
+		struct perf_event *event;
+
+		event = pcipmu->events[idx];
+		if (!event)
+			continue;
+
+		fujitsu_pci_counter_update(event);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void fujitsu_pci__pmu_enable(struct pmu *pmu)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(pmu);
+
+	/* Ensure the other programming commands are observed before enabling */
+	wmb();
+
+	writeq_relaxed(PM_ENABLE, pcipmu->regs + PCI_PM_CR);
+}
+
+static void fujitsu_pci__pmu_disable(struct pmu *pmu)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(pmu);
+
+	writeq_relaxed(0, pcipmu->regs + PCI_PM_CR);
+
+	/* Ensure the basic counter unit is stopped before proceeding */
+	wmb();
+}
+
+/*
+ * We must NOT create groups containing events from multiple hardware PMUs,
+ * although mixing different software and hardware PMUs is allowed.
+ */
+static bool fujitsu_pci__validate_event_group(struct perf_event *event)
+{
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	int counters = 0;
+
+	if (leader->pmu != event->pmu && !is_software_event(leader))
+		return false;
+
+	/* The sum of the counters used by the event and its leader event */
+	counters = 2;
+
+	for_each_sibling_event(sibling, leader) {
+		if (is_software_event(sibling))
+			continue;
+		if (sibling->pmu != event->pmu)
+			return false;
+		counters += 1;
+	}
+
+	/*
+	 * If the group requires more counters than the HW has, it
+	 * cannot ever be scheduled.
+	 */
+	return counters <= PCI_NUM_COUNTERS;
+}
+
+static int fujitsu_pci__event_init(struct perf_event *event)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Is the event for this PMU? */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * Sampling not supported
+	 * since these events are not core-attributable.
+	 */
+	if (hwc->sample_period)
+		return -EINVAL;
+
+	/*
+	 * Task mode not available, we run the counters as socket counters,
+	 * not attributable to any CPU and therefore cannot attribute per-task.
+	 */
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	/* Validate the group */
+	if (!fujitsu_pci__validate_event_group(event))
+		return -EINVAL;
+
+	hwc->idx = -1;
+
+	/*
+	 * Many perf core operations (eg. events rotation) operate on a
+	 * single CPU context. This is obvious for CPU PMUs, where one
+	 * expects the same sets of events being observed on all CPUs,
+	 * but can lead to issues for off-core PMUs, like this one, where
+	 * each event could be theoretically assigned to a different CPU.
+	 * To mitigate this, we enforce CPU assignment to one designated
+	 * processor (the one described in the "cpumask" attribute exported
+	 * by the PMU device). perf user space tools honor this and avoid
+	 * opening more than one copy of the events.
+	 */
+	event->cpu = cpumask_first(&pcipmu->cpumask);
+
+	return 0;
+}
+
+static void fujitsu_pci__event_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->state = 0;
+	fujitsu_pci_counter_start(event);
+}
+
+static void fujitsu_pci__event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	fujitsu_pci_counter_stop(event, flags);
+	if (flags & PERF_EF_UPDATE)
+		fujitsu_pci_counter_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int fujitsu_pci__event_add(struct perf_event *event, int flags)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/* Try to allocate a counter. */
+	idx = bitmap_find_free_region(pcipmu->used_mask, PCI_NUM_COUNTERS, 0);
+	if (idx < 0)
+		/* The counters are all in use. */
+		return -EAGAIN;
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	pcipmu->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		fujitsu_pci__event_start(event, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void fujitsu_pci__event_del(struct perf_event *event, int flags)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Stop and clean up */
+	fujitsu_pci__event_stop(event,  flags | PERF_EF_UPDATE);
+	pcipmu->events[hwc->idx] = NULL;
+	bitmap_release_region(pcipmu->used_mask, hwc->idx, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+}
+
+static void fujitsu_pci__event_read(struct perf_event *event)
+{
+	fujitsu_pci_counter_update(event);
+}
+
+#define PCI_PMU_FORMAT_ATTR(_name, _config)				      \
+	(&((struct dev_ext_attribute[]) {				      \
+		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
+		  .var = (void *) _config, }				      \
+	})[0].attr.attr)
+
+static struct attribute *fujitsu_pci_pmu_formats[] = {
+	PCI_PMU_FORMAT_ATTR(event, "config:0-7"),
+	NULL
+};
+
+static const struct attribute_group fujitsu_pci_pmu_format_group = {
+	.name = "format",
+	.attrs = fujitsu_pci_pmu_formats
+};
+
+static ssize_t pci_pmu_event_show(struct device *dev,
+				     struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define PCI_EVENT_ATTR(_name, _id)					     \
+	PMU_EVENT_ATTR_ID(_name, pci_pmu_event_show, _id)
+
+static struct attribute *fujitsu_pci_pmu_events[] = {
+	PCI_EVENT_ATTR(pci-port0-cycles, PCI_EVENT_PORT0_CYCLES),
+	PCI_EVENT_ATTR(pci-port0-read-count, PCI_EVENT_PORT0_READ_COUNT),
+	PCI_EVENT_ATTR(pci-port0-read-count-bus, PCI_EVENT_PORT0_READ_COUNT_BUS),
+	PCI_EVENT_ATTR(pci-port0-write-count, PCI_EVENT_PORT0_WRITE_COUNT),
+	PCI_EVENT_ATTR(pci-port0-write-count-bus, PCI_EVENT_PORT0_WRITE_COUNT_BUS),
+	PCI_EVENT_ATTR(pci-port1-cycles, PCI_EVENT_PORT1_CYCLES),
+	PCI_EVENT_ATTR(pci-port1-read-count, PCI_EVENT_PORT1_READ_COUNT),
+	PCI_EVENT_ATTR(pci-port1-read-count-bus, PCI_EVENT_PORT1_READ_COUNT_BUS),
+	PCI_EVENT_ATTR(pci-port1-write-count, PCI_EVENT_PORT1_WRITE_COUNT),
+	PCI_EVENT_ATTR(pci-port1-write-count-bus, PCI_EVENT_PORT1_WRITE_COUNT_BUS),
+	PCI_EVENT_ATTR(ea-pci, PCI_EVENT_EA_PCI),
+	NULL
+};
+
+static const struct attribute_group fujitsu_pci_pmu_events_group = {
+	.name = "events",
+	.attrs = fujitsu_pci_pmu_events
+};
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct pci_pmu *pcipmu = to_pci_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, &pcipmu->cpumask);
+}
+
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *fujitsu_pci_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group fujitsu_pci_pmu_cpumask_attr_group = {
+	.attrs = fujitsu_pci_pmu_cpumask_attrs
+};
+
+static const struct attribute_group *fujitsu_pci_pmu_attr_grps[] = {
+	&fujitsu_pci_pmu_format_group,
+	&fujitsu_pci_pmu_events_group,
+	&fujitsu_pci_pmu_cpumask_attr_group,
+	NULL
+};
+
+static int fujitsu_pci_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct pci_pmu *pcipmu = hlist_entry_safe(node, struct pci_pmu, node);
+
+	/* If there is not a CPU/PMU association pick this CPU */
+	if (cpumask_empty(&pcipmu->cpumask))
+		cpumask_set_cpu(cpu, &pcipmu->cpumask);
+
+	return 0;
+}
+
+static int fujitsu_pci_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct pci_pmu *pcipmu = hlist_entry_safe(node, struct pci_pmu, node);
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &pcipmu->cpumask))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pcipmu->pmu, cpu, target);
+	cpumask_set_cpu(target, &pcipmu->cpumask);
+
+	return 0;
+}
+
+static int fujitsu_pci_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acpi_device *acpi_dev;
+	struct pci_pmu *pcipmu;
+	struct resource *memrc;
+	char *name;
+	int ret;
+	u64 uid;
+
+	acpi_dev = ACPI_COMPANION(dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
+	ret = acpi_dev_uid_to_integer(acpi_dev, &uid);
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to read ACPI uid\n");
+
+	pcipmu = devm_kzalloc(dev, sizeof(*pcipmu), GFP_KERNEL);
+	name = devm_kasprintf(dev, GFP_KERNEL, "pci_iod%llu_pci%llu",
+			  (uid >> 4) & 0xF, uid & 0xF);
+	if (!pcipmu)
+		return -ENOMEM;
+
+	if (!name)
+		return -ENOMEM;
+
+	pcipmu->pmu = (struct pmu) {
+		.parent		= dev,
+		.task_ctx_nr	= perf_invalid_context,
+
+		.pmu_enable	= fujitsu_pci__pmu_enable,
+		.pmu_disable	= fujitsu_pci__pmu_disable,
+		.event_init	= fujitsu_pci__event_init,
+		.add		= fujitsu_pci__event_add,
+		.del		= fujitsu_pci__event_del,
+		.start		= fujitsu_pci__event_start,
+		.stop		= fujitsu_pci__event_stop,
+		.read		= fujitsu_pci__event_read,
+
+		.attr_groups	= fujitsu_pci_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE
+	};
+
+	pcipmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
+	if (IS_ERR(pcipmu->regs))
+		return PTR_ERR(pcipmu->regs);
+
+	fujitsu_pci__init(pcipmu);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0)
+		return ret;
+
+	ret = devm_request_irq(dev, ret, fujitsu_pci__handle_irq, 0,
+			       name, pcipmu);
+	if (ret)
+		return dev_err_probe(dev, ret, "Request for IRQ failed for slice @%pa\n",
+						&memrc->start);
+
+	/* Add this instance to the list used by the offline callback */
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_FUJITSU_PCI_ONLINE, &pcipmu->node);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error %d registering hotplug", ret);
+
+	ret = perf_pmu_register(&pcipmu->pmu, name, -1);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register PCI PMU (%d)\n", ret);
+
+	dev_dbg(dev, "Registered %s, type: %d\n", name, pcipmu->pmu.type);
+
+	return 0;
+}
+
+static const struct acpi_device_id fujitsu_pci_pmu_acpi_match[] = {
+	{ "FUJI200D", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, fujitsu_pci_pmu_acpi_match);
+
+static struct platform_driver fujitsu_pci_pmu_driver = {
+	.driver = {
+		.name = "fujitsu-pci-pmu",
+		.acpi_match_table = fujitsu_pci_pmu_acpi_match,
+		.suppress_bind_attrs = true
+	},
+	.probe = fujitsu_pci_pmu_probe
+};
+
+static int __init register_fujitsu_pci_pmu_driver(void)
+{
+	int ret;
+
+	/* Install a hook to update the reader CPU in case it goes offline */
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_FUJITSU_PCI_ONLINE,
+				      "perf/fujitsu/pci:online",
+				      fujitsu_pci_pmu_online_cpu,
+				      fujitsu_pci_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&fujitsu_pci_pmu_driver);
+}
+device_initcall(register_fujitsu_pci_pmu_driver);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 21006d1cda59..74b9b94404e3 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -229,6 +229,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
 	CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
 	CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE,
+	CPUHP_AP_PERF_ARM_FUJITSU_PCI_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.34.1


