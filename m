Return-Path: <linux-kernel+bounces-266032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F393F990
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B351C21DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BEE13C9A7;
	Mon, 29 Jul 2024 15:34:37 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576613BC3F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267276; cv=none; b=cFeyTiFcOTs4TUY38QyZ8S1BRIlM1J6FRQfprbYIVh/9NbuwdCxgPvd5vMfcSq8M6WYUK7rZf232bhExMrXgack60P/nRwPZIKUsLE+STGOruDE74SYub/Of39xxFEUhnO7NrXBdEL7Ki5DWZsdnZAwQ6z1ZI50FnBK94zhI89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267276; c=relaxed/simple;
	bh=C6jE+lNy+Ex8wNV6Peh6rSUXi2Qc+66cMcxevlfaqss=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Amk9XFarUWX+QUI61LloBtxs19vVd5OLeqOYOr6jIkRXDDaKFNH0kX0YsdD1IahSYI+uy/4M7lbHWyJAm0r0UAu4J5oGNrNKCGJH+RXB5nzT0e67dcDkWfNomZFHfktfStzVHZPkNpu0gkJG7Dv5RTgmdoHXdX7JWoOguve60jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81faf98703eso85432039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267274; x=1722872074;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PaIqU/2uBy+ZAxWZ54s5YgdkQoW4i4kl+6wzW7i4bI=;
        b=sNicQcfNLHES9cRRv33Kl/Bc7OU1ZZUEgVX3yEnPf/EwbU3E+15G1AGX7yMbtcjmvB
         N0Q+vZyKEDZBZlF+AAKysQLI1z6B/OlO5PMmyPY/Jx6+Ny1H6A0yaSreM4riPqnXVj3L
         gKX1ru1LVX0VzwHuj744GdenR3HGyUsbFGL/ghFnR0lQGMrDso38HNX8bb03cFRD54PG
         8hDUBY+GrcW7SZGunuBPqUGbraD6jmQUj4PTx1EVXu04izVyFb2JBmbnw5jVdMjpCNe4
         RFrEmLToQpEbqK5GTbJpoIxo684K/aWoxlf1jrPPeZP1ZMTQYKMY7jwRm/ce6QQEtJd2
         uhqw==
X-Forwarded-Encrypted: i=1; AJvYcCW+rwitzN7QLlGs/Kuoesvo/R9RrK5VzPnbYir9P0Ca2Sppv1zhv8z654o1dLktxS3nE2qzFNQCPUJ+oxPNfxpB2+zGYL4NvOkpTBml
X-Gm-Message-State: AOJu0YxKAsZVdrlBFbgzDJojpgBmFUVTFW9+1qigK7GFv3YNSDkOGWmz
	/cPq/Ge9tjjqROUIO8b1s1smO5Evm9/DBZ5gDEvEYSrrD4sWPsbvfyFNjtMBYHO1AXqwoAqSf2c
	nmNkAmNPHRTifdVoZZ1cKb2QGPzQdEwSSneSF+o9wD/VN+WI+DZSFBAU=
X-Google-Smtp-Source: AGHT+IHJXTvNP3asABosrJ/H9yB0tmIoMQE0bdq+eQZGn9o0Lc9bqFKnQmev4bWFnLXPhmHG0ZB2Nm0Au8i9r7NTtN2zFcTdSQ+r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f82:b0:803:85e8:c40a with SMTP id
 ca18e2360f4ac-81f960c86c1mr22385839f.3.1722267273745; Mon, 29 Jul 2024
 08:34:33 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:34:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f67c9061e649949@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in kcov_ioctl (2)
From: syzbot <syzbot+ff2407cef5068e202465@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3a7e02c040b1 minmax: avoid overly complicated constant exp..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132e32bd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=381b8eb3d35e3ad9
dashboard link: https://syzkaller.appspot.com/bug?extid=ff2407cef5068e202465
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/198814da854c/disk-3a7e02c0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/868e99275bc0/vmlinux-3a7e02c0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce63033f3708/bzImage-3a7e02c0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff2407cef5068e202465@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P9645/1:b..l P9626/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=53081, q=325 ncpus=2)
task:syz-executor    state:R  running task     stack:27168 pid:9626  tgid:9626  ppid:5216   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:6851
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x1f2/0x560 kernel/locking/lockdep.c:5727
Code: c1 05 3a 13 9a 7e 83 f8 01 0f 85 ea 02 00 00 9c 58 f6 c4 02 0f 85 d5 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc90004647698 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff920008c8ed5 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff8b4cc880 RDI: ffffffff8bb08c00
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff28c4cd8
R10: ffffffff946266c7 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8ddb5220 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 rcu_read_lock include/linux/rcupdate.h:838 [inline]
 page_ext_get+0x3a/0x310 mm/page_ext.c:535
 __set_page_owner+0x96/0x560 mm/page_owner.c:322
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4696
 alloc_pages_mpol_noprof+0x275/0x610 mm/mempolicy.c:2263
 vm_area_alloc_pages mm/vmalloc.c:3584 [inline]
 __vmalloc_area_node mm/vmalloc.c:3660 [inline]
 __vmalloc_node_range_noprof+0xa6a/0x1520 mm/vmalloc.c:3841
 vmalloc_user_noprof+0x6b/0x90 mm/vmalloc.c:3995
 kcov_ioctl+0x4f/0x730 kernel/kcov.c:706
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa518d76e9b
RSP: 002b:00007ffd114116d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000100000 RCX: 00007fa518d76e9b
RDX: 0000000000100000 RSI: ffffffff80086301 RDI: 00000000000000d7
RBP: 00007fa518f05f40 R08: 00000000000000da R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000009
 </TASK>
task:syz-executor    state:R  running task     stack:27088 pid:9645  tgid:9645  ppid:5216   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6708
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 insert_page mm/memory.c:2077 [inline]
 vm_insert_page+0x45d/0x6d0 mm/memory.c:2226
 kcov_mmap+0xda/0x150 kernel/kcov.c:496
 call_mmap include/linux/fs.h:2129 [inline]
 mmap_region+0x757/0x2760 mm/mmap.c:2957
 do_mmap+0xbfb/0xfb0 mm/mmap.c:1468
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:588
 ksys_mmap_pgoff+0x332/0x5d0 mm/mmap.c:1514
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7bf4f772d3
RSP: 002b:00007ffc20fff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f7bf5106018 RCX: 00007f7bf4f772d3
RDX: 0000000000000003 RSI: 0000000000200000 RDI: 00007f7bf4601000
RBP: 00007f7bf4600000 R08: 00000000000000d8 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000009
 </TASK>
rcu: rcu_preempt kthread starved for 10561 jiffies! g53081 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27312 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2034
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2236
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-syzkaller-12710-g3a7e02c040b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 48 8b 05 48 69 f2 74 48 8b 00 a8 08 75 0c 66 90 0f 00 2d b8 82 aa 00 fb f4 <fa> c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8da07d70 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8b115519
RDX: 0000000000000001 RSI: ffff88801a2cb800 RDI: ffff88801a2cb864
RBP: ffff88801a2cb864 R08: 0000000000000001 R09: ffffed1017246fe1
R10: ffff8880b9237f0b R11: 0000000000000000 R12: ffff88801c70a800
R13: ffffffff8e94eac0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1eebebf378 CR3: 000000006bb72000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0x85/0x500 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x313/0x3f0 kernel/sched/idle.c:326
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:424
 rest_init+0x16b/0x2b0 init/main.c:747
 start_kernel+0x3df/0x4c0 init/main.c:1103
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x148
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

