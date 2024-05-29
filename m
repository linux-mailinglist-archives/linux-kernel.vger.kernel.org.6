Return-Path: <linux-kernel+bounces-193723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994BF8D311D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F677293080
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCF5169373;
	Wed, 29 May 2024 08:23:04 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F216191E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970984; cv=none; b=Ys8EWeVe0vARXBw++9JvGWu9udLFn+36t7alsA6YSx2tIZF9DM2I7Hl1LA89tfj5QXUnTf70f+AhJJKkPAq/2ec++qroFo+NYsyurkui7XnUCx+BMEC0mXlPx0XfW9kuasCe7Tec6Jtdu9V13nfDibn7VejD9NtRZpDM31ie/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970984; c=relaxed/simple;
	bh=6f8ItstMlch3RcPgy7vlb027QgO046tCJUhTEb1z/0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pSO8GSxv5pZGOi0LRrxEwMfMtqCc7LnvNLz8OV3r2APFQrsJYiwBH1zf9Oofe1zoyBv39UP1nT1TuqU1IV5qXUAkF5wHQAi3XJ+kSbRGVyzgVUCWSq7XcrD09KTtZv26twjCRlk5JXs9o3cgQ1Th1324W4Uw38nWlOR8/TnH2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44T8MCFq075923;
	Wed, 29 May 2024 16:22:12 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Vq2MQ1J15z2QjGgT;
	Wed, 29 May 2024 16:18:26 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 29 May 2024 16:22:10 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH] f2fs: fix to avoid use SSR allocate when do defragment
Date: Wed, 29 May 2024 16:19:39 +0800
Message-ID: <1716970779-27896-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 44T8MCFq075923

SSR allocate mode will be used when doing file defragment
if ATGC is working at the same time, that is because
set_page_private_gcing may make CURSEG_ALL_DATA_ATGC segment
type got in f2fs_allocate_data_block when defragment page
is writeback, which may cause file fragmentation is worse.

A file with 2 fragmentations is changed as following after defragment:

----------------file info-------------------
sensorsdata :
--------------------------------------------
dev       [254:48]
ino       [0x    3029 : 12329]
mode      [0x    81b0 : 33200]
nlink     [0x       1 : 1]
uid       [0x    27e6 : 10214]
gid       [0x    27e6 : 10214]
size      [0x  242000 : 2367488]
blksize   [0x    1000 : 4096]
blocks    [0x    1210 : 4624]
--------------------------------------------

file_pos   start_blk     end_blk        blks
       0    11361121    11361207          87
  356352    11361215    11361216           2
  364544    11361218    11361218           1
  368640    11361220    11361221           2
  376832    11361224    11361225           2
  385024    11361227    11361238          12
  434176    11361240    11361252          13
  487424    11361254    11361254           1
  491520    11361271    11361279           9
  528384     3681794     3681795           2
  536576     3681797     3681797           1
  540672     3681799     3681799           1
  544768     3681803     3681803           1
  548864     3681805     3681805           1
  552960     3681807     3681807           1
  557056     3681809     3681809           1

A new FI flag FI_DEFRAG_IN_PROGRESS is introduced to avoid
this scenarios.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/file.c    | 2 ++
 fs/f2fs/segment.c | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4044e67..9281c5e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -803,6 +803,7 @@ enum {
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
+	FI_DEFRAG_IN_PROGRESS,	/* indicate file was defragmenting */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5c0b281..93d2767 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2717,6 +2717,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		goto out;
 	}
 
+	set_inode_flag(inode, FI_DEFRAG_IN_PROGRESS);
 	map.m_lblk = pg_start;
 	map.m_len = pg_end - pg_start;
 	total = 0;
@@ -2772,6 +2773,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 clear_out:
 	clear_inode_flag(inode, FI_SKIP_WRITES);
 out:
+	clear_inode_flag(inode, FI_DEFRAG_IN_PROGRESS);
 	clear_inode_flag(inode, FI_OPU_WRITE);
 unlock_out:
 	inode_unlock(inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7caf20a..dd6f8ac 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3482,7 +3482,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		if (page_private_gcing(fio->page)) {
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
-				(fio->sbi->gc_mode != GC_URGENT_HIGH))
+				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
+				!is_inode_flag_set(inode, FI_DEFRAG_IN_PROGRESS))
 				return CURSEG_ALL_DATA_ATGC;
 			else
 				return CURSEG_COLD_DATA;
-- 
1.9.1


