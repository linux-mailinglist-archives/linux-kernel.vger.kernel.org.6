Return-Path: <linux-kernel+bounces-408494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234B9C7F89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA52284366
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECCF9C0;
	Thu, 14 Nov 2024 00:52:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92411FC3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545545; cv=none; b=UCbH0D33GslKBGrLxzXrSKx6zEOuxBNgERBC406wsHWMQxA7NIM4q7cQrXFz9I+1mGo5VSCzBBB2kVcQjskXuTm3jPyR0AqPzvdQhv+W6Zauxeo7PR8gNhlcuHw3HGis+LWiMI4Zh0ZdSX0wOlWtSU7B4AB8TLK+9ZlZBECO4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545545; c=relaxed/simple;
	bh=Y+Mu4KXAGkaxgi3j9aRVbS/PL5d/aTk3ng5DuoiekRw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QrvcmSupeq3iRg4UEQxDGrBu4+FOWHJ/Z4OLW57D8h8ZGMfCIjIrqZz4GKvx7XRuNIqQ4XjGUL5bdaqzcZyVf9xeODrR+a1ZEVQYiTubnyB4de7D9a6BqQguS09evqogxoV0DRxpL58Nd6ERYdp/xgmkQYvOf5wxYbtoaf0OlU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6f3a08573so874825ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731545543; x=1732150343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAcEf/bFumMJk8xdu9pNOhDYqQVd5MmazaxzlL8b30w=;
        b=JhjFMCpf+gf2UhJyrE/ud3ROjWP9aHuKWqOzqYI5WcdGh7Pfopxq4IAGVN/XOxBbeJ
         IfLafB3KH/CflxDxCBNwfl7OBdF41/UQChX4G8HeptcQCTUNePWicSbMsx1KpD3CjvFg
         s8bszFXadKaBE5wfHHl9omvzIPZcnMqKQEktU1SLTsOmaOE+qUis20JnwIs51UEsivde
         7O+SvRldHhsS5zKtNgsC2gQNCdAIZToBIyt3CPgpbdu7xlM80l+I7B372DsEj7OAosg5
         S8nyfN2h9FCCsUWB7+vgjnT7UPRVhCVX7FNT9JGVruQ+sjIidrTSASNSSPe9osKhSSML
         Yp4g==
X-Forwarded-Encrypted: i=1; AJvYcCVc1ir6EysK1GBoBUzaup79XJVW8UbUGjGrbl/0ga4dma7Oq0Daf4J9cPbhQIWt8WexwiGjT8IQd3ceMfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFmORaqrciEaggL1YYlobkWBS04O8P8gSlbeVIbAxXy0EEzBk
	VfHwg/t+SNDolIaVs63M8CKMTsoGkzMTOSWT7CU7ECeCXbeSn+7W09biVkkZGzIHseEvTlRW45a
	8k0kPpdOwr5fewiH4fSI0yIpu4Dx8IwYyQQcjOpz9opwU31w11wA26nA=
X-Google-Smtp-Source: AGHT+IGkKEyZIHFi3M+D1jAMWiul+VshNhFz/YibDc06SQ7HKyluM8bWSyXTAoINykxefFCKK/EmAIL5SuK3vuTp2ZUGNVE7Yxdc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:3a7:1e1b:5d31 with SMTP id
 e9e14a558f8ab-3a71e1b5edamr14405805ab.0.1731545542928; Wed, 13 Nov 2024
 16:52:22 -0800 (PST)
Date: Wed, 13 Nov 2024 16:52:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673549c6.050a0220.1324f8.008c.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue
From: syzbot <syzbot+852e935b899bde73626e@syzkaller.appspotmail.com>
To: jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f714e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=852e935b899bde73626e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f714e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1657b0c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/disk-929beafb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinux-929beafb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/bzImage-929beafb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5854 at kernel/signal.c:2008 posixtimer_send_sigqueue+0x9da/0xbc0 kernel/signal.c:2008
Modules linked in:
CPU: 0 UID: 0 PID: 5854 Comm: syz-executor139 Not tainted 6.12.0-rc6-next-20241108-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:posixtimer_send_sigqueue+0x9da/0xbc0 kernel/signal.c:2008
Code: df 80 3c 08 00 74 08 48 89 df e8 c1 ad a5 00 4c 89 2b eb 51 e8 a7 32 3b 00 41 be 02 00 00 00 e9 e9 fd ff ff e8 97 32 3b 00 90 <0f> 0b 90 e9 f2 fa ff ff 4c 89 ef e8 86 33 5a 03 84 c0 0f 84 aa 01
RSP: 0018:ffffc90000007bc0 EFLAGS: 00010006
RAX: ffffffff81644979 RBX: 0000000000000000 RCX: ffff888027dd8000
RDX: 0000000000010000 RSI: 000000000000001e RDI: 0000000000000009
RBP: ffffc90000007cc0 R08: ffffffff816450cc R09: 1ffffffff2857112
R10: dffffc0000000000 R11: fffffbfff2857113 R12: ffff8880203f6264
R13: 1ffff1100407ec4c R14: ffff8880203f61e0 R15: ffff8880203f62a0
FS:  0000555573d1f480(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f61ecbdf388 CR3: 0000000036944000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 alarm_handle_timer+0x2f/0x60 kernel/time/alarmtimer.c:537
 alarmtimer_fired+0x173/0x410 kernel/time/alarmtimer.c:205
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5853
Code: 2b 00 74 08 4c 89 f7 e8 7a 52 8f 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90003bf6ea0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200077ede0 RCX: ffff888027dd8ad8
RDX: dffffc0000000000 RSI: ffffffff8c0aea60 RDI: ffffffff8c605b60
RBP: ffffc90003bf6fe8 R08: ffffffff942b88b7 R09: 1ffffffff2857116
R10: dffffc0000000000 R11: fffffbfff2857117 R12: 1ffff9200077eddc
R13: dffffc0000000000 R14: ffffc90003bf6f00 R15: 0000000000000246
 down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1547
 mmap_read_lock_killable include/linux/mmap_lock.h:198 [inline]
 __get_user_pages_locked mm/gup.c:1726 [inline]
 get_dump_page+0xe2/0x2f0 mm/gup.c:2269
 dump_user_range+0x14d/0x970 fs/coredump.c:943
 elf_core_dump+0x3e9f/0x4790 fs/binfmt_elf.c:2127
 do_coredump+0x214b/0x2e60 fs/coredump.c:758
 get_signal+0x140b/0x1750 kernel/signal.c:2995
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
 exc_page_fault+0x590/0x8c0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f61ecb6431e
Code: fd d7 c9 0f bc d1 c5 fe 7f 27 c5 fe 7f 6f 20 c5 fe 7f 77 40 c5 fe 7f 7f 60 49 83 c0 1f 49 29 d0 48 8d 7c 17 61 e9 d2 04 00 00 <c5> fe 6f 1e c5 fe 6f 56 20 c5 fd 74 cb c5 fd d7 d1 49 83 f8 21 0f
RSP: 002b:00007ffd91b57128 EFLAGS: 00010287
RAX: 00007ffd91b57130 RBX: 00007ffd91b57130 RCX: 0000000000000000
RDX: 00000000000000e0 RSI: 0000000000000000 RDI: 00007ffd91b57130
RBP: 00007ffd91b57280 R08: 00000000000000e0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00000000000f4240 R14: 00000000000140b7 R15: 00007ffd91b57264
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 7a 52 8f 00       	call   0x8f5286
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


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

