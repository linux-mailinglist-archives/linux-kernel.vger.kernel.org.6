Return-Path: <linux-kernel+bounces-377391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97FE9ABE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163571C20F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02F14A629;
	Wed, 23 Oct 2024 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GQEKvGAd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D614A615
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662728; cv=fail; b=CcnRWIDSc3UHCVnviWXgj+63DJVMILP55tX2JlZ7X3L+lqUGm75RrFv2m/yrL32PdPF00nmxQNbsid++0IwxbhGgBJgj2tEnWV1TTNhqqys9IrLmuVna3KtGVJ1fiVQsgOZjXuy9Mn5s95KHnH+pWD3j05zLgqPLr0mUQPATtK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662728; c=relaxed/simple;
	bh=Bhg6KSiMYX2Aho22TO8Ku+ZHjjJg3WFDouSUv3VuSOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnxuBaYeipGQULNrWdxdW9mV1dtDsDMX80pymNZZqBNXqKZYD1MzTOCFZOcNoZKB9S92hEbP2MFHwRloFdzDB7HtqT5p9MQxfLdRe/+nZQpla5SvafeXylgyF59+yN0C4ag1hBGIAGeViLbV/46lnoDLE7i5kAHyO7YLezS8UvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GQEKvGAd; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrHiunWdaewHreXvhIkJH06YAlv3xft8t8RcIxePBaB7Wpd+p7IpVke6sEMebKvnnhqcrLbH3Ib0dvLgBpP3OrScOL3Mkx54xitoswnqI1/Y1vewm+YO0QvxzG26icfpUfmJO0REtR8yxjudIfBGZVAhXx3jkAmt/idnyg75uuG2ZWiIj+wSo5NiziEm6RLfAF/hHPgkmnH5Vs8S9rbK9hbp3/vYjmZwCdV1VrB3bMKpnatzKbG12eiLikbem5W3tlAsUGU2BvUAOq8yeIyW9D9+Bk5CNfBTaaseHsfPUva3ltIqTHW/r/JtWnnfeJf6NSQobNOOt6CIJ/2ceAjIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ay3itgHMYpEMOPmDr2yuhGrGo3KOsbxjohAcL05yeFs=;
 b=ppeN9iPYhID9t11lo2yZOqaVz4LILuWOUj8Z6PKeZQEx3RY5/ZZ8s4x5beScEF1SEr6PzGzoCn1JuAqdMUNcEbyAjHibExf41CP+/fH7CL3JjlaX95E+5pnxfddhnusGwmjOwzeZn8UqRu8xksPaTiqjYL5Zhn05rHTgZ/bE7kkolz9FymYMLRXRqJMW87vFTfOsB/zzPC3eY+2IBdiqhHOUNoCBWbEs52dxEnh+7VqcpED4s5UlUzjflgFJWv4JuT4V4gyLdJXJt5WmJyeFoJsQeO5yBZcS2JFLwb4XMe0BwIRcbgzrcahHaiSMcgbHj3dU+zXERoZ3bIED2TIWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay3itgHMYpEMOPmDr2yuhGrGo3KOsbxjohAcL05yeFs=;
 b=GQEKvGAdBJBhO3KKSrmW5LhnmVrVI3alNuwYhg4jU0VdaVJoPO8ePIf+fBiTcY4vt6lnNmdmSFYhEj8vuLsq09Qiqa/BJ40Brap5A/vEGvi2rirxy1KQwC7GYxVwp4sJKW5eQ/A2LW9sRVlMVDpt6iYUio/Z9otMfn/stYymJ6c=
Received: from DS7P220CA0057.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::9) by
 MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Wed, 23 Oct 2024 05:52:04 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::63) by DS7P220CA0057.outlook.office365.com
 (2603:10b6:8:224::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 05:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 05:52:03 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 00:51:59 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 6/6] i3c: dw: Add quirk to address OD/PP timing issue on AMD platform
Date: Wed, 23 Oct 2024 11:21:18 +0530
Message-ID: <20241023055118.1400286-7-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b892f9-7bd3-47a4-d852-08dcf326d1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HdWXeD4wQXXJktrLz+wGT3YpO0DMY8K7JPwDOFQQ0XFnFx9wNLDw8S0mopi/?=
 =?us-ascii?Q?F6aHbJEhHtmB4i3S9/Dp+kO3bybYAKzvRG3UOKB4NnegAp/PtpI2gxcOeBGb?=
 =?us-ascii?Q?khkqx/Sxiw8TmbvdRhtbxqBAGLLnn5FEpykP9AiZ/0z4T1DXCvRMPWkpPfqy?=
 =?us-ascii?Q?bParAzx4cjbHW2KuptaPWylzeCj8nPV0rgfotOHTbSTflfTwNaPzV1sN7my8?=
 =?us-ascii?Q?BM+UAjB5ZMOz5UZTlCpO+z/o6NxXGpjSS5efMc0swzTNaILGKxvMlQ487iLs?=
 =?us-ascii?Q?mG7cZrZMKmKXtUMbTsphc5dbDCxPjTXT/LJexQq70RmS6wxapvZPdZQIWLBR?=
 =?us-ascii?Q?gFAdwcBk+paeuQWleUC95gQERCjihHIBuSMObKdPkaY5+p/jZ02ypJENif2z?=
 =?us-ascii?Q?TjYRZalOLLWvohrIvnQlJ5JbykERn2Jy5tMpMeZqzZpAR1D9oCy1YO15pKEQ?=
 =?us-ascii?Q?dMwKqG7+VgYSy6o+mEMOjQ6ZwRz8eygUAVUhJCZwn0L0YFrv4IQbB8vLXTYz?=
 =?us-ascii?Q?lTMVpIAn43+BbsA6SxznkJj1CxwxmEKtu2Ad0Ce65rulL+rV2b/3eYlvopVU?=
 =?us-ascii?Q?QkzkpeUIe14LHGqMsL/WBEfzd/b++CKOFk1eZtFt/gkE1QeJ6Uu5AZeeNB/E?=
 =?us-ascii?Q?YIEYn1sJheizGNU1d65/wK+UWy0OIIYDcHNIQMzBZMU7xIEL1V09a5yDmTDx?=
 =?us-ascii?Q?KXNOxmb973Q0MO+P1cUDe2c6hcMes3kxOkVmqaGyE2FI1FgHl0XKoma+hnbg?=
 =?us-ascii?Q?fYcl1WQtyHe0EMtORB4XFNzrP9gBB57zshYtYluasV6ZYzW9fY+JypY+HVUq?=
 =?us-ascii?Q?emrVCElmYaodx4uWk9j9PuxqnB630MPIZDxsx9Fl2OCiMEwE5sLhK5GnDOZj?=
 =?us-ascii?Q?0F2+oBPD+VwKwQMyeOGhS2/Kj0CRBXEgBfTbWyoZF7XiD9DJMS6VpCwAegxL?=
 =?us-ascii?Q?i1C0XKPkfwFCOUsab00g9sls0GYhVJ3Emdz+2cmHNbhsIOtT2Ik4UTuqFaAu?=
 =?us-ascii?Q?8MTx6jJw9ATxc394/sgrbAo1Y+xTMZOQFgSCY8hCWN9VAeNHYY5TQqQLLXdB?=
 =?us-ascii?Q?b0tGHb0PPM0RcDaHJCXbkO5QrabomqoeRUZ1i+b5ir8+XuTWUPfyW9W5Ui6Y?=
 =?us-ascii?Q?G7wHo6xayRSNXB4E3nsAz6YI+nVoYLwFhpDh4hKTZC9j+iHVozF19Sq5kEEq?=
 =?us-ascii?Q?cor0WbJr7YiO1vVi/6Xwb/InzuLQmk8lCXBjX93y8osTJac0PzUO0IXdvpFy?=
 =?us-ascii?Q?uJL+7jf08z53HI4uOnT3VSnjPCS+ZD6dxYtgAIPT/en3RWM1FY4hhLlLX3f3?=
 =?us-ascii?Q?Ky6GuPQkmdWfzblRfGZQW/REB7h4sb3wKDvpAMB0LGvM7RQkNS7sNPWQmnph?=
 =?us-ascii?Q?HoujWjmPXUJojv0/EkcLSChWmUbPM+hYvif0snBVvhjU6BNNBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:52:03.4094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b892f9-7bd3-47a4-d852-08dcf326d1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

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
index 90a43209e55e..226c9946c4b7 100644
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


