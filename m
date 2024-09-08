Return-Path: <linux-kernel+bounces-320165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF09706EE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284D2281F3C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA51547D1;
	Sun,  8 Sep 2024 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+iGXD0U"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44BD153BE3
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795200; cv=none; b=qBZt781byb1c3cwVOla1fCDJ3zehUYbjI9jynBgmed4uSvVHu7DrBKjdP30xuRtGle6EiLgshMsA3WY2qbzFp9B4G5O9niwG8Q7iS/vz+lVQF1gVx16NkDPCt301a67LCrxEMqqCZBeLiyQWFP39SGucc7xAn/rDcTduVNXShCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795200; c=relaxed/simple;
	bh=aTSE1n6xrZTiUV/fAuc/0WrqIi4ApvzsNBFhFNf9pUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uHkDMiRHNkEvFLJBvvwoIcDYX8wdH+Fd/k3XQCv5PyyVDhUeUHqe/IFL+2QJk7vIHJeEMo65VIR+BdB880C9kgMU3QLoV9ZXFC4I1rf6dW8Oft8XXdy3meryk8evmEIkpeIw/mBRK5RobUY/19zCgGCcgunAsdksVcIifkC5sUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+iGXD0U; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-26fda13f898so2183939fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725795198; x=1726399998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCf3SqIpi+smHSMa+FhqUwP6bRy0VLcMO9hbpROT3lg=;
        b=O+iGXD0UM/w38mI0zRglmYUSf9aobNKk7i/KgCip9rlLOPsr0srnT63hZliaDVhEjv
         Y80QULXLcWWNYT2Gmy60vraXzmXOuFXJrK2ekjCMPRCT+M14d3DOZ9RDdYy/0Xlfpqle
         4CUbVGgLL+n8eepAL4WTTbMtTJsAL7Jf7s/M0dSYCy9ym4z7unS74GpCiUln8FEvs9yq
         7DpZXkW6llra8Buvyl5Ui4qs0ZhXabbW9MKTg6ScuQZXb7zboRvMneh4/H6I9oLy7ai2
         2blM9czWFS5pKyCUldqK/RWDdbTLgc5VC4voVNZNACcM+0q7hmBDnMh5kU8T0imOOMEE
         1U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795198; x=1726399998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCf3SqIpi+smHSMa+FhqUwP6bRy0VLcMO9hbpROT3lg=;
        b=grl3teVgwdH7S8wB1Ieom76KQb4kXjmL+cXI/Xz4jEhO+8bzW4UyWBTN9nnqcnKx05
         JseZVWz27Q/FmASNzi/Gdd/Z3AMJN5eRrWMsaMKg8Xlz8zixm9im8yoPhvxVBEql/UX+
         I/Aw/EBepzDx28VT4GvJwD8mjd8k4SFzvjWjemW4JDxwHXU0q+KkTGZh5rtQeeJiAYkD
         X9KeXRIhTkLKjHJTzSxbwygiQgr/p9evpZR616aUiTif22220+STwvG14tR0ODCT1Qub
         0lEvQIb8gQB2El7qnwMK1Op1nGazoflHht9hafJ0Pt8li356cSsKqHlvzV6cEFi8bpkN
         hGsA==
X-Gm-Message-State: AOJu0Yx6R+9Qlya4/jVpVn1X+YzlEKjbSH/SUxEwDmfo4upG5sf2GUEa
	YinDsFN+Vyn4vuUsw+HOnogGyG9x6kL7owB5a2y17iTPPWRZB1KI
X-Google-Smtp-Source: AGHT+IGgnVUgCX9L9lS8XnRGuJjXO+VV4YSVk8d73qgSbvuWxv39aa8cX4xgbe9tq35ikK1YGUUU6w==
X-Received: by 2002:a05:6870:610e:b0:277:f14c:9c0f with SMTP id 586e51a60fabf-27b82fab15amr9961210fac.32.1725795197690;
        Sun, 08 Sep 2024 04:33:17 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5896e1bsm1973485b3a.7.2024.09.08.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:33:17 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Sun,  8 Sep 2024 20:33:13 +0900
Message-Id: <20240908113313.14315-1-aha310510@gmail.com>
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

