Return-Path: <linux-kernel+bounces-194748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1218D4164
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAD61F24735
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8170516E88E;
	Wed, 29 May 2024 22:30:23 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5415B979
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021823; cv=none; b=ca4OmufqWPDd1FUtYwEFqC5PzebY3e3DTlVblh5kwDZnWj+qUppSSpMbpy0xNhaCUvSss0hjYcCfX/8FjDHbLjUrst4/XgenXS71CM5dGOsv+i5+9aloRsgTQqbM0Wa8nlnq4xfulotz8MJinmWkEZ4Fd0UPRWozGcEZr8vRi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021823; c=relaxed/simple;
	bh=Wjqvok8fPK5NLe0M0PZ1xDWxdUJWuoYVqXck7hWrW0o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WPHCnk+fne6RT1F8PfYVFzgXyuPCoIP14JHnR4Q6aRQ+VEfSaIcFnVR7J0Eq+FR6uK3MQQp1TEcGLt0Ogwz9Tf8PS3TUIjWocirRatAP8l+L3M++XaPBTzMMFr0eyloPM+t667i7GKfOFdWZ8pVEfh33VZABH4+GLzmq2t9EGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ea8fc6bd4dso24166939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021821; x=1717626621;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hxfthigWSnf6Iu5GhtUpWJNdXbPNHy9/QhHLuf/wi8=;
        b=ePQJFmt0A1z6/g6OdzMQvmiLM0+KkQ6nISVGn5jKtP1dKjRk5lXtZaCcv95iEurQgA
         ClqDHUaJy3mgx8O0QwivJFzE1LTUdZQxAwCuX00N8iIein7YhMJ+yIQ5n7MzJNJV9R3W
         iI8XXZFfi1hJNDTk8WZZo6GLMrDOPoalajj/LJ1gn5gM5GhvBdR3EmYplEKROMK2xw6x
         hg23vabw2K4JG+EaX9lW50lM04bxL5hXw0PAJ/5D1Cph2+Ph5/uDUbnDbSW+gkSkGw18
         LyQnqG4DNLgMH3cQjdzztZ0/nKj4cZ6Nx0GY/WkW4OmHTlbq3RLSs9igz4aQyv25DSwc
         07lA==
X-Forwarded-Encrypted: i=1; AJvYcCXqdb2Drc4eogeR2CiCvsauwDJfKhX3sIHqPo5Kd/cpBQ23TiukEZ5CCmNGvyMQdORK1A2Neuw8bzNUK7+CAZ/UXJpwGqj0HjaH2+Rf
X-Gm-Message-State: AOJu0YwBeYCIax+i0Kl7DNxIukBw8fF+8jWwiBCAmTB5TwrPCze4qXiP
	Pu8OTdonvockM7/yuO1ncL9LDFh+AO4Qgl27TiC7yC9FxilnzhzwTB30VFxQfPVV23NmpBKwZU4
	KYjknVNAzIMJRvEnxc07CCvxXbJG2bKgXWqPqAWnqceOYiipHE5+Hnj0=
X-Google-Smtp-Source: AGHT+IGWug0sawcJCS+CC+4eZbKySZoVKmyCcuC7dUNwUwNu+Q/SlvQzKIPAHuj6QxZDKfyBuXNJPwgMH6YiLmRRCHeWRr3B57is
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2c01:b0:488:59cc:eb4c with SMTP id
 8926c6da1cb9f-4b1e4f7222fmr13937173.3.1717021819342; Wed, 29 May 2024
 15:30:19 -0700 (PDT)
Date: Wed, 29 May 2024 15:30:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d216906199f4bbc@google.com>
Subject: [syzbot] [kernel?] kernel BUG in deactivate_slab
From: syzbot <syzbot+3ca210d193a9b5978ec2@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    54f71b0369c9 Merge tag 'rtc-6.10' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b53a34980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e70c03a304f3c3ef
dashboard link: https://syzkaller.appspot.com/bug?extid=3ca210d193a9b5978ec2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-54f71b03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bc3c5654135/vmlinux-54f71b03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d88013021348/bzImage-54f71b03.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ca210d193a9b5978ec2@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/slub.c:2923!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 5293 Comm: kworker/2:4 Not tainted 6.9.0-syzkaller-12333-g54f71b0369c9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: slub_flushwq flush_cpu_slab
RIP: 0010:deactivate_slab+0x350/0x4a0 mm/slub.c:2923
Code: de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7a 5a fe 08 f3 90 4d 8b 6f 20 4d 8b 77 28 4c 89 f1 48 c1 e9 18 84 c9 0f 88 61 fe ff ff 90 <0f> 0b 48 8b 4c 24 20 4c 89 e8 4c 89 f2 f0 49 0f c7 4f 20 41 0f 94
RSP: 0018:ffffc900043f7bb0 EFLAGS: 00010246
RAX: 14ffff88805d9880 RBX: ffff88805d98f8c0 RCX: 000000ff00000000
RDX: ffffc900043f7c20 RSI: ffff88805d988000 RDI: 00000000000004a8
RBP: ffffc900043f7c88 R08: 0000000000000001 R09: 0000000000000014
R10: ffff88805d98f8c0 R11: 0000000000000001 R12: ffff888025b61cc0
R13: 0000000000000000 R14: ffffea0001766201 R15: ff00000000801800
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000edc6be00 CR3: 000000004b302000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_slab mm/slub.c:3100 [inline]
 flush_cpu_slab+0x141/0x410 mm/slub.c:3146
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:deactivate_slab+0x350/0x4a0 mm/slub.c:2923
Code: de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7a 5a fe 08 f3 90 4d 8b 6f 20 4d 8b 77 28 4c 89 f1 48 c1 e9 18 84 c9 0f 88 61 fe ff ff 90 <0f> 0b 48 8b 4c 24 20 4c 89 e8 4c 89 f2 f0 49 0f c7 4f 20 41 0f 94
RSP: 0018:ffffc900043f7bb0 EFLAGS: 00010246
RAX: 14ffff88805d9880 RBX: ffff88805d98f8c0 RCX: 000000ff00000000
RDX: ffffc900043f7c20 RSI: ffff88805d988000 RDI: 00000000000004a8
RBP: ffffc900043f7c88 R08: 0000000000000001 R09: 0000000000000014
R10: ffff88805d98f8c0 R11: 0000000000000001 R12: ffff888025b61cc0
R13: 0000000000000000 R14: ffffea0001766201 R15: ff00000000801800
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000edc6be00 CR3: 000000000d97a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

