Return-Path: <linux-kernel+bounces-433685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDCE9E5BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F016A182
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF0E22258C;
	Thu,  5 Dec 2024 16:42:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC7221471
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416926; cv=none; b=N7yM116+nXH2k+fC1pvEMtf+gu5hNUpJYi/ob4lZGrL/iLwprm+99yLFA4P0VEfdKMy6/OBrTiIOq/KV6g9D0DFCWzYWrADPZFAxF/xCDdY0c/v+pmC66D/yvNfRaY3NPlTjg5TiP8pY2LEqOp4rGL+we5TMNWmexXa4RJSbfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416926; c=relaxed/simple;
	bh=1M+fSBsJg+L7EWAIi7NM0rLjs9Al/ZQQFwxoUFMs0Qc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LqYxIOdgC16RugwKjTbRPUn0BecRgBbcMXbljd2gLKLL7SKHCBa9w2/e/updWjdpiq1I32EmUAuVJqeSEG2LB3sMHYS/7switAEa8KPLx8gdPZ87tHhsxsqNctod6FJLP5YUDs0EWOqNPPbCoZ1VKYNv1ptlhMWRxnfPneYewW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8419aa81d6aso96167539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416923; x=1734021723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8+l5BOURtQLM8FetTW7/bpYsa5AQgbui1GP3aJkfQs=;
        b=PPUF6fceOkV+vLhO/UFhN5snDjK6nA9fyfwCd58IzAhwH6pGSdh2KoAY69BTfY53Am
         VG+2gWVVrJU8HyqLNRKpbGzTXJFBTDZZCgB4JUPKmCF/SDNQcAlQztNiL/6ZSt0JKfmZ
         strNTVmWRKIIiaVr5rdBbb5xWnpJ3IJx3B9raRcibQfD4qa0DKX3paL+6nS+gLyIwcJ8
         Try/mgRes3sYpXDxFNADmDTgScVHhSnTXTHMx8MLnFyQfmWr0UzovpFWMe8eDh3LRioc
         0lwd1TLU/HHD2T0R9E384LDVXSCn3ZpkA/KIsKXQ7BzxaqGCIakLPaoibvOIwqqPel3J
         eQdg==
X-Gm-Message-State: AOJu0YxynpUqrIz8MKmKJ+QhGSTDulGXosdyIpDlUG0WBF3s/gjyGlf7
	z/D2P0LRNMa9NcoVPq1N+AUEfbhFj6DX6P0c0hUmCJF5P+PW8sqXTJSsIdFgZS+QStAj3jPFfw+
	6gTBS4XF0OcA3roxUQWte9nk9N2B3JdAg6W5rN/66tde7ufZ3iRrL4qc=
X-Google-Smtp-Source: AGHT+IH1wG3fv6QVCABdL+5A1Oj/on7TofT/pnyx+VERftISGcaa3Al1WxltnGFXnKMhAlXxrJWyP6DVy2YjT6pasV0IJf6/QAMG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3a7:d7dd:e709 with SMTP id
 e9e14a558f8ab-3a7f9a3b659mr108917975ab.7.1733416923396; Thu, 05 Dec 2024
 08:42:03 -0800 (PST)
Date: Thu, 05 Dec 2024 08:42:03 -0800
In-Reply-To: <D63VY8C6B77L.2EEUFPWVWLWFB@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751d7db.050a0220.b4160.01db.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in mgmt_remove_adv_monitor_complete

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0 Not tainted
------------------------------------------------------
syz.0.44/6929 is trying to acquire lock:
ffff88807ed2c078 (&hdev->lock){+.+.}-{4:4}, at: mgmt_remove_adv_monitor_complete+0xaf/0x550 net/bluetooth/mgmt.c:5524

but task is already holding lock:
ffff88807ed2c690 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_clear+0x4e/0x220 net/bluetooth/hci_sync.c:658

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       hci_cmd_sync_lookup_entry net/bluetooth/hci_sync.c:838 [inline]
       hci_cmd_sync_queue_once+0x43/0x240 net/bluetooth/hci_sync.c:782
       le_conn_complete_evt+0xae1/0x12e0 net/bluetooth/hci_event.c:5778
       hci_le_conn_complete_evt+0x18c/0x420 net/bluetooth/hci_event.c:5789
       hci_event_func net/bluetooth/hci_event.c:7481 [inline]
       hci_event_packet+0xa55/0x1540 net/bluetooth/hci_event.c:7536
       hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4041
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&hdev->lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       mgmt_remove_adv_monitor_complete+0xaf/0x550 net/bluetooth/mgmt.c:5524
       _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:645 [inline]
       hci_cmd_sync_clear+0x107/0x220 net/bluetooth/hci_sync.c:660
       hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
       hci_dev_close+0x101/0x220 net/bluetooth/hci_core.c:510
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
  lock(&hdev->cmd_sync_work_lock);
                               lock(&hdev->lock);
                               lock(&hdev->cmd_sync_work_lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

1 lock held by syz.0.44/6929:
 #0: ffff88807ed2c690 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_clear+0x4e/0x220 net/bluetooth/hci_sync.c:658

stack backtrace:
CPU: 1 UID: 0 PID: 6929 Comm: syz.0.44 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0
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
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 mgmt_remove_adv_monitor_complete+0xaf/0x550 net/bluetooth/mgmt.c:5524
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:645 [inline]
 hci_cmd_sync_clear+0x107/0x220 net/bluetooth/hci_sync.c:660
 hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 hci_dev_close+0x101/0x220 net/bluetooth/hci_core.c:510
 sock_do_ioctl+0x158/0x460 net/socket.c:1209
 sock_ioctl+0x626/0x8e0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f620ff80849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6210cef058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6210145fa0 RCX: 00007f620ff80849
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000004
RBP: 00007f620fff3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6210145fa0 R15: 00007ffc046d95d8
 </TASK>


Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10491330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1620ade8580000


