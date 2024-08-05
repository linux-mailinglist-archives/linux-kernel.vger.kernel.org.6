Return-Path: <linux-kernel+bounces-274641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E071947AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230E9281F57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D7156F4B;
	Mon,  5 Aug 2024 12:20:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E13156C67
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860405; cv=none; b=itC91voPwwL8m1xSetF6B5Gni5koiaUe3+YuIQ88nv/hkaYqcsl7auNGIcusRGtHWZ2r8nvPByNoTjzeFeUmdCRfRazjsC7BpWOCUo/kJ27KNYTviiAd8FseuXKrTPdSDDp+psBicmTKo32LrKJs24tDPnAk6WoW5CSp3vfCDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860405; c=relaxed/simple;
	bh=JpfWE7rLFaXco8Q+uNOFBhFrFS7qAYeS5EPeu1xnvhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DJgtI625ayN+Va5bapSOl0BUJnZQTXDt0yFXEuw3ZXrcR3rHxlhhNJ1EMvbYvsDO7WjcM4Bw1RYmXhBZhufDu+oIzX0K31UpdOlgc0ztJzaApRlB/xItIOGc7Sw1jn1njdH5bC32BixEa1HTtc+Bjd5phzbVkVM/dIGOjVrdesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso156409325ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722860403; x=1723465203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ADBftjc8YiRzL1bynp2FMlY8eKZq7exZpuZkW2ZY8U=;
        b=JaZzhyZRVI6HRlcxHAHtrqlYOsORMYuxFJNsnzF/kRv0g/8r8aqTkXEYKbB7cZIQik
         Rjqnu3glC76zPMt9qdPvec0rrOxOvpzBAu3E6W7U3S2IBtcvw0fcj3rKQoWNBQTTbEPk
         TiHArS83P8TrU9WLf+P5Ux75Efo11DqA2GkgkVeJwlOgSicfxIHregqMr0A1H2XYXCQF
         n42G/q2hZnpn/hBC/DHhywXXJU5yt5P+ILTaZQUQG1Jy2EHMRV/7oApi6Xpz+uMQg9VQ
         zRXC10vE9dCGMjzjTmzQSe0ehLGVDBmUPswfysIVfFM2bYwNe96ZOeDMBg+q53NQk7wn
         Rasw==
X-Forwarded-Encrypted: i=1; AJvYcCW00d3+VyNqgl2OZTNYPGSwFW4p0DgjE9SFuwexyuufCuvBfVuTgZAyWkarZdPd9tmdZHK/Gmvl8FmD0Gb5raoIYHkRdPm5gTiNMja5
X-Gm-Message-State: AOJu0YxG5bXFnRmyJm5NTd7udW7RcXYmfPTGZ8643X/3Tsk5D7mO4bjq
	pBtbyLmJGEx1LDN8iP2JwnAXZpqqo5M+GMY5OMnEY9SakPJc9jSv5ams3HJEDlZHNVvzHh3xMH8
	6m8ImvNTuQ85Qo1BHJ/iw3k7/VlnTixo5hpRi3QVlf6hK3NdHpyXNUE0=
X-Google-Smtp-Source: AGHT+IFhvx8xGqwcf9+OvOV2qxGAIYqI8RCYaoWDcEXIb+EzvJC3I6lkL0EQw8ldLOCBsur7wz+uce4ZsMKVydueDs8ma+6RgB57
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:396:ec3b:df69 with SMTP id
 e9e14a558f8ab-39b1fc382damr8738255ab.3.1722860402935; Mon, 05 Aug 2024
 05:20:02 -0700 (PDT)
Date: Mon, 05 Aug 2024 05:20:02 -0700
In-Reply-To: <tencent_48AA749F76BD66F03C5F3724972036684A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000509a88061eeeb2cd@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in lmLogSync

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 112 Comm: jfsCommit Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:lmLogSync+0x130/0xae0 fs/jfs/jfs_logmgr.c:935
Code: a6 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 fe 96 d3 fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 e1 96 d3 fe 48 8b 3b e8 99 c5 a6
RSP: 0018:ffffc90002c8fc00 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: cec33d79cc59c000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002c8fd18 R08: ffffffff81cbb49a R09: 0000000000000000
R10: ffffc90002c8f9e8 R11: fffff52000591f6b R12: ffff88807720a800
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff88807dc3f238
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0017f8000 CR3: 000000002f11c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_syncpt+0x7d/0xa0 fs/jfs/jfs_logmgr.c:1041
 txEnd+0x30f/0x560 fs/jfs/jfs_txnmgr.c:549
 txLazyCommit fs/jfs/jfs_txnmgr.c:2684 [inline]
 jfs_lazycommit+0x634/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:lmLogSync+0x130/0xae0 fs/jfs/jfs_logmgr.c:935
Code: a6 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 fe 96 d3 fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 e1 96 d3 fe 48 8b 3b e8 99 c5 a6
RSP: 0018:ffffc90002c8fc00 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: cec33d79cc59c000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002c8fd18 R08: ffffffff81cbb49a R09: 0000000000000000
R10: ffffc90002c8f9e8 R11: fffff52000591f6b R12: ffff88807720a800
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff88807dc3f238
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f43bc3ff000 CR3: 000000002f11c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)
   1:	fe 49 8d             	decb   -0x73(%rcx)
   4:	5f                   	pop    %rdi
   5:	f0 48 89 d8          	lock mov %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 fe 96 d3 fe       	call   0xfed3971a
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 30          	add    $0x30,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 e1 96 d3 fe       	call   0xfed3971a
  39:	48 8b 3b             	mov    (%rbx),%rdi
  3c:	e8                   	.byte 0xe8
  3d:	99                   	cltd
  3e:	c5                   	.byte 0xc5
  3f:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)


Tested on:

commit:         50736169 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1500d4d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=eda89a33c5856f66f823
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a018f3980000


