Return-Path: <linux-kernel+bounces-322601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D79972B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FF8285244
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB293188003;
	Tue, 10 Sep 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQWHLDDd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+X/5hx72";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQWHLDDd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+X/5hx72"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0331862B3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955256; cv=none; b=dPfSKJ9xYtbu6Byv+gVoiYtuVTlSYrX+ZY+9tGKxhltDytvpgErfIRKAmLwUHQOGQpWY55p0IFK700GW5TI8KCZ/m2FNXy7r4XaWtBLkqb/kDtmmL0u2h8hqWng2YpM+63HnlTrAX+KjfFzMbPqJs4MrcD/hFq2EgXI1gZp4zUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955256; c=relaxed/simple;
	bh=VNHI6gtINqZ8KBQ6rJcl5wrE9sYAmdnM6oF9pW3kR88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCRuOEjJV8jc0Nqu0K2MMW4DCkGjnndUJe7gw93zBLsqhagH69cYYWELLxiyWgipZ9+G/olgBJqpYzxbj4v79jR/2BlQKkBjqepD1dbpI9eTWahuqiyWJkst5jUY7uBsAznRR+40iS2QMd8LRhIx3ztnDJ/S/T1EGiOhTMBmXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQWHLDDd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+X/5hx72; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQWHLDDd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+X/5hx72; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 729ED21A3D;
	Tue, 10 Sep 2024 08:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWMTJ6u3klMxfD86oEWdVkDNRrL55iQpRE7zIr7zbs=;
	b=oQWHLDDd4N1+3CUcsrROCuMC89cK1HbnGVB9kVwqYtvBbmMXlQx9qiB0lHS/mVjDOKpf/X
	S9O5ft5skcZ07Pcz8QjCCmtucnsz8rVewX0YYmVSObHmnzKfLIQzxCfL/av19cFEClCwuR
	Qpe6m2fQIGjR+yAxUQ+bfMnLCum21hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWMTJ6u3klMxfD86oEWdVkDNRrL55iQpRE7zIr7zbs=;
	b=+X/5hx72CiALe9ui2f+0GZ3F7RnD/snURiHFvuoI9YH+caDjjVkQNKm1MKRYH9YXbjIa0U
	r5m9jQOiF+AoGSDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWMTJ6u3klMxfD86oEWdVkDNRrL55iQpRE7zIr7zbs=;
	b=oQWHLDDd4N1+3CUcsrROCuMC89cK1HbnGVB9kVwqYtvBbmMXlQx9qiB0lHS/mVjDOKpf/X
	S9O5ft5skcZ07Pcz8QjCCmtucnsz8rVewX0YYmVSObHmnzKfLIQzxCfL/av19cFEClCwuR
	Qpe6m2fQIGjR+yAxUQ+bfMnLCum21hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWMTJ6u3klMxfD86oEWdVkDNRrL55iQpRE7zIr7zbs=;
	b=+X/5hx72CiALe9ui2f+0GZ3F7RnD/snURiHFvuoI9YH+caDjjVkQNKm1MKRYH9YXbjIa0U
	r5m9jQOiF+AoGSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B80F513A8F;
	Tue, 10 Sep 2024 08:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sBgDKrT832Y2MQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 10 Sep 2024 08:00:52 +0000
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
Subject: [PATCH v3 6/9] mm: Make hugetlb mappings go through mm_get_unmapped_area_vmflags
Date: Tue, 10 Sep 2024 10:00:27 +0200
Message-ID: <20240910080030.1272373-7-osalvador@suse.de>
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

Hugetlb mappings will no longer be special cased but rather go through
the generic mm_get_unmapped_area_vmflags function.
For that to happen, let us remove the .get_unmapped_area from
hugetlbfs_file_operations struct, and hint __get_unmapped_area
that it should not send hugetlb mappings through thp_get_unmapped_area_vmflags
but through mm_get_unmapped_area_vmflags.

Create also a function called hugetlb_mmap_check_and_align() where a
couple of safety checks are being done and the addr is aligned to
the huge page size.
Otherwise we will have to do this in every single function, which
duplicates quite a lot of code.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/hugetlbfs/inode.c    | 24 ++++++++++++++++--------
 include/linux/hugetlb.h |  9 ++++-----
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f6cff356796..978f5d62c5cf 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -258,15 +258,23 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 			pgoff, flags);
 }
 
-#ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-static unsigned long
-hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-			  unsigned long len, unsigned long pgoff,
-			  unsigned long flags)
+unsigned long
+__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+			    unsigned long len, unsigned long flags)
 {
-	return generic_hugetlb_get_unmapped_area(file, addr, len, pgoff, flags);
+	unsigned long addr0 = 0;
+	struct hstate *h = hstate_file(file);
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if ((flags & MAP_FIXED) && prepare_hugepage_range(file, addr, len))
+		return -EINVAL;
+	if (addr)
+		addr0 = ALIGN(addr, huge_page_size(h));
+
+	return mm_get_unmapped_area_vmflags(current->mm, file, addr, len, pgoff,
+					    flags, 0);
 }
-#endif
 
 /*
  * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
@@ -1300,7 +1308,7 @@ static const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
-	.get_unmapped_area	= hugetlb_get_unmapped_area,
+	.get_unmapped_area	= __hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
 	.fallocate		= hugetlbfs_fallocate,
 	.fop_flags		= FOP_HUGE_PAGES,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 368d552e4860..3a81b6126f62 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -546,11 +546,10 @@ static inline struct hstate *hstate_inode(struct inode *i)
 }
 #endif /* !CONFIG_HUGETLBFS */
 
-#ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-					unsigned long len, unsigned long pgoff,
-					unsigned long flags);
-#endif /* HAVE_ARCH_HUGETLB_UNMAPPED_AREA */
+unsigned long
+__generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+				    unsigned long len, unsigned long pgoff,
+				    unsigned long flags);
 
 unsigned long
 generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-- 
2.46.0


