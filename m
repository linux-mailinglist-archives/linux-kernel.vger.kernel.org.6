Return-Path: <linux-kernel+bounces-391629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26AF9B8983
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC09B21B91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564DF13B7A1;
	Fri,  1 Nov 2024 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDgtB2n/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75944C7C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429824; cv=none; b=L2pVUORgEtYf/X3hVOY04/nXV6Iu+Ka3OB9GtKH8WesK1rGHz7QA7xo+HDXtpihoPWpjjyu5LQSK1EhF+zWnBIkCqchLcWLHN0zu81WjmOFPVjnEs9P63Htr2bOuUKeijEVZNC68G9kHhgy8l2/CHq0tcEfo8aIH8a88oxsoyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429824; c=relaxed/simple;
	bh=a5NoWWYguUVibk5QAlWSTdse0oOpmio5ZTRSxSKdTHQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h7/WOlzhxG95Wq4uQkhe9TUG21KyYdtZbEhVrAYOoFSkxHK/dcQxL5oc/sE08aT8qzpGdUqetIVnQ68PzecHmTnjSmsVR07PxmRL7oZFbtGJ+eQ0XtMCeFlthlrs2v9mO+Xi00yiSNgZJYVpeabI5ZutRPSFMiEOaaq6RckS1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDgtB2n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637C6C4CEC3;
	Fri,  1 Nov 2024 02:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730429824;
	bh=a5NoWWYguUVibk5QAlWSTdse0oOpmio5ZTRSxSKdTHQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LDgtB2n/HKHauidVy8f6LWxckuLLteBQUPkA57BwctbN+eQ1yakpFY3sQDHCTOrJg
	 xN3vpCWW2tMu/Ke0ecwhFcpPNVtFbzhSGirlOLjm+ShI2QsvOvSFVK8PX7sSonAV4a
	 DKACWeJ7NumwAjf3vqJQ0sOneT9upQmjyT4y8eRQGA/nHO+zfhexQzsuAZjl57YDnI
	 SOMBvT3g12aFu/ZHx7U39eeDDR/1oynkUkilbwkPOsMfeAXjggQ9TndK9QzuD545g1
	 +ZxyfqNLtwwcT9tK4YHT+C9tip5WP8iecrCP7aTqcdubMEpvse+VY0AoIaXFy5d/pR
	 1KQsEUD15OesA==
Message-ID: <b822c677-b241-4469-a1fc-0aaf5b0e7895@kernel.org>
Date: Fri, 1 Nov 2024 10:56:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 lonuxli.64@gmail.com
Subject: Re: [PATCH 1/2] f2fs: fix race in concurrent f2fs_stop_gc_thread
To: Long Li <leo.lilong@huawei.com>, jaegeuk@kernel.org
References: <20241031064553.55283-1-leo.lilong@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241031064553.55283-1-leo.lilong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/31 14:45, Long Li wrote:
> In my test case, concurrent calls to f2fs shutdown report the following
> stack trace:
> 
>   Oops: general protection fault, probably for non-canonical address 0xc6cfff63bb5513fc: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 UID: 0 PID: 678 Comm: f2fs_rep_shutdo Not tainted 6.12.0-rc5-next-20241029-g6fb2fa9805c5-dirty #85
>   Call Trace:
>    <TASK>
>    ? show_regs+0x8b/0xa0
>    ? __die_body+0x26/0xa0
>    ? die_addr+0x54/0x90
>    ? exc_general_protection+0x24b/0x5c0
>    ? asm_exc_general_protection+0x26/0x30
>    ? kthread_stop+0x46/0x390
>    f2fs_stop_gc_thread+0x6c/0x110
>    f2fs_do_shutdown+0x309/0x3a0
>    f2fs_ioc_shutdown+0x150/0x1c0
>    __f2fs_ioctl+0xffd/0x2ac0
>    f2fs_ioctl+0x76/0xe0
>    vfs_ioctl+0x23/0x60
>    __x64_sys_ioctl+0xce/0xf0
>    x64_sys_call+0x2b1b/0x4540
>    do_syscall_64+0xa7/0x240
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The root cause is a race condition in f2fs_stop_gc_thread() called from
> different f2fs shutdown paths:
> 
>    [CPU0]                       [CPU1]
>    ----------------------       -----------------------
>    f2fs_stop_gc_thread          f2fs_stop_gc_thread
>                                   gc_th = sbi->gc_thread
>      gc_th = sbi->gc_thread
>      kfree(gc_th)
>      sbi->gc_thread = NULL
>                                   < gc_th != NULL >
>                                   kthread_stop(gc_th->f2fs_gc_task) //UAF

Hi Long,

Thanks for catching this.

Can we cover f2fs_stop_gc_thread() w/ write lock of s_umount in
f2fs_do_shutdown()?

Thanks,

> 
> The commit c7f114d864ac ("f2fs: fix to avoid use-after-free in
> f2fs_stop_gc_thread()") attempted to fix this issue by using a read
> semaphore to prevent races between shutdown and remount threads, but
> itfails to prevent all race conditions.
> 
> While upgrading to s_umount write lock in f2fs_do_shutdown() would fix
> the current issue, however, using s_umount lock requires extreme caution
> to avoid lock recursion. A better solution is to introduce a semaphore
> to prevent races between concurrent f2fs_stop_gc_thread calls.
> 
> Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
>   fs/f2fs/f2fs.h  | 1 +
>   fs/f2fs/gc.c    | 9 +++++++--
>   fs/f2fs/super.c | 1 +
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3c6f3cce5779..7ae1e2a4789f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1679,6 +1679,7 @@ struct f2fs_sb_info {
>   						 * race between GC and GC or CP
>   						 */
>   	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
> +	struct semaphore gc_clean_lock;		/* semaphore for clean GC thread */
>   	struct atgc_management am;		/* atgc management */
>   	unsigned int cur_victim_sec;		/* current victim section num */
>   	unsigned int gc_mode;			/* current GC state */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e40bdd12e36d..e1b8bf98b5fa 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -232,14 +232,19 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>   
>   void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
>   {
> -	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
> +	struct f2fs_gc_kthread *gc_th;
>   
> -	if (!gc_th)
> +	down(&sbi->gc_clean_lock);
> +	gc_th = sbi->gc_thread;
> +	if (!gc_th) {
> +		up(&sbi->gc_clean_lock);
>   		return;
> +	}
>   	kthread_stop(gc_th->f2fs_gc_task);
>   	wake_up_all(&gc_th->fggc_wq);
>   	kfree(gc_th);
>   	sbi->gc_thread = NULL;
> +	up(&sbi->gc_clean_lock);
>   }
>   
>   static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 80a53dbf1c38..47a15050ea9c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4419,6 +4419,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   
>   	/* initialize locks within allocated memory */
>   	init_f2fs_rwsem(&sbi->gc_lock);
> +	sema_init(&sbi->gc_clean_lock, 1);
>   	mutex_init(&sbi->writepages);
>   	init_f2fs_rwsem(&sbi->cp_global_sem);
>   	init_f2fs_rwsem(&sbi->node_write);


