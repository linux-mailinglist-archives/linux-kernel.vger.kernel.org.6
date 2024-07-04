Return-Path: <linux-kernel+bounces-240500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D735C926E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5754A1F23C93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8DA22087;
	Thu,  4 Jul 2024 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mvxA8c0w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gtiiSyL8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mvxA8c0w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gtiiSyL8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D3757E7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067524; cv=none; b=sXQYLHBqi7tyGBKd15heIDlV19aMZfhJojGMq7GbooxH7yDy5JPLIF0Zb45QD2y/y3tJIo2w01kf0qRxpPIF5jvuQrzv6TDe6jFxwPyytyqjfa/QBQYoQteeWTpXfZgxVbsKZYaNMwm/nIf7U4URzEKRFs1rQej/WFTucQg6Hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067524; c=relaxed/simple;
	bh=cjk/JLRgvQpbw0r3DIONPGQ7F/AxQIIt+ehoTwPy9T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isv4pxPuzOnVf5aU00UYcXPLxvLngiulGAXE8MD+O6M+lQSoSlbop9AOoYkl/O5ljRJ/X8vMXLujr9UpueoyEgpWVjqnrm7CGyL98LtpjgCOmjcDJTBD50I9UB900UnyD8sY2B9Z0YEVJ4nygUmslg8f0d8rsrJ3u8kR0TJxw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mvxA8c0w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gtiiSyL8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mvxA8c0w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gtiiSyL8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4A8C1FCF8;
	Thu,  4 Jul 2024 04:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=759iJlxKnytdAlee8rRqvYsRUqK1GzIE0jiP12kfaog=;
	b=mvxA8c0wNNkkavEyFQzOp2mf8378ze4FIH4m4ZfgOZRJ7zpzcoSPW950dQZsa3S/CK+ttv
	iZlMjg840j6JYRueSYvhI7YBduf5ZmQglN6zSGHvYGjJBa7Jy2q7URNYkz9x4o2JnliPCw
	zchyR+/MljAZfrr+nxrpTvg2ZDweQk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=759iJlxKnytdAlee8rRqvYsRUqK1GzIE0jiP12kfaog=;
	b=gtiiSyL8IoxKC27iK+u4Mo4MByRQvcwll4qDeKH5vMoKVQYazRAVgxQtYJlScwNErbS0UE
	MtZSHFG7y/+A7DCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=759iJlxKnytdAlee8rRqvYsRUqK1GzIE0jiP12kfaog=;
	b=mvxA8c0wNNkkavEyFQzOp2mf8378ze4FIH4m4ZfgOZRJ7zpzcoSPW950dQZsa3S/CK+ttv
	iZlMjg840j6JYRueSYvhI7YBduf5ZmQglN6zSGHvYGjJBa7Jy2q7URNYkz9x4o2JnliPCw
	zchyR+/MljAZfrr+nxrpTvg2ZDweQk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=759iJlxKnytdAlee8rRqvYsRUqK1GzIE0jiP12kfaog=;
	b=gtiiSyL8IoxKC27iK+u4Mo4MByRQvcwll4qDeKH5vMoKVQYazRAVgxQtYJlScwNErbS0UE
	MtZSHFG7y/+A7DCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5A4213889;
	Thu,  4 Jul 2024 04:31:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIG7I78lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:59 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 09/45] mm: Implement pud-version functions for swap and vm_normal_page_pud
Date: Thu,  4 Jul 2024 06:30:56 +0200
Message-ID: <20240704043132.28501-10-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
References: <20240704043132.28501-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

HugeTLB pages will be handled on pud level as well, so we need to
implement pud-version of vm_normal_page_pud and swp-pud functions.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
 include/linux/mm.h                           |  4 ++
 include/linux/pgtable.h                      |  6 +++
 include/linux/swapops.h                      | 15 ++++++
 mm/memory.c                                  | 51 ++++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 519b1743a0f4..fa4bb8d6356f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -687,6 +687,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
 #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
 #define __pmd_to_swp_entry(pmd)	(__pte_to_swp_entry(pmd_pte(pmd)))
+#define __pud_to_swp_entry(pud)	(__pte_to_swp_entry(pud_pte(pud)))
 #define __swp_entry_to_pmd(x)	(pte_pmd(__swp_entry_to_pte(x)))
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5f1075d19600..baade06b159b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2371,6 +2371,10 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t pmd);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd);
+struct folio *vm_normal_folio_pud(struct vm_area_struct *vma,
+				  unsigned long addr, pud_t pud);
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
+				pud_t pud);
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3a7b8751747e..a9edeb86b7fe 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1990,4 +1990,10 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)			\
 }									\
 EXPORT_SYMBOL(vm_get_page_prot);
 
+#ifdef CONFIG_HUGETLB_PAGE
+#ifndef __pud_to_swp_entry
+#define __pud_to_swp_entry(pud) ((swp_entry_t) { pud_val(pud) })
+#endif
+#endif
+
 #endif /* _LINUX_PGTABLE_H */
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index cb468e418ea1..182957f0d013 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -126,6 +126,21 @@ static inline int is_swap_pte(pte_t pte)
 	return !pte_none(pte) && !pte_present(pte);
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static inline int is_swap_pud(pud_t pud)
+{
+	return !pud_none(pud) && !pud_present(pud);
+}
+
+static inline swp_entry_t pud_to_swp_entry(pud_t pud)
+{
+	swp_entry_t arch_entry;
+
+	arch_entry = __pud_to_swp_entry(pud);
+	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
+}
+#endif
+
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
diff --git a/mm/memory.c b/mm/memory.c
index 0a769f34bbb2..90c5dfac35c6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -718,6 +718,57 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
+				pud_t pud)
+{
+	unsigned long pfn = pud_pfn(pud);
+
+	/*
+	 * There is no pmd_special() but there may be special pmds, e.g.
+	 * in a direct-access (dax) mapping, so let's just replicate the
+	 * !CONFIG_ARCH_HAS_PTE_SPECIAL case from vm_normal_page() here.
+	 */
+	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
+		if (vma->vm_flags & VM_MIXEDMAP) {
+			if (!pfn_valid(pfn))
+				return NULL;
+			goto out;
+		} else {
+			unsigned long off;
+
+			off = (addr - vma->vm_start) >> PAGE_SHIFT;
+			if (pfn == vma->vm_pgoff + off)
+				return NULL;
+			if (!is_cow_mapping(vma->vm_flags))
+				return NULL;
+		}
+	}
+
+	if (pud_devmap(pud))
+		return NULL;
+	if (unlikely(pfn > highest_memmap_pfn))
+		return NULL;
+
+	/*
+	 * NOTE! We still have PageReserved() pages in the page tables.
+	 * eg. VDSO mappings can cause them to exist.
+	 */
+out:
+	return pfn_to_page(pfn);
+}
+
+struct folio *vm_normal_folio_pud(struct vm_area_struct *vma,
+				  unsigned long addr, pud_t pud)
+{
+	struct page *page = vm_normal_page_pud(vma, addr, pud);
+
+	if (page)
+		return page_folio(page);
+	return NULL;
+}
+#endif
+
 static void restore_exclusive_pte(struct vm_area_struct *vma,
 				  struct page *page, unsigned long address,
 				  pte_t *ptep)
-- 
2.26.2


