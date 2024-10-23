Return-Path: <linux-kernel+bounces-378700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5A9AD42F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0781C221AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9D1F5829;
	Wed, 23 Oct 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gRIxb/xs"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609241D0F77
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708969; cv=fail; b=gnP9gHs58BmvILTkaxdUQUSHFPu9xuFVf7pufGpBTMNGfgHVAoFgtiH20QkzzOAlBQo+3L27yv55CLXv35YzOMMeXrxB0IlrkEZoAK85aVppvFc7oJ7LMZuyxuunZ9vNq+r1Pu96o6mE9/Cd5O/okzU8wPekBimfofC1BwI42mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708969; c=relaxed/simple;
	bh=KKjVOJ+4oty9aO8RZypy2MvOCRwhA1t8m96eAEAPasA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4CKw6vvU1goT+yHK88cq7je4H3piHrxon5bkVsId64rBVaf0ZRGE0e320XET4f5/pL9zDa8WmwXzIhW3qYqUcy/3Vf0LVPwvYJdIjCeDGJX8OCg8cn2hoomlFn45llGGsaqhmjlGmyCmOBMPzXnj/B0TjYh06hH/w0hpLWCgGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gRIxb/xs; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnTD+eZIF4DVlcKtUsnMyZKJFpNiZqgV/V2wiej078+Qkv82unSQW+tl4fFtrxJChHjCq96IK5ET/YFYfZAcvb77f7Q8HXgf2lMDc0v5arYnJ0mSkyFxW+/yGVRuOzfTduhXRsZ6ncykDOuo3eAQNDRN+gbHje9kS5jG9mPZIa7PexJfxhotNTli+pS+ttKpk1MpH0iCYwz620VzqNc5XSodYZZFDv+SQUM1C6WhjS+IhwfzIEFDFPlKU4ZMFNSu2cMsPI07AK90fnJAu4Z11gQRBpjEC3bghmuFrI4z6Oh9+NoZh7UULnVBMcRGndolBmJtenRKhWZT5hAW/Wud0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVoTMHboGg7BugSOfhTuu8AzxK8hStGADWOk/xb1xCM=;
 b=be+awZNQ/HF3ZvnnY8m0o6CmjvzpZqtMTZRTxgoeaZwZYZ18HQLWKT8RzvM46F1aziLcYTpxvFaNPMWfmnH07R7D96lQd+j3cEmjJiIk4QChxXkZ0WT84xkS9um4TPIxiQiV4ikeA6vvV6VYnjP17npOZkK6i0QIbiB0Khbpt1+jd8/kyRESohV/guUuUj1/0PHHSmW6cWWPEnT7aLLkfuerFdx3QHWyFcgM0nGSn7MPiqgRfHyN8bFzvmirqy/iq93/kjTaA4uBcFdf0bMAf38aAYyE+yzcY/RBmrLQV9q2tBH3YAqswnNx0qgX66F0Tp5yX64Nc4n6ph77l5m6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVoTMHboGg7BugSOfhTuu8AzxK8hStGADWOk/xb1xCM=;
 b=gRIxb/xsmTRKD+tseiLRBLmx2+ELkrNLK4t5dMaQ90IzUEW7zBsigA+cyiPpeuS+JpMeELMAh0/r5B/7vthf7B9yE8PPQLyfwd0AOrSc3/OJzcoFG3GUOjOUEcd4jmAKldYXqhlgvcO4+BsqJG0sFjKg1RZqM2jRY0JIHwU1Gqg=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 18:42:44 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::e8) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 18:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:42:43 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:42:42 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 4/8] x86/sev: Move the SNP probe routine out of the way
Date: Wed, 23 Oct 2024 13:41:58 -0500
Message-ID: <783232bca4cfb1c82bacdb0a6048ff4b9ad9d05f.1729708922.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729708922.git.thomas.lendacky@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: d39b6a94-ada5-4abc-0e5e-08dcf3927b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G3fenGeIPfcW3aVa3E8NcwG6vO52ea2Ban/yqkq8j6Y5erN+3dsD+pioHJ0L?=
 =?us-ascii?Q?OKpYqKfTfMW67jZTPlwmHPQungkTnY/9J23e3Zz5r73H9woO3ZmuQ97Uy7VD?=
 =?us-ascii?Q?E7kT/fMWP+URLJk8Y+aZGsy2xSKRUn05R4TiiLYb1rsQMCLog0E/K57LYO+h?=
 =?us-ascii?Q?lbJQ6UDKJAR3VDsaBgQs3POuwX4zihxmd6IpCR9r88BSjUpPLFZG/NEWkqoA?=
 =?us-ascii?Q?QPsf29FuWlO+h8H/QdtXz7ZNIIy4Tu3JeOdcjz386o65NqHgFRi/ko/Fu/GZ?=
 =?us-ascii?Q?uC8dgAq+dLQjCYP7R2HhLHm4/gY8vlmnWOVBDePIydkIw1XVCjfWrHdyoFTA?=
 =?us-ascii?Q?+DoWdBNYjnkciex8U0ovkBFO/6ooqqaVlUYASiSRKA5I/wXxvfeubPAqwYZu?=
 =?us-ascii?Q?hb77p3iNEFG9zsB46jj3hrR036doS7RroqhKwn5QjND3Sa89x6zrY82jhMDl?=
 =?us-ascii?Q?ssJfko1TervLynsFgPDt5C4OsbRK4XwvBtSoR62roAMH7jzdm91Z6YiQf+QB?=
 =?us-ascii?Q?8zz/7sf+eamRLcyaxAExz0oRpdXUTCJe9ndAg8BwRwypCCrAUUtKgX44JonR?=
 =?us-ascii?Q?91brrznTnXLZtnfpURYlOxsdKTSveGMbAIYVaSlU1Gyzmr3w7uRwuAsLnPhB?=
 =?us-ascii?Q?XEzUwBKV/7rRGL5pi/GpKaVwCYbDLweaQnCQfqpvuMDUG/pOt2w/GpyW4SPV?=
 =?us-ascii?Q?x9SicPNpGxnedbU4G4N0rmrxX0dMcQ3mvBi4VTbqB1X0gBibhkJ8ro2hNmu6?=
 =?us-ascii?Q?yr6lcxitEiCfI7S2kC1G9tthcDAwxY7gZQVUrjXMnxzu/RLKelOlMfAkS8D5?=
 =?us-ascii?Q?FCADKxl3uECFTBnBefkrVuZMq1hhmezUkE1omPd1AY6YMKdtPiOhQRDn/au0?=
 =?us-ascii?Q?RFdw/kbivWMuQO/he4Zz0AyjtxWasA/VI1F9IGdgXhsWwLMwhGX8cSEDRzYe?=
 =?us-ascii?Q?uWAWbcErm0bxPYg9n3UsXWzElrcaWMYp70I0UN1sucFn1CU768GoVWv4KcO+?=
 =?us-ascii?Q?TkIj2c/FdoKuw5mFIKmJeYHTyvTPqmdxCoBWaYOyUkYckYrC/OJid7dRY4jv?=
 =?us-ascii?Q?VxwfXJxriGaeXZiAlffgujyD43Q9I8mMC5XdNqGDME5DhmWyTzRdSGqCiQZl?=
 =?us-ascii?Q?3ExUij4owJv3bieLaTKJGj3Ei6vouwiNIrXMMo2PzYMF/uWHM2oCtUAX0avK?=
 =?us-ascii?Q?0jzXcwoI8fOZMPiQeoF6yCkLe9yZyvV/LJ5SkMTO9dr+0eYyW3xOgeTM/fxt?=
 =?us-ascii?Q?FrMoOJo2F0VeqRS+5t8Bn8IaMkNTscDZB7DbhoOjzK+eJEuzE3EdKJXPz12I?=
 =?us-ascii?Q?hUX+4CyAjuqNp8pW4XANZU7WffapJhiekYysQJVfqAh+c+T9/0IAX+P5tupc?=
 =?us-ascii?Q?XKFSxeH0FjOJFpawdTmMxerg60xiiy7DzQOF19ggVLlD+6yTCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:42:43.4234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39b6a94-ada5-4abc-0e5e-08dcf3927b1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

To make patch review easier for the segmented RMP support, move the SNP
probe function out from in between the initialization-related routines.

No functional change.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/virt/svm/sev.c | 60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index e197610b4eed..d0fca9bb2e12 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -132,36 +132,6 @@ static __init void snp_enable(void *arg)
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
@@ -286,6 +256,36 @@ static int __init snp_rmptable_init(void)
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
 static struct rmpentry *__get_rmpentry(u64 pfn)
 {
 	if (!rmptable)
-- 
2.46.2


