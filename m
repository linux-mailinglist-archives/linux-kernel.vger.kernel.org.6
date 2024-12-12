Return-Path: <linux-kernel+bounces-442552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B369EDE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109B21888DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D86153BF6;
	Thu, 12 Dec 2024 04:08:26 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379D257D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733976505; cv=none; b=bQJKDKIwflgcN9NOjlzMC7r6838+hwT1ZE6GYeySwHo6zr+Dlw7cPF51udvcuYIyRpep9SFj7rXjOBcxj7BZnj5aVwD9NXtFgWD+1T3lfiXtb366BZvpl6xJHjDtiNnatTZHQSgkGKUQxbMj2/vdBWcLN7A9VEQGd1POTnH/WYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733976505; c=relaxed/simple;
	bh=BcR4GWiJnxWccrq2UrzXIdHNMFVl7E8qTgLudfNhD3g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W4gNvkQCHDhmC9i6x8cA6gQN0kCqxY/ceAE8W3IBsgCscNpJKaHe2VBPLGf3o46BNhG7lFOIEHo7c2wdJa6gegcDcKIVpTH9SI1SCTcJ3F7zJbUykafrrsOBd5rgHZyuXXtfqIlG8A9npvvyci8zVdgMespoc5PCRbjqpj1Pljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso2315055ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733976503; x=1734581303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGI38PYexk+CxlMAAtU1uWM8gvxpaJ09c2Eqyvc9vo4=;
        b=M3MbpBWkPXxk+oJwyY5RE1h+oVDQOJlluIogI2bixjQBI8VyYkcdASCi8FMFLHEQKA
         8kgr5JVoHOKe3H5kHnZRfbhErHvbyv4HDMqXKUpZnNzo6FBUVbGZfNlEFObGnzqMSakn
         EtvSc8E/atIGo+VPLLLl/3UOJRb53uvMBxa/7yuqUrEGOJvfiaDkcCdlZrlzCvb0vqLD
         85Sxzph8kAIaq56aEAcVJozk9013J/5FzI+MVO5zfpOlN1/fdoJ16NxVJnzLC9/hU9a4
         ENjYKs8FEi6fS/NHv7RwBJEN0+71td/K/Yl+5faLK5dl7jAA+TXFzZcDx/UavQUlXfCl
         Z4Gg==
X-Gm-Message-State: AOJu0Yz6IwsCiWttb98G2GKMQ0SGRaW93QxeUiSWUjP0nuztpE8xaX+x
	6isUjtV0uZwiw2OLexATj0eZKDFa/r+koyybFQWWQnCzy6UKYukLXuHr8aaer64GhoN68fxYBTq
	GETVvaOvPU2bnd2IMZmKzUM58aYnaA14BbYNZe8DYgJamIxNWGUQbe/FBWQ==
X-Google-Smtp-Source: AGHT+IFekEQrqOXB/6x54gG6MNBiztebBxH0Se5Uo2fLDVcxbXJeHqpXMANi0KKDeRJXdeXtL9x43ZUMgpRw/Fs/1m25nOcLPXA/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3ac47d44b35mr15229295ab.9.1733976503371; Wed, 11 Dec 2024
 20:08:23 -0800 (PST)
Date: Wed, 11 Dec 2024 20:08:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675a61b7.050a0220.17f54a.004e.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in sched_mm_cid_exit_signals
From: syzbot <syzbot+a7dddc711489766b3d23@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7503345ac5f5 Merge tag 'block-6.13-20241207' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124e4820580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=a7dddc711489766b3d23
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f66ad6e028a7/disk-7503345a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/822436e7e431/vmlinux-7503345a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/264599a99f7f/bzImage-7503345a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7dddc711489766b3d23@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 7950 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 7950 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4850 [inline]
WARNING: CPU: 0 PID: 7950 at kernel/locking/lockdep.c:232 __lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Modules linked in:
CPU: 0 UID: 0 PID: 7950 Comm: syz.4.614 Not tainted 6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4850 [inline]
RIP: 0010:__lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Code: 00 00 83 3d 91 c8 9e 0e 00 75 23 90 48 c7 c7 20 95 0a 8c 48 c7 c6 20 98 0a 8c e8 17 62 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90005877670 EFLAGS: 00010046
RAX: 55799a8e77b73a00 RBX: 00000000000016d8 RCX: ffff88802d680000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000c16d8 R08: ffffffff81601c02 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff88802d680ac4
R13: 0000000000000005 R14: 1ffff11005ad0165 R15: ffff88802d680b28
FS:  00007fa9992c46c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c337a3a CR3: 000000005ebca000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:606
 raw_spin_rq_lock kernel/sched/sched.h:1514 [inline]
 _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1534 [inline]
 rq_lock_irqsave kernel/sched/sched.h:1799 [inline]
 class_rq_lock_irqsave_constructor kernel/sched/sched.h:1848 [inline]
 sched_mm_cid_exit_signals+0x17b/0x4b0 kernel/sched/core.c:10606
 exit_signals+0x357/0x5c0 kernel/signal.c:3111
 do_exit+0x6b4/0x28e0 kernel/exit.c:895
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3017
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa99857fed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa9992c40e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fa998746168 RCX: 00007fa99857fed9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fa998746168
RBP: 00007fa998746160 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa99874616c
R13: 0000000000000000 R14: 00007ffc44f667e0 R15: 00007ffc44f668c8
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

