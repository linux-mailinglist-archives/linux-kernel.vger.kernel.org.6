Return-Path: <linux-kernel+bounces-202817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF68FD17F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C01F24701
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109DF14C592;
	Wed,  5 Jun 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gibihAjz"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453ED188CA3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600819; cv=fail; b=sv0lGF8DCwjhLMKerU6c/UbPE/lxJUl2MZfVg+QyMohnQHeEgphSSWBuHotdrMDRBQHWDE10z5mFwsnobOzh1rHYd5i0aYVoTEhdddGu+xdiAsK05rbeZh5m6vV39C324Z6av02aUe4WcFIaOMGny+vDWBMCFH+SQh1G+nRCWUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600819; c=relaxed/simple;
	bh=eoju5O5rT6GH9dRuLSPadDkh1L1NJ69BtLKEswXMNyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldf7RYCwbzISPVUfnb8NpmdhLE9O4f6l+AumM8F6pKQH3odoQpq+ZEQiEEqbL8pQQAUSHrl/rpeDmiqZic4ItEGJ05VZ775A6VbXOI7iWZD58d+CqS5A9d7hPrwC4RSSPKeoq7dyJRUD9a5z7gSuuZQQLYKVLkYVn3N8VHmBLqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gibihAjz; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1ruU81VxyNt9w01ZiQXtphRSqC5shTzP55VOnQ+QqmAxTHLuHJ26IZW+EtSbLI2ogO2nLuXbNuIOfZXklLYBzSFN35wahzuUzLC/ILDmwS6RGp8a8ka0RckALz92sTz/lT9UiT5tay7pEiP6/69XDH1C222llPXU4b1WlQLl+Sd1lxzBdx3YdsDm77U/Iw1GkxfmGRC+eruB7E7nF72t2FMELgSpctEJ8cU34d0Cvr5PkR32ggh38xAFguWwVVAxiF8mD44/UjkeQHEAv8r6huAxfeg6tghFTIsaLmayRNn1KnWt/VZeGqzb5iaFj7BTVXMhHOiiOjJctjnkb/ssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzeSj+sUzj3hgQqk6L6vstC9tEv6wqQVMdDGWDD/dVo=;
 b=meqfH07sItXytvJ3e04vTCNqxeEldb03/QQOmzM6igaO9ARclwGI/NjR1YIpoZNed9uJiV+m4BcmR24M99dRtNSHIzKa9+dUEaL03bUEo45L5a6yhpCit3DaYmZfO4cco9PTh+/2hQspbF91umNyRIipcnRofwSGhDcmkUV7AGj+htiGXM5t1S7z5ZMZcnmKCScckEdTyqnRhYa5mTV73MQ+QPm2Fpno/IBdBDd5ibJwhYgFNoO2wxvtVKUr/NqoWJIAT1dOeDBaTf1y44BScJQkBSTKyoKoS1n3c4vPJhLUnL80kASiRVBJqg1ffxYT5569bCiGwHXDHPgTnoxHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzeSj+sUzj3hgQqk6L6vstC9tEv6wqQVMdDGWDD/dVo=;
 b=gibihAjz2QgA8LoJ+i9ZDOB/yvTspNmEgV0PMGUsBOfM0R1WS9i1sHiqv5X6VdNqSX8TZdWakssmeINow6pZgpaKvtHQJ59PBfCaC1Ehsw/Za5s6Azh2grNa2gvyI3VsXK9aOXaHAXWuKndFcdWi6j2b7oTXneNa8de1/nwx3Cw=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 15:20:14 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::77) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 15:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:20:14 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:20:13 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 08/13] virt: sev-guest: Choose the VMPCK key based on executing VMPL
Date: Wed, 5 Jun 2024 10:18:51 -0500
Message-ID: <b88081c5d88263176849df8ea93e90a404619cab.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1717600736.git.thomas.lendacky@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: fe231be3-9941-4749-c9a9-08dc8572ffbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9I034238pM7yRuHtEyCqACWAas6kT+po1hqqviYGed/rj72GFSWOCQZpUqJO?=
 =?us-ascii?Q?LVJy+uRlxQCkvej+zGhKwsV8uFkR4cosvmhdBmHQ7J9y9DMT1cggo/rwsJpU?=
 =?us-ascii?Q?U4Rvkg0rL3exMHTcfSv6FI8r/yvDRNkRwUMMJfVuf/S4qx9VZNbzY38CWri/?=
 =?us-ascii?Q?GTI0MpZQPAZ3qZA3Zc7CMtN7eFm2xF27DFuM4HOc/TMavsLhWitmY/xK/ouc?=
 =?us-ascii?Q?S1BkGXUBEpotHrD8YXCl1gVRh1CoTGBhY0tXK7Z1PDcN9Q02ssh3NIc9F/nW?=
 =?us-ascii?Q?zlvH3IfqUKNQwtV+ynLPKrgfvjrIdjeDbMnRvrZ/gNFeOSVAPupyYlzVAPwS?=
 =?us-ascii?Q?OGFtI00fjw2eyfV+zn3y9AHSWBDWZTZyaB7uVakDhZks2o9BDZ6IjDGekoR9?=
 =?us-ascii?Q?Z6MSqN9vjBBEirPaA2KWycfGMb1L8PBbNWVg3WiVd7uyeispiMBv+0L8n518?=
 =?us-ascii?Q?hXq92tKzVYRtIHCydA6WL2G1pzxLl05JzCOzP+10U/Nbi7shyOd2miwP1dJK?=
 =?us-ascii?Q?SZWLMcEoINNxR8LYLU8br4B1mdaj8xksk8Rtv9PsQXwRUoFHtIhhJJnfvg1D?=
 =?us-ascii?Q?vPhkGAg4217rIbQYNO5AJ0tIX3wstqsq9fgbHnhd2+fo6HY72uhFd6AH6I1P?=
 =?us-ascii?Q?YVLiq5UDyfQaO84IPd78y6YMlSom418oFaYCyNk5SxDGZfx4oOiKWwXt5YwX?=
 =?us-ascii?Q?+sVDRUkcv8wSE2CwUNiabPtSQTCsX/y3PnvRwALp/eT0AHl2mqIDayBJY8HX?=
 =?us-ascii?Q?c7QUsY0T8n5u6PmZZAu260XYU/bklDcMjr00nfrdeSVfKDBEazdBtPUCOS7V?=
 =?us-ascii?Q?pDbMg8Y+CQz6Bod3qr5WtkCzITiH2i7LHexVsCgBdnEK6j4yHbiMTZC5RQvQ?=
 =?us-ascii?Q?sHDII6HD1UHk+kOPNs1UfTZUFd8xAO14KZIC2p06H+tmKNd2CC0xD9xEp8ZE?=
 =?us-ascii?Q?X9hITFXZ0DbiVTAw8m/o6WmfQj4E97mPrj63pZlD6t2/pStmMxJvKLEj6Q2Z?=
 =?us-ascii?Q?Wy7rO4utrD9BYRry7pSwbgamtoWPOAihsBM3HZwd2FM6rumiDLBPDd0vIlEk?=
 =?us-ascii?Q?uvMA9a9X9YVJdZV1IgNm4LnhC6XLDS8DyyT05nxAj6zz3DdX5G02lR6QOaQg?=
 =?us-ascii?Q?BnPHdA/c3BsUXpPs+D/JrDRY3a0T2q+qFIexGQfC9jbUlM64AazVsx+Ee14c?=
 =?us-ascii?Q?x+pg6uoVjTd1rHLm7+4QxmWkwdvkn6DfyDwRVP2/rELXGknImvpmh8hAQsTp?=
 =?us-ascii?Q?K30ZdPsT1oZdzJsx2VOav6GYJmvak/hyImSBtuuS3leXtZt81RD2vf5q81qk?=
 =?us-ascii?Q?2sdc5pWylZbsqSX0Vn9ocqxhw2AITeRF060QsuFUcKUIoDC/znB5a5hNYCBU?=
 =?us-ascii?Q?+n9ujFxWSeGDbGnKp8SStR00dWtOA/8XjxvUmaR6G0DWWH/Yhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:20:14.2471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe231be3-9941-4749-c9a9-08dc8572ffbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

Currently, the sev-guest driver uses the vmpck-0 key by default. When an
SVSM is present, the kernel is running at a VMPL other than 0 and the
vmpck-0 key is no longer available. If a specific vmpck key has not be
requested by the user via the vmpck_id module parameter, choose the vmpck
key based on the active VMPL level.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/virt/coco/sev-guest.rst   | 11 +++++++++++
 arch/x86/include/asm/sev.h              | 11 +++++++++--
 arch/x86/kernel/sev-shared.c            |  3 ++-
 drivers/virt/coco/sev-guest/sev-guest.c | 17 ++++++++++++++---
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index e1eaf6a830ce..9d00967a5b2b 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -204,6 +204,17 @@ has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
 Otherwise, guest owner attestation provides no assurance that the kernel wasn't
 fed incorrect values at some point during boot.
 
+4. SEV Guest Driver Communication Key
+=====================================
+
+Communication between an SEV guest and the SEV firmware in the AMD Secure
+Processor (ASP, aka PSP) is protected by a VM Platform Communication Key
+(VMPCK). By default, the sev-guest driver uses the VMPCK associated with the
+VM Privilege Level (VMPL) at which the guest is running. Should this key be
+wiped by the sev-guest driver (see the driver for reasons why a VMPCK can be
+wiped), a different key can be used by reloading the sev-guest driver and
+specifying the desired key using the vmpck_id module parameter.
+
 
 Reference
 ---------
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 36cd7aebaa9b..f7a966e99a73 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -237,6 +237,9 @@ struct svsm_call {
 #define SVSM_CORE_DELETE_VCPU		3
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+
+extern u8 snp_vmpl;
+
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
 static __always_inline void sev_es_ist_enter(struct pt_regs *regs)
@@ -320,7 +323,10 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_remap_svsm_ca(void);
-#else
+
+#else	/* !CONFIG_AMD_MEM_ENCRYPT */
+
+#define snp_vmpl 0
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
@@ -350,7 +356,8 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_remap_svsm_ca(void) { }
-#endif
+
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 #ifdef CONFIG_KVM_AMD_SEV
 bool snp_probe_rmptable_info(void);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index e91fcffcf602..10599e66c5fd 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -36,7 +36,8 @@
  *   early boot, both with identity mapped virtual addresses and proper kernel
  *   virtual addresses.
  */
-static u8 snp_vmpl __ro_after_init;
+u8 snp_vmpl __ro_after_init;
+EXPORT_SYMBOL_GPL(snp_vmpl);
 static struct svsm_ca *boot_svsm_caa __ro_after_init;
 static u64 boot_svsm_caa_pa __ro_after_init;
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 654290a8e1ba..4597042f31e4 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -2,7 +2,7 @@
 /*
  * AMD Secure Encrypted Virtualization (SEV) guest driver interface
  *
- * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
  *
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  */
@@ -70,8 +70,15 @@ struct snp_guest_dev {
 	u8 *vmpck;
 };
 
-static u32 vmpck_id;
-module_param(vmpck_id, uint, 0444);
+/*
+ * The VMPCK ID represents the key used by the SNP guest to communicate with the
+ * SEV firmware in the AMD Secure Processor (ASP, aka PSP). By default, the key
+ * used will be the key associated with the VMPL at which the guest is running.
+ * Should the default key be wiped (see snp_disable_vmpck()), this parameter
+ * allows for using one of the remaining VMPCKs.
+ */
+static int vmpck_id = -1;
+module_param(vmpck_id, int, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
 /* Mutex to serialize the shared buffer access and command handling. */
@@ -923,6 +930,10 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!snp_dev)
 		goto e_unmap;
 
+	/* Adjust the default VMPCK key based on the executing VMPL level */
+	if (vmpck_id == -1)
+		vmpck_id = snp_vmpl;
+
 	ret = -EINVAL;
 	snp_dev->vmpck = get_vmpck(vmpck_id, secrets, &snp_dev->os_area_msg_seqno);
 	if (!snp_dev->vmpck) {
-- 
2.43.2


