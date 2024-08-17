Return-Path: <linux-kernel+bounces-290826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6225955932
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4BE1F21AD6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB651553BB;
	Sat, 17 Aug 2024 17:46:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB212C46D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723916790; cv=none; b=DUcO+kNGsnfaiXBpSH7mGPPsSF52QNGli5+88MpDR3EMVij0xE3cGau4cCVyRelEm9rL5Zz69jt0onzD9stSu2wVCn+FHUxaGn3MHRKTh32jbCqpoEhUzoad15mUx+/VQWTjUHTGvInxmOeaDjlrT6X6AL5ZTVGBx2n23SwYOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723916790; c=relaxed/simple;
	bh=W/+uVizMVR9vGpQxbGVag0BW2mj4QMLV24SQfH30w9c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PceOskT0L4o8LDIXBSjwqYUIXtm6fiVMe9fuBgaG5AAbSxDFjhkCLZd1ylxykrXTk7J2iAIMi9N1tkBbmKXlqZvVk4jlYI5vyfNhYmEVZ/MnU0S+IJYVWlXD+gTgRt2mVYAPI5hyZyRfnlCm3egVbEkyd+bDrQGP5MtQizRjN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d27488930so17793475ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 10:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723916788; x=1724521588;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebWrfS+689otl4sLKCGe5obuD7mBCfaUX+ut3RYyWlU=;
        b=Jeth/mUAep3nYcorJeXfuPQkIiKpz9/t5OAEjUKpWa+F8SIaMRc6HZA4if4ahrGCOM
         CfIh7ZZKJSP78SAyZNjA4LpRsqVIHBqJ2ewrRxi3hQCm4rmX3JtDlmPCTVNETrSF7r+j
         GdDc7GQTEru5e5fiuoKoOFyV8/+KKEFtjVvLDEuDIQ5Xi+luqJzoU6QURkJqzmiupuK+
         8J79GFZ+ge/8wm93w+uJ0TPvwHa0MdmRPn2sw2DDpQ4Mi9ecOnKvuwOIOM9AID6DF8lD
         0pUdwBoyZfu4xoJQGV1OnBfikU5MyGII55TlBfkvOxm8laJEu6HiepklwwhJoKiLk+pb
         H+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIiuaBs8qfMRxnCKoPn+tY3/teUoyBM451YTarIcuKOlCzpHX+wOEnk0suk6EEsbktoA7bZ6oTtb5wrp1NIrBrGbY5sM+uRHDir1pB
X-Gm-Message-State: AOJu0YxBDkChKgSEMWepjjxgRSmOe8hudeyerd3GX4rf0dhfnWbKE9J0
	L/Z9+hQdhrxPQxVC8xtgfWH1fM26Arb27fQynlCfxH6pXk1NVdJyy3GIbyW0btaUMS3P/pWwtp/
	PbpRdT2TW6BhAY1HfJPnGkCt8PpC30+dRbbTCS/A7UiKYzSCtp1I+pVI=
X-Google-Smtp-Source: AGHT+IFJkwRJhL/l/ms5STwnkH+kjNrJW+5nATteoNlAmTLoyGW3wzXDcOvbR+ZcsdQ9swPDGKg3LOR6H88zavPLvrcuV23rqiCf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2207:b0:39d:300f:e91c with SMTP id
 e9e14a558f8ab-39d300fecefmr3265535ab.5.1723916787902; Sat, 17 Aug 2024
 10:46:27 -0700 (PDT)
Date: Sat, 17 Aug 2024 10:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3ff9f061fe4a709@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_del (2)
From: syzbot <syzbot+a6d9742ac04af8e8a014@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=158d4405980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bc88a9f65787e86
dashboard link: https://syzkaller.appspot.com/bug?extid=a6d9742ac04af8e8a014
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ef30d34e749/disk-8867bbd4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a21c2389ebfb/vmlinux-8867bbd4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9720b12c3f99/Image-8867bbd4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6d9742ac04af8e8a014@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=8192 which is not allocated.
WARNING: CPU: 1 PID: 6377 at lib/idr.c:525 ida_free+0x2b8/0x378 lib/idr.c:525
Modules linked in:
CPU: 1 PID: 6377 Comm: kworker/u9:2 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: hci3 hci_error_reset
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ida_free+0x2b8/0x378 lib/idr.c:525
lr : ida_free+0x2b8/0x378 lib/idr.c:525
sp : ffff8000a02e7880
x29: ffff8000a02e7930 x28: 1ffff000124706cc x27: 1ffff0001405cf14
x26: dfff800000000000 x25: ffff70001405cf10 x24: ffff0000e735c008
x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000002000 x19: ffff8000a02e78a0 x18: 1fffe000367a49de
x17: ffff80008f3bd000 x16: ffff80008033878c x15: 0000000000000001
x14: 1fffe000367a7600 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 97b9b82baa63c900
x8 : 97b9b82baa63c900 x7 : ffff8000802aebf8 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff80008b3800a0 x0 : ffff800124a1d000
Call trace:
 ida_free+0x2b8/0x378 lib/idr.c:525
 hci_conn_cleanup net/bluetooth/hci_conn.c:156 [inline]
 hci_conn_del+0x5c4/0xaa0 net/bluetooth/hci_conn.c:1154
 hci_conn_hash_flush+0x184/0x220 net/bluetooth/hci_conn.c:2585
 hci_dev_close_sync+0x76c/0xec0 net/bluetooth/hci_sync.c:5062
 hci_dev_do_close net/bluetooth/hci_core.c:556 [inline]
 hci_error_reset+0x108/0x35c net/bluetooth/hci_core.c:1087
 process_one_work+0x7b0/0x15e8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:3393
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 6510
hardirqs last  enabled at (6509): [<ffff8000802aec98>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1418 [inline]
hardirqs last  enabled at (6509): [<ffff8000802aec98>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5162
hardirqs last disabled at (6510): [<ffff80008b1fe010>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (6500): [<ffff8000801ea530>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (6500): [<ffff8000801ea530>] handle_softirqs+0xa60/0xc34 kernel/softirq.c:582
softirqs last disabled at (6341): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
Bluetooth: hci3: Opcode 0x0c03 failed: -110
Bluetooth: hci3: Opcode 0x206c failed: -110
Bluetooth: hci3: Opcode 0x2046 failed: -110


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

