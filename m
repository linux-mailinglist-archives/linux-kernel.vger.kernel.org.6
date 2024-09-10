Return-Path: <linux-kernel+bounces-322600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17308972B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A81A1C21B04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4110188002;
	Tue, 10 Sep 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ItqeHbI+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lIO2uYXK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ItqeHbI+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lIO2uYXK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533A185942
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955256; cv=none; b=HjKRfvUNd5bc18/ie1YiCsVbefTGpPQXJ9FTaWx4N3/lqAPfNiHNmEKmjsKnhGELPtZF5WMGve7KqTFIINHkzXF1VMIDgg0WX6QDpJ7tyIJPXQWmgj3WONuCNT1jrV31XqT08S+V8bWGZ2KC4D6Kdy0P5sRuTOKCqI3hBgAunCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955256; c=relaxed/simple;
	bh=65iiIC6vTesNB2Wn9xPCeMa4g3pLb8SgV97O7hV+yzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cny9QZdXs3oLM5Nnl5CSZRfnTEcVNAFpYKZNOX+mSNH7HTIjkQ2TcV7gvN8yFSDgDXr7760L62yAN8yjNpqtsrxAH4ldwjM8QEx3BzSGwtJyyk7Yspk+YLXfOSHRR94CxUyo2qJbtvLlb4UZWk2B8/JSAFfN+DfxptZLoIIhpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ItqeHbI+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lIO2uYXK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ItqeHbI+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lIO2uYXK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A470F1F80B;
	Tue, 10 Sep 2024 08:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPjsfCQSviNFBHuUqkfk5P5tQyuHiB7xifQvmojeMuQ=;
	b=ItqeHbI+GRbj3eHSk7v57wunACPQojKxsCDJTzlIKMrzNkxsdr1T62g/nz65YeakEebMDY
	E5Vsofuq9et42QNa/KWxgCIYEizqZZNdR7D1Do3AOoscL+tEpizKP5N+MmQyj59/UHTalg
	m9Q9rg1xJGZltuRNl9zju4xaQEmSC3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPjsfCQSviNFBHuUqkfk5P5tQyuHiB7xifQvmojeMuQ=;
	b=lIO2uYXKTWyWdv+ERVGq2fs1LKyuNHkzCTLZ5UbKiIBqlEb8Qt8jtmFNGkvBA3ujBAVCj2
	r7y6P8mz5pteo9DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPjsfCQSviNFBHuUqkfk5P5tQyuHiB7xifQvmojeMuQ=;
	b=ItqeHbI+GRbj3eHSk7v57wunACPQojKxsCDJTzlIKMrzNkxsdr1T62g/nz65YeakEebMDY
	E5Vsofuq9et42QNa/KWxgCIYEizqZZNdR7D1Do3AOoscL+tEpizKP5N+MmQyj59/UHTalg
	m9Q9rg1xJGZltuRNl9zju4xaQEmSC3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPjsfCQSviNFBHuUqkfk5P5tQyuHiB7xifQvmojeMuQ=;
	b=lIO2uYXKTWyWdv+ERVGq2fs1LKyuNHkzCTLZ5UbKiIBqlEb8Qt8jtmFNGkvBA3ujBAVCj2
	r7y6P8mz5pteo9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBB22132CB;
	Tue, 10 Sep 2024 08:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qG3GMrP832Y2MQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 10 Sep 2024 08:00:51 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 5/9] arch/powerpc: Teach book3s64 arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Tue, 10 Sep 2024 10:00:26 +0200
Message-ID: <20240910080030.1272373-6-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910080030.1272373-1-osalvador@suse.de>
References: <20240910080030.1272373-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLgqtx3dhxu3ne7bo4p8poxdrt)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area{_topdown}
to handle those.
Reshuffle file_to_psize() definition so arch_get_unmapped_area{_topdown}
can make use of it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/powerpc/mm/book3s64/slice.c | 40 ++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index 87307d0fc3b8..3a858f6b7270 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -633,6 +633,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 }
 EXPORT_SYMBOL_GPL(slice_get_unmapped_area);
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int file_to_psize(struct file *file)
+{
+	struct hstate *hstate = hstate_file(file);
+
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
@@ -640,11 +654,17 @@ unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long flags,
 				     vm_flags_t vm_flags)
 {
+	unsigned int psize;
+
 	if (radix_enabled())
 		return generic_get_unmapped_area(filp, addr, len, pgoff, flags, vm_flags);
 
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
@@ -654,11 +674,17 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 					     const unsigned long flags,
 					     vm_flags_t vm_flags)
 {
+	unsigned int psize;
+
 	if (radix_enabled())
 		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags, vm_flags);
 
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
@@ -789,12 +815,6 @@ unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
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
2.46.0


