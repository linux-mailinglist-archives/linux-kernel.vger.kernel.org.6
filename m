Return-Path: <linux-kernel+bounces-223622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7A9115AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CA61F20F43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10F36126;
	Thu, 20 Jun 2024 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u4oiR0RU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336213D278
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922179; cv=fail; b=b11tufK/BJYEXMUcUpl1rpLR3YUjI+9FgYCGQYuwhaxwXjVDZL+0gQZMRVhwdfnxEQQ9691v1S7ajYjQfHVjy9PWyFmaxNeWG4GUPJevWs949VTyFXqKKaAahdHFY1HPoprramLOvpbRLM+BeUdec6FkDCWugn67HhXt2Aco3Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922179; c=relaxed/simple;
	bh=Cz5oWioZB0MwubsyJnEsDOXCCgmPjG85ZMEayl1Ogu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDPTcd32hKSIGfa1BJkA28NH1Ucd9oHLqQnjb59UN8AWo1Wm+/5MzsGyjq4MBod94znq3yvv54TJEhcNIhGgXPwbHKcL/SZxnoo0iaDPygiQyXbmdyVJN4dAAHy+dXRPfHh7WcYTwyOjS1kOkE3IggVAN2Q9oLU10zFdp8PMMdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u4oiR0RU; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlm932qpOpwuyRuVzJpydvpgyXTtLPcaVhpaQSkPoAuTQFheDbvvhseZTMfXavup+L68axxZummP/q13fq4kewCCW1MIm7C0FP6+tQT7KpK5C41e6GS8cDChFDL0+vSgRAc1U9fCXT6+dLDFPP2w1iHNw3rMqi79PjVHosiJXOYcKauWX0O/Y7y3cENKKCpooWlun8RabyvyUgpQwBlg2VpE/ha6xpZTJc5pqxT6Hs+KC+NfQjP+yXLezaLAHL60/avSG3BV5QMk+WSygYV80oXXy7lQUpSmnzWdzKIpkJ3+lYyM4sXvohXkTnRH0HMo3etW107kDi+VO1N2ebnegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj2BhBxx4wYRoT0LbWSvinK3WpvpOcunghmNG7FkIkM=;
 b=F5LSqz1bZqu96t7GA2bHBFbekd/n9iubRk7nCMvJdO7HvthiMqehDqtMjZGWRjYVN6sFB/M2KKO0iRNmFc5qGrL86f1fKaHa1SQZHfW10Ji1gOslUi17kymY1VmIP9YpTjxJrkI2rnIT2zE0JD04XKahV+bq4Pz2OawOxepkFfZO78CTk7M/agjPaLtwX1VMb9DX3thh9ftr9Z1r1U5D1EzmQ1AYn1oqaB9eMdj6IqOFCEqzLykinmGKFYmAI/AWXcT2TNo7Nn9hr9KNCBmKj6GMEimV3YY+6GSKlMLZ2ARwOEaFCVBo+DnbYcJhsRooAQelMdh9wg1j7G0Vf2ZIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj2BhBxx4wYRoT0LbWSvinK3WpvpOcunghmNG7FkIkM=;
 b=u4oiR0RUsVDXZBuvYjepCgjRFjnKqJ2WgkmEoH2M6VAay4r8L3nHC04cdXkLYh2Cz03XN8nWrzBMIXbvKr0BsYsYv8WcoKjM3BnN6H+T8kBc90lTpr/FURRUpq1D8vb9J8Yr2jjM0kmqwU4BfPA6PO/QYuGBi24ydahakiqKgu0=
Received: from CH2PR14CA0036.namprd14.prod.outlook.com (2603:10b6:610:56::16)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 22:22:53 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::74) by CH2PR14CA0036.outlook.office365.com
 (2603:10b6:610:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Thu, 20 Jun 2024 22:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 22:22:53 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 17:22:52 -0500
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
Subject: [PATCH v9 0/3] x86/snp: Add kexec support
Date: Thu, 20 Jun 2024 22:22:42 +0000
Message-ID: <cover.1718920799.git.ashish.kalra@amd.com>
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
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9d765b-7a7a-4e03-7584-08dc91778734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hdep0BcUENpi9tXVxkbBk3dJG9KQ8kyJDo+zhUdy90zPb2W8N60D1igZd3bU?=
 =?us-ascii?Q?t+kB9gDVov04q1+vxs3xCf2laMAmQ4+ucYxViayouwBeIoE+ZvCpmkan2sOF?=
 =?us-ascii?Q?aHYJTdB//TnwCQvAp226x5TJlTawxtScf2o44p0vvFK7B4Ue1ESyX09LwYic?=
 =?us-ascii?Q?S7Gv4Zivf8YppHNm+Tla16SPx2en8zfG2Z21Zg0yNHaCgwddDnx+ss6hVcKM?=
 =?us-ascii?Q?nCItRQpJn5aL4FCVUngp5w+0vgfoR6W2tEAyJC3g3q2Ejuz6t12zp3R+TQyL?=
 =?us-ascii?Q?FlYWIEUUxf/8Cy9kULFGhTIGxnxyr5LMiKyPY6cDmjrcRtfBGvXIO+oUBr4z?=
 =?us-ascii?Q?loVEG0fnJ2AqDIz7oMAB7rocxRAbD8ZLWQfCgTqmvNARhmI/xxp+azFkwpja?=
 =?us-ascii?Q?ann9bUx77QodLmSU+yQpxAqaTvXQWacAgobiHSpwnkh8Nu6wbaXsXl4Lpx3Y?=
 =?us-ascii?Q?26nN4C2eyB5vrJ0SytFj4vrQ9R4ny7ETB2uxYmjKRQDxp89VlZasbpUmnxbF?=
 =?us-ascii?Q?brbQAx2e0HZNJIRMq40rRu3s8lF5Fpc9Q2HchwpQ7D2CFrBtJ/g0VkJPA//t?=
 =?us-ascii?Q?8JKs1zcuORPJIQHDS/Bn1VpXGc26ibjfM8mQBCb3bRlc1L7SrTiRY5PeznAQ?=
 =?us-ascii?Q?7zLGtySYV8v05bW7bwgixr0Fmk1sebWloPq5oeld24jwZytn00ugtVBDMAhv?=
 =?us-ascii?Q?9uqKMoeDyHoPWSyRULL4cCDlMHSAWSLGXdNFSafzY+wZc1kFgL1/KUhLIIOS?=
 =?us-ascii?Q?lqeiklFMxTwOOmq0vxpTtEQikciNpzhOPnJbEN+cdbOLpXuiMYJRTDd5q7QL?=
 =?us-ascii?Q?FGDOBQzrSC2qLTTUGxRnWacdUk6+Z2MaJ3Cp5L8Klof9H/vzB6uPFaDanZNk?=
 =?us-ascii?Q?Y8FgQ/C5LR45IvjRC87RyQYhSkzT50BXujr8KTmjJY7fRTkty6A4Hp1QsiN6?=
 =?us-ascii?Q?9b2RPvrWl8Pn/3Bsx7kzIBA5kf5pgOE7nIbKvKRtWefSlTJ8J5g8aE8psWDx?=
 =?us-ascii?Q?mz651nn6UbUZLNn+AaH25HrP6NqEKBEruExG0E6ihp1+6/fcVMjk/f0HCN4K?=
 =?us-ascii?Q?dPaak/Md9AzE68xL9q80SKknIVQKl7rBreJ27EGXaB9YJdjnV2mpocQXckWn?=
 =?us-ascii?Q?OlwJoLh+iiBu0nCikMOX63k/Fh4jdKKDHl6PuwuwQlgDHMDH5KlDSy4/NemL?=
 =?us-ascii?Q?3pfYEVkl9F09GVX66mkid0Cg9pU3A68SwJ+A5Wwby5biHesVoo2j6h/zRIF0?=
 =?us-ascii?Q?0MgTfsYp78jT49bq26Cp8cf6e0ard+Mf+JE3rwJrq165WVe/bzmuaczKhL3m?=
 =?us-ascii?Q?gIxrk72FlEVC9nth5pdtoInU7nR+Qjh4xelX6TDUmla8sXoHTfZZph46pVy6?=
 =?us-ascii?Q?XsZY23U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:22:53.4640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9d765b-7a7a-4e03-7584-08dc91778734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires the following fix for preventing EFI memory map
corruption while doing SNP guest kexec:
  https://lore.kernel.org/all/16131a10-b473-41cc-a96e-d71a4d930353@amd.com/T/#m77f2f33f5521d1369b0e8d461802b99005b4ffd6

The series is based off and tested against tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

----

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

Ashish Kalra (2):
  x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
  x86/snp: Convert shared memory back to private on kexec

Borislav Petkov (AMD) (1):
  x86/sev: Move SEV compilation units

 arch/x86/boot/compressed/misc.c               |  15 ++
 arch/x86/boot/compressed/sev.c                |   2 +-
 arch/x86/coco/Makefile                        |   1 +
 arch/x86/coco/sev/Makefile                    |   3 +
 arch/x86/{kernel/sev.c => coco/sev/core.c}    | 170 +++++++++++++++++-
 .../sev-shared.c => coco/sev/shared.c}        |   0
 arch/x86/include/asm/sev.h                    |   4 +
 arch/x86/kernel/Makefile                      |   2 -
 arch/x86/mm/mem_encrypt_amd.c                 |   2 +
 9 files changed, 195 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/coco/sev/Makefile
 rename arch/x86/{kernel/sev.c => coco/sev/core.c} (93%)
 rename arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} (100%)

-- 
2.34.1


