Return-Path: <linux-kernel+bounces-411971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADA89D01DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 02:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34CBB22AC8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE46FBF;
	Sun, 17 Nov 2024 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="oaLNIexA"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440014C83
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731807959; cv=none; b=tdexKSLvPMOCipwkoJtKsmkT0PURv1tY7DoJvHGITPMt4HElioeYrqCld3Ju2dub/FFaUn/8TvYAf9h7DCnzBwbSxw1RVECddYBdeXQefEkdAju4dM8fBnwEak73KFWbNMMJRPiN/w3HWaboYwhw4m8QrCzsS3GoQY+SiYdavQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731807959; c=relaxed/simple;
	bh=6s0mDHX6ZnG00ZipVHKtpuSrqNBxekOZnXVBfWgDSbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5Tw/aFwLSyv2p73ZVyxxkuyvZ91qVGAkKk/UTMb1/btHs3iKNrYBbJfH/Z3uRpeQzzsxzzEVURDl7hzRvLQC6bmTYJkBgoubEYT73brpgZvZGQozfu/dhkAVAMY7S4mejTVWvUwFwSrLiVRfCpyEEgl+1ogW6Sj20NKwK7v4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=oaLNIexA; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2A93214C1E1;
	Sun, 17 Nov 2024 02:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1731807953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDz8BZrrqqRZeFmlipnmY/iNDnemQmTYhooaCQXDXSk=;
	b=oaLNIexAhshjW14gvAMV3ZoeyH/4HdQN95C3mxBZTgH2NTa0MYCQ6LmPC6caaMXEcjIGrB
	tzGPRmqBoDpgNpjAoCQlHUIZJk6l30MhweqtGESfc3IGKYx1dfgf8K1hKI9QMGePmPT/BW
	sqb6isN4oFC2leBlPSsjvjG9H5ewxpEW+WQWM3PNj+izfgbff60HtGVVOLIjs7NXUxfg1G
	ujjBmPMCQCs3l0FmOFcwXz8Y4Ufk5LAOGlGJRR2+ysaxnzQ/mL3v6BUpKmS7Lepkd26STo
	R08I6HNY0peP0/yHZzZf7IA7LCgvyWMInpDFrAMgn1v9GpsRwVFldOL5pZd/Vw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7fa8ce8a;
	Sun, 17 Nov 2024 01:45:48 +0000 (UTC)
Date: Sun, 17 Nov 2024 10:45:33 +0900
From: asmadeus@codewreck.org
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, ericvh@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	David Howells <dhowells@redhat.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
Message-ID: <ZzlKvSbkMe4iIbi4@codewreck.org>
References: <6731d39c.050a0220.1fb99c.014e.GAE@google.com>
 <6739490e.050a0220.87769.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6739490e.050a0220.87769.0000.GAE@google.com>

Lizhi Xu,

now a reproducer was found it would be great if you could also test your
patch on this; it looks like the same problem as [1]

[1] https://lkml.kernel.org/r/672b7858.050a0220.350062.0256.GAE@google.com

Thanks,

(full quote for context, no other below)
syzbot wrote on Sat, Nov 16, 2024 at 05:38:22PM -0800:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    e8bdb3c8be08 Merge tag 'riscv-for-linus-6.12-rc8' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136a52e8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=327b6119dd928cbc
> dashboard link: https://syzkaller.appspot.com/bug?extid=885c03ad650731743489
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1642d2c0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14547130580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e8bdb3c8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3fca1f7d05f3/vmlinux-e8bdb3c8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/51d966b1b453/bzImage-e8bdb3c8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com
> 
> BUG: TASK stack guard page was hit at ffffc90005abfff8 (stack is ffffc90005ac0000..ffffc90005ac8000)
> Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 6005 Comm: syz-executor698 Not tainted 6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:mark_lock+0xb0/0xc60 kernel/locking/lockdep.c:4703
> Code: fe 09 0f 87 e3 00 00 00 41 83 fe 08 49 89 fc 48 89 f3 0f 84 97 00 00 00 41 bd 01 00 00 00 44 89 f1 41 d3 e5 4d 63 ed 48 89 df <e8> cb 6b ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 60 48 89 f9
> RSP: 0018:ffffc90005ac0000 EFLAGS: 00010002
> RAX: 0000000000000000 RBX: ffff888029b953b0 RCX: 0000000000000003
> RDX: 0000000000000002 RSI: ffff888029b953b0 RDI: ffff888029b953b0
> RBP: ffffc90005ac0138 R08: 0000000000000000 R09: 0000000000000006
> R10: ffffffff96e2ed1f R11: 0000000000000002 R12: ffff888029b94880
> R13: 0000000000000200 R14: 0000000000000009 R15: 1ffff92000b58006
> FS:  00007f59e396f6c0(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc90005abfff8 CR3: 000000003c6a2000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <#DF>
>  </#DF>
>  <TASK>
>  mark_usage kernel/locking/lockdep.c:4646 [inline]
>  __lock_acquire+0x906/0x3ce0 kernel/locking/lockdep.c:5156
>  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
>  rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  page_ext_get+0x3a/0x310 mm/page_ext.c:525
>  __set_page_owner+0x96/0x560 mm/page_owner.c:322
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4750
>  alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>  alloc_slab_page mm/slub.c:2412 [inline]
>  allocate_slab mm/slub.c:2578 [inline]
>  new_slab+0x2c9/0x410 mm/slub.c:2631
>  ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
>  __slab_alloc_node mm/slub.c:3961 [inline]
>  slab_alloc_node mm/slub.c:4122 [inline]
>  kmem_cache_alloc_noprof+0x2a7/0x2f0 mm/slub.c:4141
>  p9_tag_alloc+0x9c/0x870 net/9p/client.c:281
>  p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
>  p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
>  p9_client_read_once+0x443/0x820 net/9p/client.c:1570
>  p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
>  v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
>  netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
>  netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
>  netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
>  netfs_unbuffered_read_iter_locked+0x12f6/0x19b0 fs/netfs/direct_read.c:221
>  netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
>  v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
>  __kernel_read+0x3f1/0xb50 fs/read_write.c:527
>  integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
>  ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x89f/0xa40 security/integrity/ima/ima_api.c:293
>  process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0x8e/0x210 security/security.c:3129
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x1419/0x2d60 fs/namei.c:3933
>  do_filp_open+0x1dc/0x430 fs/namei.c:3960
>  do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x154/0x1e0 fs/open.c:1434
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f59e39b43e9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f59e396f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 00007f59e3a3e308 RCX: 00007f59e39b43e9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
> RBP: 00007f59e3a3e300 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f59e3a3e30c
> R13: 00007f59e3a0b074 R14: 0030656c69662f2e R15: 00000000ffffff3c
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:mark_lock+0xb0/0xc60 kernel/locking/lockdep.c:4703
> Code: fe 09 0f 87 e3 00 00 00 41 83 fe 08 49 89 fc 48 89 f3 0f 84 97 00 00 00 41 bd 01 00 00 00 44 89 f1 41 d3 e5 4d 63 ed 48 89 df <e8> cb 6b ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 60 48 89 f9
> RSP: 0018:ffffc90005ac0000 EFLAGS: 00010002
> RAX: 0000000000000000 RBX: ffff888029b953b0 RCX: 0000000000000003
> RDX: 0000000000000002 RSI: ffff888029b953b0 RDI: ffff888029b953b0
> RBP: ffffc90005ac0138 R08: 0000000000000000 R09: 0000000000000006
> R10: ffffffff96e2ed1f R11: 0000000000000002 R12: ffff888029b94880
> R13: 0000000000000200 R14: 0000000000000009 R15: 1ffff92000b58006
> FS:  00007f59e396f6c0(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc90005abfff8 CR3: 000000003c6a2000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	fe 09                	decb   (%rcx)
>    2:	0f 87 e3 00 00 00    	ja     0xeb
>    8:	41 83 fe 08          	cmp    $0x8,%r14d
>    c:	49 89 fc             	mov    %rdi,%r12
>    f:	48 89 f3             	mov    %rsi,%rbx
>   12:	0f 84 97 00 00 00    	je     0xaf
>   18:	41 bd 01 00 00 00    	mov    $0x1,%r13d
>   1e:	44 89 f1             	mov    %r14d,%ecx
>   21:	41 d3 e5             	shl    %cl,%r13d
>   24:	4d 63 ed             	movslq %r13d,%r13
>   27:	48 89 df             	mov    %rbx,%rdi
> * 2a:	e8 cb 6b ff ff       	call   0xffff6bfa <-- trapping instruction
>   2f:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
>   36:	fc ff df
>   39:	48 8d 78 60          	lea    0x60(%rax),%rdi
>   3d:	48 89 f9             	mov    %rdi,%rcx
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

-- 
Dominique Martinet | Asmadeus

