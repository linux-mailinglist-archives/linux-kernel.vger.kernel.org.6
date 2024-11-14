Return-Path: <linux-kernel+bounces-410091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D79C9665
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2734328186E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B41B0F04;
	Thu, 14 Nov 2024 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YH4mBdzW"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954D4CB36
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628154; cv=none; b=OiaDX07coqv0FbJVjO67bm8GfR8c0b44ay8M2rb8kogpajIyqah2e6A8pbpTHdlqnNB6evEyO4OYImmwfEzkqGel7jBBNk0Qz/9wY8dfwNuXWlOeACUnyKgibtVgmJLEuZQET3Gq03ojuRyGIXydupi2kzBV5uBcSwsFrBnybBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628154; c=relaxed/simple;
	bh=jp4BvhE+gXc1W0KUkeF8QXDsyPN6qJep/pOLvVyPzF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+juKTO4ecE4cKcSQc15xG6HJC/v3P7GdXttO1nB9VeuCYCOODwTF3iByKYyUsv1rCT6YggkzdMEW1KWIV3CeB7nmCRYP2ukvEEtsR9ojHa8qJw1UijET0Xae9gyiTZrADMgPeKlIBncSkSS0iibjqGzP9sh71WD3FVfbqhkHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YH4mBdzW; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731628148; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7KvcB1KztsR3lLpg/1Ms3SRcWCtnXERwAb7ZmDuyOGg=;
	b=YH4mBdzWQ1IJAThpQJxBojnAdxClzTJKs+kWiMWv7Xb2ZlnALewEIIzNZYThc4uiQCcF1jVjI/WNRwQCKxWwzoI8zOS8ZuwKqSjgHBdr7X7IHbo957uzPtWdVrZkdroOJPx7ofk5ZNvvCWQTOwdFTWf6gcYaZzpABswNTndF1Hk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJQR2zF_1731628147 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 07:49:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Subject: [PATCH v3 RESEND] erofs: fix file-backed mounts over FUSE
Date: Fri, 15 Nov 2024 07:49:05 +0800
Message-ID: <20241114234905.1873723-1-hsiangkao@linux.alibaba.com>
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
v2: https://lore.kernel.org/r/20241114090109.757690-1-hsiangkao@linux.alibaba.com
Changes since v2:
 - set *both* ->mapping and ->file suggested by Al.

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


