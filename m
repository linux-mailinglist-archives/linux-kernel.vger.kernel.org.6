Return-Path: <linux-kernel+bounces-260503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08293AA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A8F1F2395B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABED5234;
	Wed, 24 Jul 2024 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QiOQ2lw3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69ECDDA0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783167; cv=none; b=dEwGsGSiR7ZEKRoIMwVVAGiAr4At7JXP4jY6SccJufSrWQh5DHxRDJcM7v5UaJz8E5MxmGdUAuoXCvx3yKqPc46j97Wm7RXtOEr8W6KvSFZVkkqhc31MetjHBhjY6SlYOBlogFsHRHpBjgRWiji3gBZkj+/nlRHbPxo5naHP2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783167; c=relaxed/simple;
	bh=psUIz3oVZMx1qwQEFAiBplG9CcQKs4s9Itq16i67tAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giXllvU4TanSgF3KbFfQ6WeVvDLXYMpQn/sQ8S8xuMyc6s8VSf6yXwHevPJ1/30dDQzDn2oC7DVP7XfM2L/wYZthmiv4F4VL7JxhETIKJT1V7idPMYhKk/0mR7XueQdn8s4CrTPzNVRcnCHoMwXB8hvFP81oEvubxm1C5bjgAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QiOQ2lw3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=y98KBMGmUe2J2iqnZ771EKPXLObJQtefLUww85ZIvzI=; b=QiOQ2lw31tG6W157GXdGaIw6xs
	pDfIkgyYS9dEB9cL504E+dGBIPHOVam6KHS62m4c62UOXkg4HcTYnZLcWshnenzJAEreM3HDHq6DS
	lN/UH1pW0LmG0zsQqURu6dFDhVfPGz80ti39GxZTNszvk2Nw4I1GQxQPYS192IYkzH/WZQZKyt4vX
	pqv8U0MqbEWyfeLIyl5AGtHgnnnZ+ApouJQY/5R78w8Ngq3+KZBHFfWlKmVjgSGKxaEoZzOX6b7Oq
	Fca/bc3x8XL4EOjIhoXn3xgWZ6RrISkhHP+YBQDlJtwGDkCunMeGV6pK2gsnN9afcOiOycLNBlrod
	LJTranlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWQS2-00000007MpE-21p9;
	Wed, 24 Jul 2024 01:05:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] fs: Remove calls to set and clear the folio error flag
Date: Wed, 24 Jul 2024 02:05:46 +0100
Message-ID: <20240724010550.1755992-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724010550.1755992-1-willy@infradead.org>
References: <20240724010550.1755992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the folio error flag any more, so we can stop setting
and clearing it.  Also remove the documentation suggesting to not
bother setting the error bit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/vfs.rst | 3 +--
 mm/filemap.c                      | 8 --------
 mm/migrate.c                      | 2 --
 mm/page_io.c                      | 4 +---
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 6e903a903f8f..a6022ec59a2d 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -913,8 +913,7 @@ cache in your filesystem.  The following members are defined:
 	stop attempting I/O, it can simply return.  The caller will
 	remove the remaining pages from the address space, unlock them
 	and decrement the page refcount.  Set PageUptodate if the I/O
-	completes successfully.  Setting PageError on any page will be
-	ignored; simply unlock the page if an I/O error occurs.
+	completes successfully.
 
 ``write_begin``
 	Called by the generic buffered write code to ask the filesystem
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..c7bef2247a68 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -530,7 +530,6 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 			struct folio *folio = fbatch.folios[i];
 
 			folio_wait_writeback(folio);
-			folio_clear_error(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -2342,13 +2341,6 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 	unsigned long pflags;
 	int error;
 
-	/*
-	 * A previous I/O error may have been due to temporary failures,
-	 * eg. multipath errors.  PG_error will be set again if read_folio
-	 * fails.
-	 */
-	folio_clear_error(folio);
-
 	/* Start the actual read. The read will unlock the page. */
 	if (unlikely(workingset))
 		psi_memstall_enter(&pflags);
diff --git a/mm/migrate.c b/mm/migrate.c
index e7296c0fb5d5..e4431c157bc9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -585,8 +585,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 {
 	int cpupid;
 
-	if (folio_test_error(folio))
-		folio_set_error(newfolio);
 	if (folio_test_referenced(folio))
 		folio_set_referenced(newfolio);
 	if (folio_test_uptodate(folio))
diff --git a/mm/page_io.c b/mm/page_io.c
index ff8c99ee3af7..9d4edf8bc422 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -273,9 +273,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		 * memory for allocating transmit buffers.
 		 * Mark the page dirty and avoid
 		 * folio_rotate_reclaimable but rate-limit the
-		 * messages but do not flag PageError like
-		 * the normal direct-to-bio case as it could
-		 * be temporary.
+		 * messages.
 		 */
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
 				   ret, swap_dev_pos(page_swap_entry(page)));
-- 
2.43.0


