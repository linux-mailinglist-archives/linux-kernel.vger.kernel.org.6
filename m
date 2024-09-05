Return-Path: <linux-kernel+bounces-317277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05296DBD8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934ED1C211C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F9DDAB;
	Thu,  5 Sep 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2BwTPD/h"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60CD528;
	Thu,  5 Sep 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546703; cv=fail; b=BFifEDbfBKalMXKQAQJfj/CFXKTyeIyNcmKjumqQUy6Kqv1RhA0mKiOs0brPkWZr7GKaL3OBpX3JMUMlZc3JQP1elMXnk80U84EKrAw49U5Dh0tkyE32CTBdW3Xn3fdW3RaWWXkpZ0yMAVAiSmRd1RhT0QWoowas7w+jBEiVuIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546703; c=relaxed/simple;
	bh=8TYZxNRtUEIxP4fZY/f9t3LSZbxPhlrb9Rp/uGdzmN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/hHczoatD2d5xQoQKOzCPMC+xnjbiVZLsXAImY5w4irhEdSILQMfp714fuxsrOyhz2PJjRnOt9Qc/vdxHW8i4eLDkiVpa3q6vsxDezk8Icqax/XDZ2H87qs8QbOr9l31Grx0eqSwiTyfjQ775U//NRQvOVPgeOrfT4VTVXJlos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2BwTPD/h; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqOm9943dgPiW/XAydWcEloIEXbqRv2ZYLgaUcIDfQbLylIe1u6NDkrABzgzEWwLsQip/9mbeukL4/5O3eZyRoD9TNPleOauBNp+6YZP7MQRcOJjLdVF+b78MTCulcRKpVzMejlCBh3H2OBQ23HnpHgXDwTObA0BQl8MOAOfDEEoDUoXhgTYHnJbaXRRT0QG1Qf3pCFfELnlsmHXxOUeQY0cfwpxExZmf53Ao3gfnXkJ4SK6UQqNDFz4UMPneOJCGLUf0ehyvNP1e+SUA51J8e6yjUwLCGiU6l1pam8GLvTdq+Hl9+jd4H9eLt6z9lFtBaUyC4854XsODRG95G6XGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK7JzzgPgY+vB73szTd/ngGCEFFtnOqUIDOwDsAsCXw=;
 b=SMfxwcUkAwz192+U3OOX9HU2fYyCUFdb1pLwvFCuZMnLyUWkrcIhv2phaGlk1sxL1GgXWR0cfjobrFkL/2e0OmcKa/l6IWwJ94OnLRqk3KC9/GKU80Tf1QOr8TcUPwjuY6XapCVJE5A04qMtIiICz/JbknrFZQPRDM6kAbDOa1SAQap6rfjclZNa39GIwDSYf2/wEeqdxi8KcMeTS6rdwBtXyEwmwszPdHP3Ur+s5IV5kmhnZ4FiGIEu+coqrKOQDRxOvaXNAbKQuTzRgISATC5Atcb8GAfC27p3vJr/GRYfCOcjywfwoThLT/FaXcRBBgMoCDjABz9JyyWtR3SNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK7JzzgPgY+vB73szTd/ngGCEFFtnOqUIDOwDsAsCXw=;
 b=2BwTPD/h9XmerQcgbq5htj2bSiDcgnxSNPxSlBvSTMkMDs7ucbzJp75gL8VwoLPL+t1wzg4rdJP5yRVvTaN5AScmmB6iJSkTDxPk+qJ/Oa0uscHOtvuwtEySGIpORt9H1pI0bB3CUiUw8lhV442vYRXaVV+gBOHq9vHm9AzdlY8=
Received: from SJ0PR03CA0153.namprd03.prod.outlook.com (2603:10b6:a03:338::8)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 14:31:32 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::f) by SJ0PR03CA0153.outlook.office365.com
 (2603:10b6:a03:338::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 14:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 14:31:32 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 09:31:31 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v3 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line
Date: Thu, 5 Sep 2024 09:30:56 -0500
Message-ID: <20240905143056.48216-3-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905143056.48216-1-papaluri@amd.com>
References: <20240905143056.48216-1-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9fd26c-8007-4ab5-914b-08dccdb7706a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ltqcg7Sszgq80pAxMZqEONLHUiYtJIVU0dS+PX1Z7UUCSqS4OM7Hu/7Q9D6w?=
 =?us-ascii?Q?DyngBkX7SvUmbvfXxKSoCEfOsHVcg/fUpkN8SoIIBtwedLGkDwhF/BsMljzQ?=
 =?us-ascii?Q?vxReEsEoOA4pFZyyZf2OkwZMUmjLyD7k8BAmUniKamoPStMy2PcqRvOpqEmS?=
 =?us-ascii?Q?+1Bd1Elhx3JVJNSIIsZh76i2g6iBjg2nGPm0lrH8P/zH54ihFBxEKa/ZL72E?=
 =?us-ascii?Q?gDufZSeDvVbvBjxinT8JVcxeTuHVhSWjsWAkhs7VlgAYzhWuhhVivVBIURw/?=
 =?us-ascii?Q?pJ/HRZJLJdqa1Ayv41kEMnnUyD3N3nD9D2puVwHOmHEnsO14lgUK2BG2t3vu?=
 =?us-ascii?Q?TT0iyhiiEhFV8Vp3fMZE2wsVSnpT/M70zvMKTShd3LE6D4hVB5pBjxQaHerH?=
 =?us-ascii?Q?2mCMxatSAhptUNTcMFUdmqm7nRLEsIhm2nhJ64Oz/SGhe4RuKTFCEkOJaf3w?=
 =?us-ascii?Q?q8y7TsItD/ghzmv/g8RPtfERLZkioBSBzmMuJVil8TS2exi66X+SwdRLrF7D?=
 =?us-ascii?Q?Lu9tPu11Hza1lOLmEAf4aF5lT2nySKvWdb3+B40bKnF1h983ml8If6CkTg5F?=
 =?us-ascii?Q?jS6QD6d4F8SmXZ2Hm/j5puyt5Lb7Hyt8Kb+3XaK/1S/c9efVm1eKtP5OW0KR?=
 =?us-ascii?Q?f9L+gLd8Bx/x8ZDZ7ItMIRhKKvaP6wGFEwutX5x/mxIwhYYVPVMJBEL55484?=
 =?us-ascii?Q?zThFNIpdEoExwSFZZwo8g/QeCUkFsUDCnLGzn2NXGX6clU/JQ8PnsIPvzu79?=
 =?us-ascii?Q?iAIuNH3O5mc5sOgl6Jia0S/laAxAQZtIpe3+ZyfsBzYoZFwpOqp7pZ7QPRUh?=
 =?us-ascii?Q?uuYRy4pXiZwOZwavidWbXjWAfJBwXjDRpykPXkHAmn3Z8KscQYczZYdcuHVe?=
 =?us-ascii?Q?0uDdTllGJHAiDa9UnNb96k18ROmO9q+r8E+GCKCoN4SIUAROcve5us0drll+?=
 =?us-ascii?Q?izYyS+nLMgZxhuZyLfhUxSc4BRq6twbpNlfucgJYcwyQXweDMsUoZAZD4j0D?=
 =?us-ascii?Q?Ra7oWhXVLwf4Ydso1ozi0rjwxaxCxZL1BgQQJiPVwmdgFPJsPXounyNri58h?=
 =?us-ascii?Q?TiQnR8izJiQH/C7TWYQ+Rj7BUPPXWpqHxjo1W+kPh/a6IuVOdm6fZEF9igCb?=
 =?us-ascii?Q?cZOD1jV21AqsYDcP7q3oPN5YZSDj+JzDQ8uDk5WSzGTukATYtWLZysZacKqv?=
 =?us-ascii?Q?xFt2KFCjc03v+roJz42nFxL9KFs01Inza1/wBQcrpY9svAcSBNlj0tXEzNvu?=
 =?us-ascii?Q?/wKwpnwhT8Ruub3i5qzUrOYiAdR+7oArG0JR2rf3Bm0v6E0+ebxte/ekBDCc?=
 =?us-ascii?Q?H9moE5sdyRPdxM0x/XeYKxW8tHwEwpKVU3r7MuNxhGx7DGUAvN9kodyLaP8r?=
 =?us-ascii?Q?c4XxSxwyNiBY2Rs6fOqn6ARYPtEuGVGkuk20yNEOTKjqZhFEvMf+/nGpbco3?=
 =?us-ascii?Q?A8MyHf99ezjlurWSrkP3jI44fPh+M2//?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:31:32.6790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9fd26c-8007-4ab5-914b-08dccdb7706a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327

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
index 964677ab02d6..454574539c49 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 
 #include <asm/sev-common.h>
+#include <asm/cpufeature.h>
 
 struct sev_config sev_cfg;
 
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


