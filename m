Return-Path: <linux-kernel+bounces-198312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4B8D768C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637E51F22E49
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0D446A5;
	Sun,  2 Jun 2024 15:20:30 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33443AD7
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717341629; cv=none; b=hKsqLF0KQ6CD8G5F7+pTfZluLPFzwcUSXwbNz0YWDCDAvHq2Sdkqch2P3HyA72pWYKPt2ZwPxg1G58xu7o4OJai3FBPQTdXP33b+VDTFPOgxa5TQZhd50fty5KhOXlKBywZxw+n3IsGlRJfn7+wvxFBpWvkwm5eswUGfUDXWRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717341629; c=relaxed/simple;
	bh=bfcDyitL9JyfqB8mXXKBlA/fduvkTlxFm9ljvQIvmSM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hQL1BKodI8ze0xoCsuTwWQy7O0RdCOHZc9J1rWZX1bIdrqOYCmq8SQgWnkaghjrHH9jlEia2CuBqP3AyLuIPLSuSXkgkK4HVZ2ZzlmvOJDtu132yhfwneczxwJMNtXc4IIV5ZbR9oO7YVme5SujahPy2AjDiqTJ49WHkmwNBD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so441076339f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 08:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717341627; x=1717946427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hw/cyPAupwvO4MINMkPBsqJkF6/hIeFcTmJPzXQq1Do=;
        b=C05l3WgzGlYVmvN/3iNIqpnBCp4iIQJvhGxp9MFk7AfV+cQyo4nbyebPu+PoYqQTtb
         QOY22VWwJr2H7RgakJ6g0fpK0WY3O397eoNIUJjjoG2e2JDy/7CPbNoiz7QGGF8CGEQy
         bkwyFwHaeyKC9HbeDNOBLXKdnZMg4JZtj3p9VcaovlN0DMaEiEezkG/jYf4jeAfe3Tu4
         dlTOQQWlkb1PYCrD7Doa0zcBFgYIg6K2I1vFbIjGZqwoCfKR0qyB3mjcphgfnDtgLyuv
         ouSd5cM44kgzVK507xzn64EJrJ3RlAHLsdwPaTbnZ0fXKSZAq85goT1nJKWgI+SrnJjh
         OZng==
X-Forwarded-Encrypted: i=1; AJvYcCW7x7MiETQkGW51q6mJe/9SOK2z5vYNTBaw2k5wRaZ/zZVQqh8IiyNlzpcxpo9QhjVc8UJPzNJVwNGKAzZsliFDioHycLyLFkMXydbJ
X-Gm-Message-State: AOJu0YxhUj0Es0Hpg7/eAv1KyQTnVU95qZU/XImyKrYu03ZzTFpQy2iz
	on+3duJnfnyewLxCoNQdviPKhTHD/ae6Vz5AFVJ1Sjp9cyvn27z3t4faNFlOC+G/iQ2CpuePl2m
	nAlM3nl9TdZsdujrHYcOoABcf84mLdjBmwIJ4MYE3qp9OcOJkXYYFwwY=
X-Google-Smtp-Source: AGHT+IHd92VAlVj+z+iI/KFR1SzU+VGcumWPp6hLiCgVHVAIF5pNtBDDQHRBeclbXF0on5pzu7uV4if77NSYqnzuGFClJmnwabrr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc8:b0:7ea:ff9a:8420 with SMTP id
 ca18e2360f4ac-7eafff5276emr48801439f.3.1717341627358; Sun, 02 Jun 2024
 08:20:27 -0700 (PDT)
Date: Sun, 02 Jun 2024 08:20:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a82e6e0619e9c192@google.com>
Subject: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: airlied@redhat.com, akpm@linux-foundation.org, brauner@kernel.org, 
	jack@suse.cz, kraxel@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0e1980c40b6e Add linux-next specific files for 20240531
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ac4616980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=b2cfdac9ae5278d4b621
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f01564980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14484aba980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44fb1d8b5978/disk-0e1980c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a66ce5caf0b2/vmlinux-0e1980c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8992fc8fe046/bzImage-0e1980c4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8530480d64fb/mount_0.gz

The issue was bisected to:

commit 344a1d8575b05298d0702a9f9231e57db86a855e
Author: Vivek Kasireddy <vivek.kasireddy@intel.com>
Date:   Thu Apr 11 06:59:42 2024 +0000

    udmabuf: convert udmabuf driver to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153a7026980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=173a7026980000
console output: https://syzkaller.appspot.com/x/log.txt?x=133a7026980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com
Fixes: 344a1d8575b0 ("udmabuf: convert udmabuf driver to use folios")

VFS: Close: file count is 0 (f_op=shmem_file_operations)
------------[ cut here ]------------
kernel BUG at fs/open.c:1514!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5089 Comm: syz-executor317 Not tainted 6.10.0-rc1-next-20240531-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:filp_flush+0x152/0x160 fs/open.c:1512
Code: e9 80 e1 07 80 c1 03 38 c1 7c a6 48 89 ef e8 c5 03 f0 ff eb 9c e8 6e 16 8a ff 48 c7 c7 20 59 d8 8b 48 89 ee e8 6f 84 7d 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900033bfc80 EFLAGS: 00010246
RAX: 0000000000000038 RBX: 0000000000000000 RCX: fe0d96255f7cdc00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffffff8bd42dc0 R08: ffffffff8176b129 R09: 1ffff92000677f2c
R10: dffffc0000000000 R11: fffff52000677f2d R12: ffff8880784d9680
R13: dffffc0000000000 R14: ffff88807aa761c0 R15: 0000000000000009
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000003f3be538 CR3: 000000007f062000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filp_close+0x1e/0x40 fs/open.c:1532
 close_files fs/file.c:437 [inline]
 put_files_struct+0x1b6/0x360 fs/file.c:452
 do_exit+0xa08/0x28e0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 __do_sys_exit_group kernel/exit.c:1034 [inline]
 __se_sys_exit_group kernel/exit.c:1032 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc324e0fd09
Code: Unable to access opcode bytes at 0x7fc324e0fcdf.
RSP: 002b:00007fffe9a711b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc324e0fd09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fc324e8b2d0 R08: ffffffffffffffb8 R09: 0000555580c204c0
R10: 0000555580c204c0 R11: 0000000000000246 R12: 00007fc324e8b2d0
R13: 0000000000000000 R14: 00007fc324e8c040 R15: 00007fc324dddf00
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:filp_flush+0x152/0x160 fs/open.c:1512
Code: e9 80 e1 07 80 c1 03 38 c1 7c a6 48 89 ef e8 c5 03 f0 ff eb 9c e8 6e 16 8a ff 48 c7 c7 20 59 d8 8b 48 89 ee e8 6f 84 7d 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900033bfc80 EFLAGS: 00010246
RAX: 0000000000000038 RBX: 0000000000000000 RCX: fe0d96255f7cdc00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffffff8bd42dc0 R08: ffffffff8176b129 R09: 1ffff92000677f2c
R10: dffffc0000000000 R11: fffff52000677f2d R12: ffff8880784d9680
R13: dffffc0000000000 R14: ffff88807aa761c0 R15: 0000000000000009
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000003f3be538 CR3: 000000007f062000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

