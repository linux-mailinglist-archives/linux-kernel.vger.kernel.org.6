Return-Path: <linux-kernel+bounces-363895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E499C830
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B079B1C25EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA91A76DD;
	Mon, 14 Oct 2024 11:01:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355991D3624
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903718; cv=none; b=huEztXZU+j8ZrNwFa6qkEFCtRHgPmJ+fpxzHClDv66EHTzK51NDbhom92dZW9ozUtLAtNYfT1ri4qtfOyO87vfS7FN1+8qZh16xJj7swdhMPZtSrxpF4SLMCnXM+I9596Q2sD46VByGIlK1b4jnWat0RJf+qAe0eiDXidHhIVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903718; c=relaxed/simple;
	bh=tObwb618ZSTF6zsP7bIlO7E6YzHLh2clJtCrO/U+DNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q40i+IEkwSNeGjobFss2GZKmdZy21LPuXKJSFxPsnwfAyEhmcfXaynrZuhJY5pfbTHzPv1E6nvXIqsSgoIefk+3loxJKPfUF2Xs/K7EaOqU43hNkpR+Z1Q4NeNQnX28QmBCzOWMBFCQ53xJrem4QXulcC4G90HxAEPugfODT9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FFED19F0;
	Mon, 14 Oct 2024 04:02:26 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 512493F51B;
	Mon, 14 Oct 2024 04:01:54 -0700 (PDT)
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
Subject: [RFC PATCH v1 49/57] arm64: Convert BUILD_BUG_ON to VM_BUG_ON
Date: Mon, 14 Oct 2024 11:58:56 +0100
Message-ID: <20241014105912.3207374-49-ryan.roberts@arm.com>
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

There are some build bug checks that will no longer compile for
boot-time page size because the values they are testing are no longer
compile-time constants. Resolve these by converting them to VM_BUG_ON,
which will perform a runtime check.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/mm/init.c | 6 +++---
 arch/arm64/mm/mmu.c  | 4 ++--
 arch/arm64/mm/pgd.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 42eb246949072..4d24034418b39 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -388,15 +388,15 @@ void __init mem_init(void)
 	 * detected at build time already.
 	 */
 #ifdef CONFIG_COMPAT
-	BUILD_BUG_ON(TASK_SIZE_32 > DEFAULT_MAP_WINDOW_64);
+	VM_BUG_ON(TASK_SIZE_32 > DEFAULT_MAP_WINDOW_64);
 #endif
 
 	/*
 	 * Selected page table levels should match when derived from
 	 * scratch using the virtual address range and page size.
 	 */
-	BUILD_BUG_ON(ARM64_HW_PGTABLE_LEVELS(CONFIG_ARM64_VA_BITS) !=
-		     CONFIG_PGTABLE_LEVELS);
+	VM_BUG_ON(ARM64_HW_PGTABLE_LEVELS(CONFIG_ARM64_VA_BITS) !=
+		  CONFIG_PGTABLE_LEVELS);
 
 	if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
 		extern int sysctl_overcommit_memory;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b4cd3b6a73c22..ad7fd3fda705a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -639,8 +639,8 @@ static void __init map_mem(pgd_t *pgdp)
 	 * entire reduced VA space is covered by a single pgd_t which will have
 	 * been populated without the PXNTable attribute by the time we get here.)
 	 */
-	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end) &&
-		     pgd_index(_PAGE_OFFSET(VA_BITS_MIN)) != PTRS_PER_PGD - 1);
+	VM_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end) &&
+		  pgd_index(_PAGE_OFFSET(VA_BITS_MIN)) != PTRS_PER_PGD - 1);
 
 	early_kfence_pool = arm64_kfence_alloc_pool();
 
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 0c501cabc2384..4b106510358b1 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -56,7 +56,7 @@ void __init pgtable_cache_init(void)
 	 * With 52-bit physical addresses, the architecture requires the
 	 * top-level table to be aligned to at least 64 bytes.
 	 */
-	BUILD_BUG_ON(PGD_SIZE < 64);
+	VM_BUG_ON(PGD_SIZE < 64);
 #endif
 
 	/*
-- 
2.43.0


