Return-Path: <linux-kernel+bounces-202823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 161708FD186
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67434B26F58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5E19308A;
	Wed,  5 Jun 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hpnW3bYB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E719307D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600862; cv=fail; b=NUEgHtMgcWT6BOC8+L4lwjsB23b5gTd7wJwwW+DvA16ctPIAu47tIoAR2W3OVIztnj+kyZFKY9Wj9kcaXgAt2vhFbzVN8aiH7vA23nam+xpFLI7URr4oCd9XH57sUWG1T5o+TcNmEdu2ss61l7N8xorOYMZyRGg51tHr9QJYpCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600862; c=relaxed/simple;
	bh=AircKrfsNlMSJI3s0adG5ofeDMaAt9OP1GjcUy38nEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/YPM30oOsaELgQmTGX1iIiziFmbLObJW1+0rrUxpETKRkFwTvOjZt6f4gUjwzYnmQmLzydi79ZQ9/7MxibmcBTV3gnDdolwMqA6PibILHfEJQCzVDsimvdwbjgP/WqFrR6I4O2EC3UK+CI5Wb/JO2jI0M2dRignOgiI5dohCMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hpnW3bYB; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPvu9yB0V/s2E5yKp1ouE44KJ4FFJACsygWfK2fsnvX8QiH5lgsj9h1tQRlCsLToxjrdBg0O0Dd9vzs6bIj69pCmW2TyDjC1O8ebO9B8Qk3jhjvzD2CZu/gMz47DhtZ16JpTXHG6UuS821cYo9ynMO0Dsd1+42tKrINLyC3/gup8MEItny7DbGoOOdV7xLd2SHIxfQbpLvaTO01dJc2oKJ6YlnMrsty2nFNdjIcmomxJjwXh5Pb+t1QDmcFajK7iQxEhc/qq+2UfVuIDqxBweO4f8dHgkCoPmB5Nv8a1cwhjDXbFmzQZ3ZXpi6tR3M9VE14PjyWuDI4xcLQw/17oNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSAQ121X98iwiEcitX8x/iHAY6E8i4awlh577kfvVy0=;
 b=AwQ5eKVJrKnb3V+n4zVCOxgPzwqfwmjl9BiTVFxQ7XhUiNhZOxw00fQsNIdx4PecdM65eeCSrcR4P263qDbycvkQYN5JyLQp2+UHu3A2WYjYwUpMmQRiUdXg27vvKvHLxY6r1DU3xLCtitUO+eF3pXPhvICk3Zj5IsCVGtVoxsLY7b00IS1kwu4Id/n36U628W1nqVq3J0PTmp/amsiT6HqmseMXYAEEnALhQqf3OUTVYfmqo3jk16ko9XdaDSqtFWQ6YGMVfuXcj2f8XbXrw2skHPskt5CYAAN+u9CC0J3fAbJ+dlS4lqPvxaQZ2G0dIMTv0HxL04L/qZym9VkN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSAQ121X98iwiEcitX8x/iHAY6E8i4awlh577kfvVy0=;
 b=hpnW3bYBpQAMlZH38TUvOw8QKeRQRZJj7aaG40hiCwQX8K38xlaT5C3FOA13c9UL7fhqyyo8bUHUVbEQiSyt311/bJvNJop/PEvfQ80ilS0brZnPPkzCAEWp41I2KuqxEHEpiXvvMOlC/O6RVlyBL0SGerN7ZJm2keUB2bmSZnQ=
Received: from BN9PR03CA0709.namprd03.prod.outlook.com (2603:10b6:408:ef::24)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 15:20:50 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::ca) by BN9PR03CA0709.outlook.office365.com
 (2603:10b6:408:ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 15:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:20:50 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:20:49 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 13/13] x86/sev: Allow non-VMPL0 execution when an SVSM is present
Date: Wed, 5 Jun 2024 10:18:56 -0500
Message-ID: <2ce7cf281cce1d0cba88f3f576687ef75dc3c953.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1717600736.git.thomas.lendacky@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbd74a5-6994-4d7a-8809-08dc8573153d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2UrSqoGFE9p8sO1/SMqMdyk/FhUedxNuA/a75xLKNUrdmQnrGxTapdnJrggw?=
 =?us-ascii?Q?AEISPXMWqmV4EeRwo3K1icpK9ORpxI579s5ANYPUSARx3CIbJE00ePmmLKi3?=
 =?us-ascii?Q?L45Y91XgeeR/NE1/Jmf1bntVTJAYeN9AwHaDJXgofb1vSxeXpq33pnzq3C3y?=
 =?us-ascii?Q?IDv19J5cGPfCko5xBh/ReAUbUk3QKFCAoZX4iHf4v4BLLDTgeLEO+ymMPc9t?=
 =?us-ascii?Q?gxrzrKTk2w1zZ0wS7tdM1cYvXZZnLhRLVshSAoaMnZFXigs7VO1ME1VtitOB?=
 =?us-ascii?Q?POYf4qxpyKcaEXjRHkjPDH4NwDIU9s0gZOdNONsPWJkePkCq9gPe9IXa3GI5?=
 =?us-ascii?Q?TMUoFoR1fvKlk5l1Vv3tL6Ek7mvhtCaFuhekP1J1d8IDbaLj7uB/v6F7jG/q?=
 =?us-ascii?Q?ezl8Gji6O9NqiRkvpVbB1ij2oTJ+3bA6b/FQNb/tzUimjQr8y9UawztYDKQe?=
 =?us-ascii?Q?2l6pFmhPqpTyn3W3k2h6VgfaZfAYy00yRhYDHa8frL+32gOzcEGCsO2BUP4b?=
 =?us-ascii?Q?utOh+v2depIU7SrDFNzw7Og7yvXfEDnzDPBZRH4Yu/xZ4nR+z6JPJ8HJBxqW?=
 =?us-ascii?Q?nij8Fes/E2pp9Mp+jg0mbpWFwP2hmnEPDJ5qWbZKzobvhht4WwTms6a6lsLE?=
 =?us-ascii?Q?8zPi5sKID7y7QXHhBkRkunJy0dWZcqFZ9BuJFGz30r5ZRHiPxjYxUtHzCuAT?=
 =?us-ascii?Q?xTOptiemSu7Ccgve9OzEduY8TZnwMmbGwTZ66RAQ2fZNNZ9jIpQMxYQmb9Eh?=
 =?us-ascii?Q?tNZxqE+mBcGarxhZTXNL3ap9vhBHXEewiQF5ycKYFfYtS928nnNprwsHpvyY?=
 =?us-ascii?Q?rUhhh19XSjFDANwUqNbR5K9ZNPZnQf1hHPqV5QdEcEVaJblbOIgpCSrjnpP3?=
 =?us-ascii?Q?fiJVM6s4eyWB18oBlMxxLsPOkd/nhS2A1Sv17RWkJmID2QQZqZuTWnQjE+fO?=
 =?us-ascii?Q?hJEG5ziHVjeV25AGNUZF5/uzfb9ALScDM+05Sq8qkdK/OTYd11LgyFMuIMkH?=
 =?us-ascii?Q?FBejaeT2am1ZSxQqGCR+V2WmjfxDoCNdk21OhtSpUOJolM+blKkzzDVqEA/U?=
 =?us-ascii?Q?srwJAhkwWECYMBfS5O2vIcM6aJN62i4e5wEr2amoym+gCScY6oSdMCsd7tZ4?=
 =?us-ascii?Q?DHIVV4X/1UP1I4z3V+9L1URBn9WZzcgBrOeMwqWvKOBP3sQtAJCh2GMTFa3p?=
 =?us-ascii?Q?JQjCMr42OhNZPH6RzbiByYAQ/+aqf9f51/qz/MP+fezQ4n9hbZ0jICfYPkSX?=
 =?us-ascii?Q?t9GW0FnY8VLZeV+kNFaxFP8rbaPapCBkB5RokNyy3IH3gBVWODriq8hhIhVb?=
 =?us-ascii?Q?UzPvfKabIql0CCYA6FMMONUe9CWAMXcXHAutNvs4aS1fVcpTsF9TAH+BUPBT?=
 =?us-ascii?Q?7RyG5kAE9iWAVTB5Daqi0DnXoxUYdWM2Tp8XAG19nbUV6FxODg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:20:50.3230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbd74a5-6994-4d7a-8809-08dc8573153d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962

To allow execution at a level other than VMPL0, an SVSM must be present.
Allow the SEV-SNP guest to continue booting if an SVSM is detected and
the hypervisor supports the SVSM feature as indicated in the GHCB
hypervisor features bitmap.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 17 ++++++++++++++---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kernel/sev.c             | 20 ++++++++++++--------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 1cc3106a3ba7..018c37ec1838 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -609,11 +609,15 @@ void sev_enable(struct boot_params *bp)
 	 * features.
 	 */
 	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
-		if (!(get_hv_features() & GHCB_HV_FT_SNP))
+		u64 hv_features;
+		int ret;
+
+		hv_features = get_hv_features();
+		if (!(hv_features & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 		/*
-		 * Enforce running at VMPL0.
+		 * Enforce running at VMPL0 or with an SVSM.
 		 *
 		 * Use RMPADJUST (see the rmpadjust() function for a description of
 		 * what the instruction does) to update the VMPL1 permissions of a
@@ -622,7 +626,14 @@ void sev_enable(struct boot_params *bp)
 		 * only ever run at a single VMPL level so permission mask changes of a
 		 * lesser-privileged VMPL are a don't-care.
 		 */
-		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
+
+		ret = rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1);
+
+		/*
+		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
+		 * supports the required SVSM GHCB events.
+		 */
+		if (ret && !(snp_vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 78a4c25119da..e90d403f2068 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -122,6 +122,7 @@ enum psc_op {
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
+#define GHCB_HV_FT_SNP_MULTI_VMPL	BIT_ULL(5)
 
 /*
  * SNP Page State Change NAE event
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index f4ae1d037b04..b7f3c767ef00 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2349,23 +2349,27 @@ static void dump_cpuid_table(void)
  * expected, but that initialization happens too early in boot to print any
  * sort of indicator, and there's not really any other good place to do it,
  * so do it here.
+ *
+ * If running as an SNP guest, report the current VM privilege level (VMPL).
  */
-static int __init report_cpuid_table(void)
+static int __init report_snp_info(void)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
-	if (!cpuid_table->count)
-		return 0;
+	if (cpuid_table->count) {
+		pr_info("Using SNP CPUID table, %d entries present.\n",
+			cpuid_table->count);
 
-	pr_info("Using SNP CPUID table, %d entries present.\n",
-		cpuid_table->count);
+		if (sev_cfg.debug)
+			dump_cpuid_table();
+	}
 
-	if (sev_cfg.debug)
-		dump_cpuid_table();
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		pr_info("SNP running at VMPL%u.\n", snp_vmpl);
 
 	return 0;
 }
-arch_initcall(report_cpuid_table);
+arch_initcall(report_snp_info);
 
 static int __init init_sev_config(char *str)
 {
-- 
2.43.2


