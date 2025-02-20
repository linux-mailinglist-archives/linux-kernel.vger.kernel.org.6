Return-Path: <linux-kernel+bounces-524828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7AFA3E795
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748593A4D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C52641F8;
	Thu, 20 Feb 2025 22:35:24 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4E1E9B35
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090924; cv=none; b=QlskO77dClt5OHtMjCKuwBQHXK+BZKppf2tQz2uHX2AcJ3pRWcenqgoBYTi4q10dHVVwM+Y0rDJD2HBUdWmZhPG4BLxHPbbb9s9i+uT0LgPmxuuGVgKHi32FknTGRYcJggM3mFnLugWjzg25WftWSn0lMajhOz2Rz5GL+3Y56pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090924; c=relaxed/simple;
	bh=ijyk55lzWg3n7ZFF/gLcubHcBhqTDuRhqm7w/8th/sY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=moOIpXGcpJEZzwuIfPKlziNCJOAi3E71lES5TTCkxkk44DaqCS+ZQ4rCjhzC/j6hIQZIN0fs8eD0Dzd2m1ciGoMafBSwaPERpgMGclV+Hj3mnn5T1UWcfpLnRAAZPnurvrOApJ2rMLujQYfSA8yRM0iX3AoQu66o9MVSkX6+LPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso11333915ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090922; x=1740695722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agDK5+Zl3GX3F7Oz3wf5K6RpdvFWW71K4VMoRjwWLn8=;
        b=cdD9tAfZmO8eGHZY7/BQKqYykk47OQsbhEDqLVrb3wKRRxyBmJ4Ptt/dltmK3VYEQh
         jtSylz5VlgGPl63RpqL0lR96kuXhP+OEyIuX4xpme1Eq//ghDBKRvkGLH7N+eAoDKocO
         hnnpwNbpK0yZq2RJLnfHCFPNVcy0OlYOqZGYkCSRiZ+cAGFTrekJp2kdrs1hLUKQpXdF
         Gmghla/0NWmNGcYSC2VtB29foUqNcbF4OQiFPEZc57BJj8jrJ4uKqFGHlfytjJLPw6Il
         bxILiT8sUjn4SbeArvsWbgrcQz8Eh+BRlONi7Y4oapkIYZ3vTlhPttCH6EL8aG9EGBby
         FM6A==
X-Forwarded-Encrypted: i=1; AJvYcCWzKIeo8DlwyaWLie2WAMB4rbHBi1Fojuq1z1zqLibTIYUm/h92S+dYbQLX+LQPLKxGO4IKyrCc6tPkULg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTW+sOGMztGT6AqiBSE5C1/azjLCtFWfQELYOtUDFkL0X3n0z
	mR2mN3kk0PBe1KZTwLueHFxcPu/awptJczYUB+vx3XwJwHOp1kNiOGl9M/8VtLECpQAeVOUU93d
	hnNRCzCB0HaqKQpwTQ0VCa11sIfQlutUETccfZhDqae1VWh5307rL8A4=
X-Google-Smtp-Source: AGHT+IEa8zH0Ykopx2dMK9O3dXzWmjTCoQDWu02Zj0nAj72YFDq2FB7nf11xVrWGt5DWX+JQwbj2gUV8cc8FAINOtb6LV4LiXytW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d83:b0:3d0:1db8:e824 with SMTP id
 e9e14a558f8ab-3d2cae69873mr8607965ab.10.1740090921992; Thu, 20 Feb 2025
 14:35:21 -0800 (PST)
Date: Thu, 20 Feb 2025 14:35:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7ae29.050a0220.14d86d.02fe.GAE@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in gfs2_jindex_free
From: syzbot <syzbot+41ebde41e42dfdd1797d@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    253c82b3a2ce Add linux-next specific files for 20250217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=154a75a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f984ff1d92cb4017
dashboard link: https://syzkaller.appspot.com/bug?extid=41ebde41e42dfdd1797d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af8b0f79abb4/disk-253c82b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/463f7d416e09/vmlinux-253c82b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07101e97dd04/bzImage-253c82b3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41ebde41e42dfdd1797d@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/gfs2/super.c:76!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5841 Comm: syz-executor Not tainted 6.14.0-rc2-next-20250217-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:gfs2_jindex_free+0x4a2/0x4b0 fs/gfs2/super.c:76
Code: 41 5e 41 5f 5d c3 cc cc cc cc 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c b6 fd ff ff e8 49 81 09 fe e9 ac fd ff ff e8 cf 0c a2 fd 90 <0f> 0b e8 57 9b ec 07 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900042efc00 EFLAGS: 00010293
RAX: ffffffff841ff1f1 RBX: ffff8880333f1378 RCX: ffff8880656bbc00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000001
RBP: ffffc900042efca8 R08: ffff888024b0cf6f R09: 1ffff110049619ed
R10: dffffc0000000000 R11: ffffed10049619ee R12: ffff8880333f1300
R13: ffffc900042efc40 R14: dffffc0000000000 R15: ffffc900042efc48
FS:  0000555583644500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe6777efe8 CR3: 0000000065e18000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_put_super+0x8c8/0x940 fs/gfs2/super.c:648
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1710
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1424
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f326d38e117
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe6777f1b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000064 RCX: 00007f326d38e117
RDX: 0000000000000200 RSI: 0000000000000009 RDI: 00007ffe67780360
RBP: 00007f326d40e08c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffe67780360
R13: 00007f326d40e08c R14: 00005555836444a8 R15: 00007ffe67781430
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_jindex_free+0x4a2/0x4b0 fs/gfs2/super.c:76
Code: 41 5e 41 5f 5d c3 cc cc cc cc 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c b6 fd ff ff e8 49 81 09 fe e9 ac fd ff ff e8 cf 0c a2 fd 90 <0f> 0b e8 57 9b ec 07 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900042efc00 EFLAGS: 00010293
RAX: ffffffff841ff1f1 RBX: ffff8880333f1378 RCX: ffff8880656bbc00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000001
RBP: ffffc900042efca8 R08: ffff888024b0cf6f R09: 1ffff110049619ed
R10: dffffc0000000000 R11: ffffed10049619ee R12: ffff8880333f1300
R13: ffffc900042efc40 R14: dffffc0000000000 R15: ffffc900042efc48
FS:  0000555583644500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fae8f599000 CR3: 0000000065e18000 CR4: 00000000003526f0
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

