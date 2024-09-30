Return-Path: <linux-kernel+bounces-344962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CAC98B0A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4F7B23057
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E218C918;
	Mon, 30 Sep 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JCWSXbb5"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A9186E24;
	Mon, 30 Sep 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727737896; cv=fail; b=f2BYjE6ajBb/dmFBa93bASRktqyEc7D1jIoJyp4r+2qmHu9/A/EVXvUx3kpUQTNCf8VHSqOMU9vfQw6hh/WvKwQy2kROwxW6IkiB34wmXJJqbIHLLOHaIozCA93ZyI4AGPb2eZGH8mXYPKeV59zflyIRHrjuYX1HeKMcjxWBkP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727737896; c=relaxed/simple;
	bh=hroTRP738OghtaNu2KOoXMspeAzXmy2nwXkRcARulBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSSzhcCOUP1xggkj55lVjP7IB0orAPlSeAUFhCiXDjKrjg0LRcqJMNrBjdZG93qjS+E7amH11wAM8+/ZFOoI+pkRMgdeGmMIObJcN0ePYYy/WngvEKF6yhQ1DkUKiGCNhKA3FLyyD5NUvMWrvw8gWUWU5l8GS92tNLUEAoTJml0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JCWSXbb5; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wc57YchSxGXnbTEPt/UvApkfumA/3knsss0ClV6Pab1glsbAUeDNIuc0/9BA9d+SAE8syZkNz4p1npUAHMpb2IiOo3gtcq2RBpCXVcnI/B0zuZHm8s4fjqQ0BmADhaWeJlC4wKZXQpTYBELdAJfdR/+deFreSWbsZvme2URme2+LrJkoXW2Dzu5FcbPvuPmtgPZf/M1gBa7H3V0fzj6DrjJ/bgV3UTZkiePDZtkT65zRu15xfeB2rtgKTwBL2qrq0b/vkyrVfI/59ESk+KMfmZ0SIRYLe/9bFCtgTe8yWRkL2r/IKvRFKBYqEGBZO5F4T0vRVsYXX8rZ3+mBtwWV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nL/0FNC6qWDEBaZ1+OnJnqPmWoEQikTtvbzKCSvDmw=;
 b=fTaLQAI/I6mG1AE/3arR1Zp+NyO8XWOFrWzC51fUA01Mm7hhYjRkuQLh7v6yI4IGusJ9b/PmHwIVPNYsfi0D1AkQDKlPORHfbQWzZJ3siwkxm7Gr4sRn/BbJCX410syCuP69acVjTye/PCdr1tJJ+SOSx0nZxqUQIJUNtlnwwjXxy4zcTz688PMTvJk4gv3PZvMQcwDY2p4y17r9osi8B8c6+bh1rnSJbJYboYzyTC4F+6k1wk02z+BsjvH75mLzHxx3937loJxmJ7HHHTrK8Y7AtzmNpuzEAAigVUS8wRkKbWfZu9XL5jN6iUtCwfPmYAa7Q0HoQjRc05OBw3fBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nL/0FNC6qWDEBaZ1+OnJnqPmWoEQikTtvbzKCSvDmw=;
 b=JCWSXbb5oXH+klbFP06zhYhSLfUPuVdzTp/U+STtk7B2JNj8bAFdv8WXCOJJf+j6ML/ZSOrbcCbMr8k8g5qKguiFu8/c5Gowk/1miWLFTKo8UrjMvANbHz1nlodDsmvOZqwzEs0GBFd7R0yC1PEsXsXH87EoVtxS7UlvEiVURP8=
Received: from CH2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:610:4e::36)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 23:11:32 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::66) by CH2PR02CA0026.outlook.office365.com
 (2603:10b6:610:4e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 23:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 23:11:32 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 18:11:31 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v5 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line
Date: Mon, 30 Sep 2024 18:11:02 -0500
Message-ID: <20240930231102.123403-3-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930231102.123403-1-papaluri@amd.com>
References: <20240930231102.123403-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 097ed8e0-4add-4af9-d8cf-08dce1a53963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H/bQLThXNUkx+UDZytJT8LVuTA4uT3lPyEWdYBpnbFMfUHt3QvRnCzWaPhgV?=
 =?us-ascii?Q?rzcon0TllNNPkVF3l1OKSzD+3PajrR1fjJrDo3Fo+C1i4zUVhYgrcuhThnHt?=
 =?us-ascii?Q?8u6JtEb5GAmIZg74HcPf1yezJbyQeZCbSUeplgmLH3HL3/6Nm374zs2Wu4Li?=
 =?us-ascii?Q?4erH6j63fnCfu5cBYfqI3vY6nCTjPpSZRPaY4Qof4DDIkco3Un6tfH902Am+?=
 =?us-ascii?Q?WU4d1vM3I8Pf1TBlQH/A8oghWIOEhXMRLHUrOEy7oEWWsH9KXlW7RbQHIlbf?=
 =?us-ascii?Q?8e1Z3TH2LNbsDIAU8P0MU03C63h4Mz7BcpWZuOkI6KLxYaNkS8KtsRaOYkkt?=
 =?us-ascii?Q?vehcR6dEmyMNT+SnlNl24tGdtgyMIiPXjz4cniuo0bqhdFQASuJuL2lcBIV4?=
 =?us-ascii?Q?m0vp/oQNO8bkCW3z619t5PsPXykdi7jvgCnXCs3Z3ucXtFNI58pvLKIsNKCP?=
 =?us-ascii?Q?qMi7xCZ7IuM0AW081WgLMuRsQwgJttrt1hK+GVqZfM9236TTLkVDwIU9QZ80?=
 =?us-ascii?Q?pUHb0gjuHeMWoJRcmlfGqUqQ2ab2Mfw2nrS0n17FkyWhMU/G7ZNPrBJ37UI5?=
 =?us-ascii?Q?42zxb9HmrCY5ACQLlokN9ps90IXZAR6KGAyZyU7+q4JRURFQ9I3OmRLBUzAG?=
 =?us-ascii?Q?co/pZjkDk7KCNSQa1d2TE0siu//HLFAhwgpZr2Un+xRxo3I1ZRnBaVelBrs3?=
 =?us-ascii?Q?LovMeHQvAMegepy0B9VCQUy2dsCCBmkEx5azlexl8z70urV28R21+IGiByxL?=
 =?us-ascii?Q?kGDMiWMiIhJT4gSKkHTZ0/vadAQb7Qqa97q3lonS6uZoJxRKh5VoiQhquKpg?=
 =?us-ascii?Q?2aKfa0rdstQc+wxyb3QI5n/xdqdqoCinQm2RzXYh0kck7guFD0pw38B9Ou+w?=
 =?us-ascii?Q?Et/j0NgI9Gf4WzeqAxGTkSFDE2fj9Lr1SYEKerF+weRG4+f4YfQjYlei4lJI?=
 =?us-ascii?Q?jqIFFlXLKZeAew00BgzMglaLMBTdIB5vv/XpsRWMK7zMTGdmgLXDfhIukEWe?=
 =?us-ascii?Q?MN+yhHWsGxxHwD9kIJmebHqcuWE0UleOwqLe5UZm2yrk5cRbpPsvN1kpFyWx?=
 =?us-ascii?Q?stb6vcm1uyw1Uc6CG2rrpUV3pAhU3fP67Rp4wp77EbKSclK8bPf+/DJMSQIi?=
 =?us-ascii?Q?DGst2IoMZtPiQevIlc3OgDmzLTW4zvAbGxrXk6HE9cumCem/Q4gyFSYrxkeL?=
 =?us-ascii?Q?Umik/J2H0aBcYmwI83+6sGA4BWxUoUwPyFeTtbyXKCVZXu5c5nbv+LkY/7nC?=
 =?us-ascii?Q?UYjXXOpxM1JQD9bdG/W1LIHvpUglA+E0b6NQTL7sRQ4OZdDxwWEdCP1F27lt?=
 =?us-ascii?Q?lFGrFwe8wsppSiaa37LVNCQrZGj6uPIaCJUpphfQhsWRP0Lq/rzF1MTtGEME?=
 =?us-ascii?Q?7aP5tDa0/Hv8LJohDI4RLyTzJRgm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 23:11:32.7684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ed8e0-4add-4af9-d8cf-08dce1a53963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085

Provide a "nosnp" kernel command line option to prevent enabling of the
RMP and SEV-SNP features in the host/hypervisor. Not initializing the
RMP removes system overhead associated with RMP checks.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/arch/x86/x86_64/boot-options.rst | 3 +++
 arch/x86/virt/svm/cmdline.c                    | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 98d4805f0823..7ae6d882ea52 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -305,3 +305,6 @@ The available options are:
 
    debug
      Enable debug messages.
+
+   nosnp
+     Do not enable SEV-SNP (applies to host/hypervisor only).
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


