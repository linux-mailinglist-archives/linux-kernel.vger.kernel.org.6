Return-Path: <linux-kernel+bounces-239193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E09257E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEF6B22C62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DB1428E9;
	Wed,  3 Jul 2024 10:07:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832213D2B7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001245; cv=none; b=Tx3J6UMM7WD6oaHt83t7UB/e+CkGwaR2ORvMtDegSJ7kcvzgCmMkBPMhHdCQI5iegFOnG2pXL2Hli9jMeRzFcyIXpu4O7/YphQsfNYxD42IaSZaG2WTeolFy286UpwQ3NhdNRL/8V0H/t/2fUyHAHzfY3pzIa7QkLYCpnx3aJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001245; c=relaxed/simple;
	bh=ZIuKwCFOqTL8pOktHjCU9h2caLMPG9s4matNsaZtuOw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V5vHSGJnvL1DYPZKWj4PuMQbLjREZqXBlwl4CCC//0bZSPa/qLhj8AaNfN1rqfPMlAMz8a7zsvqB/pHbYQLr/33Pi4XYPigG115BnMrZqt8+jHYjvFRJiteesrR3zAovKvFoanN+ZRBUQvTiKr5l1ChevTrI9WFrYbeqrVHqhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so614165839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001243; x=1720606043;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3N5UkilUP0FtclcvoZuhXstBFZtygwq7BeddGR7cF4=;
        b=Onwv1bAf9DY1deQ1wyJUibykXaLj6nOvkn2qi21F4cMe1eiZRBYm3ycU7XcmvjvmBS
         Cd27rfBq6Bl7GwKC3xjZK9K0yR6ApgjRt62U0ZJWLkuL9UGTro+uJsUiV8qRbebV06LU
         NCItfTvuffJQSY+ElUDGAh3HkCnvcucPu4bCkdLRDEP3OpmCTS+GjSg5aHKmFAXFB1nN
         6gYnrw9RMb380+xzlojVzkS/6OtCXThknixs4rr0Dxcqh6r2ZQE6Gm9sW4Jm9+SwR6rV
         umEPEWUJRY07jXTcS/6p63u1y8EK9XW8TSAmQhgVw9cRWhbRtZdnfPsI+Mr/GS1TrDNE
         LoJg==
X-Forwarded-Encrypted: i=1; AJvYcCX5CjJ2k8DoWLWRWef35pL00CLqfwJmuxSXKQonbiMQuuHq+8RPQqRrSX3X2gnNdTucw57uUbLDdB3pwYRn5NdbiTTQr7wvpBGOMxod
X-Gm-Message-State: AOJu0Yxt+Np+U+rwQEohv6NU48mGf6KX4aVreeX5BP3zLaDkcJvy/BpP
	OP+rLpN/hAld573sZZh2yqxToyYwIAc1GGZyDiU8jV7SJ5XGEucFIqQXf7IUbH6ePh+oNawipkV
	18SgJASNXto/WGPC1xLxqfPw3tsCbgYYN8ShrZ/ugDpnk5UYX3aVq0PM=
X-Google-Smtp-Source: AGHT+IHrxeCXTH9Urtgk3l8NZfqKqxVbQJndN59fgp+rQ0ChAeAArHRDJuAwMGuYcNaJfmMZSBxpkgXo7PAbzy2O9PY9I6pVIFAv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8621:b0:4b9:6688:4fc with SMTP id
 8926c6da1cb9f-4bbb6ef77b4mr956998173.2.1720001243539; Wed, 03 Jul 2024
 03:07:23 -0700 (PDT)
Date: Wed, 03 Jul 2024 03:07:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000227d2c061c54ff82@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in dev_activate
From: syzbot <syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1dfe225e9af5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a4f2d1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=2120b9a8f96b3fa90bad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3894cf8b5271/disk-1dfe225e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/573c202ade8f/vmlinux-1dfe225e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a356d869b8f3/bzImage-1dfe225e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.10.0-rc6-syzkaller-00051-g1dfe225e9af5 #0 Not tainted
-----------------------------
net/sched/sch_generic.c:1249 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:0/11:
 #0: ffff88801efaa148 ((wq_completion)bond0#9){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801efaa148 ((wq_completion)bond0#9){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc90000107d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc90000107d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2824

stack backtrace:
CPU: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.10.0-rc6-syzkaller-00051-g1dfe225e9af5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 dev_activate+0xf8/0x1240 net/sched/sch_generic.c:1249
 linkwatch_do_dev+0xfb/0x170 net/core/link_watch.c:173
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

