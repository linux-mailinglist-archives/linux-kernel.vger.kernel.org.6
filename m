Return-Path: <linux-kernel+bounces-287094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE39522D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006AB286440
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE7C1BF31B;
	Wed, 14 Aug 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hASncvI7"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2691B5804
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665066; cv=fail; b=ld8DgHjULkiFpq/HxqkSBa3PLYmKKkMHlZGhZfcHbJqmMe1GuMMnuGehsuNl4aO8IadXHqK0iUgcTe2MCurDKZLs5eJJa7/JH5uje/bHRfTfk5f48wfmQkNl7+jYvHxkpceaJliyneNgQUUYfPf09t3zGcU3OxuXaay9ajXIlng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665066; c=relaxed/simple;
	bh=O7SlO4jUWxkYC5eZi4nXFGEuF8oLFU4y6r+7/UlpaVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuxMQiJdHPDDQr6gmH88kAuySZkKPt5SzgcByoAYl2ZzYsXJ+aFAQaEqaT8h2Sw0hSl6NlCJIFGCwq2ZtoDfkKBc9sXWlC5b0Z2vZ6JixMtcOofV/HzO6c16/Qrtn79ti8O+SuwiliVHTjLYY5GrWj4ZBMU2YgOxqcxL6CgADGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hASncvI7; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClUctrHiLeeVxjjlO3I5JV86fvfIbOoDHdcHf3381Ur5XhNHPIRYuHFJ48xvtICSS6lIeYb7QvXT1ijbsIHwirVKe+le3o93sEhVy0bWDhWIIAG5t81S+oS3L1ExH0/J3DkBbBmbXUEVHIxtIwE04zwAYVLlDco2gs88k0EoVh06NJcNK2DaDbB8v9u4Yi2AmnDh0pPCcuxV1Q+EUDJW4I0pm0JtaCQIDBUz6htB7SIaIaAaVooUl2OdFWejYWepTI/ut/hSK3K9iE5qvYDhkbzlGyVqZKfy3TALsWSwwQnM5/+gxctSaeZKqERTUOchE4Q5uUBRZR/YCpEY033f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=726QpRcn+lvf4rCuApM2KwRHNgakfInv/OKNIzKT6VQ=;
 b=N/OCJHenfd8GrkLCGyVvzqUQtgI7qm+DkJVVnrOKEKZ7IOW7O8bTdwfd9zH7oYhJQsYeLtbx3iJae1OyaPPbQGwiPZV25IxgKZzsRGrzYFjXTXqlgPvJMKdbY1AFpA4ABxABIR8QsU7Cx81N5ZbhZkbNpbnRGVHGWleSMQQjHLT0fExX8NxDMHPNocxOW03it69nQ3HuH1bXsa+Znsvi5ZrBmIbbWipZqb+1zFkrWnlLaesfCuA6PxUlfaFvNDUjwq2w5d/fjrYBqZcDuIIHFHM3WfPzwxFGahHW97hoC3SgOp2EHdpUFxpBpE7JTIl2zzpsA7j4DoMpNA4qJHanHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=726QpRcn+lvf4rCuApM2KwRHNgakfInv/OKNIzKT6VQ=;
 b=hASncvI7nC6ehjU+hsWeU46XeP/bmnEZQt1s0MdgmZ6YAsB3bu4WdvKT1im/ytH1B2h2yCOCPYyOt76PE/A18n35Vwk9NTyyWGG2f+Ie78T7fstOsl58OmwJaegt+axtoHLegtdXIH2MMEqm+GgbEgzBFfg52rvgZzZJaqrfpYM=
Received: from MW4PR04CA0091.namprd04.prod.outlook.com (2603:10b6:303:83::6)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 19:51:02 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::4e) by MW4PR04CA0091.outlook.office365.com
 (2603:10b6:303:83::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 19:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 14 Aug 2024 19:51:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 14:51:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 14:51:01 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 14 Aug 2024 14:51:00 -0500
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
Subject: [PATCH v2 2/5] x86/pvh: Make PVH entrypoint PIC for x86-64
Date: Wed, 14 Aug 2024 15:50:50 -0400
Message-ID: <20240814195053.5564-3-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814195053.5564-1-jason.andryuk@amd.com>
References: <20240814195053.5564-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d40ee4-e912-4ded-44d1-08dcbc9a6d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5fG4thVHpJa8UBCnUBBURbKKrtZ9+8rNhat9p7NjhKvaO0QpxDzmCEIH0ez?=
 =?us-ascii?Q?bRop2WDvuY5lOBZTNOu2KqnHDR0vc5bZNGJW15cv7tn+iP0WfUD//eUBnNQ+?=
 =?us-ascii?Q?kpLIAgr0fkX9SGXMgReCz5vCfl89zsrahxHS6j7vD6paZXRa90Rh4RBZEgjG?=
 =?us-ascii?Q?RZrnihOOwXFbIG87amymTi3cAhZTwCkSJ/RbIxbCLRBZh59cjlFi2IpNSdD7?=
 =?us-ascii?Q?Jrj90dKr476tys7q4tDFl9h+aIK4sOFXYZa4YAW0XcZNU8ejBJAWRfMCRNdd?=
 =?us-ascii?Q?SjviAZlkGH9qjLfZ1PtmZHeoh3FPlnpIz/crQp5IQecQbEWTKNKNZbxSzlzw?=
 =?us-ascii?Q?vl7e93yzk4op+ZJhx65DvRCzAAwxFMQgUk3o9HqrC1rP5cJzOatlHiAhAM2z?=
 =?us-ascii?Q?watF7tqEAem8bg34/8zg4g0CzT4RHWD9J49JGHs8LGSUFWhAl3XcUT00eZFF?=
 =?us-ascii?Q?ryWrCYNzPTTqfEvlp93fpCmwwLh4Avus7pJHuSxnx5xpJ1f5FISR4na+aGwj?=
 =?us-ascii?Q?uCAvze4MdGlyIB+dbabjigQ813WoSPsi1/gcb3Vs2DZyV148N6PMJzsrGG2T?=
 =?us-ascii?Q?VxQ6zg1pzT0XCIWdmsYGPOp4bERQPDiczsAENmwUA+RCFCSaJDJFXmB12Tbm?=
 =?us-ascii?Q?hlJDAaoQLZDsUapt5IhTxithiXSqYo3lcyYORMs9TrfddWVlV3etu2SFlKtw?=
 =?us-ascii?Q?K4WgFUtTbsYdBwfuNoradvKbriUHKPoNf1N0rZ2Wl9UF/1ZhV/CylbJUPWiQ?=
 =?us-ascii?Q?ieFmbCdXlUX3gv1rz6MBGvSdSZyzjgcAoDsDjtMP83Andl20RxRmMp67Oeyz?=
 =?us-ascii?Q?+AeM+AZYa2rgfW8VfFimumvJ0bHyrIRilnH4XBdaeT8Ch1C/dm7gWWRJQC7D?=
 =?us-ascii?Q?XDMJQWsjHk7/ZZd51bmsIWDdkQMxupzYbySzU+17FLA6QY/j9zbNEfAd1owW?=
 =?us-ascii?Q?5+oiyifA4bVmHHgdHJ4kp27VXTDJyvWLLNJDfnKXm8QhfwO42D2MgSAT4hYt?=
 =?us-ascii?Q?+3OhnjTBwqEGYGKaP4VcJWj/DC4iel3kIWX0949Hhv2MYz6xkHbM8aST2W+x?=
 =?us-ascii?Q?ml/Lh0HvO1UWAdxVHoOL+DKwCynjsaPGADLfbB9ri5DGZqkkcrIQEq3N6e+n?=
 =?us-ascii?Q?5sgfrgYehQCvdn+kp5tK6QnSxpGTcfA+Cxy3/H+7D2Wd5CAj5/SRt5GHM/s5?=
 =?us-ascii?Q?EE9JNoYu5RZR0L08nJvNfMLZf4V3CERfssJsmNlQySpSfhNvyL3AQRSdl7qR?=
 =?us-ascii?Q?Ouimx3pY40hB63zfD+nOFSWSrHOkp6d3CfgK/SQqzCACqsDK2yyfOdy1g/oj?=
 =?us-ascii?Q?yYg+TrTN0LWwqx8+Fh6tvBpJby03OyyfS/U/EHuTNDqDjw1ybdne6qhDcN4x?=
 =?us-ascii?Q?rVkr/p6x0/rsWaD94w44s5qaPECeBlk1ln/G9PXNdelkA1OsC7ecfVK7lNpV?=
 =?us-ascii?Q?zV3liZNppTISEHEScOAvWXhalipSRoYUPu5suOlW5rPJlEOrjGZnOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 19:51:02.1650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d40ee4-e912-4ded-44d1-08dcbc9a6d40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

The PVH entrypoint is 32bit non-PIC code running the uncompressed
vmlinux at its load address CONFIG_PHYSICAL_START - default 0x1000000
(16MB).  The kernel is loaded at that physical address inside the VM by
the VMM software (Xen/QEMU).

When running a Xen PVH Dom0, the host reserved addresses are mapped 1-1
into the PVH container.  There exist system firmwares (Coreboot/EDK2)
with reserved memory at 16MB.  This creates a conflict where the PVH
kernel cannot be loaded at that address.

Modify the PVH entrypoint to be position-indepedent to allow flexibility
in load address.  Only the 64bit entry path is converted.  A 32bit
kernel is not PIC, so calling into other parts of the kernel, like
xen_prepare_pvh() and mk_pgtable_32(), don't work properly when
relocated.

This makes the code PIC, but the page tables need to be updated as well
to handle running from the kernel high map.

The UNWIND_HINT_END_OF_STACK is to silence:
vmlinux.o: warning: objtool: pvh_start_xen+0x7f: unreachable instruction
after the lret into 64bit code.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
v2:
Use rip-relative loads in 64bit mode
Direct jmp to startup_64
---
 arch/x86/platform/pvh/head.S | 46 ++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index f7235ef87bc3..ba4d0eab4436 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -7,6 +7,7 @@
 	.code32
 	.text
 #define _pa(x)          ((x) - __START_KERNEL_map)
+#define rva(x)          ((x) - pvh_start_xen)
 
 #include <linux/elfnote.h>
 #include <linux/init.h>
@@ -54,7 +55,25 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	UNWIND_HINT_END_OF_STACK
 	cld
 
-	lgdt (_pa(gdt))
+	/*
+	 * See the comment for startup_32 for more details.  We need to
+	 * execute a call to get the execution address to be position
+	 * independent, but we don't have a stack.  Save and restore the
+	 * magic field of start_info in ebx, and use that as the stack.
+	 */
+	mov  (%ebx), %eax
+	leal 4(%ebx), %esp
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call 1f
+1:	popl %ebp
+	mov  %eax, (%ebx)
+	subl $rva(1b), %ebp
+	movl $0, %esp
+
+	leal rva(gdt)(%ebp), %eax
+	leal rva(gdt_start)(%ebp), %ecx
+	movl %ecx, 2(%eax)
+	lgdt (%eax)
 
 	mov $PVH_DS_SEL,%eax
 	mov %eax,%ds
@@ -62,14 +81,14 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	mov %eax,%ss
 
 	/* Stash hvm_start_info. */
-	mov $_pa(pvh_start_info), %edi
+	leal rva(pvh_start_info)(%ebp), %edi
 	mov %ebx, %esi
-	mov _pa(pvh_start_info_sz), %ecx
+	movl rva(pvh_start_info_sz)(%ebp), %ecx
 	shr $2,%ecx
 	rep
 	movsl
 
-	mov $_pa(early_stack_end), %esp
+	leal rva(early_stack_end)(%ebp), %esp
 
 	/* Enable PAE mode. */
 	mov %cr4, %eax
@@ -84,30 +103,33 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	wrmsr
 
 	/* Enable pre-constructed page tables. */
-	mov $_pa(init_top_pgt), %eax
+	leal rva(init_top_pgt)(%ebp), %eax
 	mov %eax, %cr3
 	mov $(X86_CR0_PG | X86_CR0_PE), %eax
 	mov %eax, %cr0
 
 	/* Jump to 64-bit mode. */
-	ljmp $PVH_CS_SEL, $_pa(1f)
+	pushl $PVH_CS_SEL
+	leal  rva(1f)(%ebp), %eax
+	pushl %eax
+	lretl
 
 	/* 64-bit entry point. */
 	.code64
 1:
+	UNWIND_HINT_END_OF_STACK
+
 	/* Set base address in stack canary descriptor. */
 	mov $MSR_GS_BASE,%ecx
-	mov $_pa(canary), %eax
+	leal canary(%rip), %eax
 	xor %edx, %edx
 	wrmsr
 
 	call xen_prepare_pvh
 
 	/* startup_64 expects boot_params in %rsi. */
-	mov $_pa(pvh_bootparams), %rsi
-	mov $_pa(startup_64), %rax
-	ANNOTATE_RETPOLINE_SAFE
-	jmp *%rax
+	lea pvh_bootparams(%rip), %rsi
+	jmp startup_64
 
 #else /* CONFIG_X86_64 */
 
@@ -143,7 +165,7 @@ SYM_CODE_END(pvh_start_xen)
 	.balign 8
 SYM_DATA_START_LOCAL(gdt)
 	.word gdt_end - gdt_start
-	.long _pa(gdt_start)
+	.long _pa(gdt_start) /* x86-64 will overwrite if relocated. */
 	.word 0
 SYM_DATA_END(gdt)
 SYM_DATA_START_LOCAL(gdt_start)
-- 
2.34.1


