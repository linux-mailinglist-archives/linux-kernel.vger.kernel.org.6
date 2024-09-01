Return-Path: <linux-kernel+bounces-310347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90982967BA4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469DB281F5A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894A183CC1;
	Sun,  1 Sep 2024 18:05:36 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01D18306C
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213936; cv=none; b=R4oDBDse0CK3coz16Hdrrebq2XrVg3DR4dbhmylvYwrGtE81A8RpQVAkT4UR0ddoKlazw3noGncAQlySRChpafCI8hbCRDWjx+G4p+eMg/e5gzM2S5ttQFBpYkkfCcTktX2Z5UP7VoDHlr5/sjc1JaV4AfqxIP+IQkUrzQrucOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213936; c=relaxed/simple;
	bh=xe4H309ncZ6b3uP86vLrmgcA6/5kXN4xkauLD1CrmHw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tma+oN32V7RAySvyJSK9F9ByCs0SxVoAqAuhxzNEs1/893euVsNegmRvMJ8Hy2SjjjfZIcoOkDpyopRkEBDCFGDNflx9Y5BC7mxnt76G5WLmJ1LDr2w4um4aGZFP2V+Ur51s6roN+fOwE/uufYztF57MxQmGoqP7NBUM/IK6kVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2044b532so38296375ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 11:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725213933; x=1725818733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83Y3SnCsJy5Zx+0NGs/Pec13m9on1G/M8LYnEtKP7ZE=;
        b=Wf3/xdYTkjqbtlrmEazpCbLJE0pHwY423bpX6AzwZNjyoHQHAGcpvYWcZ9JOr6iZNo
         QFvOmD3o6FfKgMz/y1xEMkZsNenwWAC65OKoA3yBRsFl0ud1rUOcsPV557eQlw6/2i41
         7HeGGy1tDUgUQNnmI2dyvJNaBT/yhuuAP8wyVhMWN/Fo9f1nl9jLEhvt2vX2k+Gu+q1b
         JZR45N2jkg76xBGD8tysaL3a1sSc36d3LVz5YL5exQT+v3QIh1Q20d3swC5bSh4uAs/s
         5QBW4qcRFKdAeYFPFTMUHsyOuqEJBfjBOsHUyun/SfDfSA0LbYRx+t1F4w46N39kiibH
         Oz3A==
X-Forwarded-Encrypted: i=1; AJvYcCXP8MH1+xesVL2NR2whhOshBF+eRYj8bk5J0p0IDYWRvEYCrHuGKWO8ytIfU+6Nm/t2DlD7aUBThEmn3mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWm9ZNmnU1T3WXN/Efz1OV2GcOLHc3//w/tYBo9hbm59Q1/5AT
	9MOIhQWEf88UY+g0N5LsRIVyl7a0UCnvU+D2s7OtqWGjLM7afENHcs9CaXTfhdVisOxEXSMjAuL
	9SFQEssBVSU//dgS9f5xh0+6fAMW8vy6Y7flZjmplog7jFGe63nTyG7o=
X-Google-Smtp-Source: AGHT+IGp7cfo4urMQBIpzM8jClXAfbPR8iCw+8Nx+l71AUO3OvrTj+GvLYceLashzIeWpH0kCorjGLq7h++S7VZX4CIv6CcwzCBQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b05:b0:39f:4ec5:f4bf with SMTP id
 e9e14a558f8ab-39f4ec5f75amr1609865ab.0.1725213933688; Sun, 01 Sep 2024
 11:05:33 -0700 (PDT)
Date: Sun, 01 Sep 2024 11:05:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adea7f062112ab4c@google.com>
Subject: [syzbot] [ntfs3?] BUG: sleeping function called from invalid context
 in ntfs_d_hash
From: syzbot <syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86987d84b968 Merge tag 'v6.11-rc5-client-fixes' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12935393980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8605cd35ddc8ff3c
dashboard link: https://syzkaller.appspot.com/bug?extid=7f71f79bbfb4427b00e1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14516fa7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bf1e47980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/17720a1549d0/disk-86987d84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/55a9f2cf6e8d/vmlinux-86987d84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8760a72ae7d5/bzImage-86987d84.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/8d38edc6ad5d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/57ba0d69287b/mount_1.gz

The issue was bisected to:

commit d392e85fd1e8d58e460c17ca7d0d5c157848d9c1
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Tue Jun 25 06:57:33 2024 +0000

    fs/ntfs3: Fix the format of the "nocase" mount option

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1525a647980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1725a647980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1325a647980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com
Fixes: d392e85fd1e8 ("fs/ntfs3: Fix the format of the "nocase" mount option")

ntfs3: loop0: Failed to initialize $Extend/$Reparse.
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:337
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5222, name: syz-executor508
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
1 lock held by syz-executor508/5222:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: path_init+0x12a/0x1360 fs/namei.c:2437
CPU: 0 UID: 0 PID: 5222 Comm: syz-executor508 Not tainted 6.11.0-rc5-syzkaller-00057-g86987d84b968 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8463
 might_alloc include/linux/sched/mm.h:337 [inline]
 slab_pre_alloc_hook mm/slub.c:3939 [inline]
 slab_alloc_node mm/slub.c:4017 [inline]
 kmem_cache_alloc_noprof+0x5d/0x2a0 mm/slub.c:4044
 ntfs_d_hash+0x1a0/0x420 fs/ntfs3/namei.c:398
 link_path_walk+0x92d/0xea0 fs/namei.c:2375
 path_openat+0x25d/0x3470 fs/namei.c:3882
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5174e4c2f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8ece6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffe8ece6040 RCX: 00007f5174e4c2f9
RDX: 000000000000275a RSI: 0000000020000240 RDI: 00000000ffffff9c
RBP: 00007ffe8ece6048 R08: 00007ffe8ece6048 R09: 00007f5174e17ff0
R10: 0000000000000000 R11: 0000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

