Return-Path: <linux-kernel+bounces-404258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950869C418B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D431C2085D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EC1A256C;
	Mon, 11 Nov 2024 15:08:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43CD19CD1B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337712; cv=none; b=u+OiRmgxbSXTGc1GClgAg9z6FarD0zgEu03iyQC/SC0dpSHUTfbf0sLMQ8r0XofnkgYjVBS3ow1n6xBFF6Fibtcqbl/VWbh6+JNDZtDDVcLyk7tLLlWsciBhDJzmm9yJM55xzvItfJWkJx8vBcaeJIwSjJtnKVv4EfkmyFo6QUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337712; c=relaxed/simple;
	bh=FDCLdt6jTXusBq+H45UNYrhQXqtWmVoWcVPMg+KNF/c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AJN78+hX7pY0ORRfKh/PShnZTITShkA2W7W23WlBMxwwH0gJEosFrb/l98OUgFyhHKG4+9RIPesbaOGb486gPqZ6jlNbMtOzkNOlITedZjmpL5BzlG62fIy4cBnX3OBn2X6lcVar3+ymuViPFPk+N4N2J36KepRPtxHHL75rlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6a9cb7efdso46871525ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731337710; x=1731942510;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZABHj6qRef2ZQjH9g/cV4sIBVHktb/q6XswMeQxqNg=;
        b=Nluv2nbWFzZ+KhmCy+uBC2HIVUygzFdCjadoAftz36lf9HnrnvA1R3QuAYkIFRXpog
         Rloa31ZdoDlWi9raqulvLB71SJM8XFQ8dkNTQa2LJVs2wTjopzI7E+nbu57jiIIkVXY6
         sjpXoYR1sf8e66FpRGB25XfErD/hfOMoGUPDI3Kq+xR4dZSIJhTZTop7Lyb0wMjZOOTp
         0Et488ps6DSd3FLz33mks58o0dfzYnV4+mXClE/AQ5OeqWoUJAvwPxXpQ8SRQxRdR1vT
         TVp9ioup6/VPp66E8tNM0nJ4tdH9Lsj5pXuqs6X71RpK9hKc0lYkqGs09Qf8qi5WOD55
         ZJMA==
X-Forwarded-Encrypted: i=1; AJvYcCX1d+QwFwD4hvodBt9ai0CEw+RahWeJJAA2kyUiMwDfR1PZ6NCce9GGWnrAAv6KzREbwjkZ7/qggw8xXOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoZHn4LPNUKxe4KrttJODAZW9mkO4ZTkz6wKMwxOM2UIfzRw5
	nZ5vJXLDmz7+a10yG9vkKa1nZOcPOCNZgbWIQ+SwX9XEGldkLwBfL6e0zNeTM0UqaEaITlZVsUv
	AKDXZOU02qpPjoB/QbX3SR432W47V42ZXgnlddHDEm9JwXhgt0qvqzgk=
X-Google-Smtp-Source: AGHT+IHNFa+TL3YwCbai22qPDbdHnv9vPxDALx9Tn4KEQIkwvaOL/l5nc2QICiQt4GF6u5UQcHGIux9+0uHaFkflJzwGBiWkfr2p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180e:b0:3a0:9829:100b with SMTP id
 e9e14a558f8ab-3a6f1a44d6fmr138535375ab.21.1731337709857; Mon, 11 Nov 2024
 07:08:29 -0800 (PST)
Date: Mon, 11 Nov 2024 07:08:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67321ded.050a0220.a83d0.0016.GAE@google.com>
Subject: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton
From: syzbot <syzbot+3fa2af55f15bd21cada9@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    226ff2e681d0 usb: typec: ucsi: Convert connector specific ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=169619f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=358c1689354aeef3
dashboard link: https://syzkaller.appspot.com/bug?extid=3fa2af55f15bd21cada9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e48f2af8afd7/disk-226ff2e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76328e28b54c/vmlinux-226ff2e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab9f75a466a2/bzImage-226ff2e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3fa2af55f15bd21cada9@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:1352:16
shift exponent 4294967295 is too large for 32-bit type 'int'
CPU: 1 UID: 0 PID: 31701 Comm: kworker/1:9 Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2a5/0x480 lib/ubsan.c:468
 s32ton.cold+0x37/0x9c drivers/hid/hid-core.c:1352
 hid_set_field+0x1e0/0x370 drivers/hid/hid-core.c:1905
 hidinput_input_event+0x290/0x430 drivers/hid/hid-input.c:1865
 input_event_dispose drivers/input/input.c:321 [inline]
 input_handle_event+0x14e/0x14d0 drivers/input/input.c:369
 input_inject_event+0x1bb/0x370 drivers/input/input.c:428
 __led_set_brightness drivers/leds/led-core.c:52 [inline]
 led_set_brightness_nopm drivers/leds/led-core.c:323 [inline]
 led_set_brightness_nosleep drivers/leds/led-core.c:354 [inline]
 led_set_brightness+0x211/0x290 drivers/leds/led-core.c:316
 kbd_led_trigger_activate+0xcb/0x110 drivers/tty/vt/keyboard.c:1036
 led_trigger_set+0x59a/0xc60 drivers/leds/led-triggers.c:212
 led_match_default_trigger drivers/leds/led-triggers.c:269 [inline]
 led_match_default_trigger drivers/leds/led-triggers.c:263 [inline]
 led_trigger_set_default drivers/leds/led-triggers.c:287 [inline]
 led_trigger_set_default+0x1bd/0x2a0 drivers/leds/led-triggers.c:276
 led_classdev_register_ext+0x78c/0x9e0 drivers/leds/led-class.c:555
 led_classdev_register include/linux/leds.h:273 [inline]
 input_leds_connect+0x552/0x8e0 drivers/input/input-leds.c:145
 input_attach_handler.isra.0+0x181/0x260 drivers/input/input.c:1027
 input_register_device+0xa84/0x1110 drivers/input/input.c:2470
 hidinput_connect+0x1d9c/0x2ba0 drivers/hid/hid-input.c:2343
 hid_connect+0x13a8/0x18a0 drivers/hid/hid-core.c:2234
 hid_hw_start drivers/hid/hid-core.c:2349 [inline]
 hid_hw_start+0xaa/0x140 drivers/hid/hid-core.c:2340
 ms_probe+0x195/0x500 drivers/hid/hid-microsoft.c:391
 __hid_device_probe drivers/hid/hid-core.c:2699 [inline]
 hid_device_probe+0x2eb/0x490 drivers/hid/hid-core.c:2736
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 hid_add_device+0x37f/0xa70 drivers/hid/hid-core.c:2882
 usbhid_probe+0xd3b/0x1410 drivers/hid/usbhid/hid-core.c:1431
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---


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

