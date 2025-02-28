Return-Path: <linux-kernel+bounces-537889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B11A49225
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D84188D7FD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606AB1C726D;
	Fri, 28 Feb 2025 07:26:39 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278EA276D12
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727598; cv=none; b=bX50iA5NplqlHClTehNmdJ1eZ4LJyqi6jH9by4XBM2zOrO6PM0fYfxkLRNzoij/sqyprQCtUoFFbwK1ci5kGnVHj1qDJVHwGvxvFNvfGr01981rQ06I60lJf8c+edHzY/EDKbQ14C70i8G9TPkaMnFKYvMMpr/5mvgWTS/6Jivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727598; c=relaxed/simple;
	bh=Pv3qR/WBGTEu5D4Zzhqcs/yE+xj0lJ9dkRpMZLIRRbc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l3+1RKOJLiDAxyfH4JgcVG42M+X+T9e1VkVpR4W/FyCFlPAipu9a95IkRfA8LqAcHsrtGPHWjbOIDfnyV20jufuPnHvp5XjIHKkmtot4jvV2s8p/gin9R8wG+66cYVjzBDo4TPYeIlpFUMVse/u8lYqDtunPYXdxpJkvk307okI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2a60faa44so39557505ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740727596; x=1741332396;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XwPxgMwXBxwnScKeXU9LmUMc/8OGZ4f3QkBdwP/kOs=;
        b=dbuAT8pkyZ3xvLr+y5wm8UbbAohfDEGlO/rozgPqiQJ470H1D0+1tTJ/EKjiLNTkl0
         WvXEkdyQeB8NquyYxqjWHgNoDmgoIKJ9gJrcUBTD9tpkK6s4KTEi1CQcwjOwfYtA7RHb
         XKIwPD/LSL7u8Mu+VCblY/U9ziAI9U5Gx0UTatSGnUMqSp2kLgsrrWT3V5XvWkw5rtcD
         jIY2LzQUS9/t2pGWjArYNjpPUecnIsBOlAwqUO/GZC4dBwTVxlpjq4k2VYJf5J7Qxz7q
         QqwTNoMvpaxweByesCQGvRqF5G2BtHq2U5mrOUEycirVCTQa+9qkPRMTG0nc8U+oZrX8
         AEjA==
X-Forwarded-Encrypted: i=1; AJvYcCWE7eGD1QtOxepqD7HXLbBu5Rl8MBtJbcJw/mA40sGmEEfgMkLCghtnxbCaUjUsMTZ/GV2wwPN0/rEDK9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAOh/Dxp8hVcntXu5J8KhDY0COcR4zR4eq5gE+CWA3z7ruLNK
	PsFutUMurAcRPg5V7REq3e4wvm+bOyXwvHDlLKzpANoh69EqzGX2iBwn9kwO6t/xpaG6Cc3gKCu
	+7ApOr7AIM5D+YcgPekupQzRNAyqNCxM9x834qX26yuLuiRveJ7TWZ8o=
X-Google-Smtp-Source: AGHT+IF1N3B6h99XgGr74HWyjuwsL9CqMPdjrIOGL2+11DAJab2NQeS7/wfwC9s6Oxamy0oOKhblWpOuiSsxGepjjHI9Zb2omGXo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3d3:dcac:909c with SMTP id
 e9e14a558f8ab-3d3e6f99a88mr24843115ab.18.1740727596244; Thu, 27 Feb 2025
 23:26:36 -0800 (PST)
Date: Thu, 27 Feb 2025 23:26:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c1652c.050a0220.1baf.000d.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in filemap_fault
From: syzbot <syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156586e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=f37372d86207b3bb2941
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com

 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1424
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at mm/filemap.c:3478!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 9323 Comm: syz.5.597 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:filemap_fault+0x15b2/0x1620 mm/filemap.c:3478
Code: 49 c6 ff 4c 89 f7 48 c7 c6 e0 ed 33 8c e8 96 09 11 00 90 0f 0b e8 9e 49 c6 ff 4c 89 f7 48 c7 c6 60 e7 33 8c e8 7f 09 11 00 90 <0f> 0b e8 87 49 c6 ff 4c 89 f7 48 c7 c6 e0 ed 33 8c e8 68 09 11 00
RSP: 0018:ffffc900144d71c0 EFLAGS: 00010246
RAX: 183f9497d65b5500 RBX: ffffea0001228018 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c2a9d00 RDI: 0000000000000001
RBP: ffffc900144d7338 R08: ffffffff903da477 R09: 1ffffffff207b48e
R10: dffffc0000000000 R11: fffffbfff207b48f R12: ffffea0001228008
R13: ffff88807b6fc208 R14: ffffea0001228000 R15: dffffc0000000000
FS:  00007f654f9326c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f61a6653440 CR3: 0000000066368000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_fault+0x135/0x390 mm/memory.c:4978
 do_read_fault mm/memory.c:5393 [inline]
 do_fault mm/memory.c:5527 [inline]
 do_pte_missing mm/memory.c:4048 [inline]
 handle_pte_fault+0x3f07/0x61c0 mm/memory.c:5890
 __handle_mm_fault mm/memory.c:6033 [inline]
 handle_mm_fault+0x11ae/0x1cd0 mm/memory.c:6202
 faultin_page mm/gup.c:1196 [inline]
 __get_user_pages+0x1a8f/0x4140 mm/gup.c:1494
 populate_vma_page_range+0x264/0x330 mm/gup.c:1932
 __mm_populate+0x27a/0x460 mm/gup.c:2035
 mm_populate include/linux/mm.h:3467 [inline]
 vm_mmap_pgoff+0x303/0x430 mm/util.c:581
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:607
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f654eb8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f654f932038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f654eda6080 RCX: 00007f654eb8d169
RDX: 0000000000000002 RSI: 0000000000b36000 RDI: 0000400000000000
RBP: 00007f654ec0e2a0 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f654eda6080 R15: 00007ffc0d9602e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:filemap_fault+0x15b2/0x1620 mm/filemap.c:3478
Code: 49 c6 ff 4c 89 f7 48 c7 c6 e0 ed 33 8c e8 96 09 11 00 90 0f 0b e8 9e 49 c6 ff 4c 89 f7 48 c7 c6 60 e7 33 8c e8 7f 09 11 00 90 <0f> 0b e8 87 49 c6 ff 4c 89 f7 48 c7 c6 e0 ed 33 8c e8 68 09 11 00
RSP: 0018:ffffc900144d71c0 EFLAGS: 00010246
RAX: 183f9497d65b5500 RBX: ffffea0001228018 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c2a9d00 RDI: 0000000000000001
RBP: ffffc900144d7338 R08: ffffffff903da477 R09: 1ffffffff207b48e
R10: dffffc0000000000 R11: fffffbfff207b48f R12: ffffea0001228008
R13: ffff88807b6fc208 R14: ffffea0001228000 R15: dffffc0000000000
FS:  00007f654f9326c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcf53d4bc8 CR3: 0000000066368000 CR4: 00000000003526f0
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

