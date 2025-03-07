Return-Path: <linux-kernel+bounces-550607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC63A561ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6AD3B2E41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679B1A5B95;
	Fri,  7 Mar 2025 07:39:32 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BE1A5B96
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333171; cv=none; b=KwSoUp/DUTyxzTIcg6AmyA32gADf+f+qJVxJ0TfVTmIJ52ja2lzj0WS5YCyLm25doOZeFK8sMlQKR3xNIwZkZpdFJcNsjPDjf3ywpP8F6PSmLI/1XUPCaO3hRaNOxFVJa/sUVFBRFE8lZzHlJ5CKhQGszu8hLmJ8/vD13B25nVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333171; c=relaxed/simple;
	bh=HFOr96uzJVOgA3F1Ejo/ufXdkdDy96HL2ss30AGNFL4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N+d1o/rgHygx5wY4YmazX+tdF3VP4GGmwx++PoZDn+brubcnGA9pjhcKH5k5km87VqbERE8uDCuR3qr3ypX2bWJTeCZbnIrhuBDV/8vRDoJpZ4DMomNcsMNP5ufibRWc4H4/uIC/28Mtg9PgN44hFNIs/BJM/veGUF12Ydtsqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso14081345ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741333169; x=1741937969;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKX1UD8UaY3+TFx/rG6mu4yhrmjHNkemFwk644ISkVA=;
        b=msquMPdraJZEhdCQTHoc3wPyQReAWyE3utCEU4UwZjgCGT4MqOm7eoqiSpv8DPBLDO
         CGg6YQKYuK3gcAB7dEl9UqW5gavTyp6I+/Q+oacOfaucRJmsxgDpikUHBDdf6qSg688I
         nk6ty2f0eYrlTlUbSLNvfU6kK2dTpd1GvYn9v7+3VA9lDrSDPPY1IcnE2AnydwyJOPm0
         99hUeMvTEPWz7AHKAYSZXDwQOFtCVdvcbyF15EVxoGregA+Lad41/odUMqfGBCAqrQ7R
         u32NSE42jS/ufugzWGFMkEa+KutQdvpPU36tR4MuK2WcNfovWsvufyEMheRuzQLgzLjw
         7wpg==
X-Forwarded-Encrypted: i=1; AJvYcCV8A84LItuk9JK/2RDJr1iIMBaOVARFizYQeeHZOXj6KdM4CJFhnDeFEjlLV7I5Lfq6kGpV2gE+tUWVTU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuqhqCV0LDv5EE4KhmAtmqmFc+v8w9dPEN9gPHYqmj1uO2qnSE
	bYqBnm0NDCv9RW2ijIw9AhhWZHrYbYkNTSxcTw/tVHvJ+kYpI9YNtOHtGJFYsJLcM8QWiFDQzA4
	2PKhBZOJj6RzfvzkDK3ksMZaOmMmXH9gFtHFGAMygXLWJo5urvH424QU=
X-Google-Smtp-Source: AGHT+IEo7WRMFD1Fsxov9bQBeyeVXc7HpSkzBOF8+SScLg5uQ1aWkATDpYOw/+KCQp5CH+iri6Mnk/EZv5wznjdm7TO9Lx7Xh5bR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:3d0:bd5:b863 with SMTP id
 e9e14a558f8ab-3d441a1d665mr27903305ab.20.1741333169078; Thu, 06 Mar 2025
 23:39:29 -0800 (PST)
Date: Thu, 06 Mar 2025 23:39:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67caa2b1.050a0220.15b4b9.0077.GAE@google.com>
Subject: [syzbot] [bpf?] general protection fault in bpf_map_offload_map_alloc
From: syzbot <syzbot+0c7bfd8cf3aecec92708@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2525e16a2bae Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14d18878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc61e4c6e816b7b
dashboard link: https://syzkaller.appspot.com/bug?extid=0c7bfd8cf3aecec92708
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bae047feb57e/disk-2525e16a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f10529c6bdd/vmlinux-2525e16a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8dcb6d0a6029/bzImage-2525e16a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c7bfd8cf3aecec92708@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
CPU: 1 UID: 0 PID: 9913 Comm: syz.1.1316 Not tainted 6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
RIP: 0010:bpf_map_offload_map_alloc+0x19a/0x910 kernel/bpf/offload.c:533
Code: 48 89 44 24 30 42 80 3c 20 00 74 08 48 89 df e8 ac e6 3b 00 48 89 5c 24 18 4c 89 2b 49 8d 9d bd 0c 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 df 06 00 00 0f b6 1b 31 ff 89 de e8 dd
RSP: 0018:ffffc90002e67bc0 EFLAGS: 00010203
RAX: 0000000000000197 RBX: 0000000000000cbd RCX: ffff8880307ebc00
RDX: 0000000000000000 RSI: 0000000067ff0009 RDI: 0000000000000009
RBP: ffffc90002e67cd8 R08: ffffffff89c99bd3 R09: 1ffffffff207a16e
R10: dffffc0000000000 R11: fffffbfff207a16f R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888062af0000 R15: 1ffff920005ccf80
FS:  00007f142b0266c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f142b025f98 CR3: 00000000622c6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 map_create+0x946/0x11c0 kernel/bpf/syscall.c:1455
 __sys_bpf+0x6d3/0x820 kernel/bpf/syscall.c:5777
 __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5900
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f142a18d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f142b026038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f142a3a5fa0 RCX: 00007f142a18d169
RDX: 0000000000000048 RSI: 0000400000000000 RDI: 0000000000000000
RBP: 00007f142a20e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f142a3a5fa0 R15: 00007fff7b881dc8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
RIP: 0010:bpf_map_offload_map_alloc+0x19a/0x910 kernel/bpf/offload.c:533
Code: 48 89 44 24 30 42 80 3c 20 00 74 08 48 89 df e8 ac e6 3b 00 48 89 5c 24 18 4c 89 2b 49 8d 9d bd 0c 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 df 06 00 00 0f b6 1b 31 ff 89 de e8 dd
RSP: 0018:ffffc90002e67bc0 EFLAGS: 00010203
RAX: 0000000000000197 RBX: 0000000000000cbd RCX: ffff8880307ebc00
RDX: 0000000000000000 RSI: 0000000067ff0009 RDI: 0000000000000009
RBP: ffffc90002e67cd8 R08: ffffffff89c99bd3 R09: 1ffffffff207a16e
R10: dffffc0000000000 R11: fffffbfff207a16f R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888062af0000 R15: 1ffff920005ccf80
FS:  00007f142b0266c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9c38c00f98 CR3: 00000000622c6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
   5:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   a:	74 08                	je     0x14
   c:	48 89 df             	mov    %rbx,%rdi
   f:	e8 ac e6 3b 00       	call   0x3be6c0
  14:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
  19:	4c 89 2b             	mov    %r13,(%rbx)
  1c:	49 8d 9d bd 0c 00 00 	lea    0xcbd(%r13),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 df 06 00 00    	jne    0x716
  37:	0f b6 1b             	movzbl (%rbx),%ebx
  3a:	31 ff                	xor    %edi,%edi
  3c:	89 de                	mov    %ebx,%esi
  3e:	e8                   	.byte 0xe8
  3f:	dd                   	.byte 0xdd


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

