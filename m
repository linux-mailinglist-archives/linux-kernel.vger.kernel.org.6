Return-Path: <linux-kernel+bounces-281762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938B94DAE8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1B1F22303
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 05:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855813C8EE;
	Sat, 10 Aug 2024 05:29:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5F1CD37
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267744; cv=none; b=Vn2N63BUdDRxCnqLPmi830VYO4QsfDIEDCpxvhy4elSJxcYxn6ccVKMu2gOboenJmaQ2MzPsw8Ae6XKKLmz6b9A18RuO7Uf1LOPdNukEeEORdAA2ExYjOmGutxdLPKlZMHogSUAIkYI8htHjQ1v4M5p3A9yGileMVM/VGbVEO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267744; c=relaxed/simple;
	bh=HCFRJl1n0Zat2bEtJqSV0wuOHBfgyJ5I6N0Av8jEel8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bzHzalufItX5d8qztRwBy+4EL1arY2t1nQHBhikM6hZRwmoV+YyZARGOr0AtXD2psWbRA4YbLuJy/67NVQEJ74fZ/33JKXMb9CVwnsXPzyXA3i5eadaI07DRNaNYIhhKUBVFeSP18b/z5vdKVQcggiyd40qulcRF0COXB2CITGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a16e61586so35188225ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 22:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723267742; x=1723872542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNpz67BHJn/KoY1MLDQIFrifjd+BorGTioJ0gkOf2UU=;
        b=bwhtIyMiK+tDHyQwpjpCzx8Oi1e4UHJU1xSwNGtlsa3dXCJhH9z7gqkUqQmeJ2IGiZ
         UXM0SooczSCLM80POeA4recMbhrUaU6xhAAuP0M1diur0hC7NJOyNqINDSTkmigCkBbv
         ooziJH7ASLHOlzzO74iJnC70ds6rZSk1t4DAvpGmg77BbIafbtJBfRPwBkAtGzkShMFM
         0lXAcP+G5TPj8grQ0xPvlAVA5iDDok/DzHOt44VSTXAoHCrnNDUcBSOYyAA67vNe8N1k
         n7Mr5VeZyJ+22CLm3ojUKLGBjxlQWsId5JxbHUZ3dj3VgIsPuqZIrQEFnIwHHi6RmGHe
         nvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP/RraOaqII5D0FabkWf5YuUEqamB6pcLoIu4bRymzF6zRRwJhABTSs8Hxj6TgDgrxCxsnUa2CGAgu4h42qdy50RxRhK2EZkR0fo0Y
X-Gm-Message-State: AOJu0YyBoGLB0Obusd/ZCcIXa6QFq0/mtca4eMFVjOHujTkCm4A1COZ9
	GPD5yuj9Hqy4Hdb5II/8Ugcc7hKe/su12FS6xEWAIip6PohRlyJF+VFBwGBPzQsy9Rbzae1IN4K
	zCuYi5IF2DS1BgZPVSvsdLJErxTlgFr6UcZaPSmV808a+kBz/TeEouh8=
X-Google-Smtp-Source: AGHT+IGGNhDy2Xfi7YiKpSfYwJ5Hnz7I1gJRdzac9dD1FLj1vPZVgrpFvlqCyJ56NwhsQjNyfglmS/CzFSJU5hcDvtsU0IWryKGH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:381:24e:7a85 with SMTP id
 e9e14a558f8ab-39b7484d530mr2964465ab.1.1723267741683; Fri, 09 Aug 2024
 22:29:01 -0700 (PDT)
Date: Fri, 09 Aug 2024 22:29:01 -0700
In-Reply-To: <tencent_741B7B2507BA67BBF633729E061B244B3808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098a26b061f4d896f@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: 1901335, folio: ffffea0000cd8c00, netfs_writepages
ino: 1901335, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901335
WARNING: CPU: 2 PID: 1105 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 2 UID: 0 PID: 1105 Comm: kworker/u32:6 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-1559)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 a0 9b 8e 8b e8 65 49 0d fe 90 <0f> 0b 90 90 eb 80 e8 49 2a a8 fe e9 6f ff ff ff e8 af 29 a8 fe e9
RSP: 0018:ffffc90005c0f478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888032f6c060 RCX: ffffffff814cc379
RDX: ffff888022edc880 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888032f6c060
R13: ffffc90005c0f840 R14: ffff888025835380 R15: ffff888025835618
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd489a9e18 CR3: 0000000043618000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x839/0x1080 fs/netfs/write_issue.c:541
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12a328ed980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11223d11980000


