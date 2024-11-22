Return-Path: <linux-kernel+bounces-417770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FE9D58EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0912284536
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B631632C6;
	Fri, 22 Nov 2024 04:48:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D92746D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250904; cv=none; b=IlttWghkYFZYx5woQVnUjBk3TrAVCHTrW9I9EXVhis24kiADYiZuT533VzLIRj0NS9/c9yU1rxhmW4T4vN2edAnG9hLuHbIkY1VfTvkbNla8gAtidxgUaeYQCFUnzMRidQyv35NI9yCkOhBRbY5YDcqLh8Jzq/9zceloyZgsac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250904; c=relaxed/simple;
	bh=W17Eb99vA47L89/Zopwm69gA4mmWV0IPq2kmf9TqDAE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ER8RD7e4PA45/cujaTbURkIuK15o9gWnh1QrL0TMxgiS+MsJ50pf6Ko9tjhuW8/XBFN8r+mPvXkr06IlpN7iw12kukJe6fiOoksLCeU3X2T1PdvWeztms2yNVGD/ruWrLponmC/+ryfXPSy6H/qG99tEK0ySAzMVoc+2TpQV25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a763f42b35so12799495ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 20:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250902; x=1732855702;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1RcO0TmnnkYqFobA3xcmpDmvpNzGA8a+TGdYVYOpIc=;
        b=nzJ7EN4Gdd+jiHx+DwxabdnZ0cDimIki9jsnXvxDx4zvlpZvaRlGtnnjiZauxMZZmA
         SesjE6oEByXqq0f59AU4HwRqhI+aAjtAtkbDNinKIPF7HruEJAUmh+zHvgpvJuMSfi/H
         reDGEZ8SC+WgcxRZfxzdQs9+6kDVMOGLu86mXOTVyTikazdGNaaqdvXWWv14x/f1BAij
         YNelMd8gIVO2mZr95E3gfHD5LI+ZrGEqg2aCeTYKsUUZTz0UULutVQd0RX6WBTLiAXjz
         huKsnLq8XR6FF0lleW5iUL62Ii+6FLmNvU0kMsDTtCIllfHQgnsRM+UzJT//bM68B3EK
         NZGw==
X-Forwarded-Encrypted: i=1; AJvYcCX9urdjsNCjF4U8I1Dwpo+WII/NDGwhHKMH/YNs7q+IqDWvMra9J+S/8MSKa4HmXWKTerjd6mP1ZeAQ2zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3x8jSzjniOY/twefZnrhQAnlncXV4IpEqaenDFIROFV9oyXZg
	sD360Z5RDCNm2XOR+eczR/cfhd41uML+1yQLMgRJdOG2sQC3FSEw5giUERp2MIai/VdyiFDQn7f
	7AncViuVuknjts/+3D2ET/RBs9q3diipkNbu59iwyDWVaSATLzoXWE0U=
X-Google-Smtp-Source: AGHT+IHcJ6BOXBImHbbr7PXDhYm+3gIjaqafqRTua3U0hxg2vwoo3B0OrmzmwP6A5yyut65uzRyPFvzMEjmyJ9pzfMI6s/7Xcx4O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1809:b0:3a7:8208:b843 with SMTP id
 e9e14a558f8ab-3a79af53d8bmr17513955ab.23.1732250902474; Thu, 21 Nov 2024
 20:48:22 -0800 (PST)
Date: Thu, 21 Nov 2024 20:48:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67400d16.050a0220.363a1b.0132.GAE@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfs_read_inode
From: syzbot <syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f66d6acccbc0 Merge tag 'x86_urgent_for_v6.12' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1381b2e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=570f86970553dcd2
dashboard link: https://syzkaller.appspot.com/bug?extid=2db3c7526ba68f4ea776
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1400bb5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162c8ac0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/83bb4f67b45d/disk-f66d6acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb0cedffb310/vmlinux-f66d6acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3af8c8949657/bzImage-f66d6acc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bfaab1c46dcf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in hfs_inode_read_fork fs/hfs/inode.c:287 [inline]
BUG: KMSAN: uninit-value in hfs_read_inode+0x10ae/0x1690 fs/hfs/inode.c:343
 hfs_inode_read_fork fs/hfs/inode.c:287 [inline]
 hfs_read_inode+0x10ae/0x1690 fs/hfs/inode.c:343
 inode_insert5+0x1dd/0x970 fs/inode.c:1281
 iget5_locked+0xfe/0x1d0 fs/inode.c:1338
 hfs_iget+0x121/0x240 fs/hfs/inode.c:403
 hfs_fill_super+0x2098/0x23c0 fs/hfs/super.c:431
 mount_bdev+0x39a/0x520 fs/super.c:1693
 hfs_mount+0x4d/0x60 fs/hfs/super.c:457
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable rec created at:
 hfs_fill_super+0x67/0x23c0 fs/hfs/super.c:383
 mount_bdev+0x39a/0x520 fs/super.c:1693

CPU: 1 UID: 0 PID: 5790 Comm: syz-executor415 Not tainted 6.12.0-rc7-syzkaller-00216-gf66d6acccbc0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================


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

