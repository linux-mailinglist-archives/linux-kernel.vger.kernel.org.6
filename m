Return-Path: <linux-kernel+bounces-417807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677D59D594B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79BEB22F56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50F916EBE8;
	Fri, 22 Nov 2024 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cev24n4A"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA43230982;
	Fri, 22 Nov 2024 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256363; cv=none; b=rS5JrJmyA5C2nBf0OJGN7FxjWYt5EMOpD6QGE5wYzWnOHnfyJeCy6v+H4PaWbgiZnbZx9pVnf1RQzeetMk856Gy2Vxlik3Pk9huzbL16DTMDu0aRJE4s88mYq4zJuXzj9Do72QqDMO+udZ1WAi5blU856J89iUsYbldgEmQLG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256363; c=relaxed/simple;
	bh=Ad+GFJbzLBMFqia7k0BxVtzWb4IxG3eAIFp13H8h8MM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2Pak5nsGDlyIXJG+PumS6Lm2xS6wKfg0R7DWKbfp5CU8QcrNuAuOZu5K0tSij03pvOKZ/9vVZ55byGtdc/6mtSIMQcm0iTuClmjbocJxv082Dou8Sx+q1nsL0l2XgdoSPPm7PPoAc9+tSf/P1+FhKKmSnQkSCYYknmy39Qfgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cev24n4A; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732256361; x=1763792361;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Ad+GFJbzLBMFqia7k0BxVtzWb4IxG3eAIFp13H8h8MM=;
  b=cev24n4AWc6oK7JkyP0le+YK1ILJvSwHK5cH/Ce6uzKDUPOO6elgzJg+
   DHYnHWF1UpLNjsCtqmN5JegGNeesBSZsXm+fbCZxPUrpTrWmmwTkpx93v
   RhQ71R12PVX9FhOAlrpIXrxhEUISOEbkxx0A9n0GZNFq/H44WNTBlQY6y
   qQmgQaM7Dp3cvUH7IEuvIuKMXsTIzLw79Lro/hsiZZbWoATDppmCMPf5f
   z9WLsnVOLSR2BwsPYURAVy2+46RQUd6Q9d/F/bJORShxUQedPYwo+/ghv
   PgqeFVKNDfk5javs1s0hjVEBsOXGzb1D3NuFq/UVSLCutsggWwnukmrPz
   g==;
X-CSE-ConnectionGUID: ZMCDSdULTlOjpYHGXPBeNA==
X-CSE-MsgGUID: WtnqCVv7Q5ObXTZu/5DZ3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="181300943"
X-IronPort-AV: E=Sophos;i="6.12,174,1728918000"; 
   d="scan'208";a="181300943"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:18:09 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D3D9FEA890;
	Fri, 22 Nov 2024 15:18:06 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A1A5574DE;
	Fri, 22 Nov 2024 15:18:06 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by oym-om1.fujitsu.com (Postfix) with ESMTP id F0F0A4007A424;
	Fri, 22 Nov 2024 15:18:05 +0900 (JST)
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
Subject: [PATCH v2 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Date: Fri, 22 Nov 2024 06:17:52 +0000
Message-Id: <20241122061753.2598688-2-fj5100bi@fujitsu.com>
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
control the Uncore MAC PMUs in Fujitsu chips.

This driver was created with reference to drivers/perf/qcom_l3_pmu.c.

This driver exports formatting and event information to sysfs so it can
be used by the perf user space tools with the syntaxes:

perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls

FUJITSU-MONAKA Specification URL:
https://github.com/fujitsu/FUJITSU-MONAKA

Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
---
 .../admin-guide/perf/fujitsu_mac_pmu.rst      |  75 +++
 Documentation/admin-guide/perf/index.rst      |   1 +
 drivers/perf/Kconfig                          |   9 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/fujitsu_mac_pmu.c                | 570 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 6 files changed, 657 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
 create mode 100644 drivers/perf/fujitsu_mac_pmu.c

diff --git a/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
new file mode 100644
index 000000000000..b6676526bde2
--- /dev/null
+++ b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
@@ -0,0 +1,75 @@
+====================================================
+Fujitsu Uncore MAC Performance Monitoring Unit (PMU)
+====================================================
+
+This driver supports the Uncore MAC PMUs found in Fujitsu chips.
+Each MAC PMU on these chips is exposed as a uncore perf PMU with device name
+mac_iod<iod>_mac<mac>_ch<ch>.
+
+The driver provides a description of its available events and configuration
+options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/.
+This driver exports:
+- formats, used by perf user space and other tools to configure events
+- events, used by perf user space and other tools to create events
+  symbolically, e.g.:
+    perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
+- cpumask, used by perf user space and other tools to know on which CPUs
+  to open the events
+
+This driver supports the following events:
+- cycles
+  This event counts MAC cycles at MAC frequency.
+- read-count
+  This event counts the number of read requests to MAC.
+- read-count-request
+  This event counts the number of read requests including retry to MAC.
+- read-count-return
+  This event counts the number of read requests to MAC.
+- read-count-request-pftgt
+  This event counts the number of read requests including retry with PFTGT
+  flag.
+- read-count-request-normal
+  This event counts the number of read requests including retry without PFTGT
+  flag.
+- read-count-return-pftgt-hit
+  This event counts the number of read requests which hit the PFTGT buffer.
+- read-count-return-pftgt-miss
+  This event counts the number of read requests which miss the PFTGT buffer.
+- read-wait
+  This event counts outstanding read requests issued by DDR memory controller
+  per cycle.
+- write-count
+  This event counts the number of write requests to MAC (including zero write,
+  full write, partial write, write cancel).
+- write-count-write
+  This event counts the number of full write requests to MAC (not including
+  zero write).
+- write-count-pwrite
+  This event counts the number of partial write requests to MAC.
+- memory-read-count
+  This event counts the number of read requests from MAC to memory.
+- memory-write-count
+  This event counts the number of full write requests from MAC to memory.
+- memory-pwrite-count
+  This event counts the number of partial write requests from MAC to memory.
+- ea-mac
+  This event counts energy consumption of the MAC.
+- ea-memory
+  This event counts energy consumption of the memory.
+- ea-memory-mac-read
+  This event counts the number of read requests from MAC to memory.
+- ea-memory-mac-write
+  This event counts the number of write requests from MAC to memory.
+- ea-memory-mac-pwrite
+  This event counts the number of partial write requests from MAC to memory.
+- ea-ha
+  This event counts energy consumption of the HA.
+
+  'ea' is the abbreviation for 'Energy Analyzer'.
+
+Examples for use with perf::
+
+  perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
+
+Given that these are uncore PMUs the driver does not support sampling, therefore
+"perf record" will not work. Per-task perf sessions are not supported.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index a58bd3f7e190..8cdcb426c6b4 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -27,3 +27,4 @@ Performance monitor support
    cxl
    ampere_cspmu
    mrvl-pem-pmu
+   fujitsu_mac_pmu
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4e268de351c4..3786aaffaee4 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -178,6 +178,15 @@ config FSL_IMX9_DDR_PMU
 	 can give information about memory throughput and other related
 	 events.
 
+config FUJITSU_MAC_PMU
+	bool "Fujitsu Uncore MAC PMU"
+	depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
+	help
+	 Provides support for the Uncore MAC performance monitor unit (PMU)
+	 in Fujitsu processors.
+	 Adds the Uncore MAC PMU into the perf events subsystem for
+	 monitoring Uncore MAC events.
+
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && ACPI
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index de71d2574857..c9a2ba78d34f 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARM_SMMU_V3_PMU) += arm_smmuv3_pmu.o
 obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
 obj-$(CONFIG_FSL_IMX9_DDR_PMU) += fsl_imx9_ddr_perf.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
+obj-$(CONFIG_FUJITSU_MAC_PMU) += fujitsu_mac_pmu.o
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
diff --git a/drivers/perf/fujitsu_mac_pmu.c b/drivers/perf/fujitsu_mac_pmu.c
new file mode 100644
index 000000000000..810f51f798a0
--- /dev/null
+++ b/drivers/perf/fujitsu_mac_pmu.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Uncore MAC PMUs in Fujitsu chips.
+ *
+ * See Documentation/admin-guide/perf/fujitsu_mac_pmu.rst for more details.
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
+#define MAC_NUM_COUNTERS  8
+/* Mask for the event type field within perf_event_attr.config and EVTYPE reg */
+#define MAC_EVTYPE_MASK   0xFF
+
+/* Perfmon registers */
+#define MAC_PM_EVCNTR(__cntr) (0x000 + ((__cntr) & 0x7) * 8)
+#define MAC_PM_CNTCTL(__cntr) (0x100 + ((__cntr) & 0x7) * 8)
+#define MAC_PM_EVTYPE(__cntr) (0x200 + ((__cntr) & 0x7) * 8)
+#define MAC_PM_CR         0x400
+#define MAC_PM_CNTENSET   0x410
+#define MAC_PM_CNTENCLR   0x418
+#define MAC_PM_INTENSET   0x420
+#define MAC_PM_INTENCLR   0x428
+#define MAC_PM_OVSR       0x440
+
+/* MAC_PM_CNTCTLx */
+#define PMCNT_RESET           0
+
+/* MAC_PM_EVTYPEx */
+#define EVSEL(__val)          ((__val) & MAC_EVTYPE_MASK)
+
+/* MAC_PM_CR */
+#define PM_RESET              (1UL << 1)
+#define PM_ENABLE             (1UL << 0)
+
+/* MAC_PM_CNTENSET */
+#define PMCNTENSET(__cntr)    (1UL << ((__cntr) & 0x7))
+
+/* MAC_PM_CNTENCLR */
+#define PMCNTENCLR(__cntr)    (1UL << ((__cntr) & 0x7))
+#define PM_CNTENCLR_RESET     0xFF
+
+/* MAC_PM_INTENSET */
+#define PMINTENSET(__cntr)    (1UL << ((__cntr) & 0x7))
+
+/* MAC_PM_INTENCLR */
+#define PMINTENCLR(__cntr)    (1UL << ((__cntr) & 0x7))
+#define PM_INTENCLR_RESET     0xFF
+
+/* MAC_PM_OVSR */
+#define PMOVSRCLR(__cntr)     (1UL << ((__cntr) & 0x7))
+#define PMOVSRCLR_RESET       0xFF
+
+#define MAC_EVENT_CYCLES			0x000
+#define MAC_EVENT_READ_COUNT			0x010
+#define MAC_EVENT_READ_COUNT_REQUEST		0x011
+#define MAC_EVENT_READ_COUNT_RETURN		0x012
+#define MAC_EVENT_READ_COUNT_REQUEST_PFTGT	0x013
+#define MAC_EVENT_READ_COUNT_REQUEST_NORMAL	0x014
+#define MAC_EVENT_READ_COUNT_RETURN_PFTGT_HIT	0x015
+#define MAC_EVENT_READ_COUNT_RETURN_PFTGT_MISS	0x016
+#define MAC_EVENT_READ_WAIT			0x017
+#define MAC_EVENT_WRITE_COUNT			0x020
+#define MAC_EVENT_WRITE_COUNT_WRITE		0x021
+#define MAC_EVENT_WRITE_COUNT_PWRITE		0x022
+#define MAC_EVENT_MEMORY_READ_COUNT		0x040
+#define MAC_EVENT_MEMORY_WRITE_COUNT		0x050
+#define MAC_EVENT_MEMORY_PWRITE_COUNT		0x060
+#define MAC_EVENT_EA_MAC			0x080
+#define MAC_EVENT_EA_MEMORY			0x090
+#define MAC_EVENT_EA_MEMORY_MAC_READ		0x091
+#define MAC_EVENT_EA_MEMORY_MAC_WRITE		0x092
+#define MAC_EVENT_EA_MEMORY_MAC_PWRITE		0x093
+#define MAC_EVENT_EA_HA			0x0a0
+
+struct mac_pmu {
+	struct pmu		pmu;
+	struct hlist_node	node;
+	void __iomem		*regs;
+	struct perf_event	*events[MAC_NUM_COUNTERS];
+	unsigned long		used_mask[BITS_TO_LONGS(MAC_NUM_COUNTERS)];
+	cpumask_t		cpumask;
+};
+
+#define to_mac_pmu(p) (container_of(p, struct mac_pmu, pmu))
+
+static void fujitsu_mac_counter_start(struct perf_event *event)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	/* Initialize the hardware counter and reset prev_count*/
+	local64_set(&event->hw.prev_count, 0);
+	writeq_relaxed(0, macpmu->regs + MAC_PM_EVCNTR(idx));
+
+	/* Set the event type */
+	writeq_relaxed(EVSEL(event->attr.config), macpmu->regs + MAC_PM_EVTYPE(idx));
+
+	/* Enable interrupt generation by this counter */
+	writeq_relaxed(PMINTENSET(idx), macpmu->regs + MAC_PM_INTENSET);
+
+	/* Finally, enable the counter */
+	writeq_relaxed(PMCNT_RESET, macpmu->regs + MAC_PM_CNTCTL(idx));
+	writeq_relaxed(PMCNTENSET(idx), macpmu->regs + MAC_PM_CNTENSET);
+}
+
+static void fujitsu_mac_counter_stop(struct perf_event *event,
+					      int flags)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	/* Disable the counter */
+	writeq_relaxed(PMCNTENCLR(idx), macpmu->regs + MAC_PM_CNTENCLR);
+
+	/* Disable interrupt generation by this counter */
+	writeq_relaxed(PMINTENCLR(idx), macpmu->regs + MAC_PM_INTENCLR);
+}
+
+static void fujitsu_mac_counter_update(struct perf_event *event)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u64 prev, new;
+
+	do {
+		prev = local64_read(&event->hw.prev_count);
+		new = readq_relaxed(macpmu->regs + MAC_PM_EVCNTR(idx));
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, new) != prev);
+
+	local64_add(new - prev, &event->count);
+}
+
+static inline void fujitsu_mac__init(struct mac_pmu *macpmu)
+{
+	int i;
+
+	writeq_relaxed(PM_RESET, macpmu->regs + MAC_PM_CR);
+
+	writeq_relaxed(PM_CNTENCLR_RESET, macpmu->regs + MAC_PM_CNTENCLR);
+	writeq_relaxed(PM_INTENCLR_RESET, macpmu->regs + MAC_PM_INTENCLR);
+	writeq_relaxed(PMOVSRCLR_RESET, macpmu->regs + MAC_PM_OVSR);
+
+	for (i = 0; i < MAC_NUM_COUNTERS; ++i) {
+		writeq_relaxed(PMCNT_RESET, macpmu->regs + MAC_PM_CNTCTL(i));
+		writeq_relaxed(EVSEL(0), macpmu->regs + MAC_PM_EVTYPE(i));
+	}
+
+	/*
+	 * Use writeq here to ensure all programming commands are done
+	 * before proceeding
+	 */
+	writeq(PM_ENABLE, macpmu->regs + MAC_PM_CR);
+}
+
+static irqreturn_t fujitsu_mac__handle_irq(int irq_num, void *data)
+{
+	struct mac_pmu *macpmu = data;
+	/* Read the overflow status register */
+	long status = readq_relaxed(macpmu->regs + MAC_PM_OVSR);
+	int idx;
+
+	if (status == 0)
+		return IRQ_NONE;
+
+	/* Clear the bits we read on the overflow status register */
+	writeq_relaxed(status, macpmu->regs + MAC_PM_OVSR);
+
+	for_each_set_bit(idx, &status, MAC_NUM_COUNTERS) {
+		struct perf_event *event;
+
+		event = macpmu->events[idx];
+		if (!event)
+			continue;
+
+		fujitsu_mac_counter_update(event);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void fujitsu_mac__pmu_enable(struct pmu *pmu)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(pmu);
+
+	/* Ensure the other programming commands are observed before enabling */
+	wmb();
+
+	writeq_relaxed(PM_ENABLE, macpmu->regs + MAC_PM_CR);
+}
+
+static void fujitsu_mac__pmu_disable(struct pmu *pmu)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(pmu);
+
+	writeq_relaxed(0, macpmu->regs + MAC_PM_CR);
+
+	/* Ensure the basic counter unit is stopped before proceeding */
+	wmb();
+}
+
+/*
+ * We must NOT create groups containing events from multiple hardware PMUs,
+ * although mixing different software and hardware PMUs is allowed.
+ */
+static bool fujitsu_mac__validate_event_group(struct perf_event *event)
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
+	return counters <= MAC_NUM_COUNTERS;
+}
+
+static int fujitsu_mac__event_init(struct perf_event *event)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
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
+	if (!fujitsu_mac__validate_event_group(event))
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
+	event->cpu = cpumask_first(&macpmu->cpumask);
+
+	return 0;
+}
+
+static void fujitsu_mac__event_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->state = 0;
+	fujitsu_mac_counter_start(event);
+}
+
+static void fujitsu_mac__event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	fujitsu_mac_counter_stop(event, flags);
+	if (flags & PERF_EF_UPDATE)
+		fujitsu_mac_counter_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int fujitsu_mac__event_add(struct perf_event *event, int flags)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/* Try to allocate a counter. */
+	idx = bitmap_find_free_region(macpmu->used_mask, MAC_NUM_COUNTERS, 0);
+	if (idx < 0)
+		/* The counters are all in use. */
+		return -EAGAIN;
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	macpmu->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		fujitsu_mac__event_start(event, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void fujitsu_mac__event_del(struct perf_event *event, int flags)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Stop and clean up */
+	fujitsu_mac__event_stop(event,  flags | PERF_EF_UPDATE);
+	macpmu->events[hwc->idx] = NULL;
+	bitmap_release_region(macpmu->used_mask, hwc->idx, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+}
+
+static void fujitsu_mac__event_read(struct perf_event *event)
+{
+	fujitsu_mac_counter_update(event);
+}
+
+#define MAC_PMU_FORMAT_ATTR(_name, _config)				      \
+	(&((struct dev_ext_attribute[]) {				      \
+		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
+		  .var = (void *) _config, }				      \
+	})[0].attr.attr)
+
+static struct attribute *fujitsu_mac_pmu_formats[] = {
+	MAC_PMU_FORMAT_ATTR(event, "config:0-7"),
+	NULL
+};
+
+static const struct attribute_group fujitsu_mac_pmu_format_group = {
+	.name = "format",
+	.attrs = fujitsu_mac_pmu_formats
+};
+
+static ssize_t mac_pmu_event_show(struct device *dev,
+				     struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define MAC_EVENT_ATTR(_name, _id)					     \
+	PMU_EVENT_ATTR_ID(_name, mac_pmu_event_show, _id)
+
+static struct attribute *fujitsu_mac_pmu_events[] = {
+	MAC_EVENT_ATTR(cycles, MAC_EVENT_CYCLES),
+	MAC_EVENT_ATTR(read-count, MAC_EVENT_READ_COUNT),
+	MAC_EVENT_ATTR(read-count-request, MAC_EVENT_READ_COUNT_REQUEST),
+	MAC_EVENT_ATTR(read-count-return, MAC_EVENT_READ_COUNT_RETURN),
+	MAC_EVENT_ATTR(read-count-request-pftgt, MAC_EVENT_READ_COUNT_REQUEST_PFTGT),
+	MAC_EVENT_ATTR(read-count-request-normal, MAC_EVENT_READ_COUNT_REQUEST_NORMAL),
+	MAC_EVENT_ATTR(read-count-return-pftgt-hit, MAC_EVENT_READ_COUNT_RETURN_PFTGT_HIT),
+	MAC_EVENT_ATTR(read-count-return-pftgt-miss, MAC_EVENT_READ_COUNT_RETURN_PFTGT_MISS),
+	MAC_EVENT_ATTR(read-wait, MAC_EVENT_READ_WAIT),
+	MAC_EVENT_ATTR(write-count, MAC_EVENT_WRITE_COUNT),
+	MAC_EVENT_ATTR(write-count-write, MAC_EVENT_WRITE_COUNT_WRITE),
+	MAC_EVENT_ATTR(write-count-pwrite, MAC_EVENT_WRITE_COUNT_PWRITE),
+	MAC_EVENT_ATTR(memory-read-count, MAC_EVENT_MEMORY_READ_COUNT),
+	MAC_EVENT_ATTR(memory-write-count, MAC_EVENT_MEMORY_WRITE_COUNT),
+	MAC_EVENT_ATTR(memory-pwrite-count, MAC_EVENT_MEMORY_PWRITE_COUNT),
+	MAC_EVENT_ATTR(ea-mac, MAC_EVENT_EA_MAC),
+	MAC_EVENT_ATTR(ea-memory, MAC_EVENT_EA_MEMORY),
+	MAC_EVENT_ATTR(ea-memory-mac-read, MAC_EVENT_EA_MEMORY_MAC_READ),
+	MAC_EVENT_ATTR(ea-memory-mac-write, MAC_EVENT_EA_MEMORY_MAC_WRITE),
+	MAC_EVENT_ATTR(ea-memory-mac-pwrite, MAC_EVENT_EA_MEMORY_MAC_PWRITE),
+	MAC_EVENT_ATTR(ea-ha, MAC_EVENT_EA_HA),
+	NULL
+};
+
+static const struct attribute_group fujitsu_mac_pmu_events_group = {
+	.name = "events",
+	.attrs = fujitsu_mac_pmu_events
+};
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, &macpmu->cpumask);
+}
+
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *fujitsu_mac_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group fujitsu_mac_pmu_cpumask_attr_group = {
+	.attrs = fujitsu_mac_pmu_cpumask_attrs
+};
+
+static const struct attribute_group *fujitsu_mac_pmu_attr_grps[] = {
+	&fujitsu_mac_pmu_format_group,
+	&fujitsu_mac_pmu_events_group,
+	&fujitsu_mac_pmu_cpumask_attr_group,
+	NULL
+};
+
+static int fujitsu_mac_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct mac_pmu *macpmu = hlist_entry_safe(node, struct mac_pmu, node);
+
+	/* If there is not a CPU/PMU association pick this CPU */
+	if (cpumask_empty(&macpmu->cpumask))
+		cpumask_set_cpu(cpu, &macpmu->cpumask);
+
+	return 0;
+}
+
+static int fujitsu_mac_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct mac_pmu *macpmu = hlist_entry_safe(node, struct mac_pmu, node);
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &macpmu->cpumask))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&macpmu->pmu, cpu, target);
+	cpumask_set_cpu(target, &macpmu->cpumask);
+
+	return 0;
+}
+
+static int fujitsu_mac_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acpi_device *acpi_dev;
+	struct mac_pmu *macpmu;
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
+	macpmu = devm_kzalloc(dev, sizeof(*macpmu), GFP_KERNEL);
+	name = devm_kasprintf(dev, GFP_KERNEL, "mac_iod%llu_mac%llu_ch%llu",
+			  (uid >> 8) & 0xF, (uid >> 4) & 0xF, uid & 0xF);
+	if (!macpmu)
+		return -ENOMEM;
+
+	if (!name)
+		return -ENOMEM;
+
+	macpmu->pmu = (struct pmu) {
+		.parent		= dev,
+		.task_ctx_nr	= perf_invalid_context,
+
+		.pmu_enable	= fujitsu_mac__pmu_enable,
+		.pmu_disable	= fujitsu_mac__pmu_disable,
+		.event_init	= fujitsu_mac__event_init,
+		.add		= fujitsu_mac__event_add,
+		.del		= fujitsu_mac__event_del,
+		.start		= fujitsu_mac__event_start,
+		.stop		= fujitsu_mac__event_stop,
+		.read		= fujitsu_mac__event_read,
+
+		.attr_groups	= fujitsu_mac_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE
+	};
+
+	macpmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
+	if (IS_ERR(macpmu->regs))
+		return PTR_ERR(macpmu->regs);
+
+	fujitsu_mac__init(macpmu);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0)
+		return ret;
+
+	ret = devm_request_irq(dev, ret, fujitsu_mac__handle_irq, 0,
+			       name, macpmu);
+	if (ret)
+		return dev_err_probe(dev, ret, "Request for IRQ failed for slice @%pa\n",
+						&memrc->start);
+
+	/* Add this instance to the list used by the offline callback */
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE, &macpmu->node);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error %d registering hotplug", ret);
+
+	ret = perf_pmu_register(&macpmu->pmu, name, -1);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register MAC PMU (%d)\n", ret);
+
+	dev_dbg(dev, "Registered %s, type: %d\n", name, macpmu->pmu.type);
+
+	return 0;
+}
+
+static const struct acpi_device_id fujitsu_mac_pmu_acpi_match[] = {
+	{ "FUJI200C", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, fujitsu_mac_pmu_acpi_match);
+
+static struct platform_driver fujitsu_mac_pmu_driver = {
+	.driver = {
+		.name = "fujitsu-mac-pmu",
+		.acpi_match_table = fujitsu_mac_pmu_acpi_match,
+		.suppress_bind_attrs = true
+	},
+	.probe = fujitsu_mac_pmu_probe
+};
+
+static int __init register_fujitsu_mac_pmu_driver(void)
+{
+	int ret;
+
+	/* Install a hook to update the reader CPU in case it goes offline */
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE,
+				      "perf/fujitsu/mac:online",
+				      fujitsu_mac_pmu_online_cpu,
+				      fujitsu_mac_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&fujitsu_mac_pmu_driver);
+}
+device_initcall(register_fujitsu_mac_pmu_driver);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index a04b73c40173..21006d1cda59 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -228,6 +228,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
 	CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
+	CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.34.1


