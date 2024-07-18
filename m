Return-Path: <linux-kernel+bounces-256284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A5934C15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAE5B22E07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406313AA40;
	Thu, 18 Jul 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ROL3Btep";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oRwpoIhB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ROL3Btep";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oRwpoIhB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F421369AA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300361; cv=none; b=NGdSPGDkSv+vCKmxFMJQX4lGk+U4XW5Nksi8qvxBuzD4nGLUFRX3XRWRpd2emm+tbZ7Dn01VOoB4v2TndCSdwmUm1ww+9FUnh2wplexipT/zTtavuYhCYkbFMG5AipeVoc2iPjMfnZeQRUABLzmwQ6qCGbe1HH65ME8W6A6Ge1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300361; c=relaxed/simple;
	bh=5dRtDVzsIJNwCqB6oj8Jh4GgA81UiKGy4ufBtCMkz4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeG7nCHSEK7eIiorQerqGangrd/mqymlBy7E8HUKj8cIBDRoHESWHcG//PVqHqC59w7EByQHIhFgrJaJV9PmdNCJo6kauFCgXM/2Xj5ZLZhxqaplhT+IUmWrCGEhtCabQjuMsUXz7egyONpvTNhkUMDFUUjs5sgXIeespGDth3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ROL3Btep; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oRwpoIhB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ROL3Btep; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oRwpoIhB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2CC421AF5;
	Thu, 18 Jul 2024 10:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHN99Otp08yvKHunYIWd3zL4cHzZBNMKDmIpLbdX684=;
	b=ROL3BtepMH8hvdTP7yikKJC2Bjb9wtA9aU5ZNrKsCn3UdiH8tgTp7mWjKfzyR6YHaSdep2
	G6hKQv7Z3pspF9/Z4RwVT8ZFhDH4P4+nr6cMUcLDjDjxYck1Kpk2zlruoAW4hpns58FdEh
	d3+2822x2EWq255lyXMNp4Gmi3DFQKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHN99Otp08yvKHunYIWd3zL4cHzZBNMKDmIpLbdX684=;
	b=oRwpoIhBYuLkTUNMIPtBuktOIT1rvbaVJ65aKpRzjqSSeEiTSL+RUohgMBZlb86A1noTlR
	tBdC3gAq5HtrS/Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ROL3Btep;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oRwpoIhB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHN99Otp08yvKHunYIWd3zL4cHzZBNMKDmIpLbdX684=;
	b=ROL3BtepMH8hvdTP7yikKJC2Bjb9wtA9aU5ZNrKsCn3UdiH8tgTp7mWjKfzyR6YHaSdep2
	G6hKQv7Z3pspF9/Z4RwVT8ZFhDH4P4+nr6cMUcLDjDjxYck1Kpk2zlruoAW4hpns58FdEh
	d3+2822x2EWq255lyXMNp4Gmi3DFQKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHN99Otp08yvKHunYIWd3zL4cHzZBNMKDmIpLbdX684=;
	b=oRwpoIhBYuLkTUNMIPtBuktOIT1rvbaVJ65aKpRzjqSSeEiTSL+RUohgMBZlb86A1noTlR
	tBdC3gAq5HtrS/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCF64136F7;
	Thu, 18 Jul 2024 10:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8AwlKYP1mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:15 +0000
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
Subject: [PATCH 3/9] arch/x86: Teach arch_get_unmapped_area_vmflags to handle hugetlb mappings
Date: Thu, 18 Jul 2024 12:58:57 +0200
Message-ID: <20240718105903.19617-4-osalvador@suse.de>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: B2CC421AF5

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area_{topdown_}vmflags
to handle those.
x86 specific hugetlb function does not set either info.start_gap or
info.align_offset so the same here for compability.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/kernel/sys_x86_64.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 01d7cd85ef97..aa7491f036a7 100644
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
@@ -148,12 +151,15 @@ arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned l
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
 
@@ -199,7 +205,10 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 		info.low_limit = PAGE_SIZE;
 
 	info.high_limit = get_mmap_base(0);
-	info.start_gap = stack_guard_placement(vm_flags);
+	if (!(filp && is_file_hugepages(filp))) {
+		info.start_gap = stack_guard_placement(vm_flags);
+		info.align_offset = pgoff << PAGE_SHIFT;
+	}
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
@@ -211,9 +220,8 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
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
2.45.2


