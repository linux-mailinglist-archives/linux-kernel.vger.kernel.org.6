Return-Path: <linux-kernel+bounces-445946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404409F1DB8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BEC168A08
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522E1922F0;
	Sat, 14 Dec 2024 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CjlPnAbc"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804816F8F5
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167120; cv=none; b=ru5qiInYLkb3da8AGPlXTOjqsLewVZuGbgWCevtjcLrQHdVj/ww8BgNuM4yK6S7KZPwoUDn1wHWM+hSFZbE9FVfNDTD0c4x+jJhGefto0eKLHt5o0ipUMxRzB4G2FOUyH/o+tNwgHB+VFEhgJ+caXYbe1gxJPEnf07OdoO/dOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167120; c=relaxed/simple;
	bh=jz2f+TXF9L6eH57WLv03lHqQHkdhz2aBBoef3FGpiyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6KV2vsdEMyTS8aX4Ld2zru11E3IyuJvVdAQNxHluTpF5NsH2ehGC/rUI1Cpdq4JY6YAsS5ZAtTjk1cYa2FglLC5UI4hIFK/YAGzBASqe9MC2GqiONxRBsbrtIuWiy1hiYYYzhuKteaKNHBhiqE17coUoGGUXd9G35uPJe1qmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CjlPnAbc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso22631865ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167118; x=1734771918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGOtYoMgWgj4YJiYefYK2aPYu+m8suzmBGDTS71l9lQ=;
        b=CjlPnAbc1deakWC9wWLVtj+9u5M9eAWxpd58PQE3PwjWxs7YqQAGdNbsblUNevLBxu
         SmItK3a541WmTF4AV7vBun707O/UAOiFfEpY/DXNNDxgzymowLrNC3gEnGMEORiR33Gm
         ZIGr+ZoxK1N1Msq1DrXyZCVFDMidVeQ/Ga1/2j5F3CxTfUO79t0sfWwnyrpZIbziiUtc
         lBU6ck8FarO0qOiN+yY2wjio6Tx9KpNSgRH/9BbFmYojbkL6ReCKuWYDHJPp7DerJF9I
         5R75h5iUo++F8K1hgFTjk6dhC4e78AyuWxLnjetqKUNCBiqu5BzbxLIcXPhvtR/VQk5H
         YIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167118; x=1734771918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGOtYoMgWgj4YJiYefYK2aPYu+m8suzmBGDTS71l9lQ=;
        b=HFXYtY4msWURNkCaM+ofqeOYV11YBxL+LlPJDI0rqUMGju1kxXjBDxp+J36039ymLg
         UkPeawyWaMAvtwUOyc0tUiPfaQLRlUk7M9UFl/GMndWS0Zg/cKxc7JJGKB7YETBQcXGl
         im2rTaSACe30si3B42j6Ans7CA1VKNF1kRw1Lk8PZetgTEsVcEvU//pFoHtqfNWJpX08
         U34P9DmA58bGy7M7/lcFyeGlwGx7RPP2TfaHIBjX3ZjGR7JuDXZtgJB6RDdahnl1mejZ
         G+0cW0rWWE4t0pZiRYoCx2e06nMtdoDDJWx4lwuulQHBSyM2z0+3DwJZJ0EArjfnqAYw
         2ahQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQR5ahhHR9bYpG7ep0GTRli48YUOWpYLY3xe5tIXYHxmxqiKwEqJd3dt7r16P3b+bwC+b7ZRCMUkdbbpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9hhkhxuyZvKpdlDHaPZ/0Dkiv+YSqrM9jK+eV/9ZJHD5YRg4
	XFG3ye7tIQUnQWlqQ/n4/VvrqZ1uZ2UTVBTS2dBd2OBwOWhjVR254trh16KC/TA=
X-Gm-Gg: ASbGncsFm/H3p0ES8+wlaX0OMgNV//lBtF3QmvbbsKZPKXKLGJ4naCk+bD3KJrpOKRI
	l10Yc+99omqNwwBVJK1FLsqsPSdEV9VGWMJlBMSgtZLW2E3TNAqZ9n5IyDTk0u5Zy4UJdv3A4CJ
	ifv4nF6IXTeZxkFXqVBc+rlInYyUerUM4tc3OFSCAJKrUUalnVbErHLsLyXFK6tFZ6e3VvGaYMm
	cBvNicIOmcxhtFe2TGtU9rl/EITOC0nc6V7tKdlrfjMPqL+qIHRKgsYhNfdnINNdnCPxCtYF4Em
	A3/dvj5RXy0ogCG2vBSswNvViLjVBQ==
X-Google-Smtp-Source: AGHT+IGZK6CYdPWEqKPfkUj35U2xxEx7kipqiMJDua7xnmtA6POZpy/3kuQaFLc+awGAy7moPmF5qQ==
X-Received: by 2002:a17:902:d481:b0:216:4b66:1f1f with SMTP id d9443c01a7336-21892a7c538mr78074805ad.54.1734167118105;
        Sat, 14 Dec 2024 01:05:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:05:17 -0800 (PST)
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 11/12] mm: pgtable: introduce generic __tlb_remove_table()
Date: Sat, 14 Dec 2024 17:02:57 +0800
Message-Id: <271e58cd4ab808c4f402539b76d5916924e2bc6f.1734164094.git.zhengqi.arch@bytedance.com>
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

Several architectures (arm, arm64, riscv, s390 and x86) define exactly the
same __tlb_remove_table(), just introduce generic __tlb_remove_table() to
eliminate these duplications.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm/include/asm/tlb.h      |  9 ---------
 arch/arm64/include/asm/tlb.h    |  7 -------
 arch/powerpc/include/asm/tlb.h  |  1 +
 arch/riscv/include/asm/tlb.h    | 12 ------------
 arch/s390/include/asm/tlb.h     |  1 -
 arch/s390/mm/pgalloc.c          |  7 -------
 arch/sparc/include/asm/tlb_32.h |  1 +
 arch/sparc/include/asm/tlb_64.h |  1 +
 arch/x86/include/asm/tlb.h      | 17 -----------------
 include/asm-generic/tlb.h       | 15 +++++++++++++--
 10 files changed, 16 insertions(+), 55 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 264ab635e807a..ea4fbe7b17f6f 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -27,15 +27,6 @@
 #else /* !CONFIG_MMU */
 
 #include <asm/tlbflush.h>
-
-static inline void __tlb_remove_table(void *_table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)_table;
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 #include <asm-generic/tlb.h>
 
 static inline void
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 93591a80b5bfb..8d762607285cc 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -10,13 +10,6 @@
 
 #include <linux/pagemap.h>
 
-static inline void __tlb_remove_table(void *_table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)_table;
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
 
 #define tlb_flush tlb_flush
 static void tlb_flush(struct mmu_gather *tlb);
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 1ca7d4c4b90db..2058e8d3e0138 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -37,6 +37,7 @@ extern void tlb_flush(struct mmu_gather *tlb);
  */
 #define tlb_needs_table_invalidate()	radix_enabled()
 
+#define __HAVE_ARCH_TLB_REMOVE_TABLE
 /* Get the generic bits... */
 #include <asm-generic/tlb.h>
 
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index ded8724b3c4f7..50b63b5c15bd8 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -10,18 +10,6 @@ struct mmu_gather;
 
 static void tlb_flush(struct mmu_gather *tlb);
 
-#ifdef CONFIG_MMU
-
-static inline void __tlb_remove_table(void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
-#endif /* CONFIG_MMU */
-
 #define tlb_flush tlb_flush
 #include <asm-generic/tlb.h>
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 79df7c0932c56..7052780740349 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -22,7 +22,6 @@
  * Pages used for the page tables is a different story. FIXME: more
  */
 
-void __tlb_remove_table(void *_table);
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 		struct page *page, bool delay_rmap, int page_size);
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index c73b89811a264..3e002dea6278f 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -193,13 +193,6 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	pagetable_dtor_free(ptdesc);
 }
 
-void __tlb_remove_table(void *table)
-{
-	struct ptdesc *ptdesc = virt_to_ptdesc(table);
-
-	pagetable_dtor_free(ptdesc);
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pte_free_now(struct rcu_head *head)
 {
diff --git a/arch/sparc/include/asm/tlb_32.h b/arch/sparc/include/asm/tlb_32.h
index 5cd28a8793e39..910254867dfbd 100644
--- a/arch/sparc/include/asm/tlb_32.h
+++ b/arch/sparc/include/asm/tlb_32.h
@@ -2,6 +2,7 @@
 #ifndef _SPARC_TLB_H
 #define _SPARC_TLB_H
 
+#define __HAVE_ARCH_TLB_REMOVE_TABLE
 #include <asm-generic/tlb.h>
 
 #endif /* _SPARC_TLB_H */
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index 3037187482db7..1a6e694418e39 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -33,6 +33,7 @@ void flush_tlb_pending(void);
 #define tlb_needs_table_invalidate()	(false)
 #endif
 
+#define __HAVE_ARCH_TLB_REMOVE_TABLE
 #include <asm-generic/tlb.h>
 
 #endif /* _SPARC64_TLB_H */
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index f64730be5ad67..3858dbf75880e 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,23 +20,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
 }
 
-/*
- * While x86 architecture in general requires an IPI to perform TLB
- * shootdown, enablement code for several hypervisors overrides
- * .flush_tlb_others hook in pv_mmu_ops and implements it by issuing
- * a hypercall. To keep software pagetable walkers safe in this case we
- * switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the comment
- * below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
- * for more details.
- */
-static inline void __tlb_remove_table(void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 #ifdef CONFIG_PT_RECLAIM
 static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
 {
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 709830274b756..939a813023d7e 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -153,8 +153,9 @@
  *
  *  Useful if your architecture has non-page page directories.
  *
- *  When used, an architecture is expected to provide __tlb_remove_table()
- *  which does the actual freeing of these pages.
+ *  When used, an architecture is expected to provide __tlb_remove_table() or
+ *  use the generic __tlb_remove_table(), which does the actual freeing of these
+ *  pages.
  *
  *  MMU_GATHER_RCU_TABLE_FREE
  *
@@ -207,6 +208,16 @@ struct mmu_table_batch {
 #define MAX_TABLE_BATCH		\
 	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
 
+#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
+static inline void __tlb_remove_table(void *_table)
+{
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
+}
+#endif
+
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
 #else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
-- 
2.20.1


