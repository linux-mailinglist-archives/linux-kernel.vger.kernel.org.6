Return-Path: <linux-kernel+bounces-394186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5A9BAB94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DC51F21C95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A066165F04;
	Mon,  4 Nov 2024 03:46:25 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B51FC3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691984; cv=none; b=ZpdNVkytDosB1c5PXlbBaDe1Qzf614nT3CLaYvTMdiwI7/w+Lt4wKG+nL9dm86qv5Am+4MqrPzdIuKWoPOlAf/NrIuvj5QyZZDF4AZqPD+JCy8dqDHoguRFJBXEmxcdzb9RqI9zvbih/DUJ3417lJyXXcHX7hw/h8/NVelWAohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691984; c=relaxed/simple;
	bh=/SuTSeLj7fqu3BwQ3HeAy1VjHdW+1Ms+dz1ZWmvmEyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzLYodqI0I0UPsIu3hiPDTsMeDVIZkQc7/2aG0cVsRfuENK9eiVrFoKFIBzEjGibJI2rZlz21+4UBGEeROXbun+BpPxkxvEp9lpM53XW3HpPLndPz3myFOCMvp//THan8lFf6hTAUEJqb1bTH7AC3/w4ICKj+dPKuVzt6Q6qs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4A43joUG085656;
	Mon, 4 Nov 2024 11:45:50 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XhcmZ5dWzz2KgRlB;
	Mon,  4 Nov 2024 11:45:02 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 4 Nov 2024 11:45:47 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v3 1/5] f2fs: expand f2fs_invalidate_compress_page() to f2fs_invalidate_compress_pages_range()
Date: Mon, 4 Nov 2024 11:45:41 +0800
Message-ID: <20241104034545.497907-2-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104034545.497907-1-yi.sun@unisoc.com>
References: <20241104034545.497907-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4A43joUG085656

New function f2fs_invalidate_compress_pages_range() adds the @len
parameter. So it can process some consecutive blocks at a time.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/compress.c | 5 +++--
 fs/f2fs/f2fs.h     | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7f26440e8595..f6626f2feb0c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1903,11 +1903,12 @@ struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->compress_inode->i_mapping;
 }
 
-void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr)
+void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
+				block_t blkaddr, unsigned int len)
 {
 	if (!sbi->compress_inode)
 		return;
-	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr);
+	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr + len - 1);
 }
 
 void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 119706dbaefa..2b32443d06a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4383,7 +4383,8 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
 int __init f2fs_init_compress_cache(void);
 void f2fs_destroy_compress_cache(void);
 struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
-void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr);
+void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
+					block_t blkaddr, unsigned int len);
 void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 						nid_t ino, block_t blkaddr);
 bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
@@ -4438,8 +4439,8 @@ static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return
 static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
 static inline int __init f2fs_init_compress_cache(void) { return 0; }
 static inline void f2fs_destroy_compress_cache(void) { }
-static inline void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi,
-				block_t blkaddr) { }
+static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
+				block_t blkaddr, unsigned int len) { }
 static inline void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 				struct page *page, nid_t ino, block_t blkaddr) { }
 static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
@@ -4758,7 +4759,7 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
 								block_t blkaddr)
 {
 	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
-	f2fs_invalidate_compress_page(sbi, blkaddr);
+	f2fs_invalidate_compress_pages_range(sbi, blkaddr, 1);
 }
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-- 
2.25.1


