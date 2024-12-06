Return-Path: <linux-kernel+bounces-434885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD189E6C4B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7277E288019
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF06201003;
	Fri,  6 Dec 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzTjpYkz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82020100B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481060; cv=none; b=rP76CnKFMSZfoe1vr7SMnunXaPPy+H3zrl3UqWoFtoDoIQXI7wPg04PfXatH4swcSxjCSXLQpbmu5iMXbaqcPadeBKmLiR9jThx5YgjhiXAtAUSKIVyPUP22NYbGpvpDxgHjYBIXjRpfYXZPchAWBMAUo92/Z3xBFMclxRvs8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481060; c=relaxed/simple;
	bh=qHcGrkohNx7hxmnNJHNurnCZ4l7JamjC2Lkg2afi2p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cy78KrDqs7c7dEO+54CXraFbFo33gusZlsxg+CmwDwgpEc8Qh4jlgu9AwP4q1m7TsqfKfgfBxYylOY2y+6zXtIvIBytKgneNh4/56htmfPVXHngl7xg/UHsPL4jmuqqD+WkeiF/VgOeV1Z572r5Hxp1THiM3P7GbNobodBJNi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzTjpYkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D3CC4CED1;
	Fri,  6 Dec 2024 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733481059;
	bh=qHcGrkohNx7hxmnNJHNurnCZ4l7JamjC2Lkg2afi2p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzTjpYkzP4DWMPn1YP6AMBbp7LjvUocHRi/gXgfDhK7vrtvQwHZwMDj8v975tWiL1
	 GeEojsjCltEGFnsqH3MNLtEz3qAUJkL1L0Gjjpt4572jzO5aqIWVGfTfYR7XS+9GAJ
	 kcMasZWsRAH1P1+ePxhVurWkqXMW1GaWYmSY3ploszNyjpKVZAdVMiFHGpOG5C2cnQ
	 jEsGOGtThWXdxyvjQ5Zz2ODpBz5yL82pb0TFiUtw7CNdrwi+fCWX8RfgHJYjkOeGFI
	 LR7bbXtflmQjJZpUjOwxndbEYf8oXgKob0LXp37Xf2BBGaCdcHp9O5skabSH1+3Vso
	 Ebo+EAVROZmOQ==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ning Sun <ning.sun@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	tboot-devel@lists.sourceforge.net
Subject: [PATCH v2 4/4] x86/e820: drop E820_TYPE_RESERVED_KERN and related code
Date: Fri,  6 Dec 2024 12:30:31 +0200
Message-ID: <20241206103031.737458-5-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206103031.737458-1-rppt@kernel.org>
References: <20241206103031.737458-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

E820_TYPE_RESERVED_KERN is a relict from the ancient history that was used
to early reserve setup_data (see commit 28bb22379513 ("x86: move
reserve_setup_data to setup.c")).

Nowadays setup_data is anyway reserved in memblock and there is no point in
carrying E820_TYPE_RESERVED_KERN that behaves exactly like E820_TYPE_RAM
but only complicates the code.

A bonus for removing E820_TYPE_RESERVED_KERN is a small but measurable
speedup of 20 microseconds in init_mem_mappings() on a VM with 32GB or RAM.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/include/asm/e820/api.h   |  1 -
 arch/x86/include/asm/e820/types.h |  9 -----
 arch/x86/kernel/e820.c            | 65 ++-----------------------------
 arch/x86/kernel/setup.c           |  1 -
 arch/x86/kernel/tboot.c           |  3 +-
 arch/x86/mm/init_64.c             |  8 ----
 6 files changed, 4 insertions(+), 83 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 2e74a7f0e935..c83645d5b2a8 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -29,7 +29,6 @@ extern unsigned long e820__end_of_low_ram_pfn(void);
 extern u64  e820__memblock_alloc_reserved(u64 size, u64 align);
 extern void e820__memblock_setup(void);
 
-extern void e820__reserve_setup_data(void);
 extern void e820__finish_early_params(void);
 extern void e820__reserve_resources(void);
 extern void e820__reserve_resources_late(void);
diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index 314f75d886d0..80c4a7266629 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -35,15 +35,6 @@ enum e820_type {
 	 * marking it with the IORES_DESC_SOFT_RESERVED designation.
 	 */
 	E820_TYPE_SOFT_RESERVED	= 0xefffffff,
-
-	/*
-	 * Reserved RAM used by the kernel itself if
-	 * CONFIG_INTEL_TXT=y is enabled, memory of this type
-	 * will be included in the S3 integrity calculation
-	 * and so should not include any memory that the BIOS
-	 * might alter over the S3 transition:
-	 */
-	E820_TYPE_RESERVED_KERN	= 128,
 };
 
 /*
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index cb9985fd3881..625766e255be 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -187,8 +187,7 @@ void __init e820__range_add(u64 start, u64 size, enum e820_type type)
 static void __init e820_print_type(enum e820_type type)
 {
 	switch (type) {
-	case E820_TYPE_RAM:		/* Fall through: */
-	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
+	case E820_TYPE_RAM:		pr_cont("usable");			break;
 	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
 	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
 	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
@@ -764,7 +763,7 @@ void __init e820__register_nosave_regions(unsigned long limit_pfn)
 
 		pfn = PFN_DOWN(entry->addr + entry->size);
 
-		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
+		if (entry->type != E820_TYPE_RAM)
 			register_nosave_region(PFN_UP(entry->addr), pfn);
 
 		if (pfn >= limit_pfn)
@@ -990,60 +989,6 @@ static int __init parse_memmap_opt(char *str)
 }
 early_param("memmap", parse_memmap_opt);
 
-/*
- * Reserve all entries from the bootloader's extensible data nodes list,
- * because if present we are going to use it later on to fetch e820
- * entries from it:
- */
-void __init e820__reserve_setup_data(void)
-{
-	struct setup_indirect *indirect;
-	struct setup_data *data;
-	u64 pa_data, pa_next;
-	u32 len;
-
-	pa_data = boot_params.hdr.setup_data;
-	if (!pa_data)
-		return;
-
-	while (pa_data) {
-		data = early_memremap(pa_data, sizeof(*data));
-		if (!data) {
-			pr_warn("e820: failed to memremap setup_data entry\n");
-			return;
-		}
-
-		len = sizeof(*data);
-		pa_next = data->next;
-
-		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
-		if (data->type == SETUP_INDIRECT) {
-			len += data->len;
-			early_memunmap(data, sizeof(*data));
-			data = early_memremap(pa_data, len);
-			if (!data) {
-				pr_warn("e820: failed to memremap indirect setup_data\n");
-				return;
-			}
-
-			indirect = (struct setup_indirect *)data->data;
-
-			if (indirect->type != SETUP_INDIRECT)
-				e820__range_update(indirect->addr, indirect->len,
-						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-		}
-
-		pa_data = pa_next;
-		early_memunmap(data, len);
-	}
-
-	e820__update_table(e820_table);
-
-	pr_info("extended physical RAM map:\n");
-	e820__print_table("reserve setup_data");
-}
-
 /*
  * Called after parse_early_param(), after early parameters (such as mem=)
  * have been processed, in which case we already have an E820 table filled in
@@ -1063,7 +1008,6 @@ void __init e820__finish_early_params(void)
 static const char *__init e820_type_to_string(struct e820_entry *entry)
 {
 	switch (entry->type) {
-	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		return "System RAM";
 	case E820_TYPE_ACPI:		return "ACPI Tables";
 	case E820_TYPE_NVS:		return "ACPI Non-volatile Storage";
@@ -1079,7 +1023,6 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
 static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
 {
 	switch (entry->type) {
-	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		return IORESOURCE_SYSTEM_RAM;
 	case E820_TYPE_ACPI:		/* Fall-through: */
 	case E820_TYPE_NVS:		/* Fall-through: */
@@ -1101,7 +1044,6 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
 	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
 	case E820_TYPE_SOFT_RESERVED:	return IORES_DESC_SOFT_RESERVED;
-	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
 	case E820_TYPE_UNUSABLE:	/* Fall-through: */
 	default:			return IORES_DESC_NONE;
@@ -1124,7 +1066,6 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
 	case E820_TYPE_PRAM:
 	case E820_TYPE_PMEM:
 		return false;
-	case E820_TYPE_RESERVED_KERN:
 	case E820_TYPE_RAM:
 	case E820_TYPE_ACPI:
 	case E820_TYPE_NVS:
@@ -1356,7 +1297,7 @@ void __init e820__memblock_setup(void)
 		if (entry->type == E820_TYPE_SOFT_RESERVED)
 			memblock_reserve(entry->addr, entry->size);
 
-		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
+		if (entry->type != E820_TYPE_RAM)
 			continue;
 
 		memblock_add(entry->addr, entry->size);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d4e44f50f350..2c1f7fbcd505 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -892,7 +892,6 @@ void __init setup_arch(char **cmdline_p)
 		setup_clear_cpu_cap(X86_FEATURE_APIC);
 	}
 
-	e820__reserve_setup_data();
 	e820__finish_early_params();
 
 	if (efi_enabled(EFI_BOOT))
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4c1bcb6053fc..46b8f1f16676 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -200,8 +200,7 @@ static int tboot_setup_sleep(void)
 	tboot->num_mac_regions = 0;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
-		if ((e820_table->entries[i].type != E820_TYPE_RAM)
-		 && (e820_table->entries[i].type != E820_TYPE_RESERVED_KERN))
+		if (e820_table->entries[i].type != E820_TYPE_RAM)
 			continue;
 
 		add_mac_region(e820_table->entries[i].addr, e820_table->entries[i].size);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..519aa53114fa 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -468,8 +468,6 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
-			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN) &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_ACPI))
 				set_pte_init(pte, __pte(0), init);
@@ -525,8 +523,6 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
-			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_ACPI))
 				set_pmd_init(pmd, __pmd(0), init);
@@ -614,8 +610,6 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
-			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN) &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_ACPI))
 				set_pud_init(pud, __pud(0), init);
@@ -703,8 +697,6 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
-			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN) &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_ACPI))
 				set_p4d_init(p4d, __p4d(0), init);
-- 
2.45.2


