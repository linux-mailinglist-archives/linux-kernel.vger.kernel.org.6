Return-Path: <linux-kernel+bounces-363893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2D999C82E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C35E1C25D02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A39C1D1E62;
	Mon, 14 Oct 2024 11:01:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766A21D14E8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903712; cv=none; b=h0Nx7FmTiWYdqvZV59ZEdpu8wb7bhLSfD6oiNB61APslSiRzXM/VWf/Fs8F3xDl0EksKgSOHrUitq70j0Ka5q6GTPiJObfAHP2Y1QP4XYlvTXKvcGTbD4spjEyOmEFOteegfid8nme77RXKSk63jE2xQLy8SgiOjY1ybjW0mipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903712; c=relaxed/simple;
	bh=yhFOHFcdXSc/tus5owk1BUSLa21Hclx8JBn17i6EL8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk7S/qDNjD4nZIPRdMXqXDyGNSLJLF0FZSnF0mP1Q4WwWhdfrTsygYsiW0b8gzmqgpzaRG4w/hwERz0M2bbTWn1kd9+RiWMLXDEy1PawbOFIaUNejPcmPOXfvNguZ9mV1C9tLgbDAaOKkYXCExZM0tQ3AL/BQKdW9+8u4E5DFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1DC6176B;
	Mon, 14 Oct 2024 04:02:20 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B31C53F51B;
	Mon, 14 Oct 2024 04:01:48 -0700 (PDT)
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
Subject: [RFC PATCH v1 47/57] arm64: Statically allocate and align for worst-case page size
Date: Mon, 14 Oct 2024 11:58:54 +0100
Message-ID: <20241014105912.3207374-47-ryan.roberts@arm.com>
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

Increase the size and alignment of the zero page and various static
buffers used for page tables to PAGE_SIZE_MAX. This resolves to the same
thing for compile-time page size builds.

For boot-time builds, we may in future consider freeing unused pages at
runtime when the selected page size is less than MAX.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/pgtable.h  | 2 +-
 arch/arm64/kernel/pi/map_kernel.c | 2 +-
 arch/arm64/mm/mmu.c               | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7a4f5604be3f7..fd47f70a42396 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -61,7 +61,7 @@
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
+extern unsigned long empty_zero_page[PAGE_SIZE_MAX / sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr)	phys_to_page(__pa_symbol(empty_zero_page))
 
 #define pte_ERROR(e)	\
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index 7a62d4238449d..deb8cd50b0b0c 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -199,7 +199,7 @@ static void __init remap_idmap(bool use_lpa2, int page_shift)
 
 static void __init map_fdt(u64 fdt, int page_shift)
 {
-	static u8 ptes[INIT_IDMAP_FDT_SIZE_MAX] __initdata __aligned(PAGE_SIZE);
+	static u8 ptes[INIT_IDMAP_FDT_SIZE_MAX] __initdata __aligned(PAGE_SIZE_MAX);
 	static bool first_time __initdata = true;
 	u64 limit = (u64)&ptes[INIT_IDMAP_FDT_SIZE_MAX];
 	u64 efdt = fdt + MAX_FDT_SIZE;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 84df9f278d24d..b4cd3b6a73c22 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -62,7 +62,7 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
  */
-unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
+unsigned long empty_zero_page[PAGE_SIZE_MAX / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
@@ -783,8 +783,8 @@ void __pi_map_range(u64 *pgd, u64 limit, u64 start, u64 end, u64 pa,
 		    pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
 		    u64 va_offset);
 
-static u8 idmap_ptes[IDMAP_LEVELS_MAX - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
-	  kpti_ptes[IDMAP_LEVELS_MAX - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
+static u8 idmap_ptes[IDMAP_LEVELS_MAX - 1][PAGE_SIZE_MAX] __aligned(PAGE_SIZE_MAX) __ro_after_init,
+	  kpti_ptes[IDMAP_LEVELS_MAX - 1][PAGE_SIZE_MAX] __aligned(PAGE_SIZE_MAX) __ro_after_init;
 
 static void __init create_idmap(void)
 {
-- 
2.43.0


