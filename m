Return-Path: <linux-kernel+bounces-190274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 780E58CFC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89A8B212CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E195D60DCF;
	Mon, 27 May 2024 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UCDi/dVS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3982433C8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800368; cv=none; b=n/hXsmZ0nuQ4wm7y4jNk6PaxIRYvD4YOVb5GmT77e7z8pNYhzq2ingP43RlFTUt11O0TtAIS04KM7iHxyez1i/Ye6xVFRAmFJzykWDESSx50LtPR9ep7bNVMsSQMp3aYZ7q/2HGbFdzLwz31eLiJqt5c1VFH8LZbJ+LY0pg9KzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800368; c=relaxed/simple;
	bh=TZD7kVj7NRmOdHCDx+mzPgsTPNekbm5iPjC5pVh3Yk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqAamhdXRHwStGe5zcxFiXkH3+pJrDoGb6wOvo+/G/DJ++JIrwoBBypqslUBJGfhitF3nzzKV3cvPbL2Fn/iwsHJZ+X3KTqE2sTGQAn7JpxRBPwg6By38GdlXa3nan/dHubiKxnk+np+ZZTcX/wI4ACvLOlx1zCnsZiLO540VA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UCDi/dVS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B5CB740E01A3;
	Mon, 27 May 2024 08:59:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GGDHjd5gsnHB; Mon, 27 May 2024 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716800358; bh=D9eHks7tU1/cJwdrMXw8IZHM0vmbBPY6H8QDZaZTIo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCDi/dVSqRvhOVvNl+MiukHNX5RhHKfzLFCWNxkjixKSJJLTD/NajIJzTFNqMZLcG
	 uf87ifZBn5X5wbN9lP1cHGEbrpBoh5jIdRkchiwVPjCAImrr6NUrEZLCNA63f+N7H2
	 ah0MlyyWhE09Z94h9uwmfBm57rl23hoDweaBDUcE47eYlW98a3RBdscyVyWaUkYzi/
	 4vTdXYPD5GxeIC/kb78FJVPXLgTUH3uAMNzo8aTGMvBeCr19gUyiqYwoXJOtR89wH2
	 7okuV7e1sqK7rkZ/fEahHgKKMq6GkgDBJcK8tbccIPsGPWjf8YuI1EYECJYMJ7KBxW
	 g5/ENrl2/vTH6Qxqwo5gtz2WK8rimBnuBBNoJA5EhDKUymF+dGwJfjv4kMss6pMeOt
	 voi+Wesz7txLzQMzARJj+bWkGV1qXiX/3/RBzsSZMVcxLPrnXqJbaWfbnIa1A6CcG/
	 0hkZ5JtCbuWesnzYleNCdIyUExuMiSl7NmkM7d9ujWYaqVI2VQkFzf1BXaOBK9Qzcl
	 IQqAlnDEiMJ2yE0LlT9pHHDj8g4zWVFX4waQ6u9YXNW4VlmzAJY/WgG3W/9MyVrQVU
	 fsTfcYSXtO/sZAx3j34BdrdMIqyW/3ueZfNFxG7XRE2iEed5lUVzDaT9U7CImaJtOk
	 pGJveVc6Ac/8QMVq1N2EgLj8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3EB2040E016A;
	Mon, 27 May 2024 08:59:09 +0000 (UTC)
Date: Mon, 27 May 2024 10:59:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: syzbot <syzbot+79388700e25aa19555b9@syzkaller.appspotmail.com>,
	linux-mm <linux-mm@kvack.org>
Cc: dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in deactivate_slab
Message-ID: <20240527085801.GAZlRLGZpDIdCq4p2z@fat_crate.local>
References: <0000000000004dbd4f06196af76f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000004dbd4f06196af76f@google.com>

+ linux-mm

syzbot folks: might wanna refresh your patterns on how this automated
thing is deciding who to Cc. This is clearly a mm issue.

On Mon, May 27, 2024 at 01:04:26AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1613e604df0c Linux 6.10-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15410752980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=79388700e25aa19555b9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1613e604.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bdfe02141e4c/vmlinux-1613e604.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9e655c2629f1/bzImage-1613e604.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+79388700e25aa19555b9@syzkaller.appspotmail.com
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000001
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 256e3067 P4D 256e3067 PUD 4977c067 PMD 0 
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 3 PID: 56 Comm: kworker/3:1 Not tainted 6.10.0-rc1-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Workqueue: slub_flushwq flush_cpu_slab
> RIP: 0010:PagePoisoned include/linux/page-flags.h:296 [inline]
> RIP: 0010:page_to_nid include/linux/mm.h:1664 [inline]
> RIP: 0010:folio_nid include/linux/mm.h:1670 [inline]
> RIP: 0010:slab_nid mm/slab.h:194 [inline]
> RIP: 0010:deactivate_slab+0x1b/0x4a0 mm/slub.c:2880
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56 49 89 f6 41 55 41 54 53 48 83 e4 f0 48 81 ec b0 00 00 00 <48> 8b 06 48 89 54 24 08 48 83 f8 ff 0f 84 c3 03 00 00 48 8b 06 48
> RSP: 0018:ffffc9000076fbb0 EFLAGS: 00010282
> RAX: 0000000000000002 RBX: ffffe8ffad339190 RCX: 1ffffffff28415f8
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888021133540
> RBP: ffffc9000076fc88 R08: 0000000000000001 R09: fffffbfff283ee5e
> R10: ffffffff941f72f7 R11: ffffffff81e16fea R12: 0000000000000200
> R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
> FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000001 CR3: 000000001b47c000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  flush_slab mm/slub.c:3100 [inline]
>  flush_cpu_slab+0x141/0x410 mm/slub.c:3146
>  process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
>  process_scheduled_works kernel/workqueue.c:3312 [inline]
>  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> CR2: 0000000000000001
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:PagePoisoned include/linux/page-flags.h:296 [inline]
> RIP: 0010:page_to_nid include/linux/mm.h:1664 [inline]
> RIP: 0010:folio_nid include/linux/mm.h:1670 [inline]
> RIP: 0010:slab_nid mm/slab.h:194 [inline]
> RIP: 0010:deactivate_slab+0x1b/0x4a0 mm/slub.c:2880
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56 49 89 f6 41 55 41 54 53 48 83 e4 f0 48 81 ec b0 00 00 00 <48> 8b 06 48 89 54 24 08 48 83 f8 ff 0f 84 c3 03 00 00 48 8b 06 48
> RSP: 0018:ffffc9000076fbb0 EFLAGS: 00010282
> RAX: 0000000000000002 RBX: ffffe8ffad339190 RCX: 1ffffffff28415f8
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888021133540
> RBP: ffffc9000076fc88 R08: 0000000000000001 R09: fffffbfff283ee5e
> R10: ffffffff941f72f7 R11: ffffffff81e16fea R12: 0000000000000200
> R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
> FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000001 CR3: 000000001b47c000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	90                   	nop
>    1:	90                   	nop
>    2:	90                   	nop
>    3:	90                   	nop
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	90                   	nop
>    9:	90                   	nop
>    a:	90                   	nop
>    b:	90                   	nop
>    c:	90                   	nop
>    d:	90                   	nop
>    e:	90                   	nop
>    f:	55                   	push   %rbp
>   10:	48 89 e5             	mov    %rsp,%rbp
>   13:	41 57                	push   %r15
>   15:	41 56                	push   %r14
>   17:	49 89 f6             	mov    %rsi,%r14
>   1a:	41 55                	push   %r13
>   1c:	41 54                	push   %r12
>   1e:	53                   	push   %rbx
>   1f:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
>   23:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
> * 2a:	48 8b 06             	mov    (%rsi),%rax <-- trapping instruction
>   2d:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
>   32:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
>   36:	0f 84 c3 03 00 00    	je     0x3ff
>   3c:	48 8b 06             	mov    (%rsi),%rax
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

