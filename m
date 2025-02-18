Return-Path: <linux-kernel+bounces-518977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44DA396CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10133ADCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAF22DF83;
	Tue, 18 Feb 2025 09:11:22 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FE7E1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869882; cv=none; b=EmtZZiZixr3POur3r/UoUiasxnt/rq4duap63I23gXCbDvMWfP8FzRs0MyRXyFcD6MUbDzth56ioEd43uKvbDaP94grihyefj1ypKeVsE3PpNv9orDJCpO1X+/67yYcxjkqjWPIT9P8/cMY8iYMXH7kvYufzo1faiU3Bf43ZEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869882; c=relaxed/simple;
	bh=l7knZN4W/sdx8EjNigShL7jvGxNk401Q/KFmvQdIhIE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hgDOCVAVQvqaekJjeKe3OmpbdQFCrK6q1CDkX64I5CQ0dD1vpHnM+DW7uvcWHtiwVOoPhufsY9Bxa8Ul4QrtSEl10qWcKF6G9pps7iFgYCz+aomO//R5NBwWLZTTif3t6xw3sXfy7+6lHPxRXoNOun3caU9EmQwlv96Thee0oeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2b1e1e89fso230005ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869879; x=1740474679;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrddDZpG5+l1dfekVwD4fLhNCFPqqVG4cen7iWuaUtM=;
        b=us93gxXh0brZ8adjMRp+3QXbrJeWhaLb/KgdslisZ6xmuQopD0dmAG47xMkIV4bDWV
         HLIoZBhn+OxpUkWb9CmwtybaJ9tA1x53dqkgKgmq4z7hWjKgs15j1vGIrqMm4GydFrl9
         vZBrFU3Dh+wY9mrunlX8dCF5pxn0FvRjXTWJEGWSxDtx/L5Ic5ds+FYdeupf3yC4DkR6
         LoISPSvOYrkzsqzsrIr2dQiYjLphwb4Wy+XCp3WJ2S461Sa4kCozB4r5LGzr0p7gMJeh
         lFj4KAT8mleUQgS6ZeOkxocpvF0ZgDs4aSZNdTD5dLO7dfHdXmdAQPmn+tBsyJILYE9b
         PgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLpAfl7d3ZpkexOiveXRKCGodQXOng/Yiv4TSOlwzZt9c9GkVv4Sj8Xehfa9NLyHQnxzsRU1GtSIbLZeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXd31F9fMo5e/ei7ScF7mgo1GxswnEyZjKEQvxmDh4kjvX74r
	ony/CNGQ3HF+LYULCefAF0EnhSYuT6v6+TfXOdpBJLHKdJChGlG9mfX36VEqT/HlpEDAYyoDpMB
	XPm499hjhR6z6d3wntnak7SEvoc+mfiTh79CdfTR/blDZmKc5Ho9x39A=
X-Google-Smtp-Source: AGHT+IGpSzJQNaZAX0/UkZ0ss9s8jdMrds/GrIl+FwLWx8laWT5fJqlH1oaphUhy1L5ArI3aBqPnW0i2RCiDvYtaQeZpFjZyYlho
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:3d1:9992:bf11 with SMTP id
 e9e14a558f8ab-3d28091f90dmr129002755ab.21.1739869879493; Tue, 18 Feb 2025
 01:11:19 -0800 (PST)
Date: Tue, 18 Feb 2025 01:11:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b44eb7.050a0220.173698.004a.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in try_to_migrate_one / zap_page_range_single
From: syzbot <syzbot+419c4b42acc36c420ad3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2408a807bfc3 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17481898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce4e433ac2a58cc2
dashboard link: https://syzkaller.appspot.com/bug?extid=419c4b42acc36c420ad3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2b5bc36288cc/disk-2408a807.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75982289b311/vmlinux-2408a807.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c94f6df111e0/bzImage-2408a807.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+419c4b42acc36c420ad3@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in try_to_migrate_one / zap_page_range_single

write to 0xffff88810005d8f8 of 8 bytes by task 8962 on cpu 1:
 update_hiwater_rss include/linux/mm.h:2669 [inline]
 zap_page_range_single+0x1a0/0x2f0 mm/memory.c:2012
 unmap_mapping_range_vma mm/memory.c:3834 [inline]
 unmap_mapping_range_tree mm/memory.c:3851 [inline]
 unmap_mapping_pages mm/memory.c:3917 [inline]
 unmap_mapping_range+0x15c/0x1a0 mm/memory.c:3954
 shmem_fallocate+0x278/0x860 mm/shmem.c:3672
 vfs_fallocate+0x368/0x3b0 fs/open.c:338
 madvise_remove mm/madvise.c:1025 [inline]
 madvise_vma_behavior mm/madvise.c:1260 [inline]
 madvise_walk_vmas mm/madvise.c:1502 [inline]
 do_madvise+0x14da/0x2ad0 mm/madvise.c:1689
 __do_sys_madvise mm/madvise.c:1705 [inline]
 __se_sys_madvise mm/madvise.c:1703 [inline]
 __x64_sys_madvise+0x61/0x70 mm/madvise.c:1703
 x64_sys_call+0x23ab/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:29
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810005d8f8 of 8 bytes by task 8928 on cpu 0:
 update_hiwater_rss include/linux/mm.h:2668 [inline]
 try_to_migrate_one+0x775/0x12e0 mm/rmap.c:2183
 rmap_walk_file+0x272/0x3c0 mm/rmap.c:2708
 try_to_migrate+0x108/0x150
 migrate_folio_unmap mm/migrate.c:1320 [inline]
 migrate_pages_batch+0x786/0x1930 mm/migrate.c:1866
 migrate_pages_sync mm/migrate.c:1989 [inline]
 migrate_pages+0xf02/0x1840 mm/migrate.c:2098
 do_mbind mm/mempolicy.c:1394 [inline]
 kernel_mbind mm/mempolicy.c:1537 [inline]
 __do_sys_mbind mm/mempolicy.c:1611 [inline]
 __se_sys_mbind+0xfd1/0x11c0 mm/mempolicy.c:1607
 __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1607
 x64_sys_call+0x2662/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:238
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000000021af -> 0x00000000000021b9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 8928 Comm: syz.4.2451 Not tainted 6.14.0-rc3-syzkaller-00012-g2408a807bfc3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
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

