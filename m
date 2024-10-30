Return-Path: <linux-kernel+bounces-388479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256969B6034
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D117F1F21FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD741E493C;
	Wed, 30 Oct 2024 10:32:28 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C921E377A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284348; cv=none; b=koQGwua3S2xrSTWxQSCDTfbdn47Rm4khUOop508Eq6XFM1AbTQeX7ItFBtVJEAiXLPFjD8Na1qoXb49fCH8EF80WM3TOheGISY8OA2x9H9FynsUuOGK31JYG9hsKKFFaB8LgP056XgqhwJ/tV0+9hlvx8mI0NdF9SBHeGgHB3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284348; c=relaxed/simple;
	bh=PUBc5a3SONvppUw3w94dSdkO4p3xhINmzL1ECdhrVnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUFps/h3rc572J6PmNKyYnbLwpaI6ebsbcGCedEsXvDobt5LWjl8xqvGn6/LquNFeln/vcQNTdiLTRfVT3ptyFyFvWyEh81gqQztK3nZUn9VcrHPcOMLRaeGdSSd6q1CMcInHMULPGNDLHoOekX7HXz0EHLH4jb1SBU6QACtwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49UAVgrR026815;
	Wed, 30 Oct 2024 18:31:42 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xdk1N5Y5dz2K4lHM;
	Wed, 30 Oct 2024 18:31:04 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 30 Oct 2024 18:31:40 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v2 2/5] f2fs: expand f2fs_invalidate_compress_page() to f2fs_invalidate_compress_pages_range()
Date: Wed, 30 Oct 2024 18:31:33 +0800
Message-ID: <20241030103136.2874140-3-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 49UAVgrR026815

New function f2fs_invalidate_compress_pages_range() adds the @len
parameter. So it can process some consecutive blocks at a time.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/compress.c | 7 ++++---
 fs/f2fs/f2fs.h     | 9 +++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7f26440e8595..e607a7885b57 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1903,11 +1903,12 @@ struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->compress_inode->i_mapping;
 }
 
-void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr)
+void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
+				block_t blkaddr, unsigned int len)
 {
-	if (!sbi->compress_inode)
+	if (!sbi->compress_inode || len == 0)
 		return;
-	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr);
+	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr + len - 1);
 }
 
 void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3c6f3cce5779..d3fe66a93a56 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4384,7 +4384,8 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
 int __init f2fs_init_compress_cache(void);
 void f2fs_destroy_compress_cache(void);
 struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
-void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr);
+void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
+					block_t blkaddr, unsigned int len);
 void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 						nid_t ino, block_t blkaddr);
 bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
@@ -4439,8 +4440,8 @@ static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return
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
@@ -4759,7 +4760,7 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
 								block_t blkaddr)
 {
 	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
-	f2fs_invalidate_compress_page(sbi, blkaddr);
+	f2fs_invalidate_compress_pages_range(sbi, blkaddr, 1);
 }
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-- 
2.25.1


