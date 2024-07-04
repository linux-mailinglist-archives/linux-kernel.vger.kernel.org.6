Return-Path: <linux-kernel+bounces-240508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B02926E66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C181B24839
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBA14386B;
	Thu,  4 Jul 2024 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rGzyLD7L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8nHTN6MV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rGzyLD7L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8nHTN6MV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06327142E7A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067535; cv=none; b=ssEAhSckkGkL2MjHn+zwE8qriMJIEM0GGNvS6hb4+1OmXHPyHR9kKSG2PCymqzVJETUt3eg/rMITGORhKuhDhatFftv0S6zTPPcX/mIeX88flEbvak9Aj9KNgSqxc8PjTOp8xnYnPAggxtIEZVBMbmM66/B/EBQv/PpoQfzYSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067535; c=relaxed/simple;
	bh=sfs9op56n+Ymo/NUKk/B9a68bdkBPRf5wMfkaL74S/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saA6KXtgX5luHaZ5xtAzomqdf03E5p3kuvezUAEthK1LlU3vV2c1151hzBgvyCfsget90fLPJ5vV9tqGNMBOIuYXWVb8KfcpiEClP8aOdya5WpoXK32oSoaqGq2X9jSyuk7EtiS0h0usaaI2LNLU3xAxDWekSDcHVw7+XhntSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rGzyLD7L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8nHTN6MV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rGzyLD7L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8nHTN6MV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 717E31FCF8;
	Thu,  4 Jul 2024 04:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKLC6fxewOrLf0i98Rd25YFQam44kkf2M+DOutpQYdQ=;
	b=rGzyLD7LkYyMAvmIw4xFUDH+buX9d/II8oeFi+WRfNzUSU6mBH1Xd+8r3gYOEPGL9dYDCy
	IlLqdjWxRy5mraTCwA+0ut4zZnng0xAJIvDVvopn+3dMXHd6APSdUZmCaNvfWzCqwkjiNn
	u/St7F29ojB/6wl0e44bDnr1D1/7TB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKLC6fxewOrLf0i98Rd25YFQam44kkf2M+DOutpQYdQ=;
	b=8nHTN6MVi8gMxqJWpwXDGmQUc1P5i9EMQ+Rwyw40Sbfz/xQvdeEiZOiulE9osEkcCpeY4k
	3YaniTexv02tM6Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKLC6fxewOrLf0i98Rd25YFQam44kkf2M+DOutpQYdQ=;
	b=rGzyLD7LkYyMAvmIw4xFUDH+buX9d/II8oeFi+WRfNzUSU6mBH1Xd+8r3gYOEPGL9dYDCy
	IlLqdjWxRy5mraTCwA+0ut4zZnng0xAJIvDVvopn+3dMXHd6APSdUZmCaNvfWzCqwkjiNn
	u/St7F29ojB/6wl0e44bDnr1D1/7TB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKLC6fxewOrLf0i98Rd25YFQam44kkf2M+DOutpQYdQ=;
	b=8nHTN6MVi8gMxqJWpwXDGmQUc1P5i9EMQ+Rwyw40Sbfz/xQvdeEiZOiulE9osEkcCpeY4k
	3YaniTexv02tM6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E2E313889;
	Thu,  4 Jul 2024 04:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UP40DsolhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:10 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 17/45] mm: Implement pud-version for pud_mkinvalid and pudp_establish
Date: Thu,  4 Jul 2024 06:31:04 +0200
Message-ID: <20240704043132.28501-18-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
References: <20240704043132.28501-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]

HugeTLB pages will be handled on pud level as well, so we need to
implement pud-versions of pud_mkinvalid and pudp_establish.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/arm64/include/asm/pgtable.h             | 11 ++++++
 arch/loongarch/include/asm/pgtable.h         |  8 ++++
 arch/mips/include/asm/pgtable.h              |  7 ++++
 arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++-
 arch/powerpc/mm/book3s64/pgtable.c           | 15 ++++++-
 arch/riscv/include/asm/pgtable.h             | 15 +++++++
 arch/x86/include/asm/pgtable.h               | 31 ++++++++++++++-
 include/linux/pgtable.h                      | 41 +++++++++++++++++++-
 mm/pgtable-generic.c                         | 21 ++++++++++
 9 files changed, 150 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 936ed3a915a3..5e26e63b1012 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -595,6 +595,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
 #define pud_mkhuge(pud)		(__pud(pud_val(pud) & ~PUD_TABLE_BIT))
+#define pud_mkinvalid(pud)	pte_pud(pte_mkinvalid(pud_pte(pud)))
 
 #define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
 #define __phys_to_pud_val(phys)	__phys_to_pte_val(phys)
@@ -1344,6 +1345,16 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
+#define pudp_establish pudp_establish
+static inline pud_t pudp_establish(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp, pud_t pud)
+{
+	page_table_check_pud_set(vma->vm_mm, pudp, pud);
+	return __pud(xchg_relaxed(&pud_val(*pudp), pud_val(pud)));
+}
+#endif
+
 /*
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 161dd6e10479..cf73c2f2da2c 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -581,6 +581,14 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 	return pmd;
 }
 
+static inline pud_t pud_mkinvalid(pud_t pud)
+{
+	pud_val(pud) |= _PAGE_PRESENT_INVALID;
+	pud_val(pud) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY | _PAGE_PROTNONE);
+
+	return pud;
+}
+
 /*
  * The generic version pmdp_huge_get_and_clear uses a version of pmd_clear() with a
  * different prototype.
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index c29a551eb0ca..390a2f022147 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -736,6 +736,13 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 	return pmd;
 }
 
+static inline pud_t pud_mkinvalid(pud_t pud)
+{
+	pud_val(pud) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY);
+
+	return pud;
+}
+
 /*
  * The generic version pmdp_huge_get_and_clear uses a version of pmd_clear() with a
  * different prototype.
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index fa4bb8d6356f..f95ac2a87548 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1085,7 +1085,8 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
 #define pmd_clear_soft_dirty(pmd) pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)))
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+#if defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) || defined(CONFIG_HUGETLB_PAGE)
+#define pud_swp_soft_dirty(pud)		pte_swp_soft_dirty(pud_pte(pud))
 #define pmd_swp_mksoft_dirty(pmd)	pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)))
 #define pmd_swp_soft_dirty(pmd)		pte_swp_soft_dirty(pmd_pte(pmd))
 #define pmd_swp_clear_soft_dirty(pmd)	pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)))
@@ -1386,6 +1387,10 @@ static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
 extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			     pmd_t *pmdp);
 
+#define __HAVE_ARCH_PUDP_INVALIDATE
+extern pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			     pud_t *pudp);
+
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
 extern int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index f4d8d3c40e5c..1b6ae7898f99 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL(__pmd_frag_nr);
 unsigned long __pmd_frag_size_shift;
 EXPORT_SYMBOL(__pmd_frag_size_shift);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 /*
  * This is called when relaxing access to a hugepage. It's also called in the page
  * fault path when we don't hit any of the major fault cases, ie, a minor
@@ -259,7 +259,18 @@ pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	pmdv &= _HPAGE_CHG_MASK;
 	return pmd_set_protbits(__pmd(pmdv), newprot);
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		     pud_t *pudp)
+{
+	unsigned long old_pud;
+
+	VM_WARN_ON_ONCE(!pud_present(*pudp));
+	old_pud = pud_hugepage_update(vma->vm_mm, address, pudp, _PAGE_PRESENT, _PAGE_INVALID);
+	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	return __pud(old_pud);
+}
+#endif /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 
 /* For use by kexec, called with MMU off */
 notrace void mmu_cleanup_all(void)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ebfe8faafb79..51600afa203c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -657,6 +657,11 @@ static inline unsigned long pud_pfn(pud_t pud)
 	return ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT);
 }
 
+static inline pud_t pud_mkinvalid(pud_t pud)
+{
+	return __pud(pud_val(pud) & ~(_PAGE_PRESENT|_PAGE_PROT_NONE));
+}
+
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
@@ -804,6 +809,16 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#ifdef CONFIG_HUGETLB_PAGE
+#define pudp_establish pudp_establish
+static inline pud_t pudp_establish(struct vm_area_struct *vma,
+				unsigned long address, pud_t *pudp, pud_t pud)
+{
+	page_table_check_pud_set(vma->vm_mm, pudp, pud);
+	return __pud(atomic_long_xchg((atomic_long_t *)pudp, pud_val(pud)));
+}
+#endif
+
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
  * are !pte_none() && !pte_present().
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 640edc31962f..572458a106e9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -783,6 +783,12 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 		      __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
 }
 
+static inline pud_t pud_mkinvalid(pud_t pud)
+{
+	return pfn_pud(pud_pfn(pud),
+		      __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
+}
+
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
@@ -1353,6 +1359,23 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 	return pud;
 }
 
+#ifndef pudp_establish
+#define pudp_establish pudp_establish
+static inline pud_t pudp_establish(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp, pud_t pud)
+{
+	page_table_check_pud_set(vma->vm_mm, pudp, pud);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		return xchg(pudp, pud);
+	} else {
+		pud_t old = *pudp;
+
+		WRITE_ONCE(*pudp, pud);
+		return old;
+	}
+}
+#endif
+
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
@@ -1389,7 +1412,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PMDP_INVALIDATE_AD
 extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp);
-
 /*
  * Page table pages are page-aligned.  The lower half of the top
  * level is used for userspace and the top half for the kernel.
@@ -1541,7 +1563,12 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 	return pte_clear_flags(pte, _PAGE_SWP_SOFT_DIRTY);
 }
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+#if defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) || defined(CONFIG_HUGETLB_PAGE)
+static inline int pud_swp_soft_dirty(pud_t pud)
+{
+	return pud_flags(pud) & _PAGE_SWP_SOFT_DIRTY;
+}
+
 static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_SWP_SOFT_DIRTY);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a2e2ebb93f21..458e3cbc96b2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -956,6 +956,11 @@ extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_INVALIDATE
+extern pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			    pud_t *pudp);
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE_AD
 
 /*
@@ -976,6 +981,26 @@ extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_INVALIDATE_AD
+
+/*
+ * pudp_invalidate_ad() invalidates the PMD while changing a hugetlb mapping in
+ * the page tables. This function is similar to pudp_invalidate(), but should
+ * only be used if the access and dirty bits would  not be cleared by the software
+ * in the new PUD value. The function ensures  that hardware changes of the access
+ * and dirty bits updates would not be lost.
+ *
+ * Doing so can allow in certain architectures to avoid a TLB flush in most
+ * cases. Yet, another TLB flush might be necessary later if the PUD update
+ * itself requires such flush (e.g., if protection was set to be stricter). Yet,
+ * even when a TLB flush is needed because of the update, the caller may be able
+ * to batch these TLB flushing operations, so fewer TLB flush operations are
+ * needed.
+ */
+extern pud_t pudp_invalidate_ad(struct vm_area_struct *vma,
+				unsigned long address, pud_t *pudp);
+#endif
+
 #ifndef __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
@@ -1406,7 +1431,16 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
-#ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
+static inline int pud_soft_dirty(pud_t pud)
+{
+	return 0;
+}
+#if !defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !defined(CONFIG_HUGETLB_PAGE)
+static inline int pud_swp_soft_dirty(pud_t pud)
+{
+	return 0;
+}
+
 static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
 {
 	return pmd;
@@ -1487,6 +1521,11 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
 {
 	return pmd;
 }
+
+static inline int pud_swp_soft_dirty(pud_t pud)
+{
+	return 0;
+}
 #endif
 
 #ifndef __HAVE_PFNMAP_TRACKING
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4adf711a..e11ad8663903 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -194,6 +194,27 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 }
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_INVALIDATE
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		     pud_t *pudp)
+{
+	VM_WARN_ON_ONCE(!pud_present(*pudp));
+	pud_t old = pudp_establish(vma, address, pudp, pud_mkinvalid(*pudp));
+
+	flush_pud_tlb_range(vma, address, address + PUD_SIZE);
+	return old;
+}
+#endif
+
+#ifndef __HAVE_ARCH_PUDP_INVALIDATE_AD
+pud_t pudp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
+			 pud_t *pudp)
+{
+	VM_WARN_ON_ONCE(!pud_present(*pudp));
+	return pudp_invalidate(vma, address, pudp);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
 pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
-- 
2.26.2


