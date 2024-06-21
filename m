Return-Path: <linux-kernel+bounces-224855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C5D9127A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDAF1F251D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3735CDF0;
	Fri, 21 Jun 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnfCgak6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C44D8AD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979925; cv=none; b=bdsVSkAZDHEvfhbXn+RdhgSQ0gBtVHQOTXruj2xprF8/PPO0OfYILu+UA8t4t00+EqgblrsXO74uWe7Ty6xITXnp9C5r3YVP6jWJBkX4q89rwRvuUyyK/vJIERFfM44q9pEfTkodluiAMVQy6FHKQ110misZ5VKGoc8ddr/xoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979925; c=relaxed/simple;
	bh=XjjA2tmFAAypYeLP8NdXol8grBVU43yRXPOg3GP+ySM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxBdmATuHaXk04z6OVwlh058XbVlGD5jGlie8AWcS/6g8NDwAL0PD5sITxYSH9+diUB4kypazvYprfwdPl3ulqzB7j852wpYNT4/F1sSyCXC2k5FQmcRxPeJoUi0HOZ6f/SAvLxWrUV+Fttq1DOQxE3miixCeiDwzCh37QMOGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnfCgak6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718979923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSfUWMuuFFpoXlX71uD6ModhPCWC1FSZp1xmlIx7N4=;
	b=NnfCgak6UafnbQ9z9xI2oOsEhyaT9T1OvvNMabvBSvUUUMClZyaJ01cAWsg6Bmb2FeHls2
	6e9VEmxzewbeM7eYi6/D2AES00yi7G4iT3eUM0uT23C5Itkax7SbVSft5oDmdtEW+F+zGO
	/i9pYK8cCOqMI7Jxmj44xhK1bX/72rs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660--UcYftHGNaWP2vErBh2etw-1; Fri, 21 Jun 2024 10:25:22 -0400
X-MC-Unique: -UcYftHGNaWP2vErBh2etw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6f97a99d7dfso141990a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979920; x=1719584720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqSfUWMuuFFpoXlX71uD6ModhPCWC1FSZp1xmlIx7N4=;
        b=R0sTpobXsS9+wz9Fc60GHW2OKqPYGON0vE5b8Bmp+KATd0aU4bgZn20oxIDCXgcPGP
         aAKsfXZp6Nmtm4p18eRL+95P+ftHmi6IU21UOpQxQpr5OQQYu6PymL3uwgyK3VqhPv5i
         iKmS9TUGQvOVtn3iJg8kOui09Yn1MXwmoGiPt4EgKZBOA/0G8YvsCSi3JT6X+UT9pTIX
         cZCRL2tKmeSZ4zTQOczd94G/fzf0sgBjc5ngRjeAOrhuGhEVLS1MX371Un8fWl8z++tj
         ylkyaJTydI4zZ1hgQTr16VlQQNuG2j0aRQIxpKcTb6tGJ7PlxiczEXSeUDQK8sdWCDwL
         L4MQ==
X-Gm-Message-State: AOJu0YzTMUZPI91ny4vZlWeDGYR3wD3tuiLK40NW4TZeC8g1an7zdPq9
	aw2Lm97+DHOGhWjSKz7BlTYEEmxScFD0wvIBaQ08A09XfZGODlC/dF/Ic2caGCwdV7kh7U3DPa3
	WfUNqexNIvGIJRJDQbRqN3O4QiBbkGTJfxJ/dovC04gv+/9mG+4VMiGRCIIrZSi568f7E3Q0qzg
	c8QUlB4e1PAHw25q33G+TYUo0iOLXo2IFrhacJrtJvN9A=
X-Received: by 2002:a05:6358:8096:b0:19f:81fb:131c with SMTP id e5c5f4694b2df-1a1fd1d513bmr911568855d.0.1718979920317;
        Fri, 21 Jun 2024 07:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOaIBFrX4PIBPbd7NrgasVtJd+jvRQiQvrolpQX5hE+bY+MZMCcoynbRsNLrRaLePwagbsiQ==
X-Received: by 2002:a05:6358:8096:b0:19f:81fb:131c with SMTP id e5c5f4694b2df-1a1fd1d513bmr911563455d.0.1718979919599;
        Fri, 21 Jun 2024 07:25:19 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce944cb2sm90564785a.125.2024.06.21.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:25:18 -0700 (PDT)
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
Subject: [PATCH 6/7] mm/x86: Add missing pud helpers
Date: Fri, 21 Jun 2024 10:25:03 -0400
Message-ID: <20240621142504.1940209-7-peterx@redhat.com>
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++++
 arch/x86/mm/pgtable.c          | 11 +++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 25fc6d809572..3c23077adca6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -775,6 +775,12 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
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
@@ -839,6 +845,21 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return pmd_result;
 }
 
+static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
+{
+	pudval_t val = pud_val(pud), oldval = val;
+
+	/*
+	 * NOTE: no need to consider shadow stack complexities because it
+	 * doesn't support 1G mappings.
+	 */
+	val &= _HPAGE_CHG_MASK;
+	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val = flip_protnone_guard(oldval, val, PHYSICAL_PUD_PAGE_MASK);
+
+	return __pud(val);
+}
+
 /*
  * mprotect needs to preserve PAT and encryption bits when updating
  * vm_page_prot
@@ -1377,10 +1398,25 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+static inline pud_t pudp_establish(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp, pud_t pud)
+{
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
index 93e54ba91fbf..4e245a1526ad 100644
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


