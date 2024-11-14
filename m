Return-Path: <linux-kernel+bounces-409177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E49C8853
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C50281EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1721F9408;
	Thu, 14 Nov 2024 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZZJ+8ec4"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDA1F8F0A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582190; cv=fail; b=nXyaapxkeBJcgBuuUXW0X2TiLAnoP/HDHCppaEENI+18lqkunKD6Tibg8aEcicFZVh/xObLHUu/j7xXkZgu1Q0Gbu83YUxh++Eby/xn5hU6bL1UgXDfsypSHPCoNJlMOf/4wbX2PhazzwoyxbMazbBu6eACvNRAwZgoh2wlXyu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582190; c=relaxed/simple;
	bh=8txHB/syYdvkjZWIx6zLTD/be9IiCt3kt8AwM2uD5mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWAEYTX89KOuybaAfFxAheukHyWsVj49IDBXAUYYDYdP/fLs1d9CHTNHYPL0X/NirANqPrxypRvV8S7ymWHVyGrcTaDlOMGPvYH1NyyK5mfcojrN079yZTXfONIfm1Ykejp44lkL07y1LIKjXtslzNgTvSpemQeQ9m1vfxHZeG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZZJ+8ec4; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvEl0r33xrs4SCH0Hv2F6seaKNqDPFVT7Zy6bvLkVR2fp+3eHgpnAaMPfAVgQBGOhGJZbuyULyKdDXVo7MYeWf4VzsIrkHRhHqvdiDcsw1+GwVOknHPNxaDYNwGsIi19LQ60LWXsh5vFyetzr8qtNTnyMkkOYGwmQtOipfmH+C3e2g++DD/oj5gw1c4WKwd7IbOKIuKLJOMApKg3xNVMfbsXVdKb2SJ+a2cgCzscfwDEA/nzHe1S0rw3H+Jr5S9QPVlDjDIWJx/X0f0rrIFasCpgTcdOYChjRBexPGm6WOlYCYKSRFRYmJhVkuvol2n/yph5Bw/wOZh+Eyy3Ie+CkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/vSk/DTVHzr5SPHLLdLTp45dLNo+KoJM6NFiitEswc=;
 b=VOwR8Z8WDzNTUKGR56wWl6S07TnhbPACx4U8zEDX+UFHKJtQ1Fdk68DZ+TlEY/OUL85+1h6iuW2cI68tN5uxLU/W5UoemPplt7ymKciTOXRN9EYGkEK/SZqEBch43XncxMPWo/Q29I5HySITAgrZNI2T0w+rYCjQoYBMxsk5GST02e85a0dKeknWqaxiXghiH/XTliBFuKHuMWwMVwrpYh4uXnE3BTw/kdOsEGgArq4YgU2JfurSKbkJMSoynAxKy/n1k3sAu6T1QqoGzO1in2XfRmB+QCnFb00TVfUGGrA0xMbXStVFsmK8DLufuyB722tY6YNrcRDxBQC+NWac7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/vSk/DTVHzr5SPHLLdLTp45dLNo+KoJM6NFiitEswc=;
 b=ZZJ+8ec40whl7zg79X6cCA2p2vac66KmfdW0IAqMF+vqy/BPvsnYYNCkNQtfB1VYkoHvRFDCSTZQyYJ75tjRYbSzUUKEuk+rvMjtpU4zyiQEYDoXTGHTRkOxYKfnsVuUQ5Br+WlDtWm6ICkda2gQUelmcnP13kic2s0g9hw6Svo=
Received: from MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 11:03:05 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::79) by MN2PR07CA0027.outlook.office365.com
 (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 11:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 11:03:04 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 05:03:02 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 2/2] i3c: dw: Add quirk to address OD/PP timing issue on AMD platform
Date: Thu, 14 Nov 2024 16:32:39 +0530
Message-ID: <20241114110239.660551-3-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114110239.660551-1-Shyam-sundar.S-k@amd.com>
References: <20241114110239.660551-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0cc0dc-4c62-4c10-2c56-08dd049be9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJPBIszSYKB4XAm87g/8a9eHDmQ+P64VmvDt9VfDHHsyH2PGWhl377clAXwE?=
 =?us-ascii?Q?K9PVYDknrrw8uTosf8svggRiix697iIjjMuDDQAU8aJv0lqWKuWXRVbxss/P?=
 =?us-ascii?Q?Mr4T2rpnO+cU8GoZWdyorV0XRVzSLsZHFym0RBe7P8Dr4bTqM9oIdwbcoPdv?=
 =?us-ascii?Q?7/1UbzJmxOOesubK9JQjCULWeXeu7S9IBVqXSYTRzevwCOXwV9FzFU5412aH?=
 =?us-ascii?Q?e4sOnRgHuuyj75pPnmWmHoVUKOe2Ac97eDjk9FoCdLlKdvCV9/SPOT9C+9zu?=
 =?us-ascii?Q?92phCFEY77FiGkyaz+/TpUXc743ExZ1gg8ctqAdiVXrLOYuY7h5MXNbldv90?=
 =?us-ascii?Q?g9dMcjVcQRfuyiD7rXDotPOOVO1e3CC76dyDkdroycmtFpbMyCvR+bjO/+6t?=
 =?us-ascii?Q?T9vVhoTHGZN8cULks79eW+jvYO+I6FiX6RBqCGlbPIaaoHcr2JSPk2NmRC24?=
 =?us-ascii?Q?2B88gD5rcN1G4Cusm0oKgXAU3lTNwnmiQH5nNHr+xL+8jdY4a/nNEzhjE+sn?=
 =?us-ascii?Q?6LNCQ7IoiX5KjXpgDlmC9Jf8gkey8nsuNaen2TJSolbaaq0mMJij5fV0MpFM?=
 =?us-ascii?Q?gc423F3qSE4FAB4A2jZfadBfch2XUjDpBx48jzhdv4XTDCZE04Y8Gw0/dHFj?=
 =?us-ascii?Q?6MUF+kFUBjNzHDkUGdYl+PhVOrrJzW9p0UKGLJ5j9ncQD8JF4iNcy9ZWkuG/?=
 =?us-ascii?Q?qHcvNZG6YT3w500XKts1x2ZkZEp5+C90RpPMfO6T0QGoxvyUlhSNPkbXDqHY?=
 =?us-ascii?Q?6gX8p9tPxb4fsR2KeKz8Of+0Z3b6IsZ3oEQ7Rupqay/cfzuv+gPt4lqiHsot?=
 =?us-ascii?Q?UGQ6WgWItisfm4PeE27Et6X1k7Btuyuan8b5twdAY0zMLklIAAEZlNDc+cpL?=
 =?us-ascii?Q?ccBZRytx/Rq3gkNS7dstRaXykV7y26I1vJT8ylLAcGr6ECzETkupQBiuWZm5?=
 =?us-ascii?Q?sF1pFSTTsCxSlEUSFka+/DWnnLwNatRXqYIRWxEv1oObScBqJMAdEmN66fP/?=
 =?us-ascii?Q?PGQ5WIVw/On8NovsMLjAKc4Mx/4JVV5yQK1yAQ0TJSO3+MCPvUrH/GwPN+/8?=
 =?us-ascii?Q?gzzoHEM1UP1xyqmzCN1PsONAC2RNGBMGe9Cvh5h0AVEpyJOho6lMRqOyCulb?=
 =?us-ascii?Q?ZzvDUdTTM7NPhxThIyHus3KhbDoUvV/MO98FrswnYyaOLX4lwk4jxbcb81RT?=
 =?us-ascii?Q?TyWRdSwpbdguvk+ehTUlYicVv8uDO0Z4ibWWlgc6IZsS+3Yp+Ifqj7/W3d9x?=
 =?us-ascii?Q?SpTpOxcjccta6Cg7zRxHgbo8sAFODVIOFF//LTRfuQWt4tuHh3yCx+Zh0d1e?=
 =?us-ascii?Q?mNrw0W8SxJ9Y/yel7aM0iCXfJDjMRYkXwReusbSQoq84qbUAHmoisWhH3Wl1?=
 =?us-ascii?Q?mjg/8gnFOTSVGwbouIfsWfk50G43YsG/NHklr1aSXUqwOBEq1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:03:04.7625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0cc0dc-4c62-4c10-2c56-08dd049be9fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

The AMD Legacy I3C is having a problem with its IP, specifically with the
push-pull and open-drain pull-up registers. These registers need to be
manually programmed for every CCC submission to align with the duty cycle.
Therefore, add a quirk to address this issue.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 29 ++++++++++++++++++++++++++++-
 drivers/i3c/master/dw-i3c-master.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1a7c300b6d45..5b5c2e4bdc51 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -220,6 +220,14 @@
 
 #define XFER_TIMEOUT (msecs_to_jiffies(1000))
 #define RPM_AUTOSUSPEND_TIMEOUT 1000 /* ms */
+
+/* Timing values to configure 12.5MHz frequency */
+#define AMD_I3C_OD_TIMING          0x4C007C
+#define AMD_I3C_PP_TIMING          0x8001A
+
+/* List of quirks */
+#define AMD_I3C_OD_PP_TIMING		BIT(1)
+
 struct dw_i3c_cmd {
 	u32 cmd_lo;
 	u32 cmd_hi;
@@ -794,6 +802,12 @@ static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
 	return ret;
 }
 
+static void amd_configure_od_pp_quirk(struct dw_i3c_master *master)
+{
+	master->i3c_od_timing = AMD_I3C_OD_TIMING;
+	master->i3c_pp_timing = AMD_I3C_PP_TIMING;
+}
+
 static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 				      struct i3c_ccc_cmd *ccc)
 {
@@ -803,6 +817,13 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	if (ccc->id == I3C_CCC_ENTDAA)
 		return -EINVAL;
 
+	/* AMD platform specific OD and PP timings */
+	if (master->quirks & AMD_I3C_OD_PP_TIMING) {
+		amd_configure_od_pp_quirk(master);
+		writel(master->i3c_pp_timing, master->regs + SCL_I3C_PP_TIMING);
+		writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
+	}
+
 	ret = pm_runtime_resume_and_get(master->dev);
 	if (ret < 0) {
 		dev_err(master->dev,
@@ -1602,6 +1623,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	master->maxdevs = ret >> 16;
 	master->free_pos = GENMASK(master->maxdevs - 1, 0);
 
+	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
@@ -1675,6 +1698,10 @@ static void dw_i3c_master_restore_addrs(struct dw_i3c_master *master)
 
 static void dw_i3c_master_restore_timing_regs(struct dw_i3c_master *master)
 {
+	/* AMD platform specific OD and PP timings */
+	if (master->quirks & AMD_I3C_OD_PP_TIMING)
+		amd_configure_od_pp_quirk(master);
+
 	writel(master->i3c_pp_timing, master->regs + SCL_I3C_PP_TIMING);
 	writel(master->bus_free_timing, master->regs + BUS_FREE_TIMING);
 	writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
@@ -1749,7 +1776,7 @@ static const struct of_device_id dw_i3c_master_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
 
 static const struct acpi_device_id amd_i3c_device_match[] = {
-	{ "AMDI0015" },
+	{ "AMDI0015", AMD_I3C_OD_PP_TIMING },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_i3c_device_match);
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index 219ff815d3a7..c5cb695c16ab 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -50,6 +50,7 @@ struct dw_i3c_master {
 	u32 bus_free_timing;
 	u32 i2c_fm_timing;
 	u32 i2c_fmp_timing;
+	u32 quirks;
 	/*
 	 * Per-device hardware data, used to manage the device address table
 	 * (DAT)
-- 
2.34.1


