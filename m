Return-Path: <linux-kernel+bounces-331222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E717497A9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC3E2899F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7DEAD5;
	Tue, 17 Sep 2024 00:15:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2BAD4B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532124; cv=none; b=tWqREbp8XsJb6cvc6muKWVkMG1F6JSfRH5koSdDlcatz3nRMgN4bLDq89QALb2yXAafWaics08RSYLgtImeHipVJQFFJLo7muCj5HBLLXrVuNgP8qEA7vUkm5D9oNtYVPF0sWYbbCTGpGoYjkQH3kd4vpRlABJdQ77XT5eFFDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532124; c=relaxed/simple;
	bh=CNBzNQdnsZHE0wH2x1rThyyF99snvKQUPqSvMlfK+kw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qoWcFA9IV2EshahZRWrDqb8gIa+OL5GsrQJdCmNJ8ECSikpV5g2JcjYVbDH5gSwcxNZ3pZ+oR8uHAQe7BBE2C/kj/tMkH5XGI1gZwP9I6l0tnZeKBPx8Ti7o/BlWbZDPrQHP0ucIAfpJd+g5/n7sUQvdL/kZ1GHiJuG1KX2juGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a047cb2e7dso93734025ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532120; x=1727136920;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCMu4c94BWLzTQllMfg/FEkXcOhMIHzrAA/CyyJbrS4=;
        b=VaYnrYqAcxEZDu6eMpjpiRn1EBTBhzH4wxE4tF3VNqpzld6MpU6zEQSfSd0bt9z9o+
         /dMNXgJT+s3DL+3PtVnTkFwolW5h1yztXTqOIXdn8aFlmD2o/OZkDON4jMVCeMYzzo5k
         4L2wC4rGwHGGPMxA3GZHuyXQ5D6doEcljr9f2u/BvtOOPJv7sRxOPeNgiS3BrXdLci6J
         EyRNOpFV2j6DCHYkvb5Q1VVka2N+NTmV/a3TYS4+2EITQzYXimQues0EEyOVhk5nlEJt
         uee8fVcdmXwIpRy5KW/whwKCzFJZL46UNNW+Ry5unfbj3RESA8Tul2hmnsJ8lxhCm0Mb
         q9ng==
X-Forwarded-Encrypted: i=1; AJvYcCWI4ULYs+j3TUExliB4KAzhkg2nljl9G0CR8HXZkpxknhlMu/aYkVOxltBSq3n6UHPrjOzWcD/tl0wZVNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0/U7MOzUrrsf/ULRGBr5yMdn98+xIyZQpJao9G7MO5jjVbw2
	Cs1uOK5vIA9jlR46KUTQsPYDbMmshiHX5eSGmJgzOsoCaGozDXFVBcDneRR1zR+PXRflQ4y2V13
	60fgo2iYn2Z2tYOY8BPJTbyDrnYDc4Q5AkMjacQm50O6RdLPsDqzpYDY=
X-Google-Smtp-Source: AGHT+IHL87yWhtDH0W3l7n9hhUwba92yHpakz/85OcxEILUygnm5Z+FoxM4+zOCwQ6dwofXBDzJp5u3vhvchANC9qpR8xIG9DH+Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1687:b0:3a0:9aff:5046 with SMTP id
 e9e14a558f8ab-3a09aff514dmr78063375ab.15.1726532120414; Mon, 16 Sep 2024
 17:15:20 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:15:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb21c50622459589@google.com>
Subject: [syzbot] [usb?] WARNING: refcount bug in get_taint (2)
From: syzbot <syzbot+72d3b151aacf9fa74455@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e936e7d4a83b Merge tag 'spi-fix-v6.11-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e5349f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a22dcefdc7043a4
dashboard link: https://syzkaller.appspot.com/bug?extid=72d3b151aacf9fa74455
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15db8900580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13db8900580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-e936e7d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac5abfd95f54/vmlinux-e936e7d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c24d34efe77b/zImage-e936e7d4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72d3b151aacf9fa74455@syzkaller.appspotmail.com

usb 1-1: USB disconnect, device number 2
------------[ cut here ]------------
WARNING: CPU: 1 PID: 46 at lib/refcount.c:28 refcount_warn_saturate+0x13c/0x174 lib/refcount.c:28
refcount_t: underflow; use-after-free.
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 UID: 0 PID: 46 Comm: kworker/1:1 Not tainted 6.11.0-rc7-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: usb_hub_wq hub_event
Call trace: 
[<8195d3d8>] (dump_backtrace) from [<8195d4d4>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:826228c4 r5:00000000 r4:8200cac0
[<8195d4bc>] (show_stack) from [<8197b1f4>] (__dump_stack lib/dump_stack.c:93 [inline])
[<8195d4bc>] (show_stack) from [<8197b1f4>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:119)
[<8197b1a0>] (dump_stack_lvl) from [<8197b234>] (dump_stack+0x18/0x1c lib/dump_stack.c:128)
 r5:00000000 r4:8286dd18
[<8197b21c>] (dump_stack) from [<8195df7c>] (panic+0x120/0x368 kernel/panic.c:354)
[<8195de5c>] (panic) from [<802421e4>] (check_panic_on_warn kernel/panic.c:243 [inline])
[<8195de5c>] (panic) from [<802421e4>] (get_taint+0x0/0x1c kernel/panic.c:238)
 r3:8260c5c4 r2:00000001 r1:81ff52e4 r0:81ffd0bc
 r7:80813f4c
[<80242170>] (check_panic_on_warn) from [<80242338>] (__warn+0x7c/0x180 kernel/panic.c:741)
[<802422bc>] (__warn) from [<80242624>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:774)
 r8:00000009 r7:8205adc0 r6:df91dc04 r5:8348a400 r4:00000000
[<80242440>] (warn_slowpath_fmt) from [<80813f4c>] (refcount_warn_saturate+0x13c/0x174 lib/refcount.c:28)
 r10:827c8bd8 r9:848e4080 r8:00000044 r7:848e4430 r6:83ed47b4 r5:848e4400
 r4:83ed4000
[<80813e10>] (refcount_warn_saturate) from [<819372e0>] (__refcount_sub_and_test include/linux/refcount.h:275 [inline])
[<80813e10>] (refcount_warn_saturate) from [<819372e0>] (__refcount_dec_and_test include/linux/refcount.h:307 [inline])
[<80813e10>] (refcount_warn_saturate) from [<819372e0>] (refcount_dec_and_test include/linux/refcount.h:325 [inline])
[<80813e10>] (refcount_warn_saturate) from [<819372e0>] (kref_put include/linux/kref.h:64 [inline])
[<80813e10>] (refcount_warn_saturate) from [<819372e0>] (kobject_put+0x158/0x1f4 lib/kobject.c:737)
[<81937188>] (kobject_put) from [<80a74a04>] (put_device+0x18/0x1c drivers/base/core.c:3790)
 r7:848e4430 r6:83ed47b4 r5:848e4400 r4:83ed4000
[<80a749ec>] (put_device) from [<81344bf8>] (hdm_disconnect+0x98/0x9c drivers/most/most_usb.c:1130)
[<81344b60>] (hdm_disconnect) from [<80dbe638>] (usb_unbind_interface+0x84/0x2c4 drivers/usb/core/driver.c:461)
 r7:848e4430 r6:827c8bd8 r5:00000000 r4:848e4400
[<80dbe5b4>] (usb_unbind_interface) from [<80a7c8dc>] (device_remove drivers/base/dd.c:568 [inline])
[<80dbe5b4>] (usb_unbind_interface) from [<80a7c8dc>] (device_remove+0x64/0x6c drivers/base/dd.c:560)
 r10:00000000 r9:848e4080 r8:00000044 r7:848e4474 r6:827c8bd8 r5:00000000
 r4:848e4430
[<80a7c878>] (device_remove) from [<80a7ddf4>] (__device_release_driver drivers/base/dd.c:1272 [inline])
[<80a7c878>] (device_remove) from [<80a7ddf4>] (device_release_driver_internal+0x18c/0x200 drivers/base/dd.c:1295)
 r5:00000000 r4:848e4430
[<80a7dc68>] (device_release_driver_internal) from [<80a7de80>] (device_release_driver+0x18/0x1c drivers/base/dd.c:1318)
 r9:848e4080 r8:82fbc140 r7:82fbc138 r6:82fbc10c r5:848e4430 r4:82fbc130
[<80a7de68>] (device_release_driver) from [<80a7bf60>] (bus_remove_device+0xcc/0x120 drivers/base/bus.c:574)
[<80a7be94>] (bus_remove_device) from [<80a76070>] (device_del+0x148/0x38c drivers/base/core.c:3871)
 r9:848e4080 r8:8348a400 r7:04208060 r6:00000000 r5:848e4430 r4:848e4474
[<80a75f28>] (device_del) from [<80dbc054>] (usb_disable_device+0xdc/0x1f0 drivers/usb/core/message.c:1418)
 r10:00000000 r9:00000000 r8:848e4400 r7:848e4000 r6:84aae288 r5:00000001
 r4:00000038
[<80dbbf78>] (usb_disable_device) from [<80db0eb8>] (usb_disconnect+0xec/0x29c drivers/usb/core/hub.c:2304)
 r10:00000001 r9:83ff9600 r8:848e40c4 r7:83e03c00 r6:848e4080 r5:848e4000
 r4:60000013
[<80db0dcc>] (usb_disconnect) from [<80db3b68>] (hub_port_connect drivers/usb/core/hub.c:5361 [inline])
[<80db0dcc>] (usb_disconnect) from [<80db3b68>] (hub_port_connect_change drivers/usb/core/hub.c:5661 [inline])
[<80db0dcc>] (usb_disconnect) from [<80db3b68>] (port_event drivers/usb/core/hub.c:5821 [inline])
[<80db0dcc>] (usb_disconnect) from [<80db3b68>] (hub_event+0xe78/0x194c drivers/usb/core/hub.c:5903)
 r10:00000001 r9:00000100 r8:839cc900 r7:848e4000 r6:83e03400 r5:83e03e10
 r4:00000001
[<80db2cf0>] (hub_event) from [<80265f04>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3231)
 r10:82ea8c05 r9:8348a400 r8:01800000 r7:ddde4000 r6:82ea8c00 r5:839cc900
 r4:82fbdb80
[<80265d50>] (process_one_work) from [<80266ae8>] (process_scheduled_works kernel/workqueue.c:3312 [inline])
[<80265d50>] (process_one_work) from [<80266ae8>] (worker_thread+0x1ec/0x3bc kernel/workqueue.c:3393)
 r10:8348a400 r9:82fbdbac r8:61c88647 r7:ddde4020 r6:82604d40 r5:ddde4000
 r4:82fbdb80
[<802668fc>] (worker_thread) from [<8026fb04>] (kthread+0x104/0x134 kernel/kthread.c:389)
 r10:00000000 r9:df87de78 r8:82fbfbc0 r7:82fbdb80 r6:802668fc r5:8348a400
 r4:82fbf940
[<8026fa00>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf91dfb0 to 0xdf91dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026fa00 r4:82fbf940
Rebooting in 86400 seconds..


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

