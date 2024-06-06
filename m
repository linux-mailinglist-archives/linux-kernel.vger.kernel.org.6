Return-Path: <linux-kernel+bounces-204498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38168FEFD1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D392288C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4501B011E;
	Thu,  6 Jun 2024 14:39:34 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581119E7DC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684773; cv=none; b=kPMtUC2lhXT6C2JeRSKNJpCaWaIIeBo7QxBVUT1uZHtl4C2S4jaxLayhdWKyN4MZNgEgrAycL6Jp9cYHtFRAmAHCW4m1e9FHIcEenvNjvr3zNXqGZ0TOhDZ0Q9gIOd/u/9Liic86PXLKIpIuvm1claZJVhhh9WUL2B8jd4a75DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684773; c=relaxed/simple;
	bh=P4YiNVb3I4wjSghmt9SxnupyyU9a+FcsHOsRzA0+z/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n0GL6Vm0RzdPCwGujKGwvlUjDyXhrejvA1whOn7n/aYQYupsG0N94UNKvDO138u5Jz5nYA/zdcijNlVV39mHb5Vf6xyB28sPHcez96Ck1QHN+aoholtqDHIoZxpUYXMp8CzzqH7Mro78TS8Db7LXPzpOMWOqT9WNk1tCdvnfyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e261e3e1beso113088339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684770; x=1718289570;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNjFQrtwTKaWBte4tJrnqffbmDU+f1M7PL3F7OYz3Hg=;
        b=YX0ex5a2zNy08IuKe+dmg82L9xY22hZZbcxxUg+YbpD5qmoF8LVIRiqjyKO1XZF7De
         ztGSDgjWjSV6KQHsFV7rn8sI+wll6Qk5bH7UUCiS6lCrueHSm+4Kv6flVtiXLJ10mMI5
         d+/VlyZvK4vZ7qy4EY9mRtmQFWBq376OKIE99fQYT1iBVbv4NimVGSht5/xwxRfqSNxl
         i/0SvVhBtRnKvTtC1QTVEal45npGkU8S06//CDSqKwCviNMTxuJq2eUFX3ZPcuIl+bqC
         gr1wM8Uh+VXw4ZvHgMjx2a2L7fjceoFBsCflJ2+MN5Cj4ar6zogzegNl5qddFIQPEUPU
         gCww==
X-Forwarded-Encrypted: i=1; AJvYcCXxwDAt5YjZKGz7xZ5XvM4hT7j310OJ/GWV7ZuuOo7a00QiT7WRxAdl+evLqzc8aDUF+wIn0FeT0rb7nfD7N/PzvVIwSc7O9bYZfVhp
X-Gm-Message-State: AOJu0YxcRl8oMhq8dYTYEz8K9TosKSLibwubwaicZmLt2VhCMvrspEwN
	4kLA6AH3K2kmxbg+aPT6UA3106XnUrlZfpU0HMSFWvJdWXSwWTGtda/5OHz7aBYaGWuO/KyfqIH
	9wUJHSwr3kpitiXQYkAdi7VonimmmnrmjwBAzx5EtQF9jP19vnHzH1t8=
X-Google-Smtp-Source: AGHT+IFIPjUi6WEYAJixMlNNBzpSNLHiIstWGXkkrLSgheRHg7OUK5Sf5r0nZt1aVPWD8p7VlDX4yyWaVmpw6Y6EPCRNmi0SKY5c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156d:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-374b1f84326mr3805595ab.6.1717684770736; Thu, 06 Jun 2024
 07:39:30 -0700 (PDT)
Date: Thu, 06 Jun 2024 07:39:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000989d2a061a39a667@google.com>
Subject: [syzbot] [mm?] general protection fault in dequeue_hugetlb_folio_nodemask
From: syzbot <syzbot+c019f68a83ef9b456444@syzkaller.appspotmail.com>
To: Tim.Huang@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	akpm@linux-foundation.org, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, evan.quan@amd.com, lijo.lazar@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mario.limonciello@amd.com, 
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, yifan1.zhang@amd.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0e1980c40b6e Add linux-next specific files for 20240531
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166086f2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=c019f68a83ef9b456444
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f4094a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e1e432980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44fb1d8b5978/disk-0e1980c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a66ce5caf0b2/vmlinux-0e1980c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8992fc8fe046/bzImage-0e1980c4.xz

The issue was bisected to:

commit cd94d1b182d2986378550c9087571991bfee01d4
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Thu May 2 18:32:17 2024 +0000

    dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176121c2980000
console output: https://syzkaller.appspot.com/x/log.txt?x=10e121c2980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c019f68a83ef9b456444@syzkaller.appspotmail.com
Fixes: cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000489: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000000002448-0x000000000000244f]
CPU: 1 PID: 5089 Comm: syz-executor257 Not tainted 6.10.0-rc1-next-20240531-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:zonelist_zone_idx include/linux/mmzone.h:1613 [inline]
RIP: 0010:next_zones_zonelist include/linux/mmzone.h:1644 [inline]
RIP: 0010:first_zones_zonelist include/linux/mmzone.h:1670 [inline]
RIP: 0010:dequeue_hugetlb_folio_nodemask+0x193/0xe40 mm/hugetlb.c:1362
Code: 13 9b a0 ff c7 44 24 14 00 00 00 00 83 7c 24 40 00 0f 85 97 0c 00 00 48 83 7c 24 20 00 0f 85 45 09 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 58 09 00 00 44 8b 33 44 89 f7 8b 5c 24
RSP: 0018:ffffc900035ef720 EFLAGS: 00010002
RAX: 0000000000000489 RBX: 0000000000002448 RCX: ffff888026ef0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900035ef858 R08: ffffffff81f5e070 R09: fffff520006bdee8
R10: dffffc0000000000 R11: fffff520006bdee8 R12: 00000000ffffffff
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555564010380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007bd96000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 alloc_hugetlb_folio_nodemask+0xae/0x3f0 mm/hugetlb.c:2603
 memfd_alloc_folio+0x15e/0x390 mm/memfd.c:75
 memfd_pin_folios+0x1066/0x1720 mm/gup.c:3864
 udmabuf_create+0x658/0x11c0 drivers/dma-buf/udmabuf.c:353
 udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:420 [inline]
 udmabuf_ioctl+0x304/0x4f0 drivers/dma-buf/udmabuf.c:451
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5151a7a369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd962ee9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd962eebb8 RCX: 00007f5151a7a369
RDX: 00000000200002c0 RSI: 0000000040187542 RDI: 0000000000000003
RBP: 00007f5151aed610 R08: 00007ffd962eebb8 R09: 00007ffd962eebb8
R10: 00007ffd962eebb8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd962eeba8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:zonelist_zone_idx include/linux/mmzone.h:1613 [inline]
RIP: 0010:next_zones_zonelist include/linux/mmzone.h:1644 [inline]
RIP: 0010:first_zones_zonelist include/linux/mmzone.h:1670 [inline]
RIP: 0010:dequeue_hugetlb_folio_nodemask+0x193/0xe40 mm/hugetlb.c:1362
Code: 13 9b a0 ff c7 44 24 14 00 00 00 00 83 7c 24 40 00 0f 85 97 0c 00 00 48 83 7c 24 20 00 0f 85 45 09 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 58 09 00 00 44 8b 33 44 89 f7 8b 5c 24
RSP: 0018:ffffc900035ef720 EFLAGS: 00010002
RAX: 0000000000000489 RBX: 0000000000002448 RCX: ffff888026ef0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900035ef858 R08: ffffffff81f5e070 R09: fffff520006bdee8
R10: dffffc0000000000 R11: fffff520006bdee8 R12: 00000000ffffffff
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555564010380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007bd96000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	13 9b a0 ff c7 44    	adc    0x44c7ffa0(%rbx),%ebx
   6:	24 14                	and    $0x14,%al
   8:	00 00                	add    %al,(%rax)
   a:	00 00                	add    %al,(%rax)
   c:	83 7c 24 40 00       	cmpl   $0x0,0x40(%rsp)
  11:	0f 85 97 0c 00 00    	jne    0xcae
  17:	48 83 7c 24 20 00    	cmpq   $0x0,0x20(%rsp)
  1d:	0f 85 45 09 00 00    	jne    0x968
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 58 09 00 00    	jne    0x98f
  37:	44 8b 33             	mov    (%rbx),%r14d
  3a:	44 89 f7             	mov    %r14d,%edi
  3d:	8b                   	.byte 0x8b
  3e:	5c                   	pop    %rsp
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

