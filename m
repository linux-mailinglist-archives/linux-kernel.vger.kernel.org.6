Return-Path: <linux-kernel+bounces-238330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB092485A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984E9281BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1241CCCD7;
	Tue,  2 Jul 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="XXelbVcu"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2043.outbound.protection.outlook.com [40.95.54.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF86E5ED;
	Tue,  2 Jul 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948790; cv=fail; b=dzcqT+kkOYsWEmeRMTkZI3xvI15DtFXm0cqTxmTZKpWPlUBIMsg0TpJJ/DCqvC+Hu6XhIW51K0rB0Y67V62hQlFJsXdlvw4DLBqy5AeYRgrLy0K7FDwKEzBvIZUp6+I9UpT8VtCcKJpTtjQ+u1Or+yHkqCItBQRnj5mZii7R2hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948790; c=relaxed/simple;
	bh=x+HpfM6gWPQ/yy5Sq+enIeSQBQNxyLtWGe5nxdMBB80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvfuDeJhzqT0B8t83GqMSQfkRe39zHyWwrntFEoS4H9ONGIb1qo5toS2mhopvng/WIKXwRKV4XyPITXP/Q2DhH5aZ+5x7SWPQFe3100Y2vXbhqAfT1KaZJF3TVwaQoKfA9IAliE/vUf7CAfcwPF1aRd7ZxGMPgayluOW/LSMHtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=XXelbVcu; arc=fail smtp.client-ip=40.95.54.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGeYhDU5gjL5N5LLyXPSFTf4PsvXPdaO/rzRggdKYMuIPvrJx+9xqAKWpyQpX81V366p+NlE86a3uwejuDlsHIXyroKScLvpubq2nVARpP8uA9j55o5A7xklNDkS8M8zwTfi1klzeFTW+wHKbNkcRiW92mrQ0RmMWE76L3cD4AVTDnAczMOtJ2+N1Ganhk5fzvqRvt/6P8FP7cIS5OfKzZYbJB9h3nj911PmyvgBWS1sKxtie2QLQISH/+b8w5njVUsdBLe4jHsqv9TmKP7uTKGg41SlUSznHS/nIQgMVdaSivcCQpYJ+CobTf63wYhgv0FgIXRoUZAZhORRrHYoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBNRui6a3llWT8awtxN8qovYX9LPiG7+BiZ49N8O13w=;
 b=Tqvngx2NOFlQu1NQuDy809o/j/K96HU24gGV+eVrujulbT4oU646N3qauPvN5emHU89I33QHDQr6USj21nhG9DaGXGiHiumusWlxDDc93HUsVapYJf/xwm/8X/WMVQQiBSU6mNC/KTIQkTYpfXra/MGfvRmpRnQQQ8vzMB/T0cvHRXN4YGjxpgvC8oKSNDL8FUz62HfjasX9sQOjWtf3jBG8siyZMlv4rPbMTWyn0ciRRH9xdctFtQyBFU3YNnAruE0Ndl3apzSdnUHGb7WxGwJJF95RNuFtBrC4XSsL7aPSzGSt6upHBhEM5G+OJBKFFvnnsPG2MHTyBMoiAOSApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBNRui6a3llWT8awtxN8qovYX9LPiG7+BiZ49N8O13w=;
 b=XXelbVcuzyD+1fz6qMdIbeVrr2SvbyO3SIduOCoUjgDAYoIW5ehu9XJnmBaPxh+A/XC+1QD/2xSzm1aYXRTOWx78rrAE1nI7lHWdb+AWADm+yY4EYCYjk3TEbOSQYVA/D8C6boeZdt3BN4CetMHDp845BqhvBT/yGUwUinXg8YA=
Received: from SI1PR02CA0028.apcprd02.prod.outlook.com (2603:1096:4:1f4::6) by
 SEZPR03MB7658.apcprd03.prod.outlook.com (2603:1096:101:12a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Tue, 2 Jul 2024 19:17:03 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:1f4:cafe::7b) by SI1PR02CA0028.outlook.office365.com
 (2603:1096:4:1f4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Tue, 2 Jul 2024 19:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:17:02 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 03:16:59 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Jul 2024 03:16:59 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id CF4B25F681;
	Tue,  2 Jul 2024 22:16:57 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id CD6D6DC0750; Tue,  2 Jul 2024 22:16:57 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v26 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
Date: Tue, 2 Jul 2024 22:16:49 +0300
Message-ID: <20240702191650.57364-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702191650.57364-1-tmaimon77@gmail.com>
References: <20240702191650.57364-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|SEZPR03MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2a6c6b-bbd1-4262-a673-08dc9acb8dd0
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|48200799018|7093399012|61400799027|35950700016|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uk2egOfm+cojfb7MTuVDK1z4DfYSL6xYhEK0MTADkY5vwgUYSk99ZQlKnadi?=
 =?us-ascii?Q?otDcUogZ4ENYSsn/18RztX7SOKp/Eo7mK2uYcVGvXncqsGhGBCY7S4mvUnwe?=
 =?us-ascii?Q?4kRDu25yJjW3WCfk3d9bSswGTHbWzPe0gbXuRrz0fBY1V6pvspRCfkorHHoc?=
 =?us-ascii?Q?7s37WovBuCANt/CB8H2JBgdXm4YWSibZzG3lqgACI4Mo1JsjGDMkuTFuPCN5?=
 =?us-ascii?Q?PzlqkFcGZQAtf/7md64WRfMCzjauV+aBCFdpLY9Fp5uoBz4QqgX11ixkowMA?=
 =?us-ascii?Q?fNFQT9MzYDpxvH+njElp7YOnZ+g8Wf81eKghDSAWib2JQ+FYtzYHkUlD77wM?=
 =?us-ascii?Q?iKpLDB4ltVs4ahjRMVSn8BHSfmksD1kAyv2LQEa1Fu0YWEWrakO2KGGOyCsY?=
 =?us-ascii?Q?FBrhBXjj5IVGugejmeOIwtwksLLr/Hb+UlCmXdfH1cOTGIJkfBhJKeo7JbNX?=
 =?us-ascii?Q?5q23qfP3u+Y9ISifM6l1nh2TZGYu7cVRZgLDjzA/edFVxvHtP7YXKhsvcap+?=
 =?us-ascii?Q?E7YVBaaOTcOBBmkRHMvNBkh6jsmzZblnej9F5FjWfm1mI0fdkQcI1CNEe/AV?=
 =?us-ascii?Q?AxPf70try8PUMNOWQTJaUwYcAJboLAte3Og95zUPDERebRuN/X9xpYjlejJU?=
 =?us-ascii?Q?9GnHTQAr2Oc5QoJZZFoYVrwmvEN/aOaQYj+MiuVtcFByHxtE5ddjK/1i57M3?=
 =?us-ascii?Q?+gDlvxa7lYfqgOPq3fDmuygHAMtnNHV7n4h838/os86+aDjqBymjW87SzKhq?=
 =?us-ascii?Q?3Y5qXqGTAHmAWDQJSxDVk5MtoueVqFEDW3p9OrIbpj3VDWQdNuaknsHkaQKR?=
 =?us-ascii?Q?kSxqk1LITRh421QlEAiCGAdalXFwK3x350vzofBAk2zD4PzsqUFa9CzpaCw2?=
 =?us-ascii?Q?c8h5+2sKOolpcOzPLHIYH7wFHieqB6QSZWKrrDr0H3yUdhRg0WKi9XML2Tb0?=
 =?us-ascii?Q?flBIm+0fm7ltj8Zf2MJfzdY1TBDK1MmU+NR+XZpa+O9GZSiiRuFBFUBqc0ts?=
 =?us-ascii?Q?CxQG5xW+m0EQ7riI4ADmCc4iqsSgvC9m0jG+bzy+Aoc6fd8nFHyGIeIw+Vl0?=
 =?us-ascii?Q?5+tqXUrUGbtmjX4Blf3ZqZNwidONXQzoeUwxnc6YFOip3yHB6vI5X3a9gDjB?=
 =?us-ascii?Q?P+oPFM4ePGqEsvZj7dKNQG1w/f/YHTIxGYcrRxMQs3m8K7cuHMBv3bRg7KAe?=
 =?us-ascii?Q?jEDVxJbwp20rzAYGvTceWuoZnu9ZfEG5TUB5ufHhTZPL4bzWKu0l8/+wJXrg?=
 =?us-ascii?Q?HvQYJOiObSwNRPRVo6eoxCj/sWuNWoi4QsmNkmSDyyyGlef/rLfp46D33Mu/?=
 =?us-ascii?Q?JC+HhbOKqpZGzngzWSJdnw/ULhFFjLn6E9ljUnc95WDOpDX4DgF6DpGjrP9A?=
 =?us-ascii?Q?fmGocf1IPSsA+Y8LXDwg75jinnN/81QsKcG+psz2L76D63MmjcXUXgbwXY39?=
 =?us-ascii?Q?Ob0gvs91RJ8HF0T0yALfcGqF+EJYhDSwRi8MkOidyNghws7Wf4B1leIHihyb?=
 =?us-ascii?Q?Lyr46NRicYYDJfg=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(48200799018)(7093399012)(61400799027)(35950700016)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:17:02.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2a6c6b-bbd1-4262-a673-08dc9acb8dd0
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7658

Add NPCM8xx clock controller auxiliary bus device registration.

The NPCM8xx clock controller is registered as an aux device because the
reset and the clock controller share the same register region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/Kconfig               |  1 +
 drivers/reset/reset-npcm.c          | 74 ++++++++++++++++++++++++++++-
 include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7112f5932609..31ec8795c105 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -148,6 +148,7 @@ config RESET_MESON_AUDIO_ARB
 config RESET_NPCM
 	bool "NPCM BMC Reset Driver" if COMPILE_TEST
 	default ARCH_NPCM
+	select AUXILIARY_BUS
 	help
 	  This enables the reset controller driver for Nuvoton NPCM
 	  BMC SoCs.
diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 8935ef95a2d1..aa68b947226a 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Nuvoton Technology corporation.
 
+#include <linux/auxiliary_bus.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -10,11 +11,14 @@
 #include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/reset-controller.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/of_address.h>
 
+#include <soc/nuvoton/clock-npcm8xx.h>
+
 /* NPCM7xx GCR registers */
 #define NPCM_MDLR_OFFSET	0x7C
 #define NPCM7XX_MDLR_USBD0	BIT(9)
@@ -89,6 +93,7 @@ struct npcm_rc_data {
 	const struct npcm_reset_info *info;
 	struct regmap *gcr_regmap;
 	u32 sw_reset_number;
+	struct device *dev;
 	void __iomem *base;
 	spinlock_t lock;
 };
@@ -372,6 +377,67 @@ static const struct reset_control_ops npcm_rc_ops = {
 	.status		= npcm_rc_status,
 };
 
+static void npcm_clock_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void npcm_clock_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
+
+	kfree(rdev);
+}
+
+static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
+{
+	struct npcm_clock_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	rdev->base = rst_data->base;
+
+	adev = &rdev->adev;
+	adev->name = clk_name;
+	adev->dev.parent = rst_data->dev;
+	adev->dev.release = npcm_clock_adev_release;
+	adev->id = 555u;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(rdev);
+		return ERR_PTR(ret);
+	}
+
+	return adev;
+}
+
+static int npcm8xx_clock_controller_register(struct npcm_rc_data *rst_data, char *clk_name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = npcm_clock_adev_alloc(rst_data, clk_name);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(rst_data->dev, npcm_clock_unregister_adev, adev);
+}
+
 static int npcm_rc_probe(struct platform_device *pdev)
 {
 	struct npcm_rc_data *rc;
@@ -392,6 +458,7 @@ static int npcm_rc_probe(struct platform_device *pdev)
 	rc->rcdev.of_node = pdev->dev.of_node;
 	rc->rcdev.of_reset_n_cells = 2;
 	rc->rcdev.of_xlate = npcm_reset_xlate;
+	rc->dev = &pdev->dev;
 
 	ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
 	if (ret) {
@@ -413,7 +480,12 @@ static int npcm_rc_probe(struct platform_device *pdev)
 		}
 	}
 
-	return ret;
+	switch (rc->info->bmc_id) {
+	case BMC_NPCM8XX:
+		return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
+	default:
+		return ret;
+	}
 }
 
 static struct platform_driver npcm_rc_driver = {
diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/clock-npcm8xx.h
new file mode 100644
index 000000000000..139130e98c51
--- /dev/null
+++ b/include/soc/nuvoton/clock-npcm8xx.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_NPCM8XX_CLOCK_H
+#define __SOC_NPCM8XX_CLOCK_H
+
+#include <linux/auxiliary_bus.h>
+#include <linux/container_of.h>
+
+struct npcm_clock_adev {
+	void __iomem *base;
+	struct auxiliary_device adev;
+};
+
+#define to_npcm_clock_adev(_adev) \
+	container_of((_adev), struct npcm_clock_adev, adev)
+
+#endif
-- 
2.34.1


