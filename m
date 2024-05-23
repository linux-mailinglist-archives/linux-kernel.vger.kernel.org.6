Return-Path: <linux-kernel+bounces-186914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276CA8CCABB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B871F21077
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551B9475;
	Thu, 23 May 2024 02:27:26 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAE847B
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431246; cv=none; b=YuulXEXCQIpToEz3B04xknI9kY+6xfqp8osW/cM7l+LKP25eDuasGqH2uQer+tOALi/SQnOHYFwzNc51uR0YMps5RXh9XtcipL2pW7jnTPBX/0IU+6g68SoygqX1B7AcvaX/V5zJwS0+hyigLTV7ae3MTYCH0bQxM88tFnV8xRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431246; c=relaxed/simple;
	bh=bSFp0V3O/8ow+t83Egk4O9tbQmALaBMG+AVxfZAfrD4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KrRYJ1siz/0KQ8LVJ3d6MgC4fBlhF8ePs4EtIQPKS7O+/N1WcxE1Ynign42pb71Ufy1fKWzmLTmNRSM4uEWdEzow0vxCN4ojvIxURsZexkyaFpSUdH7umQP+FhpBawtLWq9xsA9ChOVjhzFOmXWfvUKTvme88UaBzToBXORAPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1e409d1f4so117232739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716431244; x=1717036044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgJmmoVp+JrxU5ljaXxCBdzfp456SHHaXgodLVHwqLU=;
        b=vvhPBOTRwSScJKOF5zv1eXDVp7ZoXweMGBr1NRHqjoSqtOznhIxDH0dK9jxkfKAZbS
         X978/c+adDrOcj/faLn7g+4+Eu4S+2A+zZWhQKQ9mWE2bjoRW1v9uXyucTf8NlSrg81b
         eypvv8cYNTC/wkriZAFkLnkD/kD99o8nLwEw87dcksP+WRMx7KVXQO/FW0ATLkTpPrT/
         aTMd+CZSAY0lar2F8GYa4cB8FY3SaLzmavQE/VZ9flBeB4tne9OWDKsLijj+sTHAjeyG
         042RnSZtMJwxAUkjJbTgNfMDfzPpdGO0L07QMt3SdpqG+FAsxXWWSWTAYX0blAwjlN+0
         YnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEUkZckVPLLXzwinx7LuH3OO21iOE+lR+hcpK9UhuqsqOo8J7oLfnv8XgOxWdqx8j8b2wbuxVRcO4jwjL5nKys3RkCWF/y2W3btZfK
X-Gm-Message-State: AOJu0YzlTpaaWq2fszCir6939Bi7h7+XAOZ+8lMy7H7jF5qzALeJ1mqA
	qJ/7RLbBWvYTxGTmu1H6uK4wpcBMEIttDIjRDNhXC3kpTQlfxKFkkdkYR8EA28m0d5ZPWMewnBE
	eX8O8BFIy4sBdH0bPLw589iOkI5J4ulE7TR10DPoGcfjoEIxjTYvOdJA=
X-Google-Smtp-Source: AGHT+IGiLWtutli4ybjmH9BuUV3InSOSYt1Rcxi2bqzc28tMI8TpNlDUASjdVONvrYgZ0Btznzpv9gg592hcdjpmD0VCiri33Fi+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2182:b0:369:f7ca:a361 with SMTP id
 e9e14a558f8ab-371f8f1cd31mr3282225ab.1.1716431243480; Wed, 22 May 2024
 19:27:23 -0700 (PDT)
Date: Wed, 22 May 2024 19:27:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c9d27061915ca9c@google.com>
Subject: [syzbot] [kernel?] WARNING in flush_cpu_slab
From: syzbot <syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d42b0a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
dashboard link: https://syzkaller.appspot.com/bug?extid=50e25cfa4f917d41749f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(l->owner)
WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_slab mm/slub.c:3088 [inline]
WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_cpu_slab+0x37f/0x410 mm/slub.c:3146
Modules linked in:
CPU: 3 PID: 5221 Comm: kworker/3:3 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: slub_flushwq flush_cpu_slab
RIP: 0010:local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
RIP: 0010:flush_slab mm/slub.c:3088 [inline]
RIP: 0010:flush_cpu_slab+0x37f/0x410 mm/slub.c:3146
Code: ff e8 e5 b2 fc 08 e9 25 ff ff ff e8 db b2 fc 08 e9 46 ff ff ff 90 48 c7 c6 7f 68 37 8d 48 c7 c7 b6 33 37 8d e8 72 88 6f ff 90 <0f> 0b 90 90 e9 dd fe ff ff 90 48 c7 c6 88 68 37 8d 48 c7 c7 b6 33
RSP: 0018:ffffc90002b57c98 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffe8ffac1021b0 RCX: ffffffff81510229
RDX: ffff88801bb7c880 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: ffff88802790b540 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: 0000000000000200
R13: ffffe8ffac1021d0 R14: 0000000000000000 R15: ffffc90002b57d80
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f73ffec2 CR3: 00000000268ca000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
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

