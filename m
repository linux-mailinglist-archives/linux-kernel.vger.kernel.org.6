Return-Path: <linux-kernel+bounces-240211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3326926A48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A711F2327D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CEF194147;
	Wed,  3 Jul 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a01RS/TJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE0191F8E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042184; cv=none; b=OJvy7H3WKxqgXmYdm0ugOIitL0N22zL4oLpWw9QJf0LZi6Zl65WwMSeJwdhNuH+B0kHKLcoCQ0mDoioCJTFuoU7sOXQCHIQuRFQEel2MLLtmE3G6skxp5dDxyZDYQzc7T0uAzZOlX8+YK/lpS/FJe5+uncWi3UVNhreOUgR3UPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042184; c=relaxed/simple;
	bh=RvEiakZHQCqkyKEDQbLD0I2EOD9bX4tcpkuD7BRzdYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snLjU5/D9u8aoc1AW9WXdfc37ibY8jzelnVAMjSLVm2EtZlIb++Dj0bIvwfnOX6Y0pfaWSS81p97VEP+QPvuvUN/3jqkl8UmQRPiDApJstfQFLoRE8r6IeUI471qDBBnieNSfFT1/7I4UxkCexfhMxaRCwbCfj7aKQd9BdMzDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a01RS/TJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720042182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2Zxgw15onbd0eMS/03kg+dHZsOcAz6IsQR1l1z1OuE=;
	b=a01RS/TJJveUPLYohI+PTw4Fz5ABLMwFdAAq3dpTUoz/WuTF3ra6SI4H9Ng8QvhLaP8Z0f
	IWHUFdCqTMaKz1YyyoNa/jaJ4g9p3opnxtMz29ono+EO7o1zW8fmDL1K/AvEDthPMXa5IO
	7rgSEkSIaXG+XtrE1XZhWOSSDtAcGe0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-I286sxBrM--7qt7460bY_w-1; Wed, 03 Jul 2024 17:29:40 -0400
X-MC-Unique: I286sxBrM--7qt7460bY_w-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4464454e329so1958291cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042180; x=1720646980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2Zxgw15onbd0eMS/03kg+dHZsOcAz6IsQR1l1z1OuE=;
        b=ZOah8deW2KtMwmOfOMsIS7RCtjPxvq4LE935UBYwYyGooHgWzwMon5Jq9bYGlCvyYa
         V4O4BwDXuFl+Ba9100AyQX/az7aevssQvlfiTJqAUASgoehTFogSAa9/ohFr0m7Gy6Ud
         Ky7zjxI82Rl2Lh6DL2rVXAWzXOoh+Se8ksxLfZLt7v1DrkhkFrFZU67tRURklLEGBwKU
         k9GCuNDuS3Hd6yhEEPnZ45c9CvSZAIrSjbTzkokMfILBqEmHlUXTc5Pxvduh29wFjK4i
         D5VZ95pZOzkvLxmRHrdQK0Nu+nVthm5xGY18YK8NdzzBU2WbMvhiK2IFd/m2r8TLxZXN
         jhnQ==
X-Gm-Message-State: AOJu0YzajAytjK2C+rVnJ41Gw+6ocpn1Pee+uMzWy1YXCsZwxdVuRUnd
	esxf/u24XStybVWl+REk4Kgqt1cKOmAORbQ/sn+0KfszxtwRjB0wd+agHzzcrd0ddmByyknJNry
	FDvcYLe3AOQ6y3wrmGF++nkJDR4uTUVYikQ5u515jB44sHsgFfKQhJ3DmEpTyOBH8kV/hnz06W2
	Zs9ElyxuUSRAQhOk8l6s/bAnmZKlZobGVH1jcLhNJ7c6A=
X-Received: by 2002:a05:622a:8f:b0:446:3c97:d3ab with SMTP id d75a77b69052e-44662eb7436mr151118711cf.4.1720042179770;
        Wed, 03 Jul 2024 14:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9nYtpxfPIDPA/kSFmDjfHMlL7UyJZQtNoCKoRdFeJRABCZlINs1O4dDPbOXn5gaxSQwwtsA==
X-Received: by 2002:a05:622a:8f:b0:446:3c97:d3ab with SMTP id d75a77b69052e-44662eb7436mr151118391cf.4.1720042179335;
        Wed, 03 Jul 2024 14:29:39 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143eb1csm54337481cf.57.2024.07.03.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:29:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Dave Jiang <dave.jiang@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Dan Williams <dan.j.williams@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	peterx@redhat.com,
	Hugh Dickins <hughd@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 8/8] mm/mprotect: fix dax pud handlings
Date: Wed,  3 Jul 2024 17:29:18 -0400
Message-ID: <20240703212918.2417843-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240703212918.2417843-1-peterx@redhat.com>
References: <20240703212918.2417843-1-peterx@redhat.com>
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
index cee3c5da8f0e..2ebebadfbe47 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -348,6 +348,17 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
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
@@ -591,6 +602,19 @@ static inline int next_order(unsigned long *orders, int prev)
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
index 017377920d18..4998452f7c49 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2099,6 +2099,53 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2329,6 +2376,11 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
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


