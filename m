Return-Path: <linux-kernel+bounces-183705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2158C9CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998C71F20F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9C54660;
	Mon, 20 May 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKhb6Yji"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD715676F;
	Mon, 20 May 2024 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206235; cv=fail; b=XIWF7nzvWcguNfmgg0uYxcVJxhK1hhglOcnkU4lYqmPM2JUah68EcE/u0CuJaBVz5ZRVaL+zz033DoVAvvhDqKH8f5syVdt97u20+ZJd8v0sMgNLgvTnAOhq+ZLA/Gv43UN6nTWUiZCLo0pVRlWLdBKexhDOYvWT3IzcE/MWsuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206235; c=relaxed/simple;
	bh=tu+l9oOPO1ViZIzn530t9nkb4u6RJMZaMufBUT+0eg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZmPcWqjuyrpncfTK+YO6dEBWJlckDhqX9EpiP3D52OclwnF2NY4emarSmdKUHF3fMpkcvxSscaEn8qsNa77rdu0wZIJS3Xq5uBDS9VVJXCGBWNVxN8JYVU28J2hVffLpDJz6L1QFOqz1pvbg/f+kk/OGaki8xkfotiMWJ3JicQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dKhb6Yji; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyZvJQY67yYmcmw9K8CsCsg/6gsFFIdj+mZcgV/yDHwlUaWnxw7Ft6kv/neDR6wowltrR+FOBeah7as6GJMgtiSI2ko7kSJViQhVBwS7THrjM7IDtOXBdSMJ0smIaSH302FPzRSneFBTCNMh36XEcqyN3s61hettYrMJhxRUXOSa/epmfSvZuhQ2+wEm3NHr6A67+CJCaLZWJD4th2SUBjBGMVgbQ2qu3zA1rp2vpg89c+dOeOtYHhSIMckJzPH0+wl6rcfGn5tQYFYbRA4n8Nyjlw43uqNef+7AujCSsmsf7SK6Ty1JMI/2rvgLrlnlGxCT4F+hb6AcGD9ndLMoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3G9hGj4HQSEaeMOnQ/xjz2Mzid1MG0kFCIbFwKAaOo=;
 b=MwuHqHZWF+osd9anX9/02rndKYksSe5OLceTs/OYrvWSaXo2dVpdBQb0kpJr7a/TJ3haVAKHJwy7c6FCdWoP+TFPskg4Ibk4eXAOFT/pDIEL1ydAtI+ba4mZeDbw5gmiOxQHysTKr/nIuwcIkUsOlvANow3Qo4TBQX4+vnQfTWl+zC0tlQ+vtZ+YCAyIkaKNfSqeQd7HEqgZ9o6L7lx+jrAw3rk2ye3nNiYrQrw9BWexJRnlC32Wjg6VjLP3GtHkZLdp3ql8k6tgrTAr7YtDuG5sI3/cEzyUN6lkjCljWUTgrqS5uxzy2MKdkq5qnk4aWCPUBAYq0rrTkA98WX3O6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3G9hGj4HQSEaeMOnQ/xjz2Mzid1MG0kFCIbFwKAaOo=;
 b=dKhb6Yji5O/LhZsHaWRbGlSBXsVzamKP0iYe3xFJJNw5nMcnbFGNKAcHqK9dp40g9Ph3HeevOeBbHvR4Qep2KFp80uz056eLu02LcDeLgpMl0o4aNGK54zMLQeZ7RuHrPU1zEy1ElLeN5atthI0VD994qtOtmmRwteJRfWyNA0W/F9BPB/M00RUm3cseujAzDAVUUIqTqsJic0S3YyXdriP7a6UjAwnocUbpF0QMAt1T1+zCU8aATGgeLxarZUJ8E12F+c3/U0TL9qWnkPyU9vhbgWFGowTTovo56rYdSGgvS9GFfpWzeLnUSDlnggrOtwzUxxYNNsG+Azvjyo3lsA==
Received: from BN9PR03CA0145.namprd03.prod.outlook.com (2603:10b6:408:fe::30)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Mon, 20 May
 2024 11:57:04 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::f0) by BN9PR03CA0145.outlook.office365.com
 (2603:10b6:408:fe::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Mon, 20 May 2024 11:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 11:57:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:49 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 20 May
 2024 04:56:48 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] platform/mellanox: mlxbf-pmc: Add support for clock_measure performance block
Date: Mon, 20 May 2024 07:56:35 -0400
Message-ID: <9a2c59a17314d1449a43d13ac0cf51b807de09c8.1716205838.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1716205838.git.shravankr@nvidia.com>
References: <cover.1716205838.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e314e5-703a-430c-186f-08dc78c3f742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CDDw9pvEMT4R4ZLynfQJWaXwzqPrbEZr217ypM3XszWWyY1ACF0Z/b9kw7/9?=
 =?us-ascii?Q?Qxhsq/BrW3vWd8IkkML/GhZi958J1uLiS1x8twX8CVbfuOZWGzwP/ops7b1j?=
 =?us-ascii?Q?nB+tHiNVoZ9aZbv06xTQsAy6Ay21+yZy2FFQt7oZC31cFnzpsVMADk9Lq+t0?=
 =?us-ascii?Q?syk5UwUtRWfjoyAeqO28MycIRCcjGkcWu3Rmee9VLNIWelDOTNr6NgcJJiqK?=
 =?us-ascii?Q?mFE/hdFx+kJDKaC/0VsYvxCaZsuw07FNHw+Ox5wGVv5zFSVawlFWscEFn6oD?=
 =?us-ascii?Q?hLvAgE1mET5ATZgnFifwiIISJ7iHWZ/QsphCFef4yyRCL1cNMqSCWPSE0YVP?=
 =?us-ascii?Q?HZT+BrSNwppu6xetg2nfz18As5serz/frZBd0/VSniGu2g2NDo6gMsJHLyi3?=
 =?us-ascii?Q?8k6IzuAaJOrSIl/w61laM3gVKmsL3685T3+BVgBkmrFVZUkprZaLXiTN7YnO?=
 =?us-ascii?Q?nnhdqOvNbjFyi9g29EeWPDtEryywyVVZ23AADDq56jxcrOCZWsrlItmuk34Q?=
 =?us-ascii?Q?qmiqYwiduYvNHNZ+N9NoRphD03JurreY8w6yokK4KB6od2C/nX/LuHY16FgB?=
 =?us-ascii?Q?e23ocNec/36JeTJwkFQ3GQUPRr9Ck9+2sWXh3VrwS+RlIk41+vIaLk3V0JVw?=
 =?us-ascii?Q?wshC3ssLWwVszRl0Ii5pS8UCZnmpVLcusSzMXyrkdmfDvArrA7lanURwIaav?=
 =?us-ascii?Q?7n5p5Iy5JZlU/bKVcHhwU2O6X3nciAnT9yGp5S2UNhGu+DfNRuJFiuXDU9n0?=
 =?us-ascii?Q?ElU05LCC3hJrrDq88g5PwcnCMqcICxSstq9yaA4Q+WqCO+ZKnvHCsUhwgyhu?=
 =?us-ascii?Q?oTt1bspK/1Jf7ovJq2TzquC/pFDngKXSkpOuFBec/Qz7j+smVQeSC08fjbZy?=
 =?us-ascii?Q?rkmW0aOaQEeJs21T4w9q1z8t7atkoJ83LYyeCXkRPVUDbWo/tni5DITt1XDH?=
 =?us-ascii?Q?LGoKE0e8uX/RsLv45Zqb0VWKNlGQJB8+ILrFK401LH6VxrF6MSwQFuG1CNO+?=
 =?us-ascii?Q?HePGRsRHNMHyyofT5wX1m0fSZD+0w60TjEHeci6iX7UnpERARwSZhtIloyxs?=
 =?us-ascii?Q?RSZY8Ivf+YCyEdBR0RYO37TpmxSQEX54UO+P+0e5P80GXRaBKZ2ZptOCu2pC?=
 =?us-ascii?Q?+rUTv1jSqoS+sO7dEyQUrhBEpNugnmX7xNBJjMgJEkskXLMs9XeNnoByDkq2?=
 =?us-ascii?Q?bfkfzKM7X9u0FF8oLkCwOHqyUxJZcmpahbbEKK9DiigRIIS/KpJtrfD0LF7e?=
 =?us-ascii?Q?GtS2587wuBT4R2SfKHEC0vzui+arMUrHaXqUYjl7gxBuuImgk1DqUcpwbGvb?=
 =?us-ascii?Q?7XHDNrIy1mBtgl55TRmve2Rf3pr/peEsYJDnMTLr/8rXAZx8pJ/+8x31BWqp?=
 =?us-ascii?Q?NLFFCK48X2jR0RUcgr9lygZgfm6J?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 11:57:03.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e314e5-703a-430c-186f-08dc78c3f742
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

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


