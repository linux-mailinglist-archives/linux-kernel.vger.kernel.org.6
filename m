Return-Path: <linux-kernel+bounces-283562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BC294F663
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7962843E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13BD18E02E;
	Mon, 12 Aug 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEDLc3Yv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48533189BBF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486361; cv=none; b=WidcrW+abEnkBhQccGWxNxHfzl1mS5BMcAWWNRMuisN7EjgFyQL30LW3oCxLno0K0AVzgmOchRX8nqjbER8aQyewr+hQPiI4giDO0HjNQgBGXxEy8Csk7HEp/Wp2i1GKQzpbytS8BnOhBWshuIaUP84R77snhxv5defQGkk8aBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486361; c=relaxed/simple;
	bh=Q9BRWExV0ScETKxkjA3f7Ihs4gMyMyZNmWdsKJun9SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDKmAZpW2NQmgtytlal0oTrWCrwWmwqs00+U/RZCCkKyr80qvHXJTRvxpMgt+5W8niKRpLl6eHTxAQrbqO8pPszxklC9OzH8SFOExONtFQJ3l47c5Yp8pXINm+pBHhFUeatXDM6qpyHgV4CBVqlr/QxbxK9mUVmQn42XQHFrjoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEDLc3Yv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wAu0M0+1UWqmiItjD8rL7YnlMQXKv8wW1V5JPENrD98=;
	b=LEDLc3YvRwbCgJbZQuCnpDKkQ866ksh09MdLevvoplTyFZGxXKPgtrsb6PeqYrlzGmsMGn
	5807NhXZ3SpPcLx44mNskwnJLzIMgQeGyVgeVmOOEWHoDtV3LJEE+KSqu7FZKCVYH3rExY
	v3kbu2ay5iZNFhi+FhRM3ktbcM5QE0k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-kqFy8varPo-LW0erpvyumg-1; Mon, 12 Aug 2024 14:12:36 -0400
X-MC-Unique: kqFy8varPo-LW0erpvyumg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d3c02fcfso18662785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486356; x=1724091156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAu0M0+1UWqmiItjD8rL7YnlMQXKv8wW1V5JPENrD98=;
        b=xRxU5w1h3ePu22Kx1FUTry0uVcXn3nBsFtTYDwk2W/E9gHtMfbVXl7Rx36ArRRImTu
         qX4Dl4p6uL/kmHoPQcwdfnXjyE2U2M3289V5yRnSf8Lny43TGsRjvl+JaU6v5wX/SydR
         uI0QJHhzsKbmcB37iHHujZviTMQOes2fRqNa9dYsWZ2L2pwrPHOyKSyM9DtyYMgkbcMT
         w4VjdCaglGmFV1eFKgjoJR/kssZXfmsLrTfbZlRIhEhgCo9rMCMGweHlz96uH/1Yna8f
         J9DmDW4VsEnjhdLbG8yPOaN16gW6/LJp3ABX89/mZIAykGmtC+712Zx6mJ5J4FAqg9z3
         iL3g==
X-Gm-Message-State: AOJu0YzZhBLrUH9RvUhwuoq6bFEW7yDaoZXCMOkFc5Z30v80VKjtUQ8x
	Wxo38nqB473lOCVkLdokIeFkn9X85q+t1avjar6PWVDpSw803F46PSCXcoh6a3Q9PbzIcguqmj0
	sfCDDXE5UIJ3gi8U1BCmTO/5sgGGyGN1fIEgbKSGR1cB2uUoNuKfdTYakfiCkhp/GrIRIS3D8RR
	ibZkT38/13lAa4b+Gl0lP//JPtmxOXfJ0Cf6pEbxAXnM0=
X-Received: by 2002:a05:620a:4005:b0:79f:84f:80b1 with SMTP id af79cd13be357-7a4e15d46a6mr74883385a.7.1723486355882;
        Mon, 12 Aug 2024 11:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpNsU7cY2l6XFvfi/NYSnYqbYktrA9n3rcHeLoBtv5kBl17wu9V8UOiRcR1CmKk37Q2l0U8w==
X-Received: by 2002:a05:620a:4005:b0:79f:84f:80b1 with SMTP id af79cd13be357-7a4e15d46a6mr74878085a.7.1723486355340;
        Mon, 12 Aug 2024 11:12:35 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm268663985a.84.2024.08.12.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	peterx@redhat.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 3/7] mm/powerpc: Add missing pud helpers
Date: Mon, 12 Aug 2024 14:12:21 -0400
Message-ID: <20240812181225.1360970-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240812181225.1360970-1-peterx@redhat.com>
References: <20240812181225.1360970-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some new helpers will be needed for pud entry updates soon.  Introduce
these helpers by referencing the pmd ones.  Namely:

  - pudp_invalidate(): this helper invalidates a huge pud before a split
  happens, so that the invalidated pud entry will make sure no race will
  happen (either with software, like a concurrent zap, or hardware, like
  a/d bit lost).

  - pud_modify(): this helper applies a new pgprot to an existing huge pud
  mapping.

For more information on why we need these two helpers, please refer to the
corresponding pmd helpers in the mprotect() code path.

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


