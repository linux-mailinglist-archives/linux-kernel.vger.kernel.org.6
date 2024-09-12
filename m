Return-Path: <linux-kernel+bounces-327136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA697712F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3062CB24F08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BA1C1AA5;
	Thu, 12 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iJDK2TuB"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD541C2DC4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168168; cv=fail; b=EQtOIQL0ZbFonA3NnvFG/DKMuElwMTD1ymdxLwSodDonTl6rM/4SDnMDuUun0iXXsuRu1mYOlpJnj6bx93JFrz2SJ8MBUQlFf+BYhDGiRVL1y6/ghTrIvdyfV0A3HrPzlPGPtRzqrsbe0I4nnv+ikv7g5AsmuKjI+IhTGYyPVto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168168; c=relaxed/simple;
	bh=g1p2sczEJrvVkXXYOhH1qD9QJq86T8CVjTGZxyD+Pi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxbpsjtjAr6exWQGnDr3EAcVvSbdCw0ti1JLnfNttWInemTecroAmpWLa05r/mB6P+XMsDft49scdQdrBsCNIQuv7oh5whOk4T0Y9H7rxeyOVcRI07jXFSaQg8y1vyrDjhONlM5J8Dfn97FLCKi012YCLl30h2YYmzUA394SfII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iJDK2TuB; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM1GjqTeO9UitvPdg3stcSOJtRaJf/KOjnIIe4+TOrD4MZQE1MAlpNInPz2aXNpOdgzWokV/URvQ5GkCp6faxt7cEW+yo/kz8cdfEfOKUNX9A5DKTIJzazUIJEmdgWYn4Dl9rBZCBuYDAxTpUqxOKLYGa4oGWxv5iQ1ZigmBrB0of7ROA7box5kjU04rKs/2tBOsXWwVCP+sl+lWwaq2j78+p1DNJ5X4CMENQ5thy6jRfuKh/Ricb2EWSpibrV/PvMndhKZRh/ZDwy1cMQI8cFulNTgWo2gXTav5pKfEgIf+HVt4i0S7WWkr26qKvO+SBN5HFytA9xtCgmDlgUmkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F634t9K6rFK0Q/87eVi21/EeH+e4kdyRyEewvhEXG/Y=;
 b=bwHDoDCfHlf1fx3b6CDxp7Ce6Js+v/5hyq89vdElnB/z9sjLcLE56JFd3S/DkfvR5yQqi0dj9+lEAtcvCohnD8KlYGL1DBU/ZxuN0t9l1TyJedaqqR6Fdio75LpgAmhbbZNeAhwq6LilMPoxywTws37/dNaRiNKEbfOABS1AsdlNPEPiYH3A2sJCFgVD2y6NmU/nCt6/rXLBvS3FTv81+x1SBpv7LYDw/68He8xWaXznpPg2s/HtYNSXbLoyzE75tAYFHHDRvwrlBwl7US1FkZtB55VM7VLiXtyGni/0KRbuUt9LytkdwFLVYAz/5Gm9wnzrN0m5e3K3biA/VfB4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F634t9K6rFK0Q/87eVi21/EeH+e4kdyRyEewvhEXG/Y=;
 b=iJDK2TuB0nDtAOj5AzzMerH2pCLYSWIy6VRaxE0NCgA551tj1BX/E2NTk2udDf9qOOkUIJLMrh6iRBrTfBHb4p1lnTKTCM5RDWdIJpn4SwKhbxXP4W4eLKM/IUPIgrxrLCPClACd6krv/2GtrW0tZt2rY2y6NrHNr0fJrnu8QAo=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Thu, 12 Sep
 2024 19:09:22 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::16) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:22 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:18 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Date: Thu, 12 Sep 2024 14:08:44 -0500
Message-ID: <20240912190857.235849-22-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1f32d2-6c2b-4aff-dda3-08dcd35e6916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dRqpcRZdBpGfULjPAucLlStFvOhbVhshw1m3uzHBSN1IJj9+xKwSMctWPrGN?=
 =?us-ascii?Q?mfTF9InFiuOEffApih+mKzr5cjS/AMR8JW/WlMy6Ni6SssUEp7aVqk0IRp+d?=
 =?us-ascii?Q?nL4O7hKqsC0z+0fiz+9I9zpYIyuzUeGTbi1oLCMKz6Eqi90BOk5xS8YRVLuS?=
 =?us-ascii?Q?YssbhzRPLe9FVfH0AsV16SRr98g8bdr0UmemQrUHq88oFV+lrNUU3dF7exsg?=
 =?us-ascii?Q?OQPm1k/ejE3MAF63/bQd8dE9lXHshz6tygsTyO86n6lf6o+ggguD+BZWi6q/?=
 =?us-ascii?Q?l97pn+IB99YAfzBRQq1WgN8mstj8MAen5y0ENFZd/cYJKq2jO5OLBKtiRCiN?=
 =?us-ascii?Q?oB4doXA8CmqaOCjtUDMKuGmsK2uR9zH21/fK4nGbwNjUCj/w3X8wuDm0EY5F?=
 =?us-ascii?Q?9acMpI2yeI+D/AtvuB+KITMVGlJcaP45U+59svQNIRO3c7IbULKqp8gywVKG?=
 =?us-ascii?Q?sSTTPFpf6520QVLkZl5fxR1xWmsOWsYt6/bqvZbnvzPKCTObqW191pezyAPY?=
 =?us-ascii?Q?3dOV3e2/gwuiUnsArlyvPwp6jUsFPNrO4zLyxLTWLKu+wk/lDO/mtzsWMpbo?=
 =?us-ascii?Q?b9MsVRLdRFfVWlt6rSu75Jq8f5s3h0oQSz9+knHi50xNI7B1cFeY2auTHMMz?=
 =?us-ascii?Q?Sf9l+eUFrE5xwWNnFFXE730k0vJEe+7DQUB1hB3Me2z4lf3HopPmjB0fVBfA?=
 =?us-ascii?Q?8C9DiGhKWVwTL7c/TgTj+rRfzYKdJagqvdOnF94qpKt0lRuOpVNxVjVWUPH7?=
 =?us-ascii?Q?cq8TcoDEJVG1XODEneqbfVZqUSIXy35dPZ0DGHQOThu3jsC3yuDn98OuliGG?=
 =?us-ascii?Q?XioAv3U4sUNXSA13PBwrG+SRBihMty28tVk5ZeEl/NqZxBB+DQxcRQIY5YJ3?=
 =?us-ascii?Q?LDtFXrtGOBhpwwQE3XIV2AqpjUozaa50RTgI58FG/fxGqjjn0XK8R6P/pFxU?=
 =?us-ascii?Q?pLVTW0x/quZnrVMXgCFi2KH5OE2mfPpLI/ZLvwyaUrnvewMjwcvCJIfyg+nN?=
 =?us-ascii?Q?Yr7uhiMyp1YqHLJFCCPQ9wX8n1yBw3O/FcZCgd+DsrR6eo+VehSEoK5O5s62?=
 =?us-ascii?Q?ZLbm4U1FG7MCj6zV+HBxyyVDlBj4aTKTgaxA7YUNeW4ex1HQA8kFOVzDJLWt?=
 =?us-ascii?Q?Idw23Nm/hyep70fXr4y1gZ1ZLK9F9+1AGof+Ts/dO3zGeL5rIHOUopwj3U6l?=
 =?us-ascii?Q?mBsn7z3xJDIFNp5KSlNRVrdJuW5+I0kysSyLMDWWvIntlSDWIRjt4y90SBGG?=
 =?us-ascii?Q?9aOVbj79NQmHtDIWBlU6Ma1Z7e6TxpzzFwxD0a9joXvkAt/5Fc4pnBbT9lsH?=
 =?us-ascii?Q?7AoRKkHhW8eSq0IYI8hX2mHFIpuHkpkEUEiN9vsP7EW4Hzr/mVztCjelx+QR?=
 =?us-ascii?Q?2FEJI9F4ycuqS/REjVwAG+W9qmes2cQXiOB5MYuxpRpmBpFnPE6ArjW6Fc7+?=
 =?us-ascii?Q?JZL8xbexeP+3/XKIgSKV144QDAgGNuzQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:22.1854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1f32d2-6c2b-4aff-dda3-08dcd35e6916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

Use attack vector controls to determine if mds mitigation is required.

If cross-thread attack mitigations are required, disable SMT.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a50c7cf2975d..a5fbd7cc9e25 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -414,8 +414,12 @@ static void __init mds_select_mitigation(void)
 		return;
 	}
 
-	if (mds_mitigation == MDS_MITIGATION_AUTO)
-		mds_mitigation = MDS_MITIGATION_FULL;
+	if (mds_mitigation == MDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(MDS))
+			mds_mitigation = MDS_MITIGATION_FULL;
+		else
+			mds_mitigation = MDS_MITIGATION_OFF;
+	}
 
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
@@ -446,7 +450,8 @@ static void __init mds_apply_mitigation(void)
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
-		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
+		    (mds_nosmt || cpu_mitigations_auto_nosmt() ||
+		     cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD)))
 			cpu_smt_disable(false);
 	}
 }
-- 
2.34.1


