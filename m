Return-Path: <linux-kernel+bounces-195084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7980F8D476B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA2BAB20BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69B6F2EE;
	Thu, 30 May 2024 08:46:30 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6F1761BF
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058790; cv=none; b=HWGycxgJ0fQiScmx6Ms/i3JPYu5ZzUtJfkVVnCx0KfX/SYa1QcMUmWZXeZFKrYSqmV2c7kCb83ImZxdce4oR+2BISg5XaIaaeiV+os5zXJDS4L+Ut3Bd7HZD4DYCmn6cu6zduY6yXLNHiDuo+WpKRGNFvQitDLYdUVE0z9dDcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058790; c=relaxed/simple;
	bh=5+LHasuOIYiWmSTZWOGMNCpGQ1ATSwQT4Ficzma0FdI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=guNdkg34/YRfcyt7wS4jS2jHrcQtPbZGNf1CsXcOe1B3sUs8xfSasioiOVcZhDB3bRiimzys2MQwzOznLBPG8SQX2COY4L+YP4rdEFUfdz6jrvD0H+QJCWFOQHWqBsPxGIrgWtu1a1OJYRCYJG7GZNGrwrtlBM8IbTg7AuDM7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-37481e2793eso1628075ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058788; x=1717663588;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOHiZgHlaOGjmg5s/A045cvtq4Ms3VgIs/iP1UczQ2M=;
        b=QzjY+YoZEkl8rSmME80OwvXOkh4ohoy3i9EeEX+yq8PJ0wn3Ac8RCtqrZxxhxiLBHq
         V9vRbBKktVXhgA9gzo91IuDyZRBL8TK/02IX31XkurSCmpMmumbs2q8Y0vDl9Bo4cr7R
         Y6fIG15tIy8ioC0xZnU4NEnneP3w8cdCqSkoIZF/MVeEYgPeYUHL6MKcjfECBcztZUZV
         /1zjjQRmxqWQXEUNNkjdvVWYIbA5Nr14+bCI4nfNpYRZeVgyVdjwTo/9oWlQgzHaWbOi
         KLjhztPVNRHkJBLGnFVW70ryi73BiYQZTTsGgMbT0tGUxZBXUUKzqxtp5W2CmbXIHSMW
         c9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUdhPfTo+S6ukeyy9sC1YuzZmXjP0L4sm3AhBWkn3LTrlrSjd+RKSU3c6WoxedmDlSMnQFjIm+Jht1eWWX36719RvnoCB+hg7E2KTak
X-Gm-Message-State: AOJu0Yy8qrtwgcMGX3pRcp77ylD3eR7Ja1jouwMiVKCaR6N7pGJ4DuzU
	V5fDoEeZVV6llYRbJW/eQKHgSgii8iM/4zhCmXm1xIoKTx1fdnNEUnYvUbWbWsPtL7dmaJu7Bdu
	gvsVTj8+195mD8IxskN1kc6u9D/sy3CHDlSB1YGCo+gJMXXMWcSc0EsM=
X-Google-Smtp-Source: AGHT+IH/7Gn/EX/fKTucYomipSI4I2HjJ27JxZ+EGJ/hoUiolaqsTpBPvWYk/ZYLUteUaJLTJlGiKtHEdkDUHNE2hIs207l6chVc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0e:b0:371:a225:45b5 with SMTP id
 e9e14a558f8ab-3747e1ee036mr604125ab.1.1717058787873; Thu, 30 May 2024
 01:46:27 -0700 (PDT)
Date: Thu, 30 May 2024 01:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c2dac0619a7e77c@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_flush_nocow_writes_async
From: syzbot <syzbot+917694e2e9db5284865f@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    101b7a97143a Merge tag 'acpi-6.10-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d948f2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ac2f8c387a23814
dashboard link: https://syzkaller.appspot.com/bug?extid=917694e2e9db5284865f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4f673334a91c/disk-101b7a97.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e6db59f4091/vmlinux-101b7a97.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e5782387c9d/bzImage-101b7a97.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+917694e2e9db5284865f@syzkaller.appspotmail.com

bcachefs (loop0): snapshots_read... done
bcachefs (loop0): journal_replay... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in find_first_bit include/linux/find.h:207 [inline]
BUG: KMSAN: uninit-value in bch2_inode_flush_nocow_writes_async+0x6bd/0x6f0 fs/bcachefs/fs-io.c:64
 find_first_bit include/linux/find.h:207 [inline]
 bch2_inode_flush_nocow_writes_async+0x6bd/0x6f0 fs/bcachefs/fs-io.c:64
 bch2_inode_flush_nocow_writes fs/bcachefs/fs-io.c:99 [inline]
 bch2_flush_inode+0x3d4/0x480 fs/bcachefs/fs-io.c:186
 bch2_fsync+0x1d1/0x2a0 fs/bcachefs/fs-io.c:203
 vfs_fsync_range+0x20d/0x270 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2811 [inline]
 bch2_buffered_write fs/bcachefs/fs-io-buffered.c:1136 [inline]
 bch2_write_iter+0xe59/0x5b30 fs/bcachefs/fs-io-buffered.c:1144
 do_iter_readv_writev+0x7e6/0x960
 vfs_writev+0x574/0x1450 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
 __se_compat_sys_pwritev2+0x2a8/0x490 fs/read_write.c:1210
 __ia32_compat_sys_pwritev2+0x11d/0x1a0 fs/read_write.c:1210
 ia32_sys_call+0x918/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:380
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmem_cache_alloc+0x5b9/0xc20 mm/slub.c:3925
 bch2_alloc_inode+0x56/0x280 fs/bcachefs/fs.c:1497
 alloc_inode+0x86/0x460 fs/inode.c:261
 new_inode_pseudo fs/inode.c:1007 [inline]
 new_inode+0x38/0x4f0 fs/inode.c:1033
 bch2_new_inode+0xc8/0x290 fs/bcachefs/fs.c:224
 bch2_lookup_trans fs/bcachefs/fs.c:408 [inline]
 bch2_lookup+0x1993/0x1fc0 fs/bcachefs/fs.c:437
 lookup_open fs/namei.c:3483 [inline]
 open_last_lookups fs/namei.c:3574 [inline]
 path_openat+0x27a9/0x5b00 fs/namei.c:3804
 do_filp_open+0x20e/0x590 fs/namei.c:3834
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_compat_sys_openat fs/open.c:1481 [inline]
 __se_compat_sys_openat fs/open.c:1479 [inline]
 __ia32_compat_sys_openat+0x298/0x300 fs/open.c:1479
 ia32_sys_call+0x38e1/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:296
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 PID: 15357 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-02339-g101b7a97143a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


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

