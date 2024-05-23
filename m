Return-Path: <linux-kernel+bounces-187418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D768D8CD185
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C65628452C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EC13BC0A;
	Thu, 23 May 2024 11:49:26 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017ED13BAEB
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464965; cv=none; b=qr3mYRz9vkXyMl58U1y4x6HgfRQOJQSy6HUuOQOLuoA/zo/FQMIalH+UYAEyW18CRmr5rjWC3lQpSRk5ISbA1ZgYZolr8C2EOrAZiIyrJvjDGy/F+60dbimDLmw4OomXxrDnUwzwFBpDYqte0Z07ugBqRI4xVw5NCQ8FYxzPhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464965; c=relaxed/simple;
	bh=fajVoYRll+RgxhdSLI20qXx0rDsvb3goo9o0gS2wghI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k/7/avG8rsDFjt3bWpo6ddzzxtYb/B7RjOyrSBhTQ4a0BeRhKxKKnDRDMgf5Ea0yvUqhsdfrfRGVdOXjXXsW72YHx+UIc6NeHrQSRCoTdT2CZseVak49p/OwWXUnftN3i2U9REEIA2utAwb6am5u6M7NCRN/X1riboodBNQ/ZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3705289d46fso19491435ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716464963; x=1717069763;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mM1Pxf+/gr4MztO09tIozckZkAVhEu+YpQkO92MctCg=;
        b=dxhv7ZL55Mz8WVu2+FIWYKSqIiIU97fth/xTxLHhFtBhnfBMv1Ajuc1Gpunej6rMcE
         3240WNbWfZ6SkGwIWlVavskMKkspOpi0+T1Hnisca5RC5ofqc0EniRNca1Rsr01eBw/b
         qQZ0l6+q478+c7j4nYyjDdoV3Kqi00d0zabZ4j7U7cBJ1glSlb0XkOWRBSaZ8aD7PKB1
         I7fTKbTww7t/GFTHqJUkZTmRDnPqfUT4t7AXFFC3hia3cfUV0nFxnMBENDAr7VKTy/fN
         l2H+Kv4iuvj/owKNBPFLOnU4G3QkXLFK1hIUvRjCOSBEwo10YbvyIAX0Qf8ZHUdTSsmN
         +T9A==
X-Forwarded-Encrypted: i=1; AJvYcCW3aQBqzcfdpQk0LWCkdhOOlgJnrFl7S5mpxCYbuupXsHy4f+sjp4HnZ5qr5cxhpgv/RdowulDvdHReCP8Uq2Ugslyj/NLgjA6RQG6B
X-Gm-Message-State: AOJu0YxIhQhtiom9bmkL7/lFJZy0UQGTl50XpAukGe7zgYPy5B2r9Nwm
	e5AAun4sq41edorRKELVmaGCC7VPMfA7LGkoyV6eHxMWXRRpRq3jAZ+47WrBTJPNMwOqsjeEnbN
	nKYA3qUDscbirdAhmIcxakSh7UcOmuIHOhUJmTxvHCr+HlquZhTJZAfI=
X-Google-Smtp-Source: AGHT+IEOTF9Ni4vh4sKwLtaj7YtaFZlQUMentcl0NZX6Zu3N74hrybWVTmMMAocrqlfBafkCpArzQ2mGySaD5BdcGieN8rDW9GhU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c247:0:b0:36c:c4ce:8448 with SMTP id
 e9e14a558f8ab-371fb43b3d3mr4368585ab.6.1716464961621; Thu, 23 May 2024
 04:49:21 -0700 (PDT)
Date: Thu, 23 May 2024 04:49:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ea17306191da404@google.com>
Subject: [syzbot] [tomoyo?] INFO: rcu detected stall in security_file_ioctl (8)
From: syzbot <syzbot+67defecaa74f7dd0a5d3@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0450d2083be6 Merge tag '6.10-rc-smb-fix' of git://git.samb..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134a2cb2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=67defecaa74f7dd0a5d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17109b3f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bcb2a4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea5625524879/disk-0450d208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da5d9e44bc33/vmlinux-0450d208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36d37dbc4f83/bzImage-0450d208.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67defecaa74f7dd0a5d3@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (3 GPs behind) idle=b35c/1/0x4000000000000000 softirq=6130/6131 fqs=1
rcu: 	(detected by 0, t=10502 jiffies, g=5373, q=289 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5128 Comm: syz-executor184 Not tainted 6.9.0-syzkaller-08995-g0450d2083be6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__lock_acquire+0x2f7/0x1fd0
Code: 44 24 08 0f 83 9f 19 00 00 4c 8d 34 92 4b 8d 5c f0 20 48 89 d8 48 c1 e8 03 48 89 44 24 20 0f b6 04 30 84 c0 0f 85 2e 14 00 00 <48> 8b ac 24 d0 00 00 00 b8 00 e0 ff ff 23 03 41 81 e5 ff 1f 00 00
RSP: 0018:ffffc90000a18a30 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff88802532a928 RCX: ffffffff94798603
RDX: 0000000000000001 RSI: dffffc0000000000 RDI: 0000000000000726
RBP: 1ffff11004a65520 R08: ffff88802532a8e0 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff1f5981e R12: ffff888078adb300
R13: 0000000000000726 R14: 0000000000000005 R15: 0000000000000000
FS:  00005555851bc380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 0000000023856000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 advance_sched+0xab/0xca0 net/sched/sch_taprio.c:924
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:235 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x8/0x90 kernel/kcov.c:304
Code: 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 4c 8b 04 24 <65> 48 8b 14 25 80 d3 03 00 65 8b 05 80 9d 6d 7e a9 00 01 ff 00 74
RSP: 0018:ffffc900036ffb40 EFLAGS: 00000246
RAX: ffffffff8466a304 RBX: 0000000000000004 RCX: 0000000000000004
RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000000000
RBP: 0000000000000010 R08: ffffffff8466a319 R09: ffffffff8467eb9c
R10: 0000000000000002 R11: ffffffff8466a290 R12: 0000000000000010
R13: dffffc0000000000 R14: ffff888140112500 R15: ffffc900036ffcc0
 tomoyo_check_path_number_acl+0x89/0x280 security/tomoyo/file.c:281
 tomoyo_check_acl+0x12e/0x3f0 security/tomoyo/domain.c:175
 tomoyo_path_number_perm+0x459/0x880 security/tomoyo/file.c:733
 security_file_ioctl+0x75/0xb0 security/security.c:2765
 __do_sys_ioctl fs/ioctl.c:901 [inline]
 __se_sys_ioctl+0x47/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f58b7718069
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc5953828 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f58b7718069
RDX: 0000000020000600 RSI: 0000000000008933 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcc5953880
R13: 000000000003d776 R14: 00007ffcc595384c R15: 0000000000000003
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.002 msecs
rcu: rcu_preempt kthread starved for 10500 jiffies! g5373 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:24496 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2202
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.9.0-syzkaller-08995-g0450d2083be6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x1894/0x2a00 kernel/smp.c:855
Code: 45 8b 65 00 44 89 e6 83 e6 01 31 ff e8 85 0c 0c 00 41 83 e4 01 49 bc 00 00 00 00 00 fc ff df 75 07 e8 30 08 0c 00 eb 38 f3 90 <42> 0f b6 04 23 84 c0 75 11 41 f7 45 00 01 00 00 00 74 1e e8 14 08
RSP: 0018:ffffc90000ab76e0 EFLAGS: 00000293
RAX: ffffffff818a299c RBX: 1ffff110172a8879 RCX: ffff88801bee8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000ab78e0 R08: ffffffff818a296b R09: 1ffffffff25f40b0
R10: dffffc0000000000 R11: fffffbfff25f40b1 R12: dffffc0000000000
R13: ffff8880b95443c8 R14: ffff8880b943f780 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b91266e050 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2069 [inline]
 text_poke_bp_batch+0x352/0xb30 arch/x86/kernel/alternative.c:2279
 text_poke_flush arch/x86/kernel/alternative.c:2470 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2477
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
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

