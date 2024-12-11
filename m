Return-Path: <linux-kernel+bounces-441111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D09EC9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FAF1889229
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EC11DFE26;
	Wed, 11 Dec 2024 09:54:26 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F21C5CAC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910866; cv=none; b=ITLruX6PBnTK4A//yqFXApxXPRe045720bP68R0EivNEOcsSBS7ttUukviWDVIuug/OlgLI63fcSX9OeILEAru0+9FHn5/F+yOumkHmg82oQtvwfDyricMJgKVi37TB5G+H1h2P+g/ah7ZMRJQTjg3z7X42iLToh1ylaxIcGSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910866; c=relaxed/simple;
	bh=neLcSCO7FuPXRHDl0h5zIFHBBVXZPhwo4Laj50ozTns=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YZ3Rb8oI8aR8+SP9LdQRW++d5so5cQk8lvS14IIVeyhqY/hSMsDrHj13cO0WE/x/ICAbmH+3UZyzl2Y4hs3i1paJuPMV/aBs2bGWasdOgWy7vPMKfK7YXS+HRzsRcQme9EsfOS0aqTlXvPt1O0UT8D390Eg6mX0ahsnqSxQYFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a812f562bbso93333235ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733910864; x=1734515664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+fay17taHXFBDh4RbEffJkLVWBjiLfW/1BhMdmhSiI=;
        b=e1cHjgGJ5tLf9dZMH66QMbfIA3cHrXfunnX7+A0JycldtQnjHo3cQAoNlm0k6MDdJV
         CQDWl+XFs3WmrFmkmKBVcKVBfJJ0iGY9z95hU77QimSLbSfC+Kim0ZNabw39lQfT5pnc
         SP2EmUp7k5oU3T1wtiG9p1uMU5Y93hFdA/V9MftIZgnq0+m6VmGu7Zf8/pm7x2nEQTNG
         CJV4S35EYqyAIksGeuNyIhVEyZhtMX8QQ/wy/I2IgOPEfb4ZCv9gs+FvkrhiPQEepbdE
         Ljo50DoX8PWNLOiyqUtvJpiLHW9DW5rQGKdIzcerrvMSxkeUgSDpGLIznjJ96xzvl44T
         Dvug==
X-Forwarded-Encrypted: i=1; AJvYcCX2jm2KBm4NmBHYqAeox+ra/yVLytkNkAU7P1h9cGNGG1gXi7I+76+OpMqtdwq6CFLiJd0LdEjZK116wtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmGPh8PqaBLu7w94t8gKeK/ngDhFWZmrVfBpRq0Gk94ltatBS
	2yfP1EAF7aCxanPw15MoRz/W4qceWmXnIs7ehw/SHErpryAnOWPJjhLT6XA0gGNxVPtvPED1z3C
	qwkuYBTjXHE2cjKDe4dkwk/cErAaVs4AZ3flhJdk1Dh9ZPJqL1SUlEDE=
X-Google-Smtp-Source: AGHT+IGbvplk2JkcgSvwMRBVRcM92vGsL+VcGpCHS/oEXj4M3gRbrpQCz+K9yF7+aqRSMA9s2xhNlKn5LyyYPaZRDMuh/n39p1Se
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd88:0:b0:3a7:c5cb:8bf3 with SMTP id
 e9e14a558f8ab-3aa0616248bmr25586175ab.9.1733910863763; Wed, 11 Dec 2024
 01:54:23 -0800 (PST)
Date: Wed, 11 Dec 2024 01:54:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759614f.050a0220.17f54a.0037.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_alloc_sectors_start_trans
From: syzbot <syzbot+7727bbb9b847a6d3d8de@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9a6e8c7c3a02 Merge tag 'drm-fixes-2024-12-07' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12020820580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcc2c6db74766fbc
dashboard link: https://syzkaller.appspot.com/bug?extid=7727bbb9b847a6d3d8de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5d7d5a6fd94d/disk-9a6e8c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a82a9827cbbc/vmlinux-9a6e8c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f2d0bbaf255/bzImage-9a6e8c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7727bbb9b847a6d3d8de@syzkaller.appspotmail.com

bcachefs (loop1): stripes_read... done
bcachefs (loop1): snapshots_read... done
bcachefs (loop1): check_allocations... done
bcachefs (loop1): going read-write
bcachefs (loop1): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in writepoint_find fs/bcachefs/alloc_foreground.c:1313 [inline]
BUG: KMSAN: uninit-value in bch2_alloc_sectors_start_trans+0x44a/0x32b0 fs/bcachefs/alloc_foreground.c:1413
 writepoint_find fs/bcachefs/alloc_foreground.c:1313 [inline]
 bch2_alloc_sectors_start_trans+0x44a/0x32b0 fs/bcachefs/alloc_foreground.c:1413
 __bch2_write+0x7f8/0x8540 fs/bcachefs/io_write.c:1437
 bch2_write+0xec0/0x1d10 fs/bcachefs/io_write.c:1631
 closure_queue include/linux/closure.h:270 [inline]
 closure_call include/linux/closure.h:432 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:449 [inline]
 bch2_writepages+0x24a/0x3c0 fs/bcachefs/fs-io-buffered.c:641
 do_writepages+0x427/0xc30 mm/page-writeback.c:2702
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_write_and_wait_range+0x59d/0x850 mm/filemap.c:684
 bchfs_truncate+0xab2/0x1490
 bch2_setattr+0x29f/0x2f0 fs/bcachefs/fs.c:1163
 notify_change+0x1a8e/0x1b80 fs/attr.c:552
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_compat_sys_truncate fs/open.c:152 [inline]
 __se_compat_sys_truncate fs/open.c:150 [inline]
 __ia32_compat_sys_truncate+0x6c/0xa0 fs/open.c:150
 ia32_sys_call+0xa62/0x4180 arch/x86/include/generated/asm/syscalls_32.h:93
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was stored to memory at:
 bch2_writepage_io_alloc fs/bcachefs/fs-io-buffered.c:477 [inline]
 __bch2_writepage+0x39d9/0x3f10 fs/bcachefs/fs-io-buffered.c:599
 write_cache_pages+0xc9/0x280 mm/page-writeback.c:2659
 bch2_writepages+0x11f/0x3c0 fs/bcachefs/fs-io-buffered.c:639
 do_writepages+0x427/0xc30 mm/page-writeback.c:2702
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_write_and_wait_range+0x59d/0x850 mm/filemap.c:684
 bchfs_truncate+0xab2/0x1490
 bch2_setattr+0x29f/0x2f0 fs/bcachefs/fs.c:1163
 notify_change+0x1a8e/0x1b80 fs/attr.c:552
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_compat_sys_truncate fs/open.c:152 [inline]
 __se_compat_sys_truncate fs/open.c:150 [inline]
 __ia32_compat_sys_truncate+0x6c/0xa0 fs/open.c:150
 ia32_sys_call+0xa62/0x4180 arch/x86/include/generated/asm/syscalls_32.h:93
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4110 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_lru_noprof+0x91c/0xe20 mm/slub.c:4172
 __bch2_new_inode+0x98/0x450 fs/bcachefs/fs.c:401
 bch2_new_inode fs/bcachefs/fs.c:427 [inline]
 bch2_inode_hash_init_insert+0x7d/0x3a0 fs/bcachefs/fs.c:447
 bch2_lookup_trans fs/bcachefs/fs.c:622 [inline]
 bch2_lookup+0x1605/0x2360 fs/bcachefs/fs.c:659
 lookup_open fs/namei.c:3627 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x292f/0x6200 fs/namei.c:3984
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_compat_sys_openat fs/open.c:1479 [inline]
 __se_compat_sys_openat fs/open.c:1477 [inline]
 __ia32_compat_sys_openat+0x298/0x300 fs/open.c:1477
 ia32_sys_call+0x2fb4/0x4180 arch/x86/include/generated/asm/syscalls_32.h:296
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 7718 Comm: syz.1.753 Not tainted 6.13.0-rc1-syzkaller-00239-g9a6e8c7c3a02 #0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

