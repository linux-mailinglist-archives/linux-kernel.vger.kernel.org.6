Return-Path: <linux-kernel+bounces-283946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDD094FAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3062B21A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F1E5661;
	Tue, 13 Aug 2024 00:57:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493844A23
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723510625; cv=none; b=CQsndsgUEND7X73AKCRVcjBcU940iOWe4dBOX4PBz9dk9tsVFbEcSEL9BHmlHechqOYyFiPpy6T8U3ahrS9g5PiCloK6BWBxTNfBbJx71NWIgQcwnZLlsCra7NPvgSRF1+ZwQy6huMTaH6F1PQNs9ZkVs7RiqYml7PW1eyBhHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723510625; c=relaxed/simple;
	bh=2ag7cpysBMdQIWsrW3K1o/lmo3/SG/ofXdgE0DGVeSM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KMt4g3LOPRPbQxOJT0A8+HWpuV+s4Xt7Or/P81JLEe41UsAPtvyqVIbpslRb1dT6l4bswp5buFdq70iTksGNMQuXg7iYj7cXsRzsDVeFl0yCB3KU2+vxqWGfm032XMWXVK70e5ffZWekkP64kWOtacu9Jc7IEtQJgYGhezbB+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so609907139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723510623; x=1724115423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfgACBN6LMlB9ysqJ7f5aRuWU+LZ0USjeCNnZe2pXAg=;
        b=eDK8a6XBed5Yvim+pB7fatJGMo3wPiio+izr/OjiejPS0RGGvnSJ7TKwYh6tPnQb1N
         EvCc7NVc/bleMHIyDoMZei4EB83xPJMKrmxFD4hfTrriP7QkI4QXsmMmeiz/7NmJ7mAO
         HYz8d5VMcnG8VBIpYU3/eWwJ1ybNBrLftjux9dxy06gfLj/theriAjfBJFvHg6v4pBvV
         k3SFhJAFGmZILywxFY5WsX7ELbLqST8EXpzBWOczgth4YR9Q3qx4ofCTpQzANok4WkIr
         LAmQaBPTmfwulj88Y9ucXuh9eimP1CBo1ga3NQnl6TbNOc57y5+Ki2uyNIdscNtMFQOU
         g4zw==
X-Forwarded-Encrypted: i=1; AJvYcCVeOb9+WsH0wYJU9fTURGp80aMilKY3fN+WMYc+bAHW6GKs07hoCZ/t2v4Aply3t+g8dHK/T9eAqT3eEpHV0vBv9Ts0piFO5w12v861
X-Gm-Message-State: AOJu0YwWhf9vkSJNJZ53CvZXNN4FPMc73I3tiDV51XX2xHTjYukHW1JY
	/5eZmB0lbcj2YdQQTdWvreJ6Q2tDqLsSJLzSDy43kiabxrD32vYgvpoRGe5HpEr23YbuwXC1wYP
	arns2GedxYhl35BuiB9jBGgA8lXoUL54MhGw4mFbiW2z8lxxmO2yt1Yw=
X-Google-Smtp-Source: AGHT+IGKAbeE42TpFXfis+Fz4ebs+nLb1GmrVL6kBA70HTSpLLTrfnPZ0ohji4XLs80pbxtOanBraOWlv8wWw0k0inFOhaTcLYV4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8601:b0:4c2:95db:b837 with SMTP id
 8926c6da1cb9f-4ca9f89afcemr99615173.6.1723510623348; Mon, 12 Aug 2024
 17:57:03 -0700 (PDT)
Date: Mon, 12 Aug 2024 17:57:03 -0700
In-Reply-To: <tencent_4F3D01369496AE36884A5875BF762566BE09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078b825061f861675@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino state: 393351, ino: 1901337, comm: kworker/u32:1, folio: ffffea0000d06040, netfs_writepages
ino: 1901337, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901337
WARNING: CPU: 1 PID: 13 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 1 UID: 0 PID: 13 Comm: kworker/u32:1 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-143)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 a0 a3 8e 8b e8 75 3c 0d fe 90 <0f> 0b 90 90 eb 80 e8 49 24 a8 fe e9 6f ff ff ff e8 af 23 a8 fe e9
RSP: 0018:ffffc90000107478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880324173e0 RCX: ffffffff814cc379
RDX: ffff888017ea8000 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880324173e0
R13: ffff888024c17358 R14: dffffc0000000000 R15: ffffc90000107840
FS:  0000000000000000(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555571e075c8 CR3: 000000002bbf0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x97c/0x1240 fs/netfs/write_issue.c:551
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
console output: https://syzkaller.appspot.com/x/log.txt?x=137d46ed980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e46af5980000


