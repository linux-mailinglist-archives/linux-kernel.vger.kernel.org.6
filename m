Return-Path: <linux-kernel+bounces-560166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656EAA5FEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A79D17EA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139951EE7A8;
	Thu, 13 Mar 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4iPb9+3"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698BF1F12E7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889514; cv=none; b=PTRtuJH3m1kunr0+Gqx189uzi0bEaDS2wZT9qWGazx+ZvPtSTE5TFfcArFkt2kET0RoKnlKETlA0JynNYBWXkxpPI9dPqRT+ZCEmZBAvkV66/WrzbLcD8rkbqEo/r9M0NI01xDRC0Hc015sEBIXq94S6YBeiBZ74ZzbYWT4UfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889514; c=relaxed/simple;
	bh=R7Z7ffLemwCnPpH5COhJObTeiUx2wzTsUCtrICT8b20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UxFQpwXHhJzIUnAL3HRnLCsOkIF54eCWHyQkx1X8vMEZTYmsz008KIhz2L36DNGkR8p5Z1W97vIxgsdKAvOlPUduIrYaq7ytFL9p7zmmPjRZq0xHp10/wGJZtlqSFg9AbHvGEfIE85Rhs6u5tJ3U9BUzT5I/Dsj14u+Jx85QRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4iPb9+3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so9403545e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889511; x=1742494311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vGPxFkxCcqyivuTgzW117dDJKBNuPeXqpXAI/2K5I4=;
        b=T4iPb9+35pSq3olPvxKQJXiTNWbvZ/oXKHfHCzsKHEAiWr/yIX63F9RmDEpUfnNkvP
         rNAXLjSzBA+mg3Lq3UnCMwRgYJjy43yynxBNtoPpmHIS2EqxH08lx5gRykfCb4wq/tJQ
         tosUxhstUa9Tcua4nhCPQCbItn6ef36okHsdSVPK6P3Z+fPWftfj1yd8udv/hf6ZepZC
         s27xDXihuCdf520FtLoUOSsOYXh3PvWVVosAe/Z0pt1ZkfC7ORrixNuublwqOPCEZFgN
         YiCIzEostx5ofHkJjyLtsq4dcLSoT3Y6r6QBNiYEs8j2vBglshnhBrOcv4RiiEfT9Nf2
         X1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889511; x=1742494311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vGPxFkxCcqyivuTgzW117dDJKBNuPeXqpXAI/2K5I4=;
        b=B1gsB+NBjzKkun6duRp1ZyKyzm680AhV0O9aT1RhocAa8s8nnS6H5kqcjZ7Vg4/626
         EJN4kqjIvZ8Tct7xBx9UX7NoYArvpaH9+0uICIAlpZot4IoY00ZSk2T1SaU7yoXR00mj
         osxc4Jzjqxml+pSvd8cqkIgWdoZ/ADGSChNP97prEpj50H12XCZlyQhfM4uBtArUjK74
         ZbAwaXpy4ic1TPm2tVGoQ4CklqHlGxDI2OW1h83CxRvqmx2RqKPk4d5rs87QeRYnzTdm
         qis6N3IGKX/NSoNvjKLzcciQkTRxi50ztJPYrNbMohuBL9rEYcLAKB0tEDCekRX23UN1
         GsMQ==
X-Gm-Message-State: AOJu0YynvhC8+hRDBECl++v1fRCMChbMrt9BeAXDiD1omFpG0fsCk6do
	bif6TcPHjOuaTdNKfobRsCoebdOMLf+hAgJrK1TgrBGG07p2F/Ou07dwem2EaG9a347/9wqXsxr
	+dk0aMuKCrg==
X-Google-Smtp-Source: AGHT+IF292MH6JqAkiIN8jtyln5hVYHbTRuF9S/Wm78jwx44s0FdKYuBZ0MucR5gttxIvSprRDkRwKMLpsnBdw==
X-Received: from wmbfj6.prod.google.com ([2002:a05:600c:c86:b0:43c:f256:f4b3])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d12:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-43d01bdd224mr152891025e9.11.1741889510788;
 Thu, 13 Mar 2025 11:11:50 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:24 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-5-04972e046cea@google.com>
Subject: [PATCH RFC HACKS 05/11] Add asi_map() and asi_unmap()
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Junaid Shahid <junaids@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Patrick Bellasi <derkling@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

Do not worry too much about the implementation of this. I am trying to
implement this more neatly using the x86 PAT logic but haven't managed to
get it working in time for the RFC. To enable testing & review, I'm very
hastily throwing something together that basically works, based on a
simplified version of what was used for the latest RFC [0].

[0] https://lore.kernel.org/linux-mm/20250110-asi-rfc-v2-v2-0-8419288bc805@google.com/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/asi.h |  3 ++
 arch/x86/mm/asi.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/asi.h        |  2 ++
 include/linux/vmalloc.h    |  4 +++
 mm/vmalloc.c               | 32 +++++++++++--------
 5 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index b8f604df6a36508acbc10710f821d5f95e8cdceb..cf8be544de8b108190b765e3eb337089866207a2 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -23,6 +23,9 @@ static __always_inline pgd_t *asi_pgd(struct asi *asi)
 	return asi ? asi->pgd : NULL;
 }
 
+void asi_map(struct page *page, int numpages);
+void asi_unmap(struct page *page, int numpages);
+
 #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 
 #endif /* _ASM_X86_ASI_H */
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index e5a981a7b3192655cd981633514fbf945b92c9b6..570233224789631352891f47ac2f0453a7adc06e 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -1,8 +1,85 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bug.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/pgtable.h>
+#include <linux/set_memory.h>
+#include <linux/vmalloc.h>
+
 #include <asm/asi.h>
+#include <asm/traps.h>
 
 static __aligned(PAGE_SIZE) pgd_t asi_global_nonsensitive_pgd[PTRS_PER_PGD];
 
 struct asi __asi_global_nonsensitive = {
 	.pgd = asi_global_nonsensitive_pgd,
 };
+
+/*
+ * Map the given pages into the ASI nonsensitive physmap. The source of the
+ * mapping is the regular unrestricted page tables. Only supports mapping at
+ * pageblock granularity. Does no synchronization.
+ */
+void asi_map(struct page *page, int numpages)
+{
+	unsigned long virt;
+	unsigned long start = (size_t)(page_to_virt(page));
+	unsigned long end = start + PAGE_SIZE * numpages;
+	unsigned long page_size;
+
+	VM_BUG_ON(!IS_ALIGNED(page_to_pfn(page), pageblock_nr_pages));
+	VM_BUG_ON(!IS_ALIGNED(numpages, pageblock_nr_pages));
+
+	for (virt = start; virt < end; virt = ALIGN(virt + 1, page_size)) {
+		pte_t *pte, *pte_asi;
+		int level, level_asi;
+		pgd_t *pgd = pgd_offset_pgd(asi_global_nonsensitive_pgd, virt);
+
+		pte_asi = lookup_pgtable_in_pgd(pgd, virt, &level_asi);
+		page_size = page_level_size(level_asi);
+
+		pte = lookup_address(virt, &level);
+		if (!pte || pte_none(*pte))
+			continue;
+
+		/*
+		 * Physmap should already be setup by PAT code, with no pages
+		 * smaller than 2M. This function should only be called at
+		 * pageblock granularity. Thus it should never be required to
+		 * break up pages here.
+		 */
+		if (WARN_ON_ONCE(!pte_asi) ||
+		    WARN_ON_ONCE(ALIGN_DOWN(virt, page_size) < virt) ||
+				 ALIGN(virt, page_size) > end)
+			continue;
+
+		/*
+		 * Existing mappings should already match the structure of the
+		 * unrestricted physmap.
+		 */
+		if (WARN_ON_ONCE(level != level_asi))
+			continue;
+
+		set_pte(pte_asi, *pte);
+	}
+}
+
+/*
+ * Unmap pages previously mapped via asi_map().
+ *
+ * Interrupts must be enabled as this does a TLB shootdown.
+ */
+void asi_unmap(struct page *page, int numpages)
+{
+	size_t start = (size_t)page_to_virt(page);
+	size_t end = start + (PAGE_SIZE * numpages);
+	pgtbl_mod_mask mask = 0;
+
+	VM_BUG_ON(!IS_ALIGNED(page_to_pfn(page), pageblock_nr_pages));
+	VM_BUG_ON(!IS_ALIGNED(numpages, pageblock_nr_pages));
+
+	vunmap_pgd_range(asi_pgd(ASI_GLOBAL_NONSENSITIVE), start, end, &mask);
+
+	flush_tlb_kernel_range(start, end - 1);
+}
diff --git a/include/linux/asi.h b/include/linux/asi.h
index 2d3049d5fe423e139dcce8f3d68cdffcc0ec0bfe..ee9811f04a417556cf2e930644eaf05f3c9bfee3 100644
--- a/include/linux/asi.h
+++ b/include/linux/asi.h
@@ -13,6 +13,8 @@
 struct asi {};
 
 static inline pgd_t *asi_pgd(struct asi *asi) { return NULL; }
+static inline void asi_map(struct page *page, int numpages) { }
+static inline void asi_unmap(struct page *page, int numpages) { }
 
 #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 #endif /* _INCLUDE_ASI_H */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e39334ddaff910222d4751c18da5e7..c498ba127b4a511b5a6f10afa2aae535509fc153 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -11,6 +11,7 @@
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
+#include <linux/pgtable.h>
 
 #include <asm/vmalloc.h>
 
@@ -324,4 +325,7 @@ bool vmalloc_dump_obj(void *object);
 static inline bool vmalloc_dump_obj(void *object) { return false; }
 #endif
 
+void vunmap_pgd_range(pgd_t *pgd_table, unsigned long addr, unsigned long end,
+			pgtbl_mod_mask *mask);
+
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 61981ee1c9d2f769d4a06ab542fc84334c1b0cbd..ffeb823398809388c0599f51929a7f3506ed035f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -427,6 +427,24 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	} while (p4d++, addr = next, addr != end);
 }
 
+void vunmap_pgd_range(pgd_t *pgd_table, unsigned long addr, unsigned long end,
+		      pgtbl_mod_mask *mask)
+{
+	unsigned long next;
+	pgd_t *pgd = pgd_offset_pgd(pgd_table, addr);
+
+	BUG_ON(addr >= end);
+
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_bad(*pgd))
+			*mask |= PGTBL_PGD_MODIFIED;
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		vunmap_p4d_range(pgd, addr, next, mask);
+	} while (pgd++, addr = next, addr != end);
+}
+
 /*
  * vunmap_range_noflush is similar to vunmap_range, but does not
  * flush caches or TLBs.
@@ -441,21 +459,9 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
  */
 void __vunmap_range_noflush(unsigned long start, unsigned long end)
 {
-	unsigned long next;
-	pgd_t *pgd;
-	unsigned long addr = start;
 	pgtbl_mod_mask mask = 0;
 
-	BUG_ON(addr >= end);
-	pgd = pgd_offset_k(addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_bad(*pgd))
-			mask |= PGTBL_PGD_MODIFIED;
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		vunmap_p4d_range(pgd, addr, next, &mask);
-	} while (pgd++, addr = next, addr != end);
+	vunmap_pgd_range(init_mm.pgd, start, end, &mask);
 
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);

-- 
2.49.0.rc1.451.g8f38331e32-goog


