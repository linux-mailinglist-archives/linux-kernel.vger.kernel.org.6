Return-Path: <linux-kernel+bounces-272761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45699460AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A721C20929
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B8F136352;
	Fri,  2 Aug 2024 15:42:43 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D215C134
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613363; cv=none; b=IMXFbF4FBbpFqDkodSMyrLxEjExxvx4yRAUVHxUaFG48gxoLB4mGkjgSydZ+65ohLTb9/1zt0wrRILSHZ98ntiMAViq+zdwpq2UILDYNtozHW5jROwLnzfxweq6fEXC1HtVhJQ6W1uUHaDYUVW08FtngVaVYVOP74IOWKDS5214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613363; c=relaxed/simple;
	bh=wq9ctuiUCiXHryZBSgTI6gxp2GEyh4EnMGHu40pf4k4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rr9fVyrmQMqisNL7uzLr8M/ea52qmnRCSyRzYdsbQeFZ3SE4V9EhBgjvMr/x6t6kfQ1f0Wx8fl+15LHQ1Ao4ikmbcLTPjngw2TIFe2N5qqgBWV5uKjwR0A2TM2r6F74O73LwMSzqMGx2ql+h2NUETDNVh7y46/h2VG73viEh2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39642f5482eso39418315ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613360; x=1723218160;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVl04E7x0dvLdJdkJLudxByg96SiL7CFJgqGpyvdXSg=;
        b=GzeDQvvtd1ws7GfoAYyv9dJRSLVIp6z/ugD3RQbodsc7ZiDjv4jgd+MG+xUTpygUQ8
         oX3mqBPHzFOYN7EBAswB04qPg4w9sRdXWY+j/ya/2xYtfbhF+D9kF0ycXHqfhx4XdO6d
         m0p6yHdnxXinRBSelomVvnfgl+V/FX7uFkNZyT/mUAUCTNEZGTmbZIebkJERG1KmsNMz
         9YPiYBym5qD76UlYoDqx1SmiOVYKhMhYU0qgmSUvksZtYzaZ85v3OdqRaXE8YG0XFvfV
         83eBl1X97gDuHW1pso/bzrNgqG3qrAdYOjqNcxy4dIwxeWfdlDLA1LHPFYONVou6S4er
         PMeg==
X-Forwarded-Encrypted: i=1; AJvYcCXhL2MTenDAoXlsW5bsxhht4LOE/9HD55S1L+6RU0TgRtRYYJ26546+elkeuu+ofnmHvjZ55t4FO8Iu6vI7xZhMSUGeuPVxvPd6ERgj
X-Gm-Message-State: AOJu0YwO9MIys9eDVoZuhKZk2hmai18IqhoymX8CuBusSCgtwEPew4ir
	vyZlRFSkbCD6pnPcSsbc2KrZ13bRrCp9WykT6FgfHA6pAnHL9CnlK8BRFkf7A7Ea1faBbd3Earn
	ltO6DAz59oFeFFUfXIVdo2nVkpF9qaNSPnNrXx1RuBwNEo7MvW/DLpYI=
X-Google-Smtp-Source: AGHT+IG5Kkfb2mDN8DI1tEctsnkyOW3LQ1A//RvKO0ed21Yb7bWl81wQ9yCazJ4N/DKF+WreeAyXFIaVGMHUTrpwObRTIfNFGA+C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:39b:c00:85aa with SMTP id
 e9e14a558f8ab-39b20054434mr2692095ab.0.1722613360449; Fri, 02 Aug 2024
 08:42:40 -0700 (PDT)
Date: Fri, 02 Aug 2024 08:42:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f6622061eb52dba@google.com>
Subject: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_generic_write
From: syzbot <syzbot+8f282cce71948071c335@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94ede2a3e913 profiling: remove stale percpu flip buffer va..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12166111980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a7cf62669c9536b
dashboard link: https://syzkaller.appspot.com/bug?extid=8f282cce71948071c335
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4adcb60c426/disk-94ede2a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50bde94d1be7/vmlinux-94ede2a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0756c72c7478/bzImage-94ede2a3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f282cce71948071c335@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usbtmc_generic_write+0x7b6/0xe80 drivers/usb/class/usbtmc.c:1213
 usbtmc_write+0xdbd/0x1220 drivers/usb/class/usbtmc.c:1622
 vfs_write+0x493/0x1550 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3490/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __kmalloc_cache_noprof+0x4f0/0xb00 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 usbtmc_create_urb drivers/usb/class/usbtmc.c:757 [inline]
 usbtmc_generic_write+0x430/0xe80 drivers/usb/class/usbtmc.c:1176
 usbtmc_write+0xdbd/0x1220 drivers/usb/class/usbtmc.c:1622
 vfs_write+0x493/0x1550 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3490/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 1-3 of 4 are uninitialized
Memory access of size 4 starts at ffff88805376e000

CPU: 1 UID: 0 PID: 5623 Comm: syz.0.70 Not tainted 6.11.0-rc1-syzkaller-00043-g94ede2a3e913 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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

