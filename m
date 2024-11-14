Return-Path: <linux-kernel+bounces-408689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2575F9C8256
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FC1B249E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238DE17B401;
	Thu, 14 Nov 2024 05:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vo3JBX4S"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402916EB76
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731561619; cv=none; b=nZK2yqZ3FeU2vg7KTBjlDqBq7t6Ek5tYRW/uO7U2RNkVkiOpgioc03uYQ1127p6Yo0gDuZaDcmYDtcw41c1EtV/vh4k4wnrcbZVApi0fjpk8jxD7dEFiiqELJqGPB+W4Y+yVanrYNaJSGeib/ecyJ6CxgOZ9I8egzzjYWwBAv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731561619; c=relaxed/simple;
	bh=H8amFsZPdnvP0Hq+MsKjVRFwvn1m2U0rZLB+EX4UTZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBTBIE2AdNgxfXsCM2TXnzmMH6+gaP3VqZQkh3T8bW6zQ/3osRDl7YCXq3P9CV929XjOqNqEe3eu8gKHPSG0Ft1foVJBH1k2Bi0BXamJ5FKIHT5OzuIBqfDd+NkrepEtNbKFm5bRMliyIE+yO3Vwve+3XOhI181HnqJzWj+CW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vo3JBX4S; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731561607; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LBovoTp6LXztaTEv4dhpi+GGkF4r/KEIcGS31ovBYVk=;
	b=vo3JBX4SheDY9vy7f3aQ4zfeneiX9Kp5Zn5qh9+J2rdMLZWcK1bVc4D/C71dQqmMn7zmZSSErPYfw61ccw0SyomGPAIM54LPk41jHV9iRJKeExRXugA0I/yjbsxezAqmg9DzgL42IrdPCB7AXJP57QJEva5aScpfwkME0t/bsek=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJNFjtS_1731561599 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 13:20:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Subject: [PATCH] erofs: fix file-backed mounts over FUSE
Date: Thu, 14 Nov 2024 13:19:57 +0800
Message-ID: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
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
Fixes: fb176750266a ("erofs: add file-backed mount support")
Closes: https://lore.kernel.org/r/6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 10 +++++++---
 fs/erofs/internal.h |  6 +++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6355866220ff..43c89194d348 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -38,7 +38,10 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 	}
 	if (!folio || !folio_contains(folio, index)) {
 		erofs_put_metabuf(buf);
-		folio = read_mapping_folio(buf->mapping, index, NULL);
+		folio = buf->use_fp ?
+			read_mapping_folio(file_inode(buf->filp)->i_mapping,
+				index, buf->filp) :
+			read_mapping_folio(buf->mapping, index, NULL);
 		if (IS_ERR(folio))
 			return folio;
 	}
@@ -61,8 +64,9 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fileio_mode(sbi))
-		buf->mapping = file_inode(sbi->fdev)->i_mapping;
+	buf->use_fp = erofs_is_fileio_mode(sbi);
+	if (buf->use_fp)	/* some fs like FUSE needs it */
+		buf->filp = sbi->fdev;
 	else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->s_fscache->inode->i_mapping;
 	else
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5459d0b39415..df67a1980ada 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -208,10 +208,14 @@ enum erofs_kmap_type {
 };
 
 struct erofs_buf {
-	struct address_space *mapping;
+	union {
+		struct address_space *mapping;
+		struct file *filp;
+	};
 	struct page *page;
 	void *base;
 	enum erofs_kmap_type kmap_type;
+	bool use_fp;
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
 
-- 
2.43.5


