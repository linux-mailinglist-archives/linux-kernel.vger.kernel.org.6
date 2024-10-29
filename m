Return-Path: <linux-kernel+bounces-386902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57C9B4962
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB881C21455
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9D0206041;
	Tue, 29 Oct 2024 12:15:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D677205E2F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204110; cv=none; b=J5oU/PjvzNH+P5eawV+ykuoGbXNN/DbBFOYuQP3/k6tEZzon9AzDcXgQtUGnIur1AiF5UiCxerQ8G/+ptMG27kFDbJpH1aA0RBjNaveWyYdEk89UVktlZauxche3o3tplWsK16cY0jH1HHd1X4xffOaDd3R5HGLAPjyq71JpmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204110; c=relaxed/simple;
	bh=Qo7TfdJLl+ia3sHIR7vXmzlM5ZaJ8oAbTVK7mCVF2eo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rdVwz5o0a8UoAp1umzvLHbhZYIR09hS3sCIaBjUdArsRAyxseZRxnxR6IVJtZ2AGlb0XeU6bDFC15KByvYSpLYDbHWxKVohRA0HP4odSHFBUKxEsxNS0VEexY86Bfwv95WK6WxseV8d4OMqXElr44WLTl3/WZlSIN9pcQSJmAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4eb49864dso33494145ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730204107; x=1730808907;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0FEm/To/GnDoROuOVyUz33Gm3KH3KARtPCnlf1+kaA=;
        b=LBQvJm9pQDu1+BP84UG/mKAAcD3jL3qIoV5bbpn0Jpz8Qc4bQxZwo8zzYkBIDSssL9
         4v9OeQBNMJKzTerZhmA2KN82Gz+8dX9jDFJOU8H7P3HCp/kIW9ZkuGCT6V9EUCDY5AS/
         GqeTVkxYFYqx4zjBqydLKenpRomaBlZzt3uebdeZm+G/kOA6dnwu+Ys06ACt/X3fLlfH
         U2CWXomAK/VUZPkm/S7ElawpLFzrI+fwUxVOK5IpEFcvt6mqmavX2VQ9mqre24NWJgH4
         M45WWa50kOWKmlpVIzeeG5ui9qAir0k/aPVsvnBcHEdf9qcjB5E+7fX5cDz65arlOcuk
         PGcw==
X-Gm-Message-State: AOJu0YwsO4ApWX4Uj4Pwakl2E4h9sCgje3a9JlhMlKygGqPLsbY9oUNp
	6y+uZo4VWYOOg1Zxy+U6nUYcII1iPqrIoVO0PCM81IbOJFBAPERVfujBEqoqBedX49Kq+qJkNQp
	g+QJ5GL/7d9Mxnx2eRVvOQX0WKbjcdOOyzp8+oZtkD9fCfXUvAKwhEUA=
X-Google-Smtp-Source: AGHT+IGiZee/wMBHLzyVrDLh+5LUa0Ei4StwwlJqUb4JVr6WuE2ZisHwu46axwsWFRvFgjCA8bxPKQJMsCF9FXv06ET1V8rgRUkw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180e:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a4ed2ff79dmr92187545ab.15.1730204107231; Tue, 29 Oct 2024
 05:15:07 -0700 (PDT)
Date: Tue, 29 Oct 2024 05:15:07 -0700
In-Reply-To: <671f4b6f.050a0220.2b8c0f.0203.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720d1cb.050a0220.4735a.025c.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in ocfs2_file_read_iter
From: syzbot <syzbot+a73e253cca4f0230a5a5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in ocfs2_file_read_iter
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e42b1a9a2557aa94fee47f078633677198386a52

diff --git a/fs/ocfs2/aops.h b/fs/ocfs2/aops.h
index 45db1781ea73..1d1b4b7edba0 100644
--- a/fs/ocfs2/aops.h
+++ b/fs/ocfs2/aops.h
@@ -70,6 +70,8 @@ enum ocfs2_iocb_lock_bits {
 	OCFS2_IOCB_NUM_LOCKS
 };
 
+#define ocfs2_iocb_init_rw_locked(iocb) \
+	(iocb->private = NULL)
 #define ocfs2_iocb_clear_rw_locked(iocb) \
 	clear_bit(OCFS2_IOCB_RW_LOCK, (unsigned long *)&iocb->private)
 #define ocfs2_iocb_rw_locked_level(iocb) \
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 58887456e3c5..1e37176ac405 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2390,6 +2390,8 @@ static ssize_t ocfs2_file_write_iter(struct kiocb *iocb,
 	} else
 		inode_lock(inode);
 
+	ocfs2_iocb_init_rw_locked(iocb);
+
 	/*
 	 * Concurrent O_DIRECT writes are allowed with
 	 * mount_option "coherency=buffered".
@@ -2536,6 +2538,8 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 	if (!direct_io && nowait)
 		return -EOPNOTSUPP;
 
+	ocfs2_iocb_init_rw_locked(iocb);
+
 	/*
 	 * buffered reads protect themselves in ->read_folio().  O_DIRECT reads
 	 * need locks to protect pending reads from racing with truncate.

