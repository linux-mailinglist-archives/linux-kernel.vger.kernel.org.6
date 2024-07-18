Return-Path: <linux-kernel+bounces-256283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3201A934C14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B222D1F2250B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB18139566;
	Thu, 18 Jul 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RCEaPyHR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CDuhEnaY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RCEaPyHR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CDuhEnaY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB651304AD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300359; cv=none; b=kdEAiBtXABH60dc0JIbpjHzukFGCAiCZtj0ueeMFuszrOWn6+2ynrian7+3ihSrEGkgl4c8hw1UV5fI8axyX54/dn+lwfHsg59QiNpgfgnCHplmqb4FEqaJGazMXUsIc49GTYA8NJ9eIl3aL5+qa5rTzEMXrDY8PTy7gBsltBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300359; c=relaxed/simple;
	bh=AERzkuQp3e5SCpyMgzurTrxd9C+NDArafi+fcQnPWHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzFa6FrRPG4mNXCahaVh5o5q8z9QP6Qm8u6ShYpqaLdyR+iHXP7IKBTNd7ZqzzofRRJJn2okYqwCFjk5t9yfTQzaYF0JyIH4hiyZI1CcnCZV1PCOUb884VghVOIdonNnCQr2Web2kOtMLb9jHAXruqqunhkC5yFsJPi4FKt1sTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RCEaPyHR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CDuhEnaY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RCEaPyHR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CDuhEnaY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95F9D21AD8;
	Thu, 18 Jul 2024 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YtBEq+futfpDK6VnLTGAsLUUeg4b//ccUCfgdjh03Q=;
	b=RCEaPyHRDPlkfDCvQ819eOOfEcQ+0vrYU9ule7hx6xQDWOaYKbsDWj91KHSrZBm7Wa2ZXA
	2sBeiZo8RXWvY2KC7S4RFP1na2xHi76mIPDQZXi8H1waAaTvryQGy/U2nNHYxzKcY6m1LJ
	GvGpWCJmuek9+pIN3/WXYVxlDw31Xxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YtBEq+futfpDK6VnLTGAsLUUeg4b//ccUCfgdjh03Q=;
	b=CDuhEnaYXEELncVh53GTkwlfSqTOIGXNHABa1+qHjSgFOe/UogyIgh9YcMFJ7OOOCdr6In
	3SislPYiilqx9GAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YtBEq+futfpDK6VnLTGAsLUUeg4b//ccUCfgdjh03Q=;
	b=RCEaPyHRDPlkfDCvQ819eOOfEcQ+0vrYU9ule7hx6xQDWOaYKbsDWj91KHSrZBm7Wa2ZXA
	2sBeiZo8RXWvY2KC7S4RFP1na2xHi76mIPDQZXi8H1waAaTvryQGy/U2nNHYxzKcY6m1LJ
	GvGpWCJmuek9+pIN3/WXYVxlDw31Xxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YtBEq+futfpDK6VnLTGAsLUUeg4b//ccUCfgdjh03Q=;
	b=CDuhEnaYXEELncVh53GTkwlfSqTOIGXNHABa1+qHjSgFOe/UogyIgh9YcMFJ7OOOCdr6In
	3SislPYiilqx9GAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97C4E136F7;
	Thu, 18 Jul 2024 10:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eCHDIIL1mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:14 +0000
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
Subject: [PATCH 2/9] arch/s390: Teach arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Thu, 18 Jul 2024 12:58:56 +0200
Message-ID: <20240718105903.19617-3-osalvador@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area{_topdown}
to handle those.
s390 specific hugetlb function does not set info.align_offset, so do
the same here for compability.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/s390/mm/mmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 206756946589..408b5a541a28 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -17,6 +17,7 @@
 #include <linux/random.h>
 #include <linux/compat.h>
 #include <linux/security.h>
+#include <linux/hugetlb.h>
 #include <asm/elf.h>
 
 static unsigned long stack_maxrandom_size(void)
@@ -73,6 +74,8 @@ static inline unsigned long mmap_base(unsigned long rnd,
 
 static int get_align_mask(struct file *filp, unsigned long flags)
 {
+	if (filp && is_file_hugepages(filp))
+		return huge_page_mask_align(filp);
 	if (!(current->flags & PF_RANDOMIZE))
 		return 0;
 	if (filp || (flags & MAP_SHARED))
@@ -106,7 +109,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	info.align_mask = get_align_mask(filp, flags);
-	info.align_offset = pgoff << PAGE_SHIFT;
+	if (!(filp && is_file_hugepages(filp)))
+		info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 	if (offset_in_page(addr))
 		return addr;
@@ -144,7 +148,8 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	info.align_mask = get_align_mask(filp, flags);
-	info.align_offset = pgoff << PAGE_SHIFT;
+	if (!(filp && is_file_hugepages(filp)))
+		info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.45.2


