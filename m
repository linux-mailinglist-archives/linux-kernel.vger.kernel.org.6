Return-Path: <linux-kernel+bounces-423795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1318C9DACD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD59028219B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E522010E8;
	Wed, 27 Nov 2024 18:04:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940913BC35
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732730664; cv=none; b=Ncnnm1R/mJ/sslxq+BUxvpg3J4Og6fG1l/MM4DHIbOYsqTmkxkvK7H/QYZfEQ6TI1d86A+FxtTMGBOfT+3hH4dwTfptKX0m3oIkmH6xCJUNMEoNH8l1mClYuKqTnGqyEVKmfIQa2xikj94gofE8HzCQiVkGqnFi5rrbSeZaWMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732730664; c=relaxed/simple;
	bh=JzS500PxWffVihiDZ7AMokjE5g31kEYPPG3bsEBc0Sc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A28Bt/RR/G9XOYSga+P1TXYFSwAmclLfNnsc08ub7HrUNDheDAhZaAxNyACogI6bGKbsfffQmyKGTVTlkz02ycsQpModx2tn9VIHADEppRNy2Mg2JI7jnuDoZn5sswQs5S7Ii6UACiGyAjIj51s3zDFPoGE1kTSkmcvPsjcWgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7932544c4so67483025ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732730662; x=1733335462;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/f5h0Y9XRI0DexcqLkUpUpE+N2FUo+0oErMpwWJ3jNs=;
        b=q4TxrOLbRBy3ZotFOLFPqnktSupEZqHbXhSZoVujHnot7RLcHTJBTCYGa9wvqO5szY
         tl4VejmZhXD/k28Dls5CWhwjEZC5tCKkZXYaZor9ij3ScPHPxSe2fQF9ISPYBXOkWVwm
         PAeYbegp/Sf7ooxj6e8NS2ptI6u/g4Cum1JLnzFp/u17WQ8wEDSI/3Bfj1i19qGBIcPZ
         RSpZYR8uXo0vYXAfrQQ9zjjicnWkZgOtqt2iCBy2fEMhB2MSFN9G+2KiupLi/rOj1/hW
         im0FKvHYwHGH3EsUZWHwOyBh76BrqwdUpi7OBDOYZk5dREIR5CDOc347oDB09VTl9hbG
         25yw==
X-Forwarded-Encrypted: i=1; AJvYcCVAB++GVUD2xANFmQoRkhWt822o0bF5q3gO+R2sYFupTitvI08Pa+ORxLuvZ4cb0xK9Mv423AiQZ5qH5QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7xLm11P+LcPWtRylrWskmFrdE+E8vsRb1XEir7BFlpy0CjNr
	xDRQl/1Q+iE4HlZ5nnPJLpO2Jo91vfjRQS+gLB7AXMxiYVLFBe1RxhUMAUT+1gwuS4ThIfA1l4a
	K+g99ZD3prVNKBuFdgJ96hArer/hCbz3e/9UKhqmMsTn5CyGdepzXcQs=
X-Google-Smtp-Source: AGHT+IGHHygyC07GPZNk2r7m71YWqRIOtS05ffHx/ZNW9xXsuWg/zpzCfCqB0FyvgeWQS0ANOw+qfdz+vXEjjbhTMQz/4LgsMC3D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4414:20b0:3a7:c5b1:a55c with SMTP id
 e9e14a558f8ab-3a7c5b1a6f5mr25603915ab.0.1732730661882; Wed, 27 Nov 2024
 10:04:21 -0800 (PST)
Date: Wed, 27 Nov 2024 10:04:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67475f25.050a0220.253251.005b.GAE@google.com>
Subject: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_do
From: syzbot <syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    445d9f05fa14 Merge tag 'nfsd-6.13' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12733530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c44a32edb32752c
dashboard link: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fd43c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cf2f5f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9fd8dd2a6550/disk-445d9f05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af034d90afcb/vmlinux-445d9f05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07a713832258/bzImage-445d9f05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in fuse_copy_do+0x183/0x320 fs/fuse/dev.c:809
Write of size 5 at addr 0000000000000000 by task syz-executor159/5840

CPU: 0 UID: 0 PID: 5840 Comm: syz-executor159 Not tainted 6.12.0-syzkaller-09734-g445d9f05fa14 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
 fuse_copy_do+0x183/0x320 fs/fuse/dev.c:809
 fuse_copy_one fs/fuse/dev.c:1065 [inline]
 fuse_copy_args+0x1e6/0x770 fs/fuse/dev.c:1083
 copy_out_args fs/fuse/dev.c:1966 [inline]
 fuse_dev_do_write+0x1cc1/0x3720 fs/fuse/dev.c:2052
 fuse_dev_write+0x14f/0x1e0 fs/fuse/dev.c:2087
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa4c9df3c0f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 89 5e 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 dc 5e 02 00 48
RSP: 002b:00007fa4c9da71e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa4c9e7f3e8 RCX: 00007fa4c9df3c0f
RDX: 0000000000000015 RSI: 0000000020000540 RDI: 0000000000000003
RBP: 00007fa4c9e7f3e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fa4c9e4c33c
R13: 00007fa4c9e44027 R14: 00007fff3bcf2380 R15: 00007fa4c9e4a338
 </TASK>
==================================================================


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

