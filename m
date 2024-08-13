Return-Path: <linux-kernel+bounces-284958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56667950754
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0FB1C22E53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297A519E839;
	Tue, 13 Aug 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpS+8sNg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027B19E822
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558438; cv=none; b=LNquOFCssC0/9pNTDRdJVj7RgWoDEkgUvQUsYgQ2nKbmjZbyqs+m0C8X224FFnu3KMrnzAUshIxW/Vt9WSIyUNKSE79lUI1rPuwi9+mMeuqGruyQvZUUjDxbjFEovRUDFdCuWP4P+jos8o9w0nqmY1jSpAu4N+YxxG8WzHYuzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558438; c=relaxed/simple;
	bh=5T499NbgrjKr5NOj5StQGgnVfYV5k+BMGIi5VEOc7AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A8C7Pjy9sS65HqvryWm92EdXpaarBEsaQC0+/g1C7Af3EsiHxrMja8gGivJ2YP3T60pksNo5IQu4jrS0TdJSfweuNHPEhwo3j7KOWrAKkw66zLmtp4l/pLu6Wnxo89tviPoFGnEcrxBlM5MObQDImmJNcUc9sMlt73Q5Mt6LZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpS+8sNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D559CC4AF0B;
	Tue, 13 Aug 2024 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558438;
	bh=5T499NbgrjKr5NOj5StQGgnVfYV5k+BMGIi5VEOc7AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpS+8sNg/0fjtUqjjEU21HwpPd1cVu3aEWiOVNVS6pXd87OhjQlLc2OjCXW4Z/qOC
	 CMui+djcxR8+17IaMN3S1g/nnlIEu/2OMbeEDLIFqsb38mCsaKE0BT1tsGvbm1g5dI
	 I2hG+3ecJsm+Q6Oc9JkJeBXKGednlRW6hsQqbzF95oF1k3QcYQ/OxyJYpjTvMDapWq
	 6arnDIddQiw4lng0uDwIlQIH16LMkeYPqEXCK2sSB+2OqHjoatR9rhnDcOXo6rB+bW
	 3oYsk2yOWwXYyPa49ge+ahGv4R45qYQ8ky4bGSTgYeqd7dF6+cTZcPrAsEQ/jdWX2L
	 gICkksTrwlR/w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 8/9] f2fs: convert f2fs_read_multi_pages() to use folio
Date: Tue, 13 Aug 2024 22:13:30 +0800
Message-Id: <20240813141331.417067-8-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240813141331.417067-1-chao@kernel.org>
References: <20240813141331.417067-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0779e222f709..9e21cfe11cc7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2207,19 +2207,22 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	/* get rid of pages beyond EOF */
 	for (i = 0; i < cc->cluster_size; i++) {
 		struct page *page = cc->rpages[i];
+		struct folio *folio;
 
 		if (!page)
 			continue;
-		if ((sector_t)page->index >= last_block_in_file) {
-			zero_user_segment(page, 0, PAGE_SIZE);
-			if (!PageUptodate(page))
-				SetPageUptodate(page);
-		} else if (!PageUptodate(page)) {
+
+		folio = page_folio(page);
+		if ((sector_t)folio->index >= last_block_in_file) {
+			folio_zero_segment(folio, 0, folio_size(folio));
+			if (!folio_test_uptodate(folio))
+				folio_mark_uptodate(folio);
+		} else if (!folio_test_uptodate(folio)) {
 			continue;
 		}
-		unlock_page(page);
+		folio_unlock(folio);
 		if (for_write)
-			put_page(page);
+			folio_put(folio);
 		cc->rpages[i] = NULL;
 		cc->nr_rpages--;
 	}
@@ -2279,7 +2282,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	}
 
 	for (i = 0; i < cc->nr_cpages; i++) {
-		struct page *page = dic->cpages[i];
+		struct folio *folio = page_folio(dic->cpages[i]);
 		block_t blkaddr;
 		struct bio_post_read_ctx *ctx;
 
@@ -2289,7 +2292,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		f2fs_wait_on_block_writeback(inode, blkaddr);
 
-		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
+		if (f2fs_load_compressed_page(sbi, folio_page(folio, 0),
+								blkaddr)) {
 			if (atomic_dec_and_test(&dic->remaining_pages)) {
 				f2fs_decompress_cluster(dic, true);
 				break;
@@ -2299,7 +2303,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		if (bio && (!page_is_mergeable(sbi, bio,
 					*last_block_in_bio, blkaddr) ||
-		    !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL))) {
+		    !f2fs_crypt_mergeable_bio(bio, inode, folio->index, NULL))) {
 submit_and_realloc:
 			f2fs_submit_read_bio(sbi, bio, DATA);
 			bio = NULL;
@@ -2308,7 +2312,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		if (!bio) {
 			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages,
 					f2fs_ra_op_flags(rac),
-					page->index, for_write);
+					folio->index, for_write);
 			if (IS_ERR(bio)) {
 				ret = PTR_ERR(bio);
 				f2fs_decompress_end_io(dic, ret, true);
@@ -2318,7 +2322,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 			}
 		}
 
-		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
+		if (bio_add_folio(bio, folio, blocksize, 0) < blocksize)
 			goto submit_and_realloc;
 
 		ctx = get_post_read_ctx(bio);
-- 
2.40.1


