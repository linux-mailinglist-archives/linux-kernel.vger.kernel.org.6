Return-Path: <linux-kernel+bounces-421032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B249D85DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB70E169754
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1939C1A76A4;
	Mon, 25 Nov 2024 13:05:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD6118A6C1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539926; cv=none; b=Vh7ZUyCKnypZK/lzIeLc6UcQxGJoeSh41lnpi3yDUBuaSqqIac1K0BYWAPGnv/EE0HvPTwLoAOwP4YjnnIQowARPZchTgqU/+z1tea/iU0bcuAI/j7xl/0qoQ41EPEW8eePfb9WfJ/5jRrUITFwLz8hojvrzl2p2nrAZ0JSh4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539926; c=relaxed/simple;
	bh=EFzcynI/xt/LaI/1hq/ie0RvRp2BG5Lbd88GzxGvUSI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OFFWA+HoiS3pfkE+wYuWm4QN2ZXu52tYjImjYqADMgbvbv9P/kaIudhquaFvFtwv2XhUtqJto28+E8/f8FOAyebXINYXNw8vAV0LPqfhbHExGiwsjhuL6YtIrCJ2JzJc0q2vm7h3UsPwFOBjBFQmVOpNAzDDXYc2NwXIu0vx7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a79088e7abso44988595ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539924; x=1733144724;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOMKV4YUWbwyYTwWXtmPT//Xtz8ymxtP6dUYZK6kaq8=;
        b=w3+O9BxJuCr4FfTiuTopJClk7g2aruvF7hexKsIWY1qZhHGlYfa2flp+tu/y6086Ms
         Q2VJT+v+3iFnqUF7MoGGyB/3lnAj/wdl/NEGebELttIEoMCOBORxkhEbSXtzt/Gm/Eed
         IgDgT4NvXML+CrhDP6iG19SxMEHtovqsq9ylzIiuMk8pz/A/AzNsZgHro52XX2QIzLgP
         puNX1BwVp0Eav3BRfNvM6BoTgxFVTQnSU+KqZkDL2Le1lHw+8eX+1KEoXm7+WlogwU0z
         F3Mb16gDOZVT9neHt2QE/h79pw31pqirACh3cuUcJnxJs1OCUE3+thlC+57FD7GhzGh0
         YQkw==
X-Forwarded-Encrypted: i=1; AJvYcCV5WBkGPfkd62Qh8jFgPH7omPvPyEMm5vQNAm9BId1K74UAwPnFcf+zAAU5dhajAUt7/G3Cc0VlMrFMceg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywev2qovWVpj7liUeBca8dlWuJihlV+9YrXGEg0EK5bzKxvt1Px
	0vOfeRv3iA/9Fib7pj2MBHfBo4UqSntQenV0Q0J6n+D/RMG222P+oQev0sc0gIiXzpjNUe4wfUX
	/E/LfH7JOlmYIBFO6D+f0k0Mtv28cEuw2MiSWM4yQkI2v0QFA3sVPGn8=
X-Google-Smtp-Source: AGHT+IGBKtJ14iU7MOwx15GPROVJ2moKZr8B2O+fcZA1xpV9LV1AGk0AFqNvqReMsgs5xHtBCJ/MIYEZCONpiUcPupiDJt97Bevx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:3a7:85ee:fa78 with SMTP id
 e9e14a558f8ab-3a79af9bd40mr136118425ab.18.1732539924064; Mon, 25 Nov 2024
 05:05:24 -0800 (PST)
Date: Mon, 25 Nov 2024 05:05:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67447614.050a0220.1cc393.007f.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_evacuate_bucket
From: syzbot <syzbot+bd56952613b5dae47ca4@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13260ee8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=bd56952613b5dae47ca4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124c25c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164c25c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9f905470542/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b4c9cc530ec/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0f262e4c35e/bzImage-9f16d5e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8b2fe0894685/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd56952613b5dae47ca4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/bkey_types.h:210!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5847 Comm: bch-copygc/loop Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:bkey_s_c_to_backpointer fs/bcachefs/bkey_types.h:210 [inline]
RIP: 0010:bch2_get_next_backpointer+0x1316/0x1320 fs/bcachefs/backpointers.c:257
Code: f9 fd e9 56 f9 ff ff e8 78 58 91 fd 90 0f 0b e8 d0 5a ba 07 e8 6b 58 91 fd 90 0f 0b e8 63 58 91 fd 90 0f 0b e8 5b 58 91 fd 90 <0f> 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003dd6c80 EFLAGS: 00010293
RAX: ffffffff84048765 RBX: 00000000000000b3 RCX: ffff888033fc5a00
RDX: 0000000000000000 RSI: 00000000000000b3 RDI: 000000000000001c
RBP: ffffc90003dd6ff8 R08: ffffffff840480a8 R09: 0000000000000000
R10: 0000000000880000 R11: 0000000000000000 R12: ffff88807dae4000
R13: 1ffff920007bad9c R14: ffffc90003dd6ed0 R15: ffff88806f8c0160
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f337ebb000 CR3: 000000007db9a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_evacuate_bucket+0x113c/0x3620 fs/bcachefs/move.c:708
 bch2_copygc+0x42c9/0x4ca0 fs/bcachefs/movinggc.c:240
 bch2_copygc_thread+0x737/0xc20 fs/bcachefs/movinggc.c:381
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bkey_s_c_to_backpointer fs/bcachefs/bkey_types.h:210 [inline]
RIP: 0010:bch2_get_next_backpointer+0x1316/0x1320 fs/bcachefs/backpointers.c:257
Code: f9 fd e9 56 f9 ff ff e8 78 58 91 fd 90 0f 0b e8 d0 5a ba 07 e8 6b 58 91 fd 90 0f 0b e8 63 58 91 fd 90 0f 0b e8 5b 58 91 fd 90 <0f> 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003dd6c80 EFLAGS: 00010293
RAX: ffffffff84048765 RBX: 00000000000000b3 RCX: ffff888033fc5a00
RDX: 0000000000000000 RSI: 00000000000000b3 RDI: 000000000000001c
RBP: ffffc90003dd6ff8 R08: ffffffff840480a8 R09: 0000000000000000
R10: 0000000000880000 R11: 0000000000000000 R12: ffff88807dae4000
R13: 1ffff920007bad9c R14: ffffc90003dd6ed0 R15: ffff88806f8c0160
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f337c9a518 CR3: 000000007ce96000 CR4: 00000000003526f0
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

