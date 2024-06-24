Return-Path: <linux-kernel+bounces-226552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE17914043
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598A02815B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 01:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D18F40;
	Mon, 24 Jun 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBjsfufS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AB8BE8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194309; cv=none; b=GOvCbM8dA6pQAdycI6UozK63ldX8zp1avYF5gLt7CMRzFpCCfdgMZYBxzybWMnfJoJAsNVzVS+bQ9dy7duDLDnZppHhEELqN1Mun47uZOa8+fVsfFXV+Bgv8SD9lwcX1AtNAttCZFn5r1PxAuvOLcuht5k4wfypVjhB5OdzU6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194309; c=relaxed/simple;
	bh=GpDfdTZNP+dYTbdjDBrpbsC4ckNum2kz7o64tgKOqCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYI2dD+XX57LyS1AwjDcfqJIaSaA62Ya0B7h1+IA0xFdDNINOqVCd+a8SnFtMA8qbd7gviTj4rXjLEUR4XINBGPikVyW8vDpHZmK99nLS10skbe4txyO4XZsbARDutVeDS55k+ZcChQpd919ptdkqUavQm/IvkilvQVgu6RxLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBjsfufS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F0AC2BD10;
	Mon, 24 Jun 2024 01:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719194308;
	bh=GpDfdTZNP+dYTbdjDBrpbsC4ckNum2kz7o64tgKOqCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FBjsfufSyYuou00Gv45QP2AF7Njr1JLe479GgOcWyKeV2O4xqgBcGOxAuyQ34LIaR
	 I5E8lAayBhkBxlIgzB7J0fjwdSjb09kXp1a/+qtg3tdmG5FkpKB0AajFvGZC0IamQX
	 YSxiNIaSZ2It396SPsJy6w3IeePaW5TazKMNvcNnpTBhSWMIQ3e0/aJ3gCrTRUVtkO
	 Q3+y+u33qj4tUc9fU9SeNBMMHNip9M1GsT6R7AoBNGkbqlu3cNKJszH2nuCxtwrtx9
	 +fcU90iM3xb0JTZ0aPTo26+cKHi1kcEpJ7QZ3x9gnmC8KgzESc5hvIi5lLVtCz+CvP
	 jUgwydwy3WiFg==
Message-ID: <dfc4a115-9778-49b0-8a11-fd1cfd2272e9@kernel.org>
Date: Mon, 24 Jun 2024 09:58:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to add missing sb_{start,
 end}_intwrite() for ckpt thread
To: jaegeuk@kernel.org, Daeho Jeong <daeho43@gmail.com>
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240606095213.4087668-1-chao@kernel.org>
 <d38a2712-f7cc-4aea-a343-00335a5215a0@kernel.org>
 <CACOAw_x3s2m70-cBhA0X0h5AetCQgDzVh7hRM00OVm=0Od5FUA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_x3s2m70-cBhA0X0h5AetCQgDzVh7hRM00OVm=0Od5FUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Please ignore this patch, because during freeze_super(), it will call
sync_fs() to clear all dirty data, there should be no race case after
that.

Thanks,

On 2024/6/10 23:10, Daeho Jeong wrote:
> On Sat, Jun 8, 2024 at 5:36 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/6/6 17:52, Chao Yu wrote:
>>> After commit 261eeb9c1585 ("f2fs: introduce checkpoint_merge mount
>>> option"), checkpoint can be triggered in background thread, it missed
>>> to cover f2fs inner checkpoint operation w/ sb_{start,end}_intwrite(),
>>> fix it.
>>
>> It needs to use sb_start_intwrite_trylock(), otherwise, it will cause
>> deadlock as below:
>>
>> - freeze_super
>>    - sb_wait_write(SB_FREEZE_WRITE)
>>    - sb_wait_write(SB_FREEZE_PAGEFAULT)
>>    - sb_wait_write(SB_FREEZE_FS)
>>                                          - sync
>>                                           - iterate_supers
>>                                            - super_lock_shared
>>                                             - down_read(&sb->s_umount)
>>                                             - sync_fs_one_sb
>>                                              - f2fs_sync_fs
>>                                               - f2fs_issue_checkpoint
>>                                                - wait_for_completion
>>                                                                          - issue_checkpoint_thread
>>                                                                           - sb_start_intwrite(sbi->sb);
>>
>> - thaw_super
>>    - super_lock_excl
>>     - down_write(&sb->s_umount)
>>
>> Thanks,
>>
>>>
>>> Fixes: 261eeb9c1585 ("f2fs: introduce checkpoint_merge mount option")
>>> Cc: Daeho Jeong <daehojeong@google.com>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>    fs/f2fs/checkpoint.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 55d444bec5c0..66eaad591b60 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -1828,8 +1828,11 @@ static int issue_checkpoint_thread(void *data)
>>>        if (kthread_should_stop())
>>>                return 0;
>>>
>>> -     if (!llist_empty(&cprc->issue_list))
>>> +     if (!llist_empty(&cprc->issue_list)) {
>>> +             sb_start_intwrite(sbi->sb);
>>>                __checkpoint_and_complete_reqs(sbi);
>>> +             sb_end_intwrite(sbi->sb);
>>> +     }
>>>
>>>        wait_event_interruptible(*q,
>>>                kthread_should_stop() || !llist_empty(&cprc->issue_list));
>>
>>
> 
> Reviewed-by: Daeho Jeong <daehojeong@google.com>
> 
> Thanks.
> 
> 
> 
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

