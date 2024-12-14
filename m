Return-Path: <linux-kernel+bounces-445944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C1C9F1DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AF2188BD94
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75155188CCA;
	Sat, 14 Dec 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S+xwpjio"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51029186E58
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167101; cv=none; b=Ja6dqM7t+G6QjTSftN9fiFnNnp6s/zneDxVslkZrvLEgM7a4+f0pS1QK/up5bAG38wp6nsLnHw+XVJMQL+sVkBRSVLC0BQ/SabfVU5EyyKIkIVkbwdbAx4Hd7k2c9rtBWMagzgr9cX9OZp4nDd+O33M46jRBAWoRRoCfDQqTPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167101; c=relaxed/simple;
	bh=O1rd8xPAKupYKIoOHV8CV0w14aUMzX9ObgWsGmQJ/DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APMBfI/5/42XbHaFd1luhjIkNK5k8CryiI7QyBuUp8CCwFS2LPI7xQz0mCiVQ0rJgpUeB2K1d2UQXoXERyNDUUpFZT4gye+GQneF+B8c4EluPngCLK/FTwlUaBtOVao5ZFx7Rw/a50WSUyXLfghz7lfZsgJygIvuDi+rYM1Xp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S+xwpjio; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728f1525565so2996047b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167099; x=1734771899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMCudVMtlfI7I8C+EWzj20f+Ae2SGvA6pNu/2M7K/mw=;
        b=S+xwpjioxrmHWHedggmEIVICmQXCppfg4Q+La7y8+mQstfKeKxAj+FmzMDDXusjr0t
         0IjfTXH/EoFNz20+g05D6IE+agUg6TRc+Y9dCyQNT3lquDHTi8jAhK2fQUMdQIzwEQ4+
         Ho6BNaqV5W6JR2Oxq45uMvZDe3WmD3UXM4Y6dsDh0EBoVWYvG7M/yE0Uq3Kgu3P5ElaB
         7hULBtqHiGNoHZC9Fvf+xJ3j699LSxph9ze9AffGN5R3g3aYrE8U5RITSWN4IHxHTh5i
         UllQ91I3kyrqcrtGXnMHbtWwth97FHMeFSzI+hNoj3VCqThq0TH6SzhA7dCoQQruu8oJ
         e6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167099; x=1734771899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMCudVMtlfI7I8C+EWzj20f+Ae2SGvA6pNu/2M7K/mw=;
        b=KT0PC9UkjnNgv7XFo7tLlR+rxAGTQEK8iVD/v8lKpBZ99E1WzAPhTm2INmQvXtyM+w
         vQBARVv1d6y8lihkHTe7470nYO+UjdtMIMvLpOrlca/DTw1c3T3Zc7kd26ylrCuXA75L
         6YmGVSRoRSUQ7piTldpDISUJp6RsUkGzR0SshR0bF2SpZIXUxMuFbNSNwSJBVxRFrTxv
         P+NLVfGoIuFu2kUL4HGjnWO+6QkXVyS07ohZem7YKlrRlsEsRSJJsYe1FZDt4Z+0DP9L
         IvdYLaCFjFZ7fuphbCJ7HIdjJKvvxa8y9nFVFu9I5J3C71V6TBgdNy7r73eKfFwUeQ2X
         aDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7S71r444mqJJjYz1NdFW3ZNQrB9ydzZtMqw6kIUd01QXNrVoO2v2D40go4JeuJhbcDZua6R9vHkoe/eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLkPcbND8vo2htrsiP8NFN9cKHJm1dIfle+3aaK2Vb0udkMAF
	oOTTfjYbhdjqD3UVSorj9jz5tGl2wKGQ4s/H8iO6IrNJ7imtHSWgD8/MmM4zfz8=
X-Gm-Gg: ASbGncv3lMucHGlnVapRy62PilhUB/605Pyfj+/HHzxIYO+Bt2lbhG/HDmbuQSZCsZR
	g6Ow368dmZzkdGa8V6xJ5+IhXe2mwfgtqytcnvOz3oiOBMddx779OjR1vveCfpthgo2TgI1FTOI
	jZAN1/NIp4sro7eA1kpa9dqxJwI3Eu+Rfv+D9CMUOUVYYXINak1abv8Y5+5zg3Iv/6pHdhsuO0c
	a9EJblGu6E2wAQx8+konStLzpj+T9gC1ncsoXyfHp9kuGz7wK/2E6jYg4J8sVPe4bYpwSiW9Boi
	yWLSTCGwoGRMuQ294rEnY5TJwLmNQg==
X-Google-Smtp-Source: AGHT+IHNImhO/lIwU1CxZtuKJT3uG8XCXYTC5vUDdEevSxX9VuCSFNAuRKGmdb9G/Urv3IN3FNQNtw==
X-Received: by 2002:a05:6a20:d808:b0:1e1:c0d7:7502 with SMTP id adf61e73a8af0-1e1dfe1d265mr6847659637.37.1734167099625;
        Sat, 14 Dec 2024 01:04:59 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:04:59 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	x86@kernel.org
Subject: [PATCH 09/12] x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Sat, 14 Dec 2024 17:02:55 +0800
Message-Id: <01a0ce994f5d475230117b2991566cd7e2ff1dcf.1734164094.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734164094.git.zhengqi.arch@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/tlb.h | 17 ++++++++++-------
 arch/x86/kernel/paravirt.c |  1 +
 arch/x86/mm/pgtable.c      | 12 ++----------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 73f0786181cc9..f64730be5ad67 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -31,24 +31,27 @@ static inline void tlb_flush(struct mmu_gather *tlb)
  */
 static inline void __tlb_remove_table(void *table)
 {
-	free_page_and_swap_cache(table);
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #ifdef CONFIG_PT_RECLAIM
 static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = container_of(head, struct page, rcu_head);
-	put_page(page);
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	__tlb_remove_table(ptdesc);
 }
 
 static inline void __tlb_remove_table_one(void *table)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = table;
-	call_rcu(&page->rcu_head, __tlb_remove_table_one_rcu);
+	ptdesc = table;
+	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
 }
 #define __tlb_remove_table_one __tlb_remove_table_one
 #endif /* CONFIG_PT_RECLAIM */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7bdcf152778c0..46d5d325483b0 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -62,6 +62,7 @@ void __init native_pv_lock_init(void)
 #ifndef CONFIG_PT_RECLAIM
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
+	pagetable_dtor(table);
 	tlb_remove_page(tlb, table);
 }
 #else
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a6cd9660e29ec..a0b0e501ba663 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -23,6 +23,7 @@ EXPORT_SYMBOL(physical_mask);
 static inline
 void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
+	pagetable_dtor(table);
 	tlb_remove_page(tlb, table);
 }
 #else
@@ -60,7 +61,6 @@ early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
-	pagetable_dtor(page_ptdesc(pte));
 	paravirt_release_pte(page_to_pfn(pte));
 	paravirt_tlb_remove_table(tlb, pte);
 }
@@ -68,7 +68,6 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 #if CONFIG_PGTABLE_LEVELS > 2
 void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 	paravirt_release_pmd(__pa(pmd) >> PAGE_SHIFT);
 	/*
 	 * NOTE! For PAE, any changes to the top page-directory-pointer-table
@@ -77,16 +76,12 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	pagetable_dtor(ptdesc);
-	paravirt_tlb_remove_table(tlb, ptdesc_page(ptdesc));
+	paravirt_tlb_remove_table(tlb, virt_to_page(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-	pagetable_dtor(ptdesc);
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
 }
@@ -94,9 +89,6 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-	pagetable_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
-- 
2.20.1


