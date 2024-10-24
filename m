Return-Path: <linux-kernel+bounces-380518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3E99AEFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBE81C20FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5770A215F4A;
	Thu, 24 Oct 2024 18:52:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890B215031
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795954; cv=none; b=DuOEjDwkRVstVHRu5OAqocbwHjbiFjU2yZjduF/nIuIGIrMNm18yhw3UqOs2u76wY/UPistcRXYE21NBdTAhD9g75/3aD1TDUQ9eLWJfcncdR6h/Lgs73NqB893flIkfDSErTP58KrkDRzP3BW2ad51CqaAC3y17i+x73WCNKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795954; c=relaxed/simple;
	bh=UdbZoNzJBAzFTWh9oXYGiu3ArUCC4022GnvN5bmFGxY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KDKEEPi23IJiKBaFkfUMMOGVNsG6ao04jEnez9gByQuykReppfmbT+IyruwRscKu0YkjsR61IzDlMw7UWBjqcwccb6MuooYdg6046q+RuYzQN6PHBrGxhHCXBX8JRSPlUC9VTJUAoxfXytqIVFqn/YDmuQyyOOmui5U38/TmQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so13779455ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795951; x=1730400751;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOLmJG+n6Utw+/MDpQ5obB1n1FgdorLgz2p2VTUaDbM=;
        b=dKXE5rirGHMAALE9Pyk6H/gkWZ0oWQQCU1B2FQ2Ru2iZYv9duu4fioUnWfAWIPTwlH
         fxfUhx8Ejl1rTmJg7GRPWXnv9aWYxXefrP6AtXiXJ1vrRdFumA1biTgSjncgAA0eWD8g
         p54TelNkBVyHZYaT8HFtcVAEy+NH5/cwLjozwX4vM2g5htomUlQqdvQhC2K+ur7fwtab
         iBe6utyfH1N02BQulMQ2MBfT1aSxooXNMt+yY5WGvieN8Hbc6/ykT7iDlQIN+Iujiasi
         cJsaV82BJFwqfsDZYkPsi74xLcURsSTGqhTM0Y2UWn1KBRW2L9eQh4Eto5L84dWjbVB3
         K3fA==
X-Forwarded-Encrypted: i=1; AJvYcCW/azsKbknRG0OyvoHFzoxeUjSq3wIJzBFSZaCCm0TqxYMQdGRQ+SPDZNUMSDvkarfhQXzn0pE1ZCP1e10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSkN1l2PK/Am7V6AtSpBIsHiKr7cdj3resZXrBWQUTvb3VDtf
	e8lcJIxCGNhcOsGToDP0c9/7UAxFFeG5t0Wc2Fuzt8D37wunIXVipnbPgkjagOaS0WJcQKE2r0p
	xnr6MueRqdpEI/RNmyCcYIDt39wbguC8MUBE6eh6cb0SmSZHx3SlNpcc=
X-Google-Smtp-Source: AGHT+IFhUxjtB+q1/HVecEuw5SKHa8dajLzk8xKubrl6dHV2dtShpsJ2y88Tjp5WB9o7JwQQVJktoZsqC+x6DogjGc243lrhRSqB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:3a0:a0bd:f92b with SMTP id
 e9e14a558f8ab-3a4de7a47b3mr36246005ab.10.1729795951586; Thu, 24 Oct 2024
 11:52:31 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:52:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671a976f.050a0220.2eb763.00c7.GAE@google.com>
Subject: [syzbot] [ntfs3?] WARNING: locking bug in ntfs_fill_super (2)
From: syzbot <syzbot+b856fe782caf1f85be6e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    715ca9dd687f Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1700ec87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e543edc81a3008
dashboard link: https://syzkaller.appspot.com/bug?extid=b856fe782caf1f85be6e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7ae9f0c1b9fa/disk-715ca9dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91e10a24baa4/vmlinux-715ca9dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f46b6b5990f3/bzImage-715ca9dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b856fe782caf1f85be6e@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 4096
ntfs3(loop5): Different NTFS sector size (2048) and media sector size (512).
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 6340 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 6340 at kernel/locking/lockdep.c:232 __lock_acquire+0x1345/0x2050 kernel/locking/lockdep.c:5199
Modules linked in:
CPU: 1 UID: 0 PID: 6340 Comm: syz.5.66 Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:__lock_acquire+0x1345/0x2050 kernel/locking/lockdep.c:5199
Code: 00 00 83 3d 2c c1 ac 0e 00 75 23 90 48 c7 c7 60 c9 0a 8c 48 c7 c6 00 cc 0a 8c e8 86 71 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 83 c3 40 48 89 d8 48 c1 e8 03 80 3c 10 00
RSP: 0018:ffffc90003f2f650 EFLAGS: 00010046
RAX: 11c528de68187400 RBX: 0000000000000f00 RCX: 0000000000040000
RDX: dffffc0000000000 RSI: 000000000000dc83 RDI: 000000000000dc84
RBP: 39845540049e23b7 R08: ffffffff8155e402 R09: fffffbfff1cf9fe0
R10: dffffc0000000000 R11: fffffbfff1cf9fe0 R12: 0000000000000001
R13: ffff88802e92e4d8 R14: 1ffff11005d25ca5 R15: ffff88802e92e528
FS:  00007f47db4276c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020a1a000 CR3: 000000007873e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 iput_final fs/inode.c:1866 [inline]
 iput+0x615/0xa50 fs/inode.c:1903
 ntfs_fill_super+0x3e27/0x4730 fs/ntfs3/super.c:1472
 get_tree_bdev+0x3f9/0x570 fs/super.c:1635
 vfs_get_tree+0x92/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47da57f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47db426e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f47db426ef0 RCX: 00007f47da57f79a
RDX: 00000000200000c0 RSI: 0000000020000b00 RDI: 00007f47db426eb0
RBP: 00000000200000c0 R08: 00007f47db426ef0 R09: 0000000000000010
R10: 0000000000000010 R11: 0000000000000246 R12: 0000000020000b00
R13: 00007f47db426eb0 R14: 000000000001f3bc R15: 0000000020000280
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

