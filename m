Return-Path: <linux-kernel+bounces-283567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D592294F66B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916B4282487
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584C189B92;
	Mon, 12 Aug 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jv3P17X8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AFC192B65
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486367; cv=none; b=cyjQKPQm8RBH9eEfGwkVYioRP1gvAOqOqfU/6OVauEwpujKGhCJOQq56XGtBLdluMQe8Q98WnJUZIJNR5C52kSkg3lkpVYYB5eTLLIVpptihebRQLl6bOLBwbZe0yBqudEHrirItpG3W+2p4t9NXeOa7EFAqjW1KGc5IJS6QJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486367; c=relaxed/simple;
	bh=K7ZJhR/anPfS9VjsoLzJfQ2pZfXOc5WtMvlRrlxDC4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJo15WQ3fMxCpJ7MKvRsGFi8xXDfUcD3yX8M0njZ3ognyPcZSm3JFyovb2GmTwetwTn5nTFXlPYMBvudoCwYDHYTPyNP327mVnm6o3aO1VNhDqcu8QmRdgBQn8MyAZXYkFLHtcC7LNdhk7/bDEsUjM2C2Adhw+8IGrZ33JjwUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jv3P17X8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j48ti3LHCtaDfvs8kVCshb+r8YjKqoQPQoRoRoS7ZWU=;
	b=Jv3P17X8mjzSYLEnyLyZxS2Fcc+ifBAWbcXy1KCS1EcX5ZC/8zqvELCwQPpeP5BRKS5qn5
	thI1MAAVu5OOFIlqjzrrz+mHxzHZJkgPkOCYs2XhwcqdMvZLKXsWql9tqn2zThzAKGvLr7
	wdb3YGLzY5LOJgxB6idMR57Z+RO7te0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-dd4hPUdXMiGNxMNTttk8bw-1; Mon, 12 Aug 2024 14:12:43 -0400
X-MC-Unique: dd4hPUdXMiGNxMNTttk8bw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b95c005dbcso13023196d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486362; x=1724091162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j48ti3LHCtaDfvs8kVCshb+r8YjKqoQPQoRoRoS7ZWU=;
        b=HEzA7WKmVRz+I8n4jVRnrLitnS/cMKYooNTm6zvlhWB1annJvxeXyYeUEdnhFXxbdI
         x4kXvt+5JPCMp9j0My98Ha3b24JOcfazVHh3hzPRlwOKz4PT8+cbH2hsBzKsAY2tcdrH
         czidSi9Qua8B1Zkc8lspjKoHYbtaPCONyXso960tPAuk+77FEy3M68KucIGe8luyEjiE
         VdbX1kuqA4Umzv9hhVzqetIEpGAu4Mzr9jDFiNjicGcoY1X2ky0GeKvMoDv3d5ZHKxSz
         xIv9EafKUS3JZ2Ire7/pNhQQ1Yr+W0wWt2oidRuNb6agQJQNybgkVf4ahgEjPMGLZViU
         e/dA==
X-Gm-Message-State: AOJu0Yzw9qUjVC7R4m1QGpuKz073AkSLcBnr7BhQGXNTsCeR0XeIe/gx
	o3SEBrRYzYr7cIlR6/bqvcPOGMD6Y3pfv8TFsydKQN/i/KCZfuNL2R8M3HzT7pW5fyLMuiFG0an
	42ms0vjjksDYY3BFX7gZHCreSKEsN411yhXHw5QWWckTN/7mfEVHmEHNu9tJL5coDqwkPe3RCdu
	j3RtmP/sv4dmHP4P80b6pYkYE/fFHoWVaBypPAMPgMntY=
X-Received: by 2002:a05:620a:4609:b0:79d:6273:9993 with SMTP id af79cd13be357-7a4e15be5b1mr69033285a.6.1723486362543;
        Mon, 12 Aug 2024 11:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnMgvJOIkVw2s4SdK0L87wmxjCzEZ4UjgHz1yAaoa3V+0fWl6Gh90ffNusNtYhZ+374uYqxw==
X-Received: by 2002:a05:620a:4609:b0:79d:6273:9993 with SMTP id af79cd13be357-7a4e15be5b1mr69028285a.6.1723486361844;
        Mon, 12 Aug 2024 11:12:41 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm268663985a.84.2024.08.12.11.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:41 -0700 (PDT)
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
Subject: [PATCH v5 6/7] mm/x86: Add missing pud helpers
Date: Mon, 12 Aug 2024 14:12:24 -0400
Message-ID: <20240812181225.1360970-7-peterx@redhat.com>
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

When at it, simplify the pud_modify()/pmd_modify() comments on shadow stack
pgtable entries to reference pte_modify() to avoid duplicating the whole
paragraph three times.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 57 +++++++++++++++++++++++++++++-----
 arch/x86/mm/pgtable.c          | 12 +++++++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index fdb8ac9e7030..8d12bfad6a1d 100644
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
@@ -1389,10 +1412,28 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
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
+#endif
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
index 36e7139a61d9..5745a354a241 100644
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


