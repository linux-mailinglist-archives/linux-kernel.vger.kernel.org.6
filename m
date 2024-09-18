Return-Path: <linux-kernel+bounces-332351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F497B8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42F1283EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4616BE39;
	Wed, 18 Sep 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz1B4ff3"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4716F0CA
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645591; cv=none; b=Htak8R0vP6HfJ7ZHReXTt/E+5Wb1yemH/vsZV/+a24GVENU7m5ISSlbazVNibR3gWnufBRhNEuiKeeG0pNZ7vOA4nfHpXOr3Cjvbss0QvhvV0J5mH8BoNWsimadCp5tjnLvtXoS6pYtspdYJ1Au8iLR5e6HT6Q/IHgIL5t5sjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645591; c=relaxed/simple;
	bh=qAdd2TfN7hS0syGxpH1v+rcnaAojaXYA5cvjR+7gtHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgcyZ6l6K+TKXRBvHOcMEW0oEm6Zq7dMqB1Y2jGH0vV1YU9q1DRUKxMN8gV98UW2DSKD+SfsHH+k3E2xlviCIc400uHhOlN/Atp4ThwtrZpCzEk9Dk5DyycyOyOJLeal85hJZzeCXCdjKv50N21I8jhd4VrUM3pkPuNiPbnmlpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz1B4ff3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-205909afad3so67541955ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726645589; x=1727250389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku5VERMlaKrQLdzVf4SJAzrELVCHsIjcgrBZORjAAfY=;
        b=Nz1B4ff3UdUeZ8yTud18ZnjjP222pnEt43/Y6tW1KD0ojc3JgoPko29a2g/sLDk8Ku
         L6lp/QzT2weyeKtxkaveybckzLovMzto46C6+/B0i7u+1FGiASN0mboeNBg/k0SdeHYE
         24TipWvxtDp2O4YEq1cPi5LhI+CE1sfcJyYGXF0HkqRnXWuTAxKJ1wssX4wgZUEiUoLm
         HzxPcHJ10FC3LAN4DDecSxlGktrkZ6jIY77L4bJS+4+7PDHQbnvruBcHLzEG0MU2oj/R
         +EOhLxe2ZzjaJuKDdh8Xq+0oXkeqmm16jFytSY2b1ku+uwUbQkfolzmvYnyEIDEsYyZG
         VlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645589; x=1727250389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku5VERMlaKrQLdzVf4SJAzrELVCHsIjcgrBZORjAAfY=;
        b=aiJ/ziDe5+Nm0gyZg8ropuvsyW3wroMB+GA9umqSfRuf3RameVPT5QYmkCvNLNhsue
         rgAiaH91E1+3ukR5LEDThq/zQbxwFam/NVsSJhvf4T1m3OOlgEH8x77r3dfxpvd5tEWi
         PdOyPu1dOF7xGLJ/rXuGhES97uOXXcsvxMH36opz8B2mWEyjRxOnIM1hORd1WVW7cW2i
         g3UK9CTEAX7oYpOahr3NlLO9dxYPPYkYf1XAsDvgBEYuptR9ezkCW8INx1rATJC167FO
         P0fbr1AT1VlNJCumz+vyKnri94FJ1wZY7gK8Oc9LFSYDwRJBDCLgzNpsKA7VFW2ywpJN
         wj1g==
X-Gm-Message-State: AOJu0YxIwz2ICitzis2WLghaBs3X4ff0BN/YnccMGpJQQJUR5y8Azybw
	J23y1qXP5uUQ1X7UYvwx5rdekJ1xpZXN4/dH/fsZICkNY/iOrIeB
X-Google-Smtp-Source: AGHT+IER8dPe3JkQVgF4cm8I9Jzn3KzF9SFb38G+SU2y06ScOzIcvlM+H2NbFY4v8sbvrGK6TzLF6w==
X-Received: by 2002:a17:903:98b:b0:206:9f91:3624 with SMTP id d9443c01a7336-2076e32fe49mr332978615ad.13.1726645588808;
        Wed, 18 Sep 2024 00:46:28 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d19aasm59957525ad.127.2024.09.18.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 00:46:28 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Wed, 18 Sep 2024 16:46:24 +0900
Message-Id: <20240918074624.207621-1-aha310510@gmail.com>
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
index e72145c4ae5a..9c918cf2eb7e 100644
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
+		 (ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_block_bitmap_hi)) << 32 : 0);
 }
 
 ext4_fsblk_t ext4_inode_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_inode_bitmap_lo) |
+	return le32_to_cpu(READ_ONCE(bg->bg_inode_bitmap_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_bitmap_hi) << 32 : 0);
+		 (ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_inode_bitmap_hi)) << 32 : 0);
 }
 
 ext4_fsblk_t ext4_inode_table(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_inode_table_lo) |
+	return le32_to_cpu(READ_ONCE(bg->bg_inode_table_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_table_hi) << 32 : 0);
+		 (ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_inode_table_hi)) << 32 : 0);
 }
 
 __u32 ext4_free_group_clusters(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_blocks_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_blocks_count_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_free_inodes_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_used_dirs_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_used_dirs_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_used_dirs_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_used_dirs_count_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_used_dirs_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_itable_unused_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_itable_unused_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_itable_unused_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_itable_unused_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_itable_unused_hi)) << 16 : 0);
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

