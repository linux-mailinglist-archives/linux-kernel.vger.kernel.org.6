Return-Path: <linux-kernel+bounces-207357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3943901617
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C172817C0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5443D0A4;
	Sun,  9 Jun 2024 12:28:31 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15B43AA8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717936110; cv=none; b=Zx7MJRiDHmkIZOXcClYTn94SFiPSNrevUDpEYk09pnZJinFc1OLUNTw02/U1SZ3YBclf9ng9TG1XHXalL0tRZHHlgEU2/WMqt1O3VJc1axkvbzm/lX4rjkmKqcGly8w0b+6pQPmxi/nmf2B9NX8kD3hm3SL7qtbFIPPqQZsm+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717936110; c=relaxed/simple;
	bh=K0ORc1aeAcAcGcGkRWK0VUE1Qupq6YMjDHlrOtZc548=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bNZBm6nZIHVhigDfkcSCgAW2rdx3YDkIYe5d0WySUpE6cUDLZra2L85b8k4M+zzrkGHsJCouz90x0ofa1BsBLKUgpM3p3LNKV0GSvqAmcHIH/o5QGlTFaC5ExWQqiVWSGkMWEmIYQHJxY7gbZj+6XqOmDx6OOkTZDc+4rSQOgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-375a26a094dso2824075ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 05:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717936108; x=1718540908;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SI4BosB179rlU4hZe0+UZ/iNfuHMZo8+aaLPxTAP5Fw=;
        b=qS9aV0DGxE4RLqmtSXqL02wG50iUJyH9P89atRX/DzLumOzIGomNdgrnWNohZYZpYk
         cD/ynzTaKDNaJYa65O9jVvrKfhVVNLfelb6M3R3LCiFleReloCkAHW0KrlLuYz6deItx
         yv1Jppoqm0KubbCx6oQ6ClpONGR131nHWDoi1lxmkLhCAqrcY78YSklNBoKSOVDB4WxD
         iQ1AA9oG9P/u2WCXGxzju/OMShc7I8Fbi+bYNdNF9mMPbMnb1F/VGXWwKVwePyO6v7MD
         mdS+JJx1VdyU2CslbuwsapFgCh7Yy6CZprn3MqdBd5t0AfqWBP1OYSY9HINCreiVSfk/
         4qgA==
X-Forwarded-Encrypted: i=1; AJvYcCUfdEkzU5nNyu0qFOPtPxs2Ffpayny7MaAcV+YYbqYTzZkJok0odswH8Q1B13yxnp20V+t+XhwpK07lfp5jXEEWBiBbmFoQWv1ba6En
X-Gm-Message-State: AOJu0YxqjUXla1aM8LKjYz+J2sw5+pu80bnXGcJoauXBUs94rl6pw97y
	DKQNgBRdlGnPw6DnynaI1KeV8bl8/c1mtzc2eQXfoy4D0kU5j05weeDN2KA7d7YvoKsGcHJrrN2
	/WaPz9ryA+SMifHdn9d1SfQWsPyEQbdDiTxhoQuxICt0yVvAm7C0PTbw=
X-Google-Smtp-Source: AGHT+IG5vP1AtUPLYy+C2Ht2vR/qae/HcDftvWFKZz2sbQKnWNAGK43Jfp66AjTBawMqJgkVXlnKMR1YYqbhfiD7/MRokAdsCmrT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:374:a422:b90 with SMTP id
 e9e14a558f8ab-375803827abmr3223565ab.3.1717936108471; Sun, 09 Jun 2024
 05:28:28 -0700 (PDT)
Date: Sun, 09 Jun 2024 05:28:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e1964061a742b0a@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_mb_add_groupinfo
From: syzbot <syzbot+9316d51d9d379787e4ad@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32f88d65f01b Merge tag 'linux_kselftest-fixes-6.10-rc3' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105806bc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a1d4156cdd1d8e2
dashboard link: https://syzkaller.appspot.com/bug?extid=9316d51d9d379787e4ad
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-32f88d65.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4330b2cd167b/vmlinux-32f88d65.xz
kernel image: https://storage.googleapis.com/syzbot-assets/961415fd7b0b/bzImage-32f88d65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9316d51d9d379787e4ad@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 1024
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(l->owner)
WARNING: CPU: 3 PID: 7049 at include/linux/local_lock_internal.h:30 local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
WARNING: CPU: 3 PID: 7049 at include/linux/local_lock_internal.h:30 ___slab_alloc+0x16c2/0x1870 mm/slub.c:3715
Modules linked in:
CPU: 3 PID: 7049 Comm: syz-executor.3 Not tainted 6.10.0-rc2-syzkaller-00022-g32f88d65f01b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
RIP: 0010:___slab_alloc+0x16c2/0x1870 mm/slub.c:3715
Code: a0 02 85 c0 74 09 83 3d 0f f3 04 0e 00 74 21 90 e9 30 ff ff ff 90 48 c7 c6 ff 20 3b 8d 48 c7 c7 28 ec 3a 8d e8 0f 5a 70 ff 90 <0f> 0b 90 90 eb c6 90 48 c7 c6 08 21 3b 8d 48 c7 c7 28 ec 3a 8d e8
RSP: 0018:ffffc9000394f830 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000246 RCX: ffffc90003db1000
RDX: 0000000000040000 RSI: ffffffff81500016 RDI: 0000000000000001
RBP: ffffc9000394f910 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff888024f90000
R13: ffff88804aaa4dc0 R14: ffffe8fefd34e860 R15: ffffe8fefd34e840
FS:  00007fe0ca3416c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c42d000 CR3: 000000001ebea000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmem_cache_alloc_noprof+0x2a7/0x2f0 mm/slub.c:4007
 ext4_mb_add_groupinfo+0x445/0x1180 fs/ext4/mballoc.c:3355
 ext4_mb_init_backend fs/ext4/mballoc.c:3434 [inline]
 ext4_mb_init+0x127a/0x2530 fs/ext4/mballoc.c:3732
 __ext4_fill_super fs/ext4/super.c:5501 [inline]
 ext4_fill_super+0x6d4f/0xace0 fs/ext4/super.c:5676
 get_tree_bdev+0x36f/0x610 fs/super.c:1615
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0c967e5ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0ca340ef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe0ca340f80 RCX: 00007fe0c967e5ea
RDX: 0000000020000040 RSI: 0000000020000200 RDI: 00007fe0ca340f40
RBP: 0000000020000040 R08: 00007fe0ca340f80 R09: 0000000000200000
R10: 0000000000200000 R11: 0000000000000202 R12: 0000000020000200
R13: 00007fe0ca340f40 R14: 000000000000057c R15: 0000000020000180
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

