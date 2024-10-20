Return-Path: <linux-kernel+bounces-373158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0239A530F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA841C20FE8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFDE39AEB;
	Sun, 20 Oct 2024 08:11:40 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E9179BC
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729411900; cv=none; b=QL8H9AXplA53PTRxiVkOC/CvYbL7kcL0gHLnP9wjaC0X8pXopPdyzF7VUPeiB64IvoQH4gTrNPhsIv7XV55O5RN6SBeX0mvXGF1JZAaeaamm77hnIYbVGl5U2i/hh7RV3jvGN6lXyjf6VfMjHj5sSA0UVsmjKJQwhi6Z+DUm8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729411900; c=relaxed/simple;
	bh=ZyMWFyzATpl7gRu/4GyRCbY2STjRj5U1XzquaXNCuC0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ORss+pf6PC/HGGO/dlsFHqUodyTDUTHN9AW1djsCm01O0lgYkp1ivrCztBeebKBIX23P6KJ680LLxZfuPD7K816hMecevwYNNFyZ3Tu2YWEQc3b9QhOHFVZx0oQS1FZUHu9XT4pcD5sQUpXUwcnCRKbAa3pqFvKgDoTVK9aR17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so39585495ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 01:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729411897; x=1730016697;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNIoubmccZ0d+EUZGQlF8nJU3f2qCwuXExAlgMyym2o=;
        b=Raj5fSSkCetETGNvq/CSNdQNMFZd05fOcH/imCrSLQGIPUgDK5eQx4HUq6Oj40NtGd
         FqQPzDPg0Fps/w2PpeuqlLtqsisB8E5ti+4dciaULqJuk5CPYuFYVULCf2BJBKa9Smdn
         1DJL9V1r+k5igG6h4PcVzkfGW8IELqDI3MxpdooHhVy+JS8+js+mN+9uX5XSRKbuNSrr
         foRbGemC8UbeWThI6w5qYS6AkkVDw6GutSI7843dApSJNAC0wk2e57zg2MIUh7LlwtSz
         2+ncOp16/N9896SYZnSNfdpB3I3ufN0l121ty34u00qbRzeJnYk/SzcU29Yf8nNMjOl6
         LvVg==
X-Forwarded-Encrypted: i=1; AJvYcCXrZSvWTBIUBylr6AQSexFsT5sdS91zluVObDmfaGcuuYnKl9Glwi4Wa5n6NPd2OBtUpF5iarLppzsu0Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfe1wq9eObHWWNonOk6vbCWGeMnZQg5QVOyV5jikUpnt8EcuyB
	AJTXW15Ttcp1I3aFS5u0nmjVCQ+SPmK/dqYX0/Vdzu1LZUWgq0EyhzIP3uHds0T7sEnROm5okhM
	+DTxFuWzSPQEgTs8qkaP3d6Sf2ZQNEUOyTlb7/e7Y07FskcTeDgls9iM=
X-Google-Smtp-Source: AGHT+IH/c67AjGIAB1dGP22XRncw+0Ntb5AJHOdFGQbVgTgxbeicy0MokTm8um7LjlK0TfPhFQCnFRgo9qQC2WYMKJh3cDcvIQFs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c7:b0:3a0:480c:6ac4 with SMTP id
 e9e14a558f8ab-3a3f40b7328mr67150415ab.22.1729411897038; Sun, 20 Oct 2024
 01:11:37 -0700 (PDT)
Date: Sun, 20 Oct 2024 01:11:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714bb39.050a0220.10f4f4.002e.GAE@google.com>
Subject: [syzbot] [fuse?] kernel BUG in fuse_dev_do_write
From: syzbot <syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1597745f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=65d101735df4bb19d2a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1623e830580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16582f27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c85347a66a1c/vmlinux-15e7d45e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/648cf8e59c13/bzImage-15e7d45e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/highmem.h:269!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5238 Comm: syz-executor755 Not tainted 6.12.0-rc3-next-20241016-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:zero_user_segments include/linux/highmem.h:269 [inline]
RIP: 0010:folio_zero_range include/linux/highmem.h:641 [inline]
RIP: 0010:fuse_notify_store fs/fuse/dev.c:1671 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1908 [inline]
RIP: 0010:fuse_dev_do_write+0x5d6d/0x5da0 fs/fuse/dev.c:1992
Code: c6 a0 11 41 8c e8 43 fc c9 fe 90 0f 0b e8 ab 55 7e fe 4c 89 ef 48 c7 c6 40 11 41 8c e8 2c fc c9 fe 90 0f 0b e8 94 55 7e fe 90 <0f> 0b e8 8c 55 7e fe eb 0c e8 85 55 7e fe eb c1 e8 7e 55 7e fe 4c
RSP: 0018:ffffc90003e67860 EFLAGS: 00010293
RAX: ffffffff83168cbc RBX: 0000000000001001 RCX: ffff88802178bc00
RDX: 0000000000000000 RSI: 0000000000001001 RDI: 0000000000001000
RBP: ffffc90003e67bb0 R08: ffffffff8316685c R09: 1ffffd40003defd8
R10: dffffc0000000000 R11: fffff940003defd9 R12: 0000000000001000
R13: ffffea0001ef7ec0 R14: 1ffffd40003defd8 R15: 0000000000000001
FS:  000055557fdec380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001f80 CR3: 000000007a4ca000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_dev_write+0x148/0x1d0 fs/fuse/dev.c:2076
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffaa74606e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9501f418 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffaa74a9029 RCX: 00007ffaa74606e9
RDX: 000000000000002a RSI: 0000000020001f80 RDI: 0000000000000003
RBP: 00007ffaa74d3610 R08: 00007fff9501f5e8 R09: 00007fff9501f5e8
R10: 0000000020000200 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff9501f5d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:zero_user_segments include/linux/highmem.h:269 [inline]
RIP: 0010:folio_zero_range include/linux/highmem.h:641 [inline]
RIP: 0010:fuse_notify_store fs/fuse/dev.c:1671 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1908 [inline]
RIP: 0010:fuse_dev_do_write+0x5d6d/0x5da0 fs/fuse/dev.c:1992
Code: c6 a0 11 41 8c e8 43 fc c9 fe 90 0f 0b e8 ab 55 7e fe 4c 89 ef 48 c7 c6 40 11 41 8c e8 2c fc c9 fe 90 0f 0b e8 94 55 7e fe 90 <0f> 0b e8 8c 55 7e fe eb 0c e8 85 55 7e fe eb c1 e8 7e 55 7e fe 4c
RSP: 0018:ffffc90003e67860 EFLAGS: 00010293
RAX: ffffffff83168cbc RBX: 0000000000001001 RCX: ffff88802178bc00
RDX: 0000000000000000 RSI: 0000000000001001 RDI: 0000000000001000
RBP: ffffc90003e67bb0 R08: ffffffff8316685c R09: 1ffffd40003defd8
R10: dffffc0000000000 R11: fffff940003defd9 R12: 0000000000001000
R13: ffffea0001ef7ec0 R14: 1ffffd40003defd8 R15: 0000000000000001
FS:  000055557fdec380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055874a56a790 CR3: 000000007a4ca000 CR4: 00000000003526f0
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

