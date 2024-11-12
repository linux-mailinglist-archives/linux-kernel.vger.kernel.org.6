Return-Path: <linux-kernel+bounces-406561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B79C60D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F88E283F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9015217F47;
	Tue, 12 Nov 2024 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NvyNiMJ8"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9D217915
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437521; cv=fail; b=UCMn4GErN+/p+vTXesSlMRb/o8PM7Wzk2kLCP9XVH+CetlC2y1IXvd/SBN4CktdTpAiNkNUVgTTnJ3BAxX1iiUhf3OrKTBhsbEt0dXIt/DbEH/QRilRoVLmiMHW4sZSa7bGn13gYiYxgmSyOkXJEk4/1/Ox8h62rA6PqvwnXl70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437521; c=relaxed/simple;
	bh=JCArq2paes462V82FvolIinFT9U/GeOLXOi2cG53vD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rj9z6PUzQsSS1Oj8e2jZjN0ttI0i+14mDjKB9RQvlK5hQ/MrgQWf+3w5Qz76/+f9R/0x8gYwHgXiLwERRWcOURGWl6hKosnWYkRGez6O83YVdcZDwvpz+t8ML+zh5G6xTNx+7/a9e/88boAcH6abywAt1lP3uUZ4akxVbVCnL4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NvyNiMJ8; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG3M10u/hmvGrscZCLCysxRtMRzZtl48eeSXUD34kDLafbtam4oEF1JBHVHHSbGpP+G5H0C0BDeiAsFIiwAslCL16gqYwdmW9ROirSR0IC3UFIaD0PxXdrcVYVdexf7qte663oiq9Twqi1btfiN+7uLwKhGWxQJ50RoOm5IUcFJ2sapOyMWXkbCndPj1Z+Fy38gMH7fnKxoaDhhHYucgyvDNhFyawNisk/QGOYPGcOF9wRCOCp0HE+xIoDukPBehrwq5/oK5jLjMf5sMdqvoO3IPPSvfJL0+8wnQrY+adNRDdasSiqNdOk1aODeYkoQOwQA8NB0lXqfjcN/Ttuqxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tB/zHa4I0nkrecKYF8loAUxBra6/AwysO5/gHTQRL4=;
 b=ei3+QvwdD/THngXEyUJtKFsvgU5QtqPyQPPfPHpeITjTMOK8OW8050HCz18X5o2EVvCd5AJtM+cVQfWrj1AlxReAnJ5KxzWSo1kGpQOtyaqfwpE5D4T/7PnQuONvhHsPeQHSue3tcZitWaeAUsumfMGivCJrJTKopN7gKzY9ulJTeas+cmd5z7sIc2YhH8b7PfZcvSJdz52DY36s8NNxvRSD8PSAUfYJHLVbB/nnfCPEJlgxr2EvPDy8C8bj4iw8+SWIclkxqdTnFteKtvVXUqsE5JenVZLHsI85HooxfMdRygNagt4ukcsP9nITlLvAGRKHHP26w3ofkd0bzCqM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tB/zHa4I0nkrecKYF8loAUxBra6/AwysO5/gHTQRL4=;
 b=NvyNiMJ82pCh+RVmBrrqzW7EfHt80I1WugcslqlCdXsSZT6Wy1XaofH24cDcRjsNYxTdZT2YSnzfPAPlvs7tL6QvAV8y7O4k+pRtpLqRf6BBHGMsxQD6Rjo5nMX1Lup9JjSUV0Ja0Zo6oVMVP6S91FAH1JkUNECzcc29TjSgRQI=
Received: from CH2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:610:60::13)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 12 Nov
 2024 18:51:55 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::e0) by CH2PR14CA0003.outlook.office365.com
 (2603:10b6:610:60::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 18:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 18:51:55 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 12:51:51 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] soundwire: amd: clear wake enable register for power off mode
Date: Wed, 13 Nov 2024 00:21:38 +0530
Message-ID: <20241112185138.3235375-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: b15ee624-0942-4259-7e0f-08dd034b1453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O+cfNXX/gNZR60He+gxfIGlxe22x4nkEBx2qzE/FOZQ5E/zmp8x//nL2lLQE?=
 =?us-ascii?Q?ybB4YKOHt49CvRkmt0zNBfNvoFBXwL8rz3wcO7KojxzXz4cNsJhg4PSk4YOF?=
 =?us-ascii?Q?PfAB5zpa78nQozeXZDP/gI3NO1RTfsbZ96ddD+vWT7097BQGN2EV9Q3Rb4zY?=
 =?us-ascii?Q?DUoXtjYV9Z3UEHD7Y0K0RDlTCAD3GFOEvgLCuBgPE21798sMdTQUy41atr2d?=
 =?us-ascii?Q?9KLl0+3R8ScX3fJ59IhKSEOcXIv/8bS8EHGcwqnB1UCHn71XDbd1qshgaoKB?=
 =?us-ascii?Q?DOwPcfJjGazsIAf02mU7GCAI3Xt+d8nxmVOYbbA4IpvqzniqBBBMH1mjxHjq?=
 =?us-ascii?Q?jjPUqxMdjCtB8YVzEzuSBaIapcbSN2GELXDUlrNQ2h6bsF/mRyTUf+NsKZ0T?=
 =?us-ascii?Q?470R268WiZ84LpL0sclbpbPG2MxnIEJm7WUZiiqI4UyTNMyPFs1Rxu1c+/pi?=
 =?us-ascii?Q?yL3g7QtV2glOdX4imMC/9WFE5rcf+jT90xgmv7c0dSV11//gn0OVIT/0iZj/?=
 =?us-ascii?Q?nuFPYceFXhHDr/j/r6NDJW4w7UvVHWr8yns8CdW36weoqb8aqv+9ZOrAk28S?=
 =?us-ascii?Q?Nq2YecMhx8D7BaIEWpHa7uBIMwsqkeXeawFSk/oYbLMSnjcLUTxo0mPmef78?=
 =?us-ascii?Q?du4eoBAOESWJftN997GHcl3ft/fjHFQXYsQBf/QpNqFLf4dOqkKA9qDW/b3i?=
 =?us-ascii?Q?O6qFXCgVrhxPYYRp1u/XnV52kok36c3L8EuuSfnnEHa8CqcZvQB0aqFgyB4D?=
 =?us-ascii?Q?b9NQk0+1LAlWDqj00oH3NzWW/CS2m5Te+jV8WS+nIp1UC5I3wTotVF6W3Hii?=
 =?us-ascii?Q?+BPBbaSpk/xMiGza7ISGlnb8mH3t8aZC949Bms5nqU11NABq+fsiltU/O3MG?=
 =?us-ascii?Q?lNSM/HoyQC+58K4JAHt/c/k1iXgArxuKCTB3gyCktrPMg9PutP5ILwxlFgfU?=
 =?us-ascii?Q?aBQLyfSHfQhyYg65NYL6oj80O6FNZdnPlHw2FqfdWF/2aFu1xSsYLGMgjbRw?=
 =?us-ascii?Q?xJDULB4RJHjUX6M1w8XyAI0QS7fDys7ayOqGT+fUVLmMt7dTIVRaa3jVzlfR?=
 =?us-ascii?Q?c6wR0OzGDMidjmiFni2gfvshMeJNJJSU6H0d9FJ1NFLqgwLDh2KFZ2qbLXq+?=
 =?us-ascii?Q?c3ywlo/LrDXzIguK2h07kN+0QNI5mKcOgABqU3oeftd7tgVxuA2s1vEhpyRL?=
 =?us-ascii?Q?Eh7CQmG6if5IvOgHpmjHaOiAvlLmG8QPPiXWO/zNuEIAO5dxDu3sbCXVwIZ6?=
 =?us-ascii?Q?5T+PZsIMckYTDGiw+YePHq649DYtLVtr+DfvKP5L2vWkGrn0DG0l9dzG4C4n?=
 =?us-ascii?Q?ZnAYFhdCZyIQdWUB+H64YajM0Ub7vsO/S4yQXLVi34npZSm5GgBCGlslIPJZ?=
 =?us-ascii?Q?XifB8vABTNGRwUqlzXSGf3v9Q4wWs1gSGAeyk2bMW97oPQrXRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 18:51:55.3987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15ee624-0942-4259-7e0f-08dd034b1453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

As per design for power off mode, clear the wake enable register during
resume sequence.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 5a4bfaef65fb..96a3aa6da711 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1190,6 +1190,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
 		return amd_sdw_clock_stop_exit(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
 		val = readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
 		if (val) {
 			val |= AMD_SDW_CLK_RESUME_REQ;
-- 
2.34.1


