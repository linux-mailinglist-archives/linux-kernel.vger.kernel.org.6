Return-Path: <linux-kernel+bounces-449640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D999F524D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3041892793
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD321F868D;
	Tue, 17 Dec 2024 17:14:25 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E71F75A6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455665; cv=none; b=BjHqVlOjhcItx2gexbFkV9Xh90Nh11wZ3ObO520f919t5vjm0iZtecukRkxFo7TCCsfImBO2ooCHbv1SYFZ+rmRDfMlFj5FxQvHpIjjn3nOhfxnhocARrRRQR2TXTmq5C9Iox8H6TI+vehpnze3BEvecUnZfrWBvukLb2JFVg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455665; c=relaxed/simple;
	bh=01r2qqdUKp2I9g8w6F1kmh4dP9m8LHugsXIj2M4NCnw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UoTzcHJQ/FYFSKMmaARphxxrJrOR+hHg0nN1wxlyTE1PDuvoL3gmrUdu/AKnJWjaUbEq6zEQMepnIJ6EuFTuxQKOkZgaRujWZKd4/x1k7x1NbypbNOX1EvENBBFu5Kg+HZEm3mdYyCZgtpcMgGgSAfHpsO8Uea2/bIR+morsFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a817be161bso50377275ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455663; x=1735060463;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/ATdYBM+ycWlNTVFfFExo0UM2gKqufi3AzBJWgLcQs=;
        b=Hvl7Rg4wB+5S1+cRqScSl88O56YgQyNiBJ4GKug+IzBZcGEdY0KhJ3jGEF2Dz0Mzdg
         qiuZkzWhWmtpV6OTvYCrwA+umemqzTrU/7Qgj0WZ2OpXj//Duj8POKGOW+2CjLXivkjr
         uJ4A+iEJz1iMQAiVuQF2uesP5yRI5qoWIGnU/wcIbrk0aQaL1NjKDCWDbWTpTxQvAojh
         Qd1KoLA4RgKrxRespSPAWwl4Uy2ieInXCHVaADffCLFts94CRM+m5DT1n3pFUW/He1L8
         0BXnhhX7p+EF7qG3Mdg8Z3Pa77JLorUWi0olVEgN1wb9mhtNeJMrWgx6c0jQFGNizMUb
         pz0g==
X-Forwarded-Encrypted: i=1; AJvYcCXDXhHAlZU2ZgBCp4qrjMJ2UQNKOpvowjEFHas52zTC+eYM63vIAkxcgEnGE+CIcHaCbvt6IomJY5GWN0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8i1mGx+Wn1JokVV3ckOE1NdwAV6dlDPdsWVV1/2uAoy+oASDo
	Mq0LhcvY11fFwDutpd1vFrwxogc9KoPHHOx0A6QC42XRbAooLbSFLeNJt0WoOyF4snCNlYeve83
	5hm9NlxYNTwY4GlKQouP7Vqqf/oy4Sb3BfAzihlO9ypY/5Oyzw+JkoHI=
X-Google-Smtp-Source: AGHT+IFv4n2oUHz4WOXCEB97Ot8VZ8WIaksuUQyNuB1+pATHZkpUovM37Z6dl2oR6dXqAqUMSlxNo7Gw8J+Xnh81L6LEHyxAJlwh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8d:b0:3a7:cff5:16d6 with SMTP id
 e9e14a558f8ab-3bb079e5153mr36959225ab.3.1734455662929; Tue, 17 Dec 2024
 09:14:22 -0800 (PST)
Date: Tue, 17 Dec 2024 09:14:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761b16e.050a0220.29fcd0.006d.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue (2)
From: syzbot <syzbot+3c2e3cc60665d71de2f7@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78d4f34e2115 Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10010b44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b86955f5c0c7be27
dashboard link: https://syzkaller.appspot.com/bug?extid=3c2e3cc60665d71de2f7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d4b4f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b9730580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-78d4f34e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3d545fe5a74/vmlinux-78d4f34e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c244cffe535/bzImage-78d4f34e.xz

The issue was bisected to:

commit df7a996b4dab03c889fa86d849447b716f07b069
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Nov 5 08:14:54 2024 +0000

    signal: Queue ignored posixtimers on ignore list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110727e8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130727e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=150727e8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c2e3cc60665d71de2f7@syzkaller.appspotmail.com
Fixes: df7a996b4dab ("signal: Queue ignored posixtimers on ignore list")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5933 at kernel/signal.c:2050 posixtimer_send_sigqueue+0xba8/0x1020 kernel/signal.c:2050
Modules linked in:
CPU: 1 UID: 0 PID: 5933 Comm: syz-executor261 Not tainted 6.13.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:posixtimer_send_sigqueue+0xba8/0x1020 kernel/signal.c:2050
Code: ff ff 4c 89 e7 e8 98 ff 9d 00 e9 7e f8 ff ff 41 bf 02 00 00 00 e9 87 f8 ff ff 48 89 54 24 10 48 89 44 24 08 e8 59 51 3b 00 90 <0f> 0b 90 48 8d 7b 10 48 8b 44 24 08 48 b9 00 00 00 00 00 fc ff df
RSP: 0018:ffffc900006b0d50 EFLAGS: 00010046
RAX: 0000000080010003 RBX: ffff888031d62000 RCX: 1ffff110063ac403
RDX: ffff888022920000 RSI: ffffffff815ec2e7 RDI: 0000000000000001
RBP: ffff888029fb2440 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffff888031d620a4
R13: 1ffff920000d61af R14: ffff888031d620d8 R15: ffff888031d620c0
FS:  00007fb777ee36c0(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020040fe0 CR3: 0000000023c34000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 posix_timer_fn+0x31/0x60 kernel/time/posix-timers.c:323
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x392/0x8e0 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 86 04 4b f6 48 89 df e8 ce 83 4b f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 c5 68 3c f6 65 8b 05 96 23 d8 74 85 c0 74 16 5b
RSP: 0018:ffffc900028f7d58 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff888031d62030 RCX: 1ffffffff20bdd41
RDX: 0000000000000000 RSI: ffffffff8b6cd840 RDI: ffffffff8bd1e7e0
RBP: 0000000000000293 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff905f2c57 R11: 0000000000000002 R12: ffffc900028f7e50
R13: 0000000000000000 R14: 1ffff9200051efb1 R15: dffffc0000000000
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 unlock_timer kernel/time/posix-timers.c:128 [inline]
 do_timer_settime+0x315/0x400 kernel/time/posix-timers.c:908
 __do_sys_timer_settime kernel/time/posix-timers.c:928 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:914 [inline]
 __x64_sys_timer_settime+0x26a/0x2c0 kernel/time/posix-timers.c:914
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb777f283a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb777ee3228 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007fb777f283a9
RDX: 0000000020040fe0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fb777fb2308 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb777fb2300
R13: 00007fb777fb230c R14: 00007fffae0f2ba0 R15: 00007fffae0f2c88
 </TASK>
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   7:	48 89 fb             	mov    %rdi,%rbx
   a:	48 83 c7 18          	add    $0x18,%rdi
   e:	e8 86 04 4b f6       	call   0xf64b0499
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 ce 83 4b f6       	call   0xf64b83e9
  1b:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  21:	75 23                	jne    0x46
  23:	9c                   	pushf
  24:	58                   	pop    %rax
  25:	f6 c4 02             	test   $0x2,%ah
  28:	75 37                	jne    0x61
* 2a:	bf 01 00 00 00       	mov    $0x1,%edi <-- trapping instruction
  2f:	e8 c5 68 3c f6       	call   0xf63c68f9
  34:	65 8b 05 96 23 d8 74 	mov    %gs:0x74d82396(%rip),%eax        # 0x74d823d1
  3b:	85 c0                	test   %eax,%eax
  3d:	74 16                	je     0x55
  3f:	5b                   	pop    %rbx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

