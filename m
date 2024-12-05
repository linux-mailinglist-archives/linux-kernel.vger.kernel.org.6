Return-Path: <linux-kernel+bounces-433368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC429E577B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A613D18836EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D1218ABE;
	Thu,  5 Dec 2024 13:44:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723D1773A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406245; cv=none; b=mCQeSLfJlr0hnchKAFTI2LuoAkd8/Cgonuo+Hj3HgqUpr/qJXv/zyfFyVKw0idRYSxCBuNzo+lpsOALYy7X5kvkCYcOyqXKvOrZNY8nZI+8sx7mfEMg0SOluQE6M29YkkcuakjlojRs9A3iyGOdaU9gS1bGdIUjP6WDU1jFR2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406245; c=relaxed/simple;
	bh=Csu+kOUvQvxT3DgexAFZY4klj9Q8+zcR2hL/vCdm2bI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u/e3X1o7WRQf5mVraL3LOFR5q/gK2SMo+cHCOtgIvKNydqRxiWul4Oj3/BeZgNL06LX7HfvPixv6j726bsqC1NvxmbIy6VNxKDWL9gGtNrqi5gu/yhEb9ZUIR83Vo4I9vIVngrMmAzesGf+NH7lvijhagUOXvBUyomQit/iRSzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-843e86e0b3fso146892939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 05:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406243; x=1734011043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nA8UJ+QM1Jv0XIADFlORUSDPB8oTyDJj6o5N3oq6adQ=;
        b=bjhIj8buNJwWZl9qDqfN514RJU6ITKFJ34TXIOMHhkkgTZobK+4Z1ey3vMAHSxTquZ
         S+U241xh7PwsZCo7K3Xmt3iQleTUYtcdjwhYDilwG8+0L1eiyWCEqvcsD+zAC/XtwX17
         jAIBFmO47xGrLNtJV5XgWTDF+/7BcZxPXhqneSUCLeGZ/LOIQUZ5Qv+BFrdxL2PFUaJH
         9OfxSIxCDzF6zUKg34udi64buXPseepuKOopPsHqeKuztGBaZQKrnPWZ6y3tTHVjuQcm
         8+9f5r9RNFTHz2OtzFI2LDTYQj5qmFHN4uEWlS3o+I4QgvCKQogb8zs5/29ccImIdrPo
         4DWw==
X-Gm-Message-State: AOJu0YyUIKSXgvQLRk5kzhuNR1Wtb7UUrgCZAArYGt5rxSgBnsig5jEh
	Rhvwxbl8WBkcC4n2mHXlDFC5lA9yIXwae3VAuoSCJL8tLp7fUdxxvyK9vadMxTqnT/hMXpoDcQz
	c7ALyfQ4F41dyz5iVRkZSNtERpcTl0EWzZ1ReBjIkM1qweEgvDDSFsVU=
X-Google-Smtp-Source: AGHT+IEUVELQN9bBQTB/bThbKIrtelfzJ/O+2tT4nRwRLfxuMQI/LTbMWE/tRXo0kNlcApdsNu71Bjey9lv+NTuQTP9d2beds5yv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3a7f9a48502mr109330035ab.9.1733406243280; Thu, 05 Dec 2024
 05:44:03 -0800 (PST)
Date: Thu, 05 Dec 2024 05:44:03 -0800
In-Reply-To: <D63SC2SEH0D2.Z2PVQQCYDRF3@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751ae23.050a0220.b4160.01d4.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hci_dev_close_sync

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0 Not tainted
------------------------------------------------------
syz.4.3898/15268 is trying to acquire lock:
ffff8880345205f0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
ffff8880345205f0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
ffff8880345205f0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4137 [inline]
ffff8880345205f0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: __flush_work+0xe7/0xc50 kernel/workqueue.c:4195

but task is already holding lock:
ffff888034520078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x5d4/0x11d0 net/bluetooth/hci_sync.c:5203

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&hdev->lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       hci_dev_close_sync+0x5d4/0x11d0 net/bluetooth/hci_sync.c:5203
       hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
       hci_unregister_dev+0x20b/0x510 net/bluetooth/hci_core.c:2698
       vhci_release+0x80/0xd0 drivers/bluetooth/hci_vhci.c:664
       __fput+0x23c/0xa50 fs/file_table.c:450
       task_work_run+0x24f/0x310 kernel/task_work.c:239
       exit_task_work include/linux/task_work.h:43 [inline]
       do_exit+0xa2f/0x28e0 kernel/exit.c:938
       do_group_exit+0x207/0x2c0 kernel/exit.c:1087
       get_signal+0x16b2/0x1750 kernel/signal.c:3017
       arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
       do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

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
       hci_dev_close_sync+0x5dc/0x11d0 net/bluetooth/hci_sync.c:5204
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

Chain exists of:
  (work_completion)(&hdev->cmd_sync_work) --> &hdev->req_lock --> &hdev->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->lock);
                               lock(&hdev->req_lock);
                               lock(&hdev->lock);
  lock((work_completion)(&hdev->cmd_sync_work));

 *** DEADLOCK ***

3 locks held by syz.4.3898/15268:
 #0: ffff888034520d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff888034520d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_close+0x10a/0x210 net/bluetooth/hci_core.c:508
 #1: ffff888034520078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x5d4/0x11d0 net/bluetooth/hci_sync.c:5203
 #2: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: start_flush_work kernel/workqueue.c:4137 [inline]
 #2: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xe7/0xc50 kernel/workqueue.c:4195

stack backtrace:
CPU: 1 UID: 0 PID: 15268 Comm: syz.4.3898 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0
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
 hci_dev_close_sync+0x5dc/0x11d0 net/bluetooth/hci_sync.c:5204
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
RIP: 0033:0x7fd2ecb80849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd2eda59058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd2ecd45fa0 RCX: 00007fd2ecb80849
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000004
RBP: 00007fd2ecbf3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd2ecd45fa0 R15: 00007ffe9928ddb8
 </TASK>


Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bf10f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162d2de8580000


