Return-Path: <linux-kernel+bounces-252983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EE0931ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DE31C21951
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C9B13CFBC;
	Mon, 15 Jul 2024 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ5YKnnZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7413C83D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071325; cv=none; b=nl+j5vdz3b/+G8Y5Ch2wrJlylVw5yiewsg6Nb3ekLU6voJ5n+wUC4KiEeZ+1B5OwQTCENIkQdLEI85+PosXVmh4PfmKj9fN54chB7WmGfsK9OKdjQyBoHFuunkMWZf1Y5ci83HMeUtC3ZetH8cZnLS89mB10LB2cj4L1YRSmdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071325; c=relaxed/simple;
	bh=ZQcIytPpRpgyZIcTGEgOPkZLRG43kHqd/i82zdy4vsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQniQXNxHyk47bJmwB5b7dPe6wVbSyZ41unlsp0Bhu+wKPiwmRwfOFuKSDBba85CKWu2BWJJ/jdsAAUWI/EuZRHRstpKsAKS6IEnn7etJSo3Fe5WnSHgdBWhMisRng13t9Y7bfuRTXcagoyBwWNMxBk4mBx1QhnAB+4KQGbrZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZ5YKnnZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIbZhmDyeGPrqbKoRiCTCUG6/nrhKTfNHRA57Ap3jGE=;
	b=KZ5YKnnZoukzulSb4D7mCcYfH3KN9l2PAXcggYlc/Do9N5BvAF/tLjml6XsZaV1ZwizO5n
	Jt76TWRqvL5zUpQ1QcIaUJWCk49FWYW/AaLTrZVQbjITm6RLS9JxnazbKvMeu8spdHYbng
	vbueWer6nZB80eg8cMDZZx+StmwNoPA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70--DmIh2AMN0OttAnvqpci8A-1; Mon, 15 Jul 2024 15:22:01 -0400
X-MC-Unique: -DmIh2AMN0OttAnvqpci8A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b7735566bfso2304546d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071321; x=1721676121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIbZhmDyeGPrqbKoRiCTCUG6/nrhKTfNHRA57Ap3jGE=;
        b=sWnKowH0lWmAG37MYnB8r+sU0b561uvzIdV0dbvYpCFHgGyf+KQnkijY/GYoHIfT6e
         GApRFIhXBLUMoREjR/345EMWfBFZIkePybsiWmJh/8tB0IceRjGRRv6qZVI2vVgp1P1W
         hIy/HbKUNgXZR0GbVW1tJZ7b3QTPaNayRPV9cnVBtRF0Vbrn4q6XtGBJ6VZKjb8yD0lo
         H4fAfv2hqLKtpLKXns/R1g2Qb1/FNC71htJWN7oD9URMTtwR445t5wyfV/ampM+x2bOM
         3P+Vdk9txnphsLmtDD3VKe1T90hk/+Am0SkDZFOdVACbTp502Z1DNsWp/KeJLeoaRhuO
         LDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG/vMEC5JtuPjIvSDCrSjWVv1/j3GOwOATHcOXitHvOzXaurJCoB4bnoEp4mZX3erHOX+0Waxaj6TFNvU7IhhGpz12WT5Tb194s0L/
X-Gm-Message-State: AOJu0Ywu/x9hj4BV2IqUunjUKzbPTRkGXY9/0tKOTWOCwqB3tSZ7YYyY
	C72+Sjf3wsNw/+ELl5+VySnpztxZDS9oVFp5ZyZxMAzWoVDS728pLsYQ6CdN374NxvGlD0I6JpW
	PQT/zM8so8fS9Lhe4yzoqley3gt5quZSfectlkJtNpGPiWmZjjYoHuEhJR95Zew==
X-Received: by 2002:a05:6214:5d0b:b0:6b5:38d4:c9c5 with SMTP id 6a1803df08f44-6b77df20d64mr4194796d6.4.1721071321076;
        Mon, 15 Jul 2024 12:22:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuNyAqmev7NeecbFUrfKh3dH4xJxhydhorfZ+q73TgeQxZK3QM+o4zZ2VKk8paCO1QT0QczQ==
X-Received: by 2002:a05:6214:5d0b:b0:6b5:38d4:c9c5 with SMTP id 6a1803df08f44-6b77df20d64mr4194626d6.4.1721071320743;
        Mon, 15 Jul 2024 12:22:00 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:22:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>,
	x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 7/8] mm/x86: Add missing pud helpers
Date: Mon, 15 Jul 2024 15:21:41 -0400
Message-ID: <20240715192142.3241557-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
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
index 564b8945951e..fa77411bb266 100644
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


