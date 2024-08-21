Return-Path: <linux-kernel+bounces-295593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE34B959EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C111282B86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348C1A4B64;
	Wed, 21 Aug 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ywx9Bztd"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9A1A4AC5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247397; cv=fail; b=lXZkADnQf2XWYGkAP/Lwkzbr4IdBqeiGDahQ6Ynf7bU5A5Tm+EGHtsn8/5pR+M1SbYxJMAFwCGOfH/KF9CNAFrnA7NVO1csozdcBulzWoQ4XQvelc3EAuBcIabTFZP/lYgwdCcXP7pd8XxeInG8oaMu8gWAC1gEGQkVVVkRVCQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247397; c=relaxed/simple;
	bh=bhy961j36Z0WyfW+PhfmlX/jWOPy4EoMBtiAdf1fGb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBRwIUTW5HvrpnmRdDBCE/ke6P/9pkBCVq16Ia9qO42AwwKMaLIWmWp3tSw6ujl0GW56i5nao98PikF7Eguc70slol0+NAts/xl25nprfm6BMMxrstalBDC57R7xyQOtqdfWrjL7HMFuUbWzOthzq2YUlh+iFAYQXNHF0PCeGxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ywx9Bztd; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyTGwIRh3ri9jNfm9IK08UnfZB+NIA3EiOKe6ysmMwqME2VcfT6p6XAlT9kJgverjKsOni8AQ24awqnAEDV3QZH5P01/9c3trEidUgt3TbuBKeDaXDz3M/tfwQs6Wp7I2pwHHP7MZd/XCFOfRtWdUPTBNJmflUf9TxSghIigEp/qINKnS7l6oCL3Fkh5mwst86CkGmy9m/wB7EW91bGK+hWMBicdC8vLfvolM3hRDcAycYWtt2iC/noclOeA08RcGdG4qK+SYeNFITrP+ORpaPIDNxSU9PmV00wE5FRee1mCBpJX7c+i2Fl29MGHp/JMCoVXgXrCmT+7MeNyMTR02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kcFPD9kGzS67atyf65c9Z4Us3HnTkZIXae5xN0lYOI=;
 b=Zxe0aVVR9RZeHmXRU5DsJv4sG2yUAPqxvvUEuq4WwiwQKkW7Rm4HlnWlYhgXqaXjyVhG3iIMwYxycHvWV6F+ocDLHoAqlrCjEmAzbR2pll2vd60mjIxZBXoT/EH+vS8DXXdXiPlwcCvDOS5/rzZTcQSRN2mKgpVrzhhjGG9r0+9+2RBirjtQE+kkWmYzSlbZ9Y0D3Xxa31w7shQLnccqA7ew/TqmYKlryMx7HHXOSQmlGI1SzqGmxAYdt+9EFwizkeN09Li1Z96jmsEi21PwXAfIcI36+XM4Ux7BhqeMK16Q7bc+eoUjllAS1pobpnDI5qF37icJeVqKDfWB4NeGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kcFPD9kGzS67atyf65c9Z4Us3HnTkZIXae5xN0lYOI=;
 b=Ywx9BztduPahg35VEQ5dmRBktkq3aThScs5nTkWYR5xh9AhWCITF/tsp5RsoVE4tQLlxs9s1DZV1WjN/0R1da3i4iy9aesS80C404JMsclc9mth0v0DCCvv+8oX0kjXnzi+4mUFLu0nLBhSOuvPbFnd2lYQIyk6mwmmX+Rx5suU=
Received: from BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::32)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 13:36:29 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::3a) by BN9P223CA0027.outlook.office365.com
 (2603:10b6:408:10b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:36:29 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:36:27 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C Support List
Date: Wed, 21 Aug 2024 19:05:49 +0530
Message-ID: <20240821133554.391937-2-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 53285335-d0af-4da2-b6e1-08dcc1e6436b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H8hBL4qRxxGhAKuqCSTx6MXkh1vmH5xb6ZYGpRRm4u23SFYWiIsH2UJds1HU?=
 =?us-ascii?Q?gUeOpz8gTNn762aLUHruiLzESh1GgEOc6yK1s3Y1dC3Vuht/XC7nBqxmZ4ZG?=
 =?us-ascii?Q?UCBb3eucz68u18H9Jc0avZrVsZsZ6sgTAsLc8EUGfMuMcxO6KMNtQc7H2q8L?=
 =?us-ascii?Q?4FNPawAWMOUBwwMkSROrM/bbO89dWshin7JfDhkfjSMUjqHjDCzkOaafapv1?=
 =?us-ascii?Q?lwBQjPLFMl8rqBqbPN+DxQ827ZM/4cBjfIczBs9uV8uD512cZdUcdXh34LU7?=
 =?us-ascii?Q?CxV7TNmcaRLR+hDwq5hz/DC3POCLzr2mBuZOqv9CqA3pUbSynCfVRFNUEbFV?=
 =?us-ascii?Q?oyokOwHxp5sWDKQuh/YTPcRl/LmxEOUqK4L20j0hkyx/lE7uB8WamivGQ/3m?=
 =?us-ascii?Q?28BLBJi4ujonmR8rPYC/RQdLjSiycOap5oHv5AZ5vesRsYFCmCFLlqJgOfaY?=
 =?us-ascii?Q?keCIBEpUcMXTYAKTIU1OnAqGIMHTU2L7KbW7InVyukggDdFNdrM3kpToZ/kN?=
 =?us-ascii?Q?X4nhpNdJP6fRRGlUy5kR+gSQI3BY7f9f2vQ3X5xwg2Xu/Re6dhXZvqnV3Qyb?=
 =?us-ascii?Q?tJgrgcHoufaaPxSZq+NZYoBRhF5B6sZlYObPsoGLiDjFx65LQl5AZf4PO6JW?=
 =?us-ascii?Q?FtULSMPiE+QDzgK9WuU3lN3ackekLbkN287HbJYnIlemZv9U2X51XPvqwwwV?=
 =?us-ascii?Q?N5/T/RT0TbtpTajyNs25nijSzYFWwpqCpHsL9RZErz+jK3lzR/IFh/fPUbgC?=
 =?us-ascii?Q?+mW2N/34b1sVZzMvZU23JBFSfXgnZXoygkfalaJ5v39Ltk/XwKTp74qtXDhQ?=
 =?us-ascii?Q?vWFLy9DA1iy/OT1jJtnemj09LOyBW3MjRSeFYYpIZ1puAguckuD4/lpnMnrS?=
 =?us-ascii?Q?St0V+rAWRjkT9YbxptXc8TmbTm2oDclOjF+HTUvpFPXZw+M15E+cMoEJqk13?=
 =?us-ascii?Q?6DKCihZBlezo3Zv3iZG1cli8utWchKP+A2khEVOTTraSZ0SgxGNuFQ3IFAEM?=
 =?us-ascii?Q?jDCzAIuwyk3eAvjQ1o+QEQygGm2ATJ1MqgkmmoJFbwbhHX+7Ow2rlHyZxVM7?=
 =?us-ascii?Q?ruVy0KcHGghRD3x+UpGQ1yxpb6ojgMXL69rY5TGPp0W0/gP2yVyXG62f6R8L?=
 =?us-ascii?Q?3y3Hy2HTWCdM5gYOnM6t6Am9HOxI7TtbaNtMqoOup7qM2yPoOD4ZF/aKHJbY?=
 =?us-ascii?Q?upuh/PSiFvjsMdWUouW/CldYg2uGEDu1Mml3WfEMWGNOY4pQpK9XSThYdX6q?=
 =?us-ascii?Q?efYJqolH6B7aGzwQZ3TFHfUoHlDbYSHyH8V7vPYIEb29wYYcgRextHZp5YPU?=
 =?us-ascii?Q?nYN6H1dyay3+GX15TMkI3YJLBDMEsovHVKDkufmJowe0bTWeamFRqetSx3F1?=
 =?us-ascii?Q?MuKZber050i159J2B+w2AISGSyunqLKWNWqf4xdfOWbBEqVvH6Asfp57b2a/?=
 =?us-ascii?Q?y8B0DmB7AGb02o/36Qf4K0rCysNwQ9Ip?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:36:29.6758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53285335-d0af-4da2-b6e1-08dcc1e6436b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229

The current driver code lacks the necessary plumbing for ACPI IDs,
preventing the mipi-i3c-hci driver from being loaded on x86
platforms that advertise I3C ACPI support.

This update adds the AMDI5017 ACPI ID to the list of supported IDs.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 4e7d6a43ee9b..b02fbd7882f8 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -834,12 +834,19 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
+static const struct acpi_device_id i3c_hci_acpi_match[] = {
+	{"AMDI5017"},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
+
 static struct platform_driver i3c_hci_driver = {
 	.probe = i3c_hci_probe,
 	.remove_new = i3c_hci_remove,
 	.driver = {
 		.name = "mipi-i3c-hci",
 		.of_match_table = of_match_ptr(i3c_hci_of_match),
+		.acpi_match_table = i3c_hci_acpi_match,
 	},
 };
 module_platform_driver(i3c_hci_driver);
-- 
2.25.1


