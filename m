Return-Path: <linux-kernel+bounces-286538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA7951C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D0B28330B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CFE1B1510;
	Wed, 14 Aug 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLzMJL93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E161B0121
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643466; cv=none; b=nH+1Bx804sQ+TX1zm9xmZkbBBQiyptB1VeGyNUZ7a5+ZNQmjNpVhzxs6mFhB/bUzElWfinx5kqDeKyr8BQ1kEh3/yoq8PdgGUgHKGBCdqGN4wIwdjdCSPehxJUMhpTkhUAqznUOx/J7l9gy1p+cA3BB9yawJoXou703jit93xLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643466; c=relaxed/simple;
	bh=rxaqh40G6QYbFhGgXzDOgOuj/ji5qhnZ1FN1k7hQmDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goPtjR9TWo5UYGinbQF4RB4IJxFDFf9m8AyICWw+Z7+64gNgdqi/DyUfztOr4EmYRLilenCAKUnjk2a5N3zcPaRXtldNcB3K1HJurUxKlOw62CRAVduTCIAqWicU2qEjDQmlbbrpv95qWXxV2V5Ep28Pue9bkOOnu5OO/v4ffMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLzMJL93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D143CC4AF0A;
	Wed, 14 Aug 2024 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723643466;
	bh=rxaqh40G6QYbFhGgXzDOgOuj/ji5qhnZ1FN1k7hQmDE=;
	h=From:To:Cc:Subject:Date:From;
	b=RLzMJL93JuH3bI0OtgWhHncPf+1MJqropPEpPcbKCeHmsq3OEPdiA0IkI0LHOnGTe
	 M3eweyiCpZll8WleGA5CYE4hb8lLAmDqJ+Dr5yVQcfcsNoNaWWZX7VjQcT9dtzBiHh
	 lHueliT5I8GztePjze4luzL6G3Xzt5b7KXerBKb0aZ6h9vWxJYjmYUYsZALNYuORJ5
	 /TtUO21OQV/cMv4sY+/RQUULAsPktfNAziwORx7SUcoYMhj5x9K2tfSr1emQYa3Nny
	 Jw68in1/TVX3dwu5A6+YOEt8y9Tjdy+I4DY2jdO/9Vgn+R7CokpLA/9zILbOQ3q2Q2
	 Eon8aEiqKGx9A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 8/9] f2fs: convert f2fs_read_multi_pages() to use folio
Date: Wed, 14 Aug 2024 21:50:59 +0800
Message-Id: <20240814135059.802454-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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
v2:
- check return value of bio_add_folio() correctly.
 fs/f2fs/data.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0779e222f709..4f4e76c33611 100644
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
+		if (!bio_add_folio(bio, folio, blocksize, 0))
 			goto submit_and_realloc;
 
 		ctx = get_post_read_ctx(bio);
-- 
2.40.1


