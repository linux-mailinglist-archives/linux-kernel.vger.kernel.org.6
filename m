Return-Path: <linux-kernel+bounces-320046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 743F1970567
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09221C20FEA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2A33998;
	Sun,  8 Sep 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVePV1Kz"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AA76410
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725781684; cv=none; b=o0Am1/CDwgjJk3SEhr8bp9KwdP/WHUR4ACRISlzzJq9UO/daWc89GxjjzRUyUDrw1rFsc+V5W+z3j2MNGct/crlCFioYakmRxE30Kzvbzm0+nXYY7OOOQGlb/ATRYzcDpCwAweer9pBRcH6SYCIOj8ARgecYzLKnfzUk3c44t+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725781684; c=relaxed/simple;
	bh=EK1ACcO0LC3YIOzuuiM9wTPhkGN9bFUkP056XW97RbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RhsZasS1+QAyi071NmnEtaFdUmg/41g3QUawAilWGTcqQXEYJ8R+KdouLIAggDYt1UHkZKsrzRBrMQLOjR/+7q9tvFuPv0qFviTwjWi+W5h70WzQsxqxW4+9D/mHQL9kUlMONyBqPsiJXovF+4a48XPcLgWKQ5x8QdP5ZJM4xLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVePV1Kz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1961366b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725781682; x=1726386482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCnWJhAMU0YGsqyejO1iLQfcsvWEKu49O7te55wdpEc=;
        b=lVePV1KzD9BNuWWnhNFV07161/g1wwbb5GATY7aJeVSnVkiE3LmLoynfy0KrbfsVdk
         0XWEXWmQ0hA3nrXywEgnDhUt3MVZWDXShiv1p6Q151kD9BYccQ1KpmErCVtPOpW2lvyi
         iWQcvyWWCwsxszMYTy1Fl30hBRWw6ov8remds4tkoQ4nRfkIdol/6vfUOVkjItujCdUp
         X0X8ZjnI2Ot0OBkmIgDEr6gjzDu1kcSAy+tArG6oq92zk5USxA5GS2TJJUgy+ZquZ5O8
         a0op2qW668noyR2bzOeMN/icU2YUqKNWJPV1P+58DiermbdgOugxHFtkwpLKMByuYn7E
         8KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725781682; x=1726386482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCnWJhAMU0YGsqyejO1iLQfcsvWEKu49O7te55wdpEc=;
        b=OeuZYfVjotuiNMNW7UqK3Z+zs6+LrNP/cMfoFttz9oAxZdvxNgY8mp5MrPClZ1QZCd
         lafgAt4U0FrpGHuoYkFyu29gfaG/uooCtm2SYT4+VTrTEz2JoFiuVegquT72XgrV0xHY
         rq7U/TAtjjp6zz9nOWtBuXnqkdWCycNIVoHjlR7YGF8SmETB7O7RLWv7SODv/e5wtR4v
         SZOKg30Za/8KqHl1eDUHsOg4PY+c1vvdXeQhcFZT3+r7VpTECUFyrBJRckZ1ItLtedIZ
         8Gz6VJYQtBWM5GaI+QEbv6s+viVk51Vvc5I4h2NnQ0ZTmGNYPwkoe8hSYlMEIeBBapqN
         OnmA==
X-Gm-Message-State: AOJu0YyiWYLa0FShhS+DJeJijwUkXpFkFzn2m1VXM5UBG9cFdAj3sWBG
	/aWShulJ6VRWDcxnNm44abb4UaZmjEFJMQ5neWtR5drkr/0WY8pU
X-Google-Smtp-Source: AGHT+IEohXLenAPRNWRzIAtV+joAow4bgsEbuSPR1a621YJWRq2ASqI64sSnSZm4lKM1SKN4u7ySIg==
X-Received: by 2002:a05:6a20:12c1:b0:1cf:30b2:97ed with SMTP id adf61e73a8af0-1cf30b29951mr3481988637.5.1725781682249;
        Sun, 08 Sep 2024 00:48:02 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e589846csm1735735b3a.30.2024.09.08.00.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 00:48:01 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Sun,  8 Sep 2024 16:47:57 +0900
Message-Id: <20240908074757.8436-1-aha310510@gmail.com>
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

