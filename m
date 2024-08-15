Return-Path: <linux-kernel+bounces-288662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBEA953D46
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CCF1F21FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAFD1552E3;
	Thu, 15 Aug 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pGueYa/+"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C73D15445D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760211; cv=fail; b=mpNBoj6ml3Hx51EmlbERfW+9n+DZdMaCpnHDzuEwmXdPDenXzCCK7XhQ6YVRfo7ihVfJ4L4Fv+l9fxJeaRz7fPYVSHVskPf68ME+Ej+QCopw7x12Er3yOvdAlZLteBu9BOIero86Yyr6aJKdYaIbuLkfH/lvQQtrf+pR8UiOZMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760211; c=relaxed/simple;
	bh=JE5sTXtT3vxHef1UFofEdLgSVfZprje0PHD9LrzCnQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sPzABMVtyHoRP2+r/j7DYCOGgyGKajvgrokKLUl2mSFugUEHnvNxb2ZqnYjpdxrjIRpDMWTT1gEaEgICmyxlHOErOWc63le+4Njx/1pD3qoGsi4fqVcm/wFzEFDcPhEMQ474W7AcrB68rN3u0Pzp91qq6VMmDXMV6HqNY/DufRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pGueYa/+; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv5qe5g6D6LOmHoQ1vZklplbcofrgJmvaEvDaBuVPcs4gR9u0YBcVeXdZEOdxbqL7FO9+K0y57fSIST1xVW8sVgACjde5etUGDdKxJ/ULpZDAgbY3uys4Cd/le/cP6hDW6fi7gu+L4fpBpe1IspX6RLbOBQItx7wjfTnn6/BYK9rxUq9ir1qti9tXKwj0x680tWc890aZMPEaVVTwbCCT/dG/VJ27DpsVtfwV1MJVU5OKuevPozpQ1hpcXnH+DnZG1APCzt3dpcbDwrJuJhPUETMgKFd+QQWj8CXAFkdcjbsYQwkHbf0V4M3OGB4jbbaPGc5zVutzMlwBOrhvbBuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUd2VwYoSXWPO+yjTAQ+XKwaKZuuP/O9Bj2Yodtb+lA=;
 b=UcnalQMhoXSLrSq84K85KZVr09QmWPxjt34TVfJKna4ZVCYhusK7saGxMN8INM/V7yLDm/RiLdEDa7iZnCFkZBGBqB/CynOdsnFNahIaRh/1/jyt5mbF66ZykncDWo1/vmkmI7wKeFgSWJjziG8dkKf3iwainKgf6Xg77ZJfwm0gQLUEIYnlBPvKPhpULjdgfZiPANbawyFOctiDnUq5azwSgESat2KKcDUeEP723Qxzm3vJXzLzCvIarEobVIwN6G3sRihzkxX8U5ovVmE7CWTKG7KxTl/MwHuxWpaj2A/NSu6Hr8Yl3nO5ovU+FfKLPzacH7Eyw5WRBOnNuCLriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUd2VwYoSXWPO+yjTAQ+XKwaKZuuP/O9Bj2Yodtb+lA=;
 b=pGueYa/+m3xC8XAs+6TvkKtQCVwUqWGJL2QjDVMtC70nkOlJQROcLsZYQGvh8ZSzRSUr6Ebl+QQ0IvSms8i/1Mzj7YLRtioNQR3r5FnhB0s8i6XD3k9gi3o9HPszgxDm0iYVF0yKf1pbJyIDq/Bcmnj1QGoJ/kYBCSXojkIHYFk=
Received: from BYAPR07CA0076.namprd07.prod.outlook.com (2603:10b6:a03:12b::17)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 22:16:43 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::d2) by BYAPR07CA0076.outlook.office365.com
 (2603:10b6:a03:12b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 22:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:16:43 +0000
Received: from purico-ed09host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:16:41 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thomas.lendacky@amd.com>
CC: <michael.roth@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev: ensure that RMP table fixups are reserved for memblock
Date: Thu, 15 Aug 2024 22:16:30 +0000
Message-ID: <20240815221630.131133-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b21c21-a1e1-44ad-911c-08dcbd77f19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D9ZkHTNTibjUivXG07muiIvFjD9/rAaUEVU3QXBzJlJAt5a5LDgrXNfT2CM7?=
 =?us-ascii?Q?ZK9fS0upJ20zIeV6kpvTOL/nZWQgdQCpA/fvCaxEGDgw5HI77FNumKLP/iui?=
 =?us-ascii?Q?L55h1zeszB+GUtK3z7Egl22CddrwIAT3VbFk4AAg8KL2EEY8N8+1CgWQEsG9?=
 =?us-ascii?Q?knJrnFSVE7qq+Qoft8aiLfXK4Ojk4Ej9Ph8qHhbELP6jRjo67E4sp/TK8VU5?=
 =?us-ascii?Q?oMyrUFcOUeD+kZelPOPwBt2Y9mA8DASmL2xv6nB4W8J8Cz+460Y5LsPMRk/c?=
 =?us-ascii?Q?2jMiFXKOJIfzEkBWN0yLOaz/MD45VXcyG6TBW0L0IKfpeH91mGSApzlgfpUS?=
 =?us-ascii?Q?OD/pdnOl1ZsX9NK4oMHrx3pMsZPPkRvmc+YePTbqmrgT/OZlJMefsWeWH5Gj?=
 =?us-ascii?Q?qg26taDy8xHbDLZEKhC9hLyB6LryPnhBft1AJ2fTZ5JO5WZIJiksj57FpmdY?=
 =?us-ascii?Q?E1MZxhJUIMk7pNXJKWf6kYbKcjptGsMusYuAUsOCjnCXjag97nDkfzbpKZ4x?=
 =?us-ascii?Q?Bv3KtBmbo/GVMyO4IQCVe3EfAJOOfgwtzaKxdqWIdQkdbx9zaMqpljLLMM1a?=
 =?us-ascii?Q?03QxhH/ssYBFjdmccAgLulakO4SAGZoU1UPyPMKOObGfkTFx8BwMn3j4vqRF?=
 =?us-ascii?Q?r/I7GFVamvo/vcIGrjw9zpfvliRdRG6whQ1ZjTGfm4SU8vO4J2AGC2d25SAX?=
 =?us-ascii?Q?OmE2JSxPGGHWHxhNXsAHv3rvE7B+UCeX+y0Pnpd8a7wQzK7eQH5x6pvwSfod?=
 =?us-ascii?Q?xbKzOyf0qq/BBikRont9tGGqOldjAWNeAzQXHz6t/sUlsFImyL/hsNKKdFmP?=
 =?us-ascii?Q?Vea98QUDcUYiLIH5GR2xM+Wkfi1i//TTWJFdVK59NT+kCg/XlYaC09XsVoSD?=
 =?us-ascii?Q?4oW+bGIAS/+JTMzGDdr4s7KQpzLp22X4y7Vv8SFrq/LE6Hfcc5XgZbXwxNwZ?=
 =?us-ascii?Q?RXD4giaW6e11mrNWASs8B8pRMmh+oZh6aN/rQe701anCiiUNQrRu2GNlzogK?=
 =?us-ascii?Q?QUsJPaguVAn3gpx7TewEqG1s/AcJCnHVZOcs5JKq5x9l92CRdzXxYkBu6wep?=
 =?us-ascii?Q?i9rJSfe3a1nrUWrmMkZhJXYHWWONBFAOOcYJUNinIe9A43G1n+Y9CQ3Y/73Q?=
 =?us-ascii?Q?/RFA9YbxQJzRbhGAwsiNwuS06UBJviSnUhiU5Gop1KlZQnFLQ7eqXj0TjCJP?=
 =?us-ascii?Q?DQmtBrUh2vDRNgl34zNU6c6pvSzV6gS5JlaINR4FkWaIDJ63KQq7gywddQqY?=
 =?us-ascii?Q?UxIOxBXTahjq9bAzfEFxQwV39YfqXyhaRsLcANPFs8bD1bYQRygmcg4zAotI?=
 =?us-ascii?Q?4UyQRkoZESoyzJYS14gVS7mUHxFZrmUJoP33i++lpcavVoJ3z+szGx1mCYFb?=
 =?us-ascii?Q?PBPOgAxF64GMFGpx5w9qj5QuYZG1qWh0BNAKOMdXR42H1x7K/LtpH27EZkbw?=
 =?us-ascii?Q?0tbwxadQWfnGd62ZPFbbzqIXgdw6tx1l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:16:43.0558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b21c21-a1e1-44ad-911c-08dcbd77f19a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487

From: Ashish Kalra <ashish.kalra@amd.com>

The BIOS reserves RMP table memory via e820 reservations, but since this
can still lead to RMP page faults during kexec if the host tries to access
memory within the same 2MB region, commit 400fea4b9651 ("x86/sev: Add
callback to apply RMP table fixups for kexec") was added to adjust the
e820 reservations for the RMP table so that the entire 2MB range at the
start/end of the RMP table is marked reserved. The e820 reservations are
then later passed to firmware via SNP_INIT where they get marked HV-Fixed.

The RMP table fixups are done after the e820 ranges have been added to
memblock, allowing the fixup ranges to still be allocated and used by
the system. The problem is that this memory range is now marked reserved
in the e820 tables and during SNP initialization these reserved ranges
are made HV-Fixed. This means that the pages cannot be used by an SNP
guest, only by the hypervisor. However, the memory management subsystem
does not make this distinction and can allocate one of those pages to an
SNP guest. This will ultimately result in RMPUPDATE failures associated
with the guest, causing it to fail to start or terminate when accessing
the HV-Fixed page.

The issue is captured below with memblock=debug:

[    0.000000] SEV-SNP: *** DEBUG: snp_probe_rmptable_info:352 - rmp_base=0x280d4800000, rmp_end=0x28357efffff
...
[    0.000000] BIOS-provided physical RAM map:
...
[    0.000000] BIOS-e820: [mem 0x00000280d4800000-0x0000028357efffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000028357f00000-0x0000028357ffffff] usable
...
...
[    0.183593] memblock add: [0x0000028357f00000-0x0000028357ffffff] e820__memblock_setup+0x74/0xb0
...
[    0.203179] MEMBLOCK configuration:
[    0.207057]  memory size = 0x0000027d0d194000 reserved size = 0x0000000009ed2c00
[    0.215299]  memory.cnt  = 0xb
...
[    0.311192]  memory[0x9]     [0x0000028357f00000-0x0000028357ffffff], 0x0000000000100000 bytes flags: 0x0
...
...
[    0.419110] SEV-SNP: Reserving start/end of RMP table on a 2MB boundary [0x0000028357e00000]
[    0.428514] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
[    0.428517] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
[    0.428520] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
...
...
[    5.604051] MEMBLOCK configuration:
[    5.607922]  memory size = 0x0000027d0d194000 reserved size = 0x0000000011faae02
[    5.616163]  memory.cnt  = 0xe
...
[    5.754525]  memory[0xc]     [0x0000028357f00000-0x0000028357ffffff], 0x0000000000100000 bytes on node 0 flags: 0x0
...
...
[   10.080295] Early memory node ranges[   10.168065]
...
node   0: [mem 0x0000028357f00000-0x0000028357ffffff]
...
...
[ 8149.348948] SEV-SNP: RMPUPDATE failed for PFN 28357f7c, pg_level: 1, ret: 2

As shown above, the memblock allocations show 1MB after the end of the RMP
as available for allocation, which is what the RMP table fixups has made
reserved. This memory range subsequently gets allocated as SNP guest
memory, resulting in an RMPUPDATE failure.

This can potentially be fixed by not reserving the memory range in the
e820 table, but that causes kexec failures when using the
KEXEC_FILE_LOAD syscall.

The solution is to use memblock_reserve() to mark the memory reserved
for the system, ensuring that it cannot be allocated to an SNP guest.

Since HV-Fixed memory is still readable/writable by the host,
this only ends up being a problem if the memory in this range requires
a page state change, which generally will only happen when allocating
memory in this range to be used for running SNP guests, which is now
possible with the SNP hypervisor support in kernel 6.11.

For this reason, this patch is not being marked for stable, even though
it fixes handling that was introduced in kernel 6.9.

Fixes: 400fea4b9651 ("x86/sev: Add callback to apply RMP table fixups for kexec")
Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/virt/svm/sev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ce17766c0e5..9a6a943d8e41 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -173,6 +173,8 @@ static void __init __snp_fixup_e820_tables(u64 pa)
 		e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		e820__range_update_table(e820_table_kexec, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		e820__range_update_table(e820_table_firmware, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		if (!memblock_is_region_reserved(pa, PMD_SIZE))
+			memblock_reserve(pa, PMD_SIZE);
 	}
 }
 
-- 
2.34.1


