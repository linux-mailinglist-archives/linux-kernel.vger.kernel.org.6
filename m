Return-Path: <linux-kernel+bounces-169686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D358BCC33
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A1281AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3723414389D;
	Mon,  6 May 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siwn/DFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8E14388F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992136; cv=none; b=f/sRbVx0ONUJzfRofaI0U64X9/jHSCo30dydExwTYQH4vQtIlYsgofQbCHuZo8APpD1rz1Y47oDAmBO2dEcLtpXGbcheVR4xKi4wYuYMPomqUMFmNlHKvNMlO95cnTnppqEfobwHDQZM+jPZdb/A0x7dNN5cEnqil1VGCHzamTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992136; c=relaxed/simple;
	bh=dv1pEoHOwA1g/+IAGWZ5yWzazulJlprTYfwb5ytZma8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+JYpdsD1J+RDypjj6mxI++39q1e4+sXs+x37uCenpK+XUD3tEBwqX4D/xa2erqxH+nL1cQ0toXPH0X/QjaIwMyLLmtcR0dTbqivRzaWlZwPKv1rR9ixQSFcxrSUTrdnLaq8JRv8ZdDOEEtN66fWl9rI55ZnUTsLfaC+Zu46zXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siwn/DFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4204C4AF68;
	Mon,  6 May 2024 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992136;
	bh=dv1pEoHOwA1g/+IAGWZ5yWzazulJlprTYfwb5ytZma8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siwn/DFOz2c0A0TUxgsNXWaLaIGaw/YomjZgU9pII4NXQGaBu7ptzSDjO8ZevIJ3A
	 Lr1MALFUgBfjLt8s+WkXAJiEagLVemd+FTxA4jg0D+Frk4DlO+5f1pMiOy6jxPlXcP
	 X2hF33+AJEHfLETLOng+0Gy2+r4cQtVgf9Xu7p+kUnwNKn1ZIC88/kPuajQ4PaBRKq
	 gLuaXHNax7qElwja1IWVrvChIDMVwPw6C/4197HiMFonxZMmJ/cnEKcpqq9uaECq7U
	 3AyXhD3c0yn51BoAuaczk6CadFECQhl+8n0feyhIVOxGgiOqN47JYKO/vuBa69M5vM
	 liVDrIv21Ys/g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 5/5] f2fs: compress: don't allow unaligned truncation on released compress inode
Date: Mon,  6 May 2024 18:41:40 +0800
Message-Id: <20240506104140.776986-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506104140.776986-1-chao@kernel.org>
References: <20240506104140.776986-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs image may be corrupted after below testcase:
- mkfs.f2fs -O extra_attr,compression -f /dev/vdb
- mount /dev/vdb /mnt/f2fs
- touch /mnt/f2fs/file
- f2fs_io setflags compression /mnt/f2fs/file
- dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=4
- f2fs_io release_cblocks /mnt/f2fs/file
- truncate -s 8192 /mnt/f2fs/file
- umount /mnt/f2fs
- fsck.f2fs /dev/vdb

[ASSERT] (fsck_chk_inode_blk:1256)  --> ino: 0x5 has i_blocks: 0x00000002, but has 0x3 blocks
[FSCK] valid_block_count matching with CP             [Fail] [0x4, 0x5]
[FSCK] other corrupted bugs                           [Fail]

The reason is: partial truncation assume compressed inode has reserved
blocks, after partial truncation, valid block count may change w/
i_blocks and .total_valid_block_count update, result in corruption.

This patch only allow cluster size aligned truncation on released
compress inode for fixing.

Fixes: c61404153eb6 ("f2fs: introduce FI_COMPRESS_RELEASED instead of using IMMUTABLE bit")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3f0db351e976..ac9d6380e433 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -952,9 +952,14 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				  ATTR_GID | ATTR_TIMES_SET))))
 		return -EPERM;
 
-	if ((attr->ia_valid & ATTR_SIZE) &&
-		!f2fs_is_compress_backend_ready(inode))
-		return -EOPNOTSUPP;
+	if ((attr->ia_valid & ATTR_SIZE)) {
+		if (!f2fs_is_compress_backend_ready(inode))
+			return -EOPNOTSUPP;
+		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
+			(attr->ia_size %
+			F2FS_BLK_TO_BYTES(F2FS_I(inode)->i_cluster_size)))
+			return -EINVAL;
+	}
 
 	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
-- 
2.40.1


