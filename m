Return-Path: <linux-kernel+bounces-401191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521D9C170E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35891F24228
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760841D1E8F;
	Fri,  8 Nov 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uTCpvILq"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954E1DED7D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051259; cv=fail; b=ljP9AMOSa6cRbvbmg4r/JTxbMEzjBZCQMwVDXII7Ej4TK1iPP6Z5xe3yaeT4I6HXP8nQ9/pwMt5NjCyKM7mIY/YIEdbLmFdnstMTj+DFuPmcgMYSGAwQLwy3mX6CoeSfs042AJCIMzNCpNgWfuVJjI48Q0e4/1Ao4BglFLjBedk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051259; c=relaxed/simple;
	bh=U1ZkqtrhGrGhdvmecPMT5Yh83U7r2uf3WzlVN/kxF8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjM+d3QClUqVSqGSNRbHUuc2qrsZDPzLndrGvEBbts24VQi5+gHup/W0CA58CxLI6VzLUe4b31eWC8+bIQpiPpNNl5s9MJhthWEJSegPOmlPy3Cu8deq6aeHa6EPCUhAs1E1Pop77d7/ZgOrL8YbLqByNqTVTbKMRWJuqt1ouDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uTCpvILq; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqAo/dBTI2iA0TdN6MXIwoor5xRod7jCwnPvUnrAcKxm7BshCfALnlEpv7/R4CaBhL1jzy7JEAbr4DlKg7QvuB9jTz4s7NWHDOchOnuP1CYdaInAqmDCDfn7wUtVGSeep7IRrN3Uh/23WFTAXSLPduX6sCZrzQXygMZbSSj4TucUQYdUhTPEZEg9BIfcPV0n5zKUayYE5hIyoVrsUEwBBf3byxxFqOZ7b85frls8bMwY7YhYHICgYqeGXiDat6/zFWtulyh8cOkesShDav8yNF0/vE86MTtAZxHgestWxKuKbBfTCjXmu0pWHLSPLAdXPoFX9xdv/JvITHm2Pc5weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eLWDscx0DGim5Ucck6S9hlO6uZ6gHFYGZM9LRDe4SI=;
 b=WbRZdVa0yeVnaXP9oWwQl+iUYR9e3rI7lS6iz85bCR3xO1SEAfJ67AJyC1Rgdi/VIkr/mq3We/eaMrWIStLTtVUw/u9pZrrsC5rvp68406FbGLS3Pli8/mFHysbvUs92izvIShSDWP5Jpv37qhBnMl7FskGWnPlObdyE+7/SfV4Eug73qC5h1OZx8Cd//1CC6jn/sS7b2VfEWqUjl7eRVK0tPRos77XttVe+xu7zpCc5QiCIRxqVzoPrKv0NCmSdghFEjQIjUOLbfv5ii5KUaxqrMSwQu9GwLo4Nbjep5i8PFh7tbwq3svY72uOrjm/q69VVC/9YFuvLXEeifmlr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eLWDscx0DGim5Ucck6S9hlO6uZ6gHFYGZM9LRDe4SI=;
 b=uTCpvILqywTMfAZJpnsm1pN+NoSyWWS8D2ZBPWPdten3WjLIcRN32bifUZaD/KpY1dyzHxTMRjQYfqrxux8zhBKQ8Wg9SnzmES5rrUBB25+nAvmOTVFs93rYQTRNV2xfUEXAx032K2cseDtlJsv3COncwyP/OWIvc9oCTe+WMRI=
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 07:34:14 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::24) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 07:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Fri, 8 Nov 2024 07:34:13 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 01:34:11 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 5/5] i3c: dw: Add quirk to address OD/PP timing issue on AMD platform
Date: Fri, 8 Nov 2024 13:03:23 +0530
Message-ID: <20241108073323.523805-6-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: bd995e9b-9581-4327-943d-08dcffc7be5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jMP6aeMpSwkj6o21K3MpY78ciOl63HmXESR2UDGxvBvmXad8w4Y1kJeFJdO?=
 =?us-ascii?Q?0xpwgP+qHTGyibuvWnRng0Xt/GvjUmiwqhO0KBuTCVo8wZb+ljDxVxGGgTRg?=
 =?us-ascii?Q?h4i97agz/hfPOXi0x1T0k9AyRmb/V323d/X8/LxGawAaDGoIHxCTgVMSaBF1?=
 =?us-ascii?Q?2oLejN4/46vs0YfrnpI33mix82jY9Rew+DpRRJjWhySPQhmMF4dtkarsd20W?=
 =?us-ascii?Q?qp7JK4b7g2pNUQvMkDk5IssHrWPB/vPBdHKvqFc+fQZK9GkQLpJ34som+NXB?=
 =?us-ascii?Q?i4X45KMYxmyXSER6nPcBnURfXqa8Pf87GNRWXWrL8XR8K9antG88zwlEaW0x?=
 =?us-ascii?Q?FDbx6x1DVJ9Bzb+WfXbxLz/hKTTvF3sl1Z2VqsYJY4Xuvtnw9zetN3gJPPDy?=
 =?us-ascii?Q?GZZJNpVR2W4zoWnyj4WfSoZ1gB5tEcyCRnE/L6pWCGoQ0SFV9Yw9EPshRFXH?=
 =?us-ascii?Q?4RBJSmdLUe1Pa1n/oRtFWfpa8E7VvVD4p8949l7A8sn+Ubp27gP+F09EX2TF?=
 =?us-ascii?Q?Gt4d57ZmcDHmu5ZKoDTZKDc2yJ9+UsginbGXIe2Nvtailc8fI/8FqUrIbuCK?=
 =?us-ascii?Q?cu4I5Ueozlq8uXWaEGyMOsmIFa9SFpB9SxFdRULg9mqSqpsCZHH28dudbQxY?=
 =?us-ascii?Q?YBEQ1SpUzzJeZgCQenM5THnnBRHNKsNXTZTCtWYz2MD+JWi6B+VL0PuLsUID?=
 =?us-ascii?Q?ChVIl1CRw74hdMmKoFy8Em+mEG5TJKDoFXw89gwNvxMAjr59O3T4kLhkvJYJ?=
 =?us-ascii?Q?uO2/PsqRbDB57Jk2fod50XtDNmwEWR6KQOSmCtTpDY0hh82RAyt+ONP7DTPg?=
 =?us-ascii?Q?bmAPdBo+rWqRS0Rmcq99BfLF+kmjY7IkZFG6Pxq67rxBoNqAzrlULDaazDb7?=
 =?us-ascii?Q?hRqP8EUWdM7V2VmMKCYGAzrGLzi78mmhVbi7pWN5wP30fWJkiTukZzHhSFf1?=
 =?us-ascii?Q?q3nOcyk0Ui0WDpM88lkEmIR1jVcV4lpuwpk3zYfhnXNNy/FOHwnj3qua8DJx?=
 =?us-ascii?Q?4VnwwsbZU5O/d1a1pXy7ypTs1EnA6/+ZaL02GVoUcSupLuTglk6ip/NdAVbC?=
 =?us-ascii?Q?JHCyUW8qjwxn0+w72YDAVQNoQXuMVURL8YMrKoD/3Q8mNB2WJtV+AJ1wFXMh?=
 =?us-ascii?Q?6SVoIB1KjEyHiSBKnWcbg2X5Po5QklwpFqCfjz6dsZDgAIdQyrXybdrplpt7?=
 =?us-ascii?Q?HIYTs5QreACftCrjY0I4drGHlR1FbQ49u0B758edBJq5e3ESQuTSPz7yUqGY?=
 =?us-ascii?Q?7MfVa1xO2qNhETjlvoZ9QtopbzFq9C6EEg+wwiYfMvfqhIGq0e5JNrz6ruaM?=
 =?us-ascii?Q?r4+YCozgm72BPIvARaBtISnsMQsKYMSP5UPR7iPcto4XnWzgSF4aYUea7vaH?=
 =?us-ascii?Q?ZXuC0s1L/BVz0PzALNwdyW17NdJ2FEKR2ht+MHCb38Wvcb7Wnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 07:34:13.6586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd995e9b-9581-4327-943d-08dcffc7be5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864

The AMD Legacy I3C is having a problem with its IP, specifically with the
push-pull and open-drain pull-up registers. These registers need to be
manually programmed for every CCC submission to align with the duty cycle.
Therefore, add a quirk to address this issue.

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 29 ++++++++++++++++++++++++++++-
 drivers/i3c/master/dw-i3c-master.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index dc701275485a..029f81729333 100644
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
@@ -795,6 +803,12 @@ static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
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
@@ -804,6 +818,13 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
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
@@ -1610,6 +1631,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 		dev_err(&pdev->dev, "Failed to get acpi device handle\n");
 #endif
 
+	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
@@ -1683,6 +1706,10 @@ static void dw_i3c_master_restore_addrs(struct dw_i3c_master *master)
 
 static void dw_i3c_master_restore_timing_regs(struct dw_i3c_master *master)
 {
+	/* AMD platform specific OD and PP timings */
+	if (master->quirks & AMD_I3C_OD_PP_TIMING)
+		amd_configure_od_pp_quirk(master);
+
 	writel(master->i3c_pp_timing, master->regs + SCL_I3C_PP_TIMING);
 	writel(master->bus_free_timing, master->regs + BUS_FREE_TIMING);
 	writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
@@ -1757,7 +1784,7 @@ static const struct of_device_id dw_i3c_master_of_match[] = {
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


