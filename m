Return-Path: <linux-kernel+bounces-224856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232139127A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E6628C7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4AA6F2F0;
	Fri, 21 Jun 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhDJRyda"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5F433D6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979927; cv=none; b=CqwgE9Tuzwz8e7c72syJ+PdXCiErJE5xqVl0+kzMtwrKpq7wORtkoHm5XrOgEm30LclKdgt5klKiXjxZOe0vgZSOiOQwUGcMwa8Ls4rBqN/YPw/uq5nFu625OrcmEpyuwsHQbydUnS1S3aJVpPJYByiEEPe+KFJM390eTIFm1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979927; c=relaxed/simple;
	bh=nOXxENP+SihR2L2Tw2z5KRQQ1L5Z5qj+bFBtQ9AMgag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5xMo1IVrdcJxqzsyib2HGQpO8dXjFWc30/hSsMPCfB/Si47sXQpX8b1hNmjBF2SYl6J8VzaHxy0CTmTdeD2cLie0tdIAUKDxqwrX2Nq3unqIusbCWL0gTXIoaMWEj2dxYtWdS3SLiwl/nIcA66mSMFO0jRAo4PZYaWyQ0CSHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhDJRyda; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718979924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FloNdHDAMCUmgBKRbs+OcXuVLR4NlkKUkgqw/Oorwhs=;
	b=QhDJRyda6rNLejYdscfslEYaJxGeILdq153SuN9eyZ0LtXj6AiVP5gKTDJjuHEtS33WJWn
	1gsisAKU5bPwDGucD3EtvtAvhf/r78i55N7iSW1OW7AJLxhtlMceL81kshrn8E43g0nJPn
	ZjLNyuYRJDlz60lYG8ctuFoc2fnu/4g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-o5dTw0E7NY-6exYoyF7aiw-1; Fri, 21 Jun 2024 10:25:23 -0400
X-MC-Unique: o5dTw0E7NY-6exYoyF7aiw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43e2c5354f9so3561121cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979922; x=1719584722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FloNdHDAMCUmgBKRbs+OcXuVLR4NlkKUkgqw/Oorwhs=;
        b=JO4jqCxIYySyHdzyVjXq3s5JZPIgVnaRZox5KAaRTv7nnTKDhyW1ekh7fpo5EID//5
         BO99YbnpF407IjO6fnYt5yMg+7PbXIZTB9RqXdIf+6cvDyz+dCd856zRbCAibc72oHET
         6jw97g7cG/aDwYvCJN2NZXIdaC6oVEguJhSDAfOJVNpiBx8YiQIe/jcs3LRZFE5ws9Mv
         lthZzWgfilS8elAWhF0Asla7kxfmlakGbbSdaQ/xrYRB0gPGecw5lktiarK4VUKZQweb
         PRx9OUMtXZD/EPQqoqCVVbpLPa2z7trqWVa/MCDwuaD8hMhFqtm2A3AMxvZdzQh/q6IB
         Y1ZA==
X-Gm-Message-State: AOJu0YxV42dgSEWhtmoikB97b00+VAzlQ56xjIKxA5eqVGvYmtfnJ/CQ
	UDv3BPQdqY1r45NmQsSg7JiOW8Kxo2oytIRjYai3oUHGWYeE4PjxV5072phDwddlx9+L82pmyi1
	AeguHuXuzZY2v1Sg/4bhcgH71fjRvu6no3HaKf/ZjY6aNnnUDu1Y2wT68O5AVnHRQpDACwFvo2v
	qUfGWdDItjqrfFm2qFk07sQ07acWer7bsfMFGr+RsS28c=
X-Received: by 2002:a05:620a:4725:b0:79b:b8ef:160f with SMTP id af79cd13be357-79bb8ef1a25mr832758785a.0.1718979922257;
        Fri, 21 Jun 2024 07:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKznxYW2FLJ0xJwWKaEtD8Tk/BHH+OIQZWLkXgxtzT/k39w+HZ9hDMrU5i6fKaXRUQoupH+Q==
X-Received: by 2002:a05:620a:4725:b0:79b:b8ef:160f with SMTP id af79cd13be357-79bb8ef1a25mr832752985a.0.1718979921429;
        Fri, 21 Jun 2024 07:25:21 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce944cb2sm90564785a.125.2024.06.21.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:25:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH 7/7] mm/mprotect: fix dax pud handlings
Date: Fri, 21 Jun 2024 10:25:04 -0400
Message-ID: <20240621142504.1940209-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240621142504.1940209-1-peterx@redhat.com>
References: <20240621142504.1940209-1-peterx@redhat.com>
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
 mm/mprotect.c           | 40 ++++++++++++++++++++++++-------
 3 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 212cca384d7e..b46673689f19 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -345,6 +345,17 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
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
@@ -588,6 +599,19 @@ static inline int next_order(unsigned long *orders, int prev)
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
index 0fffaa58a47a..af8d83f4ce02 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2091,6 +2091,53 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2319,6 +2366,11 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
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
index fb8bf3ff7cd9..694f13b83864 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -425,29 +425,53 @@ static inline long change_pud_range(struct mmu_gather *tlb,
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
-		if (ret)
-			return ret;
-		if (pud_none_or_clear_bad(pud))
+		ret = change_prepare(vma, pudp, pmd, addr, cp_flags);
+		if (ret) {
+			pages = ret;
+			break;
+		}
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


