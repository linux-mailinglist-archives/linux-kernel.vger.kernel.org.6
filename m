Return-Path: <linux-kernel+bounces-319795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F04397024E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CD91C21425
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463415B99D;
	Sat,  7 Sep 2024 13:03:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98731B85FC
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725714205; cv=none; b=Ok/zQ2buZ8ZygrxmQ+IRq2ajeTscFnllZ1FdGtpKldAl11K2BZ2akoQN1QmzYM7XbCBsRvNZBatVgG6ogVKtgAREvlDLs0d+6Htje+tx+YHi/vGiE/5+DwNl4YyRHQzRZK5GkoVnM2ZBwnkzKrmZk2OJhAIREmLSyPrRCvl6bIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725714205; c=relaxed/simple;
	bh=VJapQg2Aoc7JbW8Q+92T8iHS87wQ3RVbkhNxkhlX2uw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EYlHACDu/dxTVt6x8hDwoDK1qV806dXdhCIpCNH1Q1SSE7cfca61ZIlk6U/jJ9kdQ0cvgUiSbsB5xjviu0EcFQYF3tRxIE/viHSRwFipbbkd23Yv1Ddbf7pc9AI508TskUpq9OHJ1/5I8XgMjYKpvqdpjnbYYM3k/aXUGA1HbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0541f519dso26719965ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 06:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725714203; x=1726319003;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5s91Lwh4qocLCe4RIc61MjYGpDuFqarsLAQeU9gYkuI=;
        b=apbkLuPmettAGF+P989cfwFScPx6vO2ArLTfsxaCezoS/3BD4/FvVu7rDBkD+a0EDX
         SyfsAu/S6AIFR9Qvo4uK4IBG7lBbGrXtfD9E3GMBIfegP4KT/wMdZdR5MitxEqbKCsjB
         Ow7W1r4mGjbHvwQBfzT08201eOKbotIOK3u1rbIOSaLlF1IxDkUlMHG9u1fvuizJC1zT
         PKGunRlzcw6k4UVULYk699WDOjKeioialNSvxZj4Aauq8BgarIaBVPEOW3ttBDXhA4+F
         1f0wBMvJVj7Kw4fetN3eia3DcISb7PmhD9EDVJrpxbkuZt0PoJqaTEfY5qaYnrzLcuhx
         Kw4w==
X-Forwarded-Encrypted: i=1; AJvYcCV7ZH7DGBQHZEep/nAA3Vl7pYDCfJ0ryu8alHn5DIVUJd+ZsiVhsEklDeLWqC1LiNGyHJFBoo6+MGCurYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+DZpVVFCh3frHtE5YNggxgoo5brZEgIdbsVuhwCnKvephWFw
	xfhlyD2nWDO3N9uWx9zOR2gQ+aEhFcqHuzMxbDKQOIsthT1PcgUzzZvasq8slYUmyw8At0PQCGl
	6mbLGMxxIaUlsw0Zzz7g1Gn46qMfV9ae3hfZpYtJisiBbx9NkRcc2OBY=
X-Google-Smtp-Source: AGHT+IHyMJm1JCGsYc5LVXCxT3HOscUf7isKzFa68P/amDKMutNmWFSVIf/JgPCO+DFgMrrvSOp5cqZWBSAvTEeoyq8eRcbQRd0+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3a0:4ee1:1ac4 with SMTP id
 e9e14a558f8ab-3a04f070751mr3422345ab.1.1725714202870; Sat, 07 Sep 2024
 06:03:22 -0700 (PDT)
Date: Sat, 07 Sep 2024 06:03:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bd3d106218726f1@google.com>
Subject: [syzbot] [cgroups?] [mm?] possible deadlock in obj_cgroup_charge
From: syzbot <syzbot+57765728d598e67e505a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    c763c4339688 Merge tag 'bcachefs-2024-09-04' of git://evil.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D137309eb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8524e833fed2d47=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D57765728d598e67e5=
05a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc=
7510fe41f/non_bootable_disk-c763c433.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5448406c16b/vmlinux-=
c763c433.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c10ebc7cf1e/bzI=
mage-c763c433.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+57765728d598e67e505a@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00070-gc763c4339688 #0 Not tainted
------------------------------------------------------
kworker/3:5/9288 is trying to acquire lock:
ffff88802b93dd18 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x26b/0x1070 k=
ernel/workqueue.c:2301

but task is already holding lock:
ffff88802b9397e0 (stock_lock){..-.}-{2:2}, at: local_lock_acquire+0x10/0x15=
0 include/linux/local_lock_internal.h:29

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (stock_lock){..-.}-{2:2}:
       local_lock_acquire+0x23/0x150 include/linux/local_lock_internal.h:29
       consume_obj_stock mm/memcontrol.c:2789 [inline]
       obj_cgroup_charge+0x7e/0x4d0 mm/memcontrol.c:2919
       __memcg_slab_post_alloc_hook+0x1b6/0x9c0 mm/memcontrol.c:3012
       memcg_slab_post_alloc_hook mm/slub.c:2164 [inline]
       slab_post_alloc_hook mm/slub.c:4002 [inline]
       slab_alloc_node mm/slub.c:4041 [inline]
       __do_kmalloc_node mm/slub.c:4161 [inline]
       __kmalloc_node_noprof+0x3c0/0x440 mm/slub.c:4168
       kmalloc_node_noprof include/linux/slab.h:708 [inline]
       bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
       trie_update_elem+0x1ef/0xdb0 kernel/bpf/lpm_trie.c:342
       bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
       generic_map_update_batch+0x454/0x5f0 kernel/bpf/syscall.c:1889
       bpf_map_do_batch+0x615/0x6e0 kernel/bpf/syscall.c:5218
       __sys_bpf+0x151b/0x55e0 kernel/bpf/syscall.c:5774
       __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
       __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5815
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&trie->lock){..-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       trie_delete_elem+0xb0/0x820 kernel/bpf/lpm_trie.c:462
       0xffffffffa0000891
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run3+0x240/0x5a0 kernel/trace/bpf_trace.c:2448
       trace_workqueue_queue_work include/trace/events/workqueue.h:23 [inli=
ne]
       __queue_work+0x4fa/0x1070 kernel/workqueue.c:2323
       queue_work_on+0x11a/0x140 kernel/workqueue.c:2392
       bpf_prog_load+0x19d7/0x2670 kernel/bpf/syscall.c:2957
       __sys_bpf+0x9e0/0x55e0 kernel/bpf/syscall.c:5710
       __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
       __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5815
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x26b/0x1070 kernel/workqueue.c:2301
       queue_work_on+0x11a/0x140 kernel/workqueue.c:2392
       percpu_ref_put_many include/linux/percpu-refcount.h:335 [inline]
       percpu_ref_put include/linux/percpu-refcount.h:351 [inline]
       css_put include/linux/cgroup_refcnt.h:79 [inline]
       css_put include/linux/cgroup_refcnt.h:76 [inline]
       drain_stock+0x284/0x2e0 mm/memcontrol.c:1774
       drain_local_stock+0xbb/0x330 mm/memcontrol.c:1793
       process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &pool->lock --> &trie->lock --> stock_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(stock_lock);
                               lock(&trie->lock);
                               lock(stock_lock);
  lock(&pool->lock);

 *** DEADLOCK ***

5 locks held by kworker/3:5/9288:
 #0: ffff88801ac88948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_=
work+0x11f0/0x1ad0 kernel/workqueue.c:3206
 #1: ffffc9000727fd80 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((&memcg_stock) + 0))((void *)0); (void)__vpp_verify; } while (0=
); ({ unsigned long __ptr; __asm__ ("" : "=3Dr"(__ptr) : "0"((typeof(*((&me=
mcg_stock))) *)((&memcg_stock)))); (typeof((typeof(*((&memcg_stock))) *)((&=
memcg_stock)))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); })->work)){+.+=
.}-{0:0}, at: process_one_work+0x8bb/0x1ad0 kernel/workqueue.c:3207
 #2: ffff88802b9397e0 (stock_lock){..-.}-{2:2}, at: local_lock_acquire+0x10=
/0x150 include/linux/local_lock_internal.h:29
 #3: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:326 [inline]
 #3: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock includ=
e/linux/rcupdate.h:838 [inline]
 #3: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many =
include/linux/percpu-refcount.h:330 [inline]
 #3: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put inclu=
de/linux/percpu-refcount.h:351 [inline]
 #3: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: css_put include/linu=
x/cgroup_refcnt.h:79 [inline]
 #3: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: css_put include/linu=
x/cgroup_refcnt.h:76 [inline]
 #3: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: drain_stock+0x13c/0x=
2e0 mm/memcontrol.c:1774
 #4: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:326 [inline]
 #4: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock includ=
e/linux/rcupdate.h:838 [inline]
 #4: ffffffff8ddb94a0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xf2/0x=
1070 kernel/workqueue.c:2261

stack backtrace:
CPU: 3 UID: 0 PID: 9288 Comm: kworker/3:5 Not tainted 6.11.0-rc6-syzkaller-=
00070-gc763c4339688 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
Workqueue: events drain_local_stock
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
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x26b/0x1070 kernel/workqueue.c:2301
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2392
 percpu_ref_put_many include/linux/percpu-refcount.h:335 [inline]
 percpu_ref_put include/linux/percpu-refcount.h:351 [inline]
 css_put include/linux/cgroup_refcnt.h:79 [inline]
 css_put include/linux/cgroup_refcnt.h:76 [inline]
 drain_stock+0x284/0x2e0 mm/memcontrol.c:1774
 drain_local_stock+0xbb/0x330 mm/memcontrol.c:1793
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

