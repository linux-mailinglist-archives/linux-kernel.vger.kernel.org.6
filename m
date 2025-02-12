Return-Path: <linux-kernel+bounces-511074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1233A3256D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C25E1684C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653E20B1ED;
	Wed, 12 Feb 2025 11:52:25 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028F20AF8E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361145; cv=none; b=JRdfMMnQwlKjZMMkUzS1R5ZhoxqZsRqrtTvsW+sEPYAJgJ/Zld5m6p1QXe+YXXnhsYeamJ+LS58njodKRg84pUV3nExhzqIBfNAZTyLkwswF5TyDY7wZl/hh9zoypDcr4qmEWMnAj2saIiRNvZJ2k01I9ZYW5ZKuVmLn+DUOvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361145; c=relaxed/simple;
	bh=kWVSpqoeQhIJXhXKuwCnMmRQS0+ovdq7pd6yO5lK9F0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KShk+7Qjh48SzUZsrP7sLkygxkpQnPEuYq8ZrB/fu2gOT+IPMSdo9ICl1iFu/CjYwz2Q8X68whq2rxZZUq5mf+5CUhGmwviZt/rYX1YmTUIV+NO6onwn0ImrnLfJKgQsSpZOPHJxEoiLqBypebz7meO/xWsdpxMoG1iA02tmReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d14bf806acso88389985ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739361143; x=1739965943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxLGhq00wdOL+UyaW3IIL087bxULrFbeU4YWXL74hiw=;
        b=oIM3Dsq2ghplrQ/I97q947Y5BFpMVftThzqUtqm+cGG10saAjBix8kyDSlZTtRD6VN
         rHGabBxzkOPFY/Pc1kMp/evfdbbQC4lsYCy75ZwDXaci0Ij4mrqjrhpnfT9huBL+VV4A
         Mlk65mehe78oWqizPrlIGR3mt1cPka4lJJWIjKKMpFiZPCRjAf1i9pxsCamdP5ljFLOD
         Qf+bCBalm3kw5xtIliQovRQsOGeTJ793ajtPj92N78Q64ABcnzfPzmlV3iqQCFNBmzBj
         jqQ+D5PE9kzDTr135aA4sNtmku6XrjehwCLfLqYMm7cYbfsr0C8nI2iQOa/A77JPTtVu
         fs4g==
X-Forwarded-Encrypted: i=1; AJvYcCXW+w07VLvTGTcbYswKQ+KxCtfe/amYyIPlHdOucpEIWkYPXud3jf3YcXxBZhEOm86I4TwNBSOf82DXzWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxbLLFJOthZ+6XZj6NzeX/0NHaAzvORihdV3+ao7F6kahgSxnC
	H/TZwEvYOjfQ4FJqvsSynEnGtiK/AsYqjbs48zo6RmWuZL121Bf6kpDn1rkLrbJqiBC+WKbLd2S
	K8PogWUsbrlHO+Q3Utj+oFwBS6qCtiuGIdBE0b+dJ6+qS1StdANWpbgA=
X-Google-Smtp-Source: AGHT+IH5T10ag3TdAdWLX/3uGYT0rhtfQzMzRhu11CNjuQ2mVUmi1zR7MMFxUvQQJ/o7312e0Yp21C/cLYTP6cWGRRXrvsqp12Bk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e2:b0:3d0:123e:fbdd with SMTP id
 e9e14a558f8ab-3d17bf37929mr23235785ab.11.1739361142802; Wed, 12 Feb 2025
 03:52:22 -0800 (PST)
Date: Wed, 12 Feb 2025 03:52:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ac8b76.050a0220.3d72c.0167.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_journal_keys_peek_max
From: syzbot <syzbot+9b22c314d51cfbcd1ddc@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12213b18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=147b7d49d83b8036
dashboard link: https://syzkaller.appspot.com/bug?extid=9b22c314d51cfbcd1ddc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1580c2a4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17026bdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c15b70890a6/disk-69b54314.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0db5658a86a2/vmlinux-69b54314.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6a408104f8b/bzImage-69b54314.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1c7e787a9111/mount_0.gz

The issue was bisected to:

commit 7e5b8e00e2631ee1fa72edeb420e7393ad078ab3
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Fri Oct 25 02:12:37 2024 +0000

    bcachefs: Implement bch2_btree_iter_prev_min()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11572b18580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13572b18580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15572b18580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b22c314d51cfbcd1ddc@syzkaller.appspotmail.com
Fixes: 7e5b8e00e263 ("bcachefs: Implement bch2_btree_iter_prev_min()")

------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_journal_iter.c:83!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor138 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:bch2_journal_keys_peek_max+0x164f/0x1660 fs/bcachefs/btree_journal_iter.c:83
Code: 10 48 8d 5c 08 18 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 ff b1 e1 fd 4c 8b 33 e9 d7 fe ff ff e8 12 a0 7d fd 90 <0f> 0b e8 2a 49 ac 07 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc90003fae620 EFLAGS: 00010293
RAX: ffffffff8441af2e RBX: 000000000000003b RCX: ffff88807f1c1e00
RDX: 0000000000000000 RSI: 000000000000003b RDI: ffffffffffffffff
RBP: ffffc90003fae7e0 R08: ffffffff84419a25 R09: 0000000000000000
R10: 00000001ffffffff R11: 2000000000000000 R12: dffffc0000000000
R13: ffff888074e00000 R14: ffffffffffffffff R15: ffffc90003faf018
FS:  000055558406b380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffdf737ed0 CR3: 0000000076148000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_btree_journal_peek fs/bcachefs/btree_iter.c:2137 [inline]
 btree_trans_peek_journal+0x342/0x5a0 fs/bcachefs/btree_iter.c:2166
 __bch2_btree_iter_peek fs/bcachefs/btree_iter.c:2303 [inline]
 bch2_btree_iter_peek_max+0x1502/0x6320 fs/bcachefs/btree_iter.c:2367
 bch2_btree_iter_peek_slot+0xe0a/0x27c0 fs/bcachefs/btree_iter.c:2820
 bch2_btree_iter_peek_prev_min+0x1f3/0x6390 fs/bcachefs/btree_iter.c:2606
 __bch2_resume_logged_op_finsert+0xd5c/0x3650 fs/bcachefs/io_misc.c:431
 bch2_fcollapse_finsert+0x257/0x380 fs/bcachefs/io_misc.c:535
 bchfs_fcollapse_finsert+0x3a8/0x630 fs/bcachefs/fs-io.c:594
 bch2_fallocate_dispatch+0x3c9/0x540
 vfs_fallocate+0x623/0x7a0 fs/open.c:338
 ksys_fallocate fs/open.c:362 [inline]
 __do_sys_fallocate fs/open.c:367 [inline]
 __se_sys_fallocate fs/open.c:365 [inline]
 __x64_sys_fallocate+0xbc/0x110 fs/open.c:365
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff945c437d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0aa22888 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fff0aa22890 RCX: 00007ff945c437d9
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000004
RBP: 0000400000000000 R08: 6c616b7a79732f2e R09: 6c616b7a79732f2e
R10: 0000000007000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff0aa22a78 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_journal_keys_peek_max+0x164f/0x1660 fs/bcachefs/btree_journal_iter.c:83
Code: 10 48 8d 5c 08 18 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 ff b1 e1 fd 4c 8b 33 e9 d7 fe ff ff e8 12 a0 7d fd 90 <0f> 0b e8 2a 49 ac 07 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc90003fae620 EFLAGS: 00010293
RAX: ffffffff8441af2e RBX: 000000000000003b RCX: ffff88807f1c1e00
RDX: 0000000000000000 RSI: 000000000000003b RDI: ffffffffffffffff
RBP: ffffc90003fae7e0 R08: ffffffff84419a25 R09: 0000000000000000
R10: 00000001ffffffff R11: 2000000000000000 R12: dffffc0000000000
R13: ffff888074e00000 R14: ffffffffffffffff R15: ffffc90003faf018
FS:  000055558406b380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005572817bb0e8 CR3: 0000000076148000 CR4: 00000000003526f0
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

