Return-Path: <linux-kernel+bounces-332312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547A97B80D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570FFB26867
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966DF16849F;
	Wed, 18 Sep 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YibLITW+"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AB158219
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641691; cv=none; b=AHUHRoMpwB/4wPqViLODb1nIQw4rmqubOa1g/MBRxzLUP7vuoToQd9ASSbRFJdgEMvgnUe43GFhHUWj4vaodUwcU+3W/DUxLGlQfdLcCMoXB2bBvHbJSrqu4NWaXCZx/f0CTFgrlYlM8i2YEYK24/zYFqcNm3DRhZARRZ8S4NMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641691; c=relaxed/simple;
	bh=mGAaslFkRh5LorOiXXJPh6pzZ4ixmMNNgegZasnOX5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NXCtMiaXXDNhy+KO6zUYiwqzK5WXg0G+m4RvEDjOb0sYIHpx666+QEqmV/AEFDBIdzklNfBmOGH3eSFspPrfCGzIGzmqBGHGnsq+x5RoK2FjCnfLEmF8+dB+WOiMfnzHLvlkdM2EO/SSk/abk/Hc/FEl+sBb1pFXeuCHCayC/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YibLITW+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2057835395aso74668175ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726641690; x=1727246490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIn+FGCYpXlC92Fe5cHA8EosiG+9ahtgnsi9y2oPRZU=;
        b=YibLITW+xFwsNEIDcMvff7fmGvTKPBLqtCAzqvzgRJxmNGOQVd7dw92symBQ5xZwQp
         WG0HquM0ETSwpu3M0FKLTtsCOVwSssnoCjsrWdMStLG7Bx9XQXuCIpYpW6Mjm8iB9uP6
         VXQSNTDdgBZ2UdmxfZoLpkkyUSASi8Kb+DgJu7uCWzYNGcWI5+eBMNNYeP9SWB+pQgdG
         BeemxDvRfFPMWu+Wtx0DDAj5vpB4Ctt3srFg7+QGj6qfVKHlt07uBCFCgrEtulVEnYCr
         xFUe88a5nV1M9oQoBa7zGZYLdRsPq0yn2NhFnYDn68vizxzEp7AvPY4ZG7PO97PWdQFq
         IwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726641690; x=1727246490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIn+FGCYpXlC92Fe5cHA8EosiG+9ahtgnsi9y2oPRZU=;
        b=gCwV4ZO4Dr5zvyvSPDsqxEvTSVUu8jFahFcZPOa+p9mZ/tTQnQU7+AwdbJFcvTApcI
         cNxOKKMIJDrO+yDr7yH0/nyfzoOEexKA0xoL268ddx3eIto4KJO9wDTGgfUN6nigrD4y
         esXBJiCs1T+glincvRzMqr/hUtegWujjOa09c9J7LpLPvqyqUHjMrNz6mvkvX6taR/xe
         ajKM+BVobV1hoFu+EtW2Jm/Xq3h+YPLZl/GxdWg0GOK/HJf2PTcDGc6MEV65sFCpv8Lb
         ciQQAouP+IrLCCvKqfxsx92mxfW82heFdnNLbZeukir9It+SK+t8HRUm29U1f8r4kqiJ
         rdOg==
X-Gm-Message-State: AOJu0Yz8DAGw4zXl4quA4bdX4UcnAXi64J4PGOepH5eD1F7p26DZMTHP
	Z0XBPI2+abN1aJiJxRcEFW84psrMeuVir0eiBbsB2C5mkYKpJbob
X-Google-Smtp-Source: AGHT+IGmdiJXNKzqihPdFSrq2EU5e8sdYC9RBwCBsII7xVRF9j3umcviuoRO7mURHm3lR/C27BCm2w==
X-Received: by 2002:a17:903:234d:b0:205:7f9b:b84d with SMTP id d9443c01a7336-2076e34d952mr332099735ad.22.1726641689604;
        Tue, 17 Sep 2024 23:41:29 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794731606sm59082845ad.270.2024.09.17.23.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 23:41:29 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Wed, 18 Sep 2024 15:41:22 +0900
Message-Id: <20240918064122.202586-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000007337c705fa1060e2@google.com>
References: <0000000000007337c705fa1060e2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/ext4/super.c | 56 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..8cfd43c33480 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -314,113 +314,113 @@ void ext4_superblock_csum_set(struct super_block *sb)
 ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_block_bitmap_lo) |
+	return le32_to_cpu(READ_ONCE(bg->bg_block_bitmap_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_block_bitmap_hi) << 32 : 0);
+		 READ_ONCE((ext4_fsblk_t)le32_to_cpu(bg->bg_block_bitmap_hi)) << 32 : 0);
 }
 
 ext4_fsblk_t ext4_inode_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_inode_bitmap_lo) |
+	return le32_to_cpu(READ_ONCE(bg->bg_inode_bitmap_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_bitmap_hi) << 32 : 0);
+		 READ_ONCE((ext4_fsblk_t)le32_to_cpu(bg->bg_inode_bitmap_hi)) << 32 : 0);
 }
 
 ext4_fsblk_t ext4_inode_table(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_inode_table_lo) |
+	return le32_to_cpu(READ_ONCE(bg->bg_inode_table_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_table_hi) << 32 : 0);
+		 READ_ONCE((ext4_fsblk_t)le32_to_cpu(bg->bg_inode_table_hi)) << 32 : 0);
 }
 
 __u32 ext4_free_group_clusters(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_blocks_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_blocks_count_hi) << 16 : 0);
+		 READ_ONCE((__u32)le16_to_cpu(bg->bg_free_blocks_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_free_inodes_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : 0);
+		 READ_ONCE((__u32)le16_to_cpu(bg->bg_free_inodes_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_used_dirs_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_used_dirs_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_used_dirs_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_used_dirs_count_hi) << 16 : 0);
+		 READ_ONCE((__u32)le16_to_cpu(bg->bg_used_dirs_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_itable_unused_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_itable_unused_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_itable_unused_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_itable_unused_hi) << 16 : 0);
+		 READ_ONCE((__u32)le16_to_cpu(bg->bg_itable_unused_hi)) << 16 : 0);
 }
 
 void ext4_block_bitmap_set(struct super_block *sb,
 			   struct ext4_group_desc *bg, ext4_fsblk_t blk)
 {
-	bg->bg_block_bitmap_lo = cpu_to_le32((u32)blk);
+	WRITE_ONCE(bg->bg_block_bitmap_lo, cpu_to_le32((u32)blk));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_block_bitmap_hi = cpu_to_le32(blk >> 32);
+		WRITE_ONCE(bg->bg_block_bitmap_hi, cpu_to_le32(blk >> 32));
 }
 
 void ext4_inode_bitmap_set(struct super_block *sb,
 			   struct ext4_group_desc *bg, ext4_fsblk_t blk)
 {
-	bg->bg_inode_bitmap_lo  = cpu_to_le32((u32)blk);
+	WRITE_ONCE(bg->bg_inode_bitmap_lo, cpu_to_le32((u32)blk));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_inode_bitmap_hi = cpu_to_le32(blk >> 32);
+		WRITE_ONCE(bg->bg_inode_bitmap_hi, cpu_to_le32(blk >> 32));
 }
 
 void ext4_inode_table_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, ext4_fsblk_t blk)
 {
-	bg->bg_inode_table_lo = cpu_to_le32((u32)blk);
+	WRITE_ONCE(bg->bg_inode_table_lo, cpu_to_le32((u32)blk));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_inode_table_hi = cpu_to_le32(blk >> 32);
+		WRITE_ONCE(bg->bg_inode_table_hi, cpu_to_le32(blk >> 32));
 }
 
 void ext4_free_group_clusters_set(struct super_block *sb,
 				  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_blocks_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_blocks_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_free_blocks_count_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_free_blocks_count_hi, cpu_to_le16(count >> 16));
 }
 
 void ext4_free_inodes_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_inodes_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_inodes_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_free_inodes_count_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_free_inodes_count_hi, cpu_to_le16(count >> 16));
 }
 
 void ext4_used_dirs_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_used_dirs_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_used_dirs_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_used_dirs_count_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_used_dirs_count_hi, cpu_to_le16(count >> 16));
 }
 
 void ext4_itable_unused_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_itable_unused_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_itable_unused_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_itable_unused_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_itable_unused_hi, cpu_to_le16(count >> 16));
 }
 
 static void __ext4_update_tstamp(__le32 *lo, __u8 *hi, time64_t now)
--

