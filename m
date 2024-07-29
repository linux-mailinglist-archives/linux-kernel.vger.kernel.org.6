Return-Path: <linux-kernel+bounces-264950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A626493EA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F191281677
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E3179AB;
	Mon, 29 Jul 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UozLDJoF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1514F7A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722215522; cv=none; b=bV3Lf70ntd0qB3hUX8vM5hdk0FXzO0lND/anLAIfQ9ZdGejZmdcK9gVdmDVPsaQ0SG8c4rc03G7XfTpsNyAcnmVC3FxQp/PYh6R99Bl8BOEPNvtCNtSi9HASeHb9IuSANGH9z8kPQ15DhO8VUSqmASO3J1f7XNOmNiLDXfrLtUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722215522; c=relaxed/simple;
	bh=BnZP0WSDPhlTGSjXpTvyZEGM+Tf2TVJiglL2mtw++L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7mmMisf7mL0vpoJLHZdIK4ty5QxatG9AxyGRzdigfNY3Jo48zRiRYHUUApESdWqCEAVfFKouY4dSF32aC8OUgA+av6htiA3qLSpz7MM6t6ID/jh+r8t7jSSTeMz9+kC+lO73CJMyVeAUjJ71FrBsVLSiyRjs4LiUyKBRLGVAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UozLDJoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED34C116B1;
	Mon, 29 Jul 2024 01:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722215522;
	bh=BnZP0WSDPhlTGSjXpTvyZEGM+Tf2TVJiglL2mtw++L0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UozLDJoFlpdji7cnN5R2T1ysGypIWktH8NQVfyu+Koj+Gnft7UNBu22/yO4iLfeBS
	 vP45/WkhXUHvbJnZtybzeTtlwqrUPRtzDN/SOiH4StytQ2ZxiaqmJbquvwKARCUEYY
	 oum3+BSqkba8pnZO1wfKUYdFiOnOHFk6DQRMBOIh5dmS4dgKi2OPiDyOKXtvSHWL/O
	 GT0OkU13jKtnYuwDtlF/bjwxde3p3ZH9Nx6cldewVGoAxN4UW2Cl3JvpCDdwzb3jsS
	 VdA2uZfX1GkwF1C5ySpdUvMJfnTiaMdcwk/WoCv87COYdAqj7ulT200dHWxWntIngh
	 BqWJgi8iiO/Pw==
Message-ID: <537aa35f-c3a7-41d0-aaa4-d000daf39fa2@kernel.org>
Date: Mon, 29 Jul 2024 09:11:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to avoid use-after-free in
 f2fs_stop_gc_thread()
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
References: <20240725020841.894814-1-chao@kernel.org>
 <ZqUOFzAPXE8plKU0@google.com> <ZqURxBYKHipWcz_U@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqURxBYKHipWcz_U@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/27 23:27, Jaegeuk Kim wrote:
> On 07/27, Jaegeuk Kim wrote:
>> On 07/25, Chao Yu wrote:
>>> syzbot reports a f2fs bug as below:
>>>
>>>   __dump_stack lib/dump_stack.c:88 [inline]
>>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>>>   print_report+0xe8/0x550 mm/kasan/report.c:491
>>>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>>>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>>>   instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>>>   atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
>>>   __refcount_add include/linux/refcount.h:184 [inline]
>>>   __refcount_inc include/linux/refcount.h:241 [inline]
>>>   refcount_inc include/linux/refcount.h:258 [inline]
>>>   get_task_struct include/linux/sched/task.h:118 [inline]
>>>   kthread_stop+0xca/0x630 kernel/kthread.c:704
>>>   f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
>>>   f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
>>>   f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
>>>   __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
>>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>>>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> The root cause is below race condition, it may cause use-after-free
>>> issue in sbi->gc_th pointer.
>>>
>>> - remount
>>>   - f2fs_remount
>>>    - f2fs_stop_gc_thread
>>>     - kfree(gc_th)
>>> 				- f2fs_ioc_shutdown
>>> 				 - f2fs_do_shutdown
>>> 				  - f2fs_stop_gc_thread
>>> 				   - kthread_stop(gc_th->f2fs_gc_task)
>>>
>>> We will call f2fs_do_shutdown() in two paths:
>>> - for f2fs_ioc_shutdown() path, we should grab sb->s_umount semaphore
>>> for fixing.
>>> - for f2fs_shutdown() path, it's safe since caller has already grabbed
>>> sb->s_umount semaphore.
>>>
>>> Reported-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/linux-f2fs-devel/0000000000005c7ccb061e032b9b@google.com
>>> Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/f2fs/file.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 7a37f2b393b9..62d72da25754 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -2388,7 +2388,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>   		}
>>>   	}
>>>   
>>> +	/* grab sb->s_umount to avoid racing w/ remount() */
>>> +	down_read(&sbi->sb->s_umount);
>>
>> Is this safe for freeze_bdev()?
> 
> bdev_freeze
>   -> fs_bdev_freeze
>    -> get_bdev_super
>     -> bdev_super_lock(bdev, true)
>      -> super_lock(sb, true)
>       -> __super_lock(sb, true)
>        -> down_write(s_umount)

Oops, let me check this.

Thanks,

> 
>>
>>>   	ret = f2fs_do_shutdown(sbi, in, readonly);
>>> +	up_read(&sbi->sb->s_umount);
>>>   
>>>   	if (need_drop)
>>>   		mnt_drop_write_file(filp);
>>> -- 
>>> 2.40.1

