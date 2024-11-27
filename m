Return-Path: <linux-kernel+bounces-423080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FC69DA282
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADE7283974
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ACE1487E1;
	Wed, 27 Nov 2024 06:53:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9113BAE4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690408; cv=none; b=f1NsTTpTEEUIMV1H3SAB0cbfAWOW19Wia1TbMQJL9UWJPu7wHjdjmLhtD2V89ZmaOnQsZq9cX9pxo8H9Sshw9RPNkjT22Hv+j8BhuV12lGAsXrZHOReUKHkWtl/5J24sGsC73xfYLqFwPz+QgSkBjNGwh2rAB8MFockUXzp8T7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690408; c=relaxed/simple;
	bh=dPM4yL3SLQDlfkv8fU7NiS6F3W5AuAaTDxV64BN5MIk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lK64gsKXp+l7moNBB23Nrg4wVBrPTbhF/mrJ/P8E/rrRXzS2juwj3zcLzVLGc2L0mryOBe6m/CSKY85tDUQnozMGYd+k3wLZKTFO8pZzqweedel2F9aLTojoqt8bTnA3rRwwCGSmqcZI0sp85pZGozUfyUvsWyK8c9QlAFIQk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7c729bfbaso3005315ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732690405; x=1733295205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uR1DmXSxy/oOhcoxolUVLhBz85Ktc/N225g4+AbElMM=;
        b=DkUiGl2ZnySz9Sc+FHGq5DD6+qIo7PmRJvgO1Pc0yUUh9hdQ1sZTJ56Lwo3cCZX67b
         iaZwuDF4pxY7m+W9e1GLG95gorTpmc2Obxa2CtHp3EYqZ2kapVBQXbUOOLKeVeydt3BA
         KqxYebx5wR73kmcyxc8avSY5oi5yXNMSMukNJDeDJavkAtWiJETr5nE/Ian9jS666bgn
         Nzud3aZQsO+jfDVEh03jyEOu+CG6/Gt5fHWuNGov2dvwsbZUYzz7Z/y5wkgHpX+lUHHZ
         aru0ZU9lOJor9U3qjV6sMoezDWpstsQlDNAlHd5eBAB2Ku+JW99k9XltBBtVqk2Ss5KO
         CPeQ==
X-Gm-Message-State: AOJu0YybkuKsVP541TmvVS8AdUVeYRF7Ly4wBvzP+lvvRknU8kK4+TLo
	AorPKAknyAQAtKkwNO+j+zmWOUlwxxOKCRypyjeL76mvWhCDfryDLcTc/M0qxPbUode8TepGB1n
	IsTVbvrdQg6gZBYFcmYg/hfgwR4Tj1McNYRQFl+t8QUQ/0rncXMDc+YU=
X-Google-Smtp-Source: AGHT+IHvtI8ntuzoL09z0xAubUI0T4ojMMKrX2ffu/OEEIlRIpOrbEpG/f1sLbi5ZecwBTLFhsJn++M1JqjpmPoYwogr4z/K9svL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c547:0:b0:3a7:6c5c:9aa4 with SMTP id
 e9e14a558f8ab-3a7c5564e30mr21351925ab.12.1732690405404; Tue, 26 Nov 2024
 22:53:25 -0800 (PST)
Date: Tue, 26 Nov 2024 22:53:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746c1e5.050a0220.1286eb.002a.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in sched_core_lock (2)
From: syzbot <syzbot+37a95c05fafd621ecf0c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ff175f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b76860fd16c857
dashboard link: https://syzkaller.appspot.com/bug?extid=37a95c05fafd621ecf0c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/112cedff0255/disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f65020d28328/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fb4cb7df5b1/bzImage-06afb0f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37a95c05fafd621ecf0c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 13420 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 13420 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4850 [inline]
WARNING: CPU: 0 PID: 13420 at kernel/locking/lockdep.c:232 __lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Modules linked in:
CPU: 0 UID: 0 PID: 13420 Comm: syz.7.1623 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4850 [inline]
RIP: 0010:__lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Code: 00 00 83 3d 11 c9 ac 0e 00 75 23 90 48 c7 c7 80 d1 0a 8c 48 c7 c6 80 d4 0a 8c e8 77 64 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90003d7f2d0 EFLAGS: 00010046
RAX: 4215103f8b5df600 RBX: 00000000000010d8 RCX: 0000000000080000
RDX: dffffc0000000000 RSI: 000000000000957f RDI: 0000000000009580
RBP: 00000000000c10d8 R08: ffffffff8155fe42 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff8880359028c4
R13: 000000000000000f R14: 1ffff11006b2052f R15: ffff888035902978
FS:  00007f6b83fff6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f45936a0d58 CR3: 000000005dcb4000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 sched_core_lock+0x162/0x240 kernel/sched/core.c:374
 __sched_core_flip+0x176/0x440 kernel/sched/core.c:401
 __sched_core_enable kernel/sched/core.c:438 [inline]
 sched_core_get+0xbd/0x180 kernel/sched/core.c:456
 sched_core_alloc_cookie+0x71/0xa0 kernel/sched/core_sched.c:18
 sched_core_share_pid+0x298/0x7d0 kernel/sched/core_sched.c:185
 __do_sys_prctl kernel/sys.c:2741 [inline]
 __se_sys_prctl+0x956/0x3b50 kernel/sys.c:2467
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6b8317e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6b83fff038 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 00007f6b83335fa0 RCX: 00007f6b8317e819
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000003e
RBP: 00007f6b831f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6b83335fa0 R15: 00007fffd307ecc8
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

