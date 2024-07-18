Return-Path: <linux-kernel+bounces-256289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EEF934C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D782819B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326713D28C;
	Thu, 18 Jul 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sFCULHDi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5QSTbzcB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sFCULHDi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5QSTbzcB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882413BC1B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300366; cv=none; b=QKc8+2U2csf+vgAhaWKho9ywMR/X/KvheyydqIWpm5HFPySBvzk7/UXeG1EO23IOXrttiLxFYZ3RacmSQw42KBv8O9iT1XnZ9FdudiUOYX3zhnC1oWqgu+HL60folvs+tazwiap3goShxvXdRdCXJJ3qM5bsZw2Fnf+OK7tbzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300366; c=relaxed/simple;
	bh=U/J985KPM3uGLbgJOUAnar+YfMSKg/u9BONrfMtJS7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZFyZZQk1u1Wm5zSZLD+sXTu0XmIVLKLubqLqdIRDpksxit8vBuNmsi8Z4Dd8NdxfR0OE6j4Ga9m97zes3EdW2LNCvZrORNKVVuEdv0JvmHEpG3UPY0qXCtEM8UmZWYqWoSwP2BokS0ULNeRQSwZNWSnNvr2bNzn0HxQVSe+AkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sFCULHDi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5QSTbzcB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sFCULHDi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5QSTbzcB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC3251FBCD;
	Thu, 18 Jul 2024 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uA6OghgZH0iRGnLvFrby5KN/hDL1p1cPRMCb0kQhP1A=;
	b=sFCULHDiYLCidOxZWgtfh+8VF1osEgqzbFRVwpMV9QRjNlbaZ3kT8iCeHMxAJ5Ws8ceVFG
	crJawzL+uzhe8HxDL94Smc0nLVnBgybmnC3WTBa8z75qmnOu06PefkJVJDi0r3AGR7lm3O
	bDd4hTQNl5F0P1anhubvcKH3KCVrjjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uA6OghgZH0iRGnLvFrby5KN/hDL1p1cPRMCb0kQhP1A=;
	b=5QSTbzcBcLeISf+fa8flAihLmfARAv/AUKET9MsutkpyhqD68D3LrgM4+taA+r4HbIPTo5
	nU2ZnLM9vGHpwnCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uA6OghgZH0iRGnLvFrby5KN/hDL1p1cPRMCb0kQhP1A=;
	b=sFCULHDiYLCidOxZWgtfh+8VF1osEgqzbFRVwpMV9QRjNlbaZ3kT8iCeHMxAJ5Ws8ceVFG
	crJawzL+uzhe8HxDL94Smc0nLVnBgybmnC3WTBa8z75qmnOu06PefkJVJDi0r3AGR7lm3O
	bDd4hTQNl5F0P1anhubvcKH3KCVrjjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uA6OghgZH0iRGnLvFrby5KN/hDL1p1cPRMCb0kQhP1A=;
	b=5QSTbzcBcLeISf+fa8flAihLmfARAv/AUKET9MsutkpyhqD68D3LrgM4+taA+r4HbIPTo5
	nU2ZnLM9vGHpwnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C885136F7;
	Thu, 18 Jul 2024 10:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFt8IYn1mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:21 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 8/9] arch/s390: Clean up hugetlb definitions
Date: Thu, 18 Jul 2024 12:59:02 +0200
Message-ID: <20240718105903.19617-9-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240718105903.19617-1-osalvador@suse.de>
References: <20240718105903.19617-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *

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
index ce5f4fe8be4d..f01b101c80b7 100644
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
-pte_t huge_ptep_get(pte_t *ptep);
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+#define __HAVE_ARCH_HUGE_PTEP_GET
+extern pte_t huge_ptep_get(pte_t *ptep);
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
index 6dcf4d576970..0b89d36a4310 100644
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


