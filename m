Return-Path: <linux-kernel+bounces-251706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66F930878
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 06:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB4F2821B7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 04:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2F9E54D;
	Sun, 14 Jul 2024 04:24:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80BB65A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 04:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720931064; cv=none; b=h+qd8l60wTxPnSBG9TF9fCH397ZN/+FG509l2UzrJcE8b/orAQRcEPUR1J3sZSpphitzeB6BgxzOEOapAvhOlv66QBozoOHgu/S+IeKtJQYHIWDYXkX2Jk08x9/gafLtjGkuuMxbkhmMsZtH0voTrW3dTKuhT5QTvYpTsFsxqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720931064; c=relaxed/simple;
	bh=5/NeYb4SikfIP3E9VtcfUyU1/ZasicZ8vsdl2IF2TTE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N7yTimydDp3G2kE2e3WfYp3S6tYNi/FR7ai1p3uwkmHR21kX93UfHe8BPQKgi/NgmDHQAJ1yAiN3CDIJcnNALi5EKPIb3/59hT0lC6fz2V/fGhfv0wVgA+gxUaQzVt71rO8HfId+lO87ohEBeP/JOqp7w01sUKOiR6izikldxeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f664993edbso365957939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 21:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720931062; x=1721535862;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FizaiPj6yRY8VQDGyWpC1JBxHfLynOdyNxko1Lx1BBo=;
        b=OGFJpn6yDUPWkbiJ0hqKohyGAiE+hBUPMH93pOEWAMhWaa3Kx01yMh0gkyWH3Syzj0
         J0UHOEqFzGl8xK81MMyWjSSjKJkKsMTNr15iKVt5FpkCrQ+uDUW4psXBQkBvaAyns/h4
         LOD5rxZj8bbgxUVGBrLzNi+gxy1/+mwkuHkIDpm/gxuiRcXpyJBGuNJ1O59mCzaK4ItN
         1NtOcM3r5k/1x63mdiZLDu0i7+o+efXE9ngVy/T9PrVf5gSly+0rRyD9UOJ3eHBoKf97
         /yTMW0WKFrahDidLMZnOOlYpYKs2PxyS3P6Ai5tXN3PZqrMcPRbFxotKhl0xZUJWXCzg
         1nhw==
X-Gm-Message-State: AOJu0YzfAPeosJKUpeu2i89i0hq1kkMGMZ8StvSXsG2Ec+Z5UyvrNn/C
	tDq0DHi1LH/LCHZO3PpYToJLy5M1+FKleuJwkv7965ujmjdMgD1Kjx4iO1bdzt2aDhuosBSlRO2
	8ggJFe/sUOgjTZ8TnWPMlrI+8V+CjOcd2rn07suTNAkBAxMee+kLK3+g=
X-Google-Smtp-Source: AGHT+IEYBnPWzejwFpA2BuX7L82pN+KqrQl9kfL1OQv4ZGE88Aakw9K60HErGIdZCfNKweicR8m4fCjEUurskeQJOm3Fq7j8wIVS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d5:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4c0b2b331c3mr1290853173.4.1720931061704; Sat, 13 Jul 2024
 21:24:21 -0700 (PDT)
Date: Sat, 13 Jul 2024 21:24:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dbab1061d2d7c99@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in sched_core_lock
From: syzbot <syzbot+7279b9b6b0c7cb9c118b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    34afb82a3c67 Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10dda985980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63b35269462a0e0
dashboard link: https://syzkaller.appspot.com/bug?extid=7279b9b6b0c7cb9c118b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7152efb66a56/disk-34afb82a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48c109ca6782/vmlinux-34afb82a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b91e0cb5d11/bzImage-34afb82a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7279b9b6b0c7cb9c118b@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 64
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 8713 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 8713 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 0 PID: 8713 at kernel/locking/lockdep.c:232 __lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 0 PID: 8713 Comm: syz.4.768 Not tainted 6.10.0-rc7-syzkaller-00012-g34afb82a3c67 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4773 [inline]
RIP: 0010:__lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Code: 00 00 83 3d 0e 08 3b 0e 00 75 23 90 48 c7 c7 e0 b9 ca 8b 48 c7 c6 80 bc ca 8b e8 18 e2 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90002e5f2d0 EFLAGS: 00010046
RAX: 4301f87ac8231900 RBX: 0000000000001ef0 RCX: 0000000000040000
RDX: dffffc0000000000 RSI: 0000000000007b5b RDI: 0000000000007b5c
RBP: 000000000000000f R08: ffffffff81585822 R09: fffffbfff1c39994
R10: dffffc0000000000 R11: fffffbfff1c39994 R12: 0000000000000001
R13: ffff888029625a00 R14: 000000000000000f R15: ffff888029626578
FS:  00007fdd20ea06c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020003040 CR3: 000000007a870000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 sched_core_lock+0x162/0x240 kernel/sched/core.c:340
 __sched_core_flip+0x176/0x440 kernel/sched/core.c:367
 __sched_core_enable kernel/sched/core.c:404 [inline]
 sched_core_get+0xbd/0x180 kernel/sched/core.c:422
 sched_core_alloc_cookie+0x71/0xa0 kernel/sched/core_sched.c:18
 sched_core_share_pid+0x298/0x7d0 kernel/sched/core_sched.c:185
 __do_sys_prctl kernel/sys.c:2729 [inline]
 __se_sys_prctl+0xe27/0x3990 kernel/sys.c:2457
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd20175bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd20ea0048 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 00007fdd20303f60 RCX: 00007fdd20175bd9
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000003e
RBP: 00007fdd201e4e60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdd20303f60 R15: 00007ffecf1eac68
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

