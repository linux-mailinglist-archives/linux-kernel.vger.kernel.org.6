Return-Path: <linux-kernel+bounces-325827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DB8975EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D021F23884
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D73BB48;
	Thu, 12 Sep 2024 02:05:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89392BB1C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726106726; cv=none; b=F69WT0GkdtarY4qR35iWXy7urYVaqBZZhUZ5unVXarRfhuKBN7pEoPnxJZJBlC6bqIS21JmV4OcVxCALOGpU2bj7sf/8DjC2SjlLsFMf4VVRgQfWx0eqoUPjRm1PKmrxiv1aN9X07pv82DsNpmusYXjROaOP11Aolupmm51taGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726106726; c=relaxed/simple;
	bh=k1DDeLrPo9bZi3s9wB1xBQAJvMDXKriKzFRnWJPeDrU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FDCUtOfLHhX3gLHxOfZApCMEmDrSMekjW7/QbNmDn49dDflYAf09EzopNGputFwiz+sU2vpB1sSPi6owlM09uIlrIp9tzCM/sv+GPFlsTIQoOU82uJ3VL+Ww4XEj+HwscddE2N47eSvszxb4xteuMgW13r5cT+5UBiYt3Bb1lIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04c88a379so10628485ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726106724; x=1726711524;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YirzoZYB9q5g6bsdYZqQML31UlBw4n3vWu4awKz582k=;
        b=NrIApNOXjJwbnejl7sV0GruPiuR4aKmoL5NX93+aCDAqQgiq791rtna2MGvcVu8B/E
         DStZCpGors8TSdZyMbll+6mewkcBH9StfcCJrGyWJL6+bszK6ycHflVy/sdTiO5rf1e+
         XqYslkFsgzoK17bDQIMqWdY0VLJqVstpcGleMpfCq1UOwdkfBv0cv5qR70OwxjJC8Oo3
         +IDsRSJYxoY4Gv7RjplvdOjJ3sMIy6etowmNzZgar6c5d+RaMcJKyzQx4ChTUfuGwyJb
         d/8pd+grspRiL0cSZ8rn6MxiZrtmv9flu1j8dWOsnm7SWYCit2gTNQfUyCW4GLSFGdjM
         x+sg==
X-Forwarded-Encrypted: i=1; AJvYcCVrqsMlH5dvO6sz7BhUVQMGAY6AZGwBV43aX3Mh3Ncu2jDrU2nPzzW31VAh/DgVSfPdjyOVZ4LtuHxs/ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gBHwqT/klBH4pe0ZHasUOIjFmC+ST9yE7zRINig+XrnpLeOG
	HcUXmDWfv8csLNIIFby58XdklcijZ/CQKSA4X/VJuAE/oZ3N4MbMCsDLNxBSLl7B5Ccfcns7pAT
	pgN7X2eYve1HmW25PkTWinSZaiBPpYejnu1q1Z5bVma6UrRAlNb3jtug=
X-Google-Smtp-Source: AGHT+IFZ7aFQAsf1717hAdU4186B4n2uwnowmnHld6LVEudo/jNaLUaZ6zSVX31IQ3dq5sJ9lvvPDWRqsNp5QMXo6Q1ey39NuhZW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:3a0:4250:165f with SMTP id
 e9e14a558f8ab-3a0847d0c17mr12778215ab.0.1726106723927; Wed, 11 Sep 2024
 19:05:23 -0700 (PDT)
Date: Wed, 11 Sep 2024 19:05:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fdbd80621e28ae3@google.com>
Subject: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
From: syzbot <syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1f2d51b711a Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=125c743b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de85d75807a205cd
dashboard link: https://syzkaller.appspot.com/bug?extid=b8080cbc8d286a5fa23a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1633ca8b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11db6567980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df667fbbb2c1/disk-d1f2d51b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1574a134d7c4/vmlinux-d1f2d51b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a977c1daccb8/bzImage-d1f2d51b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com

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
Memory access of size 73 starts at ffff888135d8b000
Data copied to user address 0000000020000000

CPU: 0 UID: 0 PID: 5280 Comm: syz-executor107 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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

