Return-Path: <linux-kernel+bounces-240209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6A2926A46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A5528509C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD6194C85;
	Wed,  3 Jul 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7DUEC51"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D8194C74
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042183; cv=none; b=HD2X23GXvm7+ukgVHyIOEXEjQ42+CTmQiFgE8KmgAvAfgsZNHq2W0LgilnsDRw3cLan7azhvowqI88uW7pjtK2XXkZTHInBaQ/w4OWR+VjDPIIlGwI7+wrUZtqoYJvH7zYfzdAHwB38ID4KFY3uIobqp4YbdfXG43N2juhsTPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042183; c=relaxed/simple;
	bh=IzaeIndLiHVeJjgbcceV6K1Hd52juxEnC/hKc2l9l9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZY1rtX3SLDVvZmn15CBgJTnR761rnxjdbqGTSMQpp48C4pY784/FyHMaDDYWKvtwSRcd4h1h8/H5zd6CdgAdKvLfBZ+Kikrq+6muNV8f90QDLZZk0bekrq4zVWN5LQsTeAaTrUkKAyNyRKNpvhvejx+X9tc8ntVHQkM/SRYPs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7DUEC51; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720042180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBkUbHh5FhI05CAEJEjFs15FFfGPI8FVTV6ICfAryLc=;
	b=R7DUEC51h4yzdo27aKlb7ZX/tzSEef14gXxTIRvoxc6oFJ4KfEGYRo7MwTGqoViCxUFZA2
	G+dYdZQFUZFRUVjulUZDuGNoA3hqY3yVCETDMNdmYL/DCagfjYsTvw9Y0Z7OsNMVeW1aQg
	eujSvOMM1Sj4+bM7kJ59dOd6nS+EFV0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-J1Xj9X5YNaiPF64Nrvv-1w-1; Wed, 03 Jul 2024 17:29:39 -0400
X-MC-Unique: J1Xj9X5YNaiPF64Nrvv-1w-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5c21b6db74dso1147858eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042178; x=1720646978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBkUbHh5FhI05CAEJEjFs15FFfGPI8FVTV6ICfAryLc=;
        b=qhcW936zGLHQo34xMFvqh2l66dO2wKHxqqW3U3rYHFiZTdVMZQAeZjzoYZnnN1iluJ
         N/cHNi7iO7awhlYJMTIb0of3VdHRw6F5lAvCEP8zgKph4qgpkRR3FS5Q+UcBX2qnzObF
         ZCUbFYzivGRg+22s3DQHc5aavzL/O8UAEOOYqh09J8SxBruG40rUZfePk28Y5+WTPAxH
         8ZOe4WRPzRL4lwQanUrnhATMzQ1w04AcwYpNZoYrsXhKcOgIuCb/fhqPFx3VF3yh5twk
         5BDFuhcxsYiX4WeE+OJPrC92xnYxlldkxr9+EMwxLaweRpAdp7qzI4+QIUQrcp5a/HGd
         v7LA==
X-Gm-Message-State: AOJu0YwyJCP4XQfSzgGJpp2mCVOQA2PHh7Tx9pMqusnXq2lo11f+fXco
	CjsN6MJoGvRUQAHdiYuWba/05bhyrW69rxE+RTmV3pdiZNzOEKVGzRdvReFQ+yPz0sctLJ8wipz
	Unvvi8JIsqZNcfi9EIIzEOnaorx1sEglb87K6qk+zv6Z2ECXSUJVRFYoj3D2yH8x1d1/9JNFq6k
	YuVytSCFBOQvawiCsCP4Ecf7uR6wrtgmUzcbywH9y7VCw=
X-Received: by 2002:a05:6358:7f0d:b0:1a2:3bde:1425 with SMTP id e5c5f4694b2df-1a6acf18b33mr1469441255d.2.1720042177997;
        Wed, 03 Jul 2024 14:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh/EdB/xSzquRBRoGgcbcKdNPV887AakpSVBbTc4I0BiDNq1hD4sw71GTYj4zNAp5JLHYzHw==
X-Received: by 2002:a05:6358:7f0d:b0:1a2:3bde:1425 with SMTP id e5c5f4694b2df-1a6acf18b33mr1469428955d.2.1720042175430;
        Wed, 03 Jul 2024 14:29:35 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143eb1csm54337481cf.57.2024.07.03.14.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:29:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Dave Jiang <dave.jiang@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Dan Williams <dan.j.williams@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	peterx@redhat.com,
	Hugh Dickins <hughd@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 7/8] mm/x86: Add missing pud helpers
Date: Wed,  3 Jul 2024 17:29:17 -0400
Message-ID: <20240703212918.2417843-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240703212918.2417843-1-peterx@redhat.com>
References: <20240703212918.2417843-1-peterx@redhat.com>
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
 arch/x86/mm/pgtable.c          | 11 +++++++
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index cdf044c2ad6e..701593c53f3b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -782,6 +782,12 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
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
@@ -829,14 +835,8 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
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
@@ -846,6 +846,29 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
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
@@ -1384,10 +1407,26 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
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
index 564b8945951e..9d97a1b99160 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -641,6 +641,17 @@ pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
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


