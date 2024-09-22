Return-Path: <linux-kernel+bounces-335031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E043997E010
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A42816BF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 03:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03919308E;
	Sun, 22 Sep 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oFFQr8ZY"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7019340E;
	Sun, 22 Sep 2024 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726976258; cv=fail; b=O6HBmFP7J6hw2ZBY/5lhSSe3vGxk+lQauiTjHl9asTtZbatqNy0DSe8JNicejJ8o5gIs/LpAZ08OigKhxOBiID0dN/j4a+0PoMF+SSHWPaLXh/NysX/egC9A2LmxrTZIbSpytYervX3XvJ903eYWlRv9zNZi6OsGKjNVGPYvtGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726976258; c=relaxed/simple;
	bh=8TYZxNRtUEIxP4fZY/f9t3LSZbxPhlrb9Rp/uGdzmN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQwUB5UpTiORnCAR04G8e/7c1C/PfWI5ZeLUuClRBJ8YRbi7rqLRxVJoCOv94ap31arH1T4g6wygWXBOmnvvXg2kJGIR1Yc3XrOCeLM1McflJU0VtK9kaMxUPhgQPIoCEESu/BVQ0mQFUtbS119AfZmAXv9YyGFY+pPHZAhQxDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oFFQr8ZY; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr2X6XDymfhIc99D16R5ZhJtr7Kubr2fiQ7dFUU9VzJ7akD5eKECv1I2AtGRg1bv9tkTRuh+5Wwgd39nmEoDkfnLrmjDVZdftWtxie1+B+MLHa691iIh3dQd5fxZ7RYE6NoDEAErEn2em975R2EdJMu0i5NfQvbpdcqb/qQA4o109rGIHHcfrRunMTz9Q14OBfjZLBghskqrt4bUaz2LI3vL5tDqxw/VcdSQlX/CY5XH1mDsmMKiZflOFIhUEmxSKJZtJM2yJg/urnN4YGZYjJ02MmL2UFiEntKaQfJ2KnsXBKOympaXQyLruXhuZVv8/XLOlulfPiFc+PQzAc48Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK7JzzgPgY+vB73szTd/ngGCEFFtnOqUIDOwDsAsCXw=;
 b=LXXmrFrXtV0C5dLnIAE7yowgBsYgOE9Hcl4Kr+tGkilZ35RtjSTzoqRWCSjBU7N8A+SUYV3xn6quljnn0OtnJ0rP7HpunGxHAxn/61/GHT8elf6P6x2/wT2b37F+V2faBpSroJr2Ss7wb1ohwWxTEsSEyd1G8qZTi30+inDtQ3NVb3EcqskD9M0lFTuYFXAhQ1EYV/F/4LmnW451F7ZexYg8geT5oUiPRDCZmDsH3yY2ub2Bhp/T5wop738Vx9YPvfHU2Y1xiWkbN4TR/3B/bA49JR884b2ZnXf+63DLcRKV9kOS2f5ZK7ui346DLQE1B/bB93pgc7uxb8gu7AHvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK7JzzgPgY+vB73szTd/ngGCEFFtnOqUIDOwDsAsCXw=;
 b=oFFQr8ZYiK5juFMU2Q+sQkNVQXQX5iY8WOzx/+gW3WPZXXm7ezpO9aFJN+kH3d2Sd96UJd2zqHqL5bxfw0Ocf+UMVA5r+DdWd9SuhijYsoue/mdCXMO3j16aa9aXm3Hs+rsu6W+77TsGkSHLt42aYa/oSMwMCOfcllXEoZAurm8=
Received: from CY8PR10CA0026.namprd10.prod.outlook.com (2603:10b6:930:4b::29)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 03:37:33 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::13) by CY8PR10CA0026.outlook.office365.com
 (2603:10b6:930:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Sun, 22 Sep 2024 03:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 22 Sep 2024 03:37:33 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 21 Sep
 2024 22:37:32 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v4 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line
Date: Sat, 21 Sep 2024 22:36:26 -0500
Message-ID: <20240922033626.29038-3-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240922033626.29038-1-papaluri@amd.com>
References: <20240922033626.29038-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfdbea4-fdaf-4e9a-f0f0-08dcdab7e4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gr+kLc1fXSmUnoSi8srdzd6k6RbBwCOgfAZfvP+jW7C9qBaWsKPLQaHUy1P6?=
 =?us-ascii?Q?iIrFgROJNHjrnpSSI6rhWz8hS/Hcjb5TpRoTGEHU5GZDpoASoxIWksk72t9x?=
 =?us-ascii?Q?mJ+x+BSJ8ghc+bbdjXoOr4AQyDGWbw8csd9C1n/JKFt/SfzTtgAVpc+YXv3/?=
 =?us-ascii?Q?g65ckAR4M/J4XlRMkmJ30yDE5ySSgnvQ7WzLYiBpVzdPEJBU46U8Mo3ci38C?=
 =?us-ascii?Q?Td15wj7qKPv/vmfQfLjmfN6OaBzbmSDD+LYwfArFzBe670514crRLIEORolU?=
 =?us-ascii?Q?2x3rj93ke2On/Mvfntr/oN49eUiMgXCV3i9r9QtT8VSTReqWiHEgtTQTczx6?=
 =?us-ascii?Q?XoUeG0TyWUUuKs6D3kLGjR9DY04corX/vMAPaU0TpXC4wm+NXsnxwNijo/cC?=
 =?us-ascii?Q?EPpxh72Ial/ihFJJPXdRaQbrd7ZRL3XdyVbOADe0R1iXFoURHK9t8n3yazWe?=
 =?us-ascii?Q?/5gp3jjfL8RDczwKJr7QLx5+/u7DxXDH7nnFq5VPtATQaLEfk5qAVg1g6zJf?=
 =?us-ascii?Q?3HuhMkdzt3O3HUXQ6WflNsmW1Te4R01mBRxVUQtMbnerMstX5E6kK/1GyPqf?=
 =?us-ascii?Q?jRRmXqsHjoBd3TkyjgO2JWD3mwzo/97Nzv/s596hLgpqPcMJk3tqOamBoB+J?=
 =?us-ascii?Q?kBb8QHMyXxVWqsnOapZn5NebXsgfmViP7TJL5rV9L7RMSR7EEWfADYIp9bXU?=
 =?us-ascii?Q?egL9Vx5chBF0qCJos+/3AxpS5sClp6OyAPfVLfZjnG6p+DIcNGGNHThSxxiZ?=
 =?us-ascii?Q?TPNtGhKEb6RVBR0A11BbmQHC4W16gZifsSDPrGwt+u3N+o6d1lEStXnmqJEX?=
 =?us-ascii?Q?p3T0ekLVclHwJIO/XTbfdL2wDVo7gop++ZerXRulXqUJ7SehSXSsOdihnT9W?=
 =?us-ascii?Q?C4lbDObfV/f1nADdGHb4JKfFFR4wvmQQCfAJmVq5KogP5hxaRcjRWcCyTsc+?=
 =?us-ascii?Q?/hhB6h2yWoALPtY9pYQ8fODcqm9ArXFuiSUv+7ALav5fP8L0Tcqh8WLnhVlo?=
 =?us-ascii?Q?qIH+0RckX11RYjSnamktc5gGQXDWv/rdgUCQbAHByARMf0NzfNPIBolnAx8D?=
 =?us-ascii?Q?IErVFHO+JXW79rIALdDaHKETKJ3lik9H3FS3T7OZxAVveJS66wWcga1seBe5?=
 =?us-ascii?Q?ZayJLz5MEh6W+79wgZ3ZSFuFSNv/FE+Yg54Nnt5p6BdFgqhoBKDXEdqwQVrh?=
 =?us-ascii?Q?Xo/65JwIbAa+p7RUEhEFUOqQSAgph8RhfR5UHM1+XwkPs6CVwUpBRj/ngTJo?=
 =?us-ascii?Q?v73B+oqeyb1hq6UGGQaH67csoVtWmS2H/6lXkzKVVS+4vbrINpeRLjHmz1hY?=
 =?us-ascii?Q?Rna192CcVnDKlIBFMszIrtCx53nHP+9+l6K55JcloYWa15IY3Ne5YHRWppu7?=
 =?us-ascii?Q?Dkklo3++y4onWChNuNTZyvw/cEaG5ZEKRby8JdyqYHTuHGeHIQlvVSqTucr2?=
 =?us-ascii?Q?m4uUpjHo+AwrXthP5UYDRecPAIda5fFT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 03:37:33.0858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfdbea4-fdaf-4e9a-f0f0-08dcdab7e4d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

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


