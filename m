Return-Path: <linux-kernel+bounces-406563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DD9C6442
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414BEBA12F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7760E217F28;
	Tue, 12 Nov 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r7GPgT0U"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4A217455;
	Tue, 12 Nov 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437579; cv=none; b=mGjNy1QwMD4Umw/88i/JAqlanDu7KMI8GwAHjCYoEQEVFfSbrYVN6chpraVPac+1lEWh/DFjaORcr1njbIoYyoyIvV9TBnYGtBW0c19ZQps9/WeAtL4moa2QRzgmU4TXp2uOEp7KVJfD7ZiVE+Y3swh65dvs0lXXI+Wc9ixT/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437579; c=relaxed/simple;
	bh=YgHRSbxC/ZXv72RVmDXFLg/VmGfgqNxNSpewO/fOLmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kfr6vEaLsVprQyHhKS7yM6i0eVOHquFLZsps4VlwxCga5MHKmPZtOkIexUCkpP5KjOXfvpVwgpNKb00taVM4zORE7cx9zjo51nsI/nxj75EoeBchKptl6dIfL7YB3AeU+D+yNmA5K0B5w7aezPreuVd9iHIjCNdWxT7nJRQLvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r7GPgT0U; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731437577; x=1762973577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPTdqkauhYcoU/yyHwIv52pl8ORMHMvmHcj/aCkgZf8=;
  b=r7GPgT0UKy8JSPVK7BnhjSS8/UC8MZgfGIywipX6/iYYxlbxsoB9Fpjt
   xpYCkNPcDdqjI41pmR1tVhm3hzxEZfc6Zm3YNLrBt7Oy3xb8iv4N13buq
   9vjNV7oVXH92GrYjj2dy3OKs5hwtNEhp/QGy+/hTNSMKR10aD8N8h0D/s
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,148,1728950400"; 
   d="scan'208";a="439046280"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 18:52:54 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:52042]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.11:2525] with esmtp (Farcaster)
 id 85d768d5-4ef5-4937-9808-bf7aff734ffc; Tue, 12 Nov 2024 18:52:53 +0000 (UTC)
X-Farcaster-Flow-ID: 85d768d5-4ef5-4937-9808-bf7aff734ffc
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 18:52:53 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 18:52:49 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Matt Fleming
	<matt@codeblueprint.co.uk>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stanspas@amazon.de>,
	<nh-open-source@amazon.com>, Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH v2 1/2] x86/efi: Drop support for the EFI_PROPERTIES_TABLE
Date: Tue, 12 Nov 2024 18:52:16 +0000
Message-ID: <20241112185217.48792-1-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Drop support for the EFI_PROPERTIES_TABLE. It was a failed, short-lived
experiment that broke the boot both on Linux and Windows, and was
replaced by the EFI_MEMORY_ATTRIBUTES_TABLE shortly after.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/platform/efi/efi.c    | 19 ---------------
 arch/x86/platform/efi/efi_64.c | 42 ----------------------------------
 include/linux/efi.h            | 17 +++-----------
 3 files changed, 3 insertions(+), 75 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 88a96816de9a..375ebd78296a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -54,14 +54,12 @@
 #include <asm/uv/uv.h>
 
 static unsigned long efi_systab_phys __initdata;
-static unsigned long prop_phys = EFI_INVALID_TABLE_ADDR;
 static unsigned long uga_phys = EFI_INVALID_TABLE_ADDR;
 static unsigned long efi_runtime, efi_nr_tables;
 
 unsigned long efi_fw_vendor, efi_config_table;
 
 static const efi_config_table_type_t arch_tables[] __initconst = {
-	{EFI_PROPERTIES_TABLE_GUID,	&prop_phys,		"PROP"		},
 	{UGA_IO_PROTOCOL_GUID,		&uga_phys,		"UGA"		},
 #ifdef CONFIG_X86_UV
 	{UV_SYSTEM_TABLE_GUID,		&uv_systab_phys,	"UVsystab"	},
@@ -82,7 +80,6 @@ static const unsigned long * const efi_tables[] = {
 	&efi_runtime,
 	&efi_config_table,
 	&efi.esrt,
-	&prop_phys,
 	&efi_mem_attr_table,
 #ifdef CONFIG_EFI_RCI2_TABLE
 	&rci2_table_phys,
@@ -502,22 +499,6 @@ void __init efi_init(void)
 		return;
 	}
 
-	/* Parse the EFI Properties table if it exists */
-	if (prop_phys != EFI_INVALID_TABLE_ADDR) {
-		efi_properties_table_t *tbl;
-
-		tbl = early_memremap_ro(prop_phys, sizeof(*tbl));
-		if (tbl == NULL) {
-			pr_err("Could not map Properties table!\n");
-		} else {
-			if (tbl->memory_protection_attribute &
-			    EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA)
-				set_bit(EFI_NX_PE_DATA, &efi.flags);
-
-			early_memunmap(tbl, sizeof(*tbl));
-		}
-	}
-
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
 
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 91d31ac422d6..ac57259a432b 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -412,51 +412,9 @@ static int __init efi_update_mem_attr(struct mm_struct *mm, efi_memory_desc_t *m
 
 void __init efi_runtime_update_mappings(void)
 {
-	efi_memory_desc_t *md;
-
-	/*
-	 * Use the EFI Memory Attribute Table for mapping permissions if it
-	 * exists, since it is intended to supersede EFI_PROPERTIES_TABLE.
-	 */
 	if (efi_enabled(EFI_MEM_ATTR)) {
 		efi_disable_ibt_for_runtime = false;
 		efi_memattr_apply_permissions(NULL, efi_update_mem_attr);
-		return;
-	}
-
-	/*
-	 * EFI_MEMORY_ATTRIBUTES_TABLE is intended to replace
-	 * EFI_PROPERTIES_TABLE. So, use EFI_PROPERTIES_TABLE to update
-	 * permissions only if EFI_MEMORY_ATTRIBUTES_TABLE is not
-	 * published by the firmware. Even if we find a buggy implementation of
-	 * EFI_MEMORY_ATTRIBUTES_TABLE, don't fall back to
-	 * EFI_PROPERTIES_TABLE, because of the same reason.
-	 */
-
-	if (!efi_enabled(EFI_NX_PE_DATA))
-		return;
-
-	for_each_efi_memory_desc(md) {
-		unsigned long pf = 0;
-
-		if (!(md->attribute & EFI_MEMORY_RUNTIME))
-			continue;
-
-		if (!(md->attribute & EFI_MEMORY_WB))
-			pf |= _PAGE_PCD;
-
-		if ((md->attribute & EFI_MEMORY_XP) ||
-			(md->type == EFI_RUNTIME_SERVICES_DATA))
-			pf |= _PAGE_NX;
-
-		if (!(md->attribute & EFI_MEMORY_RO) &&
-			(md->type != EFI_RUNTIME_SERVICES_CODE))
-			pf |= _PAGE_RW;
-
-		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-			pf |= _PAGE_ENC;
-
-		efi_update_mappings(md, pf);
 	}
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e28d88066033..e5815867aba9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -379,7 +379,6 @@ void efi_native_runtime_setup(void);
 #define EFI_SYSTEM_RESOURCE_TABLE_GUID		EFI_GUID(0xb122a263, 0x3661, 0x4f68,  0x99, 0x29, 0x78, 0xf8, 0xb0, 0xd6, 0x21, 0x80)
 #define EFI_FILE_SYSTEM_GUID			EFI_GUID(0x964e5b22, 0x6459, 0x11d2,  0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define DEVICE_TREE_GUID			EFI_GUID(0xb1b621d5, 0xf19c, 0x41a5,  0x83, 0x0b, 0xd9, 0x15, 0x2c, 0x69, 0xaa, 0xe0)
-#define EFI_PROPERTIES_TABLE_GUID		EFI_GUID(0x880aaca3, 0x4adc, 0x4a04,  0x90, 0x79, 0xb7, 0x47, 0x34, 0x08, 0x25, 0xe5)
 #define EFI_RNG_PROTOCOL_GUID			EFI_GUID(0x3152bca5, 0xeade, 0x433d,  0x86, 0x2e, 0xc0, 0x1c, 0xdc, 0x29, 0x1f, 0x44)
 #define EFI_RNG_ALGORITHM_RAW			EFI_GUID(0xe43176d7, 0xb6e8, 0x4827,  0xb7, 0x84, 0x7f, 0xfd, 0xc4, 0xb6, 0x85, 0x61)
 #define EFI_MEMORY_ATTRIBUTES_TABLE_GUID	EFI_GUID(0xdcfa911d, 0x26eb, 0x469f,  0xa2, 0x20, 0x38, 0xb7, 0xdc, 0x46, 0x12, 0x20)
@@ -580,15 +579,6 @@ struct efi_mem_range {
 	u64 attribute;
 };
 
-typedef struct {
-	u32 version;
-	u32 length;
-	u64 memory_protection_attribute;
-} efi_properties_table_t;
-
-#define EFI_PROPERTIES_TABLE_VERSION	0x00010000
-#define EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA	0x1
-
 typedef struct {
 	u16 version;
 	u16 length;
@@ -871,10 +861,9 @@ static inline int efi_range_is_wc(unsigned long start, unsigned long len)
 #define EFI_PARAVIRT		6	/* Access is via a paravirt interface */
 #define EFI_ARCH_1		7	/* First arch-specific bit */
 #define EFI_DBG			8	/* Print additional debug info at runtime */
-#define EFI_NX_PE_DATA		9	/* Can runtime data regions be mapped non-executable? */
-#define EFI_MEM_ATTR		10	/* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
-#define EFI_MEM_NO_SOFT_RESERVE	11	/* Is the kernel configured to ignore soft reservations? */
-#define EFI_PRESERVE_BS_REGIONS	12	/* Are EFI boot-services memory segments available? */
+#define EFI_MEM_ATTR		9	/* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
+#define EFI_MEM_NO_SOFT_RESERVE	10	/* Is the kernel configured to ignore soft reservations? */
+#define EFI_PRESERVE_BS_REGIONS	11	/* Are EFI boot-services memory segments available? */
 
 #ifdef CONFIG_EFI
 /*
-- 
2.40.1


