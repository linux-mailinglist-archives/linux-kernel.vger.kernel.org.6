Return-Path: <linux-kernel+bounces-228244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A926915D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA335282DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451D5490F;
	Tue, 25 Jun 2024 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP6Ktd72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA34E1D2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285373; cv=none; b=iP4RswCglPoJ0wyLF6mYUTBnuwb1tWS5tpthVJt9Cc5GgbeZnsuHS3pzZXmHmddOO/O8GKEuLc1thNSAHOLz9qONyiP/RGIbFFwjdjhsQXPdZjSHRjuLEnhgcG73PJaAj1YPYXuBdP82UQowweY8sACrWPVE0f4bqCCXmayXCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285373; c=relaxed/simple;
	bh=1Xrsez65ZNQvM4VETHD3Cc+794w9s8wbJDQWT8A9bok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=detrMywkORaRgN0yPX3Jw+cxuvZa4Mi2EWrpTOYZ4tBPz9KJ2ANsCPBcAgVmg/IXYLVFSVpxqxDM+PWYlUNmiOzV3RNY38zJp2dJk6EKawpM6TuyN8p10XgbMONfJ7jdV4dJYXjQwZQGS1BK9/ZnjZQXpXauCjb/tSzyBHj80yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP6Ktd72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4220AC4AF0B;
	Tue, 25 Jun 2024 03:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719285373;
	bh=1Xrsez65ZNQvM4VETHD3Cc+794w9s8wbJDQWT8A9bok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aP6Ktd72zH4tmfpw5JvKAlyDAamSyGpm45bdv9UPzcp1OL1jesqFzK66JbgS0/Bg7
	 lJCqaaUmDmX3M9t0OrVRho6bPrDkLpkrEuYIKz4ENO5hJlNFV0b0ytlcIs4pDdg9q4
	 QJBqvvgHrJgnq63GlSfUuBYADObly4jvSzYHR4ad8CCq+xNkJ/+fBrl+ur6PszOMl+
	 Wsljxho2hatIz/2ViZ6SvSHo2NJZ7di8LVePEl8bM2XNhsBtFqtJXxnBSw1j2m55WX
	 8aqRlnuP5FzEVnrRsXgSnemPoXIKTwc7tZnCa8LnzJjxH6JVqMYfvStcFQS33gEU0c
	 9Yz7TDr7vNdXw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: clean up data_blkaddr() and get_dnode_addr()
Date: Tue, 25 Jun 2024 11:16:04 +0800
Message-Id: <20240625031604.3587691-3-chao@kernel.org>
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

Introudce a new help get_dnode_base() to wrap common code from
get_dnode_addr() and data_blkaddr() for cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1f78a39fe7f4..eacf0b0e6b2e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2905,26 +2905,31 @@ static inline __le32 *blkaddr_in_node(struct f2fs_node *node)
 }
 
 static inline int f2fs_has_extra_attr(struct inode *inode);
-static inline block_t data_blkaddr(struct inode *inode,
-			struct page *node_page, unsigned int offset)
+static inline int get_extra_isize(struct inode *inode);
+static inline unsigned int get_dnode_base(struct inode *inode,
+					struct page *node_page)
 {
-	struct f2fs_node *raw_node;
-	__le32 *addr_array;
-	int base = 0;
-	bool is_inode = IS_INODE(node_page);
-
-	raw_node = F2FS_NODE(node_page);
-
-	if (is_inode) {
+	if (IS_INODE(node_page)) {
 		if (!inode)
 			/* from GC path only */
-			base = offset_in_addr(&raw_node->i);
+			return offset_in_addr(&F2FS_NODE(node_page)->i);
 		else if (f2fs_has_extra_attr(inode))
-			base = get_extra_isize(inode);
+			return get_extra_isize(inode);
 	}
+	return 0;
+}
 
-	addr_array = blkaddr_in_node(raw_node);
-	return le32_to_cpu(addr_array[base + offset]);
+static inline __le32 *get_dnode_addr(struct inode *inode,
+					struct page *node_page)
+{
+	return blkaddr_in_node(F2FS_NODE(node_page)) +
+			get_dnode_base(inode, node_page);
+}
+
+static inline block_t data_blkaddr(struct inode *inode,
+			struct page *node_page, unsigned int offset)
+{
+	return le32_to_cpu(*(get_dnode_addr(inode, node_page) + offset));
 }
 
 static inline block_t f2fs_data_blkaddr(struct dnode_of_data *dn)
@@ -3297,8 +3302,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
-static inline __le32 *get_dnode_addr(struct inode *inode,
-					struct page *node_page);
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	__le32 *addr = get_dnode_addr(inode, page);
@@ -3437,17 +3440,6 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	return F2FS_I(inode)->i_inline_xattr_size;
 }
 
-static inline __le32 *get_dnode_addr(struct inode *inode,
-					struct page *node_page)
-{
-	int base = 0;
-
-	if (IS_INODE(node_page) && f2fs_has_extra_attr(inode))
-		base = get_extra_isize(inode);
-
-	return blkaddr_in_node(F2FS_NODE(node_page)) + base;
-}
-
 #define f2fs_get_inode_mode(i) \
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
-- 
2.40.1


