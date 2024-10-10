Return-Path: <linux-kernel+bounces-358951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA79985AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B2C1F24CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914441C4629;
	Thu, 10 Oct 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A3wGX7M5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532681C3F18;
	Thu, 10 Oct 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562531; cv=fail; b=euYZY3R9z7kQ615RCcP6ovpwiAQPWGEWphMl7gU4oEmcIYTu+A26HNFUr5aTi35Phlu/FiAYzdWkquDniG2m5eCZhiiFcux+LgawS3iUjEKrqCMXPwQqG0w4EC5wAV872SFdrohyYNve10YS4+sqgFfXhVXOp3kcfo1EilLusFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562531; c=relaxed/simple;
	bh=fuJI24g+lqVG7snhxlrsiuRR33+OAk6lyJx+tFD0bpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKOVEVoxafnMMe61raemXuWDBpVrq1PJgsDTNFZsb4naUVHUs5TLuBZmTHhMMTMmFP9LwERp4eP7jUYaweeeydWcW8WGF9y/5e9bSiRtjMS+AThc+7fuisdvqVCW2FXYjCZ2X/Rr0aFBgWjQVrNtDv2PRt8CNdKfgeXfufg9ny8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A3wGX7M5; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwFTWY+pu56oXcuUbuTJLPbsU4AeJV10MLu+UIC12S2zFsC9KkVJQHs1FaWqxz8eDtM/uZi26asCY253w6AFlsChMV/Uq5zOqepEMZ++CqM65wlKjbpWX+OwD8PdToz+zpwdRGu9RONxqtTLJ8lF5LqVfl6V55xJHfBKq+3dxllL+sWmbaaGhwkBtq3XtOM+t4VC4kw3JgPVZNOYjy2KSyYUru7nB6gxBtXPU1lhzdK2sPSlt8vl9Op62XgyexKrVehDO6PMJrd+m9yHhuCSxeuzG82e2fpMOw9dwFCFy+SduSatyKAH/IABsIOdmRDvvx2wRHAwLNA11xuZC5671Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91DX+f/Xb/MiOMiKXzxRufE8kaNCoS9bFbGmvzdyaCQ=;
 b=oYlyjeiW1fnVD5CaIqXJHy/Vv/418ZlRbBR28iw/CusrAQKkIfnHOYym7MA2sa+IcdV8QHz0eazzFVMioXxZ5qgS6C3Gr8nyiXZUrjIlAOHXoqUIiGXzAGU6dtQ5i3FICSSWm78GSiDBiboHquhWz3LKeH6IDELk+ViU5l5ZD5+hyt7iSFy23qoHv/alyaZBMh9KAIylu2aeFlAfdITB7KdGZquZqaPRv7PftXigz/1ESR9PpaYolKIwnEBUYMUNf1v3tdyoULReE8gd75BubC+Mss8ad1K0Flrhcp47wioYa1Y+/cWoLhO7hLgDelwZ+pMPrXK4is56Bqsgwlk58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91DX+f/Xb/MiOMiKXzxRufE8kaNCoS9bFbGmvzdyaCQ=;
 b=A3wGX7M5nD+VAYFlxKG5+w9TxJKwIbSWPf+gkUENRigpk/zLDFDm5a27laPs7ICmnzbxLEu2TTLdyMU68cBhoZdqyfwu4OHdKjaoHSxC/q3N44xxZ8FaR7eh98j6W3Da31VADt52gGvqOC5amxvcIQP+Y+Xm0Rjonrbzdav+jZs=
Received: from BY5PR20CA0027.namprd20.prod.outlook.com (2603:10b6:a03:1f4::40)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 12:15:25 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::58) by BY5PR20CA0027.outlook.office365.com
 (2603:10b6:a03:1f4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Thu, 10 Oct 2024 12:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 12:15:25 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 07:15:24 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Eric Van
 Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, "H
 . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan
 Kumar Paluri" <papaluri@amd.com>, Dhaval Giani <dhaval.giani@amd.com>
Subject: [PATCH v6 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line
Date: Thu, 10 Oct 2024 07:14:55 -0500
Message-ID: <20241010121455.15795-3-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010121455.15795-1-papaluri@amd.com>
References: <20241010121455.15795-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 073d4354-8329-4047-aef1-08dce92538c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wp4EE0uyhlglsQJIJAnsWekwq7gDEkymwIh4Ffsha5r9VNpF9tp434bf1O1Z?=
 =?us-ascii?Q?/bK9PZJV59Tz9ckRGmsFYqss6Q1HlxNf4iIe2to6zQGPbktVx6q0jnxcCBdo?=
 =?us-ascii?Q?3U1Nyvfrp/9JpfO+cRnc007nyhcNxm9eLRtRRAAqWufCkoSaPq8N1naiOIrM?=
 =?us-ascii?Q?cjDltdVN5Kr1KIoO9/UQ8bYYjcv8451jgpDGbsv8osaUrJd8x0O1iR5OtbIg?=
 =?us-ascii?Q?pSwxREjhQhahr+DjFwE7P/uCj1KZ97dZT2FGzUdtzSwxXY5hYIjsCRAU51aO?=
 =?us-ascii?Q?d3MdjVwnrX+9qRIX5jCp1+nY+MHM/HdrPwmaWxiIR2CWMfd1gp8W1e5aOAZG?=
 =?us-ascii?Q?dy+29bFlJ46SpDDYr4ujguTZqrEIgayYxIy1QKZLDwxTfMQEwcw5Y2cvPpOL?=
 =?us-ascii?Q?kio2oyF7DNvVh73jq7csN8KpNWvBnx83Vl3hEKzmTe/gpmmE7ply72dk85Zv?=
 =?us-ascii?Q?17GkMwBQKWpNpGYehlHy8IXzlFN5rx8R03/8sh5hrYT0KoV6LYo2x4knVqt9?=
 =?us-ascii?Q?c45WNz3noO/sIB5Q7WBDfyKlj+Xz4wfxPGYR3C/4oG3yoT1JXfIv2v/XOZwK?=
 =?us-ascii?Q?uZosJVwNlHZctPY4fLMFWdLV8rLne/A2rpXFNFkKhEKYOIvlIuI3zZL4d/gy?=
 =?us-ascii?Q?zRLrep6pwuQFPNXz7g2lxhWYIV4gl9kPWrJRqTFXnOZsMRiEbSwr778P7FLw?=
 =?us-ascii?Q?30xvvZern2VxdRroYV8PWLq57hyU0SXEMrjt8SbIqQFW3aa8a8lm3NoNywjl?=
 =?us-ascii?Q?O8WT7fnLmNmImQOrs2ftgwMkmTutJf0Q/hpzpbN74pjO+r9lz42wsg3hUrur?=
 =?us-ascii?Q?bYc9zE44AiT05kJqjW3wwRF48geZpcNRXWPJgBr6lsUhQTekMrEDZiaSofxV?=
 =?us-ascii?Q?LW1dROlqaZFFZm/RO40Q2hkZL5wTnACCmWcI2VL6bFAjxXa8PCZliEON1Z6N?=
 =?us-ascii?Q?ypgwaiiI5990ZOfWOQBybrwI8PxIpQJA0OXYAfdfMZc+uVvjuawbClItEmAj?=
 =?us-ascii?Q?j2snutddwVGFb1OLkwa+SWYBKNoDlljDrdrmwtT6ChhrkusTo6UGT7+KVt+V?=
 =?us-ascii?Q?DOcchcedUQkye2UbMbN9stxk+/rMzM7zExqfeiyLdfCH1bGgFMDHoEJKWel1?=
 =?us-ascii?Q?gQEKsYx/gcdq5O/ZEmxntGVQ5JzgEwtPDzM/zIRcZeMqGCtfouFdQUTPmm7H?=
 =?us-ascii?Q?zKXgaGA2RHGIYxCKTmwXnMetXWPFpljwDCZ5xfg8DAEet5QiZ9S/XBHc1y8T?=
 =?us-ascii?Q?1muqPbO/KTyIzI7T/d9BtU1C6PzHvob+cEOhkGcryY0XoDV6nEP0mCc2dQek?=
 =?us-ascii?Q?wR4HDN8bgqEdy9NV0+uKV0dymsesQ8PBvHk65X4QTrOzruLo32fCKAKrvf//?=
 =?us-ascii?Q?jhOMCpdLxTQMvuY2uKjM51l2/8G3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:15:25.4099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 073d4354-8329-4047-aef1-08dce92538c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065

Provide a "nosnp" kernel command line option to prevent enabling of the
RMP and SEV-SNP features in the host/hypervisor. Not initializing the
RMP removes system overhead associated with RMP checks.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/arch/x86/x86_64/boot-options.rst | 5 +++++
 arch/x86/virt/svm/cmdline.c                    | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 98d4805f0823..d69e3cfbdba5 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -305,3 +305,8 @@ The available options are:
 
    debug
      Enable debug messages.
+
+   nosnp
+     Do not enable SEV-SNP (applies to host/hypervisor only). Setting
+     'nosnp' avoids the RMP check overhead in memory accesses when
+     users do not want to run SEV-SNP guests.
diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
index 9640507342e0..313415d6f53f 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 
 #include <asm/sev-common.h>
+#include <asm/cpufeature.h>
 
 struct sev_config sev_cfg __read_mostly;
 
@@ -24,6 +25,12 @@ static int __init init_sev_config(char *str)
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


