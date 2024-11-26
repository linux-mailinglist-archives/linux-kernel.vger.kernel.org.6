Return-Path: <linux-kernel+bounces-421733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D09D8F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4762849AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86F75028C;
	Tue, 26 Nov 2024 00:00:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A932C95
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579229; cv=none; b=dNBBBPkgN79ln0yT8kSMArtkfIkgCdfqkCPHMKod9rkL5YvFkW4SThoiEVMOBeBquEjiQl9zAPmW695j398rlGVn7uk3+MvFh/SIG3GEVm00rw5DC9jGI7h5mpMLayBxEnGZUMa5nE71o1ChguCNTGYy/WhKm3/hlPBsgrf6Hbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579229; c=relaxed/simple;
	bh=saG60/wynrS6wXxgMC6P/mn7yXxobC6yhLIvsWevzXQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a68vvwUWr6H6l0CxkaNZ0Y1N7kehVw5bz35GsnTbNTwtKgQ7qVYdeO4YRRDoh7L1WecuLP30r+cdDOR2wgukmulc/tOZMdqw88TMv056A0ChMrPVIL3WlY68oo7PFCx04jfOiTMEfHWKLxxHDrlmrfXGvbVDsH0hyZOlwD7qAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7b30b03ddso20795495ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579227; x=1733184027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTxVRndIzMFiQrildLnogrEKpcut5mHcfiaAF0ID0rA=;
        b=sevG5rrJO6N9MNhCUOWKFXQdCm50aVM18lhEhBh+OqizTGPnz08g8lv+PCeW28DE/o
         01W+Dn5La8NqMZaLU6Z1uXWjp5ko+4sxdPDTFD9RFkXNbU9w0zMjdeobrYZcNuhdcsHO
         p8a/NhOZJ8ycAMgpL2oZP5MOILTBjADORzOiR+ktHpUNwf9/JMLrHjmHhIdokcn7vKul
         X3jNE/bRml4KGq5nDxHi7bcJ9y/QtdNAwwuqNH3lQFLLco+WZf3exoG0M/YcWrnghz1X
         GRrU99ralMbbpiB3KsvyYTXgtRA9RkdPUEyvkilD/RL7sVX/1V26zIoEzO1cjgryeNuE
         ABfg==
X-Forwarded-Encrypted: i=1; AJvYcCVZRYmDREbenRa8v9ERC3tHTAqq+yVcmcjhTHicL1jheaC30+3D0AjKZu0YDP8s13qKfWGXYT9oIbtNWIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77Oajvh0c6Agq0n88vdTXE8n1Qm1QaAwGV4XNdYO6bjCmBkEH
	8x/77I4L1a5gf/w6+ncxHxK3esCqhcwmQLceAoq0P2F49yqYmc+Hwa4sXl/mgu4TomueHCxx/X4
	ZhN32t3zJkN8aue0bo3pnNRjVBuu4aT18cadlpFrt1TRhgBjG7bYKcsc=
X-Google-Smtp-Source: AGHT+IEMqiYCWGRgxuA2PHH/ajse1RTikx/7/IqR5pUYZN/QScPO1Ga1UzSCPwcyjtT3flf9LV4CouoWbQSzenkRWhWZWlqNJzAR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3a79adc71b2mr152777095ab.9.1732579226839; Mon, 25 Nov 2024
 16:00:26 -0800 (PST)
Date: Mon, 25 Nov 2024 16:00:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67450f9a.050a0220.21d33d.0003.GAE@google.com>
Subject: [syzbot] [f2fs?] WARNING in f2fs_rename2
From: syzbot <syzbot+82064afd8bd59070fc22@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1374b6e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=82064afd8bd59070fc22
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1774b6e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1335975f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d32a8e8c5aae/disk-228a1157.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28d5c070092e/vmlinux-228a1157.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45af4bfd9e8e/bzImage-228a1157.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1e2338334d9b/mount_0.gz

The issue was bisected to:

commit 4c8ff7095bef64fc47e996a938f7d57f9e077da3
Author: Chao Yu <yuchao0@huawei.com>
Date:   Fri Nov 1 10:07:14 2019 +0000

    f2fs: support data compression

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=150076e8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=170076e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=130076e8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82064afd8bd59070fc22@syzkaller.appspotmail.com
Fixes: 4c8ff7095bef ("f2fs: support data compression")

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5835 at fs/inode.c:407 drop_nlink+0xc4/0x110 fs/inode.c:407
Modules linked in:
CPU: 1 UID: 0 PID: 5835 Comm: syz-executor143 Not tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:drop_nlink+0xc4/0x110 fs/inode.c:407
Code: bb 70 07 00 00 be 08 00 00 00 e8 27 d8 e5 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc e8 9d 40 7e ff 90 <0f> 0b 90 eb 83 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 5c ff ff ff
RSP: 0018:ffffc90003e377d0 EFLAGS: 00010293
RAX: ffffffff82170c43 RBX: 1ffff1100efa8122 RCX: ffff88802cca0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82170bc3 R09: 1ffff1100efa81af
R10: dffffc0000000000 R11: ffffed100efa81b0 R12: ffff888077d40910
R13: dffffc0000000000 R14: ffff888077d408c8 R15: dffffc0000000000
FS:  000055558e8f7380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000007ac16000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 f2fs_i_links_write fs/f2fs/f2fs.h:3127 [inline]
 f2fs_rename fs/f2fs/namei.c:999 [inline]
 f2fs_rename2+0x1b6c/0x2c30 fs/f2fs/namei.c:1272
 vfs_rename+0xbdb/0xf00 fs/namei.c:5067
 do_renameat2+0xd94/0x13f0 fs/namei.c:5224
 __do_sys_renameat2 fs/namei.c:5258 [inline]
 __se_sys_renameat2 fs/namei.c:5255 [inline]
 __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5255
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea51a18679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd47104348 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007ffd47104518 RCX: 00007fea51a18679
RDX: 0000000000000004 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007fea51a9b610 R08: 0000000000000000 R09: 00007ffd47104518
R10: 0000000020000100 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd47104508 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

