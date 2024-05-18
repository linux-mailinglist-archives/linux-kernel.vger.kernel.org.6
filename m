Return-Path: <linux-kernel+bounces-182771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0288C8F96
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 06:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06880B20EE2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 04:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AE8F49;
	Sat, 18 May 2024 04:28:34 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EA29A2
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716006514; cv=none; b=iwyj0uxaNNpUbd/eY2ZA9HKXthD3kiKxEYD5syTDx4d6F30Mdlhj3TT5i7q1UgkUUtqG6GkZoJxKynmd3pxCO9gOKZrI9bxL6bpa0/ur//NL/bkPKcXNTaiFHKALXt3nfHopHsS8dVfk3I0qRwWZEXPNQmD76M4YL0YunFpasts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716006514; c=relaxed/simple;
	bh=e64NGIf0pBGszdoUf4IpF/hcMVSsUDLvVGmtxTZqfU8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UbHw+YFaYyx2fAWgQ8pWAkN0cvriLWOi6P7tmIvN2g4Sv3V31gcJMN+VOYev3toB6/X+GpUWxYRNQwRfHS9VxdZ+9GXqm2F+7XnidsiOK/9C0RHbRgUUK3w5pxvlKr/iKlslxO51iov4lldAAvUIG6y3aj20uWH05Gl3bmn8jIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1d56d36b9so837718739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716006512; x=1716611312;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBHO1S9NxogkqJjTBRij/9wmAvilUNV4j/zXnwQVJFE=;
        b=etp9CqBM93UJtEJeM2HyuoE9wBkuiK9y21eNnmZBd5X69i4LaKCejXPHJ6KyfwtxwZ
         F4cmKsDjERXk1EQALxngQ9nLEF3MXcHMAYnuGz9toaSJ1vyiPXmad0Ole7FBXALDwIaU
         6E51yZssMmffFwld9lRUig4XAcudJYasjNhZCASsJ0H5Mj/6eTxwC6NYf10WnXNv5b7o
         NVI0VIMc2Pt2t/zWy8j2uDmQTRBUla/51clpM4Qfgcidv3K9vDmEj3jOJjTXpoc6sFye
         ePNfC+jHZJ1aW8vkFSp9vY4kCr6KsylU/+CQ/+TP6aLhtHCOOTSePwW7QtF4rvHHDwTI
         jGDA==
X-Forwarded-Encrypted: i=1; AJvYcCUyXaSWpNclu/aT6onlcwekBbvnYTdFw3BcJm+Kwu/SaRq6cwcolR723vmhw85PVzrF8Z+8EQLK1UveDxkaio9gLPsCuTL26wBKW54j
X-Gm-Message-State: AOJu0YyjrRyc2fBofV3FYGfRa4ZHFU+gD63OnJwUEAxbuMt5O0erVQii
	4sncBdakErLawsQrs2ULRUOrVX508DzKPTx32MevLZjRw35oCYlydT5PGfThr7NTNpPO3Rpuo4v
	y5zbgjOrmDwhD9S/ARSLtt4Qcv5EWvKFFPgkYz+zB9Vlspv3HYH4JPxM=
X-Google-Smtp-Source: AGHT+IHYBnAMvTLXRNFObOVoi4Ae6xEE72/uGamyxHtrxqeZVv2WnXmm2TTyhEcw+ZRsro33DbHUqZAWEU7NRahrbipOpMTi3Owx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8d:b0:7da:b30e:df80 with SMTP id
 ca18e2360f4ac-7e1b500aed7mr121047139f.0.1716006512022; Fri, 17 May 2024
 21:28:32 -0700 (PDT)
Date: Fri, 17 May 2024 21:28:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094e5b70618b2e6c1@google.com>
Subject: [syzbot] [f2fs?] WARNING: locking bug in f2fs_getxattr
From: syzbot <syzbot+8f9e913ccc308e66c407@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5131c3fdf26 Merge tag 'x86-shstk-2024-05-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cee100980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4f7e6f2d15a8e15
dashboard link: https://syzkaller.appspot.com/bug?extid=8f9e913ccc308e66c407
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a81f43baa3cd/disk-a5131c3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46b648092f89/vmlinux-a5131c3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6e6c1a3a7e3/bzImage-a5131c3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f9e913ccc308e66c407@syzkaller.appspotmail.com

F2FS-fs (loop2): Try to recover 1th superblock, ret: 0
F2FS-fs (loop2): Mounted with checkpoint version = 48b305e5
------------[ cut here ]------------
Looking for class "c->lock" with key init_kmem_cache_cpus.__key, but found a different class "&c->lock" with the same key
WARNING: CPU: 0 PID: 5944 at kernel/locking/lockdep.c:935 look_up_lock_class+0xdc/0x160 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 0 PID: 5944 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:look_up_lock_class+0xdc/0x160 kernel/locking/lockdep.c:932
Code: 01 0f 85 80 00 00 00 c6 05 1d 21 13 04 01 90 49 8b 16 49 8b 76 18 48 8b 8b b8 00 00 00 48 c7 c7 80 dd ca 8b e8 95 d8 d7 f5 90 <0f> 0b 90 90 eb 57 90 e8 78 23 2b f9 48 c7 c7 c0 dc ca 8b 89 de e8
RSP: 0018:ffffc9000455ee70 EFLAGS: 00010046
RAX: cedb96dd9fdb9000 RBX: ffffffff92c296e0 RCX: 0000000000040000
RDX: ffffc9000a9a0000 RSI: 000000000000ef17 RDI: 000000000000ef18
RBP: ffffc9000455ef80 R08: ffffffff81589ca2 R09: fffffbfff1c39d38
R10: dffffc0000000000 R11: fffffbfff1c39d38 R12: ffffe8ffffc76260
R13: ffffe8ffffc76260 R14: ffffe8ffffc76260 R15: ffffffff94791b10
FS:  00007f130db086c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f130ce7ddf0 CR3: 000000023177c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 register_lock_class+0x102/0x980 kernel/locking/lockdep.c:1284
 __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 local_lock_acquire+0x20/0x80 include/linux/local_lock_internal.h:29
 ___slab_alloc+0x1004/0x12e0 mm/slub.c:3641
 __slab_alloc mm/slub.c:3682 [inline]
 __slab_alloc_node mm/slub.c:3735 [inline]
 slab_alloc_node mm/slub.c:3908 [inline]
 kmem_cache_alloc+0x252/0x350 mm/slub.c:3925
 f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2832 [inline]
 xattr_alloc fs/f2fs/xattr.c:30 [inline]
 lookup_all_xattrs fs/f2fs/xattr.c:333 [inline]
 f2fs_getxattr+0x477/0x13b0 fs/f2fs/xattr.c:533
 vfs_getxattr_alloc+0x474/0x5c0 fs/xattr.c:393
 ima_read_xattr+0x38/0x60 security/integrity/ima/ima_appraise.c:229
 process_measurement+0x11d5/0x1f60 security/integrity/ima/ima_main.c:340
 ima_file_check+0xf2/0x170 security/integrity/ima/ima_main.c:559
 security_file_post_open+0x6f/0xa0 security/security.c:2981
 do_open fs/namei.c:3652 [inline]
 path_openat+0x28b7/0x3240 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f130ce7dd69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f130db080c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f130cfabf80 RCX: 00007f130ce7dd69
RDX: 000000000000275a RSI: 0000000020000040 RDI: ffffffffffffff9c
RBP: 00007f130ceca49e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f130cfabf80 R15: 00007ffe63d5a628
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

