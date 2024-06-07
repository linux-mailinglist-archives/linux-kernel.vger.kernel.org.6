Return-Path: <linux-kernel+bounces-205814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2C49000A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A792B1C21B44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D57F15ECEC;
	Fri,  7 Jun 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZrFCVJJ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855F15DBC3;
	Fri,  7 Jun 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755705; cv=fail; b=tOFYNJBiroydAe3nWEiyJE6eIbckS68vdien/WdM8ZnYIyykEf2f3QH0cmI26pgfdy0qmNxVsSABJ4zHLyzmybqB78gxk6vlb4pp/BeUxd+QuRBDkeVUS4Mr4/CwgIr492KtbkZTtzY89i7VJ0VkcM+5iJcikGIanteZ7xCrHV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755705; c=relaxed/simple;
	bh=tu+l9oOPO1ViZIzn530t9nkb4u6RJMZaMufBUT+0eg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSbv5AoiZUwkUOFOOq8UeD4gMQPEgQrn0pd3aGG5uvQBG/5cYpWhC6VJXjrB/U4s/HQml76vHP5e+8pxBcUslF//OQ8x8zCOWXrFiccM9XJaqJwmROPtiVCAOIipMkzoS6JfVSPaUAkSMpGPJL7j0FOTeyrGz5xuVqanQ7PE4+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZrFCVJJ; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0e8E5O8d+1Ca2bDQEgnSqAYMFslt+hTSFP/5v/88xZxc4+3qHgL/27AK9bNsI5AG+q2yDbunkEMH+3+Gv/IT1r7AwjgGnwWrnpg1L8auXH/9mT9GNe/8abd5hxwAHeRmWwrpW5ZFVWpmgEZySTmdGvcsAurTJVe1++KF6mv9K7Ct2J6xAjpp0i9blVERY+OPlBA9mhXwcKU/U6jhITvIf1y75+JeK6WkaQaS8vRbJ3e/eaM4nW9iUJLlYOj3d354F3FRIfBnhmj71nb3z0b9D4lXcAEyGyl525sqWtUEmxuw+MAhfrZwN+1eXHlppG3N5op45M0vAOvsNfprtjP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3G9hGj4HQSEaeMOnQ/xjz2Mzid1MG0kFCIbFwKAaOo=;
 b=XT/oSeNGjTkqQyDx0Xou/iLmRvXmXmvJqFw+YfT2L+HbvG1ulE4PWU8oV6fZ68FeQnCL2DFNmCOCUIoZnlRTttrs5sl5eSksXJw3KLDfZGv1zRCRId0p8fxxj8dMELyb4QEWmPQJvsmiSXUGb0oSAZ9BvXDklrS9tkrxH1aZL2kigxyBQj9SQYygrw6Vz1iiBefgi8Ro52haohVllG7hZr39fsSTRgBujGUa2NI5lO456exH8fWJL92zCj8T61MPk6kTyiI8KfmM8TlvPrTWwKXhkfOzQmcnlhccHfr4YBBQ5h3fp8rQtgUCXNM7ZzmuG+ckuqzYuW8AS6M/zIDPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3G9hGj4HQSEaeMOnQ/xjz2Mzid1MG0kFCIbFwKAaOo=;
 b=lZrFCVJJ+UJC08hNNJkdLaEXInSlJFwVzVjrZuJIuvatnN5q8S/eJ6po+jk9SWPb58hfMV0MlqUCP/pJ23Dcextdbbnk+pC9bjI0dDzFTdcDPeE6h7KIjVgDJ0zA+8HZJ4gIMbig/MbfYcqqAotv5qxewtqOae3COEEA+lbFYYpswRS4EYAvBaIvOrdqclRq4RVJzdHizXWCNVwb0rora+npWDnVsSinvLK+5wTYDm8v0ULQPR+WvlUsGoVYYbTx5eBFuAVM4iLK3a/EMv9TMnnideCBmhHGN3FVQVBAWLB5i2ODN8r4dylxQS/z33xZrdGyQqqduMRI1zcD1XlWyg==
Received: from BYAPR01CA0005.prod.exchangelabs.com (2603:10b6:a02:80::18) by
 IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 10:21:39 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::ca) by BYAPR01CA0005.outlook.office365.com
 (2603:10b6:a02:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Fri, 7 Jun 2024 10:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 10:21:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:24 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 7 Jun
 2024 03:21:23 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] platform/mellanox: mlxbf-pmc: Add support for clock_measure performance block
Date: Fri, 7 Jun 2024 06:21:13 -0400
Message-ID: <7f90c24049918ba877d6c576cfe995707d052bb9.1717755404.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1717755404.git.shravankr@nvidia.com>
References: <cover.1717755404.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db6d8e9-f077-4ed8-3f29-08dc86db9e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+PyqktZZ+Cq/w3vs6VKHnnJ2e0TkwqjWmkOEllGEfWy+R5eo+4DJ/VuU2wZ?=
 =?us-ascii?Q?7OmMm4Cu5rdDUxxwvPRPSItE6yCcrzil4XDPjlkcgCvJUdEGo0gr0laDbHCn?=
 =?us-ascii?Q?loWokd6K2NWY7HfvTEfKcm60YbGNqwlr97O1lODSRCUfU1PBNiEnD6/V5DtJ?=
 =?us-ascii?Q?PDi8UGVYL9NeXonUS22KPHUcVxZ6oStAvvOYlPimh7uU7j2u7ByQJ3Gw/K2L?=
 =?us-ascii?Q?8L+yRTQJyj5Q2VyJFPR+ELH7DpmVhcZR653U0+t2dy8ySktlhCCkryLBhclX?=
 =?us-ascii?Q?RFHBj56MB04btdzjxU/FK8keeKG2/+/U3tj8NoJkEof4G8cFs0cKZ1XW40qa?=
 =?us-ascii?Q?V9oiEfDULnKzmjIMZEThrC0p8Bu/5HIXHqpiuY8HwD2IFMSkQCHF3o9n56Bm?=
 =?us-ascii?Q?VRJEPidPKV/NMSg4KzPHbXwXv9KU75vYcBtEzQCNBWFTgd8sgTlmrS9hwyIW?=
 =?us-ascii?Q?gX0Mx4pqSGs0IEavJoJC1EOLVYQDdQoGRMlf3QoAFj/AVWDRx9OfamCtkYSn?=
 =?us-ascii?Q?1fcJEhZ0oKrJAEHguLKEp59BYG6QN8bxvUPVckjd/jjED1kFKj5ips3gNufK?=
 =?us-ascii?Q?0XvnykMYfbqjg2sVRSesvUZdRiSMPCD5+PvlpFzAqhsTzMNvCFgDQYLSw8ED?=
 =?us-ascii?Q?wiFkMwqvXkHcRSHKJWBNIvX/6Ut1CNhlt+lE6xzWgYe2dJ74Xy/hINt7N9Tm?=
 =?us-ascii?Q?pP/XNNxh4M3PGdcnNupKvJI9wI8zrJu4rEpc971CG5mgQhNtRMVpi7XeCdGD?=
 =?us-ascii?Q?lpPZx9hRBOTGjtV3nVgGT9+nRk+0lscoFzRiG5Dmhw6N56i8pqF77d5HiHX8?=
 =?us-ascii?Q?Q5Ea/z94ivyJfwZwLvkv14Dh8vfw2ecGY4E46c8jWHDc75NL8LIX49sF+xdt?=
 =?us-ascii?Q?ImeI1YCd4DjbRV2q1diZtlIBo7U+6L6VRjTCTPhVsXVKD/TlegITZcz19rx0?=
 =?us-ascii?Q?sc+TeHhCB5B+mDqJPwUabh2ncHoMnY2Nez62W8e2LHjD2GthcglQCLuMopah?=
 =?us-ascii?Q?PWjrzjhjMIX7rB/6NsfFsgzZtJH+oIwqtLpnTKf+QEtE4oPaDEdIN9jfVIuH?=
 =?us-ascii?Q?gQliYY7YfoXdd8AEPPtycsJhTrZPp1KOvBaiSPehZGjSDYsKIdqnwwTxYiTe?=
 =?us-ascii?Q?s08l3fnjYxbm1/HCpTATwKn1SYkYvsMPB7y49fufwny2h+C9m3kR2qoFqaSV?=
 =?us-ascii?Q?Ts4BKZvJZ2vIA6TH90DUr7/lv//nJhfZadOA/Ti2g/zXukuhGDJq7nCHjZW4?=
 =?us-ascii?Q?+g5fkQddv0WCURiJCyWytCXE7dQF1Xnzd8PEkmQzKgeVMPUaVHQd5rPA9RVF?=
 =?us-ascii?Q?+FAY2cqBtnr50Ln3STFwUMguXLKDswq5FmJasRp1/gmUW4WDY33+yizDvOrE?=
 =?us-ascii?Q?f1LbH7dTRbl9ehWOq+iQWtV2ahRv/PwPg7k3bZ4cOwkersXd1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:21:39.0163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db6d8e9-f077-4ed8-3f29-08dc86db9e3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749

The HW clock_measure counter info is passed to the driver from ACPI.
Create a new sub-directory for clock_measure events and provide
read access to the user. Writes are blocked since the fields are RO.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 46 ++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 635ecc3b3845..1212a96fb3eb 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -865,6 +865,37 @@ static const struct mlxbf_pmc_events mlxbf_pmc_llt_miss_events[] = {
 	{75, "HISTOGRAM_HISTOGRAM_BIN9"},
 };
 
+static const struct mlxbf_pmc_events mlxbf_pmc_clock_events[] = {
+	{ 0x0, "FMON_CLK_LAST_COUNT_PLL_D1_INST0" },
+	{ 0x4, "REFERENCE_WINDOW_WIDTH_PLL_D1_INST0" },
+	{ 0x8, "FMON_CLK_LAST_COUNT_PLL_D1_INST1" },
+	{ 0xc, "REFERENCE_WINDOW_WIDTH_PLL_D1_INST1" },
+	{ 0x10, "FMON_CLK_LAST_COUNT_PLL_G1" },
+	{ 0x14, "REFERENCE_WINDOW_WIDTH_PLL_G1" },
+	{ 0x18, "FMON_CLK_LAST_COUNT_PLL_W1" },
+	{ 0x1c, "REFERENCE_WINDOW_WIDTH_PLL_W1" },
+	{ 0x20, "FMON_CLK_LAST_COUNT_PLL_T1" },
+	{ 0x24, "REFERENCE_WINDOW_WIDTH_PLL_T1" },
+	{ 0x28, "FMON_CLK_LAST_COUNT_PLL_A0" },
+	{ 0x2c, "REFERENCE_WINDOW_WIDTH_PLL_A0" },
+	{ 0x30, "FMON_CLK_LAST_COUNT_PLL_C0" },
+	{ 0x34, "REFERENCE_WINDOW_WIDTH_PLL_C0" },
+	{ 0x38, "FMON_CLK_LAST_COUNT_PLL_N1" },
+	{ 0x3c, "REFERENCE_WINDOW_WIDTH_PLL_N1" },
+	{ 0x40, "FMON_CLK_LAST_COUNT_PLL_I1" },
+	{ 0x44, "REFERENCE_WINDOW_WIDTH_PLL_I1" },
+	{ 0x48, "FMON_CLK_LAST_COUNT_PLL_R1" },
+	{ 0x4c, "REFERENCE_WINDOW_WIDTH_PLL_R1" },
+	{ 0x50, "FMON_CLK_LAST_COUNT_PLL_P1" },
+	{ 0x54, "REFERENCE_WINDOW_WIDTH_PLL_P1" },
+	{ 0x58, "FMON_CLK_LAST_COUNT_REF_100_INST0" },
+	{ 0x5c, "REFERENCE_WINDOW_WIDTH_REF_100_INST0" },
+	{ 0x60, "FMON_CLK_LAST_COUNT_REF_100_INST1" },
+	{ 0x64, "REFERENCE_WINDOW_WIDTH_REF_100_INST1" },
+	{ 0x68, "FMON_CLK_LAST_COUNT_REF_156" },
+	{ 0x6c, "REFERENCE_WINDOW_WIDTH_REF_156" },
+};
+
 static struct mlxbf_pmc_context *pmc;
 
 /* UUID used to probe ATF service. */
@@ -1038,6 +1069,9 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size
 	} else if (strstr(blk, "llt")) {
 		events = mlxbf_pmc_llt_events;
 		size = ARRAY_SIZE(mlxbf_pmc_llt_events);
+	} else if (strstr(blk, "clock_measure")) {
+		events = mlxbf_pmc_clock_events;
+		size = ARRAY_SIZE(mlxbf_pmc_clock_events);
 	} else {
 		events = NULL;
 		size = 0;
@@ -1472,14 +1506,15 @@ static int mlxbf_pmc_read_event(unsigned int blk_num, u32 cnt_num, bool is_l3, u
 /* Method to read a register */
 static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
 {
-	u32 ecc_out;
+	u32 reg;
 
-	if (strstr(pmc->block_name[blk_num], "ecc")) {
+	if ((strstr(pmc->block_name[blk_num], "ecc")) ||
+	    (strstr(pmc->block_name[blk_num], "clock_measure"))) {
 		if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base + offset,
-				    &ecc_out))
+				    &reg))
 			return -EFAULT;
 
-		*result = ecc_out;
+		*result = reg;
 		return 0;
 	}
 
@@ -1493,6 +1528,9 @@ static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
 /* Method to write to a register */
 static int mlxbf_pmc_write_reg(unsigned int blk_num, u32 offset, u64 data)
 {
+	if (strstr(pmc->block_name[blk_num], "clock_measure"))
+		return -EINVAL;
+
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base + offset,
 				       MLXBF_PMC_WRITE_REG_32, data);
-- 
2.30.1


