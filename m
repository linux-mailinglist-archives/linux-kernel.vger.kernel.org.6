Return-Path: <linux-kernel+bounces-268108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3D942074
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120CA1C23D17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A2189B94;
	Tue, 30 Jul 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QW601ZZw"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EB1AA3F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367276; cv=fail; b=MGQYO0LnWPDYf0FaWbbC0gf2BqLH9BQ2fSXSyXC33OwKr5S1Ik+SVNPj5Op9H1+atNBH+5NTqv31ummETd2UfWjP+OAybN6o2oysDgKyWSBj/iDj/eA2cY39XEjgbQUL7Gp5c4raK0cRn0WHBSoE1YkuWbvVRFDkK1M09TUanu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367276; c=relaxed/simple;
	bh=K+yg8o1b9uLT/1rGIeaOvsRrag2QQDbM2u4qGKoc35Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM08I8S7/mmkaL6kzcQWDtYs9KEsS/LNszSkfrC6aNXMprYDpOvsPsVOTUMl3eUEDM0ZkrYlnxwZsk2u29c7UAfVROXHgsjPX/m4iyHeGOBnLoi3JESFdo0W66v3orHIDbhffRsVlK2o9rbmqDObRc04FYzdKmYQhteR0X8WelM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QW601ZZw; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0a/oFoFZfxgA4baGulrkSx5hdPZ0c5nSrAdc9JcOxiqXB6sMHSpxuIkNDkt2MEZn7qHcsSESRBiHJtBJ7ukoXDN/rM9Um+zKQ+RNY2lgbzHlVGEf/P8HcNyxTEXWyGbeSc3PyTJiIpiU0L5/Az1p34xL6O3xnNdP9AilrK0o4KkzEFlzIkowbdsQ+y6kZTMOffW0lzW3v2bt256ignKMX1aKCAkAfR+kOubraeMOvEeygbUZGmzhn6+Gs3aORPK8YgWNkVKwCrdfE7zkHDGSFt7n9JNLure9xLqEZP9+ze6MPXXK26jWEdX2fN0dQQLyS+kA/6ZdNfQXM1vP1AD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFA3Pz+q46+E5LeXMJl5ntuyyGYrHV1JUzZBwjsseRE=;
 b=UIMcxy1zKKDzMnSaHCiVcsMrg6TjSpcPfNAEvVGHRljaWEJCLoLTLuN8N0gnPLuc6Hyh459SDvTeuPOVCUUCHVBxwan6Q4DXZHhfFHH9jFwp4IS0BlhL+/kHfDjur6xrRqxhlPz0/rWInRmC+KYypdd0/x/ChRVzrcjxTjFQaJ7ZWxqFyyQgbA53lFX2hdwI0sQVqddBQV02ILWlukFmOAtVoq+04vQ2p0Pwtr9BXe9jaPDdyzByVy+dCiuqIpwGdSy7OsjOOzp2yW5OdLq5yd5noe7kYHhFwlbiaY7D1YCGhabgBbxeosf0Ng+Pk5NmIyG0q6AJRyCrlTb5XhSMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFA3Pz+q46+E5LeXMJl5ntuyyGYrHV1JUzZBwjsseRE=;
 b=QW601ZZwyyFceMt6OOtOHe5xjNFjQDKuR0M+1AnjrTW/N4RWt+TFYnMZwQrJS9FCFzkMJVGfncUBO5qXaIIFnxugS02fg7mwWnqhSThMMf/jWQ55cnYaiE8eWRjzwEfpKsssdJicCLYPIR/loRCJaObqoGKfrKPt2Kdff8ws0Cc=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 19:21:11 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::1a) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 19:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:21:10 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:21:09 -0500
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
Subject: [PATCH v12 0/3] x86/snp: Add kexec support
Date: Tue, 30 Jul 2024 19:20:59 +0000
Message-ID: <cover.1722366144.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4ffd1a-2d72-4a60-1fd6-08dcb0ccc4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPkFKnAKweUarvObEGfzRcX4OqWP6MLgApQPdtf7ZjWRzGZhFRRxAf+SSh20?=
 =?us-ascii?Q?0QY90SrJ7dGXjS2EyE5/3MolT8Ezl7mZrSTdrg9e35atAqNkcU5xN4Uf5gsi?=
 =?us-ascii?Q?sCcpR76ufn3y6xvgQDqtogM+bDcG4upiZlAiBae7swYEBQdyahbNwXFmNvdH?=
 =?us-ascii?Q?Ana7EUOWylGmVQ/c0z6jXcBA9Sknf8y3Di7NpngAhBjvScaeOLa8GMoCtdeM?=
 =?us-ascii?Q?9c+nwTJdj+3T9/z2na75y0Ka0LV1Sz7zGdMi9gmo1LAwAZ6D07FByzucVhBm?=
 =?us-ascii?Q?ADgrDVr/U/eoKpgkXTMP93zniB3y75PAKz4QB4R0lPWBbr8Am0GZ/6cLJOXR?=
 =?us-ascii?Q?N72IMnxOJY6Tc+4o+wTlVl5GSCQo91WVDHER9Pi3IJGiuDNhEfyTJrbaqvLd?=
 =?us-ascii?Q?KUWXr0yPqkvElmlS3MCQSEpGvTejzsdcxKMZwvHRV3lJxR2xv5x7pT1IARWv?=
 =?us-ascii?Q?l51qwHFCjL821YZjcIzBwz+LkiHvc37UhkuHodvfpxJv4tvQC4QifPyN1S05?=
 =?us-ascii?Q?FxK6ucqpYuEN/fn0O/PBHs4dXdFEPhGqFXTgcXok/oj0C9EA7srMP67C1WGk?=
 =?us-ascii?Q?npeOww1g/J+pR052PKzKaKAldGqBfGzQ5fdwKMbzc7j+L5UF6tTOPQstw9xu?=
 =?us-ascii?Q?4YGhIKYeAEXnErY4BzqvExzWqHE3xL8UhXH0aIbd+NuQhBfDqyhGX2j7a5+z?=
 =?us-ascii?Q?kIkwRpOPyEBVQhL881HUpsrFEIC3pbqB0kWfr6ciGD9CLErFCRw/W/jZ+xh0?=
 =?us-ascii?Q?4k7upV+2jyVgS4puEvu1aViGMKXy/hWDXQnmLGRUnjmqut9zjp6zx/X0VIol?=
 =?us-ascii?Q?5RDgoyeHnTtN4Jee+j8PgiUh+nP0DkhIg/f4zjFpBxMm3B9uiNGHwDtMMqif?=
 =?us-ascii?Q?pw+hRfIfGDWQ7/a1C7i3kmYQ6rf2ytNA1GsOebgPWXxXrw57gSxq/pn5K50s?=
 =?us-ascii?Q?mifPiBsBAiKIRj8AM0NdsDcO0S4NKBFCAoNzl5LaSTnPityuF2rX7GbdCB8v?=
 =?us-ascii?Q?dmGZfhYLgNloURbqUllFOq7Qc9Z7cfhd1avmiY9xtH2APGZSEEJPjCqrfPbA?=
 =?us-ascii?Q?BWabCBoL+RTICtWz/cHJnyWLT+33yk6wZrWCgeNFuB3U6e6utGPyBUI/UcVb?=
 =?us-ascii?Q?4Ta0wRbn7g1HHmSoNnd0kGRNrQ+Z+lCy4WsmsRT6SpZq2Iml71yaLoucBEO1?=
 =?us-ascii?Q?fyhVtu5umDYUA26UY3w0L0onIZPJGmLqKbc7Q2C/EEELk4QYPngufT2HXy/W?=
 =?us-ascii?Q?C2q+eiSjBLkEm94c0FJLd07fDJZGyEGtX+0oOVRQtPQuoGkSd3MIuINhALEm?=
 =?us-ascii?Q?ZAstGmbvEAUn+uXh9uEhvhNvvrby32P6yNQBrD5YxyasgvynyDVaQduypoAn?=
 =?us-ascii?Q?OGyWrfvW5AQTqLa09zXyozjokm+IHXxIrDjnJHD3HpSmphrjcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:21:10.3973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4ffd1a-2d72-4a60-1fd6-08dcb0ccc4fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires the following fix for preventing EFI memory map
corruption while doing SNP guest kexec:
  https://lore.kernel.org/all/16131a10-b473-41cc-a96e-d71a4d930353@amd.com/T/#m77f2f33f5521d1369b0e8d461802b99005b4ffd6

The series is based off and tested against tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

----

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


