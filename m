Return-Path: <linux-kernel+bounces-279412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE894BCFD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07541F22470
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C200818C33F;
	Thu,  8 Aug 2024 12:10:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C281487C8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119005; cv=none; b=h7bAhctZdScE1TPQLDmK3T5ectdEjWxb+6AhWrZF1TNZ/o91i+j/C1nXZHux6tgy2FZShT3rFi74T8NGmnkZjuNFR8zqKZOrHDmB+ErHS9WFEYV2dBioLLVaZdcal1Nd/vZqRbYyGlb3AB384U4/MDmxcq+zzMrfU+XszODxF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119005; c=relaxed/simple;
	bh=JkQOm0qGoBj3Z+AvWG7mexIBAE86z1648rdwuuetY30=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J1f7zIrI55c2wgZ6L14Cnb8x3h1akZjvNrhAcQEh9FRN+4u+pG2PnsOHTciEAxeRo+xAEx7cVcx7G8G1J9loWTSJJmqsZDQSaJxjKqe7faXwJkPKGvYOnEbTi1kYMymvcLZArXYYq3ZAHPcDI1iT2HDSdp6s/coZS8qSfx4tDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b2938b171so11118935ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119003; x=1723723803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgqbS8G8qpIT6NUN+dcieZdDFQf9OYrbQahCCrsc0bA=;
        b=wEq/IxUhN+cTXPvur3mh1Mvrt3U5rWmzX3/B9YFyfH46/2MhZtxWRhEX5d0xYdKAq4
         zjYE2UdTI0xabXUBYtpq8f5nUzkc6NzAghaS3GYGN5O1yAVUFSZSVzt+gGpn1JRCk8+l
         ujKTUES2cJelRfMlf1t+4ABQR4NLFWGJT4O6OQL7yDlC7j4MyfJXhAiqPqfoTUgLIbE1
         6JsRw12Bgzyou2uKksxIur2r7pGm6CIHzWYv99fCJcPytq7KZTTYnl7KwAFdP5T599rl
         NzWDyE6mk/z4yDPp2DFZgA2SQua0TlTZNhhMyZhPDltYm+sDPebzOVReInp+Gw8F9pCY
         P/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVIn2aPFmEKZqOTdRVrkc2mGpEz1n65B+/V4wfpVOp54KBxPDxl/S1TUqDJ9iSRxQbppWRa5D45AGHAWbytHg+D87D7x3d5Nn1VozGh
X-Gm-Message-State: AOJu0YwYO2mYcGOeM4f1kq0rybMoLwp6Zd/6s0tYSTlKVY015bttmr2V
	tCGeWXZGiaSYKAgEo067GHlJs0zqztr4xc+UW+uShNlPigK3L2fXllSf+6nljE/kaXAfs1jN27I
	IXDwUGCxoclTtuFhvHD4YvQSIfYZyOKGn+dJ5m9vTnDTARJmsG6FfNrY=
X-Google-Smtp-Source: AGHT+IGv36BPv4s2C9acpU+RW23Juan+WqKVb7K5/43l4JOcRouBUubaj464GZ1N9L6VKEys9R2Ia2gdvVZp9koZj2BZJM0sf78r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-39b5ed7488fmr1344245ab.5.1723119002904; Thu, 08 Aug 2024
 05:10:02 -0700 (PDT)
Date: Thu, 08 Aug 2024 05:10:02 -0700
In-Reply-To: <tencent_F967B76846D6B362E37D496623ACA4433705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012f9fd061f2ae8d9@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: ffff888032f426a0, inode fid list is empty: 1, v9fs_fid_find_inode
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901337
WARNING: CPU: 0 PID: 65 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 0 PID: 65 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 0 UID: 0 PID: 65 Comm: kworker/u32:3 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-76)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9c 8e 8b e8 f1 49 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 d2 2a a8 fe e9 51 ff ff ff e8 38 2a
RSP: 0018:ffffc90000d27480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888032f426a0 RCX: ffffffff814cc379
RDX: ffff88801b4d2440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888030038048
R13: dffffc0000000000 R14: ffffc90000d27840 R15: ffff888030038298
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000002aaca000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=161d9755980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11272e5d980000


