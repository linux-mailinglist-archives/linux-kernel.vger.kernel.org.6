Return-Path: <linux-kernel+bounces-364105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD6C99CB33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CBA1F21431
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4B1AC448;
	Mon, 14 Oct 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pmRZ77Md"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977E1AC447;
	Mon, 14 Oct 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911425; cv=fail; b=DH873u+e2hinQ7mdwtHOlGFYsbruey6jm5jqVGbMaJ0ieCsgO4O5eXbw/tFhtgZ0n/S9S56IDRfNV1zf0LFMatcCA/x0kgVTMtTO9KfoLFjvL3ASBKYsrhA1UXINqWUUeC7lNYeAUaoHo0sYyxsdjjgSqwjF/yh6lOz3AOB5jzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911425; c=relaxed/simple;
	bh=YDtoUjp6jCfgr+oieXFk9lucFqKjNhJ1GuAHGNlXTEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+dtAfHRoGgOob32m/kRzaEUhagTrEe9vhkNbh7FVvzc4DL7KDj1zg4/1rJNboryVk6Y3OmURgEwTi4OsBt6ssLSUGTkC8iNK7oM3NGM9jgT4hdJcRc0mFu+qR5+5UD80qs3+HZJSUiNY1p/vUY0Ym+lkXAEtOmBN8FGFZHo+YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pmRZ77Md; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKx3PYP2D6wo0W/whNXNp5csuDsd5h8iSIGuo372Yhypt3hwfr5TJA+lIGmA8WbKqdeADzwCzAttx9/nblvcxKc3DgCb6NvQV52cE+8cbqDIKqUO+GSRqcWovQHHnL01bcxO6iQpdlXTbMwrJRGblyNd+oeR/xr5JlGlCUbzy3mFUaZVPq6f6q7d0wMSbzuKM2dOd0Im9zXzqA3KPP0GShXhYxg/SpMtmGqvbsDp55gQPDllbILZ7lzQo+ds2ljjqLohqg7Fsjsx2ry0W1B1yc4xH0hD4LHSS84/TauNFNbsdQRtlNHePvTVOVmAIcSN1vwQfM7Lij40nauDPg/Sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biDnos4fIHEDpif19CnNBPntlWqEgw1CGCNmbWwVdwE=;
 b=h1++hCAsmDjKn5z9wXZiiET3SWjkVTsSde1SXK2nFUVl+jWHkjy1nvfGb2Jlim0VS8hpz6xDOppTWwDKLaY8LI5/Dh2pa1R5XAZTK++6DR26k+45lSX7Yz55oj76Al578pvQjwS1QfVcSFyEUOl6zFCOWnHXKuCmiKYWb7xtkwWOR1Bzpl2dYWS+L59BxO8c4dVmK1QDSIibI42f9tLvzv144dcuSR9BUv0L2f2wsvOpTOeayDHsMCspLZGlP5s60r5R7BJVZ+leEKuHJKD53IqPk80bXxW0siO7PX9Fl+ydI/kVM0PnKM+cIG2IPbXkehCmh1PkP6WMDeuibZ8Z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biDnos4fIHEDpif19CnNBPntlWqEgw1CGCNmbWwVdwE=;
 b=pmRZ77MdfJX2sok8kkNW5dIPXU1K9q8Z8C3o9fuk6gSq8GLuqdD2lJYQIlKGQSdZEvoQyczpN4eoUPWBddjKBS4trZ3aDcdg+KDJyzndbKlJ4tzyVQbBNmhwBZio6e0iChXJjTzMTM2V1FjDeNxAgh1j7kI0BSBoy9UoKdZldwg=
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Mon, 14 Oct 2024 13:10:19 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::d6) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 13:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 13:10:19 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 08:10:17 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Eric Van
 Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, "H
 . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan
 Kumar Paluri" <papaluri@amd.com>, Dhaval Giani <dhaval.giani@amd.com>
Subject: [PATCH v7 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line
Date: Mon, 14 Oct 2024 08:09:48 -0500
Message-ID: <20241014130948.1476946-3-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014130948.1476946-1-papaluri@amd.com>
References: <20241014130948.1476946-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: eccf8b05-7a46-4075-03c9-08dcec518d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4DgszLWt/UmgsYpBFpckD9GP+qgHCbVHbgfunTWWUwafrjCVHA/FcwHAb+e?=
 =?us-ascii?Q?pGTFlrYA24prSNpqMLwGvk7W/qY10w3yPKJBj2wjPXIVJ5vzpjlDZzJcO6tN?=
 =?us-ascii?Q?78w1iSQqTOx9QIlMh66xsITdAQ4HIJx2fxsWuFE85iKBrGqVH36pQWN+sLgC?=
 =?us-ascii?Q?9jj55WCQtW04ZqxUhsWCMmHucZtCunjdtX7gSZ/xX3/kbs/GZds8TXdCCLug?=
 =?us-ascii?Q?7sTn8dZWkjHyrEFA5/+oJIfSR7THghb0RpFdvsAZfjyR3ag7sGrQ15+tK0Sx?=
 =?us-ascii?Q?Mda36pjiONEI7q5iY6Zb+9erNO7QWsPO7Ok6mddMu9xwK5VBSjAyJ8p46B2i?=
 =?us-ascii?Q?h16qRfWUAocxMUgEIZZtQNzLWJzBpmbmJjrMPJg18ssuiFXmxb9FVGRiaSxe?=
 =?us-ascii?Q?uE3Lh9qQIC4vo7fj79pjzS0cm5JFN3H4ErgQcVR1NXBn+2HaFu7g3edUS4v/?=
 =?us-ascii?Q?5TbkHIbe7xP2piCnAFxSHoYS8l2i+3RM9MWsVnbPStoCggMJagZQGvEIqFQs?=
 =?us-ascii?Q?onRnUa80qR0SLEab2g26f4QdEqTa2i3RXfy3Zs7pYzlcgSsuNqNTngMvxICK?=
 =?us-ascii?Q?sQKxkD0xjx3S3fGnXbJgswBxL+/nongXAE1AaPQWNkrF4sdbmFuf5qM/kUuT?=
 =?us-ascii?Q?LWH+0c2UL+KQpXYzhAImnu/mmeFReVVOJOToNACErGgCrbpjcbIP523VeQVK?=
 =?us-ascii?Q?eas9vE3JXbfG7ULNw8i7x7ejtv5sZJeiXkoO6eGy6yN7QEd4NVzJq7kusmJY?=
 =?us-ascii?Q?pK2f+W3QKAkXFtCxPK8DDQrUMjAEKL+xECGnZ4/DZADwp3/2DvBvcBWaqVl2?=
 =?us-ascii?Q?NuSoUgnyr/WjZsgIsLP9uVqqOVC6kdZbDlYPpIdB0qxhSnzF9k6sGu/5dOm2?=
 =?us-ascii?Q?xrc6R/gevG/0ABXZW5YZ9+ZnzUAcXTTvQK9dhdopalUF8zVub41GR/HWzgir?=
 =?us-ascii?Q?gND1qknlHdTGMTlHOeb7GaElBihUZiv+qELZ9DTJF+G4ZHLvrGh8CR2DI1/D?=
 =?us-ascii?Q?cMdQV31yOXCkb1NV5bQrOffLBDz8xixwHlSjj1N6fHXZRGyECy0k0oxaOYDp?=
 =?us-ascii?Q?/anx4gmO1381o3c/bP5MbM5L1CTo33rMWJ8wA9Jrv7UJBWRDXZrjvr5+h2r6?=
 =?us-ascii?Q?Yi0yRyZ4lB0zGR85BPslbp/Ww2oNy/Yb9ZY+i61uxOJxZeUY2OFgM2XQi/7b?=
 =?us-ascii?Q?e6Xcfd01Z5BHQfC9HbYx5O3b3bVjoKEP7/EhA7LmaY356oKivphzEaXQk0d+?=
 =?us-ascii?Q?70kPpdgNMJP+N27z/Gt5EbuHsJHw0ZJkwyyOcaVDi/GKBNzSkUye+vCwLbU3?=
 =?us-ascii?Q?18x+R0jiiA8uj/UnjEhG+HUSeYO8Mveeh1zC7JsMLR5mvacQWsKM0eKgr0WO?=
 =?us-ascii?Q?WypvuFg0vcwmX0SbkrcTYmB0+3uu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 13:10:19.0432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccf8b05-7a46-4075-03c9-08dcec518d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

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
index add4bae3ebef..13e04547f4df 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/printk.h>
 #include <linux/cache.h>
+#include <linux/cpufeature.h>
 
 #include <asm/sev-common.h>
 
@@ -25,6 +26,12 @@ static int __init init_sev_config(char *str)
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


