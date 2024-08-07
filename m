Return-Path: <linux-kernel+bounces-277307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4893949F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2620D1F25F41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA55191F8E;
	Wed,  7 Aug 2024 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ib4vKZR6"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB019066E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008301; cv=fail; b=HW3BwXTV5mmOJRYJlFtM+p+Io67iUmzksHkLbjonHeMrYrGgMRSKVsM1x+jWtKb07E2bT/PoxKssDrR1wxt5bWQ5pgP8G8NQO2Jd/uC8OxvIdjaMcQcYUGwCPmDnla7UT4ymbBx1yObU+Urqf3LqX4nIdgkqhXsVh6deLaTRJOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008301; c=relaxed/simple;
	bh=7LNxgH5UwNzQzOvq3z8g2vA5dXDlCssf1xQ5/XC1hBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqG96+0tUuwjXlfuirq0KODseJJXoBCLWC8ovFWHSEdRFeQ8eazTB8/Now+qWH6G1Lzzq6aMSYAn/unGb1QfPDHwc2695qsbF7CVrkdiZ1Q9i4XtRZssRws0Xy5YAx6jImm2BEtqCY4l5KCa7GnMOH6CN2LgWPbb5vvifYdQVMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ib4vKZR6; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smE52I3Lb5bgBeqDzO6rLx/sswalWWRza4C++s6XovY+p7Hc9YQkVP5dcO4hTKsHuUU7LLO4FNmAVtDxQ8aPReauRDnbRYoVbkHwOCD16+M9pg63Ycx8cBtMXeIWIz16ez5v7LqM5RxIcWg7hdAB2/l7qHQEJ/0cLR+xF+6Io03r7hj6Oot0L4K8IgHDGX1G1+lQpE/knkBLgIi2jsyQ1qjbx7khkXYUSsNSUdIYuzuKz2nbR3Vm5FodfMVgCMPXa31Nk4xeuhmH9Kcurg6E/8x/BYsP6gn1CYSM9VseCQOJ2pa5K5F6Gv6VbQmZa9oHT34VbiQ3Dr1OzG6yCI8ypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeNzK2M8uP2TOsPpVfZtA0VjNeLPthHm+rBPx6MXsvk=;
 b=fE6KJ02s2HXdkgXjYuDcfThwF2HSxaL9jL5NJQKMnPXahHiKp99PB2ReMO9Nx5lHMIs7oBIwH+UAyDknuVq7JOR/JCK6nsbU61CC+dZfsrBFue9GpEhJ+H7yyZkaii3sTmkthDjcw9fvnSS6RdKppG4LSMSmljPhpOhgj8GwYRaStX4xiT9XTTWbp2FYzDOeJoQSxrOR29WID9VUvjLNBGlfxPyn9/dxZh9BVG9rjb6vj2ArudcLL4Iq4ATlcQ2xF9p3jkq9HFXULBbJO/+sdFjDudXCyk5j71Im5ATPMtCCcujeEDBEmSGcYFwo8iytvXFpS1SCJREJOmxrnpSGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeNzK2M8uP2TOsPpVfZtA0VjNeLPthHm+rBPx6MXsvk=;
 b=Ib4vKZR62raVg1fdFCM7T76YF4cWtCUBuVTXRBU3Hak0VZF98uVnCYG6ap5titIiFotKhj60BR4L0xwfM5CG4J6xdlCdKqUXi8A2HSqSwoHq2cCmpSaNVZhdEkgFEN3EG1uR7FPREYNetyl8M4viqClOoVJQjRvApArLP8ebzF0=
Received: from SA0PR12CA0017.namprd12.prod.outlook.com (2603:10b6:806:6f::22)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 05:24:57 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::65) by SA0PR12CA0017.outlook.office365.com
 (2603:10b6:806:6f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Wed, 7 Aug 2024 05:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 05:24:56 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 00:24:53 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH RESEND v3 1/6] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to the I3C Support List
Date: Wed, 7 Aug 2024 10:53:54 +0530
Message-ID: <20240807052359.290046-2-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e5d6bf-2564-4e98-b561-08dcb6a1462e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wtesaIZbwdEsNEw2PFYKlp69e1b+5bC0DnGWEsIyInkygiGLXG/1bW5WH2w?=
 =?us-ascii?Q?fkzVJP6cVH7Ps63TPpaopVAw0ENa/h/b38EbpYIC1QIQAN+7JNbdCMj37+b+?=
 =?us-ascii?Q?2JNf+m+ajUAhIfcOrJszK/eb9IOWDv5l3QvCLhWBE5NzVPoBLoL15k9k8N53?=
 =?us-ascii?Q?Gy6FATgRc4fDCZzSX/1QQugP16Otb/Axv6d04+tnEn51sh30xUzDPqWgMmFd?=
 =?us-ascii?Q?9zuyYFS3mgq9FOQX4fwPMPXqq99YawhGTh+tUxhx7GjaQSevlEfX8ngHOmae?=
 =?us-ascii?Q?uy+WeNINnRMU5A/vyVHKelqyz3pmoAxIKduizmq6HOrrT0YyhHpWTjfK1s+l?=
 =?us-ascii?Q?HguwTy9Hzxcq7BLENDcjmGw65bUPVAvVT++/skRiJGyVaq98znPI4xQc2jmR?=
 =?us-ascii?Q?t7sB2o/NBULlf09Lh1G6KXUgUwEy77v0uACWBbcjSsPx0LHfXDo0uRcU5gMp?=
 =?us-ascii?Q?2pAVmIeMMB8anty8RN4eBE8MuJ2gKHcwCfv0ZtMivJWlSaTMkIwZoBhqlBIO?=
 =?us-ascii?Q?RWCKVEA2r0w7ptotKNM2F53jAyDP3S3kYFHqxIrBJA6iqdQOklqbeFxA7bj3?=
 =?us-ascii?Q?pY6YttGzAUTDJhOkcvYxtp6vX1toPnqwj3uXHH55Pri8Zvdx3uLZ07x+0TWQ?=
 =?us-ascii?Q?Fco1HcgfiEo4GWqcMUEa+5Hfcid9dn5QLd2PWaGg0CrmMOkf7ggs6V37iXBb?=
 =?us-ascii?Q?TsI/mZVuuR475WFpGDzJ4uW88aWmTUh79ZquQW0VH57lABGc9BO/Jju0TuMk?=
 =?us-ascii?Q?+1ylDkwM6fCp7DBokMw8Pmsg9p7GqyL8n4/Io9b6MDyp6zeXvAYtB4hYImYP?=
 =?us-ascii?Q?x/v/EsENri3cNpqiANSqj+tprqb+ojgWFD6GLj/Y2RoEzQpm3YCtV6cK66Hw?=
 =?us-ascii?Q?g9hIl72Hmc8yvRfsE5diHcoVdKQzaP9xfOrpSPyjBJQZ3uVUx4xlpMaCvL52?=
 =?us-ascii?Q?6GTP5fiaMnM1ifVAWiiO40ipumiR1AJ0zjLJSdF+/a98fvF4kH7pzwhwR3oZ?=
 =?us-ascii?Q?t7Fm/QSx9CkCPN4mYvBQeyN8u8Y0e8Xm4JEjZPvpW7LAd/AQJv/baC8pYSRr?=
 =?us-ascii?Q?uNapN5wtaZlzkjqJkX95gR10ecKvJKdfbxbDTyli8S/eVwFVfe54GZhyQPji?=
 =?us-ascii?Q?JgGdMPHjrgZgz69l+C8AppkmV9AzgMyztUsbi3WQUkDPjSk92EhCIoJnkv4/?=
 =?us-ascii?Q?Zt6kIPqWRUljImO7UYzsacSI9fYtHHYjOebm1+4oIKlcL26DmRpZ3b+81txG?=
 =?us-ascii?Q?HxnGJDhAAAHFKZHfC2xtGY0JeW8Hl2QnZ3/4t3oZ6EIVa5Jn/d2NwGgcruyJ?=
 =?us-ascii?Q?C0b6rgM7ZFQUgSoOnTrwJ1jMNFvECRTYgcF/2vvSEBNzXp03pB/GLSxCZJ9S?=
 =?us-ascii?Q?hE17owxHb1vV9gf9P/Zc0yIWdRon6golqu3A/pc6K2sZWhjY5Vrqr86CeryQ?=
 =?us-ascii?Q?wf4B//Kd/Qvoln9YwslVAC/ZaPQLD3R0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 05:24:56.2442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e5d6bf-2564-4e98-b561-08dcb6a1462e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

The current driver code lacks the necessary plumbing for ACPI IDs,
preventing the mipi-i3c-hci driver from being loaded on x86
platforms that advertise I3C ACPI support.

This update adds the MIPI0100 ACPI ID to the list of supported IDs.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 4e7d6a43ee9b..24dd4603d6c6 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -834,12 +834,19 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
+static const struct acpi_device_id i3c_hci_acpi_match[] = {
+	{"MIPI0100"},
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


