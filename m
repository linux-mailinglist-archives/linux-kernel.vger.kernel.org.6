Return-Path: <linux-kernel+bounces-287676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8C7952B37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB0D1C20A39
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037EC19EED0;
	Thu, 15 Aug 2024 08:34:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183E19ADAC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710845; cv=none; b=fA0NlMGbdGAsQN5ZtfRE/0+BKiocB0DpFbI/y4c/AvmMiSs6UVpWAdT3HCfR5t7wzTv9hqfaYlD5u/X3H60v1Iyi0OCgvXFCycla6Yz8PFkY9Q7vcjoP/HBT8K5aPgTzlOZMCoLQ4zfar2MFoXEEMCVR+NfnjLI71uiwAg653m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710845; c=relaxed/simple;
	bh=WvBwN1wbsbujgz5ntVZAvqCOCnhGAQt97MjOUNNKJuQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=idKiw81kdvHQBs3DtpNoaggM8hyq53Tip8tAjpbz4RpHtwLHhV09Wwkp7s7kp8vPqxNgHEqwdPu3apaPEvB8QnCETlwl47zXhLVdBVd3LGuzL1abMvtVZqAYDL7TDrqqfN/8vJ603Dfl7oyF+ciQCT+W4hNQKWRIPLIoz30ZMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa44764bbso90573139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723710843; x=1724315643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMBaUtlfiZd3x0j+3JTRGbxRgqAYUR0clTNLfAA7gFM=;
        b=AZYSmm+9B36xTKqh5Z5LFGC6Mv9+/ANwi7WvFqPd20L6BB+n57dDsgms4Fi1u0z+QY
         tmM9B14w4/ViPeVXBMIrCa9Rt3jRrrWQf5VlgRA0YY4AUQLFl+e7L9AvDiyIWa8kfKY6
         Lj/ImdhAm8efBH6XNg0W6cgXwjuVs3TAgKgyWFK/FBGx4zXzNXxwpUW9Y16eKnDb3Aqs
         iUXZ02FSXnZJOCB/nQdI6JUFSTp69HjWIXyMJrXbOr0ZuKgRKwVgP6K84Nup18VQ6ZqP
         s+UdDTgjQjfnQLWYE/Cl8RyaCV7l/iN6rfVxyEnDFU0qgehMdixTQZ95WIbVYcp0oYm6
         HCbg==
X-Gm-Message-State: AOJu0Yzsx3UZpxGqGfbbZnF/4ejHmqQlayn7KOQSJBrLqY5caJNQDvlG
	2eJIw4TcPp5bzFbmk3X0p2vGW1z2rrzdTa29sZWYbHrM5WVFCx5I6Fh3egOqXzX6HtwW9hvicMy
	qE9xomtGpLGy0bRVLQ0b5zhP7hQIHk86Jgbd1ycvX6LFhMbc539rnJgg=
X-Google-Smtp-Source: AGHT+IHkbz1AR8TbA8q8U1K86plrWKXIhoM8Ju+EBdovtY/K8ZrTRlWoTH/qcgvAzDJU4zorL1zTlN68gOqDmIKcMrh3abBFjbND
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8916:b0:4c0:9a3e:c24b with SMTP id
 8926c6da1cb9f-4cab050ec69mr225692173.0.1723710843289; Thu, 15 Aug 2024
 01:34:03 -0700 (PDT)
Date: Thu, 15 Aug 2024 01:34:03 -0700
In-Reply-To: <20240815081319.3450173-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000829a15061fb4b4e2@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: 1901338, sync: 128, wsize: 2147483647, netfs_writepages
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901338
WARNING: CPU: 2 PID: 1106 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 2 PID: 1106 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 2 UID: 0 PID: 1106 Comm: kworker/u32:7 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-29)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9b 8e 8b e8 31 48 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 b2 29 a8 fe e9 51 ff ff ff e8 18 29
RSP: 0018:ffffc90005dff470 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880460ecd40 RCX: ffffffff814cc379
RDX: ffff888022c0a440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802dd79d88
R13: ffffc90005dff840 R14: ffff88802dd79d40 R15: ffff88802dd79d88
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000000db7c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x773/0xf60 fs/netfs/write_issue.c:536
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
console output: https://syzkaller.appspot.com/x/log.txt?x=101677c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112bc3e5980000


