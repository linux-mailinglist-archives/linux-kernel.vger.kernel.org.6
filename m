Return-Path: <linux-kernel+bounces-358949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B959985A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B961C239C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB101C4609;
	Thu, 10 Oct 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F+rF1NOc"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BB1C3F2E;
	Thu, 10 Oct 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562509; cv=fail; b=srXxcFiOf/2a6GQIErbqrTvrPJmJA7do33ghTezsHOJFkkhDW9MvcYDFsDSggNCMq0Tb900tWEdHkD8W5mIXWJgKZdyGoX85KCgV7hFcautKu8sWG89Fk3oZKRArwXRQ9ShrjoXL88guVrSsdMhr4/tZIkGWJqWcJXNdUUPhBVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562509; c=relaxed/simple;
	bh=GVO2TmwD8i6uH4uXf3OsGK9B6Pv+B+GN/sGVcxrReUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bO6tUOFDER9tz4dIhoI8Vlt9Gr9xdy93YbKlzRWcSHaMK3yIYn4YNH/rqs3p6viiEx0Hl0JyzhhAIn6nT4nwVD3+W7DeypNTEA+khTxpmefAMa+iq7kMVYFTquW1oNL9G2Bs1aetGzgPO080T1eSpXg34nRDirstgaXQ5Bhuggg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F+rF1NOc; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNFA0Jx2UMmm0xAlWf8FdKucazSR653cSse5YGa3+M5UoxOC9yvELOirInflX2GTtf7uoRh4qzVK2g2W+9kfHEbPBd+1EJEQgKAJ6lC1gtaaI8RqWO3yW6dDDlzhZlKgwzZEGHGKE1Tz5sC142P471giVMGHBdBj884kkqylW6MBO1OfV5p1ONLSO25tz/0DIUD72cAgNaoyP77WebZ7SEckOh+CRT07B5NsN0XOEj/0KJhGiAn24k8kJIApRyo0N+weZcrtY8+ERlMut32zBYp0GQm/flsfnCMIza4ACwwYsC6MawchsmPzCd0MTwFMo8Ho/bbaiejqVuscmqnxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdQXzfNLBtAiSpxrnWW+oqufrDsRXfDIOO45bu6Pr3w=;
 b=aiWlMhRx0s5SoKDA94CxXshpUkkXn8ZS5Wxn1THef3mU9qamAx9NZ2oUnNJyQ2T83na2O055QleoX0MtVxRVJMiAnurdVBuK+2dkFPE/TU0BV6w/r/kRSEwK5cji7kRqvmwfcw8FauUQ8VYzesIzE2YbReLkgfCKpHIhTkcDz12sQSF2dabBXOgpBw602EX5I16TTpKPDzyZtB8jcOKtDnFP/c0S3TYgAigEzCikn1guVCOlaYTDGezZdUOk6eh1WckL2YZcZ5sfye0Cjnxvdqxiript5VzjOe7aDAonr6f582gEU0WviE0cpjZa39EVkTZKSdAlZ4JkRsuGU2TgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdQXzfNLBtAiSpxrnWW+oqufrDsRXfDIOO45bu6Pr3w=;
 b=F+rF1NOcTPyweXs9ZmcEeEIZ43/SdkSwraofztLK6ANQ6aJOyxpRZSPQ6HgDFw20yHu0nrb3Xy8ohBNXV5oIa5GeF6Qfz6/jT+cnoozBBqCUMzX52ERMfODPpaP18e7CtkoPzvEL5gY8ZX9ZMnGOtUBGPHkzmeVzxz30Ffix9Ms=
Received: from DM5PR07CA0069.namprd07.prod.outlook.com (2603:10b6:4:ad::34) by
 DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.18; Thu, 10 Oct 2024 12:15:03 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::a3) by DM5PR07CA0069.outlook.office365.com
 (2603:10b6:4:ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 12:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 12:15:03 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 07:15:02 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Eric Van
 Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, "H
 . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan
 Kumar Paluri" <papaluri@amd.com>, Dhaval Giani <dhaval.giani@amd.com>
Subject: [PATCH v6 0/2] nosnp sev command line support
Date: Thu, 10 Oct 2024 07:14:53 -0500
Message-ID: <20241010121455.15795-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f79fbf-f4d0-4593-a489-08dce9252ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZjZz+HcqztRHqj0YY3VZSSwcl0xgYWxE2O1ME0VH/lrbtcw9C229up/UmSg?=
 =?us-ascii?Q?1ll6cfRq6DVWVlOVVkUeJuKokhUDeS06ajUtX6MOy/PuKQr/BlDPIg42wtUi?=
 =?us-ascii?Q?vSPxt1blIOI14qlC4DntG0OeQFtZZArZEpNYcvUFJrNmjfdPxIhPVSBpRO2n?=
 =?us-ascii?Q?oyR2cus+h8UM+hNQHc6EzqrVTJ2wYDPhzW/aCxQBNlzF0mZl1Bmtd/4PPLrd?=
 =?us-ascii?Q?BrSPL06uDAfl2e/OYLpIrFSX8u+V5EVXPQIfRs3sqaxAhLZJkY0bhGRaTWO2?=
 =?us-ascii?Q?DxXSvbkzmEW9yjP/SdctYs7o3gqt67/bV8N6S4sdMCJD0vrqE4T+wWmY2C04?=
 =?us-ascii?Q?gy7OMQphMAG5Ba0J/5+rOtBPAqw2dCU8cW1YL6AJzJsehdZBOd9rhpIktvCe?=
 =?us-ascii?Q?bUS+rZJyNI2DF9G+7sYg8oS5CQ8eIzj8PowaPOCWPFMI6YJcEG2DxhSw1E33?=
 =?us-ascii?Q?vPQC370eiD2l7j8lr6YnRP0BTwyoCYNAVoHo7Ocu8h37PwYgwz7nCfb0Tkky?=
 =?us-ascii?Q?uIPo0gyDdBSsCLdE3dqujg61GMwQWbhFs+24+AEcMViXNaLjiWgURd6CCHyF?=
 =?us-ascii?Q?Mr46YomsSrAAXzhOaKc1n0jqt96izqxxnNEcLPbwxY1soTv3WqouZRnkOXQ2?=
 =?us-ascii?Q?LB6sYc2rPojcQT990fBaIzw3wVEI8mIbsuWpQb33YcZY+ZbkIpED0Fmf4ddz?=
 =?us-ascii?Q?BxE4L1zCWqYnV6rU3sjkpTxKVqZhNGIB/UClb3GS6YS+whpsXRGjWlrpVKX6?=
 =?us-ascii?Q?tplgLUe+bAuobvlzOqj+Oj0RaGLftQTw2EGOKGPlRl9Q8ta7vFB3B6awWU5V?=
 =?us-ascii?Q?YlQ+HHUQrNDlqLOX1M0XaqBEHG5/nTDzkI7hbZie677GisKlI+46VNowgSuD?=
 =?us-ascii?Q?SRB0T9DXGwx8C+dKlHOxYU9bXLGei8i8V5y25yWEBCA3VlNHupp4taVOUiHt?=
 =?us-ascii?Q?ty3AdNuVEo0r6/Di3rT0boHJstapCp67FNvc55lTRMj8LtryhqgnzTlt7oG1?=
 =?us-ascii?Q?wf2PC0DGZ+FNM9uRU+3iBwgEixheWVwDOjl7FkGNr51/ZGtrkLYkBA7ZKrxf?=
 =?us-ascii?Q?A+syi2hFgPujec83HhJh+4ARLwuLXVRHMDD9NrbjoA88GW069Ro7fUK0rWSb?=
 =?us-ascii?Q?ti0MJPrzlv9x5szca/12qIDZr4kDMTzQScoS/UWuG0SF2WU++SOxIvQpzlMp?=
 =?us-ascii?Q?7n8L342SXb2fweZcuuQl7IqZTu34j2jS0V+UJTJBZna6JbrXIXisuJe8aNQI?=
 =?us-ascii?Q?X8E8DGa53OtReegHrXYBGaxlMYDsLXw/KuFmRGWYaH9Ke6NqOrGjNvWe4U5s?=
 =?us-ascii?Q?ysbw3KAWADz4sbLgPN4Q3qnHv5JXJyywZ4g3IRfZnj6SrWVodipHR+qsEMCU?=
 =?us-ascii?Q?y9gLOjOeB5owIDMTJC8txdLlY610?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:15:03.3280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f79fbf-f4d0-4593-a489-08dce9252ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694

Provide "nosnp" boot option via "sev=nosnp" kernel command line to
prevent SEV-SNP [1] capable host kernel from enabling SEV-SNP and
initializing Reverse Map Table (RMP)

Setting 'nosnp' avoids the RMP check overhead in memory accesses when
users do not want to run SEV-SNP guests.

On providing sev=nosnp via kernel command line:
cat /sys/module/kvm_amd/parameters/sev_snp should be "N".

The patchset is based on tip/master.

Reference:
[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

Changelog:
=========
v5:
  * Update cover-letter and Documentation to include information on why
    nosnp command line option is required (Dave Hansen)
  * Remove <asm/cache.h> stray header introduced in the previous
    versions because of __read_mostly attribute that is now moved into
    virt/svm/cmdline.c
  * Link: https://lore.kernel.org/all/20240930231102.123403-1-papaluri@amd.com/

v4:
  * Move __read_mostly attribute to place where sev_cfg is declared (Tom)
  * Link: https://lore.kernel.org/all/20240922033626.29038-1-papaluri@amd.com/

Pavan Kumar Paluri (2):
  x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
  x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line

 .../arch/x86/x86_64/boot-options.rst          |  5 +++
 arch/x86/coco/sev/core.c                      | 44 -------------------
 arch/x86/include/asm/sev-common.h             | 27 ++++++++++++
 arch/x86/virt/svm/Makefile                    |  1 +
 arch/x86/virt/svm/cmdline.c                   | 39 ++++++++++++++++
 5 files changed, 72 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c


base-commit: 00d91979d23c88d3f50870e22fc9cec3f5e26a2a
-- 
2.34.1


