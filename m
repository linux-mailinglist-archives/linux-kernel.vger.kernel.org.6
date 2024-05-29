Return-Path: <linux-kernel+bounces-193905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC478D33E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A411C2264E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95689179957;
	Wed, 29 May 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfbNOE2E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A6178CCD
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976871; cv=none; b=Trrs6NAbVDYbAp8YlZOdglx8Gn0czX8chg8KzNJ2UEpq/aQ6Pbsem4sSQ+aBe8MJhjbJ/xb6aoGDCPyOjGggr2t4i5dLNY9a9AhUff9hK0IcoHtyOSMGTi9s3c7fC8HkzMmCC0PGdnruuFQOAtJHoN+WE2ReVecGu/EkvtZ29ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976871; c=relaxed/simple;
	bh=L7R4kCrVdkA/TC10eCp9qRWAc3qUaQIFe050f7cF73U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lq7X+9RUyHZFp4rVxlLUSYobS4B3hma0af8h6ICjUTnpk6/cMpAP3iLGaYG40GKQR/yTFzYneNP7tYPqbP5E9mdzNAFeHf+uMTcfUr0EUhPH3lSUhrQF1cvalXUZmgWQfgFwygGilmyxtERPQsCZ6p2BzRVQcoMXlS8vmGhNzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfbNOE2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075F8C32781;
	Wed, 29 May 2024 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976871;
	bh=L7R4kCrVdkA/TC10eCp9qRWAc3qUaQIFe050f7cF73U=;
	h=From:To:Cc:Subject:Date:From;
	b=BfbNOE2EwJ150dW1NbUWRK2354DfLSxWJs1lbcASlZb5gHhuG/g/xEFu7peFMyXz3
	 MUOQ0/Eg37WklBN7V6ompNAq5r9WRqqIBGFepdl57/sbYnKGlbsVgIT6xdxPPTVtdo
	 Oqs/j4YuMw2uw//COEEvDSX9c37reqZg4Muk8z3Y3qoSTffYzVc/hoslnZZ4kanfN4
	 C7nwn1fOXM9KGSSOH5eUoCQn3Dzt7piLxMfLwkBRQfFXd2U5L2VOgWpozP8dc8DrTG
	 px90Tk6pAErwd7NT+nwxl2GnYIOyBqNflSkESzg/dmu6bRGBLw5KFQeriGuwci33bD
	 j3xM2DlRJ/v5g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	chenyuwen <yuwen.chen@xjmz.com>
Subject: [PATCH v2] f2fs: fix to truncate preallocated blocks in f2fs_file_open()
Date: Wed, 29 May 2024 18:01:03 +0800
Message-Id: <20240529100103.329778-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chenyuwen reports a f2fs bug as below:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000011
 fscrypt_set_bio_crypt_ctx+0x78/0x1e8
 f2fs_grab_read_bio+0x78/0x208
 f2fs_submit_page_read+0x44/0x154
 f2fs_get_read_data_page+0x288/0x5f4
 f2fs_get_lock_data_page+0x60/0x190
 truncate_partial_data_page+0x108/0x4fc
 f2fs_do_truncate_blocks+0x344/0x5f0
 f2fs_truncate_blocks+0x6c/0x134
 f2fs_truncate+0xd8/0x200
 f2fs_iget+0x20c/0x5ac
 do_garbage_collect+0x5d0/0xf6c
 f2fs_gc+0x22c/0x6a4
 f2fs_disable_checkpoint+0xc8/0x310
 f2fs_fill_super+0x14bc/0x1764
 mount_bdev+0x1b4/0x21c
 f2fs_mount+0x20/0x30
 legacy_get_tree+0x50/0xbc
 vfs_get_tree+0x5c/0x1b0
 do_new_mount+0x298/0x4cc
 path_mount+0x33c/0x5fc
 __arm64_sys_mount+0xcc/0x15c
 invoke_syscall+0x60/0x150
 el0_svc_common+0xb8/0xf8
 do_el0_svc+0x28/0xa0
 el0_svc+0x24/0x84
 el0t_64_sync_handler+0x88/0xec

It is because inode.i_crypt_info is not initialized during below path:
- mount
 - f2fs_fill_super
  - f2fs_disable_checkpoint
   - f2fs_gc
    - f2fs_iget
     - f2fs_truncate

So, let's relocate truncation of preallocated blocks to f2fs_file_open(),
after fscrypt_file_open().

Fixes: d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
Reported-by: chenyuwen <yuwen.chen@xjmz.com>
Closes: https://lore.kernel.org/linux-kernel/20240517085327.1188515-1-yuwen.chen@xjmz.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- only handle FADVISE_TRUNC_BIT for first open()
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/inode.c |  8 --------
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f463961b497c..9118a4e2db6d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -803,6 +803,7 @@ enum {
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
+	FI_OPENED_FILE,		/* indicate file has been opened */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5c0b281a70f3..d35190994a67 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -554,6 +554,42 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int finish_preallocate_blocks(struct inode *inode)
+{
+	int ret;
+
+	inode_lock(inode);
+	if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
+		inode_unlock(inode);
+		return 0;
+	}
+
+	if (!file_should_truncate(inode)) {
+		set_inode_flag(inode, FI_OPENED_FILE);
+		inode_unlock(inode);
+		return 0;
+	}
+
+	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
+
+	truncate_setsize(inode, i_size_read(inode));
+	ret = f2fs_truncate(inode);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
+	if (!ret)
+		set_inode_flag(inode, FI_OPENED_FILE);
+
+	inode_unlock(inode);
+	if (ret)
+		return ret;
+
+	file_dont_truncate(inode);
+	return 0;
+}
+
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int err = fscrypt_file_open(inode, filp);
@@ -571,7 +607,11 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	filp->f_mode |= FMODE_NOWAIT;
 	filp->f_mode |= FMODE_CAN_ODIRECT;
 
-	return dquot_file_open(inode, filp);
+	err = dquot_file_open(inode, filp);
+	if (err)
+		return err;
+
+	return finish_preallocate_blocks(inode);
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 33b2778d5452..4b39aebd3c70 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -610,14 +610,6 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	}
 	f2fs_set_inode_flags(inode);
 
-	if (file_should_truncate(inode) &&
-			!is_sbi_flag_set(sbi, SBI_POR_DOING)) {
-		ret = f2fs_truncate(inode);
-		if (ret)
-			goto bad_inode;
-		file_dont_truncate(inode);
-	}
-
 	unlock_new_inode(inode);
 	trace_f2fs_iget(inode);
 	return inode;
-- 
2.40.1


