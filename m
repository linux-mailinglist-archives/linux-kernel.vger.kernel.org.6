Return-Path: <linux-kernel+bounces-331277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E797AADE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF26FB23C77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B385446DB;
	Tue, 17 Sep 2024 04:59:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A92B9B3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726549174; cv=none; b=KngRnVCFNXcVhHRy5QS7ZeK+4nuVCROuKpZjZJ5x/n6BKp5NPqU8Ufvjyv08MBISfGIh/UFol9ihi7lk/VRHRCIEHavD5TkWthpseWksUFv2xOouEU1ZW30nzzCwx/suOU066qeGSde5XGY5nPYhkgxJJElxcnuTBP7t/h5Vth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726549174; c=relaxed/simple;
	bh=BRnD1pnyivyuEbtbhbhXW/rgFvfqaDTx7sUQa6/Y5hk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nVeJSX3BAskHc3nQmVTwTHbs7tay3f4OVxSQAYHrHvM3oI5nt3twBNzgUXzI7ywFLX9b6YkBPXeE9C0QW597lGLPJmoWCw8fP0eU5lf5cRk5cF+l8BBVpg6f/uUgnm2GQyX/Fo5AscPJnpByNibpQKEOs6/z6A/OuULIEyErdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cda2c8997so865697339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726549172; x=1727153972;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPcssxtsyqLzduep4ooXUuQW7AYN0Kh/6amIF3Oa4fE=;
        b=qPssR9p7gdgQojbDPJ/kNxzmpT7OCuGqvM32ZSSnJ8Fc2a/kdgTfDrQfNRl4PPUh/7
         DrDZ48HxBwZ+4fBkKpp4GwnXrqxJDMl6iiWS1PUu1eTvzdUbYuABPgF0IrS52Otc/W0M
         dbBxN3d7uaBCyjyX0G/DGpywzoj7fajOqzU1nQREKYtXObV3YdOxlLqdMcJ4xG7XNuXT
         KZsQ74TWJD5Fg38gr0ZILmxXvm0y7BCmkTQR3n4VZP9ABOGnO0uazBy+jmwI0cGeojJ7
         iDF+SAxVWJeEfbksKSjEAJkZY53/6w6eKMZZnDlAkf4Ypcm7Y4KSxjEcLx52rGkv1MqN
         fy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnqr8OiLInk9LDF9kCURWTJVR6gIBUH/n5am5wu3oBKs0nk9k7kyn070/zjvbw2jNs7yRAYH7WjYPeQqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQW5sF9E2jTWudiEEk2/VlsQPVGwnz0F6xQRp1yaGciUtUH+b
	gRqHs6NKGETfhXtNillItx1XBpwVUoAhFOtxGOfNOyM1WCmR18/ZaKGHALmfXs/E9BxrEfKXX95
	m6gHpAgYRQ3QRayIt7Sm+usc10hrw0v7W3ywnVuY6D0dMLIx4NmBvFcQ=
X-Google-Smtp-Source: AGHT+IFdWMCEBYAtT2JsW8vcJq0ngnldxzQFfNwXQHfe6PBK9K8f5Tggp2K2jn4EX+SN05Gypa8ycfbKVzMqzEHE5rGW35vcTJ1P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168c:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a09cd595c8mr73028625ab.20.1726549171744; Mon, 16 Sep 2024
 21:59:31 -0700 (PDT)
Date: Mon, 16 Sep 2024 21:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011bdde0622498ee3@google.com>
Subject: [syzbot] [erofs?] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in filemap_read_folio (3)
From: syzbot <syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118e68a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1653f803fffa3848
dashboard link: https://syzkaller.appspot.com/bug?extid=001306cd9c92ce0df23f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1452dc07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158e68a9980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66a65abf87c4/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09c88015f9aa/bzImage-a430d95c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/00e0bb849690/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
vfat: Unknown parameter 's'
./file1: Can't lookup blockdev
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 127b0067 P4D 127b0067 PUD 127b1067 PMD 0 
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5096 Comm: syz-executor418 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90002d7f9f8 EFLAGS: 00010293
RAX: ffffffff81cb4ee0 RBX: 0000000000000000 RCX: ffff88801e428000
RDX: 0000000000000000 RSI: ffffea00004bfec0 RDI: 0000000000000000
RBP: ffffc90002d7fac0 R08: ffffea00004bfec7 R09: 1ffffd4000097fd8
R10: dffffc0000000000 R11: 0000000000000000 R12: ffffea00004bfec0
R13: 1ffffd4000097fd9 R14: 0000000000000000 R15: ffffea00004bfec8
FS:  000055558992f380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000011be2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3796
 read_mapping_folio include/linux/pagemap.h:915 [inline]
 erofs_bread+0x499/0xd40 fs/erofs/data.c:41
 erofs_read_superblock fs/erofs/super.c:277 [inline]
 erofs_fc_fill_super+0x345/0x1770 fs/erofs/super.c:621
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0xb7/0x140 fs/super.c:1299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb0eb9a7f59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff42b6ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 6d616e74726f6873 RCX: 00007fb0eb9a7f59
RDX: 00000000200005c0 RSI: 0000000020000580 RDI: 0000000020000540
RBP: 0031656c69662f2e R08: 0000000000000000 R09: 00005555899304c0
R10: 0000000000200000 R11: 0000000000000246 R12: 74616c785f696e75
R13: 746e6e69773d656d R14: 646578696d3d656d R15: 00007fb0eb9f103b
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90002d7f9f8 EFLAGS: 00010293
RAX: ffffffff81cb4ee0 RBX: 0000000000000000 RCX: ffff88801e428000
RDX: 0000000000000000 RSI: ffffea00004bfec0 RDI: 0000000000000000
RBP: ffffc90002d7fac0 R08: ffffea00004bfec7 R09: 1ffffd4000097fd8
R10: dffffc0000000000 R11: 0000000000000000 R12: ffffea00004bfec0
R13: 1ffffd4000097fd9 R14: 0000000000000000 R15: ffffea00004bfec8
FS:  000055558992f380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000011be2000 CR4: 0000000000350ef0
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

