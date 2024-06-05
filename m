Return-Path: <linux-kernel+bounces-202814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC68FD17B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABC82857AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77C14D6F6;
	Wed,  5 Jun 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BO+yppT2"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88D3A260
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600795; cv=fail; b=WmoB3YTNu5ucClJ2jKbwSZNb2JOmdP9VWkkdMlXtkyl5l04oEyWwHOXGXik02PM/5tJzvhSDz+4oQu5BqeBsoeNV1exT3xx4Xm1tod5PDpgKEmZ2NAgQDPTdRDOyI4+CdNv6xAqMxSlIaX0+jpc2l4SS0jA9ijyFmy4hxOZhBy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600795; c=relaxed/simple;
	bh=SNV8BUJEA3FZ6gNafzq0xWHBLqkgW0MXbGqtwVVqS0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqqDgipacENe6okKTueEWrCpiACLcUQ6Zo2uf3R0wm/eyld1EEsdkv1ZwrD2rvu9G+j3PY/rnX/bM8NSIrRo7F1Wy9w3H7PHWiUWsodzGON9yoWMDpVvpEddooHfQD1o4G3rWPJEaT4wd5a9jUrnzDikYX0yrGQbIFxQy4XP9iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BO+yppT2; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf9gyoH0ywEBXtAPfHcO0JdbNU35PI40PBIIPLlyq5RnRGjDuP2s0HbeGAbO2bTE9Av4Qe9FTiv2aYCo7vbyP82XcEU1llfQ6eVcjF52mgq26O/lFwH0UGjo69/2hQR8w7sNHSyxYkKNX9qRU5wOmBfooPTMbfgyrN896zGrnkx5PncTXwWzTkzbGrov/lRR3+XdGDE5FfzX5twb/n1eoKvOORdP1BUs/h3a3KsC11s7riEuIDt007ApCJ4CUkfbqYGvSwodfCAGJoYuWrjBDukK4dM7/sMlQcWg5Ff4H4aieCEV+hnhWJY57U1F08LX8ECf1dw1KQ6FcFci0WuqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG3nV455pmp5tqZ0EHC3If5qatvmPmt4u7RY8hNvdp4=;
 b=ch0jd0BaCMQhyqcAYBzeuc3W7TX40MWJID3sUfajOeP5opcmVKuIYM2PwxZJi+3qy0n6RndulVqoiZarQaMkJOlu2MrcZYoD6HWGpqWYfIisbnhauFGOQrhX1uxXSp7XqCScoatNFys30n0V1atLnJDmk4GOCqjvEjJ+bmjTKBGjy9jaFgPWSwZpMPI3DT568qTdZ8OsFpTPEY/9WMA59aXvMaLQ60iNsxNEOx5T4wzyvZoeKSJST6+5JJU8k0bGir15ez5oD/OTVcbqPWlwUippQb6KND8onCzcqqOc156RDRPn1PNmW3AQwF77G5cfjUOVFGvFJ3nVS634mAohYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG3nV455pmp5tqZ0EHC3If5qatvmPmt4u7RY8hNvdp4=;
 b=BO+yppT2/z0sJ36i4PhWmxJKpRhv3MXYCHZb17dO1e6FRbDdML767g75hPTyD9GGgynFV504egs0afG1NogZT5qBNHy+Trkq/a5fzWCsBYYaMU+yM8cLj3L0npnQpYXK0Rv+eOEMqZ0RDGUWg3Wdh7d9dn07vWLlkxmWgZHzReo=
Received: from CH0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:610:e6::28)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 15:19:37 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::ab) by CH0PR03CA0293.outlook.office365.com
 (2603:10b6:610:e6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 15:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 15:19:37 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:19:36 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 04/13] x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
Date: Wed, 5 Jun 2024 10:18:47 -0500
Message-ID: <4c4017d8b94512d565de9ccb555b1a9f8983c69c.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6383bc25-84d7-45ef-35bc-08dc8572e9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qwxMvH5rQ2j7hbfLGsS0eotbSOwHmOBGHj0XpeJ3mbS3e3TwrhqsfWIpcZWQ?=
 =?us-ascii?Q?vWmucZcSzd9eISVnmPlycn19NLTovWpdtQFt16wSVGC2Sjt5r9hXec+bc4yr?=
 =?us-ascii?Q?75ydNeMp7Bf0Jf55zxb2ZtAPYyeJJa8gaBolrQyhPZQQYhd5/88eDgfOT/Md?=
 =?us-ascii?Q?UUulWKKfkzqv9rVUB3c5ch2ZUKHEbfkIeXhXUqE0E+thVeg5JP7wALjWkxCz?=
 =?us-ascii?Q?Ky/0biQpV994uoBIH3gT+Pj3qmXDAEJajLbjZa08zCr5qK3jmNSTJon0ZDzQ?=
 =?us-ascii?Q?0LPnE4YkF1krG28EH2kkw7BoQGoL240X7BneLrbeL5xnLiLBZe67jrXGqcrb?=
 =?us-ascii?Q?ZLDydScuynWzjP50zrkY/Jm3g12RZIZph6LfJ+2KEYORt1+uK/8AqTLopPaf?=
 =?us-ascii?Q?2R7DPq7M0c97l8aTVBJz48G5feC8vDOUvdawVvFyuPMZhRbJafrNS0sDu/ZH?=
 =?us-ascii?Q?JfPM6vl8uVo7XXOwnodVNZSt7O7yflLRqDV2nf1K0NsZN/ShUfsNG0nqBrJu?=
 =?us-ascii?Q?qRWPGlVWNRMK00TJ8YCMAVbt+QG6KISghcoqMHCHzDVoiA0+DOezpLP+7Oyy?=
 =?us-ascii?Q?qUAJ6idOMgOTwCXsx+2uPaPIH8MSXKgSelz3MRgXBFHEnVv+xKpFabvR56GK?=
 =?us-ascii?Q?cnKj7YAmuYkWrxdyq1ulRsulNNUQrTylkCE77Hp1igfwySCiaaVLgl/I3rYO?=
 =?us-ascii?Q?HjQeZsNY7L1FHei0tngTWSci87X2IxMz8jJ4IhLtLulVxJJ47QRqPTLTgJ6A?=
 =?us-ascii?Q?PN4zCaTMKGEKZr5wOK4wvNy+fM/WDqxWJuAbXPxpwhkZ8z7fCUbKp3AIZEDS?=
 =?us-ascii?Q?892/U9E2dir8lpPQWMLu+UtDyne0K4Vim6BlkN84pn+5IUr4NjiI0fDUroZx?=
 =?us-ascii?Q?55KbfvXZy4bTIHtMA6k6g73nYSGopKBDU7M264sUVG7GtcM+/B0RnirNFFNR?=
 =?us-ascii?Q?xqEIc2U/JfofIPuMuFMys5hts5I1okDMFEUrGKkz6QQb89AAtSjAl1vnHibS?=
 =?us-ascii?Q?Ih8rIqfW7H6c6JuNwXOsbaX6/bzphaR44Q9qKxIKgkrQFP+IJRNtArB6beif?=
 =?us-ascii?Q?JqkRT93ejH1S/p154Wy+zhEuu0L6JhU8T8XhmgqoieYxUntGokdpbtQTe+sx?=
 =?us-ascii?Q?f4qm83TkZMnAbhNZPw6ythAkHiNml3uKXiqMQQ2KT89JLzJvVb6aKBjKk2Ow?=
 =?us-ascii?Q?r+nraJVbxQmq3lCKH6fqScnBiehud0qd+co+tMemDTE3quaeziFgFk5M0+DZ?=
 =?us-ascii?Q?LjkxfEEgOkykJ0x2aGB4ePVDLKSh3Nc2QqyGiXRO9OmUnjcZLNpiqBE6nP9c?=
 =?us-ascii?Q?QDD8qFRbesXmk+jl8v3g5JgnnS9i3VYTw80w0sswa0rK9QjvqivDpgcrBww2?=
 =?us-ascii?Q?1hzZeO1PbvSU4LWeXShKKzodTZjitNSVmZQRqeSYoYBI6MLuKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:19:37.2891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6383bc25-84d7-45ef-35bc-08dc8572e9ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

The PVALIDATE instruction can only be performed at VMPL0. An SVSM will
be present when running at VMPL1 or a lower privilege level.

When an SVSM is present, use the SVSM_CORE_PVALIDATE call to perform
memory validation instead of issuing the PVALIDATE instruction directly.

The validation of a single 4K page is now explicitly identified as such
in the function name, pvalidate_4k_page(). The pvalidate_pages() function
is used for validating 1 or more pages at either 4K or 2M in size. Each
function, however, determines whether it can issue the PVALIDATE directly
or whether the SVSM needs to be invoked.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c |  45 +++++-
 arch/x86/include/asm/sev.h     |  26 ++++
 arch/x86/kernel/sev-shared.c   | 250 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/sev.c          |  30 ++--
 4 files changed, 325 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 927b71495122..1cc3106a3ba7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -129,6 +129,34 @@ static bool fault_in_kernel_space(unsigned long address)
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+static struct svsm_ca *svsm_get_caa(void)
+{
+	return boot_svsm_caa;
+}
+
+static u64 svsm_get_caa_pa(void)
+{
+	return boot_svsm_caa_pa;
+}
+
+static int svsm_perform_call_protocol(struct svsm_call *call)
+{
+	struct ghcb *ghcb;
+	int ret;
+
+	if (boot_ghcb)
+		ghcb = boot_ghcb;
+	else
+		ghcb = NULL;
+
+	do {
+		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
+			   : svsm_perform_msr_protocol(call);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
 bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
@@ -145,8 +173,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * If private -> shared then invalidate the page before requesting the
 	 * state change in the RMP table.
 	 */
-	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(paddr, paddr, false);
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
@@ -161,8 +189,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
 	 */
-	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(paddr, paddr, true);
 }
 
 void snp_set_page_private(unsigned long paddr)
@@ -255,6 +283,15 @@ void sev_es_shutdown_ghcb(void)
 	if (!sev_es_check_cpu_features())
 		error("SEV-ES CPU Features missing.");
 
+	/*
+	 * This is used to determine whether to use the GHCB MSR protocol or
+	 * the GHCB shared page to perform a GHCB request. Since the GHCB page
+	 * is being changed to encrypted, it can't be used to perform GHCB
+	 * requests. Clear the boot_ghcb variable so that the GHCB MSR protocol
+	 * is used to change the GHCB page over to an encrypted page.
+	 */
+	boot_ghcb = NULL;
+
 	/*
 	 * GHCB Page must be flushed from the cache and mapped encrypted again.
 	 * Otherwise the running kernel will see strange cache effects when
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 3abc2d759db7..01e3866c4d61 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -187,6 +187,31 @@ struct svsm_ca {
 #define SVSM_ERR_INVALID_PARAMETER		0x80000005
 #define SVSM_ERR_INVALID_REQUEST		0x80000006
 #define SVSM_ERR_BUSY				0x80000007
+#define SVSM_PVALIDATE_FAIL_SIZEMISMATCH	0x80001006
+
+/*
+ * The SVSM PVALIDATE related structures
+ */
+struct svsm_pvalidate_entry {
+	u64 page_size		: 2,
+	    action		: 1,
+	    ignore_cf		: 1,
+	    rsvd		: 8,
+	    pfn			: 52;
+};
+
+struct svsm_pvalidate_call {
+	u16 num_entries;
+	u16 cur_index;
+
+	u8 rsvd1[4];
+
+	struct svsm_pvalidate_entry entry[];
+};
+
+#define SVSM_PVALIDATE_MAX_COUNT	((sizeof_field(struct svsm_ca, svsm_buffer) -		\
+					  offsetof(struct svsm_pvalidate_call, entry)) /	\
+					 sizeof(struct svsm_pvalidate_entry))
 
 /*
  * SVSM protocol structure
@@ -207,6 +232,7 @@ struct svsm_call {
 
 #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
 #define SVSM_CORE_REMAP_CA		0
+#define SVSM_CORE_PVALIDATE		1
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 00173deefc46..c274fa826ef0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -40,6 +40,10 @@ static u8 snp_vmpl __ro_after_init;
 static struct svsm_ca *boot_svsm_caa __ro_after_init;
 static u64 boot_svsm_caa_pa __ro_after_init;
 
+static struct svsm_ca *svsm_get_caa(void);
+static u64 svsm_get_caa_pa(void);
+static int svsm_perform_call_protocol(struct svsm_call *call);
+
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -1216,19 +1220,97 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
-static void pvalidate_pages(struct snp_psc_desc *desc)
+static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svsm_ret)
+{
+	unsigned int page_size;
+	bool action;
+	u64 pfn;
+
+	pfn = pc->entry[pc->cur_index].pfn;
+	action = pc->entry[pc->cur_index].action;
+	page_size = pc->entry[pc->cur_index].page_size;
+
+	WARN(1, "PVALIDATE failure: pfn 0x%llx, action=%u, size=%u - ret=%d, svsm_ret=0x%llx\n",
+	     pfn, action, page_size, ret, svsm_ret);
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
+static void pval_terminate(u64 pfn, bool action, unsigned int page_size, int ret)
+{
+	WARN(1, "PVALIDATE failure: pfn 0x%llx, action=%u, size=%u - ret=%d\n",
+	     pfn, action, page_size, ret);
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
+static void svsm_pval_4k_page(unsigned long paddr, bool validate)
+{
+	struct svsm_pvalidate_call *pc;
+	struct svsm_call call = {};
+	unsigned long flags;
+	u64 pc_pa;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_local_irq_save();
+
+	call.caa = svsm_get_caa();
+
+	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	pc->num_entries = 1;
+	pc->cur_index   = 0;
+	pc->entry[0].page_size = RMP_PG_SIZE_4K;
+	pc->entry[0].action    = validate;
+	pc->entry[0].ignore_cf = 0;
+	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
+
+	/* Protocol 0, Call ID 1 */
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx = pc_pa;
+
+	ret = svsm_perform_call_protocol(&call);
+	if (ret)
+		svsm_pval_terminate(pc, ret, call.rax_out);
+
+	native_local_irq_restore(flags);
+}
+
+static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
+{
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, so use rip-relative
+	 * references as needed.
+	 */
+	if (RIP_REL_REF(snp_vmpl)) {
+		svsm_pval_4k_page(paddr, validate);
+	} else {
+		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+		if (ret)
+			pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret);
+	}
+}
+
+static void pval_pages(struct snp_psc_desc *desc)
 {
 	struct psc_entry *e;
 	unsigned long vaddr;
 	unsigned int size;
 	unsigned int i;
 	bool validate;
+	u64 pfn;
 	int rc;
 
 	for (i = 0; i <= desc->hdr.end_entry; i++) {
 		e = &desc->entries[i];
 
-		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
+		pfn = e->gfn;
+		vaddr = (unsigned long)pfn_to_kaddr(pfn);
 		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
 
@@ -1236,20 +1318,170 @@ static void pvalidate_pages(struct snp_psc_desc *desc)
 		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
 			unsigned long vaddr_end = vaddr + PMD_SIZE;
 
-			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
+			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE, pfn++) {
 				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 				if (rc)
-					break;
+					pval_terminate(pfn, validate, RMP_PG_SIZE_4K, rc);
 			}
-		}
-
-		if (rc) {
-			WARN(1, "Failed to validate address 0x%lx ret %d", vaddr, rc);
-			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+		} else if (rc) {
+			pval_terminate(pfn, validate, size, rc);
 		}
 	}
 }
 
+static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
+					struct svsm_pvalidate_call *pc)
+{
+	struct svsm_pvalidate_entry *pe;
+
+	/* Nothing in the CA yet */
+	pc->num_entries = 0;
+	pc->cur_index   = 0;
+
+	pe = &pc->entry[0];
+
+	while (pfn < pfn_end) {
+		pe->page_size = RMP_PG_SIZE_4K;
+		pe->action    = action;
+		pe->ignore_cf = 0;
+		pe->pfn       = pfn;
+
+		pe++;
+		pfn++;
+
+		pc->num_entries++;
+		if (pc->num_entries == SVSM_PVALIDATE_MAX_COUNT)
+			break;
+	}
+
+	return pfn;
+}
+
+static void svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc,
+					struct svsm_pvalidate_call *pc)
+{
+	struct svsm_pvalidate_entry *pe;
+	unsigned int desc_entry;
+	struct psc_entry *e;
+
+	desc_entry = desc->hdr.cur_entry;
+
+	/* Nothing in the CA yet */
+	pc->num_entries = 0;
+	pc->cur_index   = 0;
+
+	pe = &pc->entry[0];
+	e  = &desc->entries[desc_entry];
+
+	while (desc_entry <= desc->hdr.end_entry) {
+		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
+		pe->ignore_cf = 0;
+		pe->pfn       = e->gfn;
+
+		pe++;
+		e++;
+
+		desc_entry++;
+		pc->num_entries++;
+		if (pc->num_entries == SVSM_PVALIDATE_MAX_COUNT)
+			break;
+	}
+
+	desc->hdr.cur_entry = desc_entry;
+}
+
+static void svsm_pval_pages(struct snp_psc_desc *desc)
+{
+	struct svsm_pvalidate_entry pv_4k[VMGEXIT_PSC_MAX_ENTRY];
+	unsigned int i, pv_4k_count = 0;
+	struct svsm_pvalidate_call *pc;
+	struct svsm_call call = {};
+	unsigned long flags;
+	bool action;
+	u64 pc_pa;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_local_irq_save();
+
+	/*
+	 * The SVSM calling area (CA) can support processing 510 entries at a
+	 * time. Loop through the Page State Change descriptor until the CA is
+	 * full or the last entry in the descriptor is reached, at which time
+	 * the SVSM is invoked. This repeats until all entries in the descriptor
+	 * are processed.
+	 */
+	call.caa = svsm_get_caa();
+
+	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	/* Protocol 0, Call ID 1 */
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx = pc_pa;
+
+	while (desc->hdr.cur_entry <= desc->hdr.end_entry) {
+		svsm_build_ca_from_psc_desc(desc, pc);
+
+		do {
+			ret = svsm_perform_call_protocol(&call);
+			if (ret) {
+				/*
+				 * Check if the entry failed because of an RMP mismatch (a
+				 * PVALIDATE at 2M was requested, but the page is mapped in
+				 * the RMP as 4K).
+				 */
+				if (call.rax_out == SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
+				    pc->entry[pc->cur_index].page_size == RMP_PG_SIZE_2M) {
+					/* Save this entry for post-processing at 4K */
+					pv_4k[pv_4k_count++] = pc->entry[pc->cur_index];
+
+					/* Skip to the next one unless at the end of the list */
+					pc->cur_index++;
+					if (pc->cur_index < pc->num_entries)
+						ret = -EAGAIN;
+					else
+						ret = 0;
+				}
+			}
+		} while (ret == -EAGAIN);
+
+		if (ret)
+			svsm_pval_terminate(pc, ret, call.rax_out);
+	}
+
+	/* Process any entries that failed to be validated at 2M and validate them at 4K */
+	for (i = 0; i < pv_4k_count; i++) {
+		u64 pfn, pfn_end;
+
+		action  = pv_4k[i].action;
+		pfn     = pv_4k[i].pfn;
+		pfn_end = pfn + 512;
+
+		while (pfn < pfn_end) {
+			pfn = svsm_build_ca_from_pfn_range(pfn, pfn_end, action, pc);
+
+			ret = svsm_perform_call_protocol(&call);
+			if (ret)
+				svsm_pval_terminate(pc, ret, call.rax_out);
+		}
+	}
+
+	native_local_irq_restore(flags);
+}
+
+static void pvalidate_pages(struct snp_psc_desc *desc)
+{
+	if (snp_vmpl)
+		svsm_pval_pages(desc);
+	else
+		pval_pages(desc);
+}
+
 static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 {
 	int cur_entry, end_entry, ret = 0;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 6bab3244a3b9..b5c18ed4c572 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -626,6 +626,17 @@ static struct svsm_ca *svsm_get_caa(void)
 						    : RIP_REL_REF(boot_svsm_caa);
 }
 
+static u64 svsm_get_caa_pa(void)
+{
+	/*
+	 * Use rip-relative references when called early in the boot. If
+	 * cas_initialized is set, then it is late in the boot and no need
+	 * to worry about rip-relative references.
+	 */
+	return RIP_REL_REF(sev_cfg).cas_initialized ? this_cpu_read(svsm_caa_pa)
+						    : RIP_REL_REF(boot_svsm_caa_pa);
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -798,7 +809,6 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 {
 	unsigned long paddr_end;
 	u64 val;
-	int ret;
 
 	vaddr = vaddr & PAGE_MASK;
 
@@ -806,12 +816,9 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	paddr_end = paddr + (npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
-		if (op == SNP_PAGE_STATE_SHARED) {
-			/* Page validation must be rescinded before changing to shared */
-			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
-				goto e_term;
-		}
+		/* Page validation must be rescinded before changing to shared */
+		if (op == SNP_PAGE_STATE_SHARED)
+			pvalidate_4k_page(vaddr, paddr, false);
 
 		/*
 		 * Use the MSR protocol because this function can be called before
@@ -833,12 +840,9 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
 			goto e_term;
 
-		if (op == SNP_PAGE_STATE_PRIVATE) {
-			/* Page validation must be performed after changing to private */
-			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
-				goto e_term;
-		}
+		/* Page validation must be performed after changing to private */
+		if (op == SNP_PAGE_STATE_PRIVATE)
+			pvalidate_4k_page(vaddr, paddr, true);
 
 		vaddr += PAGE_SIZE;
 		paddr += PAGE_SIZE;
-- 
2.43.2


