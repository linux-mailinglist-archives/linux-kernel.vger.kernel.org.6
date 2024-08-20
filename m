Return-Path: <linux-kernel+bounces-294178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C8958A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469C428AFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E2194AEF;
	Tue, 20 Aug 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+LTHXIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC020194ACC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165729; cv=none; b=JRQKSYEVwkk7gv1nljkIru8qYqK8WoZyPd4puR4FR6ToNSx1dT8LpGEK4wo6uJXZCUqAShNbYA5o1ossog/uq4mXpBHnx3FHDHj/iueFhmu+HV47rWbPRBcKTbIBr84Tl4CmndYSYbywaIS1Sopnoikyc/6SaWh7Gqn0M4SgJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165729; c=relaxed/simple;
	bh=B1fWIi1dMz6E5T95/Mb2Eyi2qqkYJmzRfHyiW0GG3tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrfVhOAY3HgzBQ6KjDrl6RSClcvTuPtP+dV2Q6hknp5wm/u9/S6cZWdnwoNbVmz+/Bum222UU6ylcbxGdMxQYTMKKil0pYsQsAgvdtSiyZXveL6lgangAheVpBEeAokGkT+oSo5Z14iDcQHksGEk68CUBWQCeLXfmtQiov6NJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+LTHXIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04536C4AF0C;
	Tue, 20 Aug 2024 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165729;
	bh=B1fWIi1dMz6E5T95/Mb2Eyi2qqkYJmzRfHyiW0GG3tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+LTHXIZ/rFjlHLGGVRl75m3/4HDF/y4pYZp/ji0IyHooyX3INet8dv1e/IYcq1jH
	 vqgho6/9iUkn6pT4GzOBJT2jxVzC/pKKRGSDxzEmMPdPSBvKrcSeejaH+xUmJVlICK
	 nTWT4dkoVXHWsQuGzJ6UyJDRD5BVEYr1sAoJnMVwai+Zybd5yKwUSeAdkIbeesXT31
	 GlXjjwxkk6s6U9qcPwtgwBqatmNWmXrymzE5NQ5UheySvwLzQYU3+D5OguvrAmGDXs
	 MB55ztRN5lvsR5QpLVTcC4aGwrDwN12dRPbHumszFFM0SzNKIM+/eqmv44FJ9Sz8lh
	 R986GzaS7ehlg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 8/9] f2fs: convert read_node_page() to use folio
Date: Tue, 20 Aug 2024 22:55:06 +0800
Message-Id: <20240820145507.1372905-8-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
References: <20240820145507.1372905-1-chao@kernel.org>
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
 fs/f2fs/node.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index aeda3eecc9e2..f5e5abce695b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1369,6 +1369,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
  */
 static int read_node_page(struct page *page, blk_opf_t op_flags)
 {
+	struct folio *folio = page_folio(page);
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 	struct node_info ni;
 	struct f2fs_io_info fio = {
@@ -1381,21 +1382,21 @@ static int read_node_page(struct page *page, blk_opf_t op_flags)
 	};
 	int err;
 
-	if (PageUptodate(page)) {
+	if (folio_test_uptodate(folio)) {
 		if (!f2fs_inode_chksum_verify(sbi, page)) {
-			ClearPageUptodate(page);
+			folio_clear_uptodate(folio);
 			return -EFSBADCRC;
 		}
 		return LOCKED_PAGE;
 	}
 
-	err = f2fs_get_node_info(sbi, page->index, &ni, false);
+	err = f2fs_get_node_info(sbi, folio->index, &ni, false);
 	if (err)
 		return err;
 
 	/* NEW_ADDR can be seen, after cp_error drops some dirty node pages */
 	if (unlikely(ni.blk_addr == NULL_ADDR || ni.blk_addr == NEW_ADDR)) {
-		ClearPageUptodate(page);
+		folio_clear_uptodate(folio);
 		return -ENOENT;
 	}
 
-- 
2.40.1


