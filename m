Return-Path: <linux-kernel+bounces-238348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953829248A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98421C22A39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB191CD5D6;
	Tue,  2 Jul 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M9g1BH48"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BFC4084E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950215; cv=fail; b=Xy/7akJqOfdR37ZM9j/DkvKquSwKjdUI3JoE6s9n9IqQjLyGWJ9ag/UKSTEBicUJzNvGnDwAW6LT1xKUP4/kiOI+SyLbGvO1Geq1A20kLWnNCFuHweVEDQtXrIfo02UzJK5DIgGb4r5qPcqZ2S5jsg312u8DvxgPCwmvmU+gKtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950215; c=relaxed/simple;
	bh=WXF83HTo+GhGE/f7+Qr7sNuvxfxB+mX62NEMGUKPfGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkMvm+26fwkr3iMn25SPwt9Y5s9vC/KQjcqzWETnLeAvuJTkoPbuHTg6TqWnTDsz1vK37k+a7ioqu6eX9UjAJc0UQdWdIgixQ3T6rKvEIvIM6kahEHW+JP7biJWM18KBgojwHmII1mn9pm5I6g3WIy3pLx9MyCH7+9v869o8IkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M9g1BH48; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0FiuKV77xy+d7FNuFz/D0C7Aiugxgy3kPhyG4UHuiiYPp9gMLbywe33wP0v0AeQ8Yaf4vCdPCc432qH8+rhDqQo6z9fW9rX4UdjN9f3BdKcEuJaWyuQg9spLCqAiaOlgDcfr2BO5ehgnTaM7cWrq5CYiVm4KeZxM5YxBM9mPBCpJaelAkSMJ/ZQiRX3Rx2Fpy39lRKNcHmFoKjWQOjS6jubi8gatiynH9gCbr076tk83q507e/H/TXzrGm9oj9+IoNxwLU1pjGWB7Yp5cf56L/W4PFLJaCt474gD4ebs/aRgZkpDlDAn+lgqTf/pavBaOoWZA3G3cG8JZ/62/iZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmCeDU2fX7yAQjpLbzJlPnbjO+dvR6kRRZmZ1Hwi7C8=;
 b=mx59FoHCHgjJAIb+/QgR26lu2jhz6JW8uOR64j2uvuU51or67v/o6YLGGV7x9PCMfWsB9Rmct9PiTDVS+H5vxcObK8BMwAeCSingv/m1LXKsPEjSTEcEFnx8K2QSwgVr/d4HRZvZUakUw+uoxOgnnYlZao5x8Aormiit21DJtpUKbu7vPwDCjpv1/pxY2UAJwzPCfaswebPubG7WIL/hkpMJgKj2znYi6OjF2qb+uS1G6qZ9x0HlBV/LUeaw6y8bTPjNoqIlkgj/sjL2NhB+8m61mCW+airRMkCi1B4/s9d5AiFRDYTEl0LugP4Qxb7H+hbOalLiEnVNuW54WLqrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmCeDU2fX7yAQjpLbzJlPnbjO+dvR6kRRZmZ1Hwi7C8=;
 b=M9g1BH481uMpcjTh6urBda8U2/KrQ+Y5T0W00CgP9YCZMHuOcWOeJ1+zE2tsEx0+YlAKbgjWpbhAFJ2uuv/DAguK3Qru2rd0MQnfnxcTe945JoAOnoY2bbewf9cbcoUfX7Rh/AKqgJKAQ+oPnQYcU7goRQOzh5TBWYylGQ4jLuU=
Received: from CH0P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::22)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 19:56:46 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::66) by CH0P221CA0035.outlook.office365.com
 (2603:10b6:610:11d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Tue, 2 Jul 2024 19:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:56:45 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 14:56:43 -0500
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
Subject: [PATCH v11 0/3] x86/snp: Add kexec support
Date: Tue, 2 Jul 2024 19:56:33 +0000
Message-ID: <cover.1719948376.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 284f8e66-5cea-4564-71c1-08dc9ad11a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLzKCucgRmLH6r+1jp5EvkzNROdRe/+NgSennIsdJYCVacILxp7bhsHqJJXi?=
 =?us-ascii?Q?ZnI9xuNvcUC3YIf9jWt43pkxqJACt81Y/jA8Xc1+mXzu6bzRPQqH+BO9GHg4?=
 =?us-ascii?Q?d9sj5hlBH6sUlor6r975uqSxForBhR1xZZdbG8qCftH22vtaKcz6eAPGgsty?=
 =?us-ascii?Q?PreSdhIIK4ExO39YVx3KKs0ACsSwTe+3/eUaKPj6q5tYL6k9F2Oe9PIIDwbV?=
 =?us-ascii?Q?D6XCF+ac9zF5p8fOZd3sQpYEJW32/hgtvMvQXCQYD5/BRzFolNsBneDQjR/o?=
 =?us-ascii?Q?IMkzlUCPoMJGw3cla8CoxFlUjTGolEJOLIS3P1KdFQreW4em58E5C8L91JQW?=
 =?us-ascii?Q?iNRKLYQxxmTTyxloDTRyrr8dolBNc12VeoVIc+g/tZlgZChlb1R2Z0cHwzr9?=
 =?us-ascii?Q?RMOH4HQeNk7TeAT+S09RIHDdBw+InH3g+vDVVgNvwxHj0jPegmGHsrBhVaJh?=
 =?us-ascii?Q?h0HTA6/dkRqwkvX7eXcZWdL8ceMN0W6vxN2vpq+5twRDkDlLDAaMY6BSIcOh?=
 =?us-ascii?Q?adqB0rzR550RstnydkwMjQ3cHOaw7SuDBF/mMmuZwHbHBkPX3qAJDO7Gf+TI?=
 =?us-ascii?Q?8R0pcyfBv3Pr9FK5WPJgPi7LMaJnzn06dVj1s079xGrIIa7FhOggI8/EvVhr?=
 =?us-ascii?Q?equNdR8XWxty4PHfQxXu60bfdoUgVM61hILpW2YKHQQbCGG1wQGiF8zzRfDp?=
 =?us-ascii?Q?FEX5+Kgnaxx6Y0487urT/6OjuAmGB+mlFE3fYccnDlQNXWWtiSwaFP2Rw8xS?=
 =?us-ascii?Q?wiHSIG2EwaKlpYu9iO3UwVs3Ct5bMI+RlcupOMrCXRMFMnKqR1yQj4st3lY4?=
 =?us-ascii?Q?lr8M8uLun73r8t7RjmeK9yz652jf6v4sqAA8ChZl9Tb84b8gSm+ihq2qlcYO?=
 =?us-ascii?Q?2Qf0Zo2ljpFBKIdO0qNuMUUg08ZB6K8qBJzf6p+FLNV3LPLTXWTGTd4+gNe0?=
 =?us-ascii?Q?JSfc9P5b1RMW0iuvzpcJUBS2Uky2GpH8y5Vl3lmIuOOXuFbzyZO9EBTmxubA?=
 =?us-ascii?Q?UdIUZbqE6Ihz+cmPk2B0LmJmlXc/VC3Q+XT7ACxLOBPsuqrvbzwcYF32Qbpb?=
 =?us-ascii?Q?bOKc/n5GWkE9lZiJeyyAWHTHaqv9aT70A6wl3QPqHsYoJMw3sIcVKDT2KbNd?=
 =?us-ascii?Q?NbNCWlphKwQ09mIw5n/xcDUDCngz/8g32dPTV+73cr+kvgpBp1ocYH8ePM16?=
 =?us-ascii?Q?3mIttQeQybMrNkfEOVdDQ5K4ZFhg2HCyHP4ciZwQxoK5czlkQNvADxP7mjBw?=
 =?us-ascii?Q?u5tK4KhLPN5JWN68vu1PumyW+LdPYw2seF/bf3GI9HbpqdYLF5ECYNqTz9P9?=
 =?us-ascii?Q?az5Dw5VvCplpz6J7fB0rANCPp55rgaJzKWWP9myiQgg1Wvets6Za7P7fSjgf?=
 =?us-ascii?Q?49IpnICej4a6Hg8DYFP930EaDxLyiizTiYYROj/+YR3qtj5Urg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:56:45.4548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 284f8e66-5cea-4564-71c1-08dc9ad11a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires the following fix for preventing EFI memory map
corruption while doing SNP guest kexec:
  https://lore.kernel.org/all/16131a10-b473-41cc-a96e-d71a4d930353@amd.com/T/#m77f2f33f5521d1369b0e8d461802b99005b4ffd6

The series is based off and tested against tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

----

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
 arch/x86/coco/sev/core.c        | 148 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h      |  13 +++
 arch/x86/mm/mem_encrypt_amd.c   |  49 +++++++++--
 4 files changed, 217 insertions(+), 8 deletions(-)

-- 
2.34.1


