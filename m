Return-Path: <linux-kernel+bounces-369062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07319A1887
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03FF1C2188E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E1F3EA6C;
	Thu, 17 Oct 2024 02:18:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246417580
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131487; cv=none; b=oixQtzbBmrQSbduJ3OHDdK1prqRn/zHu+hse+SvatUbwnwoZzZ029DnxZnh5HnyjGrO4f7TFG0c0A/CytueixPj35zEBxNWoeMBQw7Ig4wlaDvoZT0F53UHrpdUuYnnX/wJXFcdDIo+Qr6z3usACaBJCl9poeATFF8DSIf92eZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131487; c=relaxed/simple;
	bh=iTJhuWTU5F6snIB24atb4F2rYWxzZy4FUo69IUx0iQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sEDVXhhJTyrHQlha9bpEolxkAbQjM0ocDkwq1YbJlSqaK8NYg6OJNNADqrjxMPV503JIwK0PaQcluoptLyACwR+r5JKcyJmXNFZIFLGWRzDOboVYOJgMKDyHx7Pq9ZM6qFRjSxekgmbgznGOdSwaX9aDpa1bD3dXvK4mW701EMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso4353465ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729131484; x=1729736284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqoaEixJpFtdYJcRuC99UMtplAQjxhkAotXGFWUQNe0=;
        b=kUThn6hiSAKxGcfUOUKNwBCuj8vl6lHzqKcMSlhqrgGudNEpcqu3Z94A0EQrZwOa8M
         YWSUxWJcYkSqbEJB9r8xDoTPB8Erk6gGNWUdule8vYWO9CxuzBVOOVbvG3/1f/vDTizO
         45Jlp2NYBcWakOpoGvRWz0FfeQicbehGxjC1I3dF3ED+JxONyT0AHaC+pzxSfWEBBTPv
         5qVaQMsirKh4ukd1f/twXb4GKpovWVURlLgx/yiPuv0mouFK0TKFAUtLNVJ0+DFhAecB
         ljuGluyKIYjvJiv1Ttvfd9lXY0I/5Ok6XKM9pwEHNdO1od0maDClrX3ygnYpUXGcY12t
         zObw==
X-Gm-Message-State: AOJu0YxorPSFY4KDaXmaYIKjWNoEo4X4zGzW6tlkOyI6OMM7jWe9pD3C
	fgCpLs2rG/ZE6gNV68FflzB6cYbEQY9V9SEdSVH7GQdLqzqpgH0EQxiMDJzGHADggQVrJ0TKJZm
	YJ7lGUJoWfaeGh+pZ1kvOKohNSKOgJ1Czv7V5d4jQoSsNfPAzs1/13Xs=
X-Google-Smtp-Source: AGHT+IHBQVBn3R7MpoRkIvTgMNESWBbLuMk4CRFvuQ0wtk9Y/wSUnxFSPTA451DJFEAFjtq5I8fqpN2yC/Aqfu8sCfx8FDA4E03W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170a:b0:3a0:9aef:4d0 with SMTP id
 e9e14a558f8ab-3a3dc4a04f7mr61147675ab.5.1729131483777; Wed, 16 Oct 2024
 19:18:03 -0700 (PDT)
Date: Wed, 16 Oct 2024 19:18:03 -0700
In-Reply-To: <20241017015210.3665821-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671073db.050a0220.d9b66.0177.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_fiemap
From: syzbot <syzbot+ca440b457d21568f8021@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ocfs2_fiemap

         option from the mount to silence this warning.
=======================================================
ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc3-syzkaller-00087-gc964ced77262-dirty #0 Not tainted
------------------------------------------------------
syz.0.15/6035 is trying to acquire lock:
ffff88807a5ee098 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0xaa/0x120 mm/memory.c:6700

but task is already holding lock:
ffff888071633f60 (&oi->ip_alloc_sem){++++}-{3:3}, at: ocfs2_fiemap+0x377/0xf80 fs/ocfs2/extent_map.c:755

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&oi->ip_alloc_sem){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       ocfs2_page_mkwrite+0x1e9/0xed0 fs/ocfs2/mmap.c:139
       do_page_mkwrite+0x198/0x480 mm/memory.c:3162
       do_shared_fault mm/memory.c:5358 [inline]
       do_fault mm/memory.c:5420 [inline]
       do_pte_missing mm/memory.c:3965 [inline]
       handle_pte_fault+0x11fa/0x6800 mm/memory.c:5751
       __handle_mm_fault mm/memory.c:5894 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6062
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __might_fault+0xc6/0x120 mm/memory.c:6700
       _inline_copy_to_user include/linux/uaccess.h:183 [inline]
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:216 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ocfs2_fiemap+0x9f1/0xf80 fs/ocfs2/extent_map.c:796
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1bf8/0x2e40 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&oi->ip_alloc_sem);
                               lock(&mm->mmap_lock);
                               lock(&oi->ip_alloc_sem);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz.0.15/6035:
 #0: ffff888071633f60 (&oi->ip_alloc_sem){++++}-{3:3}, at: ocfs2_fiemap+0x377/0xf80 fs/ocfs2/extent_map.c:755

stack backtrace:
CPU: 1 UID: 0 PID: 6035 Comm: syz.0.15 Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __might_fault+0xc6/0x120 mm/memory.c:6700
 _inline_copy_to_user include/linux/uaccess.h:183 [inline]
 _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:216 [inline]
 fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
 ocfs2_fiemap+0x9f1/0xf80 fs/ocfs2/extent_map.c:796
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1bf8/0x2e40 fs/ioctl.c:841
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f351397dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35147e5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3513b35f80 RCX: 00007f351397dff9
RDX: 00000000200001c0 RSI: 00000000c020660b RDI: 0000000000000005
RBP: 00007f35139f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3513b35f80 R15: 00007ffef5debf08
 </TASK>


Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14483030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=ca440b457d21568f8021
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bdf727980000


