Return-Path: <linux-kernel+bounces-363850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0689C99C7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF06C284644
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8665A19F461;
	Mon, 14 Oct 2024 10:59:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82E119F401
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903583; cv=none; b=HxU1pW8ak50eL5f8gusyH0pezxWRAuW2bN7kpj2nTrXJMNxIhaONS0c/26cMRjbRirzay09djjk62Gbag6CBj+pGPKEATOvVS8EXdq4NZMwreYIMJrVcDVLm+rQB0+pZVZNG6WFbgTfRZ4IeRjarm07nh/fh2RJpxJDtvVzIOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903583; c=relaxed/simple;
	bh=ngyHcgaywkBIUCH0Ngnr2UiDHx8Vg0LbOFYx3h+43kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxGxLdyCYsIXc4Md/MySncI3thwDeDcQ9uXTYz7ElpphdO116tkpnTi+olpAUqPF+nuU2ncwsKdLrDS6jFes62X4o7ZGQbKgrwHchrNrut3EDKCN1FJVbWNpOoUrwJXL55nfiiZE+IBTCJb9OAdDeQmW5rRJ+4mbiVrBIo2BCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E091684;
	Mon, 14 Oct 2024 04:00:10 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47583F51B;
	Mon, 14 Oct 2024 03:59:38 -0700 (PDT)
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
Subject: [RFC PATCH v1 05/57] mm: Avoid split pmd ptl if pmd level is run-time folded
Date: Mon, 14 Oct 2024 11:58:12 +0100
Message-ID: <20241014105912.3207374-5-ryan.roberts@arm.com>
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

If there are only 2 levels of translation, the first level (pgd) may not
be an entire page and so does not have a ptdesc backing it (this may be
true on arm64 depending on the VA size and page size). Even if it is an
entire page and does therefore have an entire ptdesc,
pagetable_pmd_ctor() won't be called for the ptdesc (since it's a pgd
not pmd table) and so the per-ptdec ptl fields won't be initialised.

To date this has been fine; the arch knows at compile time if it needs
to fold the pmd level and in this case does not select
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK. However, if the number of levels
are not known at compile time (as is the case for boot-time page size
selection), we want to be able to choose at boot whether to use split
pmd ptls in the pmd's ptdesc or simply fall back to the lock in the
mm_struct.

So let's make that change; when CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK is
selected, determine if it should be used at run-time based on
mm_pmd_folded().

This sets us up for arm64 to support boot-time page size selection.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 include/linux/mm.h       | 15 ++++++++++++++-
 include/linux/mm_types.h |  2 +-
 kernel/fork.c            |  4 ++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1470736017168..09a840517c23a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3037,6 +3037,8 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
+	if (mm_pmd_folded(mm))
+		return &mm->page_table_lock;
 	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
@@ -3056,7 +3058,18 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 	ptlock_free(ptdesc);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
+static inline pgtable_t *__pmd_huge_pte(struct mm_struct *mm, pmd_t *pmd)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (mm_pmd_folded(mm))
+		return &mm->pmd_huge_pte;
+	return &pmd_ptdesc(pmd)->pmd_huge_pte;
+#else
+	return NULL;
+#endif
+}
+
+#define pmd_huge_pte(mm, pmd) (*__pmd_huge_pte(mm, pmd))
 
 #else
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0844ed7cfaa53..87dc6de7b7baf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -946,7 +946,7 @@ struct mm_struct {
 #ifdef CONFIG_MMU_NOTIFIER
 		struct mmu_notifier_subscriptions *notifier_subscriptions;
 #endif
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f2012..ea472566d4fcc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -832,7 +832,7 @@ static void check_mm(struct mm_struct *mm)
 		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
 				mm_pgtables_bytes(mm));
 
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
 #endif
 }
@@ -1276,7 +1276,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	mm->pmd_huge_pte = NULL;
 #endif
 	mm_init_uprobes_state(mm);
-- 
2.43.0


