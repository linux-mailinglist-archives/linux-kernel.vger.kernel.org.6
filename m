Return-Path: <linux-kernel+bounces-370021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CBB9A260A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9DBB287DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD391DF727;
	Thu, 17 Oct 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jYFU0FAN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E2C1DF242
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177459; cv=fail; b=tM9+VE4tk09BAYOokZoi1mT7MGAutR8TVptnI/nQKKofu14IF1X4XOm4Qf0iBGkvF6hXPpgIwwkNCHU2N1LKockMNZnGlsr8PtQ1j3b3EkyvrDKQsRGNEVCNlT6NvP4RnbTC4MaURBzgX/JYZ6uTNMpMQ1UURL1v5oITUzbNgrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177459; c=relaxed/simple;
	bh=vpyAbhgEgJ/5JKq5LVLbPL8pK9h/qD2IxvsKkfOr9rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiHagM0ro3ru2BrzpuSD+6FLSpgLxdKF8DzQjlJ1+i8kGszQUJKRJ/Zk/6Q6cMZVylcJEFZ5HPSMvmZfqvIQLFi2fcHCWhyfRliRSqK7qE5N0mwDkn2EREXi26G9ZlOyizg1y6iI4o4dbBwUlrlTTxV2Doe1NpZJtkEoJKFPFOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jYFU0FAN; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPHR358Now3TEXQQMg9rVfzu4nAm2J5/Xmzk9Yb6VJ8EahKRyUsh5PqXaikWh1B1XF7K7DjJGt7BJSev1pA44uIFawutT0prqvXmRcvENZfFXcelb9dRoMG2SjYhDQO09tTyN6z6cTtcr33tkzL7ABiVPMp99MH4nXEn/rG/SIF8dAbeS+y/uNInLEpdDVu0GK8PwjuWuCIjK+5DAIehfzyF/GOzAZms7Bg+KvkoXA+tgqs08ceyFzuckQjnZPsVCA85wDf+FqSYeewBwPWhRXZC7/7tDtFwmJHsg+N3oOMAG9td5X+POOFUE0NWqwdizgnoSW8sXiajjp5infD+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S/FySrZ3Q9Ro3xJrm8Fehq4iMVq9FScAh8YpSTJngs=;
 b=bXXYfRTIJitsAiCd7L+VidvlB/z9TewTtgquNf9aLhVc00bATJnE5gF9ofoz3wqMA562YFdgnd56Xae132yBet5MGWVhgHrtYS4LA6Ssj/l2VEQqojRhTq6kGYcHslOsLHXuNA47fuqtyZd4se4C0jU9HLLaQYOTJ8bdHmFsConBGyZIXarVUOVCDhls8yEIs+kWHXBPknm8hzSlCdfHmlgvAruBpBih5zf+rPjM0D8AylH0lCsReUMGxp5cqotFkqY4tEXoFEariC1twWb1dy0azYRmK27UNLFJK2ZGt8Lfk5gC2o6yoKxKEEuoVTfX5gJbFsd2xl5PX445LvrWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S/FySrZ3Q9Ro3xJrm8Fehq4iMVq9FScAh8YpSTJngs=;
 b=jYFU0FANwRmMXftd24x9096bwPwPq7p5y3cFhsrK+1pEOZ0xH24PYXYOCtWJcBb2uCu8w5lXiAJW+0+HO4gQjt/xIKvny+TA6L3SOdC1Ck3GWAGkzAy421CWjg1kKyztP3lousO66q8PU5LrDY9yE0hRsPCGI3rJIbp8bBmyxj0=
Received: from BN0PR04CA0150.namprd04.prod.outlook.com (2603:10b6:408:ed::35)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 15:04:09 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::15) by BN0PR04CA0150.outlook.office365.com
 (2603:10b6:408:ed::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 15:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 15:04:08 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 10:04:05 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH 6/6] i3c: dw: Add quirk to address OD/PP timing issue on AMD platform
Date: Thu, 17 Oct 2024 20:33:30 +0530
Message-ID: <20241017150330.3035568-7-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017150330.3035568-1-Shyam-sundar.S-k@amd.com>
References: <20241017150330.3035568-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e13d5f-dbf4-480c-c666-08dceebcf3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06n//8K5+T1SQk00uI3+3jM5R7AO9cC2C13dn2B6zq1xYBgydrS9HeWlJBVQ?=
 =?us-ascii?Q?6/I6fPw9aFOOeaoQ+nYuIk25xY2wGrwzogULqFC6YLqdiyVgMZtMA5Yhf2w6?=
 =?us-ascii?Q?N3nfGzc6tksCnKohXS5eRoeKJFCfuiOJ0Nat3s61jCJaBXex43yw9mLwzKNR?=
 =?us-ascii?Q?99WAT848QnsPqZIfqkACax4TxTQSDBMAHCp1zuopaMkRJmpEZyQPjGV7we4P?=
 =?us-ascii?Q?37OGpAvU6IVaE5D6t2iWUeuDegi1WtJyGzj4OPZ99i3BIEvPDzfgwniPEh2A?=
 =?us-ascii?Q?YFNYl/gTbN0WHiKxe5MdqsQ81uqpoLl34N2X02uA2FXoyZ9VkMbj2SbURv7F?=
 =?us-ascii?Q?KVUT58I8LPylLPcFiagi++DeUd0crhvhm6qxd1Yjt8Zu1/et15DYTaTPZwmy?=
 =?us-ascii?Q?VsjhnRVoC3qkmSjo7lX14UsdYeMZNc/9ZhiM+ZL/0G3gTFMUN5WLWMp5izhb?=
 =?us-ascii?Q?fQdrF9EUCbsXm42/hrpUMhBO5w2L20QSZq5fU5pwOQc6Zb/DmUpOntcjN3Kh?=
 =?us-ascii?Q?tI4Uy6mSqEoQv6nQ/Zc4VV5nAGg+v5cLjxmmtH8VM0ETx0Nr+tUqxe4UZNpB?=
 =?us-ascii?Q?iYJOLzPJH1Aj2Q5u46ScgJmx0Le07yuEXv/26OQkiUjoQr0yYDVvDN4Q430y?=
 =?us-ascii?Q?TKspkXlGTTGnop8rMFyOImFJ4bEksoDqRqnqyqpbVpHBTtW4w0xr30v60TeX?=
 =?us-ascii?Q?AeC6Lj+L1Q7ZK53fX082/h/PtZ1+IwtbeGcAy39Z2TLzXYpnizJxtN40HKhW?=
 =?us-ascii?Q?n4n3JGmmFR3Pd1t6LlKCGHVBoGq7IQNn31XwTBA7XKIOd2pYzdRAGUwO0eNl?=
 =?us-ascii?Q?7Zx0mZ6v0SEsRMOmB2QoxWETx0qt4SkoBnahxFiybIeEFTx0WvUcogHgBIqM?=
 =?us-ascii?Q?iVG+dtacAgfCYraArt8II6GK+x6+To52qgBTEWS59894fGL8duuabnCqLWw6?=
 =?us-ascii?Q?m/9I8VxlZxSM7FFd1INT07eImYstEpr2W2wHKmI+Z0B8G7bTvE849aiPjyiV?=
 =?us-ascii?Q?ZTjLQhjhwP4rr6eUgm5Ox2lT7Gzz8WTZJayvt19/lCaWdEdgj/vvhHl4lY1q?=
 =?us-ascii?Q?mwSuSz+CcotypBUDWsNHUong+GgK/+T31QYYrfZ33gLraL7zcWKztUBmFb4g?=
 =?us-ascii?Q?98UTQglbc8to4rR21sj49xzM8Au4ckvSOwlA+zELGKKdCjq92W+CPqW3eiXD?=
 =?us-ascii?Q?O1GJMbM+0jSyYvnGDOENwRZmFEjT5yUiU3p9PR+DByIl0rwAdyoKhPqlOQav?=
 =?us-ascii?Q?svPzT1COKayB/UbmddYyTbItXYCM6CixkVVsvJadJJKHGEGLdeDDkpoT238O?=
 =?us-ascii?Q?NQJMIjFxRVAXm2A+ZQJ95cAjUq/40bbM1gYHDIWk91gllPCMtDIq3HNvx/pk?=
 =?us-ascii?Q?AlyyWrCRLKTGbyLIUsQVDULw9Fl0oDBk+r9gk7KtI736G8h5Jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:04:08.8344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e13d5f-dbf4-480c-c666-08dceebcf3ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596

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
index 8f452976dd7c..8500b0d0dcf3 100644
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
@@ -1608,6 +1629,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (!master->base.ahandle)
 		dev_err(&pdev->dev, "Failed to get acpi device handle\n");
 
+	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
@@ -1681,6 +1704,10 @@ static void dw_i3c_master_restore_addrs(struct dw_i3c_master *master)
 
 static void dw_i3c_master_restore_timing_regs(struct dw_i3c_master *master)
 {
+	/* AMD platform specific OD and PP timings */
+	if (master->quirks & AMD_I3C_OD_PP_TIMING)
+		amd_configure_od_pp_quirk(master);
+
 	writel(master->i3c_pp_timing, master->regs + SCL_I3C_PP_TIMING);
 	writel(master->bus_free_timing, master->regs + BUS_FREE_TIMING);
 	writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
@@ -1755,7 +1782,7 @@ static const struct of_device_id dw_i3c_master_of_match[] = {
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


