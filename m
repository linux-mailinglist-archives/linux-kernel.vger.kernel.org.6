Return-Path: <linux-kernel+bounces-202811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A07E8FD177
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B6B1C2194B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7F3F8E2;
	Wed,  5 Jun 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wNjUNO9S"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99166144D2A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600767; cv=fail; b=WxiFtkyfzCM/upZ8+v4kRKxGsxZsbYbWUknkmvyic4tF7OQ1NXwPz0mjQCW19zWQXn1448aCuzTnEMTZH7bPoK/b+Lf3mrGQubxvNENc/Q2QjdZ1TISz2j5XzGfIvRN6LUXQlvRB8Ne223zj6Kbre8aF3h+qAP+aCGmarSBrJgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600767; c=relaxed/simple;
	bh=gG7mi9/CQUGYICoJwfVhzKIrPgRNuFEwMT7vIWyKGPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUSnXUzAGZqQmD/8/buoRxo+woj81iOls9IwkVE/VjBBxjh52g3WgnRsdVnwIc2RIBruPDqp9JIl5Sy3sKanY3bm45oWQYVd5qBfmm1HhjQf6rxtDlhA/cCKREgMuvHp/lkK9wAQh9hgsX14r1yWAvRz3gjc9xmn4MMmmVHajNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wNjUNO9S; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR2tqiL20VeBeauj4UuwpV7mNfWk+fXDe1im3YzKIBsE4lzQdwtDRvQ2oHOV/oZ1ywhmtuxs74CQLDQgdZjTB15lizySm2rE0qVNLzF0dbjOmIKMSAIBPzcpmx1ZR7uWvmyszVP/Sa59FEOmWqFFttn4ijpSAGX6SqwyuwsL9Q7n2wXXFCsu4ikjE7L8mJAVV1GXd8z5gRgYyG/Ckh8KpC5hsdKW0a1pKBD9TeI6gr0IpQWtCgNSPtGnLg25CeUvUaIHIirK2/kq3FLscIW7K7u1moWqG/kBSWX8F002qFaD7GI+MklAm4Fos+6TRyO7+Rxz+BMVzfN125UKA26lTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjbJFvhCusmjaV8ztNq9uLF6nk+eh+ilw0xpIsXVlQY=;
 b=ee6ty5ii8vqwNsGx1652JVfhpo36HKO3AmCu80BXHwn+OVodcIToNNT1Fyohf3DGivxcndf2PMAcv9aXV5E8qBJ/nx7zwD5ahTFtpFnam0TfqWwD+prcdbak7z3ep7U8tiCmQu6iKLMAaz3EMKaybNC/0b/N67xjhMGkCEAXiphk/qoy1VRAYXGUF/ZQgQOnlSWyewOaYMFWwFplj0ozp9W0VlSHJFvUqJjlWHSxHI+CLo3lQj2oBEU4ilPuLfCGdTskoCBgzAH36E/XmbvKD8iQDpYgIJYLrz3fJ8F5bajnSNRM6SWs3mdI+EeBGtW7Exn8Fr0NWpsLJ/UzgA9KNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjbJFvhCusmjaV8ztNq9uLF6nk+eh+ilw0xpIsXVlQY=;
 b=wNjUNO9SUO655tFS5W7Hn/1brA6qoM13InkveomqSQC4eGhte0netmo6vemN79DDAFr5E5g4nqx+sntS97O38xMeKFAOaHffCYoRfcweNFHySxIgnBGHODIvukf2SCaPfRUutDtgMKNjFg9gReyMhMXp2oV6d0iE7eiaPQkWch8=
Received: from CH2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:610:54::38)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 15:19:23 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::2) by CH2PR11CA0028.outlook.office365.com
 (2603:10b6:610:54::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 15:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 15:19:22 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:19:21 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 02/13] x86/sev: Check for the presence of an SVSM in the SNP Secrets page
Date: Wed, 5 Jun 2024 10:18:45 -0500
Message-ID: <9d3fe161be93d4ea60f43c2a3f2c311fe708b63b.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: fc797fa5-97bd-4dd8-90c6-08dc8572e12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jA70QHmgTIYKwWWX9seiCdjsEn39j4G9H4BYZE0PAtvAolFmE0usRUd5ZDRR?=
 =?us-ascii?Q?DvQ7wxBUViiet+fWJ0aHYTImh30yp+XQB0ixO+cv+Gzr/BUr9uSa76b9+8Ay?=
 =?us-ascii?Q?0ypYP8/tY203C39E8O3IV81EPvGyW5dPo2P4GHhDfGv1ftH9HjSL+Ziq1vO9?=
 =?us-ascii?Q?UAfCWlk1omgpu704UuvWuCMRY8px+qOkKPCeyBt55ZFiANS5QofopmbwXGOn?=
 =?us-ascii?Q?CH6KyTGaxC98ViM/49xN3xeCMx/GlZOiNqey0zq0d1ibY/turKWR3yx8CZCj?=
 =?us-ascii?Q?m/ttrRThvpQ069ynwndPwRq+KtSmVwAQA8JCRnsYhFoQeMSIP4oWDxSMY5Tc?=
 =?us-ascii?Q?VeqTqdD2bpuaRVDwm+VPDrwrRukk4Yt1+WWhLUo5hoIy5L4dXgqWW4bcqmnH?=
 =?us-ascii?Q?/NKvvcbF+ZmQYVRDYgyVsjSfutMu5gl04SMuM7GRgwAxJqjXrAobODe34yqI?=
 =?us-ascii?Q?kUxgs5PmK2CDSzYyIDacyfFzVh5H2hHwHX9vEMc17JmYIeE/slQ97ycbBmhF?=
 =?us-ascii?Q?kpuq6KpZlDhhr/lGDAVtXe+X3U6JjvI1IzBOo16CioC7vTHOJSnDEjnjLoQP?=
 =?us-ascii?Q?tr2gP65HmpDLsNncnEyGUSR+cgA08iko6ahGNSc3Q13hASDwZLNYZHeMod2o?=
 =?us-ascii?Q?zrbN78aIZiifkQwezuAe7QX4wxuOWf6RK75fWxOjLXNlXSJjStOarLmq3s+c?=
 =?us-ascii?Q?O7z4qudAVbJAbY3k9JW5Lneq9MLMU4kFTwpWxkPtzmv9NL9gLwuukV+WuEIg?=
 =?us-ascii?Q?prZlEIZhvy0rVcvXnLncl/ZGHcB35LjmL9B3QZzgGlYByfWsxA8d2ns2/tIs?=
 =?us-ascii?Q?qftCTr/cIxWiKy4b35GT69BiHOaOJz0m6IXEYVgQFPrrbdUyeoNBVFT6rv0i?=
 =?us-ascii?Q?3A3il7YwKGXsaOY05NfAY4ZUGK7S0n/w7c74CjU8rCDkAS1K5m9vcMlEwLeJ?=
 =?us-ascii?Q?/chV9vrBUCz2HESumNVob67QUVCJgGrEAqx+22asVrd2r4buTm9OATcNA1Q8?=
 =?us-ascii?Q?HMlkg43CIsLDmPv4frmEysi3mRiG9Zd9rbioWYy9D1ZMZMWjpdGl17DvyjkW?=
 =?us-ascii?Q?Pgd6Rlw8Cxvl75WGWnFQWVwHy6CYGauIGFlsfM/MwuyL9xIj82GVxJ7ulA1p?=
 =?us-ascii?Q?aHRl4KWw0HqkTMQ+wQ5c/TNJN94bMPBNQdKN8JJmkCwFUp3GnDwgZMFcZDN5?=
 =?us-ascii?Q?PYoGc5m4W92cem9gsM5Z1WVYG5B3Q00JdqQCAhWrAB2CHCmiDYCXhEMKXOVX?=
 =?us-ascii?Q?PoK7X07zdBOoJ7500Gv2w7MtlmPoNaWC/FXPe+hZAqdktf6pMqSH06Ogc7e2?=
 =?us-ascii?Q?cPjcvO9ZouyTFOnwdSKY5orgM1F/dekeJg4IijsCWPTZqdINCHsgMjMtC87d?=
 =?us-ascii?Q?2X4MQFoJW5LCz+RQuHPZoA/8W/5O/YCBK8NWy7waFE7qN0YjxoHeOSI1j0f4?=
 =?us-ascii?Q?eS347b2f4IU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:19:22.9324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc797fa5-97bd-4dd8-90c6-08dc8572e12b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427

During early boot phases, check for the presence of an SVSM when running
as an SEV-SNP guest.

An SVSM is present if not running at VMPL0 and the 64-bit value at offset
0x148 into the secrets page is non-zero. If an SVSM is present, save the
SVSM Calling Area address (CAA), located at offset 0x150 into the secrets
page, and set the VMPL level of the guest, which should be non-zero, to
indicate the presence of an SVSM.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 .../arch/x86/amd-memory-encryption.rst        | 23 ++++++
 arch/x86/boot/compressed/sev.c                | 21 +++---
 arch/x86/include/asm/sev-common.h             |  4 ++
 arch/x86/include/asm/sev.h                    | 34 ++++++++-
 arch/x86/kernel/sev-shared.c                  | 71 +++++++++++++++++++
 arch/x86/kernel/sev.c                         |  7 ++
 6 files changed, 151 insertions(+), 9 deletions(-)

diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 414bc7402ae7..79eebaa85b7d 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -130,4 +130,27 @@ SNP feature support.
 
 More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
 
+Secure VM Service Module (SVSM)
+===============================
+SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
+defines four privilege levels at which guest software can run. The most
+privileged level is 0 and numerically higher numbers have lesser privileges.
+More details in the AMD64 APM[1] Vol 2, section "15.35.7 Virtual Machine
+Privilege Levels", docID: 24593.
+
+When using that feature, different services can run at different protection
+levels, apart from the guest OS but still within the secure SNP environment.
+They can provide services to the guest, like a vTPM, for example.
+
+When a guest is not running at VMPL0, it needs to communicate with the software
+running at VMPL0 to perform privileged operations or to interact with secure
+services. An example fur such a privileged operation is PVALIDATE which is
+*required* to be executed at VMPL0.
+
+In this scenario, the software running at VMPL0 is usually called a Secure VM
+Service Module (SVSM). Discovery of an SVSM and the API used to communicate
+with it is documented in "Secure VM Service Module for SEV-SNP Guests", docID:
+58019[2].
+
 [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
+[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 0457a9d7e515..927b71495122 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -462,6 +462,13 @@ static bool early_snp_init(struct boot_params *bp)
 	 */
 	setup_cpuid_table(cc_info);
 
+	/*
+	 * Record the SVSM Calling Area (CA) address if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	svsm_setup_ca(cc_info);
+
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
 	 * config table doesn't need to be searched again during early startup
@@ -571,14 +578,12 @@ void sev_enable(struct boot_params *bp)
 		/*
 		 * Enforce running at VMPL0.
 		 *
-		 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
-		 * higher) privilege level. Here, clear the VMPL1 permission mask of the
-		 * GHCB page. If the guest is not running at VMPL0, this will fail.
-		 *
-		 * If the guest is running at VMPL0, it will succeed. Even if that operation
-		 * modifies permission bits, it is still ok to do so currently because Linux
-		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
-		 * permission mask changes are a don't-care.
+		 * Use RMPADJUST (see the rmpadjust() function for a description of
+		 * what the instruction does) to update the VMPL1 permissions of a
+		 * page. If the guest is running at VMPL0, this will succeed. If the
+		 * guest is running at any other VMPL, this will fail. Linux SNP guests
+		 * only ever run at a single VMPL level so permission mask changes of a
+		 * lesser-privileged VMPL are a don't-care.
 		 */
 		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 5a8246dd532f..d31f2ed398f0 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -163,6 +163,10 @@ struct snp_psc_desc {
 #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 #define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
 #define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
+#define GHCB_TERM_SECRETS_PAGE		6	/* Secrets page failure */
+#define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
+#define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
+#define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but CAA is not page aligned */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ca20cc4e5826..16d09c1a8ceb 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -152,9 +152,32 @@ struct snp_secrets_page {
 	u8 vmpck2[VMPCK_KEY_LEN];
 	u8 vmpck3[VMPCK_KEY_LEN];
 	struct secrets_os_area os_area;
-	u8 rsvd3[3840];
+
+	u8 vmsa_tweak_bitmap[64];
+
+	/* SVSM fields */
+	u64 svsm_base;
+	u64 svsm_size;
+	u64 svsm_caa;
+	u32 svsm_max_version;
+	u8 svsm_guest_vmpl;
+	u8 rsvd3[3];
+
+	/* Remainder of page */
+	u8 rsvd4[3744];
 } __packed;
 
+/*
+ * The SVSM Calling Area (CA) related structures.
+ */
+struct svsm_ca {
+	u8 call_pending;
+	u8 mem_available;
+	u8 rsvd1[6];
+
+	u8 svsm_buffer[PAGE_SIZE - 8];
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -185,6 +208,15 @@ static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long a
 {
 	int rc;
 
+	/*
+	 * RMPADJUST modifies the RMP permissions of a page of a lesser-privileged
+	 * (numerically higher) VMPL.
+	 *
+	 * If the guest is running at a higher-privilege than the privilege level
+	 * the instruction is targeting, the instruction will succeed, otherwise,
+	 * it will fail.
+	 */
+
 	/* "rmpadjust" mnemonic support in binutils 2.36 and newer */
 	asm volatile(".byte 0xF3,0x0F,0x01,0xFE\n\t"
 		     : "=a"(rc)
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b4f8fa0f722c..739362066e00 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,21 @@
 #define sev_printk_rtl(fmt, ...)
 #endif
 
+/*
+ * SVSM related information:
+ *   When running under an SVSM, the VMPL that Linux is executing at must be
+ *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
+ *
+ *   During boot, the page tables are set up as identity mapped and later
+ *   changed to use kernel virtual addresses. Maintain separate virtual and
+ *   physical addresses for the CAA to allow SVSM functions to be used during
+ *   early boot, both with identity mapped virtual addresses and proper kernel
+ *   virtual addresses.
+ */
+static u8 snp_vmpl __ro_after_init;
+static struct svsm_ca *boot_svsm_caa __ro_after_init;
+static u64 boot_svsm_caa_pa __ro_after_init;
+
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -1269,3 +1284,59 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 
 	return ES_UNSUPPORTED;
 }
+
+/*
+ * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
+ * services needed when not running in VMPL0.
+ */
+static void __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+{
+	struct snp_secrets_page *secrets_page;
+	u64 caa;
+
+	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
+
+	/*
+	 * Check if running at VMPL0.
+	 *
+	 * Use RMPADJUST (see the rmpadjust() function for a description of what
+	 * the instruction does) to update the VMPL1 permissions of a page. If
+	 * the guest is running at VMPL0, this will succeed and implies there is
+	 * no SVSM. If the guest is running at any other VMPL, this will fail.
+	 * Linux SNP guests only ever run at a single VMPL level so permission mask
+	 * changes of a lesser-privileged VMPL are a don't-care.
+	 *
+	 * Use a rip-relative reference to obtain the proper address, since this
+	 * routine is running identity mapped when called, both by the decompressor
+	 * code and the early kernel code.
+	 */
+	if (!rmpadjust((unsigned long)&RIP_REL_REF(boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+		return;
+
+	/*
+	 * Not running at VMPL0, ensure everything has been properly supplied
+	 * for running under an SVSM.
+	 */
+	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
+
+	secrets_page = (struct snp_secrets_page *)cc_info->secrets_phys;
+	if (!secrets_page->svsm_size)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
+
+	if (!secrets_page->svsm_guest_vmpl)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
+
+	RIP_REL_REF(snp_vmpl) = secrets_page->svsm_guest_vmpl;
+
+	caa = secrets_page->svsm_caa;
+	if (caa & (PAGE_SIZE - 1))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
+
+	/*
+	 * The CA is identity mapped when this routine is called, both by the
+	 * decompressor code and the early kernel code.
+	 */
+	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
+	RIP_REL_REF(boot_svsm_caa_pa) = caa;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3342ed58e168..36a117a38b10 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2108,6 +2108,13 @@ bool __head snp_init(struct boot_params *bp)
 
 	setup_cpuid_table(cc_info);
 
+	/*
+	 * Record the SVSM Calling Area address (CAA) if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	svsm_setup_ca(cc_info);
+
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
-- 
2.43.2


