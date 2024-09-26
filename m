Return-Path: <linux-kernel+bounces-341019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C0987A55
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E96F1C22605
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD428184530;
	Thu, 26 Sep 2024 21:05:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4B28371
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727384733; cv=none; b=abYiDJrzX+QQJnKkFF7DlW9YjlMDKBEADi7fm14Zqgd9wkDaM7EgZxC9jvP469TseSNoN7Gyqqj+rPGpINcBAx5sUqAj+bMTZFsEF+YE50EpKE1MgWSkElxj09zKBYR/ilfhQ5jnSftwVAAXXj+6yxGFzo49lvauaLTuLSoMcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727384733; c=relaxed/simple;
	bh=XA6FmM8VynUQG3FKsFO+R62dgS4F62xrqyj4ENVK6i4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CBN1srdb4WUiW8jcddfHfbDQJv0rwl60W1EJY8Ja4XwUbQ/AKvzdNe36eoyplhfylk6wzzi+jK81Qlhkj39fepRRRD1tXO8XzHbN5h7OrABRLhzUsjd7PmPG03sasN7Xw1VZeyk9bfO85LYWaAx2dKNfKLns5DoEmuZ0I0y9Ieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cf147a566so132491539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727384730; x=1727989530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ys6ZbznNF95xTdG+X2OkrYhpB+iMBdnUaUn5+59grIE=;
        b=efJsXnH8XlbhxNPcdMMYgGOiCTKo02bFhe9yIvAWUaSkMfg2WIz4f40CmslUcYO4MT
         2shsGJnRFdCoEoW5SIorUd3q+X56sWKw3EbitVZ1emJWkwOWtgGFhH26/fLZOuJufOwZ
         lrme7/KSM/uMh5Nybe1kZaUV+sMVTwCz35UosP+EzzoDCefJXhmkrJPEs6S8+ffJOiNj
         fGfGsWUXCPNeG1KvpFr26chFHjh7LE6DN+QDFZBA1AeAciVzVuww+n+wyat03pLKJfdF
         w3pAq6LUg4e8+ahqzktBKExMs1vNbTnwI+l265c6MER/SFxW6H8lD6VEORFzCwNsetk0
         og/w==
X-Gm-Message-State: AOJu0YwGB1I1e/hnvVCopkqOMavoKx04Go+V/iw0oIwvV5o1kZb/8xab
	g5nLcpRqY3EZbtdcTmLXejS0AXQtv6bML2aRfFq44QIVOF0iyAWfiibkdiUP0tzn8pNn6D/5y8z
	lGyzXW8SF21jCfrchcnvm6Nu9PKYN8xrPgHJ7w2wj9SFRkL9yYdd7doo=
X-Google-Smtp-Source: AGHT+IEeoZ9D9oAwx/f7EIq7dD+wCKVJaV7FnFXl3CITfKFqABW6HnPp93rESWhiN0bheEMk4uOybUjywSuBzyLtjpK/xJr8Xd+Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:3a0:9050:702a with SMTP id
 e9e14a558f8ab-3a3451bc245mr7875195ab.17.1727384730077; Thu, 26 Sep 2024
 14:05:30 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:05:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f5cc9a.050a0220.46d20.0004.GAE@google.com>
Subject: [syzbot] [media?] WARNING in iguanair_probe/usb_submit_urb (2)
From: syzbot <syzbot+ffba8e636870dac0e0c0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, sean@mess.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID cons..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=160d3ca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb61872d4d8c5df9
dashboard link: https://syzkaller.appspot.com/bug?extid=ffba8e636870dac0e0c0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c69290425359/disk-68d42091.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4f26a3e85/vmlinux-68d42091.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3acdec4b62e6/bzImage-68d42091.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffba8e636870dac0e0c0@syzkaller.appspotmail.com

------------[ cut here ]------------
URB ffff888101efbe00 submitted while active
WARNING: CPU: 1 PID: 8831 at drivers/usb/core/urb.c:379 usb_submit_urb+0x14da/0x1730 drivers/usb/core/urb.c:379
Modules linked in:
CPU: 1 UID: 0 PID: 8831 Comm: kworker/1:3 Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x14da/0x1730 drivers/usb/core/urb.c:379
Code: fe eb cb bb fe ff ff ff e9 c1 f3 ff ff e8 ae c6 fc fc c6 05 e6 26 ee 05 01 90 48 c7 c7 a0 60 a0 87 48 89 de e8 a7 c7 c2 fc 90 <0f> 0b 90 90 e9 b6 fe ff ff bb f8 ff ff ff e9 91 f3 ff ff 48 89 ef
RSP: 0018:ffffc90011c07040 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888101efbe00 RCX: ffffc9000c704000
RDX: 0000000000100000 RSI: ffffffff811a9646 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000303be0 R12: ffff888101efbe00
R13: ffff8881118ab830 R14: ffff8881118ab8a8 R15: ffff88812faf1000
FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbcecdf6440 CR3: 0000000128104000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iguanair_send drivers/media/rc/iguanair.c:193 [inline]
 iguanair_get_features drivers/media/rc/iguanair.c:218 [inline]
 iguanair_probe+0xe78/0x22a0 drivers/media/rc/iguanair.c:438
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

