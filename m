Return-Path: <linux-kernel+bounces-402732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9054E9C2B42
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111041F21FEE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C813E043;
	Sat,  9 Nov 2024 08:24:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB6233D62
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731140669; cv=none; b=D1saSooU7/b0k7XY71qWy43jzYZg7I/eNrfOjnMtccjbadOuCpdoSAuQp8Koqi9+9EwD9T3p+pfGcQO49Xwf8QDamve27Xx2jRS8SZd2x8jcBwLqjaXXZVzJwckzRaoQuMzF9qOrcEjcOMRXySqMkttq9LDCM8I1AY8DPcI10hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731140669; c=relaxed/simple;
	bh=Jfe7igCuEjnCsxgsNMi33jYyC/yiVZwx+0UdW7PkbTs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nFiKrviTP6bfM0XS/FmjgCC5iiHJFUyy9e7VBsvx5vfRWSCVAO+cYyrsflP+nJpkp+NX9aWQx63pmd7E+twugI0JZL/0YWeet45E9NsbjPnun4HH6MvteiXzeTY+LpfG+LMpbAj0HgyphA2tGMmNhfUFrY1sdjvWpEFWbK6+PmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4e80ccd1bso30875085ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 00:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731140666; x=1731745466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHOPMNZcESCp4nYIfh1RNU6R07PxARKJTp8wG2Trlwk=;
        b=lF+2eV0I7E2z/r7bI+baOSR3bVJzVXBrpp4WIgbrLpK0rHrfzITA74ifEfM2dN+Cd8
         pUifK9fzIq2YrYZi19QPE2FwYI3mk0UA5anh9tb4W83ACXpD2mz9qJFbr7hE0TxiXCnW
         C/iE0lSxAqqMslJmgd7JFJ7R14vKGWxz5ewTSRXxf2UwX0K96EG6odBOJYls7gvxs8Es
         vPMtraVYW9JK3imh2+emjtARKkSReyEPK35SblyS0XyAlMuWxQNahV0hEbnfPu7d0ADP
         LSkkQdmWh0aPauWJpOmSwF/IuWjoXbUSHV1qyyjQp9YGEqm0jUqrIYf3or0XCA8Fb40t
         IffA==
X-Forwarded-Encrypted: i=1; AJvYcCWHvwxKqMuJEMEMMUszNfAdDy6hSv7aZfbm5eJs2RIqe02R4gAWPw4RpvPb9gEU9gRv4Zhxt/mTixAOM3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUXHEsEF9S/qciUK90bZsDmxOTPzNVBS5ElVoojh9jQCgcM//
	z15pSCRnsjorqHwIFusMJfhiHqfLWxUGHvOht8LygfXnOiwlqqlNaodMe+AwiishIhgFhlnYvm2
	its0TXSY0sxiHXx9Xq3iNNnPDX6obaQ7P3Z7QnN8EjA4r0AOXZZqsrDk=
X-Google-Smtp-Source: AGHT+IH/hEVMouRRl7vsEzB+aQYkIaENPEhh5TSWhWiDe6m31Ao9wqtowWT3ZNC5Y6QkV6OEQravvcb9fTuS3w+MU7KyXiara/Qj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0a:0:b0:3a4:e62b:4e20 with SMTP id
 e9e14a558f8ab-3a6f19b2cfemr66241625ab.9.1731140666327; Sat, 09 Nov 2024
 00:24:26 -0800 (PST)
Date: Sat, 09 Nov 2024 00:24:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672f1c3a.050a0220.138bd5.003a.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in schedule_timeout (7)
From: syzbot <syzbot+8926d1b522e7194a4b3e@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    557329bcecc2 Merge tag 'mmc-v6.12-rc3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a296a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=8926d1b522e7194a4b3e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108ced5f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47c1323cbaa7/disk-557329bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32b880369d29/vmlinux-557329bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4799d7cbb82a/bzImage-557329bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8926d1b522e7194a4b3e@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6107/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=10381, q=1041 ncpus=2)
task:syz.5.20        state:R  running task     stack:25752 pid:6107  tgid:6107  ppid:5944   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6690
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6869
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6893
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
 __kasan_kmalloc+0x23/0xb0 mm/kasan/common.c:385
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 kobject_uevent_env+0x28b/0x8e0 lib/kobject_uevent.c:540
 device_remove drivers/base/dd.c:567 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x4ab/0x7c0 drivers/base/dd.c:1296
 driver_detach+0x1fb/0x2d0 drivers/base/dd.c:1359
 bus_remove_driver+0x1f3/0x320 drivers/base/bus.c:744
 usb_gadget_unregister_driver+0x4e/0x70 drivers/usb/gadget/udc/core.c:1732
 raw_release+0xf6/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:462
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4b9d7e719
RSP: 002b:00007ffdb979f378 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001e66c RCX: 00007ff4b9d7e719
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ff4b9f37a80 R08: 0000000000000001 R09: 00007ffdb979f66f
R10: 00007ff4b9c00000 R11: 0000000000000246 R12: 000000000001eb0d
R13: 00007ffdb979f480 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>
rcu: rcu_preempt kthread starved for 10308 jiffies! g10381 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:26112 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6690
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7012
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:19 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:87 [inline]
RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:123 [inline]
RIP: 0010:lock_release+0x175/0xa30 kernel/locking/lockdep.c:5842
Code: f7 e8 6f 30 8e 00 48 c7 c0 d0 d6 e3 93 49 39 06 0f 84 ee 04 00 00 4c 8d b4 24 b0 00 00 00 4c 89 f3 48 c1 eb 03 42 80 3c 3b 00 <74> 08 4c 89 f7 e8 31 31 8e 00 4c 89 6c 24 50 48 c7 84 24 b0 00 00
RSP: 0018:ffffc90000167780 EFLAGS: 00000246
RAX: ffffffff93e3d6d0 RBX: 1ffff9200002cf06 RCX: ffffffff81706f50
RDX: 0000000000000000 RSI: ffffffff8c610840 RDI: ffffffff8c610800
RBP: ffffc900001678b0 R08: ffffffff901d08ef R09: 1ffffffff203a11d
R10: dffffc0000000000 R11: fffffbfff203a11e R12: 1ffff9200002cefc
R13: ffffffff84c3b400 R14: ffffc90000167830 R15: dffffc0000000000
 debug_objects_fill_pool+0xc1/0x9f0 lib/debugobjects.c:616
 __debug_object_init+0xa4/0x400 lib/debugobjects.c:627
 init_timer_on_stack_key kernel/time/timer.c:859 [inline]
 schedule_timeout+0x121/0x310 kernel/time/timer.c:2613
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: wg-crypt-wg1 wg_packet_encrypt_worker
RIP: 0010:usb_hcd_map_urb_for_dma+0x133/0xf90 drivers/usb/core/hcd.c:1430
Code: 00 85 ed 0f 85 b1 01 00 00 48 8b 44 24 10 48 8d 98 00 04 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 <74> 08 48 89 df e8 a3 b8 c6 fa 48 83 3b 00 0f 84 4d 03 00 00 48 8b
RSP: 0018:ffffc90000007650 EFLAGS: 00000046
RAX: 1ffff11004f51680 RBX: ffff888027a8b400 RCX: dffffc0000000000
RDX: ffff88801c290000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8737e781 R09: 1ffff11004d8d6d1
R10: dffffc0000000000 R11: ffffed1004d8d6d2 R12: 1ffff11005e0d0a9
R13: ffff888027a8b000 R14: 0000000000000040 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000029b04000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 map_urb_for_dma drivers/usb/core/hcd.c:1381 [inline]
 usb_hcd_submit_urb+0x314/0x1e80 drivers/usb/core/hcd.c:1531
 ath9k_hif_usb_reg_in_cb+0x4ce/0x6e0 drivers/net/wireless/ath/ath9k/hif_usb.c:790
 __usb_hcd_giveback_urb+0x42e/0x6e0 drivers/usb/core/hcd.c:1650
 dummy_timer+0x856/0x4620 drivers/usb/gadget/udc/dummy_hcd.c:1993
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x59d/0xd50 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1772
 handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:profile_hit include/linux/profile.h:50 [inline]
RIP: 0010:schedule_debug kernel/sched/core.c:5910 [inline]
RIP: 0010:__schedule+0x2ae/0x4c30 kernel/sched/core.c:6564
Code: 48 c7 c2 20 5e 0a 8c e8 e0 a4 a1 f5 0f 1f 44 00 00 48 c7 c0 70 0a 1d 90 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 <84> c0 0f 85 1b 18 00 00 83 3d d3 00 4e 04 02 0f 84 95 16 00 00 4c
RSP: 0018:ffffc900000e72c0 EFLAGS: 00000216
RAX: 0000000000000000 RBX: ffffc900000e0000 RCX: dffffc0000000000
RDX: 0000000000000010 RSI: ffffffff8c0adc40 RDI: ffffffff8c610860
RBP: ffffc900000e74d0 R08: ffffc900000e745f R09: ffffc900000e7450
R10: dffffc0000000000 R11: fffff5200001ce8c R12: ffffc900000e7450
R13: ffff8880b8600000 R14: dffffc0000000000 R15: dffffc0000000000
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7012
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:wg_packet_encrypt_worker+0x30b/0x1610
Code: 24 58 e8 18 d2 61 05 48 8b 84 24 88 00 00 00 48 8d 58 30 49 89 c5 48 89 9c 24 d8 00 00 00 4c 89 e8 48 c1 e8 03 42 80 3c 38 00 <74> 08 4c 89 ef e8 bb 7b 8f fb 49 8b 45 00 48 89 84 24 f8 00 00 00
RSP: 0018:ffffc900000e7660 EFLAGS: 00000246
RAX: 1ffff1100f39f4c8 RBX: ffff888079cfa670 RCX: ffffffff8170bffa
RDX: dffffc0000000000 RSI: ffffffff8c0acac0 RDI: ffffffff8c610860
RBP: ffffc900000e7bb0 R08: ffffffff942cd8ff R09: 1ffffffff2859b1f
R10: dffffc0000000000 R11: fffffbfff2859b20 R12: 0000000000000005
R13: ffff888079cfa640 R14: ffffc900000e7b40 R15: dffffc0000000000
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

