Return-Path: <linux-kernel+bounces-171497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31328BE52A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A261B22106
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C221D15F3E2;
	Tue,  7 May 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnJzb3bI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F32156C7A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090765; cv=none; b=Dc//fgAW/RAWN+rdiHiyAjgFvvxtZix+cMCX7PM4/CbkkD2DYwmlBlVkaZTO9Kbxb5+5cR5JP5eWByxk9PlfbgVxAk7FZHYt9eOh7lxJpTkLL/DOJaYZSmmtJcwh8uoJJoaWgW+nBUz4K35R26jCD/tc3IyUNyz37r1pJ7xEvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090765; c=relaxed/simple;
	bh=t2Zobjc7MI6+ixD8KnilMidW0woMS15GwGLeKi1FmbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PLYniHDp9blEk5Y8KvPRaRb1+MXhr/kKrFABCYPlL/PN5CI4nfaq4zDyg3EPvSWoJGZ2NuqfAJsoEUHZXpaRNR7nIcLU93H7S1xYRipmNnZ4+rTPoAE9W8IUAsiLXzZ2+DOxXjOz+ZIJpD4buF6QuBuqB3t2mIO75RVq3pLt2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnJzb3bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54827C2BBFC;
	Tue,  7 May 2024 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715090764;
	bh=t2Zobjc7MI6+ixD8KnilMidW0woMS15GwGLeKi1FmbM=;
	h=From:To:Cc:Subject:Date:From;
	b=YnJzb3bIQFe3kLH190BdMGPr0E/HvQ4xdxZGybOaO0N2371wx4TdQn1Qlpnc4pqMc
	 yuDw2t8/UehvZupwNXyC2fmmU5nmGiECGwUcGjy/LnJ4Q4YmAFMb+jQiLT2PjXkgqc
	 31l/kzAmeZlDUF5hxsnytnFkn0TUkXrS6ebSKySBtDGqYWJiwFVjkUgO+UPdA/0vXn
	 DHojnbLRKJJhT8C5DfTqXFbXrjdZnTU5pvNlK87FWDc0+sr0n4RghyFC9hJ36dt2n1
	 oduTM/T+Hj82UmNM3cqeUePZ4ohusMGBu7bfrDYxXaZOXcOrhpiq+13shK1VhoW7WP
	 rE71W4TunDKBg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid racing in between buffered read and OPU dio write
Date: Tue,  7 May 2024 22:05:56 +0800
Message-Id: <20240507140556.1293003-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If lfs mode is on, buffered read may race w/ OPU dio write as below,
it may cause buffered read hits unwritten data unexpectly.

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
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 20 ++++++++++++++++++--
 fs/f2fs/super.c |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 145b985bf252..b69ec1109572 100644
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
index ef4cfb4436ef..c761db952b37 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4545,7 +4545,13 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -4770,14 +4776,22 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
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
@@ -4801,8 +4815,10 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
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


