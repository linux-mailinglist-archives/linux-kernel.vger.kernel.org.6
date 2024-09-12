Return-Path: <linux-kernel+bounces-326276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A454F9765C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79161C211DE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5819F40A;
	Thu, 12 Sep 2024 09:36:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0B19F139
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133788; cv=none; b=EQ5gzxwsViA8zF70mEXji9Tn7jOYE6OfSevhGxs0fxRKObrn4/nJdpMgcJ47vtc/4lVUNSCg2T9B6bbDM5z6dItyHpdZCq4xUDUFqyLi8LChUtUrXqY+B0DuxwZ+ioddx3XD78dzQG1Zb4F1aghCI3UqsHh7vLH4kIeHfPCs3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133788; c=relaxed/simple;
	bh=mL4k831LDyv5pQPGpi2fEErthbwQFXgBYakL0Nbzj38=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iAcmsQwzYCVKGEDEAzIOvS9DVrzi6Ki3Eo9jspeGjEZn9+H9HTuA8gihu3Fz4Wa6FTeRjj3/tSvqtr0uKFIr6hGeToycJp1Fx4LQemZbgbcW/QNE91kN+TGXhjSLBTavf5d/uRgKGcMkA8dGRiX8pUzoyXDKJMypU8LTWfr+7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d28a70743so9295915ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726133786; x=1726738586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKB0eE7ZI9MF1JlypPId8csJw6x53bmImAvh3U/e124=;
        b=eykSH2dEw49FvOCn5cLdfPhDlC8bSOM4DcuZISBHZcWyXEtWcOVjEzwxQ7H1a5ANT7
         c+Oc5qO6Y6PmF2No/p17U1ysx+/3pI62Gh9phdlbVyoTSd4ux8xXhnxvmC5QBgbb7vCe
         nYqaYRgKRxetKhSmmiAtCuLBlt2EqHI4z62ZNvTrRHDn6rPbj78v1Endh+SlkVU5TLwu
         R4iSAgLnUO9fzrC7NhOMqBTX19CLjGHQG+EN2T1BzMJwlpon5cLdZbdOJyRyjkSwqkoS
         nA1mFLrscLkAy5WJuzODAspN24P+P1m1gBC53oX51tlEMJXrOGB6ey9QaGeb7NFi0HTY
         8r7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu+4IT9rwtVkiF1thUKrp5UfS8S5p3MktIN4qWjUzzFEGY9NGAbKM3CcZL6eaCl3aKAfA34QOUTuXB7O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBohF6h/dQFcGOJG4XMTSe98Zhf8T3HjRN81mXdsjzN0lMc+ge
	SoLesKCYysutwKbM1SqF4Tc8rj4QrYnJl9aN0lDyNGX9I3XXTK47qmJJVNfBDO7ZimNnKBrNMPV
	O/83EWFywXeg1nBXvMl0iZo5z00YkOmMBb8r/etDOQmeKzYWcZnksJL4=
X-Google-Smtp-Source: AGHT+IFBtokV6oT9MfGcBhz2EtUKaNEj+xA2/9/AR24nutyEM8/mMsRKeNVHIyDbA07l6sm1j6M8l+TzrOf8Bqw/2Cgn86kCzPDT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cab:b0:39b:35d8:dc37 with SMTP id
 e9e14a558f8ab-3a08464e389mr14609875ab.13.1726133785922; Thu, 12 Sep 2024
 02:36:25 -0700 (PDT)
Date: Thu, 12 Sep 2024 02:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000251ced0621e8d78d@google.com>
Subject: [syzbot] [gfs2?] WARNING in rgblk_free
From: syzbot <syzbot+363090afa6ba1357e375@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167d5807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=363090afa6ba1357e375
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-7c6a3a65.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a9a78c56595/vmlinux-7c6a3a65.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1b4e1f2187a1/bzImage-7c6a3a65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+363090afa6ba1357e375@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 2ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5117 at fs/gfs2/rgrp.c:2269 rgblk_free+0x1f5/0x960 fs/gfs2/rgrp.c:2269
Modules linked in:
CPU: 0 UID: 0 PID: 5117 Comm: syz.0.0 Not tainted 6.11.0-rc7-syzkaller-00021-g7c6a3a65ace7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:rgblk_free+0x1f5/0x960 fs/gfs2/rgrp.c:2269
Code: 20 84 c0 0f 85 fc 06 00 00 8b 1b 89 df 44 89 ee e8 d0 d5 ac fd 44 39 eb 76 60 e8 06 d4 ac fd e9 e0 00 00 00 e8 fc d3 ac fd 90 <0f> 0b 90 49 bc 00 00 00 00 00 fc ff df 48 c7 84 24 80 00 00 00 0e
RSP: 0018:ffffc90002faf420 EFLAGS: 00010283
RAX: ffffffff83e6b7a8 RBX: ffff888000cd4028 RCX: 0000000000040000
RDX: ffffc9000b8d2000 RSI: 000000000000a5db RDI: 000000000000a5dc
RBP: ffffc90002faf530 R08: ffffffff83e6b79e R09: 1ffffffff2030ebd
R10: dffffc0000000000 R11: fffffbfff2030ebe R12: 0000000000090047
R13: 00000000000024a4 R14: dffffc0000000000 R15: ffff888000cd4000
FS:  00007fb62c0a76c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb62c067470 CR3: 0000000035656000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __gfs2_free_blocks fs/gfs2/rgrp.c:2525 [inline]
 gfs2_free_meta+0x99/0x280 fs/gfs2/rgrp.c:2552
 ea_dealloc_unstuffed+0x7cf/0xb00 fs/gfs2/xattr.c:303
 ea_remove_unstuffed fs/gfs2/xattr.c:342 [inline]
 ea_set_remove_unstuffed+0x1cb/0x290 fs/gfs2/xattr.c:1086
 __gfs2_xattr_set+0x6f8/0xcf0 fs/gfs2/xattr.c:1217
 gfs2_xattr_set+0x35d/0x460 fs/gfs2/xattr.c:1258
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 path_setxattr+0x37e/0x4d0 fs/xattr.c:658
 __do_sys_setxattr fs/xattr.c:676 [inline]
 __se_sys_setxattr fs/xattr.c:672 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:672
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb62b37def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb62c0a7038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007fb62b535f80 RCX: 00007fb62b37def9
RDX: 00000000200001c0 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 00007fb62b3f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb62b535f80 R15: 00007fff806d2368
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

