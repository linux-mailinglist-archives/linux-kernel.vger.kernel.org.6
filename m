Return-Path: <linux-kernel+bounces-576291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB43A70D85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3973B6FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0FB25DCFA;
	Tue, 25 Mar 2025 23:15:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD681B4247
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944527; cv=none; b=j7aMvRwvOMBd1l8P9gZDaMSeWvwMlmUIyTalR1I5sKD+hpUPE7Qbr1xv13JqwkbmKQofmYJ6uCi+UMzBfx6MSS3vV4UXAVoj8Om/nyLHaLn0S4vLVvPReQHS7MmRsHSEU4jddIjHlVl9tWOcRG4Pw6v8C+XByouo9aDVNsrj5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944527; c=relaxed/simple;
	bh=ZKJSymgM1gpV9lZ02aHKvMGYhn7mgvmpPt2UI1o9r6E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CiGjpDKihEgNVfRKb+toMMd4pxVom0WHYhK4k+qGfXzzOAR+Cwv3IwwuZV2sqjyYzYKLdwuzOy6+xUMmLv49of3GqtEDU7rvvQMoKdD8knF+9toNqtUc/ID5wSXRkrbZIiehsauRWwYTDWJnAZ7WMv3OXNnwiOpcIpDE44D/JgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d453d367a0so126770845ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944525; x=1743549325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcNhfYX8DYDWCLTvbWQ366FzPUFPeaECk8xLDsoNIKU=;
        b=EUmw1UlXXNyI19qLzo2oxpYjTmGMtNF65xWuhkVVGG5yqw8rliVGNHDznnh9pHeqrJ
         M/zFutX3z9bixVIA2lMOEvG6Sxylr/XJnjVIeo2rctGHWy8y0pRPcaDjmC6cr/30hrT/
         PBEmyuqp1ctU1PV0n7YZN18i3VSrCVbQTfWV6rgRCWSLa8+5afninTMdwr3tBkAG1e4R
         geMolDxhxCTaSaFweFLi8epobaUmnvkqNZ/0DB4Sz328MZJeqIm78t6BQHgX7Uzx09lP
         QynEGcZok+53+6iXtIi2QQJgSd3EJimcRzK4UjiE1RxQMxfikKECSk+cBYpiVzhfa7Fp
         Ckuw==
X-Forwarded-Encrypted: i=1; AJvYcCWcPeNTethSWOm7/Ib+FyvGfaXUDBrXGkIxqDgJMazU6wjxmYUmEjzSw1tGo1PqHufF+XuXwnRdPhgVU8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YweXoLJOC2f+txG0V6UMVbQ2LVU4uePN7MtfTwrRkuU9k32LAhf
	9FzUsQsTVhfPr6i8uQ0ZLGRQMLNsLGoDj5xLHi1czy3uAUo5i4+4VPdgBtaqb7cZbKXwNpkuycL
	QNWlgpIzbwxKeqp65ljZELIWvHIixYivF6ei87ZhVsiZJU2ORqlzG64o=
X-Google-Smtp-Source: AGHT+IEVOI/b+UjVs7AqWXi2J6e1BP34OFe8JlkcPWJvlW25nHsSR44X3PkcDxU6UZf6ui41zMJ/Wrw8R8U7cfG4MzS6WCABbAt+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c263:0:b0:3cf:c773:6992 with SMTP id
 e9e14a558f8ab-3d59611acdbmr217588175ab.12.1742944524650; Tue, 25 Mar 2025
 16:15:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 16:15:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e3390c.050a0220.1ec46.0001.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in try_to_migrate_one /
 vms_clear_ptes (2)
From: syzbot <syzbot+93107467480b9f9ed726@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3ba7dfb8da62 Merge tag 'rcu-next-v6.15' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14254198580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f1cf4142160c34
dashboard link: https://syzkaller.appspot.com/bug?extid=93107467480b9f9ed726
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dd40b872cca9/disk-3ba7dfb8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86a3a241fb7d/vmlinux-3ba7dfb8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ce46917915c/bzImage-3ba7dfb8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93107467480b9f9ed726@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in try_to_migrate_one / vms_clear_ptes

write to 0xffff88810005d8f8 of 8 bytes by task 8860 on cpu 1:
 update_hiwater_rss include/linux/mm.h:2675 [inline]
 vms_clear_ptes+0x1a2/0x300 mm/vma.c:1136
 vms_complete_munmap_vmas+0x17b/0x480 mm/vma.c:1186
 do_vmi_align_munmap+0x344/0x390 mm/vma.c:1445
 do_vmi_munmap+0x1eb/0x230 mm/vma.c:1493
 __vm_munmap+0x19a/0x280 mm/vma.c:2956
 __do_sys_munmap mm/mmap.c:1084 [inline]
 __se_sys_munmap mm/mmap.c:1081 [inline]
 __x64_sys_munmap+0x36/0x40 mm/mmap.c:1081
 x64_sys_call+0xe1b/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:12
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810005d8f8 of 8 bytes by task 8858 on cpu 0:
 update_hiwater_rss include/linux/mm.h:2674 [inline]
 try_to_migrate_one+0x775/0x12e0 mm/rmap.c:2183
 rmap_walk_anon+0x28f/0x440 mm/rmap.c:2646
 try_to_migrate+0x11f/0x150
 migrate_folio_unmap mm/migrate.c:1318 [inline]
 migrate_pages_batch+0x786/0x1930 mm/migrate.c:1864
 migrate_pages_sync mm/migrate.c:1987 [inline]
 migrate_pages+0xf02/0x1840 mm/migrate.c:2096
 do_mbind mm/mempolicy.c:1425 [inline]
 kernel_mbind mm/mempolicy.c:1568 [inline]
 __do_sys_mbind mm/mempolicy.c:1642 [inline]
 __se_sys_mbind+0xfd1/0x11c0 mm/mempolicy.c:1638
 __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1638
 x64_sys_call+0x13be/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:238
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000001f8f -> 0x000000000000262f

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 8858 Comm: syz.2.1483 Tainted: G        W          6.14.0-syzkaller-00685-g3ba7dfb8da62 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
==================================================================


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

