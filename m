Return-Path: <linux-kernel+bounces-271780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5EE945327
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D1FB22BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9614A4D2;
	Thu,  1 Aug 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FJcyaaSj"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D7182D8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539659; cv=fail; b=L1Lcp/MvMQ+5f2Bo+Zvy9FQF+C/R43laKIQmrLhr8Jo3KTBEppLvwT5O7+R8205/A/Cc9P1nn9GnbHLYQCd7IstYojMzBlnveb35FK2oM3wB1AZOcTAoSa7foo/tKQ7Mq5joCJ1U/X8jBOpSyjpipMYs4GOaSgfGWN72AAlFn6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539659; c=relaxed/simple;
	bh=q4ZIFkHwBfp5Kr5CgvKsvD+p4iGR25pBRmOCEJPw6qU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF90IX+Oc0whLt0hepvzxplZDoAubrTsMnVQcQec8bGZfTjMoQc3WYcMMlpf60TwA+s/tmiGUUW/Jg5GIY0Dk/j8cSnSbYQZaiAxWzM1xZRlSCCeWNwZFQhqdVJxIDv5gpI01LlWnabzZzgdcag+famVGIoC8yQGk89sZKd2FxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FJcyaaSj; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mP58zo+vCkUiu/PAcfzmeFPQ+H9Xr4SaJRLHgvCmxqCAsV/8LbMG7JkI7wtFA4vdQZBEzfXpQFkzTjWrcyL842kuVNWVn/nWoQ1wlLLtbnpfrWSZZY/Qo1K5YUVbyeUV8lJXTvlaS4AXJ4vg8eCmoN3iXq0XdDhOygovI7GOj8pMzUAUbqJa80f8jCzLNq4AoXbOesWiqC14H/CZWf5c15MgwRbM+ziqA4P7BVY2VaJle3ME+q5hMu2EKQp0v55Dh64bqEN7+IV9A+EsdcV+NPfELzWQlOg6hbFoA/EVwVs8DrgJllZJirMQBhstR8EN+MMYZ4ESWEJTFjKKMxZ0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/IilyDAUYSpNwjmgrhce55byiCwjpuMNC8aDc2SUb4=;
 b=vCzX1Y+7NcF4VO+z8rNDB9L+dNh5hVPNyPy4+9kAg+dYEzsooxaaeCISD+MyflB1ABfIvr3MaUmql5NUhyU1GLcAyenzUx+cX/kTWj1mMVgfai2Tz5RAgOM2uXDivUse3FI+RdxvmpHMIwvrPyLupSODnJXIGg8Bq/RS9sSWHjiFHpLVyrr5oQUXCjyI91uQpFr0ZKIktc7uehS5ko1knr06y9/mYPfv80TftklH+xt1AkhbsVvwDusw2uBt0lcP+OEQAtCqdejI946KnioR9E60vXpaYpQ4bwdKUnFs9PdThFt2HvMy3lUa80Y61mAVUtkxZ+gTkZBqoKQKBOkT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/IilyDAUYSpNwjmgrhce55byiCwjpuMNC8aDc2SUb4=;
 b=FJcyaaSjaxCl3ZRGvrt2XGboSb5+dK0MCBO2G/vwaeyDxuUo8zTyxfaNLw5k3C0VWu0XC5KB+SlCGtcEy9XO3x5UAEqVTlRrE67+sTMSb+2GVjxpI0ZON/IECinlNW3ggsWs1l2ezZAnQhPI2Oac/lzPvL46jdTvQ6JBNbBNxlc=
Received: from BYAPR11CA0047.namprd11.prod.outlook.com (2603:10b6:a03:80::24)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Thu, 1 Aug
 2024 19:14:14 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::36) by BYAPR11CA0047.outlook.office365.com
 (2603:10b6:a03:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Thu, 1 Aug 2024 19:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 19:14:14 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 14:14:12 -0500
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
Subject: [PATCH v13 0/3] x86/snp: Add kexec support
Date: Thu, 1 Aug 2024 19:14:02 +0000
Message-ID: <cover.1722520012.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 77534902-b1f8-46e7-7453-08dcb25e21c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j0MUM7+W4J5HBAKKxq9BS/iRNJlZRKsx4zZ93ZrqSRvgHBL4zKnWZcS6JYFt?=
 =?us-ascii?Q?w25MYTa/LuNyZ+zVX3K/Y77MCvgWNZYxN2flAFXMDRncN/0vrKUohXqd+aRQ?=
 =?us-ascii?Q?SDAOI6cZ36aDU4byCX2F3Cfoy0M3c1l47/PLbPUcJl1Cg9nsAEUqepmFx6wc?=
 =?us-ascii?Q?JXvHJHqEdMOINRRrsNT4Muph6o+kqztPro2f0nGotBXqAPcAwHRO5B8sbXTN?=
 =?us-ascii?Q?6x1OB267LdpY4SaLOqU8WRT177dFTafgQG8SuIyqr+JRBIcG1wnE1zwgwwOV?=
 =?us-ascii?Q?ZYFoBubz4CZD8lc231cxHBoNek8hNHCwCHrWYrRYRpguoqAtdgmuFC6ME7/t?=
 =?us-ascii?Q?sdsNSsQXqCk7v5w71KC6nNXLge5Dt9id/1kzYBVgN5CkyzxMcHGea8Y77EiR?=
 =?us-ascii?Q?LC9iWytx7l36snXT4rJZO9Gck8MWaGib+9iFA4Zn7tHcOU+58BM6KAiBU7YS?=
 =?us-ascii?Q?ABBb1LnBJtYhKLcFycgVG96vJ5ghHEiSWofk4ZxBUsdjcDIlNCzo6kH5bREU?=
 =?us-ascii?Q?frQmRjg/CHV5t0qK+k8OBSMPbq+GeFAF946Ih91JGKi78JP1qn9yWnmJcmEr?=
 =?us-ascii?Q?isJwyv6mQME6ol3fIFf+i63dNM598g+Yoy6PZtIRb0mXvvp9HtivPLJdZOPf?=
 =?us-ascii?Q?q2jKIbuNGLsc8NJVVWoone9xQqJHvtScUm7DweTVSIIt6/8KkBFdXjC1VKwk?=
 =?us-ascii?Q?vtT39KaPiRCrxWGn3TkH0jObaSdHm3D1vCMziN4jdxnwSIHth3AI66l3Eu3A?=
 =?us-ascii?Q?UxALedXFEa3JMlyHMsUlTLvf4E+PsOZJYHvBff5o+aXloIKxdH5rO6lArYz8?=
 =?us-ascii?Q?Ua3p+4ReFSMhKEGaIon2JWeQ+hw6XAs9pFWLNbUdhzthIWxE59DBIKuycyzm?=
 =?us-ascii?Q?ID6ctnP5ii+BK1ieBnp/YtbEACdnzVbqID9MLRnn+irnGx/JmXFKN5PI4VRj?=
 =?us-ascii?Q?CozbfjXOBSzlCp6vtTN3aHmF9ev2tT4tBVWzwzvKleLyPuOQYWykQppkAHWt?=
 =?us-ascii?Q?K8gaB/Ag7AM6tjjrBytmLhj3bdHnC9QYK9Ig+XQZbhQ9hyAf3su1lu4ijLoc?=
 =?us-ascii?Q?XOYlFqjgrXQJQGyf29zzt0oeR77N+9lbm/UcMMyYaM1Pyt0/+IjKn1VMsPXa?=
 =?us-ascii?Q?9SbCiKoxY7iU1gCxcsT/0P5pWQ+mpqVLCwAqduCZTv+rxQKojBuY3IRYrHMw?=
 =?us-ascii?Q?Ni9buG8ZAXRSKMO4cINyZx337wWnkm2C+ss7w6Iz+AiD0sYUi5wKIUpkb0yl?=
 =?us-ascii?Q?N3GmdvZIzbthubFAMweVuYlsNxfOM61cMhVd7GcbPKb3J02dhTfYabWCK9Yt?=
 =?us-ascii?Q?uUvlFzge6aqqergTQzD833BDnWG7uyWlh+w77WLzcIbh3ITGxpb6DCl+s2KJ?=
 =?us-ascii?Q?G3jViRo61EwTDpR925LG+pcrf5Im47EpSscD5gFIX5jN9Ai4jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:14:14.1579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77534902-b1f8-46e7-7453-08dcb25e21c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires the following fix for preventing EFI memory map
corruption while doing SNP guest kexec:
  https://lore.kernel.org/all/16131a10-b473-41cc-a96e-d71a4d930353@amd.com/T/#m77f2f33f5521d1369b0e8d461802b99005b4ffd6

The series is based off and tested against tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

----

v13:
- fix potential kernel build issue without CONFIG_AMD_MEM_ENCRYPT set.

v12:
- cleanups as suggested as per upstream review.
- Moved unshare_all_bss_decrypted_memory() into unshare_all_memory().
- Zap make_pte_private() and merge into unshare_all_memory().

v11:
- Refactored __set_clr_pte_enc() and added two new helper functions to
  set/clear PTE C-bit from early SEV/SNP initialization code and
  later during normal system operations and shutdown/kexec.
- Removed kexec_last_addr_to_make_private and now skip per-cpu
  GHCB addresses when making all pages private and then after 
  converting all pages to private in snp_kexec_finish(), go over
  the per-cpu GHCB addresses and convert them to private explicitly.
- Fixed comments and commit logs as per upstream review.

v10:
- Removed pr_debug() calls as per upstream review feedback.
- Add review tags.

v9:
- Rebased onto current tip/master;
- Rebased on top of [PATCH] x86/sev: Move SEV compilation units 
  and uses the coco directory hierarchy for SEV guest kexec patches.
- Includes the above mentioned patch as part of this patch-set to
  fix any kernel test robot/build issues.
- Includes the massaged version of patch 2/3 as per upstream
  review/feedback.

v8:
- removed fix EFI memory map corruption with kexec patch as this
  is a use-after-free bug that is not specific to SNP/TDX or kexec
  and a generic fix for the same has been posted. 
- Add new early_sev_detect() and move detection of SEV-ES/SNP guest
  and skip accessing video RAM during decompressor stage into
  this function as per feedback from upstream review.

v7:
- Rebased onto current tip/master;
- Moved back to checking the md attribute instead of checking the
  efi_setup for detecting if running under kexec kernel as 
  suggested in upstream review feedback.

v6:
- Updated and restructured the commit message for patch 1/3 to
  explain the issue in detail.
- Updated inline comments in patch 1/3 to explain the issue in 
  detail.
- Moved back to checking efi_setup for detecting if running
  under kexec kernel.

v5:
- Removed sev_es_enabled() function and using sev_status directly to
  check for SEV-ES/SEV-SNP guest.
- used --base option to generate patches to specify Kirill's TDX guest
  kexec patches as prerequisite patches to fix kernel test robot
  build errors.

v4:
- Rebased to current tip/master.
- Reviewed-bys from Sathya.
- Remove snp_kexec_unprep_rom_memory() as it is not needed any more as 
  SEV-SNP code is not validating the ROM range in probe_roms() anymore.
- Fix kernel test robot build error/warnings.

v3:
- Rebased;
- moved Keep page tables that maps E820_TYPE_ACPI patch to Kirill's tdx
  guest kexec patch series.
- checking the md attribute instead of checking the efi_setup for
  detecting if running under kexec kernel.
- added new sev_es_enabled() function.
- skip video memory access in decompressor for SEV-ES/SNP systems to 
  prevent guest termination as boot stage2 #VC handler does not handle
  MMIO.

v2:
- address zeroing of unaccepted memory table mappings at all page table levels
  adding phys_pte_init(), phys_pud_init() and phys_p4d_init().
- include skip efi_arch_mem_reserve() in case of kexec as part of this 
  patch set.
- rename last_address_shd_kexec to a more appropriate 
  kexec_last_address_to_make_private.
- remove duplicate code shared with TDX and use common interfaces
  defined for SNP and TDX for kexec/kdump.
- remove set_pte_enc() dependency on pg_level_to_pfn() and make the 
  function simpler.
- rename unshare_pte() to make_pte_private().
- clarify and make the comment for using kexec_last_address_to_make_private  
  more understandable.
- general cleanup. 

Ashish Kalra (3):
  x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
  x86/mm: refactor __set_clr_pte_enc()
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/boot/compressed/misc.c |  15 ++++
 arch/x86/coco/sev/core.c        | 132 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h      |  24 ++++++
 arch/x86/mm/mem_encrypt_amd.c   |  77 ++++++++++++-------
 4 files changed, 222 insertions(+), 26 deletions(-)

-- 
2.34.1


