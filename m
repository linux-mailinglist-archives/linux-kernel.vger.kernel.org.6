Return-Path: <linux-kernel+bounces-274687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C80947B74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF952815F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07D15EFB9;
	Mon,  5 Aug 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HHkE/2IZ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29E15ECF3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862572; cv=none; b=hu2rFxYWyrDbYMVIL4otAD3BNJNZFB09j6nd1T1tvbDf8irMEeOFnsdUlWf1g/edYkTb8LFQwHzcGtKNExqC8MRwa0CPSCqamRnq5bBQDdMylU1nPMS1y4mhVUs2SFroyOm2kgerWD4c2n2nx8ZN7fa+pu9T8iYjE9O/sv/o4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862572; c=relaxed/simple;
	bh=ZiCKPKvBLRcnxeUC/BZby0xYxdKkfsXHSVFooIO/IEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHw66vAfMMkCO+fPziPtbUlciSYqItj5R04a/qRYEYH59jjPqLX3MiCfN6TfJzjZN4lC4S8mHW+bxjO/apQu5QMO+imW6V9BXqJjHKr/WYAAZ6Qhm2lbbEHokeqXc3Z6rU2664zrtECnAF/pUUW7EnH699qafYtAOGe0KLUg8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HHkE/2IZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc5bc8d23cso6126155ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722862570; x=1723467370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvOCNxNaR9g68beFCkVQN7ot2Umf+8WTdO0qJ5nAYzo=;
        b=HHkE/2IZW0HHyo0pa9EBd5KptQ6QR5Ny2cyOsom7f8MGQcgaEQJoObsVZCy5ReO0Wh
         fQw6njQE3YRCHMNlN3q5YlZhkfcwZ8SgxGkA4N1FpSVf4XyBsd0G2lXoOMLglJT5sgFT
         yvC6iiUbLR7bKLp8dh24RFyjgNYNNg3ubrGtaB7FGYm/qgyLrqE9Hnnv6GmNj/+J4xe/
         zjeEAiAhl+3egQRhjALqhC3oPd9VIZzUXf9BGCLAoqg0taDA6eSxeAX74zi7QaCZh1uM
         5KPSBRFZrqBzLVkGoKprKIwfSj+GuxR4LwkURLQJCqF0EWZv4AIQLjmF79+82fm+PCel
         XpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862570; x=1723467370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvOCNxNaR9g68beFCkVQN7ot2Umf+8WTdO0qJ5nAYzo=;
        b=mZmDm/4T78T6cQ6Z1N5FCCPrBq88JPZAVgWVRQXkaj0wpIAzNTf7pJJl9DD7a9Zcy9
         JUN1WwaU7NfeisDRm+JmiNWMJOyEXrEeHsCfoTky0AlspgwEb8yDqxot3oKWEPHdun/G
         4tKeB27FrvOaprWZPkmdr4tAcAVa4ZIUDAyVYUWIGY0kbSh1u4u1gKR+IVPH800X9pQO
         gZ2q6uP2WpWGqR6zPKhJpfSJnM3r/Kj7pcAtvK08k/8M/UFBRn+WamWbekUa2ZQB1Nql
         bFexNEu/7oeqXw/GNiwMMNdiJEKG2TXaGxsDxXm0RoS0qeX38AtQWwf1jec+2Ep3Ce2X
         1Bow==
X-Forwarded-Encrypted: i=1; AJvYcCVynNYWlgL5to14M9y5BOmhb9fnZu+DGBjtqfT8zt7oThTkbF/lZPVK2dUCuCnCzIl7m6sS61/ryMDAXNArdqqcWwnT17jer/RZj+gJ
X-Gm-Message-State: AOJu0YwgmvBvlktxNq5hmUwKF8Ye6HLWmj7WGZVK+mpXLnxKNT+frhoA
	lkc5H5kKtJuzpD/CB27PW4H/MUXoUF1F9UnADg6h3TntrfXXCgiPDpNAn5bV4tI=
X-Google-Smtp-Source: AGHT+IGEkzD+QFj3cmoP4z9fngv/zsFb+TuS1tTAyot/td9F6PCtAysO8/m5eTxJBHfpd8BN64UXhw==
X-Received: by 2002:a05:6a21:6da8:b0:1c4:c007:51b7 with SMTP id adf61e73a8af0-1c69965d0bfmr10731013637.6.1722862570294;
        Mon, 05 Aug 2024 05:56:10 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm5503030b3a.142.2024.08.05.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:56:10 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH v2 5/7] x86: mm: free page table pages by RCU instead of semi RCU
Date: Mon,  5 Aug 2024 20:55:09 +0800
Message-Id: <9a3deedc55947030db20a5ef8aca7b2741df2d9d.1722861064.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1722861064.git.zhengqi.arch@bytedance.com>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
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

 - For pmd_huge_pte, we will do zap_deposited_table() before freeing the
   PMD page, so it is also safe.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/include/asm/tlb.h | 19 +++++++++++++++++++
 arch/x86/kernel/paravirt.c |  7 +++++++
 arch/x86/mm/pgtable.c      | 10 +++++++++-
 mm/mmu_gather.c            |  9 ++++++++-
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 580636cdc257b..e223b53a8b190 100644
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
+	free_page_and_swap_cache(page);
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
index 5358d43886adc..199b9a3813b4a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,10 +60,17 @@ void __init native_pv_lock_init(void)
 		static_branch_disable(&virt_spin_lock_key);
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
index f5931499c2d6b..ea8522289c93d 100644
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
 
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 99b3e9408aa0f..d948479ca09e6 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -311,10 +311,17 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
+#ifndef __tlb_remove_table_one
+static inline void __tlb_remove_table_one(void *table)
+{
+	__tlb_remove_table(table);
+}
+#endif
+
 static void tlb_remove_table_one(void *table)
 {
 	tlb_remove_table_sync_one();
-	__tlb_remove_table(table);
+	__tlb_remove_table_one(table);
 }
 
 static void tlb_table_flush(struct mmu_gather *tlb)
-- 
2.20.1


