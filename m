Return-Path: <linux-kernel+bounces-370015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBFB9A25FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135AD2848B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552D1DED5F;
	Thu, 17 Oct 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JNpYHZfW"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C21BFE18
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177439; cv=fail; b=uJXTr1Pjr4tmLvaaEKMc+7Hum3clSsP6OqGxdWz7Bkm7vseb8kM9YHTmvWdi846k76SZnPzHzKLd6ODcA2ydwA9kzSCMi7j57tLey/LOzVVaQjVX/wEgEY+LJpsQbIVk1AkGIkgnDFAMLYEplx8QghwVRzDkTN1hWHD6tRyrmKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177439; c=relaxed/simple;
	bh=cO40n/RBoTlq3RexU5bWW+aAYSG6nrkzZR9GLOld9FE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGBlKVXnRk0BdW7nSq1ONrOu6rw1UX0khf5OlK20yMP7liSlH0nHbbozH9QBqre2yIZMQuPSmUZW5d4FgaN3QbYFcMPC0O37Jdkm31sGRwufRBaY6KtVrybNJJrK/Yi/jWa0vno+CxZLs7fmSe+gTBbGG/n3ycCskN6Dq21I82E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JNpYHZfW; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMz+5LYb13sK9CnmD3XERlLuDvvqcyRTEJNchr7y+rEt1pSgFvwjIw716V3BjcdOvn/p81Q7+J1K/LYe7ZaiMxmaEfJPCjZXs5v6H3NoEmSY+j7o3ddv1R3o2vXM5g9glQwUG/9msznzmwZelnqVgOimQ4JqxZhYqTw5Fo8INKi1367Q1dQcJ2gZQvCdAluGyVg15kKn8kHpBVacV3ASnaROd7ShCJPdaTLHzbRRdTYJ7pQkreGI8OkGBsXcAzJySURm7eDo/uIsVRgFhRVzMMwGalEFxIgbqPMIpGeCqAJ4hrbauzlPUabx3oxlBo8a0CXRBlSduPbrPcPjxfmDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG1l/OlduYMsebpG1L+Wl3PJV51SZLKOsxFAt+EupNo=;
 b=Cs1JhZzlfOijbDbNJYexf6eLRbWdDSFXfvHDP/4sgdpBlrHVVzTz79ZDOxDUPHJvsNYKY/Wdu0yD6HIAFyWOLtxUZDTikc4VTlIKujvmjrVAbrAsxfJAXE2OjSgPP74nWAiFy03iqrCeCtEtDsxzaemRcaFMYviFrwVIavSxAz1LvBJMsEZYr7KlsH641d0Yj2aUIFeqa1BJuwadN86MfLpA+hmO9zrk8dboz8lKRsZTpGn0zZ3/1JF4tyk1EPesWRIRCqwRBDyS+XHtNmDNgZr8Ue1t+gBCL9Fcdx279KeCq7VVvbMRztSG0RiO80a6DKI8y5QPprY0sCbOvFvIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG1l/OlduYMsebpG1L+Wl3PJV51SZLKOsxFAt+EupNo=;
 b=JNpYHZfWQpiWVNnUVtnTfS+GtatLucjSgIvzpBV69pG/Sft7ZEEAQGwSJOnq+VjojzrDnTTUDzRxH4NN9cI4QSJWAAiH6TOTxpErd3yg7qm8tZ2tufJctaL8vhGAcgKi7MPpYCWGEr705tviF/g3/sIUiV1nhhc5GOqWeZNKHeA=
Received: from BLAPR03CA0130.namprd03.prod.outlook.com (2603:10b6:208:32e::15)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 15:03:53 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::e) by BLAPR03CA0130.outlook.office365.com
 (2603:10b6:208:32e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 15:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 15:03:53 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 10:03:50 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH 0/6] Introduce initial support for the AMD I3C (non-HCI) to DW driver
Date: Thu, 17 Oct 2024 20:33:24 +0530
Message-ID: <20241017150330.3035568-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 741b5f6e-bd40-4e40-ef8b-08dceebcea42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NFQtigHGJFpBpekaRChIAiPSwZDHSoNrWxcAbCiXoTENpw9BbpL0KqioTynN?=
 =?us-ascii?Q?9CYQygelOF3uXgBi/jcmSe3k1kguRWXGkdpYNqsfOcqIBfosJGiQtbbwfbiL?=
 =?us-ascii?Q?lQLJpadNuJnTUS3QbBCv1cNM+rMBjbufuBezwEVLLcBGpbOSFBTcCVqAmlBk?=
 =?us-ascii?Q?SIBsJtf+S4dOgJB426BWexeVP4yiGKZbUVW8xU4XitaaXsDcc8Wa3a4U+3rQ?=
 =?us-ascii?Q?XB7jasDZGFbGGFDU9+6tHORESX9EenkLLOQXFKbmw8kF7HbK7SYdjgZJSD+I?=
 =?us-ascii?Q?PFjEmbw7WK4ouiIUx5vvaZyFCQPrAq/Q/dAdOiP9j/PGP79LEFlLz/emb3ts?=
 =?us-ascii?Q?sf+DhbraubJBYs63ODCSI8gWFfM+np9++23FpwKhlyiiwmDmupVix1fG3r3f?=
 =?us-ascii?Q?RyK14+W8J1Jsj8xWYddwffWBkecjeOss6pBSj5F6tV/Apt8usxlx1bM/335W?=
 =?us-ascii?Q?aCcR015tExhHZqdh6UgicNW6FrQWxcSXRiTA+dPx0FNBgGwDV1hdu5hJlAQx?=
 =?us-ascii?Q?6H0PcFgB8S8SfROGYo4ETEYO96jReOH779+ZFaacomhUaJDVDjiXrqaFOieB?=
 =?us-ascii?Q?1AtIKAo/6ecSlWUMcVn1czHgHITXFpc/+k3aanGlQru5n3WKOydXxC8GWbpt?=
 =?us-ascii?Q?Uxcn+MjdO+Vy5ZeyKXsnLveJ8JONnGIO7zQ9/UJQ8gIsc5CFE3OZRZnYeare?=
 =?us-ascii?Q?bKZ6kaxyDZWgyFgLzILwR/2MiTvDu2ehZhwQfVXTAz4PKEw+AHI/z9uQ5yWb?=
 =?us-ascii?Q?i3Cu+9E3beri/JaWkBPVnLUKPOmeKxlNMlwOF0AJCfkJYJlZJd13BNwUShmp?=
 =?us-ascii?Q?Q3+eUDncUWKrkX5aQlFl5t0NHKJxp7yB3p3/b1y8nblzzCFV78NnQqOPIPuL?=
 =?us-ascii?Q?YHe/eJC/l1biPKEOplppo/Kol5m6UVWPq5gLyBvE/HM8PQgWSQBnhXvLkc92?=
 =?us-ascii?Q?PWcgNiiQsEQJXt9dIi8aezklMYuWxjbDyYhGYLnOAWldQPQ3yDF4fti4zJHA?=
 =?us-ascii?Q?h02vnpgKzQazeK3K8ZdAs6Fme5zRJTnjKlRbm9g41/uyKcjXgCGg+8xnMxlI?=
 =?us-ascii?Q?8vhLuyY74+lncmf1XDSx/5FzdKBMcuzsUpRE9XDCUSASLEep1LEhKHcRV6ao?=
 =?us-ascii?Q?oCq/BDQLR2N0bovwni8tigqdwsGySxhK/12jmMrHYzb6Eu8V/25omsbJf2sB?=
 =?us-ascii?Q?eBCNMEtmqTDFX5jKILcgcNuzhd5d8dfwCBIrjZIkTaBRdPrO5wRcUsK0pzzu?=
 =?us-ascii?Q?f1Gpg9zq+oiyeLgHVDNiaZQzW5HKiHMm6x5qqqJAU+qj/Z/g8Qg9YRYKlI3L?=
 =?us-ascii?Q?GR9Un7oPFU844bxt/9kIVyfJPRs81dsIIsOOMwpsFDt+pes4eYbhpMde4D77?=
 =?us-ascii?Q?oTrRC4Q4Hn61qbGsMN+uJgtueGt7WV4DWBTRtDCsWuXzlrWy7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:03:53.0347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741b5f6e-bd40-4e40-ef8b-08dceebcea42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752

The AMD EPYC platform design has DIMMs connected over the I3C bus, with
each DIMM containing three components: SPD, PMIC, and RCD.

To access component-specific information within the DIMMs, such as initial
dynamic address, static address, and provisional ID, ACPI support is
necessary for the I3C core. This requires adding ACPI binding to the
dw-i3c-master driver and retrieving slave information from the AMD ASL.

Currently, the code is closely tied to dt-bindings. This initial set aims
to decouple some of these bindings by adding the AMD-specific _HID,
enabling the current driver to support ACPI-enabled x86 systems.

In this series, support for following features has been added.
- X86/ACPI support to i3c core
- Support for SETAASA CCC command
- Add routines to plugin a SPD device to the i3c bus
- Workaround for AMD hardware
- Add dw-i3c-master driver with ACPI bindings

Shyam Sundar S K (6):
  i3c: dw: Add support for AMDI0015 ACPI ID
  i3c: dw: Use IRQF_SHARED flag for dw-i3c-master
  i3c: master: Add ACPI support to i3c subsystem
  i3c: master: Add a routine to include the I3C SPD device
  i3c: master: Add support for SETAASA CCC
  i3c: dw: Add quirk to address OD/PP timing issue on AMD platform

 drivers/i3c/internals.h            |   2 +
 drivers/i3c/master.c               | 151 +++++++++++++++++++++++++++++
 drivers/i3c/master/dw-i3c-master.c |  42 +++++++-
 drivers/i3c/master/dw-i3c-master.h |   1 +
 include/linux/i3c/ccc.h            |   1 +
 include/linux/i3c/master.h         |   2 +
 6 files changed, 198 insertions(+), 1 deletion(-)

-- 
2.34.1


