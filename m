Return-Path: <linux-kernel+bounces-320068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87269705D2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C9B28161D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2B136337;
	Sun,  8 Sep 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEYMtKBe"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A31366
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725784470; cv=none; b=N8Oc1YHQlQBah3vFNnV+ypSshfDi2tKZsJ+96MbDwG2SiZEd0znN2T5w+IQqKpbXL2vcrllbMNK4YaAXJTDj1x9PTIe40GesIqIyOL75meD2CBs0y5NGyhXmlUGkQG5u3ARMTCeWc6gEFvtG9Gaq/zb+pxhVKQxuwd/+bmtBCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725784470; c=relaxed/simple;
	bh=c9Kfjg6JKXpt/LOPnS2V0Nlg3DxraxDVjUcwGhfqnyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmUaARmC2XjNDhtOjEbno+rdzvBJG2yhxXw0KLIaEeWH9H1LQO0ZOwfjtOpdLpVX8bgm4igxdGvyb8ztknLIoDf6DMKpO4Rl9AM5y1ZPKLEtuBYhYNOQI/i7eb2GWoH8867E07aoXiMVCsx5ZbI18vzp/dJza80XLf2sLvtJzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEYMtKBe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2068acc8b98so30755495ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725784469; x=1726389269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=voSUAYCbvQQ5+MVh4n8SzuPW1IBELoz77eh1vYARkhw=;
        b=hEYMtKBeC1h1jzeY77IQEeSdevcxXC+dsWUmfQTS+khUvxkt0Ik7xTTkZHTejFfgy8
         1ofwPZs+irO94wOa/NM5mdux/opOUTz/ds8FI3A0+D1Ci9FZA0DCRAwEr2sQ8vZl2/1g
         jSWTqSmii/6mQufpAbhIHVcQHSnlbrUpRuv0CLxFc4tgT2d7la7iL/RPb+lsfw/BR1JR
         L2cemgjViBOki2sezRUHE4pfvVtgZz89BAOWbAJx2EajYw4PNoRTg50+/WfUpNhxRh5x
         OfgaW0mSsuPDXZYuNPJ19knlCc2JfjFFpltCBxDmW3xDhxs7th71yfyeXi/5c0UelLHZ
         YvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725784469; x=1726389269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voSUAYCbvQQ5+MVh4n8SzuPW1IBELoz77eh1vYARkhw=;
        b=qwkAWPolxbkPxABgx+Ek8idJhEx9eYgvR/m0I+I7Z7If1AqvqnBQH8Ffl6acgxepm1
         e3Ry9sqUnpQ/Rd2ox1aDm8Zbc2EwhHAlSMlhkGkafxvDEFo3FD+2EcZeIHb3oYPF9twz
         XPXtwZm17WQGJgbNHnp6oO+KAiHHgDEnG5TYrdcFEdkBFCtRVpIpR68A3DKneFj/hzNg
         lgi980Z27aZ85bct10rWGziYz4Pwcd6XKmK2OtDsJNq1A2cz07DYhMb9nA9UT/I4f3Hx
         iekEcyxbS9RCFNTr9KQ4xiCn7XRINmG9qB6kApK51qxwION2bZyrz0ORL+e5QRYO7mvh
         h6RA==
X-Gm-Message-State: AOJu0Yz8HVXywRj5Yyvn6DerNguD0WEixQdrG5+oGfkaD9dHf+Y6FoFB
	QuN+vNbdh4VnIwlDE/RDpFoMKDjiR6ESkA8n5aB9OzjlnpSLgVH+
X-Google-Smtp-Source: AGHT+IE3tS3jb+AX/ZGV4b/l4lSSsFckA2vMXJ12ZW7hl3ozT5whmyXAK4X3El2BhJgyREFWZEeu0w==
X-Received: by 2002:a17:903:8ce:b0:207:2093:99a3 with SMTP id d9443c01a7336-20720939ac8mr26112895ad.5.1725784468747;
        Sun, 08 Sep 2024 01:34:28 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eead48sm17190615ad.131.2024.09.08.01.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 01:34:28 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Sun,  8 Sep 2024 17:34:24 +0900
Message-Id: <20240908083424.13212-1-aha310510@gmail.com>
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
 mm/percpu.c      | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

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
diff --git a/mm/percpu.c b/mm/percpu.c
index 20d91af8c033..5c958a54da51 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1864,7 +1864,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 
 area_found:
 	pcpu_stats_area_alloc(chunk, size);
-	spin_unlock_irqrestore(&pcpu_lock, flags);
 
 	/* populate if not all pages are already there */
 	if (!is_atomic) {
@@ -1878,14 +1877,12 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 
 			ret = pcpu_populate_chunk(chunk, rs, re, pcpu_gfp);
 
-			spin_lock_irqsave(&pcpu_lock, flags);
 			if (ret) {
 				pcpu_free_area(chunk, off);
 				err = "failed to populate";
 				goto fail_unlock;
 			}
 			pcpu_chunk_populated(chunk, rs, re);
-			spin_unlock_irqrestore(&pcpu_lock, flags);
 		}
 
 		mutex_unlock(&pcpu_alloc_mutex);
@@ -1894,6 +1891,8 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
 		pcpu_schedule_balance_work();
 
+	spin_unlock_irqrestore(&pcpu_lock, flags);
+
 	/* clear the areas and return address relative to base address */
 	for_each_possible_cpu(cpu)
 		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);
--

