Return-Path: <linux-kernel+bounces-241202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71566927833
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27733289486
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99B1AEFDD;
	Thu,  4 Jul 2024 14:22:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A181AEFF7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102944; cv=none; b=K6HOIHNLh1nxi7QYa24yohOJJgX33EPJujlIH7UCSNOMpVM8jtNaCGf9BvFyxhTTXdJcikZXkT7/tNXRI6w2jJq1unOyBY8H6AwPy+Tr0E7WbTsy3nTsgDeV9Uc3Fc4ybx4fMJpEEWfGMH+YUyUDLLE7bsrURJEKkRhqlQVa6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102944; c=relaxed/simple;
	bh=35CoZSReYLFJKV/f0XwHskDw7mzfsIS3I4SW2OMMszY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tEEyX20gaAiRgrpAWTFDm+8QGzM/usYKxQ+YRUP0oA0bZ59aN8qpLw32PJ97elqzSV4Lc3CGSrURLqzycTk3py4r+Hynv1Osjrq5XqPQ3YEDpoPHpjhPZdUgGrIKx9vlu14hV4E6bCwfb3UZyXQwsmk4IEueoTNyS4MK/JdYMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f4cff1d3d5so76567339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102942; x=1720707742;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMGr0Y7IvvwgN+c1B3bxJlbrMDt7uSdc7MkaUFXaJx8=;
        b=TB4Ie3pDjuX9dqlM0C7a9KhOftqumyopRLFGQq8uCh6SGResmhLxUs80uMH/57bCqS
         VijELxDrWxkIjN9OLGj0QWvzswwIYEyuNGhIvz+g3vo+Mh0FkvMEe2i8sEa1tbpQw6gs
         cNojZv5IRTJy+iXadErhw7H1dRCF2QUvsxOMfYSDA4grYS4uEF1KN0gIB2qe3fTxDJ2j
         BSADHEfXIlXko+PJJN0zVu6HSGJBOfzhPA5ZK9sCABzeT7ffZW6hUCXWTMryM5HYeVLk
         jpXmMseneYyL7dl7pAMJsIWffPEoMOPJbrxHuzz9A8G6vctLHew5Gv3HS4+E81nlHdV0
         iavw==
X-Forwarded-Encrypted: i=1; AJvYcCURekVaJBxPwJgyZOi0FqJrocyAqeyNvJ+pUWmopV5VacuYFPQoS6x/ysYIsIlB8wgLaLhJZ3wBDelmtepJ6LQGVfqWWdkRFYn7OKEH
X-Gm-Message-State: AOJu0YzKqhChoXg7AttAYFFeTItYp6z9ohrIqYiGvpR77X5AEOKWWoXQ
	F+3SGs2G5eNbG5dy2vtyYVeTihvv6F96L/sEl6KxVTHFp+YDS9GZuwMxbUnc8SMJYcHbxl5l9mG
	kj5Z88KXsNQJzVY4CawPi5yZKgACeF3LWwHJbEeF5A+HpgnLeyM1HW9k=
X-Google-Smtp-Source: AGHT+IH8fvPnibHl2G49Hb1xKvbSeMA1YVnj67a9pmyNVef/AmfwjJCRFsKylUEAT9mK0dNUdmaOxLSAzvqi9joRVeH4ksVmVUr+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2043:b0:4bd:4861:d7ea with SMTP id
 8926c6da1cb9f-4bf60de72a3mr105483173.2.1720102942425; Thu, 04 Jul 2024
 07:22:22 -0700 (PDT)
Date: Thu, 04 Jul 2024 07:22:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc5b12061c6cac00@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in __fsnotify_parent /
 __fsnotify_recalc_mask (5)
From: syzbot <syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a6b6b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
dashboard link: https://syzkaller.appspot.com/bug?extid=701037856c25b143f1ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d1d205c1fdf/disk-795c58e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/641c78d42b7a/vmlinux-795c58e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45ecf25d8ba3/bzImage-795c58e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com

EXT4-fs (loop3): unmounting filesystem 00000000-0000-0000-0000-000000000000.
==================================================================
BUG: KCSAN: data-race in __fsnotify_parent / __fsnotify_recalc_mask

write to 0xffff8881001c9d44 of 4 bytes by task 6671 on cpu 1:
 __fsnotify_recalc_mask+0x216/0x320 fs/notify/mark.c:248
 fsnotify_recalc_mask fs/notify/mark.c:265 [inline]
 fsnotify_add_mark_locked+0x703/0x870 fs/notify/mark.c:781
 fsnotify_add_inode_mark_locked include/linux/fsnotify_backend.h:812 [inline]
 inotify_new_watch fs/notify/inotify/inotify_user.c:620 [inline]
 inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
 __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inline]
 __se_sys_inotify_add_watch+0x66f/0x810 fs/notify/inotify/inotify_user.c:729
 __x64_sys_inotify_add_watch+0x43/0x50 fs/notify/inotify/inotify_user.c:729
 x64_sys_call+0x2af1/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:255
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881001c9d44 of 4 bytes by task 10004 on cpu 0:
 fsnotify_object_watched fs/notify/fsnotify.c:187 [inline]
 __fsnotify_parent+0xd4/0x370 fs/notify/fsnotify.c:217
 fsnotify_parent include/linux/fsnotify.h:96 [inline]
 fsnotify_file include/linux/fsnotify.h:131 [inline]
 fsnotify_open include/linux/fsnotify.h:401 [inline]
 vfs_open+0x1be/0x1f0 fs/open.c:1093
 do_open fs/namei.c:3654 [inline]
 path_openat+0x1ad9/0x1fa0 fs/namei.c:3813
 do_filp_open+0xf7/0x200 fs/namei.c:3840
 do_sys_openat2+0xab/0x120 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0xf3/0x120 fs/open.c:1439
 x64_sys_call+0x1057/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00002008

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 10004 Comm: syz-executor Not tainted 6.10.0-rc6-syzkaller-00069-g795c58e4c7fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
==================================================================


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

