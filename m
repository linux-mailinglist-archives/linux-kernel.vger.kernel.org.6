Return-Path: <linux-kernel+bounces-248224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76A92DA2B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA031F21B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E547198826;
	Wed, 10 Jul 2024 20:34:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920019149A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643663; cv=none; b=Ty8ZIiOEi4F8958eZOdddog1qZn4If93nPve9xKKFyFhAkCjRndcDn6qJabQ8X25JX9WjKpQ89sAcigfawY9qX8XFWCC+eXeXVk8fvN2i+ZEZGv3bH5iX+cdlR2rvq3IcYqZfPQvpVHM8nkjZrPTYGeGI4fAhbinFtYuBWkv5Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643663; c=relaxed/simple;
	bh=RQLqbBSNU/64kLZcztOA/JgzCZ/4yrGvjBp9Z6l1NiI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J3GH6jIJuSwjRpVwmhWq30Vygv6HsOSshH/jb2m9O6LrxdxMoXlxDQ2KZVMW7p2uuqBjvzVk7sDYrPr5L584KLW5zhaT8zPAJ4OyCO7qHfL93cssrHw8vs2pby6LyBBXL/tqEA+qfrxd4KjOKEzG54mx1UV5MDiioCwt81Lhntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-379c2ff145dso9711955ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720643660; x=1721248460;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CaYsTUVeQoEZr9Sv6phrW+uZllbnjOa27niNPQsqoA=;
        b=XX+ixtcFcseIxRsSn67v+07nRlR7Hmn4iIkVId8tsWubLkpITV64W7lqm1cHCXCSIl
         XBVe1Z1+CXK7p1uRML7L5jQjWx+gt+QJrmDnNozLy+pAot7tw5rTWxtMOS3hZDiXgI+D
         tw5McNfMlfgZZe0YrmAPLeW6St1//gW66EaHei3K7luJT7llvpW5J1EXr9VOUfB3mzWv
         q6KXT6m+lFS5iL4WnwtGiA2z9v16PtfndcYaCZaHNV3Jv7Ewb1RDpgSDHd28xcYvPrrJ
         dzoCYBIryY74tvjJn20p2j9FNLs8dmeZ1HKKtyHz0VXSEo6HkQrsEYAZeP0fZFDUgvkf
         /RGg==
X-Forwarded-Encrypted: i=1; AJvYcCU/HUjlkMoapk6ya/RQIgDa+5x25uwymjBihVl/zxdEV5wJ4m3qbuyM5NJRNFl/aqqAtW1thZ4VNFdYYhh7NAdn6aG0w0mhis6QjHPe
X-Gm-Message-State: AOJu0YwAyuai4/OUlzcwkiabqfuengFC0HE9bmEcRO7sSWGynE5GC7eW
	VBvgkDetJOAH/ISZJBbrWC6fK/ehhZ0o7wiHICMDAjWhSrN9KMeXDWx93DAulWXXojUh2hfo1Z8
	Ootxz1e87uWL5oZz0Bxx0Ek8q48VY5YNojvCUud3ArEMf2/1Cr0oLldo=
X-Google-Smtp-Source: AGHT+IESwCT7GslYc9Q2ekDpXiMHlGSVU+bI5oGteOdD4UpyrIXY2TWEE/QCuBZjLHqr8Jx0B+d2o5eTPxu4x0N/zfXYdrPOufnV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ad05:0:b0:381:f3bf:c5d2 with SMTP id
 e9e14a558f8ab-38d0bd1449bmr223095ab.3.1720643660506; Wed, 10 Jul 2024
 13:34:20 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:34:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b7de9061cea92b7@google.com>
Subject: [syzbot] [mm?] BUG: corrupted list in __folio_undo_large_rmappable
From: syzbot <syzbot+a2cc273ad0e5a4c15302@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    82d01fe6ee52 Add linux-next specific files for 20240709
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14904441980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95a20e7acf357998
dashboard link: https://syzkaller.appspot.com/bug?extid=a2cc273ad0e5a4c15302
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15882a49980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172aba49980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12dcacb06142/disk-82d01fe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ef954821378/vmlinux-82d01fe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ebf01d42887/bzImage-82d01fe6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2cc273ad0e5a4c15302@syzkaller.appspotmail.com

list_del corruption, ffffea0001eb8090->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5105 Comm: syz-executor331 Not tainted 6.10.0-rc7-next-20240709-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:__list_del_entry_valid_or_report+0xd0/0x140 lib/list_debug.c:52
Code: 06 e2 42 fd 48 8b 13 4c 39 fa 75 6b b0 01 5b 41 5c 41 5e 41 5f c3 cc cc cc cc 48 c7 c7 a0 9b 20 8c 4c 89 fe e8 71 e0 d7 06 90 <0f> 0b 48 c7 c7 00 9c 20 8c 4c 89 fe e8 5f e0 d7 06 90 0f 0b 48 c7
RSP: 0018:ffffc900034df410 EFLAGS: 00010046
RAX: 0000000000000033 RBX: ffff888140e81000 RCX: f885dda17ff31200
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffea0001eb8090 R08: ffffffff8173a779 R09: 1ffff9200069be1c
R10: dffffc0000000000 R11: fffff5200069be1d R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001eb8090
FS:  00007fe27183f6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200d1a00 CR3: 0000000021fbe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 __folio_undo_large_rmappable+0x104/0x230 mm/huge_memory.c:3289
 __folio_migrate_mapping+0x6c1/0x3490 mm/migrate.c:418
 __migrate_folio mm/migrate.c:693 [inline]
 migrate_folio+0x111/0x260 mm/migrate.c:720
 move_to_new_folio+0x306/0x12e0
 unmap_and_move_huge_page mm/migrate.c:1444 [inline]
 migrate_hugetlbs mm/migrate.c:1563 [inline]
 migrate_pages+0xb74/0x3460 mm/migrate.c:1960
 do_mbind mm/mempolicy.c:1388 [inline]
 kernel_mbind mm/mempolicy.c:1531 [inline]
 __do_sys_mbind mm/mempolicy.c:1605 [inline]
 __se_sys_mbind+0x1490/0x19f0 mm/mempolicy.c:1601
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe2718a4d39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe27183f208 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007fe27192f338 RCX: 00007fe2718a4d39
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000020199000
RBP: 00007fe27192f330 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe2718fc604
R13: 00007fe2718fc008 R14: 7277682f7665642f R15: 00000000ffffff1f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xd0/0x140 lib/list_debug.c:52
Code: 06 e2 42 fd 48 8b 13 4c 39 fa 75 6b b0 01 5b 41 5c 41 5e 41 5f c3 cc cc cc cc 48 c7 c7 a0 9b 20 8c 4c 89 fe e8 71 e0 d7 06 90 <0f> 0b 48 c7 c7 00 9c 20 8c 4c 89 fe e8 5f e0 d7 06 90 0f 0b 48 c7
RSP: 0018:ffffc900034df410 EFLAGS: 00010046
RAX: 0000000000000033 RBX: ffff888140e81000 RCX: f885dda17ff31200
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffea0001eb8090 R08: ffffffff8173a779 R09: 1ffff9200069be1c
R10: dffffc0000000000 R11: fffff5200069be1d R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001eb8090
FS:  00007fe27183f6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200d1a00 CR3: 0000000021fbe000 CR4: 00000000003506f0
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

