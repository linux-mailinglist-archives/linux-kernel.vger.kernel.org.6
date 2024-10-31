Return-Path: <linux-kernel+bounces-390152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041FD9B7629
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88AB2856F5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4A192B83;
	Thu, 31 Oct 2024 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OMnmcYlw"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EB1922D6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362487; cv=none; b=cy/roPppWzD13T9t+livjkofaHznrprG1Wjoy59kwZn8ku3vbGafRBFfElm423U8HXHUI44Q9Er5+zIAAjSvUi55BdaYvQM3dChpogiDvSEt4wTIj1WZ6qIYvPMMQnivg+I8mgR5Se2md3e8VuIJd/EcTPl5+v8cInQhzEQfVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362487; c=relaxed/simple;
	bh=5pV2lLBjHA1VmB/XAuJiCUqSMDB+4PzLY1ZtruvLm/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZrkCm0D/qWanZ9QfuoQc4LtQyiAR269NJqpf8xkaP3RNiObFHtHU6/ugPOCgctUbvxn8FyXFhZX7l763I+5X1wvOGFj6ZdfdHuv7Jq414HuO2lrnlltQmutx+KDGB3ToWouA0avEIzeZmlTqenkmqmX8yoAtVssna58sUHHHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OMnmcYlw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c77459558so6115345ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730362484; x=1730967284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96N82BICgFqmbQqgF/vu6V3zKuLzfmtjKmdmS7DODoY=;
        b=OMnmcYlwXwdAuy6RGPxS9xUVmNM6wwW7jh9NpKxNxIQmIsxvXicwm8U7KW7PR444E7
         u0qYaghLJENesbJg8n866tPeCN4SHUzyfpANRnDHk3POYPPj6mRFs4AoZYcN6FfAMyeT
         i035a71/J6ywg10FuOlKlD9Wu8fUv08ZKeRKgHfrbZgjpMcMGObb5hu58MHpJw1ZH1Q0
         5zrOIFPie/89jXjHXv9ASrsVRgK70nWV6uLql42bWpvWxSzkGw2I1DN2zap4EvFhMwQT
         AI1FA/OplnVqc0jPoLZNSSlpbYaif2oF8k2lJ+Rb0E9DpvS+fJcKQy1zNj55JYZX8eRH
         x+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362484; x=1730967284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96N82BICgFqmbQqgF/vu6V3zKuLzfmtjKmdmS7DODoY=;
        b=nd6aQKtGIpmaM6QgGIX6fN325oEDXZPfDe2OR0O9tzlLWSs0ybHcb0BVZMvovPKpiE
         X5g5+qjZZrogt2GQhn2PjYxzwPPoVuYMTk2wUzpz7Tag9J21s+1rr4AviaP9ETqYkUyW
         nVYcgxCvmP27In6RSeJw5qXRQrgqOmpezWE5IGNBe705HXqEjYq7pEPacuKCZzXl2fma
         H5wOjrL8aiWckgdlwZLr26oITNtVL4HHdO8mz0/rEtUiWnvt2s7BkCVoDDI0sJE2NYcs
         IeNu/9sXdAcg7jE1B232DsxmK2B2mdBAakr3Vd1NOgAD9qhqOqHknX6NzahC2qid+ddw
         M95w==
X-Forwarded-Encrypted: i=1; AJvYcCUxECBx3P3A21pp02ph/628gsMHa3CWdC/8OcAhADeBBQC6MFzAOOcDlsMRQ2AptnCLVS/+OBvn9OsbaPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3BwKLcOGbQ+z6TQKTmpaygOnM/6ZHSRjEyZkE4jbbDr3Bnlyr
	DoAQvULFXq7I5MYD0lW0CS70dKmqgSWgraTZwd4cwzZUhH5mn1ccJFiYwxLURBQ=
X-Google-Smtp-Source: AGHT+IHc3twInabx1E+TNdhn783JHqCF2GYMwoTNrA61R6GZcT2sSHxVlBm8Eg/JbQvoGhNtrFU0aA==
X-Received: by 2002:a17:90b:3b4b:b0:2d8:8509:85cd with SMTP id 98e67ed59e1d1-2e92cf687efmr5271210a91.40.1730362484634;
        Thu, 31 Oct 2024 01:14:44 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9201b2586sm5163996a91.0.2024.10.31.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:14:44 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	peterx@redhat.com,
	catalin.marinas@arm.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 6/7] x86: mm: free page table pages by RCU instead of semi RCU
Date: Thu, 31 Oct 2024 16:13:22 +0800
Message-Id: <c45cf245592ad4ccc86429f71500d3fc378ac4a4.1730360798.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1730360798.git.zhengqi.arch@bytedance.com>
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
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


