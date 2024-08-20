Return-Path: <linux-kernel+bounces-294176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80330958A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BBFB23DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C5194132;
	Tue, 20 Aug 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ9W16IR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E119409C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165725; cv=none; b=OKZqdIs44zPMvCQVXaveixvbLBNaaD80WvmMWO/YOWfAMj7d7M12/Ve6pyAXC/N37KRFRl0/2yOE80Xfy74iwBcEKAHN2K8c3jB1tRO/zByxnTu+EDZrZrnc9Tm1q173zqzksizU7MSNK8ZEVO0NlFFzut+SnKIwGUx2KDy3BUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165725; c=relaxed/simple;
	bh=Gv9T9VqQEXP+t9GsufY3LhPD+LhHvt38T1omk9U0JGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6nNy9yDNZ/+TdrLTyR5lkFOyVUkRM+UnBHFZna63LecCtZfzX/KCEMefzIPd5HtkNdWdDR8OVt/zJgDWC8OvXddco7cFt3ybumxnPkT+sJRx6QPehUkXRK+9nW+Zmunqf1gz+/XkKZDzn8foxFf8xKWbv9Wl9xRw7v4qD9ngQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ9W16IR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EA6C4AF13;
	Tue, 20 Aug 2024 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165725;
	bh=Gv9T9VqQEXP+t9GsufY3LhPD+LhHvt38T1omk9U0JGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZ9W16IRFWd2LFPtm1XvzpXZaxI1c02blG2XPDJLi5qAEfDHfMUuvhkdDQcfVlBxx
	 vIOzU0poC6k/ikW84ZvfV2qNsZll5T+qBBqsOz/qTORz4DIYydEyKw8NQKV+RV0PTy
	 4NNf+sHcvapSH77owmgh1JVqpXLXBTvYCxAxTsARh8ZmpJUmU2K8yITBEwZlE30MAr
	 wo/Xa+bzmX+2jPbTI2WtqWVNZ3nZzJ05CEMdPCA2MPOTKjMo7uAH3fd3Yj1A1W0fgW
	 V8tmY3a3Pd1tAlBv5cKW/qUmHLg5lyNBwVNux9mRfd1G/EUX0vFiZAZXEUyTX8vgcl
	 FrpAkJIaiekfw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 6/9] f2fs: convert f2fs_write_data_page() to use folio
Date: Tue, 20 Aug 2024 22:55:04 +0800
Message-Id: <20240820145507.1372905-6-chao@kernel.org>
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


