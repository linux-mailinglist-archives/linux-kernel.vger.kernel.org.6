Return-Path: <linux-kernel+bounces-331023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA88897A75C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E84B2437D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC6154C14;
	Mon, 16 Sep 2024 18:35:33 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F94174A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511733; cv=none; b=NLv5UiJqgMwKByqlq9tIloWBpJpG/SMwHWfj5sEB7ucvPMPED+wFJtMMmaaGA7ueMrrAzvSeCWbRvtedYx7FvZWs0rma7LhOwl2kgSOfWtaVPZ6ExE0DiEN3p1g/Le3YW5iG+WKbS9+9czkvpn2Ex44JQ7jhCeduKrqn1p0re2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511733; c=relaxed/simple;
	bh=OeW1zo2Pzi8hlSbFCN2pGdCLeVgoIrCu3RMvHINlCdo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tm8SVFD8iOT8TJHsOUrn5MSHB5s575efdRrn+LsJrUskP8H8j0YDv75pBPv+9iE0XknESwOXu/t1j5XZUpIvSVAxP6Podi2UjzxS1dPnNt6tUN81LeR13Dd5scceeBRo80uj/4qFnfpSU+bBKeko/9jKMaiIPnib4CULxa9sLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cd9c20b2bso995475539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726511730; x=1727116530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4w651fin08fFpocCDC+J1rLWeqXcKcKUsoUPWvIibs0=;
        b=supfe4g49g+Cavfl6DQjMnl5TPYBpE+9sK1RWt6qu9S7shue1wgD+QAtaFS8fjM1mf
         Ud4IY867bvaGgwjKNgeejdpZjNruJK7Fh1+GhRXtVeSoKCsLGA9kP5ppirhYcSB9XJ9S
         blc94+QRfA63VkzxPQTyoOVNnoErWVfNb/u6M9M3LUwIaOptWRlZwrILkM2r2Xkw0IQ5
         UKEQ0Nj9QUZdi5BT5+/uZ/Lp/PQsZ00KtaXLWRI006TbfBYQS0TkggziQsl2EMfPjpIM
         QE1lpLEk0fUAQpB4ENDAnfiRtvzaHYR9MV19b0pPiqKH7pia7EBlRffFhUBieK7FI5Dy
         4M4A==
X-Forwarded-Encrypted: i=1; AJvYcCXYmW8rwUNwGaFsWJgEHMscoU0WeX+jYsbA5tu4mF47LzuE2XOYUaCWj6mzpGu8N5wS/H952sSTW9wsPmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaWS9ytS/XG8sIERuprXd8O6isbtCqyN1oK5uDrmWhVTrA1S5C
	rJgLqSXQO0Kr9ySLzfyOygIr5bbqQEv83L0t1pJ+If/WLm+MZKLcSEvPs5tTE3KnUdsFxOfSLag
	uBoPAk+QfaJHYQxcv9vQFTZgY+Zs0wfKiOPznnue9EpoV2vuTKLaqbgU=
X-Google-Smtp-Source: AGHT+IFfw6K9Cu8yKEzmYzYwa8uczL+X8Qupl5U/ew71UYSssT9ypPVrYkevmSJglG9W4yQmjlToi1rklcKGBPwS6APld+3j7iOX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:591:b0:3a0:9de2:ca89 with SMTP id
 e9e14a558f8ab-3a09de2ce70mr38600075ab.17.1726511730057; Mon, 16 Sep 2024
 11:35:30 -0700 (PDT)
Date: Mon, 16 Sep 2024 11:35:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ef449062240d69c@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_write_cluster_by_desc
From: syzbot <syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    adfc3ded5c33 Merge tag 'for-6.12/io_uring-discard-20240913..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1066a8a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71033c66cc4b01c4
dashboard link: https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e45c07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ab5500580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-adfc3ded.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14d8d89edd95/vmlinux-adfc3ded.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77b35977c15b/bzImage-adfc3ded.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e39a4142077d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com

         option from the mount to silence this warning.
=======================================================
ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
------------[ cut here ]------------
kernel BUG at fs/ocfs2/aops.c:1179!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5093 Comm: syz-executor394 Not tainted 6.11.0-syzkaller-02520-gadfc3ded5c33 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_write_cluster fs/ocfs2/aops.c:1179 [inline]
RIP: 0010:ocfs2_write_cluster_by_desc+0x1fc7/0x1ff0 fs/ocfs2/aops.c:1240
Code: 03 48 8d bc 24 30 02 00 00 48 c7 c6 77 b1 0b 8e ba 7e 04 00 00 48 c7 c1 00 ef 48 8c e8 92 93 1d 00 90 0f 0b e8 5a f1 12 fe 90 <0f> 0b e8 52 f1 12 fe 90 0f 0b e8 4a f1 12 fe 90 0f 0b e8 42 f1 12
RSP: 0018:ffffc90002c0ee20 EFLAGS: 00010293
RAX: ffffffff8380b546 RBX: ffff888042afc1a0 RCX: ffff88801e3e2440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002c0f170 R08: ffffffff83809cae R09: 1ffff1100855f804
R10: dffffc0000000000 R11: ffffed100855f805 R12: 0000000000000000
R13: ffff888041224000 R14: ffff888042afc178 R15: 0000000000000000
FS:  000055555ae8d380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020201000 CR3: 00000000378be000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_write_begin_nolock+0x3a2f/0x4ec0 fs/ocfs2/aops.c:1816
 ocfs2_write_begin+0x205/0x3a0 fs/ocfs2/aops.c:1903
 generic_perform_write+0x37e/0x730 mm/filemap.c:4025
 ocfs2_file_write_iter+0x17b1/0x1f50 fs/ocfs2/file.c:2456
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x1a0/0x2c0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f459d01dad9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd75106768 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f459d01dad9
RDX: 000000000208e24b RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f459d0955f0 R08: 000055555ae8e4c0 R09: 000055555ae8e4c0
R10: 0000000000004428 R11: 0000000000000246 R12: 00007ffd75106790
R13: 00007ffd751069b8 R14: 431bde82d7b634db R15: 00007f459d06603b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_write_cluster fs/ocfs2/aops.c:1179 [inline]
RIP: 0010:ocfs2_write_cluster_by_desc+0x1fc7/0x1ff0 fs/ocfs2/aops.c:1240
Code: 03 48 8d bc 24 30 02 00 00 48 c7 c6 77 b1 0b 8e ba 7e 04 00 00 48 c7 c1 00 ef 48 8c e8 92 93 1d 00 90 0f 0b e8 5a f1 12 fe 90 <0f> 0b e8 52 f1 12 fe 90 0f 0b e8 4a f1 12 fe 90 0f 0b e8 42 f1 12
RSP: 0018:ffffc90002c0ee20 EFLAGS: 00010293
RAX: ffffffff8380b546 RBX: ffff888042afc1a0 RCX: ffff88801e3e2440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002c0f170 R08: ffffffff83809cae R09: 1ffff1100855f804
R10: dffffc0000000000 R11: ffffed100855f805 R12: 0000000000000000
R13: ffff888041224000 R14: ffff888042afc178 R15: 0000000000000000
FS:  000055555ae8d380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020201000 CR3: 00000000378be000 CR4: 0000000000350ef0
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

