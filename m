Return-Path: <linux-kernel+bounces-207376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF090164B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C861C20ACB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE5144393;
	Sun,  9 Jun 2024 13:56:29 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416833FB8B
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717941388; cv=none; b=BpmWLE8hiJeOeOBMRtE72TU7KG/JFAFonHMnaWBo8sjs7DZXA3CFXTnGuo+KA9Ju77xfCE+VW8ozz8r/8Zqt8Ybhez0fPiH813NHIFLRE2ibRrMiyfNF3iTWCuyEFBHZelc3HLk3qAG9wXYlL9nf6xQgeSHl2hUXO06fPXDPYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717941388; c=relaxed/simple;
	bh=ctgGFK0f83OshrGzxHN9PDYqPrKX7kRjkvE2eCUdg1g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H+/i2hWRPMvvuaFQhizUUOelx8SRVLMUmmbY+L0jXsLoKgi9vZKPQEb88h1bXG48ndl0TpDpsay6qfmzDIcVMJDaUcwJE7q+Cqme1aWHZ/SGU6kDTPLwJ/aJhtTOODKkw22n+VQLSI/lO9wGrrorksLG8QpTNCHgVKhq76nnCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb7e13522bso59310239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 06:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717941386; x=1718546186;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4xB2sVEkGbk0dXhq9RX5GlImfc1l66UOyNLhJBnq70=;
        b=JjZXJTFZ5xFSRMrp4s7gqhmMS7HkeMxLJFauoN8Vz30v0LgVyTawTMcqxI4Y5X5iCA
         wXg/DttINeJe6iSCJecBdsMHaA0TSadRhkq2YcvdaenrVrqXe1PjOCBrVuNkYMDzwb0w
         klF3OUyrCR4o2KwTfSlLC41xy+27tLsoa5A8ZQ+VwbQpasIQtIhnrL/n4QEZqPGt9zPx
         NfBpEOZGiRTdiWaoTpYFqplWJHEz7jlBxrjW9JE9FpBMK46QZDRb//KlGA+xm8UbF/y0
         OfFYC5GGGW8gwRIBc8VhBbSP1l00iBsv+LmWWFtZJcHoRmSkSdNZRCxk+oRqPyCl3s78
         2L+g==
X-Forwarded-Encrypted: i=1; AJvYcCXTcphrm6bL8Pl1bgGJXHECanJr24LsfXTlJmew6BtZHh2vkdu53072vn4zZi0H97itPLZlbnwJjVfQygBz+efE3/u6Vp4ODxagibQt
X-Gm-Message-State: AOJu0YwQqg412Q3FxlN+5IdKm0o+3F0BTR42E9gfSsEmJGCs22RYqKj/
	0BkSxT21SdiLb68U3j6HX7jbFqlsN3AVv5ZbvijoMHvO5jT9bTXnk6fR37xD+nKQSNM4hbRRdGa
	r6XOC0dNiIOFBzTbGkeqZgxt+5kQmIVougb5SZZQDZBVoD6CVAoNw0Bw=
X-Google-Smtp-Source: AGHT+IFxWD5oU6rI6aMJkkfqVBPKoanXVPfnsPx/cqSntI23J2zY2w6lXMv5/dAYm0jlFXnDmHbqW/D5wETUGSYLbpGxhXtt0uqG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8608:b0:4b7:ba1f:5449 with SMTP id
 8926c6da1cb9f-4b7ba1f5689mr414887173.4.1717941386345; Sun, 09 Jun 2024
 06:56:26 -0700 (PDT)
Date: Sun, 09 Jun 2024 06:56:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000141201061a75665a@google.com>
Subject: [syzbot] [usb?] WARNING in kcov_remote_start (4)
From: syzbot <syzbot+7110e6a4069f19537d85@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    771ed66105de Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c06364980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=7110e6a4069f19537d85
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9ca3dd648520/disk-771ed661.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54c60e26a55f/vmlinux-771ed661.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8ec7b1012cf/bzImage-771ed661.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7110e6a4069f19537d85@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 24 at kernel/kcov.c:870 kcov_remote_start+0x5a2/0x7e0 kernel/kcov.c:870
Modules linked in:
CPU: 1 PID: 24 Comm: ksoftirqd/1 Not tainted 6.10.0-rc2-syzkaller-00366-g771ed66105de #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:kcov_remote_start+0x5a2/0x7e0 kernel/kcov.c:870
Code: 24 00 00 00 00 9c 8f 04 24 f7 04 24 00 02 00 00 0f 85 a6 01 00 00 41 f7 c6 00 02 00 00 0f 84 93 fa ff ff fb e9 8d fa ff ff 90 <0f> 0b 90 e8 86 6f f0 09 89 c0 48 c7 c7 c8 d4 02 00 48 03 3c c5 e0
RSP: 0018:ffffc90000a189c0 EFLAGS: 00010002
RAX: 0000000080010100 RBX: ffff888017af0000 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: ffffffff8bcacd00 RDI: ffffffff8c1ff280
RBP: 0100000000000003 R08: ffffffff92fab5f7 R09: 1ffffffff25f56be
R10: dffffc0000000000 R11: fffffbfff25f56bf R12: ffffffff819630ae
R13: 00000000ffffffb9 R14: 0000000000000006 R15: ffff8880b952d4c8
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33527000 CR3: 00000000674b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 kcov_remote_start_usb include/linux/kcov.h:53 [inline]
 kcov_remote_start_usb_softirq include/linux/kcov.h:66 [inline]
 __usb_hcd_giveback_urb+0x34a/0x530 drivers/usb/core/hcd.c:1647
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:kcov_remote_start+0x2e/0x7e0 kernel/kcov.c:924
Code: 55 41 57 41 56 41 55 41 54 53 48 83 ec 18 65 48 8b 1c 25 00 d5 03 00 48 b8 00 00 00 00 ff ff ff 00 48 85 c7 74 17 90 0f 0b 90 <48> 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 89 fd
RSP: 0018:ffffc900001e7840 EFLAGS: 00000206
RAX: 5308892166c1b700 RBX: ffff888017af0000 RCX: ffffffff8172d80a
RDX: dffffc0000000000 RSI: ffffffff8bcabb80 RDI: ffffffff8c1ff280
RBP: ffff8880b952d4c8 R08: ffffffff92fab5f7 R09: 1ffffffff25f56be
R10: dffffc0000000000 R11: fffffbfff25f56bf R12: 0000000000040000
R13: 0000000000000000 R14: 0000000000000206 R15: ffff88801c71e700
 kcov_remote_start_usb include/linux/kcov.h:53 [inline]
 kcov_remote_start_usb_softirq include/linux/kcov.h:66 [inline]
 __usb_hcd_giveback_urb+0x34a/0x530 drivers/usb/core/hcd.c:1647
 usb_giveback_urb_bh+0x306/0x4e0 drivers/usb/core/hcd.c:1682
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 bh_worker+0x2a5/0x620 kernel/workqueue.c:3572
 tasklet_hi_action+0xf/0x90 kernel/softirq.c:816
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	55                   	push   %rbp
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	41 55                	push   %r13
   7:	41 54                	push   %r12
   9:	53                   	push   %rbx
   a:	48 83 ec 18          	sub    $0x18,%rsp
   e:	65 48 8b 1c 25 00 d5 	mov    %gs:0x3d500,%rbx
  15:	03 00
  17:	48 b8 00 00 00 00 ff 	movabs $0xffffff00000000,%rax
  1e:	ff ff 00
  21:	48 85 c7             	test   %rax,%rdi
  24:	74 17                	je     0x3d
  26:	90                   	nop
  27:	0f 0b                	ud2
  29:	90                   	nop
* 2a:	48 83 c4 18          	add    $0x18,%rsp <-- trapping instruction
  2e:	5b                   	pop    %rbx
  2f:	41 5c                	pop    %r12
  31:	41 5d                	pop    %r13
  33:	41 5e                	pop    %r14
  35:	41 5f                	pop    %r15
  37:	5d                   	pop    %rbp
  38:	c3                   	ret
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	cc                   	int3
  3c:	cc                   	int3
  3d:	48 89 fd             	mov    %rdi,%rbp


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

