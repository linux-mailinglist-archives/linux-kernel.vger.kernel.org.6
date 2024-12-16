Return-Path: <linux-kernel+bounces-447348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8C9F30F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F041882804
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0579204F87;
	Mon, 16 Dec 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="veUo4/av"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9A205519
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353610; cv=none; b=g/Cfkqm3MYBYbHt/YLITYNT24+0L4u08qF7eIidPImbD5e9XS6Pc+rSDvq+V/ea0iNaMXX3ZX+ost3FyV06sm+xp1gV9wbfw48z213Pev5A8Dv+AU2bUGgwJHKur7jczq9HGwQY1xfpVOu6qAJXJUwaCOOrGzRaYIBXBEVd9qqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353610; c=relaxed/simple;
	bh=Vs8Vk2sIzrEjm3mEn5QcrBZDCeVxWifk9SQeNnopYBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLEfn6yzqaCpjdri+WRwTXWIxKuLy8J7/dWBXBC8MugmsZEIyCQmOQ9PoHCLpHwILpf+QJUlmEKaoXqfl7zWC4ZKVKl+zm3sq/DAVic7IFwT6+aj8XZIY+B2Y6QGwWXRw3DGURK9wyYh28Ect5Dx5JtzYIl8upoQQyMYgt/t/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=veUo4/av; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734353599; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XV56vdeR8lvwiEIUdzTrXuvsQtQGzUpa0TMXen5H4is=;
	b=veUo4/avHmvWmARmlKKjQMxqetQ/VKRhEwGrhHW3hzZHWGpdJzylvKp8sCGF58QtR9eSOfgFdHkq8Ihrcfoji2KkZ+5hzqI6oXxSf+KUIdQqUByBEnvYai4XHgVnZ2AM4JuBJwQvg/zM9kZPhilEaqjMYzdLhNiI6m+APvLyypU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLcksM8_1734353598 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 20:53:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 3/4] erofs: reference `struct erofs_device_info` for erofs_map_dev
Date: Mon, 16 Dec 2024 20:53:09 +0800
Message-ID: <20241216125310.930933-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
References: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record `m_sb` and `m_dif` to replace `m_fscache`, `m_daxdev`, `m_fp`
and `m_dax_part_off` in order to simplify the codebase.

Note that `m_bdev` is still left since it can be assigned from
`sb->s_bdev` directly.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 26 ++++++++++----------------
 fs/erofs/fileio.c   |  2 +-
 fs/erofs/fscache.c  |  4 ++--
 fs/erofs/internal.h |  6 ++----
 4 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 622017c65958..0cd6b5c4df98 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -179,19 +179,13 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 }
 
 static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
-				    struct erofs_device_info *dif)
+		struct super_block *sb, struct erofs_device_info *dif)
 {
+	map->m_sb = sb;
+	map->m_dif = dif;
 	map->m_bdev = NULL;
-	map->m_fp = NULL;
-	if (dif->file) {
-		if (S_ISBLK(file_inode(dif->file)->i_mode))
-			map->m_bdev = file_bdev(dif->file);
-		else
-			map->m_fp = dif->file;
-	}
-	map->m_daxdev = dif->dax_dev;
-	map->m_dax_part_off = dif->dax_part_off;
-	map->m_fscache = dif->fscache;
+	if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
+		map->m_bdev = file_bdev(dif->file);
 }
 
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
@@ -201,7 +195,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	erofs_off_t startoff, length;
 	int id;
 
-	erofs_fill_from_devinfo(map, &EROFS_SB(sb)->dif0);
+	erofs_fill_from_devinfo(map, sb, &EROFS_SB(sb)->dif0);
 	map->m_bdev = sb->s_bdev;	/* use s_bdev for the primary device */
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -215,7 +209,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		erofs_fill_from_devinfo(map, dif);
+		erofs_fill_from_devinfo(map, sb, dif);
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
@@ -228,7 +222,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				erofs_fill_from_devinfo(map, dif);
+				erofs_fill_from_devinfo(map, sb, dif);
 				break;
 			}
 		}
@@ -298,7 +292,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	iomap->offset = map.m_la;
 	if (flags & IOMAP_DAX)
-		iomap->dax_dev = mdev.m_daxdev;
+		iomap->dax_dev = mdev.m_dif->dax_dev;
 	else
 		iomap->bdev = mdev.m_bdev;
 	iomap->length = map.m_llen;
@@ -327,7 +321,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = mdev.m_pa;
 		if (flags & IOMAP_DAX)
-			iomap->addr += mdev.m_dax_part_off;
+			iomap->addr += mdev.m_dif->dax_part_off;
 	}
 	return 0;
 }
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 3af96b1e2c2a..a61b8faec651 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -67,7 +67,7 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 					     GFP_KERNEL | __GFP_NOFAIL);
 
 	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
-	rq->iocb.ki_filp = mdev->m_fp;
+	rq->iocb.ki_filp = mdev->m_dif->file;
 	return rq;
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ce7e38c82719..ce3d8737df85 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -198,7 +198,7 @@ struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
 
 	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
 	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
-	io->io.private = mdev->m_fscache->cookie;
+	io->io.private = mdev->m_dif->fscache->cookie;
 	io->io.end_io = erofs_fscache_bio_endio;
 	refcount_set(&io->io.ref, 1);
 	return &io->bio;
@@ -316,7 +316,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 	if (!io)
 		return -ENOMEM;
 	iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
-	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie,
+	ret = erofs_fscache_read_io_async(mdev.m_dif->fscache->cookie,
 			mdev.m_pa + (pos - map.m_la), io);
 	erofs_fscache_req_io_put(io);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3e8d71d516f4..7cc8e1be04e8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -353,11 +353,9 @@ enum {
 };
 
 struct erofs_map_dev {
-	struct erofs_fscache *m_fscache;
+	struct super_block *m_sb;
+	struct erofs_device_info *m_dif;
 	struct block_device *m_bdev;
-	struct dax_device *m_daxdev;
-	struct file *m_fp;
-	u64 m_dax_part_off;
 
 	erofs_off_t m_pa;
 	unsigned int m_deviceid;
-- 
2.43.5


