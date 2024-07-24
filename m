Return-Path: <linux-kernel+bounces-261452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1D293B788
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CE0285D92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846971607AB;
	Wed, 24 Jul 2024 19:20:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887A613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848824; cv=none; b=cX8Bcgo0Ix+c7ePSauX3qr0pD9Ope5+Xy6Krsg9vSTPDictyAnCpuI6oOf7P0QMUPC2GPopZFFCoYiQqdJb16KCR0k8xH9y/NYbNbJJGghqldRLR+UA/JpD+RlWPdl1p/a15Wx8G3ljfm9KIn4+u2UmJKNXne2BmyDLbcB/2QIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848824; c=relaxed/simple;
	bh=oKJKRs/eTSi5xVif+yeiBjVR2WU//w2hzmdPY0HOi10=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KhFZ15uK/n1vNDcOP6W4366P77ol8YRuBokKT+2AsqLVzRBdDmfaw8GUj1U2spcsckDN1Egdz/eGHg1UwzoS3vrRMxLDfsZnWZy1hK1aC0faIe+r5Sph+gdjmU8gemHTnRSG8fnZEVz12B7A/a328D+w2tLKx6+K99FAvJ1SXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-396fa3fe46cso1255865ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848821; x=1722453621;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAfF8yFrvvPJASgn2RHcznuwDDgfM8r3YOT0gIovbTo=;
        b=nkX8vC6NkEuBDwTAQeYKJq78kupMmvtjQujRKUrRkL+Rc6hcRq6yTCUQweX1r52npR
         9kQ4ZWMkpyMLTRpINzWutVyeoUbmEWoVc88ICbdIqKmK3upMhuuTBWC0F6UWBVwxeaUx
         cOPXjSw3IWS2laSmnoe+DNBb7NWK3vEgNc99oo0LffVwD94kSucPZCE0t5N98wnlAAr0
         eKykx1PwnxNiMEKIzG7cUipP/K0rPr6q1IOq3H3vCmW58nohb7eYtPz2eIvLkDT2Cp9a
         fioKfHYUiaF653TKZvhec0960uzv/d8VAPS/t5x0oFB2gEzf+nqa06Im9h84Shdhjc/Z
         efoA==
X-Forwarded-Encrypted: i=1; AJvYcCVZLqwyAavDBj6uElCQHCUpQEvKj04Z5nR6XkEjw7dTLxE2MqJA4DGBqgCezmYAKR9MzWm/cGZrEsnj+oxbvXFXvldvn2YgFj/E+tLz
X-Gm-Message-State: AOJu0Yznnmq4h6Pf6owglvnMMepOJVe9L8V8ACyuR1TfoF911Rs7vGNL
	4hmqQEXoVbt+6ss1pxtoM/Mon9Ue6g/gyshokaAS6KlgN+onTf5obtfKrO+WA6fNRshv92C7U2i
	hRHdasf468maqmtVT/IGb39vzy/EBYEuoSnnCOedxa49lZEDUbRo6JNQ=
X-Google-Smtp-Source: AGHT+IEdMp7I0sC47IH5C/KOX4QoYuRCrgs+OWjjVNjITUGIVSEqfnt886GfHSJCSXb8lCmIGQdWyX4qgoH7B3vZ5y2Sy3UaVrrE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1383:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-39a2177dacfmr351165ab.0.1721848821475; Wed, 24 Jul 2024
 12:20:21 -0700 (PDT)
Date: Wed, 24 Jul 2024 12:20:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c7ccb061e032b9b@google.com>
Subject: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: chao@kernel.org, daehojeong@google.com, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158ef15e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136eee95980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1510b445980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c29a41eae6b/disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/938da4f6bc30/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f9521f6c1ef/bzImage-2c9b3512.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/1d96e2146be6/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/f1a30c7339a7/mount_14.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/b4ae6212a921/mount_18.gz

The issue was bisected to:

commit 3bdb7f161697e2d5123b89fe1778ef17a44858e7
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Wed Apr 3 23:07:53 2024 +0000

    f2fs: don't set RO when shutting down f2fs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dcb445980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dcb445980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dcb445980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Fixes: 3bdb7f161697 ("f2fs: don't set RO when shutting down f2fs")

F2FS-fs (loop4): Mounted with checkpoint version = 48b305e5
F2FS-fs (loop4): Stopped filesystem due to reason: 0
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:118 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0xca/0x630 kernel/kthread.c:704
Write of size 4 at addr 0000000000000028 by task syz-executor169/7772

CPU: 1 PID: 7772 Comm: syz-executor169 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 get_task_struct include/linux/sched/task.h:118 [inline]
 kthread_stop+0xca/0x630 kernel/kthread.c:704
 f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
 f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
 f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fac5a221249
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fac5a1ce218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fac5a2a8708 RCX: 00007fac5a221249
RDX: 0000000020000140 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007fac5a2a8700 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fac5a274b1c
R13: 00007fac5a274040 R14: 00007fac5a26e057 R15: 8c02ea27aa268e19
 </TASK>
==================================================================


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

