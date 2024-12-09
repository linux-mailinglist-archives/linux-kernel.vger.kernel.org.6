Return-Path: <linux-kernel+bounces-438534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5632B9EA261
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108E9283DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655719F13F;
	Mon,  9 Dec 2024 23:04:27 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16D19E99A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785466; cv=none; b=IWoS/NCXFtdE4+X+xk05er9Bkw7BRZDOt3v0pty1Cv015/StW3zhHwWEBIOVvwj9AdYiz8ozSeGusrFVt/Uqi6C/8LqTVL+p1LDut1ZrY6R1CeiIjD7UxJDMzQVp08Q60msc1kj3IExGSXk1xQNyl/0dBxC9oAWUwLYFg/QDGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785466; c=relaxed/simple;
	bh=Z3YoCyy4IGUBZ6RFrCf//nvDaIZQrVkwUgSGOnXQ0wo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qev006x4OeiFOsHgaZH4aBecypuFkldVWAuTZqa3YoY0ivO6LsAIgrCjc5nQwBvLbLiQe7HUgTeMz0S4Vr2bWRLZzwGQ8vmbFHikrVVtKoHRA/ueqglydmWob7rmt/NCY931Fe+vhkKlPykl7OvG32c3+o7MfbP2NLkHhJvc9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so48303175ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785464; x=1734390264;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlaYjZHkax7nVCPO4BIjO5tfDCepzCUxyxZQiMBgZGo=;
        b=FZwC03BW06zGAW9vzoiutQGwVgcUhTT3VDxN7UAxLrlZZxYqG1S0pcgsLKRujYTg34
         w6DsPA/aXo1l/j3E/zLpblbkhReWlCYp4qF7KzFW7D8gbNDp0DM+AZmhqnOa7LsLrZwf
         yE1VC2vVhl4hDC0cnLGw/PecEigf+uCbk3d9375atHVPlNmxaLe+ZIaTPggYeQg+E64U
         nviwqZjMb9g4ZvbOyT8/579m+Ahxy695XVDRpqwk1DtM1USv+gldsw0PqiBzWuR+2tId
         SH8f+w77ywFE3jtZMqbJFN+3+PxIZGHhFd6UwQwT0MsmyRO1nuy96Evy6tDXsg9WSM2V
         Wv6w==
X-Forwarded-Encrypted: i=1; AJvYcCWltwBgoDsMKav6PyvIyDGJALTWRcX3ctGxrGXppuYiHh1+a+j7caJ5qqdALyf25D/QMH6n3zhq6kqsqgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeX7FBK8/ovh+se5iRCVC+MrJKrvOTgQVTwet/DdS1d4bAJ4zc
	UNqaAgkzxt7UiPgtqOaN6ZiqRSWTh2lMTWzHzg5Y7lmoJMG6UUQi1rn+4/e9DRHC5RfOvpBH1vI
	2YoNJ2oUYUShoDsXyY/LMdQGLWWqiFWaerYKJgTKEDRHyJsoT0qc9qiE=
X-Google-Smtp-Source: AGHT+IEmuXVmpSA564uB1k43FVRjkDAHLl3WkeP4iIkSbG9JQ/bqkZDjSiva+CJRHFj44ClKkTwXxiYmcdDIaRLIVK9WvQ/vLAHh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3a9dbb2355emr27934235ab.19.1733785464120; Mon, 09 Dec 2024
 15:04:24 -0800 (PST)
Date: Mon, 09 Dec 2024 15:04:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67577778.050a0220.a30f1.01bc.GAE@google.com>
Subject: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_search_extent_list
From: syzbot <syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5076001689e4 Merge tag 'loongarch-fixes-6.13-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120f68df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=2313dda4dc4885c93578
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b29330580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b29330580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-50760016.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76ef343a98c8/vmlinux-50760016.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e42b3235bcc3/bzImage-50760016.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/893e4e85ff3d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
JBD2: Ignoring recovery information on journal
==================================================================
BUG: KASAN: use-after-free in ocfs2_search_extent_list+0x155/0x200 fs/ocfs2/alloc.c:776
Read of size 4 at addr ffff888049800000 by task syz-executor307/5410

CPU: 0 UID: 0 PID: 5410 Comm: syz-executor307 Not tainted 6.13.0-rc1-syzkaller-00036-g5076001689e4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 ocfs2_search_extent_list+0x155/0x200 fs/ocfs2/alloc.c:776
 ocfs2_get_clusters_nocache+0x21a/0xbf0 fs/ocfs2/extent_map.c:438
 ocfs2_get_clusters+0x5bd/0xbd0 fs/ocfs2/extent_map.c:621
 ocfs2_extent_map_get_blocks+0x24c/0x7d0 fs/ocfs2/extent_map.c:668
 ocfs2_bmap+0x2b7/0x780 fs/ocfs2/aops.c:474
 bmap+0xa8/0xe0 fs/inode.c:1997
 jbd2_journal_bmap+0x12d/0x2b0 fs/jbd2/journal.c:926
 do_readahead fs/jbd2/recovery.c:88 [inline]
 jread+0x435/0xc80 fs/jbd2/recovery.c:165
 do_one_pass+0x3cd/0x3aa0 fs/jbd2/recovery.c:646
 jbd2_journal_skip_recovery+0x95/0x240 fs/jbd2/recovery.c:366
 jbd2_journal_wipe+0xc9/0x110 fs/jbd2/journal.c:2517
 ocfs2_journal_wipe+0xab/0x2a0 fs/ocfs2/journal.c:1192
 ocfs2_check_volume fs/ocfs2/super.c:2413 [inline]
 ocfs2_mount_volume+0xb86/0x1940 fs/ocfs2/super.c:1817
 ocfs2_fill_super+0x476e/0x5760 fs/ocfs2/super.c:1084
 mount_bdev+0x20a/0x2d0 fs/super.c:1693
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc66ec71aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee9a2de18 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffee9a2de30 RCX: 00007fdc66ec71aa
RDX: 0000000020004440 RSI: 0000000020000040 RDI: 00007ffee9a2de30
RBP: 0000000000000004 R08: 00007ffee9a2de70 R09: 0000000000004431
R10: 00000000000008c0 R11: 0000000000000282 R12: 00000000000008c0
R13: 00007ffee9a2de70 R14: 0000000000000003 R15: 0000000001000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x49800
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f0(buddy)
raw: 04fff00000000000 ffff88805ffd7230 ffff88805ffd7230 0000000000000000
raw: 0000000000000000 000000000000000a 00000000f0000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff8880497fff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880497fff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888049800000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888049800080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888049800100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

