Return-Path: <linux-kernel+bounces-299131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A937195D085
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB131C218B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41A9188934;
	Fri, 23 Aug 2024 14:59:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CE18859A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425164; cv=none; b=ULUtreUFzRS4hXBH7vVKAMmES3FRX4eyvxE5ov1LW4kCwRQhzAB18TlSBu1Z93Z3HAQl4zAGba8ANqEUPvu1nKywv9U63VQ2+kCwTkPXo1xH+Ek6DWH75oiJWne5gau23V9pOgzJUlabC4NfMrGmAA/GybmFWsnpVl9oXUl7PFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425164; c=relaxed/simple;
	bh=+cO5iDtiVefaLy9OqDQvfdGVMsajBS0aKXFTf1N1mxs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DMyLii6faPCr8TK/XvwiUuuqygOxKTK3N/w9LwnyaPl+qq6WC7lvP6ZvPwrt73bxB8XKV470RkN98ay7Ez58FYkl2qv6B3C7vChevYsASyQcfJARqWW6zS3DEQcTE+TnUAGUVAsWEjCclSNNbpIqMRTZGBSrrRTaIZIrXWzsMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa44764bbso219596639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425162; x=1725029962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTIFi9L9UeHyNSaav76xv9rofn+a9DeiubQ8FGO7z3g=;
        b=nLdVCEhW/Mrf/a6lbbk7LpHFoUe7o//obF8Obi7+hcpjm6LxsDnr8T+XBBx/ARVsJ4
         vLGNeC09YowGyWa6KKNEMrgOJqCDgsociYVY3zWXZisRAWj/PX4kusuUr01nFSXZ4g4W
         eD0UyxYOSRlCUqkjTUqdtXUrNBfclATxFyl07z+u3ZEFFQFWsc4xDQcTw7lwyxi0dQzu
         N+upgzB47jGGQ02DFWFDOi4YSeId9W6RE1606SPRCRwm3nGVAa+rQHUK8aQBZWlUZVVA
         nF/owevfLgTRgOHGj6YHw4NnvTQCS5VNUf+i+WdQHq2n/p5aHhAh8CylNC/SNJhCERrB
         5mYw==
X-Forwarded-Encrypted: i=1; AJvYcCX9/LpDO/rUbmK5MTHOhaTRtR2Ynbeb78Gok8A3/9M08iPN9HYsFuwd3UyD0CizKkZCYm4vbb6CtjmmlaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/i6RlqmGMOfmh/Tdxou6iIZ6FKMBvPO0omjnPDutTR1MzNsH
	b3+MoLiPS6eb8KCr4hR/zd3VL9KmJ1KfXRtEn9IEw3Y58xs6BR//3XEuTsr/lLSWMLJLlAkg7Zh
	fnq/tBSkZ6EpSOuoPCQFKfxwXOoiN0hMDflEj7zuXOQTjpUwhxgxmhwg=
X-Google-Smtp-Source: AGHT+IEdhSqKPJiuaiV0LCtePBM5lotT/gx4Ia9RBngJx//c1xiJrf1p2mSOBcG6lU0dPAai+QX7PFstzkkXH2VQotoL6coWuOHj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c08:b0:81f:927e:d900 with SMTP id
 ca18e2360f4ac-827873128ecmr13987739f.1.1724425162032; Fri, 23 Aug 2024
 07:59:22 -0700 (PDT)
Date: Fri, 23 Aug 2024 07:59:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000399d6e06205b056e@google.com>
Subject: [syzbot] [usb?] WARNING: refcount bug in usb_get_dev
From: syzbot <syzbot+e8c4df4ec92aa7f4e3a2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    528dd46d0fc3 Merge tag 'net-6.10-rc8-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108f8c0d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63b35269462a0e0
dashboard link: https://syzkaller.appspot.com/bug?extid=e8c4df4ec92aa7f4e3a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e86e44bbf25e/disk-528dd46d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/601010d0e1b0/vmlinux-528dd46d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c98ac3165731/bzImage-528dd46d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8c4df4ec92aa7f4e3a2@syzkaller.appspotmail.com

usb 18-1: new SuperSpeed USB device number 27 using vhci_hcd
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 784 at lib/refcount.c:25 refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 1 PID: 784 Comm: kworker/1:2 Not tainted 6.10.0-rc7-syzkaller-00254-g528dd46d0fc3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Code: 80 d6 1f 8c e8 37 16 a9 fc 90 0f 0b 90 90 eb b9 e8 5b e8 e6 fc c6 05 64 bf e8 0a 01 90 48 c7 c7 e0 d6 1f 8c e8 17 16 a9 fc 90 <0f> 0b 90 90 eb 99 e8 3b e8 e6 fc c6 05 45 bf e8 0a 01 90 48 c7 c7
RSP: 0018:ffffc9000384f270 EFLAGS: 00010046
RAX: 984309741ee81900 RBX: ffff8880257470e0 RCX: ffff88801fb85a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff81585882 R09: fffffbfff1c39994
R10: dffffc0000000000 R11: fffffbfff1c39994 R12: ffff8880242d8408
R13: ffff8880242d8448 R14: ffff8880257470e0 R15: ffff8880257470a8
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000005845d99c CR3: 0000000062b7a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000400
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 kref_get include/linux/kref.h:45 [inline]
 kobject_get+0xfd/0x120 lib/kobject.c:643
 usb_get_dev+0x23/0x40 drivers/usb/core/usb.c:765
 vhci_urb_enqueue+0x5bf/0xef0 drivers/usb/usbip/vhci_hcd.c:785
 usb_hcd_submit_urb+0x36c/0x1e80 drivers/usb/core/hcd.c:1533
 usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:154
 get_bMaxPacketSize0 drivers/usb/core/hub.c:4805 [inline]
 hub_port_init+0x1156/0x2670 drivers/usb/core/hub.c:5066
 hub_port_connect drivers/usb/core/hub.c:5450 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x295f/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

