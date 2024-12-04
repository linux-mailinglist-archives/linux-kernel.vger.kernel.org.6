Return-Path: <linux-kernel+bounces-431056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63B9E387F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE45E1620B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C91B412B;
	Wed,  4 Dec 2024 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AGPQKYTx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94C1B6D1B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310698; cv=none; b=dAVp4g3CoweUmWA/7o8XGEPdRvoLj6qdXtcC1pDyY5Qhr9U3Ecjn4vt5ZPXE7vuBV5SWI2WzPsf9U+lNaZLiTe9FVvQ7SiLQnCLumM1yNkU4JzOu257TaowYClNuhWXpWYmg/J6zdrq7CFCkZ5WSJqLnJ8Kt7k5bUbDi02ELks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310698; c=relaxed/simple;
	bh=oK8sfhBv2wUjIXRu41nFpkp8JSCrB8y/UDm/DnICKz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CvQJsyEHLLERpP02V+fuoksd4dqOrNb99bB4MWPJfuizAFgQjG7h64AoB88Dl/hDK9nkcLtsUM3kzLmiv7dYEi3L/XvgVPw0GLZZifjiRA4SL+I+V5cDYGGwQTxeBg96ZrGpKrjJRUcb7osWRelCcqV2grVWjEPfL2nTCVd6Qp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AGPQKYTx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7252f48acf2so4831834b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310696; x=1733915496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fSWWcfeV8hzoFpFk7VaZVUYbnww7eiSUjs7tN8xr0c=;
        b=AGPQKYTxG/ikFMWQsHRFj9v/dwJEG4iBNJ/87yOsa1uYCUZhP9CLMhpp/WJZYQxZ93
         FhA1Qsh84J4xFtXnSU0GuyK8ddWGoat/H2rl1FEfuQzAyPKjcsVvVsfnMec4Ii9Ov1bg
         dOlD9Mse22AyuNDKRSe0QfpFBMBWFb6T3GEU0/sUMtSBieKo7bydseJgJi0RoaDQCUiO
         6MEVi06jUAt350p7daxGPgY9mfcIftIEpc2YxGSoJAZpM6QZ2mPkmMbOz2ZZUxfk4+5G
         H73ZgUlSGtjbthkOD1RtarHyNfolepRNW1CyG4CtAgCgptX3HjYqRWkeyNs+4aHu+aky
         0JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310696; x=1733915496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fSWWcfeV8hzoFpFk7VaZVUYbnww7eiSUjs7tN8xr0c=;
        b=pWabUzY50mwfpPSU4br3XykWOpHxIeoYfqYSH1pSWPT6zbQM6QmOjBH3FVG5zRamQ8
         GfrXmX8WLV4jvg2us5u8X3fTKNPLF6j/sqppYg/eDJN0kdnZ02y88ikmnX/BOD12rTKg
         3ymWIfzyxwgrnCEE3hCw5MpiyjBsRt39yNRMDb2GOATkBNdL2u2sPsiYLe0LsDxFd0zj
         G2cDlVX2re5uTioL1LN/eKU+UfZjR0bKk6sdKIHkpOam8A3qM6NELQ80D3ZNecQ8Hy9s
         0h3XYJS99jgkNLu84c8N5g5+0I8SlXvhy/oWHuNhi22yzSspnSU8E3Szlpe/WBwfJK9Q
         ML+A==
X-Forwarded-Encrypted: i=1; AJvYcCVx+5eQW8DRRKXf6FNOwkGx8nmvFbreEnjRacARwwAnFFX4IMWL2rxFcoX+NXfVR49WCnUM9n0NxjjKdo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxViXOtE8w0jhJZBaun2dxyrw9XVSI2ak4JjE7QaAtImOI9DexW
	ifh3/SToNcrsXQGZ5KWEFmJNLksNGaOatIabcOhpu6KmbUU3E1ls07D3p6nzBBU=
X-Gm-Gg: ASbGncsmsoKKPft6igjns7KtwVLyUfUJwrr1zulwuTy1N8CsqazjeBRPWEwhBTl4QCh
	SXDSKMCWNtaWVWYWVfkTrSpEJeWCqN3ouOMa3B0ShOcguCgSYogf/xhZWfCcrq4ARHPl28yTkwH
	oPAplZuHX9gcRV7WUR9bSMv35PAPvxxiQOqr8P3ZUdMaRaqGit5jWefnUGbYpWNPRElYLgn+dAe
	7E1MitQcN1Jvjb4xQjRK4OamLzEQPLHNdcxvC95n0EuptpP+tT8J9BWzE15GUtDYduJVdeO8Gxj
	VH91KGtB9MKkSzw=
X-Google-Smtp-Source: AGHT+IFovq7hDlm4wLdDhm1VdKh1zZ19bET/1mJY6NLSrbW7cKbNUzk3vayQjzm+UlBEnc1Q8UAnEw==
X-Received: by 2002:a17:902:ea10:b0:215:a190:ba28 with SMTP id d9443c01a7336-215d0041378mr59888075ad.22.1733310695765;
        Wed, 04 Dec 2024 03:11:35 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:11:35 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 10/11] x86: mm: free page table pages by RCU instead of semi RCU
Date: Wed,  4 Dec 2024 19:09:50 +0800
Message-Id: <0287d442a973150b0e1019cc406e6322d148277a.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, the page table pages
will be freed by semi RCU, that is:

 - batch table freeing: asynchronous free by RCU
 - single table freeing: IPI + synchronous free

In this way, the page table can be lockless traversed by disabling IRQ in
paths such as fast GUP. But this is not enough to free the empty PTE page
table pages in paths other that munmap and exit_mmap path, because IPI
cannot be synchronized with rcu_read_lock() in pte_offset_map{_lock}().

In preparation for supporting empty PTE page table pages reclaimation,
let single table also be freed by RCU like batch table freeing. Then we
can also use pte_offset_map() etc to prevent PTE page from being freed.

Like pte_free_defer(), we can also safely use ptdesc->pt_rcu_head to free
the page table pages:

 - The pt_rcu_head is unioned with pt_list and pmd_huge_pte.

 - For pt_list, it is used to manage the PGD page in x86. Fortunately
   tlb_remove_table() will not be used for free PGD pages, so it is safe
   to use pt_rcu_head.

 - For pmd_huge_pte, it is used for THPs, so it is safe.

After applying this patch, if CONFIG_PT_RECLAIM is enabled, the function
call of free_pte() is as follows:

free_pte
  pte_free_tlb
    __pte_free_tlb
      ___pte_free_tlb
        paravirt_tlb_remove_table
          tlb_remove_table [!CONFIG_PARAVIRT, Xen PV, Hyper-V, KVM]
            [no-free-memory slowpath:]
              tlb_table_invalidate
              tlb_remove_table_one
                __tlb_remove_table_one [frees via RCU]
            [fastpath:]
              tlb_table_flush
                tlb_remove_table_free [frees via RCU]
          native_tlb_remove_table [CONFIG_PARAVIRT on native]
            tlb_remove_table [see above]

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/tlb.h | 20 ++++++++++++++++++++
 arch/x86/kernel/paravirt.c |  7 +++++++
 arch/x86/mm/pgtable.c      | 10 +++++++++-
 include/linux/mm_types.h   |  4 +++-
 mm/mmu_gather.c            |  9 ++++++++-
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 4d3c9d00d6b6b..73f0786181cc9 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -34,8 +34,28 @@ static inline void __tlb_remove_table(void *table)
 	free_page_and_swap_cache(table);
 }
 
+#ifdef CONFIG_PT_RECLAIM
+static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	put_page(page);
+}
+
+static inline void __tlb_remove_table_one(void *table)
+{
+	struct page *page;
+
+	page = table;
+	call_rcu(&page->rcu_head, __tlb_remove_table_one_rcu);
+}
+#define __tlb_remove_table_one __tlb_remove_table_one
+#endif /* CONFIG_PT_RECLAIM */
+
 static inline void invlpg(unsigned long addr)
 {
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 }
+
 #endif /* _ASM_X86_TLB_H */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index fec3815335558..89688921ea62e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -59,10 +59,17 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
+#ifndef CONFIG_PT_RECLAIM
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
 	tlb_remove_page(tlb, table);
 }
+#else
+static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	tlb_remove_table(tlb, table);
+}
+#endif
 
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 5745a354a241c..69a357b15974a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -19,12 +19,20 @@ EXPORT_SYMBOL(physical_mask);
 #endif
 
 #ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PT_RECLAIM
 static inline
 void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
 	tlb_remove_page(tlb, table);
 }
-#endif
+#else
+static inline
+void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	tlb_remove_table(tlb, table);
+}
+#endif /* !CONFIG_PT_RECLAIM */
+#endif /* !CONFIG_PARAVIRT */
 
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3a35546bac944..706b3c926a089 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -438,7 +438,9 @@ FOLIO_MATCH(compound_head, _head_2a);
  * struct ptdesc -    Memory descriptor for page tables.
  * @__page_flags:     Same as page flags. Powerpc only.
  * @pt_rcu_head:      For freeing page table pages.
- * @pt_list:          List of used page tables. Used for s390 and x86.
+ * @pt_list:          List of used page tables. Used for s390 gmap shadow pages
+ *                    (which are not linked into the user page tables) and x86
+ *                    pgds.
  * @_pt_pad_1:        Padding that aliases with page's compound head.
  * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
  * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 99b3e9408aa0f..1e21022bcf339 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -311,11 +311,18 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-static void tlb_remove_table_one(void *table)
+#ifndef __tlb_remove_table_one
+static inline void __tlb_remove_table_one(void *table)
 {
 	tlb_remove_table_sync_one();
 	__tlb_remove_table(table);
 }
+#endif
+
+static void tlb_remove_table_one(void *table)
+{
+	__tlb_remove_table_one(table);
+}
 
 static void tlb_table_flush(struct mmu_gather *tlb)
 {
-- 
2.20.1


