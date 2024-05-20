Return-Path: <linux-kernel+bounces-183320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5D48C97A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED591C20EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3BF748D;
	Mon, 20 May 2024 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4N21gwS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5366D53A9
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716168223; cv=none; b=BIAEmzWAquKPVKk4EhTZ+JvHLCfGhBvtz912Eljazc5D8prWJ1GBn1cxSfrSStho8QOsUDWDgROmRhh6/tF1K1LUZmDe/UhQ2qwh+GKTdMBKBsIaFJkBbOJJSQcVavSyxmOKysaUf/zohIXcFvyeKSOrixcrHwNmgCPdJCtmhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716168223; c=relaxed/simple;
	bh=nJaAnZlV7G8UIvdkeNqKnHhMgwTeD6WOS4VGzx9vc6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YAA0MUvw4gD0JuMv3KWfzmjHiDz+jnqXgxvzFrnIP6vqHLDipDoLmrKN2KOky04ah+7SNCnFBS/OwUwcH1IRsqOS5HSd5rGXON/OJxiBkizREh9RI1cLqbrF2pcm6pTkL4Qmn3mS0gcjih0GS1aUxdymwoAKncvuNG8UWtWUamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4N21gwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558AEC32781;
	Mon, 20 May 2024 01:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716168222;
	bh=nJaAnZlV7G8UIvdkeNqKnHhMgwTeD6WOS4VGzx9vc6M=;
	h=From:To:Cc:Subject:Date:From;
	b=F4N21gwSvfnMb1MUqEs20LDkdi0yS+zdHZ6Y2E9zbVjQ6eTkzu5BcGN7aHc3qdEef
	 xoRx5mGcPJLR/kgOkG1Jb8remTckQ5PdLpJdRviKSOj5ZZf7FxLKJNvvGo1lq8unwo
	 dL4mrg1tYe+UByHpqWZxVJIuxO/a23NV1jxP84Dveay5WhUSdHKf0jGpEhrPpaOHdB
	 HTc7HAofECmzxIPIdxtFsiS78wa2ZpNGDTgytAFNJ1K3xejo+ct8bNvIsijtLtf7jJ
	 NAf+UauI3olZTguf9r7COsWto4eXNyXOj8Hwv3FssdlMiHamoug4JbsqZLb5VTg8S1
	 ti0U+Y4uH+TcA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	chenyuwen <yuwen.chen@xjmz.com>
Subject: [PATCH] f2fs: fix to truncate preallocated blocks in f2fs_file_open()
Date: Mon, 20 May 2024 09:23:28 +0800
Message-Id: <20240520012328.516836-1-chao@kernel.org>
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
 fs/f2fs/file.c  | 28 +++++++++++++++++++++++++++-
 fs/f2fs/inode.c |  8 --------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef4cfb4436ef..058fcc83a2fc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -554,6 +554,28 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int finish_preallocate_blocks(struct inode *inode)
+{
+	int ret;
+
+	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_POR_DOING))
+		return 0;
+
+	inode_lock(inode);
+	if (!file_should_truncate(inode)) {
+		inode_unlock(inode);
+		return 0;
+	}
+
+	ret = f2fs_truncate(inode);
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
@@ -571,7 +593,11 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
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
index 005dde72aff3..791c06e159fd 100644
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


