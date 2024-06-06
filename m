Return-Path: <linux-kernel+bounces-204383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C58FE804
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B131F24D25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDD0196435;
	Thu,  6 Jun 2024 13:38:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576813BC26
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681086; cv=none; b=CX9xcZh6IgGQ6OYVLqsGj2N+D2k+dDeZN5ZeqAlxD2NAy3zfsjzzKAF/rLEAshJ2cIxEOQYi7dp4qwFgl6GXsnamwj+OJNLTdJ7SpORdnCRSbsJOuYEulQqjNfJxa2PnpTAbLGxNPFcehNu24SvqnlRwDTPs1k+HP8GxAWJkvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681086; c=relaxed/simple;
	bh=aKkL9apVX0vcL++2yhH8jts3PZ0PoVUvM0zwvsEY5aE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QC+ioWX2yC1FskTL7/RWupLejKZlbWLbEk/+g6N0CBrtqu5pxdN3vssm3JZ24rJIqXOBV5PvhxI4IfHuKbtZ+L1GugnfUkWdr44mX2VKf25KEuvgWGXFA6DpOYSIgr3fXvgTBDZebqADxLHUUOSMUF8pgsbFNwmDQKPVTNfjmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb3ccd3990so96883239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681084; x=1718285884;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP1eNb7bNI2fqkc1i+BXKw0DYR+yJX//0WXpWUVTCTQ=;
        b=rHFWrq+x6SzYdv4HihEh20naqrYBEaKfwi+SFQM3TO8b64BgdWfitMSSZFOWY/DX6q
         xN3l1g8lllrtQi/TGVVNXD+teoWDEKp8YV/AF0s7UdGZNjE4o4RrwAUw0xVwAz7TYqVF
         WQa8tO+Oe6xU1G7nA1mNKLiq2UAOHQo/aQvjt9nu3o5qPVxaro7rdmSVritY2vUqBPku
         BVE6FaL1pSOkeeI3NXcCFfV2KNKx5ncANXwJ8ap4M/ycwTeQs9YtKJDJc9PNe5Nx1jKp
         v0ivo1fpXryMHS2E39NCfN1A2JfAxAqrkm3VPIlAm+edS9WnIMcQ25IfmVvMyfyWPEwp
         Ivsw==
X-Forwarded-Encrypted: i=1; AJvYcCWH8YpWmBbdQ5QB+GET0dlugnsRkiMnB6s64cp7tEiV0TIsmo5mfwiXNMCCg1ZqGGOzlwNnBPmJ8O/X5Nh8f66thS1by9XL9Jx6lq23
X-Gm-Message-State: AOJu0Yy9iW+Uops5tLs9Iee4o/dZpsDNnMHWbXHM6h5dSkgKa5PWdmNP
	FlGu9zN7f+lpCpKtzChj2i0BisexqycA0RTfJA0zYs68Aaq6SB/vGJg8iX3cVxkWdlzPtugDP12
	GS0RepbVPG0u9a8wF8GLgtC0Tyocl59h5npFdY/P1don6kaO08sTVW0I=
X-Google-Smtp-Source: AGHT+IG4og3fb+C3yqMQ+4Xw0Xa/qCE8x/VzekrnWdH89BDUauyWaidy8toG/WBETYuc76ZaZT6qTZR4KgYLYtqfH+5/0qYPiO3R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:238e:b0:4b0:7348:639 with SMTP id
 8926c6da1cb9f-4b63b3e282fmr234487173.5.1717681083425; Thu, 06 Jun 2024
 06:38:03 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:38:03 -0700
In-Reply-To: <tencent_92497A23B524569769377926D4536A636A05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0b6d3061a38ca59@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: locking bug in gfs2_fill_super
From: syzbot <syzbot+ee157488ade46c021ef4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering=
 an issue:
WARNING: locking bug in gfs2_fill_super

loop0: detected capacity change from 0 to 32768
gfs2: fsid=3D(=EF=BF=BD[{{{+: Trying to join cluster "lock_nolock", "(=EF=
=BF=BD[{{{+"
gfs2: fsid=3D(=EF=BF=BD[{{{+: Now mounting FS (format 0)...
gfs2: fsid=3D(=EF=BF=BD[{{{+: can't read superblock: -22
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5932 at kernel/locking/lockdep.c:233 hlock_class kerne=
l/locking/lockdep.c:233 [inline]
WARNING: CPU: 0 PID: 5932 at kernel/locking/lockdep.c:233 check_wait_contex=
t kernel/locking/lockdep.c:4824 [inline]
WARNING: CPU: 0 PID: 5932 at kernel/locking/lockdep.c:233 __lock_acquire+0x=
570/0x2000 kernel/locking/lockdep.c:5144
Modules linked in:
CPU: 0 PID: 5932 Comm: syz-executor Not tainted 6.10.0-rc1-next-20240529-sy=
zkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 04/02/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:233 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4824 [inline]
RIP: 0010:__lock_acquire+0x570/0x2000 kernel/locking/lockdep.c:5144
Code: 00 00 83 3d 81 3e 3b 0e 00 75 23 90 48 c7 c7 e0 b9 ca 8b 48 c7 c6 80 =
bc ca 8b e8 eb e3 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 3=
1 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc9000347f590 EFLAGS: 00010046
RAX: 05742692f5fa7200 RBX: 0000000000000881 RCX: ffff88807e1fbc00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: ffffffff81586802 R09: 1ffff1101728519a
R10: dffffc0000000000 R11: ffffed101728519b R12: ffff88807e1fc728
R13: ffff88807e1fc6d8 R14: ffff88807e1fc6d8 R15: ffff88807e1fbc00
FS:  00007fcda487d6c0(0000) GS:ffff8880b9400000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ba9bc07131 CR3: 000000006858c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5817
 touch_wq_lockdep_map kernel/workqueue.c:3895 [inline]
 __flush_workqueue+0x1c9/0x1710 kernel/workqueue.c:3937
 gfs2_fill_super+0x1298/0x2530 fs/gfs2/ops_fstype.c:1311
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1331
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcda3a7e5ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcda487cef8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fcda487cf80 RCX: 00007fcda3a7e5ea
RDX: 0000000020000000 RSI: 00000000200001c0 RDI: 00007fcda487cf40
RBP: 0000000020000000 R08: 00007fcda487cf80 R09: 0000000000008c1b
R10: 0000000000008c1b R11: 0000000000000246 R12: 00000000200001c0
R13: 00007fcda487cf40 R14: 000000000001279b R15: 0000000020000040
 </TASK>


Tested on:

commit:         9d99040b Add linux-next specific files for 20240529
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=3D15541096980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D735e953fee00ec1=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dee157488ade46c021=
ef4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16a4bfd69800=
00


