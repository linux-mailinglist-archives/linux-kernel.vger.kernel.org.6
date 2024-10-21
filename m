Return-Path: <linux-kernel+bounces-374406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC859A69DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19F3B2A77F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98C1EE022;
	Mon, 21 Oct 2024 13:07:43 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082801D26E9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516063; cv=none; b=tyws1K2siuMsBheeQLP9pLQjehJE4i5qCCnBhYtLIAVNwTTP5UiQvzTlQsLR/JV6T+D0MJ29agywWY5CbkgPhVZR565CFQmZQ20hBaDXC61bN39ZBtWVKVvhCkualqONpqxIKWkvdvsqwn/ePvEUxMMxesVeelRN7N6Q4n0orHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516063; c=relaxed/simple;
	bh=5Ifj4Sp13dHucqKkTQuEhcox6XUMdqjWTOIw2lr9WTQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N25g79PqJ6tepewFbOe83Cv+kDOrBlq3RBmYWjnwO9mZBuJ6yrxD7lR/qUEqkRtmZxhEyS11QEcvJL2+5b4v+7NYwdXeZ/sDXxuH2cwC7JfOTRuFhtYRa1I4/V/mTRjKAapp1HEviij3Z1fgnQNc2TmywMVS2JNsBOpkUC3/LUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c5b90293so38379355ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729516060; x=1730120860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avKkSIJdplTpCHpPm7V8BJnb89UfH6875r+tEKrJznY=;
        b=JTkR9MrnVfW54H4ympsTYVoMr/iLN0CKD6VWMvRaDt3letyqYv8zmzkbvQyh5ZawS7
         jrptLwedzVLga7k6UJhiFwLWz20awSUaIzZNJdmEwp793GTz7pCSrjfHAVV1L1iOcgOA
         ftBI9zMPxgWRfVHzqhmXj/31h3tEbeybhkkQFITMVjBwYzSmItXFYOkErnq94Z5/0y5e
         0Q8tBlTchPYe8UdUxEBuhYlDGtMveG0cmYasYeFrTOd1qLtEnTgtPevjdhgi3Fo/n8SG
         umm9yWy6+hTVVA4XE0eQCLH5PgZ3DobsPq4PaUE8VhG1hUCc2iyEo1e9uHuz33+/vozB
         PK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxZp/PGw4Hw7N8NQWEVC0Dp5IXTNLyUC9QPkUo8Xr3fDEzybsDoPCiIqS3jHjCAS51jfSqLhN2E41rDEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcBT0LeQA0KSljOI4xd0HRN3+Q40g+gnaKLomkPpONegOCIDM
	LixMVCSQsxeYW75N/vwcP1DwS/Nc/4TyDqIECVFuEBWBtdeyaIfFVgA5qTX23kvjqRqCzws+B0S
	YTjCkhDo20OLqHqahnw/c5LSycd91Om69L1uRaYQI5D9JoaLNISkcFNU=
X-Google-Smtp-Source: AGHT+IEfM1SxMR602Gv3uvZ9LAUePUEeFHq+e6NXJc8W9Cu2+R8RMwypX6k17FzaQ+miCdUY/DjBzbvJlbMr7mLXM+TdItwOBo8G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a81:b0:3a3:4175:79d2 with SMTP id
 e9e14a558f8ab-3a3f4073c20mr112039805ab.14.1729516059938; Mon, 21 Oct 2024
 06:07:39 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:07:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716521b.050a0220.1e4b4d.0059.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_journal_key_insert_take
From: syzbot <syzbot+47f334396d741f9cb1ce@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a5c240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=47f334396d741f9cb1ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11044487980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12815830580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c85347a66a1c/vmlinux-15e7d45e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/648cf8e59c13/bzImage-15e7d45e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6ba77e840d2c/mount_0.gz

The issue was bisected to:

commit d59f4aba096298347f0e0e5402843bb8505edc2d
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 12 02:53:09 2024 +0000

    bcachefs: -o norecovery now bails out of recovery earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1580c487980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1780c487980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1380c487980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47f334396d741f9cb1ce@syzkaller.appspotmail.com
Fixes: d59f4aba0962 ("bcachefs: -o norecovery now bails out of recovery earlier")

------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_journal_iter.c:190!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 1169 Comm: kworker/1:2 Not tainted 6.12.0-rc3-next-20241016-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: bcachefs_write_ref bch2_delete_dead_snapshots_work (bcachefs-delete-dead-snapshots/)
RIP: 0010:bch2_journal_key_insert_take+0x180f/0x1830 fs/bcachefs/btree_journal_iter.c:190
Code: f1 fc ff ff e8 d2 51 78 fd 90 0f 0b e8 ca 51 78 fd 90 0f 0b e8 c2 51 78 fd 90 0f 0b e8 ba 51 78 fd 90 0f 0b e8 b2 51 78 fd 90 <0f> 0b e8 4a a1 af 07 e8 a5 51 78 fd 90 0f 0b e8 9d 51 78 fd 90 0f
RSP: 0018:ffffc9000430edc0 EFLAGS: 00010293
RAX: ffffffff841c909e RBX: 0000000000000040 RCX: ffff8880272b8000
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: ffffc9000430ef30 R08: ffffffff841c7a8e R09: 1ffff1100de80035
R10: dffffc0000000000 R11: ffffed100de80036 R12: 0000000000000000
R13: ffff88806f400000 R14: dffffc0000000000 R15: ffff88806f44b310
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559ab32ac530 CR3: 00000000744be000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_journal_key_insert+0xb3/0x130 fs/bcachefs/btree_journal_iter.c:260
 do_bch2_trans_commit_to_journal_replay+0x111/0x420 fs/bcachefs/btree_trans_commit.c:1003
 __bch2_trans_commit+0x15d9/0x9420 fs/bcachefs/btree_trans_commit.c:1039
 bch2_trans_commit fs/bcachefs/btree_update.h:184 [inline]
 bch2_delete_dead_snapshots+0x19b6/0x5ae0 fs/bcachefs/snapshot.c:1655
 bch2_delete_dead_snapshots_work+0x34/0x40 fs/bcachefs/snapshot.c:1730
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_journal_key_insert_take+0x180f/0x1830 fs/bcachefs/btree_journal_iter.c:190
Cod


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

