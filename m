Return-Path: <linux-kernel+bounces-280285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E493594C82A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783AFB247CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B2F11CBD;
	Fri,  9 Aug 2024 01:44:17 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64161168B7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723167856; cv=none; b=YmzrUf6DD03Chcyz4hL5qd+O1CKPWrK4rQJkFycEEpz8aOh0Svc7ZoTWx844ugU3abQmI23iEdiAeeL3ytvp+mzYFPLAhxXhNWqrhdqIGTwBye3+saz218Yc1LbH7tXyb8og3l5GPeinuVa9YdCAyxmAFI/LMB6YfB2V0/oFLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723167856; c=relaxed/simple;
	bh=brgWCkchBWHAj9Lz6L+tJO4Frn226hbQfzTKJ+6Bw8w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZHbit4iCZXxBcocw0g1KblNtKy0MjXTOeXwusaMjZAL/4WKnj2cZGG2ji5D/6ygNjl/zsr4m2M/ykA/8IKxHJzP1OqQ5gXCnqeZTIZdJMNph6rkdnQfZsKXaLjG1jw5/bUnziu1YYV+S1KRE52/NNhzRFgbA8FeM8bcbR7dDooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f7fa42463so175911439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 18:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723167854; x=1723772654;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLet5s4ZSTdq7XeabZaViBYlDkouEcG/TvnL6kPkXN0=;
        b=p9vY18H4TTfU/prmqHVEOr6vNNEBFXjK/ZbNe25T6rIphWfrTDh0WMbUPlgpQUZHea
         Vk2IAdSgtUQaIAYGAWZitM3H5feJGgZ6pKrLsyWBfPmWznr8KsKwCpgaA+FJfuTjvKwZ
         1/mwfdsG+7KeDYa0tae0w3ccmEBnVBCqPaRz8oVi4W9UZSUyTIXtN/k4EdXA0s3sNy9f
         e7Ce3rNmrlnQYJs9TvdRz/nmNF1oPRvz6YjhOByeDDHAwHhZ4AJTxKXAypt38DWLaaSw
         kI1pL21fsyvP2wKxoRBU0ep2F3n9gjW8JuN5srAVp0XUwDege3jiuhUeuDtt/jS3wabb
         onsQ==
X-Gm-Message-State: AOJu0YyTa8QoBHGg0M6iG3tAGNmSHB714i5azikPtHBHtyvnLKPpJmlA
	ynIKKdUDFY1snL/ZN/4KrWwfdhCkUIJfD9Gkzk3Xden8jCNhL3L6dz5MkbZux/S9cqizjAZUE7r
	qh4a1bkNHiEFUENE92l3fec+oPHOzmaFNEuznG1QxhwhInQFSvBi64wI=
X-Google-Smtp-Source: AGHT+IEM6/0AVZEjS7euN9gfW94wuBFTTnyc/WMWg6dQ8T5cE3VjElEK0cgjXW0ieOIidJ+Rx8C0HQUMDXWYYtgPeqKCj/gCqYl4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1545:b0:805:e4ad:66d6 with SMTP id
 ca18e2360f4ac-8225458374dmr11028139f.0.1723167854552; Thu, 08 Aug 2024
 18:44:14 -0700 (PDT)
Date: Thu, 08 Aug 2024 18:44:14 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbfb39061f364783@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

wait for writeback done before release inode

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..cddbd7cc39e5 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -218,7 +218,13 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
 			retval = filemap_fdatawrite(inode->i_mapping);
 
+		printk("del, ind: %p, ino: %lx, ino is dirty: %d, %s\n", inode, inode->i_ino, inode->i_state & I_DIRTY,  __func__);
 		spin_lock(&inode->i_lock);
+		if (inode->i_state & I_DIRTY) {
+			spin_unlock(&inode->i_lock);
+			wait_on_bit_timeout(&inode->i_state, ~I_DIRTY, TASK_UNINTERRUPTIBLE, HZ*100);
+			spin_lock(&inode->i_lock);
+		}
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);

