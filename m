Return-Path: <linux-kernel+bounces-240210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286CA926A47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5131C21A03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B15194C96;
	Wed,  3 Jul 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjFLKX3w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDF194C7B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042184; cv=none; b=NoUCnAdeeT6Zwqa2cyoaMqW0c+wp6TTHrvRGH1/6QU30mRH3IuJZvFqxRtvw1Qcuel29ng8SiT+yRZJ40erL7EhtFlsy/qvOgCkJB1z7frFffF1fbIJh2N69y/NUGhmAy7obvOThledIi7bOMkeoHZgoaSGD3e5c/P7MihH4heY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042184; c=relaxed/simple;
	bh=ND9R4pqR5t4wh8zD63X9n4hfk1GcVTWL+KMdg1b86QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1NdwB9D6WC/gPM9x5pgRpG8oyfi87xTs6uJmcl9OmnrgbFE5FZTG3jk++JaoyJcfoFnPm4EkIOgGnK23C2NEF/DYSR3yxA5Ikj9BDzit4mt35Njsg172jieaSwBjl30GzFHk7ggQA4G/o5N8MQr2rGaqQ2/TaH3BFFz94bJkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjFLKX3w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720042181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uNV81qP1pkF0zqyhqKWAPXX0CBAvqkfZkOGu2qHMfo=;
	b=LjFLKX3wvbl1wM2U+JA9BUHT6HUNCkfTfGIL1rFrAtzUy45s8GprvYTwJ9YhpmQbBz5Kix
	0sURxyRcwTH0sT6AHgZYMUZT3VlyVSggkwgtf0zMTElWhzLIXSuZbzE5LzzscrwdXk+OjF
	ClibOaigW5aIpJXc34cQhpNibIoIsHg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341--ZfxC851MnCYQtfTH_Aq0w-1; Wed, 03 Jul 2024 17:29:34 -0400
X-MC-Unique: -ZfxC851MnCYQtfTH_Aq0w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-446405b39baso4234671cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042174; x=1720646974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uNV81qP1pkF0zqyhqKWAPXX0CBAvqkfZkOGu2qHMfo=;
        b=YeXSPK07JukDW6ROacGUk5cD+vOdZiKFcHAnQETp9WYXwepmsY4bPPeJiCn9/mQQ3m
         +G7d3xzoWqZKXghv6x9ejgDwzPeZc2U+2KobAr5PhJBBUYhtmxNXw5J087zsgxvyF7+O
         sI7cnjcbPJCzVpUt7gcnTlCqtx8DuzQbdZI2xd4pexlaAnyly+raM93jIVdlDcmOb+6/
         DUDfkvJZn466EsTUX/ToLhKnTvfw00I0nHfDAIf1sarv1k9GK4S/1t4UNK08Vo42KkSa
         /yHxdktB6VOMeH3qx+ZRQlxvWxjVkkVYnDF9vJnwP70o7Vum4SHUIB/D7vkHeAvOu5qN
         fohg==
X-Gm-Message-State: AOJu0Yz43s52mBhacKFFlPB91pF0j74eZZ7O6pG+lDoIaRQtX7Yx92Tz
	Tn03CJpVYd6ARHI7W0BsHq+KtogUUrwdMG4LlqtYBh54DY5uc2U4qWKdTBi1PkNBzJRnSbcZZPe
	8e6J0j3np3KoHxOV4j1ml1YDiHYuYuvyjckk7iZIweLCRmSx+1uVEn3TXogLXVdI0hBslz6lBWO
	qMABaDjrb7FbhoytaPF3C4NOh/c2EngtlTIV+g2Ux+M3s=
X-Received: by 2002:a05:620a:470c:b0:79d:8ea3:9d24 with SMTP id af79cd13be357-79d8ea39f72mr1046537785a.2.1720042173875;
        Wed, 03 Jul 2024 14:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFduTwlKnISGNZIByqQ7Sp6Ih/1fAT1ztK1vNR6ntfPREjYbbEVcJ6gOgRtr7E4arLOH2JOwA==
X-Received: by 2002:a05:620a:470c:b0:79d:8ea3:9d24 with SMTP id af79cd13be357-79d8ea39f72mr1046534585a.2.1720042173510;
        Wed, 03 Jul 2024 14:29:33 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143eb1csm54337481cf.57.2024.07.03.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:29:33 -0700 (PDT)
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
Subject: [PATCH v2 6/8] mm/x86: arch_check_zapped_pud()
Date: Wed,  3 Jul 2024 17:29:16 -0400
Message-ID: <20240703212918.2417843-7-peterx@redhat.com>
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

Introduce arch_check_zapped_pud() to sanity check shadow stack on PUD zaps.
It has the same logic of the PMD helper.

One thing to mention is, it might be a good idea to use page_table_check in
the future for trapping wrong setups of shadow stack pgtable entries [1].
That is left for the future as a separate effort.

[1] https://lore.kernel.org/all/59d518698f664e07c036a5098833d7b56b953305.camel@intel.com

Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 10 ++++++++++
 arch/x86/mm/pgtable.c          |  7 +++++++
 include/linux/pgtable.h        |  7 +++++++
 mm/huge_memory.c               |  4 +++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 25fc6d809572..cdf044c2ad6e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -169,6 +169,13 @@ static inline int pud_young(pud_t pud)
 	return pud_flags(pud) & _PAGE_ACCESSED;
 }
 
+static inline bool pud_shstk(pud_t pud)
+{
+	return cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+	       (pud_flags(pud) & (_PAGE_RW | _PAGE_DIRTY | _PAGE_PSE)) ==
+	       (_PAGE_DIRTY | _PAGE_PSE);
+}
+
 static inline int pte_write(pte_t pte)
 {
 	/*
@@ -1662,6 +1669,9 @@ void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte);
 #define arch_check_zapped_pmd arch_check_zapped_pmd
 void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd);
 
+#define arch_check_zapped_pud arch_check_zapped_pud
+void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud);
+
 #ifdef CONFIG_XEN_PV
 #define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
 static inline bool arch_has_hw_nonleaf_pmd_young(void)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 93e54ba91fbf..564b8945951e 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -926,3 +926,10 @@ void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
 	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
 			pmd_shstk(pmd));
 }
+
+void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud)
+{
+	/* See note in arch_check_zapped_pte() */
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pud_shstk(pud));
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..2289e9f7aa1b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -447,6 +447,13 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef arch_check_zapped_pud
+static inline void arch_check_zapped_pud(struct vm_area_struct *vma,
+					 pud_t pud)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 251d6932130f..017377920d18 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2278,12 +2278,14 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
 	spinlock_t *ptl;
+	pud_t orig_pud;
 
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
 		return 0;
 
-	pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
+	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
+	arch_check_zapped_pud(vma, orig_pud);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
 	if (vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
-- 
2.45.0


