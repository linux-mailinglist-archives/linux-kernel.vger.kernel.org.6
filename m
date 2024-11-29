Return-Path: <linux-kernel+bounces-411616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1439CFCE4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78635287E54
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA9190685;
	Sat, 16 Nov 2024 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sOAbrGLe"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E1802
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731738894; cv=none; b=Eb9VxWBp2O2SpvfBQzsZMOt4mNMHJXQxlrqR+VETiTlRNBlQTA8yzCOjkYgBtBNfaT1OOgrDde5YueyiiOscALEOpV/P/61fzREwgmOauCT3M7GjpzFrTYvcm4rcjUaczKKP5N6Ub2lnsNPwKuFn7G8c+EnoYYWA+psjpUPF2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731738894; c=relaxed/simple;
	bh=8VBIUjOl9++A5k1jwzxskL/f2EjpbgJd2UXRSfJz7KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdPvozUfwIzoYQ47doyvrSiZWZ2ApXUFs0edp7ejC1YWNkj0wwZXgezCGooK/19Uv2QyWC1ttDMlHbOPbwZ3s6eu2iGo7jC0X/MNzPeqWhGZX77gEUi8PQ+/1GM4iDNxXKq6TYEppno6/bwjxH2n/Q+U/17LOQ96DzItP5dBId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sOAbrGLe; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6C79814C1E1;
	Sat, 16 Nov 2024 07:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1731738883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KPFnXSFqvJIoZ9LVtOZodOEpwsTP2OEcVc0AYb9mHBE=;
	b=sOAbrGLe/vk8NVEIH5/qxr8V93ZrQMciJ0canyhE7lpJ49krhJXi5CAotePqNwyTlZbCCh
	R9E3hWtM7R45uPGwRxlNY7Z8mm8TsDSvJ3/KNft5oEXexHLtnAC1Xts7YnA7gzHrcxfmpI
	6yJUEs2HqRlCScfsG7T4aUk479+8M4PR1HTULg/Kf/myEgPQxyI3xQmXOVDaSpfPGr+rA5
	l7msSjzPCs+K4XMbKUJu0VxIBoTSisuU/2mSGAoNF0wyEKub+Ef+xKHQl9ZA5qrcbYDlZF
	Pu9LRAuDAcfrkPuj0BUfZhBYgt0FDlVG9iQeFdke9OyKP3QpN5cuSrAIXZPScw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 947f71c3;
	Sat, 16 Nov 2024 06:34:38 +0000 (UTC)
Date: Sat, 16 Nov 2024 15:34:23 +0900
From: asmadeus@codewreck.org
To: David Howells <dhowells@redhat.com>, Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com,
	ericvh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	Christian Brauner <brauner@kernel.org>,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [PATCH] netfs: If didn't read new data then abandon retry
Message-ID: <Zzg877mn3fCbOBdl@codewreck.org>
References: <672b7858.050a0220.350062.0256.GAE@google.com>
 <20241108034020.3695718-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108034020.3695718-1-lizhi.xu@windriver.com>

David,

I see now you weren't in Cc, does that patch make sense to you?
https://lkml.kernel.org/r/20241108034020.3695718-1-lizhi.xu@windriver.com


Lizhi Xu wrote on Fri, Nov 08, 2024 at 11:40:20AM +0800:
Subject: [PATCH] netfs: If didn't read new data then abandon retry

Since this is ended up a netfs patch please run get_maintainers.pl on it
and add appropriate maintainers neext time.

(You might want to reword that subject line as well to make it more
direct ("fix infinite recursion" or something), but if English isn't
your forte maintainers probably can fix it up anyway...)


> syzkaller reported a three-level circle calls (netfs_rreq_assess,
> netfs_retry_reads, netfs_rreq_terminated), during an unbuffered or direct
> I/O read.  [1]
> 
> netfs_rreq_terminated() only checks that subreq's transferred is greater
> than consumed and then sets the retry flag. There is no limit on the number
> of retries, and there is no judgment on whether the retry is effective in
> reading new data. This hitting the stack guard page.
> 
> To avoid the issue, let's add retry read times and the length of the data
> just read in struct netfs_io_subrequest, use them to assess the state of a
> read request and decide what to do retry.
> 
> [1]
> BUG: TASK stack guard page was hit at ffffc9000482ff48 (stack is ffffc90004830000..ffffc90004838000)
> Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 3 UID: 0 PID: 6237 Comm: syz-executor663 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
> Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 c0 4d 7a
> RSP: 0018:ffffc9000482ff50 EFLAGS: 00010086
> RAX: 000000000000000c RBX: ffff8880306c2fba RCX: 0000000000000002
> RDX: dffffc0000000000 RSI: ffff8880306c2f98 RDI: ffff8880306c2440
> RBP: ffffc90004830088 R08: 0000000000000000 R09: 0000000000000006
> R10: ffffffff96e2dd27 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffff8880306c2f98 R14: 0000000000000008 R15: ffff8880306c2440
> FS:  00007fedf3b6e6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc9000482ff48 CR3: 000000002c910000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <#DF>
>  </#DF>
>  <TASK>
>  mark_usage kernel/locking/lockdep.c:4646 [inline]
>  __lock_acquire+0x906/0x3ce0 kernel/locking/lockdep.c:5156
>  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
>  local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
>  ___slab_alloc+0x123/0x1880 mm/slub.c:3695
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
>  __slab_alloc_node mm/slub.c:3961 [inline]
>  slab_alloc_node mm/slub.c:4122 [inline]
>  kmem_cache_alloc_noprof+0x2a7/0x2f0 mm/slub.c:4141
>  radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
>  idr_get_free+0x528/0xa40 lib/radix-tree.c:1506
>  idr_alloc_u32+0x191/0x2f0 lib/idr.c:46
>  idr_alloc+0xc1/0x130 lib/idr.c:87
>  p9_tag_alloc+0x394/0x870 net/9p/client.c:321
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
>  ...
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
>  do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
>  vfs_readv+0x4cf/0x890 fs/read_write.c:1025
>  do_preadv fs/read_write.c:1142 [inline]
>  __do_sys_preadv fs/read_write.c:1192 [inline]
>  __se_sys_preadv fs/read_write.c:1187 [inline]
>  __x64_sys_preadv+0x22d/0x310 fs/read_write.c:1187
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fedf3bd4dd9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fedf3b6e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> RAX: ffffffffffffffda RBX: 00007fedf3c5e318 RCX: 00007fedf3bd4dd9
> RDX: 0000000000000001 RSI: 00000000200015c0 RDI: 0000000000000003
> RBP: 00007fedf3c5e310 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fedf3c5e31c
> R13: 000000000000000b R14: 00007fffe9d355b0 R15: 00007fffe9d35698
>  </TASK>
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-and-tested-by: syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/9p/vfs_addr.c         | 5 ++++-
>  fs/netfs/buffered_read.c | 1 +
>  fs/netfs/direct_read.c   | 1 +
>  fs/netfs/read_collect.c  | 9 ++++++---
>  fs/netfs/read_retry.c    | 2 ++
>  include/linux/netfs.h    | 2 ++
>  6 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 819c75233235..9fcc77bc77bd 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -80,8 +80,11 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
>  	if (pos + total >= i_size_read(rreq->inode))
>  		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
>  
> -	if (!err)
> +	if (!err) {
>  		subreq->transferred += total;
> +		subreq->fresh_len = total;
> +	} else
> +		subreq->fresh_len = 0;
>  
>  	netfs_read_subreq_terminated(subreq, err, false);
>  }
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index c40e226053cc..a233412ba08f 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -233,6 +233,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
>  
>  		subreq->start	= start;
>  		subreq->len	= size;
> +		subreq->rretry_times = 0;
>  
>  		atomic_inc(&rreq->nr_outstanding);
>  		spin_lock_bh(&rreq->lock);
> diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
> index b1a66a6e6bc2..beb81e06d13b 100644
> --- a/fs/netfs/direct_read.c
> +++ b/fs/netfs/direct_read.c
> @@ -66,6 +66,7 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
>  		subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
>  		subreq->start	= start;
>  		subreq->len	= size;
> +		subreq->rretry_times = 0;
>  
>  		atomic_inc(&rreq->nr_outstanding);
>  		spin_lock_bh(&rreq->lock);
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index b18c65ba5580..805e8f400797 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -509,9 +509,12 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
>  		} else {
>  			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
>  			if (subreq->transferred > subreq->consumed) {
> -				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> -				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
> -				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
> +				/* if we didn't read new data, abandon retry*/
> +				if (subreq->rretry_times && subreq->fresh_len) {
> +					__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> +					__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
> +					set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
> +				}
>  			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
>  				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 0350592ea804..7aa0420cb4c4 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -56,6 +56,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
>  				break;
>  			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
> +				subreq->rretry_times++;
>  				netfs_reset_iter(subreq);
>  				netfs_reissue_read(rreq, subreq);
>  			}
> @@ -183,6 +184,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  					goto abandon;
>  				subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
>  				subreq->start = start;
> +				subreq->rretry_times = 0;
>  
>  				/* We get two refs, but need just one. */
>  				netfs_put_subrequest(subreq, false, netfs_sreq_trace_new);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 5eaceef41e6c..c0b1f058f09a 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -191,6 +191,8 @@ struct netfs_io_subrequest {
>  	unsigned char		curr_folio_order; /* Order of folio */
>  	struct folio_queue	*curr_folioq;	/* Queue segment in which current folio resides */
>  	unsigned long		flags;
> +	size_t			fresh_len;	/* The length of the data just read */
> +	u8			rretry_times;   /* The times of retry read */
>  #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
>  #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
>  #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */

-- 
Dominique Martinet | Asmadeus

