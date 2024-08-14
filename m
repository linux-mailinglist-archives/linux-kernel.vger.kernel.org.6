Return-Path: <linux-kernel+bounces-287092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF99C9522CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2041F235F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66FF1BF311;
	Wed, 14 Aug 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v34jRRKO"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E724370
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665065; cv=fail; b=rGyt7x1Ole7T23J++qlwKjCzjW98gdoOzWJxtZM7TECfnaazYOgKkDmUCIHr3aV/4EdCjeOcW8PzIyNezme0iqktjlfqZfKsb3hehWeTeicy9ICLHiaHtmrY0L78gynUrTmLjm381/JXhQ7HWv0ZC3d4jjzctrrosxw+G8e0a0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665065; c=relaxed/simple;
	bh=DBy1pBPwWhzf2QC/za3yhekYxclKbsVEOduI2GfDglE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxlPlPqKVZKR/Q/qvMK/tv6/IE91199xN4VUYDCPvDF7ombETg/y0kQx6snw6tG5IvRG1fJvp8d1kTXxBdjdLXMcAzrOlYDS39fXkvofUCPwrPX4hoAiOatkcBpv0tndtBLyPPbqySZY78SzGYXtU7/aGP1+nU88gcasThxxd7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v34jRRKO; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnDHcebIiKZBckRdlaBcqOO0aBzOYgsPDMoRRLuZ3c03hB9Xi6e/avmXmOXWZacJLyOeM18ZtZmGMIrDTBGKJQTtaIeMW+GM08Ydh1Qn+CwbikwRF2e9nWbrnmXx38t5MMh38Dg0dZn/Fd5CHLlADo6VV2m2ZnijOTb5eY05MROTxFbNLAoxcJ6ENLsttjfbWQ0kuYlJjf18SvVCRfCrzIko1LXzJVL6e1YhxF9eKGlp1X47k9I99Lpr7OPXwWsSwKe//rwfhVSkwWwpT9fQHP2PNATiBxNsNX3yBnudpsTYNfq3WT9/UChUdr1EZtYaX6lwIl35Jsd+yEvfUpXtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPive7oFSpF3kUon9qB7Mth2EU8W7EIwN3zy7ldimdI=;
 b=KjmBqgB/plvnu5KDgtcPzfNFdqEeeMhRlhbCU7JZVDz3iXHNqrj3ugshqqrw7co3QWdmzFB5FBpd3bfxg1DIpMffOJ+3dK5GTKwuM7kWS9aibcMATuUcIPoJBMU7NwLui5NIWnFI1EEPxamV5L7q/yV/ZkXzROso7q1raHwAhtIz1JUoCm8WfRm8zSkhO+hMpxLErbf/+kiN4LrZ1z00dRIxaGmMVVt4olvh6NQd0SB3thzcFQd+k66W0/XMTOhzQoMaBanrwlzn7Xg5we8uiyIMXGonyiZe5/5ojnPKX8h96fcAWq2NLgrjd73QcufHox56qPIZYjm2IJyepb0vjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPive7oFSpF3kUon9qB7Mth2EU8W7EIwN3zy7ldimdI=;
 b=v34jRRKOCjRC5v7S3MmvOiVbPu+RwUM5UPxTftYUQV4sy4/ODao7fwqp2lfpteEPQbq2XwYE2BOx/9NqvZPUKL8OUvyqyo/5sbdf/CHvnhO1qkaE4pEqD3j3mkggp3fh7FWWOL1OV3dBsZxN1LU/d2bK4ToxQSHucvW77oPP1lM=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 19:50:58 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::c3) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15 via Frontend
 Transport; Wed, 14 Aug 2024 19:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 14 Aug 2024 19:50:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 14:50:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 14:50:56 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 14 Aug 2024 14:50:55 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, "Oleksandr
 Tyshchenko" <oleksandr_tyshchenko@epam.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Brian Gerst <brgerst@gmail.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>, "Jason
 Andryuk" <jason.andryuk@amd.com>
Subject: [PATCH v2 0/5] x86/pvh: Make 64bit PVH entry relocatable
Date: Wed, 14 Aug 2024 15:50:48 -0400
Message-ID: <20240814195053.5564-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 787b21a3-a69f-4238-9fd7-08dcbc9a6a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZASMzansHKLokB6q3tiCnaMpuPt7J6tEWSHVH8xzQQznqyddxrdLoTuqm3ZT?=
 =?us-ascii?Q?LgB40USElUboNIpKtbLW7tdHak53NesaovCIjZRg8oxqHZqpOIU+OueOmfEb?=
 =?us-ascii?Q?lh/3gXD6i/Mc9f27Ix4FE9tzH3TdnbM7ubN6iLqqvEbhgAepk0G5S5l3miIo?=
 =?us-ascii?Q?ZHZZcuArGbOnk5VBurXjB7dL/Y7apn/rx4Md5dap8cAklURNEFvBqVshu7jZ?=
 =?us-ascii?Q?jDO/Lq0iaadjG6iTOGE/171a6M9K/emtfNJWLu/7lfEDsBgFS4vIctvdkzbP?=
 =?us-ascii?Q?owcR5kdHkXj4U7RfGdYr9K0j1KHfgzrArrkMxCWFum7oUueHioilf6Nl/NJ5?=
 =?us-ascii?Q?wqTfZIS9JU9W6lw6LY8t8fB6Eyj+1abA6S3HoI6e4jykO+s0I8xSXeN1hn1+?=
 =?us-ascii?Q?WBfggd/GjSt5kv/lIPTvmDHmtC8e9Gs40lGJlj6+IFZSOe9Hj/++kRkiYNuX?=
 =?us-ascii?Q?yrL3eZcSh1ZyrbxqHA2tfp6OWXJZe1WIzvAzL+O/BAggg+6aZk4cHIfJomFe?=
 =?us-ascii?Q?BVymehb20BPtil33HvtDk7sqOxFP/rVMi/44JPmliYW49Mxa4JYWAkIxvQlw?=
 =?us-ascii?Q?NKRS3rPUSBRCfbJcwXX6nzYqYwG/dGoSk1zUR6/CgrUVo71YVMN4KPFuhvyy?=
 =?us-ascii?Q?bJJB4sWAFZH5NbZAH56pSUB7jjLciAAlqhLRctewydY1jclaEjrLdsZyzAvo?=
 =?us-ascii?Q?C1hl9R+2214MmRLrgnnY7VYmWud8VZW3JRBMszyP8+XQ/AUALoXmuiTuYJrS?=
 =?us-ascii?Q?5F14tTkdf430Xtj6Eo5bjg1K7yC6kDwCmFK1tMXIcqwLUi176eQVJtgstCO0?=
 =?us-ascii?Q?B1LSSeHMZ7BZhCyAdMUSTKX0v60rQpCnEFMDOacYyvgCXl25BDzuUL9FlhAP?=
 =?us-ascii?Q?IWU1W3lKGypQRE7jft8w+0Ifj4OWKFxpxuvkWdZWbbnvUyFxVFe9tJKKxlgf?=
 =?us-ascii?Q?FdXeDLViRg0PkWFKs4bKdH44GEenNueOUb3D4wxTayS7Y82FYh4+/u4HYPDf?=
 =?us-ascii?Q?fu2ghXQ5+SLFjEPecN68OL3kBB3KFMbdALh3md8PaOnHnfBjbnvRXUQaQaHo?=
 =?us-ascii?Q?kQ/wtTE9qZehI9bgAHq8ila3/Lh1WFaKUMKYFXyH+Dq1UnksYEwfGpom0Kys?=
 =?us-ascii?Q?jYsMbuNZrQPzwGekFNmLyC7gwublv+bCNiDnPRWPVORo93eubvY+CUY13ez4?=
 =?us-ascii?Q?MwBjXhqveKLssvyJo060y+SyFXyOUbodGbdFJIAGKPxwIPFfau8j2zVyh+pO?=
 =?us-ascii?Q?/6KYb4Zmc0jNOc0Ajq907T4Sr5jAKdujwI/F9xUZxvlBRXQ0WC5XbL6d2ydA?=
 =?us-ascii?Q?EwElog1lwoG2bUvl4/S7yasOQYDIIcP/20nCJyB0r5JNApUjxy41jr/8o6Yd?=
 =?us-ascii?Q?7uPP4+ZExEel9OpRUIU5ysMxR3nrfdFPDhAW0uJkGjXA0gZ+RSXxIqT3MTEn?=
 =?us-ascii?Q?1kR+pFIJcaoWihOh64WdVf+pxSWh/CLAlL2uZACUIBDWYIR9jxuI0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 19:50:57.5692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787b21a3-a69f-4238-9fd7-08dcbc9a6a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801

Using the PVH entry point, the uncompressed vmlinux is loaded at
LOAD_PHYSICAL_ADDR, and execution starts in 32bit mode at the
address in XEN_ELFNOTE_PHYS32_ENTRY, pvh_start_xen, with paging
disabled.

Loading at LOAD_PHYSICAL_ADDR has not been a problem in the past as
virtual machines don't have conflicting memory maps.  But Xen now
supports a PVH dom0, which uses the host memory map, and there are
Coreboot/EDK2 firmwares that have reserved regions conflicting with
LOAD_PHYSICAL_ADDR.  Xen recently added XEN_ELFNOTE_PHYS32_RELOC to
specify an alignment, minimum and maximum load address when
LOAD_PHYSICAL_ADDR cannot be used.  This patch series makes the PVH
entry path PIC to support relocation.

Only x86-64 is converted.  The 32bit entry path calling into vmlinux,
which is not PIC, will not support relocation.

The entry path needs pages tables to switch to 64bit mode.  A new
pvh_init_top_pgt is added to make the transition into the startup_64
when the regular init_top_pgt pagetables are setup.  This duplication is
unfortunate, but it keeps the changes simpler.  __startup_64() can't be
used to setup init_top_pgt for PVH entry because it is 64bit code - the
32bit entry code doesn't have page tables to use.

This is the straight forward implementation to make it work.  Other
approaches could be pursued.

checkpatch.pl gives an error: "ERROR: Macros with multiple statements
should be enclosed in a do - while loop" about the moved PMDS macro.
But PMDS is an assembler macro, so its not applicable.  There are some
false positive warnings "WARNING: space prohibited between function name
and open parenthesis '('" about the macro, too.

v2 addresses review feedback.  It also replace LOAD_PHYSICAL_ADDR with
_pa(pvh_start_xen) in some offset calculations.  They happened to be
equal in my original builds.  When the two values differ,
_pa(pvh_start_xen) is the correct one to use.

Jason Andryuk (5):
  xen: sync elfnote.h from xen tree
  x86/pvh: Make PVH entrypoint PIC for x86-64
  x86/pvh: Set phys_base when calling xen_prepare_pvh()
  x86/kernel: Move page table macros to header
  x86/pvh: Add 64bit relocation page tables

 arch/x86/include/asm/pgtable_64.h |  23 ++++-
 arch/x86/kernel/head_64.S         |  20 ----
 arch/x86/platform/pvh/head.S      | 161 +++++++++++++++++++++++++++---
 include/xen/interface/elfnote.h   |  93 ++++++++++++++++-
 4 files changed, 259 insertions(+), 38 deletions(-)

-- 
2.34.1


