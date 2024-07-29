Return-Path: <linux-kernel+bounces-265404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E893F0AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F11F22F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD62613DDDF;
	Mon, 29 Jul 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="volHx/Xn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="knVJwYfi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="volHx/Xn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="knVJwYfi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7414374C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244248; cv=none; b=mkTzsXMB0/tQSm8Jk3u1hpbLFeAR81giETtl8Iii/rNE0EmK0kAzZqvV1xJ46+Vr+zSnvAV1PJULBLNNkxzmxd0YXiiNaN9s6HwSkW9o0xWo48FvYOIpN0WnkAbwpeXevwh4HjKzq+4T7CerJslnIf74SFC2tTl56NGAP2THpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244248; c=relaxed/simple;
	bh=GA2IdPXxWkEWEnElU24UtJ//HrZLl25aHLVqA/c7LuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbaTk6Nb6Al5LuBdrDbboTIbI1qy9Wj2ryIJY3i3isnHHjzFc0UdK3QB4SC2e3BVKTbNknG29XvGjKXCsIz7CuPCa1/YTL++ITbjbmgRywOsFN/lWtckGL4Cv5cdXN54rgXIQC4WKKAVNK6etuzv8RbHzoj+TW7o9zdF+r9xDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=volHx/Xn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=knVJwYfi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=volHx/Xn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=knVJwYfi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 258031F793;
	Mon, 29 Jul 2024 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722244245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JABgt96y6DRapGbl7s1JS+H2Wcm/YvsqoufOGq2+3+w=;
	b=volHx/XnPqMA5RFciXwgbwhjRFqMgyRXT4+kbJpga0ccIN8LhNl3ops1qKrZkwIAwGqnD4
	B1A6WZEyCFCAak3QmYguTubIpnY2H2K/wyb4b4N/3HfYZ/ZsDcly7oL1N5D2P/FTPWFv5v
	tKhgYrSOZ+J9hxQ+zN7o/2YcyQVYKc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722244245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JABgt96y6DRapGbl7s1JS+H2Wcm/YvsqoufOGq2+3+w=;
	b=knVJwYfiadUdI5HIXe4e8AZ6S+VUmm7xE/xmqdsqxRUJ+CsFVcNU1YW9RneEdovsyeiL2V
	i9lLuNjU7s0+WpCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722244245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JABgt96y6DRapGbl7s1JS+H2Wcm/YvsqoufOGq2+3+w=;
	b=volHx/XnPqMA5RFciXwgbwhjRFqMgyRXT4+kbJpga0ccIN8LhNl3ops1qKrZkwIAwGqnD4
	B1A6WZEyCFCAak3QmYguTubIpnY2H2K/wyb4b4N/3HfYZ/ZsDcly7oL1N5D2P/FTPWFv5v
	tKhgYrSOZ+J9hxQ+zN7o/2YcyQVYKc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722244245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JABgt96y6DRapGbl7s1JS+H2Wcm/YvsqoufOGq2+3+w=;
	b=knVJwYfiadUdI5HIXe4e8AZ6S+VUmm7xE/xmqdsqxRUJ+CsFVcNU1YW9RneEdovsyeiL2V
	i9lLuNjU7s0+WpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89CA11368A;
	Mon, 29 Jul 2024 09:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MMqyG5Ncp2Z4BgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 09:10:43 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 8/9] arch/s390: Clean up hugetlb definitions
Date: Mon, 29 Jul 2024 11:10:17 +0200
Message-ID: <20240729091018.2152-9-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729091018.2152-1-osalvador@suse.de>
References: <20240729091018.2152-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.60 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.60

s390 redefines functions that are already defined (and the same)
in include/asm-generic/hugetlb.h.
Do as the other architectures: 1) include include/asm-generic/hugetlb.h
2) drop the already defined functions in the generic hugetlb.h and
3) use the __HAVE_ARCH_HUGE_* macros to define our own.

This gets rid of quite some code.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/s390/include/asm/hugetlb.h | 58 +++++++++------------------------
 include/asm-generic/hugetlb.h   |  8 +++++
 2 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index cf1b5d6fb1a6..37e80a32623a 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -12,21 +12,24 @@
 #include <linux/pgtable.h>
 #include <asm/page.h>
 
-#define hugetlb_free_pgd_range			free_pgd_range
 #define hugepages_supported()			(MACHINE_HAS_EDAT1)
 
+#define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte, unsigned long sz);
 void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
-pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+#define __HAVE_ARCH_HUGE_PTEP_GET
+extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
+extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep);
 
 /*
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
  */
+#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 static inline int prepare_hugepage_range(struct file *file,
 			unsigned long addr, unsigned long len)
 {
@@ -45,6 +48,7 @@ static inline void arch_clear_hugetlb_flags(struct folio *folio)
 }
 #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
 
+#define __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 				  pte_t *ptep, unsigned long sz)
 {
@@ -54,12 +58,14 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		set_pte(ptep, __pte(_SEGMENT_ENTRY_EMPTY));
 }
 
+#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long address, pte_t *ptep)
 {
 	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
 }
 
+#define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
@@ -72,6 +78,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	return changed;
 }
 
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
@@ -79,69 +86,36 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
 }
 
-static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
-{
-	return mk_pte(page, pgprot);
-}
-
+#define __HAVE_ARCH_HUGE_PTE_NONE
 static inline int huge_pte_none(pte_t pte)
 {
 	return pte_none(pte);
 }
 
+#define __HAVE_ARCH_HUGE_PTE_NONE_MOSTLY
 static inline int huge_pte_none_mostly(pte_t pte)
 {
 	return huge_pte_none(pte);
 }
 
-static inline int huge_pte_write(pte_t pte)
-{
-	return pte_write(pte);
-}
-
-static inline int huge_pte_dirty(pte_t pte)
-{
-	return pte_dirty(pte);
-}
-
-static inline pte_t huge_pte_mkwrite(pte_t pte)
-{
-	return pte_mkwrite_novma(pte);
-}
-
-static inline pte_t huge_pte_mkdirty(pte_t pte)
-{
-	return pte_mkdirty(pte);
-}
-
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
-static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
-{
-	return pte_modify(pte, newprot);
-}
-
+#define __HAVE_ARCH_HUGE_PTE_MKUFFD_WP
 static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
 {
 	return pte;
 }
 
+#define __HAVE_ARCH_HUGE_PTE_CLEAR_UFFD_WP
 static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
 {
 	return pte;
 }
 
+#define __HAVE_ARCH_HUGE_PTE_UFFD_WP
 static inline int huge_pte_uffd_wp(pte_t pte)
 {
 	return 0;
 }
 
-static inline bool gigantic_page_runtime_supported(void)
-{
-	return true;
-}
+#include <asm-generic/hugetlb.h>
 
 #endif /* _ASM_S390_HUGETLB_H */
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 594d5905f615..67bbdafcfc22 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -42,20 +42,26 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
+#ifndef __HAVE_ARCH_HUGE_PTE_MKUFFD_WP
 static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
 {
 	return huge_pte_wrprotect(pte_mkuffd_wp(pte));
 }
+#endif
 
+#ifndef __HAVE_ARCH_HUGE_PTE_CLEAR_UFFD_WP
 static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
 {
 	return pte_clear_uffd_wp(pte);
 }
+#endif
 
+#ifndef __HAVE_ARCH_HUGE_PTE_UFFD_WP
 static inline int huge_pte_uffd_wp(pte_t pte)
 {
 	return pte_uffd_wp(pte);
 }
+#endif
 
 #ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
@@ -106,10 +112,12 @@ static inline int huge_pte_none(pte_t pte)
 #endif
 
 /* Please refer to comments above pte_none_mostly() for the usage */
+#ifndef __HAVE_ARCH_HUGE_PTE_NONE_MOSTLY
 static inline int huge_pte_none_mostly(pte_t pte)
 {
 	return huge_pte_none(pte) || is_pte_marker(pte);
 }
+#endif
 
 #ifndef __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 static inline int prepare_hugepage_range(struct file *file,
-- 
2.45.2


