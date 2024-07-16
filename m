Return-Path: <linux-kernel+bounces-254239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7837793309F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCB41C229A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7411A08C2;
	Tue, 16 Jul 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TACzYWmY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093D1A08A1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155272; cv=fail; b=ivaONt0TQpKx+ddD/BUz2S8nSx9vPUdtRur5RGCoFRBBAwzgSjCGq0FtpW66l03eCAbKvoepjqUHz6K00UCd+BJ2krN5/y8D7+1An5Mm/thYCAkFbIG6Qd+EeL2xpjJoQdjP6WaU3sMNykQPcvZVfIGa4tOs1olflC4FEHm5pF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155272; c=relaxed/simple;
	bh=at7nVkiKn6xIUlL/GJKa8zUfDgj553uC5oeM2hLmA6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cjdLx2plNG42lOK0uVGv1F+QSov/VMSLSN6Zz/NiB7+w1LelmPEppGQFs4qtcEbGX1Fy562mO4eXDRUUdmHX6zQmJYFGkSh2Sdsw82hnArQMtkqrjyc2K2pb8aJDR4n+UE6hzEXvkZGVD7aMfXWq45CsYjsX1VbFelmNBev+Q7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TACzYWmY; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUwMvRmlhWRZSZVIi5Rsp8ljkNvTb5geG7V0v2scSvJly/NTLy0R2RLJbjEwifwo/dnNYayqj/ibRivI2Sc6cCDI9+Kxmyri5Po3yJimuWJcKVruvMUaKYqk8FG5lN0I21k1FNPxEM+4V+wJi9zBd+FIPDTpTJ8THuA1yVU1LDrwspjUOjZMquAkXU1W+roFatsaj7sGGCJ6WM6lkL5+XsVSDmexdx5XP6/6EtDelrexFWiTt5pKo7br4K5qF/iFITXCmG7eCNaeO2tGiPJVz+gZL1St9wHY7BViK+C1frNxBKN6XDppq2nu3KnLdwgc1+SwgO1008V0aHLkhoPDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSUO7s9DQjjnCkkAdO8gJZI3UHnkm25mYFEn+EIARNY=;
 b=a2wAGLlpRvJrVI5DxI0Gp6W7MJEPW+ZUtBz6+BAO0RHGRkD4Qk+BE3Xvyrc+Q/1xFs869cgKu50lBxbEGe9g68MicBccNbXGN7GBGGpXaFFoS7pkfY7vsYQosjmrh6nfM41b3hCtarUHnNFMslKZSwmzqBOoS0JxychM6UdLi4sQU677bC2G3wlViG5pYPkbmNMWNZ+bs48UwwfNcnegyrZez6EyR4AUcr5l0Eqo9FPxZPuiTa1O5BhVsI4thS0Uwo47mMD6AaMMoDDlF9OTtOt2hvLXM5BVpD3aCELMXdWD0pI6j3el18XTGpCAz1Qb0NEslV3iZ3R6Zs3H00Cm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSUO7s9DQjjnCkkAdO8gJZI3UHnkm25mYFEn+EIARNY=;
 b=TACzYWmYDFuXFbra0J4GwBmKDbpzQWL+yo5dIJ6by8mhAhdg/zT8hBEDBVwIZLoZGR1QHVTQS3yv84co+X2+GOPuCpYVrvgUTXBx6kbHAJhGiRwN0tlPq8lWYJ/q1BS6QGTclQaNxTV37dU5ThIQo1gTvJ3PR2ehgQBCeaB0RXA=
Received: from BN8PR16CA0017.namprd16.prod.outlook.com (2603:10b6:408:4c::30)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 18:41:07 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:4c:cafe::97) by BN8PR16CA0017.outlook.office365.com
 (2603:10b6:408:4c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 18:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 18:41:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 13:41:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 13:41:06 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 13:41:04 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH] phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume
Date: Wed, 17 Jul 2024 00:11:03 +0530
Message-ID: <1721155263-2913528-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: f637a920-0914-4511-2c5d-08dca5c6dae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T27hA39sdMTDyeFiIN27a2H4xuubGdOLffMOwmPvL9URicx/HJN4Q1412vFk?=
 =?us-ascii?Q?kAuuoVEKF4eRQHNahZ3iVyls0JkmSMI3tQ/5ZoGnqvURSasFgdHkp0v/L2OJ?=
 =?us-ascii?Q?ErQPSGHjVHC4ShjY+28aJ9fwRNNZMRevY071B7q4u/iyM6Kl+Efm2Gz1k5u0?=
 =?us-ascii?Q?ot7mZNjGutz1RaTiPVzLzOEVI1WMo+X+YjwrQKStn0XEhhX0FQYiBJ+iEL3d?=
 =?us-ascii?Q?a0n3V8ZBh+QMazdCjX1JClFRGp7Ti218crYrMtpzOdPNAAvUwe7nU7c9pHtx?=
 =?us-ascii?Q?mzL9apAd3UmR2QgfWGMz7L66VsEIYDYutoB4DPIRYGEYNmOk14u3dyL5QT4J?=
 =?us-ascii?Q?+cADGv2Yu9KHpBFwVLCcp4n/9IpFNvPa1zoPkNfBD0Y69EKH8HX5Rum/TavH?=
 =?us-ascii?Q?YkK9yb8qn6vedQ1dJE8tAzFk2PsilgZswc3zS7TExMsEUHMtfyX7o17SKMmR?=
 =?us-ascii?Q?u0vgGZTG9J/aP2Vhsqslu0ERIoKfMR7A56yQZrBmQElONJyv6Gc4RbweSU4Q?=
 =?us-ascii?Q?/mEN0OiMYrfQpoMPH5+9nm3gMWj4VGdzjZUo+lzviWzAzuCHkui7mPkOAV8l?=
 =?us-ascii?Q?X0wkoJRB657PHH+ATM6ng0P4taYkP5ONEta0IDnrGVVUa7Y3nO9qip2BjcuW?=
 =?us-ascii?Q?UI2jTESQ+x/r/KlzJOIGnHcTV6zmt69Ulh2aogi2t4iYlof+Ohr/7YtapJwL?=
 =?us-ascii?Q?waFhjvwJAH5qNHWEUNqKWIzcu+XcEOX2YhF79UQ25FMaD18Qm2mV3iyU+O5p?=
 =?us-ascii?Q?L9esHc2F9SRfmhmGSkpxrm7suDSrNgne+zspLI/qr/4Wpi9+uZRrGcyrAuiz?=
 =?us-ascii?Q?wPl4Xz09gSD5yHwtxcoAzERb8iAN0iezqjLgZFvnqPA1SnAxqXuZTqNYj4Eh?=
 =?us-ascii?Q?5wNwJHocrT/v01O4el+6NN47Sk2KlxMUZ7mSuz/jUpW1fGSg51h885zNLu1v?=
 =?us-ascii?Q?5An9SYVtPaYrRLYFAdXqxCJrX+frxHS4CQRYohS5lQEMrE3V0H9jzNmKfuZw?=
 =?us-ascii?Q?DGR8vn0nN6mAMmjGi73xH+PAE6xhgxQIZHPcQUTdJMFTvCIM45fkoqpPaFdt?=
 =?us-ascii?Q?ILSkaIb+XYwh6tIupfi+u/9X/INLO8ty7HWBCPKdtm3UaeqSf96Xre1uHf5M?=
 =?us-ascii?Q?rUgSpViM2qIG4TcA0f28sxCkDVLHjP0FwKr1jYyNsnbIQj5rAmhyyJ/eivxN?=
 =?us-ascii?Q?+qO5SN4S3orvt3ZSjRPAit+nz5YP2lwY3hT/fSOMSYSgVgJ9nLzoeXgzD+SH?=
 =?us-ascii?Q?CrBi3kKE14/PG5KKvfT6Mk9GzF44+N8kvesifkT1YXe4ZQj2mcJhgDnl7mLY?=
 =?us-ascii?Q?oOvVyW5pQ3ghuQfSaa3C6QzSJ7AzVy+ByGUAavLBC4URS9Bz+CuPa2odnWa/?=
 =?us-ascii?Q?f31gCRfsiM6Yx5sbVlbLWJw/nl6SFkuYw4ITSRj1jYds3ur5uB0IToJS08zc?=
 =?us-ascii?Q?QeXILJ4GAP3cKkkF11FVNoyLEQ9qLBZb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:41:07.3637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f637a920-0914-4511-2c5d-08dca5c6dae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196

From: Piyush Mehta <piyush.mehta@amd.com>

On a few Kria KR260 Robotics Starter Kit the PS-GEM SGMII linkup is not
happening after the resume. This is because serdes registers are reset
when FPD is off (in suspend state) and needs to be reprogrammed in the
resume path with the same default initialization as done in the first
stage bootloader psu_init routine.

To address the failure introduce a set of serdes registers to be saved in
the suspend path and then restore it on resume.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index dc8319bda43d..bdcc8d7c3dfa 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -165,6 +165,24 @@
 /* Timeout values */
 #define TIMEOUT_US			1000
 
+/* Lane 0/1/2/3 offset */
+#define DIG_8(n)		((0x4000 * (n)) + 0x1074)
+#define ILL13(n)		((0x4000 * (n)) + 0x1994)
+#define DIG_10(n)		((0x4000 * (n)) + 0x107C)
+#define RST_DLY(n)		((0x4000 * (n)) + 0x19A4)
+#define BYP_15(n)		((0x4000 * (n)) + 0x1038)
+#define BYP_12(n)		((0x4000 * (n)) + 0x102C)
+#define MISC3(n)		((0x4000 * (n)) + 0x19AC)
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
@@ -213,6 +231,7 @@ struct xpsgtr_phy {
  * @tx_term_fix: fix for GT issue
  * @saved_icm_cfg0: stored value of ICM CFG0 register
  * @saved_icm_cfg1: stored value of ICM CFG1 register
+ * @saved_regs: registers to be saved/restored during suspend/resume
  */
 struct xpsgtr_dev {
 	struct device *dev;
@@ -225,6 +244,7 @@ struct xpsgtr_dev {
 	bool tx_term_fix;
 	unsigned int saved_icm_cfg0;
 	unsigned int saved_icm_cfg1;
+	u32 *saved_regs;
 };
 
 /*
@@ -298,6 +318,32 @@ static inline void xpsgtr_clr_set_phy(struct xpsgtr_phy *gtr_phy,
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
 
@@ -992,6 +1042,12 @@ static int xpsgtr_probe(struct platform_device *pdev)
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
 

base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
-- 
2.34.1


