Return-Path: <linux-kernel+bounces-373140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503BC9A52EE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8681C2147C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3C1A269;
	Sun, 20 Oct 2024 06:45:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8DFBF6
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729406728; cv=none; b=LoFgMkAFRZuslN793VEzrClggZ/r/BgmzgNtlymwxStiZJURw27aqunl3FAG/PjIyi54UO3THYcOYDYiFChsQkwIrldiL5jyrkWZocLi/DHZlZzlyBldBof541MMVHZ/ObWHZTNRZvxjq2njquz1DkwDnpWuixL8Dziq1iSCKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729406728; c=relaxed/simple;
	bh=aNWzB6IOj0MBINu6/wEFKuO6BveptNVD8H/1L25NDfM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OvlNBx23HgsY5jlH6RfsEzekqRG/VckU00dxEFJlqnC/ih42/xQpY1ofaIl1gOg3LvReXxjRj5YrCZ58Cy7qIU5X5JO6Fw9Np8nonQYWQEusG93f/21L8P8oOFPqedvhek+077vMrFxnDvurO467ylNfoVB7L1RZJfmW2+NbRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ac3fe1cf4so112718739f.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 23:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729406725; x=1730011525;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cXuAih9iXg2aI5LiI0A+t7QUSULHFv/pwLY1KXI/r8=;
        b=Fb3cSxjeZEL23teiQeR8YXhvfDQHcjk/RCVOWTSHPV+MCH2zJZlIFbZkf4L/zaq/6j
         iDwt1T7SraHRCQdapRO89tiVZqfnzvtB8Ipmo68G8yxZLkDnR5z0u7WYPTkmuR/sFBLM
         JU5UN1ehPw314+z2PSwHErFWHlLAWle36mmF3neeGC8aVCNqTEm7hs9LizRyAN/JZ1+q
         XbsDHZWoUm2Kh/QaNPmvT0y0ULVfraZw5auS8ZJUWv7AzDPrGx9WT8wxiuXStL0ScnwK
         ELMEnv+j/bmJEOnegQe6SzJ5ld233ESLyXXo0qIU59xpKbebtarvYquaWkfj8rFB8Hu7
         qi1g==
X-Forwarded-Encrypted: i=1; AJvYcCXyfvAw8NtTJbNEJSNK9fey+Rw97V2X72lWRqIcaxki5BDoTyja6QwKxIRxzlOIBIdKtRP2Ora+PdVuRYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlncng16u/C+EQ6hsj2xOFjvwa3/0ErAyMTXBPMEjsEVTjP+4
	9HT//5WiHaLdrLLbQfGzx/CE2o0oNwE90faU8jqpiWIlbHkV4wxXji5Daxp3hPs3Rhl0qfEh2G5
	3TkXu9/ELo/HM88C5vIip1I2wD5eiOWLcJuCoDwV0uTufHin11hQA3Bc=
X-Google-Smtp-Source: AGHT+IHTEZi+Vyaqn/YxC4vkDlDlsoQ4TxcKX699DQP6aAUL2ZN6Zn9CNKsUAT3SoZgS92sl//tx8VvNuJ1V1INmzk0yAEFeAenI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:3a3:b497:f951 with SMTP id
 e9e14a558f8ab-3a3f40b58d4mr61262995ab.23.1729406725470; Sat, 19 Oct 2024
 23:45:25 -0700 (PDT)
Date: Sat, 19 Oct 2024 23:45:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714a705.050a0220.1e4b4d.0035.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in put_pwq_unlocked (2)
From: syzbot <syzbot+aa930d41d2f32904c5da@syzkaller.appspotmail.com>
To: cem@kernel.org, clm@fb.com, djwong@kernel.org, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9e4825524aa Merge tag 'input-for-v6.12-rc3' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129220a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78db40d8379956d9
dashboard link: https://syzkaller.appspot.com/bug?extid=aa930d41d2f32904c5da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c73069e3297a/disk-f9e48255.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efe8e01d8c7c/vmlinux-f9e48255.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35d48123aca0/bzImage-f9e48255.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa930d41d2f32904c5da@syzkaller.appspotmail.com

XFS (loop2): Unmounting Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
Oops: general protection fault, probably for non-canonical address 0xe01ffbf110170e7f: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x00ffff8880b873f8-0x00ffff8880b873ff]
CPU: 1 UID: 0 PID: 5226 Comm: syz-executor Not tainted 6.12.0-rc3-syzkaller-00403-gf9e4825524aa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__lock_acquire+0x69/0x2050 kernel/locking/lockdep.c:5065
Code: b6 04 30 84 c0 0f 85 9b 16 00 00 45 31 f6 83 3d f8 a7 ab 0e 00 0f 84 b6 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 b9 2b 8b 00 48 be 00 00 00 00 00 fc
RSP: 0000:ffffc90004247970 EFLAGS: 00010002
RAX: 001ffff110170e7f RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 00ffff8880b873f9
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff2037a4e R12: ffff8880617c0000
R13: 0000000000000001 R14: 0000000000000000 R15: 00ffff8880b873f9
FS:  00005555724f4500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe0c1d37a8c CR3: 0000000061f58000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
 put_pwq_unlocked+0x42/0x190 kernel/workqueue.c:1662
 destroy_workqueue+0x99d/0xc40 kernel/workqueue.c:5883
 xfs_destroy_mount_workqueues+0xd3/0x100 fs/xfs/xfs_super.c:605
 xfs_fs_put_super+0x13a/0x150 fs/xfs/xfs_super.c:1152
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1696
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa6f997f327
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff96927f68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fa6f997f327
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff96928020
RBP: 00007fff96928020 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff969290a0
R13: 00007fa6f99f0134 R14: 0000000000026639 R15: 00007fff969290e0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x69/0x2050 kernel/locking/lockdep.c:5065
Code: b6 04 30 84 c0 0f 85 9b 16 00 00 45 31 f6 83 3d f8 a7 ab 0e 00 0f 84 b6 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 b9 2b 8b 00 48 be 00 00 00 00 00 fc
RSP: 0000:ffffc90004247970 EFLAGS: 00010002
RAX: 001ffff110170e7f RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 00ffff8880b873f9
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff2037a4e R12: ffff8880617c0000
R13: 0000000000000001 R14: 0000000000000000 R15: 00ffff8880b873f9
FS:  00005555724f4500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe0c1d37a8c CR3: 0000000061f58000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 9b 16 	xor    %al,0x169b850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d f8 a7 ab 0e 00 	cmpl   $0x0,0xeaba7f8(%rip)        # 0xeaba80d
  15:	0f 84 b6 13 00 00    	je     0x13d1
  1b:	89 54 24 54          	mov    %edx,0x54(%rsp)
  1f:	89 5c 24 68          	mov    %ebx,0x68(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 b9 2b 8b 00       	call   0x8b2bf1
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


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

