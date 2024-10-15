Return-Path: <linux-kernel+bounces-366083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7899F0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9571F242F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19BA1CB9F9;
	Tue, 15 Oct 2024 15:06:36 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B201CB9E1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004796; cv=none; b=TqN68p+q2ucqqBsFXKz/RLFSTGqZEtP85PMRlELvNE+c8TbplNX0luVY41cMwIuSotsM6hjHGm452mr7NrL0JrGlnl3dZ+ZYXOWCs91hmDnVNzqt5SJNsj/f8+vb0tgSi7oh11rA7+OsDyLAk+AacyoM8WLUOXIzCtbYd6cuJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004796; c=relaxed/simple;
	bh=b9zVKdALyR6FWRIF6AKtu09YPYWfPIVFFqBz4fku8Yc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=obGtKxRTTaiFgi/UHkAZU9BOL0FJRz3zixg9dIr/Gq5aAwhnYVKjVwszWaQPC0gizg7hTkoT4IWscDvQxuF4IYExVx3gePS2Wp8KxhXf35/ZkbLSAHG+1O8Ax2Aji/D1O0UXK2Bjuku4kU1YkSCgW+DEGfKxDUYep0xDhAzr9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3cb771556so33050735ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004793; x=1729609593;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gydL3BY4I0CKdYtAxwRQGGcBCrph7RK9zLofddZFDME=;
        b=JDO02wp06YttfXSqvuPa75q9ocjsrkh20PP4mJdHUT+eW9PIFrjm4SXgbSp9sPlHWP
         f/m9b3dw7d2/6qzNEd6hKLUC6wF7GVPwjZ6+Vyvs8qwvdoe+crgvrjCsS3z1zrc8uEmq
         /dlnKUZePb5f+IGkHKxaUq6rvH6lCTewUyFyzjTtRtZP2cw5I+ecRzUNGl9627C60o4v
         xOKgX0I9nytf8ovxmeCZ8WZnQeFiA9/0Wu1UfcpiIhp5fOpgVEfyNY1ASbFyOUX5j6g1
         1p3Bb2nvNXlYS078B5CtPHinciT991KwpOnXD5LCn+eNpR/dwEjUri0NxX+MaL42xk1W
         qu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXtDGGKf1L9L/t2Dc6h0uxp0tXbrP+qY+Q0Ko2h2MibQz8fZhhDcrE3XWf4cnJkLUZHJ0frh4NCOqexa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFM59koCcnXOL0Yfw7udyrbTtkXf0ByyILi9pcTJpmXYyTmN4J
	u2gDfabG412hLbua9OhxN6dhPKBjWxaypxi8xIjmXCLDTh2/ZNWBEiN15FHxGtt2jk7uh0kCQns
	G9cikpLmAq5DgGPLq88DA+ZAhKD6IhuUYmpRBuWpAYVI2AaP6HcUI+cA=
X-Google-Smtp-Source: AGHT+IHhTzZNijy5n5VZt2U5pWpwZHIW5JojnZ+4VyClCEylWpYHdSdJJxxOiHTqjpok1/r2A7uBppatDi8LNSpyx3caccQRYVBe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c88:b0:3a2:aed1:1285 with SMTP id
 e9e14a558f8ab-3a3bccade28mr106527975ab.0.1729004793376; Tue, 15 Oct 2024
 08:06:33 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:06:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e84f9.050a0220.d5849.0008.GAE@google.com>
Subject: [syzbot] [mm?] WARNING: ODEBUG bug in __folio_put (2)
From: syzbot <syzbot+0f138d82bfc86d146253@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d73dc7b182be USB: chaoskey: Fix possible deadlock chaoskey..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15e94727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=0f138d82bfc86d146253
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e94727980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f9e1e81549a/disk-d73dc7b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5360843a122/vmlinux-d73dc7b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3476aef56fd6/bzImage-d73dc7b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f138d82bfc86d146253@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888131d037c8 object type: timer_list hint: rtl_ips_nic_off_wq_callback+0x0/0x680 drivers/net/wireless/realtek/rtlwifi/ps.c:283
WARNING: CPU: 1 PID: 36 at lib/debugobjects.c:514 debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/1:1 Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event

RIP: 0010:debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd c0 fc 46 87 41 56 4c 89 e6 48 c7 c7 20 f0 46 87 e8 2e d5 c3 fe 90 <0f> 0b 90 90 58 83 05 ad 76 ff 07 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0000:ffffc90000267418 EFLAGS: 00010282

RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff811ab159
RDX: ffff888102ad57c0 RSI: ffffffff811ab166 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8746f6c0
R13: ffffffff872a8e00 R14: ffffffff840306a0 R15: ffffc90000267528
FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d8de234978 CR3: 0000000008ca0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x4b8/0x600 lib/debugobjects.c:1019
 free_pages_prepare mm/page_alloc.c:1115 [inline]
 __free_pages_ok+0x244/0xa20 mm/page_alloc.c:1250
 __folio_put+0x1cd/0x250 mm/swap.c:126
 device_release+0xa1/0x240 drivers/base/core.c:2575
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3783
 rtl_usb_disconnect+0x41c/0x5a0 drivers/net/wireless/realtek/rtlwifi/usb.c:1079
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903


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

