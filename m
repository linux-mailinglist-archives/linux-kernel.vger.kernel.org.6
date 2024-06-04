Return-Path: <linux-kernel+bounces-201385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E228FBDE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1696B249C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC714BFA2;
	Tue,  4 Jun 2024 21:13:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7B12D215
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535608; cv=none; b=X0goIK3urP5X8eF5c3LU0hIXsQ87NRPjm0G5FvakOJc0sGG7mPQxYigUWcP+USyP1qCdpY8HUVf37ctKA1frS7jJ29yE8tI+Hpikpr3/CNJ2uwI/3ESRcJK7ASl5c+4/ft9YnPRlzPrN7pkGm8f2PI975CmJ+Md4iBEOGGH2uBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535608; c=relaxed/simple;
	bh=HsCz0ZeYwBA1nTPEYhPRjTcTOHjsSoTaudVR4/nIcT4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J+mdtsI6r8gRU3fetpZlBVAEPOt8mnNa54SmKLDoIbGH/hXy16zu2TH2TnYxcDGTzzubbS+C+t6nHDna6EVlC8Ac677lUqMUPNC10I8pPvdMw63ljr2bEfQCN2MUg0hPpWFhnTwO1JSGQ9Rd3RgYdiAdjAp5DD/jyTdsH1RoCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-374a2ada068so25057845ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717535606; x=1718140406;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X02K38cZL0DbnosXLg9Rsk7c+qtdoxUw/8K9g7MIdgE=;
        b=gI2DzjUTlms8J+ePNb0PQCglttYpalRPyOyivgWReoaQfmshoPlHgKu+UL6+XKnqZH
         4ZMR5kllgMZN+MG2rEq313NlIQLTPT/g3LyKTv4uPEaMGw4ei62F5H53u27Yt54J33fk
         txxnrQ80McCF4a/1UUF93hpiAx9ARKoSi1b7kEZ6Z3Qgd/yb/wjlxqhMmYopll82cMZe
         aWkHfiVcWO0b7gFNsx2jmIi1YW0zwvquUxVE2hkHBEXmNLbAcqahxsVDkggWJBTiOXPF
         KwZO4xB54NJHAaHb+qZsBa8Xgtw+1sMFnAQ+7/sRHRLrBxUhtlwAmpFNKW/XHIij2Tz6
         QEvw==
X-Forwarded-Encrypted: i=1; AJvYcCU98l/+k8JteMh9FE0zl1yEnni/u2DifOodu/GXxIkmxWqqMhuk/cxCrFlPv01hRwqSyj9OYbNKXam+etBNPUD73QnoD7PlcfpbezBT
X-Gm-Message-State: AOJu0YwfnXWWUQV8M0fidm6jM+pFls3yVxp/NRRjuZDx0ay/t2wlnlq7
	kmRobF2RYOEusELs/zvmFS4dT/+qBhlNxL01PZHNuXfUEqetAeqXEWoynbJM2HZSUotudQgKlzC
	eU9TDBGM9c5zzMXgoAkD7Eo0tc9Z0I1+1CN5x+oPLNEybUazJEiOIpQ0=
X-Google-Smtp-Source: AGHT+IFYJLbdIpkFirEVMTc6tK9RBxgA1XVYj8S9yeKxwETlTpQmsH6fRiahC60hevkQnvOKVlS2LawmhzLmmwy53ho1hqKlz4y3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:36c:c4ce:8448 with SMTP id
 e9e14a558f8ab-374b1f83a64mr323165ab.6.1717535606440; Tue, 04 Jun 2024
 14:13:26 -0700 (PDT)
Date: Tue, 04 Jun 2024 14:13:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6111e061a16ebc8@google.com>
Subject: [syzbot] [jfs?] kernel BUG in jfs_flush_journal (2)
From: syzbot <syzbot+e66452054e1f161e8d29@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d8ec19857b09 Merge tag 'net-6.10-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13086d3a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=e66452054e1f161e8d29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42229dacbe9b/disk-d8ec1985.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/963a405f2e94/vmlinux-d8ec1985.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d861a4407dce/bzImage-d8ec1985.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e66452054e1f161e8d29@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_logmgr.c:1588 assert(list_empty(&log->cqueue))
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:1588!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 29917 Comm: syz-executor.4 Not tainted 6.10.0-rc1-syzkaller-00104-gd8ec19857b09 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:jfs_flush_journal+0xeba/0xec0 fs/jfs/jfs_logmgr.c:1588
Code: e8 eb 77 57 08 e8 66 07 70 fe 48 c7 c7 40 9d 02 8c 48 c7 c6 40 98 02 8c ba 34 06 00 00 48 c7 c1 80 9d 02 8c e8 c7 7a 54 08 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004757b20 EFLAGS: 00010246
RAX: 0000000000000040 RBX: ffff88802538e1a8 RCX: b07b599e2cc86b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90004757c50 R08: ffffffff8176803c R09: fffffbfff1c3998c
R10: dffffc0000000000 R11: fffffbfff1c3998c R12: 1ffff920008eaf70
R13: dffffc0000000000 R14: ffff88802538e000 R15: ffff88802538e000
FS:  000055557b2d6480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555562804978 CR3: 000000007e4b2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_umount+0x170/0x3a0 fs/jfs/jfs_umount.c:58
 jfs_put_super+0x8a/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x136/0x2d0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1676
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_sys


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

