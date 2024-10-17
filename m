Return-Path: <linux-kernel+bounces-369562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A69A1EED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63361C21420
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBED1DA61E;
	Thu, 17 Oct 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BeAN8gOE"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323051DCB2B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158511; cv=none; b=EZD8ZZHzffOWNSUfX0gTOpVUhEGHk/1C1723rQOVEqkBO3UbHtfHCX+phqy/pOYSrzWbAyt55lotVbIMbxFrkV9zpks5MiRRPUGNebEIn0Z1YzF+/MVtZ7qVhKBQ3OzmWQhjfwFXjfeTQWukOiZp3nJfEiGPTrG6ASFZCMQGkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158511; c=relaxed/simple;
	bh=5pV2lLBjHA1VmB/XAuJiCUqSMDB+4PzLY1ZtruvLm/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfN++otg66dpX4YXMbVdPLdoxqfZZYlhy3I10dNTUSzCVNikfmDrX6rqqk6w/fziJI0BrLCCBiGnFxgZca8NAo6iFKjb0x0hkrWoYV6rP6OoETmxuS4modhhHmLrO3m8cdCr2nJz+nCuRj+mO+2paGvaANqXpWJDOr5wbNpBYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BeAN8gOE; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so762839a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729158505; x=1729763305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96N82BICgFqmbQqgF/vu6V3zKuLzfmtjKmdmS7DODoY=;
        b=BeAN8gOESq95JnECUlA1FEisW1jD2oOsG2K8OwJtfuwDK8KoSC2aGOiGNYkLeTrnyY
         HsgIKkA+UgD0EZR52IqNWDdnQtRsHEkYTuh0l/uAMsEydTQFGXM8EnzxO+v29Td6ifvs
         BS1qncvbQpWYSFjyYRUjkVFuE6W7/AGzIf8AZeMMifopJm9c2+WB6cZaA0FS4D/NJAMa
         FEJPiu8U9QIGFSIDAjNvgQOQwLZg2UMi+NLiw7f0whbDmBI+ZLs3eCsT09uTZmROF5lg
         zLUF2GE6kggLZoiCHRIBSA4uFx3uZDRuUwDwMJEtZJcQA2Jk71dMgI1XzcuI3Qb6bQ84
         47IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158505; x=1729763305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96N82BICgFqmbQqgF/vu6V3zKuLzfmtjKmdmS7DODoY=;
        b=l0zSEAQqR/S3vMaoDtoGc8Rnq6Ez488+a6r4UdtuTLAqOsbGoAmavTFi6ci9+QOTMD
         ql65Zp3I9HNHUpAZcWv5oeY9jj6AO8DZ4HXNWnR1fP789/9+SqBqxElyFcRMworVF0G9
         eoiNxo3Ds82h8QNO6ARuoxTcDZz3K6h2W5JX+aaygS3iL1BKBcrm16Az/qcSq9KK0mFS
         ivdxMg89ciQj4F48G6veWbnu1gkuoUBl+bgm7eLdks0DbEtL/lND/JVK84GnSlXCpDX1
         g3ObG1zqQZuHjwf16j77coKn1NF2AAWuQ27rOHtL6MDQxdGcHpsSxvdpKPXYh0EXRkmt
         mEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTdfjqEV7ra1PNCrNOaMZmBaAHn4aNznJZl490jKEeZcSULKGy4jug0ZNOZUxjJ+rPkmNJfCpgFGQ/mys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUjY+TAMxoc2N7qinOyNzVnGuEBFbJglyy1V0vf5BGiQEtFjjt
	QI6IVSps9Z72ZvY6zN8r+wRelFPzNvPQ8qdxUdFuwyXyqw4ZWhn4eg+tncotB7w=
X-Google-Smtp-Source: AGHT+IEf2y1GA9Rtz+/5nXvZXCaQlczdVC6XcSHY78uZicXgbVhL/Djw5qd37IxfTX2YDXEO2p/4DQ==
X-Received: by 2002:a05:6a21:388a:b0:1d6:97f2:71b4 with SMTP id adf61e73a8af0-1d8c9577df8mr26874708637.1.1729158505469;
        Thu, 17 Oct 2024 02:48:25 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4218sm4385365b3a.120.2024.10.17.02.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:48:24 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	jannh@google.com,
	peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 6/7] x86: mm: free page table pages by RCU instead of semi RCU
Date: Thu, 17 Oct 2024 17:47:25 +0800
Message-Id: <cc5033c6c1d0f309e7f72a69d802dbd0cad9bf52.1729157502.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1729157502.git.zhengqi.arch@bytedance.com>
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
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


