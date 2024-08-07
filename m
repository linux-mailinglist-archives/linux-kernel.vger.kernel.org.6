Return-Path: <linux-kernel+bounces-278472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E794B0A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812D9B2377A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040EF1487CE;
	Wed,  7 Aug 2024 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdO+HUA2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802161482FD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060114; cv=none; b=WTU+BUCFwQGpa0d+nGjOA0TARV+RRFikVlyYQxdrlGg8JL/qQ48guXMvQ9QvWOMGDtXI3SfwaUo/+T3JJ7fNMtABxZK+iTXtox8ffGB4fUdo/L8Ef/KqBGxt4uFEUoif9sskgjKJ2trJN2VNd2tfl0uhjzS2pMwdEKHyg1Rsot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060114; c=relaxed/simple;
	bh=jlZBQTergZikBzedosCmwjPZuxq7DHRCY1RQ0v7m73s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSqcIfK86lVuk/Dt04YY4HdY5h7UdCfIdmFv0xQSubWcUxUuF9x4sLzr5zUbuGh2VfCBMbxtd6E6IcqoyKM/jGuUzXOv4KFeQnbdKQ1+uPwFKmwUecOYmjSWe33yvbFrHewA4uFwIb6UM3meZmoImz0AwP/6VHk5etTkGfrFfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdO+HUA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723060110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDb5b0nOIqaqJ1HBArfkZKBp6ttQDN26GIh6owjfgNA=;
	b=TdO+HUA2uoAY7CqjdXmDAfm9Kd1zGVSx5rBwFDFs1Q86HNAapg0itjjHQ5NFivO+WKSJpD
	9v9ignnnq+kFe59kJyKyeXol9m0w2x6VKAy9XBWMnS6ELUzjfOcTRN6gpS9iMDbkqiD+rz
	KJofRxDWbm//GsWctR/DUoo1o5qfd5I=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-3DBBQLP8O6aAO2zcupSXnQ-1; Wed, 07 Aug 2024 15:48:29 -0400
X-MC-Unique: 3DBBQLP8O6aAO2zcupSXnQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3db15ea38baso53633b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060108; x=1723664908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDb5b0nOIqaqJ1HBArfkZKBp6ttQDN26GIh6owjfgNA=;
        b=OLZVCEvf+gpkF3Sh921JB1ceNCRadtQ1NMoWYyt4L4RlAEXHSRbQx8V3V0MCasLRUy
         f/APBsgiMD6/PoGUZ+tkT2uYCyrPPQzyKJDn0s0W2H3E1cUiCz5vDBqilHwTRyaie7Ll
         SvgIxpHuDmZbemItXAbspFZgLJufDzGwU+4UZIUtp+i3qo5XM0VHRboHe3EcDE8aokL/
         H9wyhcHyzY7YFb1clU1c9tI7wNiDviwWYleOZXr3Xac+9yZXEkySV9j70Z0SZEWIZXYJ
         RjUfQtRGsKBOIwrWkR2hpwm5fQXgD3oCs2hu3HA/Vj/UJ5DW/ZQxvqeuSynppZkPr2An
         wkTw==
X-Gm-Message-State: AOJu0Yzlop6rZ8RhP69+84gRqt9x3L1HkBNWjFiLJeg3l5X9p+MH9PS5
	xyhk84fIuDZEFYe7Fwok9d1aOl91txftfpt/NzyHtnnjhLJaad+9BZGDqJQB6iILjnZX1DvQEyT
	hJUhgnMK/svNhNQvVKBHQOhWFpU7K/iaid3v+0zRn8/i8KPhy96FaF7VnitXo80uJrH+hRwUpPh
	T6znEpZDP1kp9lbsYQkDuXpVMcxXYQz5ZSnDxFj/kTQwQ=
X-Received: by 2002:a05:6358:e49f:b0:1ac:f6e3:dbcd with SMTP id e5c5f4694b2df-1af3babf83fmr1244373255d.3.1723060108372;
        Wed, 07 Aug 2024 12:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF6PD4SDnTvqRZFf7QOZAHAr54Efqd3zzz8coMqAlruM+AKE9ZSLZCO533yzyaTsEnxMNyzw==
X-Received: by 2002:a05:6358:e49f:b0:1ac:f6e3:dbcd with SMTP id e5c5f4694b2df-1af3babf83fmr1244369055d.3.1723060107772;
        Wed, 07 Aug 2024 12:48:27 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ae4asm59853256d6.33.2024.08.07.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:48:27 -0700 (PDT)
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
Subject: [PATCH v4 6/7] mm/x86: Add missing pud helpers
Date: Wed,  7 Aug 2024 15:48:10 -0400
Message-ID: <20240807194812.819412-7-peterx@redhat.com>
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

These new helpers will be needed for pud entry updates soon.  Introduce
these helpers by referencing the pmd ones.  Namely:

- pudp_invalidate()
- pud_modify()

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 55 +++++++++++++++++++++++++++++-----
 arch/x86/mm/pgtable.c          | 12 ++++++++
 2 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index fdb8ac9e7030..a7c1e9cfea41 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -787,6 +787,12 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 		      __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
 }
 
+static inline pud_t pud_mkinvalid(pud_t pud)
+{
+	return pfn_pud(pud_pfn(pud),
+		       __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
+}
+
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
@@ -834,14 +840,8 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	pmd_result = __pmd(val);
 
 	/*
-	 * To avoid creating Write=0,Dirty=1 PMDs, pte_modify() needs to avoid:
-	 *  1. Marking Write=0 PMDs Dirty=1
-	 *  2. Marking Dirty=1 PMDs Write=0
-	 *
-	 * The first case cannot happen because the _PAGE_CHG_MASK will filter
-	 * out any Dirty bit passed in newprot. Handle the second case by
-	 * going through the mksaveddirty exercise. Only do this if the old
-	 * value was Write=1 to avoid doing this on Shadow Stack PTEs.
+	 * Avoid creating shadow stack PMD by accident.  See comment in
+	 * pte_modify().
 	 */
 	if (oldval & _PAGE_RW)
 		pmd_result = pmd_mksaveddirty(pmd_result);
@@ -851,6 +851,29 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return pmd_result;
 }
 
+static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
+{
+	pudval_t val = pud_val(pud), oldval = val;
+	pud_t pud_result;
+
+	val &= _HPAGE_CHG_MASK;
+	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val = flip_protnone_guard(oldval, val, PHYSICAL_PUD_PAGE_MASK);
+
+	pud_result = __pud(val);
+
+	/*
+	 * Avoid creating shadow stack PUD by accident.  See comment in
+	 * pte_modify().
+	 */
+	if (oldval & _PAGE_RW)
+		pud_result = pud_mksaveddirty(pud_result);
+	else
+		pud_result = pud_clear_saveddirty(pud_result);
+
+	return pud_result;
+}
+
 /*
  * mprotect needs to preserve PAT and encryption bits when updating
  * vm_page_prot
@@ -1389,10 +1412,26 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+static inline pud_t pudp_establish(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp, pud_t pud)
+{
+	page_table_check_pud_set(vma->vm_mm, pudp, pud);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		return xchg(pudp, pud);
+	} else {
+		pud_t old = *pudp;
+		WRITE_ONCE(*pudp, pud);
+		return old;
+	}
+}
+
 #define __HAVE_ARCH_PMDP_INVALIDATE_AD
 extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp);
 
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		      pud_t *pudp);
+
 /*
  * Page table pages are page-aligned.  The lower half of the top
  * level is used for userspace and the top half for the kernel.
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index d4b3ccf90236..9fc2dabf8427 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -641,6 +641,18 @@ pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		     pud_t *pudp)
+{
+	VM_WARN_ON_ONCE(!pud_present(*pudp));
+	pud_t old = pudp_establish(vma, address, pudp, pud_mkinvalid(*pudp));
+	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	return old;
+}
+#endif
+
 /**
  * reserve_top_address - reserves a hole in the top of kernel address space
  * @reserve - size of hole to reserve
-- 
2.45.0


