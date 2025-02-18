Return-Path: <linux-kernel+bounces-518993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B9A396D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC375169D85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638D232366;
	Tue, 18 Feb 2025 09:19:54 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7722F166
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870393; cv=none; b=CrdtgOh/J+/m/gMVOj1oYTciCcuR2w8XRKeiXan8AySuYjgg/O1a0UlRXf73ujVZesm64ggp347asLBkOy8NixW33u+5wOw3X2+qIz+A/omsmc/YesLF5kFH33kOxDCJeGfjPQytBNSX4oQhzeZoo9b4878yLE2NNsKDnfiz7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870393; c=relaxed/simple;
	bh=V/GkbWg7kZ+ZYIeX8C7x+60bfYcraBR0/Huket4YGwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjQr2Q6nJ0zMoAnynUq8qg9v/zCydUnNVdweYoPHgrlehzQiIHD+UI9fdh6DvXP9MLfKcU+yELvMJHq1FTDXfez9FD/awn8McztaiWq2ChWkls9iKMLVABsaZ1E21V4bSvRdEbX3gWQ4rRZncAIdJ7S0edv8qGCVJ185ARa79gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yxv6V440tz22wQJ;
	Tue, 18 Feb 2025 17:16:50 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id C82411400DD;
	Tue, 18 Feb 2025 17:19:49 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 17:19:49 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH 5/9] drivers/perf: hisi: Add support for HiSilicon SLLC v3 PMU driver
Date: Tue, 18 Feb 2025 17:19:56 +0800
Message-ID: <20250218092000.41641-6-yangyicong@huawei.com>
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

SLLC v3 PMU has the following changes compared to previous version:
a) update the register layout
b) update the definition of SRCID_CTRL and TGTID_CTRL registers.
   To be compatible with v2, we use maximum width (11 bits)
   and mask the extra length for themselves.
c) remove latency events (driver does not need to be adapted).

SLLC v3 PMU is identified with HID HISI0264.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index c1fd60d397c3..dce7195320f2 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -28,6 +28,18 @@
 #define SLLC_VERSION			0x1cf0
 #define SLLC_EVENT_CNT0_L		0x1d00
 
+/* SLLC registers definition in v3 */
+#define SLLC_V3_INT_MASK		0x6834
+#define SLLC_V3_INT_STATUS		0x6838
+#define SLLC_V3_INT_CLEAR		0x683c
+#define SLLC_V3_VERSION			0x6c00
+#define SLLC_V3_PERF_CTRL		0x6d00
+#define SLLC_V3_SRCID_CTRL		0x6d04
+#define SLLC_V3_TGTID_CTRL		0x6d08
+#define SLLC_V3_EVENT_CTRL		0x6d14
+#define SLLC_V3_EVENT_TYPE0		0x6d18
+#define SLLC_V3_EVENT_CNT0_L		0x6e00
+
 #define SLLC_EVTYPE_MASK		0xff
 #define SLLC_PERF_CTRL_EN		BIT(0)
 #define SLLC_FILT_EN			BIT(1)
@@ -40,6 +52,12 @@
 #define SLLC_TGTID_MAX_MSK		GENMASK(22, 12)
 #define SLLC_SRCID_CMD_MSK		GENMASK(11, 1)
 #define SLLC_SRCID_MSK_MSK		GENMASK(22, 12)
+
+#define SLLC_V3_TGTID_MIN_MSK		GENMASK(9, 1)
+#define SLLC_V3_TGTID_MAX_MSK		GENMASK(18, 10)
+#define SLLC_V3_SRCID_CMD_MSK		GENMASK(9, 1)
+#define SLLC_V3_SRCID_MSK_MSK		GENMASK(18, 10)
+
 #define SLLC_NR_EVENTS			0x80
 #define SLLC_EVENT_CNTn(cnt0, n)	((cnt0) + (n) * 8)
 #define SLLC_FIRST_BIT(_mask)		(find_first_bit((const unsigned long *)&(_mask), 32))
@@ -405,6 +423,27 @@ static const struct hisi_pmu_dev_info hisi_sllc_v2 = {
 	.private = &hisi_sllc_v2_pmu_regs,
 };
 
+static struct hisi_sllc_pmu_regs hisi_sllc_v3_pmu_regs = {
+	.int_mask = SLLC_V3_INT_MASK,
+	.int_clear = SLLC_V3_INT_CLEAR,
+	.int_status = SLLC_V3_INT_STATUS,
+	.perf_ctrl = SLLC_V3_PERF_CTRL,
+	.srcid_ctrl = SLLC_V3_SRCID_CTRL,
+	.srcid_mask_msk = SLLC_V3_SRCID_MSK_MSK,
+	.srcid_cmd_msk = SLLC_V3_SRCID_CMD_MSK,
+	.tgtid_ctrl = SLLC_V3_TGTID_CTRL,
+	.tgtid_max_msk = SLLC_V3_TGTID_MAX_MSK,
+	.tgtid_min_msk = SLLC_V3_TGTID_MIN_MSK,
+	.event_ctrl = SLLC_V3_EVENT_CTRL,
+	.event_type0 = SLLC_V3_EVENT_TYPE0,
+	.version = SLLC_V3_VERSION,
+	.event_cnt0 = SLLC_V3_EVENT_CNT0_L,
+};
+
+static const struct hisi_pmu_dev_info hisi_sllc_v3 = {
+	.private = &hisi_sllc_v3_pmu_regs,
+};
+
 static const struct hisi_uncore_ops hisi_uncore_sllc_ops = {
 	.write_evtype		= hisi_sllc_pmu_write_evtype,
 	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
@@ -498,6 +537,7 @@ static void hisi_sllc_pmu_remove(struct platform_device *pdev)
 
 static const struct acpi_device_id hisi_sllc_pmu_acpi_match[] = {
 	{ "HISI0263", (kernel_ulong_t)&hisi_sllc_v2 },
+	{ "HISI0264", (kernel_ulong_t)&hisi_sllc_v3 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, hisi_sllc_pmu_acpi_match);
-- 
2.24.0


