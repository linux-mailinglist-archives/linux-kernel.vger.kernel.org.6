Return-Path: <linux-kernel+bounces-402029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB19C2264
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBB21C213D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1E1991D3;
	Fri,  8 Nov 2024 16:47:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330791990C2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084426; cv=none; b=Nyw4J/5tcmKhB6x/Cp3ZM2UbZ62XCrryPdW5F9lCl8hbnNkl6LkuAfKcgnfWY+ffmbAGcA2eahWK3LlR4Cjp0hVHj5ie/kGYQPxMl8BXVZDiEjM9CfSrv/0J0vO3ZBbVpkz70LjNIz3DaFUIw491SumyxTx4Apqif5HSSsDRtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084426; c=relaxed/simple;
	bh=yQOulee0aCOrKBvIl2JvCnKwwFYPZe2MVIJ9RxxhVNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dfk18g7cltPdbJriFhf6tvUSqicOLzHG96CXWh4ABEo/U/mGjhdK6HuRC0Hfpdo9WsXQP0KBKaK4Mr+kRtxLHapvrbu5+yVqG7Ep+tK1e2MgVkW7Zdvt4Sv363LwzfTQrpojTFFlsfv5EVbI3OsFrcfLxHgjRP8odS7pW6cB3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso28728255ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 08:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731084423; x=1731689223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzP3/oQl797g0jOPqgjI+tpb9W71FRYUnjkdZMcoJkQ=;
        b=dN5P96k8LGGXv2T2a07Ck3l2bD7RT+5QhpRl0w1Nea8NTVYiBwjtDzQmOavD96Xa/b
         YUa/FECerfBgIsqXE9jNBzAq8+YWcQxbJ7PgHoDlDNmyOBgnS0buHwaFCDBWd7wfikNo
         Qd9YruaFuKqYQS+Il3G81eEbeB3JGtJdVL4i7lHRYqGFRWBVz63Wyty6SnhcuzLhOEaZ
         QDH12+mK0QOyVZM2hK+4T7EzN8xW69yjpzp7XT2qq1cTeXkPQcnRi67VibWydw1uDC8I
         XYnHdFPse/2VEKC7S0LG3JMBr+Q3Xmqldjqwr64NVvI0Voa5tEOVG51xIm6GuAzkYQb8
         DfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwzoJUDMGu3EW05X+t2nSOPhIoJQLcCSlsSatK6ejNFSXhaPQ67EmIM/UOIWYBfIFXnT4TuQbN8pqvRLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbXRn9vXmtdR1/g8hY+3eLCTIzDGHT0INoFT5Wf2EwX1WWNe0
	DvYt1kBWbaoKhYmYb4082oIOJHnTVgioCyRbVndL6EewGoEE7RdDMc01Ctji99upBHGyeDaxB3p
	j/pOPBWIl6tOME+3yj/q518oGj4VTkTW2Y3yDQL0c2gXFnW9BcZdogVw=
X-Google-Smtp-Source: AGHT+IE65GEheNwzaOr3cmZFXY49ATkgiyer2Hjt2fxnqpj2V9+vnj3FCXhf+C25eE5kLMBNTTqjUqwvhs167xC6LAtJ4PP6aQH+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a6f1a6eca3mr44888645ab.17.1731084423314; Fri, 08 Nov 2024
 08:47:03 -0800 (PST)
Date: Fri, 08 Nov 2024 08:47:03 -0800
In-Reply-To: <20241108162911.KtNm6%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672e4087.050a0220.a6ff3.0005.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: suspicious RCU usage in ieee802154_remove_interfaces

usb 2-1: Please update to version 0.2 or newer
usb 2-1: USB disconnect, device number 2
=============================
WARNING: suspicious RCU usage
6.12.0-rc6-syzkaller-00169-g906bd684e4b1-dirty #0 Not tainted
-----------------------------
net/mac802154/iface.c:700 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by kworker/1:5/5934:
 #0: ffff888144284548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888144284548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900042f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900042f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888145704190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888145704190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888077b13190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888077b13190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x103/0x950 drivers/usb/core/hub.c:2295
 #4: ffff888022f63160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888022f63160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888022f63160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffffffff8fcc1408 (rtnl_mutex){+.+.}-{3:3}, at: ieee802154_unregister_hw+0x54/0xd0 net/mac802154/main.c:277

stack backtrace:
CPU: 1 UID: 0 PID: 5934 Comm: kworker/1:5 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6821
 ieee802154_remove_interfaces+0x2e8/0x2f0 net/mac802154/iface.c:700
 ieee802154_unregister_hw+0x5c/0xd0 net/mac802154/main.c:279
 atusb_disconnect+0x152/0x260 drivers/net/ieee802154/atusb.c:1077
 usb_unbind_interface+0x25e/0x940 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3861
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1418
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
WARNING: suspicious RCU usage
6.12.0-rc6-syzkaller-00169-g906bd684e4b1-dirty #0 Not tainted
-----------------------------
net/mac802154/iface.c:700 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by kworker/1:5/5934:
 #0: ffff888144284548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888144284548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900042f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900042f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888145704190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888145704190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888077b13190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888077b13190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x103/0x950 drivers/usb/core/hub.c:2295
 #4: ffff888022f63160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888022f63160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888022f63160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffffffff8fcc1408 (rtnl_mutex){+.+.}-{3:3}, at: ieee802154_unregister_hw+0x54/0xd0 net/mac802154/main.c:277

stack backtrace:
CPU: 1 UID: 0 PID: 5934 Comm: kworker/1:5 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6821
 ieee802154_remove_interfaces+0x272/0x2f0 net/mac802154/iface.c:700
 ieee802154_unregister_hw+0x5c/0xd0 net/mac802154/main.c:279
 atusb_disconnect+0x152/0x260 drivers/net/ieee802154/atusb.c:1077
 usb_unbind_interface+0x25e/0x940 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3861
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1418
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
usb 2-1: new high-speed USB device number 3 using dummy_hcd
usb 2-1: New USB device found, idVendor=20b7, idProduct=1540, bcdDevice=b7.5a
usb 2-1: New USB device strings: Mfr=210, Product=154, SerialNumber=3
usb 2-1: Product: syz
usb 2-1: Manufacturer: syz
usb 2-1: SerialNumber: syz
usb 2-1: config 0 descriptor??
usb 2-1: Firmware version (0.0) predates our first public release.
usb 2-1: Please update to version 0.2 or newer
usb 2-1: USB disconnect, device number 3
usb 4-1: new high-speed USB device number 5 using dummy_hcd
usb 4-1: New USB device found, idVendor=20b7, idProduct=1540, bcdDevice=b7.5a
usb 4-1: New USB device strings: Mfr=210, Product=154, SerialNumber=3
usb 4-1: Product: syz
usb 4-1: Manufacturer: syz
usb 4-1: SerialNumber: syz
usb 4-1: config 0 descriptor??
usb 4-1: Firmware version (0.0) predates our first public release.
usb 4-1: Please update to version 0.2 or newer
usb 4-1: USB disconnect, device number 5
usb 4-1: new high-speed USB device number 6 using dummy_hcd
usb 4-1: New USB device found, idVendor=20b7, idProduct=1540, bcdDevice=b7.5a
usb 4-1: New USB device strings: Mfr=210, Product=154, SerialNumber=3
usb 4-1: Product: syz
usb 4-1: Manufacturer: syz
usb 4-1: SerialNumber: syz
usb 4-1: config 0 descriptor??
usb 4-1: Firmware version (0.0) predates our first public release.
usb 4-1: Please update to version 0.2 or newer
usb 4-1: USB disconnect, device number 6
usb 5-1: new high-speed USB device number 8 using dummy_hcd
usb 5-1: New USB device found, idVendor=20b7, idProduct=1540, bcdDevice=b7.5a
usb 5-1: New USB device strings: Mfr=210, Product=154, SerialNumber=3
usb 5-1: Product: syz
usb 5-1: Manufacturer: syz
usb 5-1: SerialNumber: syz
usb 5-1: config 0 descriptor??
usb 5-1: Firmware version (0.0) predates our first public release.
usb 5-1: Please update to version 0.2 or newer
usb 5-1: USB disconnect, device number 8


Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17c42ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d5835f980000


