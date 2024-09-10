Return-Path: <linux-kernel+bounces-322598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D8D972B59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB8D1F2559B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23097186284;
	Tue, 10 Sep 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1BAI1Uzw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B1CHF1FU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1BAI1Uzw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B1CHF1FU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC40566A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955254; cv=none; b=jwxkVsRFIa3RFcDtVNwvEvddFQ8olgRhS9ua39FvBNGmWRdVt8OqtOoAoFD58xSWqsDhlG/5rAnr2flGbLR+OQswXfYdsWn+3HEK5iM+dlcKyJVM7AbkEN/2yAytJoZJxVNbo6W9H7+v2cy5WjBK8ar4SUsq0w7lX3ZybenBeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955254; c=relaxed/simple;
	bh=o+ngPJR/WTqap1k53gNnSK7reZMLey1PyYgL/WO6GlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS4Lbj8zbWjgNSaXkt7UdZUESsjvb927rudDoxteVxVOdFDEO9FCf6SD4bKykZBR5cOaJaIKDUadws06hLLfSogqMRZpH97U2Gkxl8OOvzufy1WZKUhGWOLnr+wk5kydRgN7k3YkVb91A01hxAmQBdX02XdGf9tEXWwv7u2vL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1BAI1Uzw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B1CHF1FU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1BAI1Uzw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B1CHF1FU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03C4121A3A;
	Tue, 10 Sep 2024 08:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECz/ucTq55vu26EzU15Ueg1Bt6OrgMPODU+khQ9gIJU=;
	b=1BAI1UzwrJylDZdLs/tm23hsXSNM5Pt2JIUkgso7a+VmLemiWBz3yEbcqqCjmU/l4M2mCa
	RSou/oYGMbVAzURx2UqKdVYcTr6qpy84LMLQkwFTSfgbkpQaGa4htSr58WTCtPR/zJaWwx
	T4latjkh4xbhguWuW94bmXKU3ANXEqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECz/ucTq55vu26EzU15Ueg1Bt6OrgMPODU+khQ9gIJU=;
	b=B1CHF1FUCQgjAfBzphbfQXEqo50g2GfTlJhOUhGMVk2VrghOqDRTTokchbnS+RjmdkotaF
	MXaiHDXJymZZlVAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECz/ucTq55vu26EzU15Ueg1Bt6OrgMPODU+khQ9gIJU=;
	b=1BAI1UzwrJylDZdLs/tm23hsXSNM5Pt2JIUkgso7a+VmLemiWBz3yEbcqqCjmU/l4M2mCa
	RSou/oYGMbVAzURx2UqKdVYcTr6qpy84LMLQkwFTSfgbkpQaGa4htSr58WTCtPR/zJaWwx
	T4latjkh4xbhguWuW94bmXKU3ANXEqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECz/ucTq55vu26EzU15Ueg1Bt6OrgMPODU+khQ9gIJU=;
	b=B1CHF1FUCQgjAfBzphbfQXEqo50g2GfTlJhOUhGMVk2VrghOqDRTTokchbnS+RjmdkotaF
	MXaiHDXJymZZlVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49157132CB;
	Tue, 10 Sep 2024 08:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KG3tDrL832Y2MQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 10 Sep 2024 08:00:50 +0000
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
Subject: [PATCH v3 3/9] arch/x86: Teach arch_get_unmapped_area_vmflags to handle hugetlb mappings
Date: Tue, 10 Sep 2024 10:00:24 +0200
Message-ID: <20240910080030.1272373-4-osalvador@suse.de>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area_{topdown_}vmflags
to handle those.
x86 specific hugetlb function does not set either info.start_gap or
info.align_offset so the same here for compatibility.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/kernel/sys_x86_64.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 87f8c9a71c49..776ae6fa7f2d 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -18,6 +18,7 @@
 #include <linux/random.h>
 #include <linux/uaccess.h>
 #include <linux/elf.h>
+#include <linux/hugetlb.h>
 
 #include <asm/elf.h>
 #include <asm/ia32.h>
@@ -25,8 +26,10 @@
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
  */
-static unsigned long get_align_mask(void)
+static unsigned long get_align_mask(struct file *filp)
 {
+	if (filp && is_file_hugepages(filp))
+		return huge_page_mask_align(filp);
 	/* handle 32- and 64-bit case with a single conditional */
 	if (va_align.flags < 0 || !(va_align.flags & (2 - mmap_is_ia32())))
 		return 0;
@@ -49,7 +52,7 @@ static unsigned long get_align_mask(void)
  */
 static unsigned long get_align_bits(void)
 {
-	return va_align.bits & get_align_mask();
+	return va_align.bits & get_align_mask(NULL);
 }
 
 static int __init control_va_addr_alignment(char *str)
@@ -148,12 +151,15 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len,
 	info.length = len;
 	info.low_limit = begin;
 	info.high_limit = end;
-	info.align_offset = pgoff << PAGE_SHIFT;
-	info.start_gap = stack_guard_placement(vm_flags);
+	if (!(filp && is_file_hugepages(filp))) {
+		info.align_offset = pgoff << PAGE_SHIFT;
+		info.start_gap = stack_guard_placement(vm_flags);
+	}
 	if (filp) {
-		info.align_mask = get_align_mask();
+		info.align_mask = get_align_mask(filp);
 		info.align_offset += get_align_bits();
 	}
+
 	return vm_unmapped_area(&info);
 }
 
@@ -199,7 +205,10 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr0,
 		info.low_limit = PAGE_SIZE;
 
 	info.high_limit = get_mmap_base(0);
-	info.start_gap = stack_guard_placement(vm_flags);
+	if (!(filp && is_file_hugepages(filp))) {
+		info.start_gap = stack_guard_placement(vm_flags);
+		info.align_offset = pgoff << PAGE_SHIFT;
+	}
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
@@ -211,9 +220,8 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr0,
 	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
-	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {
-		info.align_mask = get_align_mask();
+		info.align_mask = get_align_mask(filp);
 		info.align_offset += get_align_bits();
 	}
 	addr = vm_unmapped_area(&info);
-- 
2.46.0


