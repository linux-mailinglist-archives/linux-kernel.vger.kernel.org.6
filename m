Return-Path: <linux-kernel+bounces-279558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEFC94BEE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C002815E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C018E03F;
	Thu,  8 Aug 2024 13:56:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB618B489
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125365; cv=none; b=MOOz6wA9D1wZuXb7QKvAYzI67o7UjDKyU3ScEFtbwXJlL/iw5WCZ05TmiGaMkfEqu10HiHfLTn+IA4C3mrvehtaflU5r+HTomKInYv6U6l7RBsTBwNwpqzR8msyJk7zVqhlN6ktf2QB3UyUpbfzDrw2NBV0o7mXpbFmx+pO1u18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125365; c=relaxed/simple;
	bh=BuWbBSk9c1d7sEwcKbdwo2Wv8m6VAJxQfyfRFYYSvKo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c55vMwSV9LAozSqmqoJRIYtywli+42wAwdat2KjMZsDcO0vIdi4Kku4KKCfhHEty51QHnSvep+UGzQK2AfCexUZb/xz+p53H5GULq47nwpgvGRnEmFOMkpKQuaKL1s7zoroEJfU8mgGMM7E1u6Z8UV35BCqepSuwSm4Y4NNynbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a16e61586so13207005ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 06:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723125363; x=1723730163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVf+bjAeD2WX75jaTyYPvVFceVDKe7WlZliTtQoeqIc=;
        b=S8fwKe38pil00T4R1tmTr2sPShHUxxE1Rh4p9BzOCPgEQZ5ylBTu3RggmsiFXCLFdR
         Nh43qwxhFONa94bh+/OqKMgtvvOjU74Xgr6aBK5lpGYUyG8KaoYT4/2ecDjvaHBeLM+H
         2+1mkzkxguvLGWHmM5XHuesyahbKDFTc7vRL9ydh1e/BcrYT43soE8DHBBNu/h42467d
         w4qd9/L8PHpPAh5sbjzlSZd9tIcxCcHlCYRiRbdL44DMlU/BjJTVdYpjyo+tsP31XMBp
         JYvOEWBOPbqNye3vkYe+FYepcflOjpaG4zrDCpKOF47aXLE/bPAs/DaYYtF9b1yk9JW7
         8n6A==
X-Forwarded-Encrypted: i=1; AJvYcCUXkWNAkmLoRbyakMjqBa0llaleCt7FTRYy0oz1u14G+FLyx7WJRmT/b22n3JCnke7KEQDvdkxM3fbuCoZrjaX5+57ghQt4RszxX9Wt
X-Gm-Message-State: AOJu0YzRQlwUv+A2f9zKucEXwRGO4dwjdNTlWuFeB0I5Mdl7QMOdV0ry
	AB9aP2PeBb7Kz24CEMHnCnd0g7cEOpIRtFf8uMEY8ptuMXECqQXHpwr1UFPrKJEk8dMVDxJSGXb
	L2y0fxG8S35ZnJmQV1cbD7s6BcWnTDbZBWz0xYCI3t8Po913BC7T8GSE=
X-Google-Smtp-Source: AGHT+IG58j6FEVECMvGJjeam9SrYl4p222UPdkQKjguSnCBcE4OMj8QEZ9QhywdrrBhXnZskVHGOiIrbkDfTz29VpB8GeRQvdbYn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a45:b0:397:3a28:94f1 with SMTP id
 e9e14a558f8ab-39b5ed2d470mr1738645ab.3.1723125362761; Thu, 08 Aug 2024
 06:56:02 -0700 (PDT)
Date: Thu, 08 Aug 2024 06:56:02 -0700
In-Reply-To: <tencent_8284976E368C4A38741176FB67D03C6B3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026b469061f2c635c@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: ffff8880329e8000, inode fid list is empty: 1, v9fs_fid_find_inode
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901335
WARNING: CPU: 3 PID: 3173 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 3 PID: 3173 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 3 UID: 0 PID: 3173 Comm: kworker/u32:11 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-172)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 e0 9a 8e 8b e8 a1 49 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 82 2a a8 fe e9 51 ff ff ff e8 e8 29
RSP: 0018:ffffc900231d7480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880329e8000 RCX: ffffffff814cc379
RDX: ffff88802c048000 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88801f08f108
R13: dffffc0000000000 R14: ffffc900231d7840 R15: ffff88801f08f358
FS:  0000000000000000(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000740 CR3: 0000000040d1c000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1355d66d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125dbd23980000


