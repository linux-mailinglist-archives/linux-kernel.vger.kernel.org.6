Return-Path: <linux-kernel+bounces-546360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F6A4F9AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7957A3FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3E1204583;
	Wed,  5 Mar 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbuIS1AC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1620409D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166084; cv=none; b=sJq4xBaFfU0XGB8V2UmhV90ckEImiCPwJAbOZsRQeYfL2de57127mAmbW7+mKPJY1VGG9a4w4qQxMUpSxJXkumnRskvbS1bLWPF8l2i44taf1hRdIygODpiNPP9UypH/IPi17JYVXLjmCcPn6HKNwg/vMFY6eoZ13P9lITM/eFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166084; c=relaxed/simple;
	bh=4QyVJFbmKdtxLQ92pp1KwxdRC4e8KKpMsgEHFxx52Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr7K1xsIxXhEAnez6cBiTFktI5qHKdDn18RDV1H1u/XJGWjQCVoGnL/1+YmIIt1btQt8ZBhGKaLb3WseDtoj7gQrtdp3LsuAKDsbIYwthjAq8p8VV//BJQ1voTYes+3Dyq3e/jvnDKcYnpgD45dM0QTTCg6drNwj30bg4b5PlL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbuIS1AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834F1C4CEE2;
	Wed,  5 Mar 2025 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741166083;
	bh=4QyVJFbmKdtxLQ92pp1KwxdRC4e8KKpMsgEHFxx52Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbuIS1ACkj+HQCw1kbViL4IsMJNOcjKbFdG02LjX9aAawDqu/0zhz0huSvN8eoP8A
	 aywAEmjS2hheIgbSNKVYDUgKXDYnxgxeL9gWQg3h2QzEIZWL+qqTrCbubjf0xz/qOf
	 WoTUttOEvLIlDSUSYL5DVU3C62DFK0+gS532RBcLX7gpCfuk7KaqC12N23GYnIUjDC
	 mKaO81xcI0y5g6bpzd0qQIv4a3Upcq35vzdLZ+/q0YXmmSjZ+br+sZM7g4OQoZwlgI
	 b2IX+j6+7K8ln5PukqYKBzuaGtKItA4fyKa0ed+8kdH3YeASCI6oncDpina+jk4ZKJ
	 VpWsREaivxcKA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/3] f2fs: introduce FAULT_INCONSISTENT_FOOTER
Date: Wed,  5 Mar 2025 17:11:48 +0800
Message-ID: <20250305091148.2086015-3-chao@kernel.org>
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

To simulate inconsistent node footer error.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- no changes
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
index b43aaa9e4ae5..6b4579b05dbf 100644
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
index 439690f40d2b..c40980447113 100644
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
index 3c875dc07266..bbd45e300311 100644
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


