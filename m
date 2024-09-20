Return-Path: <linux-kernel+bounces-334321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F197D5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D354CB234F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4848516A943;
	Fri, 20 Sep 2024 12:47:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9315CD78
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836446; cv=none; b=bW1qi9bx550nG/znQmJiSTt+7kWMUu4Dl/XhpvdrdoFkghi5vJp+qAPJVWs7vf4pAYqeFxlk1LIBUva25zTEX7uvlZQkTMd6ae5kGm9VB76Ja9K8g7F5WpDy63r3Fl0zsIh+B/sexeqZvuue63BwXvajy4y+vytRTk9HAqVm3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836446; c=relaxed/simple;
	bh=tD3iDft4SBwpBaSHl8NlI2gqYGQHO0INPEO5LqHu1QI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D+95tMoF5wbBavFXKyC4szXkscEenSLJ9DZv2FUYNyfT1VSThp97InsBdqKhjylpGwUTS0SkVYyFvYv7cGAmNJNoc0oG/BdeK3T0EQddYOVeANywwWhYP07Ke+i4N3Y2sPqyWcBsH+LWzEz9s5rNtaDZQEV4JQ5gtnrPYPOkRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so520665ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836444; x=1727441244;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxIryZOr6HYqrQlJxWr1jnYP1uSOLuO/kQSlwcjblKo=;
        b=AamxHa0AUQ2Pi+ZVZmS+897qxpag/lWbyrNmhb0kW6Hgfc2e3L8WaBzMeo90WnwXoR
         A8Y4nvNZwZLT0ddt1zNTWUZtHRz0UFWrqTlzLQdR1vzvbpxfhr6NJ4Y5k/LJ4z29XWa2
         twvl1p0lx03pusjByLhIXM9NdPZerCImKcKiVlr3ATmmzu14IOVw25DIVf0jNRvffYeF
         kkydVfKN1hSoYZiDEXfxl6ZJpDbCB4zuI08qsyn2b/dBKR/7frBMM7BaIUwz6VXGyZzi
         EsTDf/hrYWTZML18OXD3Zt4I3h65tcsx1jwng9F77QHN6fuwExRkf79uxWmUjTLsitIY
         JkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXenKcsvta5eqhVN2B7f8Cg1D/MOl3ForIk19wB5CpJYXa62BeuMAbJi0u+hEGonnqh9CEA9hNRPFJSkGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztGZQk2LNSbi7HKC3H8F/kxj8mHlPAKWSN7/iU66uXEYeycjMM
	8O211TN746FL7kDUmFWzII6k3rStWd/nP/ItlaSCQx8+0gkeWLVxWzeQ420QkatrtQsQKNgoFWg
	XnkD+i7Zb82/TxPFp8+SjXerXMBkLOQpYImCtjcyk++ROk4tp/m2P7m4=
X-Google-Smtp-Source: AGHT+IHyg/NSSAXQ6bcrGSnBfOGrXCWgOAeuOULXE3fpQN4XrKArcp3ok4OS8tizrd/GiQq5XkG9rH2jRv2x62m/Ki2fK+6/Y32U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a0c8d2ea34mr32629695ab.23.1726836444433; Fri, 20 Sep 2024
 05:47:24 -0700 (PDT)
Date: Fri, 20 Sep 2024 05:47:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed6edc.050a0220.2abe4d.0014.GAE@google.com>
Subject: [syzbot] [io-uring?] WARNING in io_sq_offload_create
From: syzbot <syzbot+71b95eda637a2088bd6b@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    adfc3ded5c33 Merge tag 'for-6.12/io_uring-discard-20240913..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ccd500580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7cbb8108ed6b75e
dashboard link: https://syzkaller.appspot.com/bug?extid=71b95eda637a2088bd6b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156d5fc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ccd500580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f36034d78003/disk-adfc3ded.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/312ad0ebcf45/vmlinux-adfc3ded.xz
kernel image: https://storage.googleapis.com/syzbot-assets/06eca1ed13c5/bzImage-adfc3ded.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71b95eda637a2088bd6b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5230 at include/linux/cpumask.h:135 cpu_max_bits_warn include/linux/cpumask.h:135 [inline]
WARNING: CPU: 1 PID: 5230 at include/linux/cpumask.h:135 cpumask_check include/linux/cpumask.h:142 [inline]
WARNING: CPU: 1 PID: 5230 at include/linux/cpumask.h:135 cpumask_test_cpu include/linux/cpumask.h:562 [inline]
WARNING: CPU: 1 PID: 5230 at include/linux/cpumask.h:135 io_sq_offload_create+0xe3d/0x1090 io_uring/sqpoll.c:469
Modules linked in:
CPU: 1 UID: 0 PID: 5230 Comm: syz-executor334 Not tainted 6.11.0-syzkaller-02520-gadfc3ded5c33 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:135 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:142 [inline]
RIP: 0010:cpumask_test_cpu include/linux/cpumask.h:562 [inline]
RIP: 0010:io_sq_offload_create+0xe3d/0x1090 io_uring/sqpoll.c:469
Code: 44 24 08 e9 2f f7 ff ff e8 a0 8d 0f fd 44 89 e3 e9 06 ff ff ff e8 93 8d 0f fd 4c 89 ff e8 6b 5f 7f fd eb ad e8 84 8d 0f fd 90 <0f> 0b 90 e9 f3 fd ff ff e8 76 8d 0f fd 31 ff 89 de e8 ad 8f 0f fd
RSP: 0018:ffffc9000369fcd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88803234bc00 RCX: ffffffff847b951e
RDX: ffff88801f7eda00 RSI: ffffffff847b972c RDI: 0000000000000005
RBP: ffff88802b2aa000 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000008
R13: 1ffff920006d3fa0 R14: ffffc9000369fd20 R15: 0000000000000000
FS:  000055557be9d380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f88aadf0df8 CR3: 0000000078b14000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 io_uring_create io_uring/io_uring.c:3617 [inline]
 io_uring_setup+0x180f/0x3730 io_uring/io_uring.c:3726
 __do_sys_io_uring_setup io_uring/io_uring.c:3753 [inline]
 __se_sys_io_uring_setup io_uring/io_uring.c:3747 [inline]
 __x64_sys_io_uring_setup+0x98/0x140 io_uring/io_uring.c:3747
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f88aad91919
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe74f4e298 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 00007f88aaddb105 RCX: 00007f88aad91919
RDX: ffffffffffffffb8 RSI: 0000000000000003 RDI: 00000000000003ff
RBP: 00007f88aaddb0e3 R08: 0000000000008000 R09: 0000000000008000
R10: 0000000000008000 R11: 0000000000000246 R12: 00007f88aade009c
R13: 00007f88aaddb0a3 R14: 0000000000000001 R15: 0000000000000001
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

