Return-Path: <linux-kernel+bounces-518191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27429A38B39
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069C73AC5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB0235BEB;
	Mon, 17 Feb 2025 18:24:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BB22F3BA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816647; cv=none; b=DM/ikZo6wXq3oZBjRX+3fI9TFKPQl/RBa5JSq0WemLOvCyRlUjgxgytLV/VJv+E8Ew23wrje78y3mcomEIrk7j9vu/XFhmlVb0nb3ezhJJQMn44xtuF61Imj9/Zfr6zEjgvvBLNDsWOGe7EZW3oeLyZ2wwIWGuu1Gua2tC5ND+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816647; c=relaxed/simple;
	bh=a4EK7Jv/fHnM109SK5o7Cw0neLTiGlVWyPKGMnq2DUs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kwo+e3liDfzPc8TwA03WJNQESUgDhuTIRnKgqgiu0m2upEWxZhqjU6QobFa3U8DRqIiyShid0LpfmKCdXXeS1IYKgdv7CUCkwg9XY6CnaMJH2lY0erHfNyXLDGt1OHiDVadfp3Yna6gaijlYf/BM4r2tdY+6O0mxYkDkZa/LGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d060cfe752so31837565ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739816645; x=1740421445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWg9q9yWvCzIzAjObOvPhFaeEHfE1epSsSJkkV5QmCM=;
        b=J5oh3/RcLHgVhLPTZ/lxw0JSHv3nACZeV8XteDeHd/UP3lhI57/DUuynXIHR+8kZRu
         zW/YHL8J8FTzxEBcc8UKqqGjhrVORfkFcMuK+8oWIugDepCDN/vfML0pT1D6IHXlqR57
         zWuWYEC1IzwKELLEW1UpDfZ3wqqAXquO+Tfdw3mmNizA61CbKt4D39vnPGh0tSjQekH1
         dyEwR6FGrzEdwnruqfOG33Tay7BG7/zdbvWfphtOzTktaAq5oL7QEklaRmLe2lVNjT2N
         Ic1F53FiHTqjmRRMUfZD6ClQMnAHrc86qUnrZHDvE+saIpC+f4lVtuPM6xbKpmLYBTxH
         LhTw==
X-Gm-Message-State: AOJu0YyLRYhe4DpamqkgwZd2mgj76LjU9OP7gLwomDQ41ckFOoOPiGNI
	Ig1LHaee0Iwzcy1U3EjesOQrlRfUFiUbiXcquqhq69UeHN5ksLDEzZE/eM9FLjlqUcgoWnh5QhM
	1RpAQETK3M3ORXL1IrbVSBpXFzDp+PRsSlrwG3lYyJ/l4fHlLHb4/KtE=
X-Google-Smtp-Source: AGHT+IH6ZTM8N34QrYI3F0v0Ev+4rjZKxRi25aTeusELPxcbVLuClMtm8INtc+z/SCJho7lSiqnHPOdhUDhWlj/9PxsIpKDfx+y1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3103:b0:3d1:863e:5536 with SMTP id
 e9e14a558f8ab-3d28090f547mr111643275ab.18.1739816645497; Mon, 17 Feb 2025
 10:24:05 -0800 (PST)
Date: Mon, 17 Feb 2025 10:24:05 -0800
In-Reply-To: <Z7N5BGu-q4N2vyCH@qasdev.system>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b37ec5.050a0220.173698.003b.GAE@google.com>
Subject: Re: [syzbot] [can?] WARNING in ucan_probe
From: syzbot <syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, qasdev00@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ucan_probe

firmware_str size: 129 bytes
union ucan_ctl_payload size: 128 bytes
ip->ctl_msg_buffer->raw size: 128 bytes
usb 1-1: ucan: probing device on interface #0
------------[ cut here ]------------
strnlen: detected buffer overflow: 129 byte read of buffer size 128
WARNING: CPU: 1 PID: 25 at lib/string_helpers.c:1033 __fortify_report+0x9d/0xb0 lib/string_helpers.c:1032
Modules linked in:
CPU: 1 UID: 0 PID: 25 Comm: kworker/1:0 Not tainted 6.14.0-rc3-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:__fortify_report+0x9d/0xb0 lib/string_helpers.c:1032
Code: 84 ed 48 8b 33 48 c7 c0 e0 ad 80 8c 48 c7 c1 00 ae 80 8c 48 0f 44 c8 48 c7 c7 60 ab 80 8c 4c 89 fa 4d 89 f0 e8 e4 d9 8b fc 90 <0f> 0b 90 90 5b 41 5e 41 5f 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90
RSP: 0018:ffffc900001f6b50 EFLAGS: 00010246
RAX: ae09b98519e5a900 RBX: ffffffff8c80aaa8 RCX: ffff88801da81e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81817e32 R09: fffffbfff1d3a614
R10: dffffc0000000000 R11: fffffbfff1d3a614 R12: dffffc0000000000
R13: 1ffff9200003ed84 R14: 0000000000000080 R15: 0000000000000081
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005630540fd131 CR3: 00000000630a8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __fortify_panic+0x9/0x10 lib/string_helpers.c:1039
 _Z7strnlenPKcU25pass_dynamic_object_size1m include/linux/fortify-string.h:235 [inline]
 _Z13sized_strscpyPcU25pass_dynamic_object_size1PKcU25pass_dynamic_object_size1m include/linux/fortify-string.h:309 [inline]
 ucan_probe+0x1991/0x19c0 drivers/net/can/usb/ucan.c:1537
 usb_probe_interface+0x641/0xbb0 drivers/usb/core/driver.c:396
 really_probe+0x2b9/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:537
 device_add+0x856/0xbf0 drivers/base/core.c:3665
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:250
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:291
 really_probe+0x2b9/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:537
 device_add+0x856/0xbf0 drivers/base/core.c:3665
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2663
 hub_port_connect drivers/usb/core/hub.c:5533 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5673 [inline]
 port_event drivers/usb/core/hub.c:5833 [inline]
 hub_event+0x2d6d/0x5150 drivers/usb/core/hub.c:5915
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         0ad2507d Linux 6.14-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152f75a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=d7d8c418e8317899e88c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e775a4580000


