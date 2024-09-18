Return-Path: <linux-kernel+bounces-332298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E797B7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1551C236E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7A15572C;
	Wed, 18 Sep 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH8H+cxn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00708339A0
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640777; cv=none; b=htQoAv+3U88UYiD647eEKW8CU9JQbg06c+AU2ANyFEyC2XpwgCuFzp543dubdhjJnZ35b38gpWgTj54HeXk2Cwi1GnpM0bGKRrxMcFLpEiC0XprIFE7Wys0vpuVPlmnjmvRRYIrl+PLxpk21myW/sY4O4OPHje44USnI3SV7r8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640777; c=relaxed/simple;
	bh=wEuJM1IRZec+fUwsabP45Zb0zuaX5y56mJRWir9xVwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+Bpo1K+0YVn0lOjtNF7Y3zm5FkZY3ithYa8solObpTLq6JZONNsBtVYnW6ViAdyVsWwpgtS8opTIUeUnQOikV2y7F8d7/Ihz3JfRrjbBeiFgkMW6gKJtdKQJXb8QL6nTS16t25rsoqmTIheAHseDpWHEef3/ZQP1iCW4DDl824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH8H+cxn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20696938f86so53269755ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726640775; x=1727245575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y5nj30IufiXWrygkI8clFjf/xER0TBJoY04B5pBRlI=;
        b=ZH8H+cxnfiKdvM2Q5MdjpC8qqhx30liNKJ8JneV/qSNeaVIzHtoMVIF1DuK8DHFbhS
         uLJd8skHSfuXvD0qcNrQy37fLpsI3pRYKl6RT6ldvaiNLTIDj1xlLCJ+T44gF83/wIDx
         sZHFoT5LGw4QqqhOT9DtSaDBBZtEVMrJnht5tvLGdgZxuNVt2Pc51UH58Q5GYc4CSfTr
         4T/8KWXmgm6ZDHcO/mhEvzESqIJrtyrzNIjlqSuGdWUf4mubWqq6BJuqLjL14v/et7nJ
         XQ0T2PZzgDvOXmiqkHzUyEGMEwkQinxAz8RMgpn6e/lvRaC3+nDXJJoT3Is8kVFanJ72
         A0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726640775; x=1727245575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y5nj30IufiXWrygkI8clFjf/xER0TBJoY04B5pBRlI=;
        b=JK9sVtsNB5Qmt9M122lHpGWIcpH6wCeW65wAiQV7uUBQPrcwvsA5YA/FRan6i4eCiz
         XeqPoXYZY1ksVlej1rLFBLNKJE/b9+u2qL1TP/sSlD4vr7qQqrsu/0ufPyrhhJjknDiB
         0/OocjbmAR0dW7P3d7b4jUwPnPiW6i95dfFKqHoerw4u0b1w0sFP5bHk4PGIYiW7qecI
         XohI6wXQ7+eUX7KHYhOGHM6OLJYyKUe3D7/NI3wwnX6LvjeIHDl1TOAFVheKN0n2zc2a
         b2ZJx/biHiSPpptqyEGmmqxoMHLb7G6XPTgrDAg/slelxd3dkQPe5PZ0VKLJYE+pNmWS
         HdUw==
X-Gm-Message-State: AOJu0YxrYWPHOrd3dV98rHYPFJeV7OLboTihO0CvqwXU/8aQ6ReBdbc2
	/0X31e8dUIEHT5wBObkQH1fmf/2nfRMkSUhXqtw6ueTutZ5wW273AQWzGupt
X-Google-Smtp-Source: AGHT+IFtSBBHd3FngxPo/hOWIyKZAKbc48h7NwxIA44NEk92Vk2y9GOfr/CZ6knBpmUPPzZ5cXl2Dg==
X-Received: by 2002:a17:903:1245:b0:1fd:9c2d:2f27 with SMTP id d9443c01a7336-2076e36d91bmr295593265ad.24.1726640775014;
        Tue, 17 Sep 2024 23:26:15 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601379sm58607325ad.95.2024.09.17.23.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 23:26:14 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Wed, 18 Sep 2024 15:26:09 +0900
Message-Id: <20240918062609.200332-1-aha310510@gmail.com>
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
index e72145c4ae5a..af78b6271e4c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -314,113 +314,113 @@ void ext4_superblock_csum_set(struct super_block *sb)
 ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_block_bitmap_lo) |
+	return READ_ONCE(le32_to_cpu(bg->bg_block_bitmap_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_block_bitmap_hi) << 32 : 0);
+		 READ_ONCE((ext4_fsblk_t)le32_to_cpu(bg->bg_block_bitmap_hi)) << 32 : 0);
 }
 
 ext4_fsblk_t ext4_inode_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_inode_bitmap_lo) |
+	return READ_ONCE(le32_to_cpu(bg->bg_inode_bitmap_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_bitmap_hi) << 32 : 0);
+		 READ_ONCE((ext4_fsblk_t)le32_to_cpu(bg->bg_inode_bitmap_hi)) << 32 : 0);
 }
 
 ext4_fsblk_t ext4_inode_table(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_inode_table_lo) |
+	return READ_ONCE(le32_to_cpu(bg->bg_inode_table_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_table_hi) << 32 : 0);
+		 READ_ONCE((ext4_fsblk_t)le32_to_cpu(bg->bg_inode_table_hi)) << 32 : 0);
 }
 
 __u32 ext4_free_group_clusters(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_blocks_count_lo) |
+	return READ_ONCE(le16_to_cpu(bg->bg_free_blocks_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_blocks_count_hi) << 16 : 0);
+		 READ_ONCE((__u32)le16_to_cpu(bg->bg_free_blocks_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_free_inodes_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
+	return READ_ONCE(le16_to_cpu(bg->bg_free_inodes_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : 0);
+		 READ_ONCE((__u32)le16_to_cpu(bg->bg_free_inodes_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_used_dirs_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_used_dirs_count_lo) |
+	return READ_ONCE(le16_to_cpu(bg->bg_used_dirs_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_used_dirs_count_hi) << 16 : 0);
+		 READ_ONCE((__u32)le16_to_cpu(bg->bg_used_dirs_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_itable_unused_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_itable_unused_lo) |
+	return READ_ONCE(le16_to_cpu(bg->bg_itable_unused_lo)) |
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

