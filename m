Return-Path: <linux-kernel+bounces-278471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82F94B0A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015501C20FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C72147C98;
	Wed,  7 Aug 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLhg6LK5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75585146A62
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060111; cv=none; b=GSeAyZ9G6yV/0J7eKyXlkcBQDLo5enaupD9urBXZgfxVbLNe8T5csBWPAhqlWpEROpP0W51029dRzsUrug2nGcZclEo5hDQryQCs9j6iq6lclmMnXI0gNS/YRK2X4HQSvOS3u4K8LI5i41aNSzLjn9G+kOL/7wXus1Q59/DETUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060111; c=relaxed/simple;
	bh=/VcNNtJJw0P8ycOBIOS5hkIVFjnZ5JtuXWiPTpXW6DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxVCP6tCB4fS4P95IC7xvL1mTjIH6vqeQlTtPZYLcjwSuf9OYvokhvblPA7sK+4qGC5UVvusTPlyZFKfJtA4e75k4Ejio1Uf+bHMkq7u+WI6tk2kzYQuzDJ+KCy3Mc1VvtEwyb8/KU6O1R94UDJfAmA4f++6OSsUtg/csJZH6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLhg6LK5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723060108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAGFj0FHVAq5pVRnc576bB34mI1HflD3zt6t4lJRJgM=;
	b=QLhg6LK5r1mF0Hm0CnKTWQZqP7VuKLmJuAxCfWWZhhYwtoWp+/8vBR4b9pz25qOLNPZqlQ
	7d/+rPgXEzfdiVnpNGKndgklUl48UmzMeIeq3G7gCp0N5VJcfIrvMXH31uOQguPAQVtwGV
	Kpqx9/+nvM1rAWo/8Fn+UsbbqHG9/Bs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-HJcXAUJCPvu-dyWVt5bIwA-1; Wed, 07 Aug 2024 15:48:27 -0400
X-MC-Unique: HJcXAUJCPvu-dyWVt5bIwA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5d5cc01aee6so12873eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060106; x=1723664906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAGFj0FHVAq5pVRnc576bB34mI1HflD3zt6t4lJRJgM=;
        b=DTyiGO4ToXZVdNVUYtIok9rAjFGriGPISE+OV0JoRhgbF2Zs7b7LPzyxbi5dI7stK8
         efRsx3h7TgJoKnSVE+KpOXYMQel7ZyWrMzNZjm5Kj9HbON8V4NXHqmkWxB29o/IawV1i
         7g4lrqMa1udbCRLVfyhSpfF2NC9l27KnFuclMN44d2U6NioV5bLiT/BzA58cznD6kGyV
         nyTv1yv5oIkJvhm77ZjXQQSdZ+2Q5SkTHKEflHi7rL1ilcmL2pARwmzlYL4j5srCtQZH
         8K5c2cap4KfFKIdgu9CUIbhCpQ9250UZlGjm9Yx8dEdK868fm/5Z3BoH53OzPQMUautM
         FflA==
X-Gm-Message-State: AOJu0YxgPenEVYD8uAlTjtEOLwnKlVS1KBrJjlwm0n3y4wIwgNNmdbO4
	o3Aqgy4slIhW00UIfsTT2Aj+NDrA0YC9hz8polWKKO4dso1P2Tsuj+tRudYJpqvp1RAT7sdiBYw
	islaxGm+WdmQhHmF/3Fl1gjjUxcyh8c6wWIcFGL5wBaq3EyGBxjZb015RUQZuzRnz+C+jNvWotf
	y7vNl3dI658eIc7SDQTGO39nxygwlH5wIa/obSqQqWaUc=
X-Received: by 2002:a4a:b90c:0:b0:5cd:920:de44 with SMTP id 006d021491bc7-5d6636caa6bmr12611344eaf.2.1723060106166;
        Wed, 07 Aug 2024 12:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE55jmIe/WZbCw3l3NTgyyno7WLqIqKlQdXAtW30hkxt69+d9woKPh92QMpZkY/maA+61+r6A==
X-Received: by 2002:a4a:b90c:0:b0:5cd:920:de44 with SMTP id 006d021491bc7-5d6636caa6bmr12611307eaf.2.1723060105619;
        Wed, 07 Aug 2024 12:48:25 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ae4asm59853256d6.33.2024.08.07.12.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:48:24 -0700 (PDT)
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
Subject: [PATCH v4 5/7] mm/x86: arch_check_zapped_pud()
Date: Wed,  7 Aug 2024 15:48:09 -0400
Message-ID: <20240807194812.819412-6-peterx@redhat.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 10 ++++++++++
 arch/x86/mm/pgtable.c          |  7 +++++++
 include/linux/pgtable.h        |  7 +++++++
 mm/huge_memory.c               |  4 +++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a2a3bd4c1bda..fdb8ac9e7030 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -174,6 +174,13 @@ static inline int pud_young(pud_t pud)
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
@@ -1667,6 +1674,9 @@ void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte);
 #define arch_check_zapped_pmd arch_check_zapped_pmd
 void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd);
 
+#define arch_check_zapped_pud arch_check_zapped_pud
+void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud);
+
 #ifdef CONFIG_XEN_PV
 #define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
 static inline bool arch_has_hw_nonleaf_pmd_young(void)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f5931499c2d6..d4b3ccf90236 100644
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
index 0024266dea0a..81c5da0708ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2293,12 +2293,14 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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


