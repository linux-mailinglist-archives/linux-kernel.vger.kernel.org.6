Return-Path: <linux-kernel+bounces-320166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DCF9706EF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567921C20D35
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DB156668;
	Sun,  8 Sep 2024 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq/sHy7S"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F70155A32
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795210; cv=none; b=XhjaxzIfOJiWW8PUpMWGw2z6QVpignYgbXqPNcLVKy6A6BV7jvYXinalekXcGzHHX4hPH+MW3jFHb0tf5I5/HqT845eGptLeL2VzxsP8wHHHqnrH0xhzSHXmNBlBgmDaty76Y+wPtxdb461D3HDQnmAOnN/e0w9vbmBr5VdO87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795210; c=relaxed/simple;
	bh=aTSE1n6xrZTiUV/fAuc/0WrqIi4ApvzsNBFhFNf9pUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ojAyssAPwmu/SxSHkwq1nEVhnwUOLVU7ESBfrpqQuGp/Ylx5zmchV8B0dn0FI2sF15OjAjCcsbOd2rXWBijPyVOfbfYLVodBA8m94M53dEj8wnXIY6oItcep944sqw5odB3xqpm+eLoTa963SBEYOdKw8NA51M5n7OvTQkU8QUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq/sHy7S; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d962ad64so1969793b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725795207; x=1726400007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCf3SqIpi+smHSMa+FhqUwP6bRy0VLcMO9hbpROT3lg=;
        b=jq/sHy7S6dVt26OznsWpZdsCvp4hP1HR+CjE4t2gPQe8ITfrUZs5jCAL+RGvu2XCnE
         wC4VhWQzQpEA7i4jFNJCUuVyhdjWL1ZKDXTCQE1YM3fDpt2wZ1Y8ixD/o0GXfpKLFvbo
         H4VdLSwhCTuRA6C+BZicnjWFB5tHwXyUFes+K7o2YVlpZVFqwRZWvYlalMc32yJEHz4b
         CGW0czeukmTfi73BdrEdrrSUXstaOPuQoKDLJS1PIbkhhGxu1QXpoBfBXsXZpy5eiUKi
         Jl080haYKEch+RYRLm0RhxwD97eHQLfRbYcPWr3ZGXgBbluzEtXUWvOQDlFHI+et7uan
         cCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795207; x=1726400007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCf3SqIpi+smHSMa+FhqUwP6bRy0VLcMO9hbpROT3lg=;
        b=Kd91KKfVciek33BVAtF+DL3cVLX7dsIQ8CO0wRlcMJFAcLrvTsPeZGbwYkr835xj2/
         nI232/gdH2kJ5Riu3gfuX/srykzdES1y0mZsLc1Fyi2lHzK9mZaEjn+PoJR8kOUw2kqR
         srWdYeNeiq3lk/ce1YGn+Fm7qohRk5d5xeHPQxploo1C4dc7a6ZoZRx8V/devumPCiio
         ogcXDnO0SLKcwQpev95T7zfcxWntujo9iTU/Vypvi9+cuH7OBy3trZybjPzZrI2H6qGr
         Tf+2jVbzAwuI8dROkLs/RIiQi3V5GqmTmhJukytl0CpOaaX/g5BudTVzrQjfEzqiDCtR
         rQ+A==
X-Gm-Message-State: AOJu0YxeuR41wCHqzaBoKtcLBHLI+okafxIKBQKSgEIHLw06jK3ykbt3
	WmOHVKMfkmdz9PvXeE9UHmgNT01//hrelOSvai7l8vnMMroAYTr1
X-Google-Smtp-Source: AGHT+IFCOaOEPadUfPPLp3kmtu/pED1UJGaXg6V+o88mLDUCO822mavVEMiOzKF3BfM+uTqTOwXA8Q==
X-Received: by 2002:a17:902:ec8e:b0:206:983c:39af with SMTP id d9443c01a7336-206f054f7bdmr83032475ad.31.1725795207151;
        Sun, 08 Sep 2024 04:33:27 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eeaf34sm18975695ad.135.2024.09.08.04.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:33:26 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Sun,  8 Sep 2024 20:33:22 +0900
Message-Id: <20240908113322.14366-1-aha310510@gmail.com>
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
 fs/ext4/orphan.c |  2 +-
 fs/ext4/super.c  |  4 ++--
 mm/percpu.c      |  5 ++---
 mm/shmem.c       | 12 +++++++-----
 4 files changed, 12 insertions(+), 11 deletions(-)

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
diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..1595f6e7688c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1154,7 +1154,9 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
+	inode_lock_shared(inode);
 	generic_fillattr(idmap, request_mask, inode, stat);
+	inode_unlock_shared(inode);
 
 	if (shmem_is_huge(inode, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
@@ -3439,7 +3441,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out_iput;
 
-	dir->i_size += BOGO_DIRENT_SIZE;
+	i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
@@ -3526,7 +3528,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir,
 		goto out;
 	}
 
-	dir->i_size += BOGO_DIRENT_SIZE;
+	i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	inode_inc_iversion(dir);
@@ -3639,8 +3641,8 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		inc_nlink(new_dir);
 	}
 
-	old_dir->i_size -= BOGO_DIRENT_SIZE;
-	new_dir->i_size += BOGO_DIRENT_SIZE;
+	i_size_write(old_dir, i_size_read(old_dir) - BOGO_DIRENT_SIZE);
+	i_size_write(new_dir, i_size_read(new_dir) + BOGO_DIRENT_SIZE);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 	inode_inc_iversion(old_dir);
 	inode_inc_iversion(new_dir);
@@ -3694,7 +3696,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-	dir->i_size += BOGO_DIRENT_SIZE;
+	i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
--

