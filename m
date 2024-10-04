Return-Path: <linux-kernel+bounces-350651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B445C9907C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B7028896A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B540219483;
	Fri,  4 Oct 2024 15:31:31 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EB1C728D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055890; cv=none; b=RQvbMRVpsvxYC5x6k3bK6ljmin7Amm0F9Fxox4hfadDzdrwrrW8A0SJAzic/tqpK0OrWnBhiKCnz/ohzCD+HXswUH7F0AIa3SYvXumECGAgt8/AsJxVP7oOt7lizgKGjj6GW2qJFLah8MFB0hO5QsiGGiwL8r91AfTeVEvpNstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055890; c=relaxed/simple;
	bh=J6VxOPQ3yJ6pzuGqghBFVlsBvc1MZIIqVbieS5Xlc6k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VKny2NpqLIa4JxCCyAS+IXMKIqHKxSp5vfvOssU720As7Dw383jrj9PoApluJjcNgumZ0JNAfYL7a6p9cjSRrzfaHNJ7MQO0+AwSxdtdIkPVRoaHcn31NX4sSsj0zpwqAI9zC0vvTzarjm+k9t+wYclFjWv+GHRTZmXITgdYPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a364acbd2eso22437345ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 08:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728055888; x=1728660688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbla0eHaAdJ6mpRqRRvSS7o67NpRjr2UUX0/SHYJaKc=;
        b=BQD+dBnqkCrjkjTenM5K7OYAbrmliVgykpYPRsV/tLs7rYCMfbGFz3pmGjDV62rDEh
         gjkw0svU62sQoM1zOX8YPwX6QNxIoy2JEsO8CjslXls5gwYFCPgw8kKp1/knAUA/5CiK
         j/249t8/kusMV8VleoKu7h8lZyYeVnbGKvtNn2KH9PxQypEUsoP2WNUAJjoJz4s4YrLM
         UZH5YEsrFIjdcyeqOgjU2/5sSpHI6GLJYtFsW7risvT4b6kEXHBIEdDft2PUnYT2SAXX
         EQ+dEnL5n677+9xTBNnX3aXhzLM7ZogSlsPBpDEwfAADFocLy9CLUWanSRRnp/00wQFu
         kXHg==
X-Forwarded-Encrypted: i=1; AJvYcCVS8gas2UjvHeqnbfQJa/3TWf4TIa+MsXhZ1TGz6JP6fZCZpG7peMsMid2YBA+vEAVYouoMsiUQALO6Ku4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2DyXG+h9Lifp59wOHwoRdQ4fFBZLkYFv0TvcL7XTWjUcVZWFw
	mH+TO0lbhDzo8KulbEN3mxtmUxlD+/R5478ww1oKQuF96NkNm5yyR7HEwquLAsOhIXrk+hAAkE9
	aRzFtwxpCIkkE3oX9htMk7woWP8O8peblD8PlncFni1qx0R3b7ffpnkk=
X-Google-Smtp-Source: AGHT+IHrvnriS81w0JuOxC/SjA0QT12vE6vWCuwAdxqr7zsO6IgFLkhuRo1pu5jffmMpYWAKGuwUyLphP4n6CY//BnhGuTtjGOLw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4d:b0:3a2:5b:7065 with SMTP id
 e9e14a558f8ab-3a375bb2a47mr31591525ab.18.1728055888266; Fri, 04 Oct 2024
 08:31:28 -0700 (PDT)
Date: Fri, 04 Oct 2024 08:31:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67000a50.050a0220.49194.048d.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in page_counter_cancel (5)
From: syzbot <syzbot+013715179d3f910d4c86@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9852d85ec9d4 Linux 6.12-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c07d07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1671921cf1ab80dd
dashboard link: https://syzkaller.appspot.com/bug?extid=013715179d3f910d4c86
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c15dd0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102c839f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3d84bc921e1/disk-9852d85e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/90a9eb597a2f/vmlinux-9852d85e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f013a91b893b/bzImage-9852d85e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+013715179d3f910d4c86@syzkaller.appspotmail.com

R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
page_counter underflow: -512 nr_pages=512
WARNING: CPU: 1 PID: 5225 at mm/page_counter.c:60 page_counter_cancel+0x110/0x170 mm/page_counter.c:60
Modules linked in:
CPU: 1 UID: 0 PID: 5225 Comm: syz-executor334 Not tainted 6.12.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:page_counter_cancel+0x110/0x170 mm/page_counter.c:60
Code: e8 55 23 98 ff 45 84 ed 75 24 e8 6b 21 98 ff c6 05 1a ef 10 0e 01 90 48 c7 c7 c0 9d 5c 8b 4c 89 e2 48 89 ee e8 91 9a 59 ff 90 <0f> 0b 90 90 e8 47 21 98 ff be 08 00 00 00 48 89 df e8 9a 71 f9 ff
RSP: 0018:ffffc900032dfae8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881404a9440 RCX: ffffffff814e2a49
RDX: ffff88801df38000 RSI: ffffffff814e2a56 RDI: 0000000000000001
RBP: fffffffffffffe00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000200
R13: 0000000000000000 R14: 0000000000000001 R15: ffff888077bbdc18
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b788f5243 CR3: 000000007ec10000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_counter_uncharge+0x32/0x70 mm/page_counter.c:182
 hugetlb_cgroup_uncharge_counter+0xd6/0x410 mm/hugetlb_cgroup.c:431
 hugetlb_vm_op_close+0x3fe/0x5b0 mm/hugetlb.c:5065
 remove_vma+0xa8/0x1a0 mm/vma.c:330
 exit_mmap+0x4e0/0xb30 mm/mmap.c:1888
 __mmput+0x12a/0x480 kernel/fork.c:1347
 mmput+0x62/0x70 kernel/fork.c:1369
 exit_mm kernel/exit.c:571 [inline]
 do_exit+0x9bf/0x2d70 kernel/exit.c:926
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6b7889d879
Code: Unable to access opcode bytes at 0x7f6b7889d84f.
RSP: 002b:00007ffcea637828 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6b7889d879
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f6b78911350 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007f6b78911350
R13: 0000000000000000 R14: 00007f6b78911da0 R15: 00007f6b78866f40
 </TASK>


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

