Return-Path: <linux-kernel+bounces-320059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 763369705BC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E379D1F21B78
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FDD6A039;
	Sun,  8 Sep 2024 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv0kXp06"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37224B28
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725783410; cv=none; b=NYUHa+c3ywzZi6pBjkBr7FbQF0vBa8hDWK1nvQLbwWryB53WmtX9cCcHZbSg+Z+/kWTM/v/1cNqox+v981tPCzpKVkqQI/zBT8eqh9RQlqAi1VHS5xOzUFmNcHWZb6JviJG44C7wvq95GbKawhrlCN5kJyMKkYsDbt5AOHmWg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725783410; c=relaxed/simple;
	bh=EK1ACcO0LC3YIOzuuiM9wTPhkGN9bFUkP056XW97RbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EcCWlxPi8eIBrXSlo4ltdOaGTZf05axG+DT+aR0u7hheZw99sKTAfHST7ObLYamDChsT4WoM6VgNRZ802ordOvPhMcCneqTiPeZUc4QLXuyB/uBWehTfIpHCA7zd0Vs3+aa/l3Y8E4BfiGd2QRNJHDLAEPiEU0V00iZ2yNBO6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv0kXp06; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd967d8234so2252444a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725783408; x=1726388208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCnWJhAMU0YGsqyejO1iLQfcsvWEKu49O7te55wdpEc=;
        b=Cv0kXp06mb9TJi3NAZlmi3JfD1dpk+U3PnsTRIspCGajpuBnuQYxq8CQ9iBtoM8KCp
         HTMXOb9mkedZaBDTwSxnGOuEtSPrUZXHid7C5dpBcfx5F18Ayp/roZAQJ2InCjo2FJPG
         GmhvLkVIQqkADqZ545H3EPV1iCD7g6nxgfrG62K0jW4mC1YM3CBNHN4k8Prk1OFV+d1M
         fuKQbQ+Nh/7W27E55VD5Cs9FK1PFNDFDPFBzv+28Y6G53JqCIMuWbRBgIXPjOmdtYhz2
         y3AK9ScE8E7ETdXqj4HQ3yJwL8seu62TOBOUBvZkC74JLT4n34kjyU1+P/7XIMai3294
         9zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725783408; x=1726388208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCnWJhAMU0YGsqyejO1iLQfcsvWEKu49O7te55wdpEc=;
        b=dZr0ipaEi6J3xzqR3qSqyV+UF8dZR6d/8eIYs7erMnEk3Gf4x9OJ7y3ttdVGenFffW
         nEnnXdYx0Q5hFuQUnfqpWqTOWMu3zLvJ0NJwwXgvq04yLN6UZyknuGol1d1D8TgqKVQL
         eUDc5/wtj73Dl/Xvg9nrd54u81d4GvgBuo975JwBqgGcwhm7XI8SRpNW7W4Xx0ce6jsA
         D7i2ywUn0XUSrfC1qCS7l0tFybQgU4PhScpofy0UjsXNpp7cVUfcEwlMsH1PrhjI9Bdm
         HphpDUENBXgTiMmdBgs6DGXQFV+oyhyaP/6/yHllnVUStvyV9uQseGcQB83y21PuK8t/
         ykyw==
X-Gm-Message-State: AOJu0YyTEpmdHiRP4LZND2jo9TTdVW+baLi6ywJFTjkD2cABg9wAg1Ya
	A9k06KvFbtkrsmqbgrg4Yhn7B9ho7jaCsPXxn05mLBhqHWETFDIf
X-Google-Smtp-Source: AGHT+IHMicrvV7nhJNHhM/+AAvI8phGMSgD1jCN69T9LRxXlqdIX9cNzcJIHVR8TxjIdnSLP8tkfgA==
X-Received: by 2002:a05:6a21:38c:b0:1c4:214c:d885 with SMTP id adf61e73a8af0-1cf1d1ec4a9mr5758033637.36.1725783408283;
        Sun, 08 Sep 2024 01:16:48 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db0413685bsm2323599a91.3.2024.09.08.01.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 01:16:47 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Sun,  8 Sep 2024 17:16:43 +0900
Message-Id: <20240908081643.8511-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/ext4/orphan.c | 2 +-
 fs/ext4/super.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index e5b47dda3317..08299b2a1b3b 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -293,7 +293,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 			mutex_unlock(&sbi->s_orphan_lock);
 			goto out_brelse;
 		}
-		NEXT_ORPHAN(i_prev) = ino_next;
+		WRITE_ONCE(NEXT_ORPHAN(i_prev), ino_next);
 		err = ext4_mark_iloc_dirty(handle, i_prev, &iloc2);
 		mutex_unlock(&sbi->s_orphan_lock);
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..8cc5e19bfe78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -346,7 +346,7 @@ __u32 ext4_free_group_clusters(struct super_block *sb,
 __u32 ext4_free_inodes_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
 		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : 0);
 }
@@ -402,7 +402,7 @@ void ext4_free_group_clusters_set(struct super_block *sb,
 void ext4_free_inodes_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_inodes_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_inodes_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
 		bg->bg_free_inodes_count_hi = cpu_to_le16(count >> 16);
 }
--

