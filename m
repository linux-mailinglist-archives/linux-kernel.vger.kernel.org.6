Return-Path: <linux-kernel+bounces-394051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7179BA9B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A572B2220A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 00:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894621C32;
	Mon,  4 Nov 2024 00:09:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3829A5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730678965; cv=none; b=vE6JkySL3jJYZX7dIc76Ewzs0GPlvfFeVax0kvwko3HMIxpm1u9YA06UtyCdweUfjD0EmjvxNiKBaJ2CDboNuLmDx2idIsidILaX7/c+Bc9TfGat3DwLFsaziMSeNTspzT0/cgB9mPYsJpqb/1pLjxqA6AEiP2Oy+93SAHO017Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730678965; c=relaxed/simple;
	bh=YzzD3ddama46FwtJbZYwdFvopb+dHljYmHa6YOjIuTM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rvVbF05aCRgoSlOJG+ZhwvXgb0a16n1YYb6rADH0c1f3OYbAf/cjbI9kpw8q2HcNAorSD0bKElkCx7+mOUQBIPV3rDWxSbW7c+c6Lg4uQArKX77v9nC7eSZLSUUIGVETB3m+SlFE/8nr2g/5gPrY1GiuUeILOzjCntgAputtRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so21035755ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 16:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730678962; x=1731283762;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oT3SXE9owQO6rk8SyxCr4J+YVAdEjf0z2blmTTr5e4I=;
        b=eZ35jT+k3Kc92qxgiEq1snOP1X7cQ2wveltAjwo8G9a+eXqjGnLIpV8+reAiyErHWu
         LFxrCrYxHXbKvxRCNBkv2RO6aiVaAxLCNiaUxW1cSQzdhYGJImGq5WYHNLw12COPuSWB
         suae6k7+ZraH5yBXArycXlG8oN2V3QVyBQ/BlgjapghvDckRfJswwKQWN2pxpHRKhZjw
         8WEuiMM4QDEmoRCk/ET6hIRltveO2rwvQ7FCMxXVbHvIcRO9LWVGa11G43HbnpLsGIH9
         lEzNOCzB7vrTC7YPcbt56etLtt/tcBpqT2JXAUNw6mWyUIu58LbepyscjEOo4TzyNILl
         q3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc5qjx95a9qzHxxX101lYrBmRIIUpvGrsaAdG6M2+qemPF85I47gk+TmaaVpO+6xB8wS0lixeJlIfiI8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkTlSjyRFFyMaSlosZ8zZ0f3aV8vFs46/BzUOEI/oc5z0V/k7s
	DxwUE9yLZA8xgh+SuLqqGoRtcc9k+Q9e4EEMtTVOUAfdUqXILX7KiLqDEx+xJvj413R0qVTjMuS
	eggQJMqz2dyviS+WtHkP0mieqi1KiEhd9BgeYVEEfz40SJ4GCCu+CDWA=
X-Google-Smtp-Source: AGHT+IE5ueOerxpZHLO9O/MUW0ak1VtoEa2z45lGoMFN6GsmDCS6i4CCtoO6zHvK1cNFnFS4DJf5kRgGVNyyXt7yV2apEjMvtVT7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3287:b0:3a6:c43d:1325 with SMTP id
 e9e14a558f8ab-3a6c43d1556mr41185535ab.8.1730678962180; Sun, 03 Nov 2024
 16:09:22 -0800 (PST)
Date: Sun, 03 Nov 2024 16:09:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672810b2.050a0220.35b515.01a9.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in dl_task_timer
From: syzbot <syzbot+b70721ed2139b6b63d31@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4236f913808c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1658c630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b70721ed2139b6b63d31
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/56f56e085e8f/disk-4236f913.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a093bc9604c/vmlinux-4236f913.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df798ef0783e/bzImage-4236f913.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b70721ed2139b6b63d31@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 18423 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 18423 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4826 [inline]
WARNING: CPU: 0 PID: 18423 at kernel/locking/lockdep.c:232 __lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5152
Modules linked in:
CPU: 0 UID: 0 PID: 18423 Comm: syz.7.2061 Not tainted 6.12.0-rc5-syzkaller-00047-g4236f913808c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4826 [inline]
RIP: 0010:__lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5152
Code: 00 00 83 3d 95 e3 ac 0e 00 75 23 90 48 c7 c7 60 c9 0a 8c 48 c7 c6 00 cc 0a 8c e8 3f 7c e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90000007990 EFLAGS: 00010046
RAX: 94cb6965071fd200 RBX: 0000000000001568 RCX: ffff88801ebd8000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000000001e R08: ffffffff8155d252 R09: fffffbfff1cf9fd0
R10: dffffc0000000000 R11: fffffbfff1cf9fd0 R12: ffff88801ebd8000
R13: 0000000000001568 R14: 1ffff11003d7b17e R15: ffff88801ebd8bf0
FS:  00007f032350e6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0322760f40 CR3: 000000007e552000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
 raw_spin_rq_lock kernel/sched/sched.h:1505 [inline]
 rq_lock kernel/sched/sched.h:1804 [inline]
 class_rq_lock_constructor kernel/sched/sched.h:1829 [inline]
 dl_server_timer kernel/sched/deadline.c:1203 [inline]
 dl_task_timer+0x242/0x1030 kernel/sched/deadline.c:1274
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x553/0xd50 kernel/time/hrtimer.c:1755
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1817
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5202
Code: c9 50 e8 f9 00 0c 00 48 83 c4 08 4c 89 f7 e8 4d 39 00 00 0f 1f 44 00 00 4c 89 f7 e8 b0 6d 6c 0a e8 8b 5a 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc9000452f2c8 EFLAGS: 00000282
RAX: 94cb6965071fd200 RBX: ffff88801ebd8000 RCX: ffffffff8170bfba
RDX: dffffc0000000000 RSI: ffffffff8c0acac0 RDI: ffffffff8c610420
RBP: ffffc9000452f310 R08: ffffffff942cc827 R09: 1ffffffff2859904
R10: dffffc0000000000 R11: fffffbfff2859905 R12: 1ffff110170c7f14
R13: dffffc0000000000 R14: ffff8880b863ea80 R15: ffff8880b863f8a0
 context_switch kernel/sched/core.c:5331 [inline]
 __schedule+0x18b7/0x4bd0 kernel/sched/core.c:6690
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7012
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5829
Code: 2b 00 74 08 4c 89 f7 e8 1a 4f 8e 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000452f6c0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920008a5ee4 RCX: 94cb6965071fd200
RDX: dffffc0000000000 RSI: ffffffff8c0adc40 RDI: ffffffff8c610420
RBP: ffffc9000452f810 R08: ffffffff942cc807 R09: 1ffffffff2859900
R10: dffffc0000000000 R11: fffffbfff2859901 R12: 1ffff920008a5ee0
R13: dffffc0000000000 R14: ffffc9000452f720 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 __d_lookup+0x81/0x7b0 fs/dcache.c:2321
 d_lookup+0x27/0x60 fs/dcache.c:2270
 lookup_dcache fs/namei.c:1594 [inline]
 lookup_one_len+0x142/0x2d0 fs/namei.c:2850
 start_creating+0x187/0x310 fs/debugfs/inode.c:378
 __debugfs_create_file+0x73/0x4b0 fs/debugfs/inode.c:423
 debugfs_create_files block/blk-mq-debugfs.c:634 [inline]
 blk_mq_debugfs_register_rqos+0x357/0x410 block/blk-mq-debugfs.c:796
 rq_qos_add+0x281/0x320 block/blk-rq-qos.c:326
 wbt_init+0x3ba/0x510 block/blk-wbt.c:922
 blk_register_queue+0x37b/0x460 block/blk-sysfs.c:779
 device_add_disk+0x73a/0x1000 block/genhd.c:489
 add_disk include/linux/blkdev.h:732 [inline]
 loop_add+0x829/0xb00 drivers/block/loop.c:2078
 loop_control_ioctl+0x11c/0x780 drivers/block/loop.c:2201
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f032277e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f032350e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0322936130 RCX: 00007f032277e719
RDX: ffffffffffffffb6 RSI: 0000000000004c80 RDI: 0000000000000004
RBP: 00007f03227f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f0322936130 R15: 00007ffd4d4ad5f8
 </TASK>
----------------
Code disassembly (best guess):
   0:	c9                   	leave
   1:	50                   	push   %rax
   2:	e8 f9 00 0c 00       	call   0xc0100
   7:	48 83 c4 08          	add    $0x8,%rsp
   b:	4c 89 f7             	mov    %r14,%rdi
   e:	e8 4d 39 00 00       	call   0x3960
  13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  18:	4c 89 f7             	mov    %r14,%rdi
  1b:	e8 b0 6d 6c 0a       	call   0xa6c6dd0
  20:	e8 8b 5a 38 00       	call   0x385ab0
  25:	fb                   	sti
  26:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
* 2a:	48 8d bb f8 15 00 00 	lea    0x15f8(%rbx),%rdi <-- trapping instruction
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	49                   	rex.WB
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


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

