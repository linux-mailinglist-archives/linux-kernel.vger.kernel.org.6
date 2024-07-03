Return-Path: <linux-kernel+bounces-240208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3EB926A44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA43285D47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CBD194AC1;
	Wed,  3 Jul 2024 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQSOKAk1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F091922E6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042178; cv=none; b=Oh8Me55is9MislrXR/M4iglViDoEvnzSJRYBIj028zdWAryIDxHsm3OgkAQhLIp+63LlR5T2lNRSAbJYwBz3kp7Q3APfO3TCQr5WXipKY2i+HKqYR7hFL34e9XKhUKiLHgfRA7gDDWfQbNo1A+WcLtltsNZbPaD2CgzZTZT+Nsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042178; c=relaxed/simple;
	bh=lGBhFBkbaz7EzTpAgSm8PUxosOm03SfTjgCaLHkY1V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX0F7+2r8f6xkQFTfX8gB4Ro4Zk82LldfOup/RQ8DNcrT0OcslxLCr/AMojcUkCh9xRQGvuoUibPot94MI20VwjXZIAyULWRrM7esF1w+s3fXM4AmUpsMy3HIwTTJlT+eRi/D/qHug3O26W5xZu8CzO179HebFCi5GCeSf8gX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQSOKAk1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720042174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPSgdrK+/9txvlBVeWURx0wHDXuvLt3nB8aMlUhEkV8=;
	b=NQSOKAk1CmR/7N2YrjoLL0po3/9WSA9KzWqCTQBv/s3HEwxQCirc+CNjSB/T4mnOdAbvtg
	AsGGkN4GQUVkOFyVwB2zy0RF2Rmf0dm0t1MqIvrPtIaO9lzAz5VifRtklhBOMgaK83Y/NI
	kG2o6lkBP/Je4e9tiE6QNEq1M+kwnIw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-t1sEetOWNwKdWF85KXkPkw-1; Wed, 03 Jul 2024 17:29:31 -0400
X-MC-Unique: t1sEetOWNwKdWF85KXkPkw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4464454e329so1957971cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042170; x=1720646970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPSgdrK+/9txvlBVeWURx0wHDXuvLt3nB8aMlUhEkV8=;
        b=l3Qw5SzNNYEMtWcB4qJiSdCFIgx+g7XC9GNBkARIZrIawHQ4serTOmYURbSwzTMv54
         unEMNx/pS6U8kzhYNAwNy1+L2ixPZ/Q8JdjrvWi8WJEuMUrySUyzohnLnByUo+3G6Nhi
         F7W81RdRzSJpvneeH0MW2Vfa4clJm8M/O2cmSHc8jnJyd5wZhzWPTBOHFgko3RgVpbn5
         sx364hCD4IUiay4AFomjT6EM2IiTSxWc8I0ciAD8QVNsOcvMqHvaRRWgKPi4z43bTu8q
         5Koy+wIB7C2Inr0sBaZm4PxOkt2N4CVZnFASvkjzUuZ9ij8EoRi+U5i51NS0o94g9+Hh
         ac+g==
X-Gm-Message-State: AOJu0Yw2auDxLo6EvfESoxTl+KN69Vwmm/GWt6VTGgTcF8gvkRWSI0us
	LIxhFQFwMVgJYDFBMZqP2sTma/M/OOm1jx6aiw0GWsz77XdTfnqUUaHRdsfkyJfIwEwJtzu9CQV
	yESfWLd4KmBqDBo+veLbcUPD/YOB6AuW7PRNQzZxG4lDJZ9WXf+mur+5SB6Bx1djQVNiWDPgV4f
	xGb5GQT2gVM72XPbv+VtjTH2zZAibdR07PGjkTVAsgRlY=
X-Received: by 2002:a05:622a:102:b0:446:5d1b:5a2e with SMTP id d75a77b69052e-44662f544a3mr145792611cf.5.1720042170365;
        Wed, 03 Jul 2024 14:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbwAQwNTOhld77jh3m6+0aceNgmx9fLMFpnLFNTJ0A2GCbsDu4E9EVwwSQY1Fjy1mOFnq/rQ==
X-Received: by 2002:a05:622a:102:b0:446:5d1b:5a2e with SMTP id d75a77b69052e-44662f544a3mr145792111cf.5.1720042169860;
        Wed, 03 Jul 2024 14:29:29 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143eb1csm54337481cf.57.2024.07.03.14.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:29:29 -0700 (PDT)
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
Subject: [PATCH v2 4/8] mm/powerpc: Add missing pud helpers
Date: Wed,  3 Jul 2024 17:29:14 -0400
Message-ID: <20240703212918.2417843-5-peterx@redhat.com>
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
them by referencing the pmd ones.  Namely:

- pudp_invalidate()
- pud_modify()

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  3 +++
 arch/powerpc/mm/book3s64/pgtable.c           | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 519b1743a0f4..5da92ba68a45 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1124,6 +1124,7 @@ extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
 extern pud_t pfn_pud(unsigned long pfn, pgprot_t pgprot);
 extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
 extern pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot);
+extern pud_t pud_modify(pud_t pud, pgprot_t newprot);
 extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		       pmd_t *pmdp, pmd_t pmd);
 extern void set_pud_at(struct mm_struct *mm, unsigned long addr,
@@ -1384,6 +1385,8 @@ static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
 #define __HAVE_ARCH_PMDP_INVALIDATE
 extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			     pmd_t *pmdp);
+extern pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			     pud_t *pudp);
 
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index f4d8d3c40e5c..5a4a75369043 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -176,6 +176,17 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	return __pmd(old_pmd);
 }
 
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		      pud_t *pudp)
+{
+	unsigned long old_pud;
+
+	VM_WARN_ON_ONCE(!pud_present(*pudp));
+	old_pud = pud_hugepage_update(vma->vm_mm, address, pudp, _PAGE_PRESENT, _PAGE_INVALID);
+	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	return __pud(old_pud);
+}
+
 pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmdp, int full)
 {
@@ -259,6 +270,15 @@ pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	pmdv &= _HPAGE_CHG_MASK;
 	return pmd_set_protbits(__pmd(pmdv), newprot);
 }
+
+pud_t pud_modify(pud_t pud, pgprot_t newprot)
+{
+	unsigned long pudv;
+
+	pudv = pud_val(pud);
+	pudv &= _HPAGE_CHG_MASK;
+	return pud_set_protbits(__pud(pudv), newprot);
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /* For use by kexec, called with MMU off */
-- 
2.45.0


