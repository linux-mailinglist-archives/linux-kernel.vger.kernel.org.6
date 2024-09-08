Return-Path: <linux-kernel+bounces-320164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1F9706ED
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C15B218CB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9911547C7;
	Sun,  8 Sep 2024 11:33:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6F1537CE
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795185; cv=none; b=V7Fy6sv4umGySz1Dmnuc6jEZEvon72/+hY38QIVlRDcajOnkI9vYJztcNXaQ8YMTP2QzVMCB8+PI39clqE77ICsJgPmhIj7liUXyxWPvPOs3bdsf+zkcENQm4P7SQh5M5Q3eKwncLpsz4xLa7WOg9Nf4hRcA79REl09hfe0Lvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795185; c=relaxed/simple;
	bh=8CXqWxk7c55fNyNFuUz4lkx1t5+nEm2/hPVLY6onpmE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cHpjLZoHVEtVfKtnMRFriXljuZRJIlS5W7ZrRYvhKo/71E8z1W2QdiLflbCJPfdoMxRtXSXKdz+nQ6tPRHAyHKkHUFrlz9ugjDqUCu88C1z8TAgmCVIs7jiqP+2MNPIIO+2wce1wspetDYDfaQJ7MXCH/Vq/kHMBmMBeTC6KeWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cda2c8997so119887539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795182; x=1726399982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPBktk5ulHWLJeJb5WPOhQJL3QIc9Wzxkhg3ZchqWv8=;
        b=pnSfl29an36JMVPa1+6ML+5Ay1vBFY/uNlPw5wayyhPzM1OVrgXNKO20l0mkoxtafS
         f/Rvcl3WB6vv/G6h08+YjMDK2HUg2n8tFPJMPgpfGMjK1eybwi4tLNTK2nbJFMlhUZYw
         hniu1LW5rFgT/5n1gKs23atlEdU/SY2OWv8nAb9MLsC/R9wzrIPLgdFxb1dsoGNFe67f
         7npOa9imeyhuwuF9+7q5ytrrVMLBR9BWoAPTgwsABrAAIf3I8UsKRjNhu4/oLMT9/0ov
         85EymxsnYvksLTUABOZHiFXoyFpVWcrtCd2w9QUHJRO045XSGQ+uaT/GNxMgSTS0JV/k
         pMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURvBE41zARRfCxxBHeXOfzdVOPkXH5Q1MRDpWL+Kv3QY5cNaazLKgr9cuLfcVqBgh4Qbu4sT6itluQryU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG00ckGk2rPON2cGewVjLiU5VeQEjD7LkH4hWKu5FkNhQVTWnD
	Ez5WcJwQUQznvj0U05snI63JZIgNCCi6ogjN/4rxIS/vVlwdE8/hgqHr0m42jg/6xDI8w9Lmm0M
	8gmxLq+D/BY8bgd0Sn4FIILlYOHEeIgRTapG96Y0Zd9WaSfvi7eacFuM=
X-Google-Smtp-Source: AGHT+IFFZt7e+fTOWMGDx/UnOPDv/S2wUPaPRi7Jz3DfA3QMJMNWLVyc8QfBkbY/A+opG6+RKvFmZ/QfxtwBtyOYDRpgH5j5dztg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:39f:6f8c:45f3 with SMTP id
 e9e14a558f8ab-3a04f0ccb8emr97725015ab.16.1725795182168; Sun, 08 Sep 2024
 04:33:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 04:33:02 -0700
In-Reply-To: <20240908111515.2457-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9de6206219a007f@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in l2cap_recv_frame

Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0 Not tainted
------------------------------------------------------
kworker/u9:2/5273 is trying to acquire lock:
ffff888031c20078 (&hdev->lock){+.+.}-{3:3}, at: l2cap_connect_req net/bluetooth/l2cap_core.c:4078 [inline]
ffff888031c20078 (&hdev->lock){+.+.}-{3:3}, at: l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4775 [inline]
ffff888031c20078 (&hdev->lock){+.+.}-{3:3}, at: l2cap_sig_channel net/bluetooth/l2cap_core.c:5546 [inline]
ffff888031c20078 (&hdev->lock){+.+.}-{3:3}, at: l2cap_recv_frame+0xe9d/0x8eb0 net/bluetooth/l2cap_core.c:6828

but task is already holding lock:
ffffffff8fcb1c28 (l2cap_conn_del_mutex){+.+.}-{3:3}, at: l2cap_recv_acldata+0x57/0xbd0 net/bluetooth/l2cap_core.c:7486

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (l2cap_conn_del_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       l2cap_conn_del+0x462/0x750 net/bluetooth/l2cap_core.c:1800
       l2cap_disconn_cfm net/bluetooth/l2cap_core.c:7310 [inline]
       l2cap_disconn_cfm+0x96/0xd0 net/bluetooth/l2cap_core.c:7303
       hci_disconn_cfm include/net/bluetooth/hci_core.h:1975 [inline]
       hci_conn_hash_flush+0x114/0x260 net/bluetooth/hci_conn.c:2592
       hci_dev_close_sync+0x59e/0x1110 net/bluetooth/hci_sync.c:5195
       hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:483
       hci_unregister_dev+0x213/0x620 net/bluetooth/hci_core.c:2698
       vhci_release+0x7f/0x100 drivers/bluetooth/hci_vhci.c:664
       __fput+0x408/0xbb0 fs/file_table.c:422
       task_work_run+0x14e/0x250 kernel/task_work.c:228
       exit_task_work include/linux/task_work.h:40 [inline]
       do_exit+0xaa3/0x2bb0 kernel/exit.c:882
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
       get_signal+0x25fb/0x2770 kernel/signal.c:2917
       arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (hci_cb_list_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
       hci_remote_features_evt+0x4dc/0x9e0 net/bluetooth/hci_event.c:3721
       hci_event_func net/bluetooth/hci_event.c:7446 [inline]
       hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
       hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4023
       process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&hdev->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       l2cap_connect_req net/bluetooth/l2cap_core.c:4078 [inline]
       l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4775 [inline]
       l2cap_sig_channel net/bluetooth/l2cap_core.c:5546 [inline]
       l2cap_recv_frame+0xe9d/0x8eb0 net/bluetooth/l2cap_core.c:6828
       l2cap_recv_acldata+0x9fe/0xbd0 net/bluetooth/l2cap_core.c:7518
       hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
       hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
       process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &hdev->lock --> hci_cb_list_lock --> l2cap_conn_del_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(l2cap_conn_del_mutex);
                               lock(hci_cb_list_lock);
                               lock(l2cap_conn_del_mutex);
  lock(&hdev->lock);

 *** DEADLOCK ***

3 locks held by kworker/u9:2/5273:
 #0: ffff888062dda148 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000379fd80 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fcb1c28 (l2cap_conn_del_mutex){+.+.}-{3:3}, at: l2cap_recv_acldata+0x57/0xbd0 net/bluetooth/l2cap_core.c:7486

stack backtrace:
CPU: 1 UID: 0 PID: 5273 Comm: kworker/u9:2 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 l2cap_connect_req net/bluetooth/l2cap_core.c:4078 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4775 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5546 [inline]
 l2cap_recv_frame+0xe9d/0x8eb0 net/bluetooth/l2cap_core.c:6828
 l2cap_recv_acldata+0x9fe/0xbd0 net/bluetooth/l2cap_core.c:7518
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0c
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103f1ffb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15508e00580000


