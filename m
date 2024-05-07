Return-Path: <linux-kernel+bounces-170735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AEC8BDB43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070CBB2284D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAA86F08E;
	Tue,  7 May 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny7IEwlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93056EB5C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062826; cv=none; b=EtX1gGqHJNIV/xwej+BYEp//MytNV8/ZGVO1lf2ROnqvDT+TpXIuGObZbMNsu+sNAiFHjpxbbiLc+fVD73rn4A7cQ8QcNzg4gharVUv+RrtcsbtjbFEZRE9d4ZOjs/5EUUBdxIszq+vK4chKQSEvpkuFbZ+c3V2UBq4R1WsEg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062826; c=relaxed/simple;
	bh=xpV/nMuQfBh/yww28aaTVU+mxRQ+Qd7MQI6xXDS/QtE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NgZ3BeLBp71e4Svw7UIohmcAyr3r+TWk7Ew3msZI4usLkNqNUKslSP3Xc4gfKud4ITrmCrBzppUSXwuYvi86nyheBC5hU/UE6hhGkvUNFfCWoUI+khx3btPKmlYb1B2kpCg6CvaTPJR5ZtsB2gEFz04IcMCpiv+1gdT45Pq8F2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny7IEwlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB70C2BBFC;
	Tue,  7 May 2024 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715062826;
	bh=xpV/nMuQfBh/yww28aaTVU+mxRQ+Qd7MQI6xXDS/QtE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ny7IEwlYDjKPkuW7sQuFVUIV+twKDFaKkaFI2EnsKMZSNDGHsiOACxYZ3ZsLjPkPQ
	 xsn2thhcDhBtKKqB5c3woONt7bKMxoQpZgrJ6uCO8m3rLKewTLNraO+ecg+Y2PVgat
	 14HASIEVf1zQ9AgNsDUYBsSUq4YQFKjqZKUCYqlKNQkRptsE/8gvN94g9l7OTglt8Q
	 iYJ4ZkSE4MfK8FuvV5eFRZf0vn5zNYv/lnqUC0fT7jNuOHhSyee5cikPkpbmda6Ixg
	 QAFO7Q0WPiOccyX0l9h8MxQQE1S0UsC57UcFJ0bmShmAEeyqW5QPgUDHaakJLywy9W
	 kX4zhkpynMiKg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 5/5] f2fs: compress: don't allow unaligned truncation on released compress inode
Date: Tue,  7 May 2024 14:20:19 +0800
Message-Id: <20240507062019.1097683-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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
v2:
- fix compile warning reported by lkp.
 fs/f2fs/file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3f0db351e976..0c8194dc6807 100644
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
+			!IS_ALIGNED(attr->ia_size,
+			F2FS_BLK_TO_BYTES(F2FS_I(inode)->i_cluster_size)))
+			return -EINVAL;
+	}
 
 	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
-- 
2.40.1


