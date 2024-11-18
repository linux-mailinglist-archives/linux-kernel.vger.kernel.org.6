Return-Path: <linux-kernel+bounces-412685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBFD9D0DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74905B27276
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661061946BA;
	Mon, 18 Nov 2024 10:06:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F917193075
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924385; cv=none; b=nWhwSgIDn9Q9HTI2h26ao7Bo3JmU3WB9gpHElzElphmR9oT8DOvjm9PQTRuinTe+MpHL9jBM2srsbaAA4L6swYbDDVzmKYYqeYe0POckK2U9MfTM8GGZhbWmh4c2PXPnR9PYFc1wgnjwVnuzXZdsUkjd8WTAoOMOiaZ05zk0cDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924385; c=relaxed/simple;
	bh=9PkD9Q/kE7hICbwwb1hSIC1rtP89m2CMQSEfhG73Qck=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QQ3JZOdPRcA5wsY7mfNukkiBK4FyZO9IzuhXDuNGQx1+hxp/7WsRZ3iOYZ3u5jysxZFTUIpnSbmv2+ysQknYXUVn+DRQGQjwd9jGQnDvBDSkjHVUrPsQC5RRiGzBqxPq0QEcQApr096e+l+hB9UwdLIYfkjiAv5aAR8IyiC+QYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aaca0efc6so423787739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924382; x=1732529182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ylip8umtXskYMIajfOQpxRLbG1VkTKbl1GYfVrPBfP4=;
        b=juu7IoO6Z67mHvKm/Y9MTojvzSRkHTakqpvzv5zS5gMP4QJneDkAGq24ZF7ym5sKBW
         MRt0YEvzj2v2ErXOCpF3W5Rmbm4XucZd7UbiSDzsQXA3Mhu7HhIF8lwsC7UJ0nYsQ023
         Yj1n2Y4PmOhAnZvhJPU78zVe80GD4IVx/hL/7DhsttCpG6khhffYAdBVQzDnHI12Fnhj
         WhRW4JYfLW2frkzUKEiYDPFvlO4ZFG9sgE8jlEvcUYbTeoEwzHFzcrml3iI5qV7biwIC
         nUHzv40c6Mh8ZTSWhV+5y01H6G6Kp6aOr/sBJgoUIGZVfwXqFdp31tyrwap4KvmNQHJX
         cZyQ==
X-Gm-Message-State: AOJu0YxhTbuPKkfzDHhTH5c5QPSFAeGGjfmyuH5RmMBWwqUUanxXmR8x
	FglQoZ3h+lwmvx6zaCO2TKX9uLAqowsOuRQPkC7MMklOFFxUPRVNmhkw733pBVQZ4rfH7++meuO
	9SiWSbcQDYI0U5MSpsHtFkykcdY6rkGS4Frc1Dh1qkZrWwywzC6a2m2c=
X-Google-Smtp-Source: AGHT+IH6E9f2wZAa+uh+cuyYCFXXmTyYhh0FKeQ6fOew+AzZ5Gl6aORlLEnBuG+M8DDUaN06Ft3ZV141R29co8K6VusjLm/XuCT7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca3:b0:3a7:2194:fd3d with SMTP id
 e9e14a558f8ab-3a748041fc6mr86801075ab.14.1731924382582; Mon, 18 Nov 2024
 02:06:22 -0800 (PST)
Date: Mon, 18 Nov 2024 02:06:22 -0800
In-Reply-To: <67381991.050a0220.57553.0045.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b119e.050a0220.87769.0028.GAE@google.com>
Subject: Re: [syzbot] Re: general protection fault in jfs_error()
From: syzbot <syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: general protection fault in jfs_error()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git adc218676eef25575469234709c2d87185ca223a

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index d68a4e6ac345..d2eff3375aad 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -96,24 +96,29 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
 	}
 
 	tid = txBegin(dip->i_sb, 0);
+	/* Do not go further if jfs_handle_error() marks us read-only. */
+	if (unlikely(dip->i_sb->s_flags & SB_RDONLY)) {
+		rc = -EROFS;
+		goto out3;
+	}
 
 	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
 	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 
 	rc = jfs_init_acl(tid, ip, dip);
 	if (rc)
-		goto out3;
+		goto out4;
 
 	rc = jfs_init_security(tid, ip, dip, &dentry->d_name);
 	if (rc) {
 		txAbort(tid, 0);
-		goto out3;
+		goto out4;
 	}
 
 	if ((rc = dtSearch(dip, &dname, &ino, &btstack, JFS_CREATE))) {
 		jfs_err("jfs_create: dtSearch returned %d", rc);
 		txAbort(tid, 0);
-		goto out3;
+		goto out4;
 	}
 
 	tblk = tid_to_tblock(tid);
@@ -140,7 +145,7 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
 			txAbort(tid, 1);	/* Marks Filesystem dirty */
 		} else
 			txAbort(tid, 0);	/* Filesystem full */
-		goto out3;
+		goto out4;
 	}
 
 	ip->i_op = &jfs_file_inode_operations;
@@ -155,10 +160,12 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
 
 	rc = txCommit(tid, 2, &iplist[0], 0);
 
-      out3:
+      out4:
 	txEnd(tid);
 	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	mutex_unlock(&JFS_IP(dip)->commit_mutex);
+
+      out3:
 	if (rc) {
 		free_ea_wmap(ip);
 		clear_nlink(ip);

