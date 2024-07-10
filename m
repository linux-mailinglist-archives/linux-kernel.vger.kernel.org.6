Return-Path: <linux-kernel+bounces-248234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AAE92DA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC4B1C20F92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79A198A0A;
	Wed, 10 Jul 2024 20:55:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB522B9DD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644922; cv=none; b=WyCFP0zNyKdniyR/8dNaFRGBQ2tfJUsFMqSObwYFGRdD2IiTR4peBL5IVaVoQtVpY76/9oHwRtkBsy9vDFsmn5RvYZI2x0y/1ite34F9byJMtKZRepqhZDHoALm8byibp1hz8t7Qn2X+BGSbsA/ADtFxP44kEz8C8iZBQ2L1j0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644922; c=relaxed/simple;
	bh=Z3msdCwZonGqDZRlBiN5ShCyZpNZWaG9kp5EzTpSBjY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u9ZnR615IOzVlNwngorRz4eGHxqAp0rVwzfERztqGyFe+Z1aJ12nvxuzfI03YXCaBdi5meoMOzP7hAyB28IDat6SsChikNongIYIuIF+W0xhhxuhjyDVb3K9ZhbOfo+YarWRuTXB9Ci9CeJKPED3q5IuIbyrTOBiVQXhqBadNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f6530b381bso25168639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720644920; x=1721249720;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVRhbjkp4RzkM3/82P29L6wAC8vxTTrCxzWywY06HU0=;
        b=hgn5lqqWWzsc8RB2y14KFvhjCVLyu96jbrS0ykASrRnQ7xvKU8PbJ2mmokjXX5JUKb
         Q8qFhmn6Jczv+uGTAIL2oHp61s2sVmAibzceGneTMhJS4ah9RJC/oGeDAdNcu0b4bNXO
         1vQB4oE8p718bbf+6icRAaKrRJUORXQFL3D/Nk2SHev86u0uqLmbYZ/x7OgQx7lvHXiV
         2H+Z/Ui+4WWR/DaWRNjrS4FCDOkxS5/dnH1Rx2X8L5KvtKEejeh+w4cauuY689vpm/Bs
         rjt80DR3aC95iUuraE2N3qSC5RkKtw27dTR09Yxj0ktQrexxJoASXco3brbLkeP5JMTv
         3SnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5GrJM95F5PHw312lUSHeBC7vSlY5r4lZnJd4OiOnuGgNkHjEiqMrC8BrMzXHXSg0Mfa/tUfgHhu5+9HO0NcnbUgOGbIEmHZaAjZEE
X-Gm-Message-State: AOJu0YwuVI1oQg2kqEz7puM2UKhiSycUgZFhQA3URMbo2L29jvPh3ZRE
	WvZSEt821qoGmchr+mJbW8obtABszkL7LSaoFinhXcdB30W/56mOcSqr4NiCkSGboC0Eb4QZrSS
	x0n2hDbeKtnDh+aQNLg3AtaHG89dr7aykpK5y489fjVbiZS/nKWXTkXQ=
X-Google-Smtp-Source: AGHT+IFhUyK1jBppUDIb4IBhN3hn+o8k3Wficd9+yDN9UuekxAY0t2cBOiWb2mYJkD5w9F7lkppg5TYKO9xNZKsK1u3o16bv0xUb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1316:b0:4b9:6637:4909 with SMTP id
 8926c6da1cb9f-4c0b2bd6b00mr472236173.6.1720644920235; Wed, 10 Jul 2024
 13:55:20 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:55:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004169f9061ceadd8a@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_journal_noflush_seq
From: syzbot <syzbot+85700120f75fc10d4e18@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1dd28064d416 Merge tag 'integrity-v6.10-fix' of ssh://ra.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d3d4a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=85700120f75fc10d4e18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120f9c9e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158b8d69980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a42549877f5c/disk-1dd28064.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f2b9c801a744/vmlinux-1dd28064.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c16f617bb3d0/bzImage-1dd28064.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f0142c51dc8c/mount_0.gz

The issue was bisected to:

commit f7643bc9749f270d487c32dc35b578575bf1adb0
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Apr 17 05:26:02 2024 +0000

    bcachefs: make btree read errors silent during scan

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e4c7c1980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e4c7c1980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e4c7c1980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85700120f75fc10d4e18@syzkaller.appspotmail.com
Fixes: f7643bc9749f ("bcachefs: make btree read errors silent during scan")

------------[ cut here ]------------
kernel BUG at fs/bcachefs/journal.c:105!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5083 Comm: syz-executor282 Not tainted 6.10.0-rc6-syzkaller-00212-g1dd28064d416 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:journal_seq_to_buf fs/bcachefs/journal.c:105 [inline]
RIP: 0010:bch2_journal_noflush_seq+0x320/0x330 fs/bcachefs/journal.c:805
Code: e8 f5 ba 65 fd 48 8b 3c 24 e8 6c a3 57 07 44 89 f0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 d1 ba 65 fd 90 <0f> 0b e8 c9 ba 65 fd 90 0f 0b 66 0f 1f 44 00 00 90 90 90 90 90 90
RSP: 0018:ffffc90002eeed78 EFLAGS: 00010293
RAX: ffffffff84306bef RBX: 000000000000000e RCX: ffff8880264f0000
RDX: 0000000000000000 RSI: 000000000000000f RDI: 000000000000000e
RBP: ffff888076a4aa80 R08: ffffffff84306a49 R09: 1ffff1100ed4954f
R10: dffffc0000000000 R11: ffffed100ed49550 R12: ffff888076a4a548
R13: dffffc0000000000 R14: 008bf40000000001 R15: 000000000000000f
FS:  0000555572c0e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555572c1f738 CR3: 000000007ab70000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_trigger_alloc+0xa4a/0x3e10 fs/bcachefs/alloc_background.c:854
 run_one_mem_trigger+0x7e9/0xb90
 bch2_trans_commit_write_locked fs/bcachefs/btree_trans_commit.c:713 [inline]
 do_bch2_trans_commit fs/bcachefs/btree_trans_commit.c:876 [inline]
 __bch2_trans_commit+0x5083/0x88e0 fs/bcachefs/btree_trans_commit.c:1119
 bch2_trans_commit fs/bcachefs/btree_update.h:170 [inline]
 bch2_inode_delete_keys+0xae8/0x1440 fs/bcachefs/inode.c:845
 bch2_inode_rm+0x165/0xd40 fs/bcachefs/inode.c:874
 bch2_evict_inode+0x21c/0x3c0 fs/bcachefs/fs.c:1588
 evict+0x2a8/0x630 fs/inode.c:667
 do_unlinkat+0x512/0x830 fs/namei.c:4420
 __do_sys_unlink fs/namei.c:4461 [inline]
 __se_sys_unlink fs/namei.c:4459 [inline]
 __x64_sys_unlink+0x49/0x60 fs/namei.c:4459
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8443dc9b17
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc4d875828 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8443dc9b17
RDX: 00007ffc4d875850 RSI: 00007ffc4d8758e0 RDI: 00007ffc4d8758e0
RBP: 00007ffc4d8758e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffc4d8769d0
R13: 0000555572c17700 R14: 0000000000000001 R15: 431bde82d7b634db
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:journal_seq_to_buf fs/bcachefs/journal.c:105 [inline]
RIP: 0010:bch2_journal_noflush_seq+0x320/0x330 fs/bcachefs/journal.c:805
Code: e8 f5 ba 65 fd 48 8b 3c 24 e8 6c a3 57 07 44 89 f0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 d1 ba 65 fd 90 <0f> 0b e8 c9 ba 65 fd 90 0f 0b 66 0f 1f 44 00 00 90 90 90 90 90 90
RSP: 0018:ffffc90002eeed78 EFLAGS: 00010293
RAX: ffffffff84306bef RBX: 000000000000000e RCX: ffff8880264f0000
RDX: 0000000000000000 RSI: 000000000000000f RDI: 000000000000000e
RBP: ffff888076a4aa80 R08: ffffffff84306a49 R09: 1ffff1100ed4954f
R10: dffffc0000000000 R11: ffffed100ed49550 R12: ffff888076a4a548
R13: dffffc0000000000 R14: 008bf40000000001 R15: 000000000000000f
FS:  0000555572c0e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555572c1f738 CR3: 000000007ab70000 CR4: 00000000003506f0
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

