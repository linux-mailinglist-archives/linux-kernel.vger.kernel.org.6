Return-Path: <linux-kernel+bounces-230563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF5917EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6911728A4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41F1802DB;
	Wed, 26 Jun 2024 10:44:24 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130C17F38D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398663; cv=none; b=Tlg+EYoGBG8SW6lz+PUf1mVyDrdCLSxQ3QIPvzDxeO5t5sHLrrUQSpmLUGgWL3bYbTmYLFMEKWVgK0xf3z7Et07KzNksWVzVPJlxyxMkdKfubTQZuXByTTwffxXEyj8sR5lFtc2knuOnty/a3wxmqGbbPPeOiQEUEbD8YdjNZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398663; c=relaxed/simple;
	bh=K52ZKYW4LxJx3jZQJjUTcvv4AGVHnJr36PDvjhH55jc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qHcqa59TZ5K9Qd8yQUJha7izi16D/SG8OpOahbrap+ezIvDEcMCRnvvg0gB7ndckyGc2gBTT8OUAvljjR1ODqKucfoxDZaHqxVq9l3L+3IEvWBQpz8BY0QOOZEBSbPCUJF8ybmev2XqZDWyk11md5SaM5g9tmLzzKJCShxNzphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3737b3ae019so83790025ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398661; x=1720003461;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOnO1ZTNDPvvJs+AkqyLoYKe/Db3dQpJ5HKxLtBlyRE=;
        b=aWO4nZazzLOjZudp0v4dWFOvFOdw2eYs5gZUoWKAfcyjFT5nk9fDKXirnVEKx8wj0d
         ounE+ZXY2lmf2g7zLZxG1tObGVojpBVc1HqSD/xBkv0/heo5rvOtj2bQ/Aj2eIOl8RF2
         yAAekj0qOT5KkN41ffzAUzsecjAs93vh+GgGJSS6aAWZbSWASXcXhBDBM1WfbZODRumo
         GH9hbeA9HodPXZ0PTY2e9fdFPRGSIWhScNtpC5iA4KbF0mYdFDJ06SCvAGTNzyI7//cq
         Oxkb+whmKeflwb9bVLV8oHMuGGljswRzdTQobMrjtEEkLsxNPLHbOY9wdGOR7kTwhah9
         qbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2NPkCP9VlO7fd7dLzka+jSmtSgQIEsc6h0l4eRlubUB0awzQhE2oLgt7AR6rKIiSGu8upj4bPGUdgsEr7E5w66SUu+orYt7l2P2Bc
X-Gm-Message-State: AOJu0YxEREK3fu1BxKxkkkLOH6TV8cdQJVmm/PyMPN6rZA0nNC+KJwiO
	iCEeNRErrwBOuQMx/NXqAel0pXbRG1+0O+MGyRoA4GU7EQU5j5gHbfqPxLvJWjYpSpXC4e0SHAy
	t9lFucaWfPVkkdWYTSTAY6zIl8zFFqj97J1AK9VcUFGXDcTMJHwGtmQQ=
X-Google-Smtp-Source: AGHT+IFyFL0O5V0tG3U+JWBjb72BivY8NivTO/MOk5RpndV24uZJFn4rhHMjdTB69qeWCoiSIENbN4hRRjXTcefpgt0LtVQB+KEk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:374:a021:f1b2 with SMTP id
 e9e14a558f8ab-3763f7424b5mr7861035ab.5.1719398661393; Wed, 26 Jun 2024
 03:44:21 -0700 (PDT)
Date: Wed, 26 Jun 2024 03:44:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070a181061bc8b256@google.com>
Subject: [syzbot] [kernel?] kernel BUG in __jump_label_patch
From: syzbot <syzbot+03cfa0c5a0bcba3bf195@syzkaller.appspotmail.com>
To: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jbaron@akamai.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f76698bd9a8c Add linux-next specific files for 20240621
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=174ca546980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca79e3c3b9118bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=03cfa0c5a0bcba3bf195
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1053f741980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b7883e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f204c5d02251/disk-f76698bd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50289c7e8999/vmlinux-f76698bd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c360e133a94f/bzImage-f76698bd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03cfa0c5a0bcba3bf195@syzkaller.appspotmail.com

jump_label: Fatal kernel bug, unexpected op at preempt_notifier_register+0x10/0xe0 kernel/sched/core.c:4788 [ffffffff81639840] (eb 12 90 48 c7 != 66 90 0f 1f 00)) size:2 type:1
------------[ cut here ]------------
kernel BUG at arch/x86/kernel/jump_label.c:73!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 28186 Comm: syz-executor226 Not tainted 6.10.0-rc4-next-20240621-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:__jump_label_patch+0x463/0x490 arch/x86/kernel/jump_label.c:73
Code: e8 52 ae 5f 00 48 c7 c7 e0 41 c5 8b 48 8b 0c 24 48 89 ce 48 89 ca 4d 89 e8 4c 8b 4c 24 08 41 54 e8 a2 a1 56 0a 48 83 c4 08 90 <0f> 0b e8 96 9b 59 0a e8 21 ae 5f 00 90 0f 0b e8 19 ae 5f 00 90 0f
RSP: 0018:ffffc9000a7ff620 EFLAGS: 00010292
RAX: 0000000000000097 RBX: 0000000000000085 RCX: 1a06c80092f08800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000a7ff748 R08: ffffffff81739789 R09: 1ffff920014ffe60
R10: dffffc0000000000 R11: fffff520014ffe61 R12: 0000000000000001
R13: ffffffff8bc56001 R14: ffffffff929c38a0 R15: ffffffff8bc56001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558d6acce8 CR3: 000000002b0e8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_jump_label_transform_queue+0x68/0x100 arch/x86/kernel/jump_label.c:137
 __jump_label_update+0x177/0x3a0 kernel/jump_label.c:493
 __static_key_slow_dec_cpuslocked+0x250/0x410 kernel/jump_label.c:293
 __static_key_slow_dec kernel/jump_label.c:301 [inline]
 static_key_slow_dec+0x51/0xa0 kernel/jump_label.c:316
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1364 [inline]
 kvm_put_kvm+0xf3b/0x1300 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1388
 kvm_vm_release+0x46/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1411
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x28e0 kernel/exit.c:876
 do_group_exit+0x207/0x2c0 kernel/exit.c:1025
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6bcd95a559
Code: Unable to access opcode bytes at 0x7f6bcd95a52f.
RSP: 002b:00007f6bcd915228 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f6bcd9e4328 RCX: 00007f6bcd95a559
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f6bcd9e432c
RBP: 00007f6bcd9e4320 R08: 00007f6bcd9156c0 R09: 00007f6bcd9156c0
R10: 00007f6bcd9156c0 R11: 0000000000000246 R12: 00007f6bcd9e432c
R13: 00007f6bcd9b1074 R14: 6d766b2f7665642f R15: 00007ffd999e9ad8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__jump_label_patch+0x463/0x490 arch/x86/kernel/jump_label.c:73
Code: e8 52 ae 5f 00 48 c7 c7 e0 41 c5 8b 48 8b 0c 24 48 89 ce 48 89 ca 4d 89 e8 4c 8b 4c 24 08 41 54 e8 a2 a1 56 0a 48 83 c4 08 90 <0f> 0b e8 96 9b 59 0a e8 21 ae 5f 00 90 0f 0b e8 19 ae 5f 00 90 0f
RSP: 0018:ffffc9000a7ff620 EFLAGS: 00010292
RAX: 0000000000000097 RBX: 0000000000000085 RCX: 1a06c80092f08800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000a7ff748 R08: ffffffff81739789 R09: 1ffff920014ffe60
R10: dffffc0000000000 R11: fffff520014ffe61 R12: 0000000000000001
R13: ffffffff8bc56001 R14: ffffffff929c38a0 R15: ffffffff8bc56001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558d6acce8 CR3: 000000002b0e8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

