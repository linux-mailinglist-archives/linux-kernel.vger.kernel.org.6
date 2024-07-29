Return-Path: <linux-kernel+bounces-265401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552FE93F0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C60284902
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE04D143734;
	Mon, 29 Jul 2024 09:10:43 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B014263B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244243; cv=none; b=mc5QRPfjsbSp8+7s2I9S68hbQdDfsS74+VOBCHv9dwz8ttKrrbCZYNPvxNrXkSAAl+JX8OCI4v7rEv3C0UPS2YZXUMKEc5xWIXQcnn+9Ch2maTk1wx/tz6EwmMZSA8WeNlNGDCa7KyNbmkhv14CEtY7oJHroLIM39Fd0JDvjOfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244243; c=relaxed/simple;
	bh=Bu39IAoeotpZQS+JPqNZI0U0fNYKWTYVrHQJZ/FZuEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnPODeUYVERd7ho4oxhFvD020NyUcC9Kdn2m0om2cLjsZsrC8vlScv81tXyDvn4tkb4VCinnFt5xuD8wACqkCXD1YxSShBv7y+qWZQMPuCm+C/v/cbJyQYoUdOQs013tx/MiLWMIarpemwhPdtO/89adL6vV7DYMW4ouiof4O/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE10A1F78C;
	Mon, 29 Jul 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D0651368A;
	Mon, 29 Jul 2024 09:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mLXnH45cp2Z4BgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 09:10:38 +0000
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
Subject: [PATCH v2 5/9] arch/powerpc: Teach book3s64 arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Mon, 29 Jul 2024 11:10:14 +0200
Message-ID: <20240729091018.2152-6-osalvador@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DE10A1F78C
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

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


