Return-Path: <linux-kernel+bounces-428362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D253D9E0D57
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9444F165254
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1801C1DF254;
	Mon,  2 Dec 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sd5dJooh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EC1DEFF7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172700; cv=fail; b=JVzSJF5arI6sYuNLzkOXbWCdmbbyxECy+fFgDcVQya007yBbzAzrThcksE7aunM/XG4SlRzx63bfo3aenCwmVUF+qQ9sRqvXmtQGLJxbY2S9mYCGWTVFqdOOk74iq9lqjD4RCVFtMZKAVng42PavHSriKnKeDK5HiwBimvz+mDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172700; c=relaxed/simple;
	bh=9sW3wbF4UmkoMx0mA4ghLj1q/ZgdvZzuwFWqkgdnL+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8GE5KJA+BgrIE/QzG9yRveGirZKuQxO6rom+mGQ5myb+VUAKNj+4DL0fdzssbv3bNi3S40GVzer1VJOJjPRNtD+4Gn32emUPqYZwPt69fRHC0HqpfBDBwIaR3tRWRMBtplGd9cSEvIkgyrH6EGMSQIePi6vKsSzLytXzPYQOUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sd5dJooh; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLyLHPuKnYVSaI4Hq3hUMOqMVX9DR5yOLH1919eeEx+P8ijqFQ+/XcdKOvfxXXFe5g+SJlPV7bhUIg3+AsNnIoCBgpwdtepDHumpME5XibsI2ND/qjHxWaaqo+/8qTGMdsqRqaRwR8v/4m3jmOMTCHHQi/bUFsBqyfanedfnUMuziLlokZObP8s/ye+6Z57egUzDVPbs+W5W7Fg9fGhHXbEbi9JZUf067Xn+lsa43hH+5QRjXtNjoPHB63hmTBPPjAqplqWRIz0fuYxGJXYa7lMgHh0dPqUVOROS1Oj8r3ZeEZgDInxy9NB3Il6U7lmrFsqi3+2bNuv1IXge6FNmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A65QjPeRWZ8PmGBke4GM8IGRTLzxlZi+UAj1BMq0Z7U=;
 b=wIJmccldT0opUi56raLiTddBP/5cM41dkPsQh9g7EhIzGaIIQw+/Lm3XQLYAEZVX2/T4NW/r0yRCvgePmP/a+6EiFdw0SOFRnOAuwpnpkqM05drhz1wFNlFDDRnw3Ly5E1TuExYp20p8vFr+N5XyCcK1AM8Ou1qPSkMfjP4wgnaCg+9lqn+8JzsyzWfsaDRQ9aUFgH4eYmwZb/ZooqbAppdNJSjUwsTkf/6UASY7H0XicQXtu95MZ84biFe8EgfP9Yne7z/LyjcmezirebNqXGMNaVWzOUlMoa/rwjqiP/0cqM0h7pvMn6miRvNwQxcfrKXzgyhIoEUwuyYEVRe37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A65QjPeRWZ8PmGBke4GM8IGRTLzxlZi+UAj1BMq0Z7U=;
 b=Sd5dJoohihkh03eGSPj9iurk+qeUkixYNDnSP5Yt1YRnd7xZY6XH+sbiHX7AUZF9zaJspqnh5oNP6mgn60cyWKNVRXusJH9bwn9EHk6992jh/m1e5OtlPc/yJhuNPJvX6cOX8XAW6Dpn1QWHWXiktOaPx7nRpx8rsqINUPGIvgY=
Received: from SA0PR11CA0108.namprd11.prod.outlook.com (2603:10b6:806:d1::23)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 20:51:34 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::9b) by SA0PR11CA0108.outlook.office365.com
 (2603:10b6:806:d1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 20:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:51:34 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:51:33 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 4/8] x86/sev: Move the SNP probe routine out of the way
Date: Mon, 2 Dec 2024 14:50:49 -0600
Message-ID: <6c2975bbf132d567dd12e1435be1d18c0bf9131c.1733172653.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1733172653.git.thomas.lendacky@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: da3e8fe3-f89a-465c-940d-08dd13131bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xHNkoZCaotSKUaNEedmH5F0YMi8VcDul69ukd6cKjjaxOVca3GC8VR2ctwW?=
 =?us-ascii?Q?0xAkeZqB6zC2cjQnO31vSHnnWEKEU6UBM8FszcCh3USSi8PTuKOaMlvHFG/b?=
 =?us-ascii?Q?HQYtixfefmPPWX1eNQGGmB3wPak9noCqc7EBDmjYKSGXtNbJ1ptbpei77XZp?=
 =?us-ascii?Q?R09KXlLfo6BydibtsbGWJVe0eD8a1uAgj+pPB3zld4NsHTDaWq8j1iJ0oQI4?=
 =?us-ascii?Q?uuKJi6bLDoJYXoNYbTlMM5nDA1Fpg1PZEU3YLU4cwl/ht+txr40C+32A/Xhj?=
 =?us-ascii?Q?R2vI4E2n8erj3GPICMUWX9QogWYTsFZP79Kg+rF9wQS2ik3LT+wY3I/eiQ6B?=
 =?us-ascii?Q?SY7a5wUflqJ/c6Z5TqrazSQlHJQdbyMs/jXykFO004J/L7DU64foGteXtg7A?=
 =?us-ascii?Q?l8CTB6lnZ1nSzsJGUWOoTJf7bv5r7a/7KUI0XVtX9wuLnO6lWHHEFBfqYZ4h?=
 =?us-ascii?Q?Tt1G9owkohN9B9WwJ0ikLoOsa7HugaOrNL3fJ/SIbsvcPSQ+bBPQE0HVXXPT?=
 =?us-ascii?Q?0Tw2ZDml9OVrO893PsgAG95YgbAOzF6D+3bN6vR+SrhnsgpqH6jpqQNOk+5s?=
 =?us-ascii?Q?darUs9/tJ2S1i/AA3NVCRGXRmmS3lU+segm6O2thv+fSRYKs+Pp9qAYfP5hf?=
 =?us-ascii?Q?9hDNDDs65KdxNCkcTJZW3Mcq3KnfWgfN7wAtjph52wlSNQJtY2jsC8v7cmtC?=
 =?us-ascii?Q?4FF1/yxio2AvEPFMxZAJmszj1lgxWOWlI6NH0MVg761HodAk0Ub9tq5cbi1M?=
 =?us-ascii?Q?Zqb3joRBshFLbFHI7P+X41QQTCpOmp6/r/MIHFQ+gh1cymY4PFUIIgNowuhD?=
 =?us-ascii?Q?VgLUGF3e6JWwCVZdZP8+O3yNvIY01/lcGc3v3/z9llhXbxt29lDdGP8MkCGy?=
 =?us-ascii?Q?KafvXanQiMaWBeMmGXu6W4/gSgVspXAlg8LwPjLl6A68CsH4w6PYUh7H+tsk?=
 =?us-ascii?Q?w9jqJWlAlj8IJ0VvSYOL0qBziTxDk+HIWoUTRMg/lw7UcPG6YwO46W3K/B0q?=
 =?us-ascii?Q?w3D74rCCn2+7nQbjJ3jVOEDSAYWKVBf6GDBBa31veHNWCg3ADXhgoeDrWyqM?=
 =?us-ascii?Q?Kpm0DuPBMmUJPFFHxETg841TetEGVPDLUh/RLKmojAeSgN3qPKaZYwWGJTAV?=
 =?us-ascii?Q?r7wBN1kBBfiaaej5Fm+dhsGrs/o0eaTcMrAJh5SDiwP8r6cLaSBmbrDatXjA?=
 =?us-ascii?Q?LyxRcsFgHtKyWJIMv13fj6F5m2AwTEdBls5GNHXXhkg2/VeZuLOLhufWkZ//?=
 =?us-ascii?Q?fxepKI7mQ4jsWNjPAg1P+s5682HDqF1+iV8CPdklmZ1fJ1m87BSRrUJzkWuO?=
 =?us-ascii?Q?U0Vqn7ENlJTnny5kshLScKyCpnj/H2kJLn5wMm5RzESNp7D5AoJl04hPXES5?=
 =?us-ascii?Q?vnu/useerlywuFkCTVGy/UqPE6dXocO1L1lFExyI9zUxlSWelWKKb2XpnqUM?=
 =?us-ascii?Q?gG+A1gOzoYTB1XTj/sdRhYTpFj1AnYER?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:51:34.6871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da3e8fe3-f89a-465c-940d-08dd13131bc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339

To make patch review easier for the segmented RMP support, move the SNP
probe function out from in between the initialization-related routines.

No functional change.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/virt/svm/sev.c | 60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 18191cbd78c5..0df378951ac7 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -135,36 +135,6 @@ static __init void snp_enable(void *arg)
 	__snp_enable(smp_processor_id());
 }
 
-#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
-
-bool snp_probe_rmptable_info(void)
-{
-	u64 rmp_sz, rmp_base, rmp_end;
-
-	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
-	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
-
-	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
-		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
-		return false;
-	}
-
-	if (rmp_base > rmp_end) {
-		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
-		return false;
-	}
-
-	rmp_sz = rmp_end - rmp_base + 1;
-
-	probed_rmp_base = rmp_base;
-	probed_rmp_size = rmp_sz;
-
-	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
-		rmp_base, rmp_end);
-
-	return true;
-}
-
 static void __init __snp_fixup_e820_tables(u64 pa)
 {
 	if (IS_ALIGNED(pa, PMD_SIZE))
@@ -291,6 +261,36 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
+#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
+
+bool snp_probe_rmptable_info(void)
+{
+	u64 rmp_sz, rmp_base, rmp_end;
+
+	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+
+	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
+		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
+		return false;
+	}
+
+	if (rmp_base > rmp_end) {
+		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
+		return false;
+	}
+
+	rmp_sz = rmp_end - rmp_base + 1;
+
+	probed_rmp_base = rmp_base;
+	probed_rmp_size = rmp_sz;
+
+	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
+		rmp_base, rmp_end);
+
+	return true;
+}
+
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
 	if (!rmptable)
-- 
2.46.2


