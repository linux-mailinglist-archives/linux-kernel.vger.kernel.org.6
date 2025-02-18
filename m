Return-Path: <linux-kernel+bounces-518991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C1A396D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C40A188DE79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AF22FF30;
	Tue, 18 Feb 2025 09:19:53 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A41F94A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870393; cv=none; b=uM8u366VsxNxpsXHp5x3rzv5ZQEH7QFUXWz0vg5VRDl9WlVU/ToGeixCn8zeLaGN4QMuGCrffH++qb5ZMzs30hL+8hdE14ay030nMuMlcXpp5Nrkp+hzBl6CVZoVsAwBTdAwKODT6o9g44jSvorz4XnOGp0mRZ383hjUaDtQDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870393; c=relaxed/simple;
	bh=OpQaAEgjXkQgYy+FwljhEWNa0KlOFlYj4AmSra935aU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7o/B7LA2S1O7jIF5eij2f2fooTz5kKKifxoHB6vZUgKjnyzCGlinPRxxbSxYTlhS/7KH1p1KxwG2DMgfaDSzAw7U6iyu2DsMZVswMa6TBjFwOUnvNF4nJnwGC4Ajs8wxM0eP2tw0gqmEYKRXcS/NN3a99g6bAchhwd3alfZmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yxv5Q6NZRz1wn7M;
	Tue, 18 Feb 2025 17:15:54 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id E15AE1A016C;
	Tue, 18 Feb 2025 17:19:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 17:19:48 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH 3/9] drivers/perf: hisi: Add support for HiSilicon DDRC v3 PMU driver
Date: Tue, 18 Feb 2025 17:19:54 +0800
Message-ID: <20250218092000.41641-4-yangyicong@huawei.com>
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

HiSilicon DDRC v3 PMU has the different interrupt register offset
compared to the v2. Add device information of v3 PMU with ACPI
HID HISI0235.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 7e3c2436e96b..26eaa6d20c00 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -43,6 +43,11 @@
 #define DDRC_V2_EVENT_TYPE	0xe74
 #define DDRC_V2_PERF_CTRL	0xeA0
 
+/* DDRC interrupt registers definition in v3 */
+#define DDRC_V3_INT_MASK	0x534
+#define DDRC_V3_INT_STATUS	0x538
+#define DDRC_V3_INT_CLEAR	0x53C
+
 /* DDRC has 8-counters */
 #define DDRC_NR_COUNTERS	0x8
 #define DDRC_V1_PERF_CTRL_EN	0x2
@@ -460,9 +465,28 @@ static const struct hisi_pmu_dev_info hisi_ddrc_v2 = {
 	.private = &hisi_ddrc_v2_pmu_regs,
 };
 
+static struct hisi_ddrc_pmu_regs hisi_ddrc_v3_pmu_regs = {
+	.event_cnt = DDRC_V2_EVENT_CNT,
+	.event_ctrl = DDRC_V2_EVENT_CTRL,
+	.event_type = DDRC_V2_EVENT_TYPE,
+	.perf_ctrl = DDRC_V2_PERF_CTRL,
+	.perf_ctrl_en = DDRC_V2_PERF_CTRL_EN,
+	.int_mask = DDRC_V3_INT_MASK,
+	.int_clear = DDRC_V3_INT_CLEAR,
+	.int_status = DDRC_V3_INT_STATUS,
+};
+
+static const struct hisi_pmu_dev_info hisi_ddrc_v3 = {
+	.counter_bits = 48,
+	.check_event = DDRC_V2_NR_EVENTS,
+	.attr_groups = hisi_ddrc_pmu_v2_attr_groups,
+	.private = &hisi_ddrc_v3_pmu_regs,
+};
+
 static const struct acpi_device_id hisi_ddrc_pmu_acpi_match[] = {
 	{ "HISI0233", (kernel_ulong_t)&hisi_ddrc_v1 },
 	{ "HISI0234", (kernel_ulong_t)&hisi_ddrc_v2 },
+	{ "HISI0235", (kernel_ulong_t)&hisi_ddrc_v3 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, hisi_ddrc_pmu_acpi_match);
-- 
2.24.0


