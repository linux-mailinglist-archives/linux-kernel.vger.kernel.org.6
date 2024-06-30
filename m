Return-Path: <linux-kernel+bounces-235210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB8D91D1A3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2887D2819D2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6613C8E5;
	Sun, 30 Jun 2024 12:37:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4F137775
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719751025; cv=none; b=casNTzZNMBFVUjhoJEViAd3xMQ+Xx+TaYAkUF1iUpgDnJ6RZKc943GPn/LPa66u0NtshkTrahPJyA2RX2M/gY4VOWT5IjwaqZ92gfQxgu1pfYUWieUv96EveYYKExMsUMiaI7a6mJb9pNVyfll3zX7y7obcCJ6fvYynsOPK4jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719751025; c=relaxed/simple;
	bh=WyJzSjprsDzoEHgAzxW0aWONlXfdgN9yU3zPDzMyT4k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZKkosqtlHzPq4nI6Qn59Dd4o02Q74ITZOdSEhfmGDo21ya5/99G5EOnkE56frRrjq/wJMgElbM8rKDqXj76bjy2pX1oUgBvrkSNrjE8sDmWbhYghLAnIZjP/jYQIYBKBvBRVhyNt2Ii46EDqgucZButeZ31WoeidSF4pGj2cS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-379c217441eso23108625ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 05:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719751022; x=1720355822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOl/nk9kEQWVaQ0sKuv6tP73LFvMGoLLap2/HOxnAJY=;
        b=vb7CsT81U09j0CyNgwePdRnh86+ZtU1xj6+KIZ4LFHa9T+XfIh/ArAEHEbVQWggy9c
         qtMcGE2ZLvYn+wGFuPTypYFc32v67Y0TJR2OpTqE6WHktA9liP6Cs3oR9xR2+ulJmA/+
         HHWj69ygDptZV3POWWEzQFC5QnZMbMkVr3cV/HxwnFV/HlIIJm3yy8h3WvLGGBkhr9jn
         YI3tUVwB5AoWebPqb3Arp1ssukfh3JlPqAIKxI8V/YwL3ZS+4+vEsFt6FB7okLS1a0dd
         DLIZEhbEbNrDud8WQm7mKma03HPxyQrjsbrnRdrrpxpCSBXUUNaMf2239hgNclJtv9Wh
         HL+w==
X-Forwarded-Encrypted: i=1; AJvYcCWWH2sKlUSOJjvNw9+6eVM4kIsQNQYhD9r5RqBFp5PoakhcTjMgpQcHHcFT29eOxMbE4dq3dS0IQD5tqaHfA0Q4/xgGT8FkUs/a9ltS
X-Gm-Message-State: AOJu0Yxem1hOsJHodVRMYF/SkdmcOFaQRM+jJs7sLQtd6nKCiWAPYtmR
	KyG3IKi0bPkHLSINOAZmTY7FM7YJhBLn0+uMhc+uFWmRIMeqym6Lg57YKiZCDUfAjkBC8p1O/e5
	qePOy61nQNnXvHGv4Yd5g+hfhyznriLPKoRbFnVuRtEtyh4UQHFAsqS8=
X-Google-Smtp-Source: AGHT+IF2mM+aL89EnbKEAqkJ50lOT9LG4ksGbsE3quXNXJRa6pOwT1bXz5jj0IGXjcH/cfD0qPuSLBj8qc90qOTppzRs8qpPtvlD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d6d1:0:b0:376:3fad:bb7c with SMTP id
 e9e14a558f8ab-37b2964ec38mr1241275ab.1.1719751022589; Sun, 30 Jun 2024
 05:37:02 -0700 (PDT)
Date: Sun, 30 Jun 2024 05:37:02 -0700
In-Reply-To: <20240630113933.2634-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdc8ca061c1abcf0@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_fs_read_only_work
From: syzbot <syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bch2_fs_read_only_work

INFO: task kworker/1:2:785 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc5-syzkaller-00282-g8282d5af7be8-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:22896 pid:785   tgid:785   ppid:2      flags:0x00004000
Workqueue: events_long bch2_fs_read_only_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 bch2_fs_read_only_work+0x25/0x40 fs/bcachefs/super.c:392
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
3 locks held by kworker/1:2/785:
 #0: ffff888015081148 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015081148 ((wq_completion)events_long){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900039efd00 ((work_completion)(&c->read_only_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900039efd00 ((work_completion)(&c->read_only_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff88806a980278 (&c->state_lock){+.+.}-{3:3}, at: bch2_fs_read_only_work+0x25/0x40 fs/bcachefs/super.c:392
2 locks held by getty/4831:
 #0: ffff88802ab140a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
3 locks held by syz-executor/6022:
2 locks held by syz-executor/6591:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc5-syzkaller-00282-g8282d5af7be8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 6591 Comm: syz-executor Not tainted 6.10.0-rc5-syzkaller-00282-g8282d5af7be8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:184 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x35/0x90 kernel/kcov.c:311
Code: 0c 25 c0 d4 03 00 65 8b 05 b0 a4 6d 7e a9 00 01 ff 00 74 10 a9 00 01 00 00 74 57 83 b9 1c 16 00 00 00 74 4e 8b 81 f8 15 00 00 <83> f8 03 75 43 48 8b 91 00 16 00 00 44 8b 89 fc 15 00 00 49 c1 e1
RSP: 0018:ffffc90002e9f758 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff8880268c0000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000002
RBP: dffffc0000000000 R08: ffffffff8b79786e R09: 1ffffffff25eeeb0
R10: dffffc0000000000 R11: fffffbfff25eeeb1 R12: ffffc90002e9f820
R13: 000000000000001f R14: ffff88806151c002 R15: ffff888067575fa8
FS:  00007f86375a56c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f86374e66e4 CR3: 000000007a3ee000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 xa_is_internal include/linux/xarray.h:175 [inline]
 xa_is_sibling include/linux/xarray.h:1287 [inline]
 xas_descend lib/xarray.c:210 [inline]
 xas_load+0x1fe/0x5c0 lib/xarray.c:245
 filemap_get_entry+0x1fe/0x4e0 mm/filemap.c:1840
 shmem_get_folio_gfp+0x2a8/0x1f50 mm/shmem.c:1982
 shmem_get_folio mm/shmem.c:2160 [inline]
 shmem_write_begin+0x170/0x4d0 mm/shmem.c:2743
 generic_perform_write+0x322/0x640 mm/filemap.c:4015
 shmem_file_write_iter+0xfc/0x120 mm/shmem.c:2919
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f863687bcaf
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 b9 80 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 0c 81 02 00 48
RSP: 002b:00007f86375a4e80 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00007f863687bcaf
RDX: 0000000001000000 RSI: 00007f862d600000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000005b5b
R10: 0000000000000002 R11: 0000000000000293 R12: 0000000000000003
R13: 00007f86375a4f80 R14: 00007f86375a4f40 R15: 00007f862d600000
 </TASK>


Tested on:

commit:         8282d5af Merge tag 'nfs-for-6.10-3' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10f4ab3e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf5def5af476d39a
dashboard link: https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116a7f05980000


