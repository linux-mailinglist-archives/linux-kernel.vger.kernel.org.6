Return-Path: <linux-kernel+bounces-395868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221CC9BC42B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7635EB221FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37CA1AC43E;
	Tue,  5 Nov 2024 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IX+eq23J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56211420A8;
	Tue,  5 Nov 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779209; cv=none; b=myvR9a0cvtFz070FtkpfjvAFehRj+PKXGCOT5QKQze8u61Nj9aAZiJLiDXKKuaV2gP9fcmnBpdEPpowOSymtipc+YYd+V5ROPbXSIdz0cslprZdgGTC4p7ts/Zaa+0zSEFrDsaJqpOOp61q+JUMS4UV4p6tKulmqf+cMoiV/X1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779209; c=relaxed/simple;
	bh=v3k8GNUkrgtLNDoXKb8LNB5C+candp04NjeilVRblBM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eHH3nwJ9+F0HqBmPcABlwclAzVbCFoHk5Z00GxnauzR40Y4fzlTKCt8/TofudvnOUkgSNtwHGsa6jsCGvRF7755zQFZ/xnro0VwA1lX4MIzavApgewqbjNbTkC5pa94vtZlHRz1w5wYwt65p5SlpuGQFsLSAPECXf64n9d7x0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IX+eq23J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B5C4CECF;
	Tue,  5 Nov 2024 04:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730779208;
	bh=v3k8GNUkrgtLNDoXKb8LNB5C+candp04NjeilVRblBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IX+eq23JWkzkCpYZIKE8SDjweZHsmsdetl22cEpuSecy9f3J+iQEpTaCR6n57VeQR
	 jmFm+OCP+LyQ+8K+/55TVuJQM0Jdp4lkL2PxMokjjbVsHPv55kmyn4ExViLG68N3Oc
	 jAVpSmaYOBdf3Jrk6vYLuxOXYYSSogUo8SbCRPk0=
Date: Mon, 4 Nov 2024 20:00:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com,
 linux-usb@vger.kernel.org
Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
Message-Id: <20241104200007.dc8d0f018cc536a4957a1cd0@linux-foundation.org>
In-Reply-To: <67230d7e.050a0220.529b6.0005.GAE@google.com>
References: <67230d7e.050a0220.529b6.0005.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 21:54:22 -0700 syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:

Thanks.  I'm suspecting some USB issue - fault injection was used to
trigger a memory allocation failure and dec_usb_memory_use_count() ended
up freeing an in-use page.  Could USB folks please have a look?

> HEAD commit:    850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1346c940580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
> dashboard link: https://syzkaller.appspot.com/bug?extid=ccc0e1cfdb72b664f0d8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158ab65f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120e6a87980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/da8019730dec/disk-850925a8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b1ee80babbbc/vmlinux-850925a8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/462580e2ad54/bzImage-850925a8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com
> 
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffede422258 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007ffede422280 RCX: 00007f69e1b3c569
> RDX: 0000000002000005 RSI: 0000000000003000 RDI: 000000002001a000
> RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000080000000
> R10: 0000000000011012 R11: 0000000000000246 R12: 00007ffede42227c
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> ------------[ cut here ]------------
> kernel BUG at mm/page_table_check.c:157!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 5850 Comm: syz-executor279 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:__page_table_check_zero+0x274/0x350 mm/page_table_check.c:157
> Code: c1 0f 8c 39 fe ff ff 48 89 df e8 87 28 f3 ff e9 2c fe ff ff e8 dd 6a 89 ff 90 0f 0b e8 d5 6a 89 ff 90 0f 0b e8 cd 6a 89 ff 90 <0f> 0b f3 0f 1e fa 4c 89 f6 48 81 e6 ff 0f 00 00 31 ff e8 95 6f 89
> RSP: 0018:ffffc900046bf6d8 EFLAGS: 00010293
> RAX: ffffffff820b7fa3 RBX: dffffc0000000000 RCX: ffff88802fc13c00
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88801e97380c
> RBP: ffff88801e97380c R08: ffff88801e97380f R09: 1ffff11003d2e701
> R10: dffffc0000000000 R11: ffffed1003d2e702 R12: ffff88801e9737c0
> R13: 1ffffffff34887b4 R14: 0000000000000002 R15: 0000000000000000
> FS:  0000555570714380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f69e1b92385 CR3: 0000000073ae6000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  page_table_check_free include/linux/page_table_check.h:41 [inline]
>  free_pages_prepare mm/page_alloc.c:1109 [inline]
>  free_unref_page+0xd0f/0xf20 mm/page_alloc.c:2638
>  dec_usb_memory_use_count+0x259/0x350 drivers/usb/core/devio.c:198
>  mmap_region+0x2180/0x2a30 mm/mmap.c:1574
>  do_mmap+0x8f0/0x1000 mm/mmap.c:496
>  vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
>  ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f69e1b3c569
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffede422258 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007ffede422280 RCX: 00007f69e1b3c569
> RDX: 0000000002000005 RSI: 0000000000003000 RDI: 000000002001a000
> RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000080000000
> R10: 0000000000011012 R11: 0000000000000246 R12: 00007ffede42227c
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__page_table_check_zero+0x274/0x350 mm/page_table_check.c:157
> Code: c1 0f 8c 39 fe ff ff 48 89 df e8 87 28 f3 ff e9 2c fe ff ff e8 dd 6a 89 ff 90 0f 0b e8 d5 6a 89 ff 90 0f 0b e8 cd 6a 89 ff 90 <0f> 0b f3 0f 1e fa 4c 89 f6 48 81 e6 ff 0f 00 00 31 ff e8 95 6f 89
> RSP: 0018:ffffc900046bf6d8 EFLAGS: 00010293
> RAX: ffffffff820b7fa3 RBX: dffffc0000000000 RCX: ffff88802fc13c00
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88801e97380c
> RBP: ffff88801e97380c R08: ffff88801e97380f R09: 1ffff11003d2e701
> R10: dffffc0000000000 R11: ffffed1003d2e702 R12: ffff88801e9737c0
> R13: 1ffffffff34887b4 R14: 0000000000000002 R15: 0000000000000000
> FS:  0000555570714380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f69e1b92385 CR3: 0000000073ae6000 CR4: 0000000000350ef0
> ----------------
> Code disassembly (best guess):
>    0:	28 00                	sub    %al,(%rax)
>    2:	00 00                	add    %al,(%rax)
>    4:	75 05                	jne    0xb
>    6:	48 83 c4 28          	add    $0x28,%rsp
>    a:	c3                   	ret
>    b:	e8 a1 1a 00 00       	call   0x1ab1
>   10:	90                   	nop
>   11:	48 89 f8             	mov    %rdi,%rax
>   14:	48 89 f7             	mov    %rsi,%rdi
>   17:	48 89 d6             	mov    %rdx,%rsi
>   1a:	48 89 ca             	mov    %rcx,%rdx
>   1d:	4d 89 c2             	mov    %r8,%r10
>   20:	4d 89 c8             	mov    %r9,%r8
>   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>   28:	0f 05                	syscall
> * 2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	ret
>   33:	48 c7 c1 b8 ff ff ff 	mov    $0xffffffffffffffb8,%rcx
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

