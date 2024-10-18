Return-Path: <linux-kernel+bounces-371776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00FE9A4030
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D86E28180B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904FE1EE009;
	Fri, 18 Oct 2024 13:40:36 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6D1DFDAC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258836; cv=none; b=sFX5MJzKqaoWj8mEu5xlalxRR7NdO4hrbhd/iVaH84w+ib7/2WCSrg2aSa1D/vHm1C5MuA3h26NSSpl2X52MBQ/rVC4wwRuBRsJpNR5WGpU6x6LELkjvi0BBbv1teBG2fPuYOLfe0jmnyi/GsFZU4uc6jgdZXRXHRU1m4WnTjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258836; c=relaxed/simple;
	bh=rreLwmYL9Zkc87ag3xfVJasrMCmNJBH+FzW850VsFE8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SZO6u5D0iYAGVDz4AMQZjglZHhZs6SrqhYSkCo9RFeOaVLlk4+y3FzVd3B+2PYOf7O28753EyXvLPklpRlZgXmFEnkWBC5YZkBU+O+1jr0XMf9QvapG6OyKvQT6DK+3T35zkgZUfxDta5aD1fKvylzaMmmh5RobD/6k+3FW8TDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3cd35858aso20618695ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258830; x=1729863630;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGuSSXfzB1o8jDthzW6tAzSRqtHD60703KkJzfuAV7c=;
        b=JNeDrysL0Br/qjymELvSUZ3ZH/6Hw2tbda7hdhreaHCCgELMe60n1c+JeYJW+10d85
         CAkUXyCxZUmpQmBan2AELmfBN1psEDBCTaEX0JrKvlmIOZRelAKeo3m42usUeyLUN5KM
         ZUIjZlxl0yrQRN/W+1MpS/UqT7/S8CX66ckQQF1P4zzR2LAlc1wfiZ1s3x0JETJQSA4Y
         F9l3fw1N+kBCoiW1HseGRF8+1jFDZ4tJmw9dGMKNORAbmda0XoiRyRKHBGEhOB/O7CMg
         O9cFYQQJET+xk7EmgapeI6uhBZDjAiJG6CV9wAMaJG4apdZXIbSUvRT9cgubUBKaq1HY
         mW4g==
X-Forwarded-Encrypted: i=1; AJvYcCU4vi4Kuixc2ZXo6ESwpH2p368vAcbfMt/JPTlg7D9UydbxEpk+uFH3ff8vnLaquLD9PrAPH/qpiFuOYNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMU8WEREOfijyIS7MIcM5Mgk6G90jjFgFAdXcmN5e6mY3AF3k
	ZFWFGxveNB/ZvcLGdj7qCmToqxfZ6pUYCJkjQBKN76MXvrPBuuh8x8N8DxF5M87efKKccg2wzAx
	DRBd9uyfBDgt4vqgXIaiwYlICzM5bpU6w/URyq3qJiwZaop/2xNbA2KQ=
X-Google-Smtp-Source: AGHT+IFtjLnhkJxFXT4lcu+2AmOePRyV5w1KnrNpL/pFQWCqQBuZon2y5zHBgTyZQH0NIEslh9rY5sq8Xwm7yevZgZh/CGrCghvf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:3a0:985b:ddb4 with SMTP id
 e9e14a558f8ab-3a3f404ff3amr23464025ab.2.1729258830507; Fri, 18 Oct 2024
 06:40:30 -0700 (PDT)
Date: Fri, 18 Oct 2024 06:40:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6712654e.050a0220.10f4f4.0014.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in process_one_work (6)
From: syzbot <syzbot+b1e6570b82775975e1bb@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6485cf5ea253 Merge tag 'hid-for-linus-2024101301' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ea385f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c9b3fd66df7ebb7
dashboard link: https://syzkaller.appspot.com/bug?extid=b1e6570b82775975e1bb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-6485cf5e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcb92964a345/vmlinux-6485cf5e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f66a07fe646/bzImage-6485cf5e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1e6570b82775975e1bb@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 1419 at kernel/locking/lockdep.c:936 look_up_lock_class+0x140/0x150 kernel/locking/lockdep.c:936
Modules linked in:
CPU: 0 UID: 0 PID: 1419 Comm: kworker/0:3 Not tainted 6.12.0-rc3-syzkaller-00007-g6485cf5ea253 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: wg-kex-wg1 wg_packet_handshake_receive_worker
RIP: 0010:look_up_lock_class+0x140/0x150 kernel/locking/lockdep.c:936
Code: c7 c7 60 cf 6c 8b e8 2f 8f 2c f6 90 0f 0b 90 90 90 31 db eb be c6 05 c5 14 26 05 01 90 48 c7 c7 40 d2 6c 8b e8 11 8f 2c f6 90 <0f> 0b 90 90 e9 58 ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc90006baf988 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff96e97090 RCX: ffffffff814e71a9
RDX: ffff888027dc8000 RSI: ffffffff814e71b6 RDI: 0000000000000001
RBP: ffffffff9ab0ac60 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 20676e696b6f6f4c R12: ffffc90006bafd80
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff9a821820
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200f7000 CR3: 000000005e206000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1240 kernel/locking/lockdep.c:1290
 __lock_acquire+0x135/0x3ce0 kernel/locking/lockdep.c:5077
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 process_one_work+0x927/0x1ba0 kernel/workqueue.c:3205
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

