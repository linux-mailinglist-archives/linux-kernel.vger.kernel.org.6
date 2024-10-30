Return-Path: <linux-kernel+bounces-388475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910789B602F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279A9283B35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3F1E284E;
	Wed, 30 Oct 2024 10:32:25 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7D1D278D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284345; cv=none; b=lviKuCiGto5J0t/B+0XvTP1PIkjEliT19O2lq2Nhl4DyLlKxFHNT39ctH1eex4SlWuWn0WlsX2w1Hj6jeSov38bKT9rB022xqe+W37rWla2tHarHeH25AEgHKFKEEmKNj+DpVhgvLs+jOwJ068FOMaDokKDppBlkTNIVa4bPje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284345; c=relaxed/simple;
	bh=3GVtOXyyD93rLRf/4WDDUmXb6p+JsYf2GMu2Iy6RY3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFAxLRNNUszKyjrQk+5aTbiJwlTZrtM9cBz4vR/DGxZpiVs1kdw4GgTeTBTnypwoza0iCcoEimavG4aXA95OYbJuvAQugAXabho5v3RWpSJ0GDNfBeNzCfwuzGPETQtCZIFe4S8YcfT+Jint0hpjyva9QxC00bW4EIlSrx0lqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49UAVhEW026848;
	Wed, 30 Oct 2024 18:31:43 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xdk1P5JHRz2KSK4X;
	Wed, 30 Oct 2024 18:31:05 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 30 Oct 2024 18:31:41 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v2 3/5] f2fs: add parameter @len to f2fs_invalidate_internal_cache()
Date: Wed, 30 Oct 2024 18:31:34 +0800
Message-ID: <20241030103136.2874140-4-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030103136.2874140-1-yi.sun@unisoc.com>
References: <20241030103136.2874140-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49UAVhEW026848

New function can process some consecutive blocks at a time.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/data.c    | 2 +-
 fs/f2fs/f2fs.h    | 6 +++---
 fs/f2fs/gc.c      | 2 +-
 fs/f2fs/segment.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 90fa8ab85194..37bc747aac89 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1420,7 +1420,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 		return err;
 
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
-		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
+		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);
 
 	f2fs_update_data_blkaddr(dn, dn->data_blkaddr);
 	return 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d3fe66a93a56..addd49af57ec 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4757,10 +4757,10 @@ static inline void f2fs_truncate_meta_inode_pages(struct f2fs_sb_info *sbi,
 }
 
 static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
-								block_t blkaddr)
+						block_t blkaddr, unsigned int len)
 {
-	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
-	f2fs_invalidate_compress_pages_range(sbi, blkaddr, 1);
+	f2fs_truncate_meta_inode_pages(sbi, blkaddr, len);
+	f2fs_invalidate_compress_pages_range(sbi, blkaddr, len);
 }
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e40bdd12e36d..155c1a4a0d74 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1410,7 +1410,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				page_address(mpage), PAGE_SIZE);
 	f2fs_put_page(mpage, 1);
 
-	f2fs_invalidate_internal_cache(fio.sbi, fio.old_blkaddr);
+	f2fs_invalidate_internal_cache(fio.sbi, fio.old_blkaddr, 1);
 
 	set_page_dirty(fio.encrypted_page);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a5bd101c63a1..92ddff285a65 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2567,7 +2567,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 		return;
 
-	f2fs_invalidate_internal_cache(sbi, addr);
+	f2fs_invalidate_internal_cache(sbi, addr, 1);
 
 	/* add it into sit main buffer */
 	down_write(&sit_i->sentry_lock);
@@ -3845,7 +3845,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		goto out;
 	}
 	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
-		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr);
+		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr, 1);
 
 	/* writeout dirty page into bdev */
 	f2fs_submit_page_write(fio);
@@ -4037,7 +4037,7 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		update_sit_entry(sbi, new_blkaddr, 1);
 	}
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO) {
-		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
+		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);
 		if (!from_gc)
 			update_segment_mtime(sbi, old_blkaddr, 0);
 		update_sit_entry(sbi, old_blkaddr, -1);
-- 
2.25.1


