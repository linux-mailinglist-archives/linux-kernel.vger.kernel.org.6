Return-Path: <linux-kernel+bounces-336623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A2983D29
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E601B1C22673
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7A81745;
	Tue, 24 Sep 2024 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DvMDTcv6"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D333B1A4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159522; cv=none; b=WJNioGNbmm3M1llt+W/4HVu3XRHqitOHxi5S5p36um4bA47ItPxURkbT1qW5ZM0BUquB7j1EpLcb2kz+8qCTMLEtF1gKNuKuMUZwyh42A1kcQS8TEvkiXkx9Xt8zCHYn4jE9tqY6y+oCgH4heoqCJOReDyr4mJUzRgs5HhrUJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159522; c=relaxed/simple;
	bh=LMUfCpUTV1BNkq0RjAQKlWxwWkUJU2R7eAR2NEja56A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UwlarueP2bZQqnlKBm0hLTbe1cQ/GLfEPQYorNfil+gP1sgJzgU2b3mIep73dA2Ld5cerSylwDYVlhOUlHUHtqr2eDab1WWOuf/2EyCZwXy5mG94J44LswZg8dcPaLYq8aNKdGmVbJ3U6RUMM/XSQiksxX4cjOSgOg8dtHM9LTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DvMDTcv6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NJxMxd018543;
	Mon, 23 Sep 2024 23:31:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=7sestQu9bX7t+tAeh/S8eLt
	ur2SV4NIcucRKIYjHlxU=; b=DvMDTcv6+tROE2t3gU2W5ko11+IEYJkjz0fhmZr
	nm7vhSZAwABl3iuNOpb2IUqvIz6wGidHMo/xccYQoaJSMefHnZk5gdUSJqbyABxx
	7Om0L+nQgQEdz5EGF3PpuCUjQqMmsiXBrwq5hJH6JpYPjLkKY4Vq5gdeWPOD7Mun
	b5075YUzMwf/SYTadzi8IVD80SV5i33HS+QM3r0H7dooqOCl86tz0LTAWrpz6TYi
	Z9DQz1ZulADVqfMN7v3ubVOuErFLqN7ns3SPi4bNGg3higb+J8UiLd9FLUrloHTA
	bOivljmEzOuvGWADiH3N3pQHrFwbIYzu05c4nNmWt2prp3w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41swnjue2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 23:31:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 23 Sep 2024 23:31:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 23 Sep 2024 23:31:32 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 7F6C83F7063;
	Mon, 23 Sep 2024 23:31:29 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v8] perf/marvell: Marvell PEM performance monitor support
Date: Tue, 24 Sep 2024 12:01:26 +0530
Message-ID: <20240924063126.460219-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jHZtZEf2upZy1gQaD3_89Nt7dnJ0eAO8
X-Proofpoint-ORIG-GUID: jHZtZEf2upZy1gQaD3_89Nt7dnJ0eAO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

PCI Express Interface PMU includes various performance counters
to monitor the data that is transmitted over the PCIe link. The
counters track various inbound and outbound transactions which
includes separate counters for posted/non-posted/completion TLPs.
Also, inbound and outbound memory read requests along with their
latencies can also be monitored. Address Translation Services(ATS)events
such as ATS Translation, ATS Page Request, ATS Invalidation along with
their corresponding latencies are also supported.

The performance counters are 64 bits wide.

For instance,
perf stat -e ib_tlp_pr <workload>
tracks the inbound posted TLPs for the workload.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---

v7->v8:

Added 64BIT dependency for compilation. 

 Documentation/admin-guide/perf/index.rst      |   1 +
 .../admin-guide/perf/mrvl-pem-pmu.rst         |  56 +++
 MAINTAINERS                                   |   6 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/marvell_pem_pmu.c                | 427 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 7 files changed, 499 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/mrvl-pem-pmu.rst
 create mode 100644 drivers/perf/marvell_pem_pmu.c

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 7eb3dcd6f4da..0e367ae9ec9c 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -25,3 +25,4 @@ Performance monitor support
    meson-ddr-pmu
    cxl
    ampere_cspmu
+   mrvl-pem-pmu
diff --git a/Documentation/admin-guide/perf/mrvl-pem-pmu.rst b/Documentation/admin-guide/perf/mrvl-pem-pmu.rst
new file mode 100644
index 000000000000..c39007149b97
--- /dev/null
+++ b/Documentation/admin-guide/perf/mrvl-pem-pmu.rst
@@ -0,0 +1,56 @@
+=================================================================
+Marvell Odyssey PEM Performance Monitoring Unit (PMU UNCORE)
+=================================================================
+
+The PCI Express Interface Units(PEM) are associated with a corresponding
+monitoring unit. This includes performance counters to track various
+characteristics of the data that is transmitted over the PCIe link.
+
+The counters track inbound and outbound transactions which
+includes separate counters for posted/non-posted/completion TLPs.
+Also, inbound and outbound memory read requests along with their
+latencies can also be monitored. Address Translation Services(ATS)events
+such as ATS Translation, ATS Page Request, ATS Invalidation along with
+their corresponding latencies are also tracked.
+
+There are separate 64 bit counters to measure posted/non-posted/completion
+tlps in inbound and outbound transactions. ATS events are measured by
+different counters.
+
+The PMU driver exposes the available events and format options under sysfs,
+/sys/bus/event_source/devices/mrvl_pcie_rc_pmu_<>/events/
+/sys/bus/event_source/devices/mrvl_pcie_rc_pmu_<>/format/
+
+Examples::
+
+  # perf list | grep mrvl_pcie_rc_pmu
+  mrvl_pcie_rc_pmu_<>/ats_inv/             [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ats_inv_latency/     [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ats_pri/             [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ats_pri_latency/     [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ats_trans/           [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ats_trans_latency/   [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_inflight/         [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_reads/            [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_req_no_ro_ebus/   [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_req_no_ro_ncb/    [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_tlp_cpl_partid/   [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_tlp_dwords_cpl_partid/ [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_tlp_dwords_npr/   [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_tlp_dwords_pr/    [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_tlp_npr/          [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ib_tlp_pr/           [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_inflight_partid/  [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_merges_cpl_partid/ [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_merges_npr_partid/ [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_merges_pr_partid/ [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_reads_partid/     [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_tlp_cpl_partid/   [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_tlp_dwords_cpl_partid/ [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_tlp_dwords_npr_partid/ [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_tlp_dwords_pr_partid/ [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_tlp_npr_partid/   [Kernel PMU event]
+  mrvl_pcie_rc_pmu_<>/ob_tlp_pr_partid/    [Kernel PMU event]
+
+
+  # perf stat -e ib_inflight,ib_reads,ib_req_no_ro_ebus,ib_req_no_ro_ncb <workload>
diff --git a/MAINTAINERS b/MAINTAINERS
index cc40a9d9b8cd..81b8a602fc05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13660,6 +13660,12 @@ S:	Supported
 F:	Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
 F:	drivers/net/ethernet/marvell/octeontx2/af/
 
+MARVELL PEM PMU DRIVER
+M:	Linu Cherian <lcherian@marvell.com>
+M:	Gowthami Thiagarajan <gthiagarajan@marvell.com>
+S:	Supported
+F:	drivers/perf/marvell_pem_pmu.c
+
 MARVELL PRESTERA ETHERNET SWITCH DRIVER
 M:	Taras Chornyi <taras.chornyi@plvision.eu>
 S:	Supported
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index aa9530b4064f..6f846f95e151 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -277,4 +277,11 @@ config CXL_PMU
 
 	  If unsure say 'm'.
 
+config MARVELL_PEM_PMU
+	tristate "MARVELL PEM PMU Support"
+	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
+	help
+	  Enable support for PCIe Interface performance monitoring
+	  on Marvell platform.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index d43df81d52f7..7b4c12182e7f 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
+obj-$(CONFIG_MARVELL_PEM_PMU) += marvell_pem_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
 obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
 obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_pmu.c
new file mode 100644
index 000000000000..d3aca94278fb
--- /dev/null
+++ b/drivers/perf/marvell_pem_pmu.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Marvell PEM(PCIe RC) Performance Monitor Driver
+ *
+ * Copyright (C) 2024 Marvell.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+/*
+ * Each of these events maps to a free running 64 bit counter
+ * with no event control, but can be reset.
+ *
+ */
+enum pem_events {
+	IB_TLP_NPR,
+	IB_TLP_PR,
+	IB_TLP_CPL,
+	IB_TLP_DWORDS_NPR,
+	IB_TLP_DWORDS_PR,
+	IB_TLP_DWORDS_CPL,
+	IB_INFLIGHT,
+	IB_READS,
+	IB_REQ_NO_RO_NCB,
+	IB_REQ_NO_RO_EBUS,
+	OB_TLP_NPR,
+	OB_TLP_PR,
+	OB_TLP_CPL,
+	OB_TLP_DWORDS_NPR,
+	OB_TLP_DWORDS_PR,
+	OB_TLP_DWORDS_CPL,
+	OB_INFLIGHT,
+	OB_READS,
+	OB_MERGES_NPR,
+	OB_MERGES_PR,
+	OB_MERGES_CPL,
+	ATS_TRANS,
+	ATS_TRANS_LATENCY,
+	ATS_PRI,
+	ATS_PRI_LATENCY,
+	ATS_INV,
+	ATS_INV_LATENCY,
+	PEM_EVENTIDS_MAX,
+};
+
+static u64 eventid_to_offset_table[] = {
+	[IB_TLP_NPR]	     = 0x0,
+	[IB_TLP_PR]	     = 0x8,
+	[IB_TLP_CPL]	     = 0x10,
+	[IB_TLP_DWORDS_NPR]  = 0x100,
+	[IB_TLP_DWORDS_PR]   = 0x108,
+	[IB_TLP_DWORDS_CPL]  = 0x110,
+	[IB_INFLIGHT]	     = 0x200,
+	[IB_READS]	     = 0x300,
+	[IB_REQ_NO_RO_NCB]   = 0x400,
+	[IB_REQ_NO_RO_EBUS]  = 0x408,
+	[OB_TLP_NPR]         = 0x500,
+	[OB_TLP_PR]          = 0x508,
+	[OB_TLP_CPL]         = 0x510,
+	[OB_TLP_DWORDS_NPR]  = 0x600,
+	[OB_TLP_DWORDS_PR]   = 0x608,
+	[OB_TLP_DWORDS_CPL]  = 0x610,
+	[OB_INFLIGHT]        = 0x700,
+	[OB_READS]	     = 0x800,
+	[OB_MERGES_NPR]      = 0x900,
+	[OB_MERGES_PR]       = 0x908,
+	[OB_MERGES_CPL]      = 0x910,
+	[ATS_TRANS]          = 0x2D18,
+	[ATS_TRANS_LATENCY]  = 0x2D20,
+	[ATS_PRI]            = 0x2D28,
+	[ATS_PRI_LATENCY]    = 0x2D30,
+	[ATS_INV]            = 0x2D38,
+	[ATS_INV_LATENCY]    = 0x2D40,
+};
+
+struct pem_pmu {
+	struct pmu pmu;
+	void __iomem *base;
+	unsigned int cpu;
+	struct	device *dev;
+	struct hlist_node node;
+};
+
+#define to_pem_pmu(p)	container_of(p, struct pem_pmu, pmu)
+
+static int eventid_to_offset(int eventid)
+{
+	return eventid_to_offset_table[eventid];
+}
+
+/* Events */
+static ssize_t pem_pmu_event_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define PEM_EVENT_ATTR(_name, _id)					\
+	(&((struct perf_pmu_events_attr[]) {				\
+	{ .attr = __ATTR(_name, 0444, pem_pmu_event_show, NULL),	\
+		.id = _id, }						\
+	})[0].attr.attr)
+
+static struct attribute *pem_perf_events_attrs[] = {
+	PEM_EVENT_ATTR(ib_tlp_npr, IB_TLP_NPR),
+	PEM_EVENT_ATTR(ib_tlp_pr, IB_TLP_PR),
+	PEM_EVENT_ATTR(ib_tlp_cpl_partid, IB_TLP_CPL),
+	PEM_EVENT_ATTR(ib_tlp_dwords_npr, IB_TLP_DWORDS_NPR),
+	PEM_EVENT_ATTR(ib_tlp_dwords_pr, IB_TLP_DWORDS_PR),
+	PEM_EVENT_ATTR(ib_tlp_dwords_cpl_partid, IB_TLP_DWORDS_CPL),
+	PEM_EVENT_ATTR(ib_inflight, IB_INFLIGHT),
+	PEM_EVENT_ATTR(ib_reads, IB_READS),
+	PEM_EVENT_ATTR(ib_req_no_ro_ncb, IB_REQ_NO_RO_NCB),
+	PEM_EVENT_ATTR(ib_req_no_ro_ebus, IB_REQ_NO_RO_EBUS),
+	PEM_EVENT_ATTR(ob_tlp_npr_partid, OB_TLP_NPR),
+	PEM_EVENT_ATTR(ob_tlp_pr_partid, OB_TLP_PR),
+	PEM_EVENT_ATTR(ob_tlp_cpl_partid, OB_TLP_CPL),
+	PEM_EVENT_ATTR(ob_tlp_dwords_npr_partid, OB_TLP_DWORDS_NPR),
+	PEM_EVENT_ATTR(ob_tlp_dwords_pr_partid, OB_TLP_DWORDS_PR),
+	PEM_EVENT_ATTR(ob_tlp_dwords_cpl_partid, OB_TLP_DWORDS_CPL),
+	PEM_EVENT_ATTR(ob_inflight_partid, OB_INFLIGHT),
+	PEM_EVENT_ATTR(ob_reads_partid, OB_READS),
+	PEM_EVENT_ATTR(ob_merges_npr_partid, OB_MERGES_NPR),
+	PEM_EVENT_ATTR(ob_merges_pr_partid, OB_MERGES_PR),
+	PEM_EVENT_ATTR(ob_merges_cpl_partid, OB_MERGES_CPL),
+	PEM_EVENT_ATTR(ats_trans, ATS_TRANS),
+	PEM_EVENT_ATTR(ats_trans_latency, ATS_TRANS_LATENCY),
+	PEM_EVENT_ATTR(ats_pri, ATS_PRI),
+	PEM_EVENT_ATTR(ats_pri_latency, ATS_PRI_LATENCY),
+	PEM_EVENT_ATTR(ats_inv, ATS_INV),
+	PEM_EVENT_ATTR(ats_inv_latency, ATS_INV_LATENCY),
+	NULL
+};
+
+static struct attribute_group pem_perf_events_attr_group = {
+	.name = "events",
+	.attrs = pem_perf_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-5");
+
+static struct attribute *pem_perf_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL
+};
+
+static struct attribute_group pem_perf_format_attr_group = {
+	.name = "format",
+	.attrs = pem_perf_format_attrs,
+};
+
+/* cpumask */
+static ssize_t pem_perf_cpumask_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct pem_pmu *pmu = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+}
+
+static struct device_attribute pem_perf_cpumask_attr =
+	__ATTR(cpumask, 0444, pem_perf_cpumask_show, NULL);
+
+static struct attribute *pem_perf_cpumask_attrs[] = {
+	&pem_perf_cpumask_attr.attr,
+	NULL
+};
+
+static struct attribute_group pem_perf_cpumask_attr_group = {
+	.attrs = pem_perf_cpumask_attrs,
+};
+
+static const struct attribute_group *pem_perf_attr_groups[] = {
+	&pem_perf_events_attr_group,
+	&pem_perf_cpumask_attr_group,
+	&pem_perf_format_attr_group,
+	NULL
+};
+
+static int pem_perf_event_init(struct perf_event *event)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event *sibling;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->attr.config >= PEM_EVENTIDS_MAX)
+		return -EINVAL;
+
+	if (is_sampling_event(event) ||
+	    event->attach_state & PERF_ATTACH_TASK) {
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0)
+		return -EOPNOTSUPP;
+
+	/*  We must NOT create groups containing mixed PMUs */
+	if (event->group_leader->pmu != event->pmu &&
+	    !is_software_event(event->group_leader))
+		return -EINVAL;
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (sibling->pmu != event->pmu &&
+		    !is_software_event(sibling))
+			return -EINVAL;
+	}
+	/*
+	 * Set ownership of event to one CPU, same event can not be observed
+	 * on multiple cpus at same time.
+	 */
+	event->cpu = pmu->cpu;
+	hwc->idx = -1;
+	return 0;
+}
+
+static u64 pem_perf_read_counter(struct pem_pmu *pmu,
+				 struct perf_event *event, int eventid)
+{
+	return readq_relaxed(pmu->base + eventid_to_offset(eventid));
+}
+
+static void pem_perf_event_update(struct perf_event *event)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev_count, new_count;
+
+	do {
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = pem_perf_read_counter(pmu, event, hwc->idx);
+	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
+
+	local64_add((new_count - prev_count), &event->count);
+}
+
+static void pem_perf_event_start(struct perf_event *event, int flags)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int eventid = hwc->idx;
+
+	/*
+	 * All counters are free-running and associated with
+	 * a fixed event to track in Hardware
+	 */
+	local64_set(&hwc->prev_count,
+		    pem_perf_read_counter(pmu, event, eventid));
+
+	hwc->state = 0;
+}
+
+static int pem_perf_event_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->idx = event->attr.config;
+	if (WARN_ON_ONCE(hwc->idx >= PEM_EVENTIDS_MAX))
+		return -EINVAL;
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		pem_perf_event_start(event, flags);
+
+	return 0;
+}
+
+static void pem_perf_event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (flags & PERF_EF_UPDATE)
+		pem_perf_event_update(event);
+
+	hwc->state |= PERF_HES_STOPPED;
+}
+
+static void pem_perf_event_del(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	pem_perf_event_stop(event, PERF_EF_UPDATE);
+	hwc->idx = -1;
+}
+
+static int pem_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct pem_pmu *pmu = hlist_entry_safe(node, struct pem_pmu,
+					       node);
+	unsigned int target;
+
+	if (cpu != pmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	pmu->cpu = target;
+	return 0;
+}
+
+static int pem_perf_probe(struct platform_device *pdev)
+{
+	struct pem_pmu *pem_pmu;
+	struct resource *res;
+	void __iomem *base;
+	char *name;
+	int ret;
+
+	pem_pmu = devm_kzalloc(&pdev->dev, sizeof(*pem_pmu), GFP_KERNEL);
+	if (!pem_pmu)
+		return -ENOMEM;
+
+	pem_pmu->dev = &pdev->dev;
+	platform_set_drvdata(pdev, pem_pmu);
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pem_pmu->base = base;
+
+	pem_pmu->pmu = (struct pmu) {
+		.module	      = THIS_MODULE,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr = perf_invalid_context,
+		.attr_groups = pem_perf_attr_groups,
+		.event_init  = pem_perf_event_init,
+		.add	     = pem_perf_event_add,
+		.del	     = pem_perf_event_del,
+		.start	     = pem_perf_event_start,
+		.stop	     = pem_perf_event_stop,
+		.read	     = pem_perf_event_update,
+	};
+
+	/* Choose this cpu to collect perf data */
+	pem_pmu->cpu = raw_smp_processor_id();
+
+	name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
+			      res->start);
+	if (!name)
+		return -ENOMEM;
+
+	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
+					 &pem_pmu->node);
+
+	ret = perf_pmu_register(&pem_pmu->pmu, name, -1);
+	if (ret)
+		goto error;
+
+	return 0;
+error:
+	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
+					    &pem_pmu->node);
+	return ret;
+}
+
+static void pem_perf_remove(struct platform_device *pdev)
+{
+	struct pem_pmu *pem_pmu = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
+					    &pem_pmu->node);
+
+	perf_pmu_unregister(&pem_pmu->pmu);
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id pem_pmu_acpi_match[] = {
+	{"MRVL000E", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, pem_pmu_acpi_match);
+#endif
+
+static struct platform_driver pem_pmu_driver = {
+	.driver	= {
+		.name   = "pem-pmu",
+		.acpi_match_table = ACPI_PTR(pem_pmu_acpi_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe		= pem_perf_probe,
+	.remove		= pem_perf_remove,
+};
+
+static int __init pem_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
+				      "perf/marvell/pem:online", NULL,
+				       pem_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&pem_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE);
+	return ret;
+}
+
+static void __exit pem_pmu_exit(void)
+{
+	platform_driver_unregister(&pem_pmu_driver);
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE);
+}
+
+module_init(pem_pmu_init);
+module_exit(pem_pmu_exit);
+
+MODULE_DESCRIPTION("Marvell PEM Perf driver");
+MODULE_AUTHOR("Linu Cherian <lcherian@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 9316c39260e0..254491a6d09b 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -228,6 +228,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
 	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+	CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.25.1


