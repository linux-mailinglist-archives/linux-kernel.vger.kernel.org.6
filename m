Return-Path: <linux-kernel+bounces-186356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89198CC321
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8131F218C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E31420C9;
	Wed, 22 May 2024 14:21:30 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B931420C8
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387689; cv=none; b=geBpWtDF47cJjjnrry2oKOs4Waczf4bf7uCVhZwBMLI0TMIkMe61sArx08DFANnO+9Am5avfiHdqPmUz9Q8rtuuS85jKopAkDMFVNTK9WupL1iV6XZ7ihJZwkWRe1bPdBzvJJNX3zvybquYP+slOCBgYZS7iGrzOTx5388rU2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387689; c=relaxed/simple;
	bh=F4MPINliyvpVTUEJeMa2f7mKDxuw42N5wCo4s/vo+ic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SLCmk4QmeQFk1pqI1fXaYngtKSOjISiYy11R7TQggyg5r8Ro6OrxwGE+PET3BsMB70y6BoSK5CFC8RlxAG+nGpmh4dMFv8oLGs1qRCS0xSIrvHhYMkLTWVT8X6ZBxTpXgPN9S9dMqIjGOwB5PevYZmOGzwqXE/Mjm/vTpgh1Rlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-36c7ba4fe7aso7755145ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716387687; x=1716992487;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mg+HZy+NVuMWqSOy5JXcKIJ+CX77DXLFzXyU/P96frE=;
        b=ROJCCmXtzP1R4uN76QcbPxKuUAofy+o+6zQzC+3/hxp6b5WSYf+7ia7wnzLNiJM3kw
         lvPc/p1r1cGE/1vFGAvUGGcRGDx/aFJ/N7WAnf+qPK4ShOLd+TYnkMoCD3VGTn/znYML
         euzDqJNkNFidnU3P1lMXe4cU46S0D4DOSPqnBwBV6TSVktj6UerBudnHdVsMu3nSfUgK
         5XjI0A2XJD2Q8uHozAHn4ZvxpZUjkxCItWmivOm3s3qM1GWGgvJkXgA/OgPAZm/M7Q3g
         XIB3t/SYVwu5riY/4xwR/H9izSGQULmw8MF2iHcFrT3w/ZMnEdl5gZiPperEmxrJpI2+
         LJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZmND1peUf1CIRvVycVXHAt+YzCQGRPMTs20tLERRLWeFLYw+vmqC+FpHV7ZLdRGUMKzSPT3MeD69v3JpnovIURR3WPdhF8U7lGTda
X-Gm-Message-State: AOJu0Yy0YgT1snArDKyNsIWN4n3ZQLx8nG1fU4U+SEv9fcZmuZTUECdO
	ppBj8eXrwgmClecIRMuatR7usIjDeb9CIN0qw6vgje9UrLE2Xf8PEmpwEY11LBPUFMZfUjedw4k
	4s05myhXtBOPEWfuTAHjcC1JXwFtiCNJKzso3kUxB6iWGRx2qO+KXYKE=
X-Google-Smtp-Source: AGHT+IFKrllj1X+ZQSADx7xCFBU7sts4VTwEsJAy1Ii8u5ELFYet8di0oZcMoMhedRZblF7weKPuS+jDhp3XkWWkgbl2/CJ9ya09
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:36d:d38e:3520 with SMTP id
 e9e14a558f8ab-371fd7625b2mr2067335ab.4.1716387687582; Wed, 22 May 2024
 07:21:27 -0700 (PDT)
Date: Wed, 22 May 2024 07:21:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a5beb06190ba6d2@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in process_one_work (5)
From: syzbot <syzbot+2dd3f44b0f42f3aee4ec@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b377b4868ef kprobe/ftrace: fix build error due to bad fun..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17096d92980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11eee78d9c5171fd
dashboard link: https://syzkaller.appspot.com/bug?extid=2dd3f44b0f42f3aee4ec
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4b377b48.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b158356f72a3/vmlinux-4b377b48.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3bdecd8d3c89/bzImage-4b377b48.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2dd3f44b0f42f3aee4ec@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "ork_completion)(&sdp->work)" with key __key.5, but found a different class "(work_completion)(&sdp->work)" with the same key
WARNING: CPU: 0 PID: 8 at kernel/locking/lockdep.c:932 look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.9.0-syzkaller-08544-g4b377b4868ef #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: rcu_gp srcu_invoke_callbacks
RIP: 0010:look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Code: c7 c7 e0 b3 2c 8b e8 3c 25 74 f6 90 0f 0b 90 90 90 31 db eb be c6 05 8e aa ee 04 01 90 48 c7 c7 00 b7 2c 8b e8 1e 25 74 f6 90 <0f> 0b 90 90 e9 62 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900003a7988 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff941f8e58 RCX: ffffffff81510469
RDX: ffff888015f22440 RSI: ffffffff81510476 RDI: 0000000000000001
RBP: ffffffff94ac4880 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 20676e696b6f6f4c R12: ffffc900003a7d80
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff94ac3ba0
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f743a0c4 CR3: 000000002a136000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1230 kernel/locking/lockdep.c:1284
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 process_one_work+0x8c4/0x1ad0 kernel/workqueue.c:3207
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
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

