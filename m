Return-Path: <linux-kernel+bounces-282187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28F94E09F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 11:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472F81F2149A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA8F35280;
	Sun, 11 Aug 2024 09:13:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EEB64E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723367584; cv=none; b=f/5EuoXr0yLgSdLR1yjxi+DOS0tJ87vC8g4tpC51E382mHzegH7uYeSzzwh78NvyZZx6Kn/bmHRfDx7TJGgBa3l9k4jyHeY3CPJR4yDsmsy0y+Ph4hwPyZiUa9r2PjFX72g3eCM6fxY1nIpdTVzyfSh/x8atcqHlaeZu6x93QN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723367584; c=relaxed/simple;
	bh=klbHZfayzumkyR67rDrJLC4y73/9HCFsYNQnIa4igpg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b8LXvDeNhoOrt3Tzk79jsvegUMySnc16EUQv8qw5OAZXxZHZFYHPXXmCct4MY14qvYb/Ilw6UhRNJ43lRh9aaOYMt0f+ewbSmznHBkCMq+NUZ4v44Xs8qGpRPgU4vWGasjUfQyhiiMLxRAPO1+JkF7BV5tkLIHauph3qnNzcdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b2938b171so42521885ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723367582; x=1723972382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZmUrBvlWoKmg+GJklyguJkrx1k9BhcFjUkcGW/8OOc=;
        b=pBpvJErR265o6zxGq8v9am1qRyKR1SwvaEhmYR9Y5sRBcISUjcZ/pPE3RpAPgKRvTb
         ae28Aiuv6wQXZJfwxYQuf30qzEUkY5Amtd3qY0qWC6Ldky822h5VlLHJVwgpmyvPAnXG
         3b6K+M0WfT6VxFsZbttXJKruFWDdQ7HltfN3HtK6vzE1qtvq6kQGDuj8+QMCJ1sKVeIs
         EdMk3i6Lge7Zgiph9lwjMfNAK9Fdl4iKj9XfnUAg65XicH1WhwCFKC5W4LPJgpXpfI6z
         z53oFWAgzSlvOoHtmVcSWgfBZt60pa43xS+GRnxYZ2s5jYpawwLAbF/huIVWCTiv4r57
         XQFA==
X-Forwarded-Encrypted: i=1; AJvYcCUXWov21kIrpGtq+/d5XP951h0q5QGnL5YvRsS7/rTIEYzOJreZOTAoovg0Yg1eqfkNIBvRk30NWCvdkurJj4bhU7J1Qrr1m4+wg1wr
X-Gm-Message-State: AOJu0YySYFBhLYRGsh8uy3g0WE6KAe+U3kVLGh6E+IiCGxTvpzpJE7S3
	mwdKILwH9rZn3oMbBH/RArkzpm+MVgVf0OUC/CtU+TkrKfToOuppaD6uw9LSo0DHV3zO0Sjsgbg
	a3Wuta7GNrOKW79F/neyfw+e6tzuza2uZc3HAENC2kivOJDtUaFKOLbI=
X-Google-Smtp-Source: AGHT+IHCQaEcWice3D1rrm8a/k8V9d5lJfgQyC60JDECvl3PqYfX8j/dPJo+m4L+62oN7cf9nJ4gOjnnXgZvswo5gX1xsrHM0Ssm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ca:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-39b81333bd8mr5401975ab.5.1723367581814; Sun, 11 Aug 2024
 02:13:01 -0700 (PDT)
Date: Sun, 11 Aug 2024 02:13:01 -0700
In-Reply-To: <tencent_ED33039E0E1BA24BEE1B67250DBA58BBC408@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008820c9061f64c8d0@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino state: 393351, ino: 1901336, comm: kworker/u32:8, folio: ffffea0000dd71c0, netfs_writepages
ino: 1901336, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901336
WARNING: CPU: 2 PID: 1115 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 2 UID: 0 PID: 1115 Comm: kworker/u32:8 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-121)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 a0 a0 8e 8b e8 f5 40 0d fe 90 <0f> 0b 90 90 eb 80 e8 f9 28 a8 fe e9 6f ff ff ff e8 5f 28 a8 fe e9
RSP: 0018:ffffc90005bd7478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88803310cd40 RCX: ffffffff814cc379
RDX: ffff888022ed4880 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88803310cd40
R13: dffffc0000000000 R14: ffffc90005bd7840 R15: ffff888045888c58
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0014bd000 CR3: 000000000db7c000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1558e95d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13aacaf3980000


