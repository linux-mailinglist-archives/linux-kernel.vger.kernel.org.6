Return-Path: <linux-kernel+bounces-227772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2791566B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700D11C21929
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226821A00E0;
	Mon, 24 Jun 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XznHPGNU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BF19F488
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253312; cv=fail; b=H6rK2MvMZQ1rCCcStNa3toxyBcWgpZmHiyXK9b+Yl4YQ1eTXtjo9MCYriyFhBg0+EwRtgYUC2qNMJ8bB7Tj8jXk67dJcowyt0uQKXGzApexDOEsK36Gn65SUeJL3IyeOSJjR6D1SmZXFwI9RA+PWMU+OiIl6N2Fx9p2CUZZ4oj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253312; c=relaxed/simple;
	bh=N4Zk+dGNgdh1zhnT3GA7CQC0vB38KFYDrADZx7bfIvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJlcS0ksBcTx0yHxsuYeMfOxdtCTkZUTjaqjnyQDMy2rDlluMbM7oIPd7NJoRVttvvd8Z2JSVPekeWrHuer61iv3IHMQwPwZnDAKzuBimC13N9zSICIdApXD6825Bd0kSktOofOJyffocT7dYOAbnAp/FR8dfyy/XRHQM5J3CgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XznHPGNU; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS3HubFjnc1uIU6l0aGe9qgtT5GsBQtTZ2+kQxWLey9IgprxJ7MJIUJBNqddsByoqiSm6i1FZ8cP7WzcDzf4/LJH7giVOgdPqc5SZ4JPNokb9izTeBompk7hqgPBgiNwqHLmANHGyZaaB/b1gaKzpeWhOQRgAFjy/LxxMbtQHYHgnmpn5bBx2yC5yZMu5N+mGqq+7EQJ5xwdnXr4o04866CxkUbX0BAPLSefLXeAFjSzg5A0O7rEU5AzmSo+MfV5DFb3dvxbMrKOc1qwRTF2hXSev4LMgQui9v3+0G0KT9MgfPRfQMdN87QDgPj4ZvUW228JCU6V4OWzkZP9FSeOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT2zjvaPwjmzCIBi+yL1MjNyh8yNkE8AcMIWGbgIQKk=;
 b=oX9F21Fz4fkfE4LSIfJxcNqxN6so2tuaFQXw61WTi6sTluva6oRAqPe00WOWvmcIgbY8DNuNC2CUxby+oiqKzOOVlHRKBsWZAAkLHYJtSe6jGc5P/s1HDJfSuN2wms8ZiXqmATmMa6QLvN3VSnjxxCQS1OYo3w+iwhUBLjtLwvA7P0mbKqlUfjH8xkIbfzLQvdT17d8uVtM51YQsLs7pN/xu4a0u2G9VOYVDVpZI1vaulnGUrRs67Ch28kQ5+EIXO3qXZu6+1Sg1kKiXq/2K3JGqJn9zLrftc2V2UumWnvXCkq5nv6jfnz1/hSZXmuC59XLBD7iaukXb3gkShwqSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT2zjvaPwjmzCIBi+yL1MjNyh8yNkE8AcMIWGbgIQKk=;
 b=XznHPGNUh5isBUBOL043fCuv2jb+shs0N4Yv5Es1V9ZGgsN6S/OeVkHubghG1AkZXdBMyK5U3ftoH2QfRupnX35Twe+5Ryr9CI+XfWx/70DhOfc1/2dh1VK+TEr3IOy/Mex3faVtS+9rL6qFn29Ky7bGf6zjn1Hz0VaTdjedKUg=
Received: from SA1PR05CA0016.namprd05.prod.outlook.com (2603:10b6:806:2d2::25)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 18:21:42 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::9d) by SA1PR05CA0016.outlook.office365.com
 (2603:10b6:806:2d2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 18:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 18:21:41 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 13:21:39 -0500
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
Subject: [PATCH v10 0/2] x86/snp: Add kexec support
Date: Mon, 24 Jun 2024 18:21:29 +0000
Message-ID: <cover.1719251730.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: eb10d912-ffbf-47f4-179f-08dc947a7ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q5Qh0571FReHCtIG3CLID/e0Rv6k1ydgDpAx1PMDMDglX5hbGbuq9luyc6W/?=
 =?us-ascii?Q?sHYGju/QxlBu4Yj+R9NXFftT7tQyj1aIX1KgPISQiVBETYrOp4IZkVcxxJtP?=
 =?us-ascii?Q?okFW5VAOKe7B1WysG3ejVVHxI9EMsGwgmg61L097hl1S5pcmSWVibEKNYLI7?=
 =?us-ascii?Q?/sKzDDaUsLzJE7auB17Ue+Gjde7UbLqmOofF2cgetpRC3v29qm0JX1Pn8jmV?=
 =?us-ascii?Q?jqPrG6mz7untGT5wk0e0+3V/7PtT8oocLK2aWfo14lTTxHgY7eYlWVSDY8fD?=
 =?us-ascii?Q?+nehpK+jPqq/ROSGQHQ4aDPMqIz+Nhuihf/+Hhhnb7ZFr18CMK+fnNVOkcsE?=
 =?us-ascii?Q?3JRmFNWijpd8ph0AIrt5IPksDl8wOxvl8balR+fQQ/9osrNU+BJdbxhx0WJx?=
 =?us-ascii?Q?zBJuB5OCPwm7WuZEulVapRdIJZquR4rBYfMG7hQhP7tpg12JN1/OI+ZsjPGe?=
 =?us-ascii?Q?8486+yBc4JCjIJGCbiKlnXipP3RML/g/ZRuph2NEUFLpFiQ+Ev5BUIP3PH61?=
 =?us-ascii?Q?DtCmC65qEv3fVjrPRDQL9ve/kyxSupCOBQwyucNNZAnAMDYXqP9unhhnXqoo?=
 =?us-ascii?Q?5oA9mGG96GAq8p6Dsm+KLhS5SHWLdrkrtHt53NFfLKY6DVjtlGTQLvuGNA4/?=
 =?us-ascii?Q?0JVPY0AFOIcMfinIQ7Lycn85KCloOuYzEVUI5Z/DphPOomThd6/aCGoU7m22?=
 =?us-ascii?Q?StM3ywft5Va5+TOuSI2fHgc9ADzdc/8W4twk32re/Jwivp2Ad24sIhloF0JO?=
 =?us-ascii?Q?NufZipKrHLPA6nUeleksRRtmqVXhSqgTzXKkco582puCmHbuGj4W9djCeEvB?=
 =?us-ascii?Q?3a8YoSsxCUux5Suz+RISwpobgv2yRSsr+m+DghjW3jQKnnuIz+GTJ+VYIYG/?=
 =?us-ascii?Q?oT2uSDQkMU5sg/QWapFJWQdCGxHt8bQHqlWegDS9lQTdzdhUuBHFyrfjIvHU?=
 =?us-ascii?Q?qO1JiFfnWGS3t8VMZLvA7tZdGI0amBVVkkQ/VzgY0B71SSSraYdzAdzTzOWe?=
 =?us-ascii?Q?bpGkCfs9icylbIhaL5xc4yH2v1WkPcQJ2OoXQj49VBG+WgVtSQn9T8zARfCF?=
 =?us-ascii?Q?Nut1wvGUjqj/Q9Ro00XUmWsDh/znT7paLMs4jt1bNi0S6QrgC4xHuSfH4DnD?=
 =?us-ascii?Q?KE+Mk1T9Txc00bZJgJhBrHPqx1nyJbiaEjR+harpns6nk3SvlXBNYWxoZs9/?=
 =?us-ascii?Q?WAa0GoQRChz+iQrEM5/I5R160GUs3uIspYOC3HDw05ljGeZSTXXRs7B0b0zD?=
 =?us-ascii?Q?VtsLhMIlv1QaVkncCdlURDJge6PUeyGLNDvX6hWDw+sT0n9WfswYVU9clDLX?=
 =?us-ascii?Q?blHCMFvlvQK4LTmSdiHknhnVF0eD5tJBTRx3nGysxo2U8lYoptKwX2ip9uxb?=
 =?us-ascii?Q?cxDWwdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:21:41.2581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb10d912-ffbf-47f4-179f-08dc947a7ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires the following fix for preventing EFI memory map
corruption while doing SNP guest kexec:
  https://lore.kernel.org/all/16131a10-b473-41cc-a96e-d71a4d930353@amd.com/T/#m77f2f33f5521d1369b0e8d461802b99005b4ffd6

The series is based off and tested against tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

----

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

Ashish Kalra (2):
  x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
  Subject: [PATCH v9 3/3] x86/snp: Convert shared memory back to private
    on  kexec

 arch/x86/boot/compressed/misc.c |  15 +++
 arch/x86/coco/sev/core.c        | 166 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h      |   4 +
 arch/x86/mm/mem_encrypt_amd.c   |   2 +
 4 files changed, 187 insertions(+)

-- 
2.34.1


