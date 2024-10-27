Return-Path: <linux-kernel+bounces-383458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B49B1BF3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC24A281810
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 03:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A96222331;
	Sun, 27 Oct 2024 03:54:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CB1E535
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730001272; cv=none; b=pWiEq5C9STmU1LAVBv+2sCj6T7DjTP0YvklkdFMZ9zxXS2Mip0EMB8Gl8Wxl2pYi5zsbI2bOo0XbRcGPU4+fW4t7je/3iAWerxzx/RXZrJ5BmHoEBx6KMhreFmA+RZ1lQXZ+QFDHYE6AjmRowRXvdHbnu01S18VDtoSK4ahTEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730001272; c=relaxed/simple;
	bh=Q2JnLIOfMwKDF9Af1I4c1W2+MS0Zj+MVXPh4hJfNkME=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dIOjp7tmm/nbhIOBLU8Cd5OHwDQl0gq6iqQ6JzszdQOHIDLxioFswM7YZZzFGbUgSGXqLtDE0yliQc8l+30LaaQo/imsHJuJxzB84l1r2GGtCAib3609ThaJy+MmaEMxf716glD1P9Tfq3D1AShBpbGwqyRIEYz3KC3zpYIVHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83a9bd80875so236175239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 20:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730001269; x=1730606069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Awm904hT1PgOhFEY2VTxE6Gcv3mz64A+/asWkoZE+wc=;
        b=AAifvCcpwczaFtiig8p7L8QGxouCg6m6bFzQcmpBXwhCi/y8TuMKjW3nxL6r9JpRGq
         KakTGfQk/Lx1RPbWIF++AN4bJVwkJZvAqFuYc9uG8hV8dpLnPKa3uvdeOy8Kp/lJM/hy
         K8LxX+UprYXel873V6rr+C6s7lsb0mAddKXM+1hQLgG16hoPZ0uXzOze8wy/kQ2rEa8H
         Ij2tEFVACe2U+ysfDo2kaOuSSqYP58D87JwveGLzYAcOcW7JU3O2r7yR1MT9u4WzFGhj
         orz6UidlMZItONFjoEmvM0TGB/XQcWg500q24Kqg09dksfLrSUGO9MgIXhO63/XHEwOq
         LZqg==
X-Forwarded-Encrypted: i=1; AJvYcCWpqVxcJxDV6H0tLGH/jITrIJJG8i16iOaroLBWjO5S7l1DdLCmzqyuXJff6A0B0Ko8FamXHoITzrhg5Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OsFETT+NHYdGfN5VAszwH6KFn/t+wSj2cVsoORse435YrYu0
	8w4X0oCnlmPQmHq3fHJ93LONu0JNMJRPl+PqQbKu5G7opAKTM0//trFeoASclrwFaFrCi+qKxLq
	3SSNB2ABl1f6UwT78cMHbzoA0fGC58Lz+eXJ7MfId2xLzY91ubcO3DfQ=
X-Google-Smtp-Source: AGHT+IG4uQD/UnaHViL9bOXsFCv+4FcfA4QhlRwUSsQ/XsvmmMKbY4xnYW8KawhA6PzNNH4t6I6wrgvXDO+e9LyAvP7JEbanjD8Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:b0:3a3:f86f:2d0f with SMTP id
 e9e14a558f8ab-3a4ed27a9a1mr33424215ab.3.1730001269007; Sat, 26 Oct 2024
 20:54:29 -0700 (PDT)
Date: Sat, 26 Oct 2024 20:54:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671db974.050a0220.2b8c0f.01c0.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_inconsistent_error
From: syzbot <syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14202a5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=bee87a0c3291c06aa8c6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11468c30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166fa640580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/bzImage-c2ee9f59.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7da30fa86689/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/error.c:29!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5094 Comm: syz-executor353 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_inconsistent_error+0x14c/0x150 fs/bcachefs/error.c:29
Code: fb 02 75 20 e8 f5 53 67 fd 49 81 c7 cc 01 00 00 e8 09 0c d1 fd 48 c7 c7 20 74 53 8c 4c 89 fe e8 2a cb 95 07 e8 d5 53 67 fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc9000b0965f8 EFLAGS: 00010293
RAX: ffffffff842d840b RBX: 0000000000000004 RCX: ffff8880359c8000
RDX: 0000000000000000 RSI: ffffffff8ef57290 RDI: 0000000000000004
RBP: ffffc9000b0967a8 R08: 0000000000000001 R09: ffffffff842d8324
R10: 0000000000000004 R11: ffff8880359c8000 R12: dffffc0000000000
R13: ffffc9000b0966c0 R14: ffff888044c00000 R15: ffff888044c00000
FS:  00005555742e5380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe064e9e68 CR3: 000000003df88000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_topology_error+0x83/0xc0 fs/bcachefs/error.c:37
 __btree_err+0x610/0x760 fs/bcachefs/btree_io.c:597
 validate_bset+0x157b/0x2640 fs/bcachefs/btree_io.c:807
 bch2_btree_node_read_done+0x2108/0x5e90 fs/bcachefs/btree_io.c:1126
 btree_node_read_work+0x68b/0x1260 fs/bcachefs/btree_io.c:1327
 bch2_btree_node_read+0x2433/0x2a10
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1753 [inline]
 bch2_btree_root_read+0x617/0x7a0 fs/bcachefs/btree_io.c:1775
 read_btree_roots+0x296/0x840 fs/bcachefs/recovery.c:524
 bch2_fs_recovery+0x2585/0x39c0 fs/bcachefs/recovery.c:854
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1aa39038fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffddefb1b08 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffddefb1b20 RCX: 00007f1aa39038fa
RDX: 0000000020000300 RSI: 0000000020005900 RDI: 00007ffddefb1b20
RBP: 0000000000000004 R08: 00007ffddefb1b60 R09: 00000000000058c4
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 00007ffddefb1b60 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_inconsistent_error+0x14c/0x150 fs/bcachefs/error.c:29
Code: fb 02 75 20 e8 f5 53 67 fd 49 81 c7 cc 01 00 00 e8 09 0c d1 fd 48 c7 c7 20 74 53 8c 4c 89 fe e8 2a cb 95 07 e8 d5 53 67 fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc9000b0965f8 EFLAGS: 00010293
RAX: ffffffff842d840b RBX: 0000000000000004 RCX: ffff8880359c8000
RDX: 0000000000000000 RSI: ffffffff8ef57290 RDI: 0000000000000004
RBP: ffffc9000b0967a8 R08: 0000000000000001 R09: ffffffff842d8324
R10: 0000000000000004 R11: ffff8880359c8000 R12: dffffc0000000000
R13: ffffc9000b0966c0 R14: ffff888044c00000 R15: ffff888044c00000
FS:  00005555742e5380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe064e9e68 CR3: 000000003df88000 CR4: 0000000000352ef0
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

