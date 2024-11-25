Return-Path: <linux-kernel+bounces-421019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FC89D8677
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF120B28B47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868101A7060;
	Mon, 25 Nov 2024 12:54:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77119F475
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539263; cv=none; b=PLMeBovHzk0YiqYanlRs3fZxPCQkpPSHR0EXPYpBtJDh7o9YM6DLMKSHbt69jZaQ1m1UtWnNzPQCPLCQc8rIZbTgfh2KVEBkzY6iGPMRGpflT+EjGhW6uxNPuUgxfjm+TGBHlEQA08LGFRekkURv94VFZafY5bQKhcEYOGJlcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539263; c=relaxed/simple;
	bh=Zfu+M2soj0eRt7qwnTvAaxlshzzixxJ27NNrtx8XKi4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bw0uRk9nwivdjWD6HX4e6KP1in8eX5/gCC8NufoPUBOT0ERnETBNl61+Zp8OZPDmEODowT4iV6a5/HZ3gpGAKF9l+aOIid/92+4QtQwYgJ7X5uH1c9eR1ZXP0uSYLY64gUWn6EwF1tGX+4k4LrTs2WzudZ/mEgeBN+vIE9gopCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-84181aad98aso156064039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539259; x=1733144059;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTOSBgDWeg+euICH9qGrAyGFT0qAPpHeyv7sBqgLfsM=;
        b=Mk/fEFWU/U+mszjUNY2NdSZ2f4FN4dsmYyjFUNyQSUulK+FYHYbwzmMmmxBbpj3C6o
         rG5GbpMGwQWfaheojjH0Prsoeof81Bxe5mD8/0XDLXXp5X2GILLK2vRc2VJYrQljARu0
         yJ1Wxa+CsWUoknLiQFtD4aiMGrTUQgHFFvrRBmfTaTFFF7LeHK9MtigfaUMgPctx8XSR
         AmdxlM/y6SMmLku76lTF+wm4UBFW/u6xlA75x5+niwgATUAS//mmOZEKcxFSXg93OFbV
         ZeptPW+LV4TTFQS1/UUCYYuTrYK0Purvbh53qg68Cdzcr2pWPuBx9pBkZ4TQ7MFsD47P
         PEdA==
X-Gm-Message-State: AOJu0Yxfa1J33y6pcDIXId5pNx7aWALNLEM+Su6xl8Ta0uBfMu25KvHF
	35wzVgqyFfuokyxJlggdbm4L7N0Xo4jmbtPBee6oeWh1N6p/07DCEDioqIakWm0ytJPX9TI+ptb
	EeTzg0ZhyiH71YjzcCmsJ2QIuwuNWYAv0jOUzddiiOgs1bampZavOVzc=
X-Google-Smtp-Source: AGHT+IFUYJcRzPEFzVBqTbOYrFz/H/VP499IrKfYBNVykhHW/8LfqdJNg6yrakmIza5rc1XCTL2icqBH3mlznM5LyRHaCOO9UrEf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3421:b0:3a7:ab43:24aa with SMTP id
 e9e14a558f8ab-3a7ab43256bmr64855455ab.7.1732539259799; Mon, 25 Nov 2024
 04:54:19 -0800 (PST)
Date: Mon, 25 Nov 2024 04:54:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6744737b.050a0220.1cc393.007e.GAE@google.com>
Subject: [syzbot] [sound?] BUG: sleeping function called from invalid context
 in vfree
From: syzbot <syzbot+351f8764833934c68836@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154bc778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47cc5fc1922531f
dashboard link: https://syzkaller.appspot.com/bug?extid=351f8764833934c68836
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dddd5525a287/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c9e082ba50b/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+351f8764833934c68836@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/vmalloc.c:3359
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6938, name: syz.1.230
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz.1.230/6938:
 #0: ffff88804a2d2968 (&rmidi->open_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
 #0: ffff88804a2d2968 (&rmidi->open_mutex){+.+.}-{4:4}, at: snd_rawmidi_output_params+0x51/0x1c0 sound/core/rawmidi.c:748
 #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: class_spinlock_irq_constructor include/linux/spinlock.h:565 [inline]
 #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: resize_runtime_buffer+0x243/0x530 sound/core/rawmidi.c:727
irq event stamp: 1218
hardirqs last  enabled at (1217): [<ffffffff8b189e32>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1217): [<ffffffff8b189e32>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
hardirqs last disabled at (1218): [<ffffffff8b189ad5>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (1218): [<ffffffff8b189ad5>] _raw_spin_lock_irq+0x45/0x50 kernel/locking/spinlock.c:170
softirqs last  enabled at (0): [<ffffffff814e57ac>] copy_process+0x1e9c/0x6f20 kernel/fork.c:2321
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 6938 Comm: syz.1.230 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8758
 vfree+0x75/0x890 mm/vmalloc.c:3359
 kvfree+0x33/0x50 mm/util.c:699
 resize_runtime_buffer+0x3a7/0x530 sound/core/rawmidi.c:736
 snd_rawmidi_output_params+0xeb/0x1c0 sound/core/rawmidi.c:751
 snd_rawmidi_ioctl_params_compat sound/core/rawmidi_compat.c:37 [inline]
 snd_rawmidi_ioctl_compat+0x3ac/0x3e0 sound/core/rawmidi_compat.c:120
 __do_compat_sys_ioctl+0x1cb/0x2c0 fs/ioctl.c:1004
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f01579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f506555c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00000000c0205710
RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

