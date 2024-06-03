Return-Path: <linux-kernel+bounces-198921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF08D7F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2329A1C2084C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23591272B4;
	Mon,  3 Jun 2024 09:38:28 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC701272A3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407508; cv=none; b=BwiDkbQfQg63FeeWLxWSKTzfyby/fZj1Xll83uygS0YZkek6EqaQWcG/4Hd0YEO3ZG7l9Nluqe+N4DFnyF4R86HRETaaViKMuEXnCccC6TpuJDsDM+U0lEoMv1TtXRj0jMGW3G/6R3vWOaT6AvQrzmvVog4RS6SxsRmidPC1d/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407508; c=relaxed/simple;
	bh=FH5a017P2qVpioxsh11eGcGx1jA+rzuNZKfmBPzg2oc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sMWY2QZMYiQsHHBI/lGO750Z1R5/SII9GgUljpz1V8aYDI6/DKyy41eJv+5kBy3tdt7HFcD+SCqC9xG7abF0LVZf3Je9A0bOFDdETU1u/9q63xKd34SXWe/TwNBUhzXlzSVCEZ4DqgrDTTfsgaPziJr3JVsuXZ+3aLpm0othuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3738719bad7so30422025ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407505; x=1718012305;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=db3NZCVls8kX73CocGnnaS/eFep2J+CfQmn9E4PMMeU=;
        b=DsFg7jVajxtAuZj/CqoS8yOKTGwEb6B+Xhwk83k8Gul1tLh0v/uXW5IlNZCz/DzrsI
         NydLznHbKmUaIeW5LPuoKzY1zuowEafNZgXS4EZcqA2eKUVyHdPAmO+BMlspswShlT7r
         A9Cy9iHd+Vd10BeUOpR5uZLOXVgmlBYEr0tOG5mBoExI2BCe4Mjy9pGregJZe4F1G0q+
         uUyctvsrKewCe0ULtTkuB0TSbiRZRoDYxtSjgoDuCpmqJ1C2HY7MUo9hWQb1lb7ziItO
         jStvBPLvZCIczivvH2x2hOpYafBeSQR9JUKx4vN9El4smZeeNn5kwb4do0bAO6oFSH5G
         6lEA==
X-Forwarded-Encrypted: i=1; AJvYcCUO7yAhR5E7qjrIjyOpiK2hyzHKrxLzUTRq4to/B3T0sgQXN6EFnzFM5ajMBl9Sii4UXMdNYBpDxwFlXmIUy5dOd6dJjapC+8LFAC4y
X-Gm-Message-State: AOJu0YxN55WfIIGOtV9mlAertFlDH/2Hpp4+3aCUoYaqA2YwLBXm4RUj
	OXJwIyeCT9BKbYhdbrgPP1Cy9NbiQ+jkq6TBB3lT+EqEHS54x1nYoK9hVHB39IuOTjM1lEqPINL
	M3higxsIaL2EnQ7uwp60ze3x9w1xHY8nERmUP5caib54oJok0XXDgFt4=
X-Google-Smtp-Source: AGHT+IExFwt0zoxXQx4GA2ppoop1WG9eivgFOPfjM5Gfph/WjzF5xDjUSUxD6Wdle+En70z3W/z/DdgYAiUM4bNl3ebNUrIRLrc8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a62:b0:374:5a8c:c011 with SMTP id
 e9e14a558f8ab-3748ba1358emr6645965ab.4.1717407505608; Mon, 03 Jun 2024
 02:38:25 -0700 (PDT)
Date: Mon, 03 Jun 2024 02:38:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e7f980619f91835@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_put_transaction (2)
From: syzbot <syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150a5f72980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=0fecc032fa134afd49df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9bbdc63efe9/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed08b308e5d6/bzImage-4a4be1ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com

BTRFS warning (device loop2 state EA): Skipping commit of aborted transaction.
BTRFS: error (device loop2 state EA) in cleanup_transaction:1999: errno=-5 IO failure
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5237 at fs/btrfs/transaction.c:146 btrfs_put_transaction+0x3d5/0x4d0 fs/btrfs/transaction.c:146
Modules linked in:
CPU: 1 PID: 5237 Comm: syz-executor.2 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:btrfs_put_transaction+0x3d5/0x4d0 fs/btrfs/transaction.c:146
Code: fe 90 0f 0b 90 e9 b4 fc ff ff 4c 89 e7 e8 43 3e 5f fe e9 93 fc ff ff 48 89 df e8 66 3e 5f fe e9 2a fd ff ff e8 bc 0b 02 fe 90 <0f> 0b 90 e9 97 fd ff ff e8 ae 0b 02 fe 90 0f 0b 90 e9 49 ff ff ff
RSP: 0018:ffffc90002d7fb38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802b0af028 RCX: ffffffff838c7071
RDX: ffff888019844880 RSI: ffffffff838c73b4 RDI: ffff88802b0af320
RBP: ffff88802b0af000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802b0af010
R13: ffff888000e94bf8 R14: ffff888000e94520 R15: ffff888000e94cc8
FS:  0000000000000000(0000) GS:ffff88802c100000(0063) knlGS:000000005816a400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000005816b000 CR3: 0000000043444000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cleanup_transaction fs/btrfs/transaction.c:2047 [inline]
 btrfs_commit_transaction+0xdf4/0x3b40 fs/btrfs/transaction.c:2582
 btrfs_sync_fs+0x13b/0x7c0 fs/btrfs/super.c:1014
 sync_filesystem+0x1cc/0x290 fs/sync.c:66
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:621
 kill_anon_super+0x3a/0x60 fs/super.c:1226
 btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf729a579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff98d248 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff98d2f0 RCX: 0000000000000009
RDX: 00000000f73f0ff4 RSI: 00000000f7341361 RDI: 00000000ff98e394
RBP: 00000000ff98d2f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
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

