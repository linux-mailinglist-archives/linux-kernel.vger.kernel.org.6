Return-Path: <linux-kernel+bounces-517791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5AA385A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D01730C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E021D004;
	Mon, 17 Feb 2025 14:08:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F962253A5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801338; cv=none; b=F3ageuqT05hwlfX1Yo8oN6/Ew2KBrJqsPDdXqOii4Vna7xgy/T/GODGDzUeDE6GL6tMcC+hdCPXEf2XS8+RVhsQBtv6NnYceNNhnquI0TCg4SPbMsaSoY5fk4dHRwFihKfzpCVbvCHKuoPLfH3xokjgjWCF25Wf3fR69FW5mtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801338; c=relaxed/simple;
	bh=pSuM6MypgxV3BUAzCVSD90Sc2VtBvvD7mnceRv9s660=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQTPjpieonGBb23hp6+7Ar+l74mYd8EKEt21AOnwa6dJ2WR9qXJQUZEXr0d1AxrosQArvISiKzh9V6sMlIQXM7upZRRQIsaEdy+EWdSyj5l91AdlAPypGcSn+gKPVeyNB4TUnt8UlT4y+pbzFLQMzixi+a+vpGrLLjZzXjpHbJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E83244C;
	Mon, 17 Feb 2025 06:09:15 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9BE63F6A8;
	Mon, 17 Feb 2025 06:08:53 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] arm64/mm: Batch barriers when updating kernel mappings
Date: Mon, 17 Feb 2025 14:08:06 +0000
Message-ID: <20250217140809.1702789-15-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140809.1702789-1-ryan.roberts@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the kernel can't tolerate page faults for kernel mappings, when
setting a valid, kernel space pte (or pmd/pud/p4d/pgd), it emits a
dsb(ishst) to ensure that the store to the pgtable is observed by the
table walker immediately. Additionally it emits an isb() to ensure that
any already speculatively determined invalid mapping fault gets
canceled.

We can improve the performance of vmalloc operations by batching these
barriers until the end of a set of entry updates. The newly added
arch_update_kernel_mappings_begin() / arch_update_kernel_mappings_end()
provide the required hooks.

vmalloc improves by up to 30% as a result.

A new TIF_ flag is created; TIF_KMAP_UPDATE_ACTIVE tells us if we are in
the batch mode and can therefore defer any barriers until the end of the
batch.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h     | 73 ++++++++++++++++++++--------
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/process.c          |  9 ++--
 3 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 51128c2956f8..f8866dbdfde7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -39,6 +39,49 @@
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <linux/page_table_check.h>
+#include <linux/pgtable_modmask.h>
+
+static inline void emit_pte_barriers(void)
+{
+	/*
+	 * These barriers are emitted under certain conditions after a pte entry
+	 * was modified (see e.g. __set_pte_complete()). The dsb makes the store
+	 * visible to the table walker. The isb ensures that any previous
+	 * speculative "invalid translation" marker that is in the CPU's
+	 * pipeline gets cleared, so that any access to that address after
+	 * setting the pte to valid won't cause a spurious fault. If the thread
+	 * gets preempted after storing to the pgtable but before emitting these
+	 * barriers, __switch_to() emits a dsb which ensure the walker gets to
+	 * see the store. There is no guarrantee of an isb being issued though.
+	 * This is safe because it will still get issued (albeit on a
+	 * potentially different CPU) when the thread starts running again,
+	 * before any access to the address.
+	 */
+	dsb(ishst);
+	isb();
+}
+
+static inline void queue_pte_barriers(void)
+{
+	if (!test_thread_flag(TIF_KMAP_UPDATE_ACTIVE))
+		emit_pte_barriers();
+}
+
+#define arch_update_kernel_mappings_begin arch_update_kernel_mappings_begin
+static inline void arch_update_kernel_mappings_begin(unsigned long start,
+						     unsigned long end)
+{
+	set_thread_flag(TIF_KMAP_UPDATE_ACTIVE);
+}
+
+#define arch_update_kernel_mappings_end arch_update_kernel_mappings_end
+static inline void arch_update_kernel_mappings_end(unsigned long start,
+						   unsigned long end,
+						   pgtbl_mod_mask mask)
+{
+	clear_thread_flag(TIF_KMAP_UPDATE_ACTIVE);
+	emit_pte_barriers();
+}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
@@ -323,10 +366,8 @@ static inline void __set_pte_complete(pte_t pte)
 	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
 	 * or update_mmu_cache() have the necessary barriers.
 	 */
-	if (pte_valid_not_user(pte)) {
-		dsb(ishst);
-		isb();
-	}
+	if (pte_valid_not_user(pte))
+		queue_pte_barriers();
 }
 
 static inline void __set_pte(pte_t *ptep, pte_t pte)
@@ -791,10 +832,8 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 
 	WRITE_ONCE(*pmdp, pmd);
 
-	if (pmd_valid_not_user(pmd)) {
-		dsb(ishst);
-		isb();
-	}
+	if (pmd_valid_not_user(pmd))
+		queue_pte_barriers();
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
@@ -859,10 +898,8 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 
 	WRITE_ONCE(*pudp, pud);
 
-	if (pud_valid_not_user(pud)) {
-		dsb(ishst);
-		isb();
-	}
+	if (pud_valid_not_user(pud))
+		queue_pte_barriers();
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -941,10 +978,8 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 
 	WRITE_ONCE(*p4dp, p4d);
 
-	if (p4d_valid_not_user(p4d)) {
-		dsb(ishst);
-		isb();
-	}
+	if (p4d_valid_not_user(p4d))
+		queue_pte_barriers();
 }
 
 static inline void p4d_clear(p4d_t *p4dp)
@@ -1072,10 +1107,8 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 
 	WRITE_ONCE(*pgdp, pgd);
 
-	if (pgd_valid_not_user(pgd)) {
-		dsb(ishst);
-		isb();
-	}
+	if (pgd_valid_not_user(pgd))
+		queue_pte_barriers();
 }
 
 static inline void pgd_clear(pgd_t *pgdp)
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 1114c1c3300a..3856e0759cc3 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -82,6 +82,7 @@ void arch_setup_new_exec(void);
 #define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
 #define TIF_KERNEL_FPSTATE	29	/* Task is in a kernel mode FPSIMD section */
 #define TIF_TSC_SIGSEGV		30	/* SIGSEGV on counter-timer access */
+#define TIF_KMAP_UPDATE_ACTIVE	31	/* kernel map update in progress */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 42faebb7b712..45a55fe81788 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -680,10 +680,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	gcs_thread_switch(next);
 
 	/*
-	 * Complete any pending TLB or cache maintenance on this CPU in case
-	 * the thread migrates to a different CPU.
-	 * This full barrier is also required by the membarrier system
-	 * call.
+	 * Complete any pending TLB or cache maintenance on this CPU in case the
+	 * thread migrates to a different CPU. This full barrier is also
+	 * required by the membarrier system call. Additionally it makes any
+	 * in-progress pgtable writes visible to the table walker; See
+	 * emit_pte_barriers().
 	 */
 	dsb(ish);
 
-- 
2.43.0


