Return-Path: <linux-kernel+bounces-186089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD78CBFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02B71C21E68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD3824BC;
	Wed, 22 May 2024 10:57:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63593824B5
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375425; cv=none; b=YNpLSKFjk6FCWo4v7A6k3EZwdPrSZuGFtp2GV9mqnUI2PpGMZLNPuNIyzpxrinZYCK80bIqkvzuADNZOShskkpH7afvbaDISdhIYoPJbsgVT8B4OoqbhZ4CylyjCVRozU7yNQOgYmjiMWTgf/G42gxMQ4naXIkgZ2HyXXXixNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375425; c=relaxed/simple;
	bh=SiDYLc1+MtcBZilsEHphRUL/bWPJcHRBLWzAcAnMCUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X+NO6psH/7DK0df3EiZZ049bTuFYCtphac81F8/KsKhwEjK3s7K65L3ed/Rr708f2SGD/WXZbfzgZIs9RxnSZZsAp3eNAnR8V0egw2i5NC1JNFzoYs0O1r1SMqgNFC1MzS1lFpKRpJbZJUos7/x4FWtv41el27W1PH3D4A0OMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36d98ad0c7eso5169605ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375423; x=1716980223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gececDKdm1Pj8nm5eje1ipDzbMX9Ru0vTJVlMioNkdE=;
        b=ScFUyo2q7JEaHcztIr57iWn3ZGfjR5J3tB2nyJDMqczroZn+rLjenQ3DlvY/wsP2VS
         9kydAlroFsYB18b9riFQzeIe7BPqdi98TH43JwfUrljvFbVhiqVV5SBYWUCPnYq8VKPB
         TpwXe6p5KkMjW/U8l7UYRFZr7Qb28GfSPnu/9CozkDHBClYdL746PjFKmTff+D9HCwPj
         yJEInT0m25Auj8cW5vukYPYVpObpgJmIC1qgPT01ry+4Nl4/iMjxLbXakSdZNFkZN4IV
         dwfo1tzFeB0fBBCszPKBATwcDYqzq1X344xEB+ETwRRSSBEOleRQDg2rdlkXWo25tLiI
         bWPw==
X-Forwarded-Encrypted: i=1; AJvYcCUHjY3dRMcexoQrZ9fGYDJ3blP/bTfAwmL5uOUm3naiy4LPIi7UyssFXFwCiKW2Sc3yasRr6K2XvIQpGRAoOIOhq6/vQPYU9uVLHxFH
X-Gm-Message-State: AOJu0YzvaAypLCKWlkAx+pbp9PaHXHCX4OVinDbyqnlsCgwP0ZXzkkH3
	iff1teGkvlYmCcWz44EBCypzc+GcQrzQT/abwsPaTKs2nYIYZkRguWBdYt2Vu42nt3x98ifY8bk
	RiFRacUAw6hYQk0TbcOSXq16ekiYshTacGGfkDXm4YCmSYWl3DM0Jiz8=
X-Google-Smtp-Source: AGHT+IGgkarJJMfig1sje2amsYURL5/TA1BkWjLvRBmoFWM28eusP8woR45z+A+MNMiZT5yjtnX9gPi8Nvw01q4P3HDi+nqEdKVw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:36d:cccb:6842 with SMTP id
 e9e14a558f8ab-371f3e40d12mr1613525ab.0.1716375423635; Wed, 22 May 2024
 03:57:03 -0700 (PDT)
Date: Wed, 22 May 2024 03:57:03 -0700
In-Reply-To: <tencent_768996EEEDAEDD0CB127C786D9D2CA064906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d65e3061908cbd9@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in iter_file_splice_write

netfs: Couldn't get user pages (rc=-14)
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 3 PID: 5391 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-07370-g33e02dc69afb-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
RIP: 0010:iter_file_splice_write+0xa28/0x10a0 fs/splice.c:759
Code: 00 00 48 89 fa 48 c1 ea 03 80 3c 2a 00 0f 85 41 05 00 00 4d 8b 6e 10 49 c7 46 10 00 00 00 00 49 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 2a 00 0f 85 16 05 00 00 49 8b 55 08 4c 89 f6 4c 89 ff 41 83
RSP: 0018:ffffc90003927930 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 7fffffffffffefff RCX: ffffffff8209a1ad
RDX: 0000000000000001 RSI: ffffffff8209a071 RDI: 0000000000000008
RBP: dffffc0000000000 R08: 0000000000000006 R09: 0000000000000000
R10: 7fffffffffffefff R11: 0000000000000001 R12: 000000000000009d
R13: 0000000000000000 R14: ffff8880350b5a08 R15: ffff888020f01800
FS:  00007f607512b6c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000026be4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x19b/0x6d0 fs/splice.c:1164
 splice_direct_to_actor+0x346/0xa40 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x17e/0x250 fs/splice.c:1233
 do_sendfile+0xaa8/0xdb0 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __x64_sys_sendfile64+0x1da/0x220 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f607447cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f607512b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f60745abf80 RCX: 00007f607447cee9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007f60744c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000100000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f60745abf80 R15: 00007ffed559a608
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
RIP: 0010:iter_file_splice_write+0xa28/0x10a0 fs/splice.c:759
Code: 00 00 48 89 fa 48 c1 ea 03 80 3c 2a 00 0f 85 41 05 00 00 4d 8b 6e 10 49 c7 46 10 00 00 00 00 49 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 2a 00 0f 85 16 05 00 00 49 8b 55 08 4c 89 f6 4c 89 ff 41 83
RSP: 0018:ffffc90003927930 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 7fffffffffffefff RCX: ffffffff8209a1ad
RDX: 0000000000000001 RSI: ffffffff8209a071 RDI: 0000000000000008
RBP: dffffc0000000000 R08: 0000000000000006 R09: 0000000000000000
R10: 7fffffffffffefff R11: 0000000000000001 R12: 000000000000009d
R13: 0000000000000000 R14: ffff8880350b5a08 R15: ffff888020f01800
FS:  00007f607512b6c0(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f60745a8000 CR3: 0000000026be4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 89 fa             	mov    %rdi,%rdx
   5:	48 c1 ea 03          	shr    $0x3,%rdx
   9:	80 3c 2a 00          	cmpb   $0x0,(%rdx,%rbp,1)
   d:	0f 85 41 05 00 00    	jne    0x554
  13:	4d 8b 6e 10          	mov    0x10(%r14),%r13
  17:	49 c7 46 10 00 00 00 	movq   $0x0,0x10(%r14)
  1e:	00
  1f:	49 8d 7d 08          	lea    0x8(%r13),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 2a 00          	cmpb   $0x0,(%rdx,%rbp,1) <-- trapping instruction
  2e:	0f 85 16 05 00 00    	jne    0x54a
  34:	49 8b 55 08          	mov    0x8(%r13),%rdx
  38:	4c 89 f6             	mov    %r14,%rsi
  3b:	4c 89 ff             	mov    %r15,%rdi
  3e:	41                   	rex.B
  3f:	83                   	.byte 0x83


Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=161cfadc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138c6830980000


