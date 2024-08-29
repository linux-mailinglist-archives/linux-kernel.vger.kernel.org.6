Return-Path: <linux-kernel+bounces-307615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02466965064
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F871C23A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA101BB695;
	Thu, 29 Aug 2024 19:56:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CBC153BEF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961381; cv=none; b=L8vqzHGi6RiNSuw94ajSbzMyY9qH4qC5wHb1kTiQx+pMAKqJAsLXl/pFug+hCmA+n+CatRp3gp0pCdRSDpLub8z4YY0boWMwyozDbdjnkxPRFR1E/ticKReDdNwTiR3oInwSfhyIvjPWkNLgY5Zhyx/0MyG+S4MQQCdLzVQ8mBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961381; c=relaxed/simple;
	bh=FIXiCzanORVwqq9ZnXwiWeK8TZ7/dcQ5D6Fa+s4XAzU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=noM/H89QVqf2C1mJzPSy6nDPDL78A6Ss9HqDm+sJnTUjSLmoMe/tfxUvpEbpAujNNsb4FpTc2MJOi3RorP8UHCMvCa324gOlSDFTvm0NNRmBgg2GE1+cud5g43VDyADxQ5qWhO26TVhEz+y7SP1UlLEOgQfkUyE9P8TQUsGzQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-827973cb3baso127798939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724961379; x=1725566179;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGGcm9Zs17wZbGGXA0+iV2y/0Ronp4Bvq6W9gouKn9g=;
        b=SPhLU0n2XmsrlmPCHHzHh/z7XvlQ4nlImMPqnZon7qgaBaJRZ47+Cc7aXCnOaHM2+s
         wmi/lUuehc2sen6BbGY3wuCbKNxMhso2eag6R7+/fAn2lTzo7QEyJn1aLERm0G2l3egT
         v8rSHTrK1M5X6EGAmFil0FB7KFWoz7woX4wlqbhZ2YAXHldAYV5UoRiAAbJxSTTCBXpx
         /eR7r+VnmIlC6sHwvkdWQQRKbGWAyZCXe0/H1WfAQ2a6BF+LKaPaPboc/xsj0YLSMcvk
         DDWMnukTBGCc9s6hH7fMaYwp1HWJ2r2IIr2/Sp169XmE0++cc9dot8rHa+YqLOkhmoq3
         V/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoNpBTXeLgiaks1r1Mie8oU0P4KaVZLN+ilUsgmtDKYGap5z28RAkySxgVeI0XMyN/Q2mnNhdrv1D4Gog=@vger.kernel.org
X-Gm-Message-State: AOJu0YygeZl8Xsv9gd046UQJsIxaPx1UvTHU/Q5meQjHgNAueXO8bBfE
	NG2hG+9wpInvh1rtc7tIV2PnAgAojaER0cJt49FUlPIuQQXyPJBqKE+lDxtTYjucobg9g30jkBU
	ot9sOYUnQmRzKFj9j5E1jqikAvC/dKtq49ATz9SlIgNUpZaKBy+IMlzA=
X-Google-Smtp-Source: AGHT+IEZkSD+k9fmrUGlfpu0IzPmJTPo1sX03BMy3ZXJCSkxp9KGqqkeo9NcDIyq0pJl2Z4le8atfg+OdfpAhsv+G2Zudcfv4E1P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1412:b0:4c2:90d0:b311 with SMTP id
 8926c6da1cb9f-4ced002cb3emr175299173.3.1724961379380; Thu, 29 Aug 2024
 12:56:19 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:56:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044ff540620d7dee2@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_get_ordered_extents_for_logging
From: syzbot <syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5be63fc19fca Linux 6.11-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f0800d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=4704b3cc972bd76024f1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16692a29980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cad8c335ccde/disk-5be63fc1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4d2dd818c33/vmlinux-5be63fc1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab5cbe08133f/bzImage-5be63fc1.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/9b6630601ecf/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1eee9b57c8d5/mount_3.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/ba6ddfb704dc/mount_4.gz
mounted in repro #4: https://storage.googleapis.com/syzbot-assets/e681ae9a9992/mount_9.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/btrfs/ordered-data.c:1018!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 6479 Comm: syz.4.61 Not tainted 6.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:btrfs_get_ordered_extents_for_logging+0x4fd/0x500 fs/btrfs/ordered-data.c:1018
Code: f7 07 90 0f 0b e8 23 f1 df fd 48 c7 c7 40 8a 2c 8c 48 c7 c6 e0 8c 2c 8c 48 c7 c2 20 8a 2c 8c b9 fa 03 00 00 e8 e4 ad f7 07 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f
RSP: 0018:ffffc90009627938 EFLAGS: 00010246
RAX: 0000000000000055 RBX: 0000000000000000 RCX: 3784e5b0ceb58c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88806597d690 R08: ffffffff817402ac R09: 1ffff920012c4ec8
R10: dffffc0000000000 R11: fffff520012c4ec9 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffc90009627ae0 R15: ffff88806597d690
FS:  00007f60c8eec6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa599c4220a CR3: 000000007953c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_sync_file+0x929/0x10f0 fs/btrfs/file.c:1712
 generic_write_sync include/linux/fs.h:2821 [inline]
 btrfs_do_write_iter+0x5e2/0x760 fs/btrfs/file.c:1515
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_pwrite64 fs/read_write.c:705 [inline]
 __do_sys_pwrite64 fs/read_write.c:715 [inline]
 __se_sys_pwrite64 fs/read_write.c:712 [inline]
 __x64_sys_pwrite64+0x1aa/0x230 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60c8179e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f60c8eec038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f60c8316130 RCX: 00007f60c8179e79
RDX: 000000000000003d RSI: 00000000200001c0 RDI: 0000000000000007
RBP: 00007f60c81e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f60c8316130 R15: 00007ffd4fce3d08
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_get_ordered_extents_for_logging+0x4fd/0x500 fs/btrfs/ordered-data.c:1018
Code: f7 07 90 0f 0b e8 23 f1 df fd 48 c7 c7 40 8a 2c 8c 48 c7 c6 e0 8c 2c 8c 48 c7 c2 20 8a 2c 8c b9 fa 03 00 00 e8 e4 ad f7 07 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f
RSP: 0018:ffffc90009627938 EFLAGS: 00010246
RAX: 0000000000000055 RBX: 0000000000000000 RCX: 3784e5b0ceb58c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88806597d690 R08: ffffffff817402ac R09: 1ffff920012c4ec8
R10: dffffc0000000000 R11: fffff520012c4ec9 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffc90009627ae0 R15: ffff88806597d690
FS:  00007f60c8eec6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f449fcc2723 CR3: 000000007953c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

