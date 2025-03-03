Return-Path: <linux-kernel+bounces-540968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F365A4B70A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4222D16C9BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B11E0DE3;
	Mon,  3 Mar 2025 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kstfaV/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA41DED5C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740974075; cv=none; b=fx2nhqx8yrv3PEmcDxEIEfRD4aVDu6o5QqRD+a98a+62vNxZh9YJgXu/1Es3/VuRNWF+CRx+DlFkf/y8Sw4VUBjPoNqjKilBYlND7QdrniGq6BT/vPEKALnGf3ero1o0rwYYwaMhpBe/+AobZUXJB3B6djnbicGPhqxW95tefFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740974075; c=relaxed/simple;
	bh=Dit0+cvWSyhtAoDZ4pYoyGBm0QT2XB2itAoOVj71vb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfGjFXIOHYATlq9ktzLNFuwB4jI8c12ud3Ayga/d7TO6NuppbkgGWb0FURqvMeOQpM7TVwhjYiFvwX2/7QwL9T1iIKncHOd/RkmLKqFrwVd3xyHFdOvEor43P5rdlrce8QNZ+RGzb44yvrFwvRwMuOsKKmqwS9C0kEUB1vqmt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kstfaV/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6FAC4CED6;
	Mon,  3 Mar 2025 03:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740974075;
	bh=Dit0+cvWSyhtAoDZ4pYoyGBm0QT2XB2itAoOVj71vb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kstfaV/hE+1Dr7mq+ZLMZqAWJ8aglk6HLBplQjRX5sAU30W8Omj6+dupI0N6y04wb
	 IxL9h0fKKehurf43akm1JTPMU4lGWHvM/0WsSpQojCXLvAG7z5kj0mh6Bsm63iJzuU
	 EcolcB6bwXn7APL/xdO4xULt3FmqJi8v4hDR7AJLU3NnQQYBHYzBwL9Zemt3spSXOn
	 oTDRc0alRUDGzDRVi2YaOnF0wHlp1pKdYtds33L+oJec0B/zfnrSOX+wkenXT0z/fD
	 lMSwFibPFq6ST7sHJu281OKkRQO7olpogs7waeOjkASaoNcqy5G2+bhpCeU17MxzIs
	 GRkZDmlpiEvuw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: introduce FAULT_INCONSISTENT_FOOTER
Date: Mon,  3 Mar 2025 11:54:23 +0800
Message-ID: <20250303035423.1357211-3-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303035423.1357211-1-chao@kernel.org>
References: <20250303035423.1357211-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To simulate inconsistent node footer error.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 1 +
 Documentation/filesystems/f2fs.rst      | 1 +
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/node.c                          | 3 ++-
 fs/f2fs/super.c                         | 1 +
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 81deae2af84d..b9a000e5098a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -734,6 +734,7 @@ Description:	Support configuring fault injection type, should be
 		FAULT_BLKADDR_VALIDITY           0x000040000
 		FAULT_BLKADDR_CONSISTENCE        0x000080000
 		FAULT_NO_SEGMENT                 0x000100000
+		FAULT_INCONSISTENT_FOOTER        0x000200000
 		===========================      ===========
 
 What:		/sys/fs/f2fs/<disk>/discard_io_aware_gran
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index fb7d2ee022bc..42f28dbf2410 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -206,6 +206,7 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 FAULT_BLKADDR_VALIDITY           0x000040000
 			 FAULT_BLKADDR_CONSISTENCE        0x000080000
 			 FAULT_NO_SEGMENT                 0x000100000
+			 FAULT_INCONSISTENT_FOOTER        0x000200000
 			 ===========================      ===========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 38016d24e59c..99cc933faf8c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -62,6 +62,7 @@ enum {
 	FAULT_BLKADDR_VALIDITY,
 	FAULT_BLKADDR_CONSISTENCE,
 	FAULT_NO_SEGMENT,
+	FAULT_INCONSISTENT_FOOTER,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5be8badc6261..58803cab2235 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1463,7 +1463,8 @@ static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
 	if (unlikely(nid != nid_of_node(page) ||
 		(ntype == NODE_TYPE_INODE && !IS_INODE(page)) ||
 		(ntype == NODE_TYPE_XATTR &&
-		!f2fs_has_xattr_block(ofs_of_node(page))))) {
+		!f2fs_has_xattr_block(ofs_of_node(page))) ||
+		time_to_inject(sbi, FAULT_INCONSISTENT_FOOTER))) {
 		f2fs_warn(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
 			  "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
 			  ntype, nid, nid_of_node(page), ino_of_node(page),
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7a8fcc1e278c..3a7e4e8ab010 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -63,6 +63,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_BLKADDR_VALIDITY]	= "invalid blkaddr",
 	[FAULT_BLKADDR_CONSISTENCE]	= "inconsistent blkaddr",
 	[FAULT_NO_SEGMENT]		= "no free segment",
+	[FAULT_INCONSISTENT_FOOTER]	= "inconsistent footer",
 };
 
 int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
-- 
2.48.1


