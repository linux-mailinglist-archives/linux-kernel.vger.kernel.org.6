Return-Path: <linux-kernel+bounces-291321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 717DF9560DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B9C1F21631
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390713BBF6;
	Mon, 19 Aug 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbRYsQze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7C3A1DA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030462; cv=none; b=lEX5XVznSfHSF/XXJ6pWeW6/gZz2CVc/aykvUkenio1D0/YUFNqADdm4wAv42wHtbYCZ+FBwd72NlY4akBJNVEkadUOelgFOcdCNkZQug4VYe2LZ68HYYohKYeZH3M0PA1jloYRgel685XV1KzVle/vxBg/G5984zw8h5sQnovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030462; c=relaxed/simple;
	bh=Gv9T9VqQEXP+t9GsufY3LhPD+LhHvt38T1omk9U0JGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syxqyLiw4M4L7riHe6Hzup6v8Pj0EMxc21Gun8yaCXbnXgiAEKldNeNGDZQKGAp4faKkfoPuxJ7pRL5bjPEfsZ1mJaDMMkYW3gHpS5CYXtbNDOBmEYfu5WY1/DJRuSW2nAMctJvD29fBKslxuF+nTBuLCEoE+3YeMsfZXcbzcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbRYsQze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92440C32786;
	Mon, 19 Aug 2024 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724030462;
	bh=Gv9T9VqQEXP+t9GsufY3LhPD+LhHvt38T1omk9U0JGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbRYsQzetuZRIRFPWhOiNqwQxgfMVNcgiXrmvVe0jjaau42YXhHHUtDXQYsNxAHPh
	 GVPmMfmspB2yvdcXUBQ43orXBKCF59vSuW7T+XkhFZc4btSv89jvK9qvZ5B/0DkqQQ
	 803lkBBj/zf6CeXNu6+g9yNzxzpWu2o5hWhDDmOB/zlP4tNYHjPqcvreiQNuCY1RRm
	 38ZTIv028YQqmHv7mvYxUZQPs3p+3LqSrfVa/a6bC6QRuOexT8lN3iIhZx9UlF9hog
	 J4tAGzPVTZpWCo4g+5tWXZ6XPifxbQrdnV7TK2A1pyNQRgb9TiSOG02+zO9ZynPE7g
	 vqBK06cFORMjQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 5/8] f2fs: convert f2fs_write_data_page() to use folio
Date: Mon, 19 Aug 2024 09:20:20 +0800
Message-Id: <20240819012023.3871272-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240819012023.3871272-1-chao@kernel.org>
References: <20240819012023.3871272-1-chao@kernel.org>
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
 fs/f2fs/data.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c57ddee2c7c5..e69097267b99 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2945,22 +2945,23 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 static int f2fs_write_data_page(struct page *page,
 					struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		goto out;
 
 	if (f2fs_compressed_file(inode)) {
-		if (f2fs_is_compressed_cluster(inode, page->index)) {
-			redirty_page_for_writepage(wbc, page);
+		if (f2fs_is_compressed_cluster(inode, folio->index)) {
+			folio_redirty_for_writepage(wbc, folio);
 			return AOP_WRITEPAGE_ACTIVATE;
 		}
 	}
 out:
 #endif
 
-	return f2fs_write_single_data_page(page_folio(page), NULL, NULL, NULL,
+	return f2fs_write_single_data_page(folio, NULL, NULL, NULL,
 						wbc, FS_DATA_IO, 0, true);
 }
 
-- 
2.40.1


