Return-Path: <linux-kernel+bounces-449138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65309F4A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCE616D8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E6A1F131C;
	Tue, 17 Dec 2024 11:56:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990701F1308
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436589; cv=none; b=SNIl/YiM+fu37/tn6GFvK2K1w3tTHAAaApUU9kcSsbI0g2/bTk4+GwkaB2CD/P/FW+LwewqNKTE5zQL7ap+2O37amIZe5EUrF9Ck7QYYBtzBXRl/B4x6KeH9WkCOYz4sLDPJ448z/kf5nkISgcl7gQvI1MCstKJ8WG5qQxJl6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436589; c=relaxed/simple;
	bh=5hZe+P6oo66jzrzq+rFGDC7o7eRsEGDDwl+Pd0KU7jg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bvOjSZT6ii6hVmFLijsnXBQNNZKKAYsMrs+na54MsH563XxLehnN0lky0rMTZNiSh8t8HW0iI3njdKRYCZeP0eh1bF+wJDFMZO76zT2R1TDvzfHTMVNDTkQLmBux5ac7YvvVb3SmxUf7aH9Wu0bVZi3me+ZspoSKqi2azrvxh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9cd0b54c1so55244575ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436586; x=1735041386;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zlkkrQiCZExvjqP+weAj44cHCo/kJFfLp/BEKnWeR9I=;
        b=mc0A1FGt310PGzIaGjwYaYzfHrkhm1+TpqvLaXPeaeL4WLG+FAkGzpOsn+tu6GO8Cm
         iNDkapC4vf7ARhITh86BkNoErdIiCeEjdeV2PXnXl8kWh35nbD/IGeAionJCI+oM+TIM
         Uiw/V1TitFkpPfEkiPegmO0b7eEabJEcQd/Q4p4ZbFn9D3y84M+NB8eqIwwYBs5tEupp
         rApkNCUOiUE0Bvqwi2WETQtVh2Czu0nlZ8Fpho39bjaMXter0OryK2GxMHP8ra1G6wgr
         baNNzlKAEes61IqnHsTs80Hqv9M1tPklMo8hFim8VacAbTyGrMqs7FTvWENOmz1y5d6d
         jBlw==
X-Gm-Message-State: AOJu0Yx2cNvhhbnptdyZgDIkEY1yxHQ9AuyjxHmfOjD0TN3Mj40Mzof7
	E6smCuMWOOg2BLP6DvnuD+aFsbyrC+oS9zk5cpqQ7DsSg7VXwRxalFUAwRiduPibkgMVKn8el3m
	l84oxkQn2poIf9wV4rxJob6gAyQk4xO+U+wcwqCEuEf4PiYRewhhoKwbYbA==
X-Google-Smtp-Source: AGHT+IEoYsiy3il0PRPN/8uQITzOGRYXbiiXnB+uwNY8qFT+cH6OwCh/YBqSUAH1zHwFVwQhFLCBFrNWIypuvrkmTqyVMoxRj4rZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cf:b0:3a7:6566:1e8f with SMTP id
 e9e14a558f8ab-3aff243f4f3mr146334115ab.16.1734436586706; Tue, 17 Dec 2024
 03:56:26 -0800 (PST)
Date: Tue, 17 Dec 2024 03:56:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676166ea.050a0220.37aaf.0174.GAE@google.com>
Subject: [syzbot] [trace?] kernel BUG in ring_buffer_map
From: syzbot <syzbot+b565bf4a6ba3a0fc072c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78d4f34e2115 Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10840b44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cac7e24ceea492
dashboard link: https://syzkaller.appspot.com/bug?extid=b565bf4a6ba3a0fc072c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120334f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a19730580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2cc4d7ad894c/disk-78d4f34e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d726c69c5750/vmlinux-78d4f34e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/514b5ee15ec5/bzImage-78d4f34e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b565bf4a6ba3a0fc072c@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5838 Comm: syz-executor194 Not tainted 6.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__phys_addr+0xd8/0x150 arch/x86/mm/physaddr.c:28
Code: 48 d3 e8 48 89 c5 48 89 c6 e8 c4 c7 4e 00 48 85 ed 75 11 e8 4a c5 4e 00 48 89 d8 5b 5d 41 5c c3 cc cc cc cc e8 39 c5 4e 00 90 <0f> 0b e8 31 c5 4e 00 48 c7 c0 10 80 ba 8d 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003d77770 EFLAGS: 00010293
RAX: 0000000000000000 RBX: f8f97078f8f8f8f8 RCX: ffffffff814a8930
RDX: ffff888079ed9e00 RSI: ffffffff814a89b7 RDI: 0000000000000006
RBP: f8f8f8f978f8f8f8 R08: 0000000000000006 R09: f8f8f8f978f8f8f8
R10: f8f97078f8f8f8f8 R11: ffffffff81fb8dda R12: 0000000000000000
R13: ffff888076006308 R14: 0000000000000003 R15: 0000000000000001
FS:  00007f203d1b16c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f26faf8bf8 CR3: 00000000324ec000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __rb_map_vma+0x5b3/0xae0 kernel/trace/ring_buffer.c:7058
 ring_buffer_map+0x56e/0x9b0 kernel/trace/ring_buffer.c:7138
 tracing_buffers_mmap+0xa6/0x120 kernel/trace/trace.c:8482
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x1786/0x2670 mm/vma.c:2456
 mmap_region+0x127/0x320 mm/mmap.c:1348
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f203d1fecb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f203d1b1228 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f203d2823c8 RCX: 00007f203d1fecb9
RDX: 0000000000000001 RSI: 000000000000401f RDI: 0000000020ffc000
RBP: 00007f203d2823c0 R08: 0000000000000003 R09: 0000000001000000
R10: 000000000008e051 R11: 0000000000000246 R12: 00007f203d2823cc
R13: 0000000000000000 R14: 00007ffc95e2dbc0 R15: 00007ffc95e2dca8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0xd8/0x150 arch/x86/mm/physaddr.c:28
Code: 48 d3 e8 48 89 c5 48 89 c6 e8 c4 c7 4e 00 48 85 ed 75 11 e8 4a c5 4e 00 48 89 d8 5b 5d 41 5c c3 cc cc cc cc e8 39 c5 4e 00 90 <0f> 0b e8 31 c5 4e 00 48 c7 c0 10 80 ba 8d 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003d77770 EFLAGS: 00010293
RAX: 0000000000000000 RBX: f8f97078f8f8f8f8 RCX: ffffffff814a8930
RDX: ffff888079ed9e00 RSI: ffffffff814a89b7 RDI: 0000000000000006
RBP: f8f8f8f978f8f8f8 R08: 0000000000000006 R09: f8f8f8f978f8f8f8
R10: f8f97078f8f8f8f8 R11: ffffffff81fb8dda R12: 0000000000000000
R13: ffff888076006308 R14: 0000000000000003 R15: 0000000000000001
FS:  00007f203d1b16c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f203d24e008 CR3: 00000000324ec000 CR4: 00000000003526f0
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

