Return-Path: <linux-kernel+bounces-268112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE2694207D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812DDB24584
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A718C91D;
	Tue, 30 Jul 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HRX7nKi/"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE63FE4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367353; cv=fail; b=KkcpJ5LJGcwOM36eYLavxyFPdkCO6sVENHho3G5CW78PWKCdW6epBDlBKdTo548h3ZZvxj+RnJXjG0NImH5kpTzttUeEem8BGvWsoUqq4z60t6WpThALJVWFx3h+sTR8hYjyrghGdxYszhVKjJOEEjyTyNGpkw0T15Wv/MnD7as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367353; c=relaxed/simple;
	bh=wLQ6a1yjenJ+2KEXHP824d8g90OGDbX3X4U4rDfz9N4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKLnj+DwWbBBBZ7Ocur7Kk6+zqtGPU1nDhPvHrD+jNgTxQYLgAN/Z/GYdqJQdME12WlNU2o/FomVA/vphoekjBX/O9geppA/B6vAeCqQEYunzxGJs7+oaHv5P5eKTgs9Ax8nFUUU1MO1OKk5orxQkfVsdcUyxxTwVNE7d4P2d3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HRX7nKi/; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC01MxrCPjc+EqX9BP3cr6uHFNBhwXxwsPGoRu+R+aMS9FmASoT+7+BeYVR6U2fuHXQJ6ox9/4kz5sZPHb12wwdOI5tLAdtSExceDqRJtOjMTSh5QIYw3HLjqOC+uLoo+759yn3WRxvrogD1mBkEWnWbGE2r84PY1dVdnFn31oy+n+A2qyKA6+57QBIyLTNjpIN+WdBWI7s0Tidj+IWPC1QX/n2rVcONV3uNla30drEoAJD7iQW26td0DsYjPKHn/27xK57BGqexNYw401qIU9ncIo29VdrhFx9h48/f02OwU7KIEqIMJAYCVl12tVkJGUx3Lbb1vc2991YZgbWr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvr2QnaUEFaV5M2ehV04+cQNlQn4ROHGv+rAF/XbKyg=;
 b=ao/xt4+TiQfor11r47sUeZgHcXFXsEmcFuAV1cjMN7/3iyjAxyOVgjZ2IGDW33K271GfORypk3p94i57vAv5R+rxzhU3DzMJcf/cFZjfcOLoko22ftScCdT15iaWoGVoRlucRz3wyXIeRGtTigdjBrYFbcWPXOe7ZC5xQbvd0FjyPPxsMlPsVaWbCHFpXT+JmZw50CifD5cqSYm9W9zGTf6ahdtfOkf+e7xXGYxHOBZM5jpSIQKhoIg/wih44owgsVtU1DSBT0yqt6Cvvvq6lDheRTf9w6OZzxoePXpStxoi2sJLjQWVZ7L375tgdmh7K1vcGh8L5gaG0r+KrVDr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvr2QnaUEFaV5M2ehV04+cQNlQn4ROHGv+rAF/XbKyg=;
 b=HRX7nKi/ZwmpzWmSNbUJJJp4dIMcuzQy/EuIyExV7hhchEzUHb7QMyXkPJs60CrmtuebevYmpm4GnjDaDoCwSwqRnHdtih4GcUQ8TUmc8n3ZF/Csk3qMKlbhzAFbeUfZasVMhRKHW6GMwFdxQ8rioii44GNaT+PDGZNLZjrY0Gk=
Received: from BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::30)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Tue, 30 Jul
 2024 19:22:17 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::df) by BN9P222CA0025.outlook.office365.com
 (2603:10b6:408:10c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 19:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:22:16 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:22:15 -0500
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
Subject: [PATCH v12 3/3] x86/snp: Convert shared memory back to private on kexec
Date: Tue, 30 Jul 2024 19:22:06 +0000
Message-ID: <aecbf9d9fe183d4819f4c9a80bb28bf8a34bc113.1722366144.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722366144.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1722366144.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ed94a1-e58c-45bf-a060-08dcb0ccec57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnAW9Lsda2/6ul4PcuIGxivQ5htgM8/qvN7AIUzyYAx4PKtnJdYwOD4b929o?=
 =?us-ascii?Q?/RUsPUon6AyhRhbWGjgWc0wJLQ5RqP1apwTDRaAAjNWqYcn7r5S0M+cbxN4R?=
 =?us-ascii?Q?ylSoGAqYDsVm13G2jYEhH6EXyu2XD82YH1RiOj2tsr71CAjGHazSBoXeEYGF?=
 =?us-ascii?Q?L9Omh8o6GB+1EOOy147hl74EdadTF3LOf4qYa0a/cQYnqY7WA9Vu9pYDYQ8u?=
 =?us-ascii?Q?VA1BnstPKJ4Bn558phkT9BfWgRALkP/PH77CGLQDk0Ek1BUdYtJoAHsDXR3D?=
 =?us-ascii?Q?3E7Fg6Hk8QlAKilSNJlHO2Gr+OpVAeCPpaM3MA4nPvJhARCeTDWqNOhNHfVv?=
 =?us-ascii?Q?5Ey992wRrjgUB1uKfjn9nbSpS3KFJVwcl5JZBGOZ9vyUQOQxkH0dgZkvkN+n?=
 =?us-ascii?Q?4DJcUVwPLtGF6k7IAEOyyWHnSrIQDoQbheKJO/W0U34p2qgG0WVZlehb5DAU?=
 =?us-ascii?Q?0I8SFtjxtcT6CBIuzBd0TDqRyHeoGiG7V/nXityVDeAeyshTlcc9bVFQ7Mwh?=
 =?us-ascii?Q?KRTwJHjPo0OInkdKAgkmyhmddbHLTRqUDPUblvA7OLpG4aVBgiSGOdC+WeeU?=
 =?us-ascii?Q?En5uy2mhH9Kr72heCkDXYSR4m1k5rHdZA80/BZ31m3L+oZ7D8UtQ/3ahWWuI?=
 =?us-ascii?Q?wk/6c2SPWQ1UxtQPrwVHihmLwhFcmBURB5eOQGeM6KPxc0e5O9GK4/C6Si3D?=
 =?us-ascii?Q?uhf2+Dgn3rpB+8YMq0NcM+I4B7UtWaxp8eRo1kbAVinRkGm0ZoA3h9YMsDi3?=
 =?us-ascii?Q?VwvIu+EOF3Nt6vY4Pwxip8kjxvNmIz0a7eiNmzsmmX6TJUAYf9kmS39hgEsg?=
 =?us-ascii?Q?9mZKpmqw8zGNxuPuQPv4q/PdB1T7BMNyYJbuhU+cVefDL4a9mfrIpdCZC3ri?=
 =?us-ascii?Q?ZZpe43IcXDlN9bCm49O6ILJUa+oeEggZzyUp8/wE+iIc3Pmn7O4QbiKuBwHZ?=
 =?us-ascii?Q?iL/GICHMkGOlwTQvrAqgnvVjN1T/W3sSec28b+nR5lzOAAXQvBSNBO75gZXf?=
 =?us-ascii?Q?UHTy7K1i7yArMcic86qX5CXp/orNo5B1lsadKURXVfJSdKGKRhnQxAh8s+UV?=
 =?us-ascii?Q?f97NgUW0YU9rsNg8wG80rS2j9L6T8krEFDI07J8+j38nBvZiP0LQgklTtwpq?=
 =?us-ascii?Q?Wi42imWVI/u6kI2rTwP3V3JRkEq0yC3iA409AyuVGD0/RVVweLBZ5xoQpmWL?=
 =?us-ascii?Q?4c5boOtUv8kJrL/bP4VRCk4MTjMaf7TDGIu7z3kEddszZT7h/7yVmEZyZIz9?=
 =?us-ascii?Q?6no/L+yxmAkAnjvpFESaj55nOVVi7e8kskXQMveu6WlegCbWk/RTsEaLRaIT?=
 =?us-ascii?Q?eLxG12ZwpG707R7eKmKcChiyaSuf2LqskhmJhZ298/6CZAqCRUIJtRKoxNhZ?=
 =?us-ascii?Q?0RwaWwEqIJd0zHEQUg6NK0k630HVGskqwXRaUKchOnaAfzyGSNC3gG7UI8OU?=
 =?us-ascii?Q?NgtR1LMTrg38jPh0YvHAk/JXaY8xigpW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:22:16.4125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ed94a1-e58c-45bf-a060-08dcb0ccec57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659

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

Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c      | 132 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h    |   4 ++
 arch/x86/mm/mem_encrypt_amd.c |   2 +
 3 files changed, 138 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index de1df0cb45da..4278cdbee3a5 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1010,6 +1010,138 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static void set_pte_enc(pte_t *kpte, int level, void *va)
+{
+	struct pte_enc_desc d = {
+		.kpte	   = kpte,
+		.pte_level = level,
+		.va	   = va,
+		.encrypt   = true
+	};
+
+	prepare_pte_enc(&d);
+	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
+}
+
+static void unshare_all_memory(void)
+{
+	unsigned long addr, end, size, ghcb;
+	struct sev_es_runtime_data *data;
+	unsigned int npages, level;
+	bool skipped_addr;
+	pte_t *pte;
+	int cpu;
+
+	/* Unshare the direct mapping. */
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+		npages = size / PAGE_SIZE;
+		skipped_addr = false;
+
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte)) {
+			addr += size;
+			continue;
+		}
+
+		/*
+		 * Ensure that all the per-cpu GHCBs are made private at the
+		 * end of unsharing loop so that the switch to the slower MSR
+		 * protocol happens last.
+		 */
+		for_each_possible_cpu(cpu) {
+			data = per_cpu(runtime_data, cpu);
+			ghcb = (unsigned long)&data->ghcb_page;
+
+			if (addr <= ghcb && ghcb <= addr + size) {
+				skipped_addr = true;
+				break;
+			}
+		}
+
+		if (!skipped_addr) {
+			set_pte_enc(pte, level, (void *)addr);
+			snp_set_memory_private(addr, npages);
+		}
+		addr += size;
+	}
+
+	/* Unshare all bss decrypted memory. */
+	addr = (unsigned long)__start_bss_decrypted;
+	end  = (unsigned long)__start_bss_decrypted_unused;
+	npages = (end - addr) >> PAGE_SHIFT;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		pte = lookup_address(addr, &level);
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
+			continue;
+
+		set_pte_enc(pte, level, (void *)addr);
+	}
+	addr = (unsigned long)__start_bss_decrypted;
+	snp_set_memory_private(addr, npages);
+
+	__flush_tlb_all();
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
+
+	/*
+	 * Crash kernel ends up here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion())
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
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
index fd19a8f413d0..4876ab4c7043 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -417,6 +417,8 @@ void sev_show_status(void);
 void snp_update_svsm_ca(void);
 int prepare_pte_enc(struct pte_enc_desc *d);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
+void snp_kexec_finish(void);
+void snp_kexec_begin(void);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -455,6 +457,8 @@ static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
 static inline int prepare_pte_enc(struct pte_enc_desc *d) { }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
+static inline void snp_kexec_finish(void) { }
+static inline void snp_kexec_begin(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index f4be81db72ee..774f9677458f 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -490,6 +490,8 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
+	x86_platform.guest.enc_kexec_begin	     = snp_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = snp_kexec_finish;
 
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
-- 
2.34.1


