Return-Path: <linux-kernel+bounces-419336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C97A9D6CA1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 06:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72721617A7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 05:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F111152E1C;
	Sun, 24 Nov 2024 05:03:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05E2F44
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732424603; cv=none; b=pvLYqcCfN6PZH1cl0psQkDDA3uSGORems+0BZlSz3TR3tNBoBIJWP2MlA9D7DPN9S6zVrA4JG4OuDfMiGbuiVBh5JwzNB5IOLUiQR0t6hrokDczF7KcaJuFv4sPhD2bOXzO6thivyM0boBdyvsjEjrNsna3l+01NWvegPZmh028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732424603; c=relaxed/simple;
	bh=Dn5sQDgGxJJ6YiNXUo+XpXRi6AW9tI9kR/PSmTOSsws=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YG57MSCwvbzTQKYucvHiimHa+gRlPl5QAgBDdul5MB+/bY4qtvap7mNncLYYQDuZACysipWP5Gl+O1thZCnE2XwjDTJTJSsTf3vof22t2RpmioUQlRNRQUFsUoffO/1Tzys/kCf3ujaA6qSH1UqkTWT+ikf7xK1KoKRswsAUl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84181aad98aso29237039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 21:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732424601; x=1733029401;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hPJlpwU0KFvqi6U6GhuJwlXkw8FGPfP92KSasoIAGFk=;
        b=f2A9AzX142EdOi9c0RDn09sTJMoqXu40NqYnjzk0SL9s7d1BSk0iSxqynl5UO2fTxc
         oi79SPMWeSsqJqhAbq54juOsQw1/MLngK6Rn0/D61YWYC1vpKVAWFdydVIRo+vIQtqsL
         dSPCvGz9cMP6c9TvkcxnYNBZK8b+GT4upwYJm/5WGJIlXmhzh/exRNq6NQ3IJ0kfYnYc
         r11DMiiU1vUxZY8Gl66g8LXDodgnyUdQxG0rChufmuVqksTUhKfRVnhvKPtFz9jgfht1
         U5d/1Cc+P/AgrQD3vQeRQyLme8ehu94SB07mLvzPs3sodokzieKqjbkAEe3ZN4Z8PiuG
         +SYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0VmDe4AX8nMvfZfDAjCOACJYkU5YkNVdSzkG9OH3SgH+05v7Ow7evYOaLrSuPvUH1wbwJFO4HdOyro60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3AD+cjI+tQYq12NxRasqiFovG8SzT/P43o1RN671Be6LXYAb4
	0C9UHHzQO8gbTfSjPq6iWMC+PZoM7+jJ8Q/fp2O1jI39pEI4zMKfHH60u8nIx7KCVQqsDXW4V70
	t60EPdaS76Vj7f+/uDkoCw4zQBAxDU/Wjxo6Gh/XscwSdnvJ/iJiv+xU=
X-Google-Smtp-Source: AGHT+IHtwYnwlpfoGFlnrGXp39OR37CMWOHKh8rUpmnAh6XL16+CL2fO60pdoDbwljgNWEYOnk1VMlLF/56YFknrL+1nb6WndZHb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:3a7:9860:d7e5 with SMTP id
 e9e14a558f8ab-3a79afda47bmr87116365ab.23.1732424601161; Sat, 23 Nov 2024
 21:03:21 -0800 (PST)
Date: Sat, 23 Nov 2024 21:03:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6742b399.050a0220.1cc393.0033.GAE@google.com>
Subject: [syzbot] [usb?] general protection fault in dummy_timer (2)
From: syzbot <syzbot+faf3a6cf579fc65591ca@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    237d4e0f4113 usb: typec: tcpm: Add support for sink-bc12-c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=114e76e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=358c1689354aeef3
dashboard link: https://syzkaller.appspot.com/bug?extid=faf3a6cf579fc65591ca
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d16b8e77d72/disk-237d4e0f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9636263bfc8f/vmlinux-237d4e0f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36d0ba4d90fb/bzImage-237d4e0f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+faf3a6cf579fc65591ca@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000040: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000200-0x0000000000000207]
CPU: 1 UID: 0 PID: 13433 Comm: syz-executor Not tainted 6.12.0-rc6-syzkaller-00153-g237d4e0f4113 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:strcmp+0x5b/0xb0 lib/string.c:266
Code: fa 48 c1 e8 03 83 e2 07 42 0f b6 04 28 38 d0 7f 04 84 c0 75 58 0f b6 6b ff 4c 8d 66 01 48 89 f0 48 89 f2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38 d0 7f 04 84 c0 75 2c 41 3a 6c 24 ff 74 ae 19 c0
RSP: 0018:ffffc900001b8850 EFLAGS: 00010046
RAX: 0000000000000040 RBX: ffffffff8746fac1 RCX: ffffffff8fb08b60
RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffffffff8746fac0
RBP: 0000000000000066 R08: 0000000000000001 R09: dffffc0000000000
R10: ffffffff8fb08b70 R11: ffffffff8fb08b60 R12: 0000000000000201
R13: dffffc0000000000 R14: 00000000000001f2 R15: ffffffff934a7980
FS:  0000555591f43500(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c30aef3 CR3: 00000001166a8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 count_matching_names kernel/locking/lockdep.c:875 [inline]
 register_lock_class+0x63b/0x1240 kernel/locking/lockdep.c:1340
 __lock_acquire+0x135/0x3ce0 kernel/locking/lockdep.c:5077
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 complete_with_flags kernel/sched/completion.c:20 [inline]
 complete+0x1d/0x200 kernel/sched/completion.c:47
 transfer drivers/usb/gadget/udc/dummy_hcd.c:1522 [inline]
 dummy_timer+0x1c04/0x3930 drivers/usb/gadget/udc/dummy_hcd.c:1977
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire.part.0+0x155/0x380 kernel/locking/lockdep.c:5790
Code: b8 ff ff ff ff 65 0f c1 05 90 1f cf 7e 83 f8 01 0f 85 d0 01 00 00 9c 58 f6 c4 02 0f 85 e5 01 00 00 48 85 ed 0f 85 b6 01 00 00 <48> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00 00 00 00 48 c7
RSP: 0018:ffffc9001499f500 EFLAGS: 00000206
RAX: 0000000000000046 RBX: 1ffff92002933ea1 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff8727f520 RDI: ffffffff8746ec80
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff1f559b4
R10: ffffffff8faacda7 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff88ebb140 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3a/0x310 mm/page_ext.c:525
 page_table_check_set mm/page_table_check.c:114 [inline]
 page_table_check_set+0x285/0x9c0 mm/page_table_check.c:102
 __page_table_check_ptes_set+0x44c/0x710 mm/page_table_check.c:225
 page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
 set_ptes include/linux/pgtable.h:267 [inline]
 __copy_present_ptes mm/memory.c:969 [inline]
 copy_present_ptes+0xc03/0x3540 mm/memory.c:1052
 copy_pte_range mm/memory.c:1167 [inline]
 copy_pmd_range mm/memory.c:1255 [inline]
 copy_pud_range mm/memory.c:1292 [inline]
 copy_p4d_range mm/memory.c:1316 [inline]
 copy_page_range+0xbd7/0x2420 mm/memory.c:1414
 dup_mmap kernel/fork.c:746 [inline]
 dup_mm kernel/fork.c:1675 [inline]
 copy_mm kernel/fork.c:1724 [inline]
 copy_process+0x8236/0x91e0 kernel/fork.c:2374
 kernel_clone+0xfd/0x960 kernel/fork.c:2786
 __do_sys_clone+0xba/0x100 kernel/fork.c:2929
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff90ac55093
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffc36e1b4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff90ac55093
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000555591f437d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000001091bd R14: 0000000000108c37 R15: 00007ffc36e1b670
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strcmp+0x5b/0xb0 lib/string.c:266
Code: fa 48 c1 e8 03 83 e2 07 42 0f b6 04 28 38 d0 7f 04 84 c0 75 58 0f b6 6b ff 4c 8d 66 01 48 89 f0 48 89 f2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38 d0 7f 04 84 c0 75 2c 41 3a 6c 24 ff 74 ae 19 c0
RSP: 0018:ffffc900001b8850 EFLAGS: 00010046
RAX: 0000000000000040 RBX: ffffffff8746fac1 RCX: ffffffff8fb08b60
RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffffffff8746fac0
RBP: 0000000000000066 R08: 0000000000000001 R09: dffffc0000000000
R10: ffffffff8fb08b70 R11: ffffffff8fb08b60 R12: 0000000000000201
R13: dffffc0000000000 R14: 00000000000001f2 R15: ffffffff934a7980
FS:  0000555591f43500(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c30aef3 CR3: 00000001166a8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fa                   	cli
   1:	48 c1 e8 03          	shr    $0x3,%rax
   5:	83 e2 07             	and    $0x7,%edx
   8:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
   d:	38 d0                	cmp    %dl,%al
   f:	7f 04                	jg     0x15
  11:	84 c0                	test   %al,%al
  13:	75 58                	jne    0x6d
  15:	0f b6 6b ff          	movzbl -0x1(%rbx),%ebp
  19:	4c 8d 66 01          	lea    0x1(%rsi),%r12
  1d:	48 89 f0             	mov    %rsi,%rax
  20:	48 89 f2             	mov    %rsi,%rdx
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e2 07             	and    $0x7,%edx
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	38 d0                	cmp    %dl,%al
  31:	7f 04                	jg     0x37
  33:	84 c0                	test   %al,%al
  35:	75 2c                	jne    0x63
  37:	41 3a 6c 24 ff       	cmp    -0x1(%r12),%bpl
  3c:	74 ae                	je     0xffffffec
  3e:	19 c0                	sbb    %eax,%eax


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

