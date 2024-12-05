Return-Path: <linux-kernel+bounces-433419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77A9E5825
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C882B285AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9FD218EA2;
	Thu,  5 Dec 2024 14:10:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CF218AC1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407806; cv=none; b=YF3/ieiTyDaQVF0O/RBk5aALAP/KYlmNQbTN+6nXf18WJHYLqptsRI79KNzv/gmOYouEtyE/4o1uPU6QcLWVXK5ua7oMYhFZtrsdRLbDmnNFg2/saHli9rLo9R2OcnYZyZ3OT5UcCJj643Wtl5F89LQDuNbQp/KwfEFLhB2DDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407806; c=relaxed/simple;
	bh=c09zKqJG23oTj9QeqntmCh1thLfP+Zld3aVXDAbd11A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B3WZFcJOiOqRksOvSDro1carcmvI0KIjfyn3kc+JkFYCEeCVzXh2T3jaJahU+JvtiLm4YIa7haTVoEW7sLrNvUiMTjTTat9yo+vXroFVYLvmkgYIW/gmWEPMZW47PnLUJn67D3l5lr315Lzu8dssGMj6KZvmGHnrQSqzwCDBp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a775636946so4589515ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 06:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733407803; x=1734012603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSOmwp3ttkxM5ifrdzJPY+sGsn3/rY/UG8NR1Fdbu50=;
        b=ZQtD4bIIyAjP1YrK0fK6v8yRVi6zmqE/Hxz1a3HZRJIJWfXE6PzqXHthRYtRAMaKQv
         hwMw30LWSk3e9HJmtVUZ1m5VyRbGbNqmBXxU4yLlr6DmjaSwr40o5pLRi0GkmQQCRn7Q
         zTlbri6063J0Um1HTA3SjmVHVZtHQNCLw6sNQEzLuRKlA8x1NMCZVMnwPpcAytucXb5y
         3qjmQq198cT9N+GePa8cx+9oxCXP2Px09mA6zhfahGNKDEMCwkykq1ML9tGq4qqNO0uy
         Mdal8OKP+oa3ngOfJhYDUTijuUfpaC1rNTsx0+W8miGNPg7QL8t42qh64K1FyIcLPJTo
         UViw==
X-Gm-Message-State: AOJu0Yy8PMafespYU+hXxMQJxYYpdEH6rc45x1FSwwyptTDbJ8AXCRZJ
	vGsLqFCDNzwA3v5MxjjQW0uxrz8gSbvs9hT9wPq5GsCc8Z+MaZ/O/U5IAedjwhlHbl5Y2c5EhXq
	YAriL/t4Qk2QncoSZvNevzkCdz3i7FYPif4lOMU586juHx+H0YgerXq8=
X-Google-Smtp-Source: AGHT+IGRlPWkdZpTbdcRrS0K00EmgLyXWILEd6hVtNrD9WxmOKtpu59GjFpu70AiSn7wnFKz8/qT0EfwbzBRlNK4Sx7/aKi1b/oC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3a7f9a4e005mr129440415ab.13.1733407803605; Thu, 05 Dec 2024
 06:10:03 -0800 (PST)
Date: Thu, 05 Dec 2024 06:10:03 -0800
In-Reply-To: <D63TE6HWP7IF.2VGLGANFA6OGW@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751b43b.050a0220.b4160.01d5.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hci_dev_close

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0 Not tainted
------------------------------------------------------
syz.1.2844/12457 is trying to acquire lock:
ffff88805c0a45f0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
ffff88805c0a45f0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
ffff88805c0a45f0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4137 [inline]
ffff88805c0a45f0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: __flush_work+0xe7/0xc50 kernel/workqueue.c:4195

but task is already holding lock:
ffff88805c0a4d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
ffff88805c0a4d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_close+0x10a/0x210 net/bluetooth/hci_core.c:508

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->req_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       touch_work_lockdep_map kernel/workqueue.c:3909 [inline]
       start_flush_work kernel/workqueue.c:4163 [inline]
       __flush_work+0x74e/0xc50 kernel/workqueue.c:4195
       __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4351
       hci_cmd_sync_clear+0x30/0x220 net/bluetooth/hci_sync.c:655
       hci_dev_close_sync+0x5cc/0x11d0 net/bluetooth/hci_sync.c:5202
       hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
       hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
       sock_do_ioctl+0x158/0x460 net/socket.c:1209
       sock_ioctl+0x626/0x8e0 net/socket.c:1328
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock((work_completion)(&hdev->cmd_sync_work));
                               lock(&hdev->req_lock);
  lock((work_completion)(&hdev->cmd_sync_work));

 *** DEADLOCK ***

2 locks held by syz.1.2844/12457:
 #0: ffff88805c0a4d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff88805c0a4d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_close+0x10a/0x210 net/bluetooth/hci_core.c:508
 #1: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: start_flush_work kernel/workqueue.c:4137 [inline]
 #1: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xe7/0xc50 kernel/workqueue.c:4195

stack backtrace:
CPU: 1 UID: 0 PID: 12457 Comm: syz.1.2844 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 touch_work_lockdep_map kernel/workqueue.c:3909 [inline]
 start_flush_work kernel/workqueue.c:4163 [inline]
 __flush_work+0x74e/0xc50 kernel/workqueue.c:4195
 __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4351
 hci_cmd_sync_clear+0x30/0x220 net/bluetooth/hci_sync.c:655
 hci_dev_close_sync+0x5cc/0x11d0 net/bluetooth/hci_sync.c:5202
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1209
 sock_ioctl+0x626/0x8e0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4dbc580849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4dbd304058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4dbc745fa0 RCX: 00007f4dbc580849
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000004
RBP: 00007f4dbc5f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4dbc745fa0 R15: 00007ffd637354e8
 </TASK>


Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158da8df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1315a8df980000


