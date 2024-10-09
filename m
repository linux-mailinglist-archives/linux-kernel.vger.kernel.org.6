Return-Path: <linux-kernel+bounces-356225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D49995E32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A639B232CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC50315383B;
	Wed,  9 Oct 2024 03:33:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222027466
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444806; cv=none; b=ANIpAvjBViGKK1x20m7hHMsujOwbtlBWgbjC2L5YFz/j2CMLcrZE2KcROfSsKchbuTsuVzxjBXi9jFwe/BLksXF1J+hrEv1clU2qVA3hIDB5ew/bO6V12ut3igN5lHtI/24KBBtCKI0iHLPu5xhT3lkOsrXaKa9QTX4jrh20JFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444806; c=relaxed/simple;
	bh=8n+Zq0BrkhcXRVhugLHIsRfmxbshrBD1U0UzwsBJJTY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o5KbTAEfToWprI0hMi9fhtiQ9oMxmoSEHvVa6OTUzyFh4m2vyVoVgheWkymH1xaINROEQSg62bI/JUvvbxZhaPIzCy5Fb3tVZF46QE4aRd7vMsC66oS8VVQraC+Z7rI61Yfrtmmt4TXkpVK/eWmIeQ19N6SYSuL2GzWUPE54tdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342e872a7so66479405ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 20:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728444804; x=1729049604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUVpWtCeL3WpJqdDa6ZWXTpkHfSKc8VXb2l+w4bGeYE=;
        b=avYEhjZ2wJQF1gntNQrDPyv2/6CalxF0jEF3y4Q/d67BYWp1WpZFT6+pNjoM9Wtrf2
         8H35TPD5Ri/ZQzxTjVRxfG+bWfyJvWrF7dfIgY3i/HQ6rDd8vbwdg9wX0NE7W4RyMk/O
         X9OjeJseKyxa0x2WWFgFADOd21JxuNugMWspblJyCpMZm/SFqTOrR2trV9R5hPx2dNjZ
         i9fItVFhpWBAJE8+ozNrvRhIbGgJxi/5dl/oCkPWfZrShVEse/eAXIVQJLBX82weBO8L
         kK+fxQL4/yceFfj3DpSv/jPO9HyuaU8BtakSsGzDupYOanfUkbS1n+mW7RA+x68WOf2M
         kJdw==
X-Forwarded-Encrypted: i=1; AJvYcCVgqY0/pCIPjao8mJjLpNqG0lJCKdRP1owIKFmouoauwkK99zGyRTaoeT7dbLya7Xzn1J4OlK/OzGA6sVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVqfYLp149FjiJGpA8Jnpu8IgE0BU/D+aD1z902MUwqz4Z5izT
	dOLnZ+2dpCCu44Is0nIrHaaveJjWE2vq9Scgo6E+XxmJvumPH1d1WpDS28zP7eSxwSQyH1Yyy31
	Ew6QsRqOd61E3aqM8tzNU3WqKFMhk86U+27ERpYIWAOl3ISj4HeqJupE=
X-Google-Smtp-Source: AGHT+IEn1izM0MJrzkz028/riHOmMQ6DJYs4byowolN/stRdhuiTFzEsT8Ahoxze9rxNhcaRi+rzQFaLWNmVc49APPuI192Gwm+O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:3a0:9aef:4c2 with SMTP id
 e9e14a558f8ab-3a397d0fd25mr10381875ab.19.1728444803962; Tue, 08 Oct 2024
 20:33:23 -0700 (PDT)
Date: Tue, 08 Oct 2024 20:33:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6705f983.050a0220.22840d.000d.GAE@google.com>
Subject: [syzbot] [usb?] possible deadlock in chaoskey_release
From: syzbot <syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, keithp@keithp.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14b53bd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=685e14d04fe35692d3bc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1029d380580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158cd307980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883c5319cb52/disk-4a9fe2a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4421ed2ef/vmlinux-4a9fe2a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8e3beb01d49/bzImage-4a9fe2a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com

raw-gadget.0 gadget.0: fail, usb_ep_enable returned -22
============================================
WARNING: possible recursive locking detected
6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0 Not tainted
--------------------------------------------
syz-executor363/2651 is trying to acquire lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x15d/0x2c0 drivers/usb/misc/chaoskey.c:322

but task is already holding lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x7f/0x2c0 drivers/usb/misc/chaoskey.c:299

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(chaoskey_list_lock);
  lock(chaoskey_list_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz-executor363/2651:
 #0: ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x7f/0x2c0 drivers/usb/misc/chaoskey.c:299

stack backtrace:
CPU: 0 UID: 0 PID: 2651 Comm: syz-executor363 Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x2e3/0x410 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain kernel/locking/lockdep.c:3891 [inline]
 __lock_acquire+0x2185/0x3ce0 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 chaoskey_release+0x15d/0x2c0 drivers/usb/misc/chaoskey.c:322
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xadd/0x2ce0 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd87e4bb409
Code: Unable to access opcode bytes at 0x7fd87e4bb3df.
RSP: 002b:00007ffcb70ccdd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd87e4bb409
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fd87e536370 R08: ffffffffffffffb8 R09: 00007ffcb70ccb47
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd87e536370
R13: 0000000000000000 R14: 00007fd87e53a080 R15: 00007fd87e489670
 </TASK>


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

