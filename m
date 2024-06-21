Return-Path: <linux-kernel+bounces-224852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B991279C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569441C25F76
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A103A1C9;
	Fri, 21 Jun 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIYjLUmo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C39208CA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979920; cv=none; b=Vjuqfth0jxy3P//Muoq6e2lblYNuUX7fAe5E3fSO+bdzTaXPyTKET3/ISHYMmwzZZrNdEozwHtVNvUNG7ASbMzYSgHKJeWCEzqaUDorpThCQTGi4K/NdwpWxz2wFReMrkvy0cGDe4RKXJLosLb+g3Cw5N8A0M3z3iuf4AKvL7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979920; c=relaxed/simple;
	bh=RovpY+xujEdVG++6JrIkRPDs1Uhe4MHJI5kSZut9Xgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5MUVqH9q5SpRvgdBZuYw1fGRxcpWUUjnm+MkV4A/y+vXSH+0A8M4zPQg/m08ojjkquy09OPXogNZ7LurQfcVrC7y8JwkAfsExIQ1yuVzaitRm5YbuLDliRw/EOlX3QX80n94xC88C8HJGRRrq6B/cIL+XInfIn8ddk1kwKIdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIYjLUmo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718979918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMhnR88Gj51dgjDcNyzJVzhu8osLx9zEmj3hidZ3w4E=;
	b=eIYjLUmoU6DCJMCBkWIE7QrTgMaT8zFGNof3uHjw87tNi9k++8c63a+YhWV6P4s3sCBaJn
	hsFli/Q3rrj1inb38CJYjGqpsT5m44YL84jTMN+2IVHnxVOfvkELNbBrn4FWtUAcTymCT9
	B3k+4Na9y6pnHCVtyc7owOVcYR79koc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-1NPjdcg3Obq8VmmUsQ_m9g-1; Fri, 21 Jun 2024 10:25:17 -0400
X-MC-Unique: 1NPjdcg3Obq8VmmUsQ_m9g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-797a903cf8fso21897885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979916; x=1719584716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMhnR88Gj51dgjDcNyzJVzhu8osLx9zEmj3hidZ3w4E=;
        b=uVjc247ppTeKwL5siGj8mo+NkGtXw9mtZizEAHXRWouaDm48d9Y5TFEWi3shHbKNe6
         9AT2KKtXOdOnUPJzrxw8ySeGFfyZEZxiiAKErOnbslkQeEv6FDnbCQRD9y4rGI7yGCHm
         8Nz2t9NBZ6OK0Ya/O7hIa06FxCNXYOnC96a3pMLrbbELdyWC+jQoKiWS0VopW+P9KMXL
         fo9tlrQkD0jsNJ6wzQHaIpUWrF+Ispmq6uXZpxNCNELuYFfTjqmfYRIHkSpRZ4t0pptd
         Lhh3sSdP37B26k08LReaQJXqChWwzINJ3xaG3wo0TcS9Gh1ERR7p4kblmPgX6LcAwCLC
         y5ag==
X-Gm-Message-State: AOJu0YxPy7b6zbn4WkDo+2Z4A3gNXzqL445M5YfeMo1X9B6+R3TrIes/
	swg8iA/GTo5o6VGxuVVG4E1b03zqQtqXX/ru4k6Y1zMAY4c2UtR8vUX41/LNteWnQwSK6i1+Svh
	P57Eh5k46tNNC6Q83tyYN8BiFvwc13Vo01a9Ij+nrY46kzv2coPcAbjJyJKCh0dB7vvx+NaiJQb
	BnRGxGyMlVEzf9oAdsDbhreH0x3+M8WVvYZNBdua546l4=
X-Received: by 2002:a05:620a:3951:b0:79b:be0b:77e9 with SMTP id af79cd13be357-79bbe0b7cbemr703659685a.1.1718979915768;
        Fri, 21 Jun 2024 07:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKR5sMdbnn7x0tNnlB82FrZESiADWgCE3S9rPF+Z4OitOxuRlE3iKP8psvTE41pTKeNbOqHw==
X-Received: by 2002:a05:620a:3951:b0:79b:be0b:77e9 with SMTP id af79cd13be357-79bbe0b7cbemr703653085a.1.1718979914845;
        Fri, 21 Jun 2024 07:25:14 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce944cb2sm90564785a.125.2024.06.21.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:25:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH 4/7] mm/powerpc: Add missing pud helpers
Date: Fri, 21 Jun 2024 10:25:01 -0400
Message-ID: <20240621142504.1940209-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240621142504.1940209-1-peterx@redhat.com>
References: <20240621142504.1940209-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These new helpers will be needed for pud entry updates soon.  Namely:

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
index 8f9432e3855a..fc628a984669 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1108,6 +1108,7 @@ extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
 extern pud_t pfn_pud(unsigned long pfn, pgprot_t pgprot);
 extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
 extern pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot);
+extern pud_t pud_modify(pud_t pud, pgprot_t newprot);
 extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		       pmd_t *pmdp, pmd_t pmd);
 extern void set_pud_at(struct mm_struct *mm, unsigned long addr,
@@ -1368,6 +1369,8 @@ static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
 #define __HAVE_ARCH_PMDP_INVALIDATE
 extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			     pmd_t *pmdp);
+extern pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			     pud_t *pudp);
 
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 2975ea0841ba..c6ae969020e0 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -176,6 +176,17 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	return __pmd(old_pmd);
 }
 
+pmd_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		      pud_t *pudp)
+{
+	unsigned long old_pud;
+
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
+	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
+	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	return __pmd(old_pmd);
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


