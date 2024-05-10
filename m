Return-Path: <linux-kernel+bounces-175219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A98C1C82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A31C213FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5191442F1;
	Fri, 10 May 2024 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqMOeopC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78693308A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715308754; cv=none; b=DOW9j8/xanDcKJucGcwDd2J+1whaW7/9Cx+KjCrgURLdpNZAcdbhHKDyaNJBPHG2rG2Fe8rLD8tx9VGzGa04RrIuLimyZbPKZF4BFo0ibAdW+YpaWJEPHanlNm+Vqldfvn38ERObF8j+p8bsuz5giOPxHcUSEr+9n4L1Y/qDM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715308754; c=relaxed/simple;
	bh=M3iK44q4XaDBGfbEx+OpWbmqokN+nvYknGFBDDBsslM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSIQBXPJpyeOTpQw63Vy00I6hBK++O8gIeIjvIiCE2smZ4Hbsl++WaaEhbmzL7DBJ+L8L+gD1vT9AfRajbw6uA2a8D/wPXdYkBbdM2AO6bZseYXzmp/+1c1bwVYh1Jr9cnFpaiOds+G62nviRxgJj0WMHj3xIG/h/BUvMB5hQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqMOeopC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD39C116B1;
	Fri, 10 May 2024 02:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715308754;
	bh=M3iK44q4XaDBGfbEx+OpWbmqokN+nvYknGFBDDBsslM=;
	h=From:To:Cc:Subject:Date:From;
	b=DqMOeopC5rR16hKDZK7Cd4bMFWFhJs8c2volLMTdFdL3rj5urU9Vo36UaR0n9B2sP
	 bBe9S9+Ra4i160s7SEsY/+aiO1BeGFPNiJt5TNsHVYuYKoFM5vc+PjfOjCLnjqBItb
	 BGh3SFIxjtVkQuc8XoTZZwokVMR0+ximqKniJNBMQeOJBHkcBbbLviEvANx0jHFmdS
	 RiT1vtHW+c+hOw/Totn4leoaPkqacGkkS2Brr2Gg9qhcJEEqvyhqbciRyk9VPtyaxo
	 bQpNI23maOeAe4EckcnGqQ/kj/cup3zsut0L68wCJcxCyteWyRqUrtmW9gYq9hk/yG
	 UMO2tAUptA+3A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to avoid racing in between read and OPU dio write
Date: Fri, 10 May 2024 10:39:06 +0800
Message-Id: <20240510023906.281700-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If lfs mode is on, buffered read may race w/ OPU dio write as below,
it may cause buffered read hits unwritten data unexpectly, and for
dio read, the race condition exists as well.

Thread A			Thread B
- f2fs_file_write_iter
 - f2fs_dio_write_iter
  - __iomap_dio_rw
   - f2fs_iomap_begin
    - f2fs_map_blocks
     - __allocate_data_block
      - allocated blkaddr #x
       - iomap_dio_submit_bio
				- f2fs_file_read_iter
				 - filemap_read
				  - f2fs_read_data_folio
				   - f2fs_mpage_readpages
				    - f2fs_map_blocks
				     : get blkaddr #x
				    - f2fs_submit_read_bio
				IRQ
				- f2fs_read_end_io
				 : read IO on blkaddr #x complete
IRQ
- iomap_dio_bio_end_io
 : direct write IO on blkaddr #x complete

This patch introduces a new per-inode i_opu_rwsem lock to avoid
such race condition.

Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to cover dio read path w/ i_opu_rwsem as well.
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 28 ++++++++++++++++++++++++++--
 fs/f2fs/super.c |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 30058e16a5d0..91cf4b3d6bc6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -847,6 +847,7 @@ struct f2fs_inode_info {
 	/* avoid racing between foreground op and gc */
 	struct f2fs_rwsem i_gc_rwsem[2];
 	struct f2fs_rwsem i_xattr_sem; /* avoid racing between reading and changing EAs */
+	struct f2fs_rwsem i_opu_rwsem;	/* avoid racing between buf read and opu dio write */
 
 	int i_extra_isize;		/* size of extra space located in i_addr */
 	kprojid_t i_projid;		/* id for project quota */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 72ce1a522fb2..4ec260af321f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4445,6 +4445,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	const loff_t pos = iocb->ki_pos;
 	const size_t count = iov_iter_count(to);
 	struct iomap_dio *dio;
+	bool do_opu = f2fs_lfs_mode(sbi);
 	ssize_t ret;
 
 	if (count == 0)
@@ -4457,8 +4458,14 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			ret = -EAGAIN;
 			goto out;
 		}
+		if (do_opu && !f2fs_down_read_trylock(&fi->i_opu_rwsem)) {
+			f2fs_up_read(&fi->i_gc_rwsem[READ]);
+			ret = -EAGAIN;
+			goto out;
+		}
 	} else {
 		f2fs_down_read(&fi->i_gc_rwsem[READ]);
+		f2fs_down_read(&fi->i_opu_rwsem);
 	}
 
 	/*
@@ -4477,6 +4484,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		ret = iomap_dio_complete(dio);
 	}
 
+	f2fs_up_read(&fi->i_opu_rwsem);
 	f2fs_up_read(&fi->i_gc_rwsem[READ]);
 
 	file_accessed(file);
@@ -4523,7 +4531,13 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (f2fs_should_use_dio(inode, iocb, to)) {
 		ret = f2fs_dio_read_iter(iocb, to);
 	} else {
+		bool do_opu = f2fs_lfs_mode(F2FS_I_SB(inode));
+
+		if (do_opu)
+			f2fs_down_read(&F2FS_I(inode)->i_opu_rwsem);
 		ret = filemap_read(iocb, to, 0);
+		if (do_opu)
+			f2fs_up_read(&F2FS_I(inode)->i_opu_rwsem);
 		if (ret > 0)
 			f2fs_update_iostat(F2FS_I_SB(inode), inode,
 						APP_BUFFERED_READ_IO, ret);
@@ -4748,14 +4762,22 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 			ret = -EAGAIN;
 			goto out;
 		}
+		if (do_opu && !f2fs_down_write_trylock(&fi->i_opu_rwsem)) {
+			f2fs_up_read(&fi->i_gc_rwsem[READ]);
+			f2fs_up_read(&fi->i_gc_rwsem[WRITE]);
+			ret = -EAGAIN;
+			goto out;
+		}
 	} else {
 		ret = f2fs_convert_inline_inode(inode);
 		if (ret)
 			goto out;
 
 		f2fs_down_read(&fi->i_gc_rwsem[WRITE]);
-		if (do_opu)
+		if (do_opu) {
 			f2fs_down_read(&fi->i_gc_rwsem[READ]);
+			f2fs_down_write(&fi->i_opu_rwsem);
+		}
 	}
 
 	/*
@@ -4779,8 +4801,10 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		ret = iomap_dio_complete(dio);
 	}
 
-	if (do_opu)
+	if (do_opu) {
+		f2fs_up_write(&fi->i_opu_rwsem);
 		f2fs_up_read(&fi->i_gc_rwsem[READ]);
+	}
 	f2fs_up_read(&fi->i_gc_rwsem[WRITE]);
 
 	if (ret < 0)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index daf2c4dbe150..b4ed3b094366 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1428,6 +1428,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_f2fs_rwsem(&fi->i_gc_rwsem[READ]);
 	init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
 	init_f2fs_rwsem(&fi->i_xattr_sem);
+	init_f2fs_rwsem(&fi->i_opu_rwsem);
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
-- 
2.40.1


