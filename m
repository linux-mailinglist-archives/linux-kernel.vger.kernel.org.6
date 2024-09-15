Return-Path: <linux-kernel+bounces-329988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E0979837
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD258B21CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00AC1CA681;
	Sun, 15 Sep 2024 18:41:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1211C9DFF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425665; cv=none; b=QCrx1gW6HJxHQ+Fg9Np6GL9Uml/7A0BE/dd2lcdYHHzhfVJL7tsKzr69/MCdCrQsXnwgcGbbr6ADDG48Jmgy0sw0oqnVRZO6IN3DZu0dhGr5aeGyBnJdpdhpsOCCNuruotnbvF5LW1RbUVBQNdndb4olJtLTbWS3VI7GKxgHfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425665; c=relaxed/simple;
	bh=iAirVr/PDoQbjcJ3UWzFf81sxQF57szPJR1tu8UljmA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ulArnKo4GcY8VcLEhc3aDrrfR5cQI+bcFiyCylZZK6NAthX5NUFqcjRpuF6f984WIdT2O2Bj1UBVCD4tr7u+0g13F4tuxIorDZjO8xJtLziyKgPg6wcQHKR5NI7/nRu7rb/Ld5kr1LalTzNy4oScJp+YfmGKo9nLihr+ZxDRYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0629ed658so82315135ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 11:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425663; x=1727030463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axSYlTik1BW5U6rzNQvrcq+UMpeJRDIHWIjkI85cetw=;
        b=gzkHj5AJjFzOaRF8BwQsO4T13TLmQDLyvpJa64pKJIjCUCJNP6DRMtvQakA6rzl/pI
         CCnZkmWz4DjFqz4ge8JNU535lC4jQRdchLYFh5ASptNCA+Bx/tJb2Xrq60BBZmJNvUP7
         znig91XeMq9KRvFQbV2F15Q/aMX86v9Eb3CLUs7H8Z6ue6OyOQBDKVU69uEqSuKJk4aF
         Rfcw6PvpmEH+dQeEEPwIITVft8zYWUuCAz31LiBz6wrecfpy61W/48KmStg3af0ZPwu3
         KVnKiFk4gsZo/ghfpWRBjO0FERqSxXZ7TTxC0t9tHqoCap2AF1qHE54Js2cTvrv9YvGK
         jMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlidfvWy51GgfbMwgM+m1qvtd+/L8oEY/KEtKPonkTgAYg2IQDb3k/0ykickN+Z5ejM3hhR6Y9EYEjdyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWxJ1P9xCxBerBgqdtD9VihGvKoNPOlJvldYA5rn6XjR6ZLXf
	80cw5C5O+3otH5XKRugzw5o3PMEC8L1Z3e9q92EGbEzLhvDJ4wF4JykZU/X1Go6eEaQ3mTUFYG8
	/GbNpjl5ck58SHRpAnSPp68YvYW9Te1sTyUlizMsJ5gDbiIPMZPGdNnQ=
X-Google-Smtp-Source: AGHT+IGZiuusz9APmkDNUZ/S4dbJO1p5/YEgUvKNRBfCnp+6wbvkccstA736bOpip64D46BTrL0DHrZSpdT74Wt6gBBCb03RVjMx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1a:b0:3a0:97fe:e89e with SMTP id
 e9e14a558f8ab-3a097fee929mr47819725ab.18.1726425663029; Sun, 15 Sep 2024
 11:41:03 -0700 (PDT)
Date: Sun, 15 Sep 2024 11:41:03 -0700
In-Reply-To: <20240915181301.18904-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060587d06222ccca6@google.com>
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
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Bytes 0-72 of 73 are uninitialized
Memory access of size 73 starts at ffff88811889e000
Data copied to user address 0000000020000000

CPU: 1 UID: 0 PID: 6520 Comm: syz.0.143 Not tainted 6.11.0-syzkaller-g98f7e32f20d2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


Tested on:

commit:         98f7e32f Linux 6.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117b97c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ab8d456be59dad9
dashboard link: https://syzkaller.appspot.com/bug?extid=b8080cbc8d286a5fa23a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

