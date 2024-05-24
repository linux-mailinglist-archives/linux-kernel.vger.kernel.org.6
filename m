Return-Path: <linux-kernel+bounces-188812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7A8CE749
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1272A1F2188F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5AB12C53A;
	Fri, 24 May 2024 14:41:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA921AACC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561693; cv=none; b=HN1VN9Apij5E7QoHYc3doY77hVM5EqUYTscFkaahEucm1wR7osN9tjIcO14GPV2gDTKJsnAAHbF9VVNNDBAy+LgyedDxKZIihz2WVilWJD/tps9QqnjmAfLSsKm1kj1JKP9h26ccGRt/i46Pe3GnkNkLmgdFlakjKG3t/6d1VtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561693; c=relaxed/simple;
	bh=Vu45rtbcjvN3EGAu7WZguOVfW+W89M687Ss5idA7zMc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oM6Mh7247eREA7VXM7k4dGFfDKaZi5PxIUMxJ1H6cHJnqui/fMFp4fIGzjgN+XdbCChL5IN4ti6BPh2lHElnFDbgUTLNswkdKzpMtNCE8OuE963XguPTVZjdf03202iS359UpD/QNIi/48xGcv95C8ZSPT9B0se6tLtAos7Xk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3737b3db665so9925615ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561691; x=1717166491;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3diBwk1afZHyXCXGdf1TiC34TBcucgnkB2c00Bw3NuY=;
        b=iYCtCTkZLrPECHbjlL3noATT09oWePcmb0skcRjknti4Nl69B4EACqysyPR2qgfhZW
         dpZf00HzvS0abyal0AGYuAd5HAQngJOQeLW6KaeT+l2qejVD57cYVGSH18UufA02oKFk
         1aEdOjoG2MxbKtY60MYxu+j3skKlIEYV1ytwQd1L25fhuFCJc1P3YQhb1XUvNnm2Exra
         0kPM/Y7J0WGlRmU5oED981X++JRWRnxkZndQNjo3iGFgJhAeKhy42GfTFUk7Y7F8Vm1t
         f0RAanxPCsY2d14rv65K3MV+qsnYkeyu72vPrnVGdYaQwXCS4qVBecX3KYQbU2Tao3M8
         Howw==
X-Forwarded-Encrypted: i=1; AJvYcCWaGuZr+ysA0ZQwpuae3eUlu4B3VnYimLuos3hGJPvfBmLeIzDDVtN/Ky6a7bEkSefpqz6eyNIZll4pPrDdf/JQpfpSkbJu3rLWN4QC
X-Gm-Message-State: AOJu0YysG3l9ujInpm+zipBufAhA5F+JlgAQ1CNKWhYO79sngV9f4E1G
	WgJ5hlW0UsqDb5EDBWNuZGi5OEatw5vNwSAsB3aDZPQlPBsyAfK3Y9VWzf0q+MCsAx0PZ24+jIN
	RC0MwArBDTcKZB1tgcGLimCpGtNH6MZXWjJ+eHdbi2ygP2zHTMF6jdZY=
X-Google-Smtp-Source: AGHT+IHRpaYBI4bRsEi3wGjh+b2oK/19QZWQUqN6tLK7mhhdWh8PlbnMXcBW/BqneqkO9+W9BBS8AUarJgCW+pY8gxJ7qNQ9hKAh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:36d:d38e:3520 with SMTP id
 e9e14a558f8ab-3737b33d769mr1754245ab.4.1716561690925; Fri, 24 May 2024
 07:41:30 -0700 (PDT)
Date: Fri, 24 May 2024 07:41:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2b05506193429da@google.com>
Subject: [syzbot] [f2fs?] WARNING in f2fs_getxattr
From: syzbot <syzbot+3c58b51b764fa1f423b1@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb6a9339efeb Merge tag 'mm-nonmm-stable-2024-05-19-11-56' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d95748980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2ea586e11acd6ec
dashboard link: https://syzkaller.appspot.com/bug?extid=3c58b51b764fa1f423b1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-eb6a9339.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21782c1528d1/vmlinux-eb6a9339.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c377678e8b1/bzImage-eb6a9339.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c58b51b764fa1f423b1@syzkaller.appspotmail.com

F2FS-fs (loop2): Mounted with checkpoint version = 48b305e4
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(l->owner)
WARNING: CPU: 0 PID: 6234 at include/linux/local_lock_internal.h:30 local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
WARNING: CPU: 0 PID: 6234 at include/linux/local_lock_internal.h:30 ___slab_alloc+0x16c2/0x1870 mm/slub.c:3715
Modules linked in:
CPU: 0 PID: 6234 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-09699-geb6a9339efeb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
RIP: 0010:___slab_alloc+0x16c2/0x1870 mm/slub.c:3715
Code: 98 02 85 c0 74 09 83 3d bf bd 00 0e 00 74 21 90 e9 30 ff ff ff 90 48 c7 c6 bf f8 36 8d 48 c7 c7 f6 c3 36 8d e8 df 54 6f ff 90 <0f> 0b 90 90 eb c6 90 48 c7 c6 c8 f8 36 8d 48 c7 c7 f6 c3 36 8d e8
RSP: 0018:ffffc900063376a0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000246 RCX: ffffc9000c171000
RDX: 0000000000040000 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: ffffc90006337780 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff88801b4ac880
R13: ffff888040ef4dc0 R14: ffffe8ffad044130 R15: ffffe8ffad044110
FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:00000000f5f1cb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020aa3000 CR3: 0000000026fac000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmem_cache_alloc_noprof+0x2ae/0x2f0 mm/slub.c:4007
 f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2832 [inline]
 xattr_alloc fs/f2fs/xattr.c:30 [inline]
 lookup_all_xattrs fs/f2fs/xattr.c:333 [inline]
 f2fs_getxattr+0x46d/0x11e0 fs/f2fs/xattr.c:533
 f2fs_xattr_generic_get+0x138/0x170 fs/f2fs/xattr.c:63
 __vfs_getxattr+0x13b/0x1a0 fs/xattr.c:423
 cap_inode_need_killpriv+0x40/0x60 security/commoncap.c:302
 security_inode_need_killpriv+0x65/0xb0 security/security.c:2504
 dentry_needs_remove_privs fs/inode.c:2015 [inline]
 file_remove_privs_flags+0x3a6/0x5d0 fs/inode.c:2046
 file_modified_flags fs/inode.c:2167 [inline]
 file_modified+0x47/0x200 fs/inode.c:2196
 f2fs_write_checks fs/f2fs/file.c:4553 [inline]
 f2fs_file_write_iter+0x3cf/0x2160 fs/f2fs/file.c:4822
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1120 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf732a579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f1c5ac EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000000000
RDX: 00000000fffff000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

