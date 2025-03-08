Return-Path: <linux-kernel+bounces-552474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3465AA57A29
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231673AE103
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF611B4139;
	Sat,  8 Mar 2025 12:30:31 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC21DFF0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741437030; cv=none; b=YtndJN6Rhh/JiKpghSeVfi/UMcywPxzcQ1kIxQ/D97RvCGo4dJ/pkGURXyvNASX7FjUwwMiHXPt5wkwjMpBZxlgYgXDzAcmtJcT3stvfOD6hN485WOTlwf5hCJsucrfO5izU4R2AsDEwDICmcCmNdBRtW/PrcTMFaOfQIX+IdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741437030; c=relaxed/simple;
	bh=DH8FbSf3YohZ9yx2Jz8KguYIBaZIrLZbHt+La4ScURQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q1dRQtbV4yipMCapcXCmTOE+GnCGnTzdTgkpzall3RPlzXp6fpWJgYZc/p/JOloizjkD9ZOs3P1aYAt6aczMIds/g337FH8hjOLYQ2Ln28EYT1409iJ3I2A8+GGHaf1Yj0w3MwdgmsMX7N77HFxFgPCj3lrgJNnospl9Lzg/vS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85b37197e83so16379439f.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 04:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741437028; x=1742041828;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOhUWRiJ/Lbl5/fUOrTlMUooqThfSWNCnyvnlDhO2Yo=;
        b=L2MltojXXIk9pxSlQZXFc0i/J2J5cmXm4fe3+L8EcRXXp+VtG0gyuUYsVpv/RxyUtq
         4Uk/bIabK3FPxso3anGTHQTmI7cQ0fqUXbAiuC4pQlIUvgk4A+OAf5wasTGnFXwD7xsd
         MesDnNheoRS9y0l8DMrqasGobHuVLha2vJu6jI/kjye2PcEfUUSwzPIY/toYTHYkHbiX
         UJqZbyxpmaj5pFxc123dgN6KOfaSJoL4kbemkj+YAjCKze/BBGjo04heFEMKmVkeQL2k
         qLZoZEsToj11vuq8SLnhesxrR8+YprOnR0c5P4mWCkJe+Q3pEgLMGF3an2K+MrDUfaHN
         cAkA==
X-Forwarded-Encrypted: i=1; AJvYcCUP6vJ8V+jGdm+PWbqVYCwJJT16Hj6y2bcmqnVMI90CU34N6izwrWWB2KQEy4F9Zws9u2yH9HY94GFX7ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSnMClOEDj0nvyTd+6rA9rV0dD8e4sC4d3Z4xqnTr8unUzp8P
	gdgIGDcFLPSZZTRoNswE5Z3IILPl8WhRdDDnFs4hlc5YNeZeIEfQftbMMOCL+TaA2fQ5iyKAPUZ
	OSmUYSlKUbJAf2sp2uIFjWSo/oP1tLbEk/GrHxiy5rMu0MiO9hjN0xmQ=
X-Google-Smtp-Source: AGHT+IEi5wXbsC2JBhfwWOTcebre2O2MJwwj+vteB7d3uQITU8fcDf1gInUzOSZqxMnlGguEisybqTotwsxU3SVfiUlG3Ih+mAT4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240a:b0:3d2:aa73:7b7a with SMTP id
 e9e14a558f8ab-3d441995eb8mr88280015ab.12.1741437028299; Sat, 08 Mar 2025
 04:30:28 -0800 (PST)
Date: Sat, 08 Mar 2025 04:30:28 -0800
In-Reply-To: <000000000000ae6c0606200d72b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cc3864.050a0220.24a339.0094.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] WARNING in kernfs_new_node (3)
From: syzbot <syzbot+306212936b13e520679d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    21e4543a2e2f Merge tag 'slab-for-6.14-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1753fa64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2040405600e83619
dashboard link: https://syzkaller.appspot.com/bug?extid=306212936b13e520679d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e1cfa0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a36f3b02b3c/disk-21e4543a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef1c824f5193/vmlinux-21e4543a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb1e24b4d535/bzImage-21e4543a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+306212936b13e520679d@syzkaller.appspotmail.com

usb 2-1: Falling back to sysfs fallback for: ueagle-atm/eagleII.fw
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6105 at fs/kernfs/dir.c:526 kernfs_get fs/kernfs/dir.c:526 [inline]
WARNING: CPU: 1 PID: 6105 at fs/kernfs/dir.c:526 kernfs_new_node+0x1d8/0x240 fs/kernfs/dir.c:703
Modules linked in:
CPU: 1 UID: 0 PID: 6105 Comm: kworker/1:8 Not tainted 6.14.0-rc5-syzkaller-00214-g21e4543a2e2f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events request_firmware_work_func
RIP: 0010:kernfs_get fs/kernfs/dir.c:526 [inline]
RIP: 0010:kernfs_new_node+0x1d8/0x240 fs/kernfs/dir.c:703
Code: 74 08 48 89 ef e8 08 58 c2 ff 48 89 5d 00 4c 89 f0 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 19 7d a9 fe e8 f9 1a 5b ff 90 <0f> 0b 90 eb a0 89 e9 80 e1 07 fe c1 38 c1 0f 8c 62 fe ff ff 48 89
RSP: 0018:ffffc900032c74b8 EFLAGS: 00010293
RAX: ffffffff8266c3f7 RBX: ffff888034152d20 RCX: ffff888035b58000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8266c394 R09: 1ffff1100682a5a4
R10: dffffc0000000000 R11: ffffed100682a5a5 R12: 00000000000041ed
R13: 0000000000000000 R14: ffff88801ffe12d0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3105ffff CR3: 000000007c79e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1061
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 class_dir_create_and_add drivers/base/core.c:3208 [inline]
 get_device_parent+0x391/0x410 drivers/base/core.c:3259
 device_add+0x325/0xbf0 drivers/base/core.c:3589
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xe55/0x1430 drivers/base/firmware_loader/main.c:941
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1194
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac0/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd30 kernel/workqueue.c:3400
 kthread+0x7ab/0x920 kernel/kthread.c:464
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

