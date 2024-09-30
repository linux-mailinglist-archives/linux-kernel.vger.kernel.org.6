Return-Path: <linux-kernel+bounces-344048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BBC98A367
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792D11C22B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AD190068;
	Mon, 30 Sep 2024 12:46:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428F19004D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700393; cv=none; b=i7CVxhm+o8iP81Als90yku8MgDFrpvpdiFbK7HzHBKLsyAholR3UhlCU4WOi7NGn5NZgR/g34Yi36xsd4t1RF/OK7kIHgJLJkn1QldmMGmehZUXCW4RcjSDW+QlGiu7FIZaY9UkmnNPUzly8c4raj4GzLyL1cSQ/JyEEo2gwkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700393; c=relaxed/simple;
	bh=fLcOW1glmDi8nNd8++58a0Sk8ANSiapo0GJYmwFxNWA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IcvhH9M366ugGqNkdZA/dW6EXsOU6IRH0aMoQmdDgjjpwuWcLjz//qrIGyZctKNDk3tDQgsH8qNw/6VcNzQGMoaiwZOUizpxK8KlkSsb5OOxueckYm/TUrURLFekO5NDZ6YZIRgHzVl2SKelZ5WydvnHkOyDuBewWqTIY1r3N+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a345a02c23so29048005ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700391; x=1728305191;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awJIzvkD2Lwo+R1d6zdZ1TcxW2vEuKMslHNdyjBpWrQ=;
        b=TsE1uHuFS7dU8KGoGqiBzlv0imbKIS2gXxz4k5g5VMhql5UENZiQwhJth875rbFJox
         bzy91zoaXTb00LiFOuoG8sLRqGG7Ri4nBWxaxxGtj+p+DQRXDs5/82YcOGFgAZR9HDGU
         9ddID8jT3+WEv0iD80rz+sRHKog5YOMZ6GK94U/kjgYW4I4/oWzkM++8vQYZJttLQrJc
         pqTfENXpMG++UoNGZIwUMUbd2llGE4nBnPdDFmrT4QlePeGtBQvThAj/GO5HXL+Z3XpT
         Q4psaE5bxvmD47PP6JeQp3Bt7DtShtI3qp0x5RbnkB0rw3O9aOFL8sLfCAQ89+mtEyhC
         p+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFGCufN8QvsOVLpWYQEjGaaHpDTbCguFAWD6tqrXfEwmiKrioTPcovhJ8MGk76a/04AnYBexTj1arqDHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzafo6ATMsqGOEE63EH4bBMb3Okatl2NjCd1eDjD7Epfo6Dfsms
	Q/GIqkCk4Y5m8McGArZP1aPpGQjwsOM9qWMH6gcv0N3QBd94whsmFVeCiP6hi+y6Dy2Pxeq7w3q
	6hNsVf2bhHH81Ru+s3Jv7803fCxu+pQ4BziQw2zz+aOuEE9Cgiyk+Hzk=
X-Google-Smtp-Source: AGHT+IHczIB3QkxOdWEyG2fNVJLCa/e2IqmJWIIcmPwVSCQ7iPucH1uFMvCTk3LnslN0kMvhGnFVUuGTvaQTOJ3gd1Tbifs59Pwh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a3451b4ba4mr90915775ab.21.1727700391138; Mon, 30 Sep 2024
 05:46:31 -0700 (PDT)
Date: Mon, 30 Sep 2024 05:46:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa9da7.050a0220.6bad9.003c.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in worker_thread (5)
From: syzbot <syzbot+c27cd2da6c2dc003b4a1@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, 
	edumazet@google.com, hpa@zytor.com, kerneljasonxing@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa486552a110 Merge tag 'memblock-v6.12-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1482da80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c71bad3e6ab6955
dashboard link: https://syzkaller.appspot.com/bug?extid=c27cd2da6c2dc003b4a1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12afcaa9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10edb627980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c6beec63de3/disk-aa486552.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa35efb3dd39/vmlinux-aa486552.xz
kernel image: https://storage.googleapis.com/syzbot-assets/537d8ff45d85/bzImage-aa486552.xz

The issue was bisected to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153d06a9980000
console output: https://syzkaller.appspot.com/x/log.txt?x=133d06a9980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c27cd2da6c2dc003b4a1@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

INFO: task kworker/1:1:51 blocked for more than 145 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:R  running task     stack:23864 pid:51    tgid:51    ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3406
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:0/11:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
5 locks held by kworker/u8:3/52:
5 locks held by kworker/u9:0/54:
 #0: ffff88801ef05948 ((wq_completion)hci1){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ef05948 ((wq_completion)hci1){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88807fa38d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88807fa38078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3e0a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3e0a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

