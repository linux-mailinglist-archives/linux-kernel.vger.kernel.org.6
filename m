Return-Path: <linux-kernel+bounces-238351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6A9248A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEAA286692
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C01CE0AC;
	Tue,  2 Jul 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNGuQNj0"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E21CD5D3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950308; cv=fail; b=bNfyMWqJ0KlXeXndvYZ4rMJCYZ7swYeGCyjMilszRKJTviHFt0DF5Hm2agpxlIIHAGlCzl1FppgJx3mYniRXJFI5qCik4EGimxpmqVyXbJAkkEKgaTK7MjiHuAxRh+ionl1MSrCkt/gCEhSKS0Bz9NANM901vKCWdCEq79dHsb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950308; c=relaxed/simple;
	bh=ZBOX3UKir4Rdc8d2vQN/PTjcbzNpxnfAWPfrvQSnZew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAme+roWxvhcPWpdefuNbBXSpG8EEOXTamQEI6NJBTfhpNaBo/CrimMk6/g+Sj6oGVdR34ubEpyGqXK7gbIvCWq6847RpIcOznQSjC9zl5chEtFy7LD/+on5DctcApF6PD1B/CweVuuiSISmiEL3J9y4itKefGSQIGDj+oQRLxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNGuQNj0; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeaWozpk7Gsrnr2v+tiNmQnOSmhbH29dOD5bFhQfxB3y3kEtNC+9NBDuWMAkPM6FUS36XQ5H76wMginRwAcVcC0GcUMGBvAJYDSJz4jgkTcvlffeTfs0uO/PQNQ6EHA46VxjgglxHoHtphWbXa2yQ4qJWV4YmJJeRDh5/kzNYeuswf8EnE3yTB/lC1WvUHBZlPdbWAVTKwVwF/ajJQofTz+Aw4exZtOz55Sej5zOjMR0s1bkEqO9TtHdU4qdk1FbrIlERdn8dk/y60LgjN/82kURxiRNCglZcNj7nimgWseECAC6nk9wsBI0ZQdNvlaxuoEWXJTgGVWEXBqWgh58ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUrI/eeryUy5zoZTv3MfnzBKWWSINPOUUDd3Dpzpvsk=;
 b=JJpHK8ryN1RzTKVl8xo9+IAJwS19CkQ/K6bcIe8VEmv43AGM5U7GzsAnQDLtqVgPaPADO8BENM4A+LTNuzbq1Vk4SstpObHhYaTOlXJ4W5hFD+AMmuwszG8rh+32MzURcaNmkHO8eFGBQ8BtFfYNQDt7zte2wFVjrMYzUKyJBvB+ThyySW9QQOTYFIngUuG82AMpT1hCiyljnBupMzyJy+Khvg76osc+MzrKsK8KwnzPXC8fI5tJO7jMIPBtvUAkFnyw2/8g4Z+9xAp9uGosVkWhdGkWxN6XnQdErDDonwLhuRcUYFvUzV+BVODNumBwFvm5ryUf4JBYL4J5o3aDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUrI/eeryUy5zoZTv3MfnzBKWWSINPOUUDd3Dpzpvsk=;
 b=iNGuQNj0Ufu+LzxHTcYlTek6KqwDQZMG2zPjcZhllSS52Xg4WHkfZ9XeYem7zSIy3CwC6yfwPcOoZtfXMt8IHQBGKtorcyFcm0BDRTBD/VAdjoLKpOhl1NSQWAvGTDcMTmswd+H90XLUTuRvptk3K5wxUK4uvWrp+wYhxThdnVk=
Received: from MN2PR19CA0054.namprd19.prod.outlook.com (2603:10b6:208:19b::31)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Tue, 2 Jul
 2024 19:58:23 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::5) by MN2PR19CA0054.outlook.office365.com
 (2603:10b6:208:19b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Tue, 2 Jul 2024 19:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:58:23 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 14:58:21 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <x86@kernel.org>
CC: <hpa@zytor.com>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <kirill.shutemov@linux.intel.com>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<ardb@kernel.org>, <dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <jroedel@suse.de>
Subject: [PATCH v11 3/3] x86/snp: Convert shared memory back to private on kexec
Date: Tue, 2 Jul 2024 19:58:11 +0000
Message-ID: <ee7d5134e67964bb5c602b5c5d69f5a1decf4597.1719948376.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719948376.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1719948376.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: bad6382a-34fa-4dba-e465-08dc9ad15431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bb+LdSJ4Hezdws8iG507zA7kadUGZqvIYGazRppgxcV+yZbobYEK01KrEqv6?=
 =?us-ascii?Q?idwNqFEWBAJa9HNphPbxUHyQS1S+D7xdhIzw+I34ylY1yy3U+u8tdLD7Zl2d?=
 =?us-ascii?Q?SexIFL+0L/6re7UQSAlth5rZ4QQxm9VZNsSG+A4SBUjh07/4ClqAvjQp2riU?=
 =?us-ascii?Q?Z9amJiVGmZ0MoqS9pfz8b5JnWP0h1UjvMghlghKEP4YjBAHLBhrnqKSU5Etu?=
 =?us-ascii?Q?1wDHWQwSYjCIcvxiJPPrSzSeyW8W2cjrVcmWBzI7rVt6TWBpsAJoUvqUOcMU?=
 =?us-ascii?Q?FmEbn172dt/3GJnsV7qrO2M66FrNK57ECXJ43HXR7LsyexwvrwreuPjKkKtP?=
 =?us-ascii?Q?nl3UHQ2j/gDRA+MXzjI3RiIYRaJcB2RN0uD2606t0k9qGWSCwxSPdtNhM8mw?=
 =?us-ascii?Q?KCnfR436AWRC7w6nznn8eh5wxyC6S0sOh5bqpN8N4UZQzifpIOWt53MKcNNh?=
 =?us-ascii?Q?ljSgYNsSXVHF4JbrpVpt6yLaM1WxGwWTTnp4PXBGkTXE0JE4wPtJwMDCVvWZ?=
 =?us-ascii?Q?aZW0+uEml6bl8LZW2hYoUnodki05Bo6x9rIk5v+StJggQKF//eSPJcrwttYz?=
 =?us-ascii?Q?MMNZgP/OVu56zZtlcvn3u2zA+bpJgcbp48HOnHmBAKqfQs4uboNicQ6SS2cs?=
 =?us-ascii?Q?oh5uP4xmuBVZtU17pC9TAkBwrm2RiErzCtagQCUpuQjg9DiFxB/2nxFZyZE1?=
 =?us-ascii?Q?/cJtL34hBUzorgrCLv1ewBznDRhhTZWTRgDv30XYnrhfmTWvSDmie8Lc0ugE?=
 =?us-ascii?Q?7K/ttbNvAU6UWDClLeKSLAtbAHWPFHMtn0nd4zyn5WVeGk67snZ8fvKgH2Ej?=
 =?us-ascii?Q?hK2xkKQKC1RC5Pq/oj3iAZLeQ+Z5ydKnadFvnZFU+PTKYO+FnXlGE62ZLxEm?=
 =?us-ascii?Q?3nZwdbJ+3CsKXc6LBuXu3D1nYfSPzhKs07pviChbj0ROycPncbc4JNpaj/Qh?=
 =?us-ascii?Q?KK4MMthyc2YFu37uze7Qipwnq9nQTEKgRKL57WhsMF6cWjW5zeZFB9PMgcEa?=
 =?us-ascii?Q?hHyghTJRkzoQide3SrK19I08yXdSRBv7+pddOenP6GI/p5GNHs3Wkdqb3x4x?=
 =?us-ascii?Q?YmpJPzf5iHC/YUpNUmpoLp46tIjlZDOrRFb9tNcgGgaxXSk8G8v/8chrodK9?=
 =?us-ascii?Q?kGEWKpsWltpXosfnYcVW7iqX/LnyP+27LE7jSkJ1yw2u/yIop9o2Q0aw11m1?=
 =?us-ascii?Q?qA7E7EiiWJTOsifXomVmxA77PfmnNYSIsMvwCOGnLQlbO6UpcFHpEOqay3pE?=
 =?us-ascii?Q?nUKay8D/Elhx+1FBTWwz+yBKp6s/9w6zhbr79zKDp1F47FNE4U5rZHgXgt2X?=
 =?us-ascii?Q?GOnkLQPb2rnlBO7uQpHmcmg3y/bKCM/jBPOqD/iY2+Djry/JHIHR1plP8Juj?=
 =?us-ascii?Q?Y66YqdDC3lMVHDMrVtyVabxgYWz5+aJf5tnKszHfwEnsnBsBk8nKyVDarPUd?=
 =?us-ascii?Q?bJ12otEz9ywMm74BKAxECYZw8gjOcFaG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:58:23.0697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad6382a-34fa-4dba-e465-08dc9ad15431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

From: Ashish Kalra <ashish.kalra@amd.com>

SNP guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second, kexec-ed, kernel has no idea what memory is converted this way.
It only sees E820_TYPE_RAM.

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
 arch/x86/coco/sev/core.c      | 148 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h    |   4 +
 arch/x86/mm/mem_encrypt_amd.c |   2 +
 3 files changed, 154 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 082d61d85dfc..0c90a8a74a88 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1010,6 +1010,154 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static void set_pte_enc(pte_t *kpte, int level, void *va)
+{
+	unsigned long pfn;
+	pgprot_t new_prot;
+
+	prep_set_clr_pte_enc(kpte, level, 1, va, &pfn, NULL, NULL, &new_prot);
+	set_pte_enc_mask(kpte, pfn, new_prot);
+}
+
+static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+	int cpu;
+
+	/*
+	 * Ensure that all the per-cpu GHCBs are made private
+	 * at the end of unshared loop so that we continue to use the
+	 * optimized GHCB protocol and not force the switch to
+	 * MSR protocol till the very end.
+	 */
+	for_each_possible_cpu(cpu) {
+		data = per_cpu(runtime_data, cpu);
+		ghcb = &data->ghcb_page;
+		/* Check for GHCB for being part of a PMD range */
+		if ((unsigned long)ghcb >= addr &&
+		    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE)))
+			return true;
+	}
+
+	set_pte_enc(pte, level, (void *)addr);
+	snp_set_memory_private(addr, pages);
+
+	return true;
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
+static void unshare_all_memory(void)
+{
+	unsigned long addr, end;
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private.
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
+		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			if (!make_pte_private(pte, addr, pages, level)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+		}
+		addr += size;
+	}
+
+	unshare_all_bss_decrypted_memory();
+
+	__flush_tlb_all();
+
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
+	struct sev_es_runtime_data *data;
+	unsigned int level, cpu;
+	unsigned long size;
+	struct ghcb *ghcb;
+	pte_t *pte;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	unshare_all_memory();
+
+	/*
+	 * Switch to using the MSR protocol to change per-cpu
+	 * GHCBs to private.
+	 * All the per-cpu GHCBs have been switched back to private,
+	 * so can't do any more GHCB calls to the hypervisor beyond
+	 * this point till the kexec kernel starts running.
+	 */
+	boot_ghcb = NULL;
+	sev_cfg.ghcbs_initialized = false;
+
+	for_each_possible_cpu(cpu) {
+		data = per_cpu(runtime_data, cpu);
+		ghcb = &data->ghcb_page;
+		pte = lookup_address((unsigned long)ghcb, &level);
+		size = page_level_size(level);
+		set_pte_enc(pte, level, (void *)ghcb);
+		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
+	}
+}
+
 static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
 {
 	int ret;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4f3fd913aadb..4f1a6d1e3f4c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -352,6 +352,8 @@ int prep_set_clr_pte_enc(pte_t *kpte, int level, int enc, void *va,
 			 unsigned long *ret_pfn, unsigned long *ret_pa,
 			 unsigned long *ret_size, pgprot_t *ret_new_prot);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
+void snp_kexec_finish(void);
+void snp_kexec_begin(void);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -393,6 +395,8 @@ prep_set_clr_pte_enc(pte_t *kpte, int level, int enc, void *va,
 		     unsigned long *ret_pfn, unsigned long *ret_pa,
 		     unsigned long *ret_size, pgprot_t *ret_new_prot) { }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
+static inline void snp_kexec_finish(void) { }
+static inline void snp_kexec_begin(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 42a35040aaf9..dec24bb08b09 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -498,6 +498,8 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
+	x86_platform.guest.enc_kexec_begin	     = snp_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = snp_kexec_finish;
 
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
-- 
2.34.1


