Return-Path: <linux-kernel+bounces-362071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FD299B088
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1F5B22C57
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711A86277;
	Sat, 12 Oct 2024 03:56:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36765A41
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705365; cv=none; b=lK2d0JLlwXegGMx5mvVbcmtFmnF+OwciurLvIFGqaWJzIs3/Y8g34Nl3M5HGRlOl4X2i82qThI5CMWg7rTJcyeX20el2ecFCxx4sJdaVZq3wwsbdMk0WAEnu3LJLDJQJ1plhwVtl+Lu0bxMjnGXjtfMfj31UJGu0qhvO5tghMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705365; c=relaxed/simple;
	bh=7b9Ul/gAnpIBZL8mgfEX8Vn2sR6CaekFNwe9o04w0Og=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VvpFZ4xt59KjEVeTm1j0Iw96xdtVmNjW3eNgsok4Zi2bBRYpeZQP+WM1JiUkMgAkS7/2PkDHx52VjUzHH61/i7vmMsUXziwWRQkXfQL3TT7ppqvqgs42XdBvMDpPE9dL+H60476cesdpIkgvcHQ/4u2OnaxHezs4RLxbiiwtFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8354dae2e52so211655539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728705363; x=1729310163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpqzyHfurE6XgXi2F9a1tVKCuHlinPJzI2VJhbQD/84=;
        b=SF5T/1stey42pXzNLcLDDiPZ8iHx7Spg2zPSN29sedGFRsc8R1bWFIeQHScuemyRVZ
         y0YUm2YI5s2l+5a34prg0Qv7uI3PaOcgb7O6W4awTZnUcz+h5ydVY7T6gY/FUEDvxEpw
         IDZZC7dsiDy7APnrhH+pMT6XKjwZyz3aedpT8N9yW2DOlgYmoHb/f9fl6/8GYVt8zAzE
         XB5q5a68v9qAEJQCO3ArH/Oj2/eRIS4vw88+Lez4XtNei/peLQjulxA3WQD8fnTASMl6
         YqMo8bKubFjX66mkn61Os2jF/GuBzOQ6nvC1N3DArVBhFCT5ZaBcG3ZocCrZbKTINyV0
         /cVw==
X-Gm-Message-State: AOJu0YzaBwpq3IyYbaF2YjwvW3dF8lWow1Z/z6FwrK4wEtQ810lhKG79
	KtsPL1zPV+l++Mtkm2me2UO0MEFmuoF6CvnPlS+D+aolAuNOS9NrQsHwCs08qbVthifnUiRftiU
	3FldmwJg9jOdzy1//2tA3mspyZVrwbc/5SgLLpiPnkylXGVWjdEsqDzo=
X-Google-Smtp-Source: AGHT+IHGtvGz6AGmep+vKMjRISpHC2Vm9oWIgGlZK9OB2UGKVBQ1S7uOKLVoEkE2X/X2jTAAnAYeRNSDDbF0X3bBisqWveyeTco/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b87:b0:82c:eeaa:b1e0 with SMTP id
 ca18e2360f4ac-837947798bbmr482535939f.11.1728705363324; Fri, 11 Oct 2024
 20:56:03 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:56:03 -0700
In-Reply-To: <20241012024727.2538384-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6709f353.050a0220.4cbc0.001c.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING: ODEBUG bug in corrupted (3)
From: syzbot <syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in call_timer_fn

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6517 at kernel/workqueue.c:2257 __queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
Modules linked in:
CPU: 1 UID: 0 PID: 6517 Comm: udevd Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 9f 2d 8b 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 a0 b1 32 00 85 db 75 60 e8 57 af 32 00 90 <0f> 0b 90 e9 f9 f7 ff ff e8 49 af 32 00 90 0f 0b 90 e9 a8 f7 ff ff
RSP: 0018:ffffc900001b8bf0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000100 RCX: ffffffff81233571
RDX: ffff888119dbd7c0 RSI: ffffffff812335c9 RDI: 0000000000000005
RBP: ffff88811a4e3780 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000000 R12: 1ffff92000037190
R13: 0000000000000001 R14: 0000000000000100 R15: ffff888119bd2000
FS:  00007f099cc31c80(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff415ce0a8 CR3: 0000000116684000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1794
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers+0x56a/0x930 kernel/time/timer.c:2419
 __run_timer_base kernel/time/timer.c:2430 [inline]
 __run_timer_base kernel/time/timer.c:2423 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2439
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2449
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1037
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_release+0x3e5/0x6f0 kernel/locking/lockdep.c:5833
Code: 7e 83 f8 01 0f 85 fd 01 00 00 9c 58 f6 c4 02 0f 85 e8 01 00 00 48 f7 04 24 00 02 00 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 c7 43 08 00 00 00 00 48 8b 84 24 88
RSP: 0018:ffffc90001a8f8c0 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff92000351f1a RCX: ffffc90001a8f910
RDX: 1ffff110233b7c49 RSI: ffffffff8727f4c0 RDI: ffffffff8746eac0
RBP: ffffffffffffffff R08: 0000000000000000 R09: fffffbfff14ac839
R10: ffffffff8a5641cf R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888119dbe250 R15: ffff888119dbd7c0
 up_read+0x16/0x20 kernel/locking/rwsem.c:1619
 kernfs_dop_revalidate+0x352/0x5a0 fs/kernfs/dir.c:1178
 d_revalidate fs/namei.c:868 [inline]
 d_revalidate fs/namei.c:865 [inline]
 lookup_fast+0x239/0x540 fs/namei.c:1693
 walk_component+0x5b/0x5b0 fs/namei.c:2049
 link_path_walk.part.0.constprop.0+0x669/0xd40 fs/namei.c:2418
 link_path_walk fs/namei.c:2350 [inline]
 path_openat+0x228/0x2d60 fs/namei.c:3929
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f099cd5c9a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff98e1ac60 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055f5be29ddd0 RCX: 00007f099cd5c9a4
RDX: 0000000000080000 RSI: 00007fff98e1ad78 RDI: 00000000ffffff9c
RBP: 00007fff98e1ad78 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055f5be29dec0 R14: 00007fff98e1ad78 R15: 000055f5902b8a04
 </TASK>
----------------
Code disassembly (best guess):
   0:	7e 83                	jle    0xffffff85
   2:	f8                   	clc
   3:	01 0f                	add    %ecx,(%rdi)
   5:	85 fd                	test   %edi,%ebp
   7:	01 00                	add    %eax,(%rax)
   9:	00 9c 58 f6 c4 02 0f 	add    %bl,0xf02c4f6(%rax,%rbx,2)
  10:	85 e8                	test   %ebp,%eax
  12:	01 00                	add    %eax,(%rax)
  14:	00 48 f7             	add    %cl,-0x9(%rax)
  17:	04 24                	add    $0x24,%al
  19:	00 02                	add    %al,(%rdx)
  1b:	00 00                	add    %al,(%rax)
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 01 c3             	add    %rax,%rbx <-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%rbx)
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	84 24 88             	test   %ah,(%rax,%rcx,4)


Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17246087980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=90f31ac02b7ae5e8b578
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161d3b27980000


