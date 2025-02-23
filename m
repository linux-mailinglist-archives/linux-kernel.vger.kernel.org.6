Return-Path: <linux-kernel+bounces-527776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB3A40F50
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9427A50C7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25AE207E08;
	Sun, 23 Feb 2025 14:48:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431315E97
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740322085; cv=none; b=LrG492LaCHmmejhF9e8oPgtqdFNywfDuGycMu0Vr/NcFi3SAsBvBurW0qLLsJHDfK+hT7JXKgozURFOVWH6jXtdd4EuWfHPMaHVOw3W4zGsCna4FE4duCBcZ4EBDsT4+xGmZY0n1aMwTDxjH7WN7uSc1sQAAB8nQZP+OfxiWtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740322085; c=relaxed/simple;
	bh=0MvDzZ2hDs+ZdQUYOxWd387crs0Sunm5aK2pIr0wY6U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p/ClvrEgeSIwfjEHeC5x8FxHI97BH8Iz4RClL48eq5fOyLVDrWqrH5wI79d640h7+gnPnk/9uXdLg68O5j+ySeTeMdnpJlCKsr2hNLKOajMgF695EB0522rnX47ut0s3+XCbklPYA5GqHUQqinfwr094FbGVCxaTFJH7KzV/qTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b6d933acso30628395ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 06:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740322083; x=1740926883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7I3MWQXqwBT8sMJDrlLu83401T/D7SpDclbmMEd0J0=;
        b=NiOhzykxCHs+aEOSi6Sbwna5JwHZlMGPx4TZUpHH52PpPN31tF9D8oGIbescEZ3OwM
         f2rqqFvnQ+DS7A39JbJjaQOSmdPrQVcydSJVsd7OHqKBTWf1v1yl/XbjMsgV6qfxmvB3
         3nSSwNG+JpqUHhqKXcsdvoaKCbYRlqy6YlBXeDMzn/sJcWbF3DWEGmTymuRUiFHXGEB7
         e2DHxrpNlCc2Ry7zhMUNkMRrClpVDeG/KfWLRu4/mWW7C6EOE4Aq38W8LEKMip/AQKZM
         RxQIrEXvElTTnCC84eayWuI6DS7CH/ynICEP/F17o0x7kYKcd+NQ6IST5xVTVbSEtcGh
         1QUw==
X-Forwarded-Encrypted: i=1; AJvYcCXJEWRUl1sf8Mzt/6XIcMMbJl7Vs62ad4QkT1vMrmptCQztMkL2oxwiJQYYnOpronw2nDbThxlKii8qE50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wilph6kwAiC1N2lIgsEnHx3x98tUnsm5M8w1z9mPnoVojsuD
	mqESFxI1sAvKljJ00eUrAPWe2KJuWHB0aSeUjKiVT9X0+RM6uPgcvmcKoXZ6E9cQSp/kqemdDS5
	jgAIZzG5nB3vv6joLUQ2F+k2k/4ZY80zRuQTXU/9bLEKUEAJZ7oU1zWc=
X-Google-Smtp-Source: AGHT+IG/QJk5BZgPEgQpSA1FDhC4QOEeZ6AD5Av575xPngmyv9rnfLC1dmqb8nBaG8hBm0jgDduAUCB+LslPhxFvmwCXv2ZocsKf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:3d1:9992:bf11 with SMTP id
 e9e14a558f8ab-3d2cb52e5a5mr98865355ab.21.1740322082869; Sun, 23 Feb 2025
 06:48:02 -0800 (PST)
Date: Sun, 23 Feb 2025 06:48:02 -0800
In-Reply-To: <tencent_383767B76C06D3F379C37E296A63A0045205@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb3522.050a0220.bbfd1.0029.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
From: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in release_nodes

hid-steam 0003:28DE:1102.0023: Steam Controller 'XXXXXXXXXX' disconnected
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88811b79fb00 object type: work_struct hint: steam_work_unregister_cb+0x0/0x230 drivers/hid/hid-steam.c:869
WARNING: CPU: 1 PID: 6885 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 6885 Comm: kworker/1:5 Not tainted 6.14.0-rc3-syzkaller-00037-gc749f058b437-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd 80 d2 47 87 41 56 4c 89 e6 48 c7 c7 00 c7 47 87 e8 ff e7 c0 fe 90 <0f> 0b 90 90 58 83 05 16 85 d8 07 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc9000174f208 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff813f4dd9
RDX: ffff8881086a8000 RSI: ffffffff813f4de6 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000009 R12: ffffffff8747cda0
R13: ffffffff87274220 R14: ffffffff85a7ad40 R15: ffffc9000174f318
FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6532f71ed8 CR3: 00000001171be000 CR4: 00000000003506f0
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
 usb_unbind_interface+0x1da/0x9a0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 usb_disable_device+0x368/0x7e0 drivers/usb/core/message.c:1418
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

commit:         c749f058 USB: core: Add eUSB2 descriptor and parsing i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1780d3b8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f429368eda610a89
dashboard link: https://syzkaller.appspot.com/bug?extid=0154da2d403396b2bd59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1746cdb0580000


