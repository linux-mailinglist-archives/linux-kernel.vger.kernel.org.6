Return-Path: <linux-kernel+bounces-187341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26A8CD06E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB61C22A42
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FD613D61D;
	Thu, 23 May 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3y7erEc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vMppQh/o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEE14430E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460586; cv=none; b=kx8uRwY+Sp4J+b0xTdXjtqp5vJPS3jMGcROEvrWpN+ZCkUy7W20gVyQIjYbtW+1afCv7Zo4nPsOrV//oPKsU9FyovGzNNK1uEwP8QiIRYiWGUMj2uhk38i6AG89CiW+J79vFeZAtxLodEOoRXcDB+GlXB6mHbDMhoEq/DB4jcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460586; c=relaxed/simple;
	bh=YPYDzEnmIdlGQA4rmOFtEcJP0ZgKGNyuzzT3z8Aigr8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdM09mUMRJDyCMvpg6LKoE05waMA19+avtfa/hinsQhdiBvSAmsD88jzF0QK45CsTfa4qjHNXSjeFqAnWXoh21KnMAntZKMZqWNbMdMJzw7bXJzNHSsbLBeNmgfNQgYaSwy8oUXQoFVyhmF6/tK97/1R0vaOc+W3RZ6bb8afr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3y7erEc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vMppQh/o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716460581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9WIBtqCr9KxZiW4jPsXAtVnjjWF2U5b/iTP2FVHh3w=;
	b=v3y7erEcnMB9Iq7+VNr+QP1CQf+cKZVcMnOXW2D7QDDys2CcmrfATKpmkZr9g+6b/nxqj+
	O9h/Y7kZK1d2nXFi9RssBywIa85BUvPbIeIy3CN21Kl9zll4MNIjldx570JWmtYIuNJ1/8
	17LAZNzsqwVQ6oOJfa445D8rkmYh76P1FYon/hl/27C/utFhL7QzXelIo1MZ+S4weuPDWa
	dLjQs9OSQFTN6cS9wnP0mlLoCT9BjrQLz0TPvkrt2qnHsjAOcbgh6iOWn8B3m822yzuAWy
	bCYz81rQoyLEqS7ogSttwxiipzLHc6l/dQ6ljR2sQaD+oVCHt146hI9gwyBHhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716460581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9WIBtqCr9KxZiW4jPsXAtVnjjWF2U5b/iTP2FVHh3w=;
	b=vMppQh/oCXsDRDLk+MduWzocKwyCDGV4Cuj0DH6UJ8D1FGgeQLlZ6DJbS/6vwEfwiNQnw8
	5VM8AixX6USeUlDw==
To: syzbot <syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org, Vlastimil Babka
 <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [syzbot] [kernel?] WARNING in flush_cpu_slab
In-Reply-To: <0000000000008c9d27061915ca9c@google.com>
References: <0000000000008c9d27061915ca9c@google.com>
Date: Thu, 23 May 2024 12:36:20 +0200
Message-ID: <87v834g6hn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

CC+: mm folks

On Wed, May 22 2024 at 19:27, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d42b0a980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
> dashboard link: https://syzkaller.appspot.com/bug?extid=50e25cfa4f917d41749f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(l->owner)
> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_slab mm/slub.c:3088 [inline]
> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_cpu_slab+0x37f/0x410 mm/slub.c:3146
> Modules linked in:
> CPU: 3 PID: 5221 Comm: kworker/3:3 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Workqueue: slub_flushwq flush_cpu_slab
> RIP: 0010:local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
> RIP: 0010:flush_slab mm/slub.c:3088 [inline]
> RIP: 0010:flush_cpu_slab+0x37f/0x410 mm/slub.c:3146
> Code: ff e8 e5 b2 fc 08 e9 25 ff ff ff e8 db b2 fc 08 e9 46 ff ff ff 90 48 c7 c6 7f 68 37 8d 48 c7 c7 b6 33 37 8d e8 72 88 6f ff 90 <0f> 0b 90 90 e9 dd fe ff ff 90 48 c7 c6 88 68 37 8d 48 c7 c7 b6 33
> RSP: 0018:ffffc90002b57c98 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: ffffe8ffac1021b0 RCX: ffffffff81510229
> RDX: ffff88801bb7c880 RSI: ffffffff81510236 RDI: 0000000000000001
> RBP: ffff88802790b540 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 000000002d2d2d2d R12: 0000000000000200
> R13: ffffe8ffac1021d0 R14: 0000000000000000 R15: ffffc90002b57d80
> FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000f73ffec2 CR3: 00000000268ca000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
>  process_scheduled_works kernel/workqueue.c:3312 [inline]
>  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

