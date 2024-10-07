Return-Path: <linux-kernel+bounces-352947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF9992668
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF1B1C20905
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512218DF7A;
	Mon,  7 Oct 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jjDvyrXZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Is+1Jb6y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jjDvyrXZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Is+1Jb6y"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF818C915
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287458; cv=none; b=QBum5pUcg0roPj/HNPAuds0CsDN9SPq2zKrmpeDTQaO+36Cbb/e+bEwiopLSpTNKhqHDkhISNPRlUxHqPhpJlA+Eocrs/vjE3+rvkIYM9pus2i/jgPpFb69KIUs7lXMI3rLS7UQoVOvpfJjyMRUXVHGp7uiPgVJxUTCXH9SQpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287458; c=relaxed/simple;
	bh=ugFwNQu8pkMdP1/lGatWN+zP4/mqxdaj1MqW9vclcdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jj0JgHXFu9QmJGcdOpJSZkGs+0NpBhkITQjmcwp3cAb8p9LwBonxRh8NCvNKlXM+IeVNCGdwTyvrCRZAr37bScYMd353qlpjPK8b2IkExwiQjEfs3H54Puig28NmXdRK4V+EQO5vms/kq2i0I7JL/Bll3uSc0NaPGORnAq7oTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jjDvyrXZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Is+1Jb6y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jjDvyrXZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Is+1Jb6y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D800621F3D;
	Mon,  7 Oct 2024 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728287454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PljpHijC2le6TjcuL38vbgVuWWQAUhtZMhhfqH3Mudw=;
	b=jjDvyrXZLGwRxc+rhEwW0WySw7JheFddYHFILlj3PfC7Y/9i690Lm64tsU5bBkQ46gwGVH
	/dsv1MVTizOb3LlOBcyDKQfcHu4kRD5rDT1/yl/yAbB4QU3WlxbCQ6IFYE+W+S2H6FosTw
	/JlR9d4fwEU/BV0lM0sI/ruESP2H/HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728287454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PljpHijC2le6TjcuL38vbgVuWWQAUhtZMhhfqH3Mudw=;
	b=Is+1Jb6y0qzHi/vp/JmfqJaQQVmgHUXIKRdJY8ZWMyL7a/Axz1IY3IbojyAKX1mGQF0rb1
	Q0cv/yTKNl4NPgAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728287454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PljpHijC2le6TjcuL38vbgVuWWQAUhtZMhhfqH3Mudw=;
	b=jjDvyrXZLGwRxc+rhEwW0WySw7JheFddYHFILlj3PfC7Y/9i690Lm64tsU5bBkQ46gwGVH
	/dsv1MVTizOb3LlOBcyDKQfcHu4kRD5rDT1/yl/yAbB4QU3WlxbCQ6IFYE+W+S2H6FosTw
	/JlR9d4fwEU/BV0lM0sI/ruESP2H/HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728287454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PljpHijC2le6TjcuL38vbgVuWWQAUhtZMhhfqH3Mudw=;
	b=Is+1Jb6y0qzHi/vp/JmfqJaQQVmgHUXIKRdJY8ZWMyL7a/Axz1IY3IbojyAKX1mGQF0rb1
	Q0cv/yTKNl4NPgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 380B0132BD;
	Mon,  7 Oct 2024 07:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GJDPCt6SA2d6cQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 07 Oct 2024 07:50:54 +0000
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
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 5/9] arch/powerpc: Teach book3s64 arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Mon,  7 Oct 2024 09:50:33 +0200
Message-ID: <20241007075037.267650-6-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007075037.267650-1-osalvador@suse.de>
References: <20241007075037.267650-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLgqtx3dhxu3ne7bo4p8poxdrt)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

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
2.46.1


