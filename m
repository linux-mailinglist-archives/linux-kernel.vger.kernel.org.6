Return-Path: <linux-kernel+bounces-218301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D60590BC41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B7A283CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8CF197A62;
	Mon, 17 Jun 2024 20:36:25 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DF16B386
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656585; cv=none; b=E28F229fOrYL+cxn0pz0uUbbCFmuNU1PmcpB2tJw87K7DwNBXvX4OxxkQbNMQxrUfpJO7qVpJ3bK7C2o6MxOy/VIBl7cKscy383IPBolWrK/FZgUnBz9GZDcVRQ1/R3iYt+nEzIaTIbmIv7m1IiltH0QjS2aqu0uroYA4e4MZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656585; c=relaxed/simple;
	bh=8kX08lsI6DAbj5XPvQSGYHXhD+DjTeYX6hUFBZtIc8U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qc73gxv6fzxBWuDzJoZWjW9VlRMiV7zJ8Aw53M4gEycJlPuu95j6IBrZaYCyb4pE9jPsE+cwtlmaZa19N2isEwiOZdJipKC2NDbiaGqgK/6cEA2MYWaQo8LENjbypoPupskkeWXURgRbUPI4S+vp0/hvfAS1oc9fdC92yumJdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-37492fe22cdso41651865ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656583; x=1719261383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wX1r7CLXDYCEQWJyieHWqqtaA+523qbeQjBU002Sr4w=;
        b=xGfpGJNXpwmeTvRRJ/JmlaVfKV8ij9zVCfoiy3n4Cn8GaFraDlDvHV7rJyulPCh4F0
         2jdVGA/TjMInIxvXccrUJNEPI+obFu5CX0dyOQPTcZx5w/PWrKoUQ+j3lO70HOg+urB7
         un6vT6jLNiZlF1mvjL4/It+VsqxGO2EHqurNrSgzsABX0YVF5gCrsDqF8huiNfXckHxu
         FRvedIYVJVyKG7bSgy3xztVvLuLlIAHCZnaoLUQty2cE0mCjNXVoQ1PxG/UIJYIQKwUt
         P5cLBjvmrS5adSeVLt4/Wu+zSAbHgOe7UB3/IG+cHEOwFOtb7YKutOjWe6zJuMWIZNkq
         LO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe/A8DaCityVfhPRTyO6NR6RDs4ioAONR2YureSKsTPHTxaBa6TgEKAYQlYL5dRFgOBMieKj39/RkZxGh/vT3Hr5eVIpGtt58eRAA+
X-Gm-Message-State: AOJu0YyxNz/+lknCgcOt5yd5hV/8D+BJ+Eak/q8bGBFobfddxJ27RXZu
	u3WYSXL0Ywe3MRHqidzZnqTufWuyW+sxsYa7sydBjYBremR3rZPqi9kpwXBaREgY6PkuvZW0PRo
	9FqoqIRVpi2hqtKb6bbHgvl7/eGlyH5BHA72gvTDDOLnyp25b6WSJcR4=
X-Google-Smtp-Source: AGHT+IGEvQav40DBte2FS9A+z0Y04K8p7GENwcMixFV2O/20HFF1NnTMDmyGbpnfdiVAsKwS/sE3bRUrifgmYtdPpi9sEImX1GXS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:373:8d04:28b2 with SMTP id
 e9e14a558f8ab-37609379cdfmr441165ab.0.1718656582810; Mon, 17 Jun 2024
 13:36:22 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:36:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c0dc8061b1bebf0@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in l2cap_publish_rx_avail
From: syzbot <syzbot+49092daf3dd0a57f9e73@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1154f6da980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=49092daf3dd0a57f9e73
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c40c1cd990d2/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2a94050804e/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49092daf3dd0a57f9e73@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000002e: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000170-0x0000000000000177]
CPU: 0 PID: 5233 Comm: kworker/u33:3 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: hci2 hci_rx_work
RIP: 0010:l2cap_publish_rx_avail+0x4f/0x1c0 net/bluetooth/l2cap_sock.c:1137
Code: 03 80 3c 02 00 0f 85 86 01 00 00 48 8b ab a0 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bd 74 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 3a
RSP: 0018:ffffc90003967978 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff888025e47000 RCX: ffffc90021bc3000
RDX: 000000000000002e RSI: ffffffff89e760be RDI: 0000000000000174
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff93943408 R12: ffff888025e42000
R13: ffff8880285b72c0 R14: ffff888025e4702e R15: ffff8880285b72c0
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32345000 CR3: 0000000029c30000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 l2cap_sock_recv_cb+0x104/0x3d0 net/bluetooth/l2cap_sock.c:1509
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x20cb/0xa190 net/bluetooth/l2cap_core.c:6833
 l2cap_recv_acldata+0x9ac/0xb60 net/bluetooth/l2cap_core.c:7516
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0xaa7/0x1610 net/bluetooth/hci_core.c:4079
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:l2cap_publish_rx_avail+0x4f/0x1c0 net/bluetooth/l2cap_sock.c:1137
Code: 03 80 3c 02 00 0f 85 86 01 00 00 48 8b ab a0 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bd 74 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 3a
RSP: 0018:ffffc90003967978 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff888025e47000 RCX: ffffc90021bc3000
RDX: 000000000000002e RSI: ffffffff89e760be RDI: 0000000000000174
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff93943408 R12: ffff888025e42000
R13: ffff8880285b72c0 R14: ffff888025e4702e R15: ffff8880285b72c0
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32345000 CR3: 0000000045a0a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 86 01 00 00 48    	test   %eax,0x48000001(%rsi)
   c:	8b ab a0 04 00 00    	mov    0x4a0(%rbx),%ebp
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	48 8d bd 74 01 00 00 	lea    0x174(%rbp),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 3a                	test   %edi,(%rdx)


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

