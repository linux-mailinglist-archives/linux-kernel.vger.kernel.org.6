Return-Path: <linux-kernel+bounces-546359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A7A4F9A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E3B16D42B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EE2036E9;
	Wed,  5 Mar 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5yxKNAI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D1202F8B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166082; cv=none; b=cAyrSeFErXzVyxTwG8WYwAOlF6ZN17qGI0zz6bp9EHGi15xkAeYVikZVfWtEf+KZjUQbRQRhR1w8YwujkX2yXJ6nlOjxS5b2Ns1n8y0eQZu4/DD1DfT8xJ7vdWOKYIlHttN1BNVcOowqctm/aIqZmY9M0gFpURshcMLIY2WKT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166082; c=relaxed/simple;
	bh=DitxeJ2gqXUOYGkIW/ENapU+8NKt4Y/c0heOSDT7o6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mav5vaNcboxtROn5kMmMMMJOpZng3WNEdIs6pbuf7O3AVtuw5MHWBrKURn307XUdOqiCs9pZ+gVNbdOtzOziDRJQrGnnLA+BrkPBJDXAjW3RALDKj1Rrnutntm5KqqjkWjbJZanbaSiDnAscp4fa20llzFdHFf5kpusC4+CoQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5yxKNAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0116C4CEEB;
	Wed,  5 Mar 2025 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741166082;
	bh=DitxeJ2gqXUOYGkIW/ENapU+8NKt4Y/c0heOSDT7o6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5yxKNAINde+X1rTymy+myu0Ib76rwex+icxkG0FpXHVBSakHS/YLWwuRY4a00n/Z
	 hzaVzzRudSmj3A0FTBdrcrp6mp58V879yKNVnlm8A1CMqZVH7aLi42PYFZsO3IP5J6
	 6eexgB7YN2WA2luGHZTsrdFPe368rYk8EBCOpfLGXoebUEyAeLScfO9CH99N+USNk5
	 JCweJGR3DiTOJ6/keFU+MuPV1sEwqXsiAb88goJYGVUTTBs8htkjUlaUksdfJ733If
	 2d2PY23LSWJpoMN6pdfa1yFlwKIYWxQXGHPryg149UXVjdsYeO6Y6Lt1f2WhHdAdnK
	 IEuC/LH5IcWVg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/3] f2fs: do sanity check on xattr node footer in f2fs_get_xnode_page()
Date: Wed,  5 Mar 2025 17:11:47 +0800
Message-ID: <20250305091148.2086015-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250305091148.2086015-1-chao@kernel.org>
References: <20250305091148.2086015-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new wrapper f2fs_get_xnode_page(), then, caller
can use it to load xattr block to page cache, meanwhile it will do sanity
check on xattr node footer.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- no changes
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/node.c  | 14 ++++++++++++--
 fs/f2fs/node.h  |  1 +
 fs/f2fs/xattr.c |  4 ++--
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9df20576c22b..b43aaa9e4ae5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3702,6 +3702,7 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct page *f2fs_get_inode_page(struct f2fs_sb_info *sbi, pgoff_t ino);
+struct page *f2fs_get_xnode_page(struct f2fs_sb_info *sbi, pgoff_t xnid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
 int f2fs_move_node_page(struct page *node_page, int gc_type);
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 789457af059c..439690f40d2b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1245,7 +1245,7 @@ int f2fs_truncate_xattr_node(struct inode *inode)
 	if (!nid)
 		return 0;
 
-	npage = f2fs_get_node_page(sbi, nid);
+	npage = f2fs_get_xnode_page(sbi, nid);
 	if (IS_ERR(npage))
 		return PTR_ERR(npage);
 
@@ -1461,7 +1461,9 @@ static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					enum node_type ntype)
 {
 	if (unlikely(nid != nid_of_node(page) ||
-		(ntype == NODE_TYPE_INODE && !IS_INODE(page)))) {
+		(ntype == NODE_TYPE_INODE && !IS_INODE(page)) ||
+		(ntype == NODE_TYPE_XATTR &&
+		!f2fs_has_xattr_block(ofs_of_node(page))))) {
 		f2fs_warn(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
 			  "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
 			  ntype, nid, nid_of_node(page), ino_of_node(page),
@@ -1551,6 +1553,14 @@ struct page *f2fs_get_inode_page(struct f2fs_sb_info *sbi, pgoff_t ino)
 	return &folio->page;
 }
 
+struct page *f2fs_get_xnode_page(struct f2fs_sb_info *sbi, pgoff_t xnid)
+{
+	struct folio *folio = __get_node_folio(sbi, xnid, NULL, 0,
+						NODE_TYPE_XATTR);
+
+	return &folio->page;
+}
+
 struct page *f2fs_get_node_page_ra(struct page *parent, int start)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 5079c6a2298d..103a437e6425 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -56,6 +56,7 @@ enum {
 enum node_type {
 	NODE_TYPE_REGULAR,
 	NODE_TYPE_INODE,
+	NODE_TYPE_XATTR,
 };
 
 /*
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index d5b42e1005d8..c691b35618ad 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -303,7 +303,7 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
 	void *xattr_addr;
 
 	/* The inode already has an extended attribute block. */
-	xpage = f2fs_get_node_page(sbi, xnid);
+	xpage = f2fs_get_xnode_page(sbi, xnid);
 	if (IS_ERR(xpage))
 		return PTR_ERR(xpage);
 
@@ -475,7 +475,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 
 	/* write to xattr node block */
 	if (F2FS_I(inode)->i_xattr_nid) {
-		xpage = f2fs_get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
+		xpage = f2fs_get_xnode_page(sbi, F2FS_I(inode)->i_xattr_nid);
 		if (IS_ERR(xpage)) {
 			err = PTR_ERR(xpage);
 			f2fs_alloc_nid_failed(sbi, new_nid);
-- 
2.48.1


