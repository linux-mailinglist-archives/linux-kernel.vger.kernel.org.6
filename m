Return-Path: <linux-kernel+bounces-218332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA990BCB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AC2B23CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286441990DB;
	Mon, 17 Jun 2024 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AOQWKeaj"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398818755F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658945; cv=fail; b=Lzln59aIjyH97gbsye722X5FGinN0F7f8HOhjhOpcMwhrRzrq6K93AT/DE529GBu5fqSS3EbSG/LuzY7NhRRNvSDofD0RAU4I0S22zELu4Z2YPv+eZ2vAPj3h7Z8ykm/PgK4apYiN8ufeW1ftluBiQXjzyo5cBz4lYx9oXO3qt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658945; c=relaxed/simple;
	bh=Ng4UUkisrm3QqLkFFnLGPdyi6j2O25okR20mb6icdKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFXwflVOCKjwwTkAKX3yJg66bmfglAQVu3i+qbZg6oHsTOezgKZZ7gJP2nCklDBsfzQnAgbSWYXObASerhCtb/qMotkUeVWh/O6BHhXE1jmuHbFTq128hFnjut3FuJbUlPkybe72nGYlXTaot0T2UqFhE1iT7tjfThxsNMN9qCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AOQWKeaj; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltrNkDM4LPdMMViwVNsB0q9f8ATybiQ3rAfI8G3XOupMfSkKr9CQZdrvt/1IZcZdWVMR8ROpQnFMGBTK5TL+eiQd1fVHLwEuPDCPRs/Qfm4cHXW6I0kJZg6SchPDluB9c0Q8aqi4F2/S4VNyODB5beSqjBQF8rbDJvUJPCVX9rfAzBKpNyI0bRzE7d0d8/NVV+ixIgblvqtpJ9nptLHw0C1i3+NfCkc3JTpjTNuyOXtiuqlKOiW8NWa36fy8PuM0Hlh+D9sfTccfxPYz6aD7i+lLXtep5iGw2+j22Gp6o/efnuWkrc5cWYnwr3hFEVxau25SC8IqyDXcq/21WSPV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEgXNBFlLKl3atA2H9TNfxPsYr++wdELPbjqpUNOVSM=;
 b=RufOqpGYZwKeAUmFen2U1d7KA7L04x6WE7+Ti/sHRIV4MxAEIrM4dbZGFiEHftWzFBXtGwAWrEsgPD1HB/Vn0cjPqXapEUQIA3n4NbWEwwXCOfE6gRP0weAVpsG/jIPNJVx03EKM5Wp9bmRHpHuio3C+caefaA3LCFOIupTJU0z8nFflo6Is6mOyCNMDtO7W8/AFn7jclg0xKUnoC9iE30743+EPhqLb9L/0pMe3dV3Dqvet3KbhgmtSELt6IDxhMtDozg4z8nu+W2zLBAD4S7dhhkZ75dmphcDPwU/KUcQCj4gIL2ya88EGQ0dGp2qC/TNbu/AO/hDbDQgPf2wteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEgXNBFlLKl3atA2H9TNfxPsYr++wdELPbjqpUNOVSM=;
 b=AOQWKeajuYcKuQoJhxo31k4GUa4jis5fLlDdy+cI0JGuP6lgJOJ/JtKjw1N+m4PJOVQldKrn4piZ8jdf+oQvO9k8QV8vdY5RmXsVequB80NKBshfX6VvEUZcJ6tLsiftgcXgxWg4WC+HGEvCoNk7ciURET8jK2ZP33PLw46/dP8=
Received: from CH2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:610:58::18)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 21:15:39 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::e) by CH2PR20CA0008.outlook.office365.com
 (2603:10b6:610:58::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 21:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 17 Jun 2024 21:15:39 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 16:15:38 -0500
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
Subject: [PATCH v8 2/2] x86/snp: Convert shared memory back to private on kexec
Date: Mon, 17 Jun 2024 21:15:28 +0000
Message-ID: <30054f450a3284fc1057f06f998bab7300ac56ea.1718657194.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718657194.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1718657194.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c3d8de-fb3d-42ff-83a5-08dc8f12a382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G0KYPew7qaCeLsNajVEkzL71edXw10GXn88J6OoFcBaaP/Pd8KBro4stSlj/?=
 =?us-ascii?Q?eySV+ZyMzP0KWVc0fjQB6AdRFfwI83+3aieFGp9FUPtVnh6Tgn1twnSkZ24W?=
 =?us-ascii?Q?X3U3ApU2MaSvzgBD4tDKrzDUVHcZ/AeY2HHdGLfNL4ItaGffyiM0m+8xztT8?=
 =?us-ascii?Q?r8BPdf5UttLPbdWTsbp7Lmn5JEqOO3hGMvGhgY+dAOj3mN4+CQ+VElRcRC0w?=
 =?us-ascii?Q?krI/bk8x6qGgJ1onokZbPnRHWLsgqJFqV/7q/b6bcgJ+f5XlwazRtLWtpgEf?=
 =?us-ascii?Q?eg461e4AOKlTdKRJkYzItCDFW7KSug5g674CgfqwpQ3WBeLhVgOl7wuS9Yt0?=
 =?us-ascii?Q?4QWjd4yJDWSX0tIC3MzrCYlIkWDdeneza0JDJU6jVmgMxcygM+/VspUZ9dAk?=
 =?us-ascii?Q?II1xCqoJH3EsYFFIHVRa3uDaYVI425Ci6SC462lnJKZQo/GDHS9eVyLZooHJ?=
 =?us-ascii?Q?eEMX1ufc3eUKtnt6UcgAguTLcQ3QUrBebV/dY6EYp/b8X9HLsg73tPjTlmmo?=
 =?us-ascii?Q?7Hv02nkrlg/Xoh+RjyJXTH2GyWDqBnNeU4VLncs6VZG0SZVUbbX16YeKVmp0?=
 =?us-ascii?Q?X6teA0NRgmt0xTYYYlwQTNDjTv82euLHVpYMT8YUfC29ItLLhOdEeCEJ2qks?=
 =?us-ascii?Q?qKZRdHgNIs8hrFfSff12iM3NI4oNGz+DywBvCWnmgidCp27e0uQSi6Qxf2Mn?=
 =?us-ascii?Q?FviniURWJrhbFh/oVEMz3H6MYZ18IqWFAYFQEvwQbOeNiC6rGGNgGHZCpTeX?=
 =?us-ascii?Q?lqyl7wQzBk70GdPRYFvp4QUjVIhiFnq2DciTnObYxpXN6kk/hNJrXHgKzsDA?=
 =?us-ascii?Q?w23yGPAVxJ6S0wrc1BUpjgt3wO/Yuz+ZOFXHwZjuaz3EYbt6SHOBwtM1/Uaw?=
 =?us-ascii?Q?ykniq1bVnxriF+APWxcKQe0ZdTVxbqytP21lLWVHTBz2yNq8gf5mAssHyYMq?=
 =?us-ascii?Q?+xP04TJQf5jtiQuO3vjE2kcPmC1zMwNxhAeAIU65e9V3WFSz8444vhN78jo/?=
 =?us-ascii?Q?U//7aRFGbHiULOp3ecNkmzcyi5a45MselbpH1hkMIY/zThSsWhDrnViSRSiY?=
 =?us-ascii?Q?p9eRQ/oKpTlP2dMjuaYDqOzVReGOcpUNwASid/yWoD+dP+nURoUH/ujrwXt9?=
 =?us-ascii?Q?YYr/iJsVhJfVrJUZ3Ucegk9kF2uctH+FFwfk+6QngzUxiLS07APj3pPBOWNK?=
 =?us-ascii?Q?FGBsJjxPy3aSgXscAE4+pv0h9jDry7Z8111QOfm+R8clFELuw1SZMQ9tFpGu?=
 =?us-ascii?Q?JYoCqHfxQtEjtFTHYiLDmi1j6MNaXwHpByux9m5oGNxNMUTWA7DETYnfkwIH?=
 =?us-ascii?Q?/z+naivZ0BdfyZKcAiZKeyq/DvunRKfcxzPryHqfmmqHp1cvRkoZMk4G2tR5?=
 =?us-ascii?Q?SJStt3gjH+xcnCeS2zZHLmlkXAkjQYGz7H+ayezgHKWme6wk8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 21:15:39.4565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c3d8de-fb3d-42ff-83a5-08dc8f12a382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837

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
 arch/x86/kernel/sev.c         | 168 ++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c |   3 +
 3 files changed, 175 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ca20cc4e5826..68c08458bb87 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -229,6 +229,8 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
+void snp_kexec_finish(void);
+void snp_kexec_begin(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -258,6 +260,8 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
+static inline void snp_kexec_finish(void) { }
+static inline void snp_kexec_begin(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3342ed58e168..ff2f385642e2 100644
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
@@ -913,6 +918,169 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
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


