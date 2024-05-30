Return-Path: <linux-kernel+bounces-196038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94158D5655
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8361C24C84
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE417C7B7;
	Thu, 30 May 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SA6vO5Sv"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7671761AF
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112277; cv=fail; b=UjeIHoxtrLDP3mA7jRyNvTj4IFjHX2ktmULESbYzpEBRp9hmpqDD1yoA6SVU5ipZdnpn5QoLHBKH79UgeDivm0diP2Y5S9EVJ80kl2mw0EjYzw3pKH6ZxjQipshy7tXp+6Rnci6Cpi8IvfA0h4kEB2HTH43izElqmQaJBtSggMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112277; c=relaxed/simple;
	bh=Glq3U4+VhK6UxVG78jJZ620JMHAa7DubHY4fpq7ULtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiF5mEP/NpbvONgRZR6uDpkBQh4Qfhh/4PbH1WG2VF5NR4wedCDLZAQlG/NbTXwSYH6Otgx07/9tljzdx74kzRg6kAV54//bqra+GZa9g7TdWqg15GhBdSXPMCBu6IApj86sgrdeBsdb8oO913NK0KaHMZ2JO73j1e2F2+u4i6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SA6vO5Sv; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ+OhhZprwa7Mq0gDfq7ntgMYUBoEnyD5aBarRqz+++KiVUun9FEknTgpw4C/1L7vLQF58gUQLF0u7a49GRWtd/hJnX0pSmLVkPOK7AzsD6Dpzm/VCTQS7lP45S1ZFOqxAN0nla3A1hxj6U8rDU6yPR8C67IXQmXopp4xZLfFGfF25Xz/MrEq924123f+MLwzjgkvOKs8tIhmXiorj3v6v+LPaGPsSphbSzPme7p/O0pmTfqcE2r/wrWeYRin5xO3stVp65zYfkqjOAZL1gVhtopdG7c3ucPi6jthxMs8wtppzCxYRS/Nxsi1k+zuS5EuIcJAtv3SQQir1ggAlyO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su8iHGvdi2wP63JHxc+soe1j+7vmL6Et7j0y2xaV5xc=;
 b=a6FikYjfkw3AegPX6QQ2N23hXTgZDMOwmMjEwAgNvFMkoegfCJ1yE7ngR7Kxr71R5LZYQM8WSWIt4VtARR6uPJQfaqoHFsXm0VTHXd02FU+ItwxTFFx50CezZ3/CQVjaF5XGKQP1AVdBu33wgPrX5xkXMITlEqvrGdUH0/HuCtgjca09GSITh8jWtH4nUrQoHgWbMYhmiztSPwwubd7Ge65vx9p9nZcaia3fTUDGnFH+M7AOV4v7ifBqc8mPeVLD26FUTur4Y2AvUEIVs/VE7w95HHPnX9CC/gXeTAvSnYsRPvtfTWynzYMGW2vZxhhB6hcJz/HSwXjiq687609T0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su8iHGvdi2wP63JHxc+soe1j+7vmL6Et7j0y2xaV5xc=;
 b=SA6vO5SvOxeZd8SAi3yrR7v4z0iGTDIVnh8z0VhJo65ZLWlMOlQczujpQ9JPmHQJJTM+b75ip7V1I34T7dkynzHR+T6EmjI4e0mWdAAfu9D0ML8GEf8VkbjGO7qCFPM7JJ3rc+9hCUbUBthqnLf+o73zjyrlBX+8lvH+xIyOsO8=
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 23:37:52 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::16) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 30 May 2024 23:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 23:37:51 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 18:37:46 -0500
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
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/3] x86/snp: Convert shared memory back to private on kexec
Date: Thu, 30 May 2024 23:37:34 +0000
Message-ID: <14385051d096edc153dc2b7016c75296ebfde7ed.1717111180.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717111180.git.ashish.kalra@amd.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com> <cover.1717111180.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dd8334-0fa2-4d8c-cdc1-08dc810185ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQ5/G1aA2Dv9Ipml2hFeeQQAQ62aCecEwK5a8oABQYVt1mwGbX/3mPk1l/q4?=
 =?us-ascii?Q?xo7dWSrcDX4WKzcml8LzWKeg9h/OAwtM0V9knkFBgcQgzfPu3fW2+JHPYXxy?=
 =?us-ascii?Q?1oELs3GrnKQI2fcW6/dniBd7TqHACqByAuos2fb/wrlYodZP+EcDJx2UA6m0?=
 =?us-ascii?Q?vdJTC1Aw9RNEvtdZKJUObBHQ47cqpxvIllpOol6ZDnLKirrIy0FMc3bkQlrV?=
 =?us-ascii?Q?SsSPFMCWGO9vjVjNXX8vfMRf+6t8RaebF/iJuAWEVECjWNKuwrSsoPXLukYc?=
 =?us-ascii?Q?gfPZfrDbQYfuxvGCS5Kfy9JCxMZcJhdWflVlOArjfAuriCDcQwyUbU11mQqM?=
 =?us-ascii?Q?+oUsTmgPVvKjILg3YeqTcqrBWPzJsRaW3lw4LheQgg76vNU+Xq32mTqvMH0R?=
 =?us-ascii?Q?rqXVc6XqZLsfppruisOQdok8poOC3AU3luP6B9Z2M5Qsvac9kRjnFsZnyUaO?=
 =?us-ascii?Q?O9ZlTFkfEBLGgyZ9UtxSNmPhdH9lDfcB7SwaxkcvTMeX7ohSYEZOkH2auhj0?=
 =?us-ascii?Q?nsXdA/FWRRotzQsyNldD3HfOSwExutdgxOgiEH+SUIIbeGFEMapNHpm0ciLA?=
 =?us-ascii?Q?1Dx+MeA6DIvcvlAe0SckypbvoaZ8vj64ntOhRfGjalstA7YatDMxImerAQ9W?=
 =?us-ascii?Q?wGFTULB6NL7nA7a2BG3qQUC9tAKeT28etQVc3ztPnA+MYTnKxtNUknc519qZ?=
 =?us-ascii?Q?UzwkqeQ4y+Zutoo02BcTngxYeZfrpCz0KDtRkr7B8lEoIizsYzroJ1SzSRZM?=
 =?us-ascii?Q?kUPUI0Y8ySw+j8GpPUxSGyTNn+lLhiRF1yaTkjqoPEdVBij98FmYDH7NVVeG?=
 =?us-ascii?Q?VTJgmzrD6hZVEkpGzsM6M7N0Ox4kQhSEBOwP9fCRRKFVZMfT/FjVCORkVPpb?=
 =?us-ascii?Q?ZZqfaky2IKdnkX1Dgqt85walMGbIf2pWeb3m4nJW/OcI655/4y7Ws3lPIi+I?=
 =?us-ascii?Q?4MjMNoRNhr4wd7qem0RUrOGONFvkiwQC3H7NYZI1zitU++4h0oeBAwO0nVsI?=
 =?us-ascii?Q?r8zyhdMcgi6FiniqijlvOmrDm3wMcZ9xVDwwNsfmTwEG5PA8XVevQ6NHBBe7?=
 =?us-ascii?Q?/J4pVxbMirR0DeXHtUoUP/a7Db+zj0RhBmqNLQuVdZ84/EGGrPHSYojpoGbv?=
 =?us-ascii?Q?9q2W65n+9gUBsnKaEHowC92RzKYo+gyggcSJ4vHfoZuKDFQpWVExH4BXxcpQ?=
 =?us-ascii?Q?W21g5eOovqP2bQzfcbekGe7/tqYw71/ZIPDzKBk9n83JP2hOO8kp7FXPXkAE?=
 =?us-ascii?Q?5Z8JhBBbAY2vFh4t72APuAM+RoF6ddYTFBVh5Z58zSCiuExnHH+YuUvNZ33w?=
 =?us-ascii?Q?zAe9rQXX2isytymJ39iK6POAHPRb8ptkyBG5pfR+n9kYpK+LCKf+r9WIhcFb?=
 =?us-ascii?Q?a9AnfQM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:37:51.6384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dd8334-0fa2-4d8c-cdc1-08dc810185ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

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
 arch/x86/include/asm/sev.h    |   4 +
 arch/x86/kernel/sev.c         | 162 ++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c |   3 +
 3 files changed, 169 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ca20cc4e5826..f9b0a4eb1980 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -229,6 +229,8 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
+void snp_kexec_finish(void);
+void snp_kexec_begin(bool crash);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -258,6 +260,8 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
+static inline void snp_kexec_finish(void) { }
+static inline void snp_kexec_begin(bool crash) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3342ed58e168..941f3996a9b6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
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
@@ -913,6 +918,163 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
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
+void snp_kexec_begin(bool crash)
+{
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	bool wait_for_lock = !crash;
+
+	if (!set_memory_enc_stop_conversion(wait_for_lock))
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+/* Walk direct mapping and convert all shared memory back to private */
+void snp_kexec_finish(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
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
 static int snp_set_vmsa(void *va, bool vmsa)
 {
 	u64 attrs;
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e7b67519ddb5..3ba792cd28ef 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -468,6 +468,9 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
 
+	x86_platform.guest.enc_kexec_begin	     = snp_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = snp_kexec_finish;
+
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
 	 * parallel bringup low level code. That raises #VC which cannot be
-- 
2.34.1


