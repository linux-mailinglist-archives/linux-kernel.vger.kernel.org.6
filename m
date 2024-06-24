Return-Path: <linux-kernel+bounces-227775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D059991566F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D37281863
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAC1A00FD;
	Mon, 24 Jun 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/Dq984T"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AB19FA92
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253336; cv=fail; b=YQNi1JK0G9h0kTlgCSsC8xkTMQeeO7jM6Gul7C4K/oREENYAXU+IGpz4dLBftCJK+9jcC4Wrssu5P73+7SntR803y6qgQ+Pmw7rOs21eDduMXVW6o74KWnKfMHVcWlr0kJcUJHjBlHYuBJ7lcrSnC7lBeepeQe/yME4NQ15ckeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253336; c=relaxed/simple;
	bh=DdIX2YBCNl2k+4jEnh5F5wAl/EcUFwK74kjZeS+p6iM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqUmFJ9bS3PfXPtiMVJzm0cbB5VmehMa3R3wDY32GaXCq/LcqrB1O7hWH9ZptTLEL582DqZ0uwgcMaVtN11JvLA2cMRY7KRLcxXLVj7arnp/arpXMp5H3ZbsbwgiiAaCR1aHqRUp/z8aO9CXXtZyIpa1AGch++332UrUy2hLs3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/Dq984T; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg/MI1oaA2+Zco5CPbrXUmkResIax/9WORwAuDkjnBuXSIhyOwrHsHaqMhKqLzid2/MnQd2twTrfhAW1YozSgR5y1L/YfBl/z6vrUsSxyv1ChGfOhrpw9JrAlikfD7HsSQzsobdKerBgSQsLpEqm8C5I5du59F1Qc32jtZ5BvRNao2HBiOpEpYxig5tfhtfOfum7W27a2a0wy4chy3h74ozUcBpklr/kzBgOua6xYEP7ukkadwC1K/9QvNZ6fuucmT345kC2Qb+BNewnEc9CTPZqyHvvf9dfBP6LSwUnKU9DMcqfpPhmvGzFliTq/5Z6jLqx8ZMCgOBjOAGS6h2hEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+ybRi0afqpQoZ2IU3HxHf1AlVwjluzelxF7du9a8bI=;
 b=USMEZydwU/vytOC0rDlgM1Qt1VjnYa+CFyHP5Z4vtOpYLzz+0r7E8XjlSYZ8xO6PU/8nMo2/x9cGOJbilFnVVTfjjgzW6Azivo4r43odF/BJlIFgCOKbSUeJ1sgFZQmVl55/nb2296Bty8pNv1gRkgOLPXz3ihjl1nY5mm4kOfieeYGLksT5Rd9dULla9uZFvw+2WKprATUKDcu0m3W/VbUJ8ndM/4etMLEyzTZuYU+MEs1YGuXtqN9NUCrN3kjxsRZ2M7zj3wQ7NHxTTvlMlm/unldFR0BFf2Wkj9JEJsu6XhtQh6QdjD1f1+weAK3e7pWbLQzJHN0LyAbtrEpijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+ybRi0afqpQoZ2IU3HxHf1AlVwjluzelxF7du9a8bI=;
 b=s/Dq984TXdCZTZbV21KlzGciXKMUPAtQhWI14Qqnd97sJ/v5/EJ1emKqL67gJhSsAAgWhbFIP+hKi2XQ4Ra4LqN1IGi4UxqTAPzR0O3i1afhQ6E/IWFRrwzUrLmOSWq1ocYhJPPfjkkNyPZu8Gl2ddktmVEAaw83SDSiAiZBhnA=
Received: from SN7PR04CA0222.namprd04.prod.outlook.com (2603:10b6:806:127::17)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 18:22:11 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::b3) by SN7PR04CA0222.outlook.office365.com
 (2603:10b6:806:127::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 18:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 18:22:10 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 13:22:09 -0500
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
Subject: [PATCH v10 2/2] Subject: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on  kexec
Date: Mon, 24 Jun 2024 18:22:00 +0000
Message-ID: <e7edcf74748e05c51aad6320eae3150e3c024c3c.1719251730.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719251730.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1719251730.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdbb549-561b-4a73-6d2a-08dc947a9005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOn6zHRSH/Nn8R0NuH8uWhRQheuiqjdsADjX1ivsiAqFimCfp9i+K58OgS08?=
 =?us-ascii?Q?uzDxqmEK2FM9NtjlIcvgj3uyea8vXirWgirKo83r7bxxbS1Pp44Mc6dMMAmn?=
 =?us-ascii?Q?oik6CGcurPCVZMhN12lnDPiJdm0DPVLzKkG7srjF+QXqvQa3yaRVeuFK7Brc?=
 =?us-ascii?Q?k7XnE7fI1yHwRc11mmcAFhGQhGapn8FAke4R3TQQ0q9MfPyvkWakWexxeKSx?=
 =?us-ascii?Q?m0/SrNPiUGaOfr2TH1KgOVuC5fCpo35Al5PYQawpkL0q9aKIilQAh1XeeI6c?=
 =?us-ascii?Q?z3Tb3YpgFpUEEE7dhTz6hdwLVHan87UgyUcTtdWxj9VvhIPlphTuZp1Zv6Z0?=
 =?us-ascii?Q?03Xt2lvnDmpitjzrrO/CH5fnyj2rZq010GuVjZzgtqSB3eXIkw0Cy1YcxDzy?=
 =?us-ascii?Q?DAdNXELsdFq90qXvDXJYpb/FpU0oVnVYWtZvMQNWnzj3M311a1DW91rhIBOH?=
 =?us-ascii?Q?UlKJYyyW248NkvR0AZLpgQ2QJWCt/pa2LklKeU24z3jZFIKIy/kFKZP3CHwq?=
 =?us-ascii?Q?ti0n8eZbjCJUjdjUT/9ZCV5uNzKP2tm4q1i2+bm64n/SxN9V+kDUUFxZFqCD?=
 =?us-ascii?Q?EKFDk7ISzglKyhqT1WIKw6MjcPMDHrnjRjRvwmRuN2sxYrxzO43VhhlJaxEW?=
 =?us-ascii?Q?UWY3At1NmpGABD9QJorTglCfdpAjeYvys5fUMUSJF5ilwdlDR6srkJQ8Fk+/?=
 =?us-ascii?Q?h69tDabJLGkH/drCZcqQfNBzjiyeoS7l7jmH8kiEOWKvVhJ0AerixqHfRDMe?=
 =?us-ascii?Q?oRYTEPEIrj62JLLzI3/BlsvOPdInTVtNGt+2PLOhiqiVT4DOChAfODCaAl2s?=
 =?us-ascii?Q?Nyu5aKMzpeQ4ijL0evGc49oCzlXxW6K+B83bgF4y6Oqs9dqmn6zB8Kps0Ss3?=
 =?us-ascii?Q?toMw4OjBBZ4aXV1WGgviKjsrrgOw3BvI83JZl6IwIY3l/LBU4tQrvCUNn+Ly?=
 =?us-ascii?Q?o23KSi2bOcnHwNupz5cXESTw7NXbI8VEwkWFh4XYDnE9AAoJ7/P3jyCh1hKs?=
 =?us-ascii?Q?qfbwWFe7FSW5ojIVbglbCC+H6vmybJ3x5ygFKf1fcA54hsv2qczfTk3Jucni?=
 =?us-ascii?Q?QVVVkxBjVdgMjR94j1rsMavyjVUFjxTeWYarg0Z/mc9aGXeYpgyMf/6zqsHs?=
 =?us-ascii?Q?TducJoeE06Kj7QtLtpZ99xb86nxEXBnpJHVq9H/AzwbVlhRZ0Y4Z/2/9iPft?=
 =?us-ascii?Q?0Nlo7GgWHo29bl/YBGga8mEoDFFrLkJP71qXVPTFkxov6k1Dhg99FCAbHxK/?=
 =?us-ascii?Q?mUhCT+oW189YhGams5lSOrX1BrO/uiGdbTrMA5Ds8m/0PL36EE+jeG+Jashb?=
 =?us-ascii?Q?aZxqJrO33FrqBiNGW46THFJxtfS7EfELEzwiU+3npkRKIg6YfbVELnyDFoPe?=
 =?us-ascii?Q?BBj3/b3CSpazst73tXk9jv4/Rq9vR6Rw2cTRi98xMY1u5Z7lLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:22:10.2338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdbb549-561b-4a73-6d2a-08dc947a9005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308

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

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c      | 166 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h    |   4 +
 arch/x86/mm/mem_encrypt_amd.c |   2 +
 3 files changed, 172 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 082d61d85dfc..9b405237f2c5 100644
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
@@ -1010,6 +1015,167 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
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


