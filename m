Return-Path: <linux-kernel+bounces-360624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD546999D67
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8828228776B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152681E9067;
	Fri, 11 Oct 2024 07:05:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02819C579
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630326; cv=none; b=BOUkt/AT0I2r4zYwo5p/bpLCCLmb1I8HI/9aQPEWKEaj5LLZgZBgHm0obrWCTzTTgY5wSLXW4GcHnHd5S5Ofnigz7TkgLBOAr6w2JjT13Y0hmW6nEGkcWCxoTe0QD0ta7wAUcw2VezkO4iYhLHMEuaQTibA83+flNYFNuSupLUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630326; c=relaxed/simple;
	bh=HBoulU4+DjvIuFJTbr3AasQF5mrZjsonr5lHPdhNz4M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K+uNvJaVeS0mTisMOgJzeefjNwGb96cLw8jDwyEs97N4/Y764b5cQnMDG4jBSY8MKyp81U+FRYLtDNQzIUsKrgz4TtLUZ3FlXIhWzKNYTV9qsjD9D/Z+mvubBoplBNq9FSVrUeV7I1gT0VVxPAE65QMmGuPMH5yUuo09GWoC+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so26592335ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630323; x=1729235123;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATJTBvGHm1DWWkKB+LMkfCRXL68NZZd/Jwpfzz032RI=;
        b=Nrc/uNG0v8qoqn6ME1RdQx34rnpu5YaCLTgUfwnidM9krTFOWnGmOc+oCle8fhIKNB
         DB8F4a8U/oF0Qx1wN4HGkKq9LclSn15tdZqyuymoTzLiA6hCG/GpTnNARrX9aBDRawoX
         AfDCNvPSMC8y6m6WomFv29DhlByS1xaeKmJKU3uxhIUrs0b3QiOYJE1aGTqrs/NOABuV
         qVNPcJO1eMd2wJOlMhN50oFKenV/JtW7vErEbTN9RpWcGve2caTfT0wyp237mwKfNDQx
         JP/3PSv9HYbQezG8zmsykA9pcMM70EISibtvaqU+VaGqEDVscj2Km1pDsZdgJUG+NNHD
         rSog==
X-Forwarded-Encrypted: i=1; AJvYcCWVEf/wceW+CHy84blxqABQe4sbP3u0KWQmmy2LOAUqmbCp1lxMuTf1S9/6XohvyPUW37y5cbxq/UUUWp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCOUwAMf72Tkn9bG5lSlkiXA5hm7bjMf4OmQb5E2a0eiTHEGH
	PUt0iXihYgZ9pvuCQDtlDyoA2keoRwBXfO5wx6jBw9+lGZfEZQOfNnmpB2FC8KQShbByXeetCcz
	/8Wa4q2r6j54//6I5P+heT0O6d6Prq5nu3pe7IFgiuPqTrle466l8TFs=
X-Google-Smtp-Source: AGHT+IGkueGtmwPEHPT7EjitnYPMhiTfT88SD7Xq11SK8R3xoCIfphm1Ac2PIP900XFEiUVK26PZUEB46YWGKD/zrOiByKDjw/T4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3a3:68bc:a16d with SMTP id
 e9e14a558f8ab-3a3b5fb75fcmr13077075ab.18.1728630323469; Fri, 11 Oct 2024
 00:05:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:05:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6708ce33.050a0220.3e960.000e.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_mprotect (8)
From: syzbot <syzbot+6f7c31cf5ae4944ad6f0@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8cf0b93919e1 Linux 6.12-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130ce7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=6f7c31cf5ae4944ad6f0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26bed9f4399f/disk-8cf0b939.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/905ef98b4b27/vmlinux-8cf0b939.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5f845e93e25/bzImage-8cf0b939.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f7c31cf5ae4944ad6f0@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P2581/1:b..l P5922/1:b..l P5886/1:b..l P5917/1:b..l P4668/1:b..l P5514/1:b..l P5885/1:b..l P5889/1:b..l
rcu: 	(detected by 0, t=10504 jiffies, g=14685, q=1880 ncpus=2)
task:modprobe        state:R  running task     stack:23072 pid:5889  tgid:5889  ppid:5778   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6997
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5829
Code: 2b 00 74 08 4c 89 f7 e8 ba 40 8e 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90008fbf2a0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920011f7e60 RCX: e9af3ef32dd55900
RDX: dffffc0000000000 RSI: ffffffff8c0adba0 RDI: ffffffff8c60fae0
RBP: ffffc90008fbf3f8 R08: ffffffff942c5807 R09: 1ffffffff2858b00
R10: dffffc0000000000 R11: fffffbfff2858b01 R12: 1ffff920011f7e5c
R13: dffffc0000000000 R14: ffffc90008fbf300 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3d/0x2a0 mm/page_ext.c:525
 __reset_page_owner+0x30/0x430 mm/page_owner.c:290
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 vma_lock_alloc kernel/fork.c:446 [inline]
 vm_area_dup+0x61/0x290 kernel/fork.c:499
 __split_vma+0x1cb/0xc50 mm/vma.c:384
 split_vma mm/vma.c:460 [inline]
 vma_modify+0x153a/0x1a80 mm/vma.c:1433
 vma_modify_flags+0x3a9/0x420 mm/vma.c:1451
 mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:664
 do_mprotect_pkey+0x8e0/0xd80 mm/mprotect.c:838
 __do_sys_mprotect mm/mprotect.c:859 [inline]
 __se_sys_mprotect mm/mprotect.c:856 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7a42ec0bb7
RSP: 002b:00007ffec51d8488 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007f7a42e9dfc0 RCX: 00007f7a42ec0bb7
RDX: 0000000000000001 RSI: 0000000000001000 RDI: 00007f7a42c15000
RBP: 00007ffec51d85a0 R08: 00007ffec51d8418 R09: 00007f7a42e9d5c0
R10: 00007f7a42bf4168 R11: 0000000000000206 R12: 00007f7a42e9dfc0
R13: 00007f7a42ec8eda R14: 00007f7a42c15f40 R15: 00007f7a42c15740
 </TASK>
task:modprobe        state:R  running task     stack:22240 pid:5885  tgid:5885  ppid:35     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6854
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6878
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 unwind_next_frame+0x18f8/0x22d0 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 __slab_free+0x31b/0x3d0 mm/slub.c:4490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 mt_alloc_one lib/maple_tree.c:162 [inline]
 mas_alloc_nodes+0x26c/0x840 lib/maple_tree.c:1241
 mas_node_count_gfp lib/maple_tree.c:1321 [inline]
 mas_preallocate+0x554/0x8c0 lib/maple_tree.c:5546
 vma_iter_prealloc mm/vma.h:432 [inline]
 __split_vma+0x302/0xc50 mm/vma.c:397
 split_vma mm/vma.c:460 [inline]
 vma_modify+0x153a/0x1a80 mm/vma.c:1433
 vma_modify_flags+0x3a9/0x420 mm/vma.c:1451
 mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:664
 do_mprotect_pkey+0x8e0/0xd80 mm/mprotect.c:838
 __do_sys_mprotect mm/mprotect.c:859 [inline]
 __se_sys_mprotect mm/mprotect.c:856 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3535921bb7
RSP: 002b:00007ffe73e0ff68 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007f35358ff570 RCX: 00007f3535921bb7
RDX: 0000000000000001 RSI: 0000000000001000 RDI: 00007f3535651000
RBP: 00007ffe73e10080 R08: 00007ffe73e0fef8 R09: 00007f35358fe5c0
R10: 00007f35355fe928 R11: 0000000000000206 R12: 00007f35358ff570
R13: 00007f3535929eda R14: 00007f3535651fb0 R15: 00007f3535651e58
 </TASK>
task:syz-executor    state:R  running task     stack:23072 pid:5514  tgid:5514  ppid:5222   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6854
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6878
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 unwind_next_frame+0x18f8/0x22d0 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 vfree+0x186/0x2e0 mm/vmalloc.c:3361
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb993174257
RSP: 002b:00007ffc673ea150 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 000000000000158c RCX: 00007fb993174257
RDX: 0000000040000000 RSI: 00007ffc673ea18c RDI: 00000000ffffffff
RBP: 00007ffc673ea18c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syslogd         state:R  running task     stack:23072 pid:4668  tgid:4668  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6997
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:get_stack_info+0xd5/0xf0 arch/x86/kernel/dumpstack_64.c:213
Code: 48 c7 c7 e0 42 76 8e 4c 89 e2 e8 96 db c0 03 4d 0f a3 e5 72 9a 8b 1b 48 83 fb 40 73 0f b8 01 00 00 00 89 d9 48 d3 e0 49 09 06 <eb> a6 be 01 00 00 00 48 c7 c7 00 43 76 8e 48 89 da e8 65 db c0 03
RSP: 0018:ffffc90003387328 EFLAGS: 00000202
RAX: 0000000000000002 RBX: 0000000000000001 RCX: 0000000000000001
RDX: ffffc900033873c0 RSI: ffffc90003388000 RDI: ffffc90003387360
RBP: ffff88807f9a5a00 R08: ffffc90003387401 R09: 0000000000000000
R10: ffffc900033873c0 R11: fffff52000670e84 R12: 0000000000000001
R13: 0000000000000000 R14: ffffc900033873e0 R15: 0000000000000000
 __unwind_start+0x434/0x740 arch/x86/kernel/unwind_orc.c:729
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe5/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 __slab_free+0x31b/0x3d0 mm/slub.c:4490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 alloc_empty_file+0x9e/0x1d0 fs/file_table.c:209
 path_openat+0x107/0x3590 fs/namei.c:3919
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa5bfdc59a4
RSP: 002b:00007ffc917b0180 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000555ae5718910 RCX: 00007fa5bfdc59a4
RDX: 0000000000000d41 RSI: 00007fa5bff64443 RDI: 00000000ffffff9c
RBP: 00007fa5bff64443 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000d41
R13: 0000000067045f78 R14: 0000000000000004 R15: 0000555ae5718a60
 </TASK>
task:modprobe        state:R  running task     stack:23072 pid:5917  tgid:5917  ppid:5914   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6997
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5829
Code: 2b 00 74 08 4c 89 f7 e8 ba 40 8e 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0000:ffffc9000960f480 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920012c1e9c RCX: b31dd6aba4800400
RDX: dffffc0000000000 RSI: ffffffff8c0adba0 RDI: ffffffff8c60fae0
RBP: ffffc9000960f5d0 R08: ffffffff942c5807 R09: 1ffffffff2858b00
R10: dffffc0000000000 R11: fffffbfff2858b01 R12: 1ffff920012c1e98
R13: dffffc0000000000 R14: ffffc9000960f4e0 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3d/0x2a0 mm/page_ext.c:525
 __reset_page_owner+0x30/0x430 mm/page_owner.c:290
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 anon_vma_alloc mm/rmap.c:95 [inline]
 __anon_vma_prepare+0x117/0x4a0 mm/rmap.c:203
 __vmf_anon_prepare mm/memory.c:3307 [inline]
 vmf_anon_prepare mm/internal.h:326 [inline]
 do_anonymous_page mm/memory.c:4774 [inline]
 do_pte_missing mm/memory.c:3963 [inline]
 handle_pte_fault+0x5361/0x6800 mm/memory.c:5751
 __handle_mm_fault mm/memory.c:5894 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6062
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fe6d3989b9d
RSP: 002b:00007ffee5bcb618 EFLAGS: 00010206
RAX: 00007fe6d3ba0a80 RBX: 00007fe6d38f6000 RCX: 0000000000dc0000
RDX: 00000000014a0000 RSI: 00007fe6d3914540 RDI: 0000000000000000
RBP: 00007ffee5bcb720 R08: 00007ffee5bc0000 R09: 00007fe6d3ba1ab0
R10: 00007fe6d38faab8 R11: 0000000000000025 R12: 00007fe6d3b6a5c0
R13: 00007fe6d3b95eda R14: 00007fe6d3a978c8 R15: 00007fe6d38faab8
 </TASK>
task:modprobe        state:R  running task     stack:23072 pid:5886  tgid:5886  ppid:5773   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6854
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6878
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 unwind_next_frame+0x18f8/0x22d0 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 vm_area_dup+0x27/0x290 kernel/fork.c:487
 __split_vma+0x1cb/0xc50 mm/vma.c:384
 split_vma mm/vma.c:460 [inline]
 vma_modify+0x153a/0x1a80 mm/vma.c:1433
 vma_modify_flags+0x3a9/0x420 mm/vma.c:1451
 mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:664
 do_mprotect_pkey+0x8e0/0xd80 mm/mprotect.c:838
 __do_sys_mprotect mm/mprotect.c:859 [inline]
 __se_sys_mprotect mm/mprotect.c:856 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd843f6abb7
RSP: 002b:00007ffc9bb30df8 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007fd843f7f2a0 RCX: 00007fd843f6abb7
RDX: 0000000000000001 RSI: 0000000000001000 RDI: 0000555bebe88000
RBP: 00007ffc9bb30f10 R08: 00007ffc9bb30d88 R09: 00007fd843f470c0
R10: 0000555bebe85458 R11: 0000000000000206 R12: 00007fd843f7f2a0
R13: 00007fd843f72eda R14: 0000555bebe88fd0 R15: 0000555bebe88f40
 </TASK>
task:modprobe        state:R  running task     stack:23072 pid:5922  tgid:5922  ppid:5918   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6997
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__kernel_text_address+0x12/0x40 kernel/extable.c:79
Code: eb b5 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 53 48 89 fb e8 43 00 00 00 85 c0 0f 95 c0 <48> c7 c1 00 90 7b 91 48 39 cb 0f 93 c1 48 c7 c2 3f 66 96 91 48 39
RSP: 0018:ffffc9000903f6f0 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffffff81fea7df RCX: 0000000080000000
RDX: dffffc0000000000 RSI: ffffc90009038000 RDI: ffffffff81fea7df
RBP: ffffc9000903f7b0 R08: ffffc9000903fc38 R09: 0000000000000000
R10: ffffc9000903f770 R11: fffff52001207ef0 R12: ffff8880257b1e00
R13: ffffffff8180a000 R14: dffffc0000000000 R15: 1ffff92001207eed
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xfd/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4d9918a46
RSP: 002b:00007ffe1fcbc548 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffe1fcbc7a8 RCX: 00007ff4d9918a46
RDX: 0000000000080000 RSI: 00007ffe1fcbc5c0 RDI: 00000000ffffff9c
RBP: 00007ffe1fcbc5b0 R08: 0000000000080000 R09: 00007ffe1fcbc5c0
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffe1fcbc5c0
R13: 0000000000000006 R14: 00007ffe1fcbc78f R15: 00000000ffffffff
 </TASK>
task:kworker/u8:7    state:R  running task     stack:21936 pid:2581  tgid:2581  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6997
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_stack_walk+0x10e/0x150 arch/x86/kernel/stacktrace.c:27
Code: 00 83 bd 70 ff ff ff 00 74 37 48 8d 9d 70 ff ff ff 48 89 df e8 03 9d 09 00 48 85 c0 74 23 4c 89 f7 48 89 c6 4d 89 eb 41 ff d3 <66> 90 84 c0 74 11 48 89 df e8 34 9e 09 00 83 bd 70 ff ff ff 00 75
RSP: 0018:ffffc900094ae620 EFLAGS: 00000286
RAX: 0000000000000001 RBX: ffffc900094ae620 RCX: ffffffff917b9000
RDX: dffffc0000000000 RSI: ffffffff821f848c RDI: ffffc900094ae70c
RBP: ffffc900094ae6b0 R08: 000000000000000d R09: ffffc900094ae710
R10: ffffc900094ae670 R11: ffffffff8180a000 R12: ffff88802dc7bc00
R13: ffffffff8180a000 R14: ffffc900094ae700 R15: 0000000000000000
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 ext4_alloc_io_end_vec+0x2b/0x160 fs/ext4/page-io.c:60
 mpage_map_and_submit_extent fs/ext4/inode.c:2256 [inline]
 ext4_do_writepages+0x12eb/0x3d20 fs/ext4/inode.c:2724
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2813
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1658
 writeback_sb_inodes+0x80c/0x1370 fs/fs-writeback.c:1954
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2025
 wb_writeback+0x42f/0xbd0 fs/fs-writeback.c:2136
 wb_check_old_data_flush fs/fs-writeback.c:2240 [inline]
 wb_do_writeback fs/fs-writeback.c:2293 [inline]
 wb_workfn+0xba1/0x1090 fs/fs-writeback.c:2321
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:modprobe        state:R  running task     stack:22976 pid:5913  tgid:5913  ppid:5909   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6997
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:stack_trace_consume_entry+0x7/0x280 kernel/stacktrace.c:83
Code: ff e8 8d d6 44 0a 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 57 <41> 56 41 55 41 54 53 48 83 ec 18 48 89 fb 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000953f708 EFLAGS: 00000286
RAX: ffffffff81f3226c RBX: ffffc9000953f720 RCX: ffffffff917b9000
RDX: ffffffff91966601 RSI: ffffffff81f3226c RDI: ffffc9000953f800
RBP: ffffc9000953f7b0 R08: ffffc9000953fb20 R09: 0000000000000000
R10: ffffc9000953f770 R11: ffffffff8180a000 R12: ffff888024e0da00
R13: ffffffff8180a000 R14: ffffc9000953f800 R15: 0000000000000000
 arch_stack_walk+0x10e/0x150 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f33370f59a4
RSP: 002b:00007ffe88637f90 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f33370f59a4
RDX: 0000000000080000 RSI: 00007f3337012707 RDI: 00000000ffffff9c
RBP: 00007f3337012707 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 00007f33370127fc R14: 0000000000000001 R15: 0000000000000000
 </TASK>
task:syz.2.126       state:R  running task     stack:22880 pid:5884  tgid:5877  ppid:5422   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6854
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6878
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 follow_page_pte+0x28c/0x2010 mm/gup.c:938
 follow_pmd_mask mm/gup.c:969 [inline]
 follow_pud_mask mm/gup.c:1021 [inline]
 follow_p4d_mask mm/gup.c:1038 [inline]
 follow_page_mask mm/gup.c:1081 [inline]
 __get_user_pages+0xb75/0x48d0 mm/gup.c:1483
 populate_vma_page_range+0x264/0x330 mm/gup.c:1923
 __mm_populate+0x27a/0x460 mm/gup.c:2026
 do_mlock+0x60f/0x7d0 mm/mlock.c:653
 __do_sys_mlock mm/mlock.c:661 [inline]
 __se_sys_mlock mm/mlock.c:659 [inline]
 __x64_sys_mlock+0x60/0x70 mm/mlock.c:659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff6cad7dff9
RSP: 002b:00007ff6ca7de038 EFLAGS: 00000246 ORIG_RAX: 0000000000000095
RAX: ffffffffffffffda RBX: 00007ff6caf36058 RCX: 00007ff6cad7dff9
RDX: 0000000000000000 RSI: 0000000000800000 RDI: 0000000020000000
RBP: 00007ff6cadf0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff6caf36058 R15: 00007ff6cb05fa28
 </TASK>
rcu: rcu_preempt kthread starved for 10893 jiffies! g14685 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:24912 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 25 Comm: kworker/1:0 Not tainted 6.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:ip6_rcv_core+0x75f/0x15f0 net/ipv6/ip6_input.c:197
Code: c1 ef 03 43 0f b6 04 2f 84 c0 48 89 54 24 08 0f 85 9d 0b 00 00 0f b6 1a 83 e3 f0 bf 60 00 00 00 89 de e8 74 5a 30 f7 80 fb 60 <0f> 85 69 02 00 00 48 c7 c7 20 e7 1a 8d e8 2f 07 61 01 48 8b 44 24
RSP: 0018:ffffc90000a188c0 EFLAGS: 00000246
RAX: 0000000000000100 RBX: 0000000000000060 RCX: ffff88801d2f1e00
RDX: ffff88801d2f1e00 RSI: 0000000000000060 RDI: 0000000000000060
RBP: ffff8880b12cbab8 R08: ffffffff8a648efc R09: 0000000000000000
R10: ffff8880b12cba28 R11: ffffed1016259748 R12: ffff88807c7783c0
R13: dffffc0000000000 R14: ffff8880b12cba00 R15: 1ffff11004e69e02
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ef077bd008 CR3: 000000007e670000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 ipv6_rcv+0x71/0xc0 net/ipv6/ip6_input.c:306
 __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
 __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5779
 process_backlog+0x662/0x15b0 net/core/dev.c:6111
 __napi_poll+0xcb/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
net_ratelimit: 9248 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:b6:0f:4e:66:3d:30, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:b6:0f:4e:66:3d:30, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:b6:0f:4e:66:3d:30, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:b6:0f:4e:66:3d:30, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:b6:0f:4e:66:3d:30, vlan:0)


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

