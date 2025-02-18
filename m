Return-Path: <linux-kernel+bounces-518998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40594A396E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7D416B79E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402DA22FAFD;
	Tue, 18 Feb 2025 09:19:58 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618922FE0A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870397; cv=none; b=DX+iQMuqoll4RKz4bLoN7ydsfvt4/p/fM7u/5uO7s5UVm17FRZxF81vx7AbDkorJpOTaZMlkIwLwzTCBGjCr5p3AogJb3J9O0NhPUAJSJwK4Alaln76WM8LFyZf3yxhZ7PI5T8D/wklb/EdBBLtNmoNqPYnbzTktLmmi0hSLQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870397; c=relaxed/simple;
	bh=x6kKZg6fpoz1JIcRkd1PUWt+KLCS8qn3KkB1aAsWSnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bn1MB4XK1V992imSNcojXiLAFLWA5XRJBhuM+qtprxhlHjGneQpw/1pvXUkoEOKKMe3Coaw/b9k7QE6QYwi3pv7xWPrLJmQsU6sJZIvUhe/Yr+EHlADS5gx1LE/bwC7QZ4kOBSBX4ipuhopYlnhrftwftNXospcmWHpxVLS4Osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yxv5T6MGQz1ltby;
	Tue, 18 Feb 2025 17:15:57 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F9011A0188;
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
Subject: [PATCH 8/9] drivers/perf: hisi: Add support for HiSilicon NoC PMU
Date: Tue, 18 Feb 2025 17:19:59 +0800
Message-ID: <20250218092000.41641-9-yangyicong@huawei.com>
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

From: Yicong Yang <yangyicong@hisilicon.com>

Adds the support for HiSilicon NoC (Network on Chip) PMU which
will be used to monitor the events on the system bus. The PMU
device will be named after the SCL ID (either Super CPU cluster
or Super IO cluster) and the index ID, just similar to other
HiSilicon Uncore PMUs. Below PMU formats are provided besides
the event:

- ch: the transaction channel (data, request, response, etc) which
  can be used to filter the counting.
- tt_en: tracetag filtering enable. Just as other HiSilicon Uncore
  PMUs the NoC PMU supports only counting the transactions with
  tracetag.

The NoC PMU doesn't have an interrupt to indicate the overflow.
However we have a 64 bit counter which is large enough and it's
nearly impossible to overflow.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 Documentation/admin-guide/perf/hisi-pmu.rst  |  11 +
 drivers/perf/hisilicon/Makefile              |   3 +-
 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c | 391 +++++++++++++++++++
 3 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c

diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
index 48992a0b8e94..d858bd3a8802 100644
--- a/Documentation/admin-guide/perf/hisi-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pmu.rst
@@ -112,6 +112,17 @@ uring channel. It is 2 bits. Some important codes are as follows:
 - 2'b00: default value, count the events which sent to the both uring and
   uring_ext channel;
 
+6. ch: NoC PMU supports to filter the event counts of certain transaction
+channel with this option. The current supported channels are as follows:
+
+- 3'b010: Request channel
+- 3'b100: Snoop channel
+- 3'b110: Response channel
+- 3'b111: Data channel
+
+7. tt_en: NoC PMU supports to only count the transactions with tracetag by
+this option. See the 2nd list for more information about tracetag.
+
 Users could configure IDs to count data come from specific CCL/ICL, by setting
 srcid_cmd & srcid_msk, and data desitined for specific CCL/ICL by setting
 tgtid_cmd & tgtid_msk. A set bit in srcid_msk/tgtid_msk means the PMU will not
diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
index 48dcc8381ea7..dcec8f39719d 100644
--- a/drivers/perf/hisilicon/Makefile
+++ b/drivers/perf/hisilicon/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
 			  hisi_uncore_hha_pmu.o hisi_uncore_ddrc_pmu.o hisi_uncore_sllc_pmu.o \
-			  hisi_uncore_pa_pmu.o hisi_uncore_cpa_pmu.o hisi_uncore_uc_pmu.o
+			  hisi_uncore_pa_pmu.o hisi_uncore_cpa_pmu.o hisi_uncore_uc_pmu.o \
+			  hisi_uncore_noc_pmu.o
 
 obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
 obj-$(CONFIG_HNS3_PMU) += hns3_pmu.o
diff --git a/drivers/perf/hisilicon/hisi_uncore_noc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_noc_pmu.c
new file mode 100644
index 000000000000..e755f6d584e4
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_noc_pmu.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for HiSilicon Uncore NoC (Network on Chip) PMU device
+ *
+ * Copyright (c) 2025 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ */
+#include <linux/bitops.h>
+#include <linux/cpuhotplug.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/sysfs.h>
+
+#include "hisi_uncore_pmu.h"
+
+#define NOC_PMU_VERSION			0x1e00
+#define NOC_PMU_GLOBAL_CTRL		0x1e04
+#define   NOC_PMU_GLOBAL_CTRL_PMU_EN	BIT(0)
+#define   NOC_PMU_GLOBAL_CTRL_TT_EN	BIT(1)
+#define NOC_PMU_CNT_INFO		0x1e08
+#define   NOC_PMU_CNT_INFO_OVERFLOW(n)	BIT(n)
+#define NOC_PMU_EVENT_CTRL(n)		(0x1e20 + 4 * (n))
+#define   NOC_PMU_EVENT_CTRL_TYPE	GENMASK(4, 0)
+/*
+ * Note channel of 0x0 will reset the counter value, so don't do it before
+ * we read out the counter.
+ */
+#define   NOC_PMU_EVENT_CTRL_CHANNEL	GENMASK(10, 8)
+#define   NOC_PMU_EVENT_CTRL_EN		BIT(11)
+#define NOC_PMU_EVENT_COUNTER(n)	(0x1e80 + 8 * (n))
+
+#define NOC_PMU_NR_COUNTERS		4
+#define NOC_PMU_COUNTER_BITS		64
+
+#define NOC_PMU_CH_DEFAULT	0x7
+
+HISI_PMU_EVENT_ATTR_EXTRACTOR(ch, config1, 2, 0);
+HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_en, config1, 3, 3);
+
+/* Dynamic CPU hotplug state used by this PMU driver */
+static enum cpuhp_state hisi_noc_pmu_cpuhp_state;
+
+/*
+ * Tracetag filtering is not per event and all the events should keep
+ * the consistence. Return true if the new comer doesn't match the
+ * tracetag filtering configuration of the current scheduled events.
+ */
+static bool hisi_noc_pmu_check_global_filter(struct perf_event *curr,
+					     struct perf_event *new)
+{
+	return hisi_get_tt_en(curr) == hisi_get_tt_en(new);
+}
+
+static void hisi_noc_pmu_write_evtype(struct hisi_pmu *noc_pmu, int idx, u32 type)
+{
+	u32 reg;
+
+	reg = readl(noc_pmu->base + NOC_PMU_EVENT_CTRL(idx));
+	reg &= ~NOC_PMU_EVENT_CTRL_TYPE;
+	reg |= FIELD_PREP(NOC_PMU_EVENT_CTRL_TYPE, type);
+	writel(reg, noc_pmu->base + NOC_PMU_EVENT_CTRL(idx));
+}
+
+static int hisi_noc_pmu_get_event_idx(struct perf_event *event)
+{
+	struct hisi_pmu *noc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_pmu_hwevents *pmu_events = &noc_pmu->pmu_events;
+	int cur_idx;
+
+	cur_idx = find_first_bit(pmu_events->used_mask, noc_pmu->num_counters);
+	if (cur_idx != noc_pmu->num_counters &&
+	    !hisi_noc_pmu_check_global_filter(pmu_events->hw_events[cur_idx], event))
+		return -EAGAIN;
+
+	return hisi_uncore_pmu_get_event_idx(event);
+}
+
+static u64 hisi_noc_pmu_read_counter(struct hisi_pmu *noc_pmu,
+				     struct hw_perf_event *hwc)
+{
+	return readq(noc_pmu->base + NOC_PMU_EVENT_COUNTER(hwc->idx));
+}
+
+static void hisi_noc_pmu_write_counter(struct hisi_pmu *noc_pmu,
+				       struct hw_perf_event *hwc, u64 val)
+{
+	writeq(val, noc_pmu->base + NOC_PMU_EVENT_COUNTER(hwc->idx));
+}
+
+static void hisi_noc_pmu_enable_counter(struct hisi_pmu *noc_pmu,
+					struct hw_perf_event *hwc)
+{
+	u32 reg;
+
+	reg = readl(noc_pmu->base + NOC_PMU_EVENT_CTRL(hwc->idx));
+	reg |= NOC_PMU_EVENT_CTRL_EN;
+	writel(reg, noc_pmu->base + NOC_PMU_EVENT_CTRL(hwc->idx));
+}
+
+static void hisi_noc_pmu_disable_counter(struct hisi_pmu *noc_pmu,
+					 struct hw_perf_event *hwc)
+{
+	u32 reg;
+
+	reg = readl(noc_pmu->base + NOC_PMU_EVENT_CTRL(hwc->idx));
+	reg &= ~NOC_PMU_EVENT_CTRL_EN;
+	writel(reg, noc_pmu->base + NOC_PMU_EVENT_CTRL(hwc->idx));
+}
+
+static void hisi_noc_pmu_enable_counter_int(struct hisi_pmu *noc_pmu,
+					    struct hw_perf_event *hwc)
+{
+	/* We don't support interrupt, so a stub here. */
+}
+
+static void hisi_noc_pmu_disable_counter_int(struct hisi_pmu *noc_pmu,
+					     struct hw_perf_event *hwc)
+{
+}
+
+static void hisi_noc_pmu_start_counters(struct hisi_pmu *noc_pmu)
+{
+	u32 reg;
+
+	reg = readl(noc_pmu->base + NOC_PMU_GLOBAL_CTRL);
+	reg |= NOC_PMU_GLOBAL_CTRL_PMU_EN;
+	writel(reg, noc_pmu->base + NOC_PMU_GLOBAL_CTRL);
+}
+
+static void hisi_noc_pmu_stop_counters(struct hisi_pmu *noc_pmu)
+{
+	u32 reg;
+
+	reg = readl(noc_pmu->base + NOC_PMU_GLOBAL_CTRL);
+	reg &= ~NOC_PMU_GLOBAL_CTRL_PMU_EN;
+	writel(reg, noc_pmu->base + NOC_PMU_GLOBAL_CTRL);
+}
+
+static u32 hisi_noc_pmu_get_int_status(struct hisi_pmu *noc_pmu)
+{
+	return readl(noc_pmu->base + NOC_PMU_CNT_INFO);
+}
+
+static void hisi_noc_pmu_clear_int_status(struct hisi_pmu *noc_pmu, int idx)
+{
+	writel(~NOC_PMU_CNT_INFO_OVERFLOW(idx), noc_pmu->base + NOC_PMU_CNT_INFO);
+}
+
+static void hisi_noc_pmu_enable_filter(struct perf_event *event)
+{
+	struct hisi_pmu *noc_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 tt_en = hisi_get_tt_en(event);
+	u32 ch = hisi_get_ch(event);
+	u32 reg;
+
+	if (!ch)
+		ch = NOC_PMU_CH_DEFAULT;
+
+	reg = readl(noc_pmu->base + NOC_PMU_EVENT_CTRL(hwc->idx));
+	reg &= ~NOC_PMU_EVENT_CTRL_CHANNEL;
+	reg |= FIELD_PREP(NOC_PMU_EVENT_CTRL_CHANNEL, ch);
+	writel(reg, noc_pmu->base + NOC_PMU_EVENT_CTRL(hwc->idx));
+
+	/*
+	 * Since tracetag filter applies to all the counters, don't touch it
+	 * if user doesn't specify it explicitly.
+	 */
+	if (tt_en) {
+		reg = readl(noc_pmu->base + NOC_PMU_GLOBAL_CTRL);
+		reg |= NOC_PMU_GLOBAL_CTRL_TT_EN;
+		writel(reg, noc_pmu->base + NOC_PMU_GLOBAL_CTRL);
+	}
+}
+
+static void hisi_noc_pmu_disable_filter(struct perf_event *event)
+{
+	struct hisi_pmu *noc_pmu = to_hisi_pmu(event->pmu);
+	u32 tt_en = hisi_get_tt_en(event);
+	u32 reg;
+
+	/*
+	 * If we're not the last counter, don't touch the global tracetag
+	 * configuration.
+	 */
+	if (bitmap_weight(noc_pmu->pmu_events.used_mask, noc_pmu->num_counters) > 1)
+		return;
+
+	if (tt_en) {
+		reg = readl(noc_pmu->base + NOC_PMU_GLOBAL_CTRL);
+		reg &= ~NOC_PMU_GLOBAL_CTRL_TT_EN;
+		writel(reg, noc_pmu->base + NOC_PMU_GLOBAL_CTRL);
+	}
+}
+
+static const struct hisi_uncore_ops hisi_uncore_noc_ops = {
+	.write_evtype		= hisi_noc_pmu_write_evtype,
+	.get_event_idx		= hisi_noc_pmu_get_event_idx,
+	.read_counter		= hisi_noc_pmu_read_counter,
+	.write_counter		= hisi_noc_pmu_write_counter,
+	.enable_counter		= hisi_noc_pmu_enable_counter,
+	.disable_counter	= hisi_noc_pmu_disable_counter,
+	.enable_counter_int	= hisi_noc_pmu_enable_counter_int,
+	.disable_counter_int	= hisi_noc_pmu_disable_counter_int,
+	.start_counters		= hisi_noc_pmu_start_counters,
+	.stop_counters		= hisi_noc_pmu_stop_counters,
+	.get_int_status		= hisi_noc_pmu_get_int_status,
+	.clear_int_status	= hisi_noc_pmu_clear_int_status,
+	.enable_filter		= hisi_noc_pmu_enable_filter,
+	.disable_filter		= hisi_noc_pmu_disable_filter,
+};
+
+static struct attribute *hisi_noc_pmu_format_attrs[] = {
+	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
+	HISI_PMU_FORMAT_ATTR(ch, "config1:0-2"),
+	HISI_PMU_FORMAT_ATTR(tt_en, "config1:3"),
+	NULL
+};
+
+static const struct attribute_group hisi_noc_pmu_format_group = {
+	.name = "format",
+	.attrs = hisi_noc_pmu_format_attrs,
+};
+
+static struct attribute *hisi_noc_pmu_events_attrs[] = {
+	HISI_PMU_EVENT_ATTR(cycles, 0x0e),
+	/* Flux on/off the ring */
+	HISI_PMU_EVENT_ATTR(ingress_flow_sum, 0x1a),
+	HISI_PMU_EVENT_ATTR(egress_flow_sum, 0x17),
+	/* Buffer full duration on/off the ring */
+	HISI_PMU_EVENT_ATTR(ingress_buf_full, 0x19),
+	HISI_PMU_EVENT_ATTR(egress_buf_full, 0x12),
+	/* Failure packets count on/off the ring */
+	HISI_PMU_EVENT_ATTR(cw_ingress_fail, 0x01),
+	HISI_PMU_EVENT_ATTR(cc_ingress_fail, 0x09),
+	HISI_PMU_EVENT_ATTR(cw_egress_fail, 0x03),
+	HISI_PMU_EVENT_ATTR(cc_egress_fail, 0x0b),
+	/* Flux of the ring */
+	HISI_PMU_EVENT_ATTR(cw_main_flow_sum, 0x05),
+	HISI_PMU_EVENT_ATTR(cc_main_flow_sum, 0x0d),
+	NULL
+};
+
+static const struct attribute_group hisi_noc_pmu_events_group = {
+	.name = "events",
+	.attrs = hisi_noc_pmu_events_attrs,
+};
+
+static const struct attribute_group *hisi_noc_pmu_attr_groups[] = {
+	&hisi_noc_pmu_format_group,
+	&hisi_noc_pmu_events_group,
+	&hisi_pmu_cpumask_attr_group,
+	&hisi_pmu_identifier_group,
+	NULL
+};
+
+static int hisi_noc_pmu_dev_init(struct platform_device *pdev, struct hisi_pmu *noc_pmu)
+{
+	hisi_uncore_pmu_init_topology(noc_pmu, &pdev->dev);
+
+	if (noc_pmu->topo.scl_id < 0)
+		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get scl-id\n");
+
+	if (noc_pmu->topo.index_id < 0)
+		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get idx-id\n");
+
+	if (noc_pmu->topo.sub_id < 0)
+		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get sub-id\n");
+
+	noc_pmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(noc_pmu->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(noc_pmu->base),
+				     "fail to remap io memory\n");
+
+	noc_pmu->on_cpu = -1;
+	noc_pmu->dev = &pdev->dev;
+	noc_pmu->ops = &hisi_uncore_noc_ops;
+	noc_pmu->pmu_events.attr_groups = hisi_noc_pmu_attr_groups;
+	noc_pmu->num_counters = NOC_PMU_NR_COUNTERS;
+	noc_pmu->counter_bits = NOC_PMU_COUNTER_BITS;
+	noc_pmu->check_event = NOC_PMU_EVENT_CTRL_TYPE;
+	noc_pmu->identifier = readl(noc_pmu->base + NOC_PMU_VERSION);
+	return 0;
+}
+
+static void hisi_noc_pmu_remove_cpuhp_instance(void *hotplug_node)
+{
+	cpuhp_state_remove_instance_nocalls(hisi_noc_pmu_cpuhp_state, hotplug_node);
+}
+
+static void hisi_noc_pmu_unregister_pmu(void *pmu)
+{
+	perf_pmu_unregister(pmu);
+}
+
+static int hisi_noc_pmu_probe(struct platform_device *pdev)
+{
+	struct hisi_pmu *noc_pmu;
+	char *name;
+	int ret;
+
+	noc_pmu = devm_kzalloc(&pdev->dev, sizeof(*noc_pmu), GFP_KERNEL);
+	if (!noc_pmu)
+		return -ENOMEM;
+
+	/*
+	 * HiSilicon Uncore PMU framework needs to get common hisi_pmu device
+	 * by device's drvdata.
+	 */
+	platform_set_drvdata(pdev, noc_pmu);
+
+	ret = hisi_noc_pmu_dev_init(pdev, noc_pmu);
+	if (ret)
+		return ret;
+
+	ret = cpuhp_state_add_instance(hisi_noc_pmu_cpuhp_state, &noc_pmu->node);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to register cpuhp instance\n");
+
+	ret = devm_add_action_or_reset(&pdev->dev, hisi_noc_pmu_remove_cpuhp_instance,
+				       &noc_pmu->node);
+	if (ret)
+		return ret;
+
+	hisi_pmu_init(noc_pmu, THIS_MODULE);
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_scl%d_noc%d_%d",
+			      noc_pmu->topo.scl_id, noc_pmu->topo.index_id,
+			      noc_pmu->topo.sub_id);
+	if (!name)
+		return -ENOMEM;
+
+	ret = perf_pmu_register(&noc_pmu->pmu, name, -1);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to register PMU\n");
+
+	return devm_add_action_or_reset(&pdev->dev, hisi_noc_pmu_unregister_pmu,
+					&noc_pmu->pmu);
+}
+
+const struct acpi_device_id hisi_noc_pmu_ids[] = {
+	{ "HISI04E0", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hisi_noc_pmu_ids);
+
+static struct platform_driver hisi_noc_pmu_driver = {
+	.driver = {
+		.name = "hisi_noc_pmu",
+		.acpi_match_table = hisi_noc_pmu_ids,
+		.suppress_bind_attrs = true,
+	},
+	.probe = hisi_noc_pmu_probe,
+};
+
+static int __init hisi_noc_pmu_module_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "perf/hisi/noc:online",
+				      hisi_uncore_pmu_online_cpu,
+				      hisi_uncore_pmu_offline_cpu);
+	if (ret < 0) {
+		pr_err("hisi_noc_pmu: Fail to setup cpuhp callbacks, ret = %d\n", ret);
+		return ret;
+	}
+	hisi_noc_pmu_cpuhp_state = ret;
+
+	ret = platform_driver_register(&hisi_noc_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(hisi_noc_pmu_cpuhp_state);
+
+	return ret;
+}
+module_init(hisi_noc_pmu_module_init);
+
+static void __exit hisi_noc_pmu_module_exit(void)
+{
+	platform_driver_unregister(&hisi_noc_pmu_driver);
+	cpuhp_remove_multi_state(hisi_noc_pmu_cpuhp_state);
+}
+module_exit(hisi_noc_pmu_module_exit);
+
+MODULE_IMPORT_NS("HISI_PMU");
+MODULE_DESCRIPTION("HiSilicon SoC Uncore NoC PMU driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
-- 
2.24.0


