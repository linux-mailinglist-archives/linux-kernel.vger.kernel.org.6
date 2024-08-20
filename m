Return-Path: <linux-kernel+bounces-294642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7935D9590A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA7FB22CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678C1C823E;
	Tue, 20 Aug 2024 22:48:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5714AD38
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194103; cv=none; b=VHQxmB201WqmjlAz30lc9cVR7VnVN1cZLktrbaTteTHUE9U1sLeVoE+ybQH0gCvHrKv/ath77r4xK9pfUpqYVPLzmPBedW2LevaWEbImGL+/hA/LlPG3NsPrFHskfa/pdlKD6sRkZ5b4Dwbigjx28SC0eZL5tkgDclTDYa0ziH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194103; c=relaxed/simple;
	bh=Z1ZLX6pB8u/g13wa02XzXwdxhp00W1aD+A6dnbBAhhQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q8BcAxdihZSfqBDXK/7cC+gXamIPjQugON1gQ+rbdO43T1h7+r6Id9wjYYGKIsWLIRqPgTqQAauBVuGmmOedvdcp3i0FeJtU1mPZw4L4rbLjpwGmBcaE/+J914lNPim9SUD+vx5W0JoacFO9bniioEjwM4mI9ojjp8lF3I4tYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d470803edso38699495ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194101; x=1724798901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8i5pbFC1HTQvk9l4CVq3dasaO2XdrmmClWyw2y/shw=;
        b=SmqbvV5hhOeFJNzH1IhVy6XfICohD9bAGHQ6c2tyhcM1jH+ef7gGQKXePwLHeBO55H
         M+660zhWKTMJDdxDpqJwNpnTVWuHT0EfttQSE0N2KbSC9OB6xsdQNyekY6z2CdxVS5v1
         jaNth2SUTKW7XjHCchuRseST3FRpnNbjini7/XxR6ymsc4dAlSsuCTMCCrncCkdWHXdD
         DlEKlRxP7XAPzg3sUykIKX+5POuMw6mpNwbzPjcYuVmjFldJgM0ZD+1/oj9xSb2we0Sl
         4Xqfu117le43bXw67KqHk7+ocxfDJhtxGpiBar6kf+kIdJ16prALSHBks2M5wCGm1zYa
         CdJA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2ff7mL0GyRNqOobRTjeU6WFhKw535dvbp/Kc3t1Pti+egY0lOSdR370QW/u4vVHRCqLFiD3LMjmoQQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxenmPD7mkvjgHaytMZljzPTqYIIUTUz8aBMmEgt6CAG2TIvd6j
	tooV4CcxkSYRILoN9rvsWaDplbX14QOqFR2T1m/M0vYDltef+9MAFJGIpyEu7AfXIc7jjZiHTAi
	2tI3hc1BZBjT+QtdaNpJbNFrz+/5A0gaSLgXeMv2GkGHI40A8zQLmd9o=
X-Google-Smtp-Source: AGHT+IGH36UFHhJwWbTdO5OattbGC6xCeTwvPH86/I/mNXJYNZ1Uu4jvjBMZxj7XWHKRfnfiAXrsIAvVBR+up8E/TxguUBUJusLl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26f:0:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39d6c2bd24emr400305ab.0.1724194100897; Tue, 20 Aug 2024
 15:48:20 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e875fa0620253803@google.com>
Subject: [syzbot] [usb?] KMSAN: kernel-infoleak in wdm_read
From: syzbot <syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7a5aa4b3c00 Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10dadbf3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=836be0e882e376f7
dashboard link: https://syzkaller.appspot.com/bug?extid=9760fbbd535cee131f81
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/946f8425a0a3/disk-d7a5aa4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ee98ed4e4f2/vmlinux-d7a5aa4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/944481feb386/bzImage-d7a5aa4b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:180 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:180 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 wdm_read+0x227/0x1270 drivers/usb/class/cdc-wdm.c:603
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
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 wdm_create+0xf5a/0x2240 drivers/usb/class/cdc-wdm.c:1066
 wdm_probe+0x265/0x330 drivers/usb/class/cdc-wdm.c:1165
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
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Byte 0 of 1 is uninitialized
Memory access of size 1 starts at ffff88803f011400
Data copied to user address 0000000020000280

CPU: 1 UID: 0 PID: 7440 Comm: syz.1.721 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
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

