Return-Path: <linux-kernel+bounces-283568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA094F66C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E46F1F23877
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286E192B65;
	Mon, 12 Aug 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEnKrTSo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C550193063
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486371; cv=none; b=LLrZfLq6VzyWkOBpVzclvISerdRNAFYEhL2uKSxyzycAw/j6GtnR4QVvQ2JAzkKlJ28fWHsBu9U0wk/a6xenG6kLA8c68nkSnzLrD9MZ+BBb0F7AbkdGxardy65DiXSOOFxNFhoqmdYQv9UHi50k3aSzkuPVe/JZISCOrg15jK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486371; c=relaxed/simple;
	bh=egk112t/6BSuiTyKSVUoJ65Hf838PJyUoM/Z74+luwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEwUr9e2Qxz3tAA15c6TjybyDmBr9sf+y0wp4Jd2NqVaGfb0KpAffrMcab+BeBk9iMLDmJ7JA78wr5uj3SsZ3shKB0ZiyfjFio10gQZbHmoEla8XIRnZu44AsiK/X2lb/mz/acxz8Rh0B+4A8cC+y6QXburJNJSPs7tK24opR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEnKrTSo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/6PEtzQTa+drbYKkEnodTZuUMYm4tSA4vStMaJG0Ro=;
	b=UEnKrTSobfuJJMruYMfG9zUfFX85yzoth4kuyLLKQ07HEMeRx/b97SI2p5SlpRHwU+8QxI
	VV8I9h8C+l3x3wmY8CISO1QRU179+hw9J1pYTnrbKtPkYwsnOF2EXkFLeXCSRDpxCZDH5k
	GhDEBI2jap3KQG8peg6v4KHNtZUg5MM=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-Gb20Htx1MOilRfxudOpp-w-1; Mon, 12 Aug 2024 14:12:45 -0400
X-MC-Unique: Gb20Htx1MOilRfxudOpp-w-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4928d06cfebso184724137.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486364; x=1724091164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/6PEtzQTa+drbYKkEnodTZuUMYm4tSA4vStMaJG0Ro=;
        b=TZBSCmRaRopGQoEG7SFmv1xruGDao+Akk8RErfxjX6sQ7js9DCaBI69nJpnQ0F23Dc
         F3/zfvW9VG4g0fuAuotKvnf0M6TcTjUkCjXK4oYyNtW8zSMJlet1WCMichp8CcZd3KWG
         UNzhkKb9e/au5HNHh/VMh75X9VYB+XznNqI3RexhtG8Sfi22vI3+ph8yuoxpRl9zlf7b
         cjZEzWmKMqhKWlqL6NMO5wDZvlSUsdyWeBggvV2LLISpANK0QbNpmODUqHLKgUZ/mhBw
         yK8oAkXlEySq6EUngcIWLudpCKVO61kvjZ85yMLwfXqAZ2KaYACFuGVhKeu9fyhWOLMC
         1cIw==
X-Gm-Message-State: AOJu0YyVXb2osORwr1YwkFjb/nA+hvekijYkxy07bl+eUGsKg5R+ENEV
	ZdVvZ5b2W35GoPLcp45Ks5z/Qt0iPDpFbemVQaYLb5F3LxvIWne/jyFFzd7kdNdwu7sWibbAvQq
	qd52zyDrRtBsjblnqDdk6LMKPxINWoNWAS3JuAOPpaGeJcn5KID33tY3sh1+a+sXLquZVvaxf61
	za0ID6UzeHaINWFuk1XVgdD1C1ygn+T/PEjdlPRgY2tJU=
X-Received: by 2002:a05:6102:38d1:b0:493:31f9:d14e with SMTP id ada2fe7eead31-4974398cf6amr785279137.2.1723486364510;
        Mon, 12 Aug 2024 11:12:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGg++VQElyCH8BIocMaINRG5gLiISp0Xxb9L94RctCtM0eBivu+dVoRsXo8+SybwrNJQcpMw==
X-Received: by 2002:a05:6102:38d1:b0:493:31f9:d14e with SMTP id ada2fe7eead31-4974398cf6amr785238137.2.1723486364018;
        Mon, 12 Aug 2024 11:12:44 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm268663985a.84.2024.08.12.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	peterx@redhat.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 7/7] mm/mprotect: fix dax pud handlings
Date: Mon, 12 Aug 2024 14:12:25 -0400
Message-ID: <20240812181225.1360970-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240812181225.1360970-1-peterx@redhat.com>
References: <20240812181225.1360970-1-peterx@redhat.com>
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


