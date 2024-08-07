Return-Path: <linux-kernel+bounces-278473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E494B0A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9998A283F45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE20148832;
	Wed,  7 Aug 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEBNCaFW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14603145335
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060115; cv=none; b=o9UpJQzOMXuB5IgiFY9rbOAtDp2A4KT0FrAsU36IVJ1aJyHUGNQtzO7Xi45GB53vz1QUW41iu4rPzeiXcUtjQ1G0iF39h0lMbNktUHaaHi40B4OfQC4X/kLvlE9ckvkqsd6CfNBFQ6KlJM39EzEPztXWZXNStN7Ty2zrSuqjSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060115; c=relaxed/simple;
	bh=egk112t/6BSuiTyKSVUoJ65Hf838PJyUoM/Z74+luwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4o0SfjdckQh1sy/zMPpI0vsuE8Kt3ncZkcPsFKLEcQQ/Vl27uM+iH+c1BieDc/r2epyyqfIATKPi7EafhqgZEVklmVREQXy2Krdrp2WZRya2pmmmZ4W/zTYGzQ+tiQOhHNsSxOdhRjefdyuXsf4sAerXanqEKFUmeziZb8HaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEBNCaFW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723060113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/6PEtzQTa+drbYKkEnodTZuUMYm4tSA4vStMaJG0Ro=;
	b=bEBNCaFWkhNqkgYgioe+QAykpqrs4ItH0zPmZs/kitG5LMOh35RYXkjYyjcznhPRb+EEHN
	4XOavuHY22dodEpRJDtVFDBfmL+6XC59DRz1GCz2vqpDWM491tb8bU5dCBNdCmC3V2bTKp
	Az56uvWuEfLY9lYlhfOW8X16wqpInGw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-uE9-s9MzOdmlYmkBR4LhZw-1; Wed, 07 Aug 2024 15:48:32 -0400
X-MC-Unique: uE9-s9MzOdmlYmkBR4LhZw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b7ad98c1f8so389826d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060111; x=1723664911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/6PEtzQTa+drbYKkEnodTZuUMYm4tSA4vStMaJG0Ro=;
        b=bLGhJMZJjepWxMmbawT/qn684rfr/Pgh5CuhAL07Jl1BqPksAj2jxWaE6MmaSMymYV
         54YqLB8DlbQvY79tvuNnivdwwMNvAJDpzsfszsq27lEbPj+GWaExlR+QUDgQpSnofshb
         EOFAa0VD5GbKAgnDXtVRvJ13rvSM16gIiclhXtctFpDWTCygoQugkkoKgtR6ndnwu1PM
         DDRvYY68Tu2TKulRJfmlO6AfmfhB8U0tYGYnJZ+GDORN3U7Uzy1er5IoFvItW5lwOfwA
         ogma2R3t47clgifEv/njhJVUbovgCti6/pR50VjaUTazqyfdCxNpZiFeVznyTG2DMfTy
         4Emg==
X-Gm-Message-State: AOJu0YzsURQfKXFbhzoNRl90CyI+SMbnldUdpDdKyzPqN3Odgc0vKemc
	zLGuBrB0wh9ShFmAVdURBc9p3r+ALfY07kjEjhcnXPgluK7RTneeIZYr+fXn5QFrKQMHob+MzvF
	UnGpTj343YvFvHRBZzEkFV4zUtYhAnQQBN8j0YPBtW3YoA3vSgRhaxdXTZ3+gjXL4trvR/o1E9a
	F+a5NDT3OdGYxJLYrKxZEVTXSWbOkkZNHQE3GTYKgqQrA=
X-Received: by 2002:a05:6214:e64:b0:6b0:8202:5c4e with SMTP id 6a1803df08f44-6bb983f0fa6mr145729416d6.5.1723060110884;
        Wed, 07 Aug 2024 12:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjs/meRFYsBYhQNSwMvbRLZa9/TlQmQfQAUysM61b8jRz23PUki/2rojCFyrJzg3cPY3hNlw==
X-Received: by 2002:a05:6214:e64:b0:6b0:8202:5c4e with SMTP id 6a1803df08f44-6bb983f0fa6mr145728896d6.5.1723060110042;
        Wed, 07 Aug 2024 12:48:30 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ae4asm59853256d6.33.2024.08.07.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:48:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	peterx@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v4 7/7] mm/mprotect: fix dax pud handlings
Date: Wed,  7 Aug 2024 15:48:11 -0400
Message-ID: <20240807194812.819412-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807194812.819412-1-peterx@redhat.com>
References: <20240807194812.819412-1-peterx@redhat.com>
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

There's some difference on handling "retry" for change_huge_pud() (where it
can return 0): it isn't like change_huge_pmd(), as the pmd version is safe
with all conditions handled in change_pte_range() later, thanks to Hugh's
new pte_offset_map_lock().  In short, change_pte_range() is simply smarter.
For that, change_pud_range() will need proper retry if it races with
something else when a huge PUD changed from under us.

The last thing to mention is currently the PUD path ignores the huge pte
numa counter (NUMA_HUGE_PTE_UPDATES), not only because DAX is not
applicable to NUMA, but also that it's ambiguous on its own to decide how
to account pud in this case.  In one earlier version of this patchset I
proposed to remove the counter as it doesn't even look right to do the
accounting as of now [1], but then a further discussion suggests we can
leave that for later, as that doesn't block this series if we choose to
ignore that counter.  That's what this patch does, by ignoring it.

When at it, touch up the comment in pgtable_split_needed() to make it
generic to either pmd or pud file THPs.

[1] https://lore.kernel.org/all/20240715192142.3241557-3-peterx@redhat.com/
[2] https://lore.kernel.org/r/added2d0-b8be-4108-82ca-1367a388d0b1@redhat.com

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
 mm/mprotect.c           | 39 ++++++++++++++++++++++++-------
 3 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ce44caa40eed..6370026689e0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -342,6 +342,17 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
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
@@ -585,6 +596,19 @@ static inline int next_order(unsigned long *orders, int prev)
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
index 81c5da0708ed..0aafd26d7a53 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2114,6 +2114,53 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2344,6 +2391,11 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
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
index d423080e6509..446f8e5f10d9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -302,8 +302,9 @@ pgtable_split_needed(struct vm_area_struct *vma, unsigned long cp_flags)
 {
 	/*
 	 * pte markers only resides in pte level, if we need pte markers,
-	 * we need to split.  We cannot wr-protect shmem thp because file
-	 * thp is handled differently when split by erasing the pmd so far.
+	 * we need to split.  For example, we cannot wr-protect a file thp
+	 * (e.g. 2M shmem) because file thp is handled differently when
+	 * split by erasing the pmd so far.
 	 */
 	return (cp_flags & MM_CP_UFFD_WP) && !vma_is_anonymous(vma);
 }
@@ -430,31 +431,53 @@ static inline long change_pud_range(struct mmu_gather *tlb,
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


