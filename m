Return-Path: <linux-kernel+bounces-410090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AD59C9661
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D216FB27931
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D71B3935;
	Thu, 14 Nov 2024 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fi1ViBQX"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE01B0F02
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628020; cv=none; b=rgeKzooZvuz2bsLg0uxjA2C6P+yJefp9sBM6pSFZ2CxNflXCfZ4lb8GIBowzrqEdBw+nMoXT3jKYNFg57yz8VGoHux6Hfnvbr+iWf5PRMi76yQClGj7+hgutBRcg5xu2iQHSzUduHEmCftpgwzac6SwMFP+s0CRueMSwER0DFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628020; c=relaxed/simple;
	bh=yrVvJ34GB8/VlenAqjh8M0UQs6i+GPEJGbsKhktT0xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cv2F8JZKtLnemuYmB3Y8nMjZLHkXXhbLcoqQXjfFZJBLyTE0q0IacNafMRHaUIifm+D31ZjkK0uKfn24x9OP4iufH5WYWqHaRsZ5+GlCSabwOx/EKAOTAstrhP/5xWUtrGPGWvmIoWwMEv+NvmZYtk+iGE7cf8AWMUgl+qk7i5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fi1ViBQX; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731628014; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NBLWn+9ZRmZh4zgtQxM7V9zX0Xit4je+p0sF89bHnbk=;
	b=Fi1ViBQXNObtUxQFHZEaE/0weMndoMzYIQ16Bv+pDE8BERXO+eUf7NH7vJcUH+G5eGAY362yb/H3X4e+niNo+/ftm2v9rfZXB6VBhaH82BUTyFqgfjwrX+27/KBfDLrADafesqgljrkCUTBmkC6ocW8AiZ0nP1Xg75Q4DWv6ACs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJQR2BP_1731628007 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 07:46:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Subject: [PATCH] erofs: fix file-backed mounts over FUSE
Date: Fri, 15 Nov 2024 07:46:46 +0800
Message-ID: <20241114234646.1870545-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a null-ptr-deref in fuse_read_args_fill:
 fuse_read_folio+0xb0/0x100 fs/fuse/file.c:905
 filemap_read_folio+0xc6/0x2a0 mm/filemap.c:2367
 do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3825
 read_mapping_folio include/linux/pagemap.h:1011 [inline]
 erofs_bread+0x34d/0x7e0 fs/erofs/data.c:41
 erofs_read_superblock fs/erofs/super.c:281 [inline]
 erofs_fc_fill_super+0x2b9/0x2500 fs/erofs/super.c:625

Unlike most filesystems, some network filesystems and FUSE need
unavoidable valid `file` pointers for their read I/Os [1].
Anyway, those use cases need to be supported too.

[1] https://docs.kernel.org/filesystems/vfs.html
Reported-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com
Fixes: fb176750266a ("erofs: add file-backed mount support")
Tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 10 ++++++----
 fs/erofs/internal.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6355866220ff..db4bde4c0852 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -38,7 +38,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 	}
 	if (!folio || !folio_contains(folio, index)) {
 		erofs_put_metabuf(buf);
-		folio = read_mapping_folio(buf->mapping, index, NULL);
+		folio = read_mapping_folio(buf->mapping, index, buf->file);
 		if (IS_ERR(folio))
 			return folio;
 	}
@@ -61,9 +61,11 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fileio_mode(sbi))
-		buf->mapping = file_inode(sbi->fdev)->i_mapping;
-	else if (erofs_is_fscache_mode(sb))
+	buf->file = NULL;
+	if (erofs_is_fileio_mode(sbi)) {
+		buf->file = sbi->fdev;		/* some fs like FUSE needs it */
+		buf->mapping = buf->file->f_mapping;
+	} else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->s_fscache->inode->i_mapping;
 	else
 		buf->mapping = sb->s_bdev->bd_mapping;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5459d0b39415..9844ee8a07e5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -209,6 +209,7 @@ enum erofs_kmap_type {
 
 struct erofs_buf {
 	struct address_space *mapping;
+	struct file *file;
 	struct page *page;
 	void *base;
 	enum erofs_kmap_type kmap_type;
-- 
2.43.5


