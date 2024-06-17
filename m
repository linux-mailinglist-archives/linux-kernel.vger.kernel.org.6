Return-Path: <linux-kernel+bounces-218327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A81EE90BCAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09491C21C54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08F1991D3;
	Mon, 17 Jun 2024 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YcBWW7ZY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B618F2CA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658841; cv=fail; b=Dx5rl3qKfXyi68ocdRJ1K7RDfmkZJC+am8yUDoe746ooLtOVWHt6BNfd3nHS36+hbIkDbD2hXSWdh8SQ9946yKu8CxJ/pQNJDAkETMgnsaAcBM0PtxsMXsOYr6j8fl/GDf3kfvhkSBryaHpTDAa1IabJ1yO9m7D2n9IpNBZLlJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658841; c=relaxed/simple;
	bh=LwZaXWFLqof1kx0vRhbYv6lLHHQl/JzzHY+1+gbV+js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyobeRFb1MY9wcHqa8+1OMrGeDwaGLgw3GlwYkX9R8vrNSsY3E5uWddzzXzJGs5aYie9TLBsGeqcHfFfvF7O36Nwih9q1U7sqgYG03gN0v5NiENzhj1AGJFRmyM8htWZpMtKXO0x5L8GtrBMIBbiRrvnc/ULzJduuiN5mat8XEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YcBWW7ZY; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFvAkFcPIbI+Vb80KzNfUEbfLMpiwZtG7r7w//cIy7hA4m1Akmh8KrGi7yw/b6wC3PTSheEGir52z4+S5WTSO+/j1gX4Td3OZsfA7TFHCKPk33oU4nd5rWXZld46nLti35oohwnlKq/y/H+JK4a+foy0B2n23Kya5u+OjDSUHZfL8ucRn1TsDVArms/nDqwxmQFwSEdKc5TkHbKvTY3Goe5/tg0Le3NiUFDW2o9S0DK7qlmZ7zrSW1pmYt9KzotJn5wy4mMLFvBs7D9wfNrus9GuhVRugvJ8OflufXaIjS/7wJvbErvJSdwK1ECweDhKEggfQpUhyBhePqyBE3/jXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tII5556ZLVx/tsEExmLJCUV4yIN303KAPwhhNEis+cI=;
 b=EfUqDE2DEAqutl94DcWZZLPMm9ORPJ/FXwQGY1+OiwA3pPamu3iYU0fb30gYfpS5+8xRwKV3mpGkkpG7qxaJI16t/4QEJpdsGhlMXp5eGr0zb0VMIvShHtJ7gv5zVhPa62Ezn/jGHNHM768SyRpxBzOWMKdpEd0vl6Epe2yxgvvwoOK3QIz2gVyFTztN+orBgA1Hr8H8DFFRY6fDyK5Gp7BoJ8IaBPqCvyeLXjEGxs9P9dbKWOwL7dvVEX4HjgQNhyl/4j/Q5apn/6ayjki8JbcxWz9hM2vJia6wedT7zAy3Qka74yhOQ31xFxCZ8sn330keQhD5/Lmx9JL6s9gMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tII5556ZLVx/tsEExmLJCUV4yIN303KAPwhhNEis+cI=;
 b=YcBWW7ZYxMPLOdmmxdB3D+7sEj3FXH8rZ+UR+M4xuXr290FvpaQTrlBfXaNIONx/1vFs77ySddCd7EPV6VEF4YdEg4gmB/cNVmKoiyQ93QLIMEBF78LS7NpdumRjiK6Bd0ipcpcPhrDi0hzM9gicu8MmdhHN19CNlMCoXZqtDQg=
Received: from PH8PR15CA0018.namprd15.prod.outlook.com (2603:10b6:510:2d2::11)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 21:13:55 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::6c) by PH8PR15CA0018.outlook.office365.com
 (2603:10b6:510:2d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 21:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 21:13:55 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 16:13:53 -0500
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
Subject: [PATCH v8 0/2] x86/snp: Add kexec support
Date: Mon, 17 Jun 2024 21:13:43 +0000
Message-ID: <cover.1718657194.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: f97da3e0-e6f1-4b8b-20b9-08dc8f126566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nIuVumXpGfVaXmZisx5sY5it3f+XzwEGgeTDzMjmZIet7opanA8njs9/BhCj?=
 =?us-ascii?Q?PO9EFC+VrN1eGrpTXIER/zBM6YCovZbWhzq7ZikMj5REzUg3zZN22SSlzqNg?=
 =?us-ascii?Q?aNxZYPmAfTgjXDSOA9rpmknMo7xbZ0xMMwdQdvlx+17G0mvdm5Sn9xzaCNt7?=
 =?us-ascii?Q?GQPtYwrRJfexS7P9ZhZN2XkEjbV2uoeS8JFfeQFSlTA3pP0GQGtLYfLiPEwI?=
 =?us-ascii?Q?W4QRaUFHW3CipuPCyS+dhJhRocaMBaynv51TB8RM8qXSfmyywki1tHdd14b8?=
 =?us-ascii?Q?SrrgNSm5rNS9qe0v8Sd3t8WXaR/OINaA+uiQ08/01+zAT/uCcleVEW3cAEs2?=
 =?us-ascii?Q?fMQQZO91aCee3KBeWWPsXbpGs07bMjRIPhWIrAwLPXP3HOxDkBfAW5yV+eNA?=
 =?us-ascii?Q?cfxy2+K6xUChqVplWGtsEreup0Hogy1YDNmU+/BKaatkz3iuFL8wUkw5qkuo?=
 =?us-ascii?Q?RhHoUoq9mIlAgoOnPldetHiI/334cPm3s57dOlacd+ByK8FhgDNecPaxIy85?=
 =?us-ascii?Q?qgWcj4LWv5hQ745s10z5F666pK3sVj8rz4kF5TG9qx2zH6P+ap5PXl1wQsG8?=
 =?us-ascii?Q?CfOCcY6c2jBTCz4QlzfgjStTUVBFdOE2+OFdxwAK7QChd7WFLJnfLTczLMFy?=
 =?us-ascii?Q?8djytzgRhYFfcnD/WPMqdgmeFvWBpfklQGq3bafnDnunJoZNgWr/84t9Nl1o?=
 =?us-ascii?Q?W3x3RRi9cnulH6FFcVHLvbHN157JUh5JvOkJKhd2scDL+kFW1/XnMpBi6zbe?=
 =?us-ascii?Q?i53PPE/7ru9EUD8nB1t84fn0UWvItl+sGkjwZJYSBNNTDkLF+qXH805whWFv?=
 =?us-ascii?Q?Igxff99q1pYNAp6yzTx6ba6PS39FzXcV5DvS+A4AgVrO2u7h36ZeBWvCid63?=
 =?us-ascii?Q?iAfFW+s5OKnLcdK8Hm/CC5PXiwa6+PlpN5bjM93T7I1wfoFWydPVRafZ9k8E?=
 =?us-ascii?Q?BjaeRxgqYkUf5mQwz1H573Kuql24asvSFAdDivYGGXDV7DI8kW9YZawFRszx?=
 =?us-ascii?Q?JkrKsuT8Eove44di3wu5q95zz0BG0MiWgrZHxl8D1VP772W0HeHk1dxwVMpc?=
 =?us-ascii?Q?sJLh/W1bW25AgMPOoBlrKIlt12+cBwZfTb5YKHwal3ICLIwYXb+ZttKhNA2i?=
 =?us-ascii?Q?+KdM9Sbu4dFpa0RPsKXBpM950ciBeEBJEtpoOpc5XaJD4IJ3yjHIDnUgVtBW?=
 =?us-ascii?Q?7BoCP4qqFTxcd9xY/u8fgE9qOMX/16OaPQVNSOg9/CLYWAdo7aQL0d+A27NM?=
 =?us-ascii?Q?LU/hQM06nx1SLmLMMEZ6oIxg0PI499bbY/NM17yuMGFcGqn2NjDjbfSU6El9?=
 =?us-ascii?Q?Ybhk7wTn0HIqRCUPXrF5LKp2IXPI6XGHKts5DyR63YMWxsPSGh4qUivrHFrP?=
 =?us-ascii?Q?01tIiMg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 21:13:55.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f97da3e0-e6f1-4b8b-20b9-08dc8f126566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires the following fix for preventing EFI memory map
corruption while doing SNP guest kexec:
https://lore.kernel.org/all/16131a10-b473-41cc-a96e-d71a4d930353@amd.com/T/#m77f2f33f5521d1369b0e8d461802b99005b4ffd6

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-kexec

----

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
  x86/boot/compressed: Skip Video Memory access in Decompressor for
    SEV-ES/SNP.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/boot/compressed/misc.c |  23 +++++
 arch/x86/include/asm/sev.h      |   4 +
 arch/x86/kernel/sev.c           | 168 ++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c   |   3 +
 4 files changed, 198 insertions(+)


base-commit: f87c20c019e22be5f2efd11bf9141a532ae876da
prerequisite-patch-id: a911f230c2524bd791c47f62f17f0a93cbf726b6
prerequisite-patch-id: bfe2fa046349978ac1825275eb205acecfbc22f3
prerequisite-patch-id: 36fe38a0547bcc26048bd1c5568d736344173d0a
prerequisite-patch-id: 1f97d0a2edb7509dd58276f628d1a4bda62c154c
prerequisite-patch-id: c890aed9c68e5f6dec8e640194950f0abeddb68c
prerequisite-patch-id: 17a7d996d9af56c6b24a2374e9e498feafe18216
prerequisite-patch-id: 6a8bda2b3cf9bfab8177acdcfc8dd0408ed129fa
prerequisite-patch-id: 99382c42348b9a076ba930eca0dfc9d000ec951d
prerequisite-patch-id: 469a0a3c78b0eca82527cd85e2205fb8fb89d645
prerequisite-patch-id: fda4eb74abfdee49760e508ee6f3b661d52ceb26
prerequisite-patch-id: 6da1f25b8b1646f326911eb10c05f3821343313e
prerequisite-patch-id: 95356474298029468750a9c1bc2224fb09a86eed
prerequisite-patch-id: d4966ae63e86d24b0bf578da4dae871cd9002b12
prerequisite-patch-id: fccde6f1fa385b5af0195f81fcb95acd71822428
prerequisite-patch-id: 16048ee15e392b0b9217b8923939b0059311abd2
prerequisite-patch-id: 5c9ae9aa294f72f63ae2c3551507dfbd92525803
prerequisite-patch-id: 6bd2e291bfdb1f61b6d194899d3bb3c678d534dd
prerequisite-patch-id: c85fd0bb6d183a40da73720eaa607481b1d51daf
prerequisite-patch-id: 60760e0c98ab7ccd2ca22ae3e9f20ff5a94c6e91
-- 
2.34.1


