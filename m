Return-Path: <linux-kernel+bounces-256285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DD934C16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742A428511F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0F13AD32;
	Thu, 18 Jul 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UnjJIEr7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NbhZQkeV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UnjJIEr7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NbhZQkeV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300D1386C6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300361; cv=none; b=U86L8+AvAmTkgCCZAlx7Mfc+JB3LBR24An12GCD0bDuRyaqjYShCKq1UEKkoWRuvxGNtObOIKp4UeLw/AVO6o0OAVK3x35hknUQrGQrdqy5dgCZBJcgpRVDuO5yo26+Jkj0Vyt7iQr5hnyQpA28ZKMP8Q+7oYe3Meej2ec5mHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300361; c=relaxed/simple;
	bh=uI1e0CW1oK4Lsb8je9yYlsQFRPWByODuxIKfmdPEvCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULsKx2CyYxfid++Nnmx1uR2nUbRwKrZffCDpbc8gTMgU+Um2yT/fq3uXUwrg+dXImUwQHyxEZQW5C+l7lPo/ryfCRHfYkC4sGNuW83Hzu06wd7ivPQyBxw7HlibZFdTB5o89FM9xzLggXhlStN8lHz1WWkmPKrY+SPLzEJTudIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UnjJIEr7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NbhZQkeV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UnjJIEr7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NbhZQkeV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA05D21AF6;
	Thu, 18 Jul 2024 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3eV4tzn99V5QCNtsrHXIAbjIOXiUl0vRGMsjIKRQw0=;
	b=UnjJIEr7+U+Yrn6jxxs3zgpZTb5TccLLns7pS78W/SYDCVTvs4A7gnL3OmtFUjvDi1S2wU
	lNxFD702yo/uvM2yCjGBBMeMjSk0NyaHmii5DSTOLypLmsSxCbVG6983rKJSa3ckiYTTvC
	0z7Kh0Lm2g4IgLHNZtfEMCAtXyxpfYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3eV4tzn99V5QCNtsrHXIAbjIOXiUl0vRGMsjIKRQw0=;
	b=NbhZQkeVeCNXG/5vzvKd+hQQ5SapWr4Znt38EgWYmc+HQiaV0WXSpR3JdMor0elYCnFmiy
	jXbfPE4afZn32cBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3eV4tzn99V5QCNtsrHXIAbjIOXiUl0vRGMsjIKRQw0=;
	b=UnjJIEr7+U+Yrn6jxxs3zgpZTb5TccLLns7pS78W/SYDCVTvs4A7gnL3OmtFUjvDi1S2wU
	lNxFD702yo/uvM2yCjGBBMeMjSk0NyaHmii5DSTOLypLmsSxCbVG6983rKJSa3ckiYTTvC
	0z7Kh0Lm2g4IgLHNZtfEMCAtXyxpfYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3eV4tzn99V5QCNtsrHXIAbjIOXiUl0vRGMsjIKRQw0=;
	b=NbhZQkeVeCNXG/5vzvKd+hQQ5SapWr4Znt38EgWYmc+HQiaV0WXSpR3JdMor0elYCnFmiy
	jXbfPE4afZn32cBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5364137EB;
	Thu, 18 Jul 2024 10:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEFJL4T1mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:16 +0000
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
Subject: [PATCH 4/9] arch/sparc: Teach arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Thu, 18 Jul 2024 12:58:58 +0200
Message-ID: <20240718105903.19617-5-osalvador@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area{_topdown}
to handle those.
sparc specific hugetlb function does not set info.align_offset, and
does not care about adjusting the align_mask for MAP_SHARED cases,
so the same here for compability.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/sparc/kernel/sys_sparc_32.c | 16 ++++++++++----
 arch/sparc/kernel/sys_sparc_64.c | 36 +++++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 08a19727795c..fc33ac48ed28 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -42,12 +42,16 @@ SYSCALL_DEFINE0(getpagesize)
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_unmapped_area_info info = {};
+	bool file_hugepage = false;
+
+	if (filp && is_file_hugepages(filp))
+		file_hugepage = true;
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
 		 */
-		if ((flags & MAP_SHARED) &&
+		if (!file_hugepage && (flags & MAP_SHARED) &&
 		    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
 			return -EINVAL;
 		return addr;
@@ -62,9 +66,13 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	info.length = len;
 	info.low_limit = addr;
 	info.high_limit = TASK_SIZE;
-	info.align_mask = (flags & MAP_SHARED) ?
-		(PAGE_MASK & (SHMLBA - 1)) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
+	if (!file_hugepage) {
+		info.align_mask = (flags & MAP_SHARED) ?
+			(PAGE_MASK & (SHMLBA - 1)) : 0;
+		info.align_offset = pgoff << PAGE_SHIFT;
+	} else {
+		info.align_mask = huge_page_mask_align(filp);
+	}
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index d9c3b34ca744..81d8f5467dd8 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -87,6 +87,16 @@ static inline unsigned long COLOR_ALIGN(unsigned long addr,
 	return base + off;
 }
 
+static unsigned long get_align_mask(struct file *filp, unsigned long flags)
+{
+	if (filp && is_file_hugepages(filp))
+		return huge_page_mask_align(filp);
+	if (filp || (flags & MAP_SHARED))
+		return PAGE_MASK & (SHMLBA - 1);
+
+	return 0;
+}
+
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
@@ -94,12 +104,16 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	unsigned long task_size = TASK_SIZE;
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
+	bool file_hugepage = false;
+
+	if (filp && is_file_hugepages(filp))
+		file_hugepage = true;
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
 		 */
-		if ((flags & MAP_SHARED) &&
+		if (!file_hugepage && (flags & MAP_SHARED) &&
 		    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
 			return -EINVAL;
 		return addr;
@@ -111,7 +125,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 		return -ENOMEM;
 
 	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
+	if ((filp || (flags & MAP_SHARED)) && !file_hugepage)
 		do_color_align = 1;
 
 	if (addr) {
@@ -129,8 +143,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
-	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
+	info.align_mask = get_align_mask(filp, flags);
+	if (!file_hugepage)
+		info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
 	if ((addr & ~PAGE_MASK) && task_size > VA_EXCLUDE_END) {
@@ -154,15 +169,19 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long addr = addr0;
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
+	bool file_hugepage = false
 
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
 
+	if (filp && is_file_hugepages(filp))
+		file_hugepage = true;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
 		 */
-		if ((flags & MAP_SHARED) &&
+		if (!file_hugepage && (flags & MAP_SHARED) &&
 		    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
 			return -EINVAL;
 		return addr;
@@ -172,7 +191,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		return -ENOMEM;
 
 	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
+	if ((filp || (flags & MAP_SHARED)) && !file_hugepage)
 		do_color_align = 1;
 
 	/* requesting a specific address */
@@ -192,8 +211,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
-	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
+	info.align_mask = get_align_mask(filp, flags);
+	if (!file_hugepage)
+		info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.45.2


