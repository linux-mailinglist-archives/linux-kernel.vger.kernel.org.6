Return-Path: <linux-kernel+bounces-540135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E69A4AE25
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 23:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35003B212F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98E1D5178;
	Sat,  1 Mar 2025 22:41:23 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694CE1C3BEB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740868883; cv=none; b=k9Nzd4OxqUP6+ihee6I7zCqYy+vrwerV/MTplqlk+Uv5MRBbdAEzqzOMc7W+L2S2Ny/7gi9FNJ3kxWrFFrtgrz/JEdrlVdQ3AKO1ZH4kpSy6KefKOCEN8Sofk9/Luhadf1PpbDi2rjdikrhjll0x5ooF4adqgQDuefCaoNCccIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740868883; c=relaxed/simple;
	bh=vDcEx24vqT0AfT7EG5VwgT7BG9mHvImBOsL7mxNPtek=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EtPGQknMjndcItB3apvAPikzIIyHMoDCI7cwFt1juTtwq2eChGGb/FNW7ePse9sOpeJI/+/+/V3TdLgo1djrXrUt6qdYUjHzu3nqne33T/D+OKVdrJj1NNfpL7bcScokYgub3grh5g8tX9rPykVkKzb+QIQQivii+sh0uiJFVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d3dee8d31aso24257385ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 14:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740868880; x=1741473680;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9B8/zfMdfkQ3k3aRblXLcyzbx8Oe8hfPyvYJjlHdxjI=;
        b=UawAbbVkE2SyzjSEBJlfdDzjliZNhi8pKnwo+d3Wrq+8vyzzautLfU5D9dthbi4V6Z
         Q/BwplLKoJR1/KhiQoF6zTqbVVF4Y1s58THF0oQ83n9rLJ2faaLHUm3i7oatNmRvJfoZ
         u08IGvX6gKS6uYaXqIBZiOXlPmHUDLRTXjn3iOGEY6iCrYqj1sNKk5hGWT12GJHNkp7Z
         AlozMjRLRi4YR9Eri4YobOEGY2xqMLVCGcqmkfLolEapqLqv7Syg9hS2isec3NYB6Kz0
         y9c+UA6/vhaI89mfuRYLryEOVEkQSVyS9ohC33RExCirhUKGLLexdE3NEun3Ye4lnKTU
         S5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW21vnstcDCfk9CpHChfRHxmeV9Clc2fiTNyvKNP4nKWr0/M55P5XIH3+ItxZ7E5mm6W0yd4IeGLvxJaaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSde1nlBIs7WiWteT9aiKeNazGVsuz4+zaXPLkOFA3qvhVghJ
	2DvQlIc+2PMT8DM1jhR+1ziKW50in91bZzL079fQZS0iETY2VMDV5Nh6JwuVR1AbePP2h/70cg7
	M+ckglLzX+75bKW1vmUtCOXbH+CoEdvkyR90T3GNFicDn6CevOb3BKHM=
X-Google-Smtp-Source: AGHT+IGernXN8o0yiyimwGLP8P9VkFk7znEzFCjP/2TLuJpSZZsWVTckg5VvKTIFDLSltwaFPURlG6Gm0kj7IQhspUGegLHOrK3b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:3d3:ced4:db9b with SMTP id
 e9e14a558f8ab-3d3e6e22d00mr92491635ab.5.1740868880588; Sat, 01 Mar 2025
 14:41:20 -0800 (PST)
Date: Sat, 01 Mar 2025 14:41:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c38d10.050a0220.dc10f.016d.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in try_to_unmap_one
From: syzbot <syzbot+fb86166504f57eff29d7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12faf7f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=fb86166504f57eff29d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb86166504f57eff29d7@syzkaller.appspotmail.com

 evict+0x4e8/0x9a0 fs/inode.c:806
 __dentry_kill+0x20d/0x630 fs/dcache.c:660
 dput+0x19f/0x2b0 fs/dcache.c:902
 __fput+0x60b/0x9f0 fs/file_table.c:472
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at mm/rmap.c:1858!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 6053 Comm: syz.4.27 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:try_to_unmap_one+0x3d0d/0x3fa0 mm/rmap.c:1858
Code: c7 c7 80 93 c3 8e 48 89 da e8 ef f3 19 03 e9 68 ca ff ff e8 b5 12 ab ff 48 8b 7c 24 20 48 c7 c6 80 17 36 8c e8 94 d2 f5 ff 90 <0f> 0b e8 9c 12 ab ff 48 8b 7c 24 18 48 c7 c6 40 1c 36 8c e8 7b d2
RSP: 0018:ffffc9000b1be9c0 EFLAGS: 00010246
RAX: 367eb4645686ad00 RBX: 00000000f4000000 RCX: ffffc9000b1be503
RDX: 0000000000000004 RSI: ffffffff8c2aaf60 RDI: ffffffff8c8156e0
RBP: ffffc9000b1bedf0 R08: ffffffff903da477 R09: 1ffffffff207b48e
R10: dffffc0000000000 R11: fffffbfff207b48f R12: 8000000053c008e7
R13: dffffc0000000000 R14: ffffea00014f0000 R15: ffffea00014f0030
FS:  00007f4d2783e6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c465fa1 CR3: 000000002a1f6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __rmap_walk_file+0x420/0x5f0 mm/rmap.c:2774
 try_to_unmap+0x219/0x2e0
 unmap_folio+0x183/0x1f0 mm/huge_memory.c:3053
 __folio_split+0x849/0x16d0 mm/huge_memory.c:3696
 truncate_inode_partial_folio+0x9b1/0xdc0 mm/truncate.c:234
 shmem_undo_range+0x82f/0x1820 mm/shmem.c:1143
 shmem_truncate_range mm/shmem.c:1237 [inline]
 shmem_fallocate+0x431/0xf20 mm/shmem.c:3663
 vfs_fallocate+0x623/0x7a0 fs/open.c:338
 madvise_remove mm/madvise.c:1034 [inline]
 madvise_vma_behavior mm/madvise.c:1263 [inline]
 madvise_walk_vmas mm/madvise.c:1505 [inline]
 madvise_do_behavior+0x1ec6/0x3b90 mm/madvise.c:1657
 do_madvise mm/madvise.c:1755 [inline]
 __do_sys_madvise mm/madvise.c:1763 [inline]
 __se_sys_madvise mm/madvise.c:1761 [inline]
 __x64_sys_madvise+0x11b/0x140 mm/madvise.c:1761
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d2698d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4d2783e038 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f4d26ba5fa0 RCX: 00007f4d2698d169
RDX: 0000000000000009 RSI: 0000000000040000 RDI: 00004000001c1000
RBP: 00007f4d26a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4d26ba5fa0 R15: 00007ffda9fdc678
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:try_to_unmap_one+0x3d0d/0x3fa0 mm/rmap.c:1858
Code: c7 c7 80 93 c3 8e 48 89 da e8 ef f3 19 03 e9 68 ca ff ff e8 b5 12 ab ff 48 8b 7c 24 20 48 c7 c6 80 17 36 8c e8 94 d2 f5 ff 90 <0f> 0b e8 9c 12 ab ff 48 8b 7c 24 18 48 c7 c6 40 1c 36 8c e8 7b d2
RSP: 0018:ffffc9000b1be9c0 EFLAGS: 00010246
RAX: 367eb4645686ad00 RBX: 00000000f4000000 RCX: ffffc9000b1be503
RDX: 0000000000000004 RSI: ffffffff8c2aaf60 RDI: ffffffff8c8156e0
RBP: ffffc9000b1bedf0 R08: ffffffff903da477 R09: 1ffffffff207b48e
R10: dffffc0000000000 R11: fffffbfff207b48f R12: 8000000053c008e7
R13: dffffc0000000000 R14: ffffea00014f0000 R15: ffffea00014f0030
FS:  00007f4d2783e6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c465fa1 CR3: 000000002a1f6000 CR4: 00000000003526f0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

