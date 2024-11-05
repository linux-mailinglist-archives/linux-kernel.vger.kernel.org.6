Return-Path: <linux-kernel+bounces-396119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AD19BC815
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5190F2837D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87DF1CDFB8;
	Tue,  5 Nov 2024 08:35:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BF13633F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795732; cv=none; b=abbrPOpMTtxGW1x3G1Ta9BrUjCH0hiQ/Gjra8p12cEMvhwkaauUydanI22focDqXzYZauFTT1iBf2EXNsUkJmKXobqYhhbD2A/es4bOVjYKN/juWdKUX14Dni8DTwkl3bCPyDw3Et2llZMWpLENKjK1YoYX2B05N3bZIIo6wL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795732; c=relaxed/simple;
	bh=/2kyD+72UszYeHBw8XDoFHwoW/81/FaJmGVnIumd/f0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iT0s0K5nXuKMpQ6WaVEZnIMd/O9xXzrBDrD0zp2Aj+MHHklnMM3pR3L2s9c5Rcufr7oSzcwSu0elp4oPSwtkIuX76HdU+P0TZYlj/HdrO8vduziaC/pp6NAVh7yueNRK1TKQkRkdBg8YGF7ZksBjquAjQqUbt0sifAidLlICHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3fa97f09cso55639185ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730795729; x=1731400529;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oviZhehDSsEpnXMuoH8iyR+xsk4jykhgYH2tvqOHVEc=;
        b=d93R0q31zu+/6WbLXAoEQuFjeKooLLUa20WSj4OkWYz78I4TKtgQevCaFT5MSQrLnp
         ciOuteRhI17IMGMF6TP4gsxHjHAS3cSdFGzwgI7sCox/hmpH2Qbhz0JyxKM96c6WlIzN
         2EkUAqDL1YV702hVg//bmXBRDmK9pnNlOnrzemVESIGbkuAv9vZxt4C5YrxD4LSzzvmH
         exek36is8yGAOubZqt5VahSR3AeUOVXi1tiWKXHwdcuK/UhaGoJP1aWZ4ZJCj87fZ71J
         xvQpnkPdt3M/QK8hxUYCk3Dqcy5hraQXy3m8U3AcnCg4aIrTpUaWbLiQP1NVrHWzdUhw
         5j/A==
X-Forwarded-Encrypted: i=1; AJvYcCV4nkOkIuzbl/80DWmiwxEONBMQUi/8VdQ3fEI7PhgfxnCXVOYLfo0kYEMiTwbCnbl+SHCZwFi5YEBfjPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4l+9XpuY0X0imWcQaAgrKWMfRils3KsRbPdgBNkbElDnokE3P
	GnHJVVvv+bVm6V61XmIZz70JZ90oGqhWjQE2WX6hs5ls6OI0LHJ8Ip3hrMRggjhf95wenPgt4qM
	scTO3S+JkK5kN+gsLoyxYFPsRK5YCsv6i3QdEzjfd9aVixRULBC5VHKo=
X-Google-Smtp-Source: AGHT+IFv07pVVVY8LHLcKsBF0K1au8ggHNhDSda/0ruptJ5yhwKV6+CbOw9aI16LzC2y9jEqdmOk5d0aBIuneUbYGF7/jEuXY2pi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e6:b0:3a6:ac17:13de with SMTP id
 e9e14a558f8ab-3a6b032b298mr157204745ab.20.1730795729760; Tue, 05 Nov 2024
 00:35:29 -0800 (PST)
Date: Tue, 05 Nov 2024 00:35:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729d8d1.050a0220.701a.0017.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] kernel BUG in free_bprm
From: syzbot <syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com>
To: brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, tandersen@netflix.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17911630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ebcda5c61915e91
dashboard link: https://syzkaller.appspot.com/bug?extid=03e1af5c332f7e0eb84b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1626d340580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10156187980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/02f4cb9cc7aa/disk-c88416ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/253f54d7165b/vmlinux-c88416ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f9612540588/bzImage-c88416ba.xz

The issue was bisected to:

commit 7bdc6fc85c9a1008e00e624612f82932136d7545
Author: Tycho Andersen <tandersen@netflix.com>
Date:   Wed Oct 30 20:37:31 2024 +0000

    exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f1aaa7980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1009aaa7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f1aaa7980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
Fixes: 7bdc6fc85c9a ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")

process 'syz-executor210' launched '/dev/fd/3' with NULL argv: empty string added
------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:23!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5846 Comm: syz-executor210 Not tainted 6.12.0-rc5-next-20241101-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__phys_addr+0x16a/0x170 arch/x86/mm/physaddr.c:23
Code: 40 a8 7a 8e 4c 89 f6 4c 89 fa e8 b1 4d aa 03 e9 45 ff ff ff e8 a7 1a 52 00 90 0f 0b e8 9f 1a 52 00 90 0f 0b e8 97 1a 52 00 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003dd7da0 EFLAGS: 00010293
RAX: ffffffff8143a369 RBX: 000000007ffffff2 RCX: ffff88807bf53c00
RDX: 0000000000000000 RSI: 000000007ffffff2 RDI: 000000001fffffff
RBP: 1ffff1100546a409 R08: ffffffff8143a305 R09: 1ffffffff203a1f6
R10: dffffc0000000000 R11: fffffbfff203a1f7 R12: dffffc0000000000
R13: fffffffffffffff2 R14: 000000007ffffff2 R15: ffff8880760fc158
FS:  000055557e80e380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f81836d5440 CR3: 000000002f60c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1294 [inline]
 kfree+0x71/0x420 mm/slub.c:4738
 free_bprm+0x2b5/0x300 fs/exec.c:1499
 do_execveat_common+0x3ae/0x750 fs/exec.c:1978
 do_execveat fs/exec.c:2061 [inline]
 __do_sys_execveat fs/exec.c:2135 [inline]
 __se_sys_execveat fs/exec.c:2129 [inline]
 __x64_sys_execveat+0xc4/0xe0 fs/exec.c:2129
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f432f022329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7487b7e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 00007ffd7487b9b8 RCX: 00007f432f022329
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f432f095610 R08: 0000000000001000 R09: 00007ffd7487b9b8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd7487b9a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x16a/0x170 arch/x86/mm/physaddr.c:23
Code: 40 a8 7a 8e 4c 89 f6 4c 89 fa e8 b1 4d aa 03 e9 45 ff ff ff e8 a7 1a 52 00 90 0f 0b e8 9f 1a 52 00 90 0f 0b e8 97 1a 52 00 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003dd7da0 EFLAGS: 00010293
RAX: ffffffff8143a369 RBX: 000000007ffffff2 RCX: ffff88807bf53c00
RDX: 0000000000000000 RSI: 000000007ffffff2 RDI: 000000001fffffff
RBP: 1ffff1100546a409 R08: ffffffff8143a305 R09: 1ffffffff203a1f6
R10: dffffc0000000000 R11: fffffbfff203a1f7 R12: dffffc0000000000
R13: fffffffffffffff2 R14: 000000007ffffff2 R15: ffff8880760fc158
FS:  000055557e80e380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f81836d5440 CR3: 000000002f60c000 CR4: 00000000003526f0
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

