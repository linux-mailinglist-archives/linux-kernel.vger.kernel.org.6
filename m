Return-Path: <linux-kernel+bounces-261972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BBB93BED2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9151F21B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC24197A68;
	Thu, 25 Jul 2024 09:14:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F7196C9B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898868; cv=none; b=h9fwF9n2b2NgEB+hxYgUyXdz00wFV5AzAXoJ2Jbql4BBI6bojbGabudKzZena/NIVaAg/5f8hmu1U9Eb+ca7bqcC+k/J5SaYB1z1en7FteG/nTBppdEIfKBCtuUIqPTRbnm1t4cB8hr594hJB+rSgnAjk/bD8zg45VNZ3btwHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898868; c=relaxed/simple;
	bh=OJck6c735mAUAKmhsoKSxXh8hUvnqcYBv6b7HoMyNH0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K+dwOitLL68LkE/n58lMprmGJWW0/AtXbgP6CMb0iUOAnJ3ZZR/fsdM0LnkfO8hUpamsXrWmoZJrryrM5FQW3bM3BDTfp1/2vraDs9F7RasKW+2I+GyuPbT8FrjyX+z9USZgEka4X+vD3zEBNsizMmnyAMBF/rGbXkyWL82rrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37642e69d7eso4441635ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898866; x=1722503666;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hs0c5tk+ACqugd2rfgHc3+ND3c0qZdYN2auNxG+ekcs=;
        b=SFyJfM1PoFrB8at40DTVg/isiuQagB1cYSf6qHHSEEhyrAN00pguBfPawN9Snr9fHo
         1CgsD1efG9kRegrNLcXrFXowqT/94OOhv7BWltwp76RIypU3i79gG2FAmDRYq43n63WD
         GtWDsdnyaChDr6xMcjhYvVju2Y18IBy/zrH3Q8z80mHuUkwCh2O2ClF7JwDO84WuWXUc
         8gbginp6ygjxY6aaG2PeRTsHf0e5lUOilli5+QPY5JfVXogKTskIbm1PaeIutfYP/0gR
         hNg1aTFm5CCt1gp9HDKcq4nOxu2KBEiagFl9vmx0116MU3CR8L5r3Ixg4NwUrkK3Qj5y
         WQAw==
X-Forwarded-Encrypted: i=1; AJvYcCUPaAQgk2vW/p5Qts8aG05OPJYposF+ipSff5WPk1Np+vD45s+kmOvrrMJ+3IRqnKSysRD6uzxGnUWPyBnMgefFCesLaP4Uyks5EpH+
X-Gm-Message-State: AOJu0Yy5XJ8fNJCqXhH2GOmI4rGvBZa/J0kIqBEIpvij58jasoB9ki+m
	Gaq7xYaj1Uhsd+afCOa+Kkfi2JqYDsVsE5l5M3Nkm4Rg/rEn8grSYDOImkdaxwfU4WRIuH0w8+x
	mLG2ect4U51THi79mdYzLGvmKnLDyAYnStEyh/OgF5J1H67pG2okIiP4=
X-Google-Smtp-Source: AGHT+IH2EmX952hG3iXpBvYE+BqQO50J7fjr+L51itj2Vxtf1bc0thuJ1r76yfEE2WqPbFi/jRGIqQilSJUPg7yrMoXkFqnM+WNa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:398:3831:4337 with SMTP id
 e9e14a558f8ab-39a21870618mr940475ab.5.1721898866072; Thu, 25 Jul 2024
 02:14:26 -0700 (PDT)
Date: Thu, 25 Jul 2024 02:14:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000407108061e0ed264@google.com>
Subject: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28bbe4ea686a Merge tag 'i2c-for-6.11-rc1-second-batch' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1519f2b1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fcd331f2f7452dee
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5547f17fee20/disk-28bbe4ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d509f262f4fb/vmlinux-28bbe4ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1b4cf478d209/bzImage-28bbe4ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usbtmc_write+0xc32/0x1220 drivers/usb/class/usbtmc.c:1606
 vfs_write+0x493/0x1550 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __ia32_sys_write+0x91/0xe0 fs/read_write.c:652
 ia32_sys_call+0x2e34/0x40d0 arch/x86/include/generated/asm/syscalls_32.h:5
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __kmalloc_cache_noprof+0x4f0/0xb00 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 usbtmc_create_urb drivers/usb/class/usbtmc.c:757 [inline]
 usbtmc_write+0x3d3/0x1220 drivers/usb/class/usbtmc.c:1547
 vfs_write+0x493/0x1550 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __ia32_sys_write+0x91/0xe0 fs/read_write.c:652
 ia32_sys_call+0x2e34/0x40d0 arch/x86/include/generated/asm/syscalls_32.h:5
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Byte 3587 of 3588 is uninitialized
Memory access of size 3588 starts at ffff88804d338000

CPU: 0 UID: 0 PID: 5392 Comm: syz.1.48 Not tainted 6.10.0-syzkaller-12084-g28bbe4ea686a #0
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

