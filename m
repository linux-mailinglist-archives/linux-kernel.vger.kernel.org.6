Return-Path: <linux-kernel+bounces-527543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE56A40C7C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794F11886A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAFB674;
	Sun, 23 Feb 2025 01:24:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B980B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740273846; cv=none; b=a2AilnJUgT0OZulYhXguD0jM9c7WLc4MiL7srjI3HBwehKCypuzGZCg46lYmcxXKWX/nsRTLXeduaFAHYEVQ6H4/UIGV0eaIUncfeHl7ZgtN57WTjeqQU5KkDD01P8nxZ8Oq1KBSmMB/GzT3wSeC6EEEGuAW6AMtDlejzNYMsxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740273846; c=relaxed/simple;
	bh=bwN4CfvrjsEhFIGXHEdQqWflWGNZqQORjdnkguCjYGs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L7MLaWwF5FGwPkzo5zOkT0FUg+/0x1ZN/8WxoJv+Bu1HITj4SfVUMoOOu2B7qObmGvwjRivSS0WGvBQSPe2eiX270gWXEBgKZs1o++GKPi4NU2EDpJPQ5pWkhhK8rH43nYp7UgHHpDHQoARhCvrfXIw8tNvvsGfKapl7xeSBH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-855a5457169so638798239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740273843; x=1740878643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhoqh6p2D/HpDTlnd+AWsV5r2ghuXuNOOaK67cnPH+M=;
        b=NVIh8S6RzRdoiJOD0B2AFXLqPN1gp2aWX/L6+w1sjrnSlpPjkUCECknkyOpPw7CdbN
         DjNmHiCrORvGYf2S3sJ3KW7KlUArJQuGBBvf2YdGz2ApJ3DW3XhtvdFm7wS2noYZ7VUA
         WuYslQ+Cf+TiNWY+n+m4T9nUzB/A8IV4/tTNa58iCVkz6EW+3xa0P1XyOJnw1zkO9orY
         m1d+7btCWkERBL7dYqVZbzyAA/bd5zQZpfQSjTDZ/+yabSPrkFMt1ME2PsF3Ljc4Cw/Y
         /1VsqN3gKg32pb3Q67VlHjNorlQZvwbM2/hz26bVXz+3ivIAY/5+3VggANVP3ynUjoTt
         Hb6w==
X-Forwarded-Encrypted: i=1; AJvYcCXrBRWfDzucIBkR6jsHP/S/6oBftY9lvuKPkWixVsC2ezbuwZboSBCsCJGmtbfOGREI9O0k8aJXoVmKeBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNw4H5bpTqQimBXC6RNW5qLYUpECF8+IvzLKJC2aUweCyQe1s
	5MTIVJiFH4tJZ2qa4dSxo1zgepFrGHJ6EsS0qRVyV8zg78GBawyKFO8uu2c/EFcPmpuLdvaxeqA
	qFIq9gXLGmacHG7ROFv2O2h1HyplnPn6FYYtrByYbBTDZ/L1CZwTN6Ak=
X-Google-Smtp-Source: AGHT+IGBuVROsOaD2ibtnRLj0C2TuJm41ZvPjTTMK+B85j7rx4mUa8qgpe83Rbmn5Kes2hvlbO0XJxxiicY83QAlSgC6RCMz9zYR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:3d2:aa73:7b76 with SMTP id
 e9e14a558f8ab-3d2cb457b93mr70705195ab.9.1740273843647; Sat, 22 Feb 2025
 17:24:03 -0800 (PST)
Date: Sat, 22 Feb 2025 17:24:03 -0800
In-Reply-To: <20250223002744.2585-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ba78b3.050a0220.bbfd1.0008.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
From: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in release_nodes

hid-steam 0003:28DE:1102.012F: Steam Controller 'XXXXXXXXXX' disconnected
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88811f475b00 object type: work_struct hint: steam_work_unregister_cb+0x0/0x180 drivers/hid/hid-steam.c:868
WARNING: CPU: 1 PID: 24 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted 6.14.0-rc3-syzkaller-00293-g5cf80612d3f7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd c0 d4 47 87 41 56 4c 89 e6 48 c7 c7 40 c9 47 87 e8 df e1 c0 fe 90 <0f> 0b 90 90 58 83 05 f6 7f d8 07 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc9000019f208 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff813f4dd9
RDX: ffff888101e90000 RSI: ffffffff813f4de6 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8747cfe0
R13: ffffffff87274240 R14: ffffffff85a7aab0 R15: ffffc9000019f318
FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c007c44020 CR3: 0000000108ff0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x4b7/0x600 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2284 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x2e1/0x480 mm/slub.c:4757
 release_nodes+0x11e/0x240 drivers/base/devres.c:506
 devres_release_group+0x1be/0x2a0 drivers/base/devres.c:689
 hid_device_remove+0x107/0x260 drivers/hid/hid-core.c:2774
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 hid_remove_device drivers/hid/hid-core.c:2953 [inline]
 hid_destroy_device+0x19c/0x240 drivers/hid/hid-core.c:2975
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e2/0x960 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2316
 hub_port_connect drivers/usb/core/hub.c:5373 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5673 [inline]
 port_event drivers/usb/core/hub.c:5833 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5915
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         5cf80612 Merge tag 'x86-urgent-2025-02-22' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13a7b498580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28127f006c1c31ee
dashboard link: https://syzkaller.appspot.com/bug?extid=0154da2d403396b2bd59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16745fdf980000


