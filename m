Return-Path: <linux-kernel+bounces-259702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E69939BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DF52817CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDE14B09E;
	Tue, 23 Jul 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hmQ2nsNS"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23514B955
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719839; cv=none; b=a2eFY/7b7WQlvu986cQrZcsc1dsjhmIGsSSkB4EFY6mKIMmgKgjFO1cClC0GVrI/vSkU7xAfNN+Byr9NC6I4EnTTw74nCiCeE7cxERqYHIXjN7ZmsMLyR+8mt/AQCekuoVfZHLA0zaA+NK+2wfIbwYdflAWY+WTtjpDAkRhgRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719839; c=relaxed/simple;
	bh=nvSFnngJcnqUd+30pC/RLAb/QSaKqPUw2V0n+PfR/Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjUIbXuLqQHXQdLF1Ok7GU0Wcswb2/obByfzMcl79PJ3tvUF+6E8LJVwJPMXFRX7RUM9oijr/K+GE35USDR+vdyr9PDMqC4hQ+ycZ9i63UfcDwi6NuN8UChoGlYiqkgAtlFJI4EnCXHfRfSY9Vv7kF+s0+sNCSRZBFMfJWIJvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hmQ2nsNS; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721719829; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HB1dyrSyOC/tIOSBfm9aosUYtjucq0jEOTKIvfimrw0=;
	b=hmQ2nsNSHjMnPpqyzFgFDHiM+YBVPr8vCZw3PIsxnNfI01pv/7c13qQRLImUMcT+vhsqGp2nX0/z/PDg1TYElqYCQzmVxnCIZ6T2yolvt+Jm38Sa0xFM9wqvQ+B0fm8Sxcbg4qSCbzdiuLtIWhsGrcx4cnF3d0W4Bt43SqQjRkA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WB8jQxT_1721719825;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WB8jQxT_1721719825)
          by smtp.aliyun-inc.com;
          Tue, 23 Jul 2024 15:30:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] erofs: support multi-page folios for erofs_bread()
Date: Tue, 23 Jul 2024 15:30:24 +0800
Message-ID: <20240723073024.875290-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the requested page is part of the previous multi-page folio, there
is no need to call read_mapping_folio() again.

Also, get rid of the remaining one of page->index [1] in our codebase.

[1] https://lore.kernel.org/r/Zp8fgUSIBGQ1TN0D@casper.infradead.org
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
(I plan to test now and take this for this cycle since this patch is
 not quite complex.)

 fs/erofs/data.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8be60797ea2f..4b8b2b004453 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -21,38 +21,33 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 	if (!buf->page)
 		return;
 	erofs_unmap_metabuf(buf);
-	put_page(buf->page);
+	folio_put(page_folio(buf->page));
 	buf->page = NULL;
 }
 
-/*
- * Derive the block size from inode->i_blkbits to make compatible with
- * anonymous inode in fscache mode.
- */
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 		  enum erofs_kmap_type type)
 {
 	pgoff_t index = offset >> PAGE_SHIFT;
-	struct page *page = buf->page;
-	struct folio *folio;
-	unsigned int nofs_flag;
+	struct folio *folio = NULL;
 
-	if (!page || page->index != index) {
+	if (buf->page) {
+		folio = page_folio(buf->page);
+		if (folio_file_page(folio, index) != buf->page)
+			erofs_unmap_metabuf(buf);
+	}
+	if (!folio || !folio_contains(folio, index)) {
 		erofs_put_metabuf(buf);
 
-		nofs_flag = memalloc_nofs_save();
-		folio = read_cache_folio(buf->mapping, index, NULL, NULL);
-		memalloc_nofs_restore(nofs_flag);
+		folio = read_mapping_folio(buf->mapping, index, NULL);
 		if (IS_ERR(folio))
 			return folio;
-
-		/* should already be PageUptodate, no need to lock page */
-		page = folio_file_page(folio, index);
-		buf->page = page;
 	}
+	buf->page = folio_file_page(folio, index);
+
 	if (buf->kmap_type == EROFS_NO_KMAP) {
 		if (type == EROFS_KMAP)
-			buf->base = kmap_local_page(page);
+			buf->base = kmap_local_page(buf->page);
 		buf->kmap_type = type;
 	} else if (buf->kmap_type != type) {
 		DBG_BUGON(1);
-- 
2.43.5


