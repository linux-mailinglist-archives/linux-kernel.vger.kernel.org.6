Return-Path: <linux-kernel+bounces-314220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE096B029
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A951C23F24
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C5824AC;
	Wed,  4 Sep 2024 04:50:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F9286A6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425422; cv=none; b=GJuyF7iMDZ0cyZVHTUDNsXrR+bQbaVic24eWk11SNmapAs2GdLC4n4yZm1hKSvY+jLFd0rFKDqtiohQ+jZrYmHqfrsgkyuxCyQ6vMwEE1CKTBCFH3yX36lv3giLKIdjnC/E0MgI6i4eoQ2WEUjWF4UeHpx+z2o+JyJF+tIOGRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425422; c=relaxed/simple;
	bh=jFXY+i1PUscbe7kIJ0oZQ+5n89W3Cj5UD4/9aexX6N8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Pb6JFRCMj4jTa0HZbwP5J0aoKzDWe+K/jpCajKvefHTH5T4bnnqXUcs2M/V1exPuf0XkIb8XQQifx/7zDxhP2/dqtyG5BPh8rexpbkrNR6+dxOH7N3N2KVH1WrbPhMIDOc6s44he2ayIiouwdOnt35TJmoPG2ogKpdCQoxEJTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a1c57f4a1so823261739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 21:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725425420; x=1726030220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zqd5iifVr8DWHCkb+dSEYsmiDd1HT0T9vAuP4BYQNb0=;
        b=hjatlMmmCe5uwUlVGTB5MrVkxKBDlEcdJ4Scg+7z/hgXU+otn5z6HdRdltkHwTpARL
         +Mte0LC5x4z52v1QpqYQjWBKuqixw9YSLEYYRk9JE+/U8wfdqGEKmRmF4nh0F4zKYJqA
         dwASyKmcV+dy2+Y132D6M9Yv+vm/SaIsirfOz8a/4YaWRaDGF5jWiDnClUbH3jchBb8g
         1ZFZJNLZ8PD2FoAPInX9kFRD/UPTaOKaHx0xZ9nieUyXtqFa9ILtCbWoBcJWKjY2+BVZ
         XCgjqQTTuq5Az1eeioiAitU0ujBgEuwSTv+CPXIJP6IMR6XkXz9tUYFfTa65K59HfdZU
         oZaw==
X-Forwarded-Encrypted: i=1; AJvYcCXT1dpPBE0VVZHtfTNL0euTftK5Loo3XCI5eBBA+YB7RyrgnWX8jryDrQ+pNfoUz/jzfjIl1liUb6Jyo4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiHbZvg4jJO/mJwkwv6ksJTQjE61Q5SDhe0nPIqjsRjq6TdA9
	N2KgZEyKJUV+Raz/pF8bG8lDv1m8QZea4tjqbEYFq9YSq8PonEbRz81mpHNyClz088ltup7CRG7
	odkT4o59//chH6JI/20uC2VlssyN7191BMHs5Fsa1cF3G0qSXk85Rkic=
X-Google-Smtp-Source: AGHT+IH8guYVsiyhajNeXuQNTdJsO/n4jziA78H/bXpnf/M8HxzNMsFIwxlkZQpRXGwH9eMkuBFp5GoSlOgbZNiF2ZBRquI5VceI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b0b:b0:7f9:919c:432b with SMTP id
 ca18e2360f4ac-82a262fbdeemr65738139f.4.1725425420262; Tue, 03 Sep 2024
 21:50:20 -0700 (PDT)
Date: Tue, 03 Sep 2024 21:50:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042f2c5062143e9fd@google.com>
Subject: [syzbot] [ext4?] kernel BUG in jbd2_journal_dirty_metadata
From: syzbot <syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fb24560f31f9 Merge tag 'lsm-pr-20240830' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1739530b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=c28d8da3e83b3cc68dc6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-fb24560f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d39db26a2bc/vmlinux-fb24560f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8910481ae16e/bzImage-fb24560f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
loop0: detected capacity change from 32768 to 0
syz.0.0: attempt to access beyond end of device
loop0: rw=0, sector=10576, nr_sectors = 1 limit=0
(syz.0.0,5108,0):__ocfs2_xattr_set_value_outside:1385 ERROR: status = -5
(syz.0.0,5108,0):ocfs2_xa_set:2261 ERROR: status = -5
(syz.0.0,5108,0):__ocfs2_journal_access:705 ERROR: Error -30 getting 1 access to buffer!
(syz.0.0,5108,0):ocfs2_journal_access_path:751 ERROR: status = -30
(syz.0.0,5108,0):ocfs2_truncate_rec:5443 ERROR: status = -30
(syz.0.0,5108,0):ocfs2_remove_extent:5584 ERROR: status = -30
(syz.0.0,5108,0):__ocfs2_remove_xattr_range:782 ERROR: status = -30
(syz.0.0,5108,0):ocfs2_xattr_shrink_size:836 ERROR: status = -30
(syz.0.0,5108,0):__ocfs2_journal_access:705 ERROR: Error -30 getting 1 access to buffer!
(syz.0.0,5108,0):ocfs2_xa_prepare_entry:2152 ERROR: status = -30
(syz.0.0,5108,0):ocfs2_xa_set:2255 ERROR: status = -30
------------[ cut here ]------------
kernel BUG at fs/jbd2/transaction.c:1513!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5108 Comm: syz.0.0 Not tainted 6.11.0-rc5-syzkaller-00207-gfb24560f31f9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jbd2_journal_dirty_metadata+0xbab/0xc00 fs/jbd2/transaction.c:1512
Code: ff e9 74 fc ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c af fc ff ff 4c 89 ef e8 30 27 8a ff e9 a2 fc ff ff e8 66 dc 22 ff 90 <0f> 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fd ff ff 48 89 df e8
RSP: 0018:ffffc90002d7ea38 EFLAGS: 00010283
RAX: ffffffff8270afca RBX: ffff88801240bca0 RCX: 0000000000040000
RDX: ffffc90003092000 RSI: 00000000000081b4 RDI: 00000000000081b5
RBP: 1ffff11002481794 R08: 0000000000000003 R09: fffff520005afd38
R10: dffffc0000000000 R11: fffff520005afd38 R12: ffff88801240bc98
R13: 1ffff110065e591e R14: ffff88801240a000 R15: ffff88801240bc38
FS:  00007f28379866c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200010c0 CR3: 000000003ce4c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_journal_dirty+0x156/0x7c0 fs/ocfs2/journal.c:812
 ocfs2_xa_journal_dirty fs/ocfs2/xattr.c:1453 [inline]
 ocfs2_xa_set+0x225b/0x2b40 fs/ocfs2/xattr.c:2264
 ocfs2_xattr_block_set+0x46e/0x3390 fs/ocfs2/xattr.c:2986
 __ocfs2_xattr_set_handle+0x67a/0x10a0 fs/ocfs2/xattr.c:3388
 ocfs2_xattr_set+0x128c/0x1930 fs/ocfs2/xattr.c:3651
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
RIP: 0033:0x7f2836b79eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2837986038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f2836d15f80 RCX: 00007f2836b79eb9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000020000080
RBP: 00007f2836be793e R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2836d15f80 R15: 00007ffdcb3dd268
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jbd2_journal_dirty_metadata+0xbab/0xc00 fs/jbd2/transaction.c:1512
Code: ff e9 74 fc ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c af fc ff ff 4c 89 ef e8 30 27 8a ff e9 a2 fc ff ff e8 66 dc 22 ff 90 <0f> 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fd ff ff 48 89 df e8
RSP: 0018:ffffc90002d7ea38 EFLAGS: 00010283
RAX: ffffffff8270afca RBX: ffff88801240bca0 RCX: 0000000000040000
RDX: ffffc90003092000 RSI: 00000000000081b4 RDI: 00000000000081b5
RBP: 1ffff11002481794 R08: 0000000000000003 R09: fffff520005afd38
R10: dffffc0000000000 R11: fffff520005afd38 R12: ffff88801240bc98
R13: 1ffff110065e591e R14: ffff88801240a000 R15: ffff88801240bc38
FS:  00007f28379866c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200010c0 CR3: 000000003ce4c000 CR4: 0000000000350ef0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

