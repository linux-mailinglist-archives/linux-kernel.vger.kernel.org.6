Return-Path: <linux-kernel+bounces-271847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C319453E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657811F2243D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD214B948;
	Thu,  1 Aug 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2VuUgf0H"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE014B09F;
	Thu,  1 Aug 2024 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722545833; cv=fail; b=LzJQUvgzvNqnZSt2pn1Yk2Xv5RQhwY3katUhMp4xs/SsryvpZrKBIbDexBAfRfOivAkUfymmNTnzXZoYE1MimFWMFOrDn2MQhxR5VOvZYStmk2BfnpRb/1d7rhh4icxPaKnJ9TKV5PwAB4OBibo7cD0zHY8CWCcF1Wnv2oEqAWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722545833; c=relaxed/simple;
	bh=0nVstud1AHpbKP7KIDd5jgNCNVIeEmiV6hYKhHsNpe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4Py9ipVw3zqp36Fx7UCh+5M9WkufZPii3K/wtDQXT1tcB2dU/ChpAj88EG2JixEoeLJ9WJJzn08pKuUAAlcQQG6u6gl9Mz3IYmtztMucR+PvB7Ppyq3Mt/wIMDEZPY5Bs2owWSxy3ufX2Frh+HtQgURFdwOmIqXMlYzZCKg6Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2VuUgf0H; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6nYW1FlZdNjygsKpviina2Ttdm1IyqPTF/L5K5jHR33CQ78o6eCj6h27PQacP+1X3E0kgXKp53ncA+S3zZjx6CIE0D4WEWDY67V+cZtitqim2wTGy8qacY6u/pmrQ9rTvoukmU1oYmDW+U0+qFbJyC+o5SJp1dR7yYD6HpOk9Bo0QpU7h1RmGn2qpROcL2geMD2eveskmLCdU/lrLaBZJD1bXhT70Y23jJ5v2JLX8l3+f1guKueyjyJ6LxcF6ycAoTtq9FX26q/UzSnqLhdGY0ZPYJYnT2KCJcNGK2dIXG+lA2DvQ2rUC+62qLtmJCPDTYvrb9C7mkslw7k1EUYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGfVJr7vigDF7yCcsU/twb2kHcxniQ40L+B4zC5/gh8=;
 b=jlpvAwyTwvUYFBI70bO6ZU7DcfM5t5Bi/C5/qL8GbSp8TojN+oc0hSOvPm/yigIS34gN8UW7CVnxKQ0xmE6VRxG3v/mgfi8WhFvj3ZfKZBS/Jm4DcUk6mUY2uv/y05046ebXZ79kxy5T0DA2J4I3TadpCg8d0/vciUPOevUvB3MAV0eVlJ49aUkXDUmlBTz4eOweUdctYtxXdJIgf5a1fU6kPxmQA28iM2/yAtnSFAGXfDe9u+0Qh2K+eFy6PYhTCrtDFYT9ycNhnsWhSb2aK+isfylWaHcIyjjabkq5j/Uh29ef0mGc5Dey3IRW3DmqNFEOBSow2gpd7ylgC5bugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGfVJr7vigDF7yCcsU/twb2kHcxniQ40L+B4zC5/gh8=;
 b=2VuUgf0HkbA2N/v9vgwKmeah4lqamYeXMC5UnB8qgzA3FWqm9Fa+pKmSnHuqzOpR2CdwVRxPAcOMdgbBIppSNF5NcfgRj2rO+hRkH7xTWyCRyEh6CNJy1DfPtyO3XOUY6fxz7usatPpJB2O7jaOJezGXd0iDVwsUgdNIRfd4gBM=
Received: from SN6PR05CA0034.namprd05.prod.outlook.com (2603:10b6:805:de::47)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Thu, 1 Aug
 2024 20:57:09 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::b) by SN6PR05CA0034.outlook.office365.com
 (2603:10b6:805:de::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Thu, 1 Aug 2024 20:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 20:57:08 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 15:57:08 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric Van Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Michael Roth
	<michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan Kumar
 Paluri" <papaluri@amd.com>
Subject: [PATCH 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line
Date: Thu, 1 Aug 2024 15:56:38 -0500
Message-ID: <20240801205638.6603-3-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801205638.6603-1-papaluri@amd.com>
References: <20240801205638.6603-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: a09d2f7e-9550-42df-c1f6-08dcb26c8237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/uHWwl6Zr8BUwXq8eZ5nssNB2Qcyqyn0Kn3CZeNjhWCVykFBQphG/9Od1kN/?=
 =?us-ascii?Q?CwMhlwyqomprCBQshIFE6tM6EA4dHPrdj5I/9KUFuv5oe4iaIAFZueAWFtrI?=
 =?us-ascii?Q?nPecY8PZSypLmtGKgVflZ5NG+KzGdciqqOtZmw/DZ+3FnwpFV5u6bX9Ogj39?=
 =?us-ascii?Q?F3aA8PbcStTDV0xGrGI0e0DF4lSYIiaLpyzAzGLusbdIbd1c4mPRKsXnSria?=
 =?us-ascii?Q?2PA8r4JtZn3nSbcYA7PqFg5Bw3zHbilgTtUFtLsoI2b1MISIamPYGDrZ0Htb?=
 =?us-ascii?Q?ujqdLBpYL2K/PXQk66KVHjYNA4g06CMfIpgIzBhU/8gbkVLv7jxtiSrjTc6e?=
 =?us-ascii?Q?ApCOOX8GzaKyLyDxvqqyutqy6+an8jnmzwDhgTp1rW2ATWkulVos5tHXjxtV?=
 =?us-ascii?Q?94ejqNLnMbww52itpwT/75TKvb/QIYOYGjxKkRx/PS2Z2zF+oPFwvBTejGHn?=
 =?us-ascii?Q?qrMqXqF8Bu0iIzD+z0Zjp/4ozReWSAQxXAyUtdiNnQJ6q11ovwEQaewqD64V?=
 =?us-ascii?Q?MiJM+bUa4faZD9yISgtTIyY1fV5fFLI5WyOpL5mlfpQkCXhri0GGjDtluI0/?=
 =?us-ascii?Q?DxSN/4in3lNc6e/pmB7LpJEKZunHuryJzL5blN646eIoGs3AFN5eA5G4uMox?=
 =?us-ascii?Q?O8fp3ZKyjjpd+C1SpujYpDQMvQtkJsHPTkgeOq6C8t4QqzVeyoqMVAKnAb+q?=
 =?us-ascii?Q?iaZh5hFHAQaF1MR6eT2KtnG0jvSbGTa8sssgIeJxcxmHcqLXUuD8hYRsWSPI?=
 =?us-ascii?Q?aYji663Ppqmi12yrs2+OddPDaoM45t2eCYL5VaeSs9n8UJiZXXSZP5Xi5d6z?=
 =?us-ascii?Q?za92fHiEe5hkhSsRmgcic7n3viIhsC2atOia0rB7HbOR+0CJZtnE2rZLY+TA?=
 =?us-ascii?Q?+c5t7eo5NsiW2jDUn0PaBcKR+lZGq9D0D/mOTmKyDiVwnnhe1urgAVHtq8EZ?=
 =?us-ascii?Q?N0RwVlVcZwd0ULySt/YhXpYEYVm9tNs/lJZhqp2Zc97hcKDe2L7gtGBkkTQ0?=
 =?us-ascii?Q?7/HUMkxsRfIH2l0PTmiYzKil7AKz8NdxJTvNpINzdsZ+j3l4wbtQvFyruuiJ?=
 =?us-ascii?Q?aCxA+lPjSoUFuaAHIIIjuHqPgjong0oDdZESZRpyk2/pTNuvP6ZmM0JGwDL+?=
 =?us-ascii?Q?9xBsqbYCWQ7T6P+wwwptxAQRNKwWtjTkSaczNkX91RSigIFdkPFfWRLFF9mU?=
 =?us-ascii?Q?+S/4xOa0xW4Hbq2xWqZRqAgCe0IiESAj0FqMPNn+rFOuZQz50SXNfWBf7Jbx?=
 =?us-ascii?Q?PMqeOAmSmhPt0bo0eSyLgBQfn8unG0T1WIyXIU9c3ue1WhXaTdCnyUWYEcEq?=
 =?us-ascii?Q?PdjNwZNZ+cprNXL24FQjwGmFS263wTa6CS245deSMWtypkpIVinz9fFr317I?=
 =?us-ascii?Q?vKv5e8iFA6V1eTxuoX3v2DPAA6Vf5eSiZs9cFHqh2w25WyCcDIWMRQXBY2Su?=
 =?us-ascii?Q?a7GyBAdyCQ0U1H2EIDufhH+3YfU9gCUf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 20:57:08.9890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a09d2f7e-9550-42df-c1f6-08dcb26c8237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

Provide a "nosnp" kernel command line option to prevent enabling of the
RMP and SEV-SNP features in the host/hypervisor. Not initializing the
RMP removes system overhead associated with RMP checks.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
---
 Documentation/arch/x86/x86_64/boot-options.rst | 3 +++
 arch/x86/virt/svm/cmdline.c                    | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 137432d34109..3d4e9a7dccf2 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -317,3 +317,6 @@ The available options are:
 
    debug
      Enable debug messages.
+
+   nosnp
+     Do not enable SEV-SNP (applies to host/hypervisor only).
diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
index 507549a9c793..1e71c75f0201 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -24,6 +24,12 @@ static int __init init_sev_config(char *str)
 			continue;
 		}
 
+		if (!strcmp(s, "nosnp")) {
+			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+			cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
+			continue;
+		}
+
 		pr_info("SEV command-line option '%s' was not recognized\n", s);
 	}
 
-- 
2.34.1


