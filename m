Return-Path: <linux-kernel+bounces-381098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB229AFA55
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435781C233D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAD21B3941;
	Fri, 25 Oct 2024 06:49:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135411AF0D9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838968; cv=none; b=Y/8wXChqVub1JMuEZg0A2h9Y3mYSxkgugKoMyRAbx9WISpGa9cAvQcLGL2Wpx01FY9lueG0EBfwr76amktBLTJGo2TZ2aXwCjW5FXLWckAqBobuCQB1XBNqBYyyIWjk7xA26IXv1WwaiRMxSCQ0zTppAWvL+OxSPRPIPzsc98k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838968; c=relaxed/simple;
	bh=VwREwhRNZR0z6IywVS2UWjw+tCAMAjImrfRMK8g+hkk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Lq4FhkNbNvnIZjqWvfkYH1L9pDjcUJsyN8kDPDz1uAm4NXmpJQzcSW8rmgwYHOmGRO18SH2zyq6wQNamNAjl0A3IGHC+qqimMoQ3iuQCwSBypS8Lv5YvNKJPmlXvGuczRTwNRzeYJ1WSXWHsmmzT5AnSzsyEOWvCANVUujH7O9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83a9bd80875so141851739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729838965; x=1730443765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ENrF44kdEafTjiWpcBLPP++m/bbeZa0/PNmjO+pqWc=;
        b=e1vS4luoUi90tBKrFtuGcgpuIETKdexXRe5EnFCwCB7i/0lOncUSeYPVHwc3TtK7EN
         vudkuDlIMkCKXXuJP1TEiKqryoSZcJgcyssQywKqt6Lo2TP8si+R8jvPoddKTsRarg3Y
         sbkzc3uorY30S8yRpU+cMgmNOd0eXUr5kXjrPP/iQSnUlpoi6L8BVXui5GyqHrUtgU0U
         gpXnExqQ7qyz/CIgTuR/A8qDPER9v+KWip2sucHE66+7dVuKPhRfY454QlMciDKpfO0k
         YrFHV+mqdsDU3b/0bj5hMIPGSzcf3k4y0g17kp6yhTp8+mNkZRUaUzSz3IA8XeDdTjy4
         v1EA==
X-Forwarded-Encrypted: i=1; AJvYcCUjCCvQU+WHDxJdqZn4FmYG2pASMOztfq8aOvzE9u6MXyPIiIk68wQauzBsx0Io3mc2Bc/hGK+13RV/U8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWVssQStk2BNolrve/IcrugTWYMSrDybq35jK+KCd99r+hYKf
	O39UzJ0TyrjNHqZh8EiQvnIM656XZaErkZuNceG9VsIRzRg0DqDVS67tSw569nxePqV3JWuWsqR
	LekBTzI8ceGQyharLg9gF+4ZNnZyfWJFsIEKNC8sAB+dW7kxNAAsuHkU=
X-Google-Smtp-Source: AGHT+IFyRKWaw53QPjuZkyjq6K8OjEl9gJDRfohptNTLQi7A2vH7m7T1jcjoHdLNKoshpEAK9NzxdLbhVygJBkwjFZhpbCpl0eVV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c7:b0:82c:eeaa:b1e0 with SMTP id
 ca18e2360f4ac-83af63fe31fmr915806039f.11.1729838965211; Thu, 24 Oct 2024
 23:49:25 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:49:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b3f75.050a0220.2eb763.00d6.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in __bch2_bkey_cmp_packed_format_checked
From: syzbot <syzbot+8761afeaaf2249358b14@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4e46774408d9 Merge tag 'for-6.12-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151d5e40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=8761afeaaf2249358b14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1622a8a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12de3287980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4e467744.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/058a92aaf61a/vmlinux-4e467744.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b79757fbe5e/bzImage-4e467744.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8081b555fd65/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8761afeaaf2249358b14@syzkaller.appspotmail.com

  fragmentation     134217728
  bp_start          8
, fixing
 done
bcachefs (loop0): check_inodes...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/bkey_cmp.h:104!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5092 Comm: syz-executor201 Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__bch2_bkey_cmp_packed_format_checked_inlined fs/bcachefs/bkey_cmp.h:103 [inline]
RIP: 0010:__bch2_bkey_cmp_packed_format_checked+0x7ef/0x800 fs/bcachefs/bkey.c:1021
Code: fd 90 0f 0b e8 02 8e 83 fd 90 0f 0b e8 fa 8d 83 fd 90 0f 0b e8 f2 8d 83 fd 90 0f 0b e8 ea 8d 83 fd 90 0f 0b e8 e2 8d 83 fd 90 <0f> 0b e8 5a 5c b5 07 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000af8de20 EFLAGS: 00010293
RAX: ffffffff841149fe RBX: 1ffff920015f1bcc RCX: ffff888000898000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000001
RBP: ffffc9000af8df50 R08: ffffffff8411470b R09: 0000000000000000
R10: ffffc9000af8dec0 R11: fffff520015f1bda R12: dffffc0000000000
R13: ffffc9000af8dec0 R14: 0000000000000001 R15: 00000000ffffffff
FS:  0000555577522380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b92594a008 CR3: 000000003e38e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bkey_cmp_p_or_unp fs/bcachefs/bset.h:291 [inline]
 bkey_iter_cmp_p_or_unp fs/bcachefs/bset.h:400 [inline]
 bch2_bset_search_linear fs/bcachefs/bset.c:1189 [inline]
 bch2_btree_node_iter_init+0x234b/0x4280 fs/bcachefs/bset.c:1334
 __btree_path_level_init fs/bcachefs/btree_iter.c:615 [inline]
 bch2_btree_path_level_init+0x4d2/0x9f0 fs/bcachefs/btree_iter.c:635
 btree_path_lock_root fs/bcachefs/btree_iter.c:769 [inline]
 bch2_btree_path_traverse_one+0x10de/0x2940 fs/bcachefs/btree_iter.c:1170
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 bch2_btree_iter_peek_slot+0x84f/0x2550 fs/bcachefs/btree_iter.c:2616
 __bch2_bkey_get_iter+0x10d/0x2a0 fs/bcachefs/btree_iter.h:575
 dirent_get_by_pos fs/bcachefs/fsck.c:1173 [inline]
 inode_get_dirent fs/bcachefs/fsck.c:1188 [inline]
 check_inode_dirent_inode fs/bcachefs/fsck.c:1209 [inline]
 check_inode fs/bcachefs/fsck.c:1312 [inline]
 bch2_check_inodes+0x18f9/0x5080 fs/bcachefs/fsck.c:1466
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:185
 bch2_run_recovery_passes+0x387/0x870 fs/bcachefs/recovery_passes.c:232
 bch2_fs_recovery+0x25cc/0x39c0 fs/bcachefs/recovery.c:862
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2170
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9d0165ee2a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0ef30e48 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc0ef30e60 RCX: 00007f9d0165ee2a
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00007ffc0ef30e60
RBP: 0000000000000004 R08: 00007ffc0ef30ea0 R09: 00000000000059c8
R10: 0000000002200006 R11: 0000000000000282 R12: 0000000002200006
R13: 00007ffc0ef30ea0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bch2_bkey_cmp_packed_format_checked_inlined fs/bcachefs/bkey_cmp.h:103 [inline]
RIP: 0010:__bch2_bkey_cmp_packed_format_checked+0x7ef/0x800 fs/bcachefs/bkey.c:1021
Code: fd 90 0f 0b e8 02 8e 83 fd 90 0f 0b e8 fa 8d 83 fd 90 0f 0b e8 f2 8d 83 fd 90 0f 0b e8 ea 8d 83 fd 90 0f 0b e8 e2 8d 83 fd 90 <0f> 0b e8 5a 5c b5 07 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000af8de20 EFLAGS: 00010293
RAX: ffffffff841149fe RBX: 1ffff920015f1bcc RCX: ffff888000898000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000001
RBP: ffffc9000af8df50 R08: ffffffff8411470b R09: 0000000000000000
R10: ffffc9000af8dec0 R11: fffff520015f1bda R12: dffffc0000000000
R13: ffffc9000af8dec0 R14: 0000000000000001 R15: 00000000ffffffff
FS:  0000555577522380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b92594a008 CR3: 000000003e38e000 CR4: 0000000000352ef0
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

