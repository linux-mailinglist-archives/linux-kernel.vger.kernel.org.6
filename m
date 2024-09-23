Return-Path: <linux-kernel+bounces-335448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62A97E5DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECBC1C20C03
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41390179A8;
	Mon, 23 Sep 2024 06:07:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556810A3E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071649; cv=none; b=tBo/UBQbQl30neYAq4M/t52S/oYU/AYh70zXEEr80PJStt8PkNqMToerMF0slBrGBuQHZ7IruFrR09gG0tnqABSKNVHDwAHqzmX6wDG9/AshwdmOiseoO2paNB9hX0TtcY+7gOoO08fqPMNFAh4Qd2JEtg9XeDRSh/d7SPjX9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071649; c=relaxed/simple;
	bh=BhzlxVaXIzg1geV/sFWQtnAbEsz37RDEkx8+wdfmHe0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qL0knJpWqQpG+kAx15wxNX7tU5Y+mlKfGd0nTAqWbGoQSk4dILzYXD0mQZ3+AoRgQ+ToVmeekdDKWoG2XhH2wmMPYMwipovR/Xg9X3q4J3Ri2V88RA5aIUVMzzcxe5UdRryOqoBAHf9moKA/zQ/bpQK2x05DE7XObzd49j4jULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cd6a028bso24127075ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727071646; x=1727676446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xh57jcqwsNfQFFP8jKv5EPTay9rC/zkzDfWjGSosjtc=;
        b=vQnGGFzejFqlWQEdQEaag+ekUwIbabfcV4JFhaMbRG5qr3OMe3w0S/O7VubtWFguHd
         PcgyCO9hobp2r6Kjn2IxRwZjcN/iw6RnG3gXo6XSn6WUxny9f4DIjCkzOFQ0TM9DEjQ/
         CtDfQBT8p8SDYQrUxkRDPrVB1SH0K+d+oB2TVRKDduJERXR66ygIoe8GWOAnxWQO6M8k
         gXVS9HXN6ECd+RjeVT3Xs274jPvLFsRpfjrPOF+c0VJZ3tz/jQrC+Wkl9GEJhUwGzD2x
         5hc4zfbxWb/16PF8II6rT1ESUaGd2pR3aRhDFOAyjkYTl79kLhwdamr/AMQQr+rGj+lf
         hnLA==
X-Forwarded-Encrypted: i=1; AJvYcCWwMx5s4wBg5OSV/+jwARyV7MaAoWAiwAanXdadiV86tA36VbIguIb+bqXcTsNJ3GHJYQtyTNLT5UlZfak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7L6G7LYbwjdB7V9M2NGUC5BmI9Wx+RLhktqdjzi67l/iuuv6
	jFNRrDIAGZQNTsUAPv8Zuw0e7LHJUvwTakSgN6nofJclsIQg3/SsOb/On/5aF0cv/8+48DSZfEH
	bV+B6YKk84aLIKnU7w8KW62m8iFD88SeTSQLYPSFFNUpLGc7lMiJnvb0=
X-Google-Smtp-Source: AGHT+IFUJyccPwsx2a1Dl+/NJ+Sb0BlTTzm487aEsEvoTv4fLhXg9/BSGoT2yRRRZGPJJOm1EUe2XhsaFT+3iVmnmpnYS2jBYIvc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c269:0:b0:3a0:a08a:a0d3 with SMTP id
 e9e14a558f8ab-3a0c9d6f25emr71948075ab.18.1727071646261; Sun, 22 Sep 2024
 23:07:26 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:07:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1059e.050a0220.c23dd.0007.GAE@google.com>
Subject: [syzbot] [jfs?] WARNING: locking bug in release_metapage
From: syzbot <syzbot+1a1e162a53d52033318c@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14600ca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
dashboard link: https://syzkaller.appspot.com/bug?extid=1a1e162a53d52033318c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4a39ac5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e77a3b8ac098/vmlinux-4a39ac5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8ee7a5fea46/bzImage-4a39ac5b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a1e162a53d52033318c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
ERROR: (device loop0): xtSearch: XT_GETPAGE: xtree page corrupt
ERROR: (device loop0): remounting filesystem as read-only
xtLookup: xtSearch returned -5
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5119 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 5119 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4823 [inline]
WARNING: CPU: 0 PID: 5119 at kernel/locking/lockdep.c:232 __lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5149
Modules linked in:
CPU: 0 UID: 0 PID: 5119 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4823 [inline]
RIP: 0010:__lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5149
Code: 00 00 83 3d 75 3a ac 0e 00 75 23 90 48 c7 c7 a0 d7 0a 8c 48 c7 c6 40 da 0a 8c e8 1f cc e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0000:ffffc90002e2ef30 EFLAGS: 00010046
RAX: 265537614b058400 RBX: 0000000000000b90 RCX: 0000000000040000
RDX: dffffc0000000000 RSI: 0000000000020741 RDI: 0000000000020742
RBP: 000000000000000f R08: ffffffff8155c052 R09: 1ffff11003fc519a
R10: dffffc0000000000 R11: ffffed1003fc519b R12: ffff88801dd1c880
R13: 0000000000000b90 R14: 1ffff11003ba3a7f R15: ffff88801dd1d3f8
FS:  00007fdc842196c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc8350c538 CR3: 000000003da9a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
 unlock_metapage fs/jfs/jfs_metapage.c:39 [inline]
 release_metapage+0xb2/0x960 fs/jfs/jfs_metapage.c:763
 xtTruncate+0x1006/0x3270
 jfs_truncate_nolock+0x2e4/0x390 fs/jfs/inode.c:373
 jfs_truncate+0xcb/0x140 fs/jfs/inode.c:412
 jfs_setattr+0x526/0x780 fs/jfs/file.c:119
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3395 [inline]
 do_open fs/namei.c:3778 [inline]
 path_openat+0x2e1e/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc8337def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdc84219038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fdc83535f80 RCX: 00007fdc8337def9
RDX: 0000000000000200 RSI: 00000000200002c0 RDI: ffffffffffffff9c
RBP: 00007fdc833f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdc83535f80 R15: 00007fff54a45628
 </TASK>


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

