Return-Path: <linux-kernel+bounces-327145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E57E977136
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA7B1C20DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB71C579F;
	Thu, 12 Sep 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wl7odaKb"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDE1C3F02
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168171; cv=fail; b=G10sF1RZQnDiQdwNBj6o4yVj//12J8d0CKfe1CRdfsorY72DQTFE5qnc6FkhSrwMKxJscxY0V+7LJOLe/Q2cYj8REx/S3AfneJFSpQ/slC6Q299s5YeeO78UckFRqEh8jOqo7ngdbsKnajuIL4aFK0pNT6+IN46fAnkoNb0M6yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168171; c=relaxed/simple;
	bh=rIZzQpAw/qZwZZeHQa9t93kvVjJw17u1DM+8cd4q3BI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meQAJ1gwaRl9SG0OJV2cUyMuaoPegp3ioyW7QdqMsTq+V6NXG7Ial4k6iIn6kKjYVr6tLxOThIIVKfER4NRdGh5FdRiHjIQ6ABpZG1VtVP2BhKTZVD41VZWcKd2m6pdLKpN8y9mIhLP/H7zz1ns7vvlea5IOSEB+Wsj0QGSTFMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wl7odaKb; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pm2K4WiIOqCXqHayMwPDf346EoaI3mPkxp2yUf1aqnSxsaTUCSW2d5ko20qaC18vSYcb9Sisa31M8V5N+i1/DAOQbLtJf6uJTJW+qmLyTymQW1VX+qwou3LugGEknIzFJI0iRqjSeGJMAIyBDfMoXl3BK8GjdYQb1SbzGWlWawi+XIriLQ3kHsoe3dCySrshIlkawke5vH8pxK4U+CRsk9jMKwwVfc/7hkAa5TCIVQ6CRdyFae3Vej59Qh5jaY7TOP1iVHrUuykVbsAyus/7+fEas7NHrtGkhc85QfPK3g7DoJ703oPUmIy6W3b0xIczTanZWq59Y7Zq/ZcOr/Rk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtdt/6rJrvzH2q87lX9QjHwUxMrUSshkV9Icv82FCx4=;
 b=h9Sw3vnYVu1M0Tf0o0eZZlBGe8S+vHizp54vl1c8gF70cZcFLoVpG2ixVoX/ymBbRVEd8HwhRRqEfEdbyjDvWopxkAaQBAfozVBg+ANQM3PeswHet1veFS3JqK6L4jnFrQ8nHRNju9uAc/g8Ys+ZN2FcYVGnoayR7t0h4Lz7xenV2Z0doy/U2hC9Mk+DkHkzBO+fByvM6W8gWRUMp4yu4uDiVixQ/s/X0Va5x4zzuGmK2Va584MdMaL4vCH2AYA2XkXMGn1t6nfenIXdTT/Ew7Kz7ImoIgEVIednbYiC77vlQLPXXGXqdAkk3CJKfPD4D04L1WIo67FkXc0dY319Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtdt/6rJrvzH2q87lX9QjHwUxMrUSshkV9Icv82FCx4=;
 b=wl7odaKbODPYzYL920OJIcnw3LtykIzahmzORwoQfQFtbltPdLxHdgIcxCKNzlgVQrCR+SGp+oavhdoMDw6ZSNOnBMTSmfDQ0IW28wLGl51yhGQBQH0NuMFbcteXiWZi37F7CI+6A4hnucKrYTqkpPA8643t2yrd/51t18ZiAE0=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 19:09:20 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::35) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:19 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:15 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 15/34] x86/bugs: Restructure ssb mitigation
Date: Thu, 12 Sep 2024 14:08:38 -0500
Message-ID: <20240912190857.235849-16-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 960c7956-f70f-4844-65c6-08dcd35e677a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7HasLLJ1vMYraJ693MXagNqI6rBFyP00nOhC9SDbJ5eEK7UhfdKSFFzpfOKY?=
 =?us-ascii?Q?pC2FdzbJff82a2dsTX8/MeDvfcamZq7FXqJxpa8g57YugMJeS7VGecYfoolX?=
 =?us-ascii?Q?f47Y1KUSC5WxdOTgm8o6oAMADodlxKNoMIw37dH9sNdjgM+W1a4ZbypJlK9D?=
 =?us-ascii?Q?TZFc6lkKA4ie+6uA88hYY2r1xaEbH5iF78TthogHcO8k+jGCmOfX64kKLN8a?=
 =?us-ascii?Q?WUNLJmjEhyvLlSPYs/3V91hYo3E6oaw2YSuHNfPx6NsUmiUXSN9joET/7g54?=
 =?us-ascii?Q?pMJVYHYpyoYWXEZGOPFisPN9nb4sb9qZqnEYHd551xFPmzvvfJdC3e9HrRr+?=
 =?us-ascii?Q?7twQXNXEClgL3exOi2R42+vKKcBqp5NAaJgA3u5Y+sSWZv8vorpC/KO1WaFq?=
 =?us-ascii?Q?srFIpTqvcXmhlLqeaix3c+60l7q52zldpCqUbZ9RbgHXg4yEPJQezvKfsm2f?=
 =?us-ascii?Q?i+Zp8tvGieqWiDnETjnZjxZkg3gtiewWkdMFm0AyE4A0j2KyPoqNDc8oFQ1g?=
 =?us-ascii?Q?tSJPjzQ6EgCB4nfh+W8ATXulMsMqKIdey7exoOloDX7ncdSQIRki6CBEJhdz?=
 =?us-ascii?Q?pw0Yl3UyGZgu/HC5MDmIsXI7vbriCJawtnk/vA2Myr4z5LvlRDTaHkvX7wTX?=
 =?us-ascii?Q?9TUmKP/xY276jb54B2n1Le+NjJ3OLyGocoff7J0Ux+LboIwsFNVLlVc9dD8H?=
 =?us-ascii?Q?/VFwaCiRVEcrKGXy1JbbcRVR5e26gs/H9+I1aZVjOYU5fS6SgmHQ8696uCX1?=
 =?us-ascii?Q?se0khTOqQo10ia+Vj9vveyiOy/AY2xnmVCZONjxSJgN69zvwuJ4DSvutsR3k?=
 =?us-ascii?Q?/CP36QzDT6r6Fqw4eDWJ06D6RNFMUElt4K81HP4ZtxiNL/6YCTcg4/+iC1Q4?=
 =?us-ascii?Q?M9E6xuKfEvUY+NYBnl36CY0ABT9F6+v3e7Mvz6Be7n3w40F+i8tyy2JgJNXR?=
 =?us-ascii?Q?Wv030qoBoL3CFaoVOsPe2cRISazUbGmu7rzgBNPXbC/UV1Padzmi3Nak2xY8?=
 =?us-ascii?Q?Ri5wAiC7z8l6e9aTN/OCxT0traENULDb1r6eMcSw1t+ZZWI+LDyqr1x8dDm6?=
 =?us-ascii?Q?cGbl8n+KG/pNI1tAnvLtiT+fTw91qNp5rZsuzu1YDteYt3CTtYpzqF8lVFbu?=
 =?us-ascii?Q?DquyBiteppy3QpXtmrpDWHpkoK8CLVf65UpvLyCh2dC1BtccXbydtoOKoLR3?=
 =?us-ascii?Q?1oaTIBj1L9mzPeUW4BzT8UANDmnSdN7ymt4534g7qUAEIbcDx4R4IJWN6KhC?=
 =?us-ascii?Q?P6Kr7iMXC+Fnzrk46J3SytZHHgFbIb2LcPuI2n8eDFT4DCX3+hn9U+F0oha+?=
 =?us-ascii?Q?ezIAb915FUrQKqfinZhsxNpDpzHOZnfn7S0CaaI8O4SV6drS+/O3J8k/HaOL?=
 =?us-ascii?Q?r4sbEQ4emjxDOMdyTvogQCm/Hsz2Euoj5qolheYsrpGWaiFlXKgssZzxqBHS?=
 =?us-ascii?Q?0h2E+0BWchjJKovHeqBQ+sJ2Wb0DibRk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:19.4822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 960c7956-f70f-4844-65c6-08dcd35e677a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334

Restructure ssb to use select/apply functions to create consistent
vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 32ebe9e934fe..c996c1521851 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,6 +65,7 @@ static void __init spectre_v2_user_select_mitigation(void);
 static void __init spectre_v2_user_update_mitigation(void);
 static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
+static void __init ssb_apply_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
@@ -223,6 +224,7 @@ void __init cpu_select_mitigations(void)
 	spectre_v2_apply_mitigation();
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
+	ssb_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -2211,13 +2213,26 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		break;
 	}
 
+	return mode;
+}
+
+static void ssb_select_mitigation(void)
+{
+	ssb_mode = __ssb_select_mitigation();
+
+	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+		pr_info("%s\n", ssb_strings[ssb_mode]);
+}
+
+static void __init ssb_apply_mitigation(void)
+{
 	/*
 	 * We have three CPU feature flags that are in play here:
 	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
 	 *  - X86_FEATURE_SSBD - CPU is able to turn off speculative store bypass
 	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
 	 */
-	if (mode == SPEC_STORE_BYPASS_DISABLE) {
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
 		/*
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
@@ -2232,15 +2247,6 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		}
 	}
 
-	return mode;
-}
-
-static void ssb_select_mitigation(void)
-{
-	ssb_mode = __ssb_select_mitigation();
-
-	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		pr_info("%s\n", ssb_strings[ssb_mode]);
 }
 
 #undef pr_fmt
-- 
2.34.1


