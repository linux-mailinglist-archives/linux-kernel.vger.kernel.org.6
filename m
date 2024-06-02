Return-Path: <linux-kernel+bounces-198135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F88D73EE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD44281AC3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 05:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8930C14A8F;
	Sun,  2 Jun 2024 05:48:24 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFA17C7C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717307304; cv=none; b=M//3S0RI6a2XdEfknWxqhzAAO9kbcqlnJTHBevRAhhwRayK/tQERZaGFH3ZSgXdo1JZOgCTuHwaWntOXSffqTIdeQh0c9k9bCidO2JzBE8SyuBd8CkrnoDFk0a/6z5GrqCBXvPpwsYUBfrTi4J/bxramKS2wkK2722NGQ0vEsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717307304; c=relaxed/simple;
	bh=HaZi+5WvzyVh8tD9Q1zjg9EtCrq+4GY2oqif4ZSOkrs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HAX9wlyZfxfa/l4n9JCc/GEvam885Xt8lnnBYBHBRb64lt0aWiATJX3J+1lZVk6j/aMuurnr82D9liQIe/D+vLVy1lArbl6pD/4NbPX1WrOh+BN/QxvyM4P0fvkONZyhTfLL530SORjQytOxrAvQBloyajGnzM4rXWLdDxN2vjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3748f2cfdabso16953695ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 22:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717307302; x=1717912102;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Pqa5pfv1WNLryRI68rJjx81gGLAYre3m61ngh7Zhtg=;
        b=PTDgqOJPke3KPVmaQHu+6nI1CUYkxikCBevaWRQjDOfQ/NhZOoHuFizuZikx20yfsr
         ++xYQrwlJnpfU4EGrSXw4BeFcCpfPTBCWL8oBA32x2WSZLXP/JyzpxKoHzXzjeU3G5qF
         BEZZtWppSojzT8CrsjtOvhvHYUVczE3SuRqNkk1m9ywATjVZI28m3XNG5tsxVv2XXX+9
         BP0Q7mXqFnhjJ2Ct0eraPD2vTB1AjpkQZUR62RGqpBPpltjwmmRwSGWiwsCTnb/bQR1I
         K77wDiHBhHnWkfDkIwp8QgbYhPQmXF2H6Nj9CsYw7kNOWyt/l9IckyF68xls8KYEOqu5
         ndjw==
X-Forwarded-Encrypted: i=1; AJvYcCUETL359WnjfrQPXBmB/4HoImfMvt70cCZCEOwt/wNHgIVFu8DgHukOUhDAT1oeuHa7CSEekLPCWoVEQzrvWOvGSJBFt358tNCNO/BO
X-Gm-Message-State: AOJu0YzL5DdLlZQEX1dKLopz6+szwvOw5HwWlcHPvuCwN8gZgXjZE7vv
	i2wd7N7Z79AJf1cULLquHzU2Au5GRPldIDG4UKuRhDkt4Pl0PXcBivqVwK7FIQ+KRFgSPBX6b0E
	rrcsG0IP2GI9Mgc1XiDpDz4tDymov1+eQ03rkECt/ySR1LqlHGOUaZ1s=
X-Google-Smtp-Source: AGHT+IHtBGTY8FCUwrhzoQBQNWe/r3MXRvq90iT1HFPiI9HaIhmJj/kylBxUwJ5FGTu1UL4R7N+kEN/Cq34vhQqTTBo0hWVHq2Rm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:374:491c:6567 with SMTP id
 e9e14a558f8ab-3748b9f8505mr4135585ab.5.1717307301835; Sat, 01 Jun 2024
 22:48:21 -0700 (PDT)
Date: Sat, 01 Jun 2024 22:48:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b241e40619e1c3bc@google.com>
Subject: [syzbot] [gfs2?] WARNING: locking bug in gfs2_fill_super
From: syzbot <syzbot+ee157488ade46c021ef4@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    9d99040b1bc8 Add linux-next specific files for 20240529
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16d60fc6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D735e953fee00ec1=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dee157488ade46c021=
ef4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1478a91498000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D129b10f2980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0deeb27b28b/disk-=
9d99040b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5acd2205cee1/vmlinux-=
9d99040b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/222eebb6b9d8/bzI=
mage-9d99040b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3ec737951e4a=
/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+ee157488ade46c021ef4@syzkaller.appspotmail.com

gfs2: fsid=3D(=EF=BF=BD[{{{+: Trying to join cluster "lock_nolock", "(=EF=
=BF=BD[{{{+"
gfs2: fsid=3D(=EF=BF=BD[{{{+: Now mounting FS (format 0)...
gfs2: fsid=3D(=EF=BF=BD[{{{+: can't read superblock: -22
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5095 at kernel/locking/lockdep.c:233 hlock_class kerne=
l/locking/lockdep.c:233 [inline]
WARNING: CPU: 0 PID: 5095 at kernel/locking/lockdep.c:233 check_wait_contex=
t kernel/locking/lockdep.c:4824 [inline]
WARNING: CPU: 0 PID: 5095 at kernel/locking/lockdep.c:233 __lock_acquire+0x=
570/0x2000 kernel/locking/lockdep.c:5144
Modules linked in:
CPU: 0 PID: 5095 Comm: syz-executor136 Not tainted 6.10.0-rc1-next-20240529=
-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 04/02/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:233 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4824 [inline]
RIP: 0010:__lock_acquire+0x570/0x2000 kernel/locking/lockdep.c:5144
Code: 00 00 83 3d 81 3e 3b 0e 00 75 23 90 48 c7 c7 e0 b9 ca 8b 48 c7 c6 80 =
bc ca 8b e8 eb e3 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 3=
1 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc9000334f4d0 EFLAGS: 00010046
RAX: 00d8e5bcc1ba5400 RBX: 0000000000000661 RCX: ffff888025c7bc00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: ffffffff81586802 R09: 1ffff1101728519a
R10: dffffc0000000000 R11: ffffed101728519b R12: ffff888025c7c728
R13: ffff888025c7c6d8 R14: ffff888025c7c6d8 R15: ffff888025c7bc00
FS:  00005555837eb380(0000) GS:ffff8880b9400000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffecc139b24 CR3: 0000000075252000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5817
 touch_wq_lockdep_map kernel/workqueue.c:3895 [inline]
 __flush_workqueue+0x1c9/0x1710 kernel/workqueue.c:3937
 drain_workqueue+0xc9/0x3a0 kernel/workqueue.c:4101
 destroy_workqueue+0xba/0xc40 kernel/workqueue.c:5817
 gfs2_fill_super+0x12a4/0x2520 fs/gfs2/ops_fstype.c:1311
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1df5f5ad7a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea18b22f8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffea18b2300 RCX: 00007f1df5f5ad7a
RDX: 0000000020000000 RSI: 00000000200001c0 RDI: 00007ffea18b2300
RBP: 0000000000000004 R08: 00007ffea18b2340 R09: 0000000000012795
R10: 0000000000008c1b R11: 0000000000000282 R12: 00007ffea18b2340
R13: 0000000000000003 R14: 0000000001000000 R15: 0000000000000001
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

