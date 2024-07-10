Return-Path: <linux-kernel+bounces-247469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C0E92CFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C96428C33D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C55F191477;
	Wed, 10 Jul 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o/R9ZuDL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wx7vnkPn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o/R9ZuDL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wx7vnkPn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2384A2F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608692; cv=none; b=Vz8KxeC9s3PMMJk4crKsEz6W162rtfJiDu4q18G6C5feAB7s7dq7Gp5XsOZcjuC3rlNnK1Wp0hxwo2bxcmoyDR2hgScnxLwzYbLSJ0AxGQVzlYudxhRMYXjP91G211H2uKbmPCylnSKM5o+VSATDvu/gk+N2O7VP6tOIRLGY/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608692; c=relaxed/simple;
	bh=Bu39IAoeotpZQS+JPqNZI0U0fNYKWTYVrHQJZ/FZuEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4dgXG2c5yM6RZJ9yD3GA9siWHMcyNzRDUAT1TblIfQ6UAy4BJGNC1xWFhI9cXQRsRcsfyNv23rlYGJOUx1YyryFN0sXqOi2eLlSkR0BD+Gs8tS4bYrP8HpKj2s4rCrSJLi4xLU4+O6o2JSzgPjn7coZTBBqtIGMrA18b8hHhe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o/R9ZuDL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wx7vnkPn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o/R9ZuDL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wx7vnkPn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C7AA21A33;
	Wed, 10 Jul 2024 10:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720608689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP7LJidVwaEiyg2vEhcsAqZZw1DICdTCoxEateoTEY=;
	b=o/R9ZuDLTBFAeen3OTEvbuoQTG+0ttv6ilWicNUQx0VjjRe1d2Up3cp0/8+x3YfBH2uMnf
	JKDJhaY0AY4YzLPDKX0j1rcmcrJuf+OVuHyMr7/IGf2LIZ6jvsCqW7o7whTOLS2nT2d4NR
	NEI1eQn7lkOnn83FIhhH1NzCWEkh8qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720608689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP7LJidVwaEiyg2vEhcsAqZZw1DICdTCoxEateoTEY=;
	b=Wx7vnkPnXLV89jq+HQkZWLMRhtuwOGjeItAZ0ibHsDgzQXaXRZmCXRBtyVOtI1O92c951J
	mfyReADNVpXDpSDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720608689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP7LJidVwaEiyg2vEhcsAqZZw1DICdTCoxEateoTEY=;
	b=o/R9ZuDLTBFAeen3OTEvbuoQTG+0ttv6ilWicNUQx0VjjRe1d2Up3cp0/8+x3YfBH2uMnf
	JKDJhaY0AY4YzLPDKX0j1rcmcrJuf+OVuHyMr7/IGf2LIZ6jvsCqW7o7whTOLS2nT2d4NR
	NEI1eQn7lkOnn83FIhhH1NzCWEkh8qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720608689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP7LJidVwaEiyg2vEhcsAqZZw1DICdTCoxEateoTEY=;
	b=Wx7vnkPnXLV89jq+HQkZWLMRhtuwOGjeItAZ0ibHsDgzQXaXRZmCXRBtyVOtI1O92c951J
	mfyReADNVpXDpSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E57C31369A;
	Wed, 10 Jul 2024 10:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oPBeM69njmazcwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 10 Jul 2024 10:51:27 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 5/8] arch/powerpc: Teach book3s64 arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Wed, 10 Jul 2024 12:50:39 +0200
Message-ID: <20240710105042.30165-6-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240710105042.30165-1-osalvador@suse.de>
References: <20240710105042.30165-1-osalvador@suse.de>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area{_topdown}
to handle those.
Reshuffle file_to_psize() definition so arch_get_unmapped_area{_topdown}
can make use of it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/powerpc/mm/book3s64/slice.c | 39 ++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index ef3ce37f1bb3..6914b8de627c 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -633,17 +633,36 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 }
 EXPORT_SYMBOL_GPL(slice_get_unmapped_area);
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int file_to_psize(struct file *file)
+{
+	struct hstate *hstate = hstate_file(file);
+	return shift_to_mmu_psize(huge_page_shift(hstate));
+}
+#else
+static int file_to_psize(struct file *file)
+{
+	return 0;
+}
+#endif
+
 unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long addr,
 				     unsigned long len,
 				     unsigned long pgoff,
 				     unsigned long flags)
 {
+	unsigned int psize;
+
 	if (radix_enabled())
 		return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
 
-	return slice_get_unmapped_area(addr, len, flags,
-				       mm_ctx_user_psize(&current->mm->context), 0);
+	if (filp && is_file_hugepages(filp))
+		psize = file_to_psize(filp);
+	else
+		psize = mm_ctx_user_psize(&current->mm->context);
+
+	return slice_get_unmapped_area(addr, len, flags, psize, 0);
 }
 
 unsigned long arch_get_unmapped_area_topdown(struct file *filp,
@@ -652,11 +671,17 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 					     const unsigned long pgoff,
 					     const unsigned long flags)
 {
+	unsigned int psize;
+
 	if (radix_enabled())
 		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags);
 
-	return slice_get_unmapped_area(addr0, len, flags,
-				       mm_ctx_user_psize(&current->mm->context), 1);
+	if (filp && is_file_hugepages(filp))
+		psize = file_to_psize(filp);
+	else
+		psize = mm_ctx_user_psize(&current->mm->context);
+
+	return slice_get_unmapped_area(addr0, len, flags, psize, 1);
 }
 
 unsigned int notrace get_slice_psize(struct mm_struct *mm, unsigned long addr)
@@ -787,12 +812,6 @@ unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 	return 1UL << mmu_psize_to_shift(get_slice_psize(vma->vm_mm, vma->vm_start));
 }
 
-static int file_to_psize(struct file *file)
-{
-	struct hstate *hstate = hstate_file(file);
-	return shift_to_mmu_psize(huge_page_shift(hstate));
-}
-
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
 					unsigned long flags)
-- 
2.45.2


