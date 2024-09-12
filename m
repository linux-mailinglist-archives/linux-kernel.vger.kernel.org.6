Return-Path: <linux-kernel+bounces-326840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD58976D97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6182E1C23DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B11B12E4;
	Thu, 12 Sep 2024 15:19:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6B848E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154345; cv=none; b=S5fz2DUSffIP/JAjb6fgdNK5oG2FXLI8D+PWSaa7ITkKk+hmRMtpdlDUqgoIoLe2WND24sbh05DJu8FDe6fOIkMAPhLY/zr/73XsFqJiu3hz+rMae4NkWZy94yr0p61PuFsXQhSZ0htwOU/etoypDAHpBzX/4b9g0v5/3RpAJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154345; c=relaxed/simple;
	bh=STV8om1P7iMadYlrC1Ov5g6TtswUDp7aufrENClQUw0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cwjFAQWUVoK77PLpM9EFevlvFrK41FNVAoIcWTN7DQNr18i/kgbBgceREceajLnGdveLLqGAtpKXpfrKEFl1byunhK81lDtoeCYbEc22sG2uxzXXNAMa3o8kFhk49TV3uEPaQS8fzK/OpGx+8jfnl4JfW0Eonntu36zm7/JMlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d49576404so11812885ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154342; x=1726759142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mYGFi5Rv2ZCy/t4Eijr16i9h0twm2O5R16/L7rUMjs=;
        b=aYqS/wgpqekKCxVjAS5Ybssp2r2tWqnWTXXnSv8YXZ7+3DFKDLX4015617y/C4qdKX
         +c5UWN5D9LkVb2d41gLuGehO1gHKCKwinDwTjgmEjTaudPXmSGs1Dxe7elnHJ6KynhKe
         VtDHEEIcsOgTkwYkzqAjp+WlEeuMBA2Mbe5peHv1SPC64xVye4xBLAHqG3IPvTae5AKy
         0nR4EesI7mlyO7ZK8wm0MvHx0htPN6r3UmrZxFiy34D9pSIuXh75usRVz/JGQhv5VOGZ
         wUYkj05jZ6MCDeX89TzjHPV6cT4lPeaXh1gT1/2JNJyMn6dpCEl7DDP+ENI0u+6OOzZF
         KbVg==
X-Forwarded-Encrypted: i=1; AJvYcCVLPloSHKqSGepQ5/g1UQ2uTObh4KK3xail497YUde1hLlgw5zbg98bzUVdMUD3jVX/1ILRrF9K1T/baoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiaqE6CiY3TiEv516S4jKKQmPeRx4FWi/8flBTLoh5fw6m1fUh
	BLZt4vVnExg40b0JWZ73e1bkVPjLI6LTttzVp5ku5k0ts0JmhawHfva0bl36x/ogrWMoMuT7Ixk
	hSyJ761o5axTw2ypIgmKSFHEhiOrVNmCeS5v55rUAhsWcMaJm675aluc=
X-Google-Smtp-Source: AGHT+IFt8aUqyC+nBbSueG12rEXJ2jmU3hElZUDMXnoWgq7lVYMH3qmZ64vb3Dj64xbadclXvHxKIEwSs77S8fmOKG4+oEaHYNhu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:3a0:72d5:185a with SMTP id
 e9e14a558f8ab-3a0849552d0mr36954395ab.16.1726154342457; Thu, 12 Sep 2024
 08:19:02 -0700 (PDT)
Date: Thu, 12 Sep 2024 08:19:02 -0700
In-Reply-To: <20240912141621.7782-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068f3710621eda08c@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
From: syzbot <syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: kernel-infoleak in iowarrior_read

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:180 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:180 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 iowarrior_read+0xb02/0xdc0 drivers/usb/misc/iowarrior.c:326
 vfs_read+0x2a1/0xf60 fs/read_write.c:474
 ksys_read+0x20f/0x4c0 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x93/0xe0 fs/read_write.c:627
 x64_sys_call+0x3055/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3998 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4174
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kmalloc_array_noprof include/linux/slab.h:726 [inline]
 iowarrior_probe+0x10ea/0x1b90 drivers/usb/misc/iowarrior.c:836
 usb_probe_interface+0xd6f/0x1350 drivers/usb/core/driver.c:399
 really_probe+0x4db/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:799
 driver_probe_device+0x72/0x890 drivers/base/dd.c:829
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:957
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1029
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3682
 usb_set_configuration+0x31c9/0x38d0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:254
 usb_probe_device+0x3a7/0x690 drivers/usb/core/driver.c:294
 really_probe+0x4db/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:799
 driver_probe_device+0x72/0x890 drivers/base/dd.c:829
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:957
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1029
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3682
 usb_new_device+0x15f4/0x2470 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x4ffb/0x72d0 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Bytes 0-72 of 73 are uninitialized
Memory access of size 73 starts at ffff88811bbc6000
Data copied to user address 0000000020000000

CPU: 0 UID: 0 PID: 5938 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-g77f587896757 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


Tested on:

commit:         77f58789 Merge tag 'arm-fixes-6.11-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c860a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea008021530b2de3
dashboard link: https://syzkaller.appspot.com/bug?extid=b8080cbc8d286a5fa23a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

