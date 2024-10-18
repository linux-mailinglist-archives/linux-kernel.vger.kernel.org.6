Return-Path: <linux-kernel+bounces-371172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D109D9A3758
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391D6B242A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C218892F;
	Fri, 18 Oct 2024 07:37:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F152BAEF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237049; cv=none; b=YmVGHjLsnXvJyOoDrPG4lXNs8lHf7MxTvBXqRghsEgFnQ+slz31z2OMoZ7lNrsTewKoqiDAQDri6p+/pb8PUUHyuQ2qI+xn8SD1S/3SQ7u5ElB0ltv6uJ1rxyLZwfeYknhOBRfOUREkG7TTCkpGkQ0xq7vsO8bZV9G8vPvpv4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237049; c=relaxed/simple;
	bh=hejyEh3RChxOA1daD1B7HTMGP8OKjXtoT3B7nSTIWhQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V4nDz/xxXSGuHr+Je24X+iKkMVUokxBLFdEfe3ps+hQyh/RgG4uROAmhY/sdFop02+l+oMV9EuAEvon7Vj97cz4Cr5WwSCtO28dyMPRDQeLXvlZNgWU0stzpm0Mb1JCsyUd/aknwZFc/lZ/R+U8EuF/s9kAcX2YAgOvYi7pmqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae775193so20823245ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237047; x=1729841847;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iUgpqL/QL9sqs5jkJjWdaUKMNldK0FxvG1XNCpY6jg4=;
        b=dhfS0MSgQ5Ed4nFTIgTgJ1yaikM/7lzJLMjMkKdO1PszKcw7Mp04sOBb4eG7Jzaygg
         OISKxKAaWhBNsFaiRiJZ0YEQHlMXmtQrZ5ovfbs0sez9gpnpsEXSRAwQFzrK16m1L3T7
         9OK4MYfZgDuD4RZIQmoYcriyxK1UBBqlb6tPnfBBxK5b7l1sHWhLxZUeNfP/KSZvXZLb
         aIBZWTRQwXM8h/G575aMnJnzhpGzkbEfrD3RYfC5nQG4r1vsd2wDIOKAdiNKqTWJ50TQ
         v3HbKAK8g8y8H2BuwhRFwx8tQ8881n1SkmSKjr3nd19W/awSjCl2jJkGAJSsYEZ2ieb2
         bHzg==
X-Forwarded-Encrypted: i=1; AJvYcCWFP631EInaOKGfm7ne/oltN8+9gtiQlbhLsP1J/3uiEU8EfGPMigCottfFoX30HN3V/oyaOq1/fhICK+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPRQr1fxqWuBR2IbCzL9UBGPymUxdgVhLIjpPPqmaHe6pM0ke
	H+VNBAz/V7qStV6zLiZDbbb4Yafd6qHQhY2s1qYDNkoFHV8YjojXhB5Id7t/LoDgtnB+ujM9FNS
	RTv3eCsdA5Al71X367VxcqI9wD+5x+BN2r5sXtMiL3RD1NJvNtsclR/I=
X-Google-Smtp-Source: AGHT+IFkrwQ99XoMOST6rSiWosDk382Ip22TMomcmOQ0MI/E4kg/rFBIfAYl+EQd4fjbwwxtKuipG7xtQZePGLpLwrXTnahyWNX4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e07:b0:3a3:97b6:74fe with SMTP id
 e9e14a558f8ab-3a3f406fc96mr16141275ab.11.1729237047228; Fri, 18 Oct 2024
 00:37:27 -0700 (PDT)
Date: Fri, 18 Oct 2024 00:37:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67121037.050a0220.10f4f4.000e.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_fs_btree_cache_exit
From: syzbot <syzbot+4deac4f47f33e16f82b7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c964ced77262 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f10240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=4deac4f47f33e16f82b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10090240580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113be830580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fb46e19c1a07/disk-c964ced7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/521abb58e739/vmlinux-c964ced7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea079e4ac77f/bzImage-c964ced7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f2414169f0cc/mount_0.gz

The issue was bisected to:

commit bf4baaa087e2be0279991f1dbf9acaa7a4c9148c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 5 21:37:02 2024 +0000

    bcachefs: Fix lockdep splat in bch2_accounting_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166b0487980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=156b0487980000
console output: https://syzkaller.appspot.com/x/log.txt?x=116b0487980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4deac4f47f33e16f82b7@syzkaller.appspotmail.com
Fixes: bf4baaa087e2 ("bcachefs: Fix lockdep splat in bch2_accounting_read")

------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_cache.c:594!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5223 Comm: syz-executor386 Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:bch2_fs_btree_cache_exit+0x1124/0x1130 fs/bcachefs/btree_cache.c:593
Code: fd 90 0f 0b e8 dd 66 84 fd 90 0f 0b e8 d5 66 84 fd 90 0f 0b e8 cd 66 84 fd 90 0f 0b e8 c5 66 84 fd 90 0f 0b e8 bd 66 84 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003b37b20 EFLAGS: 00010293
RAX: ffffffff84108043 RBX: 0000000000000002 RCX: ffff888024728000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 1ffff11005c49016 R08: ffffffff841076e7 R09: 1ffff1100bc503b6
R10: dffffc0000000000 R11: ffffed100bc503b7 R12: ffff88805e281c78
R13: ffff88805e280000 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055558a7d6380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc6ecbff000 CR3: 0000000074002000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bch2_fs_free fs/bcachefs/super.c:556 [inline]
 bch2_fs_release+0x20e/0x7d0 fs/bcachefs/super.c:610
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2403
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc6f42275f7
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffdf9e61628 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fc6f42275f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffdf9e616e0
RBP: 00007ffdf9e616e0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffdf9e62750
R13: 000055558a7d76c0 R14: 431bde82d7b634db R15: 00007ffdf9e62770
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_fs_btree_cache_exit+0x1124/0x1130 fs/bcachefs/btree_cache.c:593
Code: fd 90 0f 0b e8 dd 66 84 fd 90 0f 0b e8 d5 66 84 fd 90 0f 0b e8 cd 66 84 fd 90 0f 0b e8 c5 66 84 fd 90 0f 0b e8 bd 66 84 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003b37b20 EFLAGS: 00010293
RAX: ffffffff84108043 RBX: 0000000000000002 RCX: ffff888024728000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 1ffff11005c49016 R08: ffffffff841076e7 R09: 1ffff1100bc503b6
R10: dffffc0000000000 R11: ffffed100bc503b7 R12: ffff88805e281c78
R13: ffff88805e280000 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055558a7d6380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc6ecbff000 CR3: 0000000074002000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

