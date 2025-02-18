Return-Path: <linux-kernel+bounces-518996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D76A396DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAB716A20C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084C2343C0;
	Tue, 18 Feb 2025 09:19:55 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627822FADE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870395; cv=none; b=BBliZzrSFJxjr5OqDcjJiEkOSFHx66TAMKMzwxr+JUZ4vnZyx/o0LhneYP9W6iHQbUdQ7jtXMx+7AQBUwWXSlpRUuWYANBtMgLr/NtKe6mYFimQRodWn3pVrYZvixRvik0QqCdiQ01uwNGFrRlb6vFCoOmVQM3lOAxtbamnoy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870395; c=relaxed/simple;
	bh=D2R0a2PF4tGX7afVGe1XRyxgZVQ+cDnMLbYPEEzvRaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0jxa1QC/UH/bhJRCYlPIFdUMELTPH+o+epOzFgVpy+T94DbAU+Xkc8U+fFeVM0ex99GjDdMlmtK6WTishLOpVL5jl7k6h/vQIw0KJvJ+h1SMnvTvJPMYQsGrZy6pcL7umizjPf9PfvJQfnEYK5zbwts0Rcc0C9e5N+VhVBRomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yxv4g23rJzjY6T;
	Tue, 18 Feb 2025 17:15:15 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C2491402C1;
	Tue, 18 Feb 2025 17:19:50 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 17:19:49 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH 6/9] drivers/perf: hisi: Relax the event number check of v2 PMUs
Date: Tue, 18 Feb 2025 17:19:57 +0800
Message-ID: <20250218092000.41641-7-yangyicong@huawei.com>
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

The supported event number range of each Uncore PMUs is provided by
each driver in hisi_pmu::check_event and out of range events
will be rejected. A later version with expanded event number range
needs to register the PMU with updated hisi_pmu::check_event
even if it's the only update, which means the expanded events
cannot be used unless the driver's updated. However the unsupported
events won't be counted by the hardware so we can relax the event
number check to allow the use the expanded events.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 2 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 7 +++----
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 2 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 3 +--
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 26eaa6d20c00..21c494881ca0 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -53,7 +53,7 @@
 #define DDRC_V1_PERF_CTRL_EN	0x2
 #define DDRC_V2_PERF_CTRL_EN	0x1
 #define DDRC_V1_NR_EVENTS	0x7
-#define DDRC_V2_NR_EVENTS	0x90
+#define DDRC_V2_NR_EVENTS	0xFF
 
 #define DDRC_EVENT_CNTn(base, n)	((base) + (n) * 8)
 #define DDRC_EVENT_TYPEn(base, n)	((base) + (n) * 4)
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index ca609db86046..78cd6d67f209 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -47,9 +47,8 @@
 #define HHA_SRCID_CMD		GENMASK(16, 6)
 #define HHA_SRCID_MSK		GENMASK(30, 20)
 #define HHA_DATSRC_SKT_EN	BIT(23)
-#define HHA_EVTYPE_NONE		0xff
+#define HHA_EVTYPE_MASK		GENMASK(7, 0)
 #define HHA_V1_NR_EVENT		0x65
-#define HHA_V2_NR_EVENT		0xCE
 
 HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_cmd, config1, 10, 0);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_msk, config1, 21, 11);
@@ -197,7 +196,7 @@ static void hisi_hha_pmu_write_evtype(struct hisi_pmu *hha_pmu, int idx,
 
 	/* Write event code to HHA_EVENT_TYPEx register */
 	val = readl(hha_pmu->base + reg);
-	val &= ~(HHA_EVTYPE_NONE << shift);
+	val &= ~(HHA_EVTYPE_MASK << shift);
 	val |= (type << shift);
 	writel(val, hha_pmu->base + reg);
 }
@@ -453,7 +452,7 @@ static int hisi_hha_pmu_dev_probe(struct platform_device *pdev,
 
 	if (hha_pmu->identifier >= HISI_PMU_V2) {
 		hha_pmu->counter_bits = 64;
-		hha_pmu->check_event = HHA_V2_NR_EVENT;
+		hha_pmu->check_event = HHA_EVTYPE_MASK;
 		hha_pmu->pmu_events.attr_groups = hisi_hha_pmu_v2_attr_groups;
 		hha_pmu->num_counters = HHA_V2_NR_COUNTERS;
 	} else {
diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index a0142684e379..80108c63cb60 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -440,7 +440,7 @@ static int hisi_pa_pmu_dev_probe(struct platform_device *pdev,
 	pa_pmu->pmu_events.attr_groups = pa_pmu->dev_info->attr_groups;
 	pa_pmu->num_counters = PA_NR_COUNTERS;
 	pa_pmu->ops = &hisi_uncore_pa_ops;
-	pa_pmu->check_event = 0xB0;
+	pa_pmu->check_event = PA_EVTYPE_MASK;
 	pa_pmu->counter_bits = 64;
 	pa_pmu->dev = &pdev->dev;
 	pa_pmu->on_cpu = -1;
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index dce7195320f2..ea31b64e05e2 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -58,7 +58,6 @@
 #define SLLC_V3_SRCID_CMD_MSK		GENMASK(9, 1)
 #define SLLC_V3_SRCID_MSK_MSK		GENMASK(18, 10)
 
-#define SLLC_NR_EVENTS			0x80
 #define SLLC_EVENT_CNTn(cnt0, n)	((cnt0) + (n) * 8)
 #define SLLC_FIRST_BIT(_mask)		(find_first_bit((const unsigned long *)&(_mask), 32))
 #define SLLC_FIELD_PREP(_mask, _val)	(_mask & (_val << SLLC_FIRST_BIT(_mask)))
@@ -476,7 +475,7 @@ static int hisi_sllc_pmu_dev_probe(struct platform_device *pdev,
 
 	sllc_pmu->pmu_events.attr_groups = hisi_sllc_pmu_v2_attr_groups;
 	sllc_pmu->ops = &hisi_uncore_sllc_ops;
-	sllc_pmu->check_event = SLLC_NR_EVENTS;
+	sllc_pmu->check_event = SLLC_EVTYPE_MASK;
 	sllc_pmu->counter_bits = 64;
 	sllc_pmu->num_counters = 8;
 	sllc_pmu->dev = &pdev->dev;
-- 
2.24.0


