Return-Path: <linux-kernel+bounces-291137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD629955DCA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C69A280F28
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E87814A095;
	Sun, 18 Aug 2024 17:06:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0786250
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000788; cv=none; b=jemUW9QjItflf3CSnMW+DuDVMLv7IsMBaoiVK6kRh/LEx0hz/vmkHpVHYtGcf1/d9mBairBb/xNR1UYrmzAbRDXuQwWzIm0UUZ/t3sx8WpV3EC2yWBqE2v1mWGHnogcqbul6A5ifi0aczcyObKdqHwBcrPl4HjDf4Q5Yh8LB9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000788; c=relaxed/simple;
	bh=7uihQaIe1v3SpARYJseHEKh6z9iSbqvBveQqHa7kFYk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oUt20OBlK9osgkpXcI6/yAuHgL9fTto2wN3+W3jA8PjUTvWSxi4G+9Wlmzn8cOqWJ52JQ1spXKcC37yy9SJ50yYRS8c1Zi+Yn1NfXAbuQ3S8SU15GpUccPRxV7VLTIW2rhN4sXGkrvPKAimObqolqmLOqHvEUFuXrMOix/hTvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-824c925d120so351836739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724000786; x=1724605586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVs+Y106R9IQp9A6uG6TsFq3/HHb4uB6f0rcaCLdZuI=;
        b=Qwk6fPhw+qIID0tEEdw7+cK86A61oNggdv9b/XlJuf08NMA6QYG9sWbiomZ0uVtmD1
         VA18HLzJrBzu/sDTGzQ2A8zJbvFPXkNLkG3HL34/M7tc7xTzBUTipQV8gcpeecb1ERin
         8fdEo6d5Udn7U/xtbpvC5IIETMfl1ZA8nR+BmQ8dHIEaisD64k5FHaWiiyVVBF+Izm0R
         0dvxzEzaM9IZ63FQ+fuRp21WKfY0wECeTgSJco2/MSU1mBlLRnebMQ2Xrhzx7oG2uMSd
         nfpipjruFTna9sH/wLzGcmdRKRpEmLiO16QSb8vVVBXV/V+6sOSX1CcyjmbQpYYaCqk2
         qYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKrmrSr6syKVyn8mDZOGxlZL7EzF2x+r3LGRwY/g/BWTR9iLly0XNzcs/Meim9JIt5ZYCJdk3DgBfT3TIiRVoyycSIfm0YuvCnDc8d
X-Gm-Message-State: AOJu0YypH1GinMXKkCbKtiHrRGK+rSYxaIiadFkZvc6lVQuc6jAjmGud
	gd8ui4bdufSgIQ4N/9AYTTT/0VCSP5dd5Z43+AODJlxEZVsAOwnRApHdOsR5r9YNC0GMKa1Dptx
	ugabiToM21I3bvCPynTsiTUJ3he6kLg8iXk87Z/5Nb86jI4VhHySKLHQ=
X-Google-Smtp-Source: AGHT+IGFxLUqEwkzkWLa6Apb7vm5HQFV8SnbEj8QmO9Oli1y7ktbggvOoAEAKr2TOeW5+aLPTlVzsFVGhdHF+fqO9tA0X81SLjLC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c03:b0:81f:8d10:6f00 with SMTP id
 ca18e2360f4ac-824f269c430mr33999439f.2.1724000786264; Sun, 18 Aug 2024
 10:06:26 -0700 (PDT)
Date: Sun, 18 Aug 2024 10:06:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007541d9061ff83615@google.com>
Subject: [syzbot] [ocfs2?] WARNING: bad unlock balance in ocfs2_read_blocks
From: syzbot <syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f2d783a459 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102f82dd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=ab134185af9ef88dfed5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a0ec05980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ac3093980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c3f2d783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d927f7c3cfd/vmlinux-c3f2d783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea54bdfad24b/bzImage-c3f2d783.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/f0e7bccc5087/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/5861bd127de9/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 9061
(syz-executor268,5095,0):ocfs2_read_blocks:240 ERROR: status = -12
=====================================
WARNING: bad unlock balance detected!
6.11.0-rc3-syzkaller-00338-gc3f2d783a459 #0 Not tainted
-------------------------------------
syz-executor268/5095 is trying to release lock (&oi->ip_io_mutex) at:
[<ffffffff837f37f6>] ocfs2_read_blocks+0x11c6/0x1620 fs/ocfs2/buffer_head_io.c:394
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor268/5095:
 #0: ffff8880207680e0 (&type->s_umount_key#43/1){+.+.}-{3:3}, at: alloc_super+0x221/0x9d0 fs/super.c:344

stack backtrace:
CPU: 0 UID: 0 PID: 5095 Comm: syz-executor268 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5199
 __lock_release kernel/locking/lockdep.c:5436 [inline]
 lock_release+0x5cb/0xa30 kernel/locking/lockdep.c:5780
 __mutex_unlock_slowpath+0xe2/0x750 kernel/locking/mutex.c:912
 ocfs2_read_blocks+0x11c6/0x1620 fs/ocfs2/buffer_head_io.c:394
 ocfs2_map_slot_buffers fs/ocfs2/slot_map.c:385 [inline]
 ocfs2_init_slot_info+0xb35/0x13d0 fs/ocfs2/slot_map.c:424
 ocfs2_initialize_super fs/ocfs2/super.c:2274 [inline]
 ocfs2_fill_super+0x31b7/0x5880 fs/ocfs2/super.c:994
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0669b38cea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0669aed048 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000100 RCX: 00007f0669b38cea
RDX: 0000000020000100 RSI: 00000000200044c0 RDI: 00007f0669aed0a0
RBP: 00000000200044c0 R08: 00007f0669aed0e0 R09: 00000000ffffffe8
R10: 0000000000000000 R11: 0000000000000282 R12: 00007f0669aed0e0
R13: 000000000000447d R14: 0000000000000000 R15: 0000000020002340
 </TASK>
(syz-executor268,5095,0):ocfs2_map_slot_buffers:388 ERROR: status = -12
(syz-executor268,5095,0):ocfs2_init_slot_info:426 ERROR: status = -12
(syz-executor268,5095,0):ocfs2_initialize_super:2276 ERROR: status = -12
(syz-executor268,5095,0):ocfs2_fill_super:1178 ERROR: status = -12


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

