Return-Path: <linux-kernel+bounces-334416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02A097D6F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E29D28947E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F017BEAE;
	Fri, 20 Sep 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwjt/kC2"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71F22066
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842837; cv=none; b=fGnBOo5INKm7m3rirm9gdhcQK9ug/rGxq2VtncQ33Yqpk2AQ90T0Zz5EAxjC5aHI3Ok5pBbcj+wyB+JmIf4ikiKoOfkCDadsC72eEqOWd0aziDYnIeN52dqgd+xsb3YjU3PJEh2cEy4rLa9EGrE4AVPHwuOgbg64O+g3lycfhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842837; c=relaxed/simple;
	bh=Z7/9xzUSnqg40ACuTWBcV/Q70r10k0OJSBs9a3NyT24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EXUBR7sEbDqd9LHoj5sQAj3RkqKWsnDVUugpLkub7CQExenr6sr6sGv2vGU6QYooN9JUzH8OZs8STqN5ENh0gVLCi/jETNwsK4IK9hUVakno4bIGNHwqS1D3ID9lYgA6b4m16ZERzD3u702kGMh/Nv7t33cF/cv5JXWWX3sEJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwjt/kC2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71970655611so1822972b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726842835; x=1727447635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ySjOoFEz0iCedQw7NuLkZMcf9Ru89yqMQu+KwDu2BE=;
        b=Dwjt/kC2SLKG10maXJuQITQO0ry8gg6G5j9zSO2F1ELOq/QH01eFpWXz22qI2MxIdc
         oOrIYSq1D+gyutxOV9vmm39J4sMVrcUs3wzkqI+WmlMJ6SjaUdvb1jUGnqR/rdd3tBGF
         Fu0JQ6NkoBHoXyn07WN1oCdv0Pk7rdEUBrhN2ykl4rG8eRAeOkR9uIvusQSGG0NbpNO2
         vKtPi0pNbcdjYBAwG8hFgbIZ1m9kfm0yxFx6qxYQu6AMpDdaoj4xfGEZXFvl4CGqLPLl
         Eq6a9GhxbyZRo+XPRbMFNVmdtglAeVyc/8HGIB5Bj+htikolloK4pqScQ5Ig7D96K3cv
         xRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842835; x=1727447635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ySjOoFEz0iCedQw7NuLkZMcf9Ru89yqMQu+KwDu2BE=;
        b=s5gQTbMoc0QFGc/jbeiNPIBQMWkagxOw0BA/TEhn3ZIHqAECqM56zm57WxVCiaQLFM
         q+6XE/CHn/xV70smPKck03a3sk7WWOCBqatmaVgqpXzRjItAMQuwLFsrXdGfRCUY+mXA
         wxtBrn858B4oxcJf9DjYiEIc0izhOP/lQ3t91wpAeyWRP7o6FFporkpYkORbBVRl7Dqg
         xcTZJ4ttDUOWkNM05nVNsbmbbXDS/bRnEuN1dzpbw6/rnpFr3fS/4GUOINfeTiSxHYKB
         Ql8CYzsnkwJp/7yr4125HR4bUFxtSVIeUqe3px82d4Ka3LTF5tYI3Zh6CwCgLZv88GZR
         piHQ==
X-Gm-Message-State: AOJu0Yxk3/McLHTtZr0kXMgekQs+vDapRwIEp1nnEzQ6zyvmbZiTiKjE
	TjRSIjKlXEqZnXoQBHsAOvNo9sZW4/YNwGD+KVzau2aap13vJpFw
X-Google-Smtp-Source: AGHT+IFloT4SGS7zI+YMGBrejDEj0NnbcF5k5mXnbGLgShQkZWgIfR60Wqz5g8lX9PDlUwCb5UV6dA==
X-Received: by 2002:a05:6a00:23d3:b0:70d:2e24:af75 with SMTP id d2e1a72fcca58-7199ce3e982mr4949641b3a.24.1726842835158;
        Fri, 20 Sep 2024 07:33:55 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a97582sm10213333b3a.12.2024.09.20.07.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:33:54 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Fri, 20 Sep 2024 23:33:50 +0900
Message-Id: <20240920143350.4194-1-aha310510@gmail.com>
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
 fs/ext4/ialloc.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 9dfd768ed9f8..5cae247ff21f 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -500,11 +500,14 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 		for (i = 0; i < flex_size; i++) {
 			if (grp+i >= real_ngroups)
 				break;
+			ext4_lock_group(sb, grp+i);
 			desc = ext4_get_group_desc(sb, grp+i, NULL);
 			if (desc && ext4_free_inodes_count(sb, desc)) {
 				*group = grp+i;
+				ext4_unlock_group(sb, grp+i);
 				return 0;
 			}
+			ext4_unlock_group(sb, grp+i);
 		}
 		goto fallback;
 	}
@@ -544,14 +547,17 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 	parent_group = EXT4_I(parent)->i_block_group;
 	for (i = 0; i < ngroups; i++) {
 		grp = (parent_group + i) % ngroups;
+		ext4_lock_group(sb, grp);
 		desc = ext4_get_group_desc(sb, grp, NULL);
 		if (desc) {
 			grp_free = ext4_free_inodes_count(sb, desc);
 			if (grp_free && grp_free >= avefreei) {
 				*group = grp;
+				ext4_unlock_group(sb, grp);
 				return 0;
 			}
 		}
+		ext4_unlock_group(sb, grp);
 	}
 
 	if (avefreei) {
@@ -590,11 +596,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 		if (last > ngroups)
 			last = ngroups;
 		for  (i = parent_group; i < last; i++) {
+			ext4_lock_group(sb, i);
 			desc = ext4_get_group_desc(sb, i, NULL);
 			if (desc && ext4_free_inodes_count(sb, desc)) {
 				*group = i;
+				ext4_unlock_group(sb, i);
 				return 0;
 			}
+			ext4_unlock_group(sb, i);
 		}
 		if (!retry && EXT4_I(parent)->i_last_alloc_group != ~0) {
 			retry = 1;
@@ -616,10 +625,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 	 * Try to place the inode in its parent directory
 	 */
 	*group = parent_group;
+	ext4_lock_group(sb, *group);
 	desc = ext4_get_group_desc(sb, *group, NULL);
 	if (desc && ext4_free_inodes_count(sb, desc) &&
-	    ext4_free_group_clusters(sb, desc))
+	    ext4_free_group_clusters(sb, desc)) {
+		ext4_unlock_group(sb, *group);
 		return 0;
+	}
+	ext4_unlock_group(sb, *group);
 
 	/*
 	 * We're going to place this inode in a different blockgroup from its
@@ -640,10 +653,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 		*group += i;
 		if (*group >= ngroups)
 			*group -= ngroups;
+		ext4_lock_group(sb, *group);
 		desc = ext4_get_group_desc(sb, *group, NULL);
 		if (desc && ext4_free_inodes_count(sb, desc) &&
-		    ext4_free_group_clusters(sb, desc))
+		    ext4_free_group_clusters(sb, desc)) {
+			ext4_unlock_group(sb, *group);
 			return 0;
+		}
+		ext4_unlock_group(sb, *group);
 	}
 
 	/*
@@ -654,9 +671,13 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 	for (i = 0; i < ngroups; i++) {
 		if (++*group >= ngroups)
 			*group = 0;
+		ext4_lock_group(sb, *group);
 		desc = ext4_get_group_desc(sb, *group, NULL);
-		if (desc && ext4_free_inodes_count(sb, desc))
+		if (desc && ext4_free_inodes_count(sb, desc)) {
+			ext4_unlock_group(sb, *group);
 			return 0;
+		}
+		ext4_unlock_group(sb, *group);
 	}
 
 	return -1;
--

