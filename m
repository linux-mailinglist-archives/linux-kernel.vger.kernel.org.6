Return-Path: <linux-kernel+bounces-441506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86B9ECF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99EE162236
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585FE19F131;
	Wed, 11 Dec 2024 15:06:30 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F6246343
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929589; cv=none; b=qlBxstAzgvoT97sV+B2atJIy5x5Ew0DJW/Xl1CogfbGES6x44JZV1rrrgzpsBhySS34f5/wLnSwjVeKjAQ30YniSRd4qzxJYS4DtrJ45vxDHFr16Tiss4JzwylxavKdhfekrmuDF/wkvSZm4mOtezWDQd8AAF17G5wJSP+ghUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929589; c=relaxed/simple;
	bh=pncKTIeYr4Q8ShUECE+7ZALH25WYRUTW1403lObzUPY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=thN7btfKGNEoRF3kwtMBeu9B3HM5LtQ8qxyhTuBHD5Hnbk9sIULS3fizH17OsxP0jFK4cEPGoVTLdlK0mg0yLCnJu1RDwoBCCkuTzmVTQzSm7uGCxnLWz/JHdextPxYTEcjnBDPFcsn9L/WG6szgePosOaD0p6kxWkN/UukpvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844d02766f9so53830539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929587; x=1734534387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QP2cxWOT9S/oMb46MDN8uw1TEKjbXaaY6apHKLB3dM8=;
        b=CGAJQcMHv/txVkMfJ/jAEYrDamlr1o3xARcES/1U39iD85iGBIKmqAmpqxiehKAm60
         8IV19iyo8rV5NUvHF8xLz/1K12xnsvvrFmO1GoPgob+5AnI1z8tehypIAH0EogbMTlHO
         4yg+iiBWwm/DroBf05zrhTMFECL10qfj5nPzjmLZra7a8Qb4BgK5G2AfAbGo5UemH0WL
         iYIeeszSURPSOMaTjlzRBKN92v6IdlIgqCBo5P8YAbdPIaNavAGUrsaClQcTNBoP/7zu
         hxCG5rEFSlQTBBUdVsamGG5F8X4CpEer6ZVuBUkVar8vp1dyl9hNn2UrC6N9MHrGKDhl
         afUA==
X-Forwarded-Encrypted: i=1; AJvYcCXezWBgqwMChVLjv9/Ba7w9A2BuUQPJ4G3RWHVP0gFhI8yjWNnyFMSSQ1IIm9RBMYtyJPaFczueS4d9lrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpScER6yEAL7RMbnGz3v9GpqVAXIXmwt6yQaZKjBlZ3FxQ1dEK
	egGoRzf3FSE4hH7KZ3NnRixusmFB9NfB8Ig7aG4wiY3GPbNiV01MsimXKn3sACEG+y9Yg3ml560
	vtXPzJTVZJQJdAYb+MJzF3U0BSnSym/+Pf9XqbBRvTA/1pg0Y2gmgQyE=
X-Google-Smtp-Source: AGHT+IHQx9o7FYLJ70LcgRoNSo1jOVIQecUvreXkPqsBXJGzVazEw88U+ut63gH2pDB4cftJmCjyL/47tB4fbCnr6rd+H412tUiG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:3a7:1dcb:d44b with SMTP id
 e9e14a558f8ab-3aa06bee070mr29958785ab.11.1733929587185; Wed, 11 Dec 2024
 07:06:27 -0800 (PST)
Date: Wed, 11 Dec 2024 07:06:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759aa73.050a0220.17f54a.003d.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in l2cap_conn_del
From: syzbot <syzbot+f0e2ed7be2c4537cceb7@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5f217084ab3 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112e0820580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d99f0bff41614d0
dashboard link: https://syzkaller.appspot.com/bug?extid=f0e2ed7be2c4537cceb7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b5f21708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a2037d50b27/vmlinux-b5f21708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9e9c9c88191/bzImage-b5f21708.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0e2ed7be2c4537cceb7@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000020: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
CPU: 1 UID: 0 PID: 7416 Comm: syz-executor Not tainted 6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:l2cap_conn_del+0x3dd/0x730 net/bluetooth/l2cap_core.c:1781
Code: 8b 40 20 48 89 df ff d0 0f 1f 00 4c 89 f7 e8 ca 2f fb 00 4d 8d b4 24 80 04 00 00 48 89 df e8 8a 42 ff ff 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 0f 85 24 02 00 00 49 8b 84 24 80 04 00 00 4c 89 e3
RSP: 0018:ffffc9000371fad8 EFLAGS: 00010a02
RAX: 1bd5a00000000020 RBX: ffff88804aaa6000 RCX: ffffffff8a2f4f3e
RDX: ffff888020602440 RSI: ffffffff8a300c56 RDI: 0000000000000005
RBP: ffff8880341df800 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000000 R12: deacfffffffffc80
R13: dffffc0000000000 R14: dead000000000100 R15: 0000000000000067
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcd90480a0 CR3: 000000000df7e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 l2cap_disconn_cfm net/bluetooth/l2cap_core.c:7299 [inline]
 l2cap_disconn_cfm+0x96/0xd0 net/bluetooth/l2cap_core.c:7292
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2050 [inline]
 hci_conn_hash_flush+0x10b/0x260 net/bluetooth/hci_conn.c:2698
 hci_dev_close_sync+0x603/0x11a0 net/bluetooth/hci_sync.c:5212
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:483
 hci_unregister_dev+0x213/0x620 net/bluetooth/hci_core.c:2698
 vhci_release+0x79/0xf0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
 x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ad877fed9
Code: Unable to access opcode bytes at 0x7f5ad877feaf.
RSP: 002b:00007ffcd904a1b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5ad877fed9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007f5ad87e0840 R08: 00007ffcd9047f57 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000003 R14: 00000000ffffffff R15: 00007ffcd904a360
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:l2cap_conn_del+0x3dd/0x730 net/bluetooth/l2cap_core.c:1781
Code: 8b 40 20 48 89 df ff d0 0f 1f 00 4c 89 f7 e8 ca 2f fb 00 4d 8d b4 24 80 04 00 00 48 89 df e8 8a 42 ff ff 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 0f 85 24 02 00 00 49 8b 84 24 80 04 00 00 4c 89 e3
RSP: 0018:ffffc9000371fad8 EFLAGS: 00010a02
RAX: 1bd5a00000000020 RBX: ffff88804aaa6000 RCX: ffffffff8a2f4f3e
RDX: ffff888020602440 RSI: ffffffff8a300c56 RDI: 0000000000000005
RBP: ffff8880341df800 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000000 R12: deacfffffffffc80
R13: dffffc0000000000 R14: dead000000000100 R15: 0000000000000067
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb5df3d4fb8 CR3: 00000000506a0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 40 20             	mov    0x20(%rax),%eax
   3:	48 89 df             	mov    %rbx,%rdi
   6:	ff d0                	call   *%rax
   8:	0f 1f 00             	nopl   (%rax)
   b:	4c 89 f7             	mov    %r14,%rdi
   e:	e8 ca 2f fb 00       	call   0xfb2fdd
  13:	4d 8d b4 24 80 04 00 	lea    0x480(%r12),%r14
  1a:	00
  1b:	48 89 df             	mov    %rbx,%rdi
  1e:	e8 8a 42 ff ff       	call   0xffff42ad
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	0f 85 24 02 00 00    	jne    0x259
  35:	49 8b 84 24 80 04 00 	mov    0x480(%r12),%rax
  3c:	00
  3d:	4c 89 e3             	mov    %r12,%rbx


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

