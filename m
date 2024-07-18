Return-Path: <linux-kernel+bounces-256286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978A934C17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDCE1C21A64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738113B588;
	Thu, 18 Jul 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d+qT7m4R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RfoQg8un";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d+qT7m4R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RfoQg8un"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836B13A27D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300362; cv=none; b=kQjLegiHz7tptUBCT69rcNY2w6f/5UOYROkvi2sYoHS6pjMGDLtalc1woCr7rGhISrvtYwCfbyhQ/mD9XJNpIcJ8QhUkQ8TA7Bx4ltJNTC2bttWCsag2VoQUh1gYJvaFHjNHydlEswdSG6+KntPGqf+heB2gfEKWYxT9cxLYets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300362; c=relaxed/simple;
	bh=Bu39IAoeotpZQS+JPqNZI0U0fNYKWTYVrHQJZ/FZuEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dh5GAIyk7mrNP8sHqwNqxgyhkiko4BVm61skvKJdy2qxa1THE9EqEBdydbSybAq4OZ7xl8/zHe8s3EsT6gMgnuARrL7EIcKmzGo34N4MtzsOjIpY9+f3lkdvFnjluOGKAzSWS8o75mj3oZAQV7RJjm5jBCym+PGMfIyK/DOhV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d+qT7m4R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RfoQg8un; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d+qT7m4R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RfoQg8un; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11B8E1FBB9;
	Thu, 18 Jul 2024 10:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP7LJidVwaEiyg2vEhcsAqZZw1DICdTCoxEateoTEY=;
	b=d+qT7m4RpuC6EVZ9Nq36ak8RH1R06p1MZpQhX6/5OnJrFM+TMzDEbOlYJOnnMf53JQ18gA
	6UO8ijGQ+RQrVs6wlAdXj/I+G+awA3+FT+wBSvbQpEUb1Hiao8qP1zqiFXlZMlXyc5NW6K
	Pqi+YricO9OYQ9/hVMHCN1yOZemWs8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP7LJidVwaEiyg2vEhcsAqZZw1DICdTCoxEateoTEY=;
	b=RfoQg8un5zhYCA7bHCAPVoc/BT3n427oAmpgk3WAUkd672G0mnyM+WWXJUO/6+8Ksk08Cc
	f4O3wWrTNuyEuUAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d+qT7m4R;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RfoQg8un
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP7LJidVwaEiyg2vEhcsAqZZw1DICdTCoxEateoTEY=;
	b=d+qT7m4RpuC6EVZ9Nq36ak8RH1R06p1MZpQhX6/5OnJrFM+TMzDEbOlYJOnnMf53JQ18gA
	6UO8ijGQ+RQrVs6wlAdXj/I+G+awA3+FT+wBSvbQpEUb1Hiao8qP1zqiFXlZMlXyc5NW6K
	Pqi+YricO9OYQ9/hVMHCN1yOZemWs8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP7LJidVwaEiyg2vEhcsAqZZw1DICdTCoxEateoTEY=;
	b=RfoQg8un5zhYCA7bHCAPVoc/BT3n427oAmpgk3WAUkd672G0mnyM+WWXJUO/6+8Ksk08Cc
	f4O3wWrTNuyEuUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07B60136F7;
	Thu, 18 Jul 2024 10:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kCFWOYX1mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:17 +0000
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
Subject: [PATCH 5/9] arch/powerpc: Teach book3s64 arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Thu, 18 Jul 2024 12:58:59 +0200
Message-ID: <20240718105903.19617-6-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 11B8E1FBB9
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Spam-Level: 
X-Spamd-Bar: /

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


