Return-Path: <linux-kernel+bounces-408948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02E9C8574
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A902FB26570
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F11DC05F;
	Thu, 14 Nov 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="urbUAH1w"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595C2AF00
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574885; cv=none; b=fArRtekajd51b+zhNJZoBLBBr3d1INA0y0xeUpufQWqalI3R5KclzU6B2Q6qVpJlXe+GVWfZLEpemwY+eE9ZFDaVs22uc4xtgMLfJFWHaY220yClD9tNhxe8WvHPt/59UE/csyx29kdBHM55ce0A7u8etbZptFpKpudYN/WdVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574885; c=relaxed/simple;
	bh=XveH91dkW9i3WkgUB2g7L6FZixxSguxetejCWKH0KP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhZPktpaRHe4CQ5UM+dIdf7IkP5DWHNIsg3eZvFL6GM6p/83dDuVJ3vMew+21uXA8sizNunL1dNKVdx9irw8oDnJHAPeUjZtxmDwaAPdTLtPNbJUf4MkKpvl1K8m7XzDs4tfg97yGXe5JRkZW60SlznIFHww+mTYdY14cvL+4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=urbUAH1w; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731574878; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lKJhvBz42dMu4u3F31pUKEvxu7rYUsd8zDXVB+ulGXU=;
	b=urbUAH1wwd/6Xv0WUiDnMU03+Ap2a+nTypMGplob6jMPhpoKxgYopRMq6CnWNom16QNXk68LRo87+IdpObGMpoB/qwIVKBrLt3eXZN9gObYvEyZBa/J033Vat9r+Dz4R/s9O887QIh3DRK7gaomAJ4xOk5OfN/1awfYoDgN+IGU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJOA42p_1731574872 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 17:01:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Subject: [PATCH v2] erofs: fix file-backed mounts over FUSE
Date: Thu, 14 Nov 2024 17:01:09 +0800
Message-ID: <20241114090109.757690-1-hsiangkao@linux.alibaba.com>
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
v1: https://lore.kernel.org/r/20241114051957.419551-1-hsiangkao@linux.alibaba.com
changes since v1 (suggested by Al):
 - rename `filp` to `file`;
 - don't use union for `mapping` and `file`.

 fs/erofs/data.c     | 8 +++++---
 fs/erofs/internal.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6355866220ff..f741c3847ff2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -38,7 +38,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 	}
 	if (!folio || !folio_contains(folio, index)) {
 		erofs_put_metabuf(buf);
-		folio = read_mapping_folio(buf->mapping, index, NULL);
+		folio = buf->file ? read_mapping_folio(buf->file->f_mapping,
+					index, buf->file) :
+			read_mapping_folio(buf->mapping, index, NULL);
 		if (IS_ERR(folio))
 			return folio;
 	}
@@ -61,8 +63,8 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fileio_mode(sbi))
-		buf->mapping = file_inode(sbi->fdev)->i_mapping;
+	if (erofs_is_fileio_mode(sbi))	/* some fs like FUSE needs it */
+		buf->file = sbi->fdev;
 	else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->s_fscache->inode->i_mapping;
 	else
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


