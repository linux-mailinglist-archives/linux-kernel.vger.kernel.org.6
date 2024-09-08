Return-Path: <linux-kernel+bounces-320241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 549B39707E7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B826AB21361
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F816FF44;
	Sun,  8 Sep 2024 13:58:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA414D444
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725803884; cv=none; b=KNfihzb7MMYrJLO74rFcrT4QU2/3d7O8EyYxBvgPVL+5NZl3AWCUcPFGG13lvX1CF4WwIzOVEPJDFJsVQT6+3Gd3o7hnSoA/9ilcqMVyi9mcX++sBXFVpzee0a34n4PSTv18tp/zYrEbR3E5yjzfF+2sqigfnkBqljwwKHHVzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725803884; c=relaxed/simple;
	bh=dOTNJrz4L53LYUnnGahvSvJGRp0f1gRExVf7Z+Dvkyg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iP+guoqdjDuz+bVch1q1F9ZIE6bJLOJzOk0EuiPDzYpd7CPss7PUDonTOZvOtYqvvTg0gBEcX0tqFCjaJkiBVpt9uKL1gdYy4l0pg3SP9YDn1CZqAmV86PFkb+XG8Pjnf91F+VvoUEXjYqrYmGSRta/qjl37equqy5qv6PZsBbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa94d4683so181152339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 06:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725803882; x=1726408682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rSNgNLg9xZaMKMfMb1X+7XFfRW8g2LyJ5i+0LKtulQ=;
        b=PTqZL4DdM7BRj59GWvc7v5IQvcl19bwxaQpGSFXslw4aMQqLqhQXFhknbXxFc/xTxD
         V9Trz2ccO7oWFypxUGbREwq+KITJeh45OASXwrxTmW5J4MSEfv612ezD7HmelwhY9jGs
         1CTF3uhrmsGJezUebJMm9pk4rXvxRjyAqsFUqwQJ2RkdRy/k6fFlNOPLbLvAc6Rj7Pi0
         5KaMF0ZTNUYWqLM3WkDZGkE0mnVZg16NARxgeKxlNnwL7osOAdz990F+dbWGwOXI3CPC
         kmEM2OrJUaKJOSaiXVehrIxWpHGBcPZp410ckzkHS9qNJRSFT5kzecZZZgU6z7lIHB0i
         Z2vA==
X-Forwarded-Encrypted: i=1; AJvYcCXAPBL4Xb84EOHCSNKODwIJUYVT9SoFKrluyBd7KJTSt0I/CxrW2bgBV+gLAuRwNo3yCN4wx9PcRyzBLmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMQmFNVKxgftSGiV6epCoZO0K/J6jcF1SFPduaGJNqu/qA2QI
	ofRQ5DRaw5rnEMbgsvLYRJW0tpD0jf/rSqHqZ2b9sisqpY09/IBaLhQB5T0nH+zX9MMnId6SMrx
	JI7W8X7BHQfuKiuol+kO9dBc/aEh4boVY8CmRe1jX0X5aSLKzHW8zRXc=
X-Google-Smtp-Source: AGHT+IHV3WczQ/y2YmXlirIITUeI6O8AeHZop/CfmBjm0XC5J527l20jrSV8SICsvjAuiLY5+irIG6ZN/0S1Zpad2wcZ6erZss8e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cca:b0:82a:2d17:4d8a with SMTP id
 ca18e2360f4ac-82a9617e541mr1170767039f.2.1725803882399; Sun, 08 Sep 2024
 06:58:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 06:58:02 -0700
In-Reply-To: <20240908133747.2610-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cd79106219c07b0@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hci_dev_do_close

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0 Not tainted
------------------------------------------------------
syz-executor/5776 is trying to acquire lock:
ffff88807d6ca148 ((wq_completion)hci1#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x6e/0x120 kernel/workqueue.c:3875

but task is already holding lock:
ffff888060a68d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:481

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&hdev->req_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       hci_acldata_packet net/bluetooth/hci_core.c:3792 [inline]
       hci_rx_work+0xabf/0x1650 net/bluetooth/hci_core.c:4033
       process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}:
       process_one_work+0x927/0x1b40 kernel/workqueue.c:3207
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((wq_completion)hci1#2){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       touch_wq_lockdep_map+0x78/0x120 kernel/workqueue.c:3875
       __flush_workqueue+0x129/0x1200 kernel/workqueue.c:3917
       drain_workqueue+0x18f/0x3d0 kernel/workqueue.c:4081
       hci_dev_close_sync+0x333/0x1110 net/bluetooth/hci_sync.c:5181
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

other info that might help us debug this:

Chain exists of:
  (wq_completion)hci1#2 --> (work_completion)(&hdev->rx_work) --> &hdev->req_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock((work_completion)(&hdev->rx_work));
                               lock(&hdev->req_lock);
  lock((wq_completion)hci1#2);

 *** DEADLOCK ***

1 lock held by syz-executor/5776:
 #0: ffff888060a68d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:481

stack backtrace:
CPU: 0 UID: 0 PID: 5776 Comm: syz-executor Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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
 touch_wq_lockdep_map+0x78/0x120 kernel/workqueue.c:3875
 __flush_workqueue+0x129/0x1200 kernel/workqueue.c:3917
 drain_workqueue+0x18f/0x3d0 kernel/workqueue.c:4081
 hci_dev_close_sync+0x333/0x1110 net/bluetooth/hci_sync.c:5181
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
RIP: 0033:0x7fc96277bb8a
Code: Unable to access opcode bytes at 0x7fc96277bb60.
RSP: 002b:00007ffc87843a70 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fc96277bb8a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffc87843abc R08: 00007ffc878433cc R09: 00007ffc878437d7
R10: 00007ffc87843450 R11: 0000000000000293 R12: 0000000000000032
R13: 0000000000045913 R14: 00000000000458e1 R15: 00007ffc87843b10
 </TASK>


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dd1f29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10014877980000


