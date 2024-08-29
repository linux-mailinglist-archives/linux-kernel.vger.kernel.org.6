Return-Path: <linux-kernel+bounces-306491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85216963FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76D4B2313F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1518DF8E;
	Thu, 29 Aug 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FR+P06f/"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0C18DF76
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923077; cv=fail; b=pqYpe+ooVuG+kiTjbyElbJXFqMWuKrrgeODZJAIkCf+9XXEgDozHkRugW+t6DCY7S5E2AIT6rPAXATa+O6Y1I8Lf7JHLE90OUPzF5t1xqGj/2RD2jmSD+OAVehFRaRCP5qxejVr73bYiqlL9A2C2pZtFoSKISfFkxVjJn34GhME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923077; c=relaxed/simple;
	bh=8qboCZzP28XbPOffL8yQZ0jC1IY1gcmenwvyJiK8lVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbOXf0hT3GzIaTfqkizCdFlT06xkO4kzg9rmz6bXZQTsviWyYx5iiuGpXbQrr+OR78lDNWOt/hEq7afID3tBI/IlAot3s2P2KTbHttRPkvnfU2lzypeja9KqkGcID/GF48S9byrdpRfQbK71Jr1Oqe7PDxzFY01RzkILRAVHl30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FR+P06f/; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkSFIhR1wIMC5jLOgn1ugigf8zkQTRdNZ196QR0kOWhOA1+p7QH8wxFpURfzc9QeDg5afsypcOEzA0lcepzWCzgdC86cAdNxl9Yx/W0NCcmsAhADuHAofkl3rQ3I7X6e2zObkrEsmXyMZyRv5z7/kcmm6Ohj8xNmIG6gdxDuNBvvRLoTe0hNB813ePUpPt5vQNV+GoEoodcYydTs17xTFnHTIL45uJ/4kg94ucEqNFRJclFMVmMcxrgrml/qLUeVH6mgYcAv0P2XA7HLMbPlnVkX9OdATrw6U8ob+omNGD3Nx1z8WajtWR3w98i+BzXTtXuRrYkdUY6mWnnKgQS2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp1T/tWQWGT/oxhp2sezXe6N04bSJ5E3tjcz6ey9T74=;
 b=JzNrr4ZIfcvIpSJYN/Y/UGE82hHeXaX+MqnHlAJF1bYPeR9qMKnJhlFa1iiqcy9XT19c9s17AXhUuY5ORsjsnmxN3O938D2gtBFWUCk0gG/SxBI77kTL1BbAl1QY8am161pCX0BKXEf8Jn12RTBBcSI0C/XgpNgzcRvp5m4GtPiy73c1ZSE5mTEh1wBG1sZpEW7lXhRrSw66ABtRUdX1BsIhiLD/db94gDldZfoQvAvcEmCT6lmIphJ7vHQyjU3Q+lSGRu9NWEYBkbjBwHNlPxXU0ysDOqp9vPMDTIRGg+p0RKwCjvw2usTg5SiZ8JEQZuHH6TNttQKjDV2emqBMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp1T/tWQWGT/oxhp2sezXe6N04bSJ5E3tjcz6ey9T74=;
 b=FR+P06f/o4ggTKwlvKUUAigCBWrkwkLpdu/yjfhYzr5uBx9uEvosYdlBMGUef+nie1/I2jZ/wi0PgR0W592X9y/8sGcCqBoKDNtzwIyc328Z2iCwbKF+/USdmbxVm03DWahx3Qr+GJDeL2w4EAQ/nteAUtBudwl1TaxGGhf6i7U=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 09:17:53 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::62) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 09:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7939.2 via Frontend Transport; Thu, 29 Aug 2024 09:17:52 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 04:17:49 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only after i3c hci v1.1
Date: Thu, 29 Aug 2024 14:47:09 +0530
Message-ID: <20240829091713.736217-3-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
References: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: f973ab79-4632-4754-70a4-08dcc80b75fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DpJecxKZxb8tQ2iVR4bihNGYJ1uIUO5JPkgQ+WhtNSkY5E35PB/xP6J/Xs5L?=
 =?us-ascii?Q?1L8U3jsyTHEBvW5aBO9M8E/YQ39C93xPwpD8V0wrwWgtem8HAu2mEMZgOv1k?=
 =?us-ascii?Q?kJg3ypV29+82uUtdXHhi2pqbz6jwFpZ+9Gb5KB5wE2j7l/398w+2NmxUlc9J?=
 =?us-ascii?Q?iHNqZ/MOvUt1mdXt1uYadpr2REQRlN3yYJmFsnxuwyH4HMn+FSLaP99SxR+g?=
 =?us-ascii?Q?ON4THxvgg5Q8IhT2jeqsbEpWL2ntSk2b75kpzwqgj3/9YwC38i/jyn8IDuLT?=
 =?us-ascii?Q?VEI0F+BtkA54u3mGGZeoALZT9kUfqgs9E0nx152mGdvEbkfyK8Glgu9j5X5G?=
 =?us-ascii?Q?QfnGBXv3ElRPNHx744Tz2HaEOROgKokFmSP/fu0md9kkLsXxGlVqNGpUIojR?=
 =?us-ascii?Q?CPzkAKoXAysmb0sJsuon9kPY/fTyH/d6lwUNUzd7uUYYxQu0NzY9Zxolpq/V?=
 =?us-ascii?Q?UL0ZESv/OiTYtacLCTAE3yCPlK/AiJe1S2xOLWgsOLUL+CY+T4eO65bD70sT?=
 =?us-ascii?Q?iDe4FD8kueoCKK+mp9sEjBnBVdwzuS949ZaHMle2MVUpEuCQejBJDPyU0laC?=
 =?us-ascii?Q?ubhzRNMn/TqW9cuojimI5wMovQ2PBHOxTYUQ384fjROQK/90yP0YK87noP9v?=
 =?us-ascii?Q?0w5pCSMtzHTdbhK6YVgERmH8fF/D12k2HJQ/t/DR9aEEbfid4YEmp6ZMQ914?=
 =?us-ascii?Q?1E7yYMiGM3/g6Afv1Cv1RkMo5d9kAbKe24MFXQZklhFkZA4zSSbcqV/+V4yj?=
 =?us-ascii?Q?H8txeRK5dMCSSVCyiAyymolESfLD5TFk4/XpUcRwH8EceJIZuc2fsRySqILa?=
 =?us-ascii?Q?CjM3yQgZuSah17iFaXz0Go6QOQviJHRhuolZvimD/dpjVRc2e+0kOhmhcJi+?=
 =?us-ascii?Q?XIMKLkMoYJptfOuwy3Y4/Q0Y2iE75tL0srLMNrL1PkJs9joaTGQmZagDHPvt?=
 =?us-ascii?Q?UslBtZJc2d/s/QcJoqZgPiMEVsfZjURhrMAqZrSK0/lOXFALVDFEi6aRMseG?=
 =?us-ascii?Q?aQ5MB+TILOQpWJznMouM/jk7NcEhka9WM9402sxY0oueDGey7CbvNYp+/mpw?=
 =?us-ascii?Q?6vPrJAzA6A5rVR9Fkn8mJu5p61TLr8hyUsFOzPRgS9ZUzoqOFK6TynM5uWpi?=
 =?us-ascii?Q?5/OrcJsRPelzckMSBV+nnzfoWhlwR0xKV3C4r8ISeFORNwF9mAxIxJ/Rsx8q?=
 =?us-ascii?Q?HaFDxv1pXwV5eGRiQJpRdJBF1jE6J+zxopKZ6FTJ3V9dgiTxZt2jzwYOnhTf?=
 =?us-ascii?Q?30j3EhFbtVBvjhXK0V5GmwbnKsRLdVzRn9GjjCS40m6vdtGv+k8/sfCTIPpE?=
 =?us-ascii?Q?tVZ/KCJnzNY00NchC9/6xwOtgiTcNIUkMRTfycGkd8eECDgfkicwVLFuVkEg?=
 =?us-ascii?Q?fF/1wMK3sSbx+LYpFVJVlKCDYV3fOYr+3x8PCkVcLLCQJViDiaEcrJWub11x?=
 =?us-ascii?Q?esN7/EF+TomGc9N6eILXRAdT5i7I8AXU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:17:52.7435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f973ab79-4632-4754-70a4-08dcc80b75fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

The HC_CONTROL_PIO_MODE bit was introduced in the HC_CONTROL register
starting from version 1.1. Therefore, checking the HC_CONTROL_PIO_MODE bit
on hardware that adheres to older specification revisions (i.e., versions
earlier than 1.1) is incorrect. To address this, add an additional check
to read the HCI version before attempting to read the HC_CONTROL_PIO_MODE
status.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 07de1cecfa30..a6781cfeebb8 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -630,8 +630,8 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
 
 static int i3c_hci_init(struct i3c_hci *hci)
 {
+	bool size_in_dwords, mode_selector;
 	u32 regval, offset;
-	bool size_in_dwords;
 	int ret;
 
 	/* Validate HCI hardware version */
@@ -753,10 +753,13 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return -EINVAL;
 	}
 
+	mode_selector = hci->version_major > 1 ||
+				(hci->version_major == 1 && hci->version_minor > 0);
+
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE) {
+		if (mode_selector && (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "PIO mode is stuck\n");
 			ret = -EIO;
 		} else {
@@ -768,7 +771,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	/* If no DMA, try PIO */
 	if (!hci->io && hci->PIO_regs) {
 		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (!(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
+		if (mode_selector && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "DMA mode is stuck\n");
 			ret = -EIO;
 		} else {
-- 
2.25.1


