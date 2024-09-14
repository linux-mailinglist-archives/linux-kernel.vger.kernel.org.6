Return-Path: <linux-kernel+bounces-329096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE2978D3D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE728695A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 04:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8849E179A8;
	Sat, 14 Sep 2024 04:00:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCF8C1F
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726286430; cv=none; b=DJXX06lLJz81l53J4uqgbWhj1YOQZ2RnfjmAuIwO6knazudsMyGQxib7ocft9VTtJ0XawRCi+iWkwb7MsJkVnbQ89mnzBCw+CxeUFKp1GZ5aZZdkyXXq7dn0/t/et/uD9tfWnl7YWI0i4EBialptrMrhT/U9Wbfdq6IVtJshCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726286430; c=relaxed/simple;
	bh=fZv/ftlALop4h6I557vAed5tUBZOdf2pPSg3yn31628=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bbm26PGf4p1M/KUxO8Ocu9d0U+HjCOTk0IdsidCGEynbcXkuNz9kJpgUGYfMLnNshX3tvaukzxkllb7ADRMSbXer1+3ICe0OoDqL868AjP77tpwN7S1omt3IlIBZOnwkkMm1FVjiwGQiipVEVMSdSJzXb5++ioDhsOi3nqzKWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04af50632so48209285ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726286428; x=1726891228;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz5WZJ4tHVtePKnHi+SbP+S0EHx46AHTGM3wRpRV1ZU=;
        b=U12wbsknSim9byv/gAQpQN95/lb0xal1eDCwH89DePi7RCzj/Ag2i7vzmLT9bsqejM
         0gCS4vdFDhsk5/XMY/nL2M5dq88Qcd+61EOUPtyMYY12dEdDJQ8lMkOqxZLwgb7/vZb5
         U9RxdVrqFPY2Lv9LxFQMsEGMfPCja14bHku/6GAbHqhq3mRBn1jcyrMZooYE7I1gB0fC
         JZ3k+hcG0Ou1WepZaq/4hrx3VmTMlAMbeX8v6z2KhdWcoLzD4u+5zwNKPp2QXqBJ9RND
         ETQk9fjt/t5NhEPiaALek9y3d2069uglCdgE3fFc59ZFDDdyPRbdEmdESR6nmqrDEaFi
         0vSg==
X-Forwarded-Encrypted: i=1; AJvYcCW2m1axIy+4zClVwr2BMdhkiBOmvY03YxRnYTXMO9m50KTD6P8VrDMel1ojuxNJ0Tr5v5Jbq4+5/UTN3l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uHz1L3q4iq8NhqF3ju7vAReKxqpjPLO+M5gpWHUHZLTShRZT
	/wIPEBCNa1/YzDFnMnILE74TO7/eWEruJJA+TZwtTS7qV+B70fyCn9hLQQt4v4IJnsDX4nm7fPt
	NSiRbYTUtPtuvHRcYb1PArFcHFwJSvxNrGMyjhvwUvK+TtTqs5etQB/M=
X-Google-Smtp-Source: AGHT+IE9/reacg2tKFboN78px8MUZJfQuDgk58r8fMFV0V8YdjqZ2DN3jpSugRI00e1A4TiA+SL/FJ5p3WnTJ4rhkU2aC48Mv2pQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:3a0:4250:165f with SMTP id
 e9e14a558f8ab-3a0847d0c17mr91913705ab.0.1726286427673; Fri, 13 Sep 2024
 21:00:27 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:00:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d651706220c61a5@google.com>
Subject: [syzbot] [v9fs?] BUG: corrupted list in p9_fd_cancelled (3)
From: syzbot <syzbot+15a08eabe3d3838fb641@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e936e7d4a83b Merge tag 'spi-fix-v6.11-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136467c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=15a08eabe3d3838fb641
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d80a1fd7fbf1/disk-e936e7d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7096765887fd/vmlinux-e936e7d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/703093aff5a7/bzImage-e936e7d4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15a08eabe3d3838fb641@syzkaller.appspotmail.com

list_del corruption, ffff88805af61610->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:56!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 10605 Comm: syz.0.1206 Not tainted 6.11.0-rc7-syzkaller-00133-ge936e7d4a83b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__list_del_entry_valid_or_report+0x108/0x1c0 lib/list_debug.c:56
Code: c7 c7 e0 fe b0 8b e8 97 5e de fc 90 0f 0b 48 c7 c7 40 ff b0 8b e8 88 5e de fc 90 0f 0b 48 c7 c7 a0 ff b0 8b e8 79 5e de fc 90 <0f> 0b 48 89 ca 48 c7 c7 00 00 b1 8b e8 67 5e de fc 90 0f 0b 48 89
RSP: 0018:ffffc9000455f6d0 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff88805af61550 RCX: ffffc9000f602000
RDX: 0000000000000000 RSI: ffffffff816ceea6 RDI: 0000000000000005
RBP: ffff888025047800 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: ffff88805c934830
R13: 0000000000000005 R14: ffff88805af61610 R15: ffff88805af61618
FS:  00007fedb6f3b6c0(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f375bdfc408 CR3: 000000001eab8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 p9_fd_cancelled+0xa2/0x2a0 net/9p/trans_fd.c:736
 p9_client_flush.isra.0+0x34b/0x420 net/9p/client.c:618
 p9_client_rpc+0xaef/0xc10 net/9p/client.c:741
 p9_client_version net/9p/client.c:930 [inline]
 p9_client_create+0xcc8/0x1210 net/9p/client.c:1034
 v9fs_session_init+0x1f8/0x1a80 fs/9p/v9fs.c:410
 v9fs_mount+0xc6/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3472 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3799
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount fs/namespace.c:3997 [inline]
 __x64_sys_mount+0x294/0x320 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedb617def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedb6f3b038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fedb6336130 RCX: 00007fedb617def9
RDX: 0000000020000b80 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 00007fedb61f0b76 R08: 0000000020000180 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fedb6336130 R15: 00007ffd5f34b4f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x108/0x1c0 lib/list_debug.c:56
Code: c7 c7 e0 fe b0 8b e8 97 5e de fc 90 0f 0b 48 c7 c7 40 ff b0 8b e8 88 5e de fc 90 0f 0b 48 c7 c7 a0 ff b0 8b e8 79 5e de fc 90 <0f> 0b 48 89 ca 48 c7 c7 00 00 b1 8b e8 67 5e de fc 90 0f 0b 48 89
RSP: 0018:ffffc9000455f6d0 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff88805af61550 RCX: ffffc9000f602000
RDX: 0000000000000000 RSI: ffffffff816ceea6 RDI: 0000000000000005
RBP: ffff888025047800 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: ffff88805c934830
R13: 0000000000000005 R14: ffff88805af61610 R15: ffff88805af61618
FS:  00007fedb6f3b6c0(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f375bdfc408 CR3: 000000001eab8000 CR4: 00000000003506f0
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

