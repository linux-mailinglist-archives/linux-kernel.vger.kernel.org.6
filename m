Return-Path: <linux-kernel+bounces-294171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC42958A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2886B2310B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324BC1917F4;
	Tue, 20 Aug 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtXVGECg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80E190477
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165717; cv=none; b=Ba09DIwyLU0wNmaKuD/7JhhOa9ne4znpibCCjAXEn5PTcnuUoX1AIeZ/gzKht2w/qVbEidpYE1+2MEWeEbF89++EgCj/2+4bM6FH0RhwBm6cn29M27TIsPYv2KabS5opn1YOPomg5HWqeJh3mMPHjCE3eLPUONnF/xh+t9Jp7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165717; c=relaxed/simple;
	bh=TD4pC/7gOAIBRtl7hXh73ZpX5mOA2MdaM84eq+diEMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mSLLGXjgtMJe6CzFC/QYTZdkbhwUD9HGQ7tn2wpZ4x9wSrQ/LZYwBlQrNkTX8GhNeJZkj76Uq+n74LtwtzJa3Y0HqOf2xf/Q7E/zctdCAIXx93RQGhPn+GBzdaMfk8H7sM9Ajva3O810oqPUqWAWWfGjyUPwwiOaIXRiOKozaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtXVGECg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA452C4AF0E;
	Tue, 20 Aug 2024 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165717;
	bh=TD4pC/7gOAIBRtl7hXh73ZpX5mOA2MdaM84eq+diEMI=;
	h=From:To:Cc:Subject:Date:From;
	b=EtXVGECgRWDIRijkjHcl5yBeVwhoNpGuHrbJmX6Y6LBDg189ihRoz0Dj2h7k+IEmb
	 WXeSWw+3lx08siQiNqYbTZE9FvV2NYEXeH/GieXZPHrMY22jgRE6SXkKLls98xi1m0
	 9OlC//DrMJjvIlJt9loHYKIYo27LohbYrgzuP6Q4JjqigFnIPmXADNhgMBp4MkzHWK
	 fyeALRQMC7b8lpUaM+4Ed1BxBdkHrS6yOUml8M4qLEOp2+8cAT4gfhdigo+fIUKaUm
	 nrGWezAkG7zf0XJlIqt2ZGPS6BD35T4wNgAJQjL0Fpmnc+lE9mMLQ4NNnzJJYKV2wP
	 Sy9mYVauoBl/g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 1/9] f2fs: convert f2fs_submit_page_read() to use folio
Date: Tue, 20 Aug 2024 22:54:59 +0800
Message-Id: <20240820145507.1372905-1-chao@kernel.org>
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
 fs/f2fs/data.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4f4e76c33611..0655fddfc4ba 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1086,7 +1086,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 }
 
 /* This can handle encryption stuffs */
-static int f2fs_submit_page_read(struct inode *inode, struct page *page,
+static int f2fs_submit_page_read(struct inode *inode, struct folio *folio,
 				 block_t blkaddr, blk_opf_t op_flags,
 				 bool for_write)
 {
@@ -1094,14 +1094,14 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	struct bio *bio;
 
 	bio = f2fs_grab_read_bio(inode, blkaddr, 1, op_flags,
-					page->index, for_write);
+					folio->index, for_write);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, blkaddr);
 
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0)) {
 		iostat_update_and_unbind_ctx(bio);
 		if (bio->bi_private)
 			mempool_free(bio->bi_private, bio_post_read_ctx_pool);
@@ -1269,7 +1269,7 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 		return page;
 	}
 
-	err = f2fs_submit_page_read(inode, page, dn.data_blkaddr,
+	err = f2fs_submit_page_read(inode, page_folio(page), dn.data_blkaddr,
 						op_flags, for_write);
 	if (err)
 		goto put_err;
@@ -3668,8 +3668,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			goto fail;
 		}
 		err = f2fs_submit_page_read(use_cow ?
-				F2FS_I(inode)->cow_inode : inode, page,
-				blkaddr, 0, true);
+				F2FS_I(inode)->cow_inode : inode,
+				page_folio(page), blkaddr, 0, true);
 		if (err)
 			goto fail;
 
-- 
2.40.1


