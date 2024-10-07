Return-Path: <linux-kernel+bounces-352948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C199266A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75661C21F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988AA18E04E;
	Mon,  7 Oct 2024 07:51:00 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09918CC17
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287460; cv=none; b=R89+GirkE/pq2+GLQZyrhH3MWA8aiqU4+tvniAGhR7MYj3cqAWLvrYRMOiiX3vjOPkkrBsCBW4Q5dyS5KlXD5ixaCqZbKeSa0g0rQWeF3x7EvzZGPQDZxqhJ4hTmb1RJ18ubonZS3sCv4NaogxA3iBY7KiCnhRqtJkVKpS0R8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287460; c=relaxed/simple;
	bh=twTHEFWL4O8LTfpTRNUTDbAKVndAW03EJ0W3m8j6LVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXA7zoGlzNjkyuPIxOM8QrcMz+fgWpLZjccq9HYK1RCwZkOzn82BsCkWvJZwwVePU3jfActTfAds1uH1ebwmxaDUqaXKuOFS7ZmtSTfaJ2RX3GhR4bVKhgWoKK1GZJu02Nt5CvNMraeRYX/elzpkMdnTAb/4ylh7DHX0tcxhr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE63E1FD18;
	Mon,  7 Oct 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB9AC13A55;
	Mon,  7 Oct 2024 07:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oMimNt6SA2d6cQAAD6G6ig
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
Subject: [PATCH v4 6/9] mm: Make hugetlb mappings go through mm_get_unmapped_area_vmflags
Date: Mon,  7 Oct 2024 09:50:34 +0200
Message-ID: <20241007075037.267650-7-osalvador@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AE63E1FD18
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

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
index 5cf327337e22..2c5f34e315d2 100644
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
2.46.1


