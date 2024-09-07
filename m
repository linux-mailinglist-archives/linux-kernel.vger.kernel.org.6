Return-Path: <linux-kernel+bounces-319665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76F97004E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA13283048
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 06:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A6754652;
	Sat,  7 Sep 2024 06:23:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5CE819
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725690206; cv=none; b=IsIxkmPb0N+tjWEpqGqfv6ZSiLprTDMxR+Zj776FhiNTXRabIj8VxkFv1p7B8eSomOqKOP0VNSaroysNo/0DyGZB/CCbzD9FqBG8jJPJQoSz6YpkuwSxo6hVHg3bQvFFBnaiBNws2JbuPdXJwIAlfdJS3gAjHXEKAMNc9lpKl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725690206; c=relaxed/simple;
	bh=Q7Q2OiDF3obupfFVuzEplhhWPPRp0GFFU0Gz0DSh7wQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XnLnluSIsraHJAIhU/nwYgqjcquL5SusvduvIb1uC2cKrrmiLX6xI2Ha9yRoWUxWFuGJQdRT2zIy8+JQ752fdLCkyCKMt3JWSs+hiF5i3NCX9jyhMRH2wTaavpJMO1LHwAX0rx6ANWondalcCAcpwBaHhpbq8bAhQvTLcxbJoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0541f519dso22358755ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 23:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725690203; x=1726295003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BT0KvqJeqG5tTc1TkeQ1GSRqOQlnX8eBDu78x0vFLQ=;
        b=sBb4QhAeW2IvVRAdl/MguJDrUqpq336oxd4UBu1o46LjjoDA+bPx7h1HwdeuTQ1qcQ
         r7L4eyoMpxXw2BSWXtEypS3f8a5xibskD5YA8kI4DbuW0qOHfUkzwuRRKJN7kC5rtENq
         ntSE66LOwOXzxuLYizR4eRrHIKkK15J46dcQBtDQgsAYA/LVicuoti5DuaJkctLaljGa
         KVcFfkSz1aVmW9yA+IY8AcvYtr9DF48ndMPfbm/c7L3BKxcAFwM84chz8DrSxvzXtxk3
         +9dkLlrFsgB2T+ydsnKjTOnrNkuFuO7IZGFRIaeWAbzHcnoJx7BiGIVmhVJZZZ7C+087
         dBHA==
X-Forwarded-Encrypted: i=1; AJvYcCXwV9ceFyJwBED94R/JMoqMH3HVTEwp+ztddFCyx9XGG3owywFdNW0kFdXm13c5jz4x4I7wLiaJmQdaRaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EWlA1xFJPFtoE51ZCogMq6a4w1exKtspcTPIZtXNmiEOuHcX
	be7H4fY/Cu/P2x26G5WFqyTslul01OEuWWCCrh/5CUiNxFpI+0xL9YC9yTT3plgptCboPf2twfk
	kLaI1T9t5Bwy71dhRYHPw3NE2pYrxxnGFA20wnnalUYamC69nSLDyGBk=
X-Google-Smtp-Source: AGHT+IFu+hhuXtX9Aiw+5L8/BzHY+RW9ER8jrvFndB7ImchBQg42hz4gPkb+AWdEOHltfV38wxGl4luS8q0U50jpplpMU/IlWJ1n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4e:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-3a04f0eecd1mr2308825ab.4.1725690203572; Fri, 06 Sep 2024
 23:23:23 -0700 (PDT)
Date: Fri, 06 Sep 2024 23:23:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000939d0a0621818f1e@google.com>
Subject: [syzbot] [mm?] INFO: task hung in hugetlb_fault
From: syzbot <syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b831f83e40a2 Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1565b43b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb5e48f6ead66c72906
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c788afb419c2/disk-b831f83e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0692a9bfb15e/vmlinux-b831f83e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e22aeda7a3e2/bzImage-b831f83e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com

INFO: task syz.4.402:7932 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.402       state:D stack:25792 pid:7932  tgid:7932  ppid:6207   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 hugetlb_fault+0x56f/0x3770 mm/hugetlb.c:6451
 handle_mm_fault+0x1901/0x1bc0 mm/memory.c:5830
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f82a094497c
RSP: 002b:00007f82a0c5fb88 EFLAGS: 00010246
RAX: 0000000020000d00 RBX: 0000000000000004 RCX: 8000000000000010
RDX: 0000000000000010 RSI: 00007f82a04005d5 RDI: 0000000020000d00
RBP: 00007f82a0b37a80 R08: 00007f82a0800000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000009 R12: 0000000000038ce8
R13: 00007f82a0c5fc90 R14: 0000000000000032 R15: fffffffffffffffe
 </TASK>
INFO: task syz.4.402:7933 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.402       state:D stack:24696 pid:7933  tgid:7932  ppid:6207   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 hugetlb_wp+0x104d/0x3a90 mm/hugetlb.c:6027
 hugetlb_fault+0x27b2/0x3770 mm/hugetlb.c:6579
 handle_mm_fault+0x1901/0x1bc0 mm/memory.c:5830
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x4a/0x70 arch/x86/lib/copy_user_64.S:71
Code: 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb c9 <f3> a4 c3 cc cc cc cc 48 89 c8 48 c1 e9 03 83 e0 07 f3 48 a5 89 c1
RSP: 0018:ffffc90004127ad0 EFLAGS: 00050246
RAX: ffffffff84b29101 RBX: 0000000020008640 RCX: 0000000000000040
RDX: 0000000000000000 RSI: ffffc90004127b60 RDI: 0000000020008600
RBP: ffffc90004127c10 R08: ffffc90004127b9f R09: 1ffff92000824f73
R10: dffffc0000000000 R11: fffff52000824f74 R12: 0000000000000040
R13: 0000000000007fc0 R14: 0000000020008600 R15: ffffc90004127b60
 copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:131 [inline]
 _inline_copy_to_user include/linux/uaccess.h:181 [inline]
 _copy_to_user+0x86/0xb0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 rng_dev_read+0x3be/0x6d0 drivers/char/hw_random/core.c:251
 do_loop_readv_writev fs/read_write.c:761 [inline]
 vfs_readv+0x6c2/0xa90 fs/read_write.c:934
 do_preadv fs/read_write.c:1049 [inline]
 __do_sys_preadv fs/read_write.c:1099 [inline]
 __se_sys_preadv fs/read_write.c:1094 [inline]
 __x64_sys_preadv+0x1c7/0x2d0 fs/read_write.c:1094
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f82a097cef9
RSP: 002b:00007f82a174d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f82a0b35f80 RCX: 00007f82a097cef9
RDX: 0000000000000002 RSI: 0000000020000580 RDI: 0000000000000005
RBP: 00007f82a09ef01e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f82a0b35f80 R15: 00007f82a0c5fa28
 </TASK>
INFO: task syz.4.402:7934 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.402       state:D stack:23288 pid:7934  tgid:7932  ppid:6207   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 io_schedule+0x8d/0x110 kernel/sched/core.c:7401
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1307
 __filemap_get_folio+0xb7/0xc10 mm/filemap.c:1898
 hugetlb_fault+0x1b72/0x3770 mm/hugetlb.c:6531
 handle_mm_fault+0x1901/0x1bc0 mm/memory.c:5830
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_8+0x11/0x20 arch/x86/lib/putuser.S:107
Code: 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 cb 48 c1 fb 3f 48 09 d9 0f 01 cb <48> 89 01 31 c9 0f 01 ca c3 cc cc cc cc 66 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000383f778 EFLAGS: 00050202
RAX: 0000000000800000 RBX: 0000000000000000 RCX: 0000000020000020
RDX: 0000000000000000 RSI: ffffffff8c0ae6e0 RDI: ffffffff8c608d80
RBP: ffffc9000383fec8 R08: ffffffff901870ef R09: 1ffffffff2030e1d
R10: dffffc0000000000 R11: fffffbfff2030e1e R12: 1ffff92000707f7d
R13: 1ffff92000707f08 R14: 0000000020800000 R15: 0000000000800000
 userfaultfd_copy fs/userfaultfd.c:1735 [inline]
 userfaultfd_ioctl+0x28e7/0x70a0 fs/userfaultfd.c:2133
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f82a097cef9
RSP: 002b:00007f82a172c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f82a0b36058 RCX: 00007f82a097cef9
RDX: 0000000020000000 RSI: 00000000c028aa03 RDI: 0000000000000009
RBP: 00007f82a09ef01e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f82a0b36058 R15: 00007f82a0c5fa28
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
1 lock held by dhcpcd/4900:
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x2ce/0x1bc0 net/ipv4/devinet.c:1101
2 locks held by getty/4982:
 #0: ffff8880308270a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by kworker/u8:12/7252:
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009267d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009267d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc7f290 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0xe9/0xa90 net/core/dev.c:11883
 #4: ffffffff8e93d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #4: ffffffff8e93d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
3 locks held by kworker/u8:13/7257:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004ee7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004ee7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
2 locks held by syz.4.402/7932:
 #0: ffff88807be333d0 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:694 [inline]
 #0: ffff88807be333d0 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:5998
 #1: ffff8880206e6218 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x56f/0x3770 mm/hugetlb.c:6451
2 locks held by syz.4.402/7933:
 #0: ffff8880352aa798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
 #1: ffff8880206e6218 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_wp+0x104d/0x3a90 mm/hugetlb.c:6027
3 locks held by syz.4.402/7934:
 #0: ffff8880352aa798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
 #1: ffff8880206e6218 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x56f/0x3770 mm/hugetlb.c:6451
 #2: ffff8880250d48e8 (&resv_map->rw_sema){++++}-{3:3}, at: hugetlb_fault+0x675/0x3770 mm/hugetlb.c:6458
2 locks held by syz.2.812/9374:
 #0: ffff888024984c40 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:694 [inline]
 #0: ffff888024984c40 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:5998
 #1: ffff8880206e6218 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x56f/0x3770 mm/hugetlb.c:6451
1 lock held by syz-executor/10950:
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz.3.1233/10991:
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
3 locks held by syz.3.1233/10996:
 #0: ffffffff8fcf15b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff888062b59678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x119/0x790 net/netlink/af_netlink.c:2404
 #2: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: ethnl_default_dump_one net/ethtool/netlink.c:494 [inline]
 #2: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: ethnl_default_dumpit+0x411/0xb30 net/ethtool/netlink.c:529
2 locks held by syz.2.1230/11003:
 #0: ffffffff8fcf15b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: nl80211_pre_doit+0x5f/0x8b0 net/wireless/nl80211.c:16547
4 locks held by syz.1.1238/11010:
 #0: ffff88802f9a0d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff88802f9a0d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_unregister_dev+0x203/0x510 net/bluetooth/hci_core.c:2698
 #1: ffff88802f9a0078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x572/0x11a0 net/bluetooth/hci_sync.c:5183
 #2: ffffffff8fdf7968 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:1972 [inline]
 #2: ffffffff8fdf7968 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_hash_flush+0xa6/0x240 net/bluetooth/hci_conn.c:2592
 #3: ffffffff8e93d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #3: ffffffff8e93d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
1 lock held by syz.4.1239/11013:
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: __tun_chr_ioctl+0x48f/0x2400 drivers/net/tun.c:3120
1 lock held by syz.4.1239/11014:
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x1b0 drivers/net/tun.c:3510
1 lock held by syz.4.1239/11015:
 #0: ffffffff8fc8be48 (rtnl_mutex){+.+.}-{3:3}, at: dev_ioctl+0x706/0x1340 net/core/dev_ioctl.c:783

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 7259 Comm: kworker/u8:14 Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue:  0x0 (bat_events)
RIP: 0010:process_scheduled_works+0x1fd/0x1830 kernel/workqueue.c:3309
Code: e8 18 6f 9c 00 4c 8b 35 41 8d 02 0d 48 8b 5c 24 48 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 f6 6e 9c 00 48 8b 1b <48> 83 c3 50 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8
RSP: 0018:ffffc900098c7bc0 EFLAGS: 00000046
RAX: 1ffff11005d68dcb RBX: ffff88801aca0000 RCX: ffff88806550bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900098c7dc0 R08: ffffffff815e648d R09: 1ffff110291e65b1
R10: dffffc0000000000 R11: ffffed10291e65b2 R12: dffffc0000000000
R13: ffff888064648660 R14: 0000000100001f4d R15: ffff888064648668
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e9a1f9000 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

