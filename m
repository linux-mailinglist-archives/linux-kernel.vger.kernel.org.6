Return-Path: <linux-kernel+bounces-274202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC429474EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA621C20C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B22143C6E;
	Mon,  5 Aug 2024 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1pJGpv3A"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02E1109
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837554; cv=fail; b=k9fyYjRmVI8/thE4C0YtQ6jc3HoNyhGLpMQ3RBg0VsiTxPCbxWpJXgERBCSJkimS3tqWcOAzLD4o1Fl8Dw4IazZwLblHNNcSTkHds4Si68VviAwWdnXtSGxD+7TVezqTQ1EbLYN1n+27Zi4klrXozEnfj2rzYFJCQ1TehSlnw7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837554; c=relaxed/simple;
	bh=Xf1eteLqDzsd/v8XqAqukGomKAosxqem1s6dIX+lt3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KEcs5iYV/hvPMbHsOmL7n5qKAvBZ9aaKJ7RAGsJn8Otfo9FyAmgBLzK9VFX8J7EfNwmcI9AYgC2BAenAAKpEYMUwaOVP/GymHOvIqctdqdKW81VEsuJUbIw3yyPCKrizijgRyIziIXo9n9/lXeEcabcTlwatEmoeAe+z/KkeQ+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1pJGpv3A; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIREiqyT2l8phfbdVXZBJsuOcn+K+HnMsqZRKqolrUdw0PXvpcVoO9Nr/GY7nP3Kq96zQefJd92Sh/jPcmXW7R2V9VoRHCmCGAGo0YsTfTan7RI+S34cJwU62aSeVehKerl6ZAhuWzS2+mfeMX61K7g4sIjXP9+kA+G30pc9pzZi2jk9wh14WPS+iWxb9c1mTnrWbqtf5bx1e5BNTm0BsMtX0PbgzJ37p33obPm5mhA+Xyxb2WcnhvCVzeTNRrfYN2jH5skZtga57QMaX7q5j0PpmycL7Spoy58IT5FlthW2XwhEHSn/4cU/xRWMi10iZAUOFjyNDDrS2iY4ismWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/710h/M6giJ2S2rBeBx3w4kvkZLcUQTsY5lPIiPGbE=;
 b=PnzYlkOpuIag2ual8tGkDDF6C/u5diHOOsJGQ7Fu5J1C4mx5UwPQLyIinkdYSe1iNVGrIUC+/9GBT3WSWBQeMbFp1LBLg1w0tU0t+UgAAttO1VpmMEunovDNr4Y/uCl75pKMbkJq3zdon0WsyFNLbF5V/7i2SQKbk25X33iLAr0KYEBN2OlfMFcRU2GcBPPc6lq4go9io2a89yzJ4uO5nixiltbupDK67/MyVj7Z7p+8CSk+/Z7hKrkjj28t5MnG9W8PTavtd2cu/onLiFLcvvkipMwJ2cN4VByHvmvPpPL3weWZNIrcwtk7G3HzoLjBNKBqQhvUreHOxnvcFjLlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/710h/M6giJ2S2rBeBx3w4kvkZLcUQTsY5lPIiPGbE=;
 b=1pJGpv3AmI4oG3SYXOlACN2robpKveHYtuPUl55w6r9RLcZFX0rAYymlmCISLWMW+jx7hZbH/VY1EwfQ5DJ2ddb+bhI5FPl8l4T7LQ7BTez5XP7auNvqH6sl2hhztfm89ZUlzhe9/OgXJEkgiFTxcSyrs2XM2KANc3wHADZKICU=
Received: from CH2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:610:60::32)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 05:59:08 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::67) by CH2PR14CA0022.outlook.office365.com
 (2603:10b6:610:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 05:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 05:59:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 Aug
 2024 00:59:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 Aug
 2024 00:59:07 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 5 Aug 2024 00:59:05 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v2] phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume
Date: Mon, 5 Aug 2024 11:29:07 +0530
Message-ID: <1722837547-2578381-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc3fd65-184c-4d5b-9e1c-08dcb513b886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqBquG/TN3F8Y/gHGkPTTphSwLhiMl1lSnfUDgpsjfpAeF9QrCctvxo5F/Xd?=
 =?us-ascii?Q?NL0+Uip8h/zWES4z1as54cjZ7n0E5E3GWe3DrR8ZwONnjnFaZlWN6c7fxn7a?=
 =?us-ascii?Q?wFoJy78TXQoupYrHtdQwUQLbEW3/d9tIP91CPz7574Wfoq6CmIC+KV5zWUJm?=
 =?us-ascii?Q?9Ggn5FSABqOeikb+VV1zK0gve5WwqVp5fjwT7j0h+3NkGq5t+PE8BoXLM5wM?=
 =?us-ascii?Q?qRcDRqNhitYXAGaF7u61CBr2emmMKsLIJ3XTjtWqjqNxm8kXei79LlKPLx0Z?=
 =?us-ascii?Q?Q6Rdkhmt6wlQvY2bPO22q4NVVVZD9dyZE5I51FrIPf52fTnBaEgmw7SvCScp?=
 =?us-ascii?Q?3we1rLunBM3LN/oh+tD2CXc9d3lcuO2CjwJj5jNExbIAHiFGkH1/J/qRzVov?=
 =?us-ascii?Q?jUlNwhEBVOMEE+Jp/aNhlI9+tiD5M+LKVjkvB/fdRwkwtM6hbnfruB2HHuyX?=
 =?us-ascii?Q?K9DuGyo0wliLN8HYS4UfXbe7olxEV+eku93GBssbsVK4lCbWkrizLpofIyUb?=
 =?us-ascii?Q?2JlRp2GiqmOt6Ifx1O4afx54dJpJbXS5Jdosf+H4MrAWWN4QV0SKQN3rTbI4?=
 =?us-ascii?Q?cqAdBFqtNasnKnvI2EVwxixxlcr3KwsGQcXyZrygPMi7PLJWxQAnAq0KlGfr?=
 =?us-ascii?Q?ZOWFtApMFscottUssv4y2KRZAGLocWuOVqhgHwvnuHh34OLZUkKXGaTAArOg?=
 =?us-ascii?Q?I2AS92a+fqjVOM/ZBVYsVUBwxpM9kxSLk0nVWdMDNuaY60omHs+aAiGdohg1?=
 =?us-ascii?Q?1QJCYJciLCrU7RQrkBqOrYc3W2x2C5MTza2Gi+PU9FI40s5z6p//ENoQ9IvF?=
 =?us-ascii?Q?b1MnXa6eoTqj78w2K60I9IptSlQKAlM5VffH1dNbt5jeISUATA9fXR15bc/M?=
 =?us-ascii?Q?XuteDHVt/M6QYp28jXtk5SitaeiE8FjfjTG8WWVwvagRqPGVyghF9GErQVfc?=
 =?us-ascii?Q?cfEvqjgBUMGAbPLbSnSKGIbKY93r0PYc0u5gebCgxYGXauwdKcyJTmcLQUyv?=
 =?us-ascii?Q?F5VMkv0CogDC7rSCq3r9h6tWfIF+tYNEsPv0ENvWd8KUWJcWH4WFLGjKsWip?=
 =?us-ascii?Q?0o0tDeSBUvKF+WnxBbT63Cf4RMTK/jmzjJ7P9Ji7gE0NOvpC8eR14p3LnJlG?=
 =?us-ascii?Q?RhOZyDVyfm6tiemxhi89wt7j5PJ+fn+hfUOM2ms5A57eaz8iX5pAT7V5QZDZ?=
 =?us-ascii?Q?FjhfIfuF9B3MXX6HtRlUGl9/Zh0ryzRxVZWnReLcSFlSRZd6NbjBbiJPuap3?=
 =?us-ascii?Q?X9COSvWsghuelxN49MzCGfU/b7anFiAZfT3BLGE1W6v66xEAOFsdR5FeFPHq?=
 =?us-ascii?Q?vP7P4uVWtpsBXTUDvzuofBd5/8k4tZVoNhJy1komOM4X64GbpfYo4WxsOiD6?=
 =?us-ascii?Q?QgU/uv+mhwlLPDBrXR/p+fn/O2S7WMAF5wf3IoMyDJRNAvwJqfGMEZnzwm+K?=
 =?us-ascii?Q?8kZnhm2ykt3mgPsCJU6GiLFJS+u+zo2S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 05:59:08.3822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc3fd65-184c-4d5b-9e1c-08dcb513b886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445

From: Piyush Mehta <piyush.mehta@amd.com>

On a few Kria KR260 Robotics Starter Kit the PS-GEM SGMII linkup is not
happening after the resume. This is because serdes registers are reset
when FPD is off (in suspend state) and needs to be reprogrammed in the
resume path with the same default initialization as done in the first
stage bootloader psu_init routine.

To address the failure introduce a set of serdes registers to be saved in
the suspend path and then restore it on resume.

Fixes: 4a33bea00314 ("phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver")
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Use lower case for hex values.
- Add Fixes tag.
---
 drivers/phy/xilinx/phy-zynqmp.c | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index cb15041371c9..e6579002f114 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -160,6 +160,24 @@ static const char *const xpsgtr_icm_str[] = {
 /* Timeout values */
 #define TIMEOUT_US			1000
 
+/* Lane 0/1/2/3 offset */
+#define DIG_8(n)		((0x4000 * (n)) + 0x1074)
+#define ILL13(n)		((0x4000 * (n)) + 0x1994)
+#define DIG_10(n)		((0x4000 * (n)) + 0x107c)
+#define RST_DLY(n)		((0x4000 * (n)) + 0x19a4)
+#define BYP_15(n)		((0x4000 * (n)) + 0x1038)
+#define BYP_12(n)		((0x4000 * (n)) + 0x102c)
+#define MISC3(n)		((0x4000 * (n)) + 0x19ac)
+#define EQ11(n)			((0x4000 * (n)) + 0x1978)
+
+static u32 save_reg_address[] = {
+	/* Lane 0/1/2/3 Register */
+	DIG_8(0), ILL13(0), DIG_10(0), RST_DLY(0), BYP_15(0), BYP_12(0), MISC3(0), EQ11(0),
+	DIG_8(1), ILL13(1), DIG_10(1), RST_DLY(1), BYP_15(1), BYP_12(1), MISC3(1), EQ11(1),
+	DIG_8(2), ILL13(2), DIG_10(2), RST_DLY(2), BYP_15(2), BYP_12(2), MISC3(2), EQ11(2),
+	DIG_8(3), ILL13(3), DIG_10(3), RST_DLY(3), BYP_15(3), BYP_12(3), MISC3(3), EQ11(3),
+};
+
 struct xpsgtr_dev;
 
 /**
@@ -209,6 +227,7 @@ struct xpsgtr_phy {
  * @tx_term_fix: fix for GT issue
  * @saved_icm_cfg0: stored value of ICM CFG0 register
  * @saved_icm_cfg1: stored value of ICM CFG1 register
+ * @saved_regs: registers to be saved/restored during suspend/resume
  */
 struct xpsgtr_dev {
 	struct device *dev;
@@ -221,6 +240,7 @@ struct xpsgtr_dev {
 	bool tx_term_fix;
 	unsigned int saved_icm_cfg0;
 	unsigned int saved_icm_cfg1;
+	u32 *saved_regs;
 };
 
 /*
@@ -294,6 +314,32 @@ static inline void xpsgtr_clr_set_phy(struct xpsgtr_phy *gtr_phy,
 	writel((readl(addr) & ~clr) | set, addr);
 }
 
+/**
+ * xpsgtr_save_lane_regs - Saves registers on suspend
+ * @gtr_dev: pointer to phy controller context structure
+ */
+static void xpsgtr_save_lane_regs(struct xpsgtr_dev *gtr_dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(save_reg_address); i++)
+		gtr_dev->saved_regs[i] = xpsgtr_read(gtr_dev,
+						     save_reg_address[i]);
+}
+
+/**
+ * xpsgtr_restore_lane_regs - Restores registers on resume
+ * @gtr_dev: pointer to phy controller context structure
+ */
+static void xpsgtr_restore_lane_regs(struct xpsgtr_dev *gtr_dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(save_reg_address); i++)
+		xpsgtr_write(gtr_dev, save_reg_address[i],
+			     gtr_dev->saved_regs[i]);
+}
+
 /*
  * Hardware Configuration
  */
@@ -837,6 +883,8 @@ static int xpsgtr_runtime_suspend(struct device *dev)
 	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
 
+	xpsgtr_save_lane_regs(gtr_dev);
+
 	return 0;
 }
 
@@ -847,6 +895,8 @@ static int xpsgtr_runtime_resume(struct device *dev)
 	unsigned int i;
 	bool skip_phy_init;
 
+	xpsgtr_restore_lane_regs(gtr_dev);
+
 	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
 
@@ -994,6 +1044,12 @@ static int xpsgtr_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	gtr_dev->saved_regs = devm_kmalloc(gtr_dev->dev,
+					   sizeof(save_reg_address),
+					   GFP_KERNEL);
+	if (!gtr_dev->saved_regs)
+		return -ENOMEM;
+
 	return 0;
 }
 

base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
-- 
2.34.1


