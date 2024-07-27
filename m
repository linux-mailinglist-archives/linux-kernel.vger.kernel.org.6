Return-Path: <linux-kernel+bounces-264183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B593DFE9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCC1281FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03D4181338;
	Sat, 27 Jul 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvTOtMqz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AA17F4EC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722093081; cv=none; b=Y1TrVVkEWTbN/0HH86sIyBf+XjhtcqXU35ozLEzw6Z3UkygetuuuyhzoWYEQKpp4o+/krVvOz4w3Xms+Qu61ltmGOxgTSp9ise4hXKu3ilz2yeR4oWZ7daoi3qEtdPm5gDXP+kTA3GNu3lX1Wlt9lOvq9MZ0QJhb7FJcr/LCpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722093081; c=relaxed/simple;
	bh=cwAkkMmbUKCcFkt3RabHqDWW3gTFHRVL4u2/cL+hQHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDrBduRI4NACISB7E2RvbnHlL/VkaMY9X7Oi9Oq9sWCf946dgUYz4mGaQYY0N4WmkLiiXOahw/KoF0aB1EY5yk2vve4hLe/thV066QSqQcgNIt58BALHKXzu6JM9/tL5nD5kjfsYGeVAhi6vNBAdAW58r4amEY48uXZlDj4T03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvTOtMqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A0DC32781;
	Sat, 27 Jul 2024 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722093081;
	bh=cwAkkMmbUKCcFkt3RabHqDWW3gTFHRVL4u2/cL+hQHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvTOtMqzOr+iWbBD4YNWxLZutjs7om88GyAzMyjJ6dI/0U4AglLeierRh+25Yms5j
	 RUFL94O+9SsRs5uY8Z/2Tlgd9B+iUP9JFWalPtt5iBKsAn5zjwbVayqpB7K60+Fnxc
	 Hzm87TSEn3X4UHnh27rCVIYNu/oft12GUE0LywbIYQcHnEoSanv7wg1ZM4rUxE4n9t
	 BloNeFRhZMpR9bKMjzcs6J3oTVW81Yc57Pq2n5lsEPD1VuvUVWSWV7Y7abDASpZkuo
	 0FQe42Ioshl4vg9CBwQ4axB4LFbTsMLxbH3NJrWAr+iOTME2h0qeW0WJu+lvxjCqmr
	 7p0tBpajiQdQg==
Date: Sat, 27 Jul 2024 15:11:19 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: fix to avoid use-after-free in
 f2fs_stop_gc_thread()
Message-ID: <ZqUOFzAPXE8plKU0@google.com>
References: <20240725020841.894814-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725020841.894814-1-chao@kernel.org>

On 07/25, Chao Yu wrote:
> syzbot reports a f2fs bug as below:
> 
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_report+0xe8/0x550 mm/kasan/report.c:491
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
>  __refcount_add include/linux/refcount.h:184 [inline]
>  __refcount_inc include/linux/refcount.h:241 [inline]
>  refcount_inc include/linux/refcount.h:258 [inline]
>  get_task_struct include/linux/sched/task.h:118 [inline]
>  kthread_stop+0xca/0x630 kernel/kthread.c:704
>  f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
>  f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
>  f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
>  __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The root cause is below race condition, it may cause use-after-free
> issue in sbi->gc_th pointer.
> 
> - remount
>  - f2fs_remount
>   - f2fs_stop_gc_thread
>    - kfree(gc_th)
> 				- f2fs_ioc_shutdown
> 				 - f2fs_do_shutdown
> 				  - f2fs_stop_gc_thread
> 				   - kthread_stop(gc_th->f2fs_gc_task)
> 
> We will call f2fs_do_shutdown() in two paths:
> - for f2fs_ioc_shutdown() path, we should grab sb->s_umount semaphore
> for fixing.
> - for f2fs_shutdown() path, it's safe since caller has already grabbed
> sb->s_umount semaphore.
> 
> Reported-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-f2fs-devel/0000000000005c7ccb061e032b9b@google.com
> Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7a37f2b393b9..62d72da25754 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2388,7 +2388,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  		}
>  	}
>  
> +	/* grab sb->s_umount to avoid racing w/ remount() */
> +	down_read(&sbi->sb->s_umount);

Is this safe for freeze_bdev()?

>  	ret = f2fs_do_shutdown(sbi, in, readonly);
> +	up_read(&sbi->sb->s_umount);
>  
>  	if (need_drop)
>  		mnt_drop_write_file(filp);
> -- 
> 2.40.1

