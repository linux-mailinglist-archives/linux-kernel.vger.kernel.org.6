Return-Path: <linux-kernel+bounces-252980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD17931AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93195B21DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4AB12D214;
	Mon, 15 Jul 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXKiCgr4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8613A86C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071320; cv=none; b=LGfAX/1txIMZGsExBSSq7uTEgCEw908MG2pgsj7/xccJPM37+Arn8fhP3UF1yQ4nAdNFC8u/ASWn4d4P6XLKsyMJhgYsCYhSYCTtnEloh5M1T8y1iwFRJaSURDRLgtnYHKt2pAjY+J4bzTreg3UkLBt3vMxkJiaxCrZZCdSzz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071320; c=relaxed/simple;
	bh=lGBhFBkbaz7EzTpAgSm8PUxosOm03SfTjgCaLHkY1V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj1HpbZo4S9sx5piB07xLBNv4aKVAys0/Whlzi0Sb78poNYwAsqfXUklPOw87XAmczl08qwyHFnVZEM/704d3sa5T0Gh1gY37Qt4lYAK42sCCS9eJlD6XbJXvujqqwgRaYbp5Gs4p2QBD0/H8mQImHyH5DX3m0LCEIf5x+EMXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXKiCgr4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPSgdrK+/9txvlBVeWURx0wHDXuvLt3nB8aMlUhEkV8=;
	b=hXKiCgr45oTKVwaLOhic2Z1cvFe9Ut6FYnRutv9nP6gX3GGCSYEGOsfODQQM8Z+e6KIjRg
	DaAHFJ4X3LBuI5YS9S5VXJuiKqlmrZMPMGUcWgE1i3j/PdyEqRlJmjFSTVKLnTs+VOaChv
	znb3w6vEJ1NQXFjMKyLD6l8XwDrQ5QE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-lkjX_x3-NSW2kAhShxOsPg-1; Mon, 15 Jul 2024 15:21:55 -0400
X-MC-Unique: lkjX_x3-NSW2kAhShxOsPg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b60afbf5d1so14885416d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071315; x=1721676115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPSgdrK+/9txvlBVeWURx0wHDXuvLt3nB8aMlUhEkV8=;
        b=bmEXw7a57/q6vE63Z9f5HBxNoo+AMTHdGD0xwluGzv4ynBxaSEePo+4BClabMIO9iE
         6sguXXJdfv7MjosZF4D5o+OU8j9ChdW64wLEbg1fByK2yeg3bLxOuWURk8tAuRrbrYsD
         nTdgjeOcq1RPN2J7ZtMOnDS/jF2jsA2CAjtRpWGMhObnLakZhGriNBMA8UOo1FXKNW95
         tFkofdgrSMTV2jAR8XBckfC7Vq70bpuWsg54r3JJHo1nEqY+FtFlQmUzC7KEiiWMzXaU
         Gwl7Kqn/0AgWOK2ul92PR/IXACUvvRtzKO9GLNfycE7TXeU52Uah+9Y9917M/HA2zlVH
         lthA==
X-Forwarded-Encrypted: i=1; AJvYcCVDrF8p/VjbFIcYJPAwglb5nfsrywj7afgrVBk/+mVuAdIrseyfkyxx1i8vMzQnRDKu6cnRbZsLKGXcgztDWeke1l23yJ67mvgrIFwt
X-Gm-Message-State: AOJu0YwJSWg+lRIYiqpvJSun7lLaqWB1W6PUkA2oGhzMgwgBDxd2Vcc/
	pnRdMbSTEO5Q0B3D2wZngiBscQwpXlCoEECRTrV/d2fZDgIskpr2yuCg3Qv7ha8l1GdP/Mzi93n
	5AhePjImjLfAoieSevpSfZ8MztG2auUfV3nHe+lc8Tcnr4LbDZfBgoDZBwOAtSA==
X-Received: by 2002:a05:6214:2dc1:b0:6b5:90eb:370f with SMTP id 6a1803df08f44-6b77de8150amr4905696d6.2.1721071314997;
        Mon, 15 Jul 2024 12:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFc1iq6cjowggxR08A9jWNh2nLNKZtlnYVNF070vv7/tCRn3zBtJYgG+pCX+rmBsWl/qf7Fw==
X-Received: by 2002:a05:6214:2dc1:b0:6b5:90eb:370f with SMTP id 6a1803df08f44-6b77de8150amr4905476d6.2.1721071314625;
        Mon, 15 Jul 2024 12:21:54 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:21:54 -0700 (PDT)
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
Subject: [PATCH v3 4/8] mm/powerpc: Add missing pud helpers
Date: Mon, 15 Jul 2024 15:21:38 -0400
Message-ID: <20240715192142.3241557-5-peterx@redhat.com>
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


