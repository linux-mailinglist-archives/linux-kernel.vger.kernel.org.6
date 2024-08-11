Return-Path: <linux-kernel+bounces-282163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5888294E050
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087B51F215C3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802D81C6A1;
	Sun, 11 Aug 2024 06:35:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3BF4FB
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723358105; cv=none; b=ZgMWMca676FtYVWI40bu+yuc865HCXDQ6EtKayBoLDuPQgI6SK4veVeJyquhNDdmOAPksFePB4CMUfWTqI4GM6G+CeHyjc2wNODSRocB+4ysnrhK88E8+EQj+QhNewKedWCQ2bd1qpt3200iFrYo1z93fV28K8orfQeNPfZTfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723358105; c=relaxed/simple;
	bh=5ksxnJRw2hihZmzG0rNSI16YmqD7lh+v4TJ16u5N9jQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PtnOX7v9Cn5oOCaI9SNBrn2LgYCDTm8rbuaeVgqANaRta3GoGyuFQI9h90bqN7ICY1HR5V94GxXv7RmR/3wqDjePgdqu7zt4xC/QXAhG0ZEyRt5unZ892ryeOZWxXiPVvz+N9nJXIRoArY8E0jI38TsJdEiT49xlLmcar+vUPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a143db6c4so34082605ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 23:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723358102; x=1723962902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+ll5DL71TSNy1YyuZ1kq5738yHl7+rs43ANIpLjQB8=;
        b=SLA9uWMhCPTSDBCSfkqhMAuB/2hJdI+6uJ7Ox8Qlm0pEK5IomtkjeYAAkcEQapoXia
         jidCXP+T38Akmb51KCeATwqiOGe7UypesETCgkHzwVRNAxyRq+9EbK3u2/mOQtOynQj/
         Ys3d+e9beaTXvfdT4ldVgk567nhq7Wi2Uxr7+hJ1WDQ/D2a5qBnTUeiM1RkfYxGkn6rD
         FAKCSqabe5Oa92S+1f/wUbsnAp1V3m6s5ed8jmwk/6wwNYAn4GM99G7wMdp8osM4FlrM
         qXA6WuG2ydVl6jCjGomEVYmza4vgYqq1+FRA8SlRSlxgr4TUotjZrgA8HFISWbLp34FO
         HVnA==
X-Forwarded-Encrypted: i=1; AJvYcCWBgvCX4TCUYf3xqiE0JQMxT3XujBEKEg0+GpMXTPz/kbcGSnVXUJVbQJPGo/q0dlS4N5m3pWh2BPotURr67soj1+FBDekZ/4/m1X8x
X-Gm-Message-State: AOJu0Yzn80SQDQ857mNZJ/g6EfOz9g6t6jHYA6GSt4QbxtW9an9+Qcdr
	TylnnkkInv1bh4G4uhaXKPARNjJw+kMXQMEfCk8UuCJ8jS8W6PnDRzc9H4dNOOk+HSRfNLtKtld
	ilSH2wnFmfcRTK5GIt/L9YqlFXe7xWLWx2MS8r9PSFFMv1X56g9DqKTw=
X-Google-Smtp-Source: AGHT+IF781/wLpHuhGJjCkP+HEuZu2HXXQrPPON3jG/FMXi/xHhRg5o72WOwObwxAK7Fk6h0Lji4ONFiWi5G/RBUZtcDlZ63efed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-39b7a846901mr5250415ab.4.1723358102643; Sat, 10 Aug 2024
 23:35:02 -0700 (PDT)
Date: Sat, 10 Aug 2024 23:35:02 -0700
In-Reply-To: <tencent_3CCDF07B166EF42FD96D8C946CE932ED960A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008776a7061f62939d@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino state: 393351, ino: 1901337, comm: kworker/u32:0, folio: ffffea0000dc0780, netfs_writepages
ino: 1901337, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901337
WARNING: CPU: 1 PID: 11 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 1 UID: 0 PID: 11 Comm: kworker/u32:0 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-97)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 60 9d 8e 8b e8 65 47 0d fe 90 <0f> 0b 90 90 eb 80 e8 49 2b a8 fe e9 6f ff ff ff e8 af 2a a8 fe e9
RSP: 0018:ffffc900000e7478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888044cb0670 RCX: ffffffff814cc379
RDX: ffff888017ea2440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888044cb0670
R13: dffffc0000000000 R14: ffffc900000e7840 R15: ffff888020f2f018
FS:  0000000000000000(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555815235c8 CR3: 0000000020ffc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x6ee/0xec0 fs/netfs/write_issue.c:536
 do_writepages+0x1ae/0x940 mm/page-writeback.c:2683
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
console output: https://syzkaller.appspot.com/x/log.txt?x=106bbae5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1438d9d3980000


