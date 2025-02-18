Return-Path: <linux-kernel+bounces-518997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD2A396DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40197A3B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8D23536E;
	Tue, 18 Feb 2025 09:19:57 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0422FF4F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870396; cv=none; b=jSdwocqIK3ed9EBHGgDeU+QBTwO7v30o+EheEXk+jbcZTVZSYxPAG8ujaT3+q9CS/7zcH13dX3CjHJ83jGEi2mu6UBUv5doCZOKVS8hUEdlbB5CKc1EOp+ELtuXA03WVor3GZGgme9n1pzPmqRgduaq+NMH6Odc7WzdVtOPcRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870396; c=relaxed/simple;
	bh=3G6q8p2Szs2TPWlMdHDrbH2kJ1P3gfi7nwvuHTrNymI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puSb6C7Urf7SWKRZs/FL7XtApZ0y/7Ws4jqKPhvTjEMF/ST9onR8zNcfT77YzQc/rnVHcK8rdwXBNsQnamlXgjLSzDIIJugl3zFDeZoM4Qfmu9jkAeDi1whcsCocJbXO2dmdix3MB7vJYhmXKUs3hKRO8LprdZUitNsQ+IYzAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yxv5T4BB3z1wn7y;
	Tue, 18 Feb 2025 17:15:57 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 956321A0188;
	Tue, 18 Feb 2025 17:19:51 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 17:19:50 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH 9/9] drivers/perf: hisi: Add support for HiSilicon MN PMU driver
Date: Tue, 18 Feb 2025 17:20:00 +0800
Message-ID: <20250218092000.41641-10-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250218092000.41641-1-yangyicong@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Junhao He <hejunhao3@huawei.com>

MN (Miscellaneous Node) is a hybrid node in ARM CHI. It broadcasts the
following two types of requests: DVM operations and PCIe configuration.
MN PMU devices exist on both SCCL and SICL, so we named the MN pmu
driver after SCL (Super cluster) ID.
The MN PMU driver using the HiSilicon uncore PMU framework. And only
the event parameter is supported.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/Makefile             |   2 +-
 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c | 355 ++++++++++++++++++++
 2 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c

diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
index dcec8f39719d..186be3d02238 100644
--- a/drivers/perf/hisilicon/Makefile
+++ b/drivers/perf/hisilicon/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
 			  hisi_uncore_hha_pmu.o hisi_uncore_ddrc_pmu.o hisi_uncore_sllc_pmu.o \
 			  hisi_uncore_pa_pmu.o hisi_uncore_cpa_pmu.o hisi_uncore_uc_pmu.o \
-			  hisi_uncore_noc_pmu.o
+			  hisi_uncore_noc_pmu.o hisi_uncore_mn_pmu.o
 
 obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
 obj-$(CONFIG_HNS3_PMU) += hns3_pmu.o
diff --git a/drivers/perf/hisilicon/hisi_uncore_mn_pmu.c b/drivers/perf/hisilicon/hisi_uncore_mn_pmu.c
new file mode 100644
index 000000000000..bf9b326e40cf
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_mn_pmu.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HiSilicon SoC MN uncore Hardware event counters support
+ *
+ * Copyright (c) 2025 HiSilicon Technologies Co., Ltd.
+ */
+#include <linux/cpuhotplug.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+
+#include "hisi_uncore_pmu.h"
+
+/* Dynamic CPU hotplug state used by MN PMU */
+static enum cpuhp_state hisi_mn_pmu_online;
+
+/* MN register definition */
+#define HISI_MN_DYNAMIC_CTRL		0x400
+#define   HISI_MN_DYNAMIC_CTRL_EN	BIT(0)
+#define HISI_MN_PERF_CTRL_REG		0x408
+#define   HISI_MN_PERF_CTRL_EN		BIT(6)
+#define HISI_MN_INT_MASK_REG		0x800
+#define HISI_MN_INT_STATUS_REG		0x808
+#define HISI_MN_INT_CLEAR_REG		0x80C
+#define HISI_MN_EVENT_CTRL_REG		0x1C00
+#define HISI_MN_VERSION_REG		0x1C04
+#define HISI_MN_EVTYPE_REGn(n)		(0x1d00 + (n) * 4)
+#define   HISI_MN_EVTYPE_MASK		GENMASK(7, 0)
+#define HISI_MN_CNTR_REGn(n)		(0x1e00 + (n) * 8)
+
+#define HISI_MN_NR_COUNTERS		4
+#define HISI_MN_COUNTER_BITS		48
+#define HISI_MN_TIMEOUT_US		500U
+
+/*
+ * Each event request takes a certain amount of time to complete. If
+ * we counting the latency related event, we need to wait for the all
+ * requests complete. Otherwise, the value of counter is slightly larger.
+ */
+static void hisi_mn_pmu_counter_flush(struct hisi_pmu *mn_pmu)
+{
+	int ret;
+	u32 val;
+
+	val = readl(mn_pmu->base + HISI_MN_DYNAMIC_CTRL);
+	val |= HISI_MN_DYNAMIC_CTRL_EN;
+	writel(val, mn_pmu->base + HISI_MN_DYNAMIC_CTRL);
+
+	ret = readl_poll_timeout_atomic(mn_pmu->base + HISI_MN_DYNAMIC_CTRL,
+					val, !(val & HISI_MN_DYNAMIC_CTRL_EN),
+					1, HISI_MN_TIMEOUT_US);
+	if (ret)
+		dev_warn(mn_pmu->dev, "Counter flush timeout\n");
+}
+
+static u64 hisi_mn_pmu_read_counter(struct hisi_pmu *mn_pmu,
+				    struct hw_perf_event *hwc)
+{
+	return readq(mn_pmu->base + HISI_MN_CNTR_REGn(hwc->idx));
+}
+
+static void hisi_mn_pmu_write_counter(struct hisi_pmu *mn_pmu,
+				      struct hw_perf_event *hwc, u64 val)
+{
+	writeq(val, mn_pmu->base + HISI_MN_CNTR_REGn(hwc->idx));
+}
+
+static void hisi_mn_pmu_write_evtype(struct hisi_pmu *mn_pmu, int idx, u32 type)
+{
+	u32 val;
+
+	/*
+	 * Select the appropriate event select register.
+	 * There are 2 32-bit event select registers for the
+	 * 8 hardware counters, each event code is 8-bit wide.
+	 */
+	val = readl(mn_pmu->base + HISI_MN_EVTYPE_REGn(idx / 4));
+	val &= ~(HISI_MN_EVTYPE_MASK << HISI_PMU_EVTYPE_SHIFT(idx));
+	val |= (type << HISI_PMU_EVTYPE_SHIFT(idx));
+	writel(val, mn_pmu->base + HISI_MN_EVTYPE_REGn(idx / 4));
+}
+
+static void hisi_mn_pmu_start_counters(struct hisi_pmu *mn_pmu)
+{
+	u32 val;
+
+	val = readl(mn_pmu->base + HISI_MN_PERF_CTRL_REG);
+	val |= HISI_MN_PERF_CTRL_EN;
+	writel(val, mn_pmu->base + HISI_MN_PERF_CTRL_REG);
+}
+
+static void hisi_mn_pmu_stop_counters(struct hisi_pmu *mn_pmu)
+{
+	u32 val;
+
+	val = readl(mn_pmu->base + HISI_MN_PERF_CTRL_REG);
+	val &= ~HISI_MN_PERF_CTRL_EN;
+	writel(val, mn_pmu->base + HISI_MN_PERF_CTRL_REG);
+
+	hisi_mn_pmu_counter_flush(mn_pmu);
+}
+
+static void hisi_mn_pmu_enable_counter(struct hisi_pmu *mn_pmu,
+				       struct hw_perf_event *hwc)
+{
+	u32 val;
+
+	val = readl(mn_pmu->base + HISI_MN_EVENT_CTRL_REG);
+	val |= BIT(hwc->idx);
+	writel(val, mn_pmu->base + HISI_MN_EVENT_CTRL_REG);
+}
+
+static void hisi_mn_pmu_disable_counter(struct hisi_pmu *mn_pmu,
+					struct hw_perf_event *hwc)
+{
+	u32 val;
+
+	val = readl(mn_pmu->base + HISI_MN_EVENT_CTRL_REG);
+	val &= ~BIT(hwc->idx);
+	writel(val, mn_pmu->base + HISI_MN_EVENT_CTRL_REG);
+}
+
+static void hisi_mn_pmu_enable_counter_int(struct hisi_pmu *mn_pmu,
+					   struct hw_perf_event *hwc)
+{
+	u32 val;
+
+	val = readl(mn_pmu->base + HISI_MN_INT_MASK_REG);
+	val &= ~BIT(hwc->idx);
+	writel(val, mn_pmu->base + HISI_MN_INT_MASK_REG);
+}
+
+static void hisi_mn_pmu_disable_counter_int(struct hisi_pmu *mn_pmu,
+					    struct hw_perf_event *hwc)
+{
+	u32 val;
+
+	val = readl(mn_pmu->base + HISI_MN_INT_MASK_REG);
+	val |= BIT(hwc->idx);
+	writel(val, mn_pmu->base + HISI_MN_INT_MASK_REG);
+}
+
+static u32 hisi_mn_pmu_get_int_status(struct hisi_pmu *mn_pmu)
+{
+	return readl(mn_pmu->base + HISI_MN_INT_STATUS_REG);
+}
+
+static void hisi_mn_pmu_clear_int_status(struct hisi_pmu *mn_pmu, int idx)
+{
+	writel(BIT(idx), mn_pmu->base + HISI_MN_INT_CLEAR_REG);
+}
+
+static struct attribute *hisi_mn_pmu_format_attr[] = {
+	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
+	NULL
+};
+
+static const struct attribute_group hisi_mn_pmu_format_group = {
+	.name = "format",
+	.attrs = hisi_mn_pmu_format_attr,
+};
+
+static struct attribute *hisi_mn_pmu_events_attr[] = {
+	HISI_PMU_EVENT_ATTR(req_eobarrier_num,		0x00),
+	HISI_PMU_EVENT_ATTR(req_ecbarrier_num,		0x01),
+	HISI_PMU_EVENT_ATTR(req_dvmop_num,		0x02),
+	HISI_PMU_EVENT_ATTR(req_dvmsync_num,		0x03),
+	HISI_PMU_EVENT_ATTR(req_retry_num,		0x04),
+	HISI_PMU_EVENT_ATTR(req_writenosnp_num,		0x05),
+	HISI_PMU_EVENT_ATTR(req_readnosnp_num,		0x06),
+	HISI_PMU_EVENT_ATTR(snp_dvm_num,		0x07),
+	HISI_PMU_EVENT_ATTR(snp_dvmsync_num,		0x08),
+	HISI_PMU_EVENT_ATTR(l3t_req_dvm_num,		0x09),
+	HISI_PMU_EVENT_ATTR(l3t_req_dvmsync_num,	0x0A),
+	HISI_PMU_EVENT_ATTR(mn_req_dvm_num,		0x0B),
+	HISI_PMU_EVENT_ATTR(mn_req_dvmsync_num,		0x0C),
+	HISI_PMU_EVENT_ATTR(pa_req_dvm_num,		0x0D),
+	HISI_PMU_EVENT_ATTR(pa_req_dvmsync_num,		0x0E),
+	HISI_PMU_EVENT_ATTR(snp_dvm_latency,		0x80),
+	HISI_PMU_EVENT_ATTR(snp_dvmsync_latency,	0x81),
+	HISI_PMU_EVENT_ATTR(l3t_req_dvm_latency,	0x82),
+	HISI_PMU_EVENT_ATTR(l3t_req_dvmsync_latency,	0x83),
+	HISI_PMU_EVENT_ATTR(mn_req_dvm_latency,		0x84),
+	HISI_PMU_EVENT_ATTR(mn_req_dvmsync_latency,	0x85),
+	HISI_PMU_EVENT_ATTR(pa_req_dvm_latency,		0x86),
+	HISI_PMU_EVENT_ATTR(pa_req_dvmsync_latency,	0x87),
+	NULL
+};
+
+static const struct attribute_group hisi_mn_pmu_events_group = {
+	.name = "events",
+	.attrs = hisi_mn_pmu_events_attr,
+};
+
+static const struct attribute_group *hisi_mn_pmu_attr_groups[] = {
+	&hisi_mn_pmu_format_group,
+	&hisi_mn_pmu_events_group,
+	&hisi_pmu_cpumask_attr_group,
+	&hisi_pmu_identifier_group,
+	NULL
+};
+
+static const struct hisi_uncore_ops hisi_uncore_mn_ops = {
+	.write_evtype		= hisi_mn_pmu_write_evtype,
+	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
+	.start_counters		= hisi_mn_pmu_start_counters,
+	.stop_counters		= hisi_mn_pmu_stop_counters,
+	.enable_counter		= hisi_mn_pmu_enable_counter,
+	.disable_counter	= hisi_mn_pmu_disable_counter,
+	.enable_counter_int	= hisi_mn_pmu_enable_counter_int,
+	.disable_counter_int	= hisi_mn_pmu_disable_counter_int,
+	.write_counter		= hisi_mn_pmu_write_counter,
+	.read_counter		= hisi_mn_pmu_read_counter,
+	.get_int_status		= hisi_mn_pmu_get_int_status,
+	.clear_int_status	= hisi_mn_pmu_clear_int_status,
+};
+
+static int hisi_mn_pmu_dev_init(struct platform_device *pdev,
+				struct hisi_pmu *mn_pmu)
+{
+	int ret;
+
+	hisi_uncore_pmu_init_topology(mn_pmu, &pdev->dev);
+
+	if (mn_pmu->topo.scl_id < 0)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Failed to read MN scl id\n");
+
+	if (mn_pmu->topo.index_id < 0)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Failed to read MN index id\n");
+
+	mn_pmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mn_pmu->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(mn_pmu->base),
+				     "Failed to ioremap resource\n");
+
+	ret = hisi_uncore_pmu_init_irq(mn_pmu, pdev);
+	if (ret)
+		return ret;
+
+	mn_pmu->on_cpu = -1;
+	mn_pmu->dev = &pdev->dev;
+	mn_pmu->ops = &hisi_uncore_mn_ops;
+	mn_pmu->pmu_events.attr_groups = hisi_mn_pmu_attr_groups;
+	mn_pmu->check_event = HISI_MN_EVTYPE_MASK;
+	mn_pmu->num_counters = HISI_MN_NR_COUNTERS;
+	mn_pmu->counter_bits = HISI_MN_COUNTER_BITS;
+	mn_pmu->identifier = readl(mn_pmu->base + HISI_MN_VERSION_REG);
+	return 0;
+}
+
+static void hisi_mn_pmu_remove_cpuhp(void *hotplug_node)
+{
+	cpuhp_state_remove_instance_nocalls(hisi_mn_pmu_online, hotplug_node);
+}
+
+static void hisi_mn_pmu_unregister(void *pmu)
+{
+	perf_pmu_unregister(pmu);
+}
+
+static int hisi_mn_pmu_probe(struct platform_device *pdev)
+{
+	struct hisi_pmu *mn_pmu;
+	char *name;
+	int ret;
+
+	mn_pmu = devm_kzalloc(&pdev->dev, sizeof(*mn_pmu), GFP_KERNEL);
+	if (!mn_pmu)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mn_pmu);
+
+	ret = hisi_mn_pmu_dev_init(pdev, mn_pmu);
+	if (ret)
+		return ret;
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_scl%d_mn%d",
+				mn_pmu->topo.scl_id, mn_pmu->topo.index_id);
+	if (!name)
+		return -ENOMEM;
+
+	ret = cpuhp_state_add_instance(hisi_mn_pmu_online, &mn_pmu->node);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register cpu hotplug\n");
+
+	ret = devm_add_action_or_reset(&pdev->dev, hisi_mn_pmu_remove_cpuhp, &mn_pmu->node);
+	if (ret)
+		return ret;
+
+	hisi_pmu_init(mn_pmu, THIS_MODULE);
+
+	ret = perf_pmu_register(&mn_pmu->pmu, name, -1);
+	if (ret)
+		return dev_err_probe(mn_pmu->dev, ret, "Failed to register MN PMU\n");
+
+	return devm_add_action_or_reset(&pdev->dev, hisi_mn_pmu_unregister, &mn_pmu->pmu);
+}
+
+static const struct acpi_device_id hisi_mn_pmu_acpi_match[] = {
+	{ "HISI0222", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hisi_mn_pmu_acpi_match);
+
+static struct platform_driver hisi_mn_pmu_driver = {
+	.driver = {
+		.name = "hisi_mn_pmu",
+		.acpi_match_table = hisi_mn_pmu_acpi_match,
+		/*
+		 * We have not worked out a safe bind/unbind process,
+		 * Forcefully unbinding during sampling will lead to a
+		 * kernel panic, so this is not supported yet.
+		 */
+		.suppress_bind_attrs = true,
+	},
+	.probe = hisi_mn_pmu_probe,
+};
+
+static int __init hisi_mn_pmu_module_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "perf/hisi/mn:online",
+				      hisi_uncore_pmu_online_cpu,
+				      hisi_uncore_pmu_offline_cpu);
+	if (ret < 0) {
+		pr_err("hisi_mn_pmu: Failed to setup MN PMU hotplug: %d\n", ret);
+		return ret;
+	}
+	hisi_mn_pmu_online = ret;
+
+	ret = platform_driver_register(&hisi_mn_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(hisi_mn_pmu_online);
+
+	return ret;
+}
+module_init(hisi_mn_pmu_module_init);
+
+static void __exit hisi_mn_pmu_module_exit(void)
+{
+	platform_driver_unregister(&hisi_mn_pmu_driver);
+	cpuhp_remove_multi_state(hisi_mn_pmu_online);
+}
+module_exit(hisi_mn_pmu_module_exit);
+
+MODULE_IMPORT_NS("HISI_PMU");
+MODULE_DESCRIPTION("HiSilicon SoC MN uncore PMU driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Junhao He <hejunhao3@huawei.com>");
-- 
2.24.0


