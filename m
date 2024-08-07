Return-Path: <linux-kernel+bounces-278468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1420A94B09F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973BC1F217FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2AB146018;
	Wed,  7 Aug 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS138z7p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E53145B39
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060107; cv=none; b=eDaGNFHClKzQrwZyR3Ohr71uQRVETgK5MTs+KXi637yyVdhaIprZwT81covEhkt4J2m7yR0qDaugpPqLsMM7oz8QSr1pw0+z1sa1bH8W6Rcmq4/88k9mzI445y1upKMLZ0c1A6zgJrflhsX9jYCit+d7MkSKKh+zwCo7gyrg5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060107; c=relaxed/simple;
	bh=lGBhFBkbaz7EzTpAgSm8PUxosOm03SfTjgCaLHkY1V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/G7TRGKKlVnatbw0KO0pJqCeyAgK1BPwwXqrFOE/5/dHwsEne0PPUugTWG9EbURNirlFqc6RS5WwYJIPBG7KKCSN5+X3zxsgF5IoWcD9NfSXFZGEiI783ZZCFbcunOvBmFlYl6t1/W0cwGoyeyg9lO4luTM2FGG9QGeMmoxJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS138z7p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723060104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPSgdrK+/9txvlBVeWURx0wHDXuvLt3nB8aMlUhEkV8=;
	b=CS138z7pYDjFBV+cBxOm3z4S8IBLvToYUprABE4Nel8vyYv3gqaETSs4W63Elf5kqhTu7e
	t2t+mkcrSNYRpXUKrNBXDeivsEFnq7cS7FTd3jqxFFKk2k+h5a2f/0ENe+9xkYWNEpHnM3
	dAaTtZRFOkaCm2oqoIroq1iTmdGEVKc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-oO-GHluyOs2CxcVt_IntPg-1; Wed, 07 Aug 2024 15:48:23 -0400
X-MC-Unique: oO-GHluyOs2CxcVt_IntPg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-70b29ad14e5so26970a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060102; x=1723664902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPSgdrK+/9txvlBVeWURx0wHDXuvLt3nB8aMlUhEkV8=;
        b=O0c+FzV6NuzGBIWztDHYPanGJQTHW44csppRWuAfj6sqyXWNvQLTbdPsq8GyU5GPxR
         bYjYvSfUbIH9qrjK/3yQA0IE9UHa7GOjEvh9Fz3SHdIdGwMy/0xQrlIG82wjzn5nwXGY
         4Qfh4C+yyxQDzcVwAOoh8cYtWMngDYnmIvF1PNbTiuhWXwbotUZKPfsRaLaf+/pBN07V
         F1BYYkg/DLVGiW4STBQI/9jISczHZdMMTbzU82UulQZ1DYHUtkp3ARd+3EOQr25nRJqT
         NODugM57Q7/A7FXbZK0Po1Ni0CYSHUGebvx/JnFjXmrTA1dTAcLh+QrIAnXF64jriXnr
         eXzw==
X-Gm-Message-State: AOJu0YxWPpsKReBD619kdFOw7ZstvzmOuymXR/Pvcm3VEqS84j0/SbtT
	O9j5X6+RwwN+dv73TbHWxrbyG79uuZlA/osCER+t7fh2umb0ZkNrivd21W7fzLqppbEER1JGnzB
	xirdv5t6I92MOD86A1Y3nSBo2XZNFE6nzVN6igig9QEzHZJq0Rw7ZT2Gp7S5vxxGnAAfFEBywrq
	A4GTObLlVPN6IdqTI/l2A31+orn6nYk5FRyZcEMFsCjmo=
X-Received: by 2002:a05:6358:a096:b0:1aa:c73d:5a95 with SMTP id e5c5f4694b2df-1af3b89cddemr1270645155d.0.1723060101746;
        Wed, 07 Aug 2024 12:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH//9GjXWmqzA+Y0OZdeiBZvOf2mh0xJt9rLdJnCDcBWQbkH3n97H6Shuw3uIhtGYCg2pjapA==
X-Received: by 2002:a05:6358:a096:b0:1aa:c73d:5a95 with SMTP id e5c5f4694b2df-1af3b89cddemr1270641255d.0.1723060101168;
        Wed, 07 Aug 2024 12:48:21 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ae4asm59853256d6.33.2024.08.07.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:48:20 -0700 (PDT)
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
Subject: [PATCH v4 3/7] mm/powerpc: Add missing pud helpers
Date: Wed,  7 Aug 2024 15:48:07 -0400
Message-ID: <20240807194812.819412-4-peterx@redhat.com>
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


