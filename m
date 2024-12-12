Return-Path: <linux-kernel+bounces-443129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12D9EE7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A26D282D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F38213E9E;
	Thu, 12 Dec 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MwNQEW91"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AD2135C3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010519; cv=none; b=pnk7eDJo4OKwvsWKqwLLDnqyIvoZJcl43RYt/Pk0mYtGmUaKNxjyHboygLooIVSkvdVdbE2KoIKkj/KciswB2COMA/dREYZi0ObaTzporxg/v79p1rN7E+9IRrQ4CU/tq1g/KWNIuZmqkLSgktZcOIeGPgOc3afJPIDhRXTXhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010519; c=relaxed/simple;
	bh=jHWYbDUxHOT3K5iveDt+VlM2QAksn5TmjMMrbYhrKpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUgxRE1MSiOYbLXhGMTK67YuLG9Eqis2hRSUbD1MpL/9vUxNaTQsCPy3JdFdZe1rB2Mc/fC7qcUmWfU8jPAEZPCEek8/y8So1GRqNQGFc5voav49EehfSOQ5iJbSjgD7k30gMIAPgPfO9icE7+oM3zOv8QyRkASOErL3/e0KkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MwNQEW91; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734010513; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EA5SowTZmmM8Pbs3enBjnTmgnEvA/lWTg2GbvxtnxWs=;
	b=MwNQEW91E/pk9BZ9OSXw7KgWe+HMK63mmD+9ho+5wDdEMd+wrWXytAvsa2nHdYCM+6lNpqFk2ZM10DkMZgmvVDv9jkjUaO8/CMjvdvqAF84kmcJdkRzP/4S9e7tJqwFPanrn9827jqg+bdv2UrqC0/kFSTC1LWyTa2+L9NdJeZc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLLvJq1_1734010511 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 21:35:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/4] erofs: reference `struct erofs_device_info` for erofs_map_dev
Date: Thu, 12 Dec 2024 21:35:03 +0800
Message-ID: <20241212133504.2047178-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212133504.2047178-1-hsiangkao@linux.alibaba.com>
References: <20241212133504.2047178-1-hsiangkao@linux.alibaba.com>
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

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 26 ++++++++++----------------
 fs/erofs/fileio.c   |  2 +-
 fs/erofs/internal.h |  6 ++----
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0b0385fa3025..63840971976c 100644
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
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6e91fcdeba94..59e7739b7c3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -354,11 +354,9 @@ enum {
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


