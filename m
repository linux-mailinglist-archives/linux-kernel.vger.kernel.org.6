Return-Path: <linux-kernel+bounces-265400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A093F0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5D31F22B36
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246F142E78;
	Mon, 29 Jul 2024 09:10:42 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C065140E4D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244242; cv=none; b=iWDXgvpQ/Al2pI7GZ1D8x8e7ha2X2Aha6e38mTBFm+dZIE28//n46Fjsk5G2tvx75in5uW851mtOP6DRTq7hb+9SzFefuEhHgzWk9t1WhCYygcRgBfUW5mBIicB9rNWm5qwUzpTIylkusnPQ8/aWG8+TNsXJet2jq6J7t/GbdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244242; c=relaxed/simple;
	bh=L1oKUyjsAVGXwC24SmgHA/uYJlgt2ah8LbkXOJx7Z3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZtmQWELyFu99Aa5iT+XfzD7XY6LKclLnO2XY12wFHOOWMv5g+82dR50ljWWipv7YIm/iIV7/p6FNoy2p5sFOxynum7SLwXndU1gag4lBWa482X8IysTn9gJtMjKTAH39sTX0WcnDpNDlhfV60aPxj+sG9UW7X98YKTf5KZdI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 70CFD21BCC;
	Mon, 29 Jul 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03FE91368A;
	Mon, 29 Jul 2024 09:10:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IHMSN4xcp2Z4BgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 09:10:36 +0000
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
Subject: [PATCH v2 4/9] arch/sparc: Teach arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Mon, 29 Jul 2024 11:10:13 +0200
Message-ID: <20240729091018.2152-5-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 70CFD21BCC
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
sparc specific hugetlb function does not set info.align_offset, and
does not care about adjusting the align_mask for MAP_SHARED cases,
so the same here for compability.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/sparc/kernel/sys_sparc_32.c | 17 +++++++++++----
 arch/sparc/kernel/sys_sparc_64.c | 37 +++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 08a19727795c..852b340a7f9b 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -23,6 +23,7 @@
 #include <linux/utsname.h>
 #include <linux/smp.h>
 #include <linux/ipc.h>
+#include <linux/hugetlb.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -42,12 +43,16 @@ SYSCALL_DEFINE0(getpagesize)
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
@@ -62,9 +67,13 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
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
index d9c3b34ca744..1b271db41542 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -30,6 +30,7 @@
 #include <linux/context_tracking.h>
 #include <linux/timex.h>
 #include <linux/uaccess.h>
+#include <linux/hugetlb.h>
 
 #include <asm/utrap.h>
 #include <asm/unistd.h>
@@ -87,6 +88,16 @@ static inline unsigned long COLOR_ALIGN(unsigned long addr,
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
@@ -94,12 +105,16 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
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
@@ -111,7 +126,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 		return -ENOMEM;
 
 	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
+	if ((filp || (flags & MAP_SHARED)) && !file_hugepage)
 		do_color_align = 1;
 
 	if (addr) {
@@ -129,8 +144,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
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
@@ -154,15 +170,19 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long addr = addr0;
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
+	bool file_hugepage = false;
 
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
@@ -172,7 +192,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		return -ENOMEM;
 
 	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
+	if ((filp || (flags & MAP_SHARED)) && !file_hugepage)
 		do_color_align = 1;
 
 	/* requesting a specific address */
@@ -192,8 +212,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
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


