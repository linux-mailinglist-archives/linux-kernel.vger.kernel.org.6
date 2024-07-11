Return-Path: <linux-kernel+bounces-248500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6CA92DE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6BA1C216E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1A8F4E;
	Thu, 11 Jul 2024 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXpvcxkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8A321D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720662399; cv=none; b=ovmeISd8emvVH1xKZREal5/+rqcA5sjCola0ykGosSj47S5w4GiHufqTPMBwq0y8UCIJonhZd2l3G1T1/DEB165WdFwsUaPyiPK6JTMbIHg+A9wQeW2iXfA0pIZeJM9EfbhHgqy6K2+rQ2mzFIa8xfSFoppGWjcOHOJRNaS5wGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720662399; c=relaxed/simple;
	bh=XP/d/ZdSd0AByfrWjgBiH3rJMmDFKEO7x8m3AbPYooU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uxza0V8j15eFbWXYbeT3CKDLnSe7PGAvg9jAkuWrzzxtWyOM1CfsciPfWo2mIC8lSU1xasVPoDrfPfpFQZPfmJ3WfrcI30bPwvNZ8by4zfVmnXS+OCW/H/vIbH7Wg5ZfBjEqgIqcIqN8ctPuVEXjVuBSvF25/hGzmGU1RCTmkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXpvcxkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518CBC32781;
	Thu, 11 Jul 2024 01:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720662398;
	bh=XP/d/ZdSd0AByfrWjgBiH3rJMmDFKEO7x8m3AbPYooU=;
	h=From:To:Cc:Subject:Date:From;
	b=iXpvcxkRQ46ZCugwBTe9ZZDZVkvroa3ILeNC99WWxiJ4JevY7av1hkGbHIEC/8OIz
	 ypWdXN0xMUTDt3DrriO5eiR4HiuchVmGDSXi3N/D+CynOkL54GEe7x6Hc8i5FIz8sC
	 NGu5c57dsSyTjdjO46l7DWkJu4h2YGgUE524ByUTUyfHJrKyJHrVXOxusy7cVZma+1
	 +iYbpzKybPpLf9Mi4k5yGTD3MWRcvnxC3Mog3EUEVB/fssd1HtAdTn6ogQVkrjxWbl
	 OlWWXGTPJk9WQK0XV1NUaccYTC97ck/e2Y7FUjImYFTN8O5cNslPco2ankozGvkEg0
	 BVNwM6e1nsmDQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/3] f2fs: clean up data_blkaddr() and get_dnode_addr()
Date: Thu, 11 Jul 2024 09:46:32 +0800
Message-Id: <20240711014632.3927676-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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
v2:
- clean up get_dnode_base() and remove redundant declaration suggested
by Jaegeuk.
 fs/f2fs/f2fs.h | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3948c181997f..2d810f97992b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2900,26 +2900,27 @@ static inline __le32 *blkaddr_in_node(struct f2fs_node *node)
 }
 
 static inline int f2fs_has_extra_attr(struct inode *inode);
-static inline block_t data_blkaddr(struct inode *inode,
-			struct page *node_page, unsigned int offset)
+static inline unsigned int get_dnode_base(struct inode *inode,
+					struct page *node_page)
 {
-	struct f2fs_node *raw_node;
-	__le32 *addr_array;
-	int base = 0;
-	bool is_inode = IS_INODE(node_page);
+	if (!IS_INODE(node_page))
+		return 0;
 
-	raw_node = F2FS_NODE(node_page);
+	return inode ? get_extra_isize(inode) :
+			offset_in_addr(&F2FS_NODE(node_page)->i);
+}
 
-	if (is_inode) {
-		if (!inode)
-			/* from GC path only */
-			base = offset_in_addr(&raw_node->i);
-		else if (f2fs_has_extra_attr(inode))
-			base = get_extra_isize(inode);
-	}
+static inline __le32 *get_dnode_addr(struct inode *inode,
+					struct page *node_page)
+{
+	return blkaddr_in_node(F2FS_NODE(node_page)) +
+			get_dnode_base(inode, node_page);
+}
 
-	addr_array = blkaddr_in_node(raw_node);
-	return le32_to_cpu(addr_array[base + offset]);
+static inline block_t data_blkaddr(struct inode *inode,
+			struct page *node_page, unsigned int offset)
+{
+	return le32_to_cpu(*(get_dnode_addr(inode, node_page) + offset));
 }
 
 static inline block_t f2fs_data_blkaddr(struct dnode_of_data *dn)
@@ -3292,8 +3293,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
-static inline __le32 *get_dnode_addr(struct inode *inode,
-					struct page *node_page);
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	__le32 *addr = get_dnode_addr(inode, page);
@@ -3432,17 +3431,6 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
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


