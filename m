Return-Path: <linux-kernel+bounces-228243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914C915D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA915B2192C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6B49646;
	Tue, 25 Jun 2024 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1qqYF7n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F443ACC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285372; cv=none; b=eGWNsyS/IPezc8nZElmI0CWshLQJotynJo23+IgzOp7xg1kld8KMyyKw4L4L156EqTwcLFYJ9+yfKl3VoP4j73W0qWKtgsvZhdHDKIyQ4hWJOqHzgoRpiWJGBRPpVUZuodCDagSyIwVhqJHXJqN5ZVY8HeBUNmBCakyEyE8xCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285372; c=relaxed/simple;
	bh=bcfjSpR4747ly8u0IB5/5T8MV5FJsuo1UT28kexs9go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvAfgXjdFLMkZp/lO1PENTn4kxKvd/XNK62XUBJtcFI15VjLCUBlXfP1UILSs4UkmRR3YMYkW146P9qd/8s+9GxWJ5dTOynf4uvJ8dk1sZhO4yJF8qCu+lznGgarHLa31fL6k08APAd+JwemzKY4looEhg/Ehfpkr6pivfEGhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1qqYF7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB0FC32789;
	Tue, 25 Jun 2024 03:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719285371;
	bh=bcfjSpR4747ly8u0IB5/5T8MV5FJsuo1UT28kexs9go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1qqYF7nhrmFEUJQRTPuqDOCe8hw81XtgvnojiHzy5xj3IEtSTPoRo33HJedaJUzN
	 pDZlehNg42PKv1x8KzTYT0BierwehD/GiimORKBDZbSxC+Exr6cVkLzqagcqPwLz5e
	 PAD/l1S1kRDOhp+9Eb7J68tilVMWQtGLTSe/Wrn7W20oU4/aBB/eUC9Fp4h1+5UPNl
	 J/kxtJ7iUBEGXnVVXE4jmjqyMNCjDBIWvqntUEATsHz5tFlCYLmx4Wy20S+hOQRfQj
	 ZVGFpgeICnxtkIhg4s2JkM7mYKNNBW8XnkJ4cfgBvktDvi18cM3VyyCkKBw5nx1K6o
	 w4DjcahEZHhMg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: clean up addrs_per_{inode,block}()
Date: Tue, 25 Jun 2024 11:16:03 +0800
Message-Id: <20240625031604.3587691-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625031604.3587691-1-chao@kernel.org>
References: <20240625031604.3587691-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new help addrs_per_page() to wrap common code
from addrs_per_inode() and addrs_per_block() for cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h          | 20 +++++++-------------
 include/linux/f2fs_fs.h |  7 +++----
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 45451ca3b438..1f78a39fe7f4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3232,21 +3232,15 @@ static inline bool f2fs_need_compress_data(struct inode *inode)
 	return false;
 }
 
-static inline unsigned int addrs_per_inode(struct inode *inode)
+static inline unsigned int addrs_per_page(struct inode *inode,
+							bool is_inode)
 {
-	unsigned int addrs = CUR_ADDRS_PER_INODE(inode) -
-				get_inline_xattr_addrs(inode);
+	unsigned int addrs = is_inode ? (CUR_ADDRS_PER_INODE(inode) -
+			get_inline_xattr_addrs(inode)) : DEF_ADDRS_PER_BLOCK;
 
-	if (!f2fs_compressed_file(inode))
-		return addrs;
-	return ALIGN_DOWN(addrs, F2FS_I(inode)->i_cluster_size);
-}
-
-static inline unsigned int addrs_per_block(struct inode *inode)
-{
-	if (!f2fs_compressed_file(inode))
-		return DEF_ADDRS_PER_BLOCK;
-	return ALIGN_DOWN(DEF_ADDRS_PER_BLOCK, F2FS_I(inode)->i_cluster_size);
+	if (f2fs_compressed_file(inode))
+		return ALIGN_DOWN(addrs, F2FS_I(inode)->i_cluster_size);
+	return addrs;
 }
 
 static inline void *inline_xattr_addr(struct inode *inode, struct page *page)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 41d1d71c36ff..01bee2b289c2 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -259,15 +259,14 @@ struct node_footer {
 #define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
 					get_extra_isize(inode))
 #define DEF_NIDS_PER_INODE	5	/* Node IDs in an Inode */
-#define ADDRS_PER_INODE(inode)	addrs_per_inode(inode)
+#define ADDRS_PER_INODE(inode)	addrs_per_page(inode, true)
 /* Address Pointers in a Direct Block */
 #define DEF_ADDRS_PER_BLOCK	((F2FS_BLKSIZE - sizeof(struct node_footer)) / sizeof(__le32))
-#define ADDRS_PER_BLOCK(inode)	addrs_per_block(inode)
+#define ADDRS_PER_BLOCK(inode)	addrs_per_page(inode, false)
 /* Node IDs in an Indirect Block */
 #define NIDS_PER_BLOCK		((F2FS_BLKSIZE - sizeof(struct node_footer)) / sizeof(__le32))
 
-#define ADDRS_PER_PAGE(page, inode)	\
-	(IS_INODE(page) ? ADDRS_PER_INODE(inode) : ADDRS_PER_BLOCK(inode))
+#define ADDRS_PER_PAGE(page, inode)	(addrs_per_page(inode, IS_INODE(page)))
 
 #define	NODE_DIR1_BLOCK		(DEF_ADDRS_PER_INODE + 1)
 #define	NODE_DIR2_BLOCK		(DEF_ADDRS_PER_INODE + 2)
-- 
2.40.1


