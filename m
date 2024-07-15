Return-Path: <linux-kernel+bounces-252984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F2931ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21861F229B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC5E13D601;
	Mon, 15 Jul 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhA3Y//x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A913CA99
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071327; cv=none; b=R+Z/hk+4QXEDnBJHnd2MNeawJFkYaGFn9q0Bh6N7VjYDz9Ul0KlbUIrQOzESUFNdWuENS+IqvD6g8t0//PMEibq7GMhLDneBOWiCVl+jjuVYZu2cDK4H9FYhNEgHkj69cznIC3IuqO/8tjwOFsl9YLPKQ2asUSC3kRv2s///rAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071327; c=relaxed/simple;
	bh=KxQoRYAy31rvfs2wpC6MCQr7OcVrMQNNZjPIAFt986s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQk9PACI+Lcrx66+/OEF46OF35Yq7OYzGfao6Xy2CC4uVQUV7nGyGrgqc12Ce8Up725JHEFFJjSv5hS4xOF+1UMywJurtqswCk0rV2xRdMFPuGd3pKhGZdTIrcokathlsEma9Hglok2zFbsU6hLZKmm+oAqAsMvURWCU9ZbOWV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhA3Y//x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MX5pdN1kDqdO60LUKursnvEFOQP0WFBlMnoZkGHINQQ=;
	b=fhA3Y//xkFHR6n4wtUZ1rVyudWuhk+avUn/SEzrlFOYwepxOjhmW9oEj7H9Xlo6D/ehmKo
	fPfuiYWwKaAgKGZdgrKyHRp8+g5IdnrefuU7mTE7AMSRcvIExW4AatzaoPYEYu5gvFP9SN
	/VINJQplAlO3WyzscWp2c4KXBamt7e8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-ZNYTTk9BOmi0KmK1Tt606Q-1; Mon, 15 Jul 2024 15:22:03 -0400
X-MC-Unique: ZNYTTk9BOmi0KmK1Tt606Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5e99c06efso9781786d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071323; x=1721676123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX5pdN1kDqdO60LUKursnvEFOQP0WFBlMnoZkGHINQQ=;
        b=aODmq9haInGVI0RRaw84rYPpNRM48xxYb12kMj1OJtH0Fwpu33pgq117a55lzBu1WU
         x7d3sn00NCOwGJCa+TzQqDCd4GIgWU/9XaSOS4cen+Hjj+T46pXtELw+dTpkIhGl8DiR
         f4rnkHMKUyRAtcRnVp923he+W1e3VB58a2QTSiAqegzDh15aKKH3eB+deDkFnzMuy/OS
         bYc45rg/MK3K7HKhT55FondN/0FCGmLueEgfohovFC8cDZECtbOtA6j/5jYFh1SwX88w
         FFSHN4jk6s89aXGgkMapj1BwHyi3mUpxB/FDBjnXCQkyCic8mn6Fgs1fD0Y3vW9yAvQc
         d/YA==
X-Forwarded-Encrypted: i=1; AJvYcCVoH99X6+4/cgDPoP4TMNPA2LTgnPa7A9hlQn3DdwCcgVx4mSSnzELE/ghOW+PXR5ga9qQ8fMZBffuIH6d5qChcv5kgJshVFojzZZTC
X-Gm-Message-State: AOJu0YzWKmDFkd4UsbNOsLVSiUEay5i7vBhXA4Ox10f8obCpTRZPr/sq
	y96u81tVVisanVjVkxM6LcUkSiuq8O0fNvZttxYwwQF+FVRMtGP6bYgyqxH0RVBBdpQWR7qqNQg
	x39CmNf/Xb1/WSjUEvq4YY1xZRa76EyTYCpFAVqFlMBSLfOlSUDJuOX/r3gZQnA==
X-Received: by 2002:a05:6214:3d9c:b0:6b7:586c:6db with SMTP id 6a1803df08f44-6b77e1a9bbbmr4347846d6.9.1721071322940;
        Mon, 15 Jul 2024 12:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQhnzZI26fHLI1GP/caKDLHgduuPT+eLqK9zXdARycJ8bkdfse6d6/hJ9cmtHwcRv8UZEfEQ==
X-Received: by 2002:a05:6214:3d9c:b0:6b7:586c:6db with SMTP id 6a1803df08f44-6b77e1a9bbbmr4347496d6.9.1721071322604;
        Mon, 15 Jul 2024 12:22:02 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:22:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>,
	x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 8/8] mm/mprotect: fix dax pud handlings
Date: Mon, 15 Jul 2024 15:21:42 -0400
Message-ID: <20240715192142.3241557-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is only relevant to the two archs that support PUD dax, aka, x86_64
and ppc64.  PUD THPs do not yet exist elsewhere, and hugetlb PUDs do not
count in this case.

DAX have had PUD mappings for years, but change protection path never
worked.  When the path is triggered in any form (a simple test program
would be: call mprotect() on a 1G dev_dax mapping), the kernel will report
"bad pud".  This patch should fix that.

The new change_huge_pud() tries to keep everything simple.  For example, it
doesn't optimize write bit as that will need even more PUD helpers.  It's
not too bad anyway to have one more write fault in the worst case once for
1G range; may be a bigger thing for each PAGE_SIZE, though.  Neither does
it support userfault-wp bits, as there isn't such PUD mappings that is
supported; file mappings always need a split there.

The same to TLB shootdown: the pmd path (which was for x86 only) has the
trick of using _ad() version of pmdp_invalidate*() which can avoid one
redundant TLB, but let's also leave that for later.  Again, the larger the
mapping, the smaller of such effect.

Another thing worth mention is this path needs to be careful on handling
"retry" event for change_huge_pud() (where it can return 0): it isn't like
change_huge_pmd(), as the pmd version is safe with all conditions handled
in change_pte_range() later, thanks to Hugh's new pte_offset_map_lock().
In short, change_pte_range() is simply smarter than change_pmd_range() now
after the shmem thp collapse rework.  For that reason, change_pud_range()
will need proper retry if it races with something else when a huge PUD
changed from under us.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
Fixes: 27af67f35631 ("powerpc/book3s64/mm: enable transparent pud hugepage")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 24 +++++++++++++++++++
 mm/huge_memory.c        | 52 +++++++++++++++++++++++++++++++++++++++++
 mm/mprotect.c           | 34 ++++++++++++++++++++++-----
 3 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index cff002be83eb..6e742680590a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -336,6 +336,17 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long address);
 
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		    pud_t *pudp, unsigned long addr, pgprot_t newprot,
+		    unsigned long cp_flags);
+#else
+static inline int
+change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		pud_t *pudp, unsigned long addr, pgprot_t newprot,
+		unsigned long cp_flags) { return 0; }
+#endif
+
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
@@ -579,6 +590,19 @@ static inline int next_order(unsigned long *orders, int prev)
 {
 	return 0;
 }
+
+static inline void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
+				    unsigned long address)
+{
+}
+
+static inline int change_huge_pud(struct mmu_gather *tlb,
+				  struct vm_area_struct *vma, pud_t *pudp,
+				  unsigned long addr, pgprot_t newprot,
+				  unsigned long cp_flags)
+{
+	return 0;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c10247bef08a..9a00c5955c0c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2112,6 +2112,53 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	return ret;
 }
 
+/*
+ * Returns:
+ *
+ * - 0: if pud leaf changed from under us
+ * - 1: if pud can be skipped
+ * - HPAGE_PUD_NR: if pud was successfully processed
+ */
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		    pud_t *pudp, unsigned long addr, pgprot_t newprot,
+		    unsigned long cp_flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pud_t oldpud, entry;
+	spinlock_t *ptl;
+
+	tlb_change_page_size(tlb, HPAGE_PUD_SIZE);
+
+	/* NUMA balancing doesn't apply to dax */
+	if (cp_flags & MM_CP_PROT_NUMA)
+		return 1;
+
+	/*
+	 * Huge entries on userfault-wp only works with anonymous, while we
+	 * don't have anonymous PUDs yet.
+	 */
+	if (WARN_ON_ONCE(cp_flags & MM_CP_UFFD_WP_ALL))
+		return 1;
+
+	ptl = __pud_trans_huge_lock(pudp, vma);
+	if (!ptl)
+		return 0;
+
+	/*
+	 * Can't clear PUD or it can race with concurrent zapping.  See
+	 * change_huge_pmd().
+	 */
+	oldpud = pudp_invalidate(vma, addr, pudp);
+	entry = pud_modify(oldpud, newprot);
+	set_pud_at(mm, addr, pudp, entry);
+	tlb_flush_pud_range(tlb, addr, HPAGE_PUD_SIZE);
+
+	spin_unlock(ptl);
+	return HPAGE_PUD_NR;
+}
+#endif
+
 #ifdef CONFIG_USERFAULTFD
 /*
  * The PT lock for src_pmd and dst_vma/src_vma (for reading) are locked by
@@ -2342,6 +2389,11 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
 }
+#else
+void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
+		unsigned long address)
+{
+}
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2a81060b603d..694f13b83864 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -425,31 +425,53 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mmu_notifier_range range;
-	pud_t *pud;
+	pud_t *pudp, pud;
 	unsigned long next;
 	long pages = 0, ret;
 
 	range.start = 0;
 
-	pud = pud_offset(p4d, addr);
+	pudp = pud_offset(p4d, addr);
 	do {
+again:
 		next = pud_addr_end(addr, end);
-		ret = change_prepare(vma, pud, pmd, addr, cp_flags);
+		ret = change_prepare(vma, pudp, pmd, addr, cp_flags);
 		if (ret) {
 			pages = ret;
 			break;
 		}
-		if (pud_none_or_clear_bad(pud))
+
+		pud = READ_ONCE(*pudp);
+		if (pud_none(pud))
 			continue;
+
 		if (!range.start) {
 			mmu_notifier_range_init(&range,
 						MMU_NOTIFY_PROTECTION_VMA, 0,
 						vma->vm_mm, addr, end);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		pages += change_pmd_range(tlb, vma, pud, addr, next, newprot,
+
+		if (pud_leaf(pud)) {
+			if ((next - addr != PUD_SIZE) ||
+			    pgtable_split_needed(vma, cp_flags)) {
+				__split_huge_pud(vma, pudp, addr);
+				goto again;
+			} else {
+				ret = change_huge_pud(tlb, vma, pudp,
+						      addr, newprot, cp_flags);
+				if (ret == 0)
+					goto again;
+				/* huge pud was handled */
+				if (ret == HPAGE_PUD_NR)
+					pages += HPAGE_PUD_NR;
+				continue;
+			}
+		}
+
+		pages += change_pmd_range(tlb, vma, pudp, addr, next, newprot,
 					  cp_flags);
-	} while (pud++, addr = next, addr != end);
+	} while (pudp++, addr = next, addr != end);
 
 	if (range.start)
 		mmu_notifier_invalidate_range_end(&range);
-- 
2.45.0


