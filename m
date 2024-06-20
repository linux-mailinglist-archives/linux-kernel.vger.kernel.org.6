Return-Path: <linux-kernel+bounces-223626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5419115B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773B11F226CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C5139CE5;
	Thu, 20 Jun 2024 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E6GllXk/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A314F9EE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922255; cv=fail; b=MYemTxOmpCIbqJc7qXTLJtTPYUkvC0GiVyt04YIqTe4C+i3Mxr8kdF26Xne87RSRuLDDYS5RB6ZFfJf0+NwDeUQVDA65QnlUG+sUa/2AqwvyOJVrkYOaD3JZCQxMRzYhU16ZfzgM8VgCdpWQu7qVme38iZVu5vFBY0uD8z1QGfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922255; c=relaxed/simple;
	bh=//X+ceCgmDZ9pDa+fSwMI67J6zWoEq/kcKyPK8d7DGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI27ovJxE9sd2m0GKGc+bsIldYtSJCeHQ19lbU9kbAODyal57w9vESDRTd7TtO6DA0/M1NLS/kdAf7dxRkSe73fX1Wjm0P11ES+Z3Q+kbC1MenOQpHkwWaUz2SXXJzL/Dpm3CQwqPEth9jw55z8MHveqi2qyJK95j960MxGqQ+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E6GllXk/; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBdWoil/qRPx2hKkS8eIO+rPrVWufUwqgEhOffw6ttl0HOcwwgvTPComJt0Km5EuZeaPL7ULMRgrEDpSrW8mkaiCTnHZ2LmDcnr7YRDSQqG3bY/XxkNyPFX15614MMyfslRh5P/fCLlgLJauoRa5sdoSL4hf/9NtUt2Y8S4AZ4aV51cnUzN5Y/G06vsLyOSCAInAzLkPWesknOmj1zKCNaLx3umJnaqlZpZklQpujMi1YB/kWNYSNHunpLM7gm1JOhgapotK/uWmts9UKaVVINklmafAG/bgVrMq4n7kZcBHNt6Z125p3LIK3/QWtWTPoyKR4YrpYSBErgViIrtCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J+bxF4RMF54exgJCXjn4Sm2+fnJVGvuauyYNYQGI/w=;
 b=PKR7zUBHceCE9qIRiS8N7Nd1Q1SE9bm0K/HlVvysR2EfHm3Bapy1SQesmtsIMSDlW4tPfhP4zIbOC71QEakdt2eqRkmfpsF8kEsv80BsqfLUra6ywJgy84bHOzAqLpLxfcYAcrd3kq3/g/vXwQV5m7yNxheLNi3slL5oU4EvLg9wAYXicw2UZ/4D/Xloy5fqaP/iEywaA6yut9ffv4bPDhCc7xaFIc0zkYjrf9gi7eoBFOf/Ib0p3u2eqBu8j9G400IFuk8N1ukK3tyKq/r1/UmRG1g9jTmsah36mP/AeGM9QxdfzOmPTUzPMkFDW0hI0X1avpxiZhSqvHHDCvMt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J+bxF4RMF54exgJCXjn4Sm2+fnJVGvuauyYNYQGI/w=;
 b=E6GllXk/VshSdZflQuD0Ki7nQqJtCuasI1T057XfHa9iovCQs34vDW0khJG4eBqMuelKWHl/oylNZCDYKvBXESxeXEdpKt3W4RfYjeKnXO6bGDC7vrFZFHWPfCvBNPpOTFssoYsB2Q+y47LpKUTC9cUkPB9fxPDrO53RUoLrSJo=
Received: from CH0PR04CA0055.namprd04.prod.outlook.com (2603:10b6:610:77::30)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 22:24:09 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::4) by CH0PR04CA0055.outlook.office365.com
 (2603:10b6:610:77::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 22:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 22:24:09 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 17:24:08 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on kexec
Date: Thu, 20 Jun 2024 22:23:59 +0000
Message-ID: <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718920799.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1718920799.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df3d160-d4bb-4cbf-59e8-08dc9177b498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ghQmLF7frqupN2+g978ZLQhj8iulSpLFDTuCTvlynsk/tjZc4Qs8PinZEFiR?=
 =?us-ascii?Q?M+/tseywL29IIwMLkNP4/AyToyH+R455X3WflVekAOyZQjxuTDca+Heb1oIr?=
 =?us-ascii?Q?MDNdPVHZOXQ/ZPDw7RL9/raOGndgy4BTWEZput/yB+8Bs8B4Wsk90yl0xWXS?=
 =?us-ascii?Q?DeaVla4NYPyexkKjVO7DHz2f483x8DoPEcaQFEfyUv6FUzNL5Je09rgkAZGq?=
 =?us-ascii?Q?qg58QtHh/IHKASN065W5He8k8Kf8mHRqu9gOwC9sBRigAiVzTML9ALQDuCFI?=
 =?us-ascii?Q?tuuBaUDPbRiI/r6Gkg1DpKofdQ0szRYG32zKrIfNSgbnuoj7+EkF8OOT/XO/?=
 =?us-ascii?Q?V1ftEMSi/TaOldZ0sHOu/ETf55/mqNMv3V51k6pqW/C3/7BfmQK8494xZGIT?=
 =?us-ascii?Q?sn6mtnix+YGJ6WaZaC+H70cGPMONYrXFTNjy78+MKt709Xu8T+0mQrNZTEQr?=
 =?us-ascii?Q?FTmLom4sZvpsPCwM+qDWlzkMgqozBbfC8Doz0AeeCtrrK8O3r4DQ1BF6UBrI?=
 =?us-ascii?Q?v0hY0AGMZ3nNOYd3+k4D5NEYDjw2QdVecZjrJrncdhgxWzCDg9yk16daeFc4?=
 =?us-ascii?Q?9/P6QIS35tKSnzp+u+jRQtx58nF/CZVhXJYLvEkuICJkPNohkfv1xUj3roBC?=
 =?us-ascii?Q?czYj7QSejlkM1u9M8ZlwrDTJWyrLp4K0pkGMpdoI4HL82aGGa5+y8Mqx1vb6?=
 =?us-ascii?Q?7BzR/aCfkMQkBDuTpcWOJ9hxbCWPMzgMlmCYQV0pqQ9j6XHeUvk3iHR24UyD?=
 =?us-ascii?Q?rqY8NHpOWrazD/X94OFkDWuppewS2TWaclYeSj/lLF7fvQVSjtwBitmPHuIR?=
 =?us-ascii?Q?31v7o+EQ1ViiznAtHhoLK+oabYjcGx0fT2fTpkU8FJuhANperwUerwoxYkSp?=
 =?us-ascii?Q?clzA2MkwGw0i+7sLiJs+zrDeTH+OzpQR9htFIA1v7fOgk9Ekxmn4W1UukOXj?=
 =?us-ascii?Q?OdzoaHUTeFTMr3AOpCdRuUkAwiUt1wXRGSy8C8P8m2yh737jOT98bwQkP4+K?=
 =?us-ascii?Q?ZJ9VdLBj7T9tmSvqZ5K4bexG+1I3PwJJ6FNkweB6TtBKBVAUZTqD0/GNCfFt?=
 =?us-ascii?Q?tJeWFxPwVE7d4/XPPr0NuxkYW1tJX7tzeOMspcZkOz1KdpUfCmfimrJO2OS2?=
 =?us-ascii?Q?vpNeFi8enV/RgeZHAJiNTU3xTZAFFVgIqmnxiExy2DuXhODkn1cjoxJ9JIyP?=
 =?us-ascii?Q?9IpRP5WZcb/R4dSY66cpA2XexVhhUGjm++33Al38P7caVnVele24N59kEAS+?=
 =?us-ascii?Q?0sm0XJ63rci1o6uxUYRtGba94833MYEWBY8/zlBE2LhMrk9zqyv9DPA36mFX?=
 =?us-ascii?Q?NH7v83kw31Bbnyfbfb1gzLzE0OlKKZR7iw9Q5snJzDiIn43FxpCipXNptrrZ?=
 =?us-ascii?Q?3ynUpRmY39HG2chE3pXdSskksbKJSU18QvCA19J42ivvFDpLFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(7416011)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:24:09.6161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df3d160-d4bb-4cbf-59e8-08dc9177b498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578

From: Ashish Kalra <ashish.kalra@amd.com>

SNP guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second kernel has no idea what memory is converted this way. It only
sees E820_TYPE_RAM.

Accessing shared memory via private mapping will cause unrecoverable RMP
page-faults.

On kexec walk direct mapping and convert all shared memory back to
private. It makes all RAM private again and second kernel may use it
normally. Additionally for SNP guests convert all bss decrypted section
pages back to private.

The conversion occurs in two steps: stopping new conversions and
unsharing all memory. In the case of normal kexec, the stopping of
conversions takes place while scheduling is still functioning. This
allows for waiting until any ongoing conversions are finished. The
second step is carried out when all CPUs except one are inactive and
interrupts are disabled. This prevents any conflicts with code that may
access shared memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c      | 168 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h    |   4 +
 arch/x86/mm/mem_encrypt_amd.c |   2 +
 3 files changed, 174 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 082d61d85dfc..0ce96123b684 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -42,6 +42,8 @@
 #include <asm/apic.h>
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
+#include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -92,6 +94,9 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Last address to be switched to private during kexec */
+static unsigned long kexec_last_addr_to_make_private;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -1010,6 +1015,169 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static bool set_pte_enc(pte_t *kpte, int level, void *va)
+{
+	pte_t new_pte;
+
+	if (pte_none(*kpte))
+		return false;
+
+	/*
+	 * Change the physical page attribute from C=0 to C=1. Flush the
+	 * caches to ensure that data gets accessed with the correct C-bit.
+	 */
+	if (pte_present(*kpte))
+		clflush_cache_range(va, page_level_size(level));
+
+	new_pte = __pte(cc_mkenc(pte_val(*kpte)));
+	set_pte_atomic(kpte, new_pte);
+
+	return true;
+}
+
+static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	/* Check for GHCB for being part of a PMD range. */
+	if ((unsigned long)ghcb >= addr &&
+	    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE))) {
+		/*
+		 * Ensure that the current cpu's GHCB is made private
+		 * at the end of unshared loop so that we continue to use the
+		 * optimized GHCB protocol and not force the switch to
+		 * MSR protocol till the very end.
+		 */
+		pr_debug("setting boot_ghcb to NULL for this cpu ghcb\n");
+		kexec_last_addr_to_make_private = addr;
+		return true;
+	}
+
+	if (!set_pte_enc(pte, level, (void *)addr))
+		return false;
+
+	snp_set_memory_private(addr, pages);
+
+	return true;
+}
+
+static void unshare_all_memory(void)
+{
+	unsigned long addr, end;
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private,
+	 */
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		/*
+		 * pte_none() check is required to skip physical memory holes in direct mapped.
+		 */
+		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			if (!make_pte_private(pte, addr, pages, level)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+		}
+
+		addr += size;
+	}
+	__flush_tlb_all();
+
+}
+
+static void unshare_all_bss_decrypted_memory(void)
+{
+	unsigned long vaddr, vaddr_end;
+	unsigned int level;
+	unsigned int npages;
+	pte_t *pte;
+
+	vaddr = (unsigned long)__start_bss_decrypted;
+	vaddr_end = (unsigned long)__start_bss_decrypted_unused;
+	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
+	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
+		pte = lookup_address(vaddr, &level);
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
+			continue;
+
+		set_pte_enc(pte, level, (void *)vaddr);
+	}
+	vaddr = (unsigned long)__start_bss_decrypted;
+	snp_set_memory_private(vaddr, npages);
+}
+
+/* Stop new private<->shared conversions */
+void snp_kexec_begin(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion())
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+/* Walk direct mapping and convert all shared memory back to private */
+void snp_kexec_finish(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	unshare_all_memory();
+
+	unshare_all_bss_decrypted_memory();
+
+	if (kexec_last_addr_to_make_private) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		/*
+		 * Switch to using the MSR protocol to change this cpu's
+		 * GHCB to private.
+		 * All the per-cpu GHCBs have been switched back to private,
+		 * so can't do any more GHCB calls to the hypervisor beyond
+		 * this point till the kexec kernel starts running.
+		 */
+		boot_ghcb = NULL;
+		sev_cfg.ghcbs_initialized = false;
+
+		pr_debug("boot ghcb 0x%lx\n", kexec_last_addr_to_make_private);
+		pte = lookup_address(kexec_last_addr_to_make_private, &level);
+		size = page_level_size(level);
+		set_pte_enc(pte, level, (void *)kexec_last_addr_to_make_private);
+		snp_set_memory_private(kexec_last_addr_to_make_private, (size / PAGE_SIZE));
+	}
+}
+
 static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
 {
 	int ret;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ac5886ce252e..56e723bc63e2 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -348,6 +348,8 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_update_svsm_ca(void);
+void snp_kexec_finish(void);
+void snp_kexec_begin(void);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -384,6 +386,8 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
+static inline void snp_kexec_finish(void) { }
+static inline void snp_kexec_begin(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 86a476a426c2..9a2cb740772e 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -467,6 +467,8 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
+	x86_platform.guest.enc_kexec_begin	     = snp_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = snp_kexec_finish;
 
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
-- 
2.34.1


