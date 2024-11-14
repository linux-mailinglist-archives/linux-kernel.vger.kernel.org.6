Return-Path: <linux-kernel+bounces-408794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450F9C8397
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14106283450
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EDB1F4FD5;
	Thu, 14 Nov 2024 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UNIHQwMY"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD01F6681
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567692; cv=none; b=MdRPFyZcQKzAEQHgqNAkvRu4V6Z6T1bBE5V81sDzMivhauvmTtTIz2hbc/s7C9/fhxsN4uGF1LWN/MyNlvUvv7fcs+XAjH94fpo8sn+ClmgePgBCa/9iMC6bFdx1Qy6DZ3YWsq/oMkj4MN3keUutN6A4R505yx/nMyFh51xSKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567692; c=relaxed/simple;
	bh=20qtQZ/mJDfwp0RQIdzo2NcEVODmaojrZtA17kfYSDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dem1wDDdo6EUV8sUS2Ca8sVWTpfmoFt7UFLS2xZQ+joesxFvbFC2viqjSBgAs/HONIus45x0TNcdl7ucRIUph2jw+Tz+KZkncHLo4VSm2YBWV49sVz0Z0BPGlH5Uzhqb05ADjy+TrTJSp2qvxp2WEqhuSERd24R6PegfcLTQcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UNIHQwMY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c803787abso2012595ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567690; x=1732172490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIspmjr7fEoQ+01q6Xqvp9udSZQrZ5Y5COB53v8W124=;
        b=UNIHQwMY72wMd5M7iz4AyD7VC3S5JBNoKS1LSHLiP9f/BHdGrixdjdrzqJM1rrsE61
         3xw5g/w9Ccc6RA0I5SMedDfcavUTdbJbWOOC9ZD4XMHaNstUq6gPbz4YuGV8RbWP5YbV
         9esr8A/Cq4vfs0j12CUI2nOSwM+7AYi19c8xX7DSF46I2l3H3HOVQjwa4JZ4SvmfFA0a
         NOsGqbri31NA7yecFrTuEwDPqoUlRSnXp6vTQT8O2RtUHXCOw85EpTob9fPwHEEaDUZ/
         3gGVvQ6N/jqTvu2356tqRJfhxxvF/AdJLIwmEzVBKbPS8Im0BMdtaZbIM8tDFNpWKS0U
         6dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567690; x=1732172490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIspmjr7fEoQ+01q6Xqvp9udSZQrZ5Y5COB53v8W124=;
        b=WKzLzBjBURk5j7NeDuWgJtnux9rJRccJUV2SV9uZvNAZmUsuN0E/EZdeZhheKim2GC
         slk0NykYfCscE0kbv1XinngwD8kUvFNIZcV6r6F021bKluj2f8b+MPDaRC+lq5yyncWh
         Ctol4MhZdfS9rTvKHepArfqqg4zkNyDVwqEwvNLKWjoLOdiKsgsYB1GOZNOpXCH/+tPd
         2dxteGPTGtFVTpJULJVKIO4TRL7pjPXWQjgFCS92T1oUz3TeK5qNO1pKGjy39ZM9odEV
         N3WvSnnlVvJDubqkXgmB76J8ajnNQYBUbTLn/PHJUIRAojyJnXHaXrARUSM9xC8yw2wD
         doUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFD9/OEIAaVyXzUTTXJIU8hJBspqDNUSTMOmJt7kWGBq+dv2415niUfF9ILm7+HD9QMXOdnfrjcHoLHaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznX6kpi9To2FgCtxTYghYsHu3hbzeSAjzyelqxu4wTAZgmNm9a
	C8UirUaQpk9pj4nobKDTjkxzqTIHM2IZOPYvAbontEGS/2wP9B+Sbdx570lmcrE=
X-Google-Smtp-Source: AGHT+IGZZsMk4C1Gc1YiyqnQ/Vm69/2CldCbtvO7gKrKwJI6uPz/y6t4qr23UntpDUqpfJ9OLSSGjA==
X-Received: by 2002:a17:902:cf11:b0:211:2fb2:6a6 with SMTP id d9443c01a7336-211c0fa7399mr34336085ad.24.1731567689701;
        Wed, 13 Nov 2024 23:01:29 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:01:28 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	peterx@redhat.com
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zokeefe@google.com,
	rientjes@google.com,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 8/9] x86: mm: free page table pages by RCU instead of semi RCU
Date: Thu, 14 Nov 2024 14:59:59 +0800
Message-Id: <d7bb84a0ae61c6c1fbcef395d9110529feca9b41.1731566457.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1731566457.git.zhengqi.arch@bytedance.com>
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
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
 arch/x86/include/asm/tlb.h | 19 +++++++++++++++++++
 arch/x86/kernel/paravirt.c |  7 +++++++
 arch/x86/mm/pgtable.c      | 10 +++++++++-
 include/linux/mm_types.h   |  4 +++-
 mm/mmu_gather.c            |  9 ++++++++-
 5 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 580636cdc257b..d134ecf1ada06 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -34,4 +34,23 @@ static inline void __tlb_remove_table(void *table)
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
index 97e2f4fe1d6c4..266f53b2bb497 100644
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


