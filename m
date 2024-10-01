Return-Path: <linux-kernel+bounces-345626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E998B84F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8827C1C22386
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7801B19DFAB;
	Tue,  1 Oct 2024 09:27:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C39B67D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774852; cv=none; b=PpR1s91OeWH5qMXQBYl7vP4i1/nrJQFzVCYXl0KIziC/05pg3BAil/i/Mr5pjOuhY5WUgMzExvez0LcyagUr7crLpizE/VV8+SvTfdyKN9gsWqhmmfn014w+sx6iWzxeFqDWE/JKQe27L+uXyQoHQQHp+qhqUf0vRNBM93C52/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774852; c=relaxed/simple;
	bh=QNWQjBqQHqR5XQkgIYYYN3RstCDf2QbAhqg+ZPRzke8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PuXe+muk1SfMzxW4rLWT3UVmXDQzVnQq03abyOmAR5SjZJIBkvQv+4yJ8oe6o2DINuW+AwqHoX6Bv59D21+uwF2r/5IwvQ8iKM2u1UtwPIi+9QtfAcSsewIflWxnSR1NJxNBzobiYxmSprNo5r2OK5n+wSu47eJpWyh+kpt+GKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82aa499f938so481921439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774849; x=1728379649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kc7ivSE9qCrYu3kXFK+RkmNV7+Tj1L1ACo/tudpxxoI=;
        b=CD6bwlf/eJS3GWvVGxz2N9lZppoK9hvzhOnA2Amgws20f+CrXX+pI2yY439YutFW1d
         UGm534w6lzY2OzORfgd3EK8YyABRqAt1KkjydZaaZ1Wv8Tpzu3xRb6iFK3nGVZeEgy5w
         omc4w827v9eW5gF4TyEk2mPxMw+hb0iJ84vPyGJ9ZVPCwjXq7S7FXkrR/DmXkTrRnZ+B
         +sBnQ8gIeVP5why7/INdV9PnSaW10fi+ndXp71EXR3gSVdxGIgZGlUK8duDYJ7yQFz+u
         dOec7ANiNncHGbsSOwp9nx5v1IwzmEtl4QGjBq5PlbtJQ0xqA5IrAY5snL2M2X4//cfn
         2/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiPyF79i05UasvEgbqtM4K5SkNRj1Ll/Ld1CJi1QjfxoeHS4FMMf8B8/0cZGMki5jMsRDIMBW279vEshE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywT1NbyXfm04nZssC5WsyaVYioMtLzRwkwkkGBDMKB105d9lyd
	nFtSVuLkoUmtMMwO8KXQepLdnDXEgvyf5/DVsm36pzxf/ZttDUSQ4fVu7JSDLbU5e577wuhMDF1
	yhYs3sjuNQZvkR6YTDcwCNKk5B1q03rSvNqNG1g+0BsAVr1NuOOrGVvA=
X-Google-Smtp-Source: AGHT+IEJMLdbyn3J82EFux1eSZlQKw5vhPYG+pgEHcBA4mi2iNQHLQ2IYZUc64N4L+suY26peL98FbY7CoRHMsTK/Aot+5CW+Pyn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a35eb05072mr21855985ab.1.1727774849442; Tue, 01 Oct 2024
 02:27:29 -0700 (PDT)
Date: Tue, 01 Oct 2024 02:27:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b9be27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85d8f50d88ddf2a
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b9be27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ddd507980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/265feec46ffa/disk-ad46e8f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0f41ea693d3/vmlinux-ad46e8f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45082d33d192/bzImage-ad46e8f9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c19549ac916f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
 __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_get_block+0x733/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4092 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
 hfs_get_block+0x68d/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5188 Comm: syz-executor246 Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


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

