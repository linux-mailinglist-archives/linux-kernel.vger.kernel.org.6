Return-Path: <linux-kernel+bounces-320022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19C970521
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872B31C20BE8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 05:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562303A8F7;
	Sun,  8 Sep 2024 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA1dBZpV"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4117F6
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 05:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725773024; cv=none; b=OB+Y+2miot8YWLNFFwEGJsJ5JMY0Dqhbtzh8xd0FOtVitjy8M2bfuCnM18B6iuNRSkDGRrnxgKgCal5BOBnoiVButq2egb99DdEBhPzlerjIG+z28XDJVTTAOxoJ163NvLM95tIgRrGjLhIlYRzgLqcwR5l8yKBAFm7gPo8RQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725773024; c=relaxed/simple;
	bh=Yfv0pt+LGiQg14tp9TXf6mVRyf3onYByhS1Xvhyqg+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Log46vfsFvJxux62ucHVY1lFKOZSu0rFMQF6vA5H7CBKpBOPfjVX08fOrRvm6hr/L2zrr98qeeBeM0l+8vxys0cXx+xuWLaJmD2quwjc8+VFPGsvZ7x+MMkAZWjzLjJPkJTdsWittYKnpUXSV834fW8EOxoisNsjS8T8hvs7xho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA1dBZpV; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e03b6d99c3so419006b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 22:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725773022; x=1726377822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3oVj8gIKovVLpII7y0IVEPaNyb/VXbz1UOiMbkHR8I=;
        b=TA1dBZpVL/Xx1l2lPip48wkcFfND3GtU2X0QBNKNZiV6dhWAxPNgmTFar7eA2do9UE
         hsgMWVkU918tPkOau896M30QTSf/HU5DwYdkcdw7NptQXVkwa2Yf/+jFYLKF8U9ZIxDu
         XIFAdzHsAahMTF6TOnS9c2rrO0N7jSHu2orAlLDS4aMytur/zFYU0b5V1zGlvNNqchvH
         ch4p0PNWXNbjomsmxuQgypx1sbVHLaPLU+3i1cMIW2YSylfDnNUCaYVcLtQ3hi3l1ADz
         1gSfH2lLP7ESQiKq/MjrSesES+maKmJYy51Ij2DpcqXeXN02yX/5krnhX9DhiXm6p39F
         O5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725773022; x=1726377822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3oVj8gIKovVLpII7y0IVEPaNyb/VXbz1UOiMbkHR8I=;
        b=wZrBB/qtCK8sTjasw1+ZuhOGLb6XFRleeIFcFR3O/Q3sP7RrL4eTj6hlSnyEou87Is
         KqbPxIr4iZ5cPDuwI1K5aB9EfVfEMaLJ4GwEexsBZGEztbibB2Q40m5AMbacjpZVG4th
         O07mKLp+xn8ZwW4RS7CLAhiALKE1h4lKTlQMjiOZmIrAzf8LWBGPwTpI9C1GrPYKVcQ2
         dgcTAwqx7QWmy80CCYsFwDabe+Dd+GADLFo01wuuFdjSTAa2bsOHcTLx2ogdpWBfHehQ
         Ram8K8vP76PgpIL1vnFgYyxPriyaDR3jIM6O6hvegEZxjjlop0fxby8pJ6+ghu3S4hfW
         JSfg==
X-Gm-Message-State: AOJu0YzLHf+FvLRwFC9da5RXm9Jh+ghlgdC88+dDvPB+8WetC1gZyBN5
	94ezqvMN/NjmuTQinXPpT9QF7J1haSq4FTSWSaxaTU2uRPd9OIbEGT4dqSwy
X-Google-Smtp-Source: AGHT+IE1KGBAaCLetGIU6aMpwK//8HmwHYIc1Ckt9ND6tM3J9UxbI2VWM+U61Kse9gKo05eRwtQF+g==
X-Received: by 2002:a05:6808:1910:b0:3e0:3c1c:169e with SMTP id 5614622812f47-3e03c1c3143mr3339743b6e.14.1725773022213;
        Sat, 07 Sep 2024 22:23:42 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8259bcfefsm1521359a12.82.2024.09.07.22.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 22:23:41 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Sun,  8 Sep 2024 14:23:38 +0900
Message-Id: <20240908052338.7283-1-aha310510@gmail.com>
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
 mm/shmem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

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

