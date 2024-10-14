Return-Path: <linux-kernel+bounces-363891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E999C82C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD671C259C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504801D0F4D;
	Mon, 14 Oct 2024 11:01:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5AC1D07AB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903707; cv=none; b=m2mRyFnVcqTUN6ULy+PRLs1A43sYhaFusMLcs579SA3iJ7+qZnIBnO22EOG2TNQ3VF0OYV1E5JJ+96IDMUKzcZDuYc4JhDmRjJHxlHeOcNYveuUHSHt4jJWu3kJIghgJCRmpSUt099Nbq4e2CfRPYrapgTHaS+TWGnjJkcy8QtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903707; c=relaxed/simple;
	bh=pju+pKbnh4VxWyHMqjrVkN4GdtXP+yAOA9ey/8dQJ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUVUG3pFVxYMafKWHRijXqcxQIRISrKYKwwd6w3yhzNkq0Y7QgJbj7FW5cuyisGybdLTC+9VX5ceRKWIxD2asfAf4ahAS0Ml+vGs178C6p5BWD9mOTTCWYlmIRcnmYBxq48jte9j4lwxj2b5jd32pNryF/VO/3QCXxSvlqSu61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E6BA1764;
	Mon, 14 Oct 2024 04:02:15 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FBE13F51B;
	Mon, 14 Oct 2024 04:01:43 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 45/57] arm64: Rework trampoline rodata mapping
Date: Mon, 14 Oct 2024 11:58:52 +0100
Message-ID: <20241014105912.3207374-45-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the trampoline rodata is aligned to the next PAGE_SIZE_MAX
boundary after the end of the trampoline text, the code that maps it in
the fixmap is incorrect, because it still assumes the rodata is in the
next page immediately after the text. Of course it still works for now
with compile-time page size but for boot-time page size when selecting a
page size less than PAGE_SIZE_MAX, it will fail.

So let's fix that by allocating sufficient fixmap slots to cover the
extra alignment padding in the worst case (PAGE_SIZE == PAGE_SIZE_MIN)
and explicitly mapping the rodata to the slot offset correctly from the
text.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/fixmap.h   | 16 +++++++++++-----
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   |  4 +++-
 arch/arm64/mm/mmu.c               | 22 ++++++++++++++--------
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 87e307804b99c..9a496d54dfe6e 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -59,13 +59,19 @@ enum fixed_addresses {
 #endif /* CONFIG_ACPI_APEI_GHES */
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define TRAMP_TEXT_SIZE	(PAGE_SIZE_MIN * 3)
 #ifdef CONFIG_RELOCATABLE
-	FIX_ENTRY_TRAMP_TEXT4,	/* one extra slot for the data page */
+#define TRAMP_DATA_SIZE	PAGE_SIZE_MIN
+#define TRAMP_PAD_SIZE	(PAGE_SIZE_MAX - PAGE_SIZE_MIN)
+#else
+#define TRAMP_DATA_SIZE	0
+#define TRAMP_PAD_SIZE	0
 #endif
-	FIX_ENTRY_TRAMP_TEXT3,
-	FIX_ENTRY_TRAMP_TEXT2,
-	FIX_ENTRY_TRAMP_TEXT1,
-#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT1))
+#define TRAMP_SIZE	(TRAMP_TEXT_SIZE + TRAMP_DATA_SIZE + TRAMP_PAD_SIZE)
+	FIX_ENTRY_TRAMP_END,
+	FIX_ENTRY_TRAMP_BEGIN = FIX_ENTRY_TRAMP_END +
+				DIV_ROUND_UP(TRAMP_SIZE, PAGE_SIZE_MIN) - 1,
+#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_BEGIN))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 	__end_of_permanent_fixed_addresses,
 
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 40971ac1303f9..252ec58963093 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -21,6 +21,7 @@ extern char __exittext_begin[], __exittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+extern char __entry_tramp_rodata_start[], __entry_tramp_rodata_end[];
 extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
 
 static inline size_t entry_tramp_text_size(void)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1ef6dea13b57c..09fcc234c0f77 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -118,7 +118,9 @@ jiffies = jiffies_64;
 	*(.entry.tramp.text)				\
 	__entry_tramp_text_end = .;			\
 	. = ALIGN(PAGE_SIZE_MAX);			\
-	*(.entry.tramp.rodata)
+	__entry_tramp_rodata_start = .;			\
+	*(.entry.tramp.rodata)				\
+	__entry_tramp_rodata_end = .;
 #else
 #define TRAMP_TEXT
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a528787c1e550..84df9f278d24d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -734,25 +734,31 @@ static int __init map_entry_trampoline(void)
 		return 0;
 
 	pgprot_t prot = kernel_exec_prot();
-	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
+	phys_addr_t pa_text = __pa_symbol(__entry_tramp_text_start);
+	phys_addr_t pa_data = __pa_symbol(__entry_tramp_rodata_start);
+	int slot = FIX_ENTRY_TRAMP_BEGIN;
 
 	/* The trampoline is always mapped and can therefore be global */
 	pgprot_val(prot) &= ~PTE_NG;
 
 	/* Map only the text into the trampoline page table */
 	memset(tramp_pg_dir, 0, PGD_SIZE);
-	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
+	__create_pgd_mapping(tramp_pg_dir, pa_text, TRAMP_VALIAS,
 			     entry_tramp_text_size(), prot,
 			     __pgd_pgtable_alloc, NO_BLOCK_MAPPINGS);
 
 	/* Map both the text and data into the kernel page table */
-	for (i = 0; i < DIV_ROUND_UP(entry_tramp_text_size(), PAGE_SIZE); i++)
-		__set_fixmap(FIX_ENTRY_TRAMP_TEXT1 - i,
-			     pa_start + i * PAGE_SIZE, prot);
+	for (i = 0; i < DIV_ROUND_UP(entry_tramp_text_size(), PAGE_SIZE); i++) {
+		__set_fixmap(slot, pa_text, prot);
+		pa_text += PAGE_SIZE;
+		slot--;
+	}
 
-	if (IS_ENABLED(CONFIG_RELOCATABLE))
-		__set_fixmap(FIX_ENTRY_TRAMP_TEXT1 - i,
-			     pa_start + i * PAGE_SIZE, PAGE_KERNEL_RO);
+	if (IS_ENABLED(CONFIG_RELOCATABLE)) {
+		slot -= (pa_data - pa_text) / PAGE_SIZE;
+		VM_BUG_ON(slot < FIX_ENTRY_TRAMP_END);
+		__set_fixmap(slot, pa_data, PAGE_KERNEL_RO);
+	}
 
 	return 0;
 }
-- 
2.43.0


