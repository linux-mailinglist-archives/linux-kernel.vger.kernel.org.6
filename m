Return-Path: <linux-kernel+bounces-279738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68B094C110
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730941F29866
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48F18F2DF;
	Thu,  8 Aug 2024 15:23:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE118EFEC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130586; cv=none; b=dqxf7GY2nrVso1gaoaxGdf1t1fBCJxayoxhqoGwqxFZSiE35yWIComjkPdW9//+rQvSMZ5wKyox771Rdg1NBPdTtXjga1QZpCvaekDvqgsxBwFK8gP7wCGQhrMDSv94NvKPk4VP6r5OJA/AlDFf91JGUmnZET7pBDLKNRo3jRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130586; c=relaxed/simple;
	bh=7SAacujhggrjPBtwCORSjOPvueoog2lNLmRVvAGCVx4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gT0YD5Xrrm3h59PETQelkwrD+mEugEUCGe/Sb55SiFW+DVP+0KfmYtI9jEueQoMpSiNeY3poOiSjkbQrcc3FdZCl+WhZhIMyWwIa+4l99cnIkR2KJXiizR+uxCFpy9QehNmTYfNCphQUEUs4mUR7Js+CC8glSIt5YGHk9J/xYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b3c9fdbb6so12280975ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130584; x=1723735384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIqCPdy0DJClvcPKZ+cGoQ4/v++pwQRgmeU5SOemesU=;
        b=MSne5fGvE4oY1kyBW5xCPArym5Fn3E0fg0LtVVY47+d/AxGFhWnzCgdtxZ6mw/jwax
         +b8gTivR2k/iqQfk6dZwEgRLRPcaE4jt54Kj/i/GB2Uyhyjhc/5GuzyYRF3KkeAnmAbB
         smceiYFQIBzpfy0XS8dQX162nyZkC7Zq1F1cBiy/IVIWe1Xm/5NdSthzTzt72Xleh6Na
         nihR0UIcBlSvMAyRGuM7+HCfUtkyBiDwuijL1lVkbt1GWtm5WwftQ7KS4Ty0z9+fPVjB
         Kdt6hBQ0D96MvyRWXhQjraDpJbb2UJOuEvZswyLFDtZFR5p9uUItIoqGOwspLx6C64Vz
         UR0g==
X-Forwarded-Encrypted: i=1; AJvYcCUdM/rrlPYEdNETkedVV2x1jwGce5iPKAbzQ0zSNs7iwsrVN1nU6m5rEg2LStBTpmJlt3sR5ne8lI7Z8zLJCdAnya4ZmFT05BCT567z
X-Gm-Message-State: AOJu0YzTkzRJPqm83r/TjiBWfP3m/fFLaSSkCO9RWm3QzgDQF3xMTTu7
	xP2knvKgsIsVjKsw9gc8e86vySQ+prXv6rgbyteNkC/BImaz9/b61POb6gn61ycFkjbXIdpmmlN
	YfVxebkcivCCKQgDuxQ6bTyI/agx/GlvrzfPE6um9QLktfd1MYf9857M=
X-Google-Smtp-Source: AGHT+IGhdKynriJiJQbA2xk6ko6TkdGNlUQYBhv/JcQmLWaD2P5SJFq62r/iEFQmJ0B9F2ugsUv+OvHvtj5981uS6yptm9QiEAXS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0b:b0:380:f12f:30de with SMTP id
 e9e14a558f8ab-39b5ec80112mr1806875ab.2.1723130584339; Thu, 08 Aug 2024
 08:23:04 -0700 (PDT)
Date: Thu, 08 Aug 2024 08:23:04 -0700
In-Reply-To: <tencent_1609A06ED7AEFD4C9827C7C6D352D4866106@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061aafe061f2d9a4d@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901336
WARNING: CPU: 3 PID: 1109 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 3 UID: 0 PID: 1109 Comm: kworker/u32:8 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-18)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 a0 9b 8e 8b e8 35 4b 0d fe 90 <0f> 0b 90 90 eb 80 e8 19 2c a8 fe e9 6f ff ff ff e8 7f 2b a8 fe e9
RSP: 0018:ffffc90005a9f480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880327b26a0 RCX: ffffffff814cc379
RDX: ffff88802291c880 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880327b26a0
R13: dffffc0000000000 R14: ffffc90005a9f840 R15: ffff88801bbdf358
FS:  0000000000000000(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 00000000247e0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x656/0xde0 fs/netfs/write_issue.c:534
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x611/0x1150 fs/fs-writeback.c:1947
 wb_writeback+0x199/0xb50 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x28d/0xf40 fs/fs-writeback.c:2314
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=136a5b6d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123eb723980000


