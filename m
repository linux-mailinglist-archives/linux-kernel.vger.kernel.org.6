Return-Path: <linux-kernel+bounces-445945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF89F1DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EE3188BF0A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4540618E362;
	Sat, 14 Dec 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EkJs1S40"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011A16F8F5
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167111; cv=none; b=GqNbqzW3dmJUPUDoPVDASccdESqu/y7DCJZE0WmsN5tEUJoQPewRp6mjbAs+185J1AmuDKZlstT6qIvVW42CDWL8qPikgB911eu5fpCNa9i68KAHIv5gWvdr+VJPdOX9/+Kk37PWAqS8VnhgkRzOd2w/4a4gZioqbtBzZ/nJTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167111; c=relaxed/simple;
	bh=dUn22uFUF/7Q2aX8/sTNpsqlDbyw/AbPrg+Ofum3Ioc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCSlbzE0O1c9o9T116b3UgyV+QU1E4hrhlXaxOZS/7up/0TDpcq/Ex7fXEHI5TowVSqlq8U+llEimBrKmZtiwDUr1rxoiTzlk3SVoZVUnn4yi/SM1iU6VMKyQz+SUrLOrpKF/L1Aeau9IafRUj1Kv4DlnGLGxvXktYQqfG2swdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EkJs1S40; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2117479b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167109; x=1734771909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMqrm4pkcrZJ7adK/0JGqqs1dXiKNR49XOWaF/ar7JI=;
        b=EkJs1S40b36UBcQ5tUf9/vhozXD4UmwBoav0utIjGg4O6vI87BIvXEcRBESTFU0jxA
         kinWKUyncOnTcS0i9Fbv0ON6LZZX9H33oWjAbCGrS1HkbiftT8zr+ReTpScQbaInnsm2
         dvBp553B55mShlO/mo39Tii4GpIsm9L5IYJT2RC1ZQ8SpkAfpLtJeJK1qvvf0+oXa6Ok
         T5sf1ovXb1U9w5v9psnSDheggAZUErRkndv/Bf8dg1aEDjfuwwLCl/Fq1vu+6SiXxogC
         F59pck4XW8mkJT9Y+MhBSTwlMxeCOmM6HK+O3ylpUZKdHyg16Hezfi5S7o7cmroCjbLA
         urTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167109; x=1734771909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMqrm4pkcrZJ7adK/0JGqqs1dXiKNR49XOWaF/ar7JI=;
        b=dybYusX6vEmkiR7WsD/YLgBLVBdxeSfSpFM2TAjtZW73i11COC1W+La8LCBABYnIcy
         TOtb06QrxnkvfBeWtirtowaVOAkJGTFmugg+LeRrDIRdaaJG72T68Vndub89CwnhNjnU
         1SSKUI4ZwusEEaUilYG/tF3vtvOAlPDJS9Kkq8yVZmLNBOO7d/pgiQHPt1f1S0nsjYGK
         bBu6aR5C1lBwaYKhsB//as0qWk/C3I44F+3qCtLBBlLnO7CqoGdWS5zV+51LYLROc3Fk
         FkYzmFwo+eBKFDGkictwxtM4yrcntz3/VI+4xbTPVrESVGx/+pwG7nUwfVM6oA+4r3/7
         K2NA==
X-Forwarded-Encrypted: i=1; AJvYcCUbR6zo7iZWyoI5r6XNgjf6zGT2TCNGpiNvNIMX4wLBKH1ZJDxGEt4uxHPfmKobqfCSG/45U7mEcfNHswI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNwtkp3o0Ep5tH90MYqzDboXy2pN6H0tM+iU0LvUK4pOHnyYg
	lZnvHOV48lggdfLGgE7FVh3JRl6xYDGvnl9lfNnl7Uu3mLr+j6vCXuK/uA7869c=
X-Gm-Gg: ASbGncuOPMsdOR0sNbb4uDjUwm9peioJNUMxgwjU7YtsfhYvaPlsvsTQDYeuTU8gVXH
	C0/OMLVBVcVUlRBP79tu4lTizsuD7f9dB54U3pZME+8faWnUp96eqRhLPyHnI84gDcD+Kv2r+B5
	RDflkvLcXhkUftCeLac7QSV1u0A0x6AcZzxOft1h8ioV1KRV4NJ0ss4a0kdh/JBMiOjqyldF1Yg
	JT9OYUEl2Gwd4YOJNbVO7WIq5FkbQmK3UnWs3GbrF/vVMI2Nu0jqxH9r9htMHeM0DjtkC8XrTA6
	MZo033+MLRMjgaBdQ95IxiBWX7iWzQ==
X-Google-Smtp-Source: AGHT+IE/1mbbP4uNRetgOIypjg2bvSDj3GWH/cGEc/xqzPLinfL2kdCDxCigFtQu4L9Hg/0wQ4NEdw==
X-Received: by 2002:a05:6a20:a123:b0:1e1:96d9:a7db with SMTP id adf61e73a8af0-1e1dfbfc129mr8345681637.4.1734167109554;
        Sat, 14 Dec 2024 01:05:09 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:05:08 -0800 (PST)
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
	linux-s390@vger.kernel.org
Subject: [PATCH 10/12] s390: pgtable: also move pagetable_dtor() of PxD to __tlb_remove_table()
Date: Sat, 14 Dec 2024 17:02:56 +0800
Message-Id: <1e87efe43e9b8b679384e947dd8503715dd9faf0.1734164094.git.zhengqi.arch@bytedance.com>
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

In s390, the pagetable_dtor() of PTE has long been moved to
__tlb_remove_table(). So similarly, also move the pagetable_dtor() of
PMD|PUD|P4D to __tlb_remove_table(). This prevents the use-after-free
problem where the ptlock is freed immediately but the page table pages
is freed later via RCU.

By the way, rename pagetable_pte_dtor_free() to pagetable_dtor_free().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/tlb.h |  3 ---
 arch/s390/mm/pgalloc.c      | 14 ++++----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 74b6fba4c2ee3..79df7c0932c56 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -102,7 +102,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 {
 	if (mm_pmd_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pmd));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
@@ -122,7 +121,6 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
@@ -141,7 +139,6 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 {
 	if (mm_p4d_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(p4d));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 569de24d33761..c73b89811a264 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
+static void pagetable_dtor_free(struct ptdesc *ptdesc)
 {
 	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
@@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
-	struct page *page = ptdesc_page(ptdesc);
 
-	if (compound_order(page) == CRST_ALLOC_ORDER) {
-		/* pmd, pud, or p4d */
-		pagetable_free(ptdesc);
-		return;
-	}
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -211,7 +205,7 @@ static void pte_free_now(struct rcu_head *head)
 {
 	struct ptdesc *ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
-- 
2.20.1


