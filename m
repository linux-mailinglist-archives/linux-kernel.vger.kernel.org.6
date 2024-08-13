Return-Path: <linux-kernel+bounces-284951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054BE950743
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A131F23B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD1519D078;
	Tue, 13 Aug 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIEL4rar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110B3A8CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558425; cv=none; b=rF6hvwswyztKrcKkdxd8cnTpkiG9O8Fu36v6O3p+qX2uA0XQGIgU6K9s+vmn4hMl/01zQbHvrUqZl18z53GaFU17Xh+8V212ESZUcTFWCUnEcOCDaJzgfS3vcLj5mz8urWl2ztVo3OthU7UwlI4loR8RUvQSbdoutytU/Hiej2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558425; c=relaxed/simple;
	bh=jeYWkLahC30q53zidZWoDYe1mT2rCQxgLl7pKbyzKME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uDXC2fJz7N0o8WO2r+0/d7oFqi4OYvctiR1ufL8nctbnv89BlHPygOFOfHjuvOkYto3vvDDU+4Mxce/jl+BqkYXbNYY+p1QhXkBM0kb66axdniwtf8b0h+WAzOBjYJxYboPh9qOvEm4wAX06uUejypqAOMiKF2AnzQBQ2is3qqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIEL4rar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAC5C4AF09;
	Tue, 13 Aug 2024 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558424;
	bh=jeYWkLahC30q53zidZWoDYe1mT2rCQxgLl7pKbyzKME=;
	h=From:To:Cc:Subject:Date:From;
	b=NIEL4rarQPF1QG53mUNGMO2jwW4INcHFzUNCt5FbTPQp8KEi872+saZe00PI7+uBC
	 8WRmt+aA8qsT9tRUntGU5Sn2FOuDb/gyFWNQhQ0y6WQhpVjriOSOT8ydOfiAnCiXOp
	 z7RhRhDxZTjonxzOwGn4hq9+ySnFI5NIa5XA0sOIlB5JmyWu4zwfuYRdy7XK1oF1Jk
	 M9KULFWYRbYeNPR6bPd9nB+rdVWvX1r8Bfe2EJLBswo3TVjPdsx6aOq3RvBn5zxviI
	 DTFsFg6BTMBaaBCm9LlpAYik4TjrNIA6HoiiSpCU26nFtrQR9/KhpAJ+8wVDeAkRpw
	 yH+eChcSlm4Ow==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/9] f2fs: convert f2fs_compress_ctx_add_page() to use folio
Date: Tue, 13 Aug 2024 22:13:23 +0800
Message-Id: <20240813141331.417067-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

onvert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 14 +++++++-------
 fs/f2fs/data.c     |  4 ++--
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 990b93689b46..eb5cd1457ffc 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -160,17 +160,17 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
 		cc->cluster_idx = NULL_CLUSTER;
 }
 
-void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page)
+void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio)
 {
 	unsigned int cluster_ofs;
 
-	if (!f2fs_cluster_can_merge_page(cc, page->index))
+	if (!f2fs_cluster_can_merge_page(cc, folio->index))
 		f2fs_bug_on(F2FS_I_SB(cc->inode), 1);
 
-	cluster_ofs = offset_in_cluster(cc, page->index);
-	cc->rpages[cluster_ofs] = page;
+	cluster_ofs = offset_in_cluster(cc, folio->index);
+	cc->rpages[cluster_ofs] = folio_page(folio, 0);
 	cc->nr_rpages++;
-	cc->cluster_idx = cluster_idx(cc, page->index);
+	cc->cluster_idx = cluster_idx(cc, folio->index);
 }
 
 #ifdef CONFIG_F2FS_FS_LZO
@@ -1093,7 +1093,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		if (PageUptodate(page))
 			f2fs_put_page(page, 1);
 		else
-			f2fs_compress_ctx_add_page(cc, page);
+			f2fs_compress_ctx_add_page(cc, page_folio(page));
 	}
 
 	if (!f2fs_cluster_is_empty(cc)) {
@@ -1123,7 +1123,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		}
 
 		f2fs_wait_on_page_writeback(page, DATA, true, true);
-		f2fs_compress_ctx_add_page(cc, page);
+		f2fs_compress_ctx_add_page(cc, page_folio(page));
 
 		if (!PageUptodate(page)) {
 release_and_retry:
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e9570f4e0f21..100b6526717f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2429,7 +2429,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		if (ret)
 			goto set_error_page;
 
-		f2fs_compress_ctx_add_page(&cc, &folio->page);
+		f2fs_compress_ctx_add_page(&cc, folio);
 
 		goto next_page;
 read_single_page:
@@ -3161,7 +3161,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 			if (f2fs_compressed_file(inode)) {
 				folio_get(folio);
-				f2fs_compress_ctx_add_page(&cc, &folio->page);
+				f2fs_compress_ctx_add_page(&cc, folio);
 				continue;
 			}
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 51fd5063a69c..df436dd3aac1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4322,7 +4322,7 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
 bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
 				int index, int nr_pages, bool uptodate);
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
-void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
+void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio);
 int f2fs_write_multi_pages(struct compress_ctx *cc,
 						int *submitted,
 						struct writeback_control *wbc,
-- 
2.40.1


