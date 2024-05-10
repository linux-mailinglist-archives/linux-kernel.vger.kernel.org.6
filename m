Return-Path: <linux-kernel+bounces-175250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FDD8C1D07
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E251C21DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA901494CA;
	Fri, 10 May 2024 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPvQG7uC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306913B7AE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312027; cv=none; b=Q5RGpD14q5KMY57Vum2a7myrOcHKpviafatwCeuQCKG7rq8pcMNXWVdpsDCxqpJ3Zrq77mySsKiH5yK5YDvJPQUm0xfc+kcsR3++CN7ucZiMBkWK37LBayHpZ4F5z9LJfimWCCwxQdxMS7+gycjnbLQJmNCNu4qZoEivuHmmu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312027; c=relaxed/simple;
	bh=tQCU8a3DiAlPU9cV1Yzc3NpKh9FJk5rB1BHhgkRcW64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ctp9W4Q+2zqCvYa65ZLUc91vj3HuOdT5cPh2eS5uQ1Zpdxwn/FoBvjgzSNtbzDF2y5wCiwPxTiwbVoG0mMqR5W23E42vCVt+L86ITP30xVW2RDwvgZXh/lRYT/lMxu+Kq55j3AAkEqJTwq0Z/w4zWR9zsH1ZFvVhwpJcbq9171I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPvQG7uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06D3C116B1;
	Fri, 10 May 2024 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715312027;
	bh=tQCU8a3DiAlPU9cV1Yzc3NpKh9FJk5rB1BHhgkRcW64=;
	h=From:To:Cc:Subject:Date:From;
	b=FPvQG7uCqrunIi2zYYEK8kQmFI7UgEMMeCKgSwnzRcOiqBZZf3wbPvmYJ6pkhPDWP
	 A6EbyQBemc961bNMTu+nxSQMfyyzJc/7fsjmWKfQspdiUzLNEO/xMPjIGJL+jootOU
	 EmtHGd9QtVHTIFRan5C/+O6HVZDqnAtdNx1mE9UfoUiEf9mtNKvC+CA1V19311wxX/
	 B/3Yh1KFQqKElwZJvAdKK5w9Bw89hgqkhUcbtw19OQglD2kgoaSsF2UGgrOOHU3N4/
	 fr4B79W88VAwq5uLScMOOTfH1eoBqFyEVwHylGCKBOjXK7AL3fhMOvKAE8uWf5zMeS
	 /wO1VlIjqB2ZQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 5/5] f2fs: compress: don't allow unaligned truncation on released compress inode
Date: Fri, 10 May 2024 11:33:39 +0800
Message-Id: <20240510033339.300331-1-chao@kernel.org>
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
blocks, after partial truncation, valid block count may change w/o
i_blocks and .total_valid_block_count update, result in corruption.

This patch only allow cluster size aligned truncation on released
compress inode for fixing.

Fixes: c61404153eb6 ("f2fs: introduce FI_COMPRESS_RELEASED instead of using IMMUTABLE bit")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- fix typo in commit description: w/ -> w/o
 fs/f2fs/file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7371f485b3f7..15f4222da891 100644
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


